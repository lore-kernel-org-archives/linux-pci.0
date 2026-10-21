Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596531;
	b=DGn97bYDgNxCKvhHUbfFsWtDuik6m7aV8l/izxStF2CO42QWrJUlOVDruF7wEI/VUM9/
	 Bsh8KhxQFERbvqW0mUvv03bNiJE9UH3B3OjVT/1biigHJBURTBsAlWESvO0Lrj547nqde
	 4EpJARCKC/JnwoQQHfHD0xreO8gUvS6IEoDt8R3akHn6D/AjsJSbJuS49uaXRNTeXHXpO
	 kmkMAeYQ4fBcu13zNOI8i7zCA9BfRqLm/v5BoGO52+ySMN3uiXd/aOFwbFzvjQPxRf3he
	 qODtlnilH1uXL70g1lUAm1edUpexqCEysUl7rNzaV/55M/wW/BOSLCiS7lf4ToMc4mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596531;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=V0g6LvwyjKaJEnlWTGPOt+g0tKGbnoVSqToI+MLB8oc=;
	b=HtRQh3QAaF4jHB3POWqCtOiip8MYvb/B8dAb8JTahM9Z1kQZjCAfEEEr1dbUCth7W+qI
	 VWuncLE9s0pHNd5A10XcSXekNJuZcVjl8+TP1K9JdnOG3bNosEJkBaLGIUhC8YYZwfRA3
	 E/+ciCAYHCrapLi24Rkx64EBaXf+rO3625dTrnJ/CGb0xt3V9Gt82qK4+v13xNWVTTjEp
	 AnKEpyVT/8sLqpYmJbLxf7IYEWtFIq1o0CJ6v9bGNnVGQNIj+ta87xbID3BPgOL+rRtGl
	 YuPlCoz3+84xYOaEfzS45tGh7cba1oUwZbBqmCkUQzvNYNOZ0+SUlmBZLxyI2PelFuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rqZXuYX3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.19
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEE606A31D;
	Wed, 21 Oct 2026 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DEE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rqZXuYX3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8SJ9udvPCSOfIxzroSyvTzTI12sk6C4zrsK068EmSaDWoGrK2kbQ+ByjNSk9f7OOuIUpXLS8UpSVqa3VRitEhewRCjffJPwyVtIHEZSbrg+jVjTQPSr0tN3Zn9pD1ST25+ZZB5dgYlYxISjiFhJctEdLUpco2m6EIF0Gfy1MFO2/RJP+5LqbDexT8qAF8gyo2LHp1HXGqxUSCPXCPYBAbfLiNNarvOB7Rd4Rq08lHT1sOjPLm1fwSADIcWc3ooLZSAC0FjKy1qxIf3yJIIfLnzPTdIGpGdUVSCZ6Ti6/1wBTCPEBs0SI/vusjFqY/Ed65evPWEUYKTspOZO/0Bc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0g6LvwyjKaJEnlWTGPOt+g0tKGbnoVSqToI+MLB8oc=;
 b=OczRHO5Ntu58bR1VM2Vfrj2Fde3fMnqm1znvYkYH+f+Dw+lmZ2RWPxLWBYBkoJSigdYhbuFuFmM7f/W1NfRpeqp9OnBFFRxlUDr41ZNUs9qd8uVdnChxE7Na2q2c3SO/9+OoazyljmFMG3so+YM1HnCBZG8O9hh9wJMDFEyzQIf7dX5mqXnmfX87ZB7pwBAagQRU9BrcyxDHaX5gdmBfHWbJr5fVGxkuU/gHDi0T1cdELRC0obLt76luVkRB71HZqDWGsXqumzXqFwMTb9kA/CnR/Qv+BYHfj6jm4aSd2kmGFSiDTXD8p+2vCUZqTH31Vji81rdXZhTf/EuC83Z/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0g6LvwyjKaJEnlWTGPOt+g0tKGbnoVSqToI+MLB8oc=;
 b=rqZXuYX3EpDxBnQrJgvZ4WGOO28fwftzfDPpIHsVYdYxMxWb4YJG7SOiRGwvMB4vJtZF0y5dQpcIOUZc6hvlv9Zlu8m279F7dJfG9P+6jzL/H6qsDIwRukcrkCRqnBrAxg29hWMK/wbJEvOvUCL8LSXskmkRRYKI7aiiSlXasJIcCtde+J7gpPc+sU/m6SlIaaofETBkYJX59ow5LE8eYTV7DBGonR3vhDCVEMR+F/okkFI394Wn66YJZ8/pJoGERt1xk/P95A9CUV2E0LpeZZbgLcBMVXY1vqsacRxLH4h0yKh07mCNwOH4a8uHEuRBdkbT9S6m9VSJkVjdNHdCmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10861.eurprd04.prod.outlook.com (2603:10a6:10:592::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:28:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:28:46 +0000
Date: Wed, 21 Oct 2026 10:28:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] PCI: tegra194: Check for L1SS capability before
 programming
