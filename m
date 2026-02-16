Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6131B3D544;
	Mon, 16 Feb 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257784; cv=fail; b=Jt1v7De9Yfvq/xF1VsU0A7quRvAl/xSiySpT6qIQEezBbWu9ZeHM/C9XB+dhlhGwKffiH6wfNT1LtwAU8tbd7BG08bIj9ryBOTD0aL4+y4a6KhdiFVEjwn1PsPNqHb9pJdPCs3XkeW09QsTaawQr1tB7zDSuuuiNwEi13PHQg3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257784; c=relaxed/simple;
	bh=YAjMs9kcHadDgi0mOBGOVLZV7oSlhz9LzBNayMeMqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YI7kDP2O4VM+YPCUHH8AGC4W9XBYu99msN2EiojUkaGiIRa/f/r9r0IU5rYirbxheQlac8pURW6VBGKBavx6H7zCe1GsOlG7JLgOSrRbp+SpxyPI0LjtOsrkjhHlK5DsWcYmTn77ns2PZltjJpZ124JHMPbLiCxscNZ8mfXDpqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Br/2+z+h; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Br/2+z+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBHeel3LWCuUxLqtjbr1Ji8C8WSJ/eHPkFZNQJ69/j2/Jngpze+4C3rW9s14ZrwGdaynInZdl+xzqjfe8pbsaQmXR+FTrmitBbocN/4CNsBSXrOr1Vruc2YBZL2dt0ga3xa792Wlj+qi6nmO1Tc3XmXM94pG28YQf1+Rz8zykoPvDHBaloB/lJ63bIQ6wKlXxnh1IOEuT2JjRPzcqikW4ifP8I6BN0fo0p1rOncTHFiajoal+Ml0QNU7bXl27IbpKRTuZVLnO5Gn5936ImJLhBCH1ms3vv3EKIAYO4LEpAGgSqcjUTYt1Z3oc9jjIWLH7r3jgd1RuuKJ68+Ygb+8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZLQuN8nyN2fJYyXyWQRkIoL+Axj2961VdmCcGVJ/Qs=;
 b=MjnYgaKIVicBK2tuji+SuQQEE4nEb1mIudbSZkibJT0JKa47326Lldwi5p285zMd3udObBFhnXWoXqvOq/bsu9MRGDN4uq3qjy4aFAm71l4Ykmmqc4ImexuK+rxgDCSwFOL26VnEVTOKnoAbGUyYmmFjt4MWkHJC/5LGCnvuPaaQyuUATWM4hk8iaskwvSUBlEY2deQGnYsNYuzQgTCa9elzh0emeoz3BXS3cJ62UyDuEB5mNiXplaWivkVLjKM0We3tEMCbkUV/cXGzzlnliwaz1Yjb/OZ2MkXxhlHaRWoeMWW/Mx+Iw6zjsfxIyYBFkEIB+wa8h+J/akzYXe7USw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZLQuN8nyN2fJYyXyWQRkIoL+Axj2961VdmCcGVJ/Qs=;
 b=Br/2+z+hreJoYg7BIfCSBi5Ia80hVruunAytLqJ5dH0EPCPwmjySxqSlOSoV4Bi9pAwZhy2PLbJOnOaxcnYX0/0fIs6IbCUjuxQTkASTSS0LyDS5RqW4kivE8fhHg0Pb13Lz7QR8fMQ4MtKggeAB2KqJjUJvZ3vQj2SoCKbSoLEfCXclyVKJCqZpv1ae/wKqL6Ntr3heaaKdWFVkJwOEbcSbcczH8NUjbF91Se978ntNhOwCx7TmjbgNwT/c782uGrH+RojxTS1AqjPs2RXrd55nr8v6fR/lMXIzHFu1u6Fx0+PQrjIyT3UNAMzaU/OOo5nFIdcVSNCia5iwFdwC1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB8872.eurprd04.prod.outlook.com (2603:10a6:10:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:03:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:02:59 +0000
Date: Mon, 16 Feb 2026 11:02:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 5/9] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <aZM_rCBkIzEztT1Q@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-6-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:f2::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcaee8a-ea83-4dca-39c7-08de6d74db4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzHqm9oDUGBOXKQ/i0rt7zrcRaKCD8Rr4ASIG5laApnE83kN68D7+oo4+RGs?=
 =?us-ascii?Q?YRVpighkQAPxVL9NmfH0Po1gP/Emj8hxuKevNNFhE7W31wVyQSvMBVfkHYYb?=
 =?us-ascii?Q?lAC4NsZu++B9aga5cvY1J0zViyJwearDUT+WopI2/7YZ0P3rQFxWS510AULI?=
 =?us-ascii?Q?5BE/xjnLkCTLqkbH9GY0kqhnujKKTo251hzT+83tc/6RK0EntbBWXeOaqwgQ?=
 =?us-ascii?Q?C4Rw5s4N3JqZeslfoxJC2Iwxcp4tGLqA3eg4g5+X76K6ePnjcrdE68Em+TDh?=
 =?us-ascii?Q?Xbj5NTRKIRA/7t481aKZSmDJLzdtwaTBuq4Mc3PpXFVqFLRzWADLzZ1n0Sjo?=
 =?us-ascii?Q?A2FN6bv2RGqwrVA3kmgpVurZHYVAp9AM6HVpMgrOqNsBuCIq0da+5IYDa/7d?=
 =?us-ascii?Q?EN1MS8aXXlvQytGV4N8kAxhD39WxWjoAHZhYLSZCUoy1S6wLprNyb+lbEZii?=
 =?us-ascii?Q?u6hq+m4OIXmD0HOXBtHHLidx1V/Zun7ExkqgDb3QmfnOZ4SIuAqZlxNh5z9H?=
 =?us-ascii?Q?oJCSpwNN2vQOAauR3tWonQNTM9SSpz/T5cKZZ2JpuRTrMaF6bJTj4qdWPt9r?=
 =?us-ascii?Q?Gfgr7x42bf5D7Vn/9hMNJhpY0r1momyKksW4KCsZP7rCs2u1E5XlX7zzdRFe?=
 =?us-ascii?Q?c3oz4OgOw6V73UuAOkyQr1re1RDL4b+j5YAm8YQo6CIlRgu9wbro5J14WT3v?=
 =?us-ascii?Q?bk1Vh5Dpir/M7rbrnIpHGJVaCYyscLTlievhhYqNsxrpOX6eaBp9btSKuvLa?=
 =?us-ascii?Q?Fwev+s96G5VwHiOnET7coI19MOBg4TAYToSobO0mCnubiMQC2CY+124yBS/s?=
 =?us-ascii?Q?xzupEmgrvXy+bL9c9TvegBWcsAZ1B+KQE9sOfD89WU9gOqyAzq5Iot9k6x6N?=
 =?us-ascii?Q?ZjSTintKuz4GGUiEjdsSXOUK2ROf0rYhwA9R7Y3dLZDrjosUBUXv4md9Ypwl?=
 =?us-ascii?Q?ArY/HStLJBiiuLHHovIkthffHF52fvIMFX7aueD1PjajCyVQefe/UUZMehTO?=
 =?us-ascii?Q?IscPXQ57w6OErC8/s3WEz5TlvXClaRbIFz8eDxjRmJV0fzIkjZKc3qHfcQLL?=
 =?us-ascii?Q?4UFnEUD/K5xzI0eer/cijK/HBaVO1MyjEUDdZFcSqF3wXrMe7Mm4GTr86kZU?=
 =?us-ascii?Q?1df5aPg0IoLokQ+/8dBzO7E8g4eNyat6AfEL9WALqDL1YY7Ws/22KcE/sZyv?=
 =?us-ascii?Q?Ie+9SmbSR0ojMvNuQ+CNUKXxoATTrEBHrl/VdiwudblNj3P17SuKkc0YKjQi?=
 =?us-ascii?Q?MYJOO3EDBEg4sWG5TA9Z8VVuOg90ZJuwVQTBlPYufWq22y6mP7WxjcN3W/j+?=
 =?us-ascii?Q?0cjSSfTr49nasQeG5r7yfvR1ZocdNnfX5Efia+6xTcukSUe4biWzQlEtmz8X?=
 =?us-ascii?Q?oF0JBh61SNk7WgLQtFYXHSBNGI6CmrmqlFSohjGUa4tDulgWrFyaFiq+U4bw?=
 =?us-ascii?Q?IlEjDGCDSH+cEittZlkeoyp2/4T0Xdeuk/uYIFxqKSwCxP0F8lHDpD4i+ViR?=
 =?us-ascii?Q?F405Zf3qD2916iwObzJwMEjnOJRdydb82fFDVy4Wvzh75UPrHpifn7lxKCWX?=
 =?us-ascii?Q?5CtZe9kDCmH/f1k8nD3iIqmm+CuiZ1yxPCVbBxh2bg/D8LR4n3+nMxF/Dmh3?=
 =?us-ascii?Q?J3PyC1YZD3VWWLeC2xnBfwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0eTnwHh/l3SJydjUjd80DNZYO0R4b6k/YLMJ/nT7tajg6g934sDArd9NnpfU?=
 =?us-ascii?Q?6vh3in2vYonGkotKqAu1LsE5SJ1Q3HjR8pHqM3QQU6dQVLd6o8kVyk5rY4RG?=
 =?us-ascii?Q?PZITCAENROsYMpGT3x/jRYRvqdmidkAk4Tk4q4wkHI9sjAqr3yf/nI/6vk3f?=
 =?us-ascii?Q?FsEs27H1seJAUSsTsREyY6ULysdOHy2L/G3qemekpV4xgIoYUAwppDQepZ3a?=
 =?us-ascii?Q?1OvrP1svP/3eWBIzg5RP8PKqlXokVgb66brDpy1kGCc04fniEPMHEDJZCG3j?=
 =?us-ascii?Q?af0/7XyGfxYJqA4/KQx8LM8VMOapKaCsNrYg5xnXqreLuqqjjoLYS4VYO/PN?=
 =?us-ascii?Q?plwSqCmmDSeGKBy9baSW1e4nm96KKP74KQXL1H7450ioDDaWTOFc0yDDLZ/X?=
 =?us-ascii?Q?C/gqg59XJs+Hfd2qjTn1yIzDcm/gg9P2MNKoUu0kct+KqnghfbdMxHkbcTop?=
 =?us-ascii?Q?vzb4oCmnzm43fl5z9MC0SWoK8EbQqUpMf++fKj7kYiCPIVjGLl/fZ+FFFByU?=
 =?us-ascii?Q?P8AQvtUUxVDn/p2TDvCoBT65LvqJrijp7R4KqZXUn6D0A5/s8EGXqPcNRzoE?=
 =?us-ascii?Q?xBzLr8+GiLtT/LFLrdMJm5ND4kMqZNT8k+n4ssN4MG1uq+7E/cZgEmmFY4IS?=
 =?us-ascii?Q?ZHsyZnvDWK/zDaCS693g9BXP0te9gVHgwXizTruYklqRJZ94os+Qu/5ZAKUc?=
 =?us-ascii?Q?RT7zzJiNwopO9kWKc97O1A/fFTeaZaYZxHS7zUVXb5vVgKLPm80K9XOchCxz?=
 =?us-ascii?Q?FE+ecq/VNwlqonFK8uaK0vUwTQ32D1NH9fr9gRKaJnwckgnVzSg1gD+dnhLu?=
 =?us-ascii?Q?E/QXBlnL0FpTRucjPmNtyHsQFu704HYJXjy379kw6mfXJS7QQF71Cu0Iy5zF?=
 =?us-ascii?Q?rE0il3j71RLa1x2EIpjKpG0Aagp/f7o/nLdUJBL2aJ7+j5qfMbh1PDRJ/rJo?=
 =?us-ascii?Q?fxShFF83mD9oUmEA0bgc2G4Scu8vBCJDPnsr8MUizVODMrrRXGctRvOt8PRy?=
 =?us-ascii?Q?rx6ijmL2CBSP7IYzy/y/0MGrAHBY41cQ/p06Sd2XxY+bma/aGV+qFPqZYtut?=
 =?us-ascii?Q?h9k7BBRCelDkstdyi6V/8azPTSHVgQjVLqcK2u7b7DeTDFxjYjNFOkAUH9nm?=
 =?us-ascii?Q?CDh+CBwdyNjUSf47idGlgLxyhM2BONTybNu4OCNxA1m0XDNfQyGO2IwiXjq6?=
 =?us-ascii?Q?aK+TwaHYqh/R3ZbCCeMTqSplEQBnFGkodOMTbaMlBQqHs7b/VztRWKHuX2pG?=
 =?us-ascii?Q?05YE+f9Zh/T5p0KmG6voCVxkH2mHaDVxEBqD13Eq3nqWT/tZwt2DaOnG/kQy?=
 =?us-ascii?Q?CZH0BIAvrfesd2fhPdzu1jBrvlUBPSNShz9qHuuIS9QDrXfbU4Hm1cfgWSSU?=
 =?us-ascii?Q?IpjP6OrZ7Y2gw572EOA6gZTnJ43jJU5SyPKuwV09RDlFr1/OVVbK1cJzUQD7?=
 =?us-ascii?Q?c+KcI7pKKIK7jACzX1M8PZu7WAF9pQwbYzEqrnBFXiYyIvDGSUwHxmeVlVWR?=
 =?us-ascii?Q?VJ4co1mEhAo8ZRW1cL1+DekB29YthGGDdNQkwg2A8ir8apOu9GXFtEHJJSV9?=
 =?us-ascii?Q?W6tR4XQu8AJOB5eSJEmq11nRDp3vXLYqgcdwkaJJoFQlLNJTbu3iaYHlT95V?=
 =?us-ascii?Q?KGkzUFZ0N2Hy+ddf8VJsnTNXJJPmP41lduw8DnDYniTYGezB57QDCF91yQjJ?=
 =?us-ascii?Q?hT1DsNZO8JHMh6/z8y/+mQLTqdFCQOYzPMaJUPLv52XEAon9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcaee8a-ea83-4dca-39c7-08de6d74db4a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:02:59.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfgrle7f5cRtPI9LE4uREKZX+bWZT67bgXmaGGzcioGUfjGhkiXDY/fFt8R2IIbnTz1mewHwlbujj66v0oIXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8872

