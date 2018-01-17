Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:32378 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbeAQSbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 13:31:42 -0500
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-pci@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Subject: [PATCH] pci: Do not read INTx PIN and LINE registers for virtual functions
Date: Wed, 17 Jan 2018 19:30:29 +0100
Message-Id: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... since INTx is not supported by-spec for virtual functions.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 drivers/pci/probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 65099d0..61002fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1232,6 +1232,13 @@ static void pci_read_irq(struct pci_dev *dev)
 {
 	unsigned char irq;
 
+	/* Virtual functions do not have INTx support */
+	if (dev->is_virtfn) {
+		dev->pin = 0;
+		dev->irq = 0;
+		return;
+	}
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
 	dev->pin = irq;
 	if (irq)
-- 
2.7.4
