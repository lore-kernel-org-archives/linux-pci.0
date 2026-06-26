Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B419067C;
	Fri, 26 Jun 2026 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441038; cv=fail; b=ADI5+NpFE48ED4ryX1USyOvm9rQh4ZM7LD+4DHoNL4PrRb1qlYwRaEiuGU2e25JjyX20+7544pIy2GJzr2oPJPHsvKACEEV8JNtEYPouEr1nHIMb2HDUKz3V8k4yLgKsP4neLLcDUg6Yc2KBCxB1lEifoEXAst3IaaNNSAsTyIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441038; c=relaxed/simple;
	bh=vjJuAeQLqNg4d+CWvj0L8oWXG7t69hJVI225PgZlhos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldW2pnUqMc22ozZa3jILC+hc1WZg6wjPNVebS0XKV9zySJyw4moE/MaoJeLb/jDz0yxEuli9dXbhm0W9Y0qDRLMCIIr8gfUGL0hVrxenTc4JxzP70TAJXhy7faTCnVYW4+c+zvRpicjc4xwx8ivTwCT6mV3LoB3FM6RVI2orp0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NfkDaX8Y; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NfkDaX8Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZOQasjFf82+eqw7MLo6HzUpa1YGMm43kjjMStYPkHJy0rByRhEYuytbntnqLSfQW8qlBFphLTnGGBM4qrJcsI4OKVaVnsPjpfo5L1jFVfvfZLWHOFJ9jN/iKjiZ74l11AgpZWwZp0Sr4/5Qil3PfD34OW3/6RcASMiGwkOvoFQLmsIDkHqDvnuDc4VaGnShCldItjsSleGxBpKogmN2+asWMaA2iSuUpWhor8nqVuqgEjLojOxdfNpirzSpXXmAlOgzWzD9Q1QLP4W7/SwBS0/35UA6XcUPxqmi1maklJTKiqP9OXSq70exAndKxcw2dhdkdeYdd5uqYew34Xs/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv6+UF9gJXoTaU5qETOBu75skY22iCsqtP8j0CwjfdM=;
 b=HgUD6SBLdre6RiCfA615mWZ0GFUt3AlM5iQX8vN8ouX7QfuiWmLpcj0sGnGooH65LqoJKA/DxHs6Yc5GNZUuHEhPVz8GvjF0CSu/gAPTxmur1txrqbqWYPE02wkepDuTfFNkeTO73TX0NsHytUiDbuJDfN/FUUMyYeZCZrPueemlMya65ni66RR4Ym/MylpPUDlCbVbv7qWPT0VU1SaID+wUaW+pU/AJa+kB5yGrRpjsbybAbPc05OsqZC9wrOl8nEyMsnPhWH/i5qp+7GKXhAUj594bSsjc3+jeKSctYaUkiLvSir8kT0eHOrvpZUQGPD1b3o1EjFFQpl3Ue2V5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv6+UF9gJXoTaU5qETOBu75skY22iCsqtP8j0CwjfdM=;
 b=NfkDaX8Yl3SB2QlXg+VRLW24iC3vOCV3RI8szPw0eaw5eOLrmX0sR80u4+6OKk5/fFuoBFlHbEsCoIgz7MxUxBdhENxzGbCdSkSeUn/rO6kEpWchhqoNzkXfGIHv5jy7ld1vnBLyMYUjs8eJ6WNHTwsVzJj1rL5OPm5EOKKS6RN9Ru1RkKxbwIeMl/SXKsAIah6Xp7PU13hwiumTX7JodcbXtY89zlq1QL9NAQApGaSR7yIPkQ4nHNXVyt465csUnjXC3MR7CLdrz80E05nXClCE4FQ4f35AlKvsyAMXoRTMHYoxLY43/s+ajAvWJhetCw9xysoGmdJ/daI5dZsCpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:30:33 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:30:33 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Date: Fri, 26 Jun 2026 10:31:19 +0800
