Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:48952
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755856Ab2EDNZ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 May 2012 09:25:58 -0400
Date: Fri, 4 May 2012 15:25:49 +0200
From: Andreas Herrmann <andreas.herrmann3@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2][RESEND] x86/pci/amd: Enable
 early_fill_mp_bus_to_node on AMD family 15h models 0-0xf
Message-ID: <20120504132549.GD12199@alberich.amd.com>
References: <20120427143410.GB27535@alberich.amd.com>
 <20120427143745.GD27535@alberich.amd.com>
 <CAErSpo584dcpGhmp-jcP_Zsznmz9ZkfPuxpF3UK9UVfcnFUdRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAErSpo584dcpGhmp-jcP_Zsznmz9ZkfPuxpF3UK9UVfcnFUdRA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2012 at 11:34:15AM -0600, Bjorn Helgaas wrote:
> On Fri, Apr 27, 2012 at 8:37 AM, Andreas Herrmann
> <andreas.herrmann3@amd.com> wrote:
> >
> > While at it avoid calling this function on family 11h (aka Griffin)
> > which was a mobile part and doesn't support NUMA.
> 
> This changelog doesn't seem like it goes with this patch.  It looks
> more related to the first patch (though that affects family 11h and
> greater, not just family 11h).

So maybe I should repeat the contents of the subject line in the
changelog.

The first patch restores the function to set the NUMA node info for
busses. Linux behaviour shouldn't change after the first patch at all.

This (the second) patch will enable node detection for AMD CPU family
15h model 00-0fh (with 0x1600 as device id for NB function 0). (see
subject line) In addition it removes the NB id for CPU family 11h from
this code.  That CPU was used only in Laptops (single socket). A
mapping of bus to node is not required there. And also figuring out
MMIO and I/O port apertures while ignoring _CRS shouldn't be a use
case for such systems.

I think Device ID 0x1300 was added with commit
35ddd068fb94b187e94a3fc497ccecf27bdda9ae (x86: use bus conf in NB conf
fun1 to get bus range on, on 64-bit)

But unfortunately the changelog of this patch doesn't mention why this
is strictly req'd.


HTH,

Andreas

> >  arch/x86/pci/amd_bus.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
> > index 0384e69..d552b29 100644
> > --- a/arch/x86/pci/amd_bus.c
> > +++ b/arch/x86/pci/amd_bus.c
> > @@ -27,7 +27,7 @@ static struct pci_hostbridge_probe pci_probes[] __initdata = {
> >        { 0, 0x18, PCI_VENDOR_ID_AMD, 0x1100 },
> >        { 0, 0x18, PCI_VENDOR_ID_AMD, 0x1200 },
> >        { 0xff, 0, PCI_VENDOR_ID_AMD, 0x1200 },
> > -       { 0, 0x18, PCI_VENDOR_ID_AMD, 0x1300 },
> > +       { 0, 0x18, PCI_VENDOR_ID_AMD, 0x1600 },
> >  };
> >
> >  /**
> > --
> > 1.7.8.5
> >
> >
> >
> 


