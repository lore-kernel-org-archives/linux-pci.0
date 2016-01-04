Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:57667 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbcADRRY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 12:17:24 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 6C5E247E74C
	for <linux-pci@vger.kernel.org>; Mon,  4 Jan 2016 18:12:43 +0100 (CET)
Received: from mfilter15-d.gandi.net (mfilter15-d.gandi.net [217.70.178.143])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id ACEB641C09C
	for <linux-pci@vger.kernel.org>; Mon,  4 Jan 2016 18:12:40 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter15-d.gandi.net (mfilter15-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id mh3BmXSSyJNx for <linux-pci@vger.kernel.org>;
	Mon,  4 Jan 2016 18:12:39 +0100 (CET)
Received: from webmail.eu.com (webmail7-d.mgt.gandi.net [10.58.1.147])
	(Authenticated sender: eocallaghan@alterapraxis.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPA id 0373D41C093
	for <linux-pci@vger.kernel.org>; Mon,  4 Jan 2016 18:12:38 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 05 Jan 2016 04:12:38 +1100
From: eocallaghan@alterapraxis.com
To: linux-pci@vger.kernel.org
Subject: [PATCH] drivers/pci: Avoid iterating through memory outside the
 resource window
Message-ID: <ebd27b01905fd23bf9144800c1767e88@alterapraxis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the 'image' pointer has been advanced more than 'size',
we've already iterated through memory outside the resource window.

We have zero control over whatever we find in the option ROM,
if it's even an option ROM and not just an accident of random
data just happening to look like an option ROM.

Signed-off-by: Edward O'Callaghan <eocallaghan@alterapraxis.com>
---
  drivers/pci/rom.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index eb0ad53..45987ad 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -96,6 +96,9 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void 
__iomem *rom, size_t size)
  		last_image = readb(pds + 21) & 0x80;
  		length = readw(pds + 16);
  		image += length * 512;
+		/* Avoid iterating through memory outside the resource window */
+		if (image > rom + size)
+			break;
  	} while (length && !last_image);

  	/* never return a size larger than the PCI resource window */
-- 
2.5.0

