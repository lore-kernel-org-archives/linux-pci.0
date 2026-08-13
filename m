Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177B3F0A8C;
	Thu, 13 Aug 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648179; cv=fail; b=Sjk5x5vrH5bYB3hrh/dwB4JuKBRPBomLyrveCkjqUeAveZBuYbYrMd0LR+ZGL2eIhWztIThyB+I6aGdluwsmiEGQhjk+N4NuREBFF5xcmNMaV+rAylDT7keKRmogKgkDZ3X71Sug6hJTovZODKAsMcjBHbxWGcfnfd585LYVWek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648179; c=relaxed/simple;
	bh=ExAhlP+9prB9+KzWsFrTmT+/Qi9tplsq+Hu1VzWNogI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dtUBjTyVzVxyegiCTOiaWbt9fi+rX6kblGkndfWI+3bSZRqP8q4MGf1b3ODmXAJ0dfd56R4lAdRf39SLPuNLRTWdw7YyLQiic3NYXDjQ7HGOZZ0YsKLNB11z4XGD7bgFHt/r2BA+7G946OlfeajdCxh3DRcrDGyGaNQINgzms4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kntpLSdj; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kntpLSdj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBSmliDbbnJKGS7yPHWwFegu+pfBcUAEmMorGPNTT1LpzG1K7tU91RtG7pzlRcsZmZFApU9sxw3R0KR2ROZdSw2gLvIbBoQdj9Hd2FZgKGqDlwWvLttNC/jx+tkDy7hFiYl1RsZPUVDLlsa0u694BvZKWtALi8/A33VhUGyYRH78VFKmQW/ZGFSGAbA+4RcB4q18+mWj0x2B6cLqgMae1Zg6JmRemkemVPwyLKFoxoH6BF/eS/9BImFkjiX5Dz+5DgrKO1j/KNFYqDndDC1PJ8/TYwBGXdKqgxzS1xrIhGFkXcA69sakeD176lHyMC1fm338L2/gtPJ+mSh0iABnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt/95SjJT/g4ERzdYty0adlx9eQIguT5mYo+DjrHuq4=;
 b=k/BJeKMxZyH3OFpfiX6QNnFZNgDB0/89FTaPbO26COnTPgWwiMF1l40pm06VWaPP2OkmggJilhIXCB5pwPm354Av40Xjf8Eg7VX7d/l030YQ+RRkHrZYDn6Ajxuy4rp2FhZ2+9Uw9lEnmIwTUZ3Xqu5xeU8M5rYKgcoS2fSmr9PqYTukz0lrLhYA8iIhU/C1wq8TyYA/rLwTZE77aiEDPD7yaO6RAwhbFy/8Ong7V/ebTMSBq9tKEv/BZPiDfys+NSHNuVyJLkhX8a7lsDZrgJ9/F6bCEX9o+XsLJNtgp8o57iESC6yJmyaAoTAhJP28eZ29QFgejt/pMAfkLByvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt/95SjJT/g4ERzdYty0adlx9eQIguT5mYo+DjrHuq4=;
 b=kntpLSdjZwtvViuf5R5Wa/57YyKFg+Vlm3p+4P/K5s4GlxCQZmqhdwuRqdej3rcz4wuzDZVamb1YDF+ylhoRdyi/Hfp1Xq8urNLGkYPaaKINSL91Rhcb7XelvxezL9YJPn80tis6GDN8XSHEJdAp4pXxkSejXQ0gFELYMVgO59VCNXc02xjLOGLbhsgEoO2+DVFB4gAvT8bs+oENZmUqpL+O7BhIRjWB6ShXCroR+AIbv63GICiFZFGO4hlu8MOdtXARXsQn6WRqAD68XdA4us++Etd1tTD9J4Ey7NUnHktTg5vfAvitc1lFzVmsBSUedFm/CwtszBtjANAUdRmTqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:09:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:09:34 +0000
Date: Thu, 13 Aug 2026 14:09:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel
 delegation
