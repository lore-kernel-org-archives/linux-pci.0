Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AC2FBDE0;
	Tue,  3 Mar 2026 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519694; cv=fail; b=nP6X/qwA/eQpyrHg9n3I0e4JcKf8I7Ah47b3ZRx6unx8deuNA9UcYGp+lf5TF9MoAQqIhQM+UEcFWpEu8GgPisl2ce0psAPsqagqyuyM3MKvey0aWduwYZ0/Rcr1HT/q/uDdrpiBlQtTGMM+i8+3uI0FrRYCoaN3edsRWmPUG4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519694; c=relaxed/simple;
	bh=YOqeG9dculKUjRz2/6Z6zK47OCWPcFyeVd+cuyXqwXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKdkNG21lrTokz+EZMVeXb2pUgnhyEeXLmg3DY6wtC6NRrE8De9MtkStaBMoNDTFWNXsjahJZlDXJyoCVO8EtM7MAa08WPFxrnAXqiJ18dq9YLZb81yTnHl49yCHoc1etG79sdczLUpzUQFV0eykCCZ4gzOlVT0G76S9EFuoUxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BekyCWzf; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BekyCWzf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KutHhA0N1YB+Gu04SYquMP6UjuT70Kb3zpTFtPaF5GaKrGQ/S2YbTSa3ApAd1yFtA7Gy/6rFO1+uxpzUJsbRzZ6wVU+IZvH2tq8dNf2XRmwJZX4ys9PBxFbiB4mGpvakSYYoCmr6Reb1FFB8txf/hgKQsFTA32SZ9+T5G0gVurqFqtTSA7prz0bjmph1RuMuFSzxJ2EZFhq4qdIj8ofmOy+sPArrIf7aZYVn/bOHviM/myf6yR8PrKLqDS9JG+6rFbTAWb2f67+XwruPCL9mm7xTQ4wCLR3Rnd+eg0BUuxhJyyc/EUHCJ73pJiLhKGWzNI96sa0q21Do7vd0VNImbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIoKmpGBmFK1fvYql/YFoGDPtoL7DYb3c4A3m98LQLY=;
 b=R/gUIEuTsarNK6bQg1cfP5AH60fOo7Lj16iUzz0uHsLgwfmwiJacYRd2nBRaUBxmsY8hZLzwLHO2nF7wEAn0/SxNTljM4GlnQWTHOAtHAmGWJ4o3wxU79kIzvS2/wRnBzn6KUC2DoVWuica5YPeawfiOh6JxvX+S8Pi5lSSvgqbwuAnzDNKEQ/5ooHB8t0O1AWhJ4p2OeoqE4wzx0+bQdqpnnbxdWTDpYMSe80U4MvzOH4Lx3buxju3h3UzWUBDEg69Iobotu5AQdMy0OBd6k6/qSTkfsVnrBMQbF0PUCeDMYqhr6f+lKiwadSipn/KRMJuRtscvmvx5rgbl/L45Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIoKmpGBmFK1fvYql/YFoGDPtoL7DYb3c4A3m98LQLY=;
 b=BekyCWzfxNdxVwvw7sxNo89STLwCjLe3amQxc8DTvAEGqpyxliuE+EFy9OYXhAALO8JSFULWxHkDl4KV4BZVJDaYHqRuIm/GHwuJStNKwlD8/V4+gryTzLvrbbVNdJTreeNEsjXpreJ2a7aIePhIQ6ZERx7tRDL3R9r+74STuRST0nR4bwMZtk8ac/O8RAdGTU5Q8+3rQREugEAW0xVWZgolNFeLyhyGagDxLRoFO9YlEnarEudWg+U+7rMiNab5EFJ/FfJ/GBTBDmXMfghk9+H6860WMOO5PXqpDxWala/MMdyAFjhVHzTDL60N3aCZTLnyfcOPkH8EEhnW4e5uyw==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by PNYPR01MB11535.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2d5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:34:44 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:34:44 +0000
