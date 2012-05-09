Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699Ab2EINrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 May 2012 09:47:14 -0400
Message-ID: <1336571221.12477.136.camel@bling.home>
Subject: Re: [RESEND PATCH v3] hotplug: add device per func in ACPI DSDT
 tables
From: Alex Williamson <alex.williamson@redhat.com>
To: Amos Kong <akong@redhat.com>
Cc: mst@redhat.com, linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	kevin@koconnor.net
Date: Wed, 09 May 2012 07:47:01 -0600
In-Reply-To: <20120509072452.14872.92530.stgit@t>
References: <20111214010645.GA2044@morn.localdomain>
	 <20120509072452.14872.92530.stgit@t>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-05-09 at 15:24 +0800, Amos Kong wrote:
> Boot up a Linux VM with 8 pci block devices which
> are the 8 functions in one pci slot.
> | # qemu-kvm ...
> | -drive file=images/u0,if=none,id=drv0,format=qcow2,cache=none \
> | -device virtio-blk-pci,drive=drv0,id=v0,multifunction=on,addr=0x03.0 \
> | ....
> | -drive file=images/u7,if=none,id=drv7,format=qcow2,cache=none \
> | -device virtio-blk-pci,drive=drv7,id=v7,multifunction=on,addr=0x03.7 \
> 
> Check devices in guest.
> | vm)# ls /dev/vd*
> |    vda vdb vdc vde vdf vdg vdh
> | vm)# lspci |grep block
> | 00:03.0 SCSI storage controller: Red Hat, Inc Virtio block device
> |    ...
> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device
> |
> 
> Func1~7 still exist in guest after hot-removing the whole slot
> through qemu monitor.
> | vm)# lspci |grep block    (00:03.0 disappeared)
> | 00:03.1 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
> |    ...
> | 00:03.7 SCSI storage controller: Red Hat, Inc Virtio block device (rev ff)
> | vm)# ls /dev/vd*          (vda disappeared)
> |    vdb vdc vde vdf vdg vdh
> | vm)# mkfs /dev/vdb
> |    INFO: task mkfs.ext2:1784 blocked for more than 120 seconds. (task hung)
> 
> 
> Currently only func0 is defined in ACPI DSDT table
> of seabios, and only hot-adding func0 would cause
> a ACPI event for notification. Other funcs except
> func0 wouldn't be registered in linux pci driver.
> (we can only found func0 in slot->funcs list of
> pci driver).
> 
> When VM pci driver receives an ACPI event for
> hot-removing, it will only clean functions in
> slot->funcs list, the other funcs could not be
> cleaned.
> 
> This patch adds device per function in ACPI DSDT tables,
> then all funcs will be registered in slot->funcs list.
> It's coincident with microsoft's example:
> http://www.microsoft.com/china/whdc/system/pnppwr/hotadd/hotplugpci.mspx#EUH
> 
> Have tested with linux/winxp/win7, hot-adding/hot-remving,
> single/multiple function devices, they are all fine(all
> added devices can be removed).
> 
> This patch includes some bits mst wrote, thanks!
> ---
> old discussion: http://marc.info/?l=kvm&m=132428400917405&w=2
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  src/ssdt-pcihp.dsl |   17 
>  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 8781 insertions(+), 105 deletions(-)
> 
> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> index 4b435b8..2a3c326 100644
> --- a/src/ssdt-pcihp.dsl
> +++ b/src/ssdt-pcihp.dsl
> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
>          // at runtime, if the slot is detected to not support hotplug.
>          // Extract the offset of the address dword and the
>          // _EJ0 name to allow this patching.
> -#define hotplug_slot(slot)                              \
> -        Device (S##slot) {                              \
> +#define hotplug_func(slot, fn)                          \
> +        Device (S##slot##fn) {                          \
>             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
> -           Name (_ADR, 0x##slot##0000)                  \

I would have guessed it to be sufficient to change _ADR to
0x##slot##ffff, does that not work?  Thanks,

Alex

> +           Name (_ADR, 0x##slot##000##fn)               \
>             ACPI_EXTRACT_METHOD_STRING aml_ej0_name      \
>             Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
>             Name (_SUN, 0x##slot)                        \
>          }
> +#define hotplug_slot(slot)     \
> +        hotplug_func(slot, 0)  \
> +        hotplug_func(slot, 1)  \
> +        hotplug_func(slot, 2)  \
> +        hotplug_func(slot, 3)  \
> +        hotplug_func(slot, 4)  \
> +        hotplug_func(slot, 5)  \
> +        hotplug_func(slot, 6)  \
> +        hotplug_func(slot, 7)
>  
>          hotplug_slot(01)
>          hotplug_slot(02)
> @@ -59,7 +68,7 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
>          hotplug_slot(1f)
>  
>  #define gen_pci_hotplug(slot)   \
> -            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot, Arg1) }
> +            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot##0, Arg1) }
>  
>          Method(PCNT, 2) {
>              gen_pci_hotplug(01)


