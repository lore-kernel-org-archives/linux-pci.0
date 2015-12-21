Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37987 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbbLUNNO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2015 08:13:14 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] PCI: msi: fix typos in <linux/msi.h>
Date: Mon, 21 Dec 2015 14:13:08 +0100
Message-Id: <1450703588-12295-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit fixes two typos in the <linux/msi.h> header.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/msi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index f71a25e..8974b21 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -186,7 +186,7 @@ struct msi_domain_info;
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
- * @msi_finish:		Optional callbacl to finalize the allocation
+ * @msi_finish:		Optional callback to finalize the allocation
  * @set_desc:		Set the msi descriptor for an interrupt
  * @handle_error:	Optional error handler if the allocation fails
  *
@@ -194,7 +194,7 @@ struct msi_domain_info;
  * msi_create_irq_domain() and related interfaces
  *
  * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
- * are callbacks used by msi_irq_domain_alloc_irqs() and related
+ * are callbacks used by msi_domain_alloc_irqs() and related
  * interfaces which are based on msi_desc.
  */
 struct msi_domain_ops {
-- 
2.6.4

