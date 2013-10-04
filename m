Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11391 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab3JDXb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 19:31:28 -0400
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <james.hogan@imgtec.com>, <Qais.Yousef@imgtec.com>,
	Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
Date: Fri, 4 Oct 2013 16:30:50 -0700
Message-ID: <1380929453-15428-2-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

According to Intel PIIX4 datasheet: The memory address consists of a 17-bit
base address (AD[31:15]) and a 7-bit mask (AD[21:15]). This provides memory
ranges from 32 Kbytes to 4 Mbytes in size.

This is true for both devices 12 and 13. This patch fixes it.

Ref 1: www.intel.com/assets/pdf/datasheet/290562.pdf
       April 1997 version 001 (p131 bottom, p226 top)
Ref 2: www.intel.com/assets/pdf/specupdate/297738.pdf
       January 2002 version 017 (Nothing against the fix in the
       specification update was found.)

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/pci/quirks.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f6c31fa..3e7e489 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -414,9 +414,9 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
 	pci_read_config_dword(dev, port, &devres);
 	if ((devres & enable) != enable)
 		return;
-	base = devres & 0xffff0000;
-	mask = (devres & 0x3f) << 16;
-	size = 128 << 16;
+	base = devres & 0xffff8000;
+	mask = (devres & 0x7f) << 15;
+	size = 128 << 15;
 	for (;;) {
 		unsigned bit = size >> 1;
 		if ((bit & mask) == bit)
-- 
1.7.1


