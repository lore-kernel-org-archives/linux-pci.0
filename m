Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:49636 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758717Ab3E1DRl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2013 23:17:41 -0400
Received: by mail-qc0-f173.google.com with SMTP id c11so3778271qcv.18
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 20:17:41 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 28 May 2013 11:17:41 +0800
Message-ID: <CAKXJSOEeeOemeFk4EHZmoVB2q1FLd_RO+EoTzyn_qR4fND1OMA@mail.gmail.com>
Subject: [PATCH] PCI: fix a typo in the comment for pci.c/pci_swizzle_interrupt_pin
From: Wang Sheng-Hui <shhuiw@gmail.com>
To: Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The INTx pin should be INIT[ABCD]. Fix the type "3=INTC".

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a899d8b..e5f4e55 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2421,7 +2421,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 /**
  * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
  * @dev: the PCI device
- * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
+ * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
  *
  * Perform INTx swizzling for a device behind one level of bridge.  This is
  * required by section 9.1 of the PCI-to-PCI bridge specification for devices
-- 
1.7.12.4
