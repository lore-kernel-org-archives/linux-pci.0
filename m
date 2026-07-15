Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBA30C366;
	Wed, 15 Jul 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100457; cv=fail; b=YfdJW/HbP3MJ2iZXfm3aLlGURhINEY5pO6tOkEd8CTZ0hGcNT5jeplw99Gw2KJ8Uh+SXCe4S3oUjQHqsNAUiU4U+AkCY0HUCBxTd4hY+P4+1m/E3LymavFCqd5mTEPLtQ2NAmPg0WIi8XtssYjdvDlzq81KfikzHF54/7OcK3nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100457; c=relaxed/simple;
	bh=U94Uc2FyYzDoOVjVAdjE6MV+DMflsm4YTVuDMffO4G4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F7w3bR28eeAyKY+NRZaYE9JjEPMFVUvkA8WkU4r5S8DbVG81tgpi4zQTniPIHg0pvAWJyh84SqhuyNksJjlp1LhvQhxjkn5Zad6cfdR0u3lWXsnIDIfnU8T7yRUbwLuFK5zJmHozGMwtg3krqw+q0d2fj+X7pB3Ptn4CwN6SCLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mwaQxuRM; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mwaQxuRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSRl0j3Xpmuq5h7xzWHxxgOCYaxnxAPxtMAgjp87rwVuwcOU0ol2U8h+YqfY4cJsmcieWPQNz8Gwkdm20JihpBqSGDKCdPIiiUfT/zJvCzBj16uUmtKziNa5Ktt2aGmNQV1xi6MOfW5BiRPopizP5nXrua/hYUeQmGVppsjruBQVohfXg5jwzAJ0EME1DrLwUe1gsXBIkan0Z5XuinrP45W5la48Jr4EycxipZbvcOohwNTz0vA5FmZ8d1MG1Fl+1z9/5DZ9cqh7/lA3S+AI4N+tr2XSIN6weLW3o6+L5uCYBKt1ZccNXK/5jVUWau05GY2GqXV04Siwow3rggcVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9QFvmiYL+amOYl882iiaXNj3pwN4Op7eZUoZrOqR/c=;
 b=Aw/lJtlie4B8MmJ5VMB5XZFBnCyJ/NbN6ilaRvaKNiYKfzN3l/x9W1ceIzC0g1H3s5R1jJLibVPDek6aQQH9S7oXkv0sGUgn7Ia40C0My3YrYYE83pxdW6087KRFBfqAjvhwEKGv19ol+IeMNZ3qNKb3ajrggio7asT3Z1d64DKEOjRe+uOzknGAot34BaD0sjH1VDQWr7rdbJp3atXo+eoA8URUrh370NLUq7Tr0sIYbEStKF1otvk1IflSVcFMip7iEdTma3QkSyFFpKr4pyWeZgaetQ6H7FOs1T9LmdPX4dJog2+MODluOZH9+ag+8sZGHlpFrZ3EVBcrxvum8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9QFvmiYL+amOYl882iiaXNj3pwN4Op7eZUoZrOqR/c=;
 b=mwaQxuRM8DHdEV4EbtbdqV0HxkYLlXvR8Hszrvy0ZkB7s40WrlQ5mntsBgAH8OIHVknT8hoX9Rsq+px4CBv3571j7y9MZFaOzgvUBLENQLTT3eMakEUhtQmCnkG5LiOs+/Q2DAmFST2zQm9spTfSNy7sOX4LDou7RjHFqkqYP1UnlKN1Tv/TbQhYu/k1dwmld949/tRztlybZ3iMVHPWNwh3nQsZ9O9iOK2okKh0cuvNBZ/qVwkCIv2eb/eAbvQ1aAgfhAmEqanQ7y5sb6QEPCdyAiR5QIDIQm4bPUBmeTbp3Md02CSh58ezFHgGwnZyoH0ALjJPPRlQdtYzBDrwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15)
 by VI0PR04MB11868.eurprd04.prod.outlook.com (2603:10a6:800:31e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:27:26 +0000
Received: from AM9PR04MB8083.eurprd04.prod.outlook.com
 ([fe80::44f5:bd7a:e05b:9a41]) by AM9PR04MB8083.eurprd04.prod.outlook.com
 ([fe80::44f5:bd7a:e05b:9a41%6]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 07:27:26 +0000
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
Subject: [RESEND PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Date: Wed, 15 Jul 2026 15:30:24 +0800
Message-Id: <20260715073024.1377228-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0057.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::7) To AM9PR04MB8083.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8083:EE_|VI0PR04MB11868:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e17177-ac39-4dd2-34f0-08dee24284ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|19092799006|23010399003|18002099003|11063799006|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	eKE5P/b2CeugF9sGp7a/6se1lTf8875qQ4Vr6h5tYAoNgB/vuA9BjNk0lLmUsm7fQLGLo4LRF5Q7Pkb6WekMlCjfdPTnjBBkcmphLePY5zo3mqwailPUMs6WidVAFQPDunAe0LXNiEWMPxSuGUG+rArVWw+FF2zur5d/SYUuUnGyKI5DkiBZ2VN5Vjebg/JSsPdSIrhbtqhOnAQ3+kzU3LZQkygCLVanLdwzSv7T/5spsBeaTBMJ7ztR7kNwdaIS0U8E0iOTJL61r/HZ0t14+1HEmvNI1q0OtyXFadb3pxWFkeY5m32c4C/KLL9AViz7XeBRRd0bFP9fp5SJKxTF3rIgEUNFpjdSwFvQicd5WDiSJGioBJ8qFjnmoY0Dn03qp476rPPnqG3e57GpUvy+pJgk8QPJYvcSoe7x84Rb8U7DPkWgB0YoSV0v66oWt82pE6zLqQF+//gaoDV7FfcHcJZ04l79On3vxWaN/iolf1OE7rH7FX65ncDNJCubTSk41P209x8nDCkYyRZFi1qPOFCEfLThgTq7ICtu+SAZVV7nP+TKa0sTDcZljOZSR2HeBQgsQYO5cuVi1yXHko3VZtk7VJ+6op2Fz7cDnY9qWzcWNWEpZBMLuPHJmGupIwvBW0//lXpJnb0EGiYwwYodDJxeAqIAoTECko+l4lNStvTDX5TOAcFI/USwTPV21OkUhDfzUKRVGSyyZO7IJOknEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8083.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(11063799006)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KB66oEuGeLTyKBaIMi6EPjBCQpL5L6dzxfOPz6EcCvxw0AjrCUrs3K8K5/hm?=
 =?us-ascii?Q?/eFGuk1yl+KEjxzR39B0/AbK5OhdNlQFP0S10ZraVYUJyGeyDnRm/CLFbwDG?=
 =?us-ascii?Q?zQuO6Zl4Nvkgpp72rwdl/0/akr8pj2xfYemrfyQAsZ9MhetcYa7kXfkyu2U+?=
 =?us-ascii?Q?7/T/cAI4SEFMrY1bMDe20Wt+vuDwegKqEwxb4nqROPxXX7CWniVdsNJf8obh?=
 =?us-ascii?Q?ZpE9zDg4/qyWpyWwg9zZfexXa7iuZirrd64M5PvYwu4d8O/WWVfnZmOQnwJt?=
 =?us-ascii?Q?b7eab+F/xmwJUH+hVF0sqPyt2CK0YbGyzciZ7eeSYDjjl+F29iNN5koGmcIe?=
 =?us-ascii?Q?8dXaOfbUZpB+EwkBXlg5dbOOxwOPMIxnuauUpjhMIb7LH6S0DmTJm5qYRPNx?=
 =?us-ascii?Q?FI4rnBJV0n4h6HHEn55Odif3vBqXh/widVa54GfQfomMLCgfLq0dOj2pXeIE?=
 =?us-ascii?Q?ZUoTgfRYHLBNl2ULeXGShUeHyoPbZ7Xf8TjHApEPtzl6kZRi3HQtEuFzFOhJ?=
 =?us-ascii?Q?ScAy8GeXLBGCdaimmFlwL6xxv+s/gd5Pm/QInncHQUVcgGamMyoy9pc0WXD1?=
 =?us-ascii?Q?gRNH6A2L/LtgF4lt9FvgaZKihRgOS+ZemxL/2TbGRkwWZKDATvZh3SStjfZb?=
 =?us-ascii?Q?ON7JHrkKuIHFuT3xl0SzH+TRfeAWCPWrmsDObzP5VGVEYRkzPiO+ELgeN9hB?=
 =?us-ascii?Q?yTfDKPsU3tb8bWPY66Tdsowx7l2Vovpy/bAPSklXrIPSAG3NtXZV5nGvqqDs?=
 =?us-ascii?Q?A/wVh/qdBkJ0FDt4z8ZvHgp3HnhNpw9yN92nSotK9NFkVd6ZFepMC5Sl35Sc?=
 =?us-ascii?Q?RDUiJNjC+HDjZW8izOG2N0u6nEQSgM1uSB6k1OX6Xa46a8jxAgx5M8pq/O4Z?=
 =?us-ascii?Q?Kj2iOL7uDrTxHYPIMhfiJ/aD0+1zUBw/cAdCic7enqHiDkEUIXolYBnKhQOf?=
 =?us-ascii?Q?dt9yMQHcah3NrjysmmQZZqJiqoOB/8AR0fBh12kejVED0yD3jhQEOiEzYIyZ?=
 =?us-ascii?Q?fz1VBbxzjXKQdm941Rtlm2AL0Grm56vfzDy4wXIlir/C4MGdDyx0tf4SGigd?=
 =?us-ascii?Q?dpVuYtYtdBAMPCCR1yoZUhwZMVQRXOaXZQH/bEZ9jB29CNulHybDuaTPC8of?=
 =?us-ascii?Q?tdVanKDNc3DuqX0/MgBvzSdnwVAGv9D5SW510KQngBJzVJt36nn5XgbNh17C?=
 =?us-ascii?Q?rHgJFJ3q202AB8QHgoSXlX8sw4IizpctsnWscjt04pEL2O/uqp7R/LvKojyC?=
 =?us-ascii?Q?GLWfX91nhk3RdIUQGNL2doTZuAMUWc9EH8lnHfpalgg3Hy4HMA2SNecSbZaa?=
 =?us-ascii?Q?SnlKqZkP+vShFaFetr/BI0EJzQ7dvGoJam3xhQxDmsuebwyeW6zhXA75mQaX?=
 =?us-ascii?Q?rqemFtGmdJBKU13yvtmUyuFioZhEiesAbShbtrcUUBkqsoKxjug7IeTehhZd?=
 =?us-ascii?Q?tuspgdlnATIqmg7/AYkcyiovF8k9TlXreZLUPF5Fi7mLIHnbLeR9zZ5STmrW?=
 =?us-ascii?Q?2/Nu20ydWpNMYbNp3PH93emLpm4p7963FsM+BiFbiGCADjrWvJq2tf3Ih9A8?=
 =?us-ascii?Q?haTTfL6gqEpU2Wqhpm8P6hHVI7bkEdGRH5SFU8KWf+U61umNeH2YtamqiUSS?=
 =?us-ascii?Q?jMYegohBnthxtTaXJvdqHZ22pBJOWW1AZOGiEnri7kVAXnmUI5ZYew+ILtq+?=
 =?us-ascii?Q?wUW4ae3Rg3nakyFVhADut70UfcCyReG9ZqeMnz5i/JcNg8S5fpo4HvtpoQR7?=
 =?us-ascii?Q?tlPseQHJG9Mg4+82bjdTO2+c4AHEpjBHWf4gd8eEovcKiG+Hem5L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e17177-ac39-4dd2-34f0-08dee24284ea
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8083.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:27:26.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl51iDzpp4iI+IG5jx3HD3PYGOJ5IgjDvQ9RU5YacxE+gkjnMU8AzOOZ6eQmB/7HPHnv5chPXMaQ0Hxu9/xqWzelydQTFMssj04DuDNXU0m9WNFFYssr+FkzXH+p5O9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11868

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
I'm not sure the previous v2 patch is sent out properly or not. Resend
it.
Previous v2
https://lore.kernel.org/imx/20260708035928.580236-1-hongxing.zhu@oss.nxp.com/

Changes in v2:
Use devm_pm_runtime_set_active_enabled() simplify the codes and error path.
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fadf14de10f7c..9a574c7dd74fa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -132,6 +132,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
 /* Preserve MSI capability for platforms that require it */
 #define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
+#define IMX_PCIE_FLAG_PM_RUNTIME		BIT(14)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1978,6 +1979,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME) {
+			pm_runtime_no_callbacks(dev);
+			ret = devm_pm_runtime_set_active_enabled(dev);
+			if (ret < 0)
+				return ret;
+		}
+
 		/*
 		 * i.MX RC is powered off during suspend, force L2 entry to
 		 * ensure proper endpoint notification before power loss.
@@ -2126,6 +2134,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
 			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
+			 IMX_PCIE_FLAG_PM_RUNTIME |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
-- 
2.34.1

