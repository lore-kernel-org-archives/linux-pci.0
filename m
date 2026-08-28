Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DC284693;
	Fri, 28 Aug 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943557; cv=fail; b=Du/btWbKyTmuOEHyq+mD9kFTYzoDR3ZK7XlmpfQUnlCu18OeIqK0Fzts54QrVrs3X9k+tw3Eldq7bAZJmv3qA1EDTF4zVqGAzobgToztPf/yY/mR0vvABtXnVdzia9jtlcfsxdqqoQKnHZ47bdBaQMWaJs3+eNWfX1ZGA7lvK+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943557; c=relaxed/simple;
	bh=dPK76Vv4O2mN72y1Nq/R32Z4Xu1fE6UehzMqaC8prPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dyFEHD/GSkbV7lDHAQQd57nRHqHcOdQul7MfEIvmfCOraTOUcvPlyJ2ptttdTOS/f/JZNFPju0UKKnicyTpc1vIcglDF4gmc/s8A8LsIXW6aSkOXjRGR91SanDSosaf8v704XdC7CQcZYtNkoL65cz6DHcmikcCPND4iDaRWMlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iGUGniYv; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iGUGniYv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ8gQABKw9njVfPoaIEbsbp0J9q6ZEvkPrCMWZu9x5u93bc5WOUyJe1gsz1GGFy9vvvWAFmiZAsBso8dti9GrSRNNBLkDBnXNWRAwQQZGiW8mPUGghvlv8h0+Ya53n/Inmkx1pdfdkjnlUcXJNNIfWjcx6Tsp0CTmppCY5EOAuhuNyR5auvvfNuL/6xjt2VEOqV3h1HZ3ys4XlJ/a8PpzqhbryTm9LQJfoS9ZBvVd2Vb506r2W31IXBj+4RVAmSRMqXHbya53hjUghzjKrcTrZQkK3fIJL5fQINRNMcgo2z3thNwAMULbQrbVvJsLumJtyX2qFxTVi1SCl2zgo/Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hkcqspJjUDlM2ixJsudPFD8aHIVwPtET76qfoA96BA=;
 b=amxiCWo5iJtKwHiKYO/CH2oKLCTIkrjAkAoPXltR2ElOmSS7UiVTsSKia3vKy7pT3nFkdJZ4Fpj0UPsUY2GeX9h7tFLhSfdIWRFNP0vJkMxtusN0k+YQwlGSKWVOiIg660sC1rqJ1T2wPq91npS8Yz6fZM+z/j1Fc56nyz8Um5C0K6Cy5YyR4K0O8TE+/ChGL3Qupwh3UGT4z2eyONuSTR73RUPlsbHAHq3E9gmlkPInYanPYUnG5ph3mC2ZoD0Aih4JY7AibSItTA5jdCkvg49Z1QHqoaawdp02EiRgr7scyrC4VG9MpnlszLQCjUYopVRF8BWQZiIMRoSC+mGHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hkcqspJjUDlM2ixJsudPFD8aHIVwPtET76qfoA96BA=;
 b=iGUGniYv7i1hulmMrL2C3csTY6BFOmdQTthnxNipcbCpoSw2BpydGCAhX6Vf3xNE7prvqBeQf/VwQXjQWeMKzBAX29gmdb1f7ohkcqQ+DRpdPvx63e75HFg8CK9/D0dGo/kPjvWYQLpoIlHbZHu8E9EB79CjBGnodMWeRG9FGi9m7CoO1MOPtdR77/o/690Xh+wT5rBlatAUJF/lrMh1BLmkx7uWRw+0Uf8H6YgF3T0dWsg1vPLs1N89xlgCTlGKyL68STBGGZEx9JsJXGdpjOrM8rq2VuawgPo2X7kvItXqCV1keNJ2R3nnA9Cy1JxwQHA96eoOochkJCcDDbWRqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 18:59:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:59:11 +0000
