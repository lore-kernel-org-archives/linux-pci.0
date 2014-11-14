Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:62289 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422703AbaKNWTH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 17:19:07 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so538544igb.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2014 14:19:06 -0800 (PST)
Date: Fri, 14 Nov 2014 14:19:03 -0800
From: Dmitry Torokhov <dtor@chromium.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <wsa@the-dreams.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: keystone: fix error handling of irq_of_parse_and_map
Message-ID: <20141114221903.GA38539@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return value of irq_of_parse_and_map() is unsigned int, with 0
indicating failure, so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Not tested, found by casual code inspection.

 drivers/pci/host/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 8a27078..f2bd48d 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -197,7 +197,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	 */
 	for (temp = 0; temp < max_host_irqs; temp++) {
 		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
-		if (host_irqs[temp] < 0)
+		if (!host_irqs[temp])
 			break;
 	}
 	if (temp) {
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
