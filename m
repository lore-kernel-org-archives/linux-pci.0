Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3636341077;
	Wed, 20 May 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266847; cv=fail; b=eJxj/ZhrJO/BcySvTWpWtlMiEaVqDLcHpYAkwedLCLPCtJeAU9XvTL2Sg/mKcUZYkfkTNOPXno4wI1DDAv3FbuwQ0OPdqAqadt8UjsWOdKjBTMTBa11E51ph0PmWRbKTCteqkRPTFyVswCG5m/hX9YcBE6ZGiQeR3IHSOGNY3vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266847; c=relaxed/simple;
	bh=SQoWT9OqTP7SD0U7gdP0CnY/9QX3cK52FzZkVfrot3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4z7736Oup9AN5KU5l60aKeKRjV24ZgiC7ztvQJWZLucDNTamGe7zGIN4XNxBRkBL2e3OcWA3B8KoyivL568tCB8y+Zwb2ppLQgFImWG6jLotvb52wqIytB2q8W31ldEZ9bcv/hsWe72DpzsRSqohUxwt5xy4jZY3T5t8UfB+1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HRMMz3Li; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HRMMz3Li"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC+GWNF1Cr79AdkC7MseKeVN9Yzk0qQqegyrbwkLkZeCwFr37ClOpi2MbGIsan7tW8qrUUHxqKCLWEL6v2hxz+fkFleReKVW3BKWUmoxrrkSWn9AmgdBapthTvozdqD7vp42uH888nxh6kpnTpjxx0g1DZOYNCa4YmpaowUtkjWqHV8TnvkZU9R8OQHyOJgUW1/X4hDTM9ODmpQNpzhXii7ZoReaYXQiNgKsHevXvlNXoN7aKztv7IzuQ56shiFsxkeug89apAwG2t0rPC0ZarketzfqJ0LsArldGfvbLTQ1nhBjwfVhTFp9BKkmdmOddiMINQKY0v3ncmztG+rXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oDxro81v+Vc1W7/bZAyjtXY5aLkxh7HiW8YlWVODYw=;
 b=i2RWDsqlvYHOzkVv5JKBJtvT3j8ypcAc6hBbqmtPSkz9LnSrQcVzGHxycwrS4XTdOcSHtrljXRyLEYrG4TRntWNVJ9DYZ7WZy9st0SEQdJ+MjvOqE+maLiGMdPaM2laEx2uTL98RINc+d2fnJUTflmlEhqkp48Zlzq9DDREQw/RdlqjmejmogKjFeBpJk9dP4m8dT/Xs/lFjHcCNoOzqdMG+kzPDR5GSObFRYGat/NmDczYVsHl8u/xN3agaAlNXdWAQ2ck+sWGWI6Evc8hQx8cTTNvoMun+GGJAbyoL56200Sf1SaNXZCgtTcnqqjfZL4UFWm+I+vGJc7u+F7uG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oDxro81v+Vc1W7/bZAyjtXY5aLkxh7HiW8YlWVODYw=;
 b=HRMMz3LiVOoyVGQVDg3/f7s6TneSKKwDxv9QPXFApzSDnfFP3ODA/+AIG4U4JkfuHc9G8F8F0t5x+9LsknHekl/GhA7AmAc8A7Qif8EUC2kWMuUKBrklDlm+QQevy9kskavW3Aewvun24a2jmRF2RGgU8Kg0AwsS8FpkmT3a9Tm36PtiAvCzoxxpQMSW4127KNLhTMNiaCS2TiFporJhVk7EiRukbRKqJdRICSKb7gKTsfu9NbAMsBBpbej6PP68zX0Zb3LZJlf7RU/vNa1xNOCEv4ixDpprdjERNuv6vW80mVtk4h1OYXea09dBkTOTwAKfJXTGeInxsZKUBz9lQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:47:21 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:47:21 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 1/8] PCI: imx6: Integrate new pwrctrl API for pci-imx6
