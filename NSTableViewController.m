//
//  NSTableViewController.m
//  Lesson33-34 HW Navigation
//
//  Created by Nik on 19.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSTableViewController.h"

@interface NSTableViewController ()

@property (strong,nonatomic) NSArray* contents;
@property (strong,nonatomic) NSString* selectedPath;


@end

@implementation NSTableViewController

#pragma mark - my methods
- (void) setPath:(NSString *)path{
    
    _path = path;
    
    NSError* error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    
    if(error){
        
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [self.path lastPathComponent];
}

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath{
    
    NSString* filename = [self.contents objectAtIndex:indexPath.row];
    
    NSString* filePath = [self.path stringByAppendingPathComponent:filename];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    
    return  isDirectory;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.path){
        self.path = @"/Users/nik/Desktop/ios dev course/Lesson33-34 HW Navigation";
        
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack = %d", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack %d", [self.navigationController.viewControllers indexOfObject:self]);
}
- (void) dealloc {
    NSLog(@"controller with path %@ has been deallocated", self.path);
}
#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    static NSString* fileType = @"fileType";
    static NSString* directoryType = @"fileType";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileType ];
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    

    
    if (!cell && [self isDirectoryAtIndexPath:indexPath]) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:directoryType];
        cell.textLabel.text = fileName;
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
        
        
    } else
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fileType];
        cell.textLabel.text = fileName;
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
        
    }
    
    
    
   
    
    return cell;
    }
    
   
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self isDirectoryAtIndexPath:indexPath]){
        
        NSString* fileName = [self.contents objectAtIndex:indexPath.row];
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        
        
        //ASDirectoryViewController* vc = [[ASDirectoryViewController alloc] initWithFolderPath:path];
        //[self.navigationController pushViewController:vc animated:YES];
        
        NSTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NSTableViewController"];
        vc.path = path;
        
        [self.navigationController pushViewController:vc animated:YES];

        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
