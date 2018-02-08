Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:49076 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeBHMd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 07:33:56 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs properly
Date: Thu,  8 Feb 2018 13:33:45 +0100
Message-Id: <20180208123346.20784-3-niklas.cassel@axis.com>
In-Reply-To: <20180208123346.20784-1-niklas.cassel@axis.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A 64-bit BAR uses the succeeding BAR for the upper bits,
so we cannot simply call pci_ioremap_bar() on every single BAR.

Ignore BARs that does not have a valid resource length.

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
Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
but is it the correct function to use here?
If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
when BAR[x] is 64-bit).

 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 320276f42653..3af31bfdcfdd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (pci_resource_len(pdev, bar) == 0)
+			continue;
 		base = pci_ioremap_bar(pdev, bar);
 		if (!base) {
 			dev_err(dev, "failed to read BAR%d\n", bar);
-- 
2.14.2
