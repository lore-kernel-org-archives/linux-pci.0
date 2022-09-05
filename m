Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33250C6FA8D
	for <linux-pci@archiver.kernel.org>; Mon,  5 Sep 2022 19:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiIETZU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Sep 2022 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIETZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376981D31A;
        Mon,  5 Sep 2022 12:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AD561469;
        Mon,  5 Sep 2022 19:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4594CC433D6;
        Mon,  5 Sep 2022 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405916;
        bh=57jshmal4TifwCJhJwupFxar74e24FF1+DL9zAhrS5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUxGWg3ezE9iIUy2FENdwgwYONsygNkGTOVZlZVZL9ItoHzrQxHwefODWbouAZEl7
         iE+prkF6c1Yp+K1xtYMUrVD1WMye+SPoAHhrBA6ZXSH89Z23gl2FW1GRLwo0mAh8x+
         qfqNLXdHffKLS7qJah25bhHYQ6IprtWBF6JVVzJg5/DrZz+juUlYXlJlFGRp7EF6FH
         coPfjOyhN0BXcu9Cq8SIT5z45szPlyXp2c5hOT9qNabz4mjqOlmI1Z+hB6NLeuPzhY
         LXBVTTghhB3muVM7vpKs8mAsf2gCV66I0apOGleltS22hrXBlzSgd4uhPfsATkuZRT
         4wANWTGTWapyg==
Received: by pali.im (Postfix)
        id F2CBD7D7; Mon,  5 Sep 2022 21:25:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/7] PCI: mvebu: Cleanup error handling in mvebu_pcie_probe()
Date:   Mon,  5 Sep 2022 21:23:08 +0200
Message-Id: <20220905192310.22786-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move cleanup calls to error labels. This simplify error handling when
registering of some port fails.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* New patch
---
 drivers/pci/controller/pci-mvebu.c | 59 ++++++++++++++----------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index d9e46bd7a4ec..9986dd486680 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1856,18 +1856,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		if (IS_ERR(port->base)) {
 			dev_err(dev, "%s: cannot map registers\n", port->name);
 			port->base = NULL;
-			mvebu_pcie_powerdown(port);
-			continue;
+			goto err_port_down;
 		}
 
 		ret = mvebu_pci_bridge_emul_init(port);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot init emulated bridge\n",
 				port->name);
-			devm_iounmap(dev, port->base);
-			port->base = NULL;
-			mvebu_pcie_powerdown(port);
-			continue;
+			goto err_base_unmap;
 		}
 
 		if (port->error_irq > 0 || port->intx_irq > 0) {
@@ -1875,11 +1871,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(dev, "%s: cannot init irq domain\n",
 					port->name);
-				pci_bridge_emul_cleanup(&port->bridge);
-				devm_iounmap(dev, port->base);
-				port->base = NULL;
-				mvebu_pcie_powerdown(port);
-				continue;
+				goto err_bridge_cleanup;
 			}
 		}
 
@@ -1891,15 +1883,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(dev, "%s: cannot register error interrupt handler: %d\n",
 					port->name, ret);
-				if (port->intx_irq_domain)
-					irq_domain_remove(port->intx_irq_domain);
-				if (port->rp_irq_domain)
-					irq_domain_remove(port->rp_irq_domain);
-				pci_bridge_emul_cleanup(&port->bridge);
-				devm_iounmap(dev, port->base);
-				port->base = NULL;
-				mvebu_pcie_powerdown(port);
-				continue;
+				goto err_domain_remove;
 			}
 		}
 
@@ -1911,17 +1895,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(dev, "%s: cannot register intx interrupt handler: %d\n",
 					port->name, ret);
-				if (port->error_irq > 0)
-					devm_free_irq(dev, port->error_irq, port);
-				if (port->intx_irq_domain)
-					irq_domain_remove(port->intx_irq_domain);
-				if (port->rp_irq_domain)
-					irq_domain_remove(port->rp_irq_domain);
-				pci_bridge_emul_cleanup(&port->bridge);
-				devm_iounmap(dev, port->base);
-				port->base = NULL;
-				mvebu_pcie_powerdown(port);
-				continue;
+				goto err_free_error_irq;
 			}
 		}
 
@@ -2015,6 +1989,29 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		mvebu_pcie_setup_hw(port);
 		mvebu_pcie_set_local_dev_nr(port, 1);
 		mvebu_pcie_set_local_bus_nr(port, 0);
+
+		continue;
+
+err_free_error_irq:
+		if (port->error_irq > 0)
+			devm_free_irq(dev, port->error_irq, port);
+
+err_domain_remove:
+		if (port->intx_irq_domain)
+			irq_domain_remove(port->intx_irq_domain);
+
+		if (port->rp_irq_domain)
+			irq_domain_remove(port->rp_irq_domain);
+
+err_bridge_cleanup:
+		pci_bridge_emul_cleanup(&port->bridge);
+
+err_base_unmap:
+		devm_iounmap(dev, port->base);
+		port->base = NULL;
+
+err_port_down:
+		mvebu_pcie_powerdown(port);
 	}
 
 	bridge->sysdata = pcie;
-- 
2.20.1