Date: Fri, 28 Aug 2026 13:59:00 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 2/5] PCI: dwc: Expose endpoint DMA resources
Message-ID: <apHadCbo7o6fyMV3@SMW015318>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828170932.2735807-3-den@valinux.co.jp>
X-ClientProxiedBy: CY5PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:930:14::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b0c8ea-6c00-47b0-0585-08df053671ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3iAYq0DHXaNznqfHdqp1Mc4gcR7okLxhGUszCJ68q8wCcIjQLKwohs4z83wHkbchcG5xFbYWEVHVTT3NxmTrq1ORUzrcSHIRipcpvJfdHCHUwRyIcjKX0//ZER4HAE4Qa9j2mtNhMcdqPEePNPYTh5+LiVMdzuQjE12hoqKFqT0HyCcm2+V/v1o4/rDqXiaTXW6JUEYqSw2LxwiCwoBOf+FRhDgBH9ouuTp59LzHNHNDxwdeOnpQriA+0MmRykvihiXkpQKDImNqM6cJpXYmsSjRyLDUuxhGjUZt9UgJmzEZSWkryuNEmxHGDdBTb/CHaa9BDR8H2zuXTqab+70Q8rI5Uo0dgBJmZN4zXAZSKAqOxw2vAmaTbkeGKzVaG8fuqkxBt9Qd2LM6ZIE/d7FZWDHbUzm8KiQHEZj8M3gkXTiBVT+GZN/ORpMdJw/RaibFWTYCLHpsUoshD+l3tVEi9Kgqi7tzEG0KqvnIFj+wA1INRgRiUhr/x0TBuy8HXNh2yNUw1+Pn7ai8Isn3bnAxaGJUv0ot5a4xy4wcQe/FeWmUELZCzEeWWfD4q6Phw/uQKjx47Enh+FYZCrXoV466KGnL/WmInzR/UAxO9uo9hMQd/YvJtvgkSLItLntsZqhb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XL423oYxIiQH5NPt84Ma+rJ0aS3V3Ktizc+FtaQSpoka+XC5oLgRc19HGF7+?=
 =?us-ascii?Q?6jmqddIRW/qGKW1wYvGHMrwOcDpC7SUTJu4jYfSp7G8nHNhS2fLaLsE1PKrv?=
 =?us-ascii?Q?EeXVmFVjyjOhIIVUmRMrMkZN67dZw/3GBRb1NjrdxXx+bMzCZJgaAGXSgBaR?=
 =?us-ascii?Q?ttVcZE9UZF6ANhQHmscblRSNRDEdD9+DQ1nOXAQmPn9P0tgt6lw/KhMudl5O?=
 =?us-ascii?Q?1zxF6AypEcRIdIF7Xv2yflGON0QwVBg9LVftvLWCeeJJEcHDGAm1GQHfA16u?=
 =?us-ascii?Q?omQ8MjEmBoeJGjRygLquWjqYbXQzUIdkZGAtJUM4RLhaFR5UBASp8ZwbR+hm?=
 =?us-ascii?Q?Red7dGwpwNROz2dHbjDrT9GXgfmSnDD5cyAaLtFjd5tWoX1Kg8KE7n/D0Dfu?=
 =?us-ascii?Q?x2adOfUR4KuoCvy2hMnXTNo/xmmNmGex5ELZw1s1WrPSKrMkYVwaSfgrGynq?=
 =?us-ascii?Q?u8StfGrNgP73H3/wgCnDHyTBkZk+JCZup6K3nSCg3tcbQu+yiNGL+B4XrqzP?=
 =?us-ascii?Q?b1lEMhzpgO0+TyXfIbGLY9rW/MR6Xhab+T27twuHFRGCvdxBgDgYEm4W2CQh?=
 =?us-ascii?Q?ZdC69hgaF0Q3/mRkTFjU0VDhlaTm2+23yis68c+AwmCDn7hpE0XaZBALB0S8?=
 =?us-ascii?Q?zXRMgo4e3Iga5v7TpsV/W/XOOSD7/mGpxIfwPLZ3xwDrKfGyGYcCm4DTylTv?=
 =?us-ascii?Q?B7WmkgqBRacUTUc7g8U9VrI9tLH7hwsoX+air/cEIg1jsiQ+CGLyklMILYH6?=
 =?us-ascii?Q?Mf+yZ8J+duxo3kQv5ilU696PFWCwWHIuHuk35lXv9wd9BUXwEDoNV5A+7c8v?=
 =?us-ascii?Q?mBMN6m2pkL6M+McPyHmIW/vebMJVd9vVMEvBlAPqK5fyVqEjA7CpTt26HnOG?=
 =?us-ascii?Q?Ev/JdKLIliO63gVUha6JP1FdDd15PDaQKise79Jx8jhpIZv23oxqpavPlmq0?=
 =?us-ascii?Q?GAzSVHEyqStuJV/xbbAbuRMq+MP9XfvOn5Fd9vnAzTkyBpm/ExpXb45bLr8Y?=
 =?us-ascii?Q?LrDc0EW6HxDaf9O9HtErvcD7APO/FIaag3jA9mXMZ4otzBGTIBQP54bBoSjh?=
 =?us-ascii?Q?veLATcoAtXBrp1ZJxVavvU0HzVyjSCp/Blw4oag2Ye9L3ElU+CW5JbGnykFM?=
 =?us-ascii?Q?K2dgtgfA1Ev3puTQyyDKUMFvVUin2JCwVpgt9K1EK+DUsTIoTlNGi/WIFY0L?=
 =?us-ascii?Q?c40yS3NSQOJ1l88C20Vqz9JCrWG/zw9Cjtw5H/LEJT5WYBQsfdvmuFUppFPI?=
 =?us-ascii?Q?RoPTV7X28j+4PLflG9dS77uWnQHLljSOia4mYnw6tdcDAp2qVGwwoDWtOfDr?=
 =?us-ascii?Q?wJvb98n0+Y6NkBq88MbKjwjVX3HAKOWFD5AMQJsnJTvCu8c4928Rsr6VprYF?=
 =?us-ascii?Q?xIIJqtdrYlMNAd8KEZm2JoOQru+8WQS0rjFUHPlQf8/S7w56RjOwfM8RTLtI?=
 =?us-ascii?Q?fSYwKQF3WOJ6sNZtMGeoZsGpknwByMxAlM2I4cdAppbxFYjOnQA2y6oDIKBD?=
 =?us-ascii?Q?5/7Ab2B4r0y8QjHHIgFw10QNbRVjrmFCDVfW3jI0yluAxSvrazK2qQKsECwt?=
 =?us-ascii?Q?F8R9BMa0GNdqrbY8CXecSItE6xx1w/OzXb/i5tuHRxM0PyVbmP8A0FGLx2pC?=
 =?us-ascii?Q?iDGO8SjX9I3PjFTK3N0rznd9MrUk9Ol5Aky5QhFxFj+Y3yrwD/tjpqMO47l1?=
 =?us-ascii?Q?422o/DHeWdtlHph7AY7fbjwThcKOWwG3KhuLNreSptPl88y1Anu9txUdBXL2?=
 =?us-ascii?Q?AVZOTa3oX7lYQkbT1nox0n0owAwCVP3dFX79J/jS2vOZAMnWf6D8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b0c8ea-6c00-47b0-0585-08df053671ef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:59:11.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIHVeDjgeiSBu7k8Bimuws0OHd1TvZ/uoW4lEHJvh+MnnZ87Lolg1uvTfsr5hDzPiZFkj7rZZkN48VYXqsPK5ELuteOZs3V2HSPpxTlpKfRUJcNObDozBf/YLLpf+2r4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261

