Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD233B0ADF;
	Mon,  6 Jul 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329246; cv=fail; b=I4817xxV2mlmqdXzkqzp/qbukxInpVrLvV65jm7vGXpN+cXm39tl+1Bdixtb0a5OZU5CiQubh/ynCVE5mi3AYrxzMI9WksMfhqgzcq7iUC+JDKaLVPrTQ+n/hm6/vFcTqI2hLVBI2eFqVS/7iBZ9Cx3B4AlUMsQMz9R9qybab0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329246; c=relaxed/simple;
	bh=L/I3FLuER5SkOBrK53tAjInoDBxDeVS98sEzFpzfo6I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sZqkbAY8BjbXO8t8TvF6nMFDUHbuMeEvOkmXcWHBW0EkKZRbq9ozd2waYV6LJEyP4wszaeX5tYOGfMS9nUz9QbeORqrqURzOPCkhtuQSad+hgqZaXIHNgZrBD6pGTlA2PbuMGhmJLoxF/OmiFuLpRHEv0FcjR2cJRKRANtmzbfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iQpwPPxN; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iQpwPPxN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd38WZZ78u1dyMUtFgmAscaJHWxUoArSIY2BnpmS8qQyj9421XGgO7Kdw5CvRB/rBH0gZ4rTvfb+v9C7HNeNGSrFwHnNmDiIY2eQTT8o6GK+hS5wyJRlOT/tuQs8Vu3cb7chiDIaYa5q5vsJpGOOZ3EjFzoPC9/6SikYrQPrvjRqXel/0OLbsdnTsO7kCq5PlpZvgSFtuvmCeOtaPCQYeEtv+d11cgupkyDHBHrWUS7ysDo/20itRJu9/durNDFAXHhsN+dw6dJu/MUJHFjppWKvAbNzd5xMPK43pY53P1XEjwmso7ZODTU0t6F01XpjKtpSuHEZT1UEMLOpJkSrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXi0LHZUp3ZGpgcRmVVGJbsOuYatwbyaUpu9C/eGDDE=;
 b=GnfFdFNBkdkB5SOLLypIMDHkKcxrFmaHRJZ7RRtkR9JitqOEsvtnnn9HT+tH6K3jV8lwLX3Cnb2hfrFo+QBRuDg9/P/PQMy2zUQeNjT5wI16rhJk+bpORjVaLBvmVGQKgwA+yZDugojlh5T7lR1jnOo9QNPa9jWftQ3SCZPbDGmnnLtpci8uHBUYf4Jr10Bl5KImpu+/DbRdcTP2UskD7m9bY37rlxQNlUHksgzT6v2BW1F3K+LMHqutlqtofFejEiEuVmNyyNLqeeh+oxMfnVf4YkaJ9FdAII35mCDTXj1fYmaVZsqtz6yHNKssmoBlZ8e3ftpvxH7/ke59qCRRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXi0LHZUp3ZGpgcRmVVGJbsOuYatwbyaUpu9C/eGDDE=;
 b=iQpwPPxNC6fDdUTkk8T4bp5KW6OH1zbL1OIU75Y7AOo+YmgjiwOFkVGC6X+zoGnsM6d9uENhQ/lYuChYdDJX5AOIGgixXUvlXMTaXH3tMfjWEfGlxOKeR0YUAoQ7149C7nwiXctvdb9rD0dbdTgp+KfQE6wKZcyXZYGtjhj2sGbFw1+0u/QGaQUi3fejUqAlIb10f0Q3iJryz/MrqJh9MRohW0lUOfGx8QO1vVafXJeObau0tkJM5RLFqJ42rYBQo3q0Ia9I9GCOPAs1znwtQ2LmPvpXa/xDLGUjUwj/OKSdiACozADTRHEgP1LNjxkQ4N47ofut8eCkYerfdAPdsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AM0PR04MB6852.eurprd04.prod.outlook.com (2603:10a6:208:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 09:13:43 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:13:43 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: imx6: Add runtime PM support for i.MX95
Date: Mon,  6 Jul 2026 17:16:39 +0800
Message-Id: <20260706091639.3886856-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AM0PR04MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bb26eb-9bcc-4c88-6f81-08dedb3edfe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	vhaPduv7Wc7PkwwRqfOAXE08Pctno0sWaQk27eCACh/GUOFoPkbsJG3a/4Iu6xbvihbJd2sVquREks946VKWBhGTdr38dqvoS6cMDDen+kZRlu8MfXZgUf5UvREImmmCCepEMfUGx3gdkPkIIYTQeqV2mrRhXxKuJHk0Xwqd6/yFJ+thY/W5Tfht6ccI6Ue7kgpVG+vXa4HDIUthEKyBQs5Odj+5KRuIv6BR7SCxogQscyTqovXVoR06FtmN0JvpwBQjcHcBp3U0KDqOKcmbkpKIFBntgVd1ofQqsH0KO0u3RcH46MTRc1EiZ46fEiR1On204/EcTz+aUdUa/PaFsNXsleJpphWPFjPqRnnAtAQXOZnwV7kWjoiHtoyB/smxtIAsL4gtMHJKxakIG20paw99CtK6VDKA1Uvn1vugrcGYyOdJifr4xRsMSERivWsizdlAq3UY5/Iu+FGPVfkfDLQK0rApbEPBsF3oXaSWnWj59T3Vh3O0ZA+91XGHsKm6rwQJJHv58Yb1KZaCFsVL1Q6iNT08bQx1OMAuxQaWuPmOd+9HvqGVQbe0+/sR/gc7U0DiVdcAcPWDm43qF4rYkWQx3YPnCyzJaa+9iyP34KIQViQ/W45Xxdvy7mYxMwvbWr1Oo46LJ6A4gN9Rlnft2wjIj6Q/r4ibOW6COtCatbgKudmRykJ0RjhCCRoCCPkzSK0yqkAJNVAwM2xYm9tuUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/X1aKShcrZpdRgGL6V/yBH7lNBAxVVRLVrSooZ8RGEEtAPJtdd8hpsmgLXU?=
 =?us-ascii?Q?5TDAg7WvZUF2PMIkbV1QYAIrq8FS4rcKHGRx3YfMfUHUAMN58ZBtqoZZzeYi?=
 =?us-ascii?Q?JGzuqT9s62p01hXdBW09HAH+Pn4X8RfkpKWCt5j60AWGKH7S2+pLunvpzHvO?=
 =?us-ascii?Q?zLfMT7uJ+krTmyBEgvFOAyXWOtKGatk2oLkVpPvLUKBi1c132kojZ/2iu5un?=
 =?us-ascii?Q?vlHGqntrzGLPfABia3kLcqtv7bUJ4qSkYXnzg0699L60mRaNxmDc2DCWttqT?=
 =?us-ascii?Q?lHZAGjGgjJMnK7QUbL+z5KDAOpVGRowUa1EoY3kIhI5oNgGmfToJmhYCi6q/?=
 =?us-ascii?Q?Yubbaei2V58Tye80nMJ9UBmsSiFBsm/OpvardOGEO3dhS3MvNXXycN06/Unw?=
 =?us-ascii?Q?8nn1+mRLp0fQ6kQxOv1oOhiy9ateHLNM1sx81ohBp9niChihzA5Qtojs+G8g?=
 =?us-ascii?Q?jickhG2Es2JSOzv6sIkKN/bfMd38191P1zfuwD6qBgm74yGzeNbzCGf69pCL?=
 =?us-ascii?Q?tjxvPl2eteeYlLEfalbLLEJguxDvDy1MfEPq9tRkNt9oE1wNYSwrNyQVxKoJ?=
 =?us-ascii?Q?1Uv7mM8oRLZJqCGXCwxKT3e5grMNO2TYf9hYSWoWGiq11CHUyQVXSiIiAx5/?=
 =?us-ascii?Q?6oE+H6ghlYBvLw6VoHHG8Ls6Fe3Op/XJCXWSt6qhwxIiTMvSuqWuzz04QLOo?=
 =?us-ascii?Q?dhL/QBNH0yC3YHdBp0BE05xehPJKEkUtAgQUKSub3rHo07Yk0DAnKVgCfXzB?=
 =?us-ascii?Q?tqmDitzIBb5pc/APabInMyhgCoczgZ6pW11+th5J4Hew2L3bUWw7W0xQc9CC?=
 =?us-ascii?Q?DPvV3M2Fam2bAq46n3snYM6RI/5A6/Oz6zNnazQdGt5U6sbpXHtVmgfaRn0C?=
 =?us-ascii?Q?ioJlu58Nl5XbO9lnBp6i0ZCH59EXRDLmMEHC7E8rb/25gzmaRbnwJ9TmIW5U?=
 =?us-ascii?Q?K9J1UR050Jq5r69emBIxpmnw9L0LIPsyOhDk+UawVQLnbkadEbYpqpwPRpR2?=
 =?us-ascii?Q?tBLuSHVjXYGjxuYqhbV3x42EpPqVqQ+5qaC04b4Gacymau55hiJXwJbWWB14?=
 =?us-ascii?Q?/0tatFUjg0JAbH4WeQzjWbrf3TGVblnRTGUGnTmQGo2wqzXj7t97Y3R22Zh4?=
 =?us-ascii?Q?IeLACITcrSBQgRlpGu1TjCRvgzLXicbiwvXVL0neCN9L0IYMdLBcgFDMP+6j?=
 =?us-ascii?Q?WBX0v96rd5QAEI6TX3U/MjQA96waQ/BLzUnb/NyDMjybwawLKtvMPi0cvYaz?=
 =?us-ascii?Q?+Ysu4+AYZbhoV8zMdhrPNIAkZ6MVpF0VvtZ/R0COeaEpHII5OpzrVoV+roPd?=
 =?us-ascii?Q?9UUgjezdHr719180pwG2XFNAzNi06xq5xrQNZaSb1y0w7MAThtcz5RVh1L2n?=
 =?us-ascii?Q?GqbdQRLf8gsWxgewcRB7+/A4MLXwTuXP3sD8Nhg7E/cXv1BEm2A/YqdHHEDy?=
 =?us-ascii?Q?L4mxUHIBLOs106rQ8S1eNFNe36Clfui9+w7fUuXzXXxgTuLbkm9vCfz5EleY?=
 =?us-ascii?Q?PaEZ67GPTXyuzaOG7veotia6fBKPN8crkeOz5Ya49gEZm64LQuZLJ0qW6Xox?=
 =?us-ascii?Q?q7YI3NK9BDFX19BF7L8hYczIXcOMMiF9Q0wu0dsC35OrWmQNcIUlR3p0IGuu?=
 =?us-ascii?Q?MN/veWBjhIpM1t9/aNDlkeBEfYKYiMKldcZei1P0ga6MoUkwDQv4VzdKSR0z?=
 =?us-ascii?Q?2e2s5CI54vArQwEvxB71DMhM1q+8MYV1W2PW2B6geK9mJZVUDXOTz+bp2Mk3?=
 =?us-ascii?Q?5SuWgFKpXwdXsqG0KyRzvVxBq7cbUzuTqwPYS8dJ8FHT7kZzXT/D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb26eb-9bcc-4c88-6f81-08dedb3edfe4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:13:42.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxNsHBOwzq8Z36LXpPCRpUB60gaAkDh+38NSmWBkihva04jhitJ9rUJHRLFHTYnYvKnQ++kLBmapV/v6r48vU5DOamB07KZsn0xvnjGFwnq0K1+bPGrBSwjWWrsDfIgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6852

From: Richard Zhu <hongxing.zhu@nxp.com>

Enable runtime PM support for i.MX95 PCIe Root Complex to allow dynamic
power management when the PCIe link is idle.

The i.MX95 PCIe controller supports entering D3hot state when PCIe
devices are not actively in use. This implementation uses
pm_runtime_no_callbacks() to leverage the PCI core's generic runtime PM
handling. The PCI core automatically manages D-state transitions based
on the runtime PM state of connected endpoint devices.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 023145b0dd2c7..3c13f9888ab9a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -130,6 +130,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
 /* Preserve MSI capability for platforms that require it */
 #define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
+#define IMX_PCIE_FLAG_PM_RUNTIME		BIT(14)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1982,6 +1983,16 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME) {
+			pm_runtime_no_callbacks(dev);
+			devm_pm_runtime_enable(dev);
+			ret = pm_runtime_get_sync(dev);
+			if (ret < 0) {
+				pm_runtime_put_noidle(dev);
+				return ret;
+			}
+		}
+
 		/*
 		 * i.MX RC is powered off during suspend, force L2 entry to
 		 * ensure proper endpoint notification before power loss.
@@ -1993,8 +2004,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			pci->pp.keep_rp_msi_en = true;
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
-		if (ret < 0)
+		if (ret < 0) {
+			if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME)
+				pm_runtime_put(dev);
 			return ret;
+		}
 
 		if (pci_msi_enabled()) {
 			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
@@ -2012,6 +2026,9 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
 
+	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME)
+		pm_runtime_disable(&pdev->dev);
+
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_assert_perst(imx_pcie, true);
@@ -2130,6 +2147,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
 			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
+			 IMX_PCIE_FLAG_PM_RUNTIME |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.34.1

