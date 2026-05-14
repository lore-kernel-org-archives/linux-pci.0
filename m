Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9013AD26;
	Thu, 14 May 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785409; cv=fail; b=BuXMFaMDrn1/Kjb8e0vJCSgJ6rBo64nzlPMpd1jHgPfXWkxhLzUsVQ5RjGKfcA/5IM7+VqdY6Jcb8f6rqbq4nBubH7Cch4sBVDcqaoNvSgz43eTqyurSx3LVqFl7umtGYh1oQNbb03K/uz9sbiv+Lir47bz8FpJ/72pMIIqmbIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785409; c=relaxed/simple;
	bh=xxeWWPK+RG0W36I8sS2aVKzkapBo2KWUH0BdUc3D8FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hmhlBQ5umVeBZ2oPIwr0vArlvyC5xIY4/AvBIqVz8emnz5dnQsm3MHQOfBcCRT8MtDMLnoKZuHUKCFpljGu+WtdJzZAyKtSKnC48ICDkzATObnF5j54XwwqSEWIaRAB/C00L7c1gVUcF7yC64xgkyztpv1FIMCZTUzVI02lJMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMhxFexT; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMhxFexT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh1AOJF51MyiMuuYOOG6gahuRADB0tMOpA/5jvhBBxIz1g9QGnxM/R7XuyJsXSfkQcjz9zYCz9Pn/+zV3awD8LTmHPgbrGjQc4/BcLWWBrfc08jVbte6trZNttwlv3xZDlKY67fWSeQwuITahysvF/MXOq0DtmbJlK4TU4zkBaltoBPNDtwD1VNj1vSEJIyY+IB3RYrXhsql5xh/EUYTTxAP7DlbtRHnkusN+FaAcRVooQbRPO1gIwClJUOqjoklf7MafjkUJcTb3FjcURVWGUnQkfDTyiqe22Czu8gbyFtF2ynSPqJpytrSa2AvNHUq2U4XBaVvxaZpKyZKteNygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZIs8eTESwl7xzfFUQn8pEUTq6RsYcySCmuphqXhIo=;
 b=Z9f4NX9F+FDPxPaSBLT/ZBtWEfbxbg3IlstopvOmyOoszDo2Gpit9Zzv1blomBfQKnv2yHRUznThOBbc8gYpF17lA7HA8xV6+Fcy6tolSiMEnbu1t61PTFJweT4R5gsl7YbSD4lOz4DLMHCTuen3Oa4pl8r5VI0G2j8VMj7lvU2/rU36iUzumvnsWNX/Um/YHOFJmIpgGw8lJc8XjurJmGBtmmUOe2SE1me8AkQHmlD6QhWuqzOBcNih7i+4HTWxR3IWes3fC4QdOvV9h0GGwdXTTXpPhh0bXZGjGNWfZeGOJr6RSX5UfaMntdR3C81N2rgeCAo8fzjazc+1LObPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdZIs8eTESwl7xzfFUQn8pEUTq6RsYcySCmuphqXhIo=;
 b=KMhxFexTon3c9Tv8hDXPlCr9Dnn0GavVE5ccXzWWYaT39pgUqlj8btuFVbm4QADv3UxhQDK2rsm1E4iO+E7InT6i2iElUIBhll4SIKaZHm/bwU09/k2KpvPGJ73PD88u+HCvtxIDwTvXUH/C7OFSIrN2gbB1g5EedQ2aw1Lv4q0KlmzB6VARI+XBc26tB7VYnx2+5PQdGpOttX6s1UGyN6lZ2jkIgCP0gSb8Ob3zQzdqCideuSs76keCQyQXunEk8VgRafQ5MCxIrXuKLdhU4nBq+GCru5UlvKeudcAqoGa9iLXMRgyKLsWXGf/ycqtFeJrRqwxiEIk9S/aA7GT9/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 19:03:25 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 19:03:25 +0000
Date: Thu, 14 May 2026 15:03:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 10/12] NTB: epf: Report 0-based doorbell vector via
 ntb_db_event()
