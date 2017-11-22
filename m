Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbdKVFcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:32:54 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:14 -0500
Message-Id: <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/linux/i7300_idle.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
index 4dbe651..58cd9c6 100644
--- a/include/linux/i7300_idle.h
+++ b/include/linux/i7300_idle.h
@@ -48,7 +48,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
 	int i;
 	struct pci_dev *memdev, *dmadev;
 
-	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
+	memdev = pci_get_domain_bus_and_slot(0, MEMCTL_BUS, MEMCTL_DEVFN);
 	if (!memdev)
 		return -ENODEV;
 
@@ -61,7 +61,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
 	if (pci_tbl[i].vendor == 0)
 		return -ENODEV;
 
-	dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
+	dmadev = pci_get_domain_bus_and_slot(0, IOAT_BUS, IOAT_DEVFN);
 	if (!dmadev)
 		return -ENODEV;
 
-- 
1.9.1
