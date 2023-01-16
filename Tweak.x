#include <mach-o/dyld.h>
#include <mach/mach.h> 
#import <substrate.h>
#import <Foundation/Foundation.h>

%ctor 
{
	const uint8_t patch1[] = {
		0x22, 0x4e, 0x80, 0xd2, //MOV X2,0x271
	};
	const uint8_t patch2[] = {
		0xa2, 0x3a, 0x80, 0xd2, //MOV X2,0x1d5
	};
	const char *dyld =_dyld_get_image_name(0);
	char* bluetoothd="/usr/sbin/bluetoothd";
	NSLog(@"++++++++test");
	NSLog(@"%s",dyld);
	uint32_t apply=0;
	if(strcmp(dyld,bluetoothd)==0){
		//uint64_t target=_dyld_get_image_vmaddr_slide(0)+0x100264234;
		for(uint64_t i=0x200000;i<0x300000;i+=4){
			uint64_t target=_dyld_get_image_vmaddr_slide(0)+0x100000000+i;
			if(*(uint32_t*)target==0x52804e48 && *(uint32_t*)(target+8)==0x7109c67f){
				NSLog(@"%llx",target);
				MSHookMemory((void*)(target+0x24), patch1, sizeof(patch1));
				apply++;
			}
			if(*(uint32_t*)target==0x52803ac8 && *(uint32_t*)(target+8)==0x7107567f){
				NSLog(@"%llx",target);
				MSHookMemory((void*)(target+0x24), patch2, sizeof(patch2));
				apply++;
			}
			if(apply==2){
				NSLog(@"All patch apply success!!!");
				break;
			}
		}
		NSLog(@"hook finish");
	}
	NSLog(@"exit hook");
}
