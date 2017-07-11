Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org, wim.ten.have@oracle.com
Subject: [PATCH V3 1/2] PCI: Add Extended Tags quirk for Broadcom HT2100 Root
 Port
Date: Tue, 11 Jul 2017 11:25:33 -0400
Message-Id: <1499786735-25782-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

All PCIe devices are expected to be able to handle 8-bit tags.
'commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")'
enabled extended tags for all devices based on the spec direction.

The Broadcom HT2100 seems to be having issues with handling
8-bit tags. Mark it as broken.

Reported-by: Wim ten Have <wim.ten.have@oracle.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1467674
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 include/linux/pci.h  |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb78..073d5dd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4664,3 +4664,15 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+
+static void quirk_exttags_completer(struct pci_dev *pdev)
+{
+	/* This device cannot handle 256 tags as a completer */
+	pdev->broken_exttags_completer = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140,
+			quirk_exttags_completer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142,
+			quirk_exttags_completer);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144,
+			quirk_exttags_completer);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f..0b9f42d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,6 +376,7 @@ struct pci_dev {
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* broken BARs; ignore them */
+	unsigned int	broken_exttags_completer:1;
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
