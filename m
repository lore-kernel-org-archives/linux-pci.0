Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE274156F45;
	Mon, 23 Mar 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290983; cv=fail; b=Fd3OaK0P27By2EhJ8cdMSeGecWvhZWNJyZtpN8BEx2iRyMbPLzxXwiuf6addrVmQ+6GKB7+fXf3n3r7gAptHg7UqStYxsObgtoG2WDAMw5R0RICkFP/tsnTr+mYE07E87ZGPubBEALoU5cZGMdL+gEdQQK75CpCACNCR3qYT+UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290983; c=relaxed/simple;
	bh=aoXyN85YlurKIkzE384NtcFnGzPAY4g3tU9PE6x8xsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W6rBRN5hfQz8btW1hsFB5gAepIQG7nRmBJbrll1OkrLtACDeQOaRXSC6yEN0gpnosjaic3hQbOo3DlxywzfncEm8UmmcO8/UY0+bWd8W/2+R6hhkO2ovkj+71oEF2SsUsjRpugKZ7bIktsAJ+5GVeBKg1Q58mSxlHC+imUcKKlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=efmtOsnm; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="efmtOsnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcORgeEP9Jvb+Y/+kFoKgIlYhk3u/8W9VNPZ7zWHL/6g2tDcUTpNgYfHqv5bE/Unqm7TIE05Q8qhg2AL9WXgKPZEImrwIDZDRONGis9u9D4b55EHRx6oAN4v0Zsiqt5lPxpDTGLNQ+g9el1bcoIBhfB2qDZQl5Us1S+8DL9mG65q2e1mRrQ5aI1Rkf6Mm6ZiiKtHqqVjUz09rfOW2Iu6AzTDIeB22EMG1UuMFQ0/gO6ZKUKq1754CrO7Os5BsWx1MZq1NS+697xftBfofky3+0lPzLtCS2KnJD3zoLN/0AYMQelrV0M+lJ/rRmHPj3MDfJOCbMqIZRezc++QTTi3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFFevSA2p2BBmkDeg6K4NzeHvVxt89/Z19fklAVpnqA=;
 b=E2G7KAMKFcABSFK2tUcdre3xivN9c8mnIiq1MA8rNlr2TnF98VNJUW5PHVmPUoXYNhaz+S6LYDkpYXeA6ZwOrpaGIwMsc8SQ3l52AaylhHDiVG2ginQ0meHAZiXA+bkHpZ4PNFN+Q1EAfjIbCVu0g+GYK51WEZ7pGQ44NSpBshqCsnil4GHsfBWeRxNZbh8h0pfKg9BeWWwkeHtBAZYmyh/UtEGQaUHh0V2cKCrjOa5/qL9xJrPeNXAxswQ8VH8VkMnwsp5kX5ShF6ganNFQkR7dMkv6lok2g7CmZnQcIFHxhQkEMByEiwCTiBnTRZnLWKiNMQ+biIKtwDuL8kkddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFFevSA2p2BBmkDeg6K4NzeHvVxt89/Z19fklAVpnqA=;
 b=efmtOsnmcrD5umDUerDdKdJYvMdHljxDMHbkCsXgNwbwIbUHqP64UJpcZd8rAw5HVXzVv3CosIwnIxI42860KjnxYzjXlNvMRoTeTXy+ojLoQyVkH/SsEIjo5/OslXPoVKeWnmbUOACOIktxSqLtDP1akvcPNvwmt0vFarb5C0ZbVXmuRY4Jb4VLQ9JW+JyvQHojyKbV1KJnmO8HmJd5md2hA+K5PyTo9U9M+xqd5DMNgKxom6mP3gUBvDVzqr58MnveFO8lkXEF5123lhnigKCgBh0D3G7bwehbkGWRlqDyZwVS5J7FtWN6BUJfGpS2RK5cKg7J6kRtL3jgIwEcEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 18:36:01 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:36:11 +0000
