Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40669 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892Ab2EJXkn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 19:40:43 -0400
Date: Thu, 10 May 2012 19:40:27 -0400 (EDT)
From: Amos Kong <akong@redhat.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org, rjw@sisk.pl,
	alex williamson <alex.williamson@redhat.com>,
	kevin@koconnor.net, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [RESEND PATCH v3] hotplug: add device per func in	ACPI DSDT tables
Message-ID: <73e9b54b-5377-4dcc-b6f1-494e05dbbf8b@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FABFEE9.9060501@gmail.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----- Original Message -----
> On 05/11/2012 01:42 AM, Michael S. Tsirkin wrote:
> > On Fri, May 11, 2012 at 01:17:38AM +0800, Jiang Liu wrote:
> >> On 05/09/2012 03:24 PM, Amos Kong wrote:
> >>
> >>> ---
> >>>  src/ssdt-pcihp.dsl |   17
> >>>  src/ssdt-pcihp.hex | 8869
> >>>  +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 8781 insertions(+), 105 deletions(-)
> >>>
> >>> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> >>> index 4b435b8..2a3c326 100644
> >>> --- a/src/ssdt-pcihp.dsl
> >>> +++ b/src/ssdt-pcihp.dsl
> >>> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT",
> >>> 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
> >>>          // at runtime, if the slot is detected to not support
> >>>          hotplug.
> >>>          // Extract the offset of the address dword and the
> >>>          // _EJ0 name to allow this patching.
> >>> -#define hotplug_slot(slot)                              \
> >>> -        Device (S##slot) {                              \
> >>> +#define hotplug_func(slot, fn)                          \
> >>> +        Device (S##slot##fn) {                          \
> >>>             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
> >>> -           Name (_ADR, 0x##slot##0000)                  \
> >>> +           Name (_ADR, 0x##slot##000##fn)               \
> >>>             ACPI_EXTRACT_METHOD_STRING aml_ej0_name      \
> >>>             Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
> >>>             Name (_SUN, 0x##slot)                        \
> >>>          }
> >> It would be perfect if the Device object could also support _PS0
> >> and _STA
> >> methods.
> > 
> > It needs qemu support, and some backward compatibility hack.
> > Why?
> > 
> >> Could we re-add the slot back after hot-removing it from the guest
> >> OS with this ACPI implementation? Say execute following scripts
> >> from guest OS.
> >> echo 0 > /sys/bus/pci/slot/xx/power

I tested with qemu VM, device can be hot-removed by ^^^^
block also could not be found by (qemu) # info block
(#virt dev was removed from virt slot)

> >> echo 1 > /sys/bus/pci/slot/xx/power

so we have to add the device to qemu first
(qemu) __com.redhat_drive_add id=drv50,file=/tmp/resize0.qcow2
(qemu) device_add virtio-blk-pci,id=ddev50,drive=drv50,addr=0x5.0,multifunction=on

disk is back (no need exec :echo 1 > /sys/bus/pci/slot/xx/power in guest)


> > 
> > No because qemu removes device after eject.
> > Do you have a need for this functionality? What is it?
> 
> I'm not familiar with qemu:(
> On native OS, admin could trigger PCI device hotplug operations
> through
> /sys/bus/pci/slot/xx/power. Not sure whether that's needed for guest
> OS too.

In physical, we have two kinds of hotplug, one is hot-unplug dev from slot,
another is just 'disable' it in guest os (dev also plugs in slot)

Hotplug dev by /sys/bus/pci/slot/xx/power -> it should be 2nd condition.
For current QEMU guest, only 1st condition works, and it's enough.

