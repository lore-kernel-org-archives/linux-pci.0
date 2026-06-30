Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D123F1ADD;
	Tue, 30 Jun 2026 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815437; cv=fail; b=lnseSwzIIVjwL0Ap25WHHbfCf88hA+d20eenoiRHD5bmC7PnvbMEyFOhJDW1t8PU0uvit7w5dWtYRwwykhp2fVGVNfMDfOssKw66dE/pkBrZTN8mIBlv1Is+v87aanoHb8VkGGfemSdllRYveQifiJt/sG0jYfQ7NIsKlUHMvpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815437; c=relaxed/simple;
	bh=BNW5zCNKjLVl/bMgv9tMUP29Rj+Pqt348K4k9JBz9ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDDEzFJNi/T6xV6fIcJ+24k2NeVIQp+ejo9o92SdU2aeWOpiaAoWjS8gXMZMsxeSWBXp5zA+0Vi7lKgYEMUzjdVCcG2k64Cr82jNBSNeFLBX8Oahg+O6nK70+SVnJwsjwDqCXlGHsPzqUvZEANMaqM5eIGH1RFBd+hSU0Lc+MR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NR2Lh2Wr; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NR2Lh2Wr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NheQpuPve+gRfIfH7MsklmzyDGNesHtbTHozhFd6W3fpG2oYxuI94pG8FIFe0b/BtTwiJofSQMrCrnu+AYahtCgqM0nFk1m7JE+P4oqcIjOg65lBOHaFaxPnMXxjriRV0jQC1UHAf9cfqXbweXpFCFbM2EIysVEr4YcdlUnGFvauRZUQZSZCDndOFlN1n0QYWA7wOxYN21iETOFtile1O6p62AMeW63oGX8Tet73aoZQzSnK/VfmiMnYkvH4pRm/xIfDLutq6puSoCkVfKje8dCYlPPdixqVR/5gIutbSfIaL0W8lWPM4xJdmHuV/8b5vB5qNMW3vk3wvK0qGI7vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZvKlYF7f2F4BWN+C0F9J2WFVy06WAhnj3yU4lfJgvg=;
 b=P53Jv2lMnaat8D/AIGpq7JracDVAGGQmPehqqUs3U882WVL/wjyhH2ZotRjhPq3fbyfbkZpspt8XwoNs6k8RtvPtzgc8WFDmvUZ87D5hPQmFW+PzizABlHPqNYLV0IGOCgxkynydn0qlM/ELRvVArr+hyTBLDZoIf2PukYlvieLgmVkSGiSF4ew6uY9XxkOe9rKIrWsFEZuMuUAzqf8BC+5BkolzUSXFGDKId3BiRiVWg5xS7Un7b+IHWfgrF5z17WW/3wkPBceOenynLmxzAvlWkCuukeuINnDHwXJGjOZxvgnXipfjQOGwoBukAQwyNb81EolZgVWTJxTbvii+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZvKlYF7f2F4BWN+C0F9J2WFVy06WAhnj3yU4lfJgvg=;
 b=NR2Lh2WrsBYE6CPJ9mrP028UrQ4fwpXzkcAjgkoTdpSrYKj+de/AQvCSoAzc+DHnNZ8L9JpkwrwJY1LuZfZVV5HvutMkiEl+l2SBSz1irTFMnUaTGd5vr2Sin0RdHW9GIQThsOnajIvLxFwTAgYnBOJPueqeP6LT/kSXQpNh5+1i4zGJJ3vxEDz/t0u8bw8T3Fejqd9fduvLbGTnpGIUrUgvCMtvg+Y+5q8HF8WCMKn0EeV6uWWh+bWBmrxhudvXd10m0B2GNMw85AN3m87W9ftUHrJfCC6tQlWj/5Z2ksHtUOHJ60yPNfjkNTTbmZlZFiIZDchNMOUqH4Ipt2f/wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS8PR04MB8547.eurprd04.prod.outlook.com (2603:10a6:20b:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:32 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:32 +0000
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
Subject: [PATCH V4 2/8] PCI: imx6: Add skip_pwrctrl_off flag support
Date: Tue, 30 Jun 2026 18:31:33 +0800
Message-ID: <20260630103139.3823329-3-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS8PR04MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ad7082-c72e-4e47-11ad-08ded6929cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	w+2wvUNfavlrs9pv/LDEZJl30bzgk5hsYO1ve8Ft5w/tI2BUHPceJPouVnLhFLHNqay+mfvMWIpDahTu6p3eBNsuNuODDtpc7N+wgubCycCkOJLsa9C/BdjabUOAK/lF43qUoHKRH4zCAUKODr04lNFZGg1NHv3xmmFLdZXfamEffTzNcFdizunMnY+h7uydbU/WXcfVgIAU62D5Mff59oMMlq3CprmSR71To7/0bDCMrI3IAhRXRz9MJHJdoGRi7DmAUbU/2abeAxY6hkIrKOV0lFXO/XeZ+fyckv4aZq47JrbqteevG32tbe4kIEylFhFCkFPXMZETm0Ajx5Py49je/+WEKp0VmrLSV50T9pKyvRX6JAP/2sZao0SZFdnO/BHO+65FvofiEdjMZbaZn2or2+INPRfVDJB8/wFVTN/+rQCrnQO83gEPt8BfEP0ZPtXTQLm0wuAQBdZdN3B1VYeJIYiWdju9YEe3YOR/A1KLD0K/rjuJzCA1kYbolufnXpNFWEHdzJtt14oCqA8k7A/yL1AiO+sapgiIuro7gOQugp3rseiQXrUnlyq7Z3ddtzDLJJJcRr4q5AjETV2HmCWI8BFESAzBa/LFno7zsOpvizV5EOZba2L9V7EarwIC01Q91qDk2ESBTqO9k35q+Ay9gO8zu/LW1yeSJbEnjYsTmRzZRlskJBe3ghrrdFoD+jRZecZPcsF7UPS3S1w9oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4BqJFEJgSCymOm6A9ltwW0Ohg9WHpWcIg1GfIOdeCChq71LFabA3xfStqu3?=
 =?us-ascii?Q?Xv30U25jcAE5S9wKU4GmcRnx+V1ijLmSoR0ZrFM27LuYpcqIe55M/gG4IUKw?=
 =?us-ascii?Q?UcH77PMMDh2pNkmaMgpRCrTelx7uZ0GbZJEbet0Jk5wfYa8KdQ8o4vftxbUg?=
 =?us-ascii?Q?qMmsYoK6/ZFp4VVYq37VLC/K2fucU7BuOb5hRKOS530hSOR9YQ64UVq72kXI?=
 =?us-ascii?Q?LCvNErURW7kxLaTkgSabs3d2U2fnmUwmDI2nrOpfqiprMCFVrQvQ02ey1arl?=
 =?us-ascii?Q?xrqow4POrXYpyJHwmVE++oVA3cJNWWwk5M6alItRkYRRBNH/SZhDXWLIwTZk?=
 =?us-ascii?Q?2we6ehVJnHsdxpUnPuV3LSarhqXi6YMXc2LdNJVdkiAItO4UB6PyqwVsfTfI?=
 =?us-ascii?Q?aJDqp0bpV0182gx+ay7RsHpjoqubOgjDNyL8+LS0JDVnOSISB5itETHj92dE?=
 =?us-ascii?Q?+HH9hKG4r9sDhLeFwHaktnG0RIJGPgkbAAS0vbzjN2mufS/DNQBwhDdCK1Zi?=
 =?us-ascii?Q?fOcmNReKbEK8v+ri1MwRZeE5q4N4Yny7bbrZzQt34EaNnzFtLSrY6MO0TKqE?=
 =?us-ascii?Q?KEbUFYU8C9vt/TtCMRQlLn+aSfFT6U+5L+xsX9qvqVZ54371r0kFM+hxPm5m?=
 =?us-ascii?Q?qVlxfJkdIhAZn25Wve8P9YXjtbTuGU3ilFRuf8t+HX5LXdWVnDVRUIoNrdpm?=
 =?us-ascii?Q?+OOyl7VK02tY8eRUkI7Ex4iTF2SoC2s3DkSliWXDBUmsY4u3nNToklNP1y4f?=
 =?us-ascii?Q?+AAAo6I0iUMxs1NyNK1uULLa/RtMXPoBypOECdQlY0oF3RCwZluBXd3zXPsJ?=
 =?us-ascii?Q?4zxDTMN6G/QZzrJuzaEWInNa2/kN3wu7x/IJNFJms6MuxMVeVijCnz23EFzM?=
 =?us-ascii?Q?vG8wRmnndXGN25Qu3n0Rf7iRPKBrLDHgs6/obQJng6S8e7E51HoDMHVdhYmH?=
 =?us-ascii?Q?QH7llEP/zTNXEmstDh6VN1eTHfrg3eIdg/BcHRkrkZNU8twuVAvt0lCpSzOy?=
 =?us-ascii?Q?HVAM4j3RHbnuPU8f255WH/+1IqJqfE82Q7wZycvdM0Z59QXHPpuG1A4wHfeF?=
 =?us-ascii?Q?eYMcDQZx6xK2bbs7m6fg99n+BGC6fmevduyihmjOFZye9Bd0OCYCrdOYnPWR?=
 =?us-ascii?Q?e47qitEMrkJpAmx/tiTOzCRq1jwu7ecU8tAwZiKnAViXdyyma4RBRY7EaXXx?=
 =?us-ascii?Q?C/Zw55wMc53M3/x42u3msUw7fnwHW9hqNuMVzOz9VX53smpvV+l3GvhjG2cC?=
 =?us-ascii?Q?nlW5CNXmUBhg3q7Vs4PjoUYR+Nz4LLHbhsspTZ3dEBYoXPiU/7TCxiO91b1L?=
 =?us-ascii?Q?zXaGZBOmYB9XykFyPmm8lZTsoXhO+SijvBpC6WuB8q7arHm0ea8zQci7RY5J?=
 =?us-ascii?Q?8Iu58Yict12P3fOykOz3ayM2xz74Hm5T7yJ2TiiHItyggA6sPQgnP+ql3jJE?=
 =?us-ascii?Q?ECWQUuhfrYREuluGLJm28CfQpaSfzYfX7g3inG8J0HgYYxT8K5kHKcqk6nx3?=
 =?us-ascii?Q?/AZpfzcg+QpJjZlIlBy7tnZICz4qi37+R0xX5t3nDI4aFW1GzlI/RaVUgv4T?=
 =?us-ascii?Q?Y2c4NIzKJHF5QnNOPumc/yLXx/6WI/g0ibsWNQR3TLDIgwg1k+nK5WgjEmvy?=
 =?us-ascii?Q?cD5ki86aWpYjHau+RKZqPnpkx6idnx0AY7qcPe/ee11wQsbUUKOm3RLml3ZZ?=
 =?us-ascii?Q?IoCh9jZY96LoqUVNaOmJz9eFsQMYRG4ANVOHsOqF3eN3KywLeIDWeooEuphu?=
 =?us-ascii?Q?24ym9u5gJVfM/QWg5SJ+dZZn8od1dLiO4UCM5aywqfAV0q4mqleF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ad7082-c72e-4e47-11ad-08ded6929cff
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:32.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZn3eGiTMdwVpkW/yy8mDEbvl5FwRl6IxzTAKu6Ic4H9FcyAZ7v1r0jUaqmfVJIrhxudixKNA9HI7qMQrAGgPNLcOatXpCUuE+C57vNKoaPqZbepXjnwtDVR0Jb1EGEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8547

From: Sherry Sun <sherry.sun@nxp.com>

Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
suspend to preserve wakeup capability of the devices and also not to power
on the devices in the init path.

This allows controller power-off to be skipped when some devices(e.g. M.2
cards key E without auxiliary power) required to support PCIe L2 link state
and wake-up mechanisms.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1b535bb6fd31..0685573fee71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	ret = pci_pwrctrl_power_on_devices(dev);
-	if (ret) {
-		dev_err(dev, "failed to power on pwrctrl devices\n");
-		goto err_reg_disable;
+	if (!pp->skip_pwrctrl_off) {
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret) {
+			dev_err(dev, "failed to power on pwrctrl devices\n");
+			goto err_reg_disable;
+		}
 	}
 
 	ret = imx_pcie_clk_enable(imx_pcie);
@@ -1454,7 +1456,8 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 err_clk_disable:
 	imx_pcie_clk_disable(imx_pcie);
 err_pwrctrl_power_off:
-	pci_pwrctrl_power_off_devices(dev);
+	if (!pp->skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(dev);
 err_reg_disable:
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
@@ -1473,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	}
 	imx_pcie_clk_disable(imx_pcie);
 
-	pci_pwrctrl_power_off_devices(pci->dev);
+	if (!pci->pp.skip_pwrctrl_off)
+		pci_pwrctrl_power_off_devices(pci->dev);
 	if (imx_pcie->vpcie)
 		regulator_disable(imx_pcie->vpcie);
 }
@@ -1990,11 +1994,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
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

