Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab2EKKOh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 May 2012 06:14:37 -0400
Date: Fri, 11 May 2012 13:14:15 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, rjw@sisk.pl, alex.williamson@redhat.com,
	Amos Kong <akong@redhat.com>
Subject: Re: [SeaBIOS] [RESEND PATCH v3] hotplug: add device per func in ACPI
 DSDT tables
Message-ID: <20120511101415.GD15230@redhat.com>
References: <20111214010645.GA2044@morn.localdomain>
 <20120509072452.14872.92530.stgit@t>
 <4FABF832.1060708@gmail.com>
 <20120510174257.GD14647@redhat.com>
 <4FABFEE9.9060501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FABFEE9.9060501@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 01:46:17AM +0800, Jiang Liu wrote:
> On 05/11/2012 01:42 AM, Michael S. Tsirkin wrote:
> > On Fri, May 11, 2012 at 01:17:38AM +0800, Jiang Liu wrote:
> >> On 05/09/2012 03:24 PM, Amos Kong wrote:
> >>
> >>> ---
> >>>  src/ssdt-pcihp.dsl |   17 
> >>>  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 8781 insertions(+), 105 deletions(-)
> >>>
> >>> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> >>> index 4b435b8..2a3c326 100644
> >>> --- a/src/ssdt-pcihp.dsl
> >>> +++ b/src/ssdt-pcihp.dsl
> >>> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
> >>>          // at runtime, if the slot is detected to not support hotplug.
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
> >> It would be perfect if the Device object could also support _PS0 and _STA
> >> methods.
> > 
> > It needs qemu support, and some backward compatibility hack.
> > Why?
> > 
> >> Could we re-add the slot back after hot-removing it from the guest
> >> OS with this ACPI implementation? Say execute following scripts from guest OS.
> >> echo 0 > /sys/bus/pci/slot/xx/power
> >> echo 1 > /sys/bus/pci/slot/xx/power
> > 
> > No because qemu removes device after eject.
> > Do you have a need for this functionality? What is it?
> 
> I'm not familiar with qemu:(
> On native OS, admin could trigger PCI device hotplug operations through
> /sys/bus/pci/slot/xx/power. Not sure whether that's needed for guest OS too. 
> 
Why is it needed on physical HW? May be it is needed in a VM for the
same reason?

--
			Gleb.
