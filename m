Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558262EBBA9;
	Wed, 25 Feb 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053647; cv=fail; b=Y2I1yF6484iHqi28yvCZab4sq0fIRGX86cppSMQ3FwOC0kzcN7pyX1s2PIYHzIl5Zh/5FNrQFUBm/ep6F+8jy2ZpKXvRcycwvyKwF9LafNrZyMrCej+VyNJ39OFB7fYdsYQ9cvTU/Y8KtIdoqN2GxzipKIEvJo/QZuZmDYUHyyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053647; c=relaxed/simple;
	bh=JS2FUA/D5+wOLyT4eb5Wws1WzfpqcMxLqxYMStwcjEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hg3zfHAp2Tg5aS0Fg4NnEJNh3IbuYzKE2/4vcyFsdO7oRa1kweEeKwtk7bcf/zSHnkHKyVfJ6/ZiRUfOsETP3Iv/7KoCnJfAbc8laui24Ewku8q141WdAUncucIKhq4BVzS7TZuENxUFAoi/BBQDPnr9Z5HCfV/TtCyqGSqt7PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LRRRc7t5; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LRRRc7t5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDxs04NYsBLKM8T+DdOCDB+iXREparoKWdtoZYPvCdqL31Sd+s87DIEzxfBCQMYCLUPJEHzb23kNy9Xv0yiPNV9hH7k8MEkzYVU8GfVOhK9takAqy+hVIWkO1kQXFJgFYR4YMIPpVfCUy9ZAdj5pV5/avgqj48EYa8tBHziGPeLIVb5CwTxgWTZT/eX+c1W7CD2djyOgk5SSSMSzLK3XWXHxkwAXgcRL6ma1gzYZ805RK3CvQBklWXvRD23dmqkOYh0NjkF9e+jCvs3Afchv91OCni3II5YTZgQxaZ/DEHxFtaJJWL2oJSx1F9ruQRPpsAdVcclFLar4t9AXbdFfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGAkIyKcwmgyQSC/9UB+VIXwMtmPqwhpHDOZ8dbqUKU=;
 b=NPQsctCIMqQJV5mdtuj+NfCQWIfalLrKKip6NdHMtKvlcjaEm1HejGtIkJohNlma8Fm+jZM8K3TOAQ/b5opxUPRAUvj6HewM0iyEOH9u1zpnVdeknl2Sfb7yCXej40OOmDJ0RyRS+FJGeqOdN/hJakmAPd2yaLfxXt2bPfrLovu7lKDHLPhbUQn92bCIAvsz6zi5pJ+1XGaEteJ7vrTFQW8rcqmvJBx236JUgmKBiXCFu4qHaWxWg9GakaMVtKQj/e2Zb5l4G9cdF8GVcwBzPEeUPcmPfwTBzTOfqk0uo/avyKJmjNxjiIBDwPxh11PikL4weM3+f2O62lskPkvJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGAkIyKcwmgyQSC/9UB+VIXwMtmPqwhpHDOZ8dbqUKU=;
 b=LRRRc7t5cDRSh6jR9HUhOXUpHJJ1nNHKsxYZEcv53zwpcREaXWdi9AHyvGez+IBGMgc0/lbLzVYK6V12t47AZOrIk0IdH/L/pnRbjVudMIxa8PR6zpMq0c8oC/eZSmE7EZMJ//VEeRDoYBMayB17BWDU3fe2tb2NjM3t2T1ukEaOqCJsRBU8JHuTwvtUFMsR43245KImBrHbwqTfT499hU5laGIyG6MeByyR9ASiOD2tMjzgkAZtI1kpDoQkoR2rxgTlAH2jP0R3frX11mL7MHR3AynHtlrPpcgvXBtRrLV6ucdEjfOP60QWepXeFnh8GdSyA3L0W592RKlsJxiirQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 21:07:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:07:22 +0000
Date: Wed, 25 Feb 2026 16:07:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] NTB: epf: Make db_valid_mask cover only real
 doorbell bits