Message-ID: <20260626023126.2189931-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::10) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: d74fe3f3-7f19-4577-f699-08ded32ae5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	EBF6UIY+8SKLplOzdzABd4Fm2CWeGdLj5MrcxCyZ7wXHQmRt5Gb05V83hiKVSeRSFa5o6EObPNBp7CSpIgO+cudXi27+ewD5KivMzzmyYUGser95IR3D1hvQ08+Ria1SymtBA+h8f7p/KDPZphUym6Lii1Csu9CAF6753lUFCVBh3BS5dCT8XtaBRGKp7r/2Qi8br7VJ+pJlrqFCZrIxX9LYyJAYl5gdPBU4uEz4kf/UCmsnczF0lY3QX0e8EUhCrUlHVhV01K7WUQ5Y0+1GAzeaNHcRpnJ/9rk3X1yORPBPAidl5GKONLgsXHni2Hd8HiMUwrLuSt5NGKJbhSdFPo6Gy25/Mtu9lm/30rqjMzhnGFlmlPLEdX2IWIXpZUpfW0Wfe9HQ3HVq5JrdvnubQitU5df1tC08KGL3wz5XKdUpLTOeNy3TRmhKx83BX4xCXBpIJ2UN+jFQx81F2w7oSx0b3JepGNRZseoLnDJsru2yhW7KJLSPZvvJNTbkwyek5Kzk5MZsNfImFXT2TUTGiF/NZVsqXh6dd4DIALilj5GxTXIbRGM31sgJXFYq9pToSDwvfGw3DwGGV5qEe6VtnQos+xJ9c0RZ5uG8kzIn1syIKuuMh2Ffls8UfzdsvwlrL70Bvo0IFmWUWM34b1gGtYeuQ93R0YBlTorbeaEg6IOa2oEo7mAKpZBPfVrfwWM9ojZMLmuDxU77hhxP0LYj1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UFmac+8DORZ8GYa9kLPpWOocKaZAAfM2Kz2JxNEv294PLCYTEpGqHNP5kPq?=
 =?us-ascii?Q?c4gUdl3lCVnqb648ur4tp2JehEMzHTYUORsNdKup5PwShhHEzL5v408L5QoB?=
 =?us-ascii?Q?bG8P6WVVza9cSy6qxE9J39fVuwYUWCGMSWFhCEXY0e/f5JpHS+MkKUVqpdDs?=
 =?us-ascii?Q?e4ZzrX08D8S0bpPrTtiunVkQVCvK73xrTYDKmGU7yRni7pa558E5KW+1soe7?=
 =?us-ascii?Q?YnfzBRdgSl3/R27zqK+bRLlJINGeIPUrWdl3l1w35JP/4arPPUh8o0HTr/Wd?=
 =?us-ascii?Q?uRJqGe4waC2QOdyCOVM9jDqPVDOYmC+GG+rAW3TNalEJs3FNd5sy7g0lbMw3?=
 =?us-ascii?Q?PJRT6zXx/JqCI3RmlC2mRaOCF0QUrlN74k5giNbBDu/65RPQJLa4OFU01ojn?=
 =?us-ascii?Q?Iqn39pb4ObDuRKZ+hwKX64iqCTKin3iwyhR7esV871N/mwsxrVdxFnvsv1gl?=
 =?us-ascii?Q?13Qem3I09LBmzmr4Fra973pJ3ryxelaAOaf8ggZM27jRoNOsls1XqC587ylj?=
 =?us-ascii?Q?+t1Qlb1Zh7WrPWO+z7f2WEapu6VZX0hL9zxugMWGw5UtI7SAZGx8ESNo/xr5?=
 =?us-ascii?Q?VaxJx/uy1dNyUXOrU8kDLyv/RUAXiDbVWv4TXWuziT2rGyA4gZfNs/3TENJ5?=
 =?us-ascii?Q?+t2/TgQEMZHTo3IUX5oyoOzGnV1A7dmaJ6aRYY3oLnyTjEuD0Q5G+/HmqMVq?=
 =?us-ascii?Q?l3vzc2F3XeBvei/ONFVtUU8+qUWZMzl8bM/FhEpfp5zWduQruYXmKMHsDhrU?=
 =?us-ascii?Q?bI4D1gt9zH1yuREGmlPfT7qwL2dZuzZM3/rbom38VEvEfscuI639ecHgOH8n?=
 =?us-ascii?Q?0jopI0LuGKQmQdsjcvcmEF2pxcX696j4rW8YRAT37U9rl+CVo69+r6rU7+64?=
 =?us-ascii?Q?vJsJLC3gKz9TLdMfM+xvj++M3TtSQbC8fOiyA0aR60FoQzPjNGN0L8UEU/PD?=
 =?us-ascii?Q?Yb+9i2KIybT0V0KuijjIPjjCYgKsTeK6EgIDe2vFva9956+lFLC9IhV0U6Av?=
 =?us-ascii?Q?apN3OqRNM8YQ/gkKUz+KUgZus1t61BZPQJaehb0FS2VYFCSrgd6yDuoABiEh?=
 =?us-ascii?Q?ioEsLfeKrf4PBjeeqH+fX+htVuY03CesCEUSaCdHQ4le7DnVGNXLUIBW1aKA?=
 =?us-ascii?Q?hap1rpIY+3CBMS/ZZZMETBhxZuhtHXJfxkH2GDAkQR7NXWDra0gmF1eaX0AK?=
 =?us-ascii?Q?rewKayg4vdY7T6qwDpgvh8U1lj7lOP1+ffzqln/etSg4d95E3NcA6HzwdUcZ?=
 =?us-ascii?Q?4Pxyj67bWHtvfA8AnZ8C7vJpQHO1EzeVXyIz7Phq/iAoFQopQzrDRzpYs17D?=
 =?us-ascii?Q?vcE/2HXBh0PCVePnb6flOqY3RRxc17YrhjFkpn/xvSVJ/euHS2spegM5ssJm?=
 =?us-ascii?Q?Cq5EIgSN4RvTEsBCrYoxNUYqIxYitINkymZ5XV8X4HAaOVofG8vU/5+JEXTP?=
 =?us-ascii?Q?aPUDhxXJ5QalZeETkv1aaML5SX4zEr2fG9ozFkhFZiCyCfyOE3ei2UU1shXS?=
 =?us-ascii?Q?kFx7MwMeWnnu+Mj9L0HET0YvEiuBY3J50wYfrfnp5XdiCbADqUkeVuLaKSNq?=
 =?us-ascii?Q?1Os2W/fl/Vunz4TNMlFyD+pWLkf0iWEmdCCq3Xrq47eBlk0xroSyqdOKSQ7B?=
 =?us-ascii?Q?MbHHPtPG8VNIooovHuMtUQMNYaq1N1XHxHTZOylsAkRgdkBjp3xSo7P6X361?=
 =?us-ascii?Q?PNs+nzM5ePnnnvADCaQ+8q9/6ZtkwNsb9u0J/pMtIYMNKNGDNKXs8WmTQdUU?=
 =?us-ascii?Q?oIb4obF34HQrbD5koi0FY//eYi3Qk6Mx9ksKdTz5I77S9cmVdMfs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74fe3f3-7f19-4577-f699-08ded32ae5e5
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:30:33.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9eB+xHmRoq+mcUFwYJKWWi0lFzGMp/+eZUbkz1GnTXOMn3JjDJNU+4sy13m+sYNg6m/b2cugVbv4z9fh5fROThkvjryuDNHvasttz8UHNvhXFTVeb/TNISqjx5pwDUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

