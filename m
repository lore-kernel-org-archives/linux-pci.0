Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792600524;
	b=V+BdDXr9nHvdcaEYm9mcmK2Mm0d1zERJYQGtWsaPDw8drtAhfzpiZa0gputCMTCz4SLb
	 fJYi+5RN+hnoMo3IBzEr5NbIVCMV/0WOWFf+nN8g4K0urdWacG6ibPI+RO8qZLdv/0ja0
	 sOFkqM9hkBmCeAKbQgBRLXJD2hmAYWW3C0PriIJNRB2TJhobBc5EHdIKijB67ciwY7p6I
	 iBu4RWguNpFR39A5AuzCoYgD3R+MHAELDWXM5CEgnH2c9bsfN1eBNfr8zBrrmh3U54NyE
	 GWV7r0bI58/152K+bAg5mjFWfPVKs1/UD1+KfLmlq2tYM/Kkj7WPmTN2Ijs7Ks+Id6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600524;
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
	bh=baT3fx1zWFhGADwluVTJwZqqAXqbAK+8aCENA+fw7vA=;
	b=fgsNgvN5VLdmi4WKLYVv4g1sKfUnAERySG/rMy/7HKKPxFyJEBgvPSVantJIFz6bVka/
	 6F6iO4N8deKXO0Q4PWQa+4MKrhn5jch7ig6Q1Y+ZwpeqVR8FSZM3FIStrjmzJGqrZ6DNE
	 xuKY/u+GjuYPxrptZDrGehJhffCPvHjXFnLgE5BbzZIs6dkw+TC9E6fb7cb02pIvuWPQh
	 brFTkV6ZLV08ptgkNXgBOsOVVqm/B4lZmc3mza7JG7ebUog+VgJtsB9YYnE/t8ntK7Eou
	 ycTnVvZxuyYkbH6yVzn3rMx2eOIkPBS4DNE8Z1M1IlV6HzFMwGhiS7Equ0U4Vp9Z59g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=O+2Kh0pG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.113
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021113.outbound.protection.outlook.com [40.107.74.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32001606A31A;
	Wed, 21 Oct 2026 16:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32001606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=O+2Kh0pG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCxr6g74ok5T0V8NTQTCCOMgr32ho8lGgV+XhRnsyCFyNaRWM4KUXaluzDB3K6rOSsHM2U0sPRbBbIRuEGccFNoKV3UuwQab2bnvkcljoko7ciiku+GuT/6BeEep7VQBKVzgtNhTZdj56oUFhiR+8z1BS0E9ofUimoAqRfb9xleQAZW9LGzfuYHbdjrGm59sE5Q0Ixftk+p2AGxwq1zP4uKvpo+3P7S+ANHxn2bETNXDrNRC/HZ+w8tNDfe0wZLt9POZKiv2g+peGMx8pRjg0tKeBplCpeq0D+q59qH6JhWOffJkhuTilpONb8keepV1amP7SMRHrW4Jl8g9689f+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baT3fx1zWFhGADwluVTJwZqqAXqbAK+8aCENA+fw7vA=;
 b=KgPVMYWIBlWrRkOhfyJM3qGCfBnBZZdwv2MQwqIVACgJ4heb/SgBuhThCOWOvbpuFu5WqFk2A+Pw4PpAkRduVecstF64poekrBgi5KDXnAOhHXaKKTzMJJ3rg/D45PzqQRph2TOQswKUrKNATHlOc6TaVqsn0TZCkKDwPlMdZUdAyo/7j/2CJ2zsQqdzKwzC4ArcUCruGUVdnLxKJMTiqgLSD8XriCSBtkY9n9U1Mh36XIxbuAd1AYoesoeV/qMvAbEIbXndhYdi38pquUv+1FKXScItR25phnmilZFHPf+HyISvHA80mqu1ZKcmMVIbh2UOJMlNQ07Hk/1kVy2A5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baT3fx1zWFhGADwluVTJwZqqAXqbAK+8aCENA+fw7vA=;
 b=O+2Kh0pGCw2eNLbB5P2o1UDnpfeNCTvvdZXi/2ChdnYm6Nla0gFpaBL6oFJ7k44ftRKAiiqEEvrioX7pg+VRdMZfATYGQII0ALzjMef8mVGR9xYFJfCOewBGhbcOgtzMt7iwhCMT4hB2yrN9N9mDU9QzCN9wOREn0X9ZpeddDA0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB4273.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 16:35:19 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 16:35:19 +0000
Date: Thu, 22 Oct 2026 01:35:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <fmnltbvuo6nm2sddmoqmpb6ema345rdqgavhf6xhrggnj7twpa@nlwyqy7zjppk>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-7-den@valinux.co.jp>
 <atjfwC1LTX3L6ncV@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atjfwC1LTX3L6ncV@SMW015318>
X-ClientProxiedBy: TY4P301CA0122.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7fc6b-7215-4fdd-9d22-08df2f914b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3pIF3W1cu3psJeYWnr1HsHBClLVZwxBUrnLZOo2NudM5qsZI5eOCiMZKYr25KhY9Mr023cvgHMc8Oyiye72h39xfL3AE6Kc13vT3ph0fCQy8TBpV/3HYkr/K5HofCcP4zLNrXcJbAoOkUhM2dlf5PY0/1ojsgyQ42ufnAzlSXkiXstssB9o7RWDiWBxMFe9hgvac/781B3vDrn8F7pvRhlPQ/9aL6+Ka2bMQqkJHVFs2Fqj8uSF4j93VYE9nDpom3q36P7GtBOfvqf01LX5ZWE6TzY1AAnzsLapVORfcK3xJJxl2pEUwNYoyqicdaAG5nEOCSMT7k6fz01VeDBp1Mw0H36KNPnIxUI13X1pO5GaUNgWzltVRyGqMgCXJo2Jku4vaPKQBQ/kq0bsJHTxed5mG+dNMP5D2mMOaDpKRAjJh5b5SpMBhrWkk7ACeFb8cUyqFo+wZYdvjyDZ9752F8d/Rd493OziICzml5MsLMA61i4RCPVBUIMEdEHwJ1viDA7jy+iyHUf9Yo/P98pP09JJkZSX9oNCwEKzJRH9Dw+zH3jFYLswScwDilRw3GTMrBHbYgYDkdlZZrLZQDLTJ+bpscHBsGcUbPfrTTxM46LouheWaJZ7hjIO0bkoVm5uERJo2UKKj9kYKEJaN3DIWl6p+7Vwv8jCbBz6p+EWEWlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Q44IFurTBEMRjUZ1pUwlDnAppPNqBwaly+s5e691WoPexBK4SQB3PRU8e1y?=
 =?us-ascii?Q?QclJlK67kWgwf5x/E8GaOLq07eFwB0VoLRJr9fjYIAj1dFeoJ2WgHUqlW1zT?=
 =?us-ascii?Q?ynlTwfASjuicT+D1Q4WAuX4KdlgncY+3sHqUobIHzYnhhiMUZRzDeyQwQXRC?=
 =?us-ascii?Q?FJsNWRzGnlpnSEuqJyyN7WimuW2AJdV7v3QlH3jbnZR0eMwrfBVB49RkSTh9?=
 =?us-ascii?Q?wMnoiRrThHvMo1Dlcbd4fo/MWFYOSMyUbS3rej0DrTN+FllKv5uhmQn23Qjc?=
 =?us-ascii?Q?hqEoZlnksxoAxyUf0bfl3cxqUgMtVXEAjBOBPrZl2NMU10zCobEhoxM7akkL?=
 =?us-ascii?Q?v+9rrS8jkFl4lWqjBfGXYTyj0YmFCkArFUO+eBoolQqcM34EwZux+6VR8Zwx?=
 =?us-ascii?Q?ZNhC5O1yEVRpTss4b2qHuC4z9wUEAFj2UI/jrkc9oIyfiBnpvhxCywAzrO1h?=
 =?us-ascii?Q?m39xZvFd3wAn7WGZb380bSay65IoeM+jT96mLNulExlPzEicD2uL6GyRQcyx?=
 =?us-ascii?Q?fuCUcDWoCnDbE4nevowQ9xBgZmYppshS+TGmGuc/PEbIKrjfk8/JKUNHAdmG?=
 =?us-ascii?Q?Jqo5/kbzwpCaXJq5KwFReQDiFRF0jdOHRL0MIgYU2LnhDGVsxGakZ/6GNPV1?=
 =?us-ascii?Q?HSNycvM1PIsOx6Mo/o/efvCgDivcVeulGc1jpVlt+NLstbN6iuirzh/0PJLY?=
 =?us-ascii?Q?HNxX1Wqgx32g5VERwMpTru07iulaW+mz9e8XGDf6f/+k5QcZFipSO1XUEAms?=
 =?us-ascii?Q?EF/rtCgNcuywYjG/C420Nv9O9K0lgNltM4ayxLWgGHpHQh4ZASESlkG37ZNK?=
 =?us-ascii?Q?OSOuFpo720qtPnGTScfZr8R0kbUFxShB5jVDXqTcinPzffGvp79NBV/EGQbU?=
 =?us-ascii?Q?chc+ivtz45xJa7hn3/MdCeR8zrkH1HeSnfZ5E5xUjUl3adaO8yWsnKfsVOV/?=
 =?us-ascii?Q?vJOn05ES5VxccEQIkQ2l+Eh7tfAmWHVZGCNZwwNH9uD9OipHSmln0LMIzFwL?=
 =?us-ascii?Q?VLQdSj44M+LCvqU06aV8rbxSnc4TC2HnppzL8U/mAPrZLBSKAPA5SAGRtXDd?=
 =?us-ascii?Q?xuUu+h4RowGVb6TJbQYqnbOLTsN3gwmQg2pT3YOrDGTFcGfEz2t3ydX6UpSk?=
 =?us-ascii?Q?pT/uUkR84CdV/sUnpyqrjLW4s/RVYPLf1vPIPtjAib7wmInYtP4WrTW1X+jO?=
 =?us-ascii?Q?Ozmz3lpMRqjpWCCr/ebpb6NHK7NZ/Ik49psKDXYgtR69ZdV4gAvyQcMyWW+V?=
 =?us-ascii?Q?dMSbAKIkeCn2/Mp4crtqxb7lIS4Ar3nFiU3/AKT2uv+kfXc04GthHDLuk3YR?=
 =?us-ascii?Q?HKTfIZcKkwgNkbOLDddSKFd33cA0c/KIVganXRyMAm8hZWXQB7P6GB9G72JH?=
 =?us-ascii?Q?jrvpKjeSTUHyWaCPbhu+98zF9BuSgXp7QFDEc0RPgo1a3Bgx8DYDJ7bGHE01?=
 =?us-ascii?Q?znHvohb17iyMfmYNWtI8CEqHsB58/JWln86HxnHEizaDjX3DF+Nt6NbJxeth?=
 =?us-ascii?Q?5rEg76ToDN41rcbx5o9NfEHFZbgvetQBzBhHaV49CmTcimJMjh2Gt4He1Ayp?=
 =?us-ascii?Q?aIlKE59DTTET+1zkGwbiIRb38m3nhag4K1ntq6OsGLi3uWeNZv8TNLGrdlbs?=
 =?us-ascii?Q?zmBaWTg+lgdwTsAPCElrYGPLevsNRCVmpxKwzRGG5PzbKKFa0+AO4oUoZA3d?=
 =?us-ascii?Q?F3Nvj8Su3xP1Fc/xACzyrKGGbxt3ardWJZeIewHjNorJPH+7H/ueY1BOIp+5?=
 =?us-ascii?Q?5CaK4DW8v3GpFCEmDzBKnaGwAOV6cGPZ5jXIvXEH8Y2ndVC13pH3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7fc6b-7215-4fdd-9d22-08df2f914b9a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:35:19.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY4rKQnhD3b5GnCJSWcpUVG8v1ox/NU1x89mVqNpS27IdFdtY2Idg67hxYtX4ZCSbjncP7o7mmfSg/lndZnY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4273

On Wed, Oct 21, 2026 at 10:52:32AM -0500, Frank Li wrote:
> On Wed, Oct 21, 2026 at 01:22:25PM +0900, Koichiro Den wrote:
> > Some endpoint configurations have no spare BAR for DMA resources. Allow
> > dma_bar to select an MW BAR and place the DMA ranges after that MW.
> >
> > DMA submaps have fixed BAR offsets, so a shared MW translation must
> > cover its configured size. Report that size as the translation alignment
> > and require it to be a power of two.
> >
> > Older hosts treat the whole BAR as an MW. Require the host to advertise
> > MW/DMA boundary support in LINK_UP before enabling a shared-BAR link.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v6:
> >   - Split out the host-side changes. (Frank)
> >   - Require MW/DMA BAR boundary support in LINK_UP for shared BARs.
> >
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 154 ++++++++++++++----
> >  include/linux/pci-epf-ntb.h                   |   3 +
> >  2 files changed, 122 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ac83af54122f..721cd841a1dd 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -84,12 +84,13 @@ enum epf_irq_slot {
> >  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
> >
> >  struct epf_ntb_dma {
> > +	struct mutex lock; /* Serialize DMA submap and MW updates */
> >  	struct epf_ntb_dma_ctrl ctrl;
> >  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> >  	void *bar_scratch;
> >  	dma_addr_t bar_scratch_phys;
> >  	size_t bar_scratch_size;
> > -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> > +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
> >  	struct pci_epf_bar_submap *reg_submap;
> >  	unsigned int num_submap;
> >  	u16 rd_ch_cnt;
> > @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> >  	return false;
> >  }
> >
> > +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ntb->num_mws; i++)
> > +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> > +			return ntb->mws_size[i];
> > +
> > +	return 0;
> > +}
> > +
> > +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> > +{
> > +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> > +}
> > +
> >  struct epf_ntb_dma_filter {
> >  	struct device *dev;
> >  	int chan_id;
> > @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  	unsigned int i;
> >  	size_t align;
> >  	u32 next = 0;
> > +	u64 offset;
> >  	int ret;
> >
> >  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> > @@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  	if (!is_power_of_2(align))
> >  		return -EINVAL;
> >
> > -	if (epf_ntb_is_bar_used(ntb, barno) ||
> > -	    pci_epc_get_next_free_bar(features, barno) != barno)
> > +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> > +	    barno == ntb->epf_ntb_bar[BAR_DB])
> > +		return -EINVAL;
> > +
> > +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> > +	if (!offset &&
> > +	    (epf_ntb_is_bar_used(ntb, barno) ||
> > +	     pci_epc_get_next_free_bar(features, barno) != barno))
> > +		return -EINVAL;
> > +	if (offset > U32_MAX)
> > +		return -EOVERFLOW;
> > +	if (offset && !is_power_of_2(offset))
> >  		return -EINVAL;
> > +	dma->ctrl.submap.offset = offset;
> > +	next = offset;
> > +	if (next) {
> > +		/*
> > +		 * submap[0] covers the MW prefix. Keep its temporary
> > +		 * target at address 0 until the MW translation is
> > +		 * installed.
> > +		 */
> > +		dma->submap[0].size = next;
> > +		dma->num_submap = 1;
> > +	}
> >
> >  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> >  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> > @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  		chan->desc_addr_lo = lower_32_bits(dma_addr);
> >  		chan->desc_addr_hi = upper_32_bits(dma_addr);
> >  	}
> > -	dma->ctrl.submap.size = next;
> > +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
> >
> >  	dma_dev = ntb->epf->epc->dev.parent;
> >  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> > @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> >  	if (!dma)
> >  		return -ENOMEM;
> >
> > +	mutex_init(&dma->lock);
> > +
> >  	switch (ctrl->u.dma_ctrl.reg_layout) {
> >  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> >  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> > @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> >  		return -EOPNOTSUPP;
> >
> >  	barno = ntb->epf_ntb_bar[BAR_DMA];
> > -	mapped_size = dma->ctrl.submap.size;
> > +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
> >  	/*
> >  	 * Submaps cannot be installed until the host assigns the BAR address.
> >  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> > @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> >  	memset(bar, 0, sizeof(*bar));
> >  }
> >
> > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> > +				      const dma_addr_t *mw_addr)
> >  {
> >  	struct pci_epf_bar_submap *old_submap;
> >  	struct epf_ntb_dma *dma = ntb->dma;
> >  	unsigned int old_num_submap;
> >  	struct pci_epf_bar *bar;
> > +	dma_addr_t old_mw_addr;
> >  	int restore, ret;
> > -
> > -	if (!dma)
> > -		return 0;
> > +	lockdep_assert_held(&dma->lock);
> >
> >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> >
> >  	old_submap = bar->submap;
> >  	old_num_submap = bar->num_submap;
> > +	if (mw_addr) {
> > +		old_mw_addr = dma->submap[0].phys_addr;
> > +		dma->submap[0].phys_addr = *mw_addr;
> > +	}
> >  	bar->submap = dma->submap;
> >  	bar->num_submap = dma->num_submap;
> >
> > @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  		return 0;
> >
> >  	/* A failed dynamic update may have already removed the old mapping. */
> > +	if (mw_addr)
> > +		dma->submap[0].phys_addr = old_mw_addr;
> >  	bar->submap = old_submap;
> >  	bar->num_submap = old_num_submap;
> >  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  	return ret;
> >  }
> >
> > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +{
> > +	struct epf_ntb_dma *dma = ntb->dma;
> > +
> > +	if (!dma)
> > +		return 0;
> > +
> > +	guard(mutex)(&dma->lock);
> > +
> > +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> > +}
> > +
> >  /**
> >   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> >   *   to access the memory window of HOST
> > @@ -780,6 +839,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  					     EPF_NTB_COMMAND_STATUS_OK;
> >  		break;
> >  	case EPF_NTB_COMMAND_LINK_UP:
> > +		if (ntb->dma && ntb->dma->ctrl.submap.offset &&
> > +		    !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED)) {
> > +			epf_ntb_set_link_enabled(ntb, false);
> > +			dev_err(dev, "Host does not support MW/DMA BAR sharing\n");
> > +			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
> 
> suppose it should be fallback to old method?
> EPF_NTB_LINK_UP_DMA_MW_SUPPORTED is new feature.

It's possible (by using the whole BAR as an MW), but I personally think the
extra complexity would not really be worthwhile for this case.

If a "New" endpoint is paired with an "Old" host whose kernel cannot be
upgraded, the DMA feature cannot be used anyway. For that setup, I think
disabling DMA export with dma_bar = -1 (the default) and rebinding the endpoint
would be sufficient, with host re-enumeration as needed.

I can respin to add automatic fallback if you think it is necessary. WDYT?

Thanks for the review.
Koichiro

> 
> Frank
> 
> > +			break;
> > +		}
> >  		ret = epf_ntb_set_link_enabled(ntb, true);
> >  		if (ret < 0)
> >  			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
> > @@ -1269,6 +1335,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >   */
> >  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  {
> > +	bool shared;
> >  	int ret = 0;
> >  	int i;
> >  	u64 size;
> > @@ -1278,22 +1345,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  	for (i = 0; i < ntb->num_mws; i++) {
> >  		size = ntb->mws_size[i];
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > -
> > -		ntb->epf->bar[barno].barno = barno;
> > -		ntb->epf->bar[barno].size = size;
> > -		ntb->epf->bar[barno].addr = NULL;
> > -		ntb->epf->bar[barno].phys_addr = 0;
> > -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> > -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> > -
> > -		ret = pci_epc_set_bar(ntb->epf->epc,
> > -				      ntb->epf->func_no,
> > -				      ntb->epf->vfunc_no,
> > -				      &ntb->epf->bar[barno]);
> > -		if (ret) {
> > -			dev_err(dev, "MW set failed\n");
> > -			goto err_alloc_mem;
> > +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> > +
> > +		if (!shared) {
> > +			ntb->epf->bar[barno].barno = barno;
> > +			ntb->epf->bar[barno].size = size;
> > +			ntb->epf->bar[barno].addr = NULL;
> > +			ntb->epf->bar[barno].phys_addr = 0;
> > +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> > +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> > +
> > +			ret = pci_epc_set_bar(ntb->epf->epc,
> > +					      ntb->epf->func_no,
> > +					      ntb->epf->vfunc_no,
> > +					      &ntb->epf->bar[barno]);
> > +			if (ret) {
> > +				dev_err(dev, "MW set failed\n");
> > +				goto err_alloc_mem;
> > +			}
> >  		}
> >
> >  		/* Allocate EPC outbound memory windows to vpci vntb device */
> > @@ -1310,10 +1380,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  	return ret;
> >
> >  err_set_bar:
> > -	pci_epc_clear_bar(ntb->epf->epc,
> > -			  ntb->epf->func_no,
> > -			  ntb->epf->vfunc_no,
> > -			  &ntb->epf->bar[barno]);
> > +	if (!shared)
> > +		pci_epc_clear_bar(ntb->epf->epc,
> > +				  ntb->epf->func_no,
> > +				  ntb->epf->vfunc_no,
> > +				  &ntb->epf->bar[barno]);
> >  err_alloc_mem:
> >  	epf_ntb_mw_bar_clear(ntb, i);
> >  	return ret;
> > @@ -1331,10 +1402,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
> >
> >  	for (i = 0; i < num_mws; i++) {
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > -		pci_epc_clear_bar(ntb->epf->epc,
> > -				  ntb->epf->func_no,
> > -				  ntb->epf->vfunc_no,
> > -				  &ntb->epf->bar[barno]);
> > +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> > +			pci_epc_clear_bar(ntb->epf->epc,
> > +					  ntb->epf->func_no,
> > +					  ntb->epf->vfunc_no,
> > +					  &ntb->epf->bar[barno]);
> >
> >  		pci_epc_mem_free_addr(ntb->epf->epc,
> >  				      ntb->vpci_mw_phy[i],
> > @@ -1936,6 +2008,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	dev = &ndev->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> > +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> > +		/* DMA submaps start after the configured MW size. */
> > +		if (size != ntb->mws_size[idx])
> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&ntb->dma->lock);
> > +
> > +		return epf_ntb_dma_set_bar_locked(ntb, &addr);
> > +	}
> > +
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> > @@ -2134,15 +2216,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
> >  			resource_size_t *size_max)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > +	u64 size = ntb->mws_size[idx];
> >
> >  	if (addr_align)
> >  		*addr_align = SZ_4K;
> >
> >  	if (size_align)
> > -		*size_align = 1;
> > +		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
> >
> >  	if (size_max)
> > -		*size_max = ntb->mws_size[idx];
> > +		*size_max = size;
> >
> >  	return 0;
> >  }
> > diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
> > index 5cc0f0badae0..8131ed4c6ac9 100644
> > --- a/include/linux/pci-epf-ntb.h
> > +++ b/include/linux/pci-epf-ntb.h
> > @@ -24,6 +24,9 @@
> >  #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
> >  #define EPF_NTB_MSIX_ENABLE			BIT(16)
> >
> > +/* LINK_UP argument: the host honors the MW/DMA BAR boundary. */
> > +#define EPF_NTB_LINK_UP_DMA_MW_SUPPORTED		BIT(0)
> > +
> >  #define EPF_NTB_COMMAND_STATUS_OK		1
> >  #define EPF_NTB_COMMAND_STATUS_ERROR		2
> >
> > --
> > 2.54.0
> >
