Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33265 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbbFLXjc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 19:39:32 -0400
Received: by iebgx4 with SMTP id gx4so32965581ieb.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2015 16:39:32 -0700 (PDT)
Date: Fri, 12 Jun 2015 18:39:28 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: festevam@gmail.com, marex@denx.de, linux-pci@vger.kernel.org,
	r65037@freescale.com, l.stach@pengutronix.de, tharvey@gateworks.com
Subject: Re: [PATCH 1/1] pci-imx6: add speed change timeout message
Message-ID: <20150612233928.GL23119@google.com>
References: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
 <20150612202008.GI23119@google.com>
 <557B5C75.7040905@boundarydevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <557B5C75.7040905@boundarydevices.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 12, 2015 at 03:25:57PM -0700, Troy Kisky wrote:
> On 6/12/2015 1:20 PM, Bjorn Helgaas wrote:
> > Unrelated to your patch, but noticed while doing this: what's the magic
> > constant 0x80 here?
> > 
> > +	tmp = readl(pp->dbi_base + 0x80);
> > 
> > Is that correct?  Can we add a symbolic name for it?
> > 
> > Bjorn
> > 
> 
> The name in the manual for +x80 is
> PCIE_RC_LCSR - Link Control and Status Register


commit bc82467358d3793e1291e38cd01883e74e872eeb
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jun 12 17:27:43 2015 -0500

    PCI: imx6: Add #define PCIE_RC_LCSR
    
    Define PCIE_RC_LCSR and use it instead of the bare offset "0x80."
    No functional change.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a032c01..57db1c1 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -47,6 +47,8 @@ struct imx6_pcie {
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
 
+#define PCIE_RC_LCSR				0x80
+
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
 #define PCIE_PL_PFLR (PL_OFFSET + 0x08)
@@ -427,7 +429,7 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 		return ret;
 	}
 
-	tmp = readl(pp->dbi_base + 0x80);
+	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
 	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
 	return 0;
 }
