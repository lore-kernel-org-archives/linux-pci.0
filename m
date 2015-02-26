Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33026 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbBZIz1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 03:55:27 -0500
Received: by labgf13 with SMTP id gf13so9542624lab.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 00:55:25 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: Avoid info leak in __print_tlp_header
Date: Thu, 26 Feb 2015 09:55:03 +0100
Message-Id: <1424940903-9147-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <20150225225859.GB19236@pd.tnic>
References: <20150225225859.GB19236@pd.tnic>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit fab4c256a58b ("PCI/AER: Add a TLP header print helper")
introduced the helper function __print_tlp_header, but contrary to the
intention, the behaviour did change: Since we're taking the address of
the parameter t, the first 4 or 8 bytes printed will be the value of
the pointer t itself, and the remaining 12 or 8 bytes will be
who-knows-what (something from the stack).

We want to show the values of the four members of the struct
aer_header_log_regs; that can be done without ugly and error-prone
casts. On little-endian this should produce the same output as
originally intended, and since no-one has complained about getting
garbage output so far, I think big-endian should be ok too.

Fixes: fab4c256a58b ("PCI/AER: Add a TLP header print helper")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: Just print ->dwX as-is.

 drivers/pci/pcie/aer/aerdrv_errprint.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index c6849d9e86ce..167fe411ce2e 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -132,16 +132,8 @@ static const char *aer_agent_string[] = {
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
+		t->dw0, t->dw1, t->dw2, t->dw3);
 }
 
 static void __aer_print_error(struct pci_dev *dev,
-- 
2.1.3

