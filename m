Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D72C0303;
	Thu, 10 Sep 2026 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001793; cv=fail; b=jlb4ayFKIV9c9601ArPAd6FLkc9IJzcFibMRu0DeOLw0OTyhTK+M+qBiIFATwrkUF9VzaSHIMSBQwo1kM29PZsRSAmgJcXbdLECvCkfYmYC3MmMmg4JW3J1ikGsil3vw/2S+merJRwQZvEsWqRhcXVLZruiV9kSqzZlvBlM1+k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001793; c=relaxed/simple;
	bh=sSNbf/2Rkgx0tag8slK0yO5VluFdM1KryVoCRVFb/s4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SlmuUalCnUNuA23LjeXyrkPyVboFutLNnApMM7WXSYbQoDwu/Hn5wUspJ8S+uXKQ2xMzDMHprYwJf/MRD8Po3b2zt04dADgnMFI9BFCWoGuBT7Qd4i17787FvOoBNWif8TEIFwNLT177m5HSZ/92DF6aMTHZX0d4N/aR1Ok+hIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fCsBWIbs; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fCsBWIbs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIAImndF1ZyyFbbeltjHkpi8rNUgAktJ5+Et5w/2mfNJwAA5VpTcRQ7Wr7xmWNEHiqZKPwlGNGosp2gONAAtTp44X01Uwrvy0kPzKJTdVqcNgrgEE0sPTC7iUPGOkdEwGLRTnWO4xCJ6EmsQKdV7rqFC7JGGjoOL411D09CRLHXCMb1V9bu5Aa6OY/30xB+OQXLFK7Y8R4StLKL7cYiKVZVd7Myn1QjR9HqD0KfCGzYYPEAc6D5qJ/nLiJpOw6RBvGY+G7lGs4JEwAtg3JTHUJE5PBUtOmuMUjdd7ly0v0niuhAxoWhgFJwC6Wr8C1C7i1+JQ3T0JzxPh+v+6ETFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCUG0jg9SxiR+bo5N4moYPb7BpVetL94FDo4pYZGw78=;
 b=gm3RkceSDk0Tnpswvp1ozUuxgH4QiLj2skpPQgfZLTkJC6L7aqFKD51u2/SBEAyfRu1ZXJ1sQ+frvdZzaUKnxjZQGFXnPKyxY1Rsn4QTEdEhtVH26JFxZA1qpxETgrkrplUQ8jEtEdQK6B6bf/0VjIGtPnrM/OSgnOTYe3aWalHo0bax7xsOkKq7ZcPeRmEAADmcueRS61aKmxYwfYq+Zfm9Y4JjRZjZ+KMtP42clFAxrdUSABfLFrnKLPtnjzr4eeq7Jrzm4ww8m1IXw/p8i9mu6lnkK4voi7C1BtsEFP/7FsKxqdVWeyC5iJtUQIlNTEQrzduzIV8L41vkdIP2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCUG0jg9SxiR+bo5N4moYPb7BpVetL94FDo4pYZGw78=;
 b=fCsBWIbsATVLoRnXJrdyhUB/shq0e+qWIvYkIG4UTrTWSsdNItfYDynSEGPdHksg5/zk6bc4HTxKk9PlqDl2W/Jm5H/lJk2w3CW3dFR9XC05Uj9k7CcCfQVoXUPUEwW7zGvzSUiAsCifbWhIXrB+jKQbeZ23G7Dh0/ZHBYaAf/kK2YAbnv8m/El0T/2ZLjMwiyEeFKlYTD9gJD3Zr4I69rlPJWApYN/5o8oD8wBUopNuhcxsVmFh26655/O3201UfOnHzrJ6gFUTUOTvstNrPdUeqxaEXs6FZVcCh54cgUN1Ov3CdbkD0Hc9vOYhjBnxOxg7fYfcLsiXCL7qb1hLUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:56:24 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:56:24 +0000