Message-ID: <an4WZkoIxCZ456Pb@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-7-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 45afd7c8-b3e7-4284-8c9c-08def96e6973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gqaop3T1GlFmH3FxIC5gClXt+oelNFcni4y4/yjA7dOMudg9f0YopXLr3TqGJhD+LzXzpP9afoGyXDnRttKGtlC0aPJwd2Byeo1KOuHUWVEi0AdW0LO/cpI2x3zkAQUOgVMDpIWHjwweWDYMp21U8bUGqrEcFNpN28cffYZcBjINsG8ZyMhJl/9VPc/BtDFMduqFOw7eFynByqLFzoq/je7JeYzDIbpn1yp5wPBaDRDVT8SQzUwXoAWk/dEIytxSx2wOszGT+MbBACVtSg7dQrQob52qon3ROAy+NxQuDaIwcVefmxozA2SeYCqSyiYEQOv7HlSy6P2lQeHgX9ugYwKioRMkyYFqEZDY5yyAl9P4QpWNCJdkgQRO2NIe6klixMFTzYKzo/5bw/mZispIe1FQnxFTTum/brrsP3RJ+JxjavQymfwrZvAffZXTwXxv95YsUGz42Uf5eY7TTpAyv1/kWHDrIBYEiSnnUotCmx2P9OYCYnBjZfJg7A/vdW9QNco7iLZ/zjCi/jLgKAZzV3mLcyeh6ZeO6T7UufE/AjNDLyHUtcO7mgVE2koNCssqTzF8nVOW8BM+ApTfeLrbt44oktK8D9ykS4D9KX7QwyBfcbR6qGfFV9qDWRN19SWHM5/GgMSxEeXvpIF97Qy95w+2QufAFdAidl9TLO7RA7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IseTRpqB11ujUKWNivbZPJ2ifXycKSYa0ojozwYWwmUsnFnxCD8pRddh642/?=
 =?us-ascii?Q?b65OqtLHAlmAdNhWFev1EjFM94Xs7aaKreF0mDKRdOq2V37W5ptH4G3GNZat?=
 =?us-ascii?Q?cwb7HdXgDuDbCgu5xG/UxsvBIrA4qyoTarZYIBU0uKIQgjiDxMgNqqAf8UA6?=
 =?us-ascii?Q?rBf+zp4ftrodOv9Qa9bOEOEG3Lq8+MjB3IDPTG1NVJfBS84BckzFJO4zYfyo?=
 =?us-ascii?Q?FF+MuNAHsGAZCGUyHxat+n5ww5Z5OuKZL2KU02/DYZls9+2ftg8z3CxEzdxf?=
 =?us-ascii?Q?dFjONo05mbUx9DgzxhounQFQoba7Co3p45V/3RwWtg8PZys3oNvM0s3xJBAI?=
 =?us-ascii?Q?wJ6t/ChVCDTW3TvD1ebwvxfokrsCMD3UQNtar/T9/g9cQjCyP/mLG2RfW4T+?=
 =?us-ascii?Q?REA4OHBUj6GHeWvspVGohN+V3fSnWXDkOSxmMavngxYit1SV9sXIRcFXLXbh?=
 =?us-ascii?Q?WYtHOWYlzt3UGNRv+dP22Uymu9Q8BnXAgCaXBkPNQ0mKFSOf9/i49IVe5FAy?=
 =?us-ascii?Q?2t8lOfB/SCmf2b2gLTAx9H00f3+av+qiM7NrGq8dUzoLmbSzx1+SOJlls3k/?=
 =?us-ascii?Q?10X+VQ04EqZ5vzwJUHPf2SGL+X7N1nxsL79yFLG76eX+lxMemFp7AIAlXvOZ?=
 =?us-ascii?Q?8Wcz5LUE+LjkhN0ZsGsK3RmUx9N+uBV+tf2vx/U40RcwbCEcM9d7xWNxDE/3?=
 =?us-ascii?Q?ZQbToLD5amhnb8eX3Xyb2OMa6psMVE5ytT6+5O0IoL2QynQHpAaVQg8Fd05H?=
 =?us-ascii?Q?l8Ifqmxh/WpQbyzomN3IWZuCU87FBXNSe5IS5qtMy26jMRsKDJAdY3m7dbS+?=
 =?us-ascii?Q?lZ0vITKOI9milSQZrfN01qd7tIfULjMfFU8VHumBTN1L7SiB8dljw04qWsBM?=
 =?us-ascii?Q?qUdXdhx1Wsqcbe7NS4K+x+naDnJBBlOIpTOFLKvQY0tWcdfdjdxwKeEmPrrC?=
 =?us-ascii?Q?ZRvWqtJKcQFfYafXtQbrGu0guFmzwYn2nlBgM2L10k80YmsWg2X1BrPwNYRB?=
 =?us-ascii?Q?tW3/XDq2XsEGf/e4Tu5JrOUzRY7wxIohaRR5DHqZnlmX2esZiiYOl388AitA?=
 =?us-ascii?Q?9y1pWsPPN4m9TKcSZ0ZyLDOpoKkrXm8TxJeOE9rOQonfxr4ctoJ2La9Kq1JX?=
 =?us-ascii?Q?eh6LfhE0YG44HtEBdzyA9UqEPv5pBXZAxxFUWzCtjOJeOGMcqw2Ti40Z9pKp?=
 =?us-ascii?Q?egXVYlWbh3eVu7na7TehsaXJm279PPixlvjxHo+S04+W1xA0PZcJ51+wk+hr?=
 =?us-ascii?Q?6wARayhpujtR7Cr9KcfOOMw9Y0QzA8xp01wGvQCcl+/w3z2piO+hw2A4e0oJ?=
 =?us-ascii?Q?L2JYp+1Lc+DZRdELpyq94L4OecqXEwLCTZZoPpeTkBzGW1IWNXoquDg8gKWi?=
 =?us-ascii?Q?zVuY28AC/9qaWnNmlEyUya9Uylnv1lwegOxFNU5e5wqrtm/oJ1OjFTSXIKG/?=
 =?us-ascii?Q?R1NOf8Y9XV8mpRjT55niqyUALAaqbFCpSLqYtIsZRkVRmz0Q5/ZYy4djXB0a?=
 =?us-ascii?Q?jB9sm3ZaGINK8oX7kuTsQmXUo2f7Wzza/BbvHAnh/itASdNyFF1hv+EiF0k/?=
 =?us-ascii?Q?Sgi2iFe/NdD3BjpdPJ4+JbBh0mN+tJS+YzP7vqGZF0oNxafG6kduG86i6SrH?=
 =?us-ascii?Q?PwT+iFgwYZggUPYBJN/s8n1hEf2QI00R+G85z5T4+p6MWYXTlwI1dVCdMvUd?=
 =?us-ascii?Q?/VXlsdOnVsiM8GOMkvKgRGruyhRcRNh3+F0efzo4D4KiXcMcZo97cGwMMuj7?=
 =?us-ascii?Q?p+XlGNRWiGTAe28/+JgBTlRCVDjIn149kNnPEP//sHAckfFFZh7s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45afd7c8-b3e7-4284-8c9c-08def96e6973
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:09:34.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nA4Vs72oLx4mOSPEVkfH10pQhtNPBckJo4ygo/YIWfrakmhHOxnzxEQbt+Z5U2Wk3CegIsHMDlKrxl/FkfuR6mTGMv+//V/QV7b23SN3JVNiTmAD1M9iE5vwssFPZeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326

