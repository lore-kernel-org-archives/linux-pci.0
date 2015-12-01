Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41377 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338AbbLAOjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Dec 2015 09:39:08 -0500
Date: Tue, 1 Dec 2015 08:39:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com, mpe@ellerman.id.au, paulus@samba.org,
	benh@kernel.crashing.org, mst@redhat.com, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
Message-ID: <20151201143905.GA9473@localhost>
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20151201013540.GB9306@localhost>
 <565D9586.4050605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <565D9586.4050605@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 01, 2015 at 10:41:42AM -0200, Guilherme G. Piccoli wrote:
> On 11/30/2015 11:35 PM, Bjorn Helgaas wrote:
> >Thanks for your patience, Guilherme.
> 
> Hello Bjorn, thank you for the very deep review of my patch. Much
> appreciated!
> 
> 
> >I applied this to pci/msi for v4.5.  I reworked the changelog and made
> >pci_msi_setup_pci_dev() static, since I think it's now only called
> >from drivers/pci/probe.c.
> 
> Thanks. Regarding pci_msi_setup_pci_dev(), it really should be
> static. I changed it because PowerPC arch was calling this since my
> last patch, but this patch remove the call from PowerPC arch, so
> it's great to see this function static again.
> 
> 
> >I didn't quite follow the last paragraph about reverting 1851617cd2da.
> >1851617cd2da moved the MSI init (dev->msi_cap init and MSI disable)
> >from pci/msi.c (where it was only done when CONFIG_PCI_MSI=y) to
> >pci/probe.c (where we did it for all non-OF arches, regardless of
> >CONFIG_PCI_MSI).  So I would characterize this patch as doing the MSI
> >init for *all* arches, regardless of CONFIG_PCI_MSI.
> 
> Well, my English skills aren't so good, so I possibly I wrote
> confusing text. What I meant is that, from practical viewpoint, what
> we did here has the same effect of reverting those patches (in the
> sense of initializing MSI caps). But you can ignore my statement,
> and I appreciate that you removed it from the commit message if it
> was confusing heh

No problem, just making sure I wasn't missing something.  It's not a
literal revert, but it certainly does touch the same code.

Bjorn
