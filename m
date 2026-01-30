Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C6346A19;
	Fri, 30 Jan 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795301; cv=fail; b=O9Fxi/aryQf5Ge/OizbuujN1KBMOafXipuTBWSGUMAZWLA62SCwNTbzwoE2SJoApSIm8GrYHWSSM566tNHif/91wrriLfNXp49z1UcUlxYWyt/1aLgrr5IZisUcUyHLwr1wMlReRbbj1bGMlAK9qEVObJDf8weyFYz8fgapE7Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795301; c=relaxed/simple;
	bh=aClovBkfu60C4er5iCMUp7pFz8RUmIok8LAsFrh1iR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ACCJtlgz3KOHsz96Z+7Mdl8+T4Vi6yuXt23xJNAJBSIpmNQTTC4Ql8yli96Q7n+AJGxxcki4hzV6N4b33/pfvGWyNVEZKlsSVWeWRJpkDcu0NJm9wI36QckAPvrq73vgiYWFEv+FJs/bc0plav1lCZAR9fy9woIsPBPVNWxZrmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Juj26psF; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Juj26psF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDP8ZMl3FJnGKbjV7I92Jyaerln3BrOcNrZuWjcFaI9XwgcJJyarUEyh5kt5UHiZa0V+wlOfQkZVPZIm4dZNhLJnoMQTZAK78RUFM1Zgw/jSXlxMRdbKOY3yctfmfkZ/qdBK7t9qPYbTJnqFpWa2R+0exu1RPXKG72PnRAYtDPvVd9cJPsroBVUmDymtLh8GQ/z4cghltQ1rIl3rCZkaaWCbt2DWJt5jNvHplD2RINhqxc5lg9vku6pCTflk9YvS1kmIZSMcDGROrdfgNNSINQBv4VmDUHAQbk7Q29Z2Vj5de2eAwNL7vzN7Td0pmK1emYx+qbraE2w6lYchmCLg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U7jb/1Pvx3wDT5cHisI5WEEjMyjw+jfrYLKbk5gcV8=;
 b=pZI1k5Y7cTLH4jCIsm+pNvxaolb3hNRne4lRk0y6v8WdmW1uz6YHAzQ6Ufp216NaBwope2Rq8ISjZ6uHR9f3NMoC9nyt5xPIY5WOLsZ33cR0ix4tnxcue6S/hHKNWvhbCN5v92cAtdJEHY2R++PDeg9aogR6btWb7zltSIuSFMApG9wiGKv7ZsCJubCU16/fkQxEovbfNgRHKaVsxxLw6jJ1uetSH0RyKkUsA+qAYncDuq8sQm9z0dt56gttR+x+/KYzMLV5lMgYoafKDvH2GZKqbAcSVM6kxUbdVJX1QQzbhcr6X6Mnkjo7H7CCNxHv/q2SckCm6E8N5S/syMxnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U7jb/1Pvx3wDT5cHisI5WEEjMyjw+jfrYLKbk5gcV8=;
 b=Juj26psFDBAI0F+NmzNX6h7p4f+qx77EWaqZ3PckDbbZmiAmSuLVSO53xUGdrRZTtvQxuiGlMtm8r5FLvHY9iBhsgLcDL/9uwKcXuikKZCow4oxVi5S8zU6IB2SK7KVUY0TnkSSIFU2DB5S1UiO2Wca73ZiPwkdhCp/waDS1vSiFifqyrzvnHeJ0Bnz4ldt+wVUGmDry0jQTjjMmLsxESI1MtcLjRURlZchCR5XcNz/mHoFhks+76DfVH/LDC8CvzwJyQg7lW2aIAFvw2AI6Hu+jzNAsva1vrKdhIQbcqfx9Ki9vnapPprRMSbem3WiRZVdPUToeXO0iTwhB35IDzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:48:13 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.20.9520.010; Fri, 30 Jan 2026
 17:48:13 +0000
Date: Fri, 30 Jan 2026 12:48:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, den@valinux.co.jp,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v5 3/3] PCI: dwc: ep: Add comment explaining
 controller-level PTM access
