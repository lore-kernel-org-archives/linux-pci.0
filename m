Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAB402B83
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834342; cv=fail; b=D4GgNTzIbabLKjr/NVvXSx1E4rBfknKv/VscQyb/Dyhq5jUtACMSWqLJWJcqdfgefhcH2fuI2NcV6vV5HrWrEv7YesuRZA4PFmKwK+oX12Kb05afdCwmCh/sbqC9IWLgGfGrKR7asHdgJRUhpHqaw/WaCdTDe/dCzwvgWt/KV4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834342; c=relaxed/simple;
	bh=EFQXQYLUEJfommZKv6WeRgPNiiAqDauspr86zoEQi0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEJ0EZrtglIGW3IF2ZDpDKsFuFF1ngWPThQLtTe9qk+znkICmuGawyzyh3Cj5oq458Q6Pvyj0PD+KdGeugQNVgIffLHXx9jL2DO+LkLfH3XL466LXHqkolZcQ4LzeYrZ6PeXKjfF6CYrha6jEHmXWZjDgbLm5KXUob+bGodnwwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXHhrh2V; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXHhrh2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsrETHKW3jW77nXEFwEFp9eZCvsnY26Ab3W34uEnruP2KI5nsON2Z4iThxMcgt2YCCL/tYA/0l1B2tscrUGnE7ReQQMQ7LmdPVNlHo8nTsjIvuoNPkRnpa09ecDSXODNLtIx++kWKHRKp+I+GQ5c5SSHWlWKYdd+vyc5/oKZp2WNassZBnSSc2VA8Yi2/wEF8Q412CD/B6RPFKRC1pLf8Oq5Q5se48X8tMoVreXtvNbzJvYbNTi1IwskwalZUXq4npatpsjwnrP+Uu0uIEmlcxFjHbjm/F+8972tElJ0lTP5NOdeITW25f7zuLtkHfr6fCQXHHJBl15V93A2VJT83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dab8CQLtdS/Rlmbd3TuWb3H5ZpzCJuG/RUQJIf6EZx0=;
 b=n414gmSOQ6QEY1zwCrubp8WPt+wfKDlx54GL9S34NwNbT8uBttZ/VpyH9gVelfa3m3nz0fc/sFzjDT26T56aTe1VEIl+eTOisra+WRsP5wTz0ZLPfnlpI84/ptau3QXt1Xbb9EQm93yEYLMoaVg94wBp3ALuhvf4SkksQEVqYUIubrRbBD15WdevAV1oeNmewMZvAjpkJGwxnXlYCPSpOpoOTEEG9kf2uShgrVWy/J2Hh1Wl5Qb+1OhuBRF04M7HcpCz/LkHWzE1dZcmaWcjvJfcB1rYxB9QO4Fj/J/88e/8K7lmaDLLaVVAIfqRLG7zKzmAecDC7esItiJ8kZXgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dab8CQLtdS/Rlmbd3TuWb3H5ZpzCJuG/RUQJIf6EZx0=;
 b=eXHhrh2VNYrcrX7TgykBbaX0IZqvQ73TcbCsm7AwH6XCfSyK6uKE7VJJMmKRXapFhacqYKFp34YKWPrRiBO31q/pqu24TV9oo8IKJqw4XgQB3jYtG7nkLTHd05CG/rHrWjtalBwyNaRtMqrgArrVp0dkEvB0jbaDtovI6AUrZq6qzzh9nYhgsqw0NrqMFZ3FMfuILe0bG5thWE56yFIZFBB0qOBMadoyXKfO9MqoAzKBpifITerAq36fpIqCPp/djclXO4kYX86Wqe4JFceEG3FNbpO1Jf/hXirr7Zpk+cYMj91/IhE9Fxd18QiUSsI1zTYtRZ26Zg4937aDKrEn7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.12; Fri, 15 May 2026 08:38:56 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 08:38:55 +0000
