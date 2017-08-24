Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=+FHt=72=broadcom.com=oza.oza@kernel.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	<helgaas@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Oza Pawandeep <oza.oza@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v8 2/3] PCI: iproc: retry request when CRS returned from EP
Date: Thu, 24 Aug 2017 10:34:25 +0530
Message-Id: <1503551066-23212-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
References: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Per PCIe r3.1, sec 2.3.2, config requests that receive completions
with Configuration Request Retry Status (CRS) should be reissued by
the hardware except reads of the Vendor ID when CRS Software
Visibility is enabled.

This hardware never reissues configuration requests when it receives
CRS completions.
Note that, neither PCIe host bridge nor PCIe core re-issues the
request for any configuration offset.

For config reads, this hardware returns CFG_RETRY_STATUS data when
it receives a CRS completion for a config read, regardless of the
address of the read or the CRS Software Visibility Enable bit.

This patch implements iproc_pcie_config_read which gets called for
Stingray, if it receives a CRS completion, it retries reading it again.
In case of timeout, it returns 0xffffffff.
For other iproc based SOC, it falls back to PCI generic APIs.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 61d9be6..37f4adf 100644
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
 
@@ -473,6 +476,64 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
 	return (pcie->base + offset);
 }
 
+static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
+{
+	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
+	unsigned int data;
+
+	/*
+	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software
+	 * Visibility only affects config read of the Vendor ID.
+	 * For config write or any other config read the Root must
+	 * automatically re-issue configuration request again as a
+	 * new request.
+	 *
+	 * For config reads, this hardware returns CFG_RETRY_STATUS data when
+	 * it receives a CRS completion for a config read, regardless of the
+	 * address of the read or the CRS Software Visibility Enable bit. As a
+	 * partial workaround for this, we retry in software any read that
+	 * returns CFG_RETRY_STATUS.
+	 */
+	data = readl(cfg_data_p);
+	while (data == CFG_RETRY_STATUS && timeout--) {
+		udelay(1);
+		data = readl(cfg_data_p);
+	}
+
+	if (data == CFG_RETRY_STATUS)
+		data = 0xffffffff;
+
+	return data;
+}
+
+static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *val)
+{
+	struct iproc_pcie *pcie = iproc_data(bus);
+	unsigned int slot = PCI_SLOT(devfn);
+	unsigned int fn = PCI_FUNC(devfn);
+	unsigned int busno = bus->number;
+	void __iomem *cfg_data_p;
+	unsigned int data;
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
+	data = iproc_pcie_cfg_retry(cfg_data_p);
+
+	*val = data;
+	if (size <= 2)
+		*val = (data >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 /**
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
@@ -567,8 +628,13 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
 	int ret;
+	struct iproc_pcie *pcie = iproc_data(bus);
 
 	iproc_pcie_apb_err_disable(bus, true);
+	if (pcie->type == IPROC_PCIE_PAXB_V2)
+		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
+	else
+		ret = pci_generic_config_read32(bus, devfn, where, size, val);
 	ret = pci_generic_config_read32(bus, devfn, where, size, val);
 	iproc_pcie_apb_err_disable(bus, false);
 
-- 
1.9.1
