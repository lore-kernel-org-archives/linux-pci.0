Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:24754 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbaBML65 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 06:58:57 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH] PCI: Update outdated comment for pcibios_bus_report_status
Date: Thu, 13 Feb 2014 19:57:43 +0800
Message-ID: <1392292663-61468-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_find_device() has been superseded by pci_get_device().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/kernel/bios32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88..588ec19 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -19,7 +19,7 @@
 static int debug_pci;
 
 /*
- * We can't use pci_find_device() here since we are
+ * We can't use pci_get_device() here since we are
  * called from interrupt context.
  */
 static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, int warn)
-- 
1.7.1


