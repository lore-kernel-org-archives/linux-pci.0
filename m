Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35304 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbcDIVu6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2016 17:50:58 -0400
Received: by mail-lf0-f53.google.com with SMTP id c126so114787662lfb.2
        for <linux-pci@vger.kernel.org>; Sat, 09 Apr 2016 14:50:57 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
Cc: linux-pci@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] PCI: iproc: Enable hooking abort handler on devices with bcma
Date: Sat,  9 Apr 2016 23:50:24 +0200
Message-Id: <1460238624-2086-2-git-send-email-zajec5@gmail.com>
In-Reply-To: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This seems to be mostly needed by devices with more than 2 devices, e.g.
Netgear R8000 which is known to suffer from this issue.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/pci/host/pcie-iproc-bcma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 0d7bee4..f9ee077 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -56,6 +56,7 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 	pcie->base = bdev->io_addr;
 	pcie->base_addr = bdev->addr;
+	pcie->hook_abort_handler = true;
 
 	res_mem.start = bdev->addr_s[0];
 	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
-- 
1.8.4.5

