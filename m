Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2947A0BC;
	Thu, 11 Jun 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210204; cv=fail; b=a7hA+7VEuA5pTReMFrVG2F+owZ9RtEbnoS2l7aiY41JE5OWtZKYLG9HVI3DL6Uc2ABvtTK6vJXM/0LOfPkGOOOe62qxRrI2zMVJfXDgn5XUYOJVjPw6H7W/6eEXyIDI3sLwPTr6ciXhpx2pBKPO0TDIeAx2thjX6hMe70FNzyeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210204; c=relaxed/simple;
	bh=R/QD6REcXVerVwn0GXJbP8gjk4qyNFqFSNF/IRuQwmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwoWxbmfpYLvPsX3cy81pj3iLqU0oEIvGPKv4sU7ujrskf4JpIg2O4awksj2DQqarlfx9FkdlKS6ULzH0savwfpDvYf3P3es4fl5yb43ib4NlP1Oznv14YL6iroGaLsoXJZjbjhlshwMwdZvzRx6Ix9ByABQ/YenPO5y17BXPzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ji5pRgwz; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ji5pRgwz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP3hk0s5N7PleKi5blDHE+mzQ7u/VO8XPZGCpuN072BTv5x9OAeIeHdw93Ca8edfkQ+8560Dhv3r/PMLqaVjyvgOcVvn4ZK8Mv5enOnppFvbMOSrTE/SYccX9PGQfol+TfSbEGatlMmMLxlGiC0k4r4AN6Rd0IuYUxF73GJqlrR/Javp8v9vFvkbaisaxcvuuCfJQxcbJ0Z3IBuOsIrkFMBDAWKPSoHihm/I8BgCI6ov5sxN+cLmuh02ezBQJCEjBoyl7DbFK0RrsKpaqzNGVV37Zlzow5NU+UyfVql685GrlquUFuwJYIM96TlIFcEu4xvZuwsEqFDQCz76pMCQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5UTtwM5OuIc7Acz3fKbkPp75x2lDE2VtbXtcDcY8J4=;
 b=BgjyFP7LZE6+fPhquMIRoXaPhTXn0gLkiehwbwWO59JfzZqz1UPcITp/u3Bq4GqRa+Ts0lM1r0F2hvnZjlFCxE4+vtF2kFvO2Z04FxUsTHbF11B6rShAy2/nRA4hPt1tA4bL0qXNVzM7C5trBTHz+RfZR0wklQkw6D6Vy5WrJAE/ce0/kRkjaz1Ryq10tkRtSyngOKQKKINv3MZoTY3RxRfLrJiIjZtLaXoYJ4oY2RNhppMO/amr+zU1oWUiK+8fL03oeEOoJFvfmHY57Wc/eYy3RkcdLkn8kdyoT83GC9YS63v6o251t2LZKEB/FFGx9c9yuq/selvf02xcZFo8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5UTtwM5OuIc7Acz3fKbkPp75x2lDE2VtbXtcDcY8J4=;
 b=ji5pRgwz/ucW9ZDann5RkPn9dVreWWQaLGnqgA8sXnrgKMVJr1RECLp+RpKpt0D2xyanZhvtPJ4K3GBXiWcBlw7p8OlFy0UQJ3sRzldeMWc3RZGOruPr8/okESQTPgHI220tXgLf6u0YoTwpljc3zfys5qwoLqHQLq4VtQunP8ZZMmgaYvqeqySAA2zhaHT6BhFZpHcOdaSIHqLdGIVdb0gWXUawfdrYOejB4goiM9/psZ6xkvfF3dmU7ky8Z3TkLkQF+hMSlmnLsfbNHu7fHTQm7vS9shKKrfI4DJHZatyEVP8sehYhpRyuQIvWwXdEuff58zs0Ut3ND5AyL/gKVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 20:36:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 20:36:39 +0000
Date: Thu, 11 Jun 2026 16:36:30 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de,
	cassel@kernel.org, alistair@alistair23.me,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 1/4] PCI/DOE: Move common definitions to the header
 file
Message-ID: <aiscTnplWtucrFfJ@lizhi-Precision-Tower-5810>
References: <20260610100256.1889111-1-a-garg7@ti.com>
 <20260610100256.1889111-2-a-garg7@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610100256.1889111-2-a-garg7@ti.com>
