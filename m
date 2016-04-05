Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758776AbcDERRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 13:17:33 -0400
Date: Tue, 5 Apr 2016 12:17:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Fix spelling mistake "Initialization"
Message-ID: <20160405171729.GB12135@localhost>
References: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 03, 2016 at 11:56:16AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Minor fix, spelling mistake "Initalization" should be
> "Initialization".
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to pci/misc for v4.7, thanks, Colin!

I noticed the same error in drivers/pci/pci.c and fixed that as well:

commit dcbb408ac5a2803ba44ca2fae8bf53eb5d4082f3
Author: Colin Ian King <colin.king@canonical.com>
Date:   Tue Apr 5 12:12:45 2016 -0500

    PCI: Fix spelling errors
    
    Fix spelling of "initalization".
    
    [bhelgaas: also fix pci/pci.c]
    Signed-off-by: Colin Ian King <colin.king@canonical.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 5139e64..3479d30 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -819,7 +819,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
-		dev_err(pcie->dev, "HW Initalization failed\n");
+		dev_err(pcie->dev, "HW Initialization failed\n");
 		return err;
 	}
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..e3d6b33 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2389,7 +2389,7 @@ out:
 	return offset + ent_size;
 }
 
-/* Enhanced Allocation Initalization */
+/* Enhanced Allocation Initialization */
 void pci_ea_init(struct pci_dev *dev)
 {
 	int ea;
