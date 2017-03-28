Return-Path: <SRS0=FwkQ=3F=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=FwkQ=3F=sigmadesigns.com=Marc_Gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [TRIVIAL PATCH] PCI: Change pci_host_common_probe visibility
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Jayachandran C <jchandra@broadcom.com>
Message-ID: <11bd9bd5-5d96-bd7c-24c7-5f262a46085c@sigmadesigns.com>
Date: Tue, 28 Mar 2017 17:29:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

pci_host_common_probe is defined when CONFIG_PCI_HOST_COMMON=y
therefore the function declaration should match that.

drivers/pci/host/pcie-tango.c:300:9: error:
	implicit declaration of function 'pci_host_common_probe'

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 include/linux/pci-ecam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 33c4750781a0..e746803df566 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -60,7 +60,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern struct pci_ecam_ops pci_generic_ecam_ops;
 
-#ifdef CONFIG_PCI_HOST_GENERIC
+#ifdef CONFIG_PCI_HOST_COMMON
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
-- 
2.11.0
