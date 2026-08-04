Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AF19D065;
	Tue,  4 Aug 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860966; cv=fail; b=XwP+33WTePow64vFUOTC/LFdxe791UZQ+TwBwBXBXS1Urq7qBFnfd0+v7W+Xl8g8WKrH60rwSg+huPdV5nf1a3UuCCZVH+qQC80U5ZBdyhfRdKw+sqMPanhPoD1+TVOkZNhl9Hf+BMSDvM0G40cyOrt6WJVxijzorHbnqMPPMsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860966; c=relaxed/simple;
	bh=3T8fd20kGC6jy5ZszMyp4SKXn5KHsoPB98SnVF7Gma4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9/h6TThdDEu2N21lCC49YJSh/s8hyBw+BvmuUG2xp7Xp3NEaqh2vxIeQsgZNYm0UynqKH70Yu51FRkvmYe9Gg5be6fToxXFvjkAIHDIwzwZZBm7f4po2ou6iO6SZKeUxO81nrWTWyAI7NAQUMuT6NV6879KBVZ/ypH14JYqKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LvjS5u3U; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LvjS5u3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AB0pZzd5sOwUql2EHFeV2moA7u2UxA03zYcozMkSEXWN4v7aHaCMFuY3Bec6BUw2tQyKngh3w6lQix8lGnvRAMmtAvZhOuc0/Tygw/JQaoI0M8eoq6aNKyrSm1Je9KI0VliXsUv3F4JTJCYVzqNg8LD+nVPHGD4mF2hGAh+I1oJp5e9zpTL7e2uWtsEBCnimT+4kllwcKVMPKhG96wlS8Eb6+wVRgy5cHJvEZq1ozV/2JIBz2k4b1TXRQi7Q3euON4fYKYfnlIifW8Go8r4mLHGziqI1ZkSx42JEiCWtTGMtKtFcO5qu5VDaH/N7h94y6ryULkxSxWu5ZPUcXCIxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Kvnyr8Al/3KCtDw5ISvoPztp2ks697wmcPNMtAbUWE=;
 b=cZHC94rWRIpTmpCutdM3+mSei3bbRRCjFf8zsNl8n0LjLvUPIbcmXExPjGeallZSzp2zaWehe4r5J7VXaoe+h6jJ717wp5bY6fvo1/UD6N907E6fK4/CcnjT79lL/Nq2J0sewdt9euU+FKs+FngJjTMm6uHZtPBlT0Vwr28PT+AthdAfFoVEaghXZk7G4dDJO4ViaG2cmVx4rIojzyd1u+rGOQHgHHeK++Me+xl5t9LE/yNeiNMlt0zn13jSU9DKibN7RRj1kCdT2Bj5/Qx7g8Pntlc715Rd2ihQy/ThUE47sSxUoZOi4pWVRpBglZ13aJql8AFwhyVc4+o3YduhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Kvnyr8Al/3KCtDw5ISvoPztp2ks697wmcPNMtAbUWE=;
 b=LvjS5u3UgWn46ZfcCOQCa8ISUeUdsWP5L1ro/o4ALgXZG1uOC7CQe8ALaxN+F2+bcoyasXiBwyzAcvGQBw4PMVyGM1dNY3v5n7+gAn1apIlvlqQmS8ye1cTGHztug1FCA78NKOwA/y/VDQvvmRlql1jKEd+jEA714oWCFiwGd2IRRcjHTLbYgoATfAj2o8IHe4NhjEgVPpLWfi1gyjVmotWU7MqVGnMKRhK82pO5ekv70DEe+5bbxT9C1tngghtkj28TImC27uJv+cfz8quoqPiApu3yV1t516b5IA1x0c92/IPGw8DiP/AEh3zl7/vbaHfBbEIhT6ONHmOByeyU1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:29:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:29:21 +0000
