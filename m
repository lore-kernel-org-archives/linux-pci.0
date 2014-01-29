Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37592 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaA2Gmh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 01:42:37 -0500
Date: Wed, 29 Jan 2014 15:42:34 +0900
From: Simon Horman <horms@verge.net.au>
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: rcar: fix bridge logic configuration accesses
Message-ID: <20140129064234.GG23833@verge.net.au>
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390903616-8073-4-git-send-email-ben.dooks@codethink.co.uk>
 <52E807E9.8060900@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E807E9.8060900@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 28, 2014 at 11:41:29PM +0400, Valentine wrote:
> On 01/28/2014 02:06 PM, Ben Dooks wrote:
> >The bridge logic at slot 0 only supports reads up to 0x40 and the
> >rest of the PCI configuration space for this slot is marked as
> >reserved in the manual.
> >
> >Trying a read from offset 0x100 is producing an error from the
> >bridge. With error interrupts enabled, the following is printed:
> 
> I don't think this is a critical error.
> The bridge works fine after an attempt to access the unsupported PCIe/PCI-X 2 area.
> 
> If you want to prevent the access, I'm OK with it.
> But I think it's better to do "if (where <= 0x100)"
> and drop the slot check since all other slots do not support
> access beyond 0x100 as well.
> 
> The PCI code attempts to access beyond 0x100 only once when probing PCI bridges
> to see if they support PCIe/PCI-X 2 area which is 4K.
> The area beyond 0x40 is never accessed because the bridge does not expose any PCI capabilities.
> 
> >
> >pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014
> 
> Did you experience any problems other than this message
> printed by the IRQ handler introduced by the previous patch?

I am wondering if the documentation for the r8a7790 and r8a7791 are
the same with regards to the <= 0x100 limit.

> 
> >
> >Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >---
> >Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >Cc: Simon Horman <horms@verge.net.au>
> >Cc: Bjorn Helgaas <bhelgaas@google.com>
> >Cc: linux-pci@vger.kernel.org
> >Cc: linux-sh@vger.kernel.org
> >---
> >  drivers/pci/host/pci-rcar-gen2.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> >index 01ba069..42f0105 100644
> >--- a/drivers/pci/host/pci-rcar-gen2.c
> >+++ b/drivers/pci/host/pci-rcar-gen2.c
> >@@ -119,6 +119,10 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
> >  	if (slot > 2)
> >  		return NULL;
> >
> >+	/* bridge logic only has registers to 0x40 */
> >+	if (slot == 0x0 && where >= 0x40)
> >+		return NULL;
> >+
> >  	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
> >  		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
> >
> >
> 
> Thanks,
> Val.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
