Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34411 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbcE3M0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 08:26:48 -0400
Received: by mail-io0-f196.google.com with SMTP id l9so40111ioe.1
        for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 05:26:48 -0700 (PDT)
From: Chris Blake <chrisrblake93@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Chris Blake <chrisrblake93@gmail.com>
Subject: [PATCH 2/2] Add Quirk for Qualcom Atheros QCA9882 No Bus Reset
Date: Mon, 30 May 2016 07:26:38 -0500
Message-Id: <1464611198-11494-3-git-send-email-chrisrblake93@gmail.com>
In-Reply-To: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
References: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Similar to the AR93xx series, the Qualcom QCA988x also has the same
quirk for the Bus Reset. Adding this will resolve the issue, and help in
cases where PCI Passthrough is used.

Signed-off-by: Chris Blake <chrisrblake93@gmail.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 35c824d..7902fbf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3197,6 +3197,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);

 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
--
1.9.1
