Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C02D73A0;
	Thu, 18 Jun 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777345; cv=fail; b=sNqUDDIiNBiXV7hoIGQAJw2gIl3TjsIBzcGkWRSiBLRMyCGBYO4xAjLGkomYQZ54j9njxvuEvtgy4z24CYrVx6DTWe9LSR3L3BDk9SJlXLZJwVQ+1Qu8+2R4nCqOaWOUbcRuceaIt4HY4shKe57MIkA4HEobphxBpQf1gI+4C+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777345; c=relaxed/simple;
	bh=HSD/Yd0rBpwB/TgGMTwFHCxHtg1pDTWphys2J6mhyaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hL5fWxjCjY3mCPxitkGunqc/TKmHJLP00y8RHoifjwUJuX0jUeIkPrKgGcge/L/RvNtPxH6pS6SqKytWFiAAsASaoIlIaif0ItL+kDAAAEsNDgXq8FWdYfSrtnlgzhJ/iJ0sXfj/zWR1hpnjli1Noie02bmsAFVcbMMl8M6arvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rVd8+Dzt; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rVd8+Dzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+m0iRlY8NwUmgR+zJFWUfdZ/5vb7Fg7naaUS2KMJYcAQMKRE+zZZ676UCLNU3uGsI3HCGwxEZ2vw6UzxMc30GXDNoY9z0dT2eqnCuyDYIPFoxPRTnm2IqPFJaa+0J2fNMHmasMucUICfe0XuDztKz7X6+KJcVFZTorIxKtNNuPKXP+shpS28dWYVLmFQUH+voFQ0vXxJbK28TWrtkXg+pGefS64irLwRqFSK//eCFQJkRUR/P7U9bh6Plq4tFAnKzcMw3mVyeeHFdugd0fCA9CU6GyzJ2AfHYJFN7RbBCM5ocvO/7TdpxGjELUD2ZneNvvXf8XhbVgcG+pkZ49K6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bonga5nGOSnk6oVAeV5dOm5hCybUOic9V5R0TatzMho=;
 b=IcXnDLUoSCnx2JFstXtdrtTzYN238NXdqqBYf19/XSi1840zfewcO3oucu518Kt36zViEBPY6aexx+x+76UlS8VO5E2ckghtWzsSWxgG6FHMNnKeDgu71kfOahiZU1XszgZeKHKfvXFk1OLRi7mvi8hC3AGt110M2+xxSnou9RA/A1a5eRmSyUzVJr0cud1DDE6S57mae0aF1xU7yx5GEInylPlJxQdLsRuxGzGBs0pxgd9Zf5HV8cnQ5hJNL+p1sDwzWo/16ui/ht5yzePlhPmQLdekVpmhiH+y7U7aEZSQQYBnieR+ryR9Vl6prrWC/s8xNUNz0wmVrtP5566ckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bonga5nGOSnk6oVAeV5dOm5hCybUOic9V5R0TatzMho=;
 b=rVd8+DztmvlpzK+EfsP3NiJip18uYb2HZt8jNvY1qraK/WuqkG0pvpv7zgkRWmCO7zOfb2Quyo2rM8rh5zOlIQ/9C5OKehgO5wqfWsZr7LRtXNv3A1xFXykAynN7J2bzR+Sh//TL3OU281NruzLAN8500Xl1v8290QVxPPSDMURsalb35F9uXUvSkqkMfxPmngIvnmAYs2T89615UEkA79H6V77vJHgD+4scc5zd+FS4eErBn2bSKFhzz297OBuTz0GTzFn6459n9+55HCNQCa6/qHJomXA1Q75LWg0SMKVfIqTfk2jSNkhTfi/5yGklSG5AjweapJvAr+VqEr1mqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:09:00 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:00 +0000
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
Subject: [PATCH 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Date: Thu, 18 Jun 2026 18:10:40 +0800
Message-ID: <20260618101047.4185497-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: a773031a-c66f-4a81-7fc8-08decd219dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	abw03xhC4WZuywmSThIQkmsVTTN2UTtJVgPUW3iXL2uMXR8nM+hDlg+LbjroE4aHnz2uCePzsBHq7u4Qmsg72vX+kPc5qLirGaRLIkpS/18/iFPsKl9gM68NCU/R5X9/KPDEUkb9Ukz0jgWgbcWUHvs3o+ehggdyZ2MGMnwS/8awdPmngSdd5iYLWB5wfzvRb58ETWApwGQGlOmJodOIEzilQtZR8Rv476hQr3n4XT+iECj/NuECsP1UvWtQYe3/RNPTarH5mTA9ujsnZVzFHuhsG1AYAJChSgwu57dUPbnFtkFqQ7ScXTSRUuSDjalDbfWV1hgFsoSq1honlnwlybiVLrKfKBbN2y9bHxMrk3BuCpK7lesxAcQz4iMKqkSCdS/xdmGbnZuluQRqu3cm+v1Iz/DeyQKhYdR+gp+fIZU7je5weX5QVzFDRip3K3NoVBudBNY1M23GgppZ0sFJOALT89CuMiWn7Wsg0Y8FWX813UCV+sYpzo9TGDMEEgKBb7VUPU10G9v6ziNke5GFDBjrkxPzaNCkB59filGcyfg4smzwC1rP+eD0g82rZZVHaQHz4Rmq8r0etKM+XHxlVZDSLsSyxsfnjBx81Bb098V18J2NaYk7gTdqDk0pus4hcfXfzhuX+ShMHk3HLFOsGRLyOm3MNBST/rRxrm/1EozuxrGV0L/trT5nG1Ktylr4E7fKkNDAgw3tyyWaSks+DxzXfM2yI/q7VXrM5bI4kKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IXacJ4RYlo/Oky2WLsEbm8KvJT1zvJGVeVmuaUWWs3VKsnUh/AIUseDFDpm?=
 =?us-ascii?Q?IjCK0lHadjCfRJPUNSnOEQJln5Cr7j2Pi6xjhXuKrHYAteNdp6acPuwEJXLv?=
 =?us-ascii?Q?Lgal/ZPcBkIJq8H2G4CKhHPKsBjW2ChlAi98hCwAGuUClpVOjgi7bPdjEYed?=
 =?us-ascii?Q?jBt1un/NBFRFXPrxH8590qJN4Gpj4ukyMZFVMY8GJkFpCZDOdgKjki1Ov9p6?=
 =?us-ascii?Q?z7I2I9yjk9OlqKu+IZH5seIlqbg93XmKTDXt9brguMQT6zcPpTlvm15YyBWQ?=
 =?us-ascii?Q?IjSz5Laok5gPsC6xmHcSexDUW7LrGwtuaPd/HDe4UR+PnrY9f5f7Ry+KWUE1?=
 =?us-ascii?Q?nAihsgob4JowtRksDWJe58J8hBUK25I9RzTJ6zoO0UDRLi84DWyC7QfIalP/?=
 =?us-ascii?Q?1LuwrOFb8lEHWHyV58cwprskmqM1MYf4Xm5R/ZQB+iiGEQ5J7Npox6FqlaLE?=
 =?us-ascii?Q?TLx/4PvhsN11qGAFBjyJVs+BOFWlaR7tP4bKqP0W+6trOv1HpLlC98dntDYO?=
 =?us-ascii?Q?cCeTAG3Mr/G76kENMqbnk8j6NaMUlzHWHKV4biIE642Y0jzH89qmneTe18IU?=
 =?us-ascii?Q?ePHcqhoSm08FTi8l123/DwWQI9MYvHN6YW6UGdwe7CVr0mJSa+LYYKvVL1rZ?=
 =?us-ascii?Q?NVC6GgZSvqfBvy1p9WYxJ5Pb0ZhCEwC+hXRxG6xBnbBKXrikGrA24fJHcO8Y?=
 =?us-ascii?Q?NGygyicwZ4EsUH+vkTmz/Hp5G8OuRaXOX9WGtQNlwZvwOWxNJgyWAnOKck1D?=
 =?us-ascii?Q?ymx3fMvJA9oqloQqTyGeyub58/OOxzbYgsVTv+nXTUTO22ohvyUCoB+kCvRP?=
 =?us-ascii?Q?LB+DHhhuPxCWdjZ4OE/DOKRcFL86hpVhMenAcOIiAHdl9dwQVwi060zyTLmo?=
 =?us-ascii?Q?l+vaC3tH+y2doMT1r7SK39b19g4XwfqDOVXSPxHNqAa5ljgpNWmATjUV3HS/?=
 =?us-ascii?Q?B9wyfWesLO5AWL2FMb+6kzTBxrFmpYO54obxvcLM1szIZ0etSEkqmKEJ43z2?=
 =?us-ascii?Q?gDFrzOz1jmv6Nb+RK/ML/xT9uxF4bD8vPUyWfVIpgxnZU1VCs9Pr7tDyjWlw?=
 =?us-ascii?Q?4xt/wcWwwk9reNbwBnfjw46yR/n7nEdH/K0nbA+Ofk1Eqy88/KPvnHM6V3fb?=
 =?us-ascii?Q?Bp4M79sw/QHehMdkX7SMnrctrSeOC5MHhviDUMcYVjB+GZf1kg/4lIko5NGf?=
 =?us-ascii?Q?J+98rEmelxMIeDO160r+R1rvOYm2z1mI3YlZQxERfI8Hsn9c+JsQrmGv5wue?=
 =?us-ascii?Q?a3AqwQ/YJ8EQXlPVcrQUefTMWODdYOMzb5XN0uU7xM1OkYYSt3mEOhB0gTUO?=
 =?us-ascii?Q?QKHwF2exhc/KolMlrcZ2Ar4Xx0viO2amcgmO6cXJmaaJjStcaBFSRso+KOZO?=
 =?us-ascii?Q?ye33TVfg1CwltOtwQDJNSkIrV8K0kEablnfr4PKJV1L6jECwwcnw/+fQFjph?=
 =?us-ascii?Q?0lmD8UBuQZFyyTcsfseydif8N+wNwWd9ub/dY4ptG2KujKjU1TPHqq3TMtx1?=
 =?us-ascii?Q?DDPMkkvYSZMcfGMJnTGI+Fko5NEz44XB6oDxXHvRRECosek8ngRtMFvFpJqN?=
 =?us-ascii?Q?HRgzpux6YrCR/CFtVo6UB8ZTn6bjkap5/xFKD5hZblkkvB2d7EHp2OBDaH9/?=
 =?us-ascii?Q?1/8+LZSopU1JXWaDKUhqC3AiGzWnjjTHz6fRQS4kmSCJ65TCPSCDi/FbB92l?=
 =?us-ascii?Q?n8xOWnZvMu3L2R5eUqu7C8dy+UI95RnqDjwwKqWgP/dYf/gj+h5tF1Bgrm6e?=
 =?us-ascii?Q?YKomSs/c4oOWfqbpBE/uS8hlWbZgUgHmcr2j18UOxlH9s3nBz9Ql?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a773031a-c66f-4a81-7fc8-08decd219dc9
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:00.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCTiJfDGe82pA2z4PUS9uymk2ir/HHF4mq9a6BhYd7fyjXtj1xHBGnBwNmOupNz4YZL11Owcy4EWReQm4HQkg4VvK0PZRBPlVoRES483aZm1kesDY3323b2rJZCyARRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905

From: Sherry Sun <sherry.sun@nxp.com>

Use dw_pcie::skip_pwrctrl_off to avoid powering off devices during suspend
to preserve wakeup capability of the devices and also not to power on the
devices in the init path.
This allows controller power-off to be skipped when some devices(e.g. M.2
cards key E without auxiliary power) required to support PCIe L2 link state
and wake-up mechanisms.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0fa716d1ed75..ff5a9565dbbf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1382,16 +1382,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = pci_pwrctrl_create_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to create pwrctrl devices\n");
-		goto err_reg_disable;
+	if (!pci->suspended) {
+		ret = pci_pwrctrl_create_devices(dev);
+		if (ret) {
+			dev_err(dev, "failed to create pwrctrl devices\n");
+			goto err_reg_disable;
+		}
 	}
 
-	ret = pci_pwrctrl_power_on_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to power on pwrctrl devices\n");
-		goto err_pwrctrl_destroy;
+	if (!pp->skip_pwrctrl_off) {
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on pwrctrl devices\n");
+			goto err_pwrctrl_destroy;
+		}
 	}
 
 	ret = imx_pcie_clk_enable(imx_pcie);
@@ -1460,9 +1464,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
 err_pwrctrl_power_off:
-	pci_pwrctrl_power_off_devices(dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(dev);
 err_pwrctrl_destroy:
-	if (ret != -EPROBE_DEFER)
+	if (ret != -EPROBE_DEFER && !pci->suspended)
 		pci_pwrctrl_destroy_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
@@ -1482,7 +1487,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pci->pp.skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
@@ -1990,12 +1996,16 @@ static int imx_pcie_probe(struct platform_device *pdev)
 static void imx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
-	pci_pwrctrl_power_off_devices(&pdev->dev);
-	pci_pwrctrl_destroy_devices(&pdev->dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(&pdev->dev);
+	if (!pci->suspended)
+		pci_pwrctrl_destroy_devices(&pdev->dev);
 }
 
 static const struct imx_pcie_drvdata drvdata[] = {
-- 
2.50.1

