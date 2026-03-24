Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829891624DF;
	Tue, 24 Mar 2026 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319357; cv=fail; b=SKloMxnhmg4VRN07yNUg4gVzmdLlxUPSIVou7xlynGd07Kb6UXw5/gnig/kjet6IP1KeBS5roIhEDQMYtV9oc5r2qNmR+cT90GaCmbE1K+rOHF9fSkcbV3yU0dJ3kmRPoJZ0bY9DUf+QpBeowT2oJOPg53kBFCx9vU2LDMqoVig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319357; c=relaxed/simple;
	bh=Ku4zjTUo/Ct7rgaKMLscKAMFN7I5RhVRlxtyXfSw7hc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YAtDfnE3nuaWl//mfVllpoRq9bgNyaafn3dqgklOfpb4tUNraGhzLCMm41yQp8vIqmznzltpWYAFPtFvYN76aEFkaPVDixc6wZkucGAh2Sdvd0Taudzxn4eC2OshQtu4R59DeBsx/PGNf51uzMRZxlYvkCrEzhCCJ0CbAk7topI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M/d81kdR; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/d81kdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHcDVy261iPfXwFLKrGIWA+tZl717uX57cYObWi0vJW3eTRfe+X5MsyCqE7yGq8Uj7ZTW6CtrhrbgwUi8QCThhL1QXFK+Bl41UQ1KBHnKYD8kOq7kBmx0NcZr1wuQOf/KhMcoC8b7idIc7cF13Q1sSiv0dabJNEHCeGIwZzKBCeJAFQQslqRc7PT48vk8pMUKPQadHPpSJsnnONB7dFOwpvga3RfrSjjTioq33BODVP06xKJpVpiouC0xMQqm8ZenfTRQ1Tc2/zB8aXQhIo14C4QMHBXfgsDNxJ+u0H0DKvangQIdzHxVNSCp+Pxko4TRBdjrIgGvPH3j+vninrc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFWnFpJaBakxCB7metXVdtPg9R0FmhuxS3iPeJ6/49o=;
 b=XQhvMLYRLfDs9N9u4MhR7TC9iFsPbpGPixQqT1o/lkGg6VFzBaRfs3zuSNAVsiClsbUGXlbGRSALcMcC9lvFsrVv1zYMa0p7vMF6nuKuv/vCTp9us2aCi40Pl/7OkDBrP2UGgON3juOuiwP2jOl9noawm8ZG4029ZZtI3QJFahD7q2pS8UVoQxnBekiRe8KAgJqE93MfmDrARsHPvoU8Vsy0ew5aCa6IAHKl3JnsE6mfbHBPPxba+LkXnc1VcHQKTQhi1w0CU4Gqt1DRLz7gKSTsq6vhlKAEOdaZ+aSoSwB5fkLJjpKpQqRAbBNE1y7+KX9oAIuoh3NJ2wtmTwO74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFWnFpJaBakxCB7metXVdtPg9R0FmhuxS3iPeJ6/49o=;
 b=M/d81kdRagwvc6u2sTkiv/JotMiKcNryeykpcnQCHr3+m8ccIEleIHyfALt27ncuiYa7aW9CPKNIreeeibsx7FbEZIqUfjIXFjQNm5bc6+6WooKnf7Eo9STIZy9qngCmbnXjy1Hy3C4+rUbzlBxeilDkxCYz+M1eUAG+F5AsuxfADfHaNg841uB6VQtSkzVjCCWNznGbgoN21y8WPCnZds2jke06Fk+iE688IY8hYkTrA4Y24cKlZmgcc8JpUR4x/sjuILR79SlmqcRVE2jsTQaU9ugviD8P6xHGPwWXHR7Ttft5PRtwZssUoHsglZKt6Gf2l8elaG/wwsyT97I07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 02:28:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:28:47 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] Add i.MX943 PCIe supports
