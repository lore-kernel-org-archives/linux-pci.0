Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:41462 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDXP2Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Apr 2018 11:28:16 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5/6] PCI: Add support for unbinding the generic PCI host controller
Date: Tue, 24 Apr 2018 17:13:41 +0200
Message-Id: <e420c5f6e3a6f8326d941d21bd730034d7b41cee.1524582822.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1524582822.git.jan.kiszka@siemens.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1524582822.git.jan.kiszka@siemens.com>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Particularly useful when working in virtual environments where the
controller may come and go, but possibly not only there.

CC: Will Deacon <will.deacon@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/host/pci-host-common.c  | 13 +++++++++++++
 drivers/pci/host/pci-host-generic.c |  1 +
 include/linux/pci-ecam.h            |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 5d028f53fdcd..d8f10451f273 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -101,5 +101,18 @@ int pci_host_common_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	platform_set_drvdata(pdev, bridge->bus);
+	return 0;
+}
+
+int pci_host_common_remove(struct platform_device *pdev)
+{
+	struct pci_bus *bus = platform_get_drvdata(pdev);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(bus);
+	pci_remove_root_bus(bus);
+	pci_unlock_rescan_remove();
+
 	return 0;
 }
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 45319ee3b484..dea3ec7592a2 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -95,5 +95,6 @@ static struct platform_driver gen_pci_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = gen_pci_probe,
+	.remove = pci_host_common_remove,
 };
 builtin_platform_driver(gen_pci_driver);
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index baadad1aabbc..29efa09d686b 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,5 +62,6 @@ extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
+int pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif
-- 
2.13.6
