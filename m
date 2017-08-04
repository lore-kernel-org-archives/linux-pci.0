Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v6 1/2] PCI: iproc: Retry request when CRS returned from EP
Date: Fri,  4 Aug 2017 21:18:15 +0530
Message-Id: <1501861696-25767-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe spec r3.1, sec 2.3.2
If CRS software visibility is not enabled, the RC must reissue the
config request as a new request.

- If CRS software visibility is enabled,
- for a config read of Vendor ID, the RC must return 0x0001 data
- for all other config reads/writes, the RC must reissue the
  request

iproc PCIe Controller spec:
4.7.3.3. Retry Status On Configuration Cycle
Endpoints are allowed to generate retry status on configuration
cycles. In this case, the RC needs to re-issue the request. The IP
does not handle this because the number of configuration cycles needed
will probably be less than the total number of non-posted operations
needed.

When a retry status is received on the User RX interface for a
configuration request that was sent on the User TX interface,
it will be indicated with a completion with the CMPL_STATUS field set
to 2=CRS, and the user will have to find the address and data values
and send a new transaction on the User TX interface.
When the internal configuration space returns a retry status during a
configuration cycle (user_cscfg = 1) on the Command/Status interface,
the pcie_cscrs will assert with the pcie_csack signal to indicate the
CRS status.
When the CRS Software Visibility Enable register in the Root Control
register is enabled, the IP will return the data value to 0x0001 for
the Vendor ID value and 0xffff  (all 1’s) for the rest of the data in
the request for reads of offset 0 that return with CRS status.  This
is true for both the User RX Interface and for the Command/Status
interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
field of the completion on the User RX Interface will not be 2=CRS and
the pcie_cscrs signal will not assert on the Command/Status interface.

Note that, neither PCIe host bridge nor PCIe core re-issues the
request for any configuration offset.

As a result of the fact, PCIe RC driver (sw) should take care of
retrying.
This patch fixes the problem, and attempts to read config space again
in case of PCIe code forwarding the CRS back to CPU.
It implements iproc_pcie_config_read which gets called for Stingray,
Otherwise it falls back to PCI generic APIs.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 0f39bd2..583cee0 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -68,6 +68,9 @@
 #define APB_ERR_EN_SHIFT             0
 #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
 
+#define CFG_RETRY_STATUS             0xffff0001
+#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. */
+
 /* derive the enum index of the outbound/inbound mapping registers */
 #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
 
@@ -448,6 +451,66 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
 	}
 }
 
+static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
+{
+	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
+	unsigned int ret;
+
+	/*
+	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software
+	 * Visibility only affects config read of the Vendor ID.
+	 * For config write or any other config read the Root must
+	 * automatically re-issue configuration request again as a
+	 * new request.
+	 *
+	 * Iproc based PCIe RC (hw) does not retry
+	 * request on its own, so handle it here.
+	 * Note that, AXI data 0xffff0001 returned by PAXB could be
+	 * valid data in configuration space, for e.g. BAR requesting
+	 * 64bit IO memory, so we retry till timeout.
+	 * And leave to be handled by upper layers.
+	 *
+	 * Also, iproc PCIe RC does not have any effect on
+	 * CRS Software visibility bit, irrespective if it
+	 * set or unset, the RC will never re-issue any configuration
+	 * access request.
+	 */
+	do {
+		ret = readl(cfg_data_p);
+		if (ret == CFG_RETRY_STATUS)
+			udelay(1);
+		else
+			return PCIBIOS_SUCCESSFUL;
+	} while (timeout--);
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
+					       unsigned int busno,
+					       unsigned int slot,
+					       unsigned int fn,
+					       int where)
+{
+	u16 offset;
+	u32 val;
+
+	/* EP device access */
+	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
+		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
+		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
+		(where & CFG_ADDR_REG_NUM_MASK) |
+		(1 & CFG_ADDR_CFG_TYPE_MASK);
+
+	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
+	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
+
+	if (iproc_pcie_reg_is_invalid(offset))
+		return NULL;
+
+	return (pcie->base + offset);
+}
+
 /**
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
@@ -499,13 +562,48 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		return (pcie->base + offset);
 }
 
+static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *val)
+{
+	struct iproc_pcie *pcie = iproc_data(bus);
+	unsigned int slot = PCI_SLOT(devfn);
+	unsigned int fn = PCI_FUNC(devfn);
+	unsigned int busno = bus->number;
+	void __iomem *cfg_data_p;
+	int ret;
+
+	/* root complex access. */
+	if (busno == 0)
+		return pci_generic_config_read32(bus, devfn, where, size, val);
+
+	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
+
+	if (!cfg_data_p)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	ret = iproc_pcie_cfg_retry(cfg_data_p);
+	if (ret)
+		return ret;
+
+	*val = readl(cfg_data_p);
+
+	if (size <= 2)
+		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
 	int ret;
+	struct iproc_pcie *pcie = iproc_data(bus);
 
 	iproc_pcie_apb_err_disable(bus, true);
-	ret = pci_generic_config_read32(bus, devfn, where, size, val);
+	if (pcie->type == IPROC_PCIE_PAXB_V2)
+		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
+	else
+		ret = pci_generic_config_read32(bus, devfn, where, size, val);
 	iproc_pcie_apb_err_disable(bus, false);
 
 	return ret;
-- 
1.9.1
