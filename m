Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-pci@vger.kernel.org, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 13/32] PCI/MIPS: use PCIe capabilities access functions to simplify implementation
Date: Wed,  1 Aug 2012 23:54:18 +0800
Message-Id: <1343836477-7287-14-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Use PCIe capabilities access functions to simplify PCIe MIPS implementation.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/mips/pci/pci-octeon.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 52a1ba7..aaed2ad 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -117,16 +117,11 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	}
 
 	/* Enable the PCIe normal error reporting */
-	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (pos) {
-		/* Update Device Control */
-		pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &config);
-		config |= PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
-		config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
-		config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
-		pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, config);
-	}
+	config = PCI_EXP_DEVCTL_CERE; /* Correctable Error Reporting */
+	config |= PCI_EXP_DEVCTL_NFERE; /* Non-Fatal Error Reporting */
+	config |= PCI_EXP_DEVCTL_FERE;  /* Fatal Error Reporting */
+	config |= PCI_EXP_DEVCTL_URRE;  /* Unsupported Request */
+	pci_pcie_capability_change_word(dev, PCI_EXP_DEVCTL, config, 0);
 
 	/* Find the Advanced Error Reporting capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-- 
1.7.9.5

