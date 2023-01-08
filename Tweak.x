#include <mach-o/dyld.h>
#include <mach/mach.h> 
#import <substrate.h>
#import <Foundation/Foundation.h>

%ctor 
{
	const uint8_t patch[] = {
    	0x22, 0x4e, 0x80, 0xd2,
	};
	const char *dyld =_dyld_get_image_name(0);
	char* bluetoothd="/usr/sbin/bluetoothd";
	NSLog(@"++++++++test");
	NSLog(@"%s",dyld);
	if(strcmp(dyld,bluetoothd)==0){
		uint64_t target=_dyld_get_image_vmaddr_slide(0)+0x100264234;
		NSLog(@"%llx",target);
		MSHookMemory((void*)(_dyld_get_image_vmaddr_slide(0)+0x100264234), patch, sizeof(patch));
		NSLog(@"hook finish");
	}
	NSLog(@"exit hook");
}
