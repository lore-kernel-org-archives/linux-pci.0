Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7127A91D;
	Mon, 16 Mar 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671772; cv=fail; b=frSj6P3dUrLLwvivbsHkyo8YWj3bdkrJ9kVjEN7MGVKWrGaXkjmBAEw4MkGReOjTHfXKhaEvsnolft+diM2MRzZkQ848i8lmjjKYeD8GC1Lo6zGxjApriZmrFi7LPZEIlQehJNcH2lDUdmVswMQiAayl3sInYZ2ZEIz2v5iuGeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671772; c=relaxed/simple;
	bh=BZnmpT2tbCI09LTUwoZhiffNPdBYfcA/pdQBHqlbIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+otHUo5pXcQ70I9CXZ/+Sksy7H4NQz5ucmuEEUtdjxFFYpmLEOQfUQD+eWhY0EnjIzHih+VUcZacDCAF6AHV6r0sYjbc05uzkRoHqtTb9NNAYkd2/QO19wIRD+nO7yvXZUPzT2PjKHBehlSpiQH1Ksbrz3xo/43Vtd5iFKdLW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FUqlmJPV; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FUqlmJPV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2EtGi/kPvfQK6ZxGuG3PYRswyitZU1FLbELmr0UOnAjsbV9eCQIoElyE/xrHWVPVL3BTe3hWOR/2OmIUku/A3s0ZZ5cxcuFsP1ApbNpS6PqRRSFiqNXSN4sX3jdKC3Gw2xU9awfNRclMeHHSHrxaeU/e/tGlQFfaKqpoeYAXUdX63jSgCYsM2SJ+4EebBAb19W9vsnoetxz2Rxf+XAj0lfrWOTGvc1v2qhfpaVYY0vp3C0/0usdcSXeaEeXKZDRqMaa/uMZfjtD1Yam3mmdjqQCQr1K4t5cGflATVKyLOXMQnXbVS9MCn0L/yBkcFbFMBwyoVPBUUSb6rcKVJ63ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5WHzL/mIZWxnkxeTxswzp1balS2Ycah/6jCRZF2IEg=;
 b=n0Invc++HN6Jq7sruuL7l05D6CgLHZGxkRgiVs+io5WMdcdt10grq9Ur6PNpJuMAOvA4c000I5axvn8uI1VZuuCMb6ml5X2LqqLiFmQL7HVMCy7DDhwgXUy8l8jcpVi0nW+QymuA3t6OO8F6HjHaCO74+Nq8xPkSamnx37buFoNpsCrsWZ+dp03ag4sldfE8A3IZx5v670ijgtxno9p+5V6ZHhk+luxCvHpV3JhgqPbUe1sRG1uLyDR0rALr/RSBvpoavYz00pIfVXqZeUPBwpUv4j2ihbuNE/LCvej3Kj1jbnmBhpSAmDdObKmiykDP+HMNA0L7rv013PnmKZWtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5WHzL/mIZWxnkxeTxswzp1balS2Ycah/6jCRZF2IEg=;
 b=FUqlmJPVXCwpjadGgPs3F7JujcQGlBfX1+06kQC4yIu2pGGrfXyxI/hJzy15yzcY1kpi0a0PDQ+opj+ddFz/wXo1WBSfAjBfV+uaD2SYx0m2IEVL3AE3rVRou8PCj/Ucf3DJ5kEaXa6J7NzDgKeO149/juPHqVByiu0mkvGl71E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2101.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:36:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 14:36:07 +0000
Date: Mon, 16 Mar 2026 23:36:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
	Christian Bruel <christian.bruel@foss.st.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <6rpfgqvrswp6zxhb4zdzkqvqzwk4ipp7zyt2wqyj2zj4w2bsri@szdiqpdpmt2b>
