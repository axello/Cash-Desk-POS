#  Notes
## How to swipe to delete UITableViewCells
https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells


Swift version: 5.1

Paul Hudson     @twostraws    May 28th 2019

It takes just one method to enable swipe to delete in table views: tableView(_:commit:forRowAt:). This method gets called when a user tries to delete one of your table rows using swipe to delete, but its very presence is what enables swipe to delete in the first place – that is, iOS literally checks to see whether the method exists, and, if it does, enables swipe to delete.

When you want to handle deleting, you have to do three things: first, check that it's a delete that's happening and not an insert (this is down to how you use the UI); second, delete the item from the data source you used to build the table; and third, call deleteRows(at:) on your table view.

It is crucial that you do those things in exactly that order. iOS checks the number of rows before and after a delete operation, and expects them to add up correctly following the change.

Here's an example that does everything correctly:

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

## second note:
### add swipeCellKit????????????????????????????????????????????????

## third note