Date: Tue, 24 Mar 2026 10:30:31 +0800
Message-Id: <20260324023036.784466-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: bdebfa21-acd3-4781-8619-08de894d1394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4tuesq0Xf6mA2z7lOT2apcyaDYL0JTDMidEpKYOGIFqsgdeWBc5wW5Oj7p/lbkgC0xt2bmnWIVBBZ76iizRGxXcwi2iOQUHpNk7OOyuIkl2GDMpKUP9cVTjpVqQzb4j8XUJN5I+OOnH3HW8ZRilaaF7zUHggd4jnnCJQKsnZgOGBHcIajxPVu8aWdk3qbmUa/sYI7029QVjeCPktusV5zlFMtcSRzRfigYKV0KEXig50C6etNQEM4gXvZHenaHFTc9Es1pEnkTFjHHKo5NfnK/s0G1hP7aWvlE/nITJGaTGr3fNblR+JJKvKL45RqUeXxZFZkU/DuwzRdRazUAo3O91HYoEnuUeeJTSQMhpjKT+i15IPo5V0xHOfMHDwGMm2hUMxpKXY8w72Ws5UZcHgxYqnDnSbv6S0n5wkZ3ZSiVpjh/Tqa+JxXKzAnN0nU/ApjpYy1Y7X5eNwngF7H6LQ4zPXLle2XxEyw+6LrG1vQLafx4TQnNDygtAhNXDGWNACgNMdUPEd386wYqDmK7P7yfczq/MAcJ38F3HHL0eZOgWNYmrIdyidd1dbIga8sTK8ByKv2ph03HTDsoXGEiQ7sQPLUZ/AYK79E8+anQeiAPH5PixxFK8GsCD8wstMopY7/2fGvuWeyRIJElINm7p+4ek1ovbY8RMK2OdbCJgEnFfMvDZn3R0knWSJ5eWEsVI46WvE0DgaS5lBPZK70FGpFx6UfZFJWhRZ7sHW1jeuw8KCrpMI3V/s0v1aynq1jtl+bsOQn4LC+Bl4U/WEk7clTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?do/vy6dHdW4OW5sQUcB97MTZd22PiR4OsS7Au7dKgL2B+18/EnkiCqO2XKtz?=
 =?us-ascii?Q?ZODQy9aKZc2RJ4uTqBL3T6BspgylVeUUH6HEQa0iNWNlWbORYRrP6Q7NtIi1?=
 =?us-ascii?Q?GmcF393YmBGlFBViM9bgHonow3yYJTTrVVqD7pNo/PXAQTn76eMji05NMMF4?=
 =?us-ascii?Q?eRN5jzrqkSCNY3mOVQimO0F5QRCTW8GOswh6+6vVcQrKq2q9uIlKKN0roOUU?=
 =?us-ascii?Q?4Ully/a17uOjp+1sEcfABa4CG9OgXMQEiYtq/9zsc3//ebZTKyvaHt+IUidS?=
 =?us-ascii?Q?dvBZtOmZ+xE3TgMSzPQCarhssWVSIDPeiRk6ETv3oNfIRayt1GJIrmj2mBjC?=
 =?us-ascii?Q?3fUY6fkQJd8Xgwkk69yCfgxo7pFGo2/v2Vn+W7vgG9/gil3U0P8IJeh2L2TC?=
 =?us-ascii?Q?3fcxJT32yer/Sjh5MMpJFQC7a4gmV2qwLNHChLMxCUMSkYcVL9l7i2yy8qA4?=
 =?us-ascii?Q?bhm7HYxAz7RI3QLS+1mCooD0H4uOANX8SGNTvsh17G/MG/+lFs0wZZId/IbU?=
 =?us-ascii?Q?TkKn2WsIEWNQEz9ESqe7cvUC5CLTmD/sPZ4aKoVTnI00lQ3T+NvMQub4l3IH?=
 =?us-ascii?Q?/OaXgVEfXJMBF1FFG3abFJVJ30IBJrfOi2HDZFpVyzENOvI4XRtHrqtiuPKF?=
 =?us-ascii?Q?X7p2SLQpcVPs46NeQCIJCs5o7jpVWAYdJIKl8YdRPpAN9clBHJYhRCOusece?=
 =?us-ascii?Q?BDdRSWsQsASppbXFvfnFSIVD3AQlWTKTrq56DlZm1DZXfHBBwIsVstExmmHu?=
 =?us-ascii?Q?hB356GL2ZKaZRWOWZMV2QSY6FTqYJn1qbsBTxZJs/csPx31QMIzjBiYvfxsy?=
 =?us-ascii?Q?djUU4nIM8Rv+U/QN3cL1C1N/QPfs8bUn3wx/wkQy+1XzNmqoBNQFASU95fV7?=
 =?us-ascii?Q?GjLsQab0tXI/vjD+k7ZCS5dDC2DZ4ZIgvUlO/6d4Ep38UPc7JVVY44WNv3FX?=
 =?us-ascii?Q?apBcuFv7G683gypd8+cokU2Pfui5Aa4Q/X/fHjkik+ymds3DKa0dXLfiOlZH?=
 =?us-ascii?Q?ECqoox7e6YcUxv9KN4byHxDPZsZA3uT/NGz2Fx6PlFoXCqoGTpKoY3FvB+ih?=
 =?us-ascii?Q?SLeL7xyj0QYEmim7/rmIDxpQ4ULvDRz3PgjDmmAJlQOfHjX8+NeX43jh6KHI?=
 =?us-ascii?Q?x05wIOzcsPBkOzPbCMqgwezAxA5FeqmZ3XANoEDRWV5v7q0I40bcvey/YDMn?=
 =?us-ascii?Q?REdkgtCSlciWHJ3rt9kiurACMch7umjedKQhlC9Gz81Ft38smSfjFwkk3uXt?=
 =?us-ascii?Q?m6yiG/md6QLjpUSJw6LdDKrC2p9O71vAfecnBezefQ0z1CMT4FsBdDJjLS4F?=
 =?us-ascii?Q?0dpmtsRQfz4sJabOkL3nWnhdfC7uXe6l3Ce9Xy3AHDdvA+XWgwoCPaI5ef7y?=
 =?us-ascii?Q?sIKHWrzBLKutB+2PRsjiWoANVdqP4u9KxDMa+tYA/ZnpWjLEMi7aACnY0lH/?=
 =?us-ascii?Q?QiuCZBPt4RsJiSgZZq+QbMPxMOo7EJmjgRchQKEjChxLHau3jq1tejpG0Ypy?=
 =?us-ascii?Q?nYo6XnG5EiMD00d3TnxbORZdv+VsXscxXK95XR7NcJ5ieECP+KEtOsUzVjnP?=
 =?us-ascii?Q?DY0ZufRVEo5ExAGyvvrx4arqmFWrktxeSzVA4hOU8EX/nv/4kZRwqMKKnIAT?=
 =?us-ascii?Q?qbSreNeT9KvBX6d1NZ1vwHmSPTHubmVbYeHf+gqnizSqRZP2psATYpUuLbKd?=
 =?us-ascii?Q?zQljry8MYjsb64zslVhXOxEnaLo/78Jd7+FkE1Oaa4IeHIzvOUKxYSi9u2kp?=
 =?us-ascii?Q?twIQO59LUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdebfa21-acd3-4781-8619-08de894d1394
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 02:28:47.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+DA2nKKMPHqhCTTJjw1PL2DtBgg7cTt92JkrJRKo8+Cpr76+c0/oKo+hHmssNVl21Jj5wSaT2cgZ+HnepGhhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
attention to that it relies on the patch-set[1], and the PCIe1 port on
the EVK board relies on the [2].

