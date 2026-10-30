Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352160;
	b=VXunHMFz8NxHS4+3OEayFmp6hPLVLP6aOVY+0retnJNmrlLUYsB/DQkveIcJ8SI7Xria
	 go0U0BIkrvK1twVA//rK3OMlFaSqkjsusyhYhP70cY3Xr0gtxfBi6I2/j78I2RkbJEAaa
	 xa/h6hv6CoizTmZQ+a6xd2k56JSq+0yPDC6v3GBEEwM7l2ncd7dLC2KtOmJmRr7PAexrP
	 Qa79mNocP1aUotaeKVtUigevNzJLFsk9002d9VqkLvIHmbz27GRtfkLfe1FDQslVzZS1q
	 xNkz2GKdMzxyVJ4zZ2+hj4mBVZFCbFx9uqteO39gXMGgAyg10zMqZY2O809UY1l02qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352160;
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
	bh=PQVzFRK92HPGxBXIByvf8krWT9abOeJzYjA+Om5Rvpk=;
	b=uiW2gufw9EXGfoVMZZQFYWRUi+zr3qQEHDAP4STxQpW33GI5zqm3IIu3mM2owuzGtAwS
	 +ff/iQVxLjH2xImCTV6Bb8bPTYWg24nmCxytupI1nbgI82Hd8FF90xcsIAA2OeImYoJ6e
	 a0Im9IWTDHEyyLBeqgmngCjaNwHGbGyMcvUPEIpX2GNfmmhbi4admdyob2S1MlCXAI5gJ
	 qZgtXs37OB/l6e/RObWHuiPK/mgGQTWojSPoAqSbaTcK4RvkRq0fACAeYb+nBc0yfHSQ4
	 t2UaZ/qzVvnf3Qtbnal73cPK3pBIaZEDg6hPBu+to8phVmMGac428Xmh8anZyRk1epQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dHFiFhr8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.8
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB82606A31C;
	Fri, 30 Oct 2026 09:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dHFiFhr8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7lEZmBW6TQC5v+D1w8nmXz+aKnyqb1HySoZN1nheQtdaoHIGxaNKr/kEjeOt8gAK2nYw5fGOfMo4NMlVTrPlDlaK+pd82/qvyMdx9d5Y139apqE+iz7UK+QCBwUnJUXkyNyMENKT4hX6ozYI56q3cFv5TurZXwX3nwqKIIUPzVOLx3FYWqstPJWslNXACUf3OqbDQ/jmNXYNXNzv91eWe1sd+sAQ+qVzeTwnaiXGu/WqteQpDw1+zystRhRyAegyC/ywfi/d2FImXOdwTglYElNhNC+AaCQyBz7vmOKYXlXsRyIqDOdNx/UhoY/xrDIPCsiGjx+Ekk0Fsw6kTw6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQVzFRK92HPGxBXIByvf8krWT9abOeJzYjA+Om5Rvpk=;
 b=w5VuolhH3LAMSjWWBIbeNXpoDhzZSkJE7wiFNYZkq76LcJbDeMmXZBGqXthLmzrSbnPsZkqjsAvVBmfCRDH2kh6mREgChZoa3eNCGWd4bShOic0Ha+7p6fQZCaw/WxzCUy+xLI6k0j7trqKuv1hmJoX3o2SeNEWYjgsq/jjiOmoqg1mFEc5ln0ciQRpsoEbxSlm/0snD//Dd82xeXFFvlGZfAqJ+mZYAXdzHcuDTDY8AZxztvGkEzq/LMJviAqLsIZHCc6t08lPExoFvjJgPYbT1bm8VrOnZblPoJCwukESE5ARN1aTDmyTL35scc4SNXvzddN5NmfQKfdfve8Ylxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQVzFRK92HPGxBXIByvf8krWT9abOeJzYjA+Om5Rvpk=;
 b=dHFiFhr89ylOvKZu4O4WS1F60SdhQrBfF4T/8tLHzDVBrb2xs1y49ERw7aPxN6a4DWUqZg0dJm3ztFFj+ai4t+A/1OzstFBwtImeXTVGlEIpAoHIszIu8M02q8zERO0Er0beImiEcozA+aDbR5KGT+1xmcqi2hvtRHRkdqDCVq61AXpHJan5ypcFeg0bxVjpNEjMROyftD1zYssDqf1Es5JghNwmgetQLWZrOpHE4WyFy8Ifo4Pi1JkXrp0+XBuIG25gdCuSyPrZRRNysg3F6BXnjNIeWGMNHP796mtD+iEH3kMoUZEkif+3K8R/Bx3lz4NBxU/NRK1BDSbPjCpfdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 09:22:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:22:35 +0000
