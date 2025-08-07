# Cheat Sheet: Links, Mounts, and Junction Points on Windows

## Create a Hard Link (Windows)
Links a file to another NTFS inode on the same volume
mklink /H "C:\path\to\hard_link" "C:\path\to\source_file"
Example: mklink /H "C:\Users\Dave\doc_link.txt" "C:\Users\Dave\doc.txt"

## Create a Soft (Symbolic) Link (Windows)
Creates a pointer to a file or directory, can cross volumes
mklink "C:\path\to\soft_link" "C:\path\to\source"
Example: mklink "C:\Users\Dave\doc_symlink.txt" "C:\Users\Dave\doc.txt"
For directories: mklink /D "C:\Users\Dave\link_dir" "C:\Users\Dave\Docs"

## Mount a Volume (Windows)
Mounts a volume to a directory or drive letter
mountvol C:\mount\point \\?\Volume{volume_guid}\
Example: mountvol C:\mnt \\?\Volume{12345678-1234-1234-1234-1234567890ab}\
Note: Find volume GUID with 'mountvol' or Disk Management

## Create a Junction Point (Windows NTFS)
Creates a directory link on NTFS
mklink /J "C:\path\to\junction" "C:\path\to\target_dir"
Example: mklink /J "C:\Users\Dave\Link" "C:\Users\Dave\Docs"

## Reference
This content is from Dave's Garage on YouTube.  

https://youtu.be/7Rbw953DXg0?si=sPBZaf1L4xJSjZrf to see the full video.
