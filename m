Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:31356 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162030Ab2CSFtz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2012 01:49:55 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 17/26] PCI: Use for_each_res pci bases reading
Date: Sun, 18 Mar 2012 22:48:40 -0700
Message-Id: <1332136129-14010-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
References: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace those open code, and make code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7d5550a..dfa56fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -277,9 +277,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg;
+	struct resource *res;
 
-	for (pos = 0; pos < howmany; pos++) {
-		struct resource *res = &dev->resource[pos];
+	for_each_pci_dev_std_resource(dev, res, pos) {
+		if (pos >= howmany)
+			break;
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
 	}
-- 
1.7.7

