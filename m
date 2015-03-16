Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailrelay118.isp.belgacom.be ([195.238.20.145]:27663 "EHLO
	mailrelay118.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934282AbbCPTzC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 15:55:02 -0400
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fabian Frederick <fabf@skynet.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH 25/35 linux-next] PCI: constify of_device_id array
Date: Mon, 16 Mar 2015 20:54:35 +0100
Message-Id: <1426535685-25996-4-git-send-email-fabf@skynet.be>
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/gpio/gpio-mpc8xxx.c      | 2 +-
 drivers/gpio/gpio-octeon.c       | 2 +-
 drivers/gpio/gpio-tz1090-pdc.c   | 2 +-
 drivers/gpio/gpio-tz1090.c       | 2 +-
 drivers/gpio/gpio-zynq.c         | 2 +-
 drivers/pci/host/pci-rcar-gen2.c | 2 +-
 drivers/pci/host/pcie-xilinx.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index a65b751..59c4c11 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -334,7 +334,7 @@ static struct irq_domain_ops mpc8xxx_gpio_irq_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static struct of_device_id mpc8xxx_gpio_ids[] = {
+static const struct of_device_id mpc8xxx_gpio_ids[] = {
 	{ .compatible = "fsl,mpc8349-gpio", },
 	{ .compatible = "fsl,mpc8572-gpio", },
 	{ .compatible = "fsl,mpc8610-gpio", },
diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 62ae251..41b5a4f 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -133,7 +133,7 @@ static int octeon_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id octeon_gpio_match[] = {
+static const struct of_device_id octeon_gpio_match[] = {
 	{
 		.compatible = "cavium,octeon-3860-gpio",
 	},
diff --git a/drivers/gpio/gpio-tz1090-pdc.c b/drivers/gpio/gpio-tz1090-pdc.c
index ede7e40..d04d814 100644
--- a/drivers/gpio/gpio-tz1090-pdc.c
+++ b/drivers/gpio/gpio-tz1090-pdc.c
@@ -222,7 +222,7 @@ static int tz1090_pdc_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tz1090_pdc_gpio_of_match[] = {
+static const struct of_device_id tz1090_pdc_gpio_of_match[] = {
 	{ .compatible = "img,tz1090-pdc-gpio" },
 	{ },
 };
diff --git a/drivers/gpio/gpio-tz1090.c b/drivers/gpio/gpio-tz1090.c
index 445660a..44f9dc7 100644
--- a/drivers/gpio/gpio-tz1090.c
+++ b/drivers/gpio/gpio-tz1090.c
@@ -585,7 +585,7 @@ static int tz1090_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tz1090_gpio_of_match[] = {
+static const struct of_device_id tz1090_gpio_of_match[] = {
 	{ .compatible = "img,tz1090-gpio" },
 	{ },
 };
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 184c4b1..8ff311a 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -695,7 +695,7 @@ static int zynq_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id zynq_gpio_of_match[] = {
+static const struct of_device_id zynq_gpio_of_match[] = {
 	{ .compatible = "xlnx,zynq-gpio-1.0", },
 	{ /* end of table */ }
 };
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index dd6b84e..db52c6a 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -356,7 +356,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id rcar_pci_of_match[] = {
+static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ },
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index f1a06a0..caae2e4 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -869,7 +869,7 @@ static int xilinx_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id xilinx_pcie_of_match[] = {
+static const struct of_device_id xilinx_pcie_of_match[] = {
 	{ .compatible = "xlnx,axi-pcie-host-1.00.a", },
 	{}
 };
-- 
2.1.0

