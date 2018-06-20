Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by all
 bridges
Date: Tue, 19 Jun 2018 22:14:46 -0400
Message-Id: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

A PCIe endpoint carries the process address space identifier (PASID) in
the TLP prefix as part of the memory read/write transaction. The address
information in the TLP is relevant only for a given PASID context.

An IOMMU takes PASID value and the address information from the
TLP to look up the physical address in the system.

If a bridge drops the TLP prefix, the translation agent can resolve the
address to an incorrect location and cause data corruption. Prevent
this condition by requiring End-to-End TLP prefix to be supported on the
entire data path between the endpoint and the root port.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/ats.c             |  9 +++++++++
 drivers/pci/probe.c           | 17 +++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 28 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 4923a2a..e1b2e6d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -268,6 +268,7 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
 int pci_enable_pasid(struct pci_dev *pdev, int features)
 {
 	u16 control, supported;
+	struct pci_dev *bridge;
 	int pos;
 
 	if (WARN_ON(pdev->pasid_enabled))
@@ -277,6 +278,14 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pos)
 		return -EINVAL;
 
+	bridge = pci_upstream_bridge(pdev);
+	while (bridge) {
+		if (!bridge->eetlp_prefix)
+			return -EINVAL;
+
+		bridge = pci_upstream_bridge(bridge);
+	}
+
 	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e3..a7f7ac1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2042,6 +2042,22 @@ static void pci_configure_ltr(struct pci_dev *dev)
 #endif
 }
 
+static void pci_configure_eetlp_prefix(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_PASID
+	u32 cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
+		return;
+
+	dev->eetlp_prefix = 1;
+#endif
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	struct hotplug_params hpp;
@@ -2051,6 +2067,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
 	pci_configure_ltr(dev);
+	pci_configure_eetlp_prefix(dev);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..cf88d47 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -350,6 +350,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
+	unsigned int	eetlp_prefix:1;	/* End-to-End TLP Prefix */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
 	struct device	dev;			/* Generic device interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4da87e2..a617ab2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -636,6 +636,7 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
+#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