Both of them are included in the v7.0 kernel.
[1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
[2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/

Changes in v8:
- Drop the redundant strings since they are compatible with i.MX95.

Changes in v7:
- Fix the checkpatch.pl warning in the first patch. Sorry for not
understanding the comments provided by Krzysztof in the v4 patch-set.
- Adjust the compatible strings in alphabetical order.

Changes in v6:
- Let i.MX94 and i.MX943 EP mode compatible strings fallback to i.MX95 EP
mode complatible string too.
- Add missing space after "=" in pcie0_ep node.

Changes in v5:
- Add Reviewed-by tag in first patch.
- Add i.MX94/i.MX943 compatible strings.
- Add "dma" irq for i.MX94/i.MX943 PCIe.
- Add 'fsl,max-link-speed = <3>;' back. Because that Link speed is decided
by pcie_link_speed[pci->max_link_speed]; Found it when one Gen3 NVME SSD is
used in the tests.

Changes in v4:
- Add missing space after comma or '='.
- Remove 'fsl,max-link-speed = <3>;' in dts, since it's not required anymore.

Changes in v3:
- Fix build warning in the dtbs_check.

Changes in v2:
- Refine the nodes sequence refer to Frank's comments.
- Rely on [3], and remove the duplacated codes mentioned by Sherry.
[3] https://patchwork.kernel.org/project/imx/patch/20260204022306.2372889-1-sherry.sun@nxp.com/

[PATCH v8 1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of
[PATCH v8 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943
[PATCH v8 3/5] arm64: dts: imx94: Add pcie0 and pcie0-ep supports
[PATCH v8 4/5] arm64: dts: imx943: Add pcie1 and pcie1-ep supports
[PATCH v8 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1]

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  4 ++--
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     | 18 ++++++++++++------
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 29 +++++++++++++++++-----------
arch/arm64/boot/dts/freescale/Makefile                           |  4 ++++
arch/arm64/boot/dts/freescale/imx94.dtsi                         | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943-evk.dts                     | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943.dtsi                        | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
7 files changed, 282 insertions(+), 19 deletions(-)

