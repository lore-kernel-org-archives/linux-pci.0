Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020077.outbound.protection.outlook.com [52.101.228.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A31F03D9
	for <linux-pci@vger.kernel.org>; Sun,  1 Mar 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371812; cv=fail; b=kHS8lKOAg4jB2ZCktX+mgDTPQPmJThMiTbrVAPOvqBpexJX6jLVOugcWUA5hEak9paylawFxD2Bh+ZQt57RZaDiMfjTQOlTQQMSaxbclUG3ILX7BeLNUDOtwQg0JLcP8eoCYBUMwJpgFmGesUyFXdNlfXpna0/Q5hYKV9YQJSH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371812; c=relaxed/simple;
	bh=alfNLjQ6SxLpi+GEzCVxVqELftWntHgscZxhBAVR7JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5pU15WVAC2l7wYP0EB0s8V9bv59E52OabGYsWyniWLxbQuV73SwHYLtzM0khDwg3bTCDOthPMPSxhMpkQaKFuTE3Tgp/XmA5SAJ9M3OYmgE2tjMEJ1lcuXNaIFxWDrHwnwOb1Q4t+zwiGMhR0Ar9I/tjRcZvM6OXdM0fVKZcPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bI4kyqQj; arc=fail smtp.client-ip=52.101.228.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bI4kyqQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpOlTYaTmriYp2obPt/M70N4u+rq1s+r/SgLqWxhLHy7ybbvqOrEufv+FxAu3QXQk0BVX4Ne3XtNCApy8w4OgqzNFneO6WlnS04qnhQD3UZP2B4sy/xJxbbwoKQ/WzUTzOabnMQr+n9ChZlvu2mbhNkROYojWJPmLhZEZlp50KV75JpynSzwfoiAYotL7GpxpEy3qB74+TkynRbyfxk8qRCj9F0gKGwa7tgjgVLx6F9mCuJj+IfepPXgFzeXzxFN7smRlJbet1f8T23zq4YzxKAkH4L48MCj+zAZar8PWB62TFaQ/MgPMr9H0JXkbsoSE/oDBmDEXzs0dpsu+R19nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ1FzXmrfuOBVf6CMmd2tspI8GJnj0M60Hz1A0I/BAA=;
 b=L8Do0r0WaZRwmIK2lBK4zTY9V78358lecXdHvWvyZ/P+szwnMFsoL5kjR+/ar7wrksiZ9Hyijnrrg6onbFG26RYixlXZkNTPZW/G9CxIqigBjifeFI2bwfsQJHq1MKaIa3UkxLew6ZA1+DMqW5DNzgEoc4CgTHm8bx4euqq07+FdBAtFk0KeusAr3lKMdhxjnIb5HrziltMoQYFZllCVGkvS3zk30zvravLegQmOL66EFOf72sEXs40EnelcQS9V977VffZtPNsBVeI4xM78CfQ6afsIkORzUXAxocYrkfCNxspuhIqau86VRv0nuwi3M7vuB/j9RDZ578jlaHIDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ1FzXmrfuOBVf6CMmd2tspI8GJnj0M60Hz1A0I/BAA=;
 b=bI4kyqQjkaSnBUKpyEeQJPJ/rfhEW579e5tcmabcuZgDFWDbnTXMdTrUJd1EJ1AQIiksCAI6BVnR5ihTow96uPJCZb6aUvgm4uDFIMpViR/ih7YxIkKRAqXckGJZTxYs79uUsRNWhBWkc56JyGcoQ0yntsLgiNJOxQNn+4KQtWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7053.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 13:30:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 13:30:07 +0000
Date: Sun, 1 Mar 2026 22:30:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl
 window
Message-ID: <i52ffvtjg7jep45k24e3z6wcasaxatp2sifqslkdjuqz6f5wnl@rbejwc2vfqu3>
References: <20260225170324.4033466-11-cassel@kernel.org>
 <20260225170324.4033466-14-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225170324.4033466-14-cassel@kernel.org>
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 020e9ce0-b039-49b3-5359-08de7796a773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	He6FJnuORUB9J2kvK+ZXCUeI1JUDDhE23me01Vg522JeF1hwSV/xrzAbnxwZuUeMsCo3awrHPz6Ym3Tm65TQW/WfTm1fU1r6xVI2jJBEWkdfkGTIxBt9WobRnsf6VGJp+YfOXnlgf9Klw0be364k0ftCT5IZYlaw4HNGXw55ZX65wMhNO5kiJB+iH/7K2KqVKdoSFP1a86A78USebh+l6lOrgO87+qx78h6ALGVRTD7wVJxBbIfcIDXlK5pYoMcpP17OUfyNEDAa+fZ5SDhu/HGKAVY7Q/923tWHLHSOsBR8RpX+PpluATj+6A2UYanm9qfVuoDXx37TN6MDp/1r76bYGujHfB7+ObQ3mwqCFOcHIVzihHWMVEtoUfmPlDwXOeNkhb5dJ5mbVJi+edDBdgyYTEKDEqk4V6jQxfr1z06733XxCsiy8chwabWEu/5yzR/eTYjz97TX/+cDVKy7tErZarN+UjRLKWs/TlnrptncHmnS9ZR+9cg097VA1rr57Zaeqo3e5aMotXgl+I1c0jxkF9psKBewZRP1VKdvIcAq9oU4RwOOj8177EdUu4S+6hFNbXkFHmghuy93mvdrqvFDDyDnRXaP9P1v7oLYXu0IYpnr3EdyV2XoDJ9AQj8PVSvS8RnbWW1ZZOo7GO/MgdEK0J0H/zuk/XsKhoVs+/nenzuqjhl+QgpNLho90lGIqKYvSBLA6Pxng/w+KT62+LrX700OLrY1OCVB5hjcn5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jmzx1N/MBi3sStduh1ugS8wfRoLhc6vlPEwe3mbOmInPVfdiCQ83aMMdE+q?=
 =?us-ascii?Q?Oyot0rs4CAWBLQ5irddRHKn5KN9Vi4bjBqnMA0fIRTeeZGu+llbnp1ctPojd?=
 =?us-ascii?Q?SSNhfmA8HSVPtdFaEKHWI3BD/jsPAPm3jS8+Ep35kZk2DTnTBQ2NDfiNKHF6?=
 =?us-ascii?Q?TopBX5jgMjEmBXsiPLjx3N/7+2fG7m54mqAT1AvX+uGWnPQpVvXjGQF7Wp+r?=
 =?us-ascii?Q?lpNK8xUOdjbYvqdbSrqHY4XySf4dClw33EA2QyAjxd9CAPBGCyg2WPK1Hdlu?=
 =?us-ascii?Q?GZpuHTzBI1egCJ0Z6bclcQMKIKwtyHeTFeb0fg/eIBbXT89MgvKeHGN6p0Hy?=
 =?us-ascii?Q?CSEZUXfmsVNYrYJ2IyaJC5gIFoI5j9DFviCgADIChkNTVGhVq+JGfr97uAu4?=
 =?us-ascii?Q?3BbE9rsk237Vz0L7/SQN0ugaICIrq12/gf9BzFQe46gRvZ2c0yjU5Zyj95Bx?=
 =?us-ascii?Q?FH2sAFhdOnHViRrFHolPBCYwjA9347TIA5fM8gyr8/KfMmBFVy+TzGmR4Qwp?=
 =?us-ascii?Q?V9hIfAFUVRVUsZ4e2EXVSnwrPCgHHQfhFmsQkcz6RTFzKMvDNB1J0FuQugf/?=
 =?us-ascii?Q?c49qXS5B4WgzaT8znq+3ujeuOe0tpo2yf03Tuai7T0mSbErTE6PyYI/JDC9q?=
 =?us-ascii?Q?EiC/HMkW+HzP2GIcO8RSu1tvSYP7uA2S6xgLuuVoFuxNnP/zLv9+eLTrAJqF?=
 =?us-ascii?Q?Y9TY/7JiXyP6F59r4R7dJ2KaZ+rbvJFP6ARRZqW79RZUFHCc0Cb+jhkQ3JgF?=
 =?us-ascii?Q?hLuEide07Cbj1AL+RgNP/qdDcvncckKLlhfWLNz3MXnJJEOpQQUj09epNzre?=
 =?us-ascii?Q?tlWDDIDddQrcU7DpjSrH43cTjeDAlTFLtShS4Tir8WU7M83a0DlBYW+N0N37?=
 =?us-ascii?Q?2Z01J/sm1vhobLiMVd+dpDylyQzDZQuj05mTAR6CbgXCyz8jR8VzsLzoVVik?=
 =?us-ascii?Q?TLdkg2re/atoCaPBH4c7glQBtTKUoA7iNMFnd2fm8VU8IW3CxrlF9mVvP+Y7?=
 =?us-ascii?Q?yRcDlJHZ9nyr8HyAjlEk5GD1dMOlwEID062I2yvneaffrA2dLDMw7mOuMi2U?=
 =?us-ascii?Q?Ki5sycI3Fn/cXobt6afj+DpUhlAVEWbsXDyv85rjirtjxxAqbHiO5PXtyEOE?=
 =?us-ascii?Q?afkTTAi++YZQtz+P6S8X4G22qwxJ5mywa6gDDdyTQFGPxxC3bTyfmVaCTv+4?=
 =?us-ascii?Q?dLhzu5mAR+A6+nkqPGMKS4yqb2GYmSdbegPp8AGW/AKagWK8dV6ehmGLo0E9?=
 =?us-ascii?Q?zlQVySdbq5Qcql1IrgUMCKkCq2XJ+Ay6d3nFOttd0N0dfcvIGDuDpMKCt85a?=
 =?us-ascii?Q?9n8WnCutB8VNBD1OeI6bHzM3q/l1wQ/7AkgFfiIZyrsU1ViLb7hn2Z6TVnr5?=
 =?us-ascii?Q?OXprFMP5Jg6WQdpUsLIa8599oL1/QCTLairOiC1E2lNhXidhD8WFrtr6fCyq?=
 =?us-ascii?Q?z/qKZdWGJAItvjHzpuSGCwJi0CG0VOdLb0WL29yqUfP2/nDkyA8fv6lCiRuX?=
 =?us-ascii?Q?tT5RyVvAHN063o7FV5eVME6AfEQ1uJ9sOUfom2oznqd+8dPYNuqO7IL/QRYC?=
 =?us-ascii?Q?/nGTj9ocEjBuJtNG7ZYvhBpGQgi3TSpkSiv0ytcbAeR5b4g8rMGVuZRUGWUd?=
 =?us-ascii?Q?mTvUWGNa06CwkR5C+P+A6hp0vQhCUrAsz4aFeV17qRpqV28JGUdjria0BMiO?=
 =?us-ascii?Q?/bnZ/lZ5TkSJN2aMlHHm2mj5FHEjlF/spyawgU0dtrH/PpScVjul9omoLqPI?=
 =?us-ascii?Q?bE2otwLbLXZkp1L10dIESyVvYfUXLRTkBLlf6iz/v5opRmylXJaN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e9ce0-b039-49b3-5359-08de7796a773
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 13:30:07.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2k0s2TUzMQCj++ladojvHzEnyL906KF3xOFojqFKaV2Nhd9TwYFgeuY/hnilzs2iMGljgbniUUV28VayGZ5laQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7053

On Wed, Feb 25, 2026 at 06:03:26PM +0100, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
> 
> On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
> are permanently mapped to BAR4 and must not be repurposed by EPF
> drivers.
> 
> When the remote peer needs to access these registers, it must use the
> fixed BAR4 window instead of creating another inbound mapping in a
> different BAR. Mixing the fixed window with an additional mapping can
> lead to incorrect behavior.
> 
> Advertise the DMA controller MMIO window as a reserved BAR subregion so
> EPF drivers can reuse it safely.
> 
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Let me add a bit of context: this patch originally came from:
https://lore.kernel.org/linux-pci/20260215163847.3522572-3-den@valinux.co.jp/
where it was introduced for the embedded doorbell fallback consumer.

That series was later split, and this part is now carried in the present
series. As a result, the actual DMA_CAP consumer is not included here.

This is why only DMA_CAP is described, and not ATU_CAP, MSI-X Table, etc in
BAR4. The consumer side is being developed on top of this as a
prerequisite.

Just leaving this as additional context for anyone who may wonder.

Best regards,
Koichiro

>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 5b17da63151d..ecc28093c589 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
>  	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>  
> +static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
> +	{
> +		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
> +		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +		.offset = 0x0,
> +		.size = 0x2000,
> +	},
> +};
> +
>  /*
>   * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
>   * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
> @@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
>  	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
>  	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
> -	.bar[BAR_4] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = {
> +		.type = BAR_RESERVED,
> +		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
> +		.rsvd_regions = rk3588_bar4_rsvd,
> +	},
>  	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>  };
>  
> -- 
> 2.53.0
> 
