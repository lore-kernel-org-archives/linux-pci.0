Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
Message-ID: <57698276.6050606@siemens.com>
Date: Tue, 21 Jun 2016 20:07:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Particularly useful when working in virtual environments where the
controller may come and go, but possibly not only there.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/ecam.h                  |  1 +
 drivers/pci/host/pci-host-common.c  | 13 +++++++++++++
 drivers/pci/host/pci-host-generic.c |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
index 9878beb..5a5f607 100644
--- a/drivers/pci/ecam.h
+++ b/drivers/pci/ecam.h
@@ -63,5 +63,6 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
+int pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 8cba7ab..c0ff4b1 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -164,6 +164,19 @@ int pci_host_common_probe(struct platform_device *pdev,
 	}
 
 	pci_bus_add_devices(bus);
+	platform_set_drvdata(pdev, bus);
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
index 6eaceab..0a2e75b 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -65,6 +65,7 @@ static struct platform_driver gen_pci_driver = {
 		.of_match_table = gen_pci_of_match,
 	},
 	.probe = gen_pci_probe,
+	.remove = pci_host_common_remove,
 };
 module_platform_driver(gen_pci_driver);
 
-- 
2.1.4
