Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 28 Aug 2017 16:53:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v8 0/3] PCI: iproc: SOC specific fixes
Message-ID: <20170828215309.GM8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Oza Pawandeep <oza.pawandeep@gmail.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Andy Gospodarek <gospo@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 24, 2017 at 10:34:23AM +0530, Oza Pawandeep wrote:
> PCI: iproc: Retry request when CRS returned from EP Above patch adds
> support for CRS in PCI RC driver, otherwise if not handled at lower
> level, the user space PMD (poll mode drivers) can timeout.
> 
> PCI: iproc: add device shutdown for PCI RC This fixes the issue where
> certian PCI endpoints are not getting detected on Stingray SOC after
> reboot.
> 
> Changes Since v7:
> Factor out the ep config access code.
> 
> Changes Since v6:
> Rebased patches on top of Lorenzo's patches.
> Bjorn's comments addressed.
> now the confg retry returns 0xffffffff as data.
> Added reference to PCIe spec and iproc Controller spec in Changelog.
> 
> Changes Since v5:
> Ray's comments addressed.
> 
> Changes Since v4:
> Bjorn's comments addressed.
> 
> Changes Since v3:
> [re-send]
> 
> Changes Since v2:
> Fix compilation errors for pcie-iproc-platform.ko which was caught
> by kbuild.
> 
> Oza Pawandeep (3):
>   PCI: iproc: factor-out ep configuration access
>   PCI: iproc: Retry request when CRS returned from EP
>   PCI: iproc: add device shutdown for PCI RC
> 
>  drivers/pci/host/pcie-iproc-platform.c |   8 ++
>  drivers/pci/host/pcie-iproc.c          | 143 ++++++++++++++++++++++++++-------
>  drivers/pci/host/pcie-iproc.h          |   1 +
>  3 files changed, 124 insertions(+), 28 deletions(-)

I applied these to pci/host-iproc for v4.14.  Man, this is ugly.

I reworked the changelog to try to make it more readable.  I also tried to
disable the PCI_EXP_RTCAP_CRSVIS bit, which advertises CRS SV support.  And
I removed what looked like a duplicate pci_generic_config_read32() call.
And I added a warning about the fact that we corrupt reads of config
registers that happen to contain 0xffff0001.

I'm pretty sure I broke something, so please take a look.

Incremental diff from your v8 to what's on pci/host-iproc:

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index cbdabe8a073e..8bd5e544b1c1 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -69,7 +69,7 @@
 #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
 
 #define CFG_RETRY_STATUS             0xffff0001
-#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milli-seconds. */
+#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milliseconds */
 
 /* derive the enum index of the outbound/inbound mapping registers */
 #define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
@@ -482,17 +482,21 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 	unsigned int data;
 
 	/*
-	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software
-	 * Visibility only affects config read of the Vendor ID.
-	 * For config write or any other config read the Root must
-	 * automatically re-issue configuration request again as a
-	 * new request.
+	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
+	 * affects config reads of the Vendor ID.  For config writes or any
+	 * other config reads, the Root may automatically reissue the
+	 * configuration request again as a new request.
 	 *
-	 * For config reads, this hardware returns CFG_RETRY_STATUS data when
-	 * it receives a CRS completion for a config read, regardless of the
-	 * address of the read or the CRS Software Visibility Enable bit. As a
+	 * For config reads, this hardware returns CFG_RETRY_STATUS data
+	 * when it receives a CRS completion, regardless of the address of
+	 * the read or the CRS Software Visibility Enable bit.  As a
 	 * partial workaround for this, we retry in software any read that
 	 * returns CFG_RETRY_STATUS.
+	 *
+	 * Note that a non-Vendor ID config register may have a value of
+	 * CFG_RETRY_STATUS.  If we read that, we can't distinguish it from
+	 * a CRS completion, so we will incorrectly retry the read and
+	 * eventually return the wrong data (0xffffffff).
 	 */
 	data = readl(cfg_data_p);
 	while (data == CFG_RETRY_STATUS && timeout--) {
@@ -515,10 +519,19 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	unsigned int busno = bus->number;
 	void __iomem *cfg_data_p;
 	unsigned int data;
+	int ret;
 
-	/* root complex access. */
-	if (busno == 0)
-		return pci_generic_config_read32(bus, devfn, where, size, val);
+	/* root complex access */
+	if (busno == 0) {
+		ret = pci_generic_config_read32(bus, devfn, where, size, val);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			return ret;
+
+		/* Don't advertise CRS SV support */
+		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)
+			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
+		return PCIBIOS_SUCCESSFUL;
+	}
 
 	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
 
@@ -635,7 +648,6 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
 	else
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
-	ret = pci_generic_config_read32(bus, devfn, where, size, val);
 	iproc_pcie_apb_err_disable(bus, false);
 
 	return ret;
@@ -1309,6 +1321,8 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		pcie->ib.nr_regions = ARRAY_SIZE(paxb_v2_ib_map);
 		pcie->ib_map = paxb_v2_ib_map;
 		pcie->need_msi_steer = true;
+		dev_warn(dev, "reads of config registers that contain %#x return incorrect data\n",
+			 CFG_RETRY_STATUS);
 		break;
 	case IPROC_PCIE_PAXC:
 		regs = iproc_pcie_reg_paxc;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