References: <20260316140225.1481658-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316140225.1481658-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P301CA0095.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba8e066-6405-4ea4-7700-08de83695c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s3CaM1XZ8Tybu1UAqQsyCkAz9DdggygVnmwIF5EeELCrlMmSq10J2spdedS0ahGkelC9CeK5Cw/ihwVf9LI1u6xIv8VG+ygkc+buz89j/48QJXfCPxdSoKDERqcFNrbbyjepCUeDUQmxEcuYTpzO4MtMiZzG6H85/sXEK4mGHz/uPj9CX/GehTJIQP+4JM1jvuyLaQdxeJLEcRMJxEnpdpZg5vncxRLY93Rw8cAKa0/gJTefDY4bf4Qp290hjs6tH2O+1xrXReBADDBKg50Bfs7AYOpMfpaX7IdUax0WWlD+VB3syeLSI/NS3UtpH7H5F0bsLedzQMQjrSONajf9gnslCojxEdAWbdK4oL+AD6xoyqOEqGLgUytTAUwengDh20DQiChkb1w3iCV5xaXINx4jIdYYTmEWazOIFy81IfUFybiNOLG4u4Uysloa/liStvUURg7W203KCmNmQSQ1ThdXAntIVeYt+w0TNdMR8Lupz2O+hrQ2OiwduEw7niAxaI5OfEO0k1SBtOWGQtEjZOCyNTxkdH+S68eCqcNsBH7Su/Z8AeoMDLOwKGQPGKBvHRyfwNsRNwXwevkBwnUpHtzzRGdwhQrQau8dKr2gKyCMU2bB+cTrDyG4d5Qr7VGECdaucMwPLZecZTHsyMsNg+LMU9Y4jK3egaeOS/yTVB2TRVoSbc56SA8F5oo8Xv9Wm7pmzTKoUL51WWNrb8HzKks/XHczWtKBslMp34dyfkmidElAR/7cqD/fk2r2vL8JqF1YRJsudDFnu2qFxZ5lP7s84kRtHc7ykwZ+op4Govw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X86nYjLb6+cwMfk5/TGWDTBYrFczUBoosjtK8lgq57UcPseL4TBTxnN5lRSS?=
 =?us-ascii?Q?vkZC3wKMDrOIhYU8dikhnnNa4EiqeRryosGiYMtSOeZRpa0ciu+5U5QYmeQD?=
 =?us-ascii?Q?2uiIUJ6ma/qdmCkfwO+gWe/AaG4RPMiJVUVTjTTf/KxBA84t39TjNDM+iKvv?=
 =?us-ascii?Q?pdYMx0AzzGa8ELj7o9qN1LB9pWco4s4szsIpNjpuRKQkX37hne7lMSqSyRcS?=
 =?us-ascii?Q?GeA6hJerRtnFYB8BnFMijtlB1fuKb7XxO6GLjIi4bLeHZ2wFyicXybeX0hQn?=
 =?us-ascii?Q?cTywX2aPgzlLi7RY8vj1xKSUwOzY6m/n0+9t/MtR/LUCar/cHUiWTMrmgmkb?=
 =?us-ascii?Q?hgOFRorjWAsmk5yuBYTHU88du1izl/zos4MOW+mEeBnm6g5WUvw3GrMDeXfK?=
 =?us-ascii?Q?17AOsko24LVj7OOLDrmjFPfuTKumYsHD5Q+SNRHpBDpUAI7eIR6M/0sdwsio?=
 =?us-ascii?Q?ni8w2PDwG9Md23nJ4ZMlivjkenC8O9o8pIAfjh0vA3xImkfuJunJtVa4u91t?=
 =?us-ascii?Q?zonHPhIH7etbcVVTqu04LRbc+n9DmyJWCPr9KP08zyoLV7z+nUd+tDIgUjrB?=
 =?us-ascii?Q?+ywgQHL59ufuumNIDmz3JR2+33aAIMr7T0hOdOr3LYiIToRyk1KHR1obZv9Q?=
 =?us-ascii?Q?q6Qa9EFpS7NuMJjgBjQFpklZrxqopvBk4OBPKDIp68enjSM3yoWyUcyXpA2r?=
 =?us-ascii?Q?GND92BUcVKa/NmiDsdA0HlTsYk9fzI1ZKF86Jldp0BkIAhj1juhaGEbFJgAl?=
 =?us-ascii?Q?FgY8+EonZWWoX9JS5sC1Hm8P0CZ1uOK4a5UiA9HgIMc4BDXnC/GITw//hSWn?=
 =?us-ascii?Q?xVFq2+L9QvfQnEiq7yhdcLEFqkL+8xLhg6ARt5DwDqaTKuqaDgDDUNUTGSId?=
 =?us-ascii?Q?T4prvdSheY+Wdlv6aMS14ZxmfJyd6XDL842i3g6r0/GZrGCva3362CzvHRs4?=
 =?us-ascii?Q?H0pr48ljUaGouMZN8zQwdZkUeg/9z7MDhdb2GF2mIwcGUcfXynwMDiAY3pwv?=
 =?us-ascii?Q?jawkoX2OtKGNqr8lAyfMnNvY2jXQB1gtOjKaMkZG1YANObgE/m5j+4r8hK99?=
 =?us-ascii?Q?9KK2PUeNjnTceutsPbTsiOyfHizWARxcHi2ia/iDBUmhX4DG7bb8zWAw7/QF?=
 =?us-ascii?Q?izriI7sLtzLDf2DJmRs/28FgjPWbkgwe1lpwjCWYSHZ94SDGRsNElHNXZCDT?=
 =?us-ascii?Q?6qjOwbnudlxRuZ9VLmrpiB5bpYzdI5tPulroUuZC2jSNHHrKJpIcqD35R/gd?=
 =?us-ascii?Q?unGTA0cgklnCu4hgJqyYveCDk/Ih+uYFdoDwTrPB5VwCwKNHgA35I86y+/ab?=
 =?us-ascii?Q?BW8IjOXrsehvPk2ntHXJ6lR3qre5DOMl/KVtCX9IUIpSMLli1TkzkmPsvYju?=
 =?us-ascii?Q?S32DGfT4zD02dIkQEtstfNzbKXurYi34qGW5YCa4asqCDOebbzTaLzxV9Eqi?=
 =?us-ascii?Q?cKR1udEubKF8XBE8ItdGlFZ6PUqxW2aBrH94FwRITwFUXWsUa7yuFPnihB0f?=
 =?us-ascii?Q?qjbqbhnglPpoLkboE6wx/mRPNuTChIVdZhRLvr5LzdTGa5dWes1jngQD9cI4?=
 =?us-ascii?Q?evw8XxtOP3fnaAno6E781yNdcJ1XEUW7LeCa8QwwTQ9rlTBV8edRiQK5wwe3?=
 =?us-ascii?Q?mj2BqSunOtz+t9NCHlj8C0nelhIEnsjxkxOMG8skgXZD25BjRVnky9dOWxrp?=
 =?us-ascii?Q?HrbglXzNzLPTP6edrDPDD3JV6/RIbZfcs0NDDhW8qC3O6AbL5LaIVJUXrqec?=
 =?us-ascii?Q?+i6kWBWnupvhrw/gWx4KEPK0GIgBG5TIM2yzXxH3FRDvKbA2JBy8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8e066-6405-4ea4-7700-08de83695c21
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:36:07.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW3Dpy6if5FrigMHfMeIQwVNj7pN3ju/mTqPXMH96TQscjxJY2SXjO99mZvH+LFbg+FK1JYutsUgsVOIKjKRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2101

On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> When the BAR subrange mapping test on DWC-based platforms fails due to
> insufficient free inbound iATU regions,
> pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> not restore the original BAR mapping. This causes subsequent test runs
> to become confusing, since the failure may leave room for the next
> subrange mapping test to pass.
> 
> Fix this by restoring the original BAR mapping when preparation of the
> subrange mapping fails, so that no side effect remains regardless of the
> test success or failure.
> 
> Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 14e61ebe1f11..f44c36f5cac5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>  	bar->submap = submap;
>  	bar->num_submap = nsub;
>  
>  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>  	if (ret) {
>  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
>  		bar->submap = old_submap;
>  		bar->num_submap = old_nsub;
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> +		if (ret)
> +			dev_warn(&epf->dev,
> +				 "failed to restore the original BAR mapping: %d\n",
> +				 ret);

Ugh, sorry, let me send v2. I accidentally overwrote 'ret'.

Koichiro

> +
>  		kfree(submap);
>  		goto err;
>  	}
>  	kfree(old_submap);
>  
>  	/*
>  	 * Fill deterministic signatures into the physical regions that
>  	 * each BAR subrange maps to. RC verifies these to ensure the
> -- 
> 2.51.0
> 
> 
