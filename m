Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/8] PCI: Add support for unbinding the generic PCI host
 controller
Date: Tue, 15 May 2018 07:58:15 +0200
Message-Id: <0ddc38e9d589c9560cb6b59d768d880e6541ae47.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
