Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:63451 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490AbbAZRGT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 12:06:19 -0500
Received: by mail-wi0-f176.google.com with SMTP id em10so11479559wid.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2015 09:06:18 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@ezchip.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 3/5] tile: use PCI define for max read request size
Date: Mon, 26 Jan 2015 18:06:12 +0100
Message-Id: <1422291972-12412-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
References: <1422291922-12324-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/tile/kernel/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
index f70c789..325df47 100644
--- a/arch/tile/kernel/pci.c
+++ b/arch/tile/kernel/pci.c
@@ -245,7 +245,7 @@ static void fixup_read_and_payload_sizes(void)
 {
 	struct pci_dev *dev = NULL;
 	int smallest_max_payload = 0x1; /* Tile maxes out at 256 bytes. */
-	int max_read_size = 0x2; /* Limit to 512 byte reads. */
+	int max_read_size = PCI_EXP_DEVCTL_READRQ_512B;
 	u16 new_values;
 
 	/* Scan for the smallest maximum payload size. */
@@ -258,7 +258,7 @@ static void fixup_read_and_payload_sizes(void)
 	}
 
 	/* Now, set the max_payload_size for all devices to that value. */
-	new_values = (max_read_size << 12) | (smallest_max_payload << 5);
+	new_values = max_read_size | (smallest_max_payload << 5);
 	for_each_pci_dev(dev)
 		pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 				PCI_EXP_DEVCTL_PAYLOAD | PCI_EXP_DEVCTL_READRQ,
-- 
1.8.4.5

