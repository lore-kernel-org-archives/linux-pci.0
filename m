Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A933C873C;
	Thu,  2 Apr 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124566; cv=fail; b=LmYykzFZCwfoFHfXZAmyGbXmS7nrsSbR8H94/WjEhydyXMw7oaTA+8XlGSBwv+AitjCYJJQMFlc5pn6ndGIhPQAhzMBMBooZPoeCwOqKBntxK/KbHHbL8DleGoL3gH2HEnC43B3Bea93S0iaqjFQMzMrBxRdR2EfvEXf7tr3eDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124566; c=relaxed/simple;
	bh=12SfMtedroPJJFyLBNXjVLomRzKoBA6UgTa4iPslaAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWsdfqFNeEdX8u/rSG8MclybjWt3n/xj61Vp701csLtzHWEgmFFSXT3Zy1qL2D4YLsYn8N2kxiSU5ysLcwwT8WuIGH0cVAMs33RM8elPOhQ3FMOuQOL4wA5+CLkHmayOlqn8rZsgCvxTpf3uEmx0fl7bQq2OC9rGrKCKysYczLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EiukpR40; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EiukpR40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLMoFzw5DSdEfxfFk5Ah01in4FzvrNqmC6v1n8vZVPXwVvmp7bMNhxVzUTo/77C31boX2n1ZtbTHwpxjv23/rhMfRJQHehu14LUKamQqbbYvf78u/w5NdyjUpCvXY/0exM+I+ZrupqlKR02vivdUcO8ItmkldVAsiIXub/H4C4sbnmJywJ5b5STchKGExWAg8f2rpEvPf7ZKTAyalG0HA5o6ErtnjPV6HiGeHnDpqDSnbReI+V9G3dgmjoxh+i/650sK+6jQJzewcJXAJoT7TbGFzbUIsrJri2UXFIozm+jNsYNgkRUSvMPFINS+UhWzdEjxwhLWubKyzNz8p70gtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOoKKWH4IHPn0BIkcfoeyVjzWEaC/vHdikI5Zp7tJa4=;
 b=GqnNpY8QF0DPWdJVgGcEOqpzWFiz76u0IpDdtX9fGtwAFS+QlpnmSjGjH8i8IQoY70FTQDUrxl8DMu3y7Y8KfchnvBNED3jAREqISTa2OwMhS/OE4v1BB5gpJyfIpcJmqP8F7NHPovVbXMcCqOTozhhOCkR0QSnk4uH2bGQEWUOTGY7GfOH2lYh1ewev6spreyXpNyjhrHUq4Je70JnOGA0rk0zPLRqQ0yg+RaV10f9wYUYKdvRRYrepukH9taynWC3WUOPSyB3/qkR3qWKo62EUHaGHULA6YL7Rbce5oVXYSj07MzuxPHCdanG+XrcuZPra1h+JhEYvGqsaKTUGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOoKKWH4IHPn0BIkcfoeyVjzWEaC/vHdikI5Zp7tJa4=;
 b=EiukpR40YM7LC/pppS5366aXfnEjis2E6nHP1EPCzM5Rc9xI5CMDH+NwTaEQxbjIzVt4c59mazml7cf5WjIQnCexllgZGLeD13OkYRY6nqBFDYZKqf8t76yfxm4/l89Qx1ZnQGcX0+02OVC4zXsRaDmphhB3OUHMqP5STfrU3kQVWnXs57ueYnH4TtViQx30G55krcnWoHs7aOIUthqruhG6vFJJniau3jRji7O0GDVt2RDZemVvVPlefOMMOGCs3WXu5/apRINMP3JYaO52XwnMcqzQi0a34ZsoULaeQAxg4toQxdpKYX7dRqGjICmzvuOOccqVSq95beKHb6zHwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8706.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:09:22 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:09:22 +0000
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
Subject: [PATCH V2 1/8] PCI: imx6: Integrate new pwrctrl API for pci-imx6
Date: Thu,  2 Apr 2026 18:10:00 +0800
Message-Id: <20260402101007.208419-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402101007.208419-1-sherry.sun@nxp.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 207968f6-c524-4406-e3ec-08de909fe95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fG8yP0ttSqzZ7oSo72MWQUYymhlRdzIBNik1rLC6hSk5XK0Eq9Xw26ZmtJiPAjoXaUmw8ECXTcs9m0TzvLct06bcwrIeK7z6tejhR06F5xIdaiPgwQqG6NFVja9IBNCQWVQ1gYLrVxU8JMJwTBYmFosIKj6ZRCGoAwZHDBBZIjfeldHgHDZ+tCIA8KKOwVLk7BJaQZldQxnhW2hbJ4/pVbF6Jmr4OB6mzJoNQ0V7S3pYj2CdZbsu4EhmeAjcaYndvKOuq5MncrLa0CcwIJz37jEZ90InIFAWg0oibkxSbt0eYUOa7WucNs5kn51ErLyBzELNad1l422L7B1ESTs8AY64d81DOoVBuIPr1MpENh5ygn9vZ/xjV485JE50Q4WJbMWq9NEh2IzRKkDUk+DkEyE6Ay13IEX0AotckJfa/vv6SqltVcjgUPEKRARWpvwtkj2w5eSFs/jSTESkWqXjbYQXpgR+DIZHjphP4xOQPYr337N+vpEsk7dn2XFscsbcdmQlyEkk6umH8M4lANm8W9a6Fdx0APoM6YZCFj69AUiWcRG2Cx4wy5ZzvkuniztEcXONxKcrzR7KPutOyU3ob3I5Pwugyunmc9lErBhFB7Ww0N/NGqtQI7FdpvM6DM2KWCpZvWgUPXOuxLr9LVOym37jQy/9ElCRxBVWStx9vPh5V8oSyDCTrYbPfUCo3TNgm+iMR/941U1ea03hVFBmkpL0VfZoOYXno6sIZK295kSF/fLPssUrSZWUQZ/Q4TOhz1kB//rmwpFFZ2KvhZ4cr+GwlJXqI99k26glc/ACIARKPbx6+cZyN3tI+SB8jDs0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sVE7v2dcuQkupZzg01reuXv5hzuZY6LkfjLl/adn+ulqJOb6sWCWnGNLuQyl?=
 =?us-ascii?Q?gmoAM1qWLZ8aNV0/YVXCMgSmGiE24MlwsCOBHyf/r8dcMlZ35GpYV7mJj25J?=
 =?us-ascii?Q?aqWnSVKSE8+gHH0ImYxoRxpv0GudzS8yDPxcu8pXruunIyDHXzMnpdhFk90y?=
 =?us-ascii?Q?Rwx0lSCia7tMvir89Tp5EeXsLAFybwkaRev5jwCPaEAfvkaSw0SQlzaQmYRU?=
 =?us-ascii?Q?GK5F11Pob2gKnBYBc0KnAp36LWLxVA950fe22//8Hb0cLAoLpW1uYxz8UD5T?=
 =?us-ascii?Q?jSRhOjxDlpj6p18BfeXaWK05pDg6REZMdXAit8qA737l/6PXUw+IS5hGrpCn?=
 =?us-ascii?Q?JPXforVwSwc1e5qWV0cbRcULdnalttV/h8zaMmw1dIeoOFihaJVK8iIip07M?=
 =?us-ascii?Q?IA3Qdzmpxo0k9UxNh8woCloW+TrNUDP/oNPlApKPfJqZIBuE/22c1qfOVQgM?=
 =?us-ascii?Q?3JxbkCZp9/EoNKEYPPoEbgAdTeZPbr7ICDJFZ/l+lKu/2Uoe0nSv/DvaD7eq?=
 =?us-ascii?Q?prL4O5Cwfud3ZkQCOfJrMfWpg+ZGlyBwgsaTdqgNkfM5d0yjxcokApLPNEKo?=
 =?us-ascii?Q?hG4r8F6uFyM5GL2Ul9oqNR4WLTuLu2jagHgFVHzNuY2cGGWBFn79eBldraiA?=
 =?us-ascii?Q?e6iDmeIPpr4SVl2Cv6bgsfxZV1ObWePN0cLVynDt8QxqcbjGvZwPpyaNpTZg?=
 =?us-ascii?Q?hvMn3bQVliNK0CoCZUoQRTQd0naw0dA6z+vAfqYG620eNTnHdjtJNbE/8FoT?=
 =?us-ascii?Q?6Y4JpPtCbLT0nKHB+YUX0RLGNLK/kl5iNG3F31KAttQhM954CCSBBfdesmSm?=
 =?us-ascii?Q?tsmoGCStV85kwKU79Co+xcSYZ/SHjsZrd55EVhv0xk6/Q7C+AU8anIzwnNsm?=
 =?us-ascii?Q?zyitSlKR9Pub62c5AkiTE3nzGXtKYwpvKV6BPsWT8AAP890fIq2rAYSG8OpC?=
 =?us-ascii?Q?5p+I4H067KAjIXOv9fXjlP5aOKNxfTIl33MoE+pH3pbxdJW5tn4/gnb/SvfM?=
 =?us-ascii?Q?SrHFvi76KJIPPQDe29EYSceMLvg32cZljY7bDthyiQeqfRZZRzExmSWnzG+5?=
 =?us-ascii?Q?o8VYEzzc/UNroMWPU9EbJ4Mrstah9Mtkj2v7E729uZHejO2wrr+c9+ejd1mV?=
 =?us-ascii?Q?1ttY3CFLVKaCxUhZZTr8ZTM64hkeMogFbXurKC9PKBErF7NWKDKtAFMUUSzc?=
 =?us-ascii?Q?HvNQaxwLmhszmk1xiVrmRdzFpCfD5YtjlVe8YPdfq6FUX/wkGF22dZ7RU94w?=
 =?us-ascii?Q?x9gqo/RkqToza80COm/MRbH5E4YoZr4pCY6vYW9jut5mE18CSwDd9o9fU3ZN?=
 =?us-ascii?Q?MkZe08DDJi5dfCxaBF87SJOFjnQ7ip087j5Vq6rG0A6YNxmgk0dfNu90XE9T?=
 =?us-ascii?Q?Ucy8lkusMfjx7zntNbblRPxfXi18KqexkZJZN8PF2iEPm7V3YtW1hx6yq/qe?=
 =?us-ascii?Q?5VCAv2oEmxF58+g6znMqnC/2LH62hWKmeRC/LDRNvMiwU5/N9Qhdi+SuGRmN?=
 =?us-ascii?Q?1TL/oIKwm2fMyt+JH5pWbY0kWUA9tAbr+PPfr3lLzcnhKrMHp+xiLcK+EuDl?=
 =?us-ascii?Q?0c9R0md2qbWlsMBOSwcq4U+Y9+5PuGfWzsZtpNVN7N9rGxEHAVuvb3rgVfne?=
 =?us-ascii?Q?LNLVrblGH6kIlJh/r/P2gJ/csSTxAHLIbE5/bnDIlpQx6jUKlW6ynFxy2g3l?=
 =?us-ascii?Q?OfsOGtLG3OF2dw3Hj1lXaKWdsnzBjeVGbViSCZCSS+x6wq9r1ask0iVlwDIb?=
 =?us-ascii?Q?jSKzKgZqDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207968f6-c524-4406-e3ec-08de909fe95e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:09:22.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YY3lM5fpEskOLWtUBsnXMq89ihNnOPDZsygMtvspxxetU8Fbn8ugzmvqEGznFqFbwhPG+16GJCx+H2F3dGeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706

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
index b44563309d40..0078cd7bbf9e 100644
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
@@ -1911,6 +1931,8 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
+	pci_pwrctrl_power_off_devices(&pdev->dev);
+	pci_pwrctrl_destroy_devices(&pdev->dev);
 }
 
 static const struct imx_pcie_drvdata drvdata[] = {
-- 
2.37.1

