Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH 3/3] PCI: generic: Fix the bug of pci_fixup_irqs() for arm64 platform.
Date: Thu, 12 Jan 2017 14:28:24 +0800
Message-ID: <1484202504-96686-4-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

arch/arm64/pci.c pcibios_alloc_irq() has the same function as
pci_fixup_irqs(), so we add condition #ifndef CONFIG_ARM64 for
pci_fixup_irqs().

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pci-host-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index e3c48b5..f160afc 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -145,7 +145,9 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
+#ifndef CONFIG_ARM64
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
 
 	/*
 	 * We insert PCI resources into the iomem_resource and
-- 
1.9.1
