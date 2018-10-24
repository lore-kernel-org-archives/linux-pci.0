Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB87CC004D3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79975207DD
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="rpHHGUfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79975207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJXXta (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:49:30 -0400
Received: from mail.nic.cz ([217.31.204.67]:48462 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXta (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 19:49:30 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 33DAB6059E;
        Wed, 24 Oct 2018 17:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1540394457; bh=7WBZC90kwiXZzjbnYMGKL6ijHTtlHbc7UzTYfWdBgsk=;
        h=From:To:Date;
        b=rpHHGUfiRVvNCbQHHTgAsDLbKAb/JsWn7AF/exSCIl8KsxYPGB/VTw2bUJFXWvHQI
         vt/o1dJunFuSvsEeJoECCRH7STd8x6jQFlWOx78rO99KzBA5gEwW6fegFgOHupeQzV
         RU51A7O0GYadUYMsvvbZ4Py2RPLiAEwBW8mhs314=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        =?UTF-8?q?Antoine=20T=C3=A9nart?= 
        <antoine.tenart@free-electrons.com>,
        =?UTF-8?q?Gr=C3=A9gory=20Clement?= 
        <gregory.clement@free-electrons.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>,
        Victor Gu <xigu@marvell.com>
Subject: [PATCH RFC v4.14] PCI: aadrvark: warm reset the cores and card
Date:   Wed, 24 Oct 2018 17:20:56 +0200
Message-Id: <20181024152056.17813-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add code to do a warm reset on the PHY and PCIE cores and if PERSTN GPIO
is specified in device tree (as reset-gpio), also reset the card.

The reset-gpio is inspired by what is done in U-Boot and linux-marvell,
and is not final version: I am hoping this can be done via a PCIe register
rather than GPIO - bit 3 of CTRL_WARM_RESET_REG register (which is added
by this patch) is called PERSTN_GPIO_EN (Enable PERSTN from GPIO) and
I think this is the right register, but manipulating this register did
not have any effect on the PERSTN pin, even when pinctrl was correctly set.

I asked Marvell about this and am awaiting their reply.

The reset-gpio is needed for Compex 5 GHz wifi card model WLE900VX. Without
this patch the PCIe link never comes up in kernel (although U-Boot pci
command was able to enumerate the card).

What is weird is that the link does not come up for this card when
pci-aardvark driver is probed in U-Boot. I haven't yet had time to discover
the problem there. My temporary solution is to compile out the pci-aardvark
driver from U-Boot.

This patch is based on 4.14 kernel.
If you have time, please try it with some PCIe cards and let me know if they
work correctly.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Lorenzo  Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas  <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: Antoine Ténart  <antoine.tenart@free-electrons.com>
Cc: Grégory  Clement  <gregory.clement@free-electrons.com>
Cc: Miquèl Raynal  <miquel.raynal@free-electrons.com>
Cc: Victor Gu <xigu@marvell.com>
---
 drivers/pci/host/pci-aardvark.c | 46 +++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 50e8addc22f9..5610fcb3f426 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/of_gpio.h>
 
 /* PCIe core registers */
 #define PCIE_CORE_CMD_STATUS_REG				0x4
@@ -147,6 +148,9 @@
 #define     CTRL_MODE_MASK			0x1
 #define     PCIE_CORE_MODE_DIRECT		0x0
 #define     PCIE_CORE_MODE_COMMAND		0x1
+#define CTRL_WARM_RESET_REG			(CTRL_CORE_BASE_ADDR + 0x4)
+#define     CTRL_PCIE_CORE_WARM_RESET		BIT(0)
+#define     CTRL_PHY_CORE_WARM_RESET		BIT(1)
 
 /* PCIe Central Interrupts Registers */
 #define CENTRAL_INT_BASE_ADDR			0x1b000
@@ -270,8 +274,25 @@ static void advk_pcie_set_ob_win(struct advk_pcie *pcie,
 	advk_writel(pcie, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
 }
 
+static void advk_pcie_warm_reset(struct advk_pcie *pcie)
+{
+	u32 reg;
+
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	reg |= CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET;
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+
+	mdelay(100);
+
+	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
+	reg &= ~(CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET);
+	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
+}
+
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
 	u32 reg;
 	int i;
 
@@ -311,10 +332,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
-	/* Set GEN2 */
+	/* Set GEN */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~PCIE_GEN_SEL_MSK;
-	reg |= SPEED_GEN_2;
+	if (of_pci_get_max_link_speed(node) == 1)
+		reg |= SPEED_GEN_1;
+	if (of_pci_get_max_link_speed(node) == 3)
+		reg |= SPEED_GEN_3;
+	else
+		reg |= SPEED_GEN_2;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
 	/* Set lane X1 */
@@ -948,6 +974,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int ret, irq;
+	int reset_gpio;
+	enum of_gpio_flags flags;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
 	if (!bridge)
@@ -970,6 +998,20 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Config reset gpio for pcie if there is valid gpio setting in DTS */
+	reset_gpio = of_get_named_gpio_flags(pdev->dev.of_node, "reset-gpio",
+					     0, &flags);
+	if (gpio_is_valid(reset_gpio)) {
+		struct gpio_desc *reset_gpiod;
+		reset_gpiod = gpio_to_desc(reset_gpio);
+		gpiod_direction_output(reset_gpiod, 0);
+		mdelay(200);
+		gpiod_direction_output(reset_gpiod, 1);
+		mdelay(200);
+	}
+
+	advk_pcie_warm_reset(pcie);
+
 	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to parse resources\n");
-- 
2.18.1

