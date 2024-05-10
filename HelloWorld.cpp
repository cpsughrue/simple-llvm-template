#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

void visitor(llvm::Function &F) {
  llvm::errs() << "Visiting: ";
  llvm::errs() << F.getName() << " (takes ";
  llvm::errs() << F.arg_size() << " args)" << '\n';
}

struct HelloWorld : llvm::PassInfoMixin<HelloWorld> {
  llvm::PreservedAnalyses run(llvm::Function &F, llvm::FunctionAnalysisManager &) {
    visitor(F);
    return llvm::PreservedAnalyses::all();
  }

  static bool isRequired() { return true; }
};

bool FPMHook(llvm::StringRef Name, llvm::FunctionPassManager &FPM, llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {
  if (Name != "hello-world")
    return false;
  FPM.addPass(HelloWorld());
  return true;
}

void PBHook(llvm::PassBuilder &PB) {
  PB.registerPipelineParsingCallback(FPMHook);
}

llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloWorld", LLVM_VERSION_STRING, PBHook};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}
