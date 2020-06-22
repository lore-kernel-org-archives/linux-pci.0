Return-Path: <SRS0=6QlD=AD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A554C433E0
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325E820720
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 14:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFVO0N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgFVO0N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADB3FC1B7;
        Mon, 22 Jun 2020 14:26:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 9/9] Revert "PCI: brcmstb: Wait for Raspberry Pi's firmware when present"
Date:   Mon, 22 Jun 2020 12:38:18 +0200
Message-Id: <20200622103817.476-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622103817.476-1-nsaenzjulienne@suse.de>
References: <20200622103817.476-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 44331189f9082c7e659697bbac1747db3def73e7.

Now that the VL805 init routine is run through a reset controller driver
the device dependencies are being taken care of by the device core. No
need to do it manually here.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7730ea845ff2..752f5b331579 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -28,8 +28,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-#include <soc/bcm2835/raspberrypi-firmware.h>
-
 #include "../pci.h"
 
 /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
@@ -931,26 +929,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
 	struct pci_host_bridge *bridge;
-	struct device_node *fw_np;
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
 	int ret;
 
-	/*
-	 * We have to wait for Raspberry Pi's firmware interface to be up as a
-	 * PCI fixup, rpi_firmware_init_vl805(), depends on it. This driver's
-	 * probe can race with the firmware interface's (see
-	 * drivers/firmware/raspberrypi.c) and potentially break the PCI fixup.
-	 */
-	fw_np = of_find_compatible_node(NULL, NULL,
-					"raspberrypi,bcm2835-firmware");
-	if (fw_np && !rpi_firmware_get(fw_np)) {
-		of_node_put(fw_np);
-		return -EPROBE_DEFER;
-	}
-	of_node_put(fw_np);
-
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.27.0

