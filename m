Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 4/5] PCI: iproc: Reject unconfigured physical functions from PAXC
Date: Mon, 11 Jun 2018 17:21:06 -0700
Message-Id: <1528762867-16823-5-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

PAXC is an emulated PCIe root complex internally in various Broadcom
based SoCs. PAXC internally connects to the embedded network processor
within these SoCs, with the embedeed network processor exposed as an
endpoint device

The number of physical functions from the embedded network processor
that can be accessed depend on the firmware configuration.
Unfortunately, due to an ASIC bug, unconfigured physical functions cannot
be properly hidden from the root complex during enumerattion. As a
result, config write access to these unconfigured physical functions
during enumeration will cause a bus lock up on the embedded network
processor

Fortunately, these unconfigured physical functions contain a very
specific, staled PCIe device ID 0x168e. By making use of this device ID,
one is able to terminate the enumeration early in the vendor/device ID
config read

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 26 +++++++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h |  5 +++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 0804aa2..59be1e0 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -582,6 +582,25 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (size <= 2)
 		*val = (data >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
 
+	/*
+	 * For PAXC and PAXCv2, the total number of PFs that one can enumerate
+	 * depends on the firmware configuration. Unfortunately, due to an ASIC
+	 * bug, unconfigured PFs cannot be properly hidden from the root
+	 * complex. As a result, write access to these PFs will cause bus lock
+	 * up on the embedded processor
+	 *
+	 * Since all unconfigured PFs are left with an incorrect, staled device
+	 * ID of 0x168e (PCI_DEVICE_ID_NX2_57810), we try to catch those access
+	 * early here and reject them all
+	 */
+#define DEVICE_ID_MASK     0xffff0000
+#define DEVICE_ID_SHIFT    16
+	if (pcie->rej_unconfig_pf &&
+	    (where & CFG_ADDR_REG_NUM_MASK) == PCI_VENDOR_ID)
+		if ((*val & DEVICE_ID_MASK) ==
+		    (PCI_DEVICE_ID_NX2_57810 << DEVICE_ID_SHIFT))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -681,7 +700,7 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	struct iproc_pcie *pcie = iproc_data(bus);
 
 	iproc_pcie_apb_err_disable(bus, true);
-	if (pcie->type == IPROC_PCIE_PAXB_V2)
+	if (pcie->iproc_cfg_read)
 		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
 	else
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
@@ -1336,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB:
 		regs = iproc_pcie_reg_paxb;
+		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_ob_map;
@@ -1358,10 +1378,14 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 	case IPROC_PCIE_PAXC:
 		regs = iproc_pcie_reg_paxc;
 		pcie->ep_is_internal = true;
+		pcie->iproc_cfg_read = true;
+		pcie->rej_unconfig_pf = true;
 		break;
 	case IPROC_PCIE_PAXC_V2:
 		regs = iproc_pcie_reg_paxc_v2;
 		pcie->ep_is_internal = true;
+		pcie->iproc_cfg_read = true;
+		pcie->rej_unconfig_pf = true;
 		pcie->need_msi_steer = true;
 		break;
 	default:
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 9d5cfee..4f03ea5 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -58,6 +58,9 @@ struct iproc_msi;
  * @phy: optional PHY device that controls the Serdes
  * @map_irq: function callback to map interrupts
  * @ep_is_internal: indicates an internal emulated endpoint device is connected
+ * @iproc_cfg_read: indicates the iProc config read function should be used
+ * @rej_unconfig_pf: indicates the root complex needs to detect and reject
+ * enumeration against unconfigured physical functions emulated in the ASIC
  * @has_apb_err_disable: indicates the controller can be configured to prevent
  * unsupported request from being forwarded as an APB bus error
  * @fix_paxc_cap: indicates the controller has corrupted capability list in its
@@ -86,6 +89,8 @@ struct iproc_pcie {
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool ep_is_internal;
+	bool iproc_cfg_read;
+	bool rej_unconfig_pf;
 	bool has_apb_err_disable;
 	bool fix_paxc_cap;
 
-- 
2.1.4