On Thu, Aug 13, 2026 at 03:37:53PM +0900, Koichiro Den wrote:
> Implement the EPC DMA channel delegation operations for DesignWare
> endpoint controllers. Verify that the DMA engine channel reserved by the
> endpoint function belongs to the integrated DesignWare eDMA instance,
> then hand its interrupt routing to the host.
>
> The DWC eDMA/HDMA engine generates DMA requests with a programmable
> requester function number. For delegated channels, the host-side
> dw-edma-pcie instance bound to the exposed DMA function programs its own
> PCI_FUNC() into the per-channel requester field; the endpoint-side chip
> func_no does
> not participate in that handoff.
>
> Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> window is assigned to a PF BAR only.
>
> Reclaim returns interrupt routing to endpoint ownership. Propagate the
> EPC quiesce request so bind failure paths can reclaim unexposed channels
> without quiescing the DMA engine.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v7:
>   - Delegate the DMA engine channel already reserved by the endpoint
>     function, matching the API and helper changes in patches 4 and 5.
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0b915824963a..a74d3896e436 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -858,6 +858,18 @@ dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
>  	return NULL;
>  }
>
> +static int dw_pcie_ep_check_edma_vfunc(u8 vfunc_no)
> +{
> +	/*
> +	 * The DWC endpoint databook says it is not possible to assign the
> +	 * DMA/HDMA registers to any Virtual Function.
> +	 */
> +	if (vfunc_no)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static int
>  dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  				   u8 vfunc_no)
> @@ -933,6 +945,34 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>
> +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no, struct dma_chan *chan)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_edma_chip *edma = &pci->edma;
> +	int ret;
> +
> +	ret = dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
> +		return -ENODEV;
> +
> +	if (!chan || chan->device->dev != edma->dev)
> +		return -EINVAL;
> +
> +	return dw_edma_delegate_chan(chan);
> +}
> +
> +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no, struct dma_chan *chan,
> +					bool quiesce)
> +{
> +	dw_edma_reclaim_chan(chan, quiesce);
> +}
> +

After use fixed chan_ids, needn't these functins. EPF driver already
find expected dma channel and config it remote only by standard API.

Frank

>  static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
> @@ -950,6 +990,8 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
>  	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
> +	.delegate_dma_chan	= dw_pcie_ep_delegate_dma_chan,
> +	.reclaim_dma_chan	= dw_pcie_ep_reclaim_dma_chan,
>  };
>
>  /**
> --
> 2.51.0
>
