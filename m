Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0B356A2B;
	Fri, 27 Feb 2026 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211566; cv=fail; b=K+Swawis80RAoBJ3XijAXIBf863OuT3qnm0aNz0a20Jo6jgM8ccrjjKFo1tJRPWwbM4i6pukH9uMZWsS9ddBVBOSukxQ5tqCMDx4gnpW1y2fw3K2w+v7dEdajCdPDG8k/rucP84mw2f3sZ2zZKanue7aMEyEi6EVHOkapmWtTQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211566; c=relaxed/simple;
	bh=AV3H2iQhvX4kw2iSMrEn9Xd3sNO1UtaZrzTuuojX8Eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sY5DvzdhcJem14p9NGhLUgt0CXkmseb+lIV0gsB4AgAG2DkZXmz5w/hTNCnuQSP4F6X97KsOlrLW5Qj0+gpxzywGGu2S93PEK3v3xyQA09yZs1h8bVB/o0AbFAoPfPDYSC457ShFbsevLwRSQZuEmrioBE0+ICHjLK80veXbsbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GK+HUF0r; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GK+HUF0r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7bBD3aDlmVsiIPj5dWNtfbIlRt3PnQoj/0rAmB2ujVCADkMcI8rLMf9aYDhp2jkDJ1finxjMBh68tC9TEaqWSRCxn4MXgiF8gi+KfVWxoyYsA7NlfcgaPJHSv8yjrten2rw7oz0l2RBfT0nuRQDsvTyBuMWlIiQj7LxXnFgFOSHfxsIFssOBrkOVhF+1oqHR4md0hoT3nrwNXpSkWvQpGg5shrjO5UhrgMBSA974FWCAOSoUfVQDdGCXpp7acTvZm/CPCByN8MAUGRizMA0PFMcPFxHGki7z9zKY9f9l18qyTve9CypyfjB6mRGuVDOd7hFIyR1n5CXpMyyP4DiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1DCdWtL1fQLWFX91kTKeow2bZBGovM4pZqKvpLzknM=;
 b=PnlyhyibP/J6IsWKsV+dJDDqen6/k3bFtq02gNI12myayH4gT8A4byUCU4QWkoBTco6YqIJYFQZzVcAZ9EkP1OmbHc3QPSZy4NR0+VMH7TgkmySDSpTMAAcbUbiXiIgt5WXUe7j9cjw3DhJNI7XmXZANt8ngT6wRlHl6LChg3YxO6sqUM52jGyNANSY3GvV0WuNjv5/sc+cqQcm9G6wnn16RPjRCbZcMYRsE4hajFK3YYrnd9sxpa6dxH/MFbLa/6RZHW89zKv6CflkuXVPJ9hU6V7HPdQ67a51z2EAEVx0NNEHZCZR8wfTGbaMbZKedv/AWYSHxoeflKEHZ2WXQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1DCdWtL1fQLWFX91kTKeow2bZBGovM4pZqKvpLzknM=;
 b=GK+HUF0rB+9HzvaZYDScX5KWCUKR/qNyCtp4apDkxnyqJOH3gwp/HuzohO8eq67IxqqAwtl7PzimAt+45AtMN1baUhkLlWwmnCDmtK9fGhToeuVEI2BUJD+a/evRurw/ub+AH35AYHmxWZuJR7KBU2yoXY228CweEIIszzyyPSh0kejdHIoySIlqP+BCOCgORQ8Kh5/gQ/8FF4Zh3Tm1RvHoomii7y03Ak1HlnAZ6z3/ZwI7MMM5lF7MOoo9ED1LpAqRfSlvWPqM+aBJcE2cEF/6QIaj7ee8O4gNOourgjumclWEdQ4gOyxIj1MfKCeYKNltLrI/mo01XLoBzI57Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 16:59:19 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 16:59:19 +0000