Message-ID: <c03eab2e-e773-4d38-be84-48b9bf9bff75@nvidia.com>
Date: Wed, 9 Sep 2026 17:56:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <apqLmL07mEji7e_k@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <apqLmL07mEji7e_k@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::16) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 689bf6ce-dcb5-4313-b782-08df0ed6560e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|5023799004|10067099003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xLQDRKQJGU2ItuzhhyPb2IQ9dvZoLXsbQns/WUMKmRVl68v5JwmGWeQRnZAaHjCjGClQOaQhEly2bgw2ZfUaRfJk55CqlC3ClRWfQOAoxT0hNyY7pHriqK8N4C8jLAeQO9gxfmpQCU1L/f3zsu1tqxr05gpbKXt8Lc32zxkMJEknFkfyynVaVuHkhGZKMAED2Hm/LsNSfmMtv+yJa3yREYs+qZaPet1l/674GfLA86ZT6PqnKU0sKytwxK5uVhbqVqckMGXDHr2fn7EbHj4naou+OVfgkHq8Mr3ppOcSpSUy6Fc4AtS9si/1yachr/cRvCrq5aijjEaLSOH/7VdP8L6TBPDHB/5taI5q1/we8L/8S9O467tyxyZVB7aSEus0NOB5lX8aSE8+pqzsFCJEnFb5pk+aLxbQaDd/TEw+nVmDLl/4kSFc3TYXkaXkNVjdZV3l7LuHThy6/oWC4hQLJg/yXsInmsKomK0f9KJNSfefFsAyPFFAQiis0sE5RxelXMW3WZAND3XRL1VXaFSsTOFXDldMFzZeV2D9rkcOJAop1KBZudZU22rGZEjzlgLuNlYZo39tMKRvcondg2bIGER5Fp7/MoPU0AWRkQYdKtDuzgZoDa6a0w4kaGBcNoLPtiAm2x1QT/Y3zi0lrzGYmE3xF3AsrsCOywX09R+rysQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(5023799004)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm4vNTJROHZqVGE1Z01TZENZaXNnaWJOWEpWeUxUa3FSRVpYeitjTk9rUkV3?=
 =?utf-8?B?RWM4cnNhbjV5ZHpjYkhJQjF2cVFMMnpDV2I4SG8zeTFzeGpTWkdObkFDU2FM?=
 =?utf-8?B?ejdtcGZLVHpPVFlocnJlaUlpYWJ6UWUzeHhpbnFoQnl5amJ5MnN6T0l3ZnFl?=
 =?utf-8?B?MjlVbjFjQjMyZDlMVU5FSmtkNjk1cHh2ZkpoSzFDSXZNcnNEVEoyMVZwVWF0?=
 =?utf-8?B?Y045NjROWTNFOEZEdmlKMlNtazJZU1h0M21haXBTNGk5SS9UZkNSL0ZGdlB0?=
 =?utf-8?B?QytkMDdWK1Z1cFNVM2tiRi9UaVRQQ0l2TWxIa0RtRzd2MkNGc1Y1azJBRnB3?=
 =?utf-8?B?SkN0OGJhUmtaR2xoWVRxUW5wZ3dyU1psczRlc3g2QkJQRnNTMWptUzg1bzhz?=
 =?utf-8?B?VTBWWFRic3c0YmxxWm0xUTc4a2lNUVJETUMvbk9udDFtMlhVZWVEQU9rUFMv?=
 =?utf-8?B?a3B2U0ZZSFpobEdHdXdrU2dsRzF2WFY2TTR0OVJJVzNvUVQrdVhnSTJTZ0Iz?=
 =?utf-8?B?eS9vcXNKWHBxeW04LzZGZDAyUUIvR2RzMmNOaEU5OTFoUmZIV3YxUnFIL3B1?=
 =?utf-8?B?dEJOYnpPalFYVUlXVWdrVllJY0VFcUxtRkNSMmZXYUdEamQ3dU9KZkNrRXpB?=
 =?utf-8?B?ZUp0eTRFa3RmbGxhdjZ0T2U2QldHeE0xaFZQN3ZacEcxZ0ppRzlQaTJxSWxw?=
 =?utf-8?B?N3ZqOWpseG5Oc0JlWkIrb2ZaSERFK3ZVNE9TbFk5bFZPYkExK1JMN0ZzQ0Vp?=
 =?utf-8?B?RUw4akJhaENqMFN1Z1Y1Szk0cGw3RDdKWFl4M0FMVXlNckt1Vm5nSGZKcWtU?=
 =?utf-8?B?MjE3YW56Q2ZBVWhoUytjanRIUlpkTEp4bGh3Ym4vaWh4YUpMZXIyWHI2a2RP?=
 =?utf-8?B?QlZLbTVPbzdqWnZqNWJKeWdHNnE2UjhpeVhVOW9XL09UMVRDazd5Uy9VcDNN?=
 =?utf-8?B?NGhISG82TEFLbjE4cyt4cFlMMk9XbkpQa2dwMmhueFBrZXFmSzhJd3p3L1BQ?=
 =?utf-8?B?aW92Rnhjb2N1TjRrRElqYlF5VGZWWWRQei9CQUlrblFJdk5oQUVtMldTamo1?=
 =?utf-8?B?Q1JJaEVTT0pIcGFkS2hqems5YlNjNWttQWJMWGxkbVpIQVVQbzlWVjkyLzRu?=
 =?utf-8?B?blRzbFlTRktBa21NOVRoZURjMVNmdUtnVjNZeXJLay9GQ3EzZkdTRHdqbE1z?=
 =?utf-8?B?Szg4WFhkdzdLemJqQTBXemlGZDIyandIemh3SXh6THJJeWp6cGN4Yk9LelZp?=
 =?utf-8?B?Q0tKcVQvdjNPZ0l4U283MURxOG1XVFhjNStZc3E0R3FXUHZ2cFdTZ3MydEtu?=
 =?utf-8?B?UlFWeER5Q0xRL1d6aGdTRldIdnZFSTFGQVk2WjErNGV0dW9sSUFocDFZUXV2?=
 =?utf-8?B?SnJtK0lFaEF2Uk9zdHFGd0ErQVVKSEFtVEs5YXQ4Z3dCV1BhKytHWGdQaGpT?=
 =?utf-8?B?ZGdlMjhUTXpSZlp5MUdESEFLR2ZmUFpleEg3bW95TnRianZuQ0RiREcvblRG?=
 =?utf-8?B?ckNuVTJSdlkwdUphZWJWejNRUWd4RUJLOE5teTA3YjFLdlRLdmlrWGRWYUhD?=
 =?utf-8?B?UERUSk9pQVRLSU9uYkpqL0dYTklXMTZKWlJVd3lTck5qVjVZcjl6d0dwQko5?=
 =?utf-8?B?OTlVSjFaS0F3WkZMVG1ieUZTbythSWg0OW5aRm9NV2lJWUJpZ2ltS2lJam1k?=
 =?utf-8?B?b0c1a1ZleU5teDNGMGxHUU9tUVJCRm9WWmFZRTFKQTRiS3FEVVRKdDNySDY1?=
 =?utf-8?B?QVBIdHJrcmFacnBmbVNjVm5relo1K2Eyd0VoazZBWFhPZ1hqZXRSYXpVZWNj?=
 =?utf-8?B?ME8zVC9WTm53UG50a2puUTc3czYzcWFWNGJUaEowSUlUNjN2MnIra1h0amhT?=
 =?utf-8?B?dVd4SDJWV3RvVEZITS9ab2xqVlYzUXhuZHdLamtvS2RLMjB4MDk2NWRFdTdG?=
 =?utf-8?B?ai9mNVVPT1RYdWZEclZNaDZpNVQ1NFpJbWVTZ3JpYkhDTExYUzk5djg5OWZE?=
 =?utf-8?B?Z1hOUW9ZVUdwOHpVWnY2ZTdBZzQ2RjB4TDJFVHpGajhXdTVKTGVVeVcyR281?=
 =?utf-8?B?ekswWmo1NkZCUkZkNzNPK2ZmTXhPdk02YVBEVCsvd3UwbEVKUmpkNEt1QWFB?=
 =?utf-8?B?Z203RXBSMHUvWU9zTG5UR3NyTEJnYlJHOUJWZHBqV1lscExrVmpuaXNGMGlu?=
 =?utf-8?B?VzNGZUFCQTdYMkFaN0VsNU5vNzNrUDI2MzhXRWJlUnRYNG9RMTVmSlpQb3JX?=
 =?utf-8?B?emxveEVYWWk4ZnAzaXlUckNSSU1uaWR1SHlPQzZ2WXpEK0dJbUpEYURWMnd5?=
 =?utf-8?B?Zy9oTHFSQm5lTll5WTFZU3Rqckw0TlRCc0dlZitSa0MzSnFycmtSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689bf6ce-dcb5-4313-b782-08df0ed6560e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:56:24.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gab2F1FQ9FK7Y3r98cQGdJXGs50v2LLfJ6pdnDzKVNu+rLdJaFhUS+HYderIeSDbX7A6bROWQ9/sQuImFAwVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618

On 9/4/26 2:15 AM, Richard Cheng wrote:
>> and the kernel must have cached HDM state sufficient to validate affected
>> ranges and restore decoder programming. The reset preserves device
>> memory; it does not request CXL Reset Memory Clear.
>>
> It seems reasonable to me, the whole approach.
> I wonder if we can document the complete reset-safety contract down ?
> 
> Especially what guarantees that all CXL.mem users and functions are quiesced ?
> Besides HDM EP , what are other EP state that should be retained or restored ?
> 
> I think it will make people understand the mechanism more easily.
> 
> Best regards,
> Richard Cheng.
Thank you. I expanded the v12 cover letter and ABI documentation to 
describe the complete reset-safety contract, including the quiescing 
assumptions, state restoration, and limitations around memory offlining 
and mapping revocation.
-- 
Regards,
Srirangan
