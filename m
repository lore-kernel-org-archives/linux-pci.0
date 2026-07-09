Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14C40E8E8;
	Thu,  9 Jul 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592025; cv=fail; b=ihF+kmfiptfyCXT9Dib3/dGByr21FfleDQlanwUZ6Gp9MCYrCkwRkKD1MVbvDzvm4bbxn1Awh8828WAKRYxJ5JxapiXNDKxps/YnZ9EcOOxX9yGtawV+ytkZz3Rvisu6aN9s8bsS6m5VsMgn3k1JXcCTITXYqSDkpTOTc8BS7c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592025; c=relaxed/simple;
	bh=fxyDAFM05WqYeaVVxc3XfpUZcmTAoNl0kE5u19OPGTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b83F6OzpF8oyZ9BWQfGFGxIDBtbX6QYjS4PEIkbzeVhxUA0i+qoufD5mv9JO1+3q4fJra267MKg0b7HqBXI8z+IbULdOFp+ko+6BBVaXuKSFumCW4ztC49lqvU+eaq8JVQkG63qAOJbS163Lam76ETqXqMunavLwVVFFdRVz6Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UeR507X0; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UeR507X0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzmXG0Syvz6FaJMNblaBIizvnuzhNzYt1g4fQhNmOFvbhxG6FD+wTUtSTq0rIk5GUqmN4hfLJf+nDht7IHE7x4EFiEhPqKnS82uqNF6EA64VySX3m+APVDpSGvGkuV9EYHixdupCRi9TcIAFpHN86tMc6AfJLKRTBluVf38Vyxqjlt5bck3Rvy56CVq3wGZpMgqFaaaH62zel975HJ0ICz2OlQkF/OR7t0Rl42uxtEbNwjvxQ9QxVhM4lDrMYHej5pEW+xhBgPg+Y0tMIUzsx8BDxMpA7JREHn57BEFPFx3URoyw6+7kg/0eNPJ7KJOsYxm3rqSNIiXhV4JEPDiBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VYUZCknGQPyzPzWOjlsHj21SaXcAzRWG2AoaIGwkLc=;
 b=zTkYlNUuAU7NIFvyFJmpKKGvDL8HyLF0mqHhBRNstaH85p8ONEVQvHhO8VCjxDq4+pzKMM2gBlVGACSYf2Q9ZWAybltwSURC4nb72abFRpOf3DCS3v9La9gW2H+OUZXLYZHn1vW0qAG8ayuqvLfr/qC+D+kOPd5QBlqVa1rSIA7peqSp+qdrcq4L4lysz1egfIyjqTGkDTX2I8g41wGfGR8/5JeYQ9+jhFCWQTZbRORa7GOOCyNgcwGjZNC1aUAnjlrPLbueSWDY3BtDmcBXU90P6ozxnBjP1xFSEu/6NVQCQOzzyRTR/IP8B35qQ1IGB61gPIGZdw01nUx+P9zQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VYUZCknGQPyzPzWOjlsHj21SaXcAzRWG2AoaIGwkLc=;
 b=UeR507X0e+5EZoLmM4A6ZMrg0O9/GpgIhhUjdh0zkviZHvgoN8YXpePmb6l3QgW/19EMP6WArZENcJb0CNvgM8x4wEtWh5Kl1Ly9pTcJNchC5+czNoaLSdyeM2YSXeotRhqGH+RLoHI24fBv4wam8Wfarj8pMmAlKhmQOkAqoo9+J9xwszrkJ84wqasyjOIhX5ei7F6Fxb5gOcE8i7Ckwgnm0ItdTbnUvNuFwoIDd6Oy8Na1GlKPIMyYvGiCuLrhhJwl7x3lK7EM9H0efelMg0FA0mngxmB/q4nkJJ1Gotb3Kb7602n0Y8ovCFV0CEl3R8AeyP/7T6fMwSVz/erLSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 10:13:40 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:13:40 +0000
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
	sherry.sun@nxp.com
