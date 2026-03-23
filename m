Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CA3093C6;
	Mon, 23 Mar 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291156; cv=fail; b=hGIKcpBSFNzI9KqFzNh9WbVfkrPq5kcVyA+1cWICIyDPAAJMLCUIoNo3RSROGbK2P4G4pz/HxgN5WUxV17g3BVqIZUMPh6+J+zahCx+qfDGDGstsZM2RnB/MAs8mtAU4p4/savaYshO++90wSCNixdAfrVURyULYfNTUMIg5cno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291156; c=relaxed/simple;
	bh=Xs5yquz9nyj18wp5ue2tBp+5chPvDcnf44bUPZ4ozP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYBq5quu8ugqenSBNgREn4GwzuqNT+VXOfEpN5Llpvg6zgd8iYVkMtx7c1LqSFlsGW/LUiBdFupTnmmR59X5BheU1N/YNXqWG43S8qjvOajA3RWYz8UrAw2l0CY3kJVzc4iS9tEly6UHQfdokoJSYXRtzn/+VIztmVylOqpo2zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hlptrV6K; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlptrV6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYPSOlttE1X9M+HECIWgbBs6kC8mofjBqLqwl1r7yOLnLB6baPCAxgf2w5eCLldGAyAyQkIeHtGpWW/s68+UyISZWHsUBvK4uIzQQ8ENIeIrI+pLT1UtNS70r3TWXkVVBdRcK9hBFuovnA1t9wEm1E2pijevvBdc40AtuF+4IjGOJR1thOKHAmF+woXZXcTh8+E0gGMxnUqmpnRaoYEEqlJ3Yu88D5A3ekbkNlzmEAYwPeUN3341tqf6gupiJLzrQwzDb7jjxBB4s66uxywE1dMxoOwoxioO4xDv6BHUWph8khn/ZFvFaMVvHK1RR+BN8C7cIgBfAWyCmtjZGKQYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neGQ0fjW/hnZGXCKUnnL0obvW/GCX4iZ3FN34iDi/7c=;
 b=nMhVZLVy9Lw2chu0VSczFgG3aqTY+NFncmMDTLBj5ceT5SqDs+EJcPUrEiIQA48e2sVRu4r8Rs5XDWSYCkw9H92Zcd1PFhXYFUy9Dqw9h3XLjRSECd7AxV43ZXv9Uxq5Oa7BVSXmnFyLMpeUw9Gl3dG2WmaBWc5gEB33cbimkHQR9NC1FHah0ldUejgQMiJ0pqrYrvIU75ChYAu4T0ftugFGiMwJI5OKNmT1MBV3AZLnnbfgfGB1RA//e88eBJZWprFCOaAR/oGNhMIbQjGU/ue9/LoKTc5u/9rLAOsls7BGPbLmGo0biYF1ESoiJfIBYUdUAejHQjngzzBpcbw26w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neGQ0fjW/hnZGXCKUnnL0obvW/GCX4iZ3FN34iDi/7c=;
 b=hlptrV6KpF0XAAkg9lfEnd4zdif/VyAurzGu4ZiAs1gUfg28Z4GRfJiRvGjoPLzPaFpW3TDngTycKtzfR6kD+P6dyH29Zh8xkDae4lruBikUTbww1FCvBMLwv7+xST7jmc8KuwB9NfkY6dj8SwZjRMbA7sLgD1ZplRJ1rXgP+IaG/rn+DSzkncwasu5FLm8XmU76nFXFPdZY+0K+9FSTNMqglor2v/phQVhmEptZKtcq+GS9Vi8kYoPPrjFha0iQs0f/yPwr4IJPI6vBm/OPtpuueucLoCGNA8p4Aa+j8CCwXDmAG0l+95mcogc0GT0VZ7VfHdNW3YXDd6Xpsmba5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9242.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 18:39:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:39:01 +0000
