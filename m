Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E33559CA;
	Tue, 28 Jul 2026 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210518; cv=fail; b=dPYaI0uRBXRd+6g1IhwgnktizE+wwmgbJkUnBrR0n7eqi/554UpfLs+fRwLW7/KG930LMJ4mDbwD9z6vPs6KVbrbv5X/gNQe397H0c+TXW5tUm37y/6xPDmk3UpwcEOWeTP32AqbLVGHlr7GwKAkGo1MKqDmJmb+LFWROTQ7ovc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210518; c=relaxed/simple;
	bh=P06i+6mapUtaATsR0JRnIGOJZNIYinzp5IC+AGC/BiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lLevZII/OEfYqU8+iEBQNS5iBJtT3Y3TYUZb83OaZ/f7mgTpnOF+o7whRlzWWTnZj9hIccoI2r7g/369nqZu+LIkXff5ohAqXOsy/iWMCfDD3QPYUPbgeVbN+LLKHz4UOBV+by2jua2eexfoZXVnOArT2G6HLqovY6KheWArI3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OmSczWyq; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OmSczWyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7fph3ziVlH2fKmeDqHBOf/pgQ12m65VqB9Ji2kBr2IjmExYSHLKm3dsFjTsSfRV39UcGzh/2fOAd28mG7gZ9Pd9qxVhZbSg6zCysk+M6n+F6ddqKf5NpqxEgh1e/5Ff4eJdg3Y6mZN04Wr1go8FZ+sXsBrHr2X6CTJgT/tuAiTzQMkCIDZzJOm7A4KohQUgx3NhfuZbLGGbZqqmY/bq4Ry+BGZSPLJlse6gAyBibEPh5GXFbxATdZni4gQ5Hw6rz4np9NjoSMczMUF5siHdUw4h9I9gQWEZDQMC3W7mTgs+dLGcjV94QZYpVZ/GxUiYQE5wozGM2bOs6polmKvksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q/AaRtHkrZwEhe251fe440ZehwwIHjkWumaFd8LZVg=;
 b=O79FpS9uUNpnoxRBkxPpTC2a2LCNkYgqbun1xdOmZsoBryufR9P3dmMdHYvqFLnAMoZmK89KXBw/SdET+nUkJ6WCmiFBnUSyrR9Ki5hJdH9Q1JWgczTjlMgAb496SX+wSw6bkjA+NL9dpN9WeFsvPX0Binuwq1qkVXR39vYOVcA/gHuyM8Fx3i0rR2DPlwe25Q/f93C1jWDwvhTh59Nd8UhYfn8l9F454Cqx6cnmDpSXsGOmq8VXfFw1L7QDTGHU5yiuCjHHybAvOajyXAWKV2rbYdQJ2yluGSArnJbxQrLFP2WIITb47aEllcWG16b9M4PhCUWAOs2y0tr9baR5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q/AaRtHkrZwEhe251fe440ZehwwIHjkWumaFd8LZVg=;
 b=OmSczWyqrzxGcq2Rj5WGNr65zk+Gx73ce+X5kdAItA6y8lJmabWT4GM1sACs8u1pnf1PtOYmZuKRTLEJbzFmmZDqIcNAoWLiegSNWIEmJoAgGBGUg4oirxBKnYnaF+X++Nt/0yPyFEvVGxecW47SlpGgz2qdQYfVWE/ecIrlqxXpCCTobPsflBS/pL29idJgSS0Et0H3l6rVnJHJBcITSTVKf5ABBJFQm2QF+3ufuZzFcF5srLuOkCubbt4Y3UP6qgOgBxZqgb2jkl+EFVdqz4kV59FiWMWwStbAAnIb8oEnbtuiRHUvisIpIIaAmTzJGXa85fN3u9lMFQsYUfilkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:48:33 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 03:48:33 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Leonardo Costa <leonardo.costa@toradex.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing
Date: Tue, 28 Jul 2026 11:51:59 +0800
Message-Id: <20260728035159.2702021-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 23443dc6-84c3-4e33-2917-08deec5b188c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|366016|7416014|376014|11063799006|56012099006|10067099003|5023799004|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	gO5XIFkuLjncV9EL+VkeOMsFs+AibFSP9Fhk2gdpGdUtaWFyIoxiDMJDvfKWaxkOZWReAOol99qpCu9hANgb/o28PxHrgmGUowtmJSIBYfQ/0lVhU3VHDvX+kMLAGF0On2NDYtB+NU6Z9WsWJFb/b8IiiLD3kKNfzm5I7WSFWD0DmJcDYdYxDV+r1cS9VceJRwIFUS/QJ1GrMXI60KRdcR9OB5Udyg3exAEJQP968XKVyk6dABDcqFKCMAA7x72IZVHSqWR9pKmlO+PkkXXPYvEdTkg86mmvLnAZkWbbx62LA1NpEl+hUVnBms2LlhLg/ZHrOgtw8XDwaffitXPA7uA8Mji/CJn42z+p9aJmNyaDcrsNYU/KWlRQ/SbyjDRsU/1WSUjKMxeb2y9v+YaO1NpV3MCvVhzfK/qwHIxi3muoR/zDwNTRrc9PkpCDTNKHRkP6Eyuv787H2Brfy+9bo5sRe5R7sqE/JWpZTWJhexYxDfapj2VWQvsjDdaEYOtOIBNRGvRmoTykNTs/rKUi6p7UvPWHFsQBgNADZ4imOEBYRf1eohE1ujkBzlSDQCYrT78fPys1tEy78y7+85exD3enWmNdzwP0IKJo9zHAQV90d3hGIdKe3PcfNGKlCpmrqA/oxH6Gj9rTxlxWlyH7l2lhM9uPxNwab++cUREEECY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(7416014)(376014)(11063799006)(56012099006)(10067099003)(5023799004)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AW9tE+TFCnARruF7z1DulLrATp5L0sFDZmHtnRswph0HNIBU655t3Gc04gEE?=
 =?us-ascii?Q?vPseyRee3+B8zfhwkDI0Rr1zyVquFH4oV2YuU9i9dPjcwFmrvOw3xStXkBMd?=
 =?us-ascii?Q?mFTIdG2FKafTZNs0EtdfFnuEI+AqyUZmi9FlZmmt6ph+GZSQlXy7o0ZNVorg?=
 =?us-ascii?Q?0KaOjQbB4jKRcQ9BmQwnneHleiZ7FIMoWM50s//KUixUzpFuAEdW5v4P4f1L?=
 =?us-ascii?Q?aMdMCU9Y6+gIlBpam6gC8tSfF/FVpn/eRUI0GCqlST4dFNPsaYMYk9UO81oy?=
 =?us-ascii?Q?u/EG2VRC37BqLOCpVsZ7QB1rbq+vJJpZs4YO0JHzdTXoVMeumLAfdarCViDP?=
 =?us-ascii?Q?RO3IlncLh3B0w59bn+SIUh4bpOBLP9qn4ISnapMVlWp8NQgXeN2wYF4U+oaI?=
 =?us-ascii?Q?mzrlKhRnvKoEcBqK0x8zQrn/buUzoyG+xDfmL4Mpnxxx5QuNDUoCNYYiYN9W?=
 =?us-ascii?Q?O4/C6T0fpfpd8zVKmXm5xupTXGkV/JFxkxO1Oyde8GPi3p/Vxjed2bC1ZWS+?=
 =?us-ascii?Q?sZ0DYIkTcMLRqn3Lrz3A4aHiC3oe/7O8+Z6Md+2rAf0PupYKcPbvi6wdXoY9?=
 =?us-ascii?Q?Kew3hSQzMVVqerrIE48ykw74VURivJbFPx0kXc7xJRZyOx3iroEQxkQb7k8I?=
 =?us-ascii?Q?rKxfAcHa0pGdhNq+hNH3IZo1uquKbs3w1B16z/HAW+6uQ7ID+uPMAxhAnBfB?=
 =?us-ascii?Q?usGnY0RmxY45NulfaWEKz5FS4FKPVvDMD1cjcpm/1OWn8aoYy5uz7wX7aarG?=
 =?us-ascii?Q?cUBEyrbDM8DGx43Z/vKyf6u8Vdvh/UAJGkEH5HLi6Pq7z79X+EUJIorUAGkm?=
 =?us-ascii?Q?yspiALlwtrYZ6gm9Uf30lJ6tL9NOt0IChrTqyAwa5El/tTQNfcb6MpfP/Gyi?=
 =?us-ascii?Q?3ttud3cXRyj9obWA3MxomSkqfeZF/68HIg+RU+nVe3bFasXPMQ+UL++ZoRJu?=
 =?us-ascii?Q?xqp4ZrJwp8H5/z5n1Fma8wCxohxiG2qbLqGCvnDMDsIr8pxqr6H1quQvKXHW?=
 =?us-ascii?Q?6sRY0d0H6pl7pX8PeGkdloKGoCdMxwn1sXdj+ZFBKOnIcFxs2mC5lmixJgld?=
 =?us-ascii?Q?HkrJ5ChyZUqAy0DRFPxNG3qXK8oQtlVY+OOTNKVQF260CbRBeTgwSLAawpvc?=
 =?us-ascii?Q?W/jjnOk3mEocfNF2lhsGzgQr919lxsIdItpko8abKpiPECwpmGvchcgJmbjr?=
 =?us-ascii?Q?ataPzeR8qJ+yDCMwJzRH24ZHMX78sdqfR57BT6hMzcHs/NepkQxtbR0wj1nK?=
 =?us-ascii?Q?VieWUOp+/3cQvJyb56FAAEeLBL1VJO6jQld7wUeza5JSUjkT7gCSV8MuT9A/?=
 =?us-ascii?Q?QsaGfzv3/sNy58sy7rY961j/hqjgugPEEFUDgCQSWlAomoBeQDCE5EWcJDof?=
 =?us-ascii?Q?FD8joC3TihWzKW3WA5NldoH6jC2zmfL9gAx0YewFBafCC8eWNy6/UF16OD/D?=
 =?us-ascii?Q?lWKASkKMKCYibsYrh7tA+WJ7wnNN/evoSmcE0zpp/d4HuOCX9047DRSUsIkB?=
 =?us-ascii?Q?sOcLKiKw1j66kch12vhK1ZEJAO4kat4rQHr6JQs6V/10MIxm1c/enPrFs934?=
 =?us-ascii?Q?uu3MJtjqWH/fjvnKtT5npCr6/GziTJ1Ee+gfjmd02zg9MPI73KuFiWuwz9FR?=
 =?us-ascii?Q?9h4l0YdVJoMWaFnO5RxfnAUqlLYj0odPe4j0EayjldSPoeE9u/1Uoqdc3Egc?=
 =?us-ascii?Q?5ZNjUNXjRf3wKQrfX6pF0VUKArQf/SvdKgRzrSx7snigzun7o8fF06PlSot4?=
 =?us-ascii?Q?xLyguK4CA7d8Xhm8u+lxEff9Gg1ngydvjvsv+HHiSKZmt/ySD6ID?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23443dc6-84c3-4e33-2917-08deec5b188c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 03:48:33.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWDPkzfplW50M+UkNgs38TlfxnUc/s1bNbpyShI6FvzDxpCiK12nYolRcmERsmwczCCtFrPX5AvMCWD5ObUfxx3SpWtmfDKj+bW+gg24jibEs9gnqInOA59rCqLWw4Cg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Richard Zhu <hongxing.zhu@nxp.com>

commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a boot hang on i.MX6Q/DL variants by reordering
imx_pcie_host_init() to call imx6q_pcie_enable_ref_clk() (which powered up
the PHY) before imx6q_pcie_core_reset() (which powered it back down).

Before 610fa91d9863, the sequence was:

  1. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
     REF_CLK_EN
  2. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
  3. Link training starts with PHY powered up (TEST_PD cleared)
  4. Link training succeeds

After 610fa91d9863, the sequence became:

  1. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
  2. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
     REF_CLK_EN
  3. imx_pcie_deassert_core_reset() - does nothing
  4. Link training starts with PHY powered down (TEST_PD set)
  5. Link training fails and boot hangs

To fix this:

  - Remove TEST_PD PHY power control from imx6q_pcie_enable_ref_clk()
  - Remove REF_CLK_EN control from imx6q_pcie_core_reset()
  - Add TEST_PD PHY power control to imx6qp_pcie_core_reset(), which
    previously relied on imx6q_pcie_enable_ref_clk() to power up the PHY by
    clearing TEST_PD
  - Clear TEST_PD to power on PHY in imx_pcie_deassert_core_reset()

These changes together ensure the correct sequence:

  1. REF_CLK_EN set in clk_enable() (TEST_PD untouched)
  2. TEST_PD set in assert_core_reset() (PHY power off)
  3. TEST_PD cleared in deassert_core_reset() (PHY power on)
  4. Link training starts with proper PHY state

The i.MX6Q/DL PCIe PHY requires approximately 120us between TEST_PD
de-assertion and link training start. Add usleep_range(200, 500) in
imx6q_pcie_core_reset() after clearing TEST_PD to satisfy this requirement.

Add explicit imx_pcie_assert_core_reset() calls in error paths and
host_exit() to ensure no power leak.

Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
Update the commit log suggested by Bjorn.

Changes in v4:
Refer to Sashiko' reivew of v3 patch.
- Adjust imx_pcie_assert_core_reset() in imx_pcie_host_exit().
- Add the delay explicitly after TEST_PD is cleared, since the PERST# GPIO
might be optional.

Changes in v3:
Update the commit descriptions to address the following items.
- Clarify the root cause of this regresssion.
- Describe why both changes are mandatory required to fix this
  regression.
- Justify the delay removal also.

Changes in v2:
Per Sashiko's review, invoke imx_pcie_assert_core_reset() explicitly
in error path of imx_pcie_host_init() and imx_pcie_host_exit().
---
 drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e25f938eefe23..c94b5e991aecd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -681,21 +681,12 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable) {
-		/* power up core phy and enable ref clock */
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-		/*
-		 * The async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * Add a ~10us delay here.
-		 */
-		usleep_range(10, 100);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-	} else {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	}
+	if (enable)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
 
 	return 0;
 }
@@ -826,6 +817,12 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
 			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
 	if (!assert)
@@ -836,11 +833,15 @@ static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (!assert)
-		return 0;
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	if (!assert)
+		usleep_range(200, 500);
 
 	return 0;
 }
@@ -1451,6 +1452,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_phy_off:
+	imx_pcie_assert_core_reset(imx_pcie);
 	phy_power_off(imx_pcie->phy);
 err_phy_exit:
 	phy_exit(imx_pcie->phy);
@@ -1470,6 +1472,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
+	imx_pcie_assert_core_reset(imx_pcie);
 	if (imx_pcie->phy) {
 		if (phy_power_off(imx_pcie->phy))
 			dev_err(pci->dev, "unable to power off PHY\n");
-- 
2.34.1