Subject: [PATCH V5 1/4] PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
Date: Thu,  9 Jul 2026 18:15:52 +0800
Message-ID: <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 6814f692-a261-4acf-ee62-08dedda2bf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|19092799006|23010399003|5023799004|56012099006|11063799006|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	GnscZLKwdELCwHbT5GfQTMEcvuMfihtmA6vrXM58f9W++baExrwwQjvEZJqIx6g257zHy6RY79S9W6QFD7FHREM20vfSoSfnfz36xx0NLoGzi9X2BVe+8JXt6Gp+y+MQKpppGEoFhsPYijGgX3grMFVd7Do7dqTyb5QZbntkV3qquuypzCtOwaZMp8iKrIpNz/sIoG7vpYKKUSyodDef+SEVnpXHGzsXDzfmADqKiFWUhz9Pyczkflpq/iAiu5Zqskq2Gx8YSCjGXRrndqpDwoTAScOopd+RIWb9vBRo/EQoZDo8Fblk7b0f+cS00fLLbcbqMxKI8A7M5dr6hAxLubCVJmz1GKHFqrePyBh1QWd5e6ZqKrjY8dudrCsamzom6HJu9Q4lFezHO5rKiOXPdTJJte7xu6VXIuLZ6/8owIIe8JXVx+DL4Lto4Xa/E0FIrHnCBxOV4/KPyq0isYHtBQdlk1dZuE4+hdfEF7DYYQGVplCG0rKpLYDdDS896BzZOWGsHtK7vfU1UpdrxIvCZiHlfbgE4rsVAfYeyGqRtSjnCDbuEB9cB6hLbtte/6jlDDgU/7r0rvwHE+6Xnsp2rGuK5M//Hmscs66WEYYyNINefpCl4QL+cCV2xvAs5bv++02hzrzY4aD2ccdea5lCjUXu+dfu3iEMeQ2pgNJdkb2cyWdz+bQ8gCQ64AgeyP1E0Hrxr1TP2D9ypj8oYScd1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(19092799006)(23010399003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qG76HKwAQoUQRMpE6mRYnEFdSmdZvyXBz54c4qKLEAmwsicrcM9mykftdYAK?=
 =?us-ascii?Q?oJk39OxcQHNEGpjKv3m/Ba9vdpYxhIgSWzUCSfPF33NqfnWiHLsG8BRVawiO?=
 =?us-ascii?Q?2Kpnr81WBvtXihTLon11FpWgijddUkZHKUUe4/AY0Rj456wMq/bvG4+22AlW?=
 =?us-ascii?Q?VXqjj9Yr9tv8RFFF3c/aJFl4Z9edqB5JR+qk+QR0uLJk7lRpeJEmTE32qLhg?=
 =?us-ascii?Q?gnJCLXuHTwlDlqLcA+kvkcgmOQSlvq6Sz/cu8bFN5NSCDNeQtFVj7c3YWN6q?=
 =?us-ascii?Q?shsQMRtqdGUCBFPOt3gwZtushTyVv6iS3AnWjdni2x3eR1azyLLz+jB9zAgj?=
 =?us-ascii?Q?KXTgb2fxD5UrP3jLK82kHjGc6U3aopBY91cJh7iyYmiyvbCnhBoPvJgOYZ8m?=
 =?us-ascii?Q?TYOWPVZUQDlloy8oOw1tjwNBKLaRrViRBhuPVpgKazpo6NaZaxVB27aHh7KH?=
 =?us-ascii?Q?yld7JsYN5K0PFi+bDrRCH0awEpN3Cmn5eak1W+NJyE2xtU2vHSQ+FVas0kJz?=
 =?us-ascii?Q?7CT/1j7OnPdjdj1OkivG09lNuUJUBBVtnw5hZ8w6fao1K+0lflpClhLLxCC4?=
 =?us-ascii?Q?nU1wN3WBEXmQMyhCs8Q014Y91Nn5HUgY1ief9UARFasOkwa/2GOfhY3VuFFt?=
 =?us-ascii?Q?3Jj7NM+r8kH1OaTjVvo1cNtuJvluzC4PWy4+5b9Tf8tKUerovE1ca81hG0mp?=
 =?us-ascii?Q?l/g3DqT/GMObFJnWITT3ZIDGrj4zrZnCS0BjTlsrDJKzvv0zzk9sQ4HE/ctw?=
 =?us-ascii?Q?PCNQ18OdgisPWkChDOJnS9dIu6/dSeH4eZD676dYq4FzaMwA/GqtvJbeaHpc?=
 =?us-ascii?Q?8GJuA689B8hzkqpwCwJ0VN2FXX+ywoB2LlUddLhgQpr+gB0zORgzVdAVrIvw?=
 =?us-ascii?Q?Axk3vLDdwQTUhFImUPhiA1lXuzyFPlJIAfKkI2oJi9o+kno4US5OeINKd1My?=
 =?us-ascii?Q?i9J4dK5OvBiDQOwCtrCWTCsZc2tpgGHScvOASw/EM3FB0qODiRB39ohftrBP?=
 =?us-ascii?Q?v30CGua1N7LldXJiovh8VRG/Imj+W5GWNc1eDnJv6SEZSSK8ZzSMEbpVxoJw?=
 =?us-ascii?Q?5DDGb3oJ0YwN2YBkeaumi4lgLqJ9hVSSc9S6jREmSE+ewEUSRywbKrbSG5Qa?=
 =?us-ascii?Q?o4/EOHrvAvnTFzrM0XdOZJpovYLpiw8VsQbRO17foaDasFcXbKm8tpw+PuXr?=
 =?us-ascii?Q?1b+RmcZ+HgQhYa9n/+O5M/4YEDqBSQYqY2IqUODBL0Wt7W8gMg/vU9p3agXX?=
 =?us-ascii?Q?WQp3qJ2CQHJ1UjihMymYDhgliJEGojGD+89dEFB8+gGnW0MeJAzIoGbv274N?=
 =?us-ascii?Q?zjYeBVx/CMmoXdC0FrL4aWNiXl8GJekKRT8wc9YL5pQfq3eV0Xi1HZTq95PA?=
 =?us-ascii?Q?84KIiZly3qcnxQ64DLqhq31t6mVaQbb/BAwxyHFHPsU0aTyFuV2tPWl/htoM?=
 =?us-ascii?Q?xk7bQggq66KWo9NVHtPJTxr13/blvPtEVEcS/gu2//+PNlC8OR2SEkPZegmV?=
 =?us-ascii?Q?77woP7p9h8ZTIg33DkpLfRwpxlKzrgMBLanFb+9Gp04h5ocwpUTZoSaHpGxi?=
 =?us-ascii?Q?h9eoc0qjwRpVSyqwLm/EkSbVFD9KHJblsU9cRB6vlI7Q8D1nZucpzHC8WXmk?=
 =?us-ascii?Q?PljUTfiR6RlqhCeat1Vxi+tRRyuz3TLMVnrpBodT5Wdjxqs1NcNVmPuyPBiH?=
 =?us-ascii?Q?fl3c0fJxxVHCpbO34O5LxZqrM9ZU+xeovc+aFLyREEXL/So7ts3qCifvAzD4?=
 =?us-ascii?Q?VfShZh5B/MvQhfOzKezE2jzKrwtWXkNR0yLhhjNSjIdlNNoSgniV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6814f692-a261-4acf-ee62-08dedda2bf67
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:13:40.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFAxtbo5VFjWJWGI6FFEaev7H1NHJxT3RmZjlAD0DtFSK52Pc1+WSgE7M6Gg0ThxVbxE0p0MevXRXgDj/fQkeun7WNQbF9h2mCU0UB3s2PaXaX5qNI1PZHsrtHpbUvX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

From: Sherry Sun <sherry.sun@nxp.com>

Previously, pci_pwrctrl_create_devices() was placed in
imx_pcie_host_init(), which is the .init callback of dw_pcie_host_ops.
This callback is invoked not only during probe, but also during resume.

This caused pci_pwrctrl_create_devices() to be called multiple
times across suspend/resume cycles, which is unnecessary since the
pwrctrl devices only need to be created once.

Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is only
called once during probe, similar to other regulator_get calls.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f55a68f60eea..92f8e4a299e8 100644
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

