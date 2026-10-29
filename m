Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244905;
	b=RYzzeSxQhYl1sWjVLtJeJXoIHfe1NBVO2H84SyJpANq8a5xgXlpFp8sinsghxXN7Rn1Z
	 WB6Rv9iEi9sLounV1+3nvQXSowR2rPJ+RHFjDk3VpXr0Zce+/65IyzSzVwPbrTTrcHY2S
	 XcLyqHv451SU/UcYvnH5kc5h2rOxMXMn8rmQKiX2vJCphDaPk9u8xVvqtUIm80nXkfsad
	 UIyKbqU1auix2IyWiqiArcGXu/233p9DCCHPl2MOoaWihaG+kZxdcVcbRe+8EcjR8ZNAf
	 puW8FhxpeCHNxMw07Tm1AjGD9Vdp60eEXZy5C4ezciLFEqimJV9VVSXz8YoIgD0QCrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244905;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eLfITd2M5S99Pz3f6gpphL0xITHeIJTug8Xr3ls694c=;
	b=JjowrCTabTUjS7xDY/OgFJcOcVpJEy471rgVSz/Z8gYw+7/eEEw/ejiVSqCo8e7YXQA1
	 1n2IKfgLWdf0RbZW+oDiJClK3S00p65JqbHMznqZvh+YmHNrRQHV8/XGgpA1WpZLpENWW
	 3XSBup1eA9aM7uFyVU1x/gYh5eutYTbxxYzILES7hDC8MOl58dYPfYscpvCipHFj62Wl+
	 hHwktw/ERTThHg0kdBvR8WHqSpQoy/m4qjO4MIxptVIwC+bjEbi2eJPpD27y59MK7qpYv
	 N4yf0GUp7SpsFUg2CRZCDr7cS7vrjx/p01PPvmCTc9mSsZe9dPbHLc7P+LguDQ9XbnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XRzMDED5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B3606A31F;
	Thu, 29 Oct 2026 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F4B3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XRzMDED5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4db9K+CQmgoq+ncMUavfXIWXz85t5ktVeeJKpUgRQ1b1P8UnQw70Xy1uUx9/61uY3qw2DOF5/79RvKaSxzVndQixjtIXkAzxEaymQoA1/VtZGcZRaHb9uYie00HrfyyssPY4ZtSfI86Ei9tHFfZhYgxx7Ck+oiuQHWyrubKnMywbnEy1w2kaVuXKGdtkdaNdP7mfjnsxdBT6PbZJigKAX3XWaujCZl0qbx1Te5oxuUhFC16GY2QJ8qHjVUHSLVA3hE1DeujqKGnWMQy3Mk00tvzQUA93i8d4t32sP7QiqTgKnhJhQCNfPjd0WA3CO8GAze+cD1J/UGpVlLLM0NWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLfITd2M5S99Pz3f6gpphL0xITHeIJTug8Xr3ls694c=;
 b=AXBYDuB6JbQK+UbQgWdCSshozef8V11xDCb8XjDCRL0kR8nvQP8f7ZnE50McWdzFhER7dMDrfBpCvAoez5w1VyVzyIrqXyQ3I4+wxA3S+z9m/u2dMEjlFbMERzT1t5YrztMsmRO3f7Uy8jVugYQ1kibvwO8UtMA+PpxaSYy0J9VCdeED+Et84V2FDuY6zaOtHngRY07e9EZIFAI3WIVDKHL/8sCYHbuylhRkEji3tDr4gysZwuaRulPFPvBxGDnfpkpjeo1WX2Bsmw3cJhc34k36+17bzrr0tfRGcGGjyi1na/7HQszSLUoe1xFtTGPy1W5Ps7DW9prNvIP4uz/ILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLfITd2M5S99Pz3f6gpphL0xITHeIJTug8Xr3ls694c=;
 b=XRzMDED53BXWxzik+t7qdNLK5ErZxhj0WUDuIw2zKGB+fB0iHiJYtd0EebGrLVSGYPxFKpmWnZ6IS7nzSt6whiEAy3gQYPInj2BpbxD3diXG+1/n/6/oW6IinrKO0LbmV4X5f0pFIYnGiOas7RPErplxwpw61Tdr8H93qst+lcVEsW7WBAqVpVWsCbbNQlkG1BOfCFcX71AKu+MhPJsMOOl/yHcooavbfIIh2GyqGXbNVExSU4tv9cIf4UbNEvR7M26ZJERdrxYJFSUThgQHooRI2tlJD4seV++vlVqHy/AOmCkeWWbMmiMeOdB+orr9g2wAdancn2pcN4DmGquDzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:35:01 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:35:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:05 +0900
