Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45567 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752463AbaACTK0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 14:10:26 -0500
Date: Fri, 3 Jan 2014 20:10:24 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	Gregory Cl??ment <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Message-ID: <20140103201024.08ca11fb@skate>
In-Reply-To: <3246739.aRbALcNl1Y@wuerfel>
References: <20131226160534.36cc4203@skate>
	<201401031322.31433.arnd@arndb.de>
	<20140103200106.5a0999a3@skate>
	<3246739.aRbALcNl1Y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Fri, 03 Jan 2014 20:04:57 +0100, Arnd Bergmann wrote:

> > Digging in the LAKML archive, I found a lspci -v output about the
> > e1000e, and it has an I/O space:
> 
> Ok, thanks for the confirmation!
> 
> Do you mind posting your hack here? It may be useful for others as
> well, such as the xgene developers that seem to be doing funny things
> with their I/O space.

The current hack is the following very ugly piece of code... It runs
some command and reads back some registers, and you should see some
well-known values (which can be found in the e1000 datasheet, I don't
remember them right now).

I'm not sure why I do the pci_request_selected_regions_exclusive() call
*after* the actual in/out. Probably a mistake, but as I said, this is
ugly stuff :)

Thomas

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index fbf75fd..739ca10 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6045,7 +6045,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (aspm_disable_flag)
 		e1000e_disable_aspm(pdev, aspm_disable_flag);
 
-	err = pci_enable_device_mem(pdev);
+	err = pci_enable_device(pdev);
 	if (err)
 		return err;
 
@@ -6073,6 +6073,34 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_pci_reg;
 
+	dev_info(&pdev->dev, "==> e1000e: I/O start 0x%x, len 0x%x\n",
+		 pci_resource_start(pdev, 2),
+		 pci_resource_len(pdev, 2));
+
+
+	{
+		unsigned long ioport_base = pci_resource_start(pdev, 2);
+		dev_info(&pdev->dev, "1. 0x%x 0x%x 0x%x 0x%x\n",
+			 inl(ioport_base),
+			 inl(ioport_base + 4),
+			 inl(ioport_base + 8),
+			 inl(ioport_base + 12));
+		outl(0x38, ioport_base);
+		dev_info(&pdev->dev, "2. 0x%x 0x%x 0x%x 0x%x\n",
+			 inl(ioport_base),
+			 inl(ioport_base + 4),
+			 inl(ioport_base + 8),
+			 inl(ioport_base + 12));
+	}
+
+	err = pci_request_selected_regions_exclusive(pdev,
+						     pci_select_bars(pdev, IORESOURCE_IO),
+						     e1000e_driver_name);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot get I/O region\n");
+		goto err_pci_reg;
+	}
+
 	/* AER (Advanced Error Reporting) hooks */
 	pci_enable_pcie_error_reporting(pdev);
 
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