Message-ID: <d81a9587-d366-47a6-b7e5-3ead438dfd62@nvidia.com>
Date: Fri, 15 May 2026 14:08:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: tegra: fix aspm-l1-entry-delay-ns L1
 latency cells
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260515070753.3852840-3-mmaddireddy@nvidia.com>
 <20260515074512.7D727C2BCB0@smtp.kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260515074512.7D727C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:8:55::13) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: c82f3224-0874-42d8-57eb-08deb25d668e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|11063799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dsy7iz06RxdbrChFkn6lHP3sNMd0BMCtZ+XM9K+YzKc4aKgHxhzTPmDSQmfwYi50r4HgEFq9CQnRIorjo+JF/WRz4rq4of5KVor3rLMbXP6WKEaiz6pzMz6T+8T5AM4FYl544LwzCDhs66TxtxMfa0hNdLnFW0LrQx/eYzxJhg3PnjpdggOgnteVd8CEv8jHMlR8VxnCUGJeKFeOmYqqMguc8AG6iYQgUacz1MjBCBxgg8TE8Yn3+bUdafNLcCA48yDNK6F7Dbbv3NN6RB3YbCZkguAF4YFytYx1Rkb9AQHPnuQOZFI6JmRUflc1UnNe9hCIjBddlslYh0Q7ij8pRMJ8K49BRnPR9G3F6UvsaAxRsBiJwRFkEUqswA5fLQccPTOv+yGwD4WnArAcUf9/JofLOt5k3qwG8oEvJwKUUzuX03jsrOdP1+G18Cw2PPnfqNEXm1CnxS2fUOSvyiostVISVRu+jylkG0GnHjcL0t4x0K2qhP2xlBrXERgCCZLF8q1a+vWnWKYZDaMKI2xRdtmV6b3pghD5f55RTenYHzlemQpY2TADP/MolV8Y2K4auUICLS+Cu/fN6le8/CCrRWCAMpmii8W8JHHRE3ZID9AHfKrC5Ut1l1PoPQZTVo4mDWi+YLhLsQztWcGLYzIYMBGz1oFMf48/kNa2T9PTOwB48Px4WPopeI1Vcr4GCnHp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(11063799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWVQZWVIZ1FXeXpNQU1DMmd3NnYyemt5bVFrLzFvelVBM0FQM2ZjVm5tdUJU?=
 =?utf-8?B?K0gzYWMrZjZEUnlyN3lhL1ZBWXgweXdKdUQrajNTU0lOYnB4WmpOMHR1QTky?=
 =?utf-8?B?ZlUyK0NDUU80cVc1Y2l0eFh1NFJ0Z1NhaGlTZ29OcU45MmRBMjN5dEFWcjIr?=
 =?utf-8?B?VEo1cTRHRHdqRitVOHBSeFBUenZlclF6VmYyRjFZSjFTcW9Wb0czY3RkYUJv?=
 =?utf-8?B?aEk0WkZEdTF6bnNnOGtLTG13bUxDSjlSYzZMSi84Y3dkS3MxUklFVjVRc3Y1?=
 =?utf-8?B?WDFHejdKeWJKWWNvZkdNS2d5b2xhT1c0aW9TNzhaVGgwREZyUkZtU2h4bU9O?=
 =?utf-8?B?YlphRTdTa1R4TXpJRkprYis3TFBDVlZUU3lwSEx3NUFJZ3diVndmeE5rZitm?=
 =?utf-8?B?c2lNUHBUckJKN2RTL0VaNzJGQm14a0hiZ1BMa0ZOMmhaM3dLL2hsYlhRay9K?=
 =?utf-8?B?TW9IcEIwR1J3bUpFVk9JR1RQTXNPdkwrUC9rRmFKZE4zcWlIcno4WHl6RThl?=
 =?utf-8?B?Y08vaTdESTByZ2hVcUg0d29WOTZmdWRMZDR0S1ZIKzdIdUpCc0lQbFZLbk44?=
 =?utf-8?B?emZvb1dmY0FkMDBKV1plcXpZa3lLV1h1NWE5SzhPbnZFUjU0OGVyKzlEcFp1?=
 =?utf-8?B?cE5GMjRiVjEvWnEzRXc3cWVvUmxZRVEwV0JDU3NKT1pod24yTW1KQkZGUU1K?=
 =?utf-8?B?aG9qalN0QmZQS1F2YTRWY2FnYUN1dDh4bHBDSmYxcjQvU3RRM1ZTSWtEekx2?=
 =?utf-8?B?cDEvczN2Q0xpZU9aSFNWZFk5MGZhTzRJU2RyZ3ptMEI5aFhRZDhYbkJ6bmNJ?=
 =?utf-8?B?ekN5a0VKdEJMdnJORk9nakRhWVQ2alNSYU1nUjV1Qlpzc1hDQ1hhdzFsYkxQ?=
 =?utf-8?B?U1JsVTRPeE0vRDRUYjhKN2g3QWFUNUxjTjB5d0F1VjZJNzVhMDFpcS9yL24v?=
 =?utf-8?B?TnJ6T2lMbjRJWmR6ZHpsSWo0RVczUU53TE1pSGJKT1l5RHRqQS9IWGxzbXNv?=
 =?utf-8?B?NTgwOEM0MUlkejE5RVQraXZIYUc5VGIrSGQ5T2hjS0JrTWpQc2lOVlNyNkRs?=
 =?utf-8?B?YWhrenZqTDM0VkE1T04xSXJ0ZFI4KytuU2E3S240eS9XUk5WdnYyOXNFaHBi?=
 =?utf-8?B?cHV0cjRhcFZGN1lLZ0pqR1VYTnZLUlpPbmF6ZXc4Qm5QdUFuZWY4d1lQSERP?=
 =?utf-8?B?aGt0UlNDdzBRUjM2NGdNOFpoVVVQS1BXV1VmbUQxTEdNYXRSZlZ0cjJkc0Jh?=
 =?utf-8?B?elVIbENQNGptUDlXejJqdkdlUDBPM3g2NUsrVE1TZ1BHMTFCYzgyZ0E4cGs5?=
 =?utf-8?B?ZkpVSFJ6MW1udk5HTGRKdEg0QlVmU0hlWE5YNmM5Y1NmbngxM2hmdHRjSmdu?=
 =?utf-8?B?NW56UC80Qkt1dkNsZ0lwWXJTeXZ2WTFvVlc2KzhOcTNLSitlbUdKTngxcU1W?=
 =?utf-8?B?TWd4dUdBWTVnaWtwKzlJeERuUDR3TTRCejNISjFpbnVHcUk0WWJ2a2d6cStV?=
 =?utf-8?B?U1ozZXc2dUpQQ2hkbXpUWEplaXpjeWdJUUJ2SjRKdjcxbWI4TkIrUzNNQW9j?=
 =?utf-8?B?dkc4b2ZlTlVWUEVSMHprUzVKbE13ZlZiS25RVWZTeGVDVWRsdTZkajZIWDhM?=
 =?utf-8?B?dmZ3Wks5Z0owZlVZSWJXRkFKUWcxU3ExbDVUZ29BZUUySWo0QzY3emNYcUIw?=
 =?utf-8?B?MmtmVmtmc0gxd0lxV0pjYi9XSXR6d21wdmNOYlptWGEzWDdBZ1Zqcm44cjdx?=
 =?utf-8?B?UkxuUXp2cjBpTjlIaHg0MXZRTEwzWWVIN3dlaVIyVkc2RDdCOEVIaTcvd1l5?=
 =?utf-8?B?RHIxY0dSS0JsenJJblludnEvVkZ5bktSWjAvSXN5OUJscHhVZk5QVms1VkdF?=
 =?utf-8?B?dnpxQXhIYURIWmRPSkhLQlhrUHF3dmhFcktOUm80enBPSzBFdjBwcmp2emda?=
 =?utf-8?B?bjFhM0hyU3Izd29yRnNPcjYyMFM4TnNaME5TRDdERHQrVDVOYWlUTUhGOHRE?=
 =?utf-8?B?NnR0THdBTDhuZC9tREM5aWcyRk5hTmlKckZEQlJ1Yjl6NVpGT1FxNFFZM0M2?=
 =?utf-8?B?WDRxQVJaZk4xSVcrMWwyZCtFdGVqTFZoZERvTy9ZWGsvUlNBK3VRRGVtdjc2?=
 =?utf-8?B?bVY2WTQwcUFZM3p5UHcvaXBWd09tY3F3ZXF6SFJwdFJ1TnFhSlFaTnZGUmxp?=
 =?utf-8?B?bFlKaEVKYzJhSFlxdnZCRHA0cmU0MlZ4MGU5ZkR2ay82T2dSUEVHc2FvakF3?=
 =?utf-8?B?TkUwN3F2czA4aTF2NnhkSm5Nc0xVdk9MZzcramVqS3EweTNyZTNhdXZzRUlu?=
 =?utf-8?B?Zm12QXFNWkhzVDE4Z3lwZktkTzlhaGpzTkN0ZEM0LzFlcE8rMGRxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f3224-0874-42d8-57eb-08deb25d668e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:38:55.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/T9P1ANgwy+FqtxnlDJbpnkYubzgd/ORX62DBrGHkhAHjBwkcjQYTiGC26JP/HAPsBp5BU2QiJbbW8J6Df7Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060



On 15/05/26 1:15 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Modifying device tree hardware descriptions to work around a mathematical bug in the driver's latency encoding logic.
> - [Low] The commit message incorrectly states that the driver converts aspm-l1-entry-delay-ns to 'whole ms'.
> --
> 
> commit bbff94096c8fb5346fe688ef1d463490a2efe6df
> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> 
> arm64: tegra: fix aspm-l1-entry-delay-ns L1 latency cells
> 
> This commit updates the aspm-l1-entry-delay-ns property in Tegra194 and
> Tegra234 device trees to larger values to adjust the L1 entrance latency
> codes programmed by the driver.
> 
>> The Tegra194 PCIe driver converts aspm-l1-entry-delay-ns to whole ms
>> with ceiling division, then derives the Synopsys DesignWare PORT_AFR L1
> 
> This isn't a bug, but there's a typo in the commit message. The driver
> uses DIV_ROUND_UP(val, 1000) which converts nanoseconds to microseconds,
> not milliseconds.
> 
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index 1d659454a6f9f..7bbf0e892724d 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -2382,7 +2382,7 @@ pcie@14100000 {
>>   			nvidia,aspm-cmrt-us = <60>;
>>   			nvidia,aspm-pwr-on-t-us = <20>;
>>   			nvidia,aspm-l0s-entrance-latency-us = <3>;
>> -			aspm-l1-entry-delay-ns = <4000>;
>> +			aspm-l1-entry-delay-ns = <8000>;
> 
> Does this work around a driver calculation bug by modifying the device tree
> hardware descriptions?
> 
> Device tree properties are generally expected to accurately describe physical
> hardware in an OS-agnostic way. The issue appears to stem from the driver
> using order_base_2() to determine the latency bucket. For exact powers of
> two, this returns the exact log2 value. For example, order_base_2(4) is 2.
> Code 2 maps to the "2 us to <4 us" bucket, which is insufficient for exactly
> 4 us.
> 
> Could the driver's calculation logic be updated to handle boundary conditions
> properly, rather than artificially inflating the hardware values in the
> device tree files?
> 

PORT_AFR L1 entrance latency uses the same style of stepped microsecond
buckets as Endpoint L1 Acceptable Latency in the PCIe spec. On our 
platforms, DWC maps a delay in (2 us, 4 us] to encoding 010b (code 2,
"maximum of 4 us" in the driver table). For that rule, order_base_2(us) 
after DIV_ROUND_UP(ns, 1000) selects the correct code (e.g. 4000 ns → 4 
us → 010b).

- Manikanta

-- 
nvpublic