Message-ID: <agYcdU_EP6z6qq0d@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-11-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-11-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a35c36-d705-421e-70af-08deb1eb79c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|4143699003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	b4OzQaJb7T14J/f+hM0AVxKnz4aEBuOjMx/UDZi8bcCEwtcWlahk8xX2H5MtWAVxYLkiL74uFY4yYIw/Pnvxn5wfGb26hc0u9Mom+K1DfHe7TGohJ3aCyrGO1VoQJ2BmyVKkbPRe4I0/s2s6X0QThJ27brsJGQebQx7ZlPnJ7bbFDU0xeknEw/hYJip1I4ZCc6oOej0oyHrD3rLC1wOSBAFT2Fik5OYa2mMX5HePC1I0E0a1JTxwCTsmPibXAOzEXuQsD3w7v0T42LagO+X0YoiZfP0dOFf/KHyybzvZcQ5m939bzvP7NLMnCgCNk9Qs2NUERhq8lGZygvvkEXhkc9sjZbZeKG+LSbtzXLayguTR7V1Kxilq/pCQxomJHALXza87+gYjA9FFVkjGP/O8/8yia6/nmnpGHnU5da5/j5d4G7xQy4jDAM5Y5cOk+mbLgyVOv8eXE16gElYDip55L7aDTNfEav8khi33XYNVKZ6nG1KAIXn5EiQ1oC8QcE6hQS4s5usULXBzxdKSeVleBQKSI+6L/YZLebPamsDBuu1o8nt/I3nYbpv312n4URakaAAyAZQFyhNUGPqn347/n0yKpDjhp9p/3RVd7QHUzAFstRMoSNP+Ey/lov4hLzcZI4Jmpt1LcgJALBHu/YrtIxlNu6neTwgTpnDjYtPfFnQh9rVC3ho8sWYufIfpWiiFVQjPXUZ6yRs4kOX38U8+mvkqQ1+vuKMG3fahkhsekmFZI/bYf2oVrkvQixZHER7q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(4143699003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qMLaYJ7p2PyDQcJc1jggsy19Nrcyf8Vg0yYe+9D5cuF9UN5NgsBlU1e+bGE?=
 =?us-ascii?Q?eo6q1llsDnuY9qAUvu88ipPmytkdwnG9emTl3lBY1lgAhMf+EVHTCWgHFndK?=
 =?us-ascii?Q?cYEIH+T1eVqGF1oZNUSC09iOvVONBSwjvSZ5W3iJxNwzIqGHc9W4B6b6g2jI?=
 =?us-ascii?Q?axAOZMD7/sE1JfmZ/P7UTjOWFBj1Tu+wkcsZGGnGf8cHFcLtVVkeTEDGVegX?=
 =?us-ascii?Q?oAPkfGj9vZsyXB1QPBQkBLXXeCp7KUfpSvqnt4His6DfxqMSHclOaBOLd0av?=
 =?us-ascii?Q?I+D+i/xIv8cPpRtfXAPOqT+DLQGwOe6H86NBAvUEAgmmV2NszYUry856XxYE?=
 =?us-ascii?Q?sslsMfQD0ebL8DSjZoHAdUg5wlURw0aGZ7jfIcl2QQD5vgu9Vk/YeWOtBvZV?=
 =?us-ascii?Q?OTaQEYJBdDaCm339z31q9d6GdTpP40iLd4P1O75V1aOStHS/fNzo77ZHlAV/?=
 =?us-ascii?Q?iLqHgxMYF3A3l7fpelicde6A895whF77wjmCS9m/K7eOPIaIqh/lEUD9D0oA?=
 =?us-ascii?Q?Z3HW8Iqo76P82EHT7GquTnYZrPrutLU/hmzaKN0glcI+KHcRuh7dFFTp/97E?=
 =?us-ascii?Q?Jh4lLBH6m8zffINP1JqiJTyCftO9x93uj477/aw/8KSDLJJGmWX96NN++3VG?=
 =?us-ascii?Q?9/yeFf5wTM7yh8o2CEiGuJ/Zkdza2WrgR1KzD92OHYVEFMuMSZb0uvz10fRi?=
 =?us-ascii?Q?DMd1uJ/mO9TiZoNdOlsjC6pAfE0IdRQVXSIbru+QOIKl2LNN2zgWuRnW3uT9?=
 =?us-ascii?Q?RGw9g+nORzjdHKCZlnqpUqGFOw3X2eNgt1f4FYBus5Tpkf/E6k4CX+AVJeIm?=
 =?us-ascii?Q?fqPM1uRJpZ5fUjv3UCVn1hw5ASMEWY4S83KC5i92lsBWyltXQciQFJlQmZzh?=
 =?us-ascii?Q?QkFA4LbUvNTj3/wkHzbduqAd/xgYmaHot2FdjGtBoaWaBAU9EyGh4jsMf+jg?=
 =?us-ascii?Q?09JSdzvr0IzIZ43q60C+kWTnWSMoGNQZ7c9CuA3MWhBTIwWn+vhcFtFwKbKV?=
 =?us-ascii?Q?eXarY0TqZodVQgEBkcG+hl7qDsmbJ6G1dLJkLy7OqhJ6z22cV6TRyO+CBP4W?=
 =?us-ascii?Q?ateM9bQlCu9oZqxB/i4lY5YaweAkcpjauN+IAnSbjsGjlJGeCsWg9LDG/Tyn?=
 =?us-ascii?Q?vzkg1VKQpysemsTuhkdMCNjgi8gEfIocYwHUFXjygXMA+gBIvJnvGATSyjpl?=
 =?us-ascii?Q?dv+KFTzb6XYbW416fGRki14Uf6WyKwkeVYXt4A10XCEEDOfHvy303wDxfRpj?=
 =?us-ascii?Q?1s11hfBqC1rE1h2KlcrUv6k9eHxKQgUp2aAyX6RrLGIbyco2K4fIR9P0ao/R?=
 =?us-ascii?Q?98DeCE9oLDfSsZmXw2MOo2HbKOpYI5ngsttr8QNR4BqOhsdNYleUTbmLQtcw?=
 =?us-ascii?Q?m7wqL48QagslYWxQEYL8hWxxZQL8f4mPp8IE3PFWCpm/dFoQnxlrWiMAqq8g?=
 =?us-ascii?Q?Tj+eAzb7AaTxWkorlEbhOF9XWVQNimqO+QZIFX6yDgwlsYo+kk4b++QHq5j/?=
 =?us-ascii?Q?fnBD0KgQ5vrr92R9jRj7/OQ/1HauyKtNpqUS5YVf7PuCshdEDz7ux/tbKvMu?=
 =?us-ascii?Q?eQFDhsKcXskTds32uw/dKRMq0GwBrLK/5zQsPFlsfsiV1bHbc4ALQOzka/pL?=
 =?us-ascii?Q?7ccDZpkwzZIwA960Xfpom7OVaky4qXRCdy+9QIFRGaEUXh3jsRgCVrYr22Pp?=
 =?us-ascii?Q?gUxDqkF0SqjdofCElFlgUEy0dx79XXE/NA/1qaoJPIFJRO6w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a35c36-d705-421e-70af-08deb1eb79c5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:03:25.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhajEfDtF9u8NNIxJvklBflcQYxvjJrHmc349Up5AjfyshA3YcQxX8W2tY8uATAkjg9X789xhNQAiz/TZrGcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Wed, May 13, 2026 at 11:49:21AM +0900, Koichiro Den wrote:
> ntb_db_event() expects the vector number to be relative to the first
> doorbell vector starting at 0.
>
> Vector 0 is reserved for link events in the EPF driver, so doorbells
> start at vector 1. However, both supported peers (ntb_hw_epf with
> pci-epf-ntb, and pci-epf-vntb) have historically skipped vector 1 and
> started doorbells at vector 2.
>
> Pass (irq_no - 2) to ntb_db_event() so doorbells are reported as 0..N-1.
> If irq_no == 1 is ever observed, warn and ignore it, since the slot is
> reserved in the legacy layout and reporting it as DB#0 would collide with
> the real DB#0 slot.
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v3:
>   - Ignore the reserved legacy slot instead of reporting it as DB#0.
>   - Drop a Reviewed-by tag due to the behavior change.
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c0bab3292075..7b0fc7ef00c6 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -81,6 +81,12 @@ enum epf_ntb_bar {
>  	NTB_BAR_NUM,
>  };
>
> +enum epf_irq_slot {
> +	EPF_IRQ_LINK = 0,
> +	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
> +	EPF_IRQ_DB_START,
> +};
> +
>  #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
>
>  struct ntb_epf_dev {
> @@ -334,10 +340,14 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	irq_no = irq - ndev->irq_base;
>  	ndev->db_val = irq_no + 1;
>
> -	if (irq_no == 0)
> +	if (irq_no == EPF_IRQ_LINK) {
>  		ntb_link_event(&ndev->ntb);
> -	else
> -		ntb_db_event(&ndev->ntb, irq_no);
> +	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
> +		dev_warn_ratelimited(ndev->dev,
> +				     "Unexpected reserved doorbell slot IRQ received\n");
> +	} else {
> +		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> +	}
>
>  	return IRQ_HANDLED;
>  }
> --
> 2.51.0
>
