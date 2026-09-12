Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EF471249;
	Sat, 12 Sep 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229791; cv=fail; b=eE//iUM/wC+kwuSoTYEIJC3aO39Z47K0GuKSRg71vuzX1KARpdLctn1r5/JiBX7dqkDnu/Hhtl5ftN6HXri6PmwoP7rud2VMb1IpA3IIDN5BjPOd8KojfNlhprXdQPkaLltOHl0EY6MXP7M1pvCdE+3QQx3YNCm+YJ2myyjFZ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229791; c=relaxed/simple;
	bh=U9BfqPNG+yV1ycRAJ2FEJYehc23Ycle3yElfVwt3G5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXBmCCgqG4Tg/w2cUimt9EsFYhD6iyu/MPth3mPRyoNVPFunbZ17saNPNJSeefby2nHhuXu0RQXFGto+CoDU85icnbHtpYFICeW8+LgQKrsYunKnZsRKbOWSFjwjPXuFGRnZukHrwn4o+n2PUQiwuDEC2Zg8EWIDl6fboWMRZ40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jcE2+EYd; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcE2+EYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHLTxLU7rp/wH6mY/ErFLmEo9iyCLoySCmxalB3v+llQAtSVNiIMNF+NmkzZfVBVusZcfB31VVUcib73soILWNx1DM3i6byrm0mQUykqfLgrfFIyz/yEYGQN6eevz3b194QUdXOfAkoA3oVKvFxlmlM7gdNO7OVqE7ZGUWJ1z9zqg3CYjUctCvgTIIPsfvSSmN4DTVfo/2HjFw9U0SEhQymA1+YduTPg/xuioVBTh8p54cFI6yYWNADNamhoSz1Pb26VzDtvzGbcNwuAEA0i/BUPCnTg/kguTz2aGbZXj7fLN66hgq2v1RONUuyPOTstQ833GriizRVBW9e/6KrGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFax5kRpkURnjwJk76LP8zB5hmul2052vISE3QbVQF0=;
 b=nyUAON0gFNRNtKEJ+iLNtkI65nwl1PTsuremfeO1+9z5OYxECPwhN9pKcLUvF0RrTfasiHPQB+i/fIwc36Ok9XeMq6/oekKgbCcKDU7bI61cyWmcILjVhmtmOuOPkbrq+PWcRLPFJ+B+vjsraR1k45ApQhc/b1VzGL+KY0a7RWtjaZCzMuwm2wDqXeG8v9aHRHtv2fuo0UvRRfkRhymdDqyJfDuOjcVk9+Qv+GcYiOJG0SKwtLXCOdWJwjrTNNqjgRxAEqy76QdAa4F9bCjRWD6mMYioS7AM7kTGvv8+Vh00vj2uu2WBZ2UBffu8xlBK15prP9LYH74jojaZWaRR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFax5kRpkURnjwJk76LP8zB5hmul2052vISE3QbVQF0=;
 b=jcE2+EYdY8QDbsH805554/cBu9Z5P5RdqbfT90sJbgJe4y+53FI8h4YqlUlVaX2QPB6Of07ECZeaOkSal/gvFsYefC4us3N1OIfQKHE+Yy97OvzlBX7yrD8+/WbAZWW1gb6mmhdoMHJJPr71G6bNQ4oJ6QbbzP8DzU7uU+T/LmXrekHPVGeIX4DepSGfLwPWrQpmTyVa7lwjwvvD54s8TFAkW0/U+0Lep0XtmcxZXQBJyhW2sr5bzs5LZ+jQSXWvR3Bc/GJPAQW4/CvzVtds1P1vCGJBpdbS12I1gWyBhkCqiewnZjLbcX3QNl6sUkDAkLf+Uf9lHbUQQVQtYL7gZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 16:16:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:16:21 +0000