Date: Mon, 23 Mar 2026 14:36:11 -0400
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
Subject: Re: [PATCH v10 3/7] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <acGIG70bIHTD2bCu@lizhi-Precision-Tower-5810>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071427.534158-4-den@valinux.co.jp>
X-ClientProxiedBy: SA1PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce08b93-5650-4f6d-1ba3-08de890b0e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|7053199007|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VTyiTf4OtsVoJKEAxjD1LLesreEIUHPZABtREWLZF6HjDXDYk43FHV5qp2C7iZJyDLFyKL8WRBYvRu0IuZzFhI43D09+xhq96anqEBYhwDx12RxzDeV6bug99oyEFaJ/hxwtE3ledUrMsqR8yRTrbA4grWcpSEvtCgDbi/Jr4H5YI47ZYVA5hC3A1ahnpg3gUdhYgzZb9Ue54w+LxSk38zcA1pPt0+BDoaT2EMJS+jwEmcSsqrQwYjHT2FKl2jTcyyAK/jQKdsI7hDotx/yVWfSQJsC+gozxYrL/jR78nAzjyx7QJmdugjb6GwD6G/XENI5h4ghOTbprj1iTAg4CYXVpylz5tjJQFyoB+ckKOPNIovG1NIxb7k+EiQPuZ7DciBzduUMOmhArO6f391ZNBzqyQtZe7MDeqslygo2qNj4OBuf3QEfJI96GI1E+RcHGjaLm66o5hA4u7NfztcbESKYPSA1zPYlpwauFdcckj62SfqLX/5IQeQRmVoMcVFJJ1WeK1ms7nxvhntfPWTM9uNazESrw7VYWXZMZjmAoo+HWyfE2yzb2OBcVQ3emEYzbLKNgzZd5VSWUZVF3mqvzppsuL4IRwpSp7c1lcctAidihQuzvOxsIjf57YreGR5l5FC5EGDT8rfvTc0L7gfQ6wqSLWv5QvEFEcCgCYfXpbXmk6hYX1ufki89EIh0QezpsMnSyfYVqNk6AdVPOtpcxx3bIeQNjEyjjt8TBghxLZF2QFw+xcHG6MwsRubbdc0TohSTUiidPwTaFFg89Rt0nQ4r/sQ0QQ6QalY/OpwLScqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(7053199007)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF3oZrsJVfrz7TBVHXGJHo/Q4zYDL6Y+RzXstS0Y5cdvyQ+cbyYDqcxzKcLN?=
 =?us-ascii?Q?x9mFbX3ycmUanm6e6qgmOsvLWBtiVWgOgeOc58Mg2Vpn/+O4Ym/ou5iRB0em?=
 =?us-ascii?Q?hGZDgqOb8Sg7WHczlI2c0d7GqUBltXN5pCEnNECgpnT+p3jhdkoCMaMxr1mA?=
 =?us-ascii?Q?RBEgjT9SmLyePG8foPy170Vg6K1NUPeujYbghcJe8sCFpZ2cpbKMhbMQKkKp?=
 =?us-ascii?Q?x+YM3v8HxPY2JSsbdP0PdicuKGYKlE/CDVkuVNFJj/73vTjB+7SoWKnOTBkb?=
 =?us-ascii?Q?u5koyAPFDqKuXMntouW356l5ok4RUMpNXatha7PvMUESNh5p4c0l5oDpiU3E?=
 =?us-ascii?Q?3NlMd0b8R5m2dNa7a7QrTveoVXBjGQuP7Fm4NsRslsJnoG1j95febESkpKI/?=
 =?us-ascii?Q?YnoBRxSNimI/PKRWJvEOqM6S1jpA5CZqvhP2fgb2PRVT4P6Y/+kPz70UzvSV?=
 =?us-ascii?Q?nof76i286a68iKINUZ7GMr2bmkzuiL5snioLE9QMPzzATj0UlqT+b4bkEAfA?=
 =?us-ascii?Q?YQdMipQ6Ay4zDuGgfklE1+yf1pkWKzTiOHWCSrITmTsBqmT5QQO+swX0l9z4?=
 =?us-ascii?Q?YwXT5TgO+KUKCV82KK1p4CcNTJUTWn1BPDL67eAUHPr2DeV4pP2cfjprKC4E?=
 =?us-ascii?Q?sPGo3ydGRQGBUfSYcS6AgdNfCgXIvDE3Iky3lu8tTAsQesfQStIfhL4vGEtP?=
 =?us-ascii?Q?5mCUDOSbYi2Io1LbXSS6aXjmNXmy3XdqlQrY0oMDgKAAeLnmfR7LyU9/vPsm?=
 =?us-ascii?Q?FqyaM0lUAk24/DLSdJa0P8mzI+6noDefEb2WdZRlO6KZyi+Z/ilSgt+BCfcC?=
 =?us-ascii?Q?p7pVnqiT78WfMJMV9zqriJqSG8GA5vpUUniMpRE4its7eU0yAVvtDePxdFRJ?=
 =?us-ascii?Q?FgW24Bm5ulmlictZt9GbBS8w8xBQ4xeIPkhe2jp3YC6nz+DteMjD6p4GqF8E?=
 =?us-ascii?Q?SpnkZgijZNZKUsrtfMqnJX9F6nn10cTx4K62eFKL+bFYj7LrruBA5MQjsy4p?=
 =?us-ascii?Q?m0KnAz5iEDcA0MCs5MyuYnJSmuApQ3w0mLr+BYVqTAHMhgFC2l4271sV1h1h?=
 =?us-ascii?Q?S4TPPCjUi4n3PoExv/sTQY+jd+o0I59fuU/od2kC4RKLxRcnpqPNNErXHBSY?=
 =?us-ascii?Q?EokwtsfJFcFlJfDZ2SEw9r5eUdL1MaSoRbpC3iHj0qjGq1KsOEAhzimuMX2F?=
 =?us-ascii?Q?PZJLbk3dRxhkBavRxLOmNhtr/D8hJC24ABTiClj2xzaNCo1tc+C0uz1Mf6fX?=
 =?us-ascii?Q?X7NHNxCgNbjzrb0BZsNR4fxPEIKPBdLph5m/khz1F1K3knlNyARMASjMNyqj?=
 =?us-ascii?Q?LaRNd835UHL7bR/15DbljkPGIyRZvyn5DWpGoxEzYBMcmQnMe4JroMLGg122?=
 =?us-ascii?Q?D8tDIYyzJTkp8HQwglMuDdsYkukDg+utY9AeL5GJl6nQQlAmWr6+pRkgNmIx?=
 =?us-ascii?Q?0iWNbHYSYPnftIUfNpnP6tVTc5BnwbWcPmeMWzvznZ9gnGA3FfPv26D0Oy2L?=
 =?us-ascii?Q?gSYBznObymBjRmp18Bvqg7Vv7pkMJ1mvLLm9cT3HGV4G6McLlS+ADH1gUnBJ?=
 =?us-ascii?Q?sgs27f6dxrE8yxUK1HGzzScTPmQLt349j2Ig/s4DpLYxlOP45MfV462D63Sd?=
 =?us-ascii?Q?+TH9uIDmNDMCFduo/M5qvjSAksPnIDOnzZ16dhU+KIvG/fc97CsfgtvxyBqE?=
 =?us-ascii?Q?Xv59Hr/pBrK4m7qnoLpS25SHDUdkpy/ruTV7kp80jIXAufsTMhOrhwUFGgeR?=
 =?us-ascii?Q?SCbl5tzKIw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce08b93-5650-4f6d-1ba3-08de890b0e6c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:36:11.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIrgc9WBbD5M7BMQdDSMapp6K29CLPAkq+tjjMkPsOCdhGSonx3+jX7v6wRqliZFOlCIchxcDAy9Enl4CiRQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