On Mon, Feb 16, 2026 at 01:38:43AM +0900, Koichiro Den wrote:
> Implement the EPC aux-resource API for DesignWare endpoint controllers
> with integrated eDMA.
>
> Report:
>   - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
>   - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
>     including its Linux IRQ
>   - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)
>
> If the DMA controller MMIO window is already exposed via a
> platform-owned fixed BAR subregion, also provide the BAR number and
> offset so EPF drivers can reuse it without reprogramming the BAR.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..ffd2797b7b81 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -808,6 +808,154 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	return ep->ops->get_features(ep);
>  }
>
> +static const struct pci_epc_bar_rsvd_region *
> +dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> +				enum pci_epc_bar_rsvd_region_type type,
> +				enum pci_barno *bar,
> +				resource_size_t *bar_offset)
> +{
> +	const struct pci_epc_features *features;
> +	const struct pci_epc_bar_desc *bar_desc;
> +	const struct pci_epc_bar_rsvd_region *r;
> +	int i, j;
> +
> +	if (!ep->ops->get_features)
> +		return NULL;
> +
> +	features = ep->ops->get_features(ep);
> +	if (!features)
> +		return NULL;
> +
> +	for (i = BAR_0; i <= BAR_5; i++) {
> +		bar_desc = &features->bar[i];
> +
> +		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
> +			continue;
> +
> +		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
> +			r = &bar_desc->rsvd_regions[j];
> +
> +			if (r->type != type)
> +				continue;
> +
> +			if (bar)
> +				*bar = i;
> +			if (bar_offset)
> +				*bar_offset = r->offset;
> +			return r;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int
> +dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			     struct pci_epc_aux_resource *resources,
> +			     int num_resources)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	const struct pci_epc_bar_rsvd_region *rsvd;
> +	struct dw_edma_chip *edma = &pci->edma;
> +	enum pci_barno dma_ctrl_bar = NO_BAR;
> +	int ll_cnt = 0, needed, idx = 0;
> +	resource_size_t db_offset = edma->db_offset;
> +	resource_size_t dma_ctrl_bar_offset = 0;
> +	resource_size_t dma_reg_size;
> +	unsigned int i;
> +
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	dma_reg_size = pci->edma_reg_size;
> +
> +	for (i = 0; i < edma->ll_wr_cnt; i++)
> +		if (edma->ll_region_wr[i].sz)
> +			ll_cnt++;
> +
> +	for (i = 0; i < edma->ll_rd_cnt; i++)
> +		if (edma->ll_region_rd[i].sz)
> +			ll_cnt++;
> +
> +	needed = 1 + ll_cnt + (db_offset != ~0 ? 1 : 0);
> +
> +	/* Count query mode */
> +	if (!resources || !num_resources)
> +		return needed;
> +
> +	if (num_resources < needed)
> +		return -ENOSPC;
> +
> +	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
> +					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +					       &dma_ctrl_bar,
> +					       &dma_ctrl_bar_offset);
> +	if (rsvd && rsvd->size < dma_reg_size)
> +		dma_reg_size = rsvd->size;
> +
> +	/* DMA register block */
> +	resources[idx++] = (struct pci_epc_aux_resource) {
> +		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
> +		.phys_addr = pci->edma_reg_phys,
> +		.size = dma_reg_size,
> +		.bar = dma_ctrl_bar,
> +		.bar_offset = dma_ctrl_bar_offset,
> +	};
> +
> +	/*
> +	 * For interrupt-emulation doorbells, report a standalone resource
> +	 * instead of bundling it into the DMA controller MMIO resource.
> +	 */
> +	if (db_offset != ~0) {
> +		if (dma_reg_size < sizeof(u32) ||
> +		    db_offset > dma_reg_size - sizeof(u32))
> +			return -EINVAL;
> +
> +		resources[idx++] = (struct pci_epc_aux_resource) {
> +			.type = PCI_EPC_AUX_DOORBELL_MMIO,
> +			.phys_addr = pci->edma_reg_phys + db_offset,
> +			.size = sizeof(u32),
> +			.bar = dma_ctrl_bar,
> +			.bar_offset = dma_ctrl_bar != NO_BAR ?
> +					dma_ctrl_bar_offset + db_offset : 0,
> +			.u.db_mmio = {
> +				.irq = edma->db_irq,
> +			},
> +		};
> +	}
> +
> +	/* One LL region per write channel */
> +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> +		if (!edma->ll_region_wr[i].sz)
> +			continue;
> +
> +		resources[idx++] = (struct pci_epc_aux_resource) {
> +			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_wr[i].paddr,
> +			.size = edma->ll_region_wr[i].sz,
> +			.bar = NO_BAR,
> +			.bar_offset = 0,
> +		};
> +	}
> +
> +	/* One LL region per read channel */
> +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> +		if (!edma->ll_region_rd[i].sz)
> +			continue;
> +
> +		resources[idx++] = (struct pci_epc_aux_resource) {
> +			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_rd[i].paddr,
> +			.size = edma->ll_region_rd[i].sz,
> +			.bar = NO_BAR,
> +			.bar_offset = 0,
> +		};
> +	}
> +
> +	return idx;
> +}
> +
>  static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
> @@ -823,6 +971,7 @@ static const struct pci_epc_ops epc_ops = {
>  	.start			= dw_pcie_ep_start,
>  	.stop			= dw_pcie_ep_stop,
>  	.get_features		= dw_pcie_ep_get_features,
> +	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
>  };
>
>  /**
> --
> 2.51.0
>