Message-ID:
 <MA5PR01MB125007E74B66A9E7D16E59918FE7FA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 3 Mar 2026 14:34:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: cadence: Support platform-specific hooks for
 RC init/deinit
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-2-me@ziyao.cc>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260227181925.52475-2-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <7b955631-93f1-4a82-bbbc-94982cb2e0d6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|PNYPR01MB11535:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8d1a62-de07-477c-1273-08de78eef4df
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d5vbofsfC/jnGJ+j4hG4ECwJh+PUDYDQ3F/uck5pUu7egm2e3RD4d1gbFQMCS8mgwy3GBKyRsNZaheP+KwYemHExilpswt/LKLCb24HYwVx5oOBpKyifMIaHGMs5Ga7hyGEmDOX/vltgC4sP/xmkGwJW1n1qO2SoyhRPmbw7dlI4UXNZVL1aKg6Zlyr375CWU1V5G77cEE8GsVpfthjAdLp0qACxf0krLELdt93C27CLpjIEffO0IOFY2JMp0fLfIQ+X1UqqG/PNo/szB4X1McTFxgFPzIkpOxCie4fw7E+E84JSyNgID//bu/OMT74fPtOlqoezsLpvVO+VigMHgMdjZQK6bb8Gu60UEwPylMDuZlpk257hdDJe5YGsYAvuYxjHebKp8TrzSSzhphwojj9AbOUElaEn/xjdOg9lyEZZe0Vcm0SBSvIrVuNcVvtgGfj4KKzfLPey0liD6s2/MkkjTZpFrq7rmNQQ02OqecEDnh91I2vnLlTAjlDOBv2TgMoC+VQwVM5byZVMhme6d8U7SJ51L6BNkHaurMDoTyEXrA05ESuZPmlIIASH03l0CYQcuz+Z6JDHOCBV4sdrf4qae4g5BPgXhlegBc6QDn/a4UNH9Pr6fmkF7HvcRkYtpM1bK1iOfPvAq0FTKbQ5PmK0uM067LxN7zRjmDKv+xVy9Zga9xXyAqewCEnurLUhbDbhPQ8AOEKo4rxn3n9O893UNexCZapFtVjaJe7T31QlmHuWLbbcSX1BbirCitJkg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|19110799012|15080799012|8060799015|5072599009|461199028|41001999006|40105399003|52005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1NlUFcxQ2psSXllWG9HcnowVlR5VWc5NlhiYnMxWjlSaWluYlcyYnp5Ym9Q?=
 =?utf-8?B?aVRJdkxELzZmR2VvaTI5aXIySm5QTkNHajErNCt0UW1SWXlPS2VQVFFlSWs3?=
 =?utf-8?B?U1JSMHlCVU84dUw0YzRxT1BqejQ2c3FJUVVQWGdyT3kwVzlwaUtuNEhQQUtm?=
 =?utf-8?B?Uzg3SExacGRxZkE1VWkyRWhyVXVpL0w3c1hvb2NNR3h2a2EvY3l2K1dSbFB1?=
 =?utf-8?B?dTBCdHhXcFBKS2d4K1B2VnYwKzE1cUdvUEtSNXVxWVFYeUJvNVd1QnRUZW15?=
 =?utf-8?B?enZPbllMUTVLUFBFd0hGbUdGMWt4L2E0WlE4VGhvMHhMdFNiNktVS0FycjFQ?=
 =?utf-8?B?K0pqaWtjT1R0Tmc3RUQwT25YTDR4RmRsZEFicXpZd083ZU1Pa3dyZm1HTmEx?=
 =?utf-8?B?ektBcDBKUjdZakFhMFh1RGZpb2x0Qng3NmN6cGd2TVdWVmhaK00zOFNYaWc1?=
 =?utf-8?B?RnQvV2hNSk8vRENNb0VacHRJN3cwajh1bVkrNUtEMFRrNVV0MVM3eU5kVWFm?=
 =?utf-8?B?T0h1emR6NGVzbmFqbkQ2YllWUHZhY0orMjl4R3RFaURhM01HV3ZOZmRNQmpT?=
 =?utf-8?B?WFphMkVJMWVkdkVCc09nTGdOZkJacXhBZ2wwLzdRNHBycER2Z09jcGxTVnFI?=
 =?utf-8?B?bjRIZVNubTIwaFUvN0Y5b2RVN1UvN3FmZjM1R1J5ZlhDbDkvbVp5aE1vandh?=
 =?utf-8?B?UHlFZHVlQXVTQzlzOTFZOXYrbERrMXUxTlVLcDhaR1Y2c0VNMFN0RXJjMktC?=
 =?utf-8?B?cWlybEFCMmFYeHV0enB0MFRnY0l4Rkp2WnVxMUpKRDQ3OC8yL2llOWFDRHRw?=
 =?utf-8?B?SXRHSGc2MFZOVG11Zjk1cmtuZ0pYR0pxMmd3d0ZQZ1RFakMvZzNCcyt6T1Y5?=
 =?utf-8?B?b2Z2Wk92WXpFUHNCb2VXY1JaakFQWnU5MjdDanNBRG1QdG92c1ZLcmVaeFVy?=
 =?utf-8?B?dEJjYjlsZVF5T092S2Z3ZXN0aU03MWtmdTh2UkhncXpyYnVKZWZHa3cwTk11?=
 =?utf-8?B?NVFjRGZIUTd2MzdGNDU1anZTKzlGREFrZytsRkJ5ZFhuVVBneTdqZkxxSExo?=
 =?utf-8?B?cDdGMDQxbW5HTzdoV3dKTVVrcCtjV2sydDdLZzROSDJXNE5Ya1l3VHVhV0hU?=
 =?utf-8?B?NHFReGljYWRSRFlzREdUWXVvYi9vMThlazNCQTdMWDYrU0g0am1GdGsrZXVU?=
 =?utf-8?B?dnl0VDB4WFo1VHVxdnpKVVdld3E4enRPUHRXc2pDZXNvNXV1V05RVGxiNHZp?=
 =?utf-8?B?VXpiZjNTQmVQazNmN1A3WlQwWDdwbEFzZE1SQ1ExUXBtam5NUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDVrU2ZmdVAwakIxMkhnZWE0WlZ2UnB2Vzg5KzFqcm9QaFhVM2pBWnZXZGV5?=
 =?utf-8?B?K0x1Z1hPd1A2VFBWVmFQWDNncXFTT1VWbjVDUUREc0tZRit5VUVTN3lZZ3Ru?=
 =?utf-8?B?Z0t3aFIyTmpoeDJmbEZVYzV4WWtHT212aWllb1oySWxHdk1RbzRBVEZnUnE0?=
 =?utf-8?B?S3ZlWGpIVzM0NnExN3BPa01xZHFzYnQwaE1nL0IvRlo5WWFvSzJicDI2dXdZ?=
 =?utf-8?B?cDJYc1d6cjM1SVhTeGRZQnpRdzYwZzNDWGhmWm9ITEg5ZkJxR0xzQjY5RGRX?=
 =?utf-8?B?MndhR0Rhd2JmU1dzOGRQTElReFlVVFl6aktjeEI4dEozSUpzY09KQmZZT25T?=
 =?utf-8?B?QzF6NnFQTGdLdmoxK0dIU1pOR2lEdlBrYmpMNjduaFVHTkRlMzRXSCs3dDRt?=
 =?utf-8?B?QkZCaUZ4RlNRaUx3ZThvQ1hjK2RWUklpT3pTUTgwRTViMHFiZTZqUzI4UlhV?=
 =?utf-8?B?R2t4OFhUbmNhbG5TckUyYzFTSWxTT3ZpcVpzSmczRmdSMkNBRmpEclkvQkVr?=
 =?utf-8?B?T0dpbDZ0aDJuNTRUakl4TUN0eGJrY1hkcHhQaUtFOXRTNTE1NE5qRHFHTkFl?=
 =?utf-8?B?ejNET2lNNVRUalFVVzlPUVR2dXAxSmw0cHZQYVZoVS8wSGlxMkJiMmVkMWpl?=
 =?utf-8?B?UlYybkkxZ2F0UHd2bjRpc2phRG03a0ZNTjFpSVl2MFY2R05CSzlVNG5NS1FK?=
 =?utf-8?B?OXdrS0V4SU9ORVc3N1c0bE4xMzVxWkx2S1BpWEpqQnhKRTcxTXBibWdLTHJO?=
 =?utf-8?B?TS9vVktUdEpOVDBiclR2UlFQajNzL3lnbkhLTTVoTnVoUTREZERmZk9kcnpD?=
 =?utf-8?B?VnEvQStzdzFDTTV4QzZ5eFBzdy9NZFBEbWJXcDZTUytacFFvbFpnMUpMR1lM?=
 =?utf-8?B?ajlTRVhMMzJCMW44bUZtNmlwOXh4WXdoTVJIa1c2SGJ4SHFqeFZIT3dIZFdo?=
 =?utf-8?B?VUlLNS9keDdkajNpeExnQnFuMlI0RGM3UHBuaGYyYkVxc2N4NmtMKzhSMWMx?=
 =?utf-8?B?MytUZnFVR3p2VXZPNnFrRFRaZTJaZWhvd3F5YlNaSWZ5SDVEZUpLYmMrWEkw?=
 =?utf-8?B?ZDZMbzRIRXZCNXVlOGxFYTFkQWZFOGhEYmE3Q05xTkxlS0x0TFE4bFNBcjJL?=
 =?utf-8?B?NnpadXd1NzZrSXlEaWZsSHUrMEVLSUtEV2dvbnhCdStUaE0rKzNDT0lMc0pm?=
 =?utf-8?B?NUFES1pQcjM3RDZsTXRYQnhTUUdyK3NHSWZXWkErY3ovVHZGbFYxNmVydStv?=
 =?utf-8?B?NEhLR2pDekt6VlRRR3FQVGhxanFkZTRBa25Db3ByYjNxM2ROWGYwMXBXYU5r?=
 =?utf-8?B?TVAxbDhyVUhoZE9MM1gvcmpQbWZ2Ky9iWi9zb0tLSVBVUkZoV3UzbHpmTG9Q?=
 =?utf-8?B?UmpFSG1Zc3pBVmpSS2ZRK1Fhb1k5ZWt6SmliTkdSWkg4QXN6aklVc2FRdktT?=
 =?utf-8?B?dFpJYURMd2ZlaUpzRG8zVXpJSWJNY1BleDNGbmlTbENxNXBKTjVGOE5NODUw?=
 =?utf-8?B?UFVMbHpMaERTeEFDOTVpQ2w5SXc2amZta2YwdU1DcnQ5OGRGK2FLMTRVZlky?=
 =?utf-8?B?cUxacy9DY0JCRm9aZ2tvUjgvcVFPVjVxNnBaanpxbGZGTFYzclBOUTBGeE0v?=
 =?utf-8?B?R3pIWTJ6dTRUSTlrWnhQekVlV0w4eW9GR2xLbEI1RS81RkpseHFUTWNsdjhC?=
 =?utf-8?B?Q0N6VTRWam01WWltN29YY0FMSi9kMjQ2RVNJcW9BQit6NzRhNmp2cWowcWNr?=
 =?utf-8?B?WjhMQzNRY3dOUDgxTXhOdzMvYy80V3Y1bW82bEtXRkNzMkRMbG15cmVTVUVT?=
 =?utf-8?B?emZDeHRiWCtWYUhnN2twSDFhRTF5VUtOVXovY2tLMjVXa0ZyajFjTmg4OXNt?=
 =?utf-8?B?SnJuNi9TdXdGMnNmZTRGTy9KTStMUFFqUXBvWktuaDh5bnF6L1I4NlIvdzIv?=
 =?utf-8?Q?SPosd7jRiNdx9VbXakmswsCssZM5ehQq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8d1a62-de07-477c-1273-08de78eef4df
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:34:44.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11535