From: vladimir.oltean@nxp.com
To: linux-pci@vger.kernel.org
Cc: Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] PCI: cadence: Remove device links to PHY
Date: Sat, 12 Sep 2026 19:14:38 +0300
Message-ID: <20260912161440.1032188-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcd2a60-9659-4f72-766a-08df10e92ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nldCP9lQsDedJ2IT3MV9aACoHWz3sxEvtXFer4l8VxprIf7bi9CE2z4McnIeBipM32aCYotcqzYiUCbz6Ber8s2BI9g/2DzpU1AqS+9yHWXjj3WUA9fkIOHlALOuxi1RPKUFp8GoaPVaWCnhX1VxwcroL5HXJhQv9hvVB8ojG2PzEK8HO9GQ4UKPOjiy8NoJCX/QhyxR9xGaDAltb0a/+1hAJ3Ztthl9kvzl+u4/ZX1c6oW1T16B4kDQ6XJJr9qUhCqvucnA+FLEmNYedO4hxo+9E4orRnfcoQhEyMCtJ1NqF5cTt3SHweyukTpfnx5bRfXK6qjcoWD7bZ4rTuRPxcPTpaFpR5DOInDGiSvg0OmxtCB1ZJpBAjrU4uMmTP5zQ3KicCDrhO7n/gFi6fODvUTnI+yC/axi0MM5IygDPWDRwMJd6q9CLb2wx9oczyFV1+cxRUbhjs46fvtoYcQc9tdaSCR9IjYpKladE5XKBu58f4kvdObD+GBU88AH9l15Gg8iH8AnMLiKbiopET27pS+amxDc7qyawd7GQYq+QgKDkESnptqaXT8wPxAJez7nnJCEXemGPZQY88iz1Ayg53MoQD6EsI/NLO69SypZ9fEj9109ZGWzWlyPrWVtGE0x/grVk6/0LsWPA9KNSwe40YS3onQBvx9rv5+VnTibJgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bq37jzzQVknzzrYRlgLkdxFU+SkDj7RMSwwiPaGBJFywr8GnPFh56bG2wAE/?=
 =?us-ascii?Q?DGpF7E1jEQx4d49kf1E72/MEbhYLQHRLbbyMdk/v1JNhEssGaevaMkObdkRa?=
 =?us-ascii?Q?DMqoZASSLPWa+wd/xSgNv1n3nF3d7p3maTlRHpwGMar47rdzBIByQiHUzR/+?=
 =?us-ascii?Q?EEonMMr96fCISHEEzZY8tkd/hGaoN/UZij3v4JpjUL1B1oaTsp1yTLPXdVUB?=
 =?us-ascii?Q?g6vJgSI6/P6VzDzfQRxGOJUciTGAjyybcZnEpIrWSBJ7DhLxln2cgH7LmDot?=
 =?us-ascii?Q?bMsgy3HJiJ4P4Ncx20WrXiBtcqKe2hCt5s588AX00isuZX3iTAsN7iON7axW?=
 =?us-ascii?Q?DDrFy7eMfj1eFrpmJTjINLsfZTUO62/iQdkIm+34PpXCSWPnf2XlTAc56Vv/?=
 =?us-ascii?Q?Q1uiCA7wOY814FRviPrAJIODpGq0rGLT/wZ3FK66y9gTAhUratt7Q9OKvgxY?=
 =?us-ascii?Q?yaKdThWUxo3UGC5VUDCyujREcRZYzX+7BGwuHL/IrcjgUVMUyOa8tSmuw1JN?=
 =?us-ascii?Q?Dq1iqiF4IhGBYVNVlstyz2hsXK8uBlw/cf4eoeLzEnhlvwo9ywCC1mNH2s6K?=
 =?us-ascii?Q?p0qdULwS10xkMm2VpYHA8gUD+HIucb+aSmhjwns4hoYl38rM+6SvjwsjinXC?=
 =?us-ascii?Q?va/Pf8hGMTndzb1HoJtzELK8/itu3P3PjOoJS2jEiIe708oOa99CPk2+UTUP?=
 =?us-ascii?Q?AU7WHaC/3jlM5GsgtH2RKH7kc3ZsfBGlpWxMDvUEuHd+aRR12UV3j6fFSmV9?=
 =?us-ascii?Q?LePfHqf1lGoSXI4N69uIEVQ0NAiIiD4wPkzbgwQLuWLathkASBRywCkjRWMx?=
 =?us-ascii?Q?9uM6/3qd5kQ0f+A5DlGs+zcRRa5Z1XiSLcyzr2EhLDHIsEZPH2MpEIErdRBf?=
 =?us-ascii?Q?aKzUYvqKvOY3n5UWWVVh/akurAUYVPMDPyeqddF0bG5qiiRo2GUSjvhQxHEF?=
 =?us-ascii?Q?kOD3k3PcMKddPpi8xei+ngZFknBgmeWU1Xr6VSZDKk1aSeFYFkgzoVQRGAGm?=
 =?us-ascii?Q?2DjmZBt5qnndbNkLZjIMV5yzDMpV+Xk2nJPkZt4GgatuFhK0YKI9tFdJqAyu?=
 =?us-ascii?Q?OKCplYkdTh2WxlxXhe7ENK89R0Su1TvXCve/BZzYh/DIemgOLQVZLpiHLENF?=
 =?us-ascii?Q?UTjDjcTphaxq0dI31I8y1OPp+dflG7VOI1xj2ezum/TcrBG5Vi0NfKZ1hhgP?=
 =?us-ascii?Q?mZCVyfZYmdb2Q7t7JbPheE15rCpIwcSNmgUygV1l9E1LOh8yvGP/F0hbM0NB?=
 =?us-ascii?Q?B0XH7J8Rp76QIUDZ0OH47Ci39owCmblPxUaaU5Ihhl7M0mQrzS7tUyeLXiqD?=
 =?us-ascii?Q?Fldv918bJDu+bY4+5ukKUnjIJ0AbKaBsGBeCHUT4Up8s55CIoC+cwAJgqmqp?=
 =?us-ascii?Q?N/ziS7+4HHak0LIQTPNse8BR8C8TSyjErVdyA5d3iXZnlKih4MB89rxIyLpa?=
 =?us-ascii?Q?DUmR0CKmRcC37mHAzaNhuUxvEZ3W0V9AGDSIvSSjCF/3vgd1RZVv0QN2Bgiu?=
 =?us-ascii?Q?V1DAJQ8RUnPD34PqteQIR12OGmnKgy3PjvNdb7LkJAGcyAeY/Dsflya63Qa0?=
 =?us-ascii?Q?VRdt+Qex8Cfw5R5yqAah5NttH3Ge9Iz5Fdu092LG5v+GkxPR/bddlpiXLnui?=
 =?us-ascii?Q?WtOsPAI2Q50dP6uzO1/fY3r42Y4iuCfaid0fo14ks1SaWwlnh/QFwwvoLE3B?=
 =?us-ascii?Q?2/f9x6/kMo2H4cqD0seKfdm562MAfrMOaIKQvCrgN7RaWGueD/SZkMOfncsy?=
 =?us-ascii?Q?ZP9q7Hr2XFTw1FtrLmRLNFoQzs6pH+ALYs7jV8zP3m1nB16e4aq3hNlD5ILj?=
