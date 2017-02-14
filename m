Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH 1/2] PCI: add QCOM root port quirks for ACS
Date: Tue, 14 Feb 2017 16:25:21 -0500
Message-Id: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 alex.williamson@redhat.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

These QCOM root ports do provide ACS-like features to disable peer
transactions and validate bus numbers in requests, but do not provide an
actual PCIe ACS capability.

Hardware supports source validation but it will report the issue as
Completer Abort instead of ACS Violation.

Hardware doesn't support peer-to-peer and each root port is a root complex
with unique segment numbers.

It is not possible for one root port to pass traffic to the other root
port. All PCIe transactions are terminated inside the root port.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/quirks.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1800bef..932949a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4136,6 +4136,27 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
+ * These QCOM root ports do provide ACS-like features to disable peer
+ * transactions and validate bus numbers in requests, but do not provide an
+ * actual PCIe ACS capability.
+ * Hardware supports source validation but it will report the issue as
+ * Completer Abort instead of ACS Violation.
+ * Hardware doesn't support peer-to-peer and each root port is a root complex
+ * with unique segment numbers.
+ * It is not possible for one root port to pass traffic to the other root
+ * port. All PCIe transactions are terminated inside the root port.
+ */
+static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
+	int ret = acs_flags & ~flags ? 0 : 1;
+
+	dev_info_once(&dev->dev, "Using QCOM ACS Quirk (%d)\n", ret);
+
+	return ret;
+}
+
+/*
  * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
  * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
  * 12.1.46, 12.1.47)[1] this chipset uses dwords for the ACS capability and
@@ -4271,6 +4292,9 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	/* I219 */
 	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
+	/* QCOM QDF2xxx root ports */
+	{ 0x17CB, 0x400, pci_quirk_qcom_rp_acs },
+	{ 0x17CB, 0x401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
