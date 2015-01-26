Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:48758 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200AbbAZRGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 12:06:11 -0500
Received: by mail-we0-f173.google.com with SMTP id w62so10270468wes.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2015 09:06:10 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/5] rapidio/tsi721: use PCI define for max read request size
Date: Mon, 26 Jan 2015 18:06:02 +0100
Message-Id: <1422291962-12374-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
References: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/rapidio/devices/tsi721.c | 2 +-
 drivers/rapidio/devices/tsi721.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 8bcfecd..eeca70d 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2430,7 +2430,7 @@ static int tsi721_probe(struct pci_dev *pdev,
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL,
 		PCI_EXP_DEVCTL_READRQ | PCI_EXP_DEVCTL_RELAX_EN |
 		PCI_EXP_DEVCTL_NOSNOOP_EN,
-		0x2 << MAX_READ_REQUEST_SZ_SHIFT);
+		PCI_EXP_DEVCTL_READRQ_512B);
 
 	/* Adjust PCIe completion timeout. */
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_DEVCTL2, 0xf, 0x2);
diff --git a/drivers/rapidio/devices/tsi721.h b/drivers/rapidio/devices/tsi721.h
index a7b4268..9d25025 100644
--- a/drivers/rapidio/devices/tsi721.h
+++ b/drivers/rapidio/devices/tsi721.h
@@ -72,8 +72,6 @@
 #define TSI721_MSIXPBA_OFFSET	0x2a000
 #define TSI721_PCIECFG_EPCTL	0x400
 
-#define MAX_READ_REQUEST_SZ_SHIFT	12
-
 /*
  * Event Management Registers
  */
-- 
1.8.4.5

