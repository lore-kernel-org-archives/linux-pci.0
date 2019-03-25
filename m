Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134C220989
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ut548Gb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfCYSXj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:23:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbfCYSXj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 14:23:39 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A8BB1EC06CA;
        Mon, 25 Mar 2019 19:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553538217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mGnzmZBEESQ1n8UULhPO3Hg8PnuEI4I6+ggV7or40e4=;
        b=Ut548Gb1PUur/F2DkFg+yZDruBY+bhzWeZzXhCyuNUU5BvWsH3z3++DsbouaA6P1nrqvBr
        f/c0ZHWyawNw6Q6ec4rynmXWvGH5JbeXWGf4+KVSO//X0y+h4og/XaX2rlhEAnc6TIyZ8I
        0YNjNzT0BbYUHRkfW757NahSWYBai08=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/LINK: Request a one-shot IRQ with NULL handler
Date:   Mon, 25 Mar 2019 19:23:38 +0100
Message-Id: <20190325182338.13609-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Booting v5.1-rc1 causes these new messages in dmesg here:

  genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 24
  pcie_bw_notification: probe of 0000:00:02.0:pcie010 failed with error -22

because requesting a threaded IRQ with NULL handler needs to be oneshot.
Otherwise a level-triggered interrupt endless loop can happen, see the
detailed explanation above the "Threaded irq... " error message in
kernel/irq/manage.c.

And PCI-MSI type interrupts are one-shot safe but not in the IOAPIC
case:

  24: ... IO-APIC   28-fasteoi   PCIe BW notif, PCIe BW notif, PCIe BW notif
  25: ... IO-APIC   29-fasteoi   PCIe BW notif, PCIe BW notif

Make the BW notification handler oneshot too.

Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/bw_notification.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index d2eae3b7cc0f..16e11c09f6bd 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -81,7 +81,7 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 		return -ENODEV;
 
 	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
-				   IRQF_SHARED, "PCIe BW notif", srv);
+				   IRQF_SHARED | IRQF_ONESHOT, "PCIe BW notif", srv);
 	if (ret)
 		return ret;
 
-- 
2.21.0