On Sat, Aug 29, 2026 at 02:09:29AM +0900, Koichiro Den wrote:
> Expose the endpoint-integrated eDMA register window and linked-list memory
> through the EPC auxiliary resource API. Endpoint functions can then choose
> which channels to export and map the required windows.
>
> Associate each linked-list region with the direction-flattened static
> channel ID used by the local dw-edma device. Report these resources only
> after that device is registered and only for channels with linked-list
> memory.
>
> When the register window is already part of a reserved BAR, report its BAR
> and offset. Otherwise report its CPU physical address.
>
> While at it, harden the existing doorbell resource query. Report it
> only after the local dw-edma device is registered, and reject VF
> queries because DWC cannot assign DMA/HDMA registers to VFs.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - Rework PCI DMA EPF v7 patch 7 around static channel IDs and the
>     reduced metadata.
>     https://lore.kernel.org/r/20260813063757.3131865-8-den@valinux.co.jp/
>   - Use cfg_non_ll instead of carrying over its LL-region scan.
>   - Leave the peer-visible layout to pci-epf-vntb.
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++++++++++++++++--
>  1 file changed, 99 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index de8ee3db4360..c5e07edb52b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -858,6 +858,15 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
>  	return NULL;
>  }
>
> +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> +{
> +	/*
> +	 * The DWC endpoint databook says it is not possible to assign the
> +	 * DMA/HDMA registers to any Virtual Function.
> +	 */
> +	return vfunc_no ? -EOPNOTSUPP : 0;
> +}
> +
>  static int
>  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  				   u8 vfunc_no)
> @@ -865,14 +874,30 @@ dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
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
> +	if (!edma->cfg_non_ll)
> +		count += 1 + ll_wr_cnt + ll_rd_cnt;
> +
> +	if (edma->db_offset != ~0)
> +		count++;
> +
> +	return count;
>  }
>
>  static int
> @@ -885,14 +910,32 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
> +	ll_wr_cnt = edma->ll_wr_cnt;
> +	ll_rd_cnt = edma->ll_rd_cnt;
> +	db_offset = edma->db_offset;
> +	has_ll = !edma->cfg_non_ll;
> +
> +	count = db_offset != ~0;
> +	if (has_ll)
> +		count += 1 + ll_wr_cnt + ll_rd_cnt;
>
>  	if (num_resources < count)
>  		return -ENOSPC;
> @@ -909,6 +952,54 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_DESC_MEM,
> +				.size = ll->sz,
> +				.bar = NO_BAR,
> +				.u.dma_desc = {
> +					.dma_addr = ll->paddr,
> +					.chan_id = i,
> +				},
> +			};
> +		}
> +
> +		for (i = 0; i < ll_rd_cnt; i++) {
> +			struct dw_edma_region *ll = &edma->ll_region_rd[i];
> +
> +			resources[count++] = (struct pci_epc_aux_resource) {
> +				.type = PCI_EPC_AUX_DMA_DESC_MEM,
> +				.size = ll->sz,
> +				.bar = NO_BAR,
> +				.u.dma_desc = {
> +					.dma_addr = ll->paddr,
> +					.chan_id = ll_wr_cnt + i,
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
> @@ -917,7 +1008,7 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