X-ClientProxiedBy: PH8P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a201b7-991d-4f00-ba6c-08dec7f923a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KujxZY7Io+5juasi6PXc15yL0uBBMhIhQq0u84aapeglF2y1qzRVTLoixDBx8OsIb6vbZNByAQXADlxJojVfb6UBVyQuMLRxZUiDPf7ta0zBXEwlkrJiyM0ctmGLKXL3rzVJ44Rzm1HqTPtOoac2RbUCGm8naKEzKztyxryFG8RypCjkqa2z9o0jcPQPb9KYA3k/Gh3tnIhwWkuNGmIyGuUmuz1/4vvevkoDhnIwWgoHZBx72rhr7+tOZ5UPHo/phFg5k8Qj6MqMrrQJ1LPCd9ta9TR7i52KTSL7ULlHrIY+MR7kBOLlMon/oOz0V1moXi3oWEBNGletg/Ry/oL07Xvzxt/1HremMyOZlmnxPUV8hfhq6ucbUJJW+uYExTXb1kr9xUGvuQM1mPY0OayFPqPpIMmvXTyu5rnbW6TjLa38Att3kVVht3p2sRa+tEtvpfjxZA6RBneVzZzA3c/y5a//KpoiXWeN+6QwaX9pXg2UevS1n9ppQHBBn7vE6MuDJpybTjjpfPTvSCaAW+bKfzQDjgKlWEy8tUL0VZsKlstSwcpQJIxBh1VK8YCsyXCJXsiqvo9zJuiWb92gSWYHBrksNgQ3OGP2JW+R+KM/f81ZdN+oB+ehq6Nqe1cWjcab0wP6TLmKlcmAY37mmHrItjGcQUx9KizbrWAB0uHqQ1JFB2mQiISgae2QU+eP2rIUn6dc3MjvGynyW+J4RHAmKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZ3JFFTncjc5fJnEe2ZjD584obUxj2mdm2JxbqNcnbfc+1uadK6/7wtX0L2W?=
 =?us-ascii?Q?QmZv40spLSDNF2rs8I1I6O2QDGkqCN2aTY/YP5pS8LQQCXKRytDeVNB5ja9+?=
 =?us-ascii?Q?GmHpQjweeQXzw2l6flii02ODr6EPwe02g5wfUo/GQujKF7oZtrHxznfow6sN?=
 =?us-ascii?Q?f8dXTpOClXj7WsBRS4/LZCPXT7mHewNN02GD8IZkw1Gfo5w3eJDoxf2osfAs?=
 =?us-ascii?Q?kUYjFsnIz769CCKEXYXfCSvLJiRFsNGgnYLyXaWHznyqYuP8eOCJYAg3wXwT?=
 =?us-ascii?Q?Ux1WdCIq2v/5VbUQ3hLQ08FTVLOREQluY9SmYZVic6+H76eldtoDzlFnMKR+?=
 =?us-ascii?Q?mEtNm7508k6euxr2FVkAbi021SrQwqRvHoh+Dd5tyL0evlD3k4K2f30a7ZT/?=
 =?us-ascii?Q?mdw52OJvs68Qbnb+lX6VyVWgplkf7KcHGLrOFVU7CbcF/PkD9iwr3cIkJ6Ui?=
 =?us-ascii?Q?PgZLJTK2S9S1ORHZIDS3F7IbEs2ZQ4yLgVmKkCpUVDuzyYTAm75gsdITgx0l?=
 =?us-ascii?Q?AxOqw7E2tYg7AgvVxLnR2prid/wEVJZ7IELyB/vUyuom0TGIozMGqH6IhpdS?=
 =?us-ascii?Q?5Q3lA0Y6CT0k+DY4ILOzffUzfrXUEhKR5A0lqh6MYkN3JVisQcoPH6sgWEK/?=
 =?us-ascii?Q?9MoDCZkg7HQEB4CPjiHojHrZOVXNiO8zsmqvjwQpWnfFTmTibO1b1Prn7qOe?=
 =?us-ascii?Q?3Wz52aos91uM6Yr5pQQKHftlcF4wzXgA8tN8uK2jtHRtuKNA22G6N4ditUuv?=
 =?us-ascii?Q?oo9lqZvk80ED4HZuDt8n+Jt2vf4gj4RzTL0IWoLv2uw90jT3+3BWc+t+NQNS?=
 =?us-ascii?Q?qFv1Ow8o+K/pBzq8NvUqTcm6UHdBQKqVk3TB2rxHIDbvjYsKizxpXb+48yM2?=
 =?us-ascii?Q?QCFsO8V66hHztcFEKbYFtOi7HN+DTB9RS/kI6CRSw7SH4syEMR4UXhg01FXi?=
 =?us-ascii?Q?TS9qa+nKHOkHwzisVeRfCSU9hO2Pd/RQ0JphVVt07HpQKIwHQCEZE4KL4PeJ?=
 =?us-ascii?Q?phz25iUDod4/uHfbGsqtzeS+k3RFQki6Vu+x0tIJe00vY7a839JLMK/e0iV3?=
 =?us-ascii?Q?ScNMHIgzsFv3TNiCTOwEyW3P1SMdz/3sZnxuVYrXJKTrfFdVPQLmfc1v4qow?=
 =?us-ascii?Q?TBoKs+kE6z/Mmly3MxD8z9CrR8LOhFMGh+XPD+YFQ2CGz7TJoA0Yo6QXUI/a?=
 =?us-ascii?Q?OwGnyREh6gbDcaQugNIO0L65uNkdtS5uwHsYgtdzmPJSGSWsGCZg5sgvbmBY?=
 =?us-ascii?Q?frcG2sSN0WdPC7z28y/Hh9Xd0HsAgqc6JcTgq/S10pTL+kU7to5SFQbZ+pDg?=
 =?us-ascii?Q?FlACyY5zE7fP0BtCCaNHAsg8SWZxPOkks1KvEmd1BL0tDOdesjQKy0q1xvHm?=
 =?us-ascii?Q?wKNhZLqAOKMmDyGdwx9qGHvuteb/LOE1RURrG2vkwzDztkxHfaD+9bsK9dse?=
 =?us-ascii?Q?B5AOUjhZaWEwsa07GY+BTVFMn6re4YMA+W/shuveiMiJW0yGxqoSlV87RgN2?=
 =?us-ascii?Q?OXi/QYTVZTPRzybKXluzh6YtjObYYgCcygKIzKYkuSLHuNdS0ZgBa647Jzqf?=
 =?us-ascii?Q?habFN3XOjSL6wioFi+8gtLC0raioukE0rNLvgyU7VAxugLiyu1/EvvVKoLpT?=
 =?us-ascii?Q?fjDdgEGtWLWMp8UHvN1qmpaFkg5kmuKSTAPd8uIfI0+MAiHWuYxMbVi9zN0x?=
 =?us-ascii?Q?c9wlMgPkcnAEBQESuzuUq816sMNdGDxo4ImWqU9Q54+ZpxIrqe2ayWYA/Kno?=
 =?us-ascii?Q?qctOj3O8QTGNYXgxxgXZgTWuwy1LVMDI0Plg481Cy6dcgUoJane9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a201b7-991d-4f00-ba6c-08dec7f923a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:36:39.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgz7vSQZtEqMtmNdIPYLpdqR12OHGN7qLgZBS7rxOcpS1yc62O6oIl2cBSQXHmYoitPjWIf30HLmZX8uhkZQWIdDk3FbfNZE+iZZ5ZjUyLZx5n1puletGFTamU8LmwWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463

