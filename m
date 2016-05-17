Return-Path: <jroedel@suse.de>
Return-Path: <jroedel@suse.de>
Date: Tue, 17 May 2016 12:17:37 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Build breakage for pci-next since v4.6-rc5
Message-ID: <20160517101737.GI9801@suse.de>
References: <20160513115642.GA22906@wunner.de>
 <36D38C1F74839847A52A484C31F3E51A62221FEF@irsmsx105.ger.corp.intel.com>
 <20160516201000.GB20759@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160516201000.GB20759@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, May 16, 2016 at 03:10:00PM -0500, Bjorn Helgaas wrote:
> I don't want to rebase my "next" branch, but if you could post the 
> incremental patch to fix up drivers/iommu/amd_iommu.c, I'll ask Linus
> to include that when he pulls my branch.

Here is the proper fix:

>From 4b19e8719c47fc8fef7c14410db606d16c9c76e3 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 17 May 2016 12:13:57 +0200
Subject: [PATCH] iommu/amd: Use pci_dma_add_alias function

The pci_dma_add_alias() function is the new interface and
replaces the old direct-access of 'struct pci_dev'. Convert the
last use of the old interface to the new one in the AMD
IOMMU driver.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5efadad..3839fd2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -263,8 +263,7 @@ static u16 get_alias(struct device *dev)
 	 */
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		pdev->dma_alias_devfn = ivrs_alias & 0xff;
+		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
 		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
-- 
2.6.6
