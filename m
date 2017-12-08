Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdLHR4h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 12:56:37 -0500
Date: Fri, 8 Dec 2017 11:56:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/PCI: limit the size of the 64bit BAR to 256GB
Message-ID: <20171208175635.GB12367@bhelgaas-glaptop.roam.corp.google.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
 <20171129141229.6107-4-christian.koenig@amd.com>
 <20171206195118.GL23510@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171206195118.GL23510@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 06, 2017 at 01:51:18PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 29, 2017 at 03:12:29PM +0100, Christian König wrote:
> > This avoids problems with Xen which hides some memory resources from the
> > OS and potentially also allows memory hotplug while this fixup is
> > enabled.
> 
> The patch itself is OK, but the changelog doesn't say enough about
> what the problem is.  I have no clue about what the Xen issue is or
> why limiting the BAR to 256GB avoids the problem or what this has to
> do with memory hotplug.
> 
> For example, we should be able to tell why 256GB is the right number.
> Maybe there's something specific in Xen you can reference?  Maybe an
> example of what goes wrong with some details?

Ping?  Is this change required to fix issues people are seeing?  If
so, we either need to rework the changelog and get it merged, or
revert the quirk as a whole.

I tentatively applied the first two patches to for-linus, but I
haven't asked Linus to pull them because I assumed we really needed
all three.

Bjorn

> > Signed-off-by: Christian König <christian.koenig@amd.com>
> > ---
> >  arch/x86/pci/fixup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index c817ab85dc82..149adbc7f2a3 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -701,7 +701,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
> >  	res->name = "PCI Bus 0000:00";
> >  	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
> >  		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
> > -	res->start = 0x100000000ull;
> > +	res->start = 0xbd00000000ull;
> >  	res->end = 0xfd00000000ull - 1;
> >  
> >  	/* Just grab the free area behind system memory for this */
> > -- 
> > 2.11.0
> > 
