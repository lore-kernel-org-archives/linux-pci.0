Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC028C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E44621738
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWsVpPyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfBTBVC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:21:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43987 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBTBVB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 20:21:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so37447274ota.10;
        Tue, 19 Feb 2019 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKu71cm1Y17WsZMdlE2Br7miRSMDbxv4AD05UHP7QGA=;
        b=SWsVpPyV2G/om9p5ChNFXDezwdMjPSMfFX/CMteAfiXL0N+dfIzos5M4QgCMrDo3Wy
         saFHTUS1Y6OHE0Z1kaN4wus9TkT306jnZr39x/2LI6w57/mK16OeUk3wiuwEsL9CstRO
         +bbaa0a5CftUc78ezzIBXpKmTTrvWsb5vcbIuHIj24/a966S9NSa/YUzX1ycaF9VbWYR
         d05SqYnNNf4jvHImu+0s9nqEqQqCvcKvdoxQheO3MFpW7Duf+0RZEikN5vkf/RRZUTAj
         Ywj0wWrhQ1KkUxnd0AHxs6/U7UPU37rMUYOFZ/bz2mwMFf0KLpfm15kXx6ioW3t4loPW
         X9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKu71cm1Y17WsZMdlE2Br7miRSMDbxv4AD05UHP7QGA=;
        b=HeYyIA1etVniEic8tTGeSNsbh0xQW3lsllyDKjvJWkcTUwMx0/v1eOqPp11LlFrZ0n
         8A3DvoM6LXFfzU39SYGX6NrG88etk8Hj3ean5hWynqyknf/saN3FXphT1uXjz+BBDtlK
         tKTnnR4HSZ0qhGzK5dffqHUcYE02oYwJm2elX9NMLESd4pYqBIvjTqM9TEP2mQQFydM3
         G6Ze9QHidoFcvXkXQRRya7AftqYDCl/nTY2rQqF5J9KrR/+Bjk13deMqEjqGVzKkf+GS
         uPG5xFHHr6/PM1nIvFsNnUCox1pEWIQngrDg25CC4x+OsurZC2LD0U+dAt/ZWlN1aatj
         +7+A==
X-Gm-Message-State: AHQUAubRZjMMPKNJdoBTjrlKXliMlNZOSz6Nfh7ydHWPR7pwLIc08DHm
        6HdFWu6B37U/ZULTpCSfmsk=
X-Google-Smtp-Source: AHgI3Ib8TYhT4kDvqGiXYkae5uLT9thhu++fxPJ+kkOi6owIkDb0qSu7hJE5pyonacf5RtQRABNbVQ==
X-Received: by 2002:a05:6830:1493:: with SMTP id s19mr20260660otq.117.1550625660833;
        Tue, 19 Feb 2019 17:21:00 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm8000424oig.36.2019.02.19.17.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:21:00 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 3/4] PCI: hotplug: Wait for PDS when in-band presence is disabled
Date:   Tue, 19 Feb 2019 19:20:29 -0600
Message-Id: <20190220012031.10741-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When inband presence is disabled, PDS may come up at any time, or not
at all. PDS being low may indicate that the card is still mating, and
we could expect contact bounce to bring down the link as well.

It is reasonable to assume that most cards will mate in a hotplug slot
in less than a second. Thus, when we know PDS only reflects
out-of-band presence, it's worthwhile to wait the extra second and
make sure the card is properly mated before loading the driver.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f77dc7c38f9a..9bcadb5d3561 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -240,6 +240,25 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	return found;
 }
 
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1000;
+	bool pds;
+	u16 slot_status;
+
+	while (true) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
+		if (pds || timeout <= 0)
+			break;
+		msleep(20);
+		timeout -= 20;
+	}
+
+	if (!pds)
+		pci_info(pdev, "Presence Detect state not set in 1000 msec\n");
+}
+
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -249,6 +268,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (!pcie_wait_for_link(pdev, true))
 		return -1;
 
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.19.2

