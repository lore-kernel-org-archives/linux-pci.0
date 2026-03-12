Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123BC38B7D5;
	Thu, 12 Mar 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307594; cv=fail; b=iPurdrPQ8oR8ZpIUtt6P8yh5lpf3rI4T4kYzcTSgqKLd8py6R99UuGCTg2kIL8O9/RCcdeRJ9kejnnw9BrjRJThrhxyks9SCDGxWBPS2td6PdolsrkZcNZFbgoLyIiUQfbJxBxQpkbynOzSSYMeuWff+zThLD5LtA7gZjmSfz+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307594; c=relaxed/simple;
	bh=fRSUjST9HzePb+Kzruta84LVdbyBdQSOrEd6XQCz7Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q6D1JA4PLCyV3tKYrjqY9xXDUnDsRBrs/d2LhKomVtgfTde6zK1mjOQbkR+YFp8yM0UENXx7Sy+4PuRpr81NPt48AUiYc0EnQlNCghVw/640XxPHRzpo6RzufxAoiyrpa/yCsHJzlzHok8PZ7//U3yWsGigZvmX9nOJKHDORwRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IlnU/omw; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IlnU/omw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0bI4pDmxIoVtQvqxe+lpgg86K/JK65dHH6Oy/kDV2k/SyUVs7cM8Yqi9kFfzpGFDNu8YT0uJ7ATT2RTU5s0+dp6gTmT3A4kIQm0Lce9p//Zu9iImAegrWhjOs4rbusFaWPeN0jjE1b9AwIVzSvl9PH1/Xq22YLOl0w+dUpfoSxx/cZNzsKVO5IoT2oVA+4+zeje/KQE8FifhPHiXwb4hLDQqAs+WzOwkaiklhBoqhwvXUqUHCWtR5XrJRQbJU9BNz9jM822NOxkIBmyl6QQ0Dn1Yn9UWWT3R5qY559ENjJ5EbCco67tuvtyeXR7UwEKZ/Vt4ioj+lbxfpaMINOowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZwysdxOuDQK9k1RfdnqTKAR1QV1SIamEnlLtls8egg=;
 b=H7PgZ+TX+JxcNaRm02ynbDwOGEMceOWQ9YC672mOGzUBdM9fj1wvglRJyUm/jLKR1h4sOk5DvZW3Y0UJjpAlV1nUK7aq96kz7gKaiI/3p9YCk+AMdRvMQsjyX7wotdN0vLgszVAd9IAlFoUvfcmsCOiGzAcA3gz3krjQ7Dht/OIBvfwRmulp+6VCfmbyDSKkCxMxJAVO64LZ+M098rteg6KOxt/tZU/lWwnTIcqVa7Z65cNsHcRerA3fM2TRGC+H3gScuW77S39QJt/J5QXtkkN6gR5dVZARYq0ctm6uObxtskMJ+WTixuXQA1NHZS45N2mCMuT9VMN6UEvVJoKDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZwysdxOuDQK9k1RfdnqTKAR1QV1SIamEnlLtls8egg=;
 b=IlnU/omwhUdfvkqvZsjpXG+3u5sPXnszo3MTYHZNc7Vr3AP28Z8ObxoHmMKYo//se+J5uVOxWZCtEvpfWKHoNuWmqL8QEO6Gt5zC19dgxI1Eini+LB0sMxMwnSixMSDdnVNwX0bVDzpRXyHF/DRdo8fk58ATMVYROckR2N0wqYmrKFf3pAoZVcAl7oDhfRxyPstoG5houkyiCGNzVoWBSxbTeB+04AuJOj03yEx6NpaWnPgonIVI/MgUK+8hC/zqyT/oQOZTax9KNCBzKFET0qKwvqiv2H3j1JXF/hhPXesYeedjLLF31tBeYdF02ts+WKyUJKdSj4cIMus3EJgbeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:26:27 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:26:26 +0000
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
Subject: [PATCH v5 0/5] Add i.MX943 PCIe supports
Date: Thu, 12 Mar 2026 17:27:40 +0800
Message-Id: <20260312092745.295578-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f597ee3-45e7-405f-628e-08de80196f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ziyx1QBgm2itLSmhAocFcDwtZBXkWBEJH7+jlBz7phEds5oc0jHVo+9JovLoUV6heUJcrDdeJvBPoHnsHufMjvT3h3Jeo2ZAA0qfMtf2aHPEcTO2R38DbtzWWlzVkjUo58/YQNpA8JykuZNhCh9+MqSJW4UjuI28H93acr4geHAmV+VWJ7R3gedwEDMxpZ01FHiHKkalP1pbU/Iy0geC8YRuH5rceRfph1OGmmJR2w2VdicSIv3oMtNVYEOsN4gvzuYVLbgmhZvZmsBwev7vqDWL3NGaJ72P2t8QGZSvs3spFHSFKI2G1YFB+PJmFV3zAr0cEi5tluGmSI9iiaARmP7i8NC+IpkOJiVtgYROIXq7vyfg7qmPFpSQ0Tuqj5zf2kG7uKLZKhYoP2nO0Tu9u7MAuHGI0A99LrKd/DCKcY6X6Mb/TOcB6/hxW5SXbNbvKdEt42PEI7IdFYp72ECSSOJixU875OFwxJ/iDfPhKvCdOM8pZ3/5x3S6WOmNNFGb41ElK4JydoDQPWFQ1jtyjwWNzg9POR98orZEvjkRCsfrGGx1eUnMUAJpX4kRo4YxmEU069GiXtpP6AlFWcZrnpuP5zlDec5C/dtv47Mp8NTj+grqhrplVny9Kqc7DdW0eP0cv/tVmXgc6dRS83zmDz3UtNIT4ZK7dltSabEATJU1C+UNrYxQSi1bbPurjs49mRJLs7Ml1YmQtP+i4PeiJ3wAwx7mEITuHJ2WiWN0Nh6JlzbV3Lc67y7PUl2Kr9d51xRKM0MoWtgDERyp9yS5Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQuHBN1X0si9A0K2sMxAl050SOW1JJVuoOFPqPGQk6qvQSvxwO6U9KcaQwWp?=
 =?us-ascii?Q?XOjCerUXndPrZdZjcIxd/sFcG0zmTPGr5gImD3JYOJclbxHSdddSmkOvf0wT?=
 =?us-ascii?Q?5HCJg6s7B0zjjghVI0h2H3KGAexYvvDukN1eYvyfLH7KHm2VDo5yKfdSBIOE?=
 =?us-ascii?Q?ftkNSu0eDYJOZeXc+A+DP9hYEptylF+QTTNishszR+mnT84KdoL3k8JOnAca?=
 =?us-ascii?Q?JmXtLxszHUSX6bb0JqA7xNHaPEZXis2RxSL9L5kDq82wIbKw5mx3c7eW6h6y?=
 =?us-ascii?Q?cU3rjvX+8ePZ4fwqvmsWlxJmOGvwwu+YhPb1Nu+onzDhuCl/A8MfYIJsr3Or?=
 =?us-ascii?Q?DaLH3KuU+WBXDU7DMMhY02ndmlZx0v+o1I5NlU8oiHM40NeCnh9g4faGLgEm?=
 =?us-ascii?Q?+X5qVipTpUMTC/oxYtWs5iDVeZrQ8qLdc7gRXIVvKPk/RwuYFQMp0eFrnbMK?=
 =?us-ascii?Q?QDgJqxpIWtOc0xAPYJ2E765E8h2Y4gaK7Yfx6q+BsSaHsJMPsilyQXPMHf25?=
 =?us-ascii?Q?OctD/m1eYlCQhEPMIX+3CxNCIEppcyRN+29t8CK7r1jBNz6Ssm871pTv7mT/?=
 =?us-ascii?Q?ih4UEzZu7hJ4EZ2VYhoRtChZlEPsFHzFbzu/MbWQaTnsvScC+0z1199Zp//D?=
 =?us-ascii?Q?HZsl4Z7VbhsyWgxswZZ/3OaSwRvSe6ygQTgP/j8dyvwAsa+l31iQnozxzIKX?=
 =?us-ascii?Q?7jVpcYstQBusWzg0g4oW1KvZjcleH/i63SiASpLSf1fXWz6ZngFH/NkKunfl?=
 =?us-ascii?Q?TJXomrfeDOz8uggz6HNfhu0VaodaIUz2yMUYmXuCSvZnECzTKpZDA6AIWRnv?=
 =?us-ascii?Q?PzZsxUNHjemgOJxuneLjEAHT/FtLBlH1X0WdK7colYT+QcAZUOp+JW6QBjXc?=
 =?us-ascii?Q?cSCimP7P+SGGKphTtA+ugKsbhG2ebA0Up3I2lbAFBqqlSmRDNsSMqSuferOE?=
 =?us-ascii?Q?u62txecq/4WWCLVC1Qwoi/Xy+U0aGYPqlRJgMkLpORFFF17B3m/8SYmAbfRb?=
 =?us-ascii?Q?zZ43nC1vg/hP/QYq2EvS2A5TGC8PwZqmn9+T9KNY5FojYx6TVVR5mMjh7pyI?=
 =?us-ascii?Q?5iqxmDXumZvSJtAzwHbcekf3AIvc+n4HaK8jUUpnlBkEAI80Nq9Ui4jSk12/?=
 =?us-ascii?Q?MpqpvHG9/UcTWBO5AoGgVIbnFnqfxjymGehkbBxmyTH9+0b8YSOLafpfFbtn?=
 =?us-ascii?Q?OlLdyGoYjfu7+V3ZOfM9d4Qhjo1giIfrk0118Gal/pYhMVFsr8hQsmbR3JMJ?=
 =?us-ascii?Q?bPBYUbjbDZUO5fqAsGDC2N+F0U6l39m2HiCm/VIdZOU98qYo5ASjomjW7qHl?=
 =?us-ascii?Q?6mviyg2tdWz4zUvqllnF6RFhh60Z2soKCX+9qWtCFn6DJM9/tz8sBlP7i0uq?=
 =?us-ascii?Q?72pB9OMAxNxrRSrnY1Yhyi+weVtFn5OE0cVtmjT4S9zAx93PrNZHC9NgLeE0?=
 =?us-ascii?Q?wA+r9tTWK8cAmiIhlLUyDjte2jqDklB5sy3Ek2PUfPRYGHKJEmtV9BVTQqow?=
 =?us-ascii?Q?GBezI/yWzsV+Kb1EXab3Oavr1Hq1WGOkTKm+LydnsUXvvb53NcuEVD+TJyAY?=
 =?us-ascii?Q?UBrhaG6eQdjEH5soThS+MesSXLzMjX+TXtrLosLuOWTijEkbeS88oDvk7d7o?=
 =?us-ascii?Q?VlcoIwrKtymMMpWP6Nnio63GNNKP7W8/2Fd8wMaojuDfeepipomxn9gO/6d9?=
 =?us-ascii?Q?/xhAqZdDyeOD1hnxFf0BNJRy6V7hwrSt3gL8CSoSFiV4irU0tc5b17EoTpGn?=
 =?us-ascii?Q?pGEInfHusA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f597ee3-45e7-405f-628e-08de80196f15
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:26:26.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkTWvfFKVOKhquYTY2f0XapNowwlSTrzEDsnuLIDugqxrNOzOdpIw5jNAuwghDnDnSDbEnAL7KaSol0SFmJgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
attention to that it relies on the patch-set[1], and the PCIe1 port on
the EVK board relies on the [2].

Both of them are included in the v7.0 kernel.
[1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
[2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/

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

[PATCH v5 1/5] dt-bindings: PCI: pci-imx6: Change maxItems of clocks
[PATCH v5 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943
[PATCH v5 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
[PATCH v5 4/5] arm64: dts: imx943: add pcie1 and pcie1-ep supports
[PATCH v5 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1]

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  4 ++--
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |  6 ++++++
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 31 +++++++++++++++++++-----------
arch/arm64/boot/dts/freescale/Makefile                           |  4 ++++
arch/arm64/boot/dts/freescale/imx94.dtsi                         | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943-evk.dts                     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943.dtsi                        | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
7 files changed, 277 insertions(+), 13 deletions(-)