X-MS-Exchange-AntiSpam-MessageData-1: Lsa+P16ntnYq7dLPo8Fn/7guS6dXbQWDDzU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd2a60-9659-4f72-766a-08df10e92ee0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:16:21.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paEUGdy0VPErY9Hxl8/w2xRSsaRpEWuCcYiDAVXddx+t+lyXJefYlNmSYnIJaaIYdzagCIX+rCSFHKiAh9EBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

This is a partial revert of the device link pieces from commit
dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP
drivers").

The trouble with this is that a PHY consumer driver dereferences fields
from struct phy, which will become no longer possible.

Since commit 987351e1ea77 ("phy: core: Add consumer device link
support") from 2019, the PHY core also adds a device link to order
PHY provider and consumer suspend/resume operations. The reverted
functionality is from 2018, and is redundant with the PHY core now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../pci/controller/cadence/pcie-cadence-plat.c   |  4 ----
 drivers/pci/controller/cadence/pcie-cadence.c    | 16 +---------------
 drivers/pci/controller/cadence/pcie-cadence.h    |  2 --
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a1ea24fc3b63..5900d68c6e83 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
-	int phy_count;
 	bool is_rc;
 	int ret;
 
@@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
-	phy_count = cdns_plat_pcie->pcie->phy_count;
-	while (phy_count--)
-		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index a1eada56edba..0ac980249941 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	struct device_node *np = dev->of_node;
 	int phy_count;
 	struct phy **phy;
-	struct device_link **link;
 	int i;
 	int ret;
 	const char *name;
@@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
-
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
 		phy[i] = devm_phy_get(dev, name);
@@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 			ret = PTR_ERR(phy[i]);
 			goto err_phy;
 		}
-		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
-		if (!link[i]) {
-			devm_phy_put(dev, phy[i]);
-			ret = -EINVAL;
-			goto err_phy;
-		}
 	}
 
 	pcie->phy_count = phy_count;
 	pcie->phy = phy;
-	pcie->link = link;
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
@@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return 0;
 
 err_phy:
-	while (--i >= 0) {
-		device_link_del(link[i]);
+	while (--i >= 0)
 		devm_phy_put(dev, phy[i]);
-	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index b4d51adefea5..4a96e1869e53 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -260,7 +260,6 @@ struct cdns_plat_pcie_of_data {
  * @is_hpa: indicates if the architecture is HPA
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
- * @link: list of pointers to corresponding device link representations
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
@@ -276,7 +275,6 @@ struct cdns_pcie {
 	bool				     is_hpa;
 	int			             phy_count;
 	struct phy		             **phy;
-	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
 	int				     max_link_speed;
-- 
2.43.0