Date: Tue, 4 Aug 2026 11:29:12 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: dwc: Expose endpoint DMA resources
Message-ID: <anITWMXfOBcFAOhs@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-7-den@valinux.co.jp>
X-ClientProxiedBy: SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4283de-89cd-4442-5936-08def2458982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|22082099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ylhnhoRL5ok+anYZ5Zsm1q9v0MAvH2Ei4+fx27+38eaK6W2w06hP8VRX/Swdrz+pWgqshhsT1PWmz/TBc84qKCa+1pa1nFTI71+5vBuW0pBttFdZfOM4ElkGbmgcz7SmeBHM+0qoEl+bkSvGOYVyJWuOTb57qM+uu332XvNrc0zn8LznrvWkGwlPfocTGMQ+2KogycZFVEWPqE0mIEbYGfg6t0SbPIi0uvCyVM7Gh47IZrgoOaBQs+PVgqhzgwk6x+iY5TYYxWvsZg+TTSwR1hw2sBPturZ5CgHs/3FOycSbHuDkrX2cDojt2gt/IyZdTr/hre59Mhylc8FTCKPr/Z7nHHkbE0bti6OpLXyp7reRf7uZu1VeLZaTuhaJngV/ex4/zpE8o/UmPMe9NnWfU4mIL9Jvr1VgudQHIjuF5rh7FHCOh3WwyvmXC6Nq6Uyj2ACGlOyBzaG+ADrL1MWDg2k6eyKMN+VSY8d10i4bGM8FzFfjba9Ibgr7eAvV2JTMXkxIsjz66Yi3dRVJ1FYpMjdd+wFY6HiMdUBnoxg9CbfCyfHOWbDKqu6l1Vv51jZA6LEaNTr5/6Stu1j1en+OBnViDrugV/d/1Apiz2EaUZ0Lwkq4pfu6pxPaBQrJeZ9rgZr7ofAIX/egD8XGLOi3svdTAmTx8G8lh+8NdbEfVns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AnQAg8C+56GBBrPVh+pDez1QaCSxazco1kmqgspjARp2qAU4F8gmBj17Gx51?=
 =?us-ascii?Q?Ow85ZrGXaBEMGwgzxCCwipvgER5m6owzWrcWptLw/VFBTnOfp+UHyxeJaJ+b?=
 =?us-ascii?Q?i4UKowEFqs7f7D6nFg8xwKbDnJn+ASS2Q/i78ZA9jqvpkRSZwRT5UcdOQo+l?=
 =?us-ascii?Q?duhxvFlxNhNkHLlAddOGSJ/x9YBUT590wSiGnefswE7tT35KdHYBvtGI03K7?=
 =?us-ascii?Q?dRHlVVFX9SWz93Q5yYtVI1RiQaYYNVpFJjo0xHYS/StcJXrDTSCzIkO1IirV?=
 =?us-ascii?Q?/+HvAvDezg3NQlyR8YA/2n91dB1yeRp9z6ImImubn7IyOEUsPJ/deBN5uRSw?=
 =?us-ascii?Q?rwM8sQeB0TNRZZmnBGsSUlp02lz4vwZRml9TGrkMI3O2g93GAYm252osgIcz?=
 =?us-ascii?Q?FDNbX5j+mPo/QWuy+wK66I/J1P1Ahc4tIM8BmrJnugEskP7W9FvRHGzLnT27?=
 =?us-ascii?Q?8UG0s9LtbTgLTj/bb6udvBsHQiUXKVee+uVkmdw8IS1TeKydybKq50IUVxD+?=
 =?us-ascii?Q?eFQ1DPhQL6JzGG5xscHPzxAgCPJa/SOwmKyORLUWNSAIYNhx4H9Ns55BxZi0?=
 =?us-ascii?Q?v3Ea1xAHOI4n1ipM1KsW9OPg9JdDbGCpNLbxQhDmbTuXijd1IuAxanpUga/J?=
 =?us-ascii?Q?tc7btIKrqJfjJ8pH2aLXTGswOj0UrYP9mOAHrv2A2umnlXwXwEm0Vx6H9ZTc?=
 =?us-ascii?Q?3dYlwHmAmoT5OOhIzs/+QpvdTmF0tpz+ssvss36L9enVcqSKAyr9ywQXwUT1?=
 =?us-ascii?Q?kaE42iL4wzZGS85RfCtFwR+A+bkVeikZa9H9vtDrQ8Dp8L0AzsKa/A3mQPvw?=
 =?us-ascii?Q?QazfcTDabOCg1DZ0Q69Np9GUIByMN5U6s1EE2GByiYJENKQIIdrwGkRo50K+?=
 =?us-ascii?Q?sSnM03HHGJkZqfHNPkpIbzZkx9787YgqpG/vPM9D2bmd1Okz0J8TTo1JxrlC?=
 =?us-ascii?Q?DKRs4FL6voDEp/rdz7bVgJBSv6zfQW5hOnZlecn6o8yvgZGMINTtJLehlvJy?=
 =?us-ascii?Q?O3kJ1/yCfLjdQ2pBCI34x4w2j3Z1I+b8yzJekR/3LS2/YIFc1hpIvpY6na0C?=
 =?us-ascii?Q?0EPpXmzfNQbTzIfm9kjMIaWpe5j2vtfDKtNk/Pa/WtXrSOioLYtElOABVYHz?=
 =?us-ascii?Q?/3UPY432xpGNXOa12fpKvpuj7jTh7bunG4DSyCfm7smFBHUxYxOqKpqZo/nW?=
 =?us-ascii?Q?l+OBT2ydUQjEhB1oQ4IrFnQB/TiL8nw5KEL+MtTDEJ2/rCX2mV8nJAzneJTM?=
 =?us-ascii?Q?q4jfcu17okjN3AjhfVA4T4ksA+ilkBYpmm+re7EliNq+rFziJywV3mJ0K2Ws?=
 =?us-ascii?Q?451w1cfv5UOS9f2pLf2gCuxrBUnsy3L3B+Is2UOcxEqim/TX6mZlfFQUK+pr?=
 =?us-ascii?Q?u8R49lwfhlGeYEtmcqrp8hUpyLrUwwunlS9l5pbK+vK/vfT4UMy+aUEZQXUb?=
 =?us-ascii?Q?piNY6QqWZjXW4uCTQ0TluaY8pBmRnvGe7j+bsmM60Vxam7C4sByrBqa27lXE?=
 =?us-ascii?Q?aqznWyYjhcr4YUF5zf7FSRG9YwMW+r1Qc7BaD0ClplZAvx4gh3Al9HP8qtDO?=
 =?us-ascii?Q?pPWUYb4hCd+1qsM7CY/ftVkoEMIjUGJZBZUZjtVuHjt3IGjqiOfSblBPg9aD?=
 =?us-ascii?Q?8NPJ9fHnEBgHIwNwevVrUmsMYzg+cgVX0fP/maQ5kVVdv/PzSbs7sGVcCtg5?=
 =?us-ascii?Q?lL4HgmFSulB5Df6njj7CEnHvBScxWtdoaf/0FW1AslYs84KtZx0as3RAbirJ?=
 =?us-ascii?Q?SovkWtSn1eL3ZjOIv3YVjF6XTv5wA2+HuuJ9x9aWKLrrKSrvl+Xj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4283de-89cd-4442-5936-08def2458982
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:29:20.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMK847aRYU4zFexYQhuUwmrwtgA2DMtoD0tc2fvwC1PePV4hiupr0E3M3GXidGhJjk9SFqEjRy4wnn3+5dytQzTj8bJZ2Pw4BNyGpMhdW/iuLG09J0tYOx2fHK/RrWvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