Date: Mon, 23 Mar 2026 14:39:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v10 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <acGIxaIRUoaAjFM1@lizhi-Precision-Tower-5810>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071427.534158-6-den@valinux.co.jp>
X-ClientProxiedBy: SN6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:805:66::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1482ae-9b1b-4fc2-0a96-08de890b73ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	XbY6V2MO9Vp1YWwu8SK8AahoE2CuaDm7YxuwZO0yzrMWf+iCdJkOQsVIfEQuYTz3GZBG6oWcL9RC8wAwjL7WsKKDf+O+IpOloOYIxT5HljCx7n01wNBHzaT/CPl2phRCR2CRek/APkuKkqLIlppB69MGgdnlC/EN/gsXj9lcIGgG+E1Et4QD3VsF/P4Ni2DstThQUDy0oUJHd1UammDafu5tNikWsxZLSi+BOBfE/wUmXcGpV9SQWOQMeKM0eGYLgka64w3wcXSazB5uDU3PP1iVwe68wfw0VsKKDeNeapGVYBhjJKFe4Xk8ya7IiP1Mx2GyDHp7hY955c5hVaW2rvlKmHSVARRQtJsYH7edmnLlgXSZI9VOKR057s9NqwHNlt/Em/+S4SXMUbjD9VQC78mFqF+7mlitpWY7LlLhCBS6bZr1HpE7wGD/stxDaLBWKdcVpV2nn2PVgmhk7jt8GaUYbJ1HBV1IMrjefEMso4RlB9XCIz+Q/v4kknvrIvvwE07MoCzuKiHCA4ybkqBRn8bsDQD7WhMDOa6BoiRLD8hvi3yMF8dfbada6rXFO2tCo5nB9P9czWdOvDoxXYGu5ttY5lkULR/0FerWFVBa9Vb8roB2xdgeeTGTQkfapdooR1Jgw7UuoC4RCfV8jGAq0vmXef3h5Ff6WQF2qtEW+1PsfBq4sj1htMYJ4TDuRasXT/MNEezznHmIz47nlaYLPsmLiLXp7xN0ZuNGG8dZyohbaaTwNxwNZqy72hKk9VQ7ojwKHZoE4ouYLr8Kf2zf7wWDnB+Ghq+rjszLReY60nQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKy24cY/srMMdFjWlzaB67fGCK4QMYNs0zqCQzSmKd3zYXVTqiT4fuOnEeRj?=
 =?us-ascii?Q?fViSHksMqYww/xT2gR9lQln/xbSrLLBPFWDhrdh4lj3qLjNc/ylhca9n9VUr?=
 =?us-ascii?Q?Dz1kmOohtid7AL1hbSizI8VqHRoD7MawBQfuabsRHvvlSYYGjt6lwIPGffSO?=
 =?us-ascii?Q?/RBUCgWJGNXid4qIiWp0MSZVCL6AYx8YNgKuwcBq8whYTsmdnDF7F0ertLWl?=
 =?us-ascii?Q?5Ub4gg1emuNW+njecX1Zjms9xWrKOXr74m21hEmrsES+0QYQdDbrcVinCgW6?=
 =?us-ascii?Q?rbn9QO0/1JVtZc4goRq2B+wl37Wwk8imhI/DxiCntpK0HHK2xBpJ2+YW7qgJ?=
 =?us-ascii?Q?YVI4ylPNhz5Uhc9+ZCdWAwsx1IBhmYD8k/CmZeYwkHkMVjpSWJzTynvmiJ4G?=
 =?us-ascii?Q?5kxYAexXLnNAGS+FT2SdaIdn0nJ46tULRn3VnqfZcPmHt9Ao2nQPAwUVkR0Q?=
 =?us-ascii?Q?02Do8LtWl79BpnFLRv0m+STU7D/Bu8/6FlY6s9Dk4qgaNDD0iI3OFVuvYfT7?=
 =?us-ascii?Q?evoupQGGzt2L8cwN747dbSVnsgV6QqGUOR0dJ9851014CB0JndIBkeyKlpsJ?=
 =?us-ascii?Q?Ssi9e6iFP86WoPdedXBTigUeJWl2eYSfC3fz4t+KKjy81+Xdc2iqDxNtDszH?=
 =?us-ascii?Q?O1LFjvWU3Kqe/p9MucumELkFqQp6NVU1+89UbCw96UIRri43rTXmMkI+5R9W?=
 =?us-ascii?Q?ibZOmHGbS9l9BVeo2XTx/eg/q6r4znFbNcLsHMTdA5y8vXbPQoQI3uUN3/VN?=
 =?us-ascii?Q?mkq8IRa23xplCLSKx4YJw+RlxzTSvBZY7/kyjIKZbceT3IkFzUBBAF/R6exP?=
 =?us-ascii?Q?ABgSX75mGs1SXtFpEmfNagTERibUDBDdSkgohunHQ4NXWyc7pttUvID6LHBw?=
 =?us-ascii?Q?iHNbaPgAmxQrUrPIn7p4aexs7iRsGDLflu80Jf9wGuAw1WUSQ07ptC2ZU/tL?=
 =?us-ascii?Q?irrQIBmzXAVH6nizDcZxTTOazKKjXU87zwUtUL2ApOgmGeHfjgIFfTqKuKCn?=
 =?us-ascii?Q?tkDhDizOgH0VLGT6krVuVwCA2klOdwRxdVkA8iCU0hVvQt/wrDsDwzffss4u?=
 =?us-ascii?Q?AOdi9PJnLlgdyQ52YZMZPx9kUxq+XzoaP3flgg/ShLfpRRgPd7d8wESUrmk2?=
 =?us-ascii?Q?DL7tN3FYWitIEFfqbTK3snC3XpLX0gRx5OROT7gruRbxn3o3xHlQlDOTKuw1?=
 =?us-ascii?Q?49T/yihEQdMSE+262VMikNAVQxn8lmx/ym6E1B64XQ1t5j1ttjwFke9/YIUZ?=
 =?us-ascii?Q?aM3GonNlo/3xseW5qJWUuNSStRnO/85y1zqi0o27ymoJI0HSMH4pC5vyXEpp?=
 =?us-ascii?Q?Dzxc1dMjF7LdW/8bBYgW4HGLGI/ye4zQXP2kPQfaggZI8TXIqvFG+xkQFr3+?=
 =?us-ascii?Q?y/iQsS72GCRXYaMmEoLrG3rzh+K7W0gpaxIRXJx/K2HJR63VSaJvMkDAwrOs?=
 =?us-ascii?Q?t5S8UqzVbkwEFy153UmuFgt2BMW8lP1EohWJb9r3UnhV3YgvG1A4phKdj4mg?=
 =?us-ascii?Q?/1QYLjljgL+EdBqPxIkjsr2W7v7ZfJyJ0X7jHriCO1BXOhQJcfjYhuiAlMpC?=
 =?us-ascii?Q?MZE8XdtutfL4QT6RGsLB2TE/lfbYanLFXl8+bz0qA0MDqyPx+tMGIMQWi2OD?=
 =?us-ascii?Q?vGJAd3fmXh6BjhW/YtrXiJdkXlFGFkTZ0F95DhsMyWTt1a6doaLUEB+MqJBt?=
 =?us-ascii?Q?tczDRb8/zLxIUydQ2jRW5N1N1xBgsxqwLtoZeh2ha6T3lrQE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1482ae-9b1b-4fc2-0a96-08de890b73ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:39:01.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5ZXcCn0RkvrHC9Xu0EdAjsi9AkYtJkwclc2XOt83ZM2tl1Jy42MFBXWWd98YXjwJM/mQXS0a/X3bqOrqe+X/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9242