Date: Fri, 30 Oct 2026 17:22:28 +0800
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
Subject: Re: [PATCH v16 17/18] PCI/CXL: Restore CXL state after CXL bus reset
Message-ID: <auRhJa-nzR0CnKf3@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-18-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-18-smadhavan@nvidia.com>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 78165503-6257-43b8-64bc-08df3667551c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|5023799004|11063799006|4143699003|6133799003|261028144727099003|261009223027099003|261022105027099003|261022113327099003|261022075727099003|261022115727099003|261021123027099003|261021130227099003|261021133027099003|261021135927099003|261021121427099003|56012099006|261026140227099003|261026135527099003|261026121527099003|261026130827099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ifWjGOLXvojuOCovBAtsqUamhX6sZ0UyqDsYuTJ4Mb1RnWKPloH4hHv91U5khLPh84QBUdyIpr6mw+Tw+TwXXXs0HzZYzgpcfWYj6M3LeRXWXk3G0TMJ6Ahqrcliy7q1XwH569Ak0gcp4pjlXL7n708bJOYMCWFegwsFL6NwQrzxifxzPz8RZ7huR7wGLLqldeozLAaAVBy5xyB9dkC1qX2iA0ERrs++Jc+hTUvYzrYbLC157VqmUip6dxk/6Z3fZ0fd/xq+hJzsUS04YzM7BEXKdKiEYgvQFltVg7EufnfC6v+v5iZQVtxujwOm/mb6OV9TCarntgMtvVL0RwbADGUUwcL7Tv9oJq1DeIU9lONhWrfcSQB0qfDEchT5vhGSlL6MyXvf/6iT3KsfQZ+cKL+yNG5DB1LL0sS6R8JeRqepHZVfcbI8CyV56sBmVyEGP6vD9Qo6Bcu8hZH3qqhhb3x0zkbwO1HP44fq//d6nxCcgMZIiPT8dWc5MZzJDMaSfmkDINS3anaOJvK+StrAAinCn0IZ0sJb9DYJIh7XXmyCtJRWNH4G4SfWOcqrg7SUz8sgUDP2tU9I8TpqD0Uzm7sdPQ8JdjmIcM11gbHV7lsJ8LRUVS3mQeQJue7SyqVT9hHDnGTcYNpUIAztus6stM0xh2PIWUdm48o5BPng7EM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(6133799003)(261028144727099003)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021135927099003)(261021121427099003)(56012099006)(261026140227099003)(261026135527099003)(261026121527099003)(261026130827099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLsepFd2vOnZET4+SfSYLJ/f2+bp/N73dUPlGzCmJvV8Hd23jzJ0WtAWtSOH?=
 =?us-ascii?Q?1xsQfuyU6lcgMNH4qWBuUNCkLCaStPyeb0iY00GVZ+NN6mQduhzAMXs9F6iT?=
 =?us-ascii?Q?kWkFNF7dklccTMnKacxhcW/xZipV5Fr5MeykSfcniQWIZOuT2cm2yTTQ0LxN?=
 =?us-ascii?Q?14Sey4pQ7ws2Ah0qCbI+B6rODT7dzpQ0oCOOaZp8MCNUc3aGt7Tqs9JLUMal?=
 =?us-ascii?Q?Y34Q6FXSGg6bQP+Q8VgOpSNiy/nPh1oQXPh89thW2D4RER5SiIotytjbRb1r?=
 =?us-ascii?Q?F4EGrTMbqFS2HU00cJgzsvBo8Otq8IZY3NQZ6uSqKQRVpp+opoYKBCIOP1QU?=
 =?us-ascii?Q?ncOwzeSk8SArwUSjKQ9I15h/Ku4VwJOlTkpFl25Qll328c6dGARC/71PNm8p?=
 =?us-ascii?Q?WX5tgNJm8mGGJBcGIWUOBCQTt9G7dB00S2wBmQosnipucK/RNh1WiE8MnPXR?=
 =?us-ascii?Q?Zb4KpN06mvCXK+ih7zEFDQAGtLk9iszZeYHAC6mc3tTAbWtU5upvsoGWq2dh?=
 =?us-ascii?Q?2llVcv+oFQ6+w5ee6Hat5uofZtNk/sySc6hCmEQhyiIVEV5FY3BTt1WlnyxJ?=
 =?us-ascii?Q?WCrkcs3gGy2Z5QRRxHVOQ/RqIDdCmbdToWSEo+1fAxe9omyNEVBEFoDLN+8R?=
 =?us-ascii?Q?NLc8yYlmfurN72z/mNUN7cOArhtJrEIHghr56qkConr4EdI6ZtIjLUVMnUev?=
 =?us-ascii?Q?+Gx6LQG6wyzs72UOAB+RJTQkyTl5TSlo21evQkM9aWFmGQz8wp3fOmcTQLzZ?=
 =?us-ascii?Q?AleRlxJp4YQIbKP3o2P9547px1MeTXG5DgVIHPusrV1PapZj+YSMikUZWIYW?=
 =?us-ascii?Q?uB5l+0vodbedCmNnyd1UnFdPu2ysrrBskok/NrP8BD6ItxVeLoFuJUw+WStA?=
 =?us-ascii?Q?W6hv5XsLGs6R3jgOvHAnpoBAW9IDl4836E5ewdhaEQ8SQWKZQ0ELWNN77iOt?=
 =?us-ascii?Q?wo0ICv7R5FFA5allveiV5uVI96OlEaQ8PWm8fOezO0D/Y0NeHq94dDWFUWgi?=
 =?us-ascii?Q?fzDV1zwhG9mdZ5bO+HzDW5j3iT6GWFpVwM2ev384wD/wJ8Fq/3Ka9wBuY9kk?=
 =?us-ascii?Q?RrPPU9AeFgO795ALwxF1AbSVDrZHM/x18X8qPWnC1BhdYFkQjXBxapNkE4Bj?=
 =?us-ascii?Q?+i0qqKhSfGTMQhCgGL6TJQ98e3J08rGxhAui31PWsuBD0kEmxmDeM2aQlPx9?=
 =?us-ascii?Q?JGffqlJAIOJM3XaJ4CHyC9rQbRgqXfT/1mfoC3nnfNqt8hL82yEeIxYYunYY?=
 =?us-ascii?Q?/JwDeN0wK7lgJqxoTaCOnLmXSt3WqI/j1Rrxx9CwGKhp0dTKe1EyHCcPQzna?=
 =?us-ascii?Q?4UoZ+B5oiK+adTz2mbpXaqvxoGZqiF8aR3pFZhLZv1q8VBG5HHBs7embFo8i?=
 =?us-ascii?Q?DUjkCGOUcg/MZwNyETicmOJMXVQJp2tax7Iocc8SoEqbaCcGJGmJj6QyUSqn?=
 =?us-ascii?Q?W4wJ+YDIHYs5o7VH+RUBX8y3p2WCXqU7Ch5Vwqhl/R1VY6x8oukXZ31ZszHh?=
 =?us-ascii?Q?BNH2sfqb0ciG+QSMJB2QyJKlXJ28PdKzhEViluZkv0q4sfsWXi7AUGSTnZ5y?=
 =?us-ascii?Q?OdMjNpvzlO3/2kGB3PTL50CMJ3R1tH+vJFcIAg1tmXag248D/d31YKk2GMj7?=
 =?us-ascii?Q?Qpu+so34T58RR1dScXwrI21Jpx/n8ND4LqRgrM+xYGISF4MvKguq1OanlelR?=
 =?us-ascii?Q?XRPXZTeygaVasQa7Eo5Rr3CIjS5YmAeQZv1l+MRP7zsjusfp3gZNpgcF/RCa?=
 =?us-ascii?Q?w/3Ezxh6zA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78165503-6257-43b8-64bc-08df3667551c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:22:35.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ufCi7KT3TBlbEVktmXvBI3wYz2fTKX30pXehtzUIW09i1JVcnvfrWpJhLT4yQQ34uPqEyVa3VjU+/DpkTd6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On Thu, Oct 29, 2026 at 02:57:02PM +0800, Srirangan Madhavan wrote:
> CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
> control state. Restore the cached state after a successful cxl_bus reset
> while IOMMU exclusion remains active.
> 
> Restore PCI configuration first so HDM MMIO is accessible, and preserve a
> disabled state if restoration fails.
> 
> Copy the cached state before the reset, then refresh its decoder settings
> from the cache under the CXL region quiesce once the reset completes. A
> region decommit during the reset updates the cache, and restoring the
> earlier decoders would leave the endpoint decoding an HPA range that the
> CXL core considers free. Keep global and DVSEC control from before the
> reset, since a refresh during the reset can read them as all-ones.
> 
> The prepare/restore interface and decoder-refresh structure follow Dave
> Jiang's cxl-type2-reset reference branch.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci/pci.c
> Assisted-by: LLM
> 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b93f0c8e67b198a63786fd3721b7177ab9df60be
> ---
>  drivers/cxl/core/hdm_state.c | 31 ++++++++++++++++
>  drivers/pci/cxl.c            | 68 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c            |  8 +++++
>  drivers/pci/pci.h            | 16 +++++++++
>  include/cxl/hdm.h            |  2 ++
>  5 files changed, 125 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index cb7ec0f86ab1..6b91721dbcd8 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -188,6 +188,37 @@ struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
>  	return copy;
>  }
>  
> +/**
> + * cxl_hdm_cache_copy_decoders() - refresh the decoders of a snapshot
> + * @slot: cache pointer owned by the device
> + * @dst: snapshot of the same device from cxl_hdm_cache_snapshot()
> + *
> + * Copy only the per-decoder settings, which region commit and teardown keep
> + * current. Leave the rest of @dst, including global and DVSEC control, as
> + * captured: a refresh during a reset may have read those registers from a
> + * device that returned all-ones.
> + *
> + * Return: 0 on success, -ENXIO when nothing is published, or -EINVAL when
> + * @dst holds a different number of decoders.
> + */
> +int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
> +				struct cxl_hdm_info *dst)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	if (!info)
> +		return -ENXIO;
> +	if (info->decoder_count != dst->decoder_count)
> +		return -EINVAL;
> +
> +	memcpy(dst->settings, info->settings,
> +	       flex_array_size(info, settings, info->decoder_count));
> +	return 0;
> +}
> +
>  void cxl_region_quiesce_lock(void)
>  	__acquires(cxl_region_quiesce)
>  	__context_unsafe(token maps to cxl_rwsem.region)
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 0c4ac0832b34..5aa97705a669 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -389,6 +389,74 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
>  	return cxl_restore_state(pdev, snapshot);
>  }
>  
> +/**
> + * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
> + * @pdev: device about to be reset
> + *
> + * Copy the cached HDM state before the reset, so that restoring cannot fail
> + * for lack of memory. The decoder settings are refreshed when the state is
> + * restored.
> + *
> + * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
> + * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
> + * failure.
> + */
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *snapshot;
> +
> +	device_lock_assert(&pdev->dev);
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot))
> +		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
> +
> +	/* Raw reset callers may not have saved the PCI state needed for restore. */
> +	if (!pdev->state_saved) {
> +		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
> +		kfree(snapshot);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return snapshot;
> +}
> +
> +/**
> + * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
> + * @pdev: device that was reset
> + * @snapshot: storage from pci_cxl_reset_prepare()
> + *
> + * Under the region quiesce, refresh the decoder settings in @snapshot from the
> + * cache and restore: first the PCI configuration needed to reach HDM MMIO,
> + * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
> + * failure.
> + *
> + * Refresh the decoders now rather than rely on the copy taken before the
> + * reset: a region commit or teardown during the reset has updated the cache,
> + * and restoring older decoders would leave the device decoding ranges the
> + * CXL core considers free.
> + */
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot)
> +{
> +	u16 command;
> +	int rc;
> +
> +	device_lock_assert(&pdev->dev);
> +	cxl_region_quiesce_lock();
> +
> +	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
> +	if (!rc) {
> +		rc = pci_cxl_restore_state(pdev, snapshot, &command);
> +	}

Hi Srirangan,

Looks like BME is going to be restored here?
The caller haven't unblock IOMMU, if we enable BME first the requesst will hit the
blocking domain.

I think we should enable BME after IOMMU restoration.

Best regards,
Richard Cheng.


> +	if (rc)
> +		cxl_reset_save_disabled_state(pdev);
> +	else
> +		rc = cxl_reset_save_restored_state(pdev, command);
> +
> +	cxl_region_quiesce_unlock();
> +	return rc;
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f5990d6cc51b..22f740417673 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5014,6 +5014,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
>  	int rc;
> @@ -5036,6 +5037,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
>  
> +	snapshot = pci_cxl_reset_prepare(dev);
> +	if (IS_ERR(snapshot))
> +		return PTR_ERR(snapshot);
> +
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> @@ -5056,6 +5061,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	if (!rc && snapshot)
> +		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
> +
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 743e65abd758..476e8eefafb2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -730,10 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
>  
> +struct cxl_hdm_info;
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> @@ -741,6 +745,18 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
> +{
> +	return NULL;
> +}
> +
> +static inline int
> +cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				  struct cxl_hdm_info *snapshot)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCI_NPEM
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 80d6ebb9f4aa..090eea2c0b46 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -66,6 +66,8 @@ void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
>  void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>  bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
>  struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
> +int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
> +				struct cxl_hdm_info *dst);
>  
>  /*
>   * Region quiesce blocks CXL region commit and teardown, and with them decoder
> -- 
> 2.43.0
> 
