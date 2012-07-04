Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58680 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab2GDIeQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 04:34:16 -0400
Received: by pbbrp8 with SMTP id rp8so10694040pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 04 Jul 2012 01:34:15 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Quirk for ASUS S3 issue
Date: Wed,  4 Jul 2012 16:34:11 +0800
Message-Id: <1341390851-22099-1-git-send-email-acelan.kao@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Attempt to suspend some ASUS systems causes hang. Power cycle required
to recover.
The root cause of this issue is result from the the BIOS will try to
disable USB which is already disabled by the driver.
BIOS will check the EHCI controller's PCI COMMAND register,
if it's not zero, then BIOS will think the USB is not disabled yet,
so it will try to disable USB again, and then hang in the BIOS code.
To resolve this, we should clear the EHCI controller's PCI COMMAND
register before entering S3. And this does no harm to the system,
since it'll switch off the power after enter S3, and the value in the
register will be reset by BIOS after wakeup.

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=43064
BugLink: http://bugs.launchpad.net/bugs/951143

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/pci/quirks.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 194b243a..d1bb4db 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2955,6 +2955,25 @@ static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
 
+/*
+ * ASUS BIOS will check the EHCI controller's PCI COMMAND register to see
+ * if the value is all zero. If not, BIOS will think the USB is not disabled
+ * and will try to disable USB. But, actually, USB is disabled by the driver
+ * while entering S3, so it'll hang in BIOS when it try to disable USB.
+ * Since it's going to enter S3, so it does no harm to clear the EHCI
+ * controller's PCI COMMAND register. And the value of the PCI COMMAND
+ * register value will be restored correctly after S3.
+ */
+static void asus_clear_pci_command(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
+		return;
+
+	pci_write_config_word(dev, PCI_COMMAND, 0);
+}
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x7808, asus_clear_memory_bit);
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_ATI, 0x4396, asus_clear_memory_bit);
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 			  struct pci_fixup *end)
 {
-- 
1.7.9.5

