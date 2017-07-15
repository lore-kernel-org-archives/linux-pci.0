Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35238 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdGOVoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2017 17:44:11 -0400
Received: by mail-lf0-f45.google.com with SMTP id w198so1475847lff.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Jul 2017 14:44:10 -0700 (PDT)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-Id: <20170715214406.657273405@cogentembedded.com>
Date: Sun, 16 Jul 2017 00:43:10 +0300
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] pci: ftpci100: fix of_irq_get() error check
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_irq_get() may return a negative error number as well as 0 on failure,
while the driver only checks for 0, blithely continuing with the call to
irq_set_chained_handler_and_data() -- that function expects *unsigned int*
so should probably do nothing when a large IRQ number resulting from a
conversion of a negative error number is passed to it. The driver then
probes successfully while being only partly functional...

Check for 'irq <= 0' instead and propagate the negative error number to
the probe method --  that will allow the deferred probing as well...

Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/pci/host/pci-ftpci100.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: pci/drivers/pci/host/pci-ftpci100.c
===================================================================
--- pci.orig/drivers/pci/host/pci-ftpci100.c
+++ pci/drivers/pci/host/pci-ftpci100.c
@@ -350,9 +350,9 @@ static int faraday_pci_setup_cascaded_ir
 
 	/* All PCI IRQs cascade off this one */
 	irq = of_irq_get(intc, 0);
-	if (!irq) {
+	if (irq <= 0) {
 		dev_err(p->dev, "failed to get parent IRQ\n");
-		return -EINVAL;
+		return irq ?: -EINVAL;
 	}
 
 	p->irqdomain = irq_domain_add_linear(intc, 4,
