Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB51EFFB7;
	Mon, 30 Mar 2026 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837052; cv=fail; b=HM8psWyj3yL/XSCrkIYLDl/vmOZG4N/X5uLBDuAugl7t3waiCQTkBXQuW8N9xnlrbzRmQDCBkC7BQq11ZovCFyhuhiLNCkhRd5NBYjTsaYSbtndxFX2ZGxqMaATLMdvsJgwqFPE7ztv6ULun7dJKemUGhPgATyYvub2fRvxb0eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837052; c=relaxed/simple;
	bh=qYMa92QLgyaQoN6bkyHi619K7x60SmgNkPC7LWU07iI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=M17dFmMeu0EJTaI7Vaqz+HZ03nrOzXYOuhVjMd8decteVXpLfikK8RIVK6n8QyhvHArxVoBfPIUrXHQ1dU4K2UiHoLlGB7mH5gjaOwmxxK4rSa+AtJAr9011fiRos01yFgn82XJ3a6cMPVv//raYRossZn43/fztbij3clYv4+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BQtz0FxK; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BQtz0FxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqOrsl3mEG1RysTIPyEL/qYvgmwPXNl6KrWCbhzyszgKncdzsLGOpyJ4/9WxOaqTDugyqdZNoMNCxOVcrQGxUXhjAMg1QqLljZIOmWykv6hYxOY82ht7H7pyJCafmt0zQ8pExRaWs4ADY5OAnz2XEJRoFZ342XXp6uF/H5nyEUzKlhnIgotCsCqLQD04GrSbJ1UHOFS6cscGCyyWyP5jygchHwLPqdg8nwH4kV5//7fcQPay8LIIZ+0xJv5HWcFDtQN/q/xhXwd4Lpbw7t/B2p788IwYm1HJMTRT0nD5UswvSUvnrQGpYoLB+1IywlXLV+qRgGVNtbBeSOsVBwmCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7ALczHi78ZuR2rhGc1+yGSYHGx21dErnohiRr/Bm14=;
 b=uQifnViigpgZbrtKxAin2+zO8w0TjHffKjyP0v69jH80xdMeSuLa6BjFIXRXqu3R06462a7AUzg2guXLxD/xPKcbeWTpOXhzWERuv50Eu7ueH/oJA0eRoAN42aws10VvvdUUTk1Oya/I5GenfzhdB9z+ZDK2NzRutj43k/iXkm0iT8N5bUB0vZdTtWH+qoDdNDqPKHPFXSnxO3l9TkqCFMoY7q76n0bYikeB+pBqmkPd+thzN4HxA6PnGLs3vFIV8rqyriJsi3i8wyWEOT8vze6fsPtwmX9v43IU0D61P0/7bV9761g8H4cyuTjE2+3VD3cRD2wim6AhLroJ7GyyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7ALczHi78ZuR2rhGc1+yGSYHGx21dErnohiRr/Bm14=;
 b=BQtz0FxKyQWHQs68d+hZPXKniWXHWjD23ODrsFYc2qJ/W3U4SQjitJjrOjA95bqXEaLOZoXMwrrsV/O/S8M+uCCHWuPhA3HYZ5B+asAYcJi9ZT5EaIDnHfbBmv+l53hek3rpxqpW06SFUfn0oB7kMVBGF7LXd8535gPaJ2d5LZig5zOhwYJ0eDO02PgTg7gQkuRjMozIjOrY9sB5387gparoijoS+v24tr/JypH8OXdP1Qg2ckd7hJGLfWq5B5PVC9RG3tTV/CtXPW+9OQo4/XYtU/gD2A/IXjYkNiC9OnwZp1HRlyMEWGIsBj2v9yBfm2I1c5VZiUasEN0T287dKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:17:27 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 02:17:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/6] PCI: tegra: Add Tegra264 support
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20260326135855.2795149-1-thierry.reding@kernel.org>
References: <20260326135855.2795149-1-thierry.reding@kernel.org>
Date: Mon, 30 Mar 2026 11:17:16 +0900
Message-Id: <177483703694.914339.6137418124414702273.b4-review@b4>
X-Mailer: b4 0.16-dev-ad80c
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c15e09-9bb7-42f5-f520-08de8e027cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4cJlun5NY/9A0zmn38kH5WJvb9LMJm9ZRzJ4Z8WU85kEBk3w9yvoS5y7oVyfF/GjYT5i+th4QaQHzVC3841BLo8Z32odFCBwDBEqatO6bbXUozXHpRjVZG2THIkJdxH7VqE0XtNjTPGEUjpXDwpArJadgzsCFOwo0BQeXaM32Ca9TmnaLWSaaMEihlJU2sxB5oFkfLV+wmwJPJ0ADoq3+ImWCpVycwQwj2LWvpZesQpy18WQ7pkw5VKGK2rGKGKUSwrX5kPPA50iqlqAClyCKNTCsdSk089bamm0ydywuPcqUywzd4VW3flJISIqrYIrnOG4Tmqynqs2XeYhgfPUpLLiBOg4s0YLtCQrTJRsyg5Ow3/SyhZL7ggP3BgixLn9rzGkof7DLgh8s6y7yAF867NTeBEZ5im7g2Wv3iSwZw1jD9ERnsfANthak6HCej8PEHX99ngVT61Xj/1K7G1s9lP4JFmkqlKSJaW2AcfgLJgEn/lCDyXHwYuUUj59DWdM3vxUrCEdYapzAVU662lbrGddNHJ6ymHySebQOs5/8Z202fouDHx1/6ZslxVPm/olCDTlYIyBYZS75K1Nk6OyMHCMrW3pI3b4bch+qz4knuk3gP52u/ahcBf4bb7fHp/xis9ed0QSfMT7Fpx7M88mj4ma+c5X+OkEciEkRDlvrKvspWSaCosKVxX72foE5iAb8d+0l2VkdmtlWaEWjddFI4TsT5VjN9vsStvvZnGZ3ZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFk1K3JLdkRIK0tTQkxLc0szblcxOEx3OG9aOWowR05KUXpCY2NKcVAxYWti?=
 =?utf-8?B?dDZ5emdNT0FRNHBBQ0RNdTVZbVpTajhOaHJuL1Q4eGc5bXdZTG8yRDV0YWcy?=
 =?utf-8?B?ZTVja3NpWlFlVVpxRFFRdmFuUGxnMml6ZkRsaW1qZVZBMk9waWQyK003ZnQv?=
 =?utf-8?B?TGNjT05wRU5vcXJuMUNpK0h6dGh4TkhWVVN1SjFvemdyUjlxb0ptNGVIU3F4?=
 =?utf-8?B?TzdUUndlZnZ2M3RuMFEwa0JLM2lES2thWjRKQTYwK1VxTVUxYXBPcVQ4N1dF?=
 =?utf-8?B?bVBLMm9KQ2ZyUmYveTZvbGFmS1NEa2ZnQzlBWUtKbnoyS1BwdVdsSlYxeGMz?=
 =?utf-8?B?SnNxV0lteHZ3VlVRWVdpUndzeVBCQzJRZTByTmZNelpkUngxNmorT1RzRTRL?=
 =?utf-8?B?K2xGQlNTcmJwamRTK21ZVUIzNjhna3hkM2VueC82dDFOM2NFTjFWeURsbFFQ?=
 =?utf-8?B?QXNxYVZLdFFOZ2l3UkZoMjQ4akRodGdYWEZYSDZqVU5BS1VNMTlrRjF2WUlF?=
 =?utf-8?B?eGNwNUlTVUZCRXlSNTRlVm50bllsTkdrRmFtUElENlEwUFd0eGtHSmV3S3hq?=
 =?utf-8?B?dmtZampNZ2JKNjZEeXIrYXN5Q2tOWlJjdStoOXJEOFZFZ2lIWENtMmxnaXB2?=
 =?utf-8?B?SEtxaWxqOXRtdlkwRlJSUExNQSt2M2s4NTltdDIwbDVCbFB5bDNRNmNwMGxX?=
 =?utf-8?B?d3g1WHRJdjE4dzN6OHBlaC96S0FOcEs3SVo3azJLaEdHK0d6aGhwWFFVTWZs?=
 =?utf-8?B?UEdtNkxWaFVsMGdBTXE0RSsvMVV6d3J3cGVRVXprUTkrTC9IWGw2QTVDelg5?=
 =?utf-8?B?bGJIZjVjVG5NMmpjQWhhajdJbVBjdmdMakR3SXFjcDBKSGltaXJwQ290ekFw?=
 =?utf-8?B?blZMRys4ZzFiN3JmMm53d2I4UUxNVlZPSkUvYkhpTzBOV0JjSmk3UnQ2cTdq?=
 =?utf-8?B?RHVzdlBpbmMvSFZ0WXBRbFo5MXRLL1FuK1pNekhJbzI2UzFkb1E4UW1mcVhr?=
 =?utf-8?B?bzg2WVVoMXdyMTNValpWMlR3MnZ1SlNqSjhaRi82WEgwaFZTeVJHQkhPS01M?=
 =?utf-8?B?S3NlaFcxMExEcUtyOWRORWVSRHNDK1U1WHVmM3crazJ3ZWlVS3RlQ3RPVUNi?=
 =?utf-8?B?Z3BrTHFzdUpqWUZrSzY3VDlTL0RoeWhISmJpajEydUFZTGtiYzd1ZExteDha?=
 =?utf-8?B?VUg1cCtlcG5Jb0pZdVUwbXBuNVVCNUxzOWY2a2RIQ0w5RGc0cUZuV1ljRTNE?=
 =?utf-8?B?bzhSa3hjRUNXRjlXRXdYUEVhYWxsWFZUeEF2NmwzL2hxUFhQbVV6RGF5TXk4?=
 =?utf-8?B?MDhLSkJzdDhTSTV6T1htZEg4cW5xTWJhVzNES2xhVXdpY3F0ZXFmdElsaXZu?=
 =?utf-8?B?d3MvV2t5bUhITkUwV21kL0NCSkxPNWh4emxvUm5XZDkrNkZJZGFDQ1YrVXZa?=
 =?utf-8?B?TGxMYXVCK2g4eW1mZ01tRGZPdEg3dUplQTczanFQTXlyWld2VEpBQ0JlSnZF?=
 =?utf-8?B?UFl5QWxycVhBVVVPSUpKR05JSEpEQi9hWXVZMFZYUzVFeUNnb2NFRWsySEJl?=
 =?utf-8?B?WkpZWGtCRnUvYi9NbE9aRHh1UmR3UW9hb2JuY0hkdE5FU2d5YTh3SkpqblhJ?=
 =?utf-8?B?VStGUk9wVnR1SWdINGo2UEg2ZGt6bkpQUisrNnV0VG4wU3ZiUGl2MGRUQ09j?=
 =?utf-8?B?bmZMc21iaVVOUEcySDhwR0xIMWRiMUZ6OHV6TTNmQzRXeFZ0a3hiMk5kaW5H?=
 =?utf-8?B?VkYwTGV0RHZuL1NSbmxDM1BuSk94eExsUkFUck1SZndkUkpZSGYvL3pMaVMz?=
 =?utf-8?B?L3kwRFAvSWhOSlFtaEVvNmpIQXJ1dTFSeEYxL1pveklSRzM2TGtEaEYzK2hN?=
 =?utf-8?B?L0RMOXRSUFVuZ0J3SS9DQ1o2WUpCald3czBqcmx2WXdXbzFBb1lxK0NISGh6?=
 =?utf-8?B?WEQwNkE1dE1lWjM1bkIvMWhiYlphUVljYVZrb3p2Z1lCQ2RNaW9iV1BNa3dW?=
 =?utf-8?B?WFJJWm5MQjVXNGlWRVZIMkwyUG9LRlJKSDQxUGFzTG5CckJhTE5GWVdFcSsr?=
 =?utf-8?B?UGd5UzlwRFdxYmgxVmhwUmliOU5QSEZmVFBCZkFUcEZkckxsZHB2VU5SN25z?=
 =?utf-8?B?RzE0ZFB5eHIyaVZTbU1SbEV4YzlhYVZwZkFkQzQrMGhiTFRZdGVyaXNTM0RZ?=
 =?utf-8?B?L3hDcDBNeTIxTDRUWDVpM3NoZ0hCbVVDQVhDQURBUlVLVFFsRmRsWmhrLzdO?=
 =?utf-8?B?cVd4OTBub3c4blMyYUh6LzB1dWVzalZWbVd5RERlblJVRFVaRmJzdm5ad1ZY?=
 =?utf-8?B?QWV6dnQ1TXQ5dklpbm9yMkxnSHVIbzdXbzdkNExJTnRFSlhWL0dzb3JrNlpP?=
 =?utf-8?Q?O03gsqu+V35loVzjCwK/hKeQEY2FdWvBMefACU1IGBT4c?=
X-MS-Exchange-AntiSpam-MessageData-1: Y3WRdkxozHVDJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c15e09-9bb7-42f5-f520-08de8e027cd1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:17:27.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg81irXDE6+95S2sLHghyjFrMm4PXdmcdEnfSHuiniIFPLuEGSjzp32MpeQTgTvdXmA3UwbO0dE6X6ooV5qpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On Thu, 26 Mar 2026 14:58:47 +0100, Thierry Reding <thierry.reding@kernel.org> wrote:
> [...]
>  16 files changed, 4629 insertions(+), 955 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
>  create mode 100644 drivers/pci/controller/pcie-tegra264.c
> 
> --
> 2.52.0

Thank you! Works nicely.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com>

-- 

