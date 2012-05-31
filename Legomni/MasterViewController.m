//
//  MasterViewController.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur.jacques. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Serie.h"
#import "Figure.h"


@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize legomni;


- (Serie*) serieForIndex:(int)index {
    return [legomni.series objectAtIndex:index];
}

- (Figure*) figureForIndexPath:(NSIndexPath*)indexPath {
    return [[self serieForIndex:indexPath.section].figures objectAtIndex:indexPath.row];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"LEGO miniFigures", @"LEGO miniFigures");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
        
        self.legomni = [[Legomni alloc] init];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;

	// Do any additional setup after loading the view, typically from a nib.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSIndexPath* firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:firstIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self tableView:self.tableView didSelectRowAtIndexPath:firstIndexPath];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];

    int total = [legomni series].count * FIGURES_PER_SERIES;
    int count = [legomni differentFiguresCount];
    int doubles = [legomni doubleCount];
    self.title = [NSString stringWithFormat:@"%@ (%d/%d + %d)", (NSLocalizedString(@"LEGO miniFigures", @"LEGO miniFigures")), count, total, doubles];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [legomni.series count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Serie* serie = [self serieForIndex:section];
    int count = [serie differentFiguresCount];
    int doublesCount = [serie doubleCount];
    return [NSString stringWithFormat:@"%@ %d (%d/%d + %d)", (NSLocalizedString(@"Série", @"Série")), serie.index, count, FIGURES_PER_SERIES, doublesCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self serieForIndex:section].figures count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    }

    // Configure the cell.
    //cell.textLabel.text = NSLocalizedString(@"Detail", @"Detail");
    Figure* figure = [self figureForIndexPath:indexPath];
    cell.textLabel.text = figure.name;
    cell.imageView.image = [UIImage imageNamed:[figure photoName]];
    if (figure.slogan) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d) %@ = %d", figure.index, (NSLocalizedString(@"Quantity", @"Quantity")), figure.quantity];
    } else {
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Figure* figure = [self figureForIndexPath:indexPath];
    if (figure.quantity > 0) {
        cell.backgroundColor = [UIColor colorWithRed:181.0/256 green:253.0/256 blue:181.0/256 alpha:1]; // [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor ];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.title = NSLocalizedString(@"All", @"All Series");
	    if (!self.detailViewController) {
	        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:nil];
	    }
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailUpdateDelegate = self;
        self.detailViewController.detailIndexPath = indexPath;
    }
    Figure* figure = [self figureForIndexPath:indexPath];
    self.detailViewController.detailItem = figure;
}

- (void) detailUpdatedForIndexPath:(NSIndexPath*)indexPath {
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

@end
