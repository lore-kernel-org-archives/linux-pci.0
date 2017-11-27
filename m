Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbdK0Q76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 11:59:58 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Maik Broemme <mbroemme@libmpq.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:INTEL FRAMEBUFFER DRIVER
        (excluding 810 and 815)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 25/29] video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:58:02 -0500
Message-Id: <1511801886-6753-26-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Find the domain number from pdev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/intelfb/intelfbhw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index d31ed4e..f695867 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -181,7 +181,9 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
 		return 1;
 
 	/* Find the bridge device.  It is always 0:0.0 */
-	if (!(bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0)))) {
+	bridge_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus), 0,
+						 PCI_DEVFN(0, 0));
+	if (!bridge_dev) {
 		ERR_MSG("cannot find bridge device\n");
 		return 1;
 	}
-- 
1.9.1
