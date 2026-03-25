Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742903BD64F;
	Wed, 25 Mar 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436443; cv=fail; b=XmzSr4ZcY8b7DP1Ab8LvTL9POk3YwYIXbkgQrhxfhNJYd99UF/8o8szB0XE09x+ocCASFMdmE9WR7rIXwmkoqBqngU/UL8zB+ZbVW/TiEbcdaHBdog4FWZPCSjtIdcAioRCDCZBeR2dX6MmCjnVHQNN4mludyXpfLG2grMK+FAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436443; c=relaxed/simple;
	bh=Jc0FrgwragrlZk+5EPEOHwx91mxL2zu9qtWaep3Stuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lrrlxufTv0WmgityUc/qFMPEYky+UDqKsg9jTNPtRTO4MeKM3CpvAnQy9oiISvyk1JaOgFfEzEMZ9U16P9Xo+UAalWxO4VJOyYQXHwn6Bnifhlj8nsqM4M1jvYrFZFuO0bWc2WNMc9zGcicF1DL1+4yyQsY3gMjD6OQGR405udk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FYYS6CYT; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYYS6CYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuuXG/bX3z2m3Hm00U3PNXXEOK+t2QU9yT98Ap8gSpzyAcLLHutThYeqK0FjR19j0LWgXzilcAdZMYzR4GbNo+pN5JDtoGB3i/AREjxatWn5RvsRFbxzC53ZfvjkgjCkeAzgdspCIegK6NRASmQyj6qJyMcPV/2s71Sm8cczKvRkLXY7/29WceWEFnmpVeaCjgpLoQvRsbtqpP5bD3CE86KV2z6xe5+kfK2xnXx4bd4c5WYssxC+sn5lQNY2I4lD2FV7F/5Vlez0daAbxLgY+UCFDGzewIBuutYwinJfAzh1f44AKEreZAspApUK52UBeJ8PLzMajhrkVDZJxS8f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfbs++LmFD5hYL733QHlHoNKtAt+15CrwJzRfB8lvX0=;
 b=ngHcVVXib51sM6GTk83gJu6ljCiZRuaEmOiONgpADOvC087W41SeByUPxLwmVcIZ8p/PhJpvG6UsX99VlDUFGTXJlRe4Smkh/NRG7lvlYS22qY0mqNbopqAyVETaKLSgy8ETZL63BHuXWLfF1iLtVejCQ+aqhe3Vg6gOPYkpb9+lu1XNWwQSe4m7F5MUTDdCnZ/gJwks2sIfpR4J7yfEWJg6ybJRIrxsfJiuoSSFyB2Q+xoXYiaTxMI/BgOv7HjbzCZ8ecWxSEpNU0Wk8hDy7TQOApfzB5buSaBLz4IsXxdQyoGuQWXbzKdF24gpd33ZBSiTxL+I6kib/ZuUmKZsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfbs++LmFD5hYL733QHlHoNKtAt+15CrwJzRfB8lvX0=;
 b=FYYS6CYTb4NINWRwGGP2l+V/YPWK5iKnudO57j+OwRVE9yY42dcYUBvjaiHe/IYI0rzOxzWucN3HW0b2jvMcaXb6l4UY2cHaKcHy2cvUY3nPoiFngjcwOxChPQ/QocGcWrpDedi2UT4WQWoh8l6Ak4wkrqQQnEERd9B0QzGq688zn6oyChCizDEwAd2WyDgkFkhW00qU6loElMi/IOuc1sj/MAvYTs9bZUdGmxzFw13ItAAB24ezPNaPUrqCEyspTS4PY8mSj9JFgspaZrJw0Ste7jm5vjRWAfsrOu0QDmI5/41On/GQdNCRfArsXVB+m1CvKMo13lh37IibXiYErQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB12268.eurprd04.prod.outlook.com
 (2603:10a6:150:2c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 25 Mar
 2026 11:00:40 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:00:39 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] PCI: imx6: Integrate new pwrctrl API for pci-imx6