Message-ID: <aZ9kgupPm1swi_AM@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-8-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7579a4bb-0e34-45c8-65ed-08de74b1de74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	zOqDxcBF2P/hSoQAo5reOqYalXXUtipYpub/A8i3D0MopbBcn1BYKwUWg1JNCKH/FXoYwlZ5vDuX3XyUXaVjrO97u6Vr/TyVutonMSupMgRAqoitT65ics4dbN34asZGy8RLCb+O4azRuGllU1ou4U/Itm+gqSuPTWo7W7hMrwEazbG7MQQI16ZNN/RxyefhTZoNhkHg43NxWATB6Ns3CB+QWQRtlhA0UoisPJmBNSEc+l9Bn2qFs/piig94PNs2GYweWC0KGl/EPNSKpN2ZHBq3hrdYEzMY69yPB3Sf87EHgTJwJA6vCim5nB9AHkGWbskpgh1yB6rLw9ES42CXut25EU3u7Xdw3QY1emUoxN9djZSqekerHa1c5Wq81UN7xXNOJuxq5Wv/rKRwdZhMPD5A5TZnfqtcwmAshldJlNGxDhuI350bkWYDvsep1w2N0WQPpRj3ZNUlhVnYn0zdBmV/PxcFNdQuBngdAjFKepIGucpGd5So5y3TszfAyOOsXzR38q5rKUqdGUkm9gcYRYnJIG+ihxBjJS1b9AxtcozH2WZKrxmeXMY/IxiK5rPOQpCpR79mMbL7h4XfmsijR1RjRunWwMyL+/NyrUv9UrjHBqccMTpGqrmVpTtugYAKKQUzSRfIfwZnpOJkiyMGfUlD0xEif5Nt49lEgsjiMds1kSckFCqPZ6UafWiE9u5kyUvjQzXRabxS3UW7Fc2aK0f8S0+QwGQZ/dSAV62Bku8zClFDiOkafO/INsIYGb4yVzqdpjUdvM/ZyXkl8x413DTEwFo4cVOPnnO8yUPJ0lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3CQCjOXcvL05L0nfYCaxgmwGt7RZe86rg7AIP75miC7QZiBaSM2WNHYkVHt?=
 =?us-ascii?Q?enqjiPbgQfK48Ne5boWQsoF2JpLtfLE7QZD9MQ6e3bvQR5uWOIfsD999sHkB?=
 =?us-ascii?Q?TNaCS/Els7Rzw4UWgGyYEcPOj5uWv6i0y0SlHYqTpB6bg6jUL/a75MVDsK82?=
 =?us-ascii?Q?A2EDQyOPVe0ElJVTRVnHI/tBbREzrsmnIkSnIDBiJxy6eLDECrRsHZmNM0ui?=
 =?us-ascii?Q?ouNL66FD6XosmwldJLvBEGAS0wcqybFTOb5a2gm0ViIpxvLqo66QZzrH6kUo?=
 =?us-ascii?Q?HOa7jM9LOPoYxD0G3ryNliMM/WDRxBIuOKLhiFTsJ4U9BGcYjxu5uhmyKUn0?=
 =?us-ascii?Q?57c6LG741i9m5/WZD/GnJV/m76wv2O22HV2QHnNjbVOuOEiCAPZlDSccBeIZ?=
 =?us-ascii?Q?mEy0ghg8eOSt0XCow/9MH8euUIXw44cn5KEN8DX0xaj0P8xcj9tTjVt+fSOY?=
 =?us-ascii?Q?tHWLMhk0njuFcBmT9NR31aLv/lSPyn8BEHjco38tiricEEwLS21RHEYreiC2?=
 =?us-ascii?Q?z0+WclqrvC+BZq6JMrQGGUXPE6GW+9GwYUTsMLTCkU9pF8llFOhuXxoTpsmm?=
 =?us-ascii?Q?17ILm0M5yu4+tw/jm94e3iw+CVEBnEPhD3fK+cEmYg/QPOLORpSre7IASrbm?=
 =?us-ascii?Q?ZgV9oaldjFtHWJsUgD4linCY9WtzHlLprmC6IiX87znpKhNTLAE9YqZjKRe1?=
 =?us-ascii?Q?AFVpwqi+fYFodj1xDNpWZExjkVKa6GwHgqg2srRJnAkEKIsy/D5eml9HJMBu?=
 =?us-ascii?Q?eN017R3PGB8pNbl1QpjKb/9Zkbb4+MIRt6tSjhszJACIgtsd//zZ1ut3m2Ct?=
 =?us-ascii?Q?XCi8TZ+TMm1jG2Rkwn8XBLnwsIIcU0YbxTRHfpbXRcKVG5G2K+WfqIeSvba2?=
 =?us-ascii?Q?L/wjK2p+19dVIL+wfJeUyvHZogyHsDMlogzOYAEfwt4Yvw5vzMUAPXiAZhRa?=
 =?us-ascii?Q?aQQ3RDDvVK2qyHpAMDEjHe5tKgl0StTmXMys+lken1nk6IkRTR6gRKe3DN41?=
 =?us-ascii?Q?Rj4oDVWG+43j9OL0YiPVn6ragb8AuDj7P407dPMHcTSIv/7ZyjLoOjQLMien?=
 =?us-ascii?Q?aTkj699grU2nUahbAKK8ve97SHJQFjrymg4qLRpDalKhGMKLNSG8KJf7KoIP?=
 =?us-ascii?Q?fU1ah0W4baDcwaBhJHCZ+IeiudxYoeGnLKERvM0IWo7tNdUtUmTC0fQXC7+N?=
 =?us-ascii?Q?tTAHSmnPbXnJyMZg2NizemATYO1RqKe5ChqC21EKyxqC3F++HftzKnOSdwl6?=
 =?us-ascii?Q?BI728pbK773FIPrZuqgpr/taQuLH4lMPyiOk2uJM94TwbaqJmVaZVP71P1PX?=
 =?us-ascii?Q?Knzi0RCcUqnbHpyyRgU3VPJzsj6eTfKS5vRFA+2lMbocRwi4lH2FoU/UlUy3?=
 =?us-ascii?Q?LsxNlJLctL1eiMu+VSbLxQxKFvqa1ATApye7DJc014KSceed8GwV7vYfXT0s?=
 =?us-ascii?Q?szbGGcAG0bOU/t9ZsjWbuSt9MQrNJnvaDey0eb9vgOpH9/MiYB11vfsZL1np?=
 =?us-ascii?Q?5cBmwMZ331BNjrw4ffEasyMBp5CsJutMLSkQkDrBG+4diiqmVMCRlGRzrpU5?=
 =?us-ascii?Q?2sbQcj1LiqZ0GsOvRNv364iPEZNIDCLE2GUebkG3WyxwgSXHcG/5omLlzj8f?=
 =?us-ascii?Q?99QoxJflquDngBguKqE4OnNve82ZpC0iu4NHZpL3WADSHtTxB/GDJZZll3f7?=
 =?us-ascii?Q?4WgwBXz3tPUTezdXcS5Heqm3cS9b3ykQfKtJ0hKZEfIV4Da+t/LJiyS0W9NB?=
 =?us-ascii?Q?cHoezQQq1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579a4bb-0e34-45c8-65ed-08de74b1de74
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:07:22.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7h0sJJReIJ6jNVIDsMMrcbSJKFuIP0siRqye/6NB+d4gfJOhh6LLQCgf7IPVYrWGgJdP9CAG538ASZnvZQ6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687

On Tue, Feb 24, 2026 at 10:34:56PM +0900, Koichiro Den wrote:
> ndev->db_count includes an unused doorbell slot due to the legacy extra
> offset in the peer doorbell path. db_valid_mask must cover only the real
> doorbell bits and exclude the unused slot.
>
> Set db_valid_mask to BIT_ULL(db_count - 1) - 1.

db_count -1 or db_count-2, previous patch use db_count-2

Frank
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index bce7130fec39..ee499eaed4f3 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -580,7 +580,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		return ret;
>  	}
>
> -	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> +	if (ndev->db_count < NTB_EPF_MIN_DB_COUNT) {
> +		dev_err(dev, "db_count %u is less than %u\n", ndev->db_count,
> +			NTB_EPF_MIN_DB_COUNT);
> +		return -EINVAL;
> +	}
> +
> +	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>
> --
> 2.51.0
>