From: Sherry Sun <sherry.sun@nxp.com>

Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
suspend to preserve wakeup capability of the devices and also not to power
on the devices in the init path.
This allows controller power-off to be skipped when some devices(e.g. M.2
cards key E without auxiliary power) required to support PCIe L2 link state
and wake-up mechanisms.

Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is only
called once during probe, similar to other regulator_get calls.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 43 ++++++++++++++++-----------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0fa716d1ed75..0685573fee71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1382,16 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = pci_pwrctrl_create_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to create pwrctrl devices\n");
-		goto err_reg_disable;
-	}
-
-	ret = pci_pwrctrl_power_on_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to power on pwrctrl devices\n");
-		goto err_pwrctrl_destroy;
+	if (!pp->skip_pwrctrl_off) {
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on pwrctrl devices\n");
+			goto err_reg_disable;
+		}
 	}
 
 	ret = imx_pcie_clk_enable(imx_pcie);
@@ -1460,10 +1456,8 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
 err_pwrctrl_power_off:
-	pci_pwrctrl_power_off_devices(dev);
-err_pwrctrl_destroy:
-	if (ret != -EPROBE_DEFER)
-		pci_pwrctrl_destroy_devices(dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
@@ -1482,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pci->pp.skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
@@ -1954,11 +1949,15 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = pci_pwrctrl_create_devices(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
+
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
-			return ret;
+			goto err_pwrctrl_destroy;
 
 		/*
 		 * FIXME: Only single Device (EPF) is supported due to the
@@ -1973,7 +1972,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
-			return ret;
+			goto err_pwrctrl_destroy;
 
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
@@ -1985,16 +1984,24 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_pwrctrl_destroy:
+	if (ret != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(dev);
+	return ret;
 }
 
 static void imx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
-	pci_pwrctrl_power_off_devices(&pdev->dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(&pdev->dev);
 	pci_pwrctrl_destroy_devices(&pdev->dev);
 }
 
-- 
2.50.1

