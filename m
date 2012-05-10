Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760674Ab2EJRnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 May 2012 13:43:17 -0400
Date: Thu, 10 May 2012 20:42:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Amos Kong <akong@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, rjw@sisk.pl, alex.williamson@redhat.com,
	kevin@koconnor.net
Subject: Re: [RESEND PATCH v3] hotplug: add device per func in ACPI DSDT
 tables
Message-ID: <20120510174257.GD14647@redhat.com>
References: <20111214010645.GA2044@morn.localdomain>
 <20120509072452.14872.92530.stgit@t>
 <4FABF832.1060708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FABF832.1060708@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 01:17:38AM +0800, Jiang Liu wrote:
> On 05/09/2012 03:24 PM, Amos Kong wrote:
> 
> > ---
> >  src/ssdt-pcihp.dsl |   17 
> >  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 8781 insertions(+), 105 deletions(-)
> > 
> > diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> > index 4b435b8..2a3c326 100644
> > --- a/src/ssdt-pcihp.dsl
> > +++ b/src/ssdt-pcihp.dsl
> > @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
> >          // at runtime, if the slot is detected to not support hotplug.
> >          // Extract the offset of the address dword and the
> >          // _EJ0 name to allow this patching.
> > -#define hotplug_slot(slot)                              \
> > -        Device (S##slot) {                              \
> > +#define hotplug_func(slot, fn)                          \
> > +        Device (S##slot##fn) {                          \
> >             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
> > -           Name (_ADR, 0x##slot##0000)                  \
> > +           Name (_ADR, 0x##slot##000##fn)               \
> >             ACPI_EXTRACT_METHOD_STRING aml_ej0_name      \
> >             Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
> >             Name (_SUN, 0x##slot)                        \
> >          }
> It would be perfect if the Device object could also support _PS0 and _STA
> methods.

It needs qemu support, and some backward compatibility hack.
Why?

> Could we re-add the slot back after hot-removing it from the guest
> OS with this ACPI implementation? Say execute following scripts from guest OS.
> echo 0 > /sys/bus/pci/slot/xx/power
> echo 1 > /sys/bus/pci/slot/xx/power

No because qemu removes device after eject.
Do you have a need for this functionality? What is it?

