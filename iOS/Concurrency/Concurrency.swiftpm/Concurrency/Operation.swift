import UIKit

class BlurImageOperation: Operation {
    var inputImage: UIImage?
    var outputImage: UIImage?
    
    override func main() {
        outputImage = blurImage(image: inputImage)
    }
    
    func blurImage(image: UIImage?) -> UIImage? {
        return nil
    }
    
    func testBlockOperation() {
        let blockOperation = BlockOperation()
        
        blockOperation.addExecutionBlock {
            
        }
    }
}


func testOperationQueue() {
    let printerQueue = OperationQueue()
    
    printerQueue.addOperation { print("厉"); sleep(3) }
    printerQueue.addOperation { print("害"); sleep(3) }
    printerQueue.addOperation { print("了"); sleep(3) }
    printerQueue.addOperation { print("我"); sleep(3) }
    printerQueue.addOperation { print("的"); sleep(3) }
    printerQueue.addOperation { print("哥"); sleep(3) }
    
    printerQueue.waitUntilAllOperationsAreFinished()
}
