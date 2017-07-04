Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:43877 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdGDCQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2017 22:16:54 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI; trivial fix for the comment of pci_vpd_srdt_{size, tag}
Date: Tue,  4 Jul 2017 10:16:35 +0800
Message-Id: <1499134595-46917-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The comment doesn't match the argument, so fix them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index bd68ed1..a360315 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2066,7 +2066,7 @@ static inline u16 pci_vpd_lrdt_tag(const u8 *lrdt)
 
 /**
  * pci_vpd_srdt_size - Extracts the Small Resource Data Type length
- * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
+ * @srdt: Pointer to the beginning of the Small Resource Data Type tag
  *
  * Returns the extracted Small Resource Data Type length.
  */
@@ -2077,7 +2077,7 @@ static inline u8 pci_vpd_srdt_size(const u8 *srdt)
 
 /**
  * pci_vpd_srdt_tag - Extracts the Small Resource Data Type Tag Item
- * @lrdt: Pointer to the beginning of the Small Resource Data Type tag
+ * @srdt: Pointer to the beginning of the Small Resource Data Type tag
  *
  * Returns the extracted Small Resource Data Type Tag Item.
  */
-- 
1.9.1
