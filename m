Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5DC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 01:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31FF20857
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 01:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9OWub+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCSBMd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:12:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35778 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCSBMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 21:12:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so11680896oib.2;
        Mon, 18 Mar 2019 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ewgNApBOMFmKFh+iKZs3KgqIE0F4/W418nT0I54kEY=;
        b=h9OWub+BErazz2+pibTai77gQV3cnND/vunX2ONcJleEgvNSpI6QdLNjpEBuPvk+tF
         gXEPRr8QfPUvxKUiK7iLZHJEljsdZFyFqrlert+hPNR76SyZcIMRe3mpNooDAaF4nlP0
         Zz9Rt5phMOnHTPk3c/DPorpWC+WW+scYPPvj1n6PkVzywD/1kxC+kUdWDEMh+lVir2ux
         /xB0AJ8JCyT76+On1+ta0IXNLMTAuz6cJi+g7dUlOMHlSV+3KFV86tUVM1R0euwWW9Ni
         fYV29jRwo8aO6KFLwlWwNhOsZZmNdiKgb2f/oCNJKs2yr1FfaE+iPYMYtNF+u6UFIDOT
         a07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ewgNApBOMFmKFh+iKZs3KgqIE0F4/W418nT0I54kEY=;
        b=Vc1q3Pnxmowym1Py3xCURvPe1WL/FFlBdpF9FFTr5lwKNX0Ld/4YIui2RPGOYRwoXe
         7gGs12A0paBVCT7XrWtd5FI3bpjxEZxFAol14S1UfxfdIaMtFjbvpyVr07OncJKeMI3h
         A+jp2jXSQXgkZTAm0cjMTAX+vnDIDEHoAUsClBlP+lADAAYzC5cJKVUcbMjU5dmkNZ+m
         g8c2zr0W8usxetd8GVeD2CQfy0X5/e3AExIClBLaEacM0NTmZUcSRE47lhekLu3IJYEJ
         Pq/Z17mMWJ30mbvDTE0taENtvmG8xpuXRDXewnc+IyEvjzki0gEBFkQSlKG9eSxNLSU4
         B0kA==
X-Gm-Message-State: APjAAAVqm7jjgdRNO51k5RwCxG38pgQqtREZuTVfo2EbQfZ7Ew/XHLwf
        K9lbMtD+Xd5gU3wmD/TS9cA=
X-Google-Smtp-Source: APXvYqxPv3SQNVha1YP9zXUhrNV6/FKSQhqwOd5Ft8RTwv8hKgl8Kr/RO4RzAGVnQrNimxzbNYLBGQ==
X-Received: by 2002:aca:d513:: with SMTP id m19mr245407oig.73.1552957951926;
        Mon, 18 Mar 2019 18:12:31 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id j18sm1722353otq.68.2019.03.18.18.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 18:12:30 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt handler NULL
Date:   Mon, 18 Mar 2019 20:12:04 -0500
Message-Id: <20190319011214.7847-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A threaded IRQ with a NULL handler does not work with level-triggered
interrupts. request_threaded_irq() will return an error:

  genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
  pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22

For level interrupts we need to silence the interrupt before exiting
the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

OOPS! I'm sorry for the noise. Here's the fix.

I was able to test this on edge-triggered interrupts. None of my
machines have PCIe ports that use level-triggered interrupts. This
might not be too straightforward to test without a hardware yanker,
but if there's a way to force a specific interrupt to be level
triggered, I could do the testing on my end.

 drivers/pci/pcie/bw_notification.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index d2eae3b7cc0f..001d6253ad48 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -44,11 +44,10 @@ static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
 }
 
-static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
+static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
 {
 	struct pcie_device *srv = context;
 	struct pci_dev *port = srv->port;
-	struct pci_dev *dev;
 	u16 link_status, events;
 	int ret;
 
@@ -58,6 +57,17 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
 	if (ret != PCIBIOS_SUCCESSFUL || !events)
 		return IRQ_NONE;
 
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
+{
+	struct pcie_device *srv = context;
+	struct pci_dev *port = srv->port;
+	struct pci_dev *dev;
+	u16 link_status;
+
 	/*
 	 * Print status from downstream devices, not this root port or
 	 * downstream switch port.
@@ -67,8 +77,8 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
 		__pcie_print_link_status(dev, false);
 	up_read(&pci_bus_sem);
 
+	pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
 	pcie_update_link_speed(port->subordinate, link_status);
-	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
 	return IRQ_HANDLED;
 }
 
@@ -80,7 +90,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 	if (!pcie_link_bandwidth_notification_supported(srv->port))
 		return -ENODEV;
 
-	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
+	ret = request_threaded_irq(srv->irq, pcie_bw_notification_irq,
+				   pcie_bw_notification_handler,
 				   IRQF_SHARED, "PCIe BW notif", srv);
 	if (ret)
 		return ret;
-- 
2.19.2

