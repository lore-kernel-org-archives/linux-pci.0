Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B53783B5;
	Thu,  5 Mar 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704378; cv=fail; b=e8uIdZUTVJBLGwnaWmTlueluECMjdM8L/7xPRe5pCTRnJiMrpzG86yqfeLiGoBCloeCeLKqZaUfbLRdhfIe1ce2zaXkph450Dha4gfm4zK7mYDnVL7BZapfgqSq7wyiQKwB9NGdudT/X1mbBQMrUm5uOc7uux9Nk9S6fAZ4nbsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704378; c=relaxed/simple;
	bh=X6kfD5cCnxu8Wnw8ImmIXbEHWFUySrOAUCyTJ0y/Veg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qw4uT1LwgeJSh5ZGDAqTJ3n4WoNuFh/e9TkSzxwNcUJsAKFHunyYsNm9YqWAAZqTImXY58zbM3rhcXrE52oNbvzZOzs16mZ0d+Pg38VeFwMXlk7qfqYP3E3dJ17SWootdft7a/GF9OLCWHrjhShogFA+5ilPIVyW8H4pD7+1voY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TepMQ2BH; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TepMQ2BH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jno5pLI4hv00UoKcKZh8dDckQDyQVqU8oYxCr04b+0M5HpgbEK+YCxhOGsbCePQHRrdPPKKl4N+bCU6pytepgjVLsBPWqPO+a92vTipzXZKN6+p3maTqx9EaIp1HagBvD9jms9shSkb0FjDDakg+xLbbnXUWLWWtnUtNBXL+mxHoKky/zsv7ptkQGuLzHiJpXs+i6V+4lfnOsajt15YewUtqGsoI4xBnN60IiD3ywqPdOM/q/704Ht5pmASpfS8NHAvtkkpbYGhOcvwt5pY+Cf9MJxTJMPm86lv+JVKgE37w6WR6zQhjjFqun9nA1HpgADlJ/gOR4bphpABPCT04OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXtEDXELY52ko99eu77lxhX5uAbC5v1oHg0fjbAZie4=;
 b=VgwTeezDJL/LnwbXvu3z4gtLml1r2T5ksC51JHLz6Ym7JFoTpYypSt/ADavPQ89d0Cnmz1F9p+9q5CQ6jFBKygDFS+mrxRQ0RvcZLXuM7tq4GZW6kt1DTrq+Ikk9KIMPCKUwIKailCDD08jCk5OtQEH4uid0QZFHF/GZPKgrTUKf7L5kr7xD2OqYinzeYZMAMPWKZx8doYAkTt4IHlCstGIDrF4dcflObgG80O2GJyTYy0LyYP3BuPEJ1OCrpbPUdUjiuaiEyea20r1qb8DV+yPSvkf4xzzdrZv5woQ2lKorTFYli+AuJ7DdG1yM/32DRqHK6YPMPASrWpFCdl99tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXtEDXELY52ko99eu77lxhX5uAbC5v1oHg0fjbAZie4=;
 b=TepMQ2BHZWQnRKUyAgfZ3xPKyfhhAc4HyI/M2YBNPI90NxCCyEjhgIDJiEkt7TbDpMg7hXwmp1X7CBIUsXwB68MtQCkljcgVyFZoGBn7WtCrt14YcLIkXLSAcSrINE9I821LksimMmfT3h6wEe4GzcT0D8dbkVXXHhlzDZrl0+tvD7eZzeG9HpT4QAnhA3n2+isaSPOTQ3S5RanaFd1r+m48fLfnaAZvMdi9wBeOTZkDqqzyWSPU3SvigIxNxVcFORuDWcwRKmdoqsC21uqtaB3uKynR4P6LM2D93rQH5fSbY9jKsPjio4r/+hRH61C6aTbHBhbTZPtE8u03AAPWMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11863.eurprd04.prod.outlook.com
 (2603:10a6:150:2f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 09:52:52 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 09:52:52 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Change imx_pcie_deassert_core_reset() to return void
Date: Thu,  5 Mar 2026 17:52:59 +0800
Message-Id: <20260305095259.235049-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11863:EE_
X-MS-Office365-Filtering-Correlation-Id: dd03fd60-243e-4cbd-3af3-08de7a9cf792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6LmEjnwDdSBWtafMzyP9RlnEgQ+FNjxg+MZ+h1Bz+ZbVgauhtn1jUcztv+ofACJPe2MLL7QP8TuDPHw177wHERxrhadKes0036MiWjEjudswWBmJJn6nQlKRiVeCXe3YML4st/kAP3tycJEFPzwDRXlCOGKWRCAvyASMKXWQH2BSBhBXq9UkcBJLIygm/qb2l2jKH38GclqKJIHszwXsHdy18MozyKRNAP7fnHA9Pn79dZCdH2KRYw6iNgHiUDRTsDHdjEktJgepH8QoGILWKJ1vyqA0qETwjQO6zCVHR3GxNhrK+8m8TvbMO2o5Ntm6gMc6z5y/K+DSjJuYfdsZ5dO3klHRndnA97q52R18jJTQd8f2kQu5SoPZFzIFSfQeNTM4M4aQa/15ZN/JrlotAeVTl+8XBfKHOszIYfUdH4FowicqNfNe0QdmxnNW5WRBnJ3x/GE9w1iZAWt3fmO1NQd99VHYnpSUVF+ALF+KFyOBD0a41sRLsHhCvQ6kzR0jnaFH73ELT/cCp4yzhLQfylKuLRqlJ/sksPVEezX2q5cQZ2fQ5p/5GOTeTiZecY+ksjwWVlMfYgjRvdq0A4bwBhTeXshBK/6HXWlp1RLPRp9HJ8+YhqlaiPKGPwfHH2imD2N6XDIFo1I42uQwYm0oKzhRgq26ylqdOsmHiuKApuJPrXqylWJc5R4mSvJH660YSDceq8XIy/hkLhpVRG+LIs+ooQtSUQU/eYcmYjkNa8b0MJsDzegeYr/EIDjYr88ve1d0X32OqRPy6YkbOZ9shsXx99XHrmUdeRsyNcHEJyW4m9DWc+0sNvridEKYrEYD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zzWVOi7HjeO0wi9gufa0QdIYbIrq/JTDGlj4rp7E+AzeM+mT+znzXU5rsLr?=
 =?us-ascii?Q?Mkrtdj+sDWhD1oOopr+e8pU0J1huZchgrVyFgsZbQ/5mdcmioC2lvE9sCzpE?=
 =?us-ascii?Q?BkavgLr4pgt+85q37+3ar7DYQ7sgyoabLwq9SmfMByk67cfGGcj39Z6MHnbw?=
 =?us-ascii?Q?XXltVW1eaTv6Lo0st1ovHEPeds9ABCOcckmZ98f1YUrTsG6Bdqn6jA7Mj1LG?=
 =?us-ascii?Q?Yn88zQzyPebfiIQaH/SoQshjFrQ96m3Ba65vljjNsjOTgyH+lOmXuvjlFOxE?=
 =?us-ascii?Q?9EZyOHqrmEyqgERVx6CI7T00dsCoOvtQvmKd3Z7O8g8qSyMU4wUZ94eDTmbr?=
 =?us-ascii?Q?pRrOKWWFiakKAzV9ACNVWPEvAKYkAb7RdekuY/3zt4EqU/ehN3R5oEJ7aE28?=
 =?us-ascii?Q?3lh33D7ecd9bOkAMDbXWmDYq9OJRm0tV801D9GeE/31tUJycJG0rkJkBWuBe?=
 =?us-ascii?Q?JnKt3ayrliMUst/CHeOVBaEGjVhVZywu+KTYzHnLd9OieqFfGfjy/bz+bXib?=
 =?us-ascii?Q?FclUzlNQTA5mkp2X4wo7VAoFqE/sPXoNjw4e39nVJI0/kHS4rGwcHAGw0wbW?=
 =?us-ascii?Q?aLqxFq5e3SiX5mecqeLGSyZh2r36RybYJ4hDwqnMUoGE/ZdyVFriqFlv3AFh?=
 =?us-ascii?Q?JFKIxLH3clXUSpqJUprsd48PwWjxR9pz1uanMlMrGEk48sX55bXj2nnIijh7?=
 =?us-ascii?Q?6wzzSn6s6A73MEnqBjZpmvl1QHUmTL3WpSKvyXV/5Sxv31PLc2L99TL2r7A8?=
 =?us-ascii?Q?0DMgrNeFDBWyFcXZKRKzEE9HgLs/nb5smiXvHjwTfJQ2PJjV8EvX4wg9TuDG?=
 =?us-ascii?Q?CrhvZnQh7226MQ7KRlqxf9CgqCFx3qzFHUnNb7lQg91f9GfLCEPwKmTN+fSh?=
 =?us-ascii?Q?CUG4QLbxRtn4LjUsUBhG7z9t7L1oG70ZNnC9iPm2I9RBk9qzvi7TFD/I5V99?=
 =?us-ascii?Q?4XFxXRH/lqQkJnoAC6wmNPJkmRIlR5E8LFIXj6CAb+QVy+CrfKM0a3qNt+vb?=
 =?us-ascii?Q?zune776E0xgcii2PkYQf++A2CGiLZNznPo3Av8W6cTMaquqN7u9wUGE9EMDS?=
 =?us-ascii?Q?yFbpfzrz95Rmh0G4ZS3/bFC+sFJjqCvuzTCizCD6Tw30RaTsDCBPC8URJhMv?=
 =?us-ascii?Q?sdb341oyaEzOpWgW9F/pKMl6W9VrgsWk5HerrIJYgu6ukU3jaC6S6QsBdtlv?=
 =?us-ascii?Q?4u0537GhXI+HD0a3lC8A8UhlVdtqtCZvz9zHM8DuXYnsLxYep1JzvJ9pTy7h?=
 =?us-ascii?Q?YV/uJN8GVo8MtGYVdc/z+jy8/0zDxb6qqriGle5U3WvLoN+xqVQC+mQ7KUm7?=
 =?us-ascii?Q?5xAFpHPloN25O50Ro00maagtxsd1+EJYBX+M+Xp0z2VCvRcnoPpSVCKBECNK?=
 =?us-ascii?Q?1kwlfoE8U9N0qBaWHRQiSGarZI0d22jRnh44RTyJcUr9iVP25pyjp4EF73uz?=
 =?us-ascii?Q?xEf6D+TbL252dlL4GKRukTd7cBkxLiWg7wS5qlfhggi4uYkAfZ3O2hHdHwGi?=
 =?us-ascii?Q?8veo+DHaI9HqsH8FGQeiLZRw13F/sjQXPMS6MBA03H0CiE3jZcoVOgVzDu/b?=
 =?us-ascii?Q?CQDd9nDM2p4exbaPBGiPM2C2tuy9surLgAOOpsNpUocWTwF4j+BmFbJQURbg?=
 =?us-ascii?Q?hnyN9nsZbTjBNeO5c76MlOFV2ienZnuNLQaIu0ORTXXZ/Haya/KY1rWvDsnD?=
 =?us-ascii?Q?GabIbCk8fClxBgaJVKVygaFAh/dYNWbrh9b8IjPnEqfdpVDYizqFMyDgQ60A?=
 =?us-ascii?Q?dz2z3G/Ncg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd03fd60-243e-4cbd-3af3-08de7a9cf792
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:52:52.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0omB8v96rA365B0MZOz72h1bj9FsMoJuzac9/OiJIntkXKbBVpLqbCeCgojyIHu9BLidmrQy5lHAIGGUZgYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11863

The function imx_pcie_deassert_core_reset() always returns 0 and the
return value is not used meaningfully by its callers.

Change the return type from int to void to simplify the code and
remove unnecessary error handling paths. No functional change intended.

Fixes: 835a345b18b0 ("PCI: imx6: Reformat suspend callback to keep symmetric with resume")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81a7093494c8..ba6e7c7ee625 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -906,7 +906,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
 }
 
-static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
+static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
 
@@ -920,8 +920,6 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 		msleep(100);
 	}
-
-	return 0;
 }
 
 static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
@@ -1292,11 +1290,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	/* Make sure that PCIe LTSSM is cleared */
 	imx_pcie_ltssm_disable(dev);
 
-	ret = imx_pcie_deassert_core_reset(imx_pcie);
-	if (ret < 0) {
-		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-		goto err_phy_off;
-	}
+	imx_pcie_deassert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->wait_pll_lock) {
 		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
@@ -1613,9 +1607,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
 		if (ret)
 			return ret;
-		ret = imx_pcie_deassert_core_reset(imx_pcie);
-		if (ret)
-			return ret;
+		imx_pcie_deassert_core_reset(imx_pcie);
 
 		/*
 		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
-- 
2.37.1