Date: Wed, 20 May 2026 16:48:57 +0800
Message-Id: <20260520084904.2424253-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: a81dc7d9-1562-4316-5eb6-08deb64c67f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	fvk4BkZ4NIgBO33QoOHRuq1YeOxqpt/DC4/P4Ju1IjYdedCuY+it6HtRsh6hqmnPwyq78IyxgNMV1sucvYkRw0OiUUYoCjLbj7Q6tNdF0OPcQEJ3U1/ZvenT7+2RE7nd+v2hH80NK5buxqJ/8IP05Yuj1hFSgIJRwtm+XZorVFsVELzb7zxFxnj5XgucxRyL1rgfwYEeBEuauQEGDg62odWgkpLs6rvLpSOiacebFrAzGyc4Ws5eBUBsF7Cfx+4EHtPzHuN3ciIYwkWgOHKDF2ZPJvLOf7hcoD0PQxbpixo/hJTl2+ELemCce+TMxqzyBZMDFe0nDgFqKvEmFpp2xmE//qJ9NFWGzITi7cG8vsqBJOjBD2EU2lkhPOrpCIRYJRycM0xYsW+QOeRTAhxKJeXRuylVgLcLoVK0ZL8LqP4DElRX/QfNaQORX2yhSV9yWaAD/5xnZ5KEixmIz82X6Q/0ZojGODCCBVSPOn5baPNACDWUaacbY/FtkEkc0nSN6Hqye2V02t5jkh6QYrVfFiZvP0BeJHZZAP503T274TaGO6dIsTZC6gZJQmqg89OIMegWeTtc46XWju1gjz5xvwSYv2TCOEBVyTgb8ik5FcmpldZY8gTEy7JDzgZ7nEUroc5Dfjv8S+eWNzeR/lECXPJWPI5celhCbFE5tbHIfOoAl+DRzOOV7tSFLre09PEC9YoFuOsTuz51iSRiNy87RFcupVc9oK5xS/pn65wEmnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzoO79otvkczF0euSy8xHhiVLDgmcxHIiPjUWpS7qOUrh6I/9YcUBDSILBIN?=
 =?us-ascii?Q?zFzkBXNpSYn8HsgVUhP+TD3u75gzyinxZa9DdQyl2go9Wiz46YKs+q/nGpD4?=
 =?us-ascii?Q?mjOaz3r+67klSCtKXOYGjSew0yu3H3Dgick8La7nvmHDpac/nfA8U4qMU6aF?=
 =?us-ascii?Q?qwlZX0pCZH3dAfQki5YlKU4C4ntd8Qt4oTqWAg8rQN4y6iZoqvGNSl5GkLQw?=
 =?us-ascii?Q?4YsbSgZTOCsEOXkk3KtyUOxcR7Ix4NTFebJcD9Xz9R75UcBYKNZOg+xfg3qL?=
 =?us-ascii?Q?x8+GbsPUKml/Com+9znKJShndJyfW0W7nAnODzwSZCNbUcTwqyLlMMt8lFRF?=
 =?us-ascii?Q?0H5uoeNI/b9wEAaH/53u7NAy/B4kbJMPC8nABHcHXO9YMpCgH3M1IE8S5vmb?=
 =?us-ascii?Q?T++1OmEJkPmOIlWZfMZ2Du3lD40SJiRQi7geBVwHWCNvykbzS7pNtxhmnjMU?=
 =?us-ascii?Q?JKC61RGCHn4l4CN2wfpJ5Rjz8FS02mr/npZp2StZjeMZKjk0PUU8vialiGEM?=
 =?us-ascii?Q?JAJa4HhvPjy36WY9b0ZCHuJj34QplEtfduSEx3/JAbAvozgDvV7u3hmC2BEh?=
 =?us-ascii?Q?7tvhT7uDU3/kIe4a524jgjLuYrVIknWBpNliwucq0FOgcem/OjaB0pePtRoR?=
 =?us-ascii?Q?wDZzvvUWJz1uynpDt/KcYuOLAVXbTNrrc6StZ0xzFTLcYqfkM1HfmP/WZzAP?=
 =?us-ascii?Q?TNtRuzdNdOfgUmOl2meH+1uUNbP6Q3geELFXlSTiW6XYcXndg2yHiMj4QnNr?=
 =?us-ascii?Q?dBvLEoO+1VXF42Yph83VKvi/dk7LussHaQESPv1+FR7u923idHYmPITDl8lb?=
 =?us-ascii?Q?lGRTjoPTN8ebFdI3U1CDuNxAt28g5UhR/4BzScPM2MuklMZCXQ9iuBLH3kJs?=
 =?us-ascii?Q?C4drUWjPr7SimqYhPtPa6n5HQZI3Kfeh8lSfIKuVRtOJm4EgT2cJWBnt1gUL?=
 =?us-ascii?Q?8RS53v4lwmrDM4oSFVDtFLn9UbVbAA3aVUDQP2YoR9Di/D6UTneckdkYU0Wc?=
 =?us-ascii?Q?HFUdJsn3Z6auuyD0fvGPusOx8pteEQ4umiFpxKSijUv7ytof0QBPPNOOnZBp?=
 =?us-ascii?Q?OLoYky9/tytyvvWQrd2RMnXnIRkmB4PdPh6uvsxyjZSyEsAYkrojPNCgvcuu?=
 =?us-ascii?Q?9y/mt2ZDxPgMlNTYhdHcfFsKOwtEaTFr0/Zs5hiQ50zgrg9xFF376aPgXvsG?=
 =?us-ascii?Q?riMXYA3MISCUNdsdZvs1q3S/Lj4W3Z8z13wOaE+0B0ZRGkY42x7BlR7J9hcm?=
 =?us-ascii?Q?2OLQ1maqohybMqtimi1FLUQuIt2AjXVEZlvP1niZHmmgUF4iV9e4piiQ36XZ?=
 =?us-ascii?Q?gNOkOPHHfSPnZrJOuvqoVz0qt0r/btGIXTWYXy8Ndtro7Rrye2lDfaqpNQHr?=
 =?us-ascii?Q?qY7QyibaMPG3NFIsmbwd7YajUKTdsPsencg1cAHofUcc6lQqjqpF7o9DfDmK?=
 =?us-ascii?Q?TVNPZRYP/JAQj+SZR0FsxTdaoiD5mNHOrBgH9o9tEs9yXED75LjmT/NZXQXg?=
 =?us-ascii?Q?26gYJ/KWFiahGykof54aMCpR/+OK+VOcPKlLJeVAgV86/JeUeEPWAIv1LieG?=
 =?us-ascii?Q?QpHPKMrKx0Kz2KHmdB80YT8nQK3vYGIosrOd9scXvt5vZ5UxsgT3gA57gDkF?=
 =?us-ascii?Q?3E9Yvf3xiInrSSNxHh65Z4jzEIZ9erQbsUAVAGm/W/a2BhVXgwHlIE95GHFy?=
 =?us-ascii?Q?ZpTQn/BEtBSxYoyTgyPEzGkTdbQbtITuoWRavKPBWGRMgP+ivztAHQIXgY4E?=
 =?us-ascii?Q?Q6AHEGKdIKRXz9U6VJc6CUo/rzLI4CwEP1HByjdsum/uVJqmMWxc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81dc7d9-1562-4316-5eb6-08deb64c67f7
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:21.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZYiCoimiqew8su1mTH8RZg/isrNGY8Wd287+0TTlzbBBLvImAIVGVWvcapYC7idsQI4o9sQwCKsrRl0Pw1ih0j8sXotAC0g8AzM2Qx76qA5YqIVybjVY11mSAfNyQUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796

From: Sherry Sun <sherry.sun@nxp.com>

Integrate the PCI pwrctrl framework into the pci-imx6 driver to provide
standardized power management for PCIe devices.

Legacy regulator handling (vpcie-supply at controller level) is
maintained for backward compatibility with existing device trees.
New device trees should specify power supplies at the Root Port
level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig    |  1 +
 drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 216ede0a867e..aa0b784c85b4 100644
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
index 773ab65b2afa..b137551871fc 100644
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
@@ -1331,6 +1332,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			return ret;
 	}
 
+	/* Legacy regulator handling for DT backward compatibility. */
 	if (imx_pcie->vpcie) {
 		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
@@ -1340,10 +1342,22 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1402,6 +1416,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1420,6 +1439,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
+	pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
@@ -1931,6 +1951,8 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
+	pci_pwrctrl_power_off_devices(&pdev->dev);
+	pci_pwrctrl_destroy_devices(&pdev->dev);
 }
 
 static const struct imx_pcie_drvdata drvdata[] = {
-- 
2.37.1

