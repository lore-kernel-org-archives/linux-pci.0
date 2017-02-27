Return-Path: <linux-arch-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Subject: [PATCH 13/20] PCI: iproc-platform: update PCI config space remap function
Date: Mon, 27 Feb 2017 15:14:24 +0000
Message-Id: <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/pcie-iproc-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index f4909bb..b48d0db 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
+	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
+					     resource_size(&reg));
 	if (!pcie->base) {
 		dev_err(dev, "unable to map controller registers\n");
 		return -ENOMEM;
-- 
2.10.0
