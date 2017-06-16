Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI: Workaround AMD EHCI controller PME bug
Date: Fri, 16 Jun 2017 17:40:54 +0800
Message-Id: <20170616094054.8044-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On an AMD Carrizo laptop, when EHCI runtime PM is enabled, EHCI ports do
not respond to any device plugging event.

As Alan Stern points out [1], the PME signal is not enabled when
controller is in D3, therefore it's not being woken up when new deivces
get plugged in.

Testing shows PME signal works when the EHCI power state is D2.

Bjorn Helgaas suggests to flip bits PCI_PM_CAP_PME_D3 and
PCI_PM_CAP_PME_D3cold in PCI fixup.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196091
Link: https://support.amd.com/TechDocs/46837.pdf (Section 23)
Link: https://support.amd.com/TechDocs/42413.pdf (Appendix A2)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/pci/fixup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 6d52b94f4bb9..0f71a908e262 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -571,3 +571,18 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+
+/*
+ * Device [1022:7808]
+ * 23. USB Wake on Connect/Disconnect with Low Speed Devices
+ * https://support.amd.com/TechDocs/46837.pdf
+ * Appendix A2
+ * https://support.amd.com/TechDocs/42413.pdf
+ */
+static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "PME# does not work under D3, disabling it\n");
+	dev->pme_support &= ~(PCI_PM_CAP_PME_D3 | PCI_PM_CAP_PME_D3cold)
+		>> PCI_PM_CAP_PME_SHIFT;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);
-- 
2.13.1