On Tue, Aug 04, 2026 at 12:38:55PM +0900, Koichiro Den wrote:
> Expose the DesignWare endpoint-integrated eDMA register window, logical
> DMA channels, and linked-list descriptor memories through the EPC
> auxiliary resource API. This lets endpoint functions decide which
> channels to publish to the host.
>
> When the DMA register window is already visible through a reserved BAR
> region, report its BAR and offset. Otherwise report it as a normal
> physical resource so an endpoint function can map it. DMA channel
> resources carry hardware channel selectors and refer to linked-list
> descriptor memory by ID.
>
> Expose DMA controller and channel resources only after the local DW eDMA
> provider has been registered, and only expose channels whose linked-list
> descriptor memory is available. The interrupt-emulation doorbell remains
> reported when the local DW eDMA provider is registered and its offset is
> valid, even if linked-list resources are unavailable. DWC non-LL exposure
> needs a metadata ABI and host parser extension, so leave it unsupported
> for now. Reject VF auxiliary resource queries because the
> RC-programmable DWC eDMA/HDMA register window is assigned to a PF BAR
> only.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - Use the same DMA resource state for bounds checking and array filling.
>     (Sashiko)
>   - Move this patch after the delegation support so every advertised DMA
>     channel is immediately usable. (Sashiko)
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 138 +++++++++++++++++-
>  1 file changed, 130 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 8c1ac9e3c517..440311e2bed9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -858,6 +858,22 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
>  	return NULL;
>  }
>
> +static bool dw_pcie_ep_has_edma_ll_resources(struct dw_edma_chip *edma,
> +					     u16 ll_wr_cnt, u16 ll_rd_cnt)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ll_wr_cnt; i++)
> +		if (!edma->ll_region_wr[i].sz)
> +			return false;
> +
> +	for (i = 0; i < ll_rd_cnt; i++)
> +		if (!edma->ll_region_rd[i].sz)
> +			return false;
> +
> +	return true;
> +}
> +
>  static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
>  {
>  	/*
> @@ -877,14 +893,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dw_edma_chip *edma = &pci->edma;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	int count = 0;
> +	int ret;
>
>  	if (!pci->edma_reg_size)
>  		return 0;
>
> -	if (edma->db_offset == ~0)
> +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
>  		return 0;
>
> -	return 1;
> +	ll_wr_cnt = edma->ll_wr_cnt;
> +	ll_rd_cnt = edma->ll_rd_cnt;
> +
> +	if (dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt, ll_rd_cnt))
> +		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
> +
> +	if (edma->db_offset != ~0)
> +		count++;
> +
> +	return count;
>  }
>
>  static int
> @@ -897,14 +929,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	const struct pci_epc_bar_rsvd_region *rsvd;
>  	struct dw_edma_chip *edma = &pci->edma;
>  	enum pci_barno dma_ctrl_bar = NO_BAR;
> -	resource_size_t db_offset = edma->db_offset;
> +	resource_size_t db_offset;
>  	resource_size_t dma_ctrl_bar_offset = 0;
>  	resource_size_t dma_reg_size;
> -	int count;
> +	u16 ll_wr_cnt, ll_rd_cnt;
> +	bool has_ll;
> +	unsigned int i;
> +	int count, ret;
>
> -	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> -	if (count < 0)
> -		return count;
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
> +		return 0;
> +
> +	/* Keep the bounds check and fill on the same provider view. */
> +	ll_wr_cnt = edma->ll_wr_cnt;
> +	ll_rd_cnt = edma->ll_rd_cnt;
> +	db_offset = edma->db_offset;
> +	has_ll = dw_pcie_ep_has_edma_ll_resources(edma, ll_wr_cnt,
> +						  ll_rd_cnt);
> +
> +	count = db_offset != ~0;
> +	if (has_ll)
> +		count += 1 + 2 * (ll_wr_cnt + ll_rd_cnt);
>
>  	if (num_resources < count)
>  		return -ENOSPC;
> @@ -921,6 +973,76 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (rsvd && rsvd->size < dma_reg_size)
>  		dma_reg_size = rsvd->size;
>
> +	count = 0;
> +	if (has_ll) {
> +		resources[count++] = (struct pci_epc_aux_resource) {
> +			.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
> +			.phys_addr = pci->edma_reg_phys,
> +			.size = dma_reg_size,
> +			.bar = dma_ctrl_bar,
> +			.bar_offset = dma_ctrl_bar_offset,
> +			.u.dma_ctrl = {
> +				.reg_layout = PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
> +				.reg_layout_data = edma->mf,
> +				.ep_to_rc_ch_cnt = ll_wr_cnt,
> +				.rc_to_ep_ch_cnt = ll_rd_cnt,
> +			},
> +		};
> +
> +		for (i = 0; i < ll_wr_cnt; i++) {
> +			struct dw_edma_region *ll = &edma->ll_region_wr[i];
> +			u16 desc_mem_id = i;
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_CHAN,
> +				.bar = NO_BAR,
> +				.u.dma_chan = {
> +					.dir = PCI_EPC_AUX_DMA_EP_TO_RC,
> +					.hw_ch = i,
> +					.desc_mem_id = desc_mem_id,
> +				},
> +			};
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_DESC_MEM,
> +				.phys_addr = ll->paddr,
> +				.size = ll->sz,
> +				.bar = NO_BAR,
> +				.u.dma_desc = {
> +					.id = desc_mem_id,
> +				},
> +			};
> +		}
> +
> +		for (i = 0; i < ll_rd_cnt; i++) {
> +			struct dw_edma_region *ll = &edma->ll_region_rd[i];
> +			u16 desc_mem_id = ll_wr_cnt + i;
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_CHAN,
> +				.bar = NO_BAR,
> +				.u.dma_chan = {
> +					.dir = PCI_EPC_AUX_DMA_RC_TO_EP,
> +					.hw_ch = i,
> +					.desc_mem_id = desc_mem_id,
> +				},
> +			};
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_DESC_MEM,
> +				.phys_addr = ll->paddr,
> +				.size = ll->sz,
> +				.bar = NO_BAR,
> +				.u.dma_desc = {
> +					.id = desc_mem_id,
> +				},
> +			};
> +		}
> +	}
> +
> +	if (db_offset == ~0)
> +		return 0;
> +
>  	/*
>  	 * For interrupt-emulation doorbells, report a standalone resource
>  	 * instead of bundling it into the DMA controller MMIO resource.
> @@ -929,7 +1051,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				  sizeof(u32), dma_reg_size))
>  		return -EINVAL;
>
> -	resources[0] = (struct pci_epc_aux_resource) {
> +	resources[count] = (struct pci_epc_aux_resource) {
>  		.type = PCI_EPC_AUX_DOORBELL_MMIO,
>  		.phys_addr = pci->edma_reg_phys + db_offset,
>  		.size = sizeof(u32),
> --
> 2.51.0
>