On 2/28/2026 2:19 AM, Yao Zi wrote:
> Support initialization and de-initialization hooks provided by
> platform-specific drivers. Initialization ones run after everything
> else has been set up for RC, but before it's probed by the PCI
> subsystem, to allow platform drivers to easily override RC properties
> like LNKCAP. De-initialization ones run before anything else has been
> cleaned-up.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>   drivers/pci/controller/cadence/pcie-cadence-host.c | 8 +++++++-
>   drivers/pci/controller/cadence/pcie-cadence.h      | 7 +++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index db3154c1eccb..23ee5a9c240d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -304,6 +304,8 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>   
>   static void cdns_pcie_host_deinit(struct cdns_pcie_rc *rc)
>   {
> +	if (rc->ops->deinit)
> +		rc->ops->deinit(rc);
>   	cdns_pcie_host_deinit_address_translation(rc);
>   	cdns_pcie_host_deinit_root_port(rc);
>   }
> @@ -316,7 +318,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
>   	if (err)
>   		return err;
>   
> -	return cdns_pcie_host_init_address_translation(rc);
> +	err = cdns_pcie_host_init_address_translation(rc);
> +	if (err)
> +		return err;
> +
> +	return rc->ops->init ? rc->ops->init(rc) : 0;
>   }
>   EXPORT_SYMBOL_GPL(cdns_pcie_host_init);
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 443033c607d7..7d8f8e87915b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -100,6 +100,11 @@ struct cdns_pcie {
>   	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>   };
>   
> +struct cdns_pcie_rc_ops {
> +	int	(*init)(struct cdns_pcie_rc *rc);
> +	void	(*deinit)(struct cdns_pcie_rc *rc);
> +};
> +
>   /**
>    * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
>    * @pcie: Cadence PCIe controller
> @@ -115,6 +120,7 @@ struct cdns_pcie {
>    * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>    * @ecam_supported: Whether the ECAM is supported
>    * @no_inbound_map: Whether inbound mapping is supported
> + * @ops: Platform-specific hooks to initialize/de-initialize PCIe Root Complex
>    */
>   struct cdns_pcie_rc {
>   	struct cdns_pcie	pcie;
> @@ -127,6 +133,7 @@ struct cdns_pcie_rc {
>   	unsigned int		quirk_detect_quiet_flag:1;
>   	unsigned int            ecam_supported:1;
>   	unsigned int            no_inbound_map:1;
> +	const struct cdns_pcie_rc_ops *ops;
>   };
>   
>   /**

LGTM.

Reviewd-by: Chen Wang <unicorn_wang@outlook.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen


