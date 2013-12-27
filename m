Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22841 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3L0AdT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2013 19:33:19 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MYF007S1W7DT470@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 27 Dec 2013 09:33:13 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: PATCH] PCI: mvebu: Use max_t() instead of max(resource_size_t,)
Date: Fri, 27 Dec 2013 09:33:12 +0900
Message-id: <000501cf029b$39aa4400$acfecc00$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use max_t() instead of max(resource_size_t,) in order to fix
the following checkpatch warning.

  WARNING: max() should probably be max_t(resource_size_t, SZ_64K, size)
  WARNING: max() should probably be max_t(resource_size_t, SZ_1M, size)

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-mvebu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index bedc0b1..fa140e1 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -735,9 +735,9 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 	 * aligned on their size
 	 */
 	if (res->flags & IORESOURCE_IO)
-		return round_up(start, max((resource_size_t)SZ_64K, size));
+		return round_up(start, max_t(resource_size_t, SZ_64K, size));
 	else if (res->flags & IORESOURCE_MEM)
-		return round_up(start, max((resource_size_t)SZ_1M, size));
+		return round_up(start, max_t(resource_size_t, SZ_1M, size));
 	else
 		return start;
 }
-- 
1.7.10.4


