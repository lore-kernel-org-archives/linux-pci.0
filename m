Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921123F7AAD;
	Tue, 30 Jun 2026 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815430; cv=fail; b=X6tWcVcY3lyNH8W4bWp/jAMKc4t8462nvw1PDY306w6Bwaxbh0y82OAb1LWz+uiG0Fnkw9AHtQyQ06E8Oeb64OmjPuKgfFiAAWwqFiY7m5prKeTPSqr5mOujrr/WvbSZq/Jchu7VWhskYFvFpTZxt+oIBp3PVHzC4mk/tiWb3eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815430; c=relaxed/simple;
	bh=Tm0lXtUfHZODJb39qn8LJjmPPDlwe9NGTxQFxZcEjMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0t/UT3jATCnsAEaycIy+JyfO3sWPHem7jOUJFmaYgvX8WDRHJBm8jwn8ZhWEpi4W1bQ2XfqsjW8vTQQ2sl57opOJ/os2KQdomDvQUe4fO6U6v2kYjs3wvnHDJ0OXiQ2rA3owapXjbb+3nf8wW3CVmxm50VKm4013aX12f6VsQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sRsOivqa; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sRsOivqa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtIht0yepyoPjMi/G9pe2PxKtt8HNNrcMtpUBYzQBsYsimG4EOVuPh2u6ad9guhKJ0mNzHQRXLmYEOmOZEBFtjxTw+YZZOOwJsbabAsYxOSj2WceX8fFi1WlW+CJaD4QG60dwH2UmuDZiLEj4qcAYsye74qABkwv1M3oGZF/ZvQl234suu12qhtEkx/r0KzvgWsOASzb6D8c62hsZyBvIanYInzKNIBkMiBtJp46lDdk0i006hhLQr59b+ASqXM1zneZYk7HpsthLMDyF4e8yScPB8cCnKj8CHwv1pEXRIsAU40qY5q3m+wF0TBZIwFHepkuQAIf0GYYxW+YhY/pMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTd3fzJNvyyEJentkuvQiu+sl5aICa74kxz/+rZZSbc=;
 b=i7FTXFc5ZR3tJRvGYVJB/c/lzQCz/RQ96kEB6uIRrxeAttcEYXAd3Yd8SWaRoaRbhYve7WNltj1HXtS3S+ozlv8NWIm9dGwZtFiN3TpQt2E6kx/AqCgwHkXnFe3uIfAoksCDJaR3FeyeeUk98EwoB5HOfG4jfxqAqPHXQw6S8scghXKncCvAWg9PZER/8hPGdi3FOTI6Xazz184THObh6iTUTE1YC2dMHtMkMLKgLYJGkTm01TQjyjGPMSvA4rY9Gnxau3pXuPt2dHNGKxZWxTdXJo9K2PlVUu/wWESVd+AjUg9iarDKzQR2x6iLZW9JPnFPo4+NfFSBv9GVo+z9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTd3fzJNvyyEJentkuvQiu+sl5aICa74kxz/+rZZSbc=;
 b=sRsOivqa+RWwOMgHreTctdbm9/2Qn2hf72KAziO1Y6D82/ynByfW4/CDjQt2xL52VKggTUb3P+O+6LIvdDUd5Og2FPTarqr0mJCDZ16qU/lEfUJ9z+pm9C7EdqUNT6tyJxxOTuVUQaTAFY6e7HcXJAxXT2sv9fx7K3QVvMjZjeOq4yjvFyfk+xrqEVYYAygnvb7nbGK2XuU+S2F8aT2T1ZCM2NSLqi5rtvpKehcDQYQNk30SblmO1uVPORiKiZDrYWtXPSPLTVjfT4lhCcXi48zPBt6aHfc9gjPiC6HuqlYFE8clq9DfKs+oXIgVqJCVoPEkp67jXEiiLaPcV2geKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS8PR04MB8547.eurprd04.prod.outlook.com (2603:10a6:20b:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:24 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:24 +0000
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
Subject: [PATCH V4 1/8] PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
Date: Tue, 30 Jun 2026 18:31:32 +0800
Message-ID: <20260630103139.3823329-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0243.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS8PR04MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: be6c1ac6-6de3-43ed-c841-08ded69297ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	p+Rv53S8fI8edB9dtePBsD1dKaIDD0yzUlcNpZZTOVINJNKRSsDqeYGrGcUDbyYAvYj6koyJu4yUgdZ0NaUDFuv4sepP8/9ufX4+7L5MvocaQ0jL+UHyEjdOxUO8Dcld+sgtopLphCGPpqBEUwY+zWjY5p30MNvcBEDUr8uPys65NiqYfFTu7bg7O8KBzx69LUxRSfUc0g01e11ju28QwpeH8fy6ZjtbbZ/33jJ6i3xC/3724kiOvWrNlyx65T2aI2FM6GlYP+ium5ReUvxB2/RFUOcl/POw8LcmwRYwa72FROD2tbyupoV3DZG0Cp+w0F/bQN2pUy0hvejB/xipn/D/abrCZa2ocFClVktv1hIjdiVxJCAjK0vSbgixVOXvFIE175kFJ4Lx2DKcW+6Hb0EaXun9SfE114bQB2y3JRpeinFkZY37emPrl7vpCuzCI511mAAAEZBvtR+NOJf5I5FZDEEg1gB0WqjRItpMcxolpjjxhUjKdNrxWrK9BKC4SrhkMaz5SXuX3L4jpQ0DJ6CW7vFUbCyS5mPpMLT4jbv+d7s7w7SN1062BOjz0sIGtakGs20fhsCwvL7gHiDzUE0DIioq0uM/NnoUozK+p7z1CL+2AYhkstxb4yEpOiV1yqrAPhFnQL5kTjlvSPPlYndMhaV0TFtL6I4T6ia2pduhODCTnPyDxvtmsoOkckYHVQSlm+QDSfCKPMyt+MC4ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lX7KePglqrieo+NjDSuUJ1V70K+qaeSkEAU/8TsDVNAm+SUCkMsCkiNYxToA?=
 =?us-ascii?Q?vk9DlzkHbyZwQowWcITb1U+27LS+XSJC7LFtj2UKw1dgNkaZWxPMZS2B7ZpV?=
 =?us-ascii?Q?Py7xRKWWVwMx91LbkYZP/lTdpW8/JtCj/wL8kT14BSznK5ddI6G+/fOFFZ7d?=
 =?us-ascii?Q?sev77SzGyFqBJjHrVXiEFOnVSpilCfsRzZXEQksCr9qVg+yFdp4fYJzF7kwT?=
 =?us-ascii?Q?OoIO0RF8CcLTOW97E5/Jn31qaf6CLK4U6PLgb3yVjVo71RNDtSmLD4uUY0Du?=
 =?us-ascii?Q?cHfrAb5pfwKoOL37qtQ0zMn3xg4gmYCzECt34OIvqeChDQKkIYxRiKwCRoH9?=
 =?us-ascii?Q?B5H6NC+w6sfWTHSKhcqOUwtplJdIlBvECgGuhF9/kJbmIkJ0Ts08G2/gLnBh?=
 =?us-ascii?Q?nqrM4Jd6zWPDxiC/yDz/2HrQfCQFSx/LWS6f6GJf/T+OXMwIo931UPjD8yyA?=
 =?us-ascii?Q?QH3YI2cbLCFhAL8/G6AsRabu93LSTsGjS+VVhJDJ5/WBdiOioaxX+v0puLIl?=
 =?us-ascii?Q?auj/99LCM6EnqTDGAzAeqeGY+09EBEk6YrvN7fmMrA0lEB0HJDagCPGaHBKv?=
 =?us-ascii?Q?ktLl4aioQAaVLTopqbb67sx7faDgHDENdC1tpaWAP1TPzm/5j7ciyhR6Hixl?=
 =?us-ascii?Q?vXsexcsufOLFknfLv/BOgoRJJ7ONisNeors3N+nxVDydfeGpZcWQK1S80JkD?=
 =?us-ascii?Q?J0COcx6BLGewV8X3tbB5SsGhncI9C+Gwy0oWzfIHkrtb84AlTZqxexrOH5/t?=
 =?us-ascii?Q?7/Yl6Ozo+foI5nRvXsOuyBP7aebNiW5tEiqyPcwxdw6o0YuliG/lgBPXbgsI?=
 =?us-ascii?Q?/9U1dc3mJZ96ObxWgL3CrEqCi0Ane5tgxkccDiKMRS+PQl+JIFNNG9iBhlxl?=
 =?us-ascii?Q?sqNKIyL4GA4cK+67MtAbvNELVxH4RzEG9sJWWEkgVu76RJSercao//iTrf5d?=
 =?us-ascii?Q?a8JqhpCAcL6axUP3vwPRQ18RSs3sFPVKsDq8dVfp6N8fuN+FyURGZqcHWPeV?=
 =?us-ascii?Q?R1LOTIqTr3b0esOw/0RcrBF+ZF7Qx9PmFZbOC1bZHO9o886ecuMSuUA/8Kkf?=
 =?us-ascii?Q?dzszhtqDDLiXAIQTIyH/w6BDJuRQmr8z3H0KpRQzU/XabxE1JAsRLHBMyc++?=
 =?us-ascii?Q?V8UaIbTezV376lwfUPwq5QKXpjNHyXrB1I+DLjJGAxDBgZMsHZMMs9Unfu+T?=
 =?us-ascii?Q?8357E0UcJjQxKx7dLBxqdu6my42sG+D95givzXslUIkVXuDsUd+zMmVaQqzP?=
 =?us-ascii?Q?CKKZUbu7hyVQoPzqLPZbZi2fAPD/QYgeiQs4ZXwSGWETLhIAUt+tTx8oUUPM?=
 =?us-ascii?Q?nl1S6ynaNDpitZ1x0NaRNPFOYDLwsGB+idg3NOiQ5a3wU6u4X8G5J62rAGik?=
 =?us-ascii?Q?PVgVmZCnPvDK3cODgr9C+lTpkh+o6RGoDu/X2yliUCXqzHVHgvjYKvKqB32a?=
 =?us-ascii?Q?E6vEH7mDaWt60wjcP+1b18Ei/Hbc65aScETxW83x5ybwQYa5V70WjfUJhYDi?=
 =?us-ascii?Q?ZkCZ6wZ9/+yNOrNztSat4KwsQhBbgTqIUJH1WY3eFSAbK1ztE/e2wzaSDRyG?=
 =?us-ascii?Q?MVojc7FrxtzMCW/7YXZ1R/AujaMtrdxjMLiTxcrTh25uvJbzgllpzDoPXsnk?=
 =?us-ascii?Q?+dFc+NcBii8mSefcQ8tMhUGAsznWoFYif7ChV7iOh34RcUme1L6zsnnMimbb?=
 =?us-ascii?Q?8ZlIUMbX3+/JBIR58wy+H4QkWePKaB7EvSvkQTj0CqpnAWq74eSD8PW0GlfL?=
 =?us-ascii?Q?IIdLYs4OAoQ8VvYYYu94qS/WPq08wx2kn3LgYNbHk8pEMBILAVXb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6c1ac6-6de3-43ed-c841-08ded69297ed
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:23.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agMsJ/MLMr9g/ymdD2j8tHCiLF4GMenu1Xg4BiHNJoG0IwW4DF1ZhUz6fBpUcMYyBdDVfZmKK1aMtoD9oJlm/Fi8byUyu0nHTqQ8lhZ9h/19zawEjZwGHr9ME6eWCroI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8547

From: Sherry Sun <sherry.sun@nxp.com>

Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is only
called once during probe, similar to other regulator_get calls.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0fa716d1ed75..1b535bb6fd31 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1382,16 +1382,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = pci_pwrctrl_create_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to create pwrctrl devices\n");
-		goto err_reg_disable;
-	}
-
 	ret = pci_pwrctrl_power_on_devices(dev);
 	if (ret) {
 		dev_err(dev, "failed to power on pwrctrl devices\n");
-		goto err_pwrctrl_destroy;
+		goto err_reg_disable;
 	}
 
 	ret = imx_pcie_clk_enable(imx_pcie);
@@ -1461,9 +1455,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	imx_pcie_clk_disable(imx_pcie);
 err_pwrctrl_power_off:
 	pci_pwrctrl_power_off_devices(dev);
-err_pwrctrl_destroy:
-	if (ret != -EPROBE_DEFER)
-		pci_pwrctrl_destroy_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
@@ -1954,11 +1945,15 @@ static int imx_pcie_probe(struct platform_device *pdev)
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
@@ -1973,7 +1968,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
-			return ret;
+			goto err_pwrctrl_destroy;
 
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
@@ -1985,6 +1980,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_pwrctrl_destroy:
+	if (ret != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(dev);
+	return ret;
 }
 
 static void imx_pcie_shutdown(struct platform_device *pdev)
-- 
2.50.1