Date: Wed, 25 Mar 2026 19:00:51 +0800
Message-Id: <20260325110058.2854742-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB12268:EE_
X-MS-Office365-Filtering-Correlation-Id: 708019a6-5ed3-4434-713e-08de8a5dbff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y3LVbPR0KqfGU5hlWvzXhbbTBMNRfV+un6nVQ8z1SfvqOyDs9QGglYtaYF85JdlClwIFvrcM5UofqxNfLj824CdQoP2c+ikNRFDxjOJJtDhGTddDb9nTeI0yJpE8iby9TCOmY2B8wRcHnrKFg2AIFqdf+IERJuUEkmK7YVWH77WdcaMtBaQYUB/Db9Z8U32Jz/3T1vomI9fRHOgiYK6bPf0hHJuX8Y2u2KN5ApMyGbbW7KgtVWs0j/3gz84jF2oexqFMFS48a2wtFQZCUwnJZzbyLTL8DKdiDz9aZCFN2Fhv8kZ7FJgP88MoMIrOxrlMA1/HsgxonvNTKMNiIV8kzd2xxTnbtttcl3a5dDbD0kpKhkH3qr9nD8RRbjgVeDfcx9VtsqLh2yF7HDXs57eJzeslFws4s3chC8pfetnUJcqCEYhJqCotkvSjP8lKjXnLJHJEV1TWO31k9NpTnrxhnQ2mEhhxVQdjALAo2B1ElJTV4g15V1Pze/AvZxinV+HYmdFCAvtlJGLZ8GeBfnrgRLFLaMM1g450QvuK40ZyWcj6kQy4VA2mhIYGvfi2lDWtFvOae8vg4loqSCnk7MI63G96EMVCcUhZz5rHXkVMwGSA4QgW35xLteq+x3vmbyM2t5Ezp59QXldoXe0mYgmXqFsjQgonWA1ZbdojCwK5LECTD9ZdqJjvvyrMzfE6EyBH5bJj/tA+vEmpfLEthARb+guXgiw2Hl9QOIV6cpEFQ6ZMfpdEDuydAgEOiA73azhaCI4/OrVvJdyRSKU5D8RojbIm0/lW9DUEZXkZa3nLKPQWrU9Ka+d47ayeaIABYEIc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+ucVhJefVzB8ziSJlA8BWdVcgZCB9SqTneJ/kADeilyFpZnrUO/wqAI5sOP?=
 =?us-ascii?Q?S3ejeMsXZ4zFOIUBQvm+eC1jJu6sXg8ActqaYzY5GWuzGnsQ/Wla/CMPEAly?=
 =?us-ascii?Q?VJEEOFjJx3WsK1SjT9jg2hSfZs57Ghk7Uc7qRbsew8W5+u2MIbR59TDyzZQy?=
 =?us-ascii?Q?M8+Gpgdim7A6oA/dAjxMzYBtmSWN2Cn515iaS/SN1ccLMUF80nNEzzXkQbe/?=
 =?us-ascii?Q?n5NmuVAGkbZz4GlH3D7D9xBCGfeM0UyrxQKGNBJHUO4AD0vmu77z/3Kh0Bqv?=
 =?us-ascii?Q?44qjEbM4W6BNicnz2YaTgXUxOa50L4uVJWJ1/7dFP5FsYVACr5w/Du05ng04?=
 =?us-ascii?Q?Kz+wVLkpJrK7GzaFSGjAIsr7NjrLy4+xK9/P+XyfDVDaTj8qScGKHPIdQAMx?=
 =?us-ascii?Q?Ah5ff+8ooXwYs+b+wDOis+SxMSxvG6l8aaVufzZpnfRe3yeyk19yl1GJBPRU?=
 =?us-ascii?Q?SsABSW4y8WwAN6iBVQZSwRccLFAQcgt1zNopkWEnaenewL5SkAJ8Vlat2Gtz?=
 =?us-ascii?Q?NR5qSeZcPY0VE5g7yj4AKkrMaKAf0EZUzaQkVBVV+bX0nmdsYEQNRBk4Nh3L?=
 =?us-ascii?Q?OzFOl7fKOl8OyUi4EjU5JnrUA5zl+mXHxJlOEGKSlsIa9QbvvLEu3ioUlN+e?=
 =?us-ascii?Q?ZifIAwW+gEbfzGffCGxzsRW8RKOsOsOrLGCYqmLwfebv+cmcZ28GmtpGVIjB?=
 =?us-ascii?Q?zdLeGuOL7x8Fj4ea7iT6STB2K4d9ZTiJHlcPczzf/5UkN3WiJlDVI2OszLZv?=
 =?us-ascii?Q?IUrg4HfC0A4Wj9thMTTdgMO501z407gFlLARTwEB4few3gxauroI8QpBtgVV?=
 =?us-ascii?Q?XLHtel0jxLZAXobdDMFMlgDTIFY71c/PN9GF9hb8YXPbJDpelnZuxa68tA7y?=
 =?us-ascii?Q?s1EZtJOAqUfz2QSbAS7NjZo97Dzdj3GX+0EeoucBlqZ9HsTQZrRk22bO+Xp8?=
 =?us-ascii?Q?CCH+EW1D2cju9mkY0rZD6qzuAb9f9/artRbNFoJxEATmGDRqUPfg3U4V7qsa?=
 =?us-ascii?Q?KdDIbPh7TXYfw3qktLy3rb1HAx/AIcETQhqIIRSXfUbR5SoCJNHLZip0DXEY?=
 =?us-ascii?Q?t3EQkHUwmG/GbJO4qekrq0MNiidFK2+vVt17KWSU/pmx9cldqYIl6uKg9vuS?=
 =?us-ascii?Q?/tHBZ/j9h/M8jR+0vwmdpPpXIwd1Mo9AUKMX74rwYXgbg8AtuWArarSWAMG2?=
 =?us-ascii?Q?/TcvkALxng6JYZ4F3IjeZ9lK86my6oE5bv6Wlu2vy6D2PgtsqrA71y8sY7y2?=
 =?us-ascii?Q?3h2gThsI2PuQtXTK4txoZdxn7whWG6HTzo9w/WwP/dcA7+C7er3gtrSwSy0H?=
 =?us-ascii?Q?VUe5qXa0RCsxkiHFEJnQPKBcSU2G1Z1T3WL4cvZrQ/iOioaV4QXEMv+QrkZK?=
 =?us-ascii?Q?F+58pgjmjRST2OVRiBplJ5kgwwhllbdPzpAsAjJnbrhmAHclSLYzkCW9GHE6?=
 =?us-ascii?Q?G0V7DTezrMoL9YICyqm9hURZtxrPpCxWN9T8DvuAHFOZaF8pFv6vt485Eu1M?=
 =?us-ascii?Q?aVLF0FJbCHLpgO5yLZ/7PtobixVOmA16pUPdzI2IJhC60ilqnwmo5clBUbyy?=
 =?us-ascii?Q?V2Cf98YJUjVKrzBw/w4Xf/B+8bbrDgewRw5AVUH5OiQQ7E+uwjXb5lBHzeK1?=
 =?us-ascii?Q?KHs/aciNz8cJgzBOeQ4g5rVAHjWjzRyJhFLgaGVwUtp4Wa4XiOiEKwaI93wa?=
 =?us-ascii?Q?5xXkEqR3wqO1Bl/11HHwwf/FV2eO5arPX+yPeO5jNdhIpGDIXSe2i4iPSDFF?=
 =?us-ascii?Q?bouHvXxMHw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708019a6-5ed3-4434-713e-08de8a5dbff4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:00:39.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 856Gtynen1nIOmYR/ANmgLe4LeHwGHGm+vsOkX1oX/dpWY26eu57qA1GUgJd4jiZcPYT+U5ugnNR6EhX8QgbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12268

