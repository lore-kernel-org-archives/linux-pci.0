Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeG2Xfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2018 19:35:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so10678926wrt.2
        for <linux-pci@vger.kernel.org>; Sun, 29 Jul 2018 15:03:49 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
Date: Mon, 30 Jul 2018 00:03:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we have a threaded interrupt with the handler being NULL, then
request_threaded_irq() -> __setup_irq() will complain and bail out
if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
being NULL and set IRQF_ONESHOT in this case.

This change is needed to migrate the mei_me driver to
pci_alloc_irq_vectors() and pci_request_irq().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 2a808e10..a1de501a 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
 	va_list ap;
 	int ret;
 	char *devname;
+	unsigned long irqflags = IRQF_SHARED;
+
+	if (!handler)
+		irqflags |= IRQF_ONESHOT;
 
 	va_start(ap, fmt);
 	devname = kvasprintf(GFP_KERNEL, fmt, ap);
 	va_end(ap);
 
 	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
-			IRQF_SHARED, devname, dev_id);
+				   irqflags, devname, dev_id);
 	if (ret)
 		kfree(devname);
 	return ret;
-- 
2.18.0
