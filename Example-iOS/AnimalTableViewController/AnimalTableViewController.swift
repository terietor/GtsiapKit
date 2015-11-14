// Copyright (c) 2015 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import GtsiapKit

class Animal {
    var name: String!
}

class AnimalTableViewController: GTTableViewController {
    
    private var animalSection = TableViewSection<Animal, AnimalTableViewCell>()

    override var performLoadDataOnLoad: Bool { return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func dataSourceForTableViewController(make: DataSourceMaker) {
        let sections: [TableViewSection<Animal, AnimalTableViewCell>] = [self.animalSection]
        make.setUpDataSourceFromSections(sections)
    }
    
    override func loadData(needsReload: Bool, completed: () -> ()) {
        
        guard needsReload else { return }

        dispatch_async(dispatch_queue_create("animalTableViewCOntrollerQueue", DISPATCH_QUEUE_SERIAL)) {
            sleep(2)
            dispatch_async(dispatch_get_main_queue()) {
                let animal = Animal()
                animal.name = "cat"
                
                let animal2 = Animal()
                animal2.name = "Dog"
                
                let elephant = Animal()
                elephant.name = "elephant"
                
                self.animalSection.resetItems([
                    animal,
                    animal2,
                    elephant
                ])
                
                completed()
            } // end dispatch main
        } // end dispatch
    }
    
    override func pullToRefresh(completed: () -> ()) {
        super.pullToRefresh() { completed() }
    } 
}
