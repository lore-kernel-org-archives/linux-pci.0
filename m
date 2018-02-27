Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:58809 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeB0L7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 06:59:17 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Tue, 27 Feb 2018 12:59:06 +0100
Message-Id: <20180227115908.14593-3-niklas.cassel@axis.com>
In-Reply-To: <20180227115908.14593-1-niklas.cassel@axis.com>
References: <20180227115908.14593-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A 64-bit BAR uses the succeeding BAR for the upper bits,
so we cannot simply call pci_ioremap_bar() on every single BAR.

BARs succeding a 64-bit BAR will not have the IORESOURCE_MEM resource
flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
resource flag set.

pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR1
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR3
pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
pci-endpoint-test 0000:01:00.0: failed to read BAR5

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Changes since v2:
Check (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
rather than (pci_resource_len(pdev, bar) == 0), thanks Bjorn.

 drivers/misc/pci_endpoint_test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 320276f42653..fe8897e64635 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -534,12 +534,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
-		base = pci_ioremap_bar(pdev, bar);
-		if (!base) {
-			dev_err(dev, "failed to read BAR%d\n", bar);
-			WARN_ON(bar == test_reg_bar);
+		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
+			base = pci_ioremap_bar(pdev, bar);
+			if (!base) {
+				dev_err(dev, "failed to read BAR%d\n", bar);
+				WARN_ON(bar == test_reg_bar);
+			}
+			test->bar[bar] = base;
 		}
-		test->bar[bar] = base;
 	}
 
 	test->base = test->bar[test_reg_bar];
-- 
2.14.2