Message-ID: <c8ac9a7e-5f37-4e5f-a33a-f1c3e94b4d19@nvidia.com>
Date: Fri, 27 Feb 2026 16:59:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] Enhancements to pcie-tegra194 driver
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f373997-55c3-4f6e-dc60-08de76218c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	kda7W/qe1IfzN1IIGjgH0CfCUZJaZIV92n8GDpnIsVLhFYYYWv3KO5ZMGQZJBBRpRJ0qlWyi2dhbD6TGVySu+0I/D2+stRmBpC9Z9B1d5uk3GCtp/GKbhKC0JvCqtppIpxPcC5DAxqNCR/ePcJu9+nGUVi1lJ++h6bHVuIQPCNL5sYyPKUn3hbxUYu/1ZS3wRT65uV+PihmBVkScLKpcVTA1+rRn7Cr/6FaFry98qkuTkRuqlmygWWiKd9hfJh4UUK2GJXxOKVwsKCOdaYGxYXnSOJLcj9rRprj3hpdT4EeYwJbtBlITyH+2GN/JkFVC8MHZtyWB3XYJeaQjMLPkeGOqW2p/DsaEBRo2XHFAre2IPaiVgsW4mTOiVBbm7EuG/hAiCpuhP6iYuVfh7QGA8zLJBLMWqyrW5YYO2c08/CuYnIU120cgvcU+Ce2CJtNGMCum6xUXpEhjECsP7FQloCy+kgp+GKquchM0x0BI4IinuGy8iuxdow2GUAtI2y2VG2dsUrrEn5SJAEU8Pzd3ZXuRUkDM4/QDsUx6ZtAeVkTOD5HOcVqY1YKdHbLe6lBTyaUCwreYk4FYQoyMaNY/mr9VFhr7d1dIFW3yr5lX4pa2xljsJRNXbTwkvqniTIEdavygF6JTeNIvKcIX6VK9JAVDHEbJkOE/D/BD/wC8SS6jza6t7v9FMR6cl7FxOmHzeKE7cBgPGpO/gX0FHlguVI3sp9BNcq1JtbvKwlj2L+qr7X107W5Un2h7p/mZ5sMFfvF61Om9p9XwKmBSSzaVL4G2hsOGJcL15Zqt7J8HEss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3VqMzdyd0FBdXZIM2Zma0taT1dHUXZkVExTaWZML0x1ZnI2L0Z1WFNibjdF?=
 =?utf-8?B?Q0pWVnFyVnFGaDFvcCtZdWl4NDdmVWlFKzFXSklrcDlrNFNXNUIvc2NUU0hH?=
 =?utf-8?B?RmFnaU5BNHRFamhZZmFNc28rT1BlcTB2VnpZRmg3cFpOdFRoaHlMU2VzNXJL?=
 =?utf-8?B?RHBDSE8zRFJzcER0a1d6WFRWU2VEM2VrM2tMNStnSFJDdjN3eUdNTlY1Uyt4?=
 =?utf-8?B?VllqWiswWXhHajVLUkhnQkNxZzBvenRKcFBEMkNTK2h6ZlgwYXpMVWlUUjVJ?=
 =?utf-8?B?Rk44ejl6eE1HUmh6OWJVVkx1dCtmNVVrV2tlSlF1a1VXdERwVUF0cUVYVnlJ?=
 =?utf-8?B?dTdWUFJUMGU3cEkxQWZ5L3ByVTJTcjVTWEJaU2g3NEM1Tm1ld0Jzc1JuTGRF?=
 =?utf-8?B?RWo3bFZPNitabjFuc0hSYVprT044NFVrL2VDWURzTFAyZWFKRGRrYWRJczB5?=
 =?utf-8?B?VGVKQUc2dDVvMERpODVuYmxkQTVNLzdXQnM5Z3V4Mldwd2V0RENmdFJoTEZ0?=
 =?utf-8?B?VUxSSW11SHNQdlpZeVJyL3pCVlB0WHRxdWF4d1ZwMDN6UXBDYnZWaS8yZG5u?=
 =?utf-8?B?Qng4SS90TXBsUDFjb1I4R0RiRTF6UmRsUit0ajUwOTA0SzR1WVBYT2F0dGNv?=
 =?utf-8?B?SjB2U3AzUVhCQzN3d2dlOXJGa0F6MERoR1d6TlpHMTNkajVRUDQ1cUp5YytZ?=
 =?utf-8?B?MTA3WU5vT1FoVEVzTFJBRXMzRWJ5RnlIYjlxaEljSy92ZmtFeFlTNmg4NjFC?=
 =?utf-8?B?a3Q0c01LM0hNM1BBMDZSVmNWK3NONm1xNzJncU9XUlJ6Z2FuMGNuMWh3UThM?=
 =?utf-8?B?KzB5UXR2eU51RWljVXFOSTN5L3lLdTV6SzZPQzlQTWZQN2NmSTY1UXBNVnUr?=
 =?utf-8?B?SlB5a1lqc05vUk82WHRnaUtuZVQrNHVRT296Y2xDWXQ5UG5ad0F1aHVGVHVX?=
 =?utf-8?B?UURoa1dJRDk1WlJWbHNxM1dzazRGOVZNcVFyVUc1R2RZdzBwWUplTWpDQXJv?=
 =?utf-8?B?SGRuZzZMcG11SzdzU1kyQmZ2TFg5VzI2TEZObm9KanZMaFVTN1U4blVBSkpU?=
 =?utf-8?B?NitwK1NRMUlqSUoybXJFdEQ5dU1PNnhKeTRHY0dLSk5wRUNOWUNpWE8zQ2pM?=
 =?utf-8?B?Y1prYjQ2NXBNWnNDYXJoNWdvOHVJWUwvdXdEUE82VE1DUXFqMXdtVVlZcE9a?=
 =?utf-8?B?aWx5SDdud0d1RVFhUFhKbXFMQ3dzREpKV2JpUGJHd1ZnaVNrc1JVS0ZGdVhU?=
 =?utf-8?B?cXI3djFJZkxMVnlwamNzaUp3S0FBWFVqWHE3UkFmZUFXVlNWOUtjTjJBd0RO?=
 =?utf-8?B?OHJ2cGZoU3d3UlVwUUVkT3VGcWp6aXFqdko0S3l6c1JxaHExNWNUK2pnSjBy?=
 =?utf-8?B?Mk80YWEvWGFxYmZxc1hleElEdXZDZk1MUGhPVTBjUis2UmtoU01OZlZwU3Vt?=
 =?utf-8?B?NXJnb0pUcUdhOGJIaUtIMzl3KzF1ckJVWEhCYlZoNDBibHo0cTQzRW81ZjN4?=
 =?utf-8?B?eTBKWTMxTlkvcmlDV1ArUnhLYmpzQXVuRHBvRndTcHNQTEJrMDFOWVp5bjlp?=
 =?utf-8?B?NnJEOCt6RE9rSzVLUHRoV2tZSlBWMkNpL1h1blJvb0U5R1dXVStRQ1IwakRQ?=
 =?utf-8?B?bzhEN2pWTksxWUswR0h3aFZVQW5CRFN2OHRvTlNiclo4V2hzY0l6ZWdON0Fl?=
 =?utf-8?B?ZnNLTUlpUWRlb3dCZ0pRc29iNDhLVGE1eFZtcEVMUzRhVWdqTTR0bEhuQlFl?=
 =?utf-8?B?c3N0V0RieWhKbStsRVNSQWhtZE81MFVla0xVc08yZ3lGVlBGbTh6ZFh6Q1Nq?=
 =?utf-8?B?QjhDMkVRRTZUMkR4clNjeURrcVR2SU9WK0p1cFFQNUpaeExwQk9ObnZZMjVX?=
 =?utf-8?B?V3RVWm94RHhnaEU4K0JNRVUrLzFiQitBTXZ6R3VPRDdUZEE1WWJQQ3ZKRENs?=
 =?utf-8?B?VDFibjlwNFk5U2l6YjZtQi85bloxcUp5ZUxleU1jUVFDMks1SVAzSkVvNTkw?=
 =?utf-8?B?Y2J3QTBpTmR1M29aWXpFd3dGZVZxMUZZcmdzU29yaGJDNkpXeVBiUHhVN0tC?=
 =?utf-8?B?VmowcFROSUlONWZZZzAwelFYcjhYUGZVb0FIUmUxNUNndjdCT01BbnpUWGVu?=
 =?utf-8?B?NjF1aElUK0Fna3VoUEoveGhCck9mSEY0WUxScEhzc3VRd3U0bTk1aGZPRit4?=
 =?utf-8?B?T0RvVFU4U2xPWU1SR2JsalhnU3hZOXh5VTgvd1FsZitobURFei9MR3RTMHNF?=
 =?utf-8?B?K2lNd1hadzhJdFBUcUFlQUhjblBwR2h0SFJvRmZ5aCtaenNtc1oyVjVpTUxP?=
 =?utf-8?B?UkVVbnZHQnBzbFZOWTZQMUJWbjFpcHFXTEN2RVJiOGhaNjladHJjSHJDWjE5?=
 =?utf-8?Q?cbHaWmiwowwuA3LlXDCtKAaRnuekA/g17iOIzGJ4Gu7jx?=
