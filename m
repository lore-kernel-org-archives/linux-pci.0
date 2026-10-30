Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332891;
	b=LRTmyAM5/CXeBVegb/xGJveLrsO7br73rBqM8hMhbWyzHEK0s/LBuqwVJuCT6W9jRt3e
	 c/+865YQLYgKxDMEQ1nas96eCj/Vw+8TtEZnHmDX8mZAqtbPR0wToeCYFort9LP2wuIwA
	 U/5YHuP2xQvsLIAtxeR8GPi0YSYOAitie2qxBkLdzE0eK2NSBSl2Dyej7Ms3DeHe5gGmr
	 F3Q4FOJMrTnsnwzqA/WxFpXnXEW2gKHyKjRGFpWGSgzfM+xTDZTnXWw+pmhpesnePXwnM
	 LbtwFCogeAXCgiM8BJddOKUSSalUU0ZMHYJM6vzWdN9ngnNGC4Ke5vwY04S5GSV2fwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332891;
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
	bh=+6h+Ci6ZeSApgdoe8JezmVOYOetsZnnVxqSc5I8ht1E=;
	b=Aj3m+DpyV4R0RjIgBYlvZEal/dbwqBgcwnsmpebMeOv5eGWWKzAdSSrLK6mhh5s79Him
	 O4K+trzrra3lSqx+cD7TXT0iI5sL0UYpEJeODal/USol4Dt3mGzI7EMZt4qY44Ubf8cIo
	 MFV+Um3Gqe7JtFjOhDPQHuC/0COBjALCKF5FlFjv74/lVo9w/9tZ4yBnIOsb7YJ+OOMjj
	 r0DCMEyiAYcrC+HGcPZsZQKVVuxiTksg1aZPMME719aAtMALXkFaDQh+n+jEvGq4W/2k2
	 CZJrvV4SjcRJEFNfLv98IVeyhRc2M68HmMm3H3R3r+f/9ONTeBx3d6k8TQmluj3XOXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LjdPHO99;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBD606A31C;
	Fri, 30 Oct 2026 04:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47CBD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LjdPHO99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gD1jazxq/LKPuelp+e565hlcsTRVCHek/Jj8FGzQfBPvUdx3NWAkl7aicjW6Uo9OfNX5LFrG6NZ8Wv9wb2jISQv5QGwLp3VMhC1syagN2JbbaOeNotAH/QouuGDCtuXJp67wV/1rpmkbB3uOwtIM96iKno2tGYfnuarQuZTwwtQfwRYYh9PoEWThF7NgvbgeAZZ5vSrQMWMd/IAepA4UzKuM30AHhr4GC6zcC24VvwZINJClHgNjFY9F1ehMc4oAr1yfoFyZwed9SbnzLRAf9KFNzz/Y3VnQ31vnqeyqmWc6G4DtoG60miViiMM6L016KJR8Seh/HS4S4EBPv/lL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6h+Ci6ZeSApgdoe8JezmVOYOetsZnnVxqSc5I8ht1E=;
 b=qKcpEfPIQfxGcqC48R4duiXeLWCYUQWg+gjpOtmwwEFUkzZcUv/ivl0EfM+jd7x4L5RhvzGXdut/VS+LsSfwUfAQ1I39jSpnMDKNqQAUCsR1X2QhgbT0cLQQ+VbE7YzQo8tU2mEJSPF75B8QCxNRyZQRfTmBac5Af5IyGFX/3Y0Ehsh8Ukpbtk2kuWGuIsA+3Kt8x/FQ3nHAiF7KneNCA3tuEiqeOdLKtW0AWslGmiSM4OHqeWNQ1d86NGNhMazFahdOR7T4ct95JBvNkD3G2SEETHDQuqqn4ows/7esB3J3lSZQWXN/5d8ah1F2i6mUVa6N02J9FwpVHcr/t6uIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6h+Ci6ZeSApgdoe8JezmVOYOetsZnnVxqSc5I8ht1E=;
 b=LjdPHO99gkbja5iaJh8sWuqCMws2WKzko8UZcGujIM0cvtSsH/9BgEawgTTo5YM24L42TrTyc5wNA62+r7GmclO3t1ACRyRBkLYpzTER5f7t+jNnZ8/Z3gV734IHk0zQMZzSYwJ2sxeKZeNQdsmyMR8cHOKf0n0mAP+7+Yc6jD+hh12tS4afBUvTbaSAA+KUQK4bQ6Q7BbNvP0HwyXcW/eBL62n6n2dnbaEkZCTN75tgfjNqG9/cYG8GKEX6jOgUOWKFVr6wcFAUsnm7OnUXy5zTQEEAiOn4v7X2mIQPS2RF2Pltj2j2NALkMKA+F56zcpFKZtQYmViGdAVVjeCIpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Fri, 30 Oct
 2026 04:01:24 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 04:01:23 +0000
Date: Fri, 30 Oct 2026 12:01:15 +0800
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
Subject: Re: [PATCH v16 06/18] cxl: Move HDM decoder helpers to built-in code
Message-ID: <auQWe9cuI9_SO9Ex@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-7-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b07d2a-3713-4fd7-0ca1-08df363a766d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261022113327099003|261009223027099003|10067099003|261021123027099003|18002099003|22082099003|261028144727099003|261026140227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	stt75GXwM3qkfOxpU7q+GFv8YBImOvWz5U3ZzosdDeNLJNYNtIBIopGTKSg6YulrO364XFFJ1SPWhMbRzl3m64zPgMplNiQX3CwbL+SDM3awOZa/G95XLBDVAX6SQLwvZnejl+mhJkGId3dUmWB9LM5XiVClKq/IgsSf16w7Z8Op752s5V6XxPyB/17aXIxyTyvIelfVPf9epmGv4XPfVAFiqqg9xMXvAIDw4KFdnq1qk0qLGONHJ5SkMQ4oE/1nFlsyINV0YaBhCFPieny2Nyu0qV9EF4XcdN2oqAXJqT5u4L7HNNXOGspBu+1LwrNk8X5coni8OyLPl3VX2d6ErN28dli1WmA0J7UhNYHxMFzgFHxyI2ZgC4kVticX9z1XwxRiS2lwr+QwNS9T37hvR1w8+f/PAk6lF2sSoNzJsARa6NAFlO2DAJoeRl4ScIoZ0w3WbT0H6obB8ni+IUP2+wxWI4WjifkCN983YUtn93tk1CyO2lg90uKInA9LEguWTFjuJxpW3aTSGC7gy9/aTu5/hrAYid46JesGeyZgyRS9p2IKWTXUkJjHWCknyq7EXuQSF+k98Lpz7qXvyvVXmwRU3tJMec37NFkCPaLpHZLMkwY4SSEYPaeu9oP702PZVlzlBzVO//Em2lrdBaO+08HzME8cfYUpd8JWHN9loEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261022113327099003)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(22082099003)(261028144727099003)(261026140227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?emmSg+EUvNQRflZ4HYildnBroRuel3b0Uy+lo/Y14xOV83NeVQXtRcjIrR+a?=
 =?us-ascii?Q?hASLDM0ZlW+Ba6S55EfR+EEek+9On2IYuNVQeg6xcK/+fdWwwBcpGW7d71ol?=
 =?us-ascii?Q?lPCXWb+GXpbmI/+zdlXwxdwzZubPomQ4NwX9rFvMtitPK62uYXVKcf9EUmtV?=
 =?us-ascii?Q?WV1oj2LoMLGXCsnmCeA6HymNN8xt220iUXDiaaBgyIs6emRfPO/P1vHrdBKC?=
 =?us-ascii?Q?zcRGmoMaBkA7c15O+Ko3IbRg3HcpNeteaVqkBbgL8FJML4QSiDJh6sopXdBo?=
 =?us-ascii?Q?K0NPkBQWk+wOhhi909HQVYy/bGcTMhx+oZeDj/ofZII7Bbrz3EHekExOpX/y?=
 =?us-ascii?Q?QBttgvn/v+PB2s7RwowS3ZVuiC/ikyCDVKLPNK/+9egNx20jo2ksxpysoBjj?=
 =?us-ascii?Q?VrsNRuq+8EBGrtyexrPygtbfjRX8XXqISd7if6bq575k6odxT0zM3ejZLL9B?=
 =?us-ascii?Q?w/ZEq/P+Yp1SQtBejfjSs1D5TPE4vYqC/4o5c3gupDPIwbu8L5HV9rLfknvO?=
 =?us-ascii?Q?53hRaq9+S0naOFV/zacxu+U2RhMtjU9FGfMP/I7nZdDuVvo4IEVz8nSKkGcG?=
 =?us-ascii?Q?dYiruxOCsQgSV8QOZv/tkMRkNzf/kO4rjrvEXi1JP468S4ZM7M85wsqI98lM?=
 =?us-ascii?Q?HOvWVRK59gHxjuZiRnMub9m8vplo+W57Co3qA1F3EUPVxbMTQ/1YYLbHoumm?=
 =?us-ascii?Q?+7W3VbK0sHrEGJy1qfpr5lZ9ikqjEBxp9N/YWsl2qSHCIi1+7O1EFxD4/fuz?=
 =?us-ascii?Q?v+yAdyFxvLspUJomGuSX0g+eKf1j+wnTc1d9MoJ0TpEBc1EbPgtiq5/r+jEj?=
 =?us-ascii?Q?uEAZwBL64Ar7SMflYXbsreV1xiNfSArqXiss4naUvT9lAoDoUOhX2jDDlbsf?=
 =?us-ascii?Q?Jht3OpyrJ9Nsxd04dlE5+KmEEDOEFEB57R+OeHzzKdQDunAFqVXCM8e6Eskb?=
 =?us-ascii?Q?C0hprfXX6ATNa7FPqsMw4ZFI/OqndV32F7ceNeGp4x8pDw7Lk1NsMmdj7Kpn?=
 =?us-ascii?Q?TNopzd8O3jFHnO2I3gM3O1LWJFmPkeYupW34EoH6dGX3aD+cwPuVCr3cnJ52?=
 =?us-ascii?Q?pryr/5Q5w8MX3v5QcU8NE2jTaPe7f8uX411RUuicdxXJXTb1574WlMdMguBS?=
 =?us-ascii?Q?Lvlxfgi3Rz0aom7C1ksuonw+nIqWS+Q/jHIA6gvLpodCIojA7GE975HEnVPM?=
 =?us-ascii?Q?GNNVFKTZWfU2XJWEo72pQqzuJcNIZYseZTMRno6tRC4GHp27wKLnWMEYIAAr?=
 =?us-ascii?Q?NxjIyyFviPqSR1id3du2hYCYIXZ+hCdUg1J0BKyY1XeVnZm8RbU8gzrI9f5F?=
 =?us-ascii?Q?UlEG9GCv4IKK0Yxrysg6Xg9+wp0fF9H4/4W8HDJ6EnZGa5IxTlLvgAC+0q5w?=
 =?us-ascii?Q?epjsDo+tWr5ZI0gs8ZviS5mZS2cozdS1O34np/Y5zhdbVaoFOoNNVjiZ/WMd?=
 =?us-ascii?Q?dO+fJN70slv7cPv0jY0mBX3IUjY3Z8yu1FdL6OB2873Na9qbWjU6lDe953PA?=
 =?us-ascii?Q?Hi+yEsKgv4tAOHAPTNDnKTuVwq7H5HX3CbsHkbyDR/juLF3nBJRXCDEL4YAK?=
 =?us-ascii?Q?2UYug/e9GfC3kLppe2802pcxaxnWixZ9ViDD+ukwm/fKPAWz2xV+0dfLhgdr?=
 =?us-ascii?Q?HoojaNChXUZqc3qOo0+fgsOZKuTwEKcvA51iBq5+ZrlaXpmEx5N6m7eTtOts?=
 =?us-ascii?Q?PtGjdOx0x9rgRPPVZW1Eyf5HQ934v9n01L8+nmo0Y1HtFu9ne1lncnP/SmQD?=
 =?us-ascii?Q?MzKWCOMlwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b07d2a-3713-4fd7-0ca1-08df363a766d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 04:01:23.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urIqVHA9Ck8xgqRvTSHzrBhozyigftolQDwi5s4UbajPJZwqqLpAE8o2huMjcgZa2yQL3ypw9VstF6Vf88Y93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902

On Thu, Oct 29, 2026 at 02:56:51PM +0800, Srirangan Madhavan wrote:
> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
> 
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
> 
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>
 
> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=e0b476ea99567fb5aa416eac0cf61bca20724880
> ---
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/hdm.c      | 102 +------------------------------
>  drivers/cxl/core/hdm_regs.c | 118 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 100 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm_regs.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..6703c1729396 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index af445f1b9798..2c373dfbc070 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -708,35 +708,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u16 eig;
> -	u8 eiw;
> -
> -	/*
> -	 * Input validation ensures these warns never fire, but otherwise
> -	 * suppress unititalized variable usage warnings.
> -	 */
> -	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> -		      "invalid interleave_ways: %d\n", config->interleave_ways))
> -		return;
> -	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      config->interleave_granularity))
> -		return;
> -
> -	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> -	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> -	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> -}
> -
> -static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> -{
> -	u32p_replace_bits(ctrl,
> -			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> -			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> -}
> -
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  {
>  	struct cxl_dport **t = &cxlsd->target[0];
> @@ -759,77 +730,6 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>  		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
>  
> -/*
> - * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> - * committed or error within 10ms, but just be generous with 20ms to account for
> - * clock skew and other marginal behavior
> - */
> -#define COMMIT_TIMEOUT_MS 20
> -int cxld_await_commit(void __iomem *hdm, int id)
> -{
> -	u32 ctrl;
> -	int i;
> -
> -	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> -			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> -			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -			return -EIO;
> -		}
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return 0;
> -		fsleep(1000);
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static u32 cxl_hdm_write_range(void __iomem *hdm,
> -			       const struct cxl_decoder_config *config)
> -{
> -	u64 size = range_len(&config->hpa_range);
> -	u64 base = config->hpa_range.start;
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -	cxld_set_interleave(config, &ctrl);
> -	cxld_set_type(config, &ctrl);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -	return ctrl;
> -}
> -
> -void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> -			       void __iomem *hdm)
> -{
> -	int id = settings->config.id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> -	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> -	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
> -void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> -			     u64 targets, void __iomem *hdm)
> -{
> -	int id = config->id;
> -	u32 ctrl;
> -
> -	lockdep_assert_held(&cxl_rwsem.dpa);
> -	ctrl = cxl_hdm_write_range(hdm, config);
> -	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> -	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> -}
> -
>  static void
>  cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
>  			      struct cxl_endpoint_decoder_settings *settings)
> @@ -846,6 +746,8 @@ static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
>  {
>  	struct cxl_endpoint_decoder_settings settings;
>  
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
>  	if (is_switch_decoder(&cxld->dev)) {
>  		struct cxl_switch_decoder *cxlsd =
>  			to_cxl_switch_decoder(&cxld->dev);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> new file mode 100644
> index 000000000000..53d2f236e49c
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/delay.h>
> +#include <linux/bug.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +#include <cxl/hdm.h>
> +
> +#include "cxl.h"
> +#include "core.h"
> +
> +/*
> + * HDM decoder register helpers are built in whenever CXL_BUS is enabled,
> + * including when cxl_core is modular. Callers provide any required locking.
> + */
> +
> +static void cxld_set_interleave(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u16 eig;
> +	u8 eiw;
> +
> +	/*
> +	 * Input validation ensures these warns never fire, but otherwise
> +	 * suppress unititalized variable usage warnings.
> +	 */
> +	if (WARN_ONCE(ways_to_eiw(config->interleave_ways, &eiw),
> +		      "invalid interleave_ways: %d\n", config->interleave_ways))
> +		return;
> +	if (WARN_ONCE(granularity_to_eig(config->interleave_granularity, &eig),
> +		      "invalid interleave_granularity: %d\n",
> +		      config->interleave_granularity))
> +		return;
> +
> +	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> +	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +}
> +
> +static void cxld_set_type(const struct cxl_decoder_config *config, u32 *ctrl)
> +{
> +	u32p_replace_bits(ctrl,
> +			  !!(config->target_type == CXL_DECODER_HOSTONLYMEM),
> +			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +}
> +
> +/*
> + * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
> + * committed or error within 10ms, but just be generous with 20ms to account for
> + * clock skew and other marginal behavior
> + */
> +#define COMMIT_TIMEOUT_MS 20
> +int cxld_await_commit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
> +
> +static u32 cxl_hdm_write_range(void __iomem *hdm,
> +			       const struct cxl_decoder_config *config)
> +{
> +	u64 size = range_len(&config->hpa_range);
> +	u64 base = config->hpa_range.start;
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	cxld_set_interleave(config, &ctrl);
> +	cxld_set_type(config, &ctrl);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	return ctrl;
> +}
> +
> +void cxl_commit_start_endpoint(const struct cxl_endpoint_decoder_settings *settings,
> +			       void __iomem *hdm)
> +{
> +	int id = settings->config.id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, &settings->config);
> +	writel(upper_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(settings->skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_endpoint, "cxl_core");
> +
> +void cxl_commit_start_switch(const struct cxl_decoder_config *config,
> +			     u64 targets, void __iomem *hdm)
> +{
> +	int id = config->id;
> +	u32 ctrl;
> +
> +	ctrl = cxl_hdm_write_range(hdm, config);
> +	writel(upper_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(lower_32_bits(targets), hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
> -- 
> 2.43.0
> 
