Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1831C43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 00:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79142192C
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 00:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlvS4Wjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCWAhR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:37:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40462 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCWAhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 20:37:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id 3so3068682oir.7;
        Fri, 22 Mar 2019 17:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvQj0vsvYv72yAE8YRembqlumXrTGOSTi8Eky6kwc24=;
        b=qlvS4WjoyGmFNYsaYlyG5aLMzu+InSqSMFo0ItRT329JuXGg6+Vv6N4em11FHlsQLi
         mB36w46yuy96UCLUzH1oYtAQdtG3QoPU3XvrHBwDNG97nwmkKJTNvinjfBeUpiydH7cS
         qWQ/FkP+QA9IPjGfZqtnEQwlTfOIhpuTG8QvIxKpfIxD/exathRa0+oo5k6Jvf59+tSX
         K7g4fYDH2ztu0yfHbclxXbk6YEWIC8u7Sp0T07CrAoEbqqHC0HhOtOxGECLImZrlyj8r
         ERKofMptfeXaTAq/wH7f3oW/jFvJB22usE4wVG/LYAj9z670RWhcwxa1WiIEePHj7L9e
         MUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvQj0vsvYv72yAE8YRembqlumXrTGOSTi8Eky6kwc24=;
        b=IqLWPOHeiFv8+5/VfoeCdga2D9j0YqN++TUW7AHJQyagv/gAlnQeTGOeN1uioxZfla
         JsiYcLDeRNRj/NQ+QUIgQKxFtQw54rjWF2WhEboZZ/q75ss2h6ftENJGJcdWI4wOh5qR
         HcoLZU09IzcJQDetK/4JeAm3XtxmkBgIoKsnoBJmgDm/7VSx+dv16TGUQXv4dZ1UA3md
         5+8ltEYWRyY2UL7V/yyfAtAYEnMQJs1qjpmbPJR9x5sL9Y+u4ro9uc7iZ2/ZK3Ylz83c
         Kpf0KhvOL2mWXOTayMiBwYjqBDRSHsGEPLgVoPuUBDTO0VcYKL6/tpWn0JWB37RNldj8
         c67Q==
X-Gm-Message-State: APjAAAV82OcVQBGw7SlVFCFgdFYx9AzWRXn7GDrSqqNH6nUGe5WfnLVK
        4JYDztr/4AoGeoveuVsT8nE=
X-Google-Smtp-Source: APXvYqxW1P3nqNgjaLMK+9OyLfnCMrtjLLwMtAOrkILgK5U7kg3rmAJJlbIxkHymSVF5k1A1ZXAOSg==
X-Received: by 2002:aca:35c5:: with SMTP id c188mr104220oia.18.1553301435777;
        Fri, 22 Mar 2019 17:37:15 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 96sm472584otf.17.2019.03.22.17.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:37:15 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/LINK: bw_notification: Do not leave interrupt handler NULL
Date:   Fri, 22 Mar 2019 19:36:51 -0500
Message-Id: <20190323003700.7294-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190320193504.GC251185@google.com>
References: <20190320193504.GC251185@google.com>
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

Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
 - move pcie_update_link_speed() to irq to prevent duplicate read of link_status
 - Add Fixes: to commit message
 
 drivers/pci/pcie/bw_notification.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index d2eae3b7cc0f..c48746f1cf3c 100644
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
+	pcie_update_link_speed(port->subordinate, link_status);
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
+{
+	struct pcie_device *srv = context;
+	struct pci_dev *port = srv->port;
+	struct pci_dev *dev;
+
 	/*
 	 * Print status from downstream devices, not this root port or
 	 * downstream switch port.
@@ -67,8 +77,6 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
 		__pcie_print_link_status(dev, false);
 	up_read(&pci_bus_sem);
 
-	pcie_update_link_speed(port->subordinate, link_status);
-	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
 	return IRQ_HANDLED;
 }
 
@@ -80,7 +88,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
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

