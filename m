Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Jayachandran C <jchandra@broadcom.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Christopher Covington <cov@codeaurora.org>,
        Duc Dang <dhdang@apm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: generic: stop hiding pci_host_common_probe declaration
Date: Tue, 21 Mar 2017 16:59:52 +0100
Message-Id: <20170321160003.339217-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When pci_host_common_probe() was moved into a separate module, the #ifdef around
the declaration was left in the header file, which can lead to build errors in
some configurations:

drivers/pci/host/pci-thunder-pem.c: In function 'thunder_pem_probe':
drivers/pci/host/pci-thunder-pem.c:412:9: error: implicit declaration of function 'pci_host_common_probe';did you mean 'pci_host_bridge_priv'? [-Werror=implicit-function-declaration]

The ifdef serves no real purpose anyway, so we can just remove it.

Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/pci-ecam.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index f0d2b9451270..92a73847e1d3 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -68,9 +68,7 @@ extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
 extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
 #endif
 
-#ifdef CONFIG_PCI_HOST_GENERIC
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
 #endif
-#endif
-- 
2.9.0
