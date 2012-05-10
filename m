Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab2EJREF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 May 2012 13:04:05 -0400
Date: Thu, 10 May 2012 20:03:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Amos Kong <akong@redhat.com>, linux-pci@vger.kernel.org,
	seabios@seabios.org, qemu-devel@nongnu.org,
	jbarnes@virtuousgeek.org, rjw@sisk.pl, kevin@koconnor.net
Subject: Re: [RESEND PATCH v3] hotplug: add device per func in ACPI DSDT
 tables
Message-ID: <20120510170345.GC14647@redhat.com>
References: <20111214010645.GA2044@morn.localdomain>
 <20120509072452.14872.92530.stgit@t>
 <1336571221.12477.136.camel@bling.home>
 <4FABF1DD.7090101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FABF1DD.7090101@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 12:50:37AM +0800, Jiang Liu wrote:
> On 05/09/2012 09:47 PM, Alex Williamson wrote:
> >> ---
> >>  src/ssdt-pcihp.dsl |   17 
> >>  src/ssdt-pcihp.hex | 8869 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 8781 insertions(+), 105 deletions(-)
> >>
> >> diff --git a/src/ssdt-pcihp.dsl b/src/ssdt-pcihp.dsl
> >> index 4b435b8..2a3c326 100644
> >> --- a/src/ssdt-pcihp.dsl
> >> +++ b/src/ssdt-pcihp.dsl
> >> @@ -17,14 +17,23 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
> >>          // at runtime, if the slot is detected to not support hotplug.
> >>          // Extract the offset of the address dword and the
> >>          // _EJ0 name to allow this patching.
> >> -#define hotplug_slot(slot)                              \
> >> -        Device (S##slot) {                              \
> >> +#define hotplug_func(slot, fn)                          \
> >> +        Device (S##slot##fn) {                          \
> >>             ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
> >> -           Name (_ADR, 0x##slot##0000)                  \
> > 
> > I would have guessed it to be sufficient to change _ADR to
> > 0x##slot##ffff, does that not work?  Thanks,
> > 
> > Alex
> Currently Linux acpiphp driver doesn't support that yet.
> 
> --gerry

If memory serves neither does windows.

