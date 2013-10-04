Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11394 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126Ab3JDXb3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 19:31:29 -0400
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <james.hogan@imgtec.com>, <Qais.Yousef@imgtec.com>,
	Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 3/4] PCI/quirks: Extract the size detection logic of PIIX4 ACPI io and mem
Date: Fri, 4 Oct 2013 16:30:52 -0700
Message-ID: <1380929453-15428-4-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Put the same algorithm in piix4_acpi_[io|mem]_quirk into a dedicated
function for size detection.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/pci/quirks.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2b66c3..06762a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -380,6 +380,20 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
+static inline u32 piix4_acpi_quirk_size(u32 max, u32 mask)
+{
+	u32 size = max;
+
+	for (;;) {
+		unsigned bit = size >> 1;
+		if ((bit & mask) == bit)
+			break;
+		size = bit;
+	}
+
+	return size;
+}
+
 static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
 				unsigned int port, unsigned int enable)
 {
@@ -391,13 +405,7 @@ static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
 		return;
 	mask = (devres >> 16) & 15;
 	base = devres & 0xffff;
-	size = 16;
-	for (;;) {
-		unsigned bit = size >> 1;
-		if ((bit & mask) == bit)
-			break;
-		size = bit;
-	}
+	size = piix4_acpi_quirk_size(16, mask);
 	/*
 	 * For now we only print it out. Eventually we'll want to
 	 * reserve it (at least if it's in the 0x1000+ range), but
@@ -418,13 +426,7 @@ static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
 		return;
 	base = devres & 0xffff8000;
 	mask = (devres & 0x7f) << 15;
-	size = 128 << 15;
-	for (;;) {
-		unsigned bit = size >> 1;
-		if ((bit & mask) == bit)
-			break;
-		size = bit;
-	}
+	size = piix4_acpi_quirk_size(128 << 15, mask);
 	/*
 	 * For now we only print it out. Eventually we'll want to
 	 * reserve it, but let's get enough confirmation reports first. 
-- 
1.7.1