Integrate the PCI pwrctrl framework into the pci-imx6 driver to provide
standardized power management for PCIe devices.

Legacy regulator handling (vpcie-supply at controller level) is
maintained for backward compatibility with existing device trees.
New device trees should specify power supplies at the Root Port
level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig    |  1 +
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index f2fde13107f2..327b0dc65550 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -114,6 +114,7 @@ config PCI_IMX6_HOST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_IMX6
+	select PCI_PWRCTRL_GENERIC
 	help
 	  Enables support for the PCIe controller in the i.MX SoCs to
 	  work in Root Complex mode. The PCI controller on i.MX is based
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 77483f44c593..b9d72793f266 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -1314,6 +1315,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			return ret;
 	}
 
+	/* Legacy regulator handling for DT backward compatibility. */
 	if (imx_pcie->vpcie) {
 		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
@@ -1323,10 +1325,22 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	ret = pci_pwrctrl_create_devices(dev);
+	if (ret) {
+		dev_err(dev, "failed to create pwrctrl devices\n");
+		goto err_reg_disable;
+	}
+
+	ret = pci_pwrctrl_power_on_devices(dev);
+	if (ret) {
+		dev_err(dev, "failed to power on pwrctrl devices\n");
+		goto err_pwrctrl_destroy;
+	}
+
 	ret = imx_pcie_clk_enable(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
+		goto err_pwrctrl_power_off;
 	}
 
 	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
@@ -1385,6 +1399,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	phy_exit(imx_pcie->phy);
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
+err_pwrctrl_power_off:
+	pci_pwrctrl_power_off_devices(dev);
+err_pwrctrl_destroy:
+	if (ret != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
@@ -1403,6 +1422,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
+	pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
@@ -1911,6 +1931,7 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
+	pci_pwrctrl_destroy_devices(&pdev->dev);
 }
 
 static const struct imx_pcie_drvdata drvdata[] = {
-- 
2.37.1