On Mon, Mar 02, 2026 at 04:14:23PM +0900, Koichiro Den wrote:
> Implement the EPC aux-resource API for DesignWare endpoint controllers
> with integrated eDMA.
>
> Report:
>   - DMA controller MMIO window (PCI_EPC_AUX_DMA_CTRL_MMIO)
>   - interrupt-emulation doorbell register (PCI_EPC_AUX_DOORBELL_MMIO),
>     including its Linux IRQ and the data value to write to trigger the
>     interrupt
>   - per-channel LL descriptor regions (PCI_EPC_AUX_DMA_CHAN_DESC)
>
> If the DMA controller MMIO window is already exposed via a
> platform-owned fixed BAR subregion, also provide the BAR number and
> offset so EPF drivers can reuse it without reprogramming the BAR.
>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../pci/controller/dwc/pcie-designware-ep.c   | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 386bfb7b2bf6..eec20800a745 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> +#include <linux/overflow.h>
>  #include <linux/platform_device.h>
>
>  #include "pcie-designware.h"
> @@ -817,6 +818,155 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
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
> +		if (range_end_overflows_t(resource_size_t, db_offset,
> +					  sizeof(u32), dma_reg_size))
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
> +				.data = 0, /* write 0 to assert */
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
> @@ -832,6 +982,7 @@ static const struct pci_epc_ops epc_ops = {
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
