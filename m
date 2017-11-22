Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbdKVFco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:32:44 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Maik Broemme <mbroemme@libmpq.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:INTEL FRAMEBUFFER DRIVER
        (excluding 810 and 815)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 26/30] video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:11 -0500
Message-Id: <1511328675-21981-27-git-send-email-okaya@codeaurora.org>
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
 drivers/video/fbdev/intelfb/intelfbhw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index d31ed4e..496c045 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -175,13 +175,15 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
 {
 	struct pci_dev *bridge_dev;
 	u16 tmp;
+	u16 devfn;
 	int stolen_overhead;
 
 	if (!pdev || !aperture_size || !stolen_size)
 		return 1;
 
+	devfn = PCI_DEVFN(0, 0);
 	/* Find the bridge device.  It is always 0:0.0 */
-	if (!(bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0)))) {
+	if (!(bridge_dev = pci_get_domain_bus_and_slot(0, 0, devfn))) {
 		ERR_MSG("cannot find bridge device\n");
 		return 1;
 	}
-- 
1.9.1
