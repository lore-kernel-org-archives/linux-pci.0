Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793349499;
	b=bEO8z2zQmiB8zpWLeNwkO2tBVUchvBDJ5UWFHVqWNLjzxUFoYrzGrFspgZbUdnbbchWG
	 yJLTKbs8XGT5bfGsNg6hrMqQm473A/8tMraAZQJbO+3wtEymxa2/QfqxHBcSCupXU2MBL
	 QFrSw5gSntTOCIyWqwv0n/96C84jGrkhqdvbPrzdCOLif3dEvHdvmWzhmP1anZyqOnT6D
	 ap4kFcU3mWfhGVrOzcPsrwh3/8PZAUijtCVUxZucOR0MmNwqH6VH0pOvWu+wsNBZ3QrQE
	 1swLXjPkXan6x8PCVJfLnsBCBZbrn8vcACfJibVpRDX8DrduqACacuZ8Ta0uqqeTBWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349499;
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
	bh=kSJ2bzk0G3jjCkWkJf1+zSUor+YkNxMPIfKZygUQytc=;
	b=C1uZfX+WWZih5LcWotIM3vEidLurHlwOGazepcegPxOr1tzZF+e28ax1X4JSQ2wCc3CF
	 ecy9KFccJ1b4YPvYm1KIY5r9oYsL1TmdD0a9BFgNdUlO1qDwKXEMdLenuQNnAuUcZ/EBZ
	 3wJRLRIfrrU8B4+8QYAJH5/gAMX/nEyS5rQrLJgUz0oeJkzpbybwCVh7bxTsBJp3e35cA
	 jTamALrh6fcBKQqt/4hlpH5EKVJEAKSFAV7BtaBf/pjnX9YkSDRbAPPTnQ31tvUMrnULw
	 Ee1ud/7iqCTz94h0CZIMMIiQTNgBdne5PfdzMb2tv1c5uWDlBOsL/X8fpc3KwvmN+ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T9WhWsIP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.0
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E3606A323;
	Fri, 30 Oct 2026 08:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2E3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T9WhWsIP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+QqCoItqA99X0DTfYkf8ceWPfyU45wEb0ROKNF0r9Ifa97v9h9xwibXTf/jsXMOiIbbx4vUuq2+vPW3p81eHvaOIHsCZbR02M44qSuJDUinWHGZ8gF4YW8rkjndLgNQW9qLzogAqoagNlgWbENzvrizEM2JED+gpcTRSvl5Yu+FzXqrOmhwfHzbnAcw8Xk3dvJcLg8jhoeEjrxow2wJOkjx694hE5y6eTivUkVJNaLiX5HVw8zbWD8ArhdRKsmJtt2Qe9uMYJt6xUCxPFULPNThhqyauswTVde6q7FADBK1yp1EqvOcu0vw0ka3bAVOgPPcjdnmBuVPNb3TRTraOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSJ2bzk0G3jjCkWkJf1+zSUor+YkNxMPIfKZygUQytc=;
 b=HclzBLwaN+xn0TTTHT38HXCNute+y2l3twDliGma9rL4xJtdNeZVYYYZunT+xfTY+kGyHfso98OCqxtuaC0jHJX7bnvWhCY7vTUiivnA/hVFzMTS5naWBkJms6qmgoRwFu5/gKFqP3rMgRYlxSPWdLrpEm1YJHgPvVD28Vn/f3gJaGdA+vFu/YL4aY/IxRf2MPPvoZu5Mmyc33whD2ONCgBYvUcKO6uMkmvOrxzp4w3eYIENBas/o5+1cvv5jeHjSmDhIHRkanOXuqX1uWH6WWNPe6qUQiZkT8Gf7cT/JocHF2P/YViGqpMth4rxv+gcS1ZaK2ANSjviDmOViGR8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSJ2bzk0G3jjCkWkJf1+zSUor+YkNxMPIfKZygUQytc=;
 b=T9WhWsIP8BsYdFj1PEkg0R3DPeGmWCpyxuWcm01bYMz/xWfSQl2z8C8kTCfpUuzYBzjSV6bpwEJpwVJ/nSqFXKgZh+3FphVe7QpZR6uZ079yXAjxrwe+kLVXOSqdAfMXshFVXbAd5tFZifSsRQ5q9qa4/HrnOByKD+4sQBU1FbapPsPQ/4PXyd9CIiHP8kT7L3O+tcrlm59AdX+caPkU37uCsJFH/w5ctlr/8tIHUDgcQknqa3cssgHd3qRhe13waE+ftVnIHQjRXNqSA/V3ZdFxNaePX71eutAbHTVdmjLoqTPTxjNrEr2L/UnYtzAZ7P/39dkmKLZPiopXj8Tg7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by FT1PR12MB155092.namprd12.prod.outlook.com (2603:10b6:170:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 08:38:03 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:38:03 +0000
Date: Fri, 30 Oct 2026 16:37:57 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 14/18] PCI/CXL: Reject reset with unsafe function
 scope