Message-ID: <aXzu05DSpiIgWSB4@lizhi-Precision-Tower-5810>
References: <20260130115516.515082-1-a-garg7@ti.com>
 <20260130115516.515082-4-a-garg7@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130115516.515082-4-a-garg7@ti.com>
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 73505524-f025-48bf-7aae-08de6027bd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEJffboPGvAqjchrZ+mW+PPI4KgDtq2RXXASjV/MeUdvwjGFKcX/wpCemXvN?=
 =?us-ascii?Q?x8uc8zm6ZEainoFfuU3UIXaMMtWkk/xRGiHJk9ahSmvOyCtTN6VRebfC4ULs?=
 =?us-ascii?Q?vqXDMNDCq7Tzw+anYwKbrxviTvkUjN7tjL6vVw2npzYN126vSr9Ss4ntPFGe?=
 =?us-ascii?Q?E9oD84xoi2Rta4suW7NIjtmoRUaAbs5/QwjgvP6IqdXkL0FCNCJzx0bus/aQ?=
 =?us-ascii?Q?O+AJpv4QeTVYRSEoNRB0yUsChhDESHBnOTXDPc0tT7r2A5QtYRcHbHKv82hq?=
 =?us-ascii?Q?uWnjNRKtapb/RS7dil0iKC03qxG0q00XFSvKI1sKtTGmV7qEzkd2HK6Zl4zO?=
 =?us-ascii?Q?Cc1O5vkA7qypA7N6H0kKxnHpvIedlZhnvaYZ9hCmhQq2AFi8tozht3rE38cy?=
 =?us-ascii?Q?Jz3sjLJ7nBmALquccHCovY4dvbcCHXjvKvb7IDLQbfBa6+HzNbVQhnJgYTot?=
 =?us-ascii?Q?ubyousAZzydaFy+Vh+AQ0aRfMrGNHDRwNRM/xz80I+BnGqy3zHgWWm3je/56?=
 =?us-ascii?Q?NsBKOz8x6VJcStToTyDmTZbQCMuFl7/dzMfQGsKmGbaDVHLyNjS+5wo7MerZ?=
 =?us-ascii?Q?XoJWGirOezcRjQ19G0fx0Zdbtcq57djjwkw9Xbqm2bxE5Xx5MQmtHnv77inP?=
 =?us-ascii?Q?j+nxb2mqsnv5YyOuOE688hp2GKqGowrbn9D6ietx5jOfXt1wtuDJfjP4rKY0?=
 =?us-ascii?Q?cCptSCPJJJ8q8j7+38HP+bLG5Kmd0H2glOOC2Z5SpODJSDsNwxG3h6lG/Man?=
 =?us-ascii?Q?/QoYDs/J7s54cjHxK6XhRllqHfQyyZ5yVspdSydPdMQirO+gTS1tECicDqIQ?=
 =?us-ascii?Q?xQ14yzahZZ3nLPSr+t+wqYJnQSn2bc9Ql8uZ7DDvteCK+8CJBqPlBnsa/X/n?=
 =?us-ascii?Q?g/BLg7X7udmk62jJlQ8SxNlbyGGhgJTwn8NREWh40y1Rm/oAFO7Fo8OpSETv?=
 =?us-ascii?Q?tXWASwgn1BcDnWSY9tsYjySPLGngs8BLgkwPUvvqrz/pRymrUGS57E8Whv/d?=
 =?us-ascii?Q?LTryTVFV6KfRisaXaJgeBTinmnXbfNBf6eKAXl+705nTlL51YxdeoO9lFrWv?=
 =?us-ascii?Q?LEuZo1MwxGs3bbhxMdEmm5rd5PYStcpq3HyF4pxIslZBYBr4+WaLURRdDt0c?=
 =?us-ascii?Q?N3yPt1mxvz2X5HmgkdDr9AGA0gvf/SRaRgbDDniPT6iL5SrrahKYnvcBbQiv?=
 =?us-ascii?Q?iyxcUvM9loj60dQpVzbgfZJmHhfckcS+MWVFhO4FIUzir6CuS9uVb7OplUP6?=
 =?us-ascii?Q?Gw4F8CI67c9jVM6O7lBeZyDIexlARW0PPuZkVfqKVtpXlSjk1/mOwL8MOe7W?=
 =?us-ascii?Q?k+4dq+V2q+cYMTnzD1YjSonc95CYIsNn8T9q+FrmA3WnbqfxHwsZVfJp9O5B?=
 =?us-ascii?Q?t9cKWKp1thgF1I3Xc71Tahxt2Q8OQaVRHgl0nAbuK9O/BlwhcsL/xZ20jbc6?=
 =?us-ascii?Q?aXZ+mhMopRQG5nW9lS6T+PlPL6XtENlnkuVk+X2ROHzebcriAn0cjrqXaKxU?=
 =?us-ascii?Q?n8ADUGzuA5YQAIwPIJSjDcjaG9AOSFRscQIGdPB6t8dAF4ywdrzAG5cQd3CN?=
 =?us-ascii?Q?fjxYWzUoHqctcYfSK7tTxwn0kviyC/+piXpOH8cQuvQtnyefY8SZk7a7CHuL?=
 =?us-ascii?Q?uKFAOXIvQOKUp/UbI34ybSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRH9M0wBVTnbU9QDl59/A1w4cvgTrVdpNO5ormHaIpvYG2r40nIYt/SNkocW?=
 =?us-ascii?Q?aONxuLFHTeH4V2Ea3Hgm31Sxyd8yvBzh52blGf4vVyCS0WuLMhuTnBKfKRMD?=
 =?us-ascii?Q?nB6y8kmJHD7ntYWMj0xgaw7uJqWw4jPRjwX6oFU71fWnwc4JmuxHr5GHIA3t?=
 =?us-ascii?Q?uDUkT7yGXourr19xPm1HUUctgjP9uhafjHBs5hOfesHTct83uGYHwbAKpsJY?=
 =?us-ascii?Q?hANT8bHFaM/UkzD1rvrLr1cE38PBbM/aPhuZNWu0QgLoGKCy2MN7jB4bSy05?=
 =?us-ascii?Q?O3/AfndK1YA9CoIs0InVYX+eOTI+Ue5SyPRtSfif8xfj4LWIpyLdA0CRdSrk?=
 =?us-ascii?Q?NIIR1hnCd1fhsEiZHqd3oT8Z37rsmJfj/9fI5vRoluZOMmJJuMx3fBVBfrMH?=
 =?us-ascii?Q?yTc48qwgU7qrZ13Rag83+IYFqRz/6khZ4p18yIT/O5YeFlHa3QnP9ep6Ew68?=
 =?us-ascii?Q?z6RxjIB2wzxMqqaFu/MAqD3WRgCr8CtFuLM1R1PNUZrMB9rR+n2ExAPWD6px?=
 =?us-ascii?Q?qYhYE5nOfEjqSV4yREFqAXX4/xzjjNeZvqFemO7fxAbGFRBaKSU6hJsi6oN6?=
 =?us-ascii?Q?zX8IU4HsNRTug4nQwe5k3TV2R6W0PpZCuXoG5IsLliLbvy97puQwDM9tjJCy?=
 =?us-ascii?Q?amKm6EbCxkC76XtYOkeUI0wXzT8P/ZmulvI4jl+ZohCx5nDgMJcCvmfyJJ8k?=
 =?us-ascii?Q?arjba1xoBpFcei1pgHx2Og/MHzNpGXNCP2ektWkvp4f8ir6r/d23P7L08E4Y?=
 =?us-ascii?Q?aspgtTxsxH74bU2x3TWoU+kUcQve8ep3S9laNBfofjBCbYWrHNwkas/62rqR?=
 =?us-ascii?Q?MNcTehG3acRfvqTR1Cy3Kqn+OzGNAWy5yWDLlKkZf3OBhFhxcnvG4Kwozicp?=
 =?us-ascii?Q?PudZtHTBEEO+bT3ZSketPWT8NUq0SyvTN+Cde5QlF8JQzYE6YOhXoP0keSUy?=
 =?us-ascii?Q?sgCF+TWGxrYZj02G/nwzPJZ0knOUruGJRourR7VJIHNuaaKpsejNNE3MGv4N?=
 =?us-ascii?Q?no6L7oFAEhEPRhM6pTcxcxtMtli8eJM2n3qxqCxYRbdjSyh7RxgP4F+hIq1n?=
 =?us-ascii?Q?7UNO/Om71qUu0XCEARvLrnXOMnoQN0OwjQrsf8Hi47ansLwmpRgGcICcNZ5Z?=
 =?us-ascii?Q?KQoIEdaNRWOBtFSK8/B0B6+E6ZIXSpJTc8EXPZLELaO4S+Id244PBRM94SmT?=
 =?us-ascii?Q?xOKIBKr0Gq0ohsMM4PjAuiD0C74bhzUnObGYLN4OzucEn8aYolTucVGYpgom?=
 =?us-ascii?Q?aRDXhKxuNRQMK/M/oaLI5gQvE6CRPpCE9r2kQj+mVfJ5mmDrcIAGpwwA3iZX?=
 =?us-ascii?Q?bAe23ra1+KAflRKaoJqH9F03fTUwEVIdXGRmUAgPh16Z6rXjc3ytBBM+zbdM?=
 =?us-ascii?Q?DtPLoJTiRQb+m8OqfzVW/5LbyuELjyj3gkdlBYFCO4hJcTCPwvCSIJ6S2vPp?=
 =?us-ascii?Q?FFgzF3B60UbgUEfb7X0fn+H2qbrI/RpK0gavjuOcNXMpZPg/zZgbElE2uQLN?=
 =?us-ascii?Q?NZtzTJ4fIgWyjWzrdS9DTym8aaKV65L3PDhpAZTNLbofTf2d2QjNe5xYoF6u?=
 =?us-ascii?Q?GN+ZdukFANuekez7An9misTxbDMeMBn4rj4ifeOun/sDewqDOuI2hRjlPF9O?=
 =?us-ascii?Q?I7WHk95f3DYBnRbvMzJG0VetIG9zxuZsPJtrSosWBnLRzTIUv5tpXCmQGckY?=
 =?us-ascii?Q?QDWu/tMsnO0ltYulqE22RDp+N5M5OwhVZYiTFbc33hHns8Vs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73505524-f025-48bf-7aae-08de6027bd4e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:48:13.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJWXL+rcp2uO9WKD/gqC8mnan+8Lmla8tt0YqHoe2NzsvyC+LrBgX7w1nMr3VDdTgPpbZjEyeEnmSidS+BmitA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

On Fri, Jan 30, 2026 at 05:25:16PM +0530, Aksh Garg wrote:
> PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
> function to control all PTM-capable functions. This makes PTM registers
> controller-level rather than per-function.
>
> Add a comment explaining why PTM capability registers are accessed
> using the standard DBI accessors instead of func_no indexed
> per-function accessors.
>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes from v4 to v5:
> - None
>
> Changes from v3 to v4:
> - Rebase
>
> Changes from v2 to v3:
> - Fixed the suggested nits
>
> v4: https://lore.kernel.org/all/20260129091753.490167-4-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260127085010.446116-4-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260122082538.309122-4-a-garg7@ti.com/
>
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 6d3c35dd280f..dd48e60b513c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1187,6 +1187,16 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>
> +	/*
> +	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
> +	 * this capability structure is required in exactly one function, which
> +	 * controls the PTM behavior of all PTM capable functions. This indicates
> +	 * the PTM capability structure represents controller-level registers
> +	 * rather than per-function registers.
> +	 *
> +	 * Therefore, PTM capability registers are configured using the standard DBI
> +	 * accessors, instead of func_no indexed per-function accessors.
> +	 */
>  	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>
>  	/*
> --
> 2.34.1
>
