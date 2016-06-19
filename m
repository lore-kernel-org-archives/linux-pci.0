Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39147 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbcFSGw1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2016 02:52:27 -0400
Date: Sat, 18 Jun 2016 23:52:25 -0700 (PDT)
Message-Id: <20160618.235225.1591502152749272620.davem@davemloft.net>
To: bhelgaas@google.com
CC: linux-pci@vger.kernel.org
Subject: [PATCH] pci: Fix unaligned accesses in VC code.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


The save/restore buffers for VC state is first composed of a 2-byte
control register, then a bunch of 4-byte words.

This causes unaligned accesses which trap on platform such as sparc.

This is easy to fix by simply moving the buffer pointer forward by 4
bytes instead of 2 after dealing with the control register.  The
length adjustment needs to be changed likewise as well.

Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index dfbab61..1fa3a32 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -221,9 +221,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 		else
 			pci_write_config_word(dev, pos + PCI_VC_PORT_CTRL,
 					      *(u16 *)buf);
-		buf += 2;
+		buf += 4;
 	}
-	len += 2;
+	len += 4;
 
 	/*
 	 * If we have any Low Priority VCs and a VC Arbitration Table Offset
