Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536836C0DC;
	Fri, 13 Mar 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390813; cv=fail; b=cAsKJ19LoGRVOcqb4ha/Cz5w0u0EiuqNRWkKFAib6SkWeW9Ibef3iXqeiWwwyEgl6bL/l357nG8jfYQoJ56jgqGj8DT7Ctj4DCDauiIXW+peIWLt9SzY9loC6PqWPoSR4EIN0D8/wKoSKy+8ql9CSkd6v43tSrTHxScDmCqbnLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390813; c=relaxed/simple;
	bh=If9MV7OI4aV8Z5Fugck0nRCT9VoKZKTn+9bgGMJpTrA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ecxaKfxFOy6SLrvce2iMUQ76/6LYbq1/8WxESlPsPbbgA/h/L+AmLTSrDPUw93Hawc1/P6nFAsC43qk7MEwrtMJOh2N+uipUFnFo321BpX8OZfvLdwl9XEF8ZQH551JURYAvraERhjyrYs3zVPB+u526bXu5FWPCi+ShKm05qmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HRiXYHlb; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRiXYHlb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTPg+GljeUgXXn1IyX3IZhQ62/DPQY9SyYRes7tmLbU0R7N658/mUmMxpLxlwzHsenRF2zwFu966QrHz7sNkg54GV1mpPJAw4dn3bQLzB0QScA3Xo/qtPP2BFdQjYCe/cLCibPm0BkMnzN/MxHH8y4ZxC2gkpGReoOCeFOsqAr3q4VN0dXAIzSYluuARs59cOHuN2hOZDcfigWR1nGpWJOwRekFjMC22AI7i/Jm4KXCZtUTGzkXywu+yAUXqqa9mQmgTzS5nT70NAp6l8dKv8SDNA9XVCa0B+TkCZUely3YkyeFN1VpX9ms+aJu2lQrlw16ef2Y6g7Hujjiw0leIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4c7zJXh536m/fKFIBGOvT6y/JGpqi/K1tjib1CoE60=;
 b=bEDi/H8hPTAQpntNNSXHNP0J8hthOaIDKnQ6TXCi4UOeAI1hJn79As+UiQkixrr3b3NserjyvkyotZ7RJSVRqZuTXD4iJKKKOPLqz3ORTpnQJ7dYs/1chpIcbRtWOuEhPd/9t4GSGZtvUV5nIMPySQHLRFQq9gbdvJjCTnslcidUxDIAV/ACCCxBoxHfG0i8iht+1vGMrH/dFwXT2+WKv3HEe5CHAnNUWH2k4fDoLlwp1kJIGqlkXk0hDidhvzDxXWItgLuu7sQ/26M/2Dke8nUYoH3jcm4XH9awOCxaih2lk51GJYgM5pFpxr/QRezXW8fJimw8bzYYQcfocpAHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4c7zJXh536m/fKFIBGOvT6y/JGpqi/K1tjib1CoE60=;
 b=HRiXYHlbxYzd3uvAwxT4t6NFat+sL0c7MUK5lIhK6gqVIE8kFM7nIA26Or4M3U2QHLf0xbt0N+Jfp2w1OaGV+W50FL6bCLCNeXSvdNeltYI3bES+A2ESFjwXTic3Z16OWxhSa6fSTNbL1T6cOOUuzKR+WRJLqofkUq+HI91AH7G3EYHnDr/VbGlWWYsMg05c0SZDgQgh6EEnKjNyeXk1ftA3LuoI8Ceu/NSGvGN61kzIUN0g38R2uiI0PWGdcXqxw8zztzKDtJzphWni6SqJZSVK7See+xvrAwWWjfKJL8mStPzXUReASYMeM9JAm1JJUMVk+dPdnnt7BMXJtUjIvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:33:19 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 08:33:15 +0000
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
Subject: [PATCH v7 0/5] Add i.MX943 PCIe supports
Date: Fri, 13 Mar 2026 16:34:38 +0800
Message-Id: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f564a8a-f453-4467-b9d9-08de80db2bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W4568cSHMQp+kKH6X6RsBENkOUK9FEy8T5LdDaflbssKl0/+L1PjcPIL6cCrck4UWdwHWfeXUYiDviKbnOzxAdukWoIZK7XSVI8WLkumEMa7k39xXQTt9ETPCl5AlCZw79qV+9Vj15kTgnmPRpRo04Vav1GmdjMvRUQyTHHdLY7jjynDs9ja190Ens6ZxastzMtnCf2+Gqh2SyuUseZuK5hGMExBv8Wa+y0G1n/Fxauw5Ad50dIKfdR4nPUNb4ftpEImnsq9ccrjHegP/4q7motl3YyglfvniIWFZEnSu9vVOXwyZvy5EFJc6kJut99ytVya+PBkYeaGIZO2JdTF965e5P+GQ2xJvKq0vFf+rUjCENxCUjGBZQaQ/JIDGx9YuKCLqZHBbxI8PmoFVWi/ZjabHBU/wq59gdr9J7m0cdPRUMqqwmQ3G0VVjyvhFcAgyZHWT+xCF3yxvIguWWzsdPMJm18E2kAVH0xzm3TMaziA2W6B3DyupKb/bgOD4MO+KeIH5DHT8w8A61ugxUtrYcMhxr80ThU2h+MKMaFHZwiGxJ7Lnp+OZPcelVplh3RgFmFjZ1qmEOBo5H0c4vt4c7jb9ZUwkA5bMkdhILdyBPCMCdDOQO9Hz7g7XLej8P4rvgCoQbfHxWr03HMTBElRlxB68jUJbMvRxD/hb4jsTN+0rWvqamKgadttYgseNywPOEX0O28EkPs0P7OzauxbDASAtIdUPQFm7CRiurAAaTQvcNHt6UlVeT4Y7Md6zm0LMflIzRH/revwXHKFxqGoxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GprbbkfMFxZtBuD1pi+VCOooMveLfwF7bqK/mfsFJzU/Ppir3RTNlgDy7Vva?=
 =?us-ascii?Q?UFDLXAWnC3NIpXWjGUFYr8I5Bm9Bcq5e7RIzOBHknnO1AFAXXdIEPQz0g29W?=
 =?us-ascii?Q?FMMHn67n4v7gHCUoakcet1iLOvU3JWQuwv/0AsCKqKOxx2Nh+7/hmUwCTV5y?=
 =?us-ascii?Q?n4VTVpV/UsIhitzSmogMzlB8xcUVhXUucoOUowR1iYKi1WgMJqobVDsZeWxg?=
 =?us-ascii?Q?NRv4T5zoMiCKSjTMW/17O/+YG4rveBYkmVxgOKYS4pjEeDztbhzSn82DqQ9V?=
 =?us-ascii?Q?gQjrt4OpE7uL28CVypjnCPWHxqdIZXT7O4p3aY52H5wQVS5qfWOWTyOss3uS?=
 =?us-ascii?Q?Ytz7Q3HaqDcoh1MtwLKBcOCpKI6Zn/6MTkXbv03z/p0oioClJN61YS7NiTZh?=
 =?us-ascii?Q?WR2YxETF4fGQlcxuppDMOZaBsYnWgPub5kRoVjp0emmIq/n2ms/Qy7Y2wEXy?=
 =?us-ascii?Q?4QoXX0fkBjfWl4J7QrF3JXGA/OcI5GccHDaWUfTRF0S7Px9hzGnVwAmHJRwU?=
 =?us-ascii?Q?cJd33M0OvNJfYH+z/Lb5zh8B+yHNmkWTVKA5OxzLLSPBkriOB3Qi64meXT2N?=
 =?us-ascii?Q?wfW1n1Q4RYuJ21HfsOenCdHhEfz67GYosVI3TJ4ZnczP7NlOfaK4cxSNAr/x?=
 =?us-ascii?Q?db+sf59FIL2RmLRA8jyrRoYJ7TRqR1sVeEWtg+nfuucjaTvSJGC4Jw3sNWXU?=
 =?us-ascii?Q?QvcW7NZT6/3gkpeO2jGBSdf0ce2mWJyjt663v0UpRz0jyxy3NyaJI5fa+Rzj?=
 =?us-ascii?Q?qqVFPCiPh6eAToIZKru9hHSAq4ByyMSss6IZGLulQZ3QrP2rxQFqN1gglYCr?=
 =?us-ascii?Q?97dYFq8b0HBHYh4HUa3VMvY3+zE57Uq76Ww8vKRT00bne5CjdWWzBH2FTSJr?=
 =?us-ascii?Q?pGa2S37MC+Dau2xBv3yF9IqCwCIFUDeqSS7G74hYe8fJlFG+zb8fgynoMZkZ?=
 =?us-ascii?Q?Ne320BeeyDx9k7Hvq/r7SPi4ZUnABSI2zO8kCsnGRCZLvembLhbfvkBAJ2ll?=
 =?us-ascii?Q?NWq/+DOLE1zOVJUpGrC/KS0aTPPyvoRjoFWHqivjcmDpSlVZaEegtkPukEC0?=
 =?us-ascii?Q?q8PWk8gCzuieQyIy4IO/628WWX8yay1z1SSEiL1quTk1N8SPi9Wp8IKbBQr9?=
 =?us-ascii?Q?Jq9mUpzXfycPQfjOLrBnZy4XsEBqTYewThajuQh8i7n+vky6TGGLM1Nwl/1Z?=
 =?us-ascii?Q?UvxzjqGReydCVsz0Br/7E8M3TTge8Ge7mWOHj3TPuTHGfdhxZG0H0Ezuym61?=
 =?us-ascii?Q?KLWUQyeBmhBwLaTVzFUo0eZ8AJOwGvSmTc+M6jcS1paSN/xXIFF6+L1RpWLT?=
 =?us-ascii?Q?YfTHvrFP5GzzMD7ckp/MnTev69mNfl2OM9sf5VE/pJszQmrBO3KQYmOlSJRU?=
 =?us-ascii?Q?jiXMsr5S2vggSCp6L6aMBMrkx9zHoWOe+C7oytGLpKDKWtJeMB7RVFfDnouw?=
 =?us-ascii?Q?ONFyOpEnk9dBoVHY9gUgVWtgsfcJkA3o2mwJQ0p5UKkJHVBxrMUbZt6N4AfW?=
 =?us-ascii?Q?KHHmbcNwjOnTbIZaLM/5M+vJM+O55Ga2hoD4aekgKqwtjBCuCN4sgFsP4itD?=
 =?us-ascii?Q?mynabu+BpQH/XGcdsg295E4t2V5YzCWPlqcxnjccoMr82lrf/qUSQfRWzNjT?=
 =?us-ascii?Q?5x7/cvP+lakTeatNc6Kf/SDNnz37ke9F8EFT6gxtodnQdJ+bCwJ9UxDcmhRn?=
 =?us-ascii?Q?2K0TpvZkHVcqNjnWOHWOR1Dt+icH/pg2LXkVlhKogZyOHRxALPXpCnjkA+OT?=
 =?us-ascii?Q?EqMylYoMhA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f564a8a-f453-4467-b9d9-08de80db2bc6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:33:15.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qdagFRKemEfI7OJJT/YquY7hV4EVZ2TGO9ma4NMHXCfall7+GVbQVwFFAZuusiZ1a+ciM58L5rBFvtB2VuCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
attention to that it relies on the patch-set[1], and the PCIe1 port on
the EVK board relies on the [2].

Both of them are included in the v7.0 kernel.
[1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
[2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/

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

[PATCH v7 1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of
[PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943
[PATCH v7 3/5] arm64: dts: imx94: add pcie0 and pcie0-ep supports
[PATCH v7 4/5] arm64: dts: imx943: add pcie1 and pcie1-ep supports
[PATCH v7 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1]

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  4 ++--
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     | 20 ++++++++++++++------
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 31 +++++++++++++++++++-----------
arch/arm64/boot/dts/freescale/Makefile                           |  4 ++++
arch/arm64/boot/dts/freescale/imx94.dtsi                         | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943-evk.dts                     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943.dtsi                        | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
7 files changed, 285 insertions(+), 19 deletions(-)

