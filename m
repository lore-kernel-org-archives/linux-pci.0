Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33529 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757617AbaFSIa4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 04:30:56 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/5] PCI/MSI: Remove the unused function msi_enabled_mask()
Date: Thu, 19 Jun 2014 16:30:09 +0800
Message-ID: <1403166609-5800-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No one uses msi_enabled_mask(), remove the dead code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7c9fb3a..dd34dbe 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -173,11 +173,6 @@ static inline __attribute_const__ u32 msi_capable_mask(u16 control)
 	return msi_mask((control >> 1) & 7);
 }
 
-static inline __attribute_const__ u32 msi_enabled_mask(u16 control)
-{
-	return msi_mask((control >> 4) & 7);
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
-- 
1.7.1