On Mon, Mar 02, 2026 at 04:14:25PM +0900, Koichiro Den wrote:
> Support doorbell backends where the doorbell target is already exposed
> via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
> must be requested with specific flags.
>
> When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
> pre-exposed BAR window and skip programming a new inbound mapping. Also
> honor db_msg[].irq_flags when requesting the doorbell IRQ.
>
> Multiple doorbells may share the same Linux IRQ. Avoid duplicate
> request_irq() calls by requesting each unique virq once.
>
> Make pci-epf-vntb work with platform-defined or embedded doorbell
> backends without exposing backend-specific details to the consumer
> layer.
>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 148a3b160812..8e9a3048c2e5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -134,6 +134,11 @@ struct epf_ntb {
>  	u16 vntb_vid;
>
>  	bool linkup;
> +
> +	/*
> +	 * True when doorbells are interrupt-driven (MSI or embedded), false
> +	 * when polled.
> +	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
>
> @@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>
> +static bool epf_ntb_db_irq_is_duplicated(const struct pci_epf *epf, unsigned int idx)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < idx; i++)
> +		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
> +			return true;
> +
> +	return false;
> +}
> +
>  static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  					    struct pci_epf_bar *db_bar,
>  					    const struct pci_epc_features *epc_features,
> @@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * The doorbell target may already be exposed by a platform-owned fixed
> +	 * BAR. In that case, we must reuse it and the requested db_bar must
> +	 * match.
> +	 */
> +	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
> +		ret = -EINVAL;
> +		goto err_free_doorbell;
> +	}
> +
>  	for (req = 0; req < ntb->db_count; req++) {
> +		/* Avoid requesting duplicate handlers */
> +		if (epf_ntb_db_irq_is_duplicated(epf, req))
> +			continue;
> +
>  		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> -				  0, "pci_epf_vntb_db", ntb);
> +				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
> +				  ntb);
>
>  		if (ret) {
>  			dev_err(&epf->dev,
> @@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		}
>  	}
>
> +	if (epf->db_msg[0].bar != NO_BAR) {
> +		for (i = 0; i < ntb->db_count; i++) {
> +			msg = &epf->db_msg[i].msg;
> +
> +			if (epf->db_msg[i].bar != barno) {
> +				ret = -EINVAL;
> +				goto err_free_irq;
> +			}
> +
> +			ntb->reg->db_data[i] = msg->data;
> +			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
> +		}
> +		goto out;
> +	}
> +
> +	/* Program inbound mapping for the doorbell */
>  	msg = &epf->db_msg[0].msg;
>
>  	high = 0;
> @@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  		ntb->reg->db_offset[i] = offset;
>  	}
>
> +out:
>  	ntb->reg->db_entry_size = 0;
>
>  	ntb->msi_doorbell = true;
> @@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	return 0;
>
>  err_free_irq:
> -	for (req--; req >= 0; req--)
> +	for (req--; req >= 0; req--) {
> +		if (epf_ntb_db_irq_is_duplicated(epf, req))
> +			continue;
>  		free_irq(epf->db_msg[req].virq, ntb);
> +	}
>
> +err_free_doorbell:
>  	pci_epf_free_doorbell(ntb->epf);
>  	return ret;
>  }
> @@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  	if (ntb->msi_doorbell) {
>  		int i;
>
> -		for (i = 0; i < ntb->db_count; i++)
> +		for (i = 0; i < ntb->db_count; i++) {
> +			if (epf_ntb_db_irq_is_duplicated(ntb->epf, i))
> +				continue;
>  			free_irq(ntb->epf->db_msg[i].virq, ntb);
> +		}
>  	}
>
>  	if (ntb->epf->db_msg)
> --
> 2.51.0
>
