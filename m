Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:48015 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161930AbaKNWV4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 17:21:56 -0500
Received: by mail-ig0-f173.google.com with SMTP id r10so505573igi.12
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2014 14:21:55 -0800 (PST)
Date: Fri, 14 Nov 2014 14:21:53 -0800
From: Dmitry Torokhov <dtor@chromium.org>
To: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rcar: fix error handling of irq_of_parse_and_map
Message-ID: <20141114222153.GA39494@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return value of irq_of_parse_and_map() is unsigned int, with 0
indicating failure, so testing for negative result never works.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

Not tested, found by casual code inspection.

 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 9b356c3..6ca976f 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -764,7 +764,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 		goto err_map_reg;
 
 	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (i < 0) {
+	if (!i) {
 		dev_err(pcie->dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
@@ -772,7 +772,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	pcie->msi.irq1 = i;
 
 	i = irq_of_parse_and_map(pdev->dev.of_node, 1);
-	if (i < 0) {
+	if (!i) {
 		dev_err(pcie->dev, "cannot get platform resources for msi interrupt\n");
 		err = -ENOENT;
 		goto err_map_reg;
-- 
2.1.0.rc2.206.gedb03e5


-- 
Dmitry
