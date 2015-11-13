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

/**
    A multi section TableView Controller with multiple rows and multiple cell identifiers
    - NOTE: the cells must comfort to the TableViewCellable protocol
 */
public class GTTableViewController: UITableViewController {
    public var dataSourceable: TableViewDataSourceType!

    public var useAutoHeightCells: Bool = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.useAutoHeightCells {
            self.tableView.estimatedRowHeight = 50
            self.tableView.rowHeight = UITableViewAutomaticDimension
        }
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Loading..")


    }
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSourceable.numberOfSections()
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceable.numberOfRowsInSection(section)
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.dataSourceable.cellForRowAtIndexPath(self, indexPath: indexPath)
    }

    override public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            // the user scrolled to the top
            return
        }
        
    }
    
    public override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        guard scrollView.contentOffset.y < 0 else {
            return
        }
        // the user scrolled in the top
        
        pullToRefreshWillBegin()
        self.refreshControl?.beginRefreshing()
        pullToRefresh() {
            self.pullToRefreshDidEnd()
            self.refreshControl?.endRefreshing()
        }
        
    }
    
}
