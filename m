Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D5356A07;
	Fri, 30 Jan 2026 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795020; cv=fail; b=NeoEOpZKVdhl/ucG8kJZcPaSdhSibo+MO1MkK9kxjOoMWc/2vbJfvBX7rhTCepMyilY3cOfVQcgoQREjsx9D7QxNFZRnqQTzvIdpkc+fgUfLO5JjhmrWUZBnTlrVqvEW57QNITq9oXJKV2p1SPun9PQv61rjn7nAsWgvkfVmVdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795020; c=relaxed/simple;
	bh=7UjwRxcFLdl80wbksc1VpN7gcoA7m4w32kvNPn1Yy6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkUVTbJW9LwBITgPT9pnkOukG2SwtafmhzYW6x76MK8MNMvGS7XzjNhnoZgmwdaR1xNxpBpNfrcZwZ7KDArYSwBp4GPDGUrHiuKIzOvlEpoYSLLpZNAgOOvFj4NYXao4Eu5PmqRGJcryZCItuYRnzYigBRN7wXqF9gHu6SCZZWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q6A9Tjwb; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6A9Tjwb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVl6K8sNB7oIFMo9u0kFTAXvsv62ZLBy2sH0/2/sgeWkDFu2ZIygK4deK1SFNZEfLdNCdrUjZvYN8V3/P0/l55k1NDtMRh4l1uFPKKBDkYb8/Y+IWW6pMe8TgxnQLNVqEEVOy8afcmwWk5AW3Q/4Sl7+mlJjYaBMG+A39voorH8aSgyQtUoXrEKLZNxIa0iMHa/Xq3dcl2gVieGR5hRQR8fjb0uRDQouTnqs3A0LSPT9tHNg5M80iFYlYvoKIGMNAiXXwkju51qcQ3TcQtlM+z/6/wMvpMxW17w1R7zV0eJcATJJ/m8dZGF+JNrzL1lViDPVmHJTWvj9nfVTqyeELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXGQBAQrto7t0ay/AlW4LuLy+896frDVErkFIrK6VDI=;
 b=yCE34dq0v0aJXJZlpJMJlRQPTq3YpC1S5uBUMx5TMRmodmU9QfXlBPSYameI9vf63/xLsaiKuRB4BCHKp6qo/gh56pd96UYQ6BlRyzxIcBDBZ8/qEwU0qkPqdr95nnDWMS+dPhfY1ifeZc7hyMe/2UoIIqWPqGnh62p8dcYGfZim+/yahjlvAkmNUudoUJ9LuaC2IO03qdyOGUb16tRImokkaGSmtJNG+mav1XNU5Oc6YcWzPiBmGSFzL+UzzaYAUp7ZQgmuwiQnYXy5vFI6pQ2rGCtTwVofj4+fg68oWJ9wwG7O1yBZSF6+r00E2PP30CmcMExWpQ0Ft4tG3KWcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXGQBAQrto7t0ay/AlW4LuLy+896frDVErkFIrK6VDI=;
 b=Q6A9TjwbcWQyCRBobinKaBJBBChFhgaz2EkWcD63k43GhQYdVda+THlkQiSxI6laqNGLhiFpoNFOdimvMhTEg2MgDl+RLqq3suN3m5oO4BGup7AMf0Et3f0Cx68wFQmrFtKQ23mR471nVPUzZjSXEIgdrn5QF7joTzL8qZsVj2sFces0xrMuHnL2n2kmwkSAzuZ8/EqSkb7ykQwYhpdoxMl3/P1dcjs20c+OUUYZEIP744RdI8xRsP/XtTRFsCBvOvMN7dfRmBdRhlT7iNZrEsXrmyBYczMkEXnrUlvecdhc2eGV1uNmSZi07D1aHZ1JyHphXQHHQt8YwxToEdCC7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DU4PR04MB10621.eurprd04.prod.outlook.com (2603:10a6:10:585::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:43:35 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.20.9520.010; Fri, 30 Jan 2026
 17:43:35 +0000
Date: Fri, 30 Jan 2026 12:43:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, den@valinux.co.jp,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v5 1/3] PCI: dwc: ep: Fix resizable BAR support for
 multi-PF configurations
