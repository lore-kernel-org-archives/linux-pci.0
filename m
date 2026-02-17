Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE45303A18
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365821; cv=fail; b=c0o6Ys132910UTuLPYcfzwd2DpM8e/RREubq3Jtr/syIljyoy9V+RjPvEaFdo5CcWAHdh+8xW7d1fVMMViViVBSZe7RkC+6A1x9iAZoKw2C/YmqV3mq7VRUPjHQ65IWwxIG14Au9EU9YRv5SWoQ/RnD0zClKIffuAdIfRqvpGdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365821; c=relaxed/simple;
	bh=7L+eEBVXiL2U6hciMelwkuJ1gFosGr2wG1wcXvgRyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UNr6sy9RVkX7aDglCj64LqaB2kYDdCwrouy/5cry2+/Em1mjT04+iGv1cpUDJdXfMPQ5szEV82aUH4xoQbvNr0xtWiTQFIh1qvJZUICYmeT2X2M/KSFLFCH1JCcMjm1C2vXpCuLAprSN6UA0L7QyWBD5En55GdxIWkek3S8v9AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X1xdgS1L; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X1xdgS1L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCFFwrqzpDZ11JyvHE9UQLH0FwBjs7L0V3wtv5ce6fMGwXMf/gL7AbFRtb3dNX4695FK3kDdLXciyUfoZkIFLRx5BDIagIyLz3ZEr9i2Fs7btzV2us0qoGyNQqwc43uaSHJ3CM314HNXI4CRpKki0YSVA+1EeSzDe8+8aIL5TuyMrrgMsRzCWavaNu5P14No1Nt7Y39Ygthm6aMs8CN+TBVK2NXr/+fFA5gPHh4E+R7foLyXIjEeQCyr/2HMezeECq+asufq4PaqNiXI3Snd2tRR5U/T0u7rGYjru6UKn5GXgofyJzpoE5HrNXfYAakRMgSPdZkmh3DgNU+p8a1AFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJKxSggsmjHOkaG5Ao59IjVZkVHuwBK8qu/2BYxHMnE=;
 b=qYF1iLbSPpme/WhAGZbz8HfaHGFReMkA7Lj4A8siI4VIzGBjPLdk1He+JcCTK4LHUtlYENIFwkKPSwPhLNtG5T4llBKaJbpTMNYTyNNnjCmDtso7bnggQbiw9vSpxSFtcUnjaOprKWi8p/6oQJzDLW3O4c0IxM5KnyHvT9xtUpScJaC0EXz6SUmpSmZbW1q14OMWSWuws1vr/YRCBBOwjyCYotxR+JmAn2yEEpYXa2/GfdMFle7l5jBl+nn1OofesnROlAzCBBMyxZWg+JN1GgbaL2NEMl7bYjZiOnwJExXDmbNwzUaqOMsDE7bO5wVPLxjIEiV5gGHgaq6DPNsrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJKxSggsmjHOkaG5Ao59IjVZkVHuwBK8qu/2BYxHMnE=;
 b=X1xdgS1Lq6ajk6yZR2KurhdEq8zw1VZ45zzol1sFbXxOzNlvmV0ZDa+//rmhZKQKwS7wZDkd/MwhmS8gv7LobZQb83ZIp4DUDfrAJdm9j/PV2xbkmJUk6VbSO6nykwjOx4G3pCJeiLamV/qlIDmGC0MwzfDgTCFqos/dL/Vet3NTsiBfjGNje9H1hjNDZ63Dc449U6d/kZtlc/ietqAej44T/mf2kdmDJNmBw8U/rmagd9Z8X5J4MPVEO2l94hbcOT/ka3xgC96B64D1Gr3TPSTJnv9LNTop5TdUcsx8mrgxUAnfzIhGmOPbhqI7a9f8gX4ywHMQXBF4Ael1WCy+/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 22:03:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 22:03:37 +0000
