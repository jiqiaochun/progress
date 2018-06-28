//
//  ViewController.swift
//  progress
//
//  Created by qiaochun ji on 2018/6/27.
//  Copyright © 2018年 qiaochun ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 创建tableview对象
    lazy var tableView:UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "主页"
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController{
    func setUpUI(){
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier : String = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        if indexPath.row == 0 {
            cell?.textLabel?.text = "CALayer介绍"
        }else{
            cell?.textLabel?.text = "进度条"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let desc = DescLayerViewController()
            self.navigationController?.pushViewController(desc, animated: true)
        }else{
            let progress = ProgreeViewController()
            self.navigationController?.pushViewController(progress, animated: true)
        }
    }
    
}