Message-ID: <aXztvRPGFeP/B1jb@lizhi-Precision-Tower-5810>
References: <20260130115516.515082-1-a-garg7@ti.com>
 <20260130115516.515082-2-a-garg7@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130115516.515082-2-a-garg7@ti.com>
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DU4PR04MB10621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be2ed73-4b46-47cb-d353-08de6027174e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/ugVwP0Q6juNLFW4TqUEiCDutCipaKxi+uECQ8+kpjoUsfzWG1XQuV6FBk1?=
 =?us-ascii?Q?j4X0vwb2cAVpvuEip9akqBFsiTBT5z3QdMrHI34ZA6WM2kM8F6BT66vjYTMP?=
 =?us-ascii?Q?WQbGOMprSXcFTV7Gqw4tVbw0rd+9rAVjZGywo2vCGlh2PG4xlC/ZHeDg/JC3?=
 =?us-ascii?Q?MIR8rw7jztoutesqQGt4KXnwklUFiFaZGAmj0vwZLUlNjsUFcS+oG0OGsq9v?=
 =?us-ascii?Q?+ELt7KVP772l44XIqeILNaun7QVGMo41DOXwMHcg+0ZajutVHOanA50M7Trf?=
 =?us-ascii?Q?u9Ve58sSmE8Yp6+krUh1Qb89pNQCBYoWHVW5OCZ9P3k6YMvx7GUFZuTa/9iU?=
 =?us-ascii?Q?szY+2N+9WXbSDreOAxXl41L9UycrylAj4UYjkM9vhlI+VaeJaP+LiFkVlGIR?=
 =?us-ascii?Q?vcA9GisdBM+OAe+pkFQgmUuGhYNft+7ecCiLkJEc9ux8Nq3paCwyGruGOPgD?=
 =?us-ascii?Q?VVRgohdZn20Tspd+bTsy47g4TJn/m5Ff7BORWukJBwXhG26oFxP+TF4frq9P?=
 =?us-ascii?Q?FV8GwwY8IPr1FmUe7T+8IFaROdUsa1pJjHNV7T4R6D4LybtdKdQcFHsAYM2h?=
 =?us-ascii?Q?Dl8YLKXmEYzCmoxhgQxjVUuu9Ro6ZTsk7HNF/mnRGnhfR/bK7n9j4ilggI14?=
 =?us-ascii?Q?AuKw1bDRVBIRoBvio9SQnc3TP7LE/B7PuNgkQwRqBl6/3n48TmDevWiaciYb?=
 =?us-ascii?Q?5utjOyfEHkh38JBo76EGuQ+7DzexgPo4vae8BzIR1RKZ9o8iuMPL+riiYU3b?=
 =?us-ascii?Q?4oHHWrMb1n7wAhC6zC4TdFgvBT2I1+ur/zsqwNofAWbfHS40e+nGXdFfgKRm?=
 =?us-ascii?Q?OER49axKA/Wsk9sXgcmL+nt9iyKMZX7K+QK0rD9t40UJeZQw3JPjiNgUZvqF?=
 =?us-ascii?Q?e+CvZx17Awqse3Q7ZLtmM2OynW1QVEUfNUSJACL0KeKrQO2d6I6Pp+6iLQJp?=
 =?us-ascii?Q?ujIOCSZpms5B+fU7fV/pIntf9boo1TTTQ91DuVPY4pM3fpOxJPeCJyTGHwG8?=
 =?us-ascii?Q?9WnzS4aqRKdvDPrspNiodeFSGR0C6+DJX4n1ME2sHeh9dwgEfbLBsUqtNkxk?=
 =?us-ascii?Q?OXUVOBE146M9S0PLzRGg21+kI2EGyF4bS9LrlLm3EQFlp7rWFmztCnWXY8Yd?=
 =?us-ascii?Q?+xWyo77BM9Nu9OQz187XAc0kVW8xR6qJT5/cbwmeGnV4E0c28pgOddHbB2ey?=
 =?us-ascii?Q?NASP+uHNTQideR76fLVDG+llCir69vi8QV6+eiw7Tz47i5pyp9UNwGoH443A?=
 =?us-ascii?Q?uIeBJ94cDa9ZSYsBZaueWDFnpu3rd0E4oDa+MQivD5FBqBx3Rv+4UlMvEwW3?=
 =?us-ascii?Q?vC2aut7LlZ8jd+BbaoFKJcjtdbDucWbgRoiOw9k6c6M3Xhv+qlxK+netQH9X?=
 =?us-ascii?Q?0gXLmlXDjzDEeVtK7SiuvrgH/F3LO2nF4Aqfogsso0t5MEEzdNfZNFSfa39W?=
 =?us-ascii?Q?Gbv3NC5d93Vqbm2qCyWluwg0q8fHjuLgjEkzUNdTf2fchCxZvYO82XbgtJUj?=
 =?us-ascii?Q?YfDXVH1aItCh0cLQbg+bBuKEtKqrv6QO5nOH2blU1UjoBDDcAhET9ZftK6XN?=
 =?us-ascii?Q?J5KGXpDvaVuyo9P7a42bbpMC1gcJs6ird+0VDP88Y+BBfztNiJDxMGSrdgFm?=
 =?us-ascii?Q?CDlUAsaGUlnOReXlZUPNqAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3jnmv/zjH74MN8TUUxmBUl66g2VQfzZ5XpN3VaI+Vf/dxvAIwHtn/+wS3LB?=
 =?us-ascii?Q?DeQhUtfpEWAuK+x0emQDJj2EIM2RYPaTAcqUYN+DYmBcGMDoQN8IZNqei1q4?=
 =?us-ascii?Q?k6XfPhAfS3C91gEbuHr81F9Xo35iiOOO7/Gboxr4qcjghpSrz2SMrbLxd9b1?=
 =?us-ascii?Q?taVuerQhQHiz9H4xBR+XeKaGqVHzWCsDHL48WsKQ/uYlKkhRYm4WkbTf7dt9?=
 =?us-ascii?Q?4VAvCXX4Q6q1I/JEZlbCw1aVZ/33iQu6lOFqpiWjV7aLKshULqLZeijZgj5z?=
 =?us-ascii?Q?/bOlWVDTOchOpQw3Y5DTjdjx0iqGVptO/b+1keWuyBKocjyLyyimK+Awac5s?=
 =?us-ascii?Q?B+nFkIqMrxY9CichsW8XDQN6okLLf1P1a+fKUbIWhPLuuTMJVXtGw4CZj7kn?=
 =?us-ascii?Q?8QBEqxE21cWh1mIIyFJrvndnIy0gC4yXgcQhgKtd0IY0SJurFxSrSixAKlgW?=
 =?us-ascii?Q?0XgJSUxItDm4NtA76A0LiMcNJjnxV4NKx0Vtz/2CINXJe6D4NMxKr+zWn7Jz?=
 =?us-ascii?Q?PH5vu8F25kKFgXAkRt61fgT0q9lUV6co+pBtj3FVgcgRlZbi8U5D8wORD8G9?=
 =?us-ascii?Q?yaaMJILVtMApI0Cljnw4p89dDwFup9cOhhO/MS2AnqQ0hzj7k95gRmzV8/Oz?=
 =?us-ascii?Q?8QT6sE8LeDqTqebqbvoK/jSBns8uVZHa5V9/CTLQz7nBsrhaBZZtlAjFQef0?=
 =?us-ascii?Q?uPcO/0hf+l081gJoX+dTfWMtZUGgKxQgno9GY6nkrZ6kRnUQO/EO7fS+SAc7?=
 =?us-ascii?Q?+LIjiEUsuoYBmVdRJFkMDThWiCNVrgYHIvCtiQSWPHj4VhAtg9ZqbJYus8Qo?=
 =?us-ascii?Q?DZLgKNOeKT9fM1LZdh3N9fE2A6OcbxcNtp24/HVHaCHFNqN+jcnvLoYhE56m?=
 =?us-ascii?Q?lw0nCeYl+HVluavnyrsbO4eFb1z/3uzcEiVUpNKwyr/HRfS6m31s9qb7hF/Q?=
 =?us-ascii?Q?+yYh4IQU0MjFioEPHEjQq7Y6QnZbXd/LF8m9wFwqDetqgpQK5hOSC2Ki/y06?=
 =?us-ascii?Q?4ZNdZ6Vy8ZGXR6U+R9DdA/Y1JBufgeQrT2nwDvhPrIEU8t+yFwSKRoUaYZmK?=
 =?us-ascii?Q?dMUPmhF0wzScN7bEWN1Pt/G6/l85E0NNNncbgFvtGqWbTlBILU//TTnwjyQd?=
 =?us-ascii?Q?7NH7bYAoxA5bq4JEPYnBg4Wf3cf4QA+ZBLCX5u0CJZKX87EBm1lnd7fQp9YG?=
 =?us-ascii?Q?wYoWmH/EBK2cQfmHm6DQCqq0+1IjD9QM8KcIQoSsaIPh+2JXu4gxDn0WaCng?=
 =?us-ascii?Q?MqsPs++hi2XqiFWZssMXg3zm9F1BKJB3HPlj3toxqqaG340Jv7J8Q4s5SbPR?=
 =?us-ascii?Q?EtUQtoOs27nT4HXRp8ZVH01DONJoV2gOHjVFn1nV/eOwQkPQcASdaEJ+W8d/?=
 =?us-ascii?Q?S7jWQjm9R8kLtpoOhsBUZz0AZKzqMP4eKiD6x8gG0AQfW5rIvwIQ+j5v0b6n?=
 =?us-ascii?Q?H2Co8vWTlfqYeRXphaCVK4ijGpn1FGUbtPk1iR+ZyYcjVw0UQX5qODUrQMTE?=
 =?us-ascii?Q?zQQXjzcKC0fgogS312kbHfAl7WYPBvqthvC+iDLE8NqDtMOdBJVdUTbt4AUc?=
 =?us-ascii?Q?zCt+26MIDSUVGpGnIG0TXtWVhrDmTuz78ptYxD4rGj+QrOEoMMFz/4YyuFy3?=
 =?us-ascii?Q?BQFEJ6GG3pD2k4dtVEVSzkMK2+bVMDQhgyFFFaj7sxnO+Zq2mgqIkRofbnvB?=
 =?us-ascii?Q?SyhD1+purlDTwgAs7yanAEDv72bs8nnMCHkMg/ojo4gzE9pZFOiYYtpWaRx4?=
 =?us-ascii?Q?Kmu/R3UQAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be2ed73-4b46-47cb-d353-08de6027174e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:43:35.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUNM1m0ynSTevcfIMu0Dm4V1Z5V1XtHUCVAzYwqgL68g29a2njaC93uYkYlpBR2DRvB9vrHRDqeKfAptlUwm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10621