Message-ID: <atjaI9HAoB_KBUaZ@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-7-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-7-mmaddireddy@nvidia.com>
X-ClientProxiedBy: PH1PEPF0001330D.namprd07.prod.outlook.com
 (2603:10b6:518:1::1c) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10861:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5de7c2-1500-4ea6-5959-08df2f87ff4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|23010399003|366016|376014|1800799024|10067099003|261009223027099003|11063799006|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	r8xz7suoLr0DlSdGKy7DbT9cAy6tKFLZovzg1ORC80XdQ9iNsJXiQJCV1bxuwHvf91p3LCULj6xCwfdu7Wbi+cwZ8aEgcLura5n7iExQv+melfa5EMw7YskGwMf9PEiSO4ZKK7WI3gxjV+1aaOKhqoG0k3w7v7ilksBlWdL89DpBIQenPN+uvPdaSeI64kvhNde4VDNalV83VclW0r/C2prA6fq3+ZKmAAQYoDT7Us8yU2tnB3JM1524vg20mCCtQLBMJoFDyy9ckM8qfDcTT+4pzEitjsErsZwwaGkjNlCfl7uLcqRvTUtRmArXanTfoX+yWJfIYZgcTdpChJy9wMdvTHasAzG7vETvpFLVsPx4F6a0JRIbbKtc5o7npmoVB7NEyUjEoxFA1noCm3eKm5e/JBVHsLRfQgZod0T7rrzI3YrRUtG/IC1hXmWGGxswWzQl63o54zsT9u6LDnHF+8EJ+y5M7KBdp3seyjjj6u1ln4wEfm/3B1ivvcelWaw4q2YfR8c3UBMnjZTbIdl6NS4WrHxd/IXK2J7fg8jr540ZCDX+/NPE/W6TnH/x6pztf+H6DgIbqJIX4EQjDf0I0iVW3GqCGsjmGrCijTVqXtv/3G27q81vdAAZa0DRq/ji97sI67t0qSrQo1QKeqWbpb2OnRN+nmhpang9FBjZcD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(23010399003)(366016)(376014)(1800799024)(10067099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yt+DeCxR0sYWHrHD6l0Sm/tYj3heAGsFApwA807jIweQsPJaNhTq0juKvU4C?=
 =?us-ascii?Q?1UHB0TAa58GwdoheUDrTxGjSD5r9D1kroLIR7l6vhqVRXjEmcg3/HF3Om7q3?=
 =?us-ascii?Q?pW9kxx9VewWqG/J6AAch5aspOddeBhIklYVZ3QnDK4g8bJbBKvjuvqL3LIPk?=
 =?us-ascii?Q?2mHLsvXbaZ/eQeGrPYky6UH8MekZ1hjnVxL2MAtmnblnQC+6JfEcjUtnQ7o2?=
 =?us-ascii?Q?FIXi660WSmtGNxtB1PpM1RzKFDlugKcaSBCWDiKK5adFBuoM4yEMXQGvTMT8?=
 =?us-ascii?Q?NU5s5SXRqsXk09lfIjHzAXXn2IG4e1QXucXYfhxWBSysQVDxldxr5+ns64W8?=
 =?us-ascii?Q?F7bHIwcq/EOlh4c0Jy4VKV/llheYQMtaC/BhS/Q/9lYSrHIinFkRRGoTd173?=
 =?us-ascii?Q?oenW2rgZJqnelGj8Fn2QMofsyQJjy7p16BRVMJneqTcTFqafwbvy4rBAQox5?=
 =?us-ascii?Q?G82BKkbaY1JOP4QIJAisYocLqyD3C3XMzPU4F4GUjoK6UuEfiHbTeeGHjTYe?=
 =?us-ascii?Q?NztAnclR68FZRjzKX/lxeu6pB+ZVabGrIKM4q1yISU62Yy9z8Mq+MWZKEN/u?=
 =?us-ascii?Q?44fxY1jHrf5P+Usu7bwfI+2Ms+Ss/IsTeEoak8zcuKOO2iLfIoME1yJ9TIWO?=
 =?us-ascii?Q?PF6hxrIz4CLojVMYH7MCbVLO/M43+otFfeXXLRdXJoLqZU+MlVzJy443NC8A?=
 =?us-ascii?Q?IwnYSunPzYCWQYL+3O16q3KqyLa5yjXS3tD1g3J7yQ1kyH07ZLKub/dVSxi3?=
 =?us-ascii?Q?J8jY3scatj7tcNkI+OQx395Pr6f1Y+booXrHk8F+bwZRm6tsgD1nS87Liwd7?=
 =?us-ascii?Q?WA/+VOwyqIkvgSrMgp+c21QSftG+oq87cxxxLbkVHiWBPoydQrUmebLbpQwD?=
 =?us-ascii?Q?G9OFO5Q4Dak8+qROPE9U6vC7ATE6GS/MFroUiTgpUOVFuddfBpSjC2dcBe55?=
 =?us-ascii?Q?Xwn6bQhUisZlGKZECasURY/lzaUeYZ/pXfJRiLItZIw3jNfMDPxBFDtPWNjU?=
 =?us-ascii?Q?ITx4FONqAqNvSBKDS4YnUG9yet8Oboai6eR262j/D5Ge8nJV3eA/RqYaw4JI?=
 =?us-ascii?Q?0VgpHJWLO2hk6wymNBoaJvoeOgInHXC0mFIcfkEzcpQswVM3VWwKjxFddmPc?=
 =?us-ascii?Q?24IW2uOExaAFDEWT7wZjWMU/RTsCIcCCY+BLJf4xXZyNDb129tLTZtES2f9i?=
 =?us-ascii?Q?BoGrp6e1kHukMZHud1nwYHJrW2Oq6pp5Lv9zqFTvsRgzeknekwO9uOopNklD?=
 =?us-ascii?Q?ibHznPuLuMeVblgUdVFoksAOIPMr8WV+uVX/cevEqxIaGSCD0+KA9cc3U70n?=
 =?us-ascii?Q?55tLcVdR15diHMy/w5YIZktHXUcW64c3B3piGvu8lReM78Gvf3PNXKa5QBQN?=
 =?us-ascii?Q?p0c8aTpvJhjzXlII5T1VaJz1H7lMQwuEqO8Aab8kzPkAY4iJWbPN+gdCnOd6?=
 =?us-ascii?Q?2pEz4V45DdatuHFKbMfyHcm/BpnMwvbCdx6b2ive8/C5UT7iRQFM8NxUXn6Q?=
 =?us-ascii?Q?pZQWaSSpCEbWAHR/q4CHJ3tpPDZJFoUqAiweHDxB5GvCZoW0qN85BZJ8fRqT?=
 =?us-ascii?Q?R4tIStK6OHbr80gnCaQfxhMX95WSvJ+f6IXQgYX9TbRgD22tdJasDwE+cyUT?=
 =?us-ascii?Q?2wnpNSHccd/DDP8dzDNKSAs5vY/yb7uKXzxTqbA8YGkRyHEbtH53kw4hNPTI?=
 =?us-ascii?Q?b0TxSWgMN2kZT9U8zoP09V/4tqrpZEAUm4gGs7rH4Wuh0x9lVjIQU8CbzUBa?=
 =?us-ascii?Q?NipvutZN7hOqIDbKsoZQnWEMpoiQ1YFZoWi6VW9zN0n8PYgcIL7C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5de7c2-1500-4ea6-5959-08df2f87ff4f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:28:46.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEgZKnl238HmPCaoRO1VfQWbffwjDbHRxfb17MEZMv6YS+MeJcwTLDE0Uf7mN38JaJZzbWxks6aSz8y9hs9UhgJ7KlWP1zlezIVUjU739WRja7xHXZKYFM+4OUUOeiem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10861

On Wed, Oct 21, 2026 at 11:43:45AM +0530, Manikanta Maddireddy wrote:
> init_host_aspm() programs the L1 PM Substates capability without checking
> whether the controller advertises it. If the capability is absent, the
> code writes offsets from zero instead of L1SS registers.
>
> Check for the L1SS capability before programming L1SS-specific fields.
> Keep RAS-DES discovery, ASPM counter enablement and AFR latency
> programming outside that guard because they do not depend on L1SS.
> Only create the ASPM counter debugfs file when the RAS-DES capability is
> present.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2:
> - Use RAS_DES_EVENT_COUNTER_CONTROL to match the preceding DWC register
>   renames. No functional changes.
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 72 ++++++++++++----------
>  1 file changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 14031cfaee8b..7c349478556d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -673,37 +673,46 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>
>  	pcie->ras_des_cap = dw_pcie_find_ext_capability(&pcie->pci,
>  							PCI_EXT_CAP_ID_VNDR);
> -
> -	/* Enable ASPM counters */
> -	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
> -	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
> -	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
> -			   RAS_DES_EVENT_COUNTER_CONTROL, val);
> -
> -	/* Program T_cmrt and T_pwr_on values */
> -	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> -	FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val, pcie->aspm_cmrt);
> -	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, pcie->aspm_pwr_on_t);
> -	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> -
> -	if (pcie->supports_clkreq)
> -		pci->l1ss_support = true;
> -
> -	/*
> -	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
> -	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
> -	 * powered up immediately without waiting for REFCLK to stabilize. This
> -	 * causes the PLL to fail to lock to the correct frequency, resulting in
> -	 * PCIe link loss. Since there is no hardware fix available, we prevent
> -	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
> -	 * in the L1 PM Substates Capabilities register. This ensures the host
> -	 * will not attempt to enter L1.2 state with this Endpoint.
> -	 */
> -	if (pcie->of_data->disable_l1_2 &&
> -	    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> +	if (pcie->ras_des_cap) {
> +		/* Enable ASPM counters */
> +		val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK,
> +				 EVENT_COUNTER_ENABLE_ALL);
> +		val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK,
> +				  EVENT_COUNTER_GROUP_5);
> +		dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
> +				   RAS_DES_EVENT_COUNTER_CONTROL, val);
> +	}
> +
> +	if (l1ss) {
> +		/* Program T_cmrt and T_pwr_on values */
>  		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> -		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
> +		FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val,
> +			     pcie->aspm_cmrt);
> +		FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val,
> +			     pcie->aspm_pwr_on_t);
>  		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> +
> +		if (pcie->supports_clkreq)
> +			pci->l1ss_support = true;
> +
> +		/*
> +		 * Disable L1.2 capability advertisement for Tegra234 Endpoint
> +		 * mode. Tegra234 has a hardware bug where during L1.2 exit,
> +		 * the UPHY PLL is powered up immediately without waiting for
> +		 * REFCLK to stabilize. This causes the PLL to fail to lock to
> +		 * the correct frequency, resulting in PCIe link loss. Since
> +		 * there is no hardware fix available, prevent the Endpoint
> +		 * from advertising L1.2 support by clearing the L1.2 bits in
> +		 * the L1 PM Substates Capabilities register. This ensures the
> +		 * host will not attempt to enter L1.2 with this Endpoint.
> +		 */
> +		if (pcie->of_data->disable_l1_2 &&
> +		    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> +			val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +			val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 |
> +				 PCI_L1SS_CAP_ASPM_L1_2);
> +			dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> +		}
>  	}
>
>  	/* Program L0s and L1 entrance latencies */
> @@ -727,8 +736,9 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
>
>  	pcie->debugfs = debugfs_create_dir(name, NULL);
>
> -	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
> -				    aspm_state_cnt);
> +	if (pcie->ras_des_cap)
> +		debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
> +					    aspm_state_cnt);
>  }
>  #else
>  static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
> --
> 2.34.1
>