Date: Tue, 17 Feb 2026 17:03:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_DISABLED
Message-ID: <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-15-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217212707.2450423-15-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e22327-ec62-41c8-cfc6-08de6e706693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WouRh1jGRbvwyIesn7bK5LWB4cEbrwntkB/A/8JHSezQ73kw6MOLhxee+tc?=
 =?us-ascii?Q?K/1mw94hd1mde1ej7IHfbkuwfem6/KiDroCRIMyzIg4W6GErXxHtZ9w70mUO?=
 =?us-ascii?Q?LttKqE49T6pDOYbOcTVe5NhDk0rNw2POUSU4IXgJVvdPOxVHb/qKri3STRuS?=
 =?us-ascii?Q?dYG09j7KFALogqMpPVt5AUAqKXZKC0s4EVZFIr2tM8UzQXuqP5bwhTbq2H8c?=
 =?us-ascii?Q?HeujvJx7Z0prLF49zx+zsOTAge/Ly3vpyXqUEwnDLrsweZYbGIX/Q1mYHUtP?=
 =?us-ascii?Q?r4c7wu5CqfBuNtP5/fWKsHLMWMv4c2iWea3dUVXSVdO85h0hiyrP5DW1ZjUU?=
 =?us-ascii?Q?8lRpx8UxVRQpE1COvn+3oqjeJxItTmV5+q7JATbcsu/fhm7eH5jZx4BaAOtQ?=
 =?us-ascii?Q?5RXrDkQ8n6px5wriggXNZ0KUFiY2b+4LwqdLY6SsQXHs8OTrLrqLCXVkfhQ0?=
 =?us-ascii?Q?fp7eIfIvmUSrPVnTKj5mhi0nuZqdVbBxnZXz45DjROhRkDO4SJWtK46aNJ9H?=
 =?us-ascii?Q?6yaJhzI1Qtn6jEB0SQ2d9Tegc9POxlVHkuBfx+7qedpe/cudW/y71f2Exn/i?=
 =?us-ascii?Q?S13EqU/EP95uYh+pnxl6BecBuWdjAZHCMvuZ5NU8AgIcrM2F41AGggFsYVbI?=
 =?us-ascii?Q?WwPaZbfQm6c5hFB+f9DCdA5J+Fjl3u6H3w/DaPIiJOtQ4VCzTLMFtcHPa6WF?=
 =?us-ascii?Q?AlvXZZDC0xdsm5z22RH49QpPvkAoPYIZq5DWTmgZNPDl5f7k4+lFJpOSYMc8?=
 =?us-ascii?Q?wXWPgH5k5qpfKbXSdigzqZt2azOFHwczng+oWFRZ7z+SNBS/zrH2f9vl1QZA?=
 =?us-ascii?Q?W9k4VZQSwt96RBF1mUKogEmmsZvS9PpegS7W0i/1DzXQFY1GZ17Y5fX4qaQ/?=
 =?us-ascii?Q?kspjtuOPNSChuDXH6VPQa48EolFVMGkHkr6+j3PdB1CBjwGwD+vciafDSOO1?=
 =?us-ascii?Q?9eJSriOOAQRfsHNoOLYxC3Lu8kvhHT4DszqE76vrEuxiNXEyNnMDKePDabtA?=
 =?us-ascii?Q?B1hMeh+sghMn56kuDToLQ0B/Okd2dYZ3E470Ci2tI4kKAFQyme2wmXFg3V9C?=
 =?us-ascii?Q?Yd0jO7ZcTi7Oa//2Q2SoxrCEWKKn7HZ3Ub/jM++ctRdyy2ymyKQvpyNOWn6m?=
 =?us-ascii?Q?m0zxR7lER0Mswkoe8Cz8XgkJWBixdhXLMtH7LROaTKcS+CRg19V/x4adnOxG?=
 =?us-ascii?Q?S08XOM0Bkj5oKoWM4iZVlCtSq9eo9QP7+tTt0lDInVlP3KSc+kOXBKaq8WKi?=
 =?us-ascii?Q?X6YknEkn2Xdts1llEjp2tx9lrkQmSEF4uTxAgAhz3ivGtTUYKN90TYmVPQ9Y?=
 =?us-ascii?Q?jGmSL4gB+2WgVLo68Ki4MKB4Z5QD7YTY18U7pPceoc8tSBfLcyl0AeX/LyV3?=
 =?us-ascii?Q?GOuiuEIcQooPviTfkMq5PSVI+Adh+SZqgvKivb2Md0KpIwMi1LVQvW7YHneS?=
 =?us-ascii?Q?QMDeo4OeQXf5uxdYgkRiv9qdR9bxB4wKaRy4wg9Ktas/hcs7V1TsQuZYGk3K?=
 =?us-ascii?Q?kclcYi83ikMqXqrcsYyY+RWPkpqXWgTlWQXrldBtiRmx8zrNuh7GJyai1SFa?=
 =?us-ascii?Q?V5vWRWzKQYFLvdA9o61RdByRJ+0lBsrQIQB/n/S5P9ByTWPSC5TtbPE/38d9?=
 =?us-ascii?Q?eRxwtPwZXtTmH+WER/TQMOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lqCK3Pkcy0VQ9l3wfc0D/nK6w0HG5++/6URBXDaPebpSRi8zvjwL/vWso1J?=
 =?us-ascii?Q?EmOurw/R8x1myiCUo8vkvRgWxBoq42g0tlT6i0vor//n9lpSLv8DXWW87+JU?=
 =?us-ascii?Q?fDBPF3aNCgPgq9mOWhv+pbJenx4eX2fdXHtNEUCaY26sm2z8MVC2+b1r3pkN?=
 =?us-ascii?Q?/I26c6yNqUeFlOrdZ/ig1sz0AIjk8QwVy1BD4zFU6BSyEMjI1R8sN6mm4ezJ?=
 =?us-ascii?Q?emy70mMXtCNIIqHJaP1S2KCV0ALwgrZbE3MiKAVLy++6nDpITtlKJFZP4NXQ?=
 =?us-ascii?Q?fVZevfeKclYD0/oGKGIeJWZhCrl9aCMBuTLtC4f04SsYf69fVH5qjPvdih3h?=
 =?us-ascii?Q?0/A0YxSZc0CjWmti+bWO0OjD2XftCs9MqaLvQ1YQrgJDhBonQsvOAEfU8aYi?=
 =?us-ascii?Q?GVQr4oSR9lNXcFbj+Yx1VMIMGNujG9e0Lfg+jpY6SR5xX/VSqqoZahNB7s7T?=
 =?us-ascii?Q?WGxnFsbtfbzj7Ytl/BAn+zNN5sAnJJmoZGg8yXolKt1ScmbhBfWdNnTw12at?=
 =?us-ascii?Q?E6hw3kxGYpCPL7ABqLEktGLUXYmZJo88fTyBgtR1XXpJgkkDOknjpsQw/hal?=
 =?us-ascii?Q?hXp1nAf98LoOEzPQX3SNQ7DQm1LKXr6lKho5PxKA2TuKvi0GpQnvcPpsqQ+l?=
 =?us-ascii?Q?a6pXceokyFsO8fEKUia6r3b7JoCK2hV9BbTSDuJkpWv1eAqQSVPzQ1T4CYVq?=
 =?us-ascii?Q?ckZpkH5XRIVj1aq9Y1CUsF9VdPe1KdyF+M/lhly8NAetLNbJspOAcWoYxy7c?=
 =?us-ascii?Q?YpSZS+mW9xNtEuAaVv1D0jrcG1TT4NpoKicrbCz/p52yMkco/krzXERUbK8e?=
 =?us-ascii?Q?sCMpgabzXb0x1TIYsKneHj1Ptf7dORPr7D8uLg7z3tyavKOj+VcHdOulRwNw?=
 =?us-ascii?Q?DlxtMr6D31yZD3aUrgovEH6a1/nibr9Ze2RvoVvX1aM/iWeunVrV1PYe812G?=
 =?us-ascii?Q?BxGgwiNW/qisfiT4XSCV9vmnSkCyldy7Nh7W0iTXW13VLnkqRSTPbwQUFclq?=
 =?us-ascii?Q?Xsco/McwxF3nRbDPYoGF23vpJ3X2Yp0eY9SUidQj06CV2HIgG+lcnzySgSRd?=
 =?us-ascii?Q?uFkDY/Fhw0JYFzL98Mbkwep0jR41cv4mS4AlOGdeWmWq0dImlkmiSBBbDpiD?=
 =?us-ascii?Q?llmU1F7d91wqZNP9kTTpx4JsbREt1MXGd0Fkbdfo74/RgJwwtRGHJT/Ed0gy?=
 =?us-ascii?Q?jtD9rSruGdMXh33+cvGAymhx7DyNaGONdKF/Bg6ScG8VXwVx0472ha+ZbwHi?=
 =?us-ascii?Q?UZMyUJknXumEX9wD44Fff1kt7FYBXb8uJJuxTn9HpKwUlClryJ6XbtN6oTrc?=
 =?us-ascii?Q?8OKkpKJBU5Uqc4kt6LLlZBQdwqf62mkfUEIeOip502cEySl7uMVyA79NMiCh?=
 =?us-ascii?Q?MvtArLv8vzOZMOo0Q1Dun//BjC+AUKkLebwD8jY65FXMqZ1u77/iGVqotOA3?=
 =?us-ascii?Q?85++t49PbxHXzkmXKvaH21E+exssCiuWZttQUCy0WqbUEqxt7R5Ghny23hlJ?=
 =?us-ascii?Q?E9iIIbRDhq4/fDY45qwsJ4IwxEbJdpsY4btDnRpEbNkDoGPtFlJ6jPFqRlfe?=
 =?us-ascii?Q?U2w2/FxGZd6DZEGAo3ADq+raFaW1Pd1fnGSMbt1tJGyQbSZXeimxWJT1bsFE?=
 =?us-ascii?Q?I5a/jk8ft+yvQ+9HNuTHLMvwtjuOj5BkKhw3d6Fm/yq0SxzXToJa+8RHB3Dx?=
 =?us-ascii?Q?EnxfPyoyVkulgoNmeO5eGCqu8IICKCV7UzkFGLGXHwz71TP7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e22327-ec62-41c8-cfc6-08de6e706693
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 22:03:37.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXdnA7WbWXQI7Aq4SbTwyTUurg4HWiQ1HslrKzOZ8rNLUmCH1ksfwgrpXoYujwyvPULQmThsEmwDcrJ/EizJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658