On Fri, Jan 30, 2026 at 05:25:14PM +0530, Aksh Garg wrote:
> The resizable BAR support added by the commit 3a3d4cabe681
> ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable
> BARs") incorrectly configures the resizable BARs only for the first
> Physical Function (PF0) in EP mode.
>
> The resizable BAR configuration functions use generic dw_pcie_*_dbi
> operations instead of physical function specific dw_pcie_ep_*_dbi
> operations. This causes resizable BAR configuration to always target
> PF0 regardless of the requested function number.
>
> Additionally, dw_pcie_ep_init_non_sticky_registers() only initializes
> resizable BAR registers for PF0, leaving other PFs unconfigured during
> the execution of this function.
>
> Fix this by using physical function specific configuration space access
> operations throughout the resizable BAR code path and initializing
> registers for all the physical functions that support resizable BARs.
>
> Fixes: 3a3d4cabe681 ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes from v4 to v5:
> - None
>
> Changes from v3 to v4:
> - Rebased the patch, no functional change
>
> Changes from v2 to v3:
> - Changed function name from __dw_pcie_ep_init_non_sticky_registers()
>   to dw_pcie_ep_init_rebar_registers()
>
> Changes from v1 to v2:
> - Fixed the suggested nit
>
> v4: https://lore.kernel.org/all/20260129091753.490167-2-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260127085010.446116-2-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260122082538.309122-2-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 855b2e58c338..1cc2985bab03 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -75,6 +75,13 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  				 cap, NULL, ep, func_no);
>  }
>
> +static u16 dw_pcie_ep_find_ext_capability(struct dw_pcie_ep *ep,
> +					  u8 func_no, u8 cap)
> +{
> +	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_ep_read_cfg, 0,
> +				     cap, NULL, ep, func_no);
> +}
> +
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -350,22 +357,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	ep->epf_bar[bar] = NULL;
>  }
>
> -static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> +static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
>  						enum pci_barno bar)
>  {
>  	u32 reg, bar_index;
>  	unsigned int offset, nbars;
>  	int i;
>
> -	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>  	if (!offset)
>  		return offset;
>
> -	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +	reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>
>  	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  		bar_index = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, reg);
>  		if (bar_index == bar)
>  			return offset;
> @@ -386,7 +393,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 rebar_cap, rebar_ctrl;
>  	int ret;
>
> -	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
> +	rebar_offset = dw_pcie_ep_get_rebar_offset(ep, func_no, bar);
>  	if (!rebar_offset)
>  		return -EINVAL;
>
> @@ -416,16 +423,16 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>  	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
>  	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
>  	 */
> -	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
> +	rebar_ctrl = dw_pcie_ep_readl_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL);
>  	rebar_ctrl &= ~GENMASK(31, 16);
> -	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
> +	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
>
>  	/*
>  	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
>  	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
>  	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
>  	 */
> -	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
> +	dw_pcie_ep_writel_dbi(ep, func_no, rebar_offset + PCI_REBAR_CAP, rebar_cap);
>
>  	dw_pcie_dbi_ro_wr_dis(pci);
>
> @@ -1023,20 +1030,17 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>
> -static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +static void dw_pcie_ep_init_rebar_registers(struct dw_pcie_ep *ep, u8 func_no)
>  {
> -	struct dw_pcie_ep *ep = &pci->ep;
>  	unsigned int offset;
>  	unsigned int nbars;
>  	enum pci_barno bar;
>  	u32 reg, i, val;
>
> -	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> -
> -	dw_pcie_dbi_ro_wr_en(pci);
> +	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>
>  	if (offset) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		reg = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, reg);
>
>  		/*
> @@ -1057,16 +1061,28 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  			 * the controller when RESBAR_CAP_REG is written, which
>  			 * is why RESBAR_CAP_REG is written here.
>  			 */
> -			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>  			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
>  			if (ep->epf_bar[bar])
>  				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
>  			else
>  				val = BIT(4);
>
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
> +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_REBAR_CAP, val);
>  		}
>  	}
> +}
> +
> +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +{
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	u8 funcs = ep->epc->max_functions;
> +	u8 func_no;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	for (func_no = 0; func_no < funcs; func_no++)
> +		dw_pcie_ep_init_rebar_registers(ep, func_no);
>
>  	dw_pcie_setup(pci);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> --
> 2.34.1
>
