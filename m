Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kishon@ti.com>
CC: <nsekhar@ti.com>
Subject: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend and resume
Date: Fri, 3 Jul 2015 16:33:44 +0530
Message-ID: <1435921425-15121-3-git-send-email-kishon@ti.com>
In-Reply-To: <1435921425-15121-1-git-send-email-kishon@ti.com>
References: <1435921425-15121-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain platforms require MSE bit to be cleared to set the master
in standby mode. (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe
Controller Master Standby Behavior advises to use the clearing
of the local MSE bit to set the master in standby. Without this
some of the clocks do not idle).

Cleared the MSE bit on suspend and enabled it back on resume.
This is required to get suspend/resume working.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/host/pcie-designware.c |   20 ++++++++++++++++++++
 drivers/pci/host/pcie-designware.h |    2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..cfb2bd6 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -811,6 +811,26 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
 
+void dw_pcie_suspend_rc(struct pcie_port *pp)
+{
+	u32 val;
+
+	/* clear MSE */
+	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
+	val &= ~PCI_COMMAND_MEMORY;
+	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
+}
+
+void dw_pcie_resume_rc(struct pcie_port *pp)
+{
+	u32 val;
+
+	/* set MSE */
+	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
+	val |= PCI_COMMAND_MEMORY;
+	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
+}
+
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
 MODULE_DESCRIPTION("Designware PCIe host controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..0df2dfa 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -83,5 +83,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_suspend_rc(struct pcie_port *pp);
+void dw_pcie_resume_rc(struct pcie_port *pp);
 
 #endif /* _PCIE_DESIGNWARE_H */
-- 
1.7.9.5