On Wed, Jun 10, 2026 at 03:32:53PM +0530, Aksh Garg wrote:
> Move common macros and structures from drivers/pci/doe.c to
> drivers/pci/pci.h to allow reuse across root complex and
> endpoint DOE implementations.
>
> PCI_DOE_MAX_LENGTH macro can be used outside the PCI core as well,
> hence move the macro to include/linux/pci-doe.h.
>
> These changes prepare the groundwork for the DOE endpoint implementation
> that will reuse these common definitions.
>
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Changes from v4 to v5:
> - None.
>
> Changes from v3 to v4:
> - None.
>
> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
>
> Changes since v1:
> - Moved the common macros that need not be visible outside the PCI core
>   to drivers/pci/pci.h instead to include/linux/pci-doe.h as suggested
>   by Lukas Wunner
> - Removed the redundant empty inlines guarded with CONFIG_PCI_DOE in
>   include/linux/pci-doe.h.
>
> v4: https://lore.kernel.org/all/20260522052434.802034-2-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-2-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-2-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260213123603.420941-3-a-garg7@ti.com/
>
>  drivers/pci/doe.c       | 11 -----------
>  drivers/pci/pci.h       |  9 +++++++++
>  include/linux/pci-doe.h |  3 +++
>  3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 7b41da4ec11a..e8d9e95644b3 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -28,12 +28,6 @@
>  #define PCI_DOE_TIMEOUT HZ
>  #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
>
> -#define PCI_DOE_FLAG_CANCEL	0
> -#define PCI_DOE_FLAG_DEAD	1
> -
> -/* Max data object length is 2^18 dwords */
> -#define PCI_DOE_MAX_LENGTH	(1 << 18)
> -
>  /**
>   * struct pci_doe_mb - State for a single DOE mailbox
>   *
> @@ -63,11 +57,6 @@ struct pci_doe_mb {
>  #endif
>  };
>
> -struct pci_doe_feature {
> -	u16 vid;
> -	u8 type;
> -};
> -
>  /**
>   * struct pci_doe_task - represents a single query/response
>   *
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a..5844deee2b5f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -683,6 +683,15 @@ struct pci_sriov {
>  	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
>  };
>
> +/* DOE Mailbox state flags */
> +#define PCI_DOE_FLAG_CANCEL	0
> +#define PCI_DOE_FLAG_DEAD	1
> +
> +struct pci_doe_feature {
> +	u16 vid;
> +	u8 type;
> +};
> +
>  #ifdef CONFIG_PCI_DOE
>  void pci_doe_init(struct pci_dev *pdev);
>  void pci_doe_destroy(struct pci_dev *pdev);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index bd4346a7c4e7..abb9b7ae8029 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -19,6 +19,9 @@ struct pci_doe_mb;
>  #define PCI_DOE_FEATURE_CMA 1
>  #define PCI_DOE_FEATURE_SSESSION 2
>
> +/* Max data object length is 2^18 dwords */
> +#define PCI_DOE_MAX_LENGTH		(1 << 18)
> +
>  struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>  					u8 type);
>
> --
> 2.34.1
>