On Tue, Feb 17, 2026 at 10:27:10PM +0100, Niklas Cassel wrote:
> Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate

s/BAR_64BIT_UPPER/BAR_DISABLED/

> BAR_DISABLED from BAR_RESERVED.

from BAR_RESERVED.

>
> This BAR type will only be used for a BAR that the EPC driver should
> disable. (Unlike a BAR_RESERVED, which is still enabled.)

confused. it looks, "this bar type will be never used by EPC drivers"

Frank

>
> Co-developed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c |  5 +++--
>  include/linux/pci-epc.h             | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 8de321e1c342..5045e22367cf 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -103,9 +103,10 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>  		bar++;
>
>  	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
> -		/* If the BAR is not reserved, return it. */
> +		/* If the BAR is not reserved or disabled, return it. */
>  		if (epc_features->bar[i].type != BAR_RESERVED &&
> -		    epc_features->bar[i].type != BAR_64BIT_UPPER)
> +		    epc_features->bar[i].type != BAR_64BIT_UPPER &&
> +		    epc_features->bar[i].type != BAR_DISABLED)
>  			return i;
>  	}
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f7f48f43d370..8687b9c3462b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -191,7 +191,14 @@ struct pci_epc {
>   * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
>   *		   NOTE: An EPC driver can currently only set a single supported
>   *		   size.
> - * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
> + * @BAR_RESERVED: Used for HW-backed BARs (e.g. MSI-X table, DMA regs). The BAR
> + *		  should not be disabled an EPC driver. The BAR should not be
> + *		  reprogrammed by an EPF driver. An EPF driver is allowed to
> + *		  disable the BAR if absolutely necessary. (However, right now
> + *		  there is no EPC operation to disable a BAR that has not been
> + *		  programmed using pci_epc_set_bar().)
> + * @BAR_DISABLED: The BAR should be disabled by an EPC driver. The BAR will be
> + *		  unavailable to an EPF driver.
>   * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
>   *		     as only_64bit.
>   */
> @@ -200,6 +207,7 @@ enum pci_epc_bar_type {
>  	BAR_FIXED,
>  	BAR_RESIZABLE,
>  	BAR_RESERVED,
> +	BAR_DISABLED,
>  	BAR_64BIT_UPPER,
>  };
>
> @@ -238,7 +246,7 @@ struct pci_epc_bar_rsvd_region {
>   *
>   *		only_64bit should not be set on a BAR of type BAR_RESERVED.
>   *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
> - *		touch, then both BARx and BARx+1 must be set to type
> + *		reprogram, then both BARx and BARx+1 must be set to type
>   *		BAR_RESERVED.)
>   * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
>   * @rsvd_regions: fixed subregions behind BAR_RESERVED
> --
> 2.53.0
>
