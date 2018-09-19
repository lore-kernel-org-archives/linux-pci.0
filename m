Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40362 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeISULZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:25 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/12] MIPS: BMIPS: enable PCI
Date: Wed, 19 Sep 2018 10:32:04 -0400
Message-Id: <1537367527-20773-10-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the Kconfig hooks to enable the Broadcom STB PCIe root complex
driver for Broadcom MIPS systems.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..a15c0da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -220,6 +220,9 @@ config BMIPS_GENERIC
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
+	select HW_HAS_PCI
+	select PCI_DRIVERS_GENERIC
+	select PCI
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYNC_R4K
-- 
1.9.0.138.g2de3478