Message-ID: <auRXPsGjIZgOv2lN@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-15-smadhavan@nvidia.com>
X-ClientProxiedBy: SI3PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:4:297::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|FT1PR12MB155092:EE_
X-MS-Office365-Filtering-Correlation-Id: faadad28-ec97-4852-b67a-08df36611c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	i6PEsg+1bMJ2eFkwgdERxzKDpxMlaeh2RD5JtNvs9ycf0DxulUeE7p5wccL/ONfu1t5lrE7pXDDbz7Dg8HB62aqJIkNKI01ZqV9cEjkdKeaLawa8TjDiGFqvJKpNnkvYXwl7dwVF3f0WpEvf81845cfTTAso8hObil9gKjXa2ZQ7209irTkCIIERP5Iltrt4iw+whA6SObalzs8eT+1qS0rd85wfJ1Hmcrd0334slN3UWPmpcuZxReYm6GnICkS93HigF1rg1zXAhkacm4/+YQxmlS8i3rizv2CvTvZzNSFDSrrjh0kailvxk2YtwqyhkdZScqaGWhuptkq6npQUB46jV3snHayakgw+mAyDzpBJ8nDtv/OXOkYCAUagxF9mrOThNAYbfBIxnB119pYOJfjohpm/tddEhJoV/DbCoE1CZPyI8W06rKhhLPkPyOH4z5zPDiwKChQs9A2ybhqIyjo/kuU+1v2/74g0mXHmqnVFcXKeoUdX/zW8ijXsOMUD8uxqaL0EhItgGfaDWLJKXKFvGPmeqwgOKHDBlzBBPvnTKT+OpkGCKGHkyVA3959eu0NQBOxLErOogGg6mfcOsxmpqhMHB3Ftx6/esc5wlFdu2G1ZSvz7DDReVtH05lAFSHEVbDHwXFB2I5TFkov2aG+MeBTioCRz7y20L+0xClg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+JiIezbMNbZqsdEGUoE3urKKKjIv6J1W8sujn7F0FDAFZFUOypt7/s3bh6X?=
 =?us-ascii?Q?sNW4Ajx2jLSNx4e5vjEi/lOV4N6qar5PYdiaCM2qfXN2J89o6vx1D0ypG+TZ?=
 =?us-ascii?Q?A1TybhgD9V8WRSlyT3QV2WU8klgigIFOdz7lPA4odhW2AWz0EVJbF2z2Ndi7?=
 =?us-ascii?Q?K/h8eptj2mqwm3ufB7iN1wZo9sFyNUvyPxe3/90oKJXu4Dp0ghO2xdAUbnYV?=
 =?us-ascii?Q?nRuCLh60QGU93yMbqfKbRHLkeSakVpKGLsVXko4CybLGgfEb+yvCFdgp2aq+?=
 =?us-ascii?Q?5fJ/MYBOEQmsd0xnnwALA+DFuouGrd89YCq3r+BnzcJ9khSfW5pEY0HpIuga?=
 =?us-ascii?Q?ZBCIoH086OsKZgyihiMcSiWdw70KenFlr0tzMJl+bN//9rTwkozQKDDo1cnl?=
 =?us-ascii?Q?hFp7NqrgwQfiXbPrZvSvz3xmO/hMgRn4bQEP7VqCYLxJGvPcYRgkYeg+uleR?=
 =?us-ascii?Q?NKJRB3Mrcqv0RaLyQMlF3hJdS6YQWH4474k57M/u+l5V+p0obTQhYgu/xqbm?=
 =?us-ascii?Q?W6FhyQXyX24HXDaPD4V1xc1AP2uGuVbc5BPfRspkznGL6kBXKS/piYicmAba?=
 =?us-ascii?Q?dCQfljNTLokkpmZgrM9hfvV8RPgoU7ckTCHfG9pBodWSZDXgSF6z3byWpJj9?=
 =?us-ascii?Q?kLNwJx3dGCPfZK0fEzZvQzGpSNQ+f20znWCUdCxQ6MHZpUkegJr6bXdOZfsq?=
 =?us-ascii?Q?HTbVuWSKYiSpXV+GiuGSdYCZhvKIhO7CmJQQq4iGHt2TJ5l70BbO/3KKnRaj?=
 =?us-ascii?Q?2q+nyo3kNUiHbEjxKwYvFTOJ4EdJenpmUvCrMxg6h6CZv/G/VVJP4VfF3Vfx?=
 =?us-ascii?Q?bDj9pSKPqhxGh27xH6rXmQT0o/otzt67WRUWQOqQ+445vW3YQj3+yqA6WFBq?=
 =?us-ascii?Q?vbYV+IA7q6w/TfpphFrAODlcKhpTDRRsdNHjqWY63UIFW3ifBveldhpAARdF?=
 =?us-ascii?Q?lhn1yA+XcZnkxtOwHxUHu9+DYSmm/yBRpPXu1Y+d8LZ8xfUbUkGXHT4FwmSS?=
 =?us-ascii?Q?ziG1niBzOhC6clw6i26KfHs4Q3ZLk6Cxhq/NQYQ9NlQV8S2SM+hk7GV0S5jR?=
 =?us-ascii?Q?sWZoDO54z05FDb65/Yb2zzkTNuVamoohpL99lpU8o1CHwNVG7wd5OxS2FvlC?=
 =?us-ascii?Q?jtMtAswELOdRm55lrrZkGfOVC//2OcqOnL3rmhDyn2gPsZz6QXd7jZsbtNRW?=
 =?us-ascii?Q?F17FZv07kdHT5su353qMSFsUzmky00Dog+sUy2iyhyt6kw8iJ5IWl0KbSxXm?=
 =?us-ascii?Q?z86t4MSrzfsk93LSs8ZsQb4yPsf/CD7FERV8o2Z8zPg2e8n4GApfMwk2Ai32?=
 =?us-ascii?Q?d2q5RtPj3i2G2fXB73+R4+ex3kmNU7jfo5lAqxQlmjtQONnwQQVD9nuwG21n?=
 =?us-ascii?Q?/yXCEBylBxrhAgVTobGdoCxGcrYta1SWg9AKpWd+Cla6N9UkW96Dn2n65esC?=
 =?us-ascii?Q?5B0WlhgfYufW8kUvsMxzJmkvlJcVh/xDDIM4qyzsUj3/bnhJIQydJIP8pBtR?=
 =?us-ascii?Q?5nJTXKWVznCNIF02bRanUmHyWBYV3sp9LxUditdLY4ZnL6uSDghA9bH3E36W?=
 =?us-ascii?Q?z9/harvMJIzPa5nBIyL2MZG8zvfPx8Ksz4C3Btl6sR/lX8uGUjuP/RNfQ+2A?=
 =?us-ascii?Q?qf3OzVoJBOIVv29BthXOmeGXo6UmirvCIrLQQK+ZeMqhTJv1KJHF0+u9vQfK?=
 =?us-ascii?Q?cxOnaa5jrBJyTWXNIfBkcyCXUfmZsKZgpjl7ey8auVUX4KaGkVfm4Wzpl1NF?=
 =?us-ascii?Q?zjSVlxuEEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faadad28-ec97-4852-b67a-08df36611c5a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:38:02.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHjJ4hl/yO/A1B9b4UDMMgfkM0SfloBAqROmf2cY9dC5HqwLlmcrmxYlOAz5arUDiStOeiekC1K+JYWDm+b4eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB155092

On Thu, Oct 29, 2026 at 02:56:59PM +0800, Srirangan Madhavan wrote:
> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for VFs, multifunction devices, and PFs with
> enabled VFs.
> 
> Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/pci/cxl.c | 3 +++
>  drivers/pci/pci.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 4a8969145f8b..9a298e90586d 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -515,6 +515,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
>  
> +	if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..9031060423cc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>  
> +	if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> -- 
> 2.43.0
> 