X-MS-Exchange-AntiSpam-MessageData-1: qn3QBfVx4y02hA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f373997-55c3-4f6e-dc60-08de76218c21
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:59:19.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGxDpgaRk2XY1AYhRvjjhzcx6G9DdaP4hrGD9OH4mQ3DOh486ITc55L92NzaUQ3iVJVYD0ZCORGxZsft7cAQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656


On 23/02/2026 18:45, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments and split this into
> two series, one for fixes and the other is for enhancements(current).
> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
> 
> Disabling L1SS capability based on support-clkreq device tree property
> is moved to common DWC driver, so I reworked below patch to disable
> just L1.2 capability on Tegra234 SoC.
>   - PCI: tegra194: Disable L1.2 capability of Tegra234 EP
> 
> I added below new patch to tune the ASPM parameters, commit message of the
> patch has the details on the bug and fix.
>   - PCI: tegra194: Add ASPM L1 entrance latency config
> 
> I added more context in the commit message for below patch based on review
> comment in V3.
>   - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
> 
> Rest of the patches are same as the original V3 series, just rebased them on
> 6.19.0-rc6-next.
> 
> I fixed the missing PATCH prefix in the subject in V6.
> 
> Verification details.
>   - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
>   - Basic sanity Link up, configuration space access and BAR access are verified.
>   - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
>   - I verified suspend to RAM tests with Endpoint mode.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/
> 
> Manikanta Maddireddy (1):
>    PCI: tegra194: Add ASPM L1 entrance latency config
> 
> Vidya Sagar (8):
>    PCI: tegra194: Drive CLKREQ signal low explicitly
>    PCI: tegra194: Calibrate P2U for endpoint mode
>    PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
>      registration
>    PCI: tegra194: Enable DMA interrupt
>    PCI: tegra194: Enable hardware hot reset mode in Endpoint
>    PCI: tegra194: Disable L1.2 capability of Tegra234 EP
>    dt-bindings: PCI: tegra194: Add monitor clock support
>    PCI: tegra194: Add core monitor clock support
> 
>   .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |  6 +-
>   .../bindings/pci/nvidia,tegra194-pcie.yaml    |  6 +-
>   drivers/pci/controller/dwc/pcie-tegra194.c    | 67 ++++++++++++++++++-
>   3 files changed, 76 insertions(+), 3 deletions(-)
> 

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic

