Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34409 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbcE3M0r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 08:26:47 -0400
Received: by mail-io0-f196.google.com with SMTP id l9so40095ioe.1
        for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 05:26:47 -0700 (PDT)
From: Chris Blake <chrisrblake93@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Chris Blake <chrisrblake93@gmail.com>
Subject: [PATCH 1/2] Add Quirk for Atheros AR9485 No Bus Reset
Date: Mon, 30 May 2016 07:26:37 -0500
Message-Id: <1464611198-11494-2-git-send-email-chrisrblake93@gmail.com>
In-Reply-To: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
References: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Similar to the AR93xx series, the AR94xx also has the same quirk for the
Bus Reset. Adding this will resolve the issue, and help in cases where
PCI Passthrough is used.

Signed-off-by: Chris Blake <chrisrblake93@gmail.com>
---
 drivers/pci/quirks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..35c824d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3189,13 +3189,14 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 }

 /*
- * Atheros AR93xx chips do not behave after a bus reset.  The device will
- * throw a Link Down error on AER-capable systems and regardless of AER,
- * config space of the device is never accessible again and typically
- * causes the system to hang or reset when access is attempted.
+ * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
+ * The device will throw a Link Down error on AER-capable systems and
+ * regardless of AER, config space of the device is never accessible again
+ * and typically causes the system to hang or reset when access is attempted.
  * http://www.spinics.net/lists/linux-pci/msg34797.html
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);

 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
--
1.9.1