Subject: [PATCH 3/6] PCI/pwrctrl: Add the Tegra264 iGPU to the generic
 match table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-3-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0160.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::7) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ebd124-6fe7-4adc-a5df-08df356d9d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5hZx9Pn5TDmPaUgK4ZwE5D32DG1p8R/MrAJ502YaPPBLsG1gs3tiqIGacBChEGopNjT04HAOPfXiAY+LVeZRfkr8ihrSwkSymL6KtOouAgyz0VvnWmofWez9nqu475aA1nXUYPmFND+lq9j+ypL+RInnkjASfHpngJjKoeUF+dovHis3ptTCbks3+ew0sPhRMkii5JF0kV8r0FnL3xq2x9QwHCowEQvEFVp5fS8C+C7wf4Ldc4TKIefR1+mNz+0mvbmNjSr8mJ21qPQFcob6xt3KvJf2BamJRsHqhN/1vw9eiTpdXo02MSE4L+RQRJ2IxsJoijx7/tHjpHuRTHfF2NHhPag9J232TkhqAZd/pGW1tRLswRNtwldp3ict1kNEs95nWYDKRhhKztxVxf7XdSITZB6qTEfzIk6UvATo4y5rNuut887WDhNP2AFweG/t/0sTWoOyF3MJmCnpXz+xPXNZM2RkZjAmfp1h292dM2cWA4qCJhipvIajkWHa2Y9VlQLapK3yYvKndqJ7cQVVuHgKK0pclWOkmq+dxH46vk6MYN3pL3qllHrR8p3MMdd0wGcB+qrzzYpvEs6x9vOz8XOP8/KM6ndMcqnQylPlIfrMJIirldw7UEj/XvMfDpvzofLOIsvLQ6rzf76WXwj4bhxQbvSQbZCMo+k87GBFPk1Jioh7jSmVmxfTG4Xug+wjrETI04us4drfIoJH2Ykccw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blNiZlVabXpKOVVvMGU3c3Z5UjZLd1dES1FHekZPTk1iQ0lZMVJ4RGlYWDJL?=
 =?utf-8?B?R0ZRaWtId1BYWU5LZlNMTFdHcFAyUnIzREtRcjlScFRFay9kRVcxMjFheDZI?=
 =?utf-8?B?VVpxUENLNkhON1E1bWl2SG96OFNBNFhqMHZWY1pJREx4OHF5VkxDRG5zWHBO?=
 =?utf-8?B?Z1NKakF2bXFHbHZTWWMvVWZiTTBFWTRIOTlMbi8xdTltRXdUSWxwUTljbWRZ?=
 =?utf-8?B?Sm04WHpHU1hqb0JHdndPWktuRWM5UEttenNHWFZRQU1BNEhlcDU3RGZtSFJu?=
 =?utf-8?B?R3lNQzQ0TDlZOHkyU1c5NGFiTzFPVmdkbUpXTm1JdVZSYnlsamtIRWRTRXlv?=
 =?utf-8?B?NXFzaFkrQ2N0TXJpUkhiR0lPbEJxc0FVM3RVQ3EyUUFpKzY5SDVNRDJkb2JW?=
 =?utf-8?B?SWZMZkwwcktSQ2VadTVHZ2Vjd3Z3MVdNQS8yVmkzTFNEUGpWNmJJQzRSeVhZ?=
 =?utf-8?B?MWZyb0RiKzhRTHcrM0tqZk1KSUozQlFMY2FUOVNueFhDNXZTSlJmTldzcW16?=
 =?utf-8?B?SlVEZkVpQXlUZ3E0NEJnU3huR1hBb2NISC8zaS9jNHpvTmNGVjA2M1o0SEd5?=
 =?utf-8?B?YVMrQ1VYcE9ZblhsK01ZbFZleURCWkhxc2tZSkNjRjd2WFRWSjZBQkw1NGJ5?=
 =?utf-8?B?MjYzSGswcm9Lc091VklIbmRwTllNeVQ2MUN6bit4Z3hTaFFzK01aNEwvODdm?=
 =?utf-8?B?OHNwSzgvNFpvZDdsYTduY2dGbHdRMm5YWGFUd01uOHh1VXZHT0Y2TklxUGlB?=
 =?utf-8?B?SHVMMWR6dmpreWgyYm8wY3Y5RWNqcFdDVjVYQ3hkQW96TERGMmZuU093TG4y?=
 =?utf-8?B?R0thdFUvMTZ1YlBtN3JBaXVSMkQySlVISUJuZzNVa2F5dFFVbFBTeUhSVTlu?=
 =?utf-8?B?QU1sTlJjcDVXNVhwU1RUTVpQTkRwbDdKSkVDeFFlZ3R0ODFrcVV2REdOR1ZT?=
 =?utf-8?B?d0JaN2M4N1dKY3lVcktqUHdySU1xYWVvczkvL2JZSlVPWjNMOXYzMFhuUEV2?=
 =?utf-8?B?S0JQTVdNamRtRzF0SkcrZHNkQWFacFZtVEJ6OXZHb3ZDVTdYZ1hYeUJ5WEtO?=
 =?utf-8?B?TmNYbjdWTkFTM1MrTlg3S2NaWkl2VmpXRnBKMGFuOWRCWStwZy8reUZnMGRp?=
 =?utf-8?B?dXIyNWZVTmp3RGlxVVdPeHdiYUpJKzRmVi82aE5sUk9sNHNsMUR5YVVWRWhI?=
 =?utf-8?B?Yzhvc01VUkYxNEJ6SjR6YkZGckRIOGtsenUxb1ZMdkhRWlh1eXlwM09yV3lk?=
 =?utf-8?B?SCttSjRaanZ3OWQ4dHVSNkpzeUppbzVBcEhMd1NnQ2dlbzR5N2Q2OHRnQXZB?=
 =?utf-8?B?dWg4WlhqeWZIWmpWUWNZQk5GclVBbWJiVzRPbkFSdDZ2aWFoSTFtU1ZMUVNs?=
 =?utf-8?B?cU5kclZNeDF5ay90VTZ6bG1ZbnhBYTZ4QkNtVkErd1M5MlpDMWVOV1JlMDZo?=
 =?utf-8?B?c1Y0WDZKU2dBMjF1a2c4dGhyYXdIS3Jqb2hQT2xqV29xS0VUTGxrOE9icGVj?=
 =?utf-8?B?cTZOQ3pzYUpXLzJrcHlZQlpKZDNZY0NkRlhnNy9UTjA1Y2d2NjVlQTdFMWFq?=
 =?utf-8?B?WWVKa3E1ZTAwQzF5MnZ0bng4SmVBSnJhWklPc3VQRVlLZXpaVzdHcGI0UkpV?=
 =?utf-8?B?bytvVDNzOC9HZ3NJV3Q0MTZUZmFSZ3p6eElMT2tocUdmS3RqUnU1bWpVM3BV?=
 =?utf-8?B?QTNHcUNxL010V2s1cTdIemwyZ1ZjUEFnY1ZXelExZFU1TXY0SE5IQWhHSmI1?=
 =?utf-8?B?cStBMXVGUnV4dnhoRm0wZVZhZURFbW5PSEswbThJVXYxRHBPTGJEdWRKNmZD?=
 =?utf-8?B?bEh2Nml6V0N0dklXYWYyTEVSdVNlUDRKbmV1MFpKZ09Ibng0NEJta01oUTRo?=
 =?utf-8?B?SWkzZUQxdFJwNzBTOFNZNjkzbEtVVEFTVE0zUVpDRkVMTkRldStkMFZRYUxW?=
 =?utf-8?B?RWVISFlUWWtEQmhoY1A4RHl5VjAzbVZvV3Y1K2pQQ1RaNmNlVUw1MlhpUXJH?=
 =?utf-8?B?b1pseGhuVlVBVnFqOHE3WlVYUVo5K3pPa2NweGFId1ZEM3VmZGN5ajFaMFlD?=
 =?utf-8?B?N1EzMkZ6WVFObHRTL2UvZ05MRG12elpmYUVuNFBjMTY1QWxMaFZLWE0zM1Br?=
 =?utf-8?B?eG9oMUZNd1ZwbmEzdFBJM2xhbGlGYjJKZmd3Uk92YU5PSjJDT3YvT1ZTUXBk?=
 =?utf-8?B?Rk9VWkNvYlBiaFcyWHNoUTBNN1pYUDB0ekh3THMxSUhWNWV3MCtmNjhvaEsz?=
 =?utf-8?B?U0lObFFhRUlBVmxNOEhBNndUZXJvN2VlblNQdHlvaEFCb2xPN3U2OFoyOHRv?=
 =?utf-8?B?UUJHQjZVOFlIWGxJb1hvOTREQURpWkFTVmtSdDZ1ZHlIUGt0bi9iNDVhOFkx?=
 =?utf-8?Q?FU4LRdn2wG5rxoA7EaX9onx6IMW1BvyFLlbpD2GjWdVvJ?=
X-MS-Exchange-AntiSpam-MessageData-1: mh+4hV3Be6U75w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ebd124-6fe7-4adc-a5df-08df356d9d4d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:35:01.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40RSc2FmDTK+aA8yxNPV5Y3IJTf9sd/nCvWaQGcxOlcjTmjXh9cWMpkG/IWUFiKaHfdRlHMijzCwGIo1vqM8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

Tegra264 exposes its integrated GB10B GPU as PCI device 10de:2b00.
Its power domain must be enabled before enumeration.

Match pci10de,2b00 to let the generic power-control driver bind to the
GPU's platform device and enable its power domain before enumeration.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pci/pwrctrl/generic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index 4b6cbbb52248..393ef7dd96af 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -118,6 +118,10 @@ static const struct of_device_id slot_pwrctrl_of_match[] = {
 	{
 		.compatible = "pciclass,0604",
 	},
+	/* NVIDIA Tegra264 GB10B GPU */
+	{
+		.compatible = "pci10de,2b00",
+	},
 	/* Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller */
 	{
 		.compatible = "pci1912,0014",

-- 
2.55.0

