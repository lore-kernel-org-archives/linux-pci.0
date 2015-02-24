Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:45209 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbBXWvG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 17:51:06 -0500
Received: by lbjb6 with SMTP id b6so62459lbj.12
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 14:51:04 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Borislav Petkov <bp@suse.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Avoid info leak in __print_tlp_header
Date: Tue, 24 Feb 2015 23:50:46 +0100
Message-Id: <1424818246-11841-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit fab4c256a58b ("PCI/AER: Add a TLP header print helper")
introduced the helper function __print_tlp_header, but contrary to the
intention, the behaviour did change: Since we're taking the address of
the parameter t, the first 4 or 8 bytes printed will be the value of
the pointer t itself, and the remaining 12 or 8 bytes will be
who-knows-what (something from the stack).

We want to treat the four members of the struct aer_header_log_regs as
little-endian 32 bit numbers and print those. That can be done without
ugly and confusing casts.

Fixes: fab4c256a58b ("PCI/AER: Add a TLP header print helper")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index c6849d9e86ce..e328978038c1 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -132,16 +132,9 @@ static const char *aer_agent_string[] = {
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
-	unsigned char *tlp = (unsigned char *)&t;
-
-	dev_err(&dev->dev, "  TLP Header:"
-		" %02x%02x%02x%02x %02x%02x%02x%02x"
-		" %02x%02x%02x%02x %02x%02x%02x%02x\n",
-		*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
-		*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
-		*(tlp + 11), *(tlp + 10), *(tlp + 9),
-		*(tlp + 8), *(tlp + 15), *(tlp + 14),
-		*(tlp + 13), *(tlp + 12));
+	dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
+		le32_to_cpu(t->dw0), le32_to_cpu(t->dw1),
+		le32_to_cpu(t->dw2), le32_to_cpu(t->dw3));
 }
 
 static void __aer_print_error(struct pci_dev *dev,
-- 
2.1.3

