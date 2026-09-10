Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27C1E9B1A;
	Thu, 10 Sep 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999066; cv=fail; b=qmDD5YioWzwAA8BVab3oAF7BaeHWAqIsvcQeGjQP9xfeogBmb3G4gR3xa+Vl04laMzD+Xy1YIkOQgavBQ9WubF8oIl0Ce53pwblXeFDPO+p/FKnP7dzkAblaHTWHhPa6ayfZ10+wwPtJj+T/Rh4BIMZyZ/AfOXwa+kTlZeFLvGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999066; c=relaxed/simple;
	bh=ZWIMbdSHkyrvbj81vUuRsK6MsVbBbXbk8jiBoE52r2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EV72HgtUhJH8IFc3QpLmnT8fuEnA45TrIOnfkKi9qWSp5Y+2+w4MDnEGc+Hx8NXNlTuYZJZJfKDI7t5GLXk/2IoUT2NuBbdMmmHBdmMsgmvR/VFp/DYHIMwJii7PcWyAfjlYUZDbHMzQF/KdQdlYl9nRnw8B8ucb2afEjKhVMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOzja93C; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOzja93C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ekz1clWDROH+R5kLiglan4A81hKs+wklkSGHBnsYWiUB8w2j6h6LaJjH9GBQk6oOWm+OYMkmDzluvsXuWz6osSSFqr5riWeMqIrc1JCH3xAxCGPUmcX40z6EcFU7GyAhnDrlGrH/6a/8sf96rwplAU4CMQn4u25v1yU1xCIiUUvceJI/UlfC/W9eltOBlIjc3OyP9QAW4T4HEB6vqZe5DLN1dhVA90sVSkXHZHzuJVniIaiVHmmNBQJdmnYrtVsXC34ZOkkISfA1VSwaWdzqY55gzu3XzbNPyvo8vmh4QwMc43bXurJjJ50rJxWTEf1yN322PvHx6+/+XOa5t9kW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlrDvlaEnNX26zRVnq6sj0vSLdGgjGg4FAldZLvMFpE=;
 b=DHVJ3hB50lkKNn803J3/lT25JhsCoVdXmtQagsaXg1knGuVcNM5cP6gu1e3116Rw94+ui0LsLRLGRXdWtx8UlyBkLp4x0xkyk1QlhCoNAealhmjS4WjkZRBusIZt04xWXKogWTEgtHN0UTF+xW9RiIsiH893qpHL9js6uoNJSUyjeJ0qflmBO73zxSlMOMLvmX45UWmlj6iDrXLYbEfQUJjzEhLQIDm2Jxar88nVWECFHDMfsvhE1flj0sUTbUIqt/w1TM3EsGCyiD/mBx1h9ig+bPu+5KEhSORfQQg/70raFU4hW4vq9OG/WxeTrjJR/CzfiJHym4EdUaN8Xa9Hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlrDvlaEnNX26zRVnq6sj0vSLdGgjGg4FAldZLvMFpE=;
 b=WOzja93CqwqkXZDtTu8GEARkH0yr/d07t1Fnak+KYFyPQhLUpIo6dSfrIE78RwjaxY6+88E2kaMgSTAeEDxUi4AnV4gpwf1bvB7mFCBGjpg9fJ0PQC7/af5R6P0YagQ9AZtokP1zIBLq1d2m9W8+AIeGYvhiVr8W7S+ctTCEG+N3wUqfo6d7qNUGfahJe7jimI8wePC8ln3yhu128qgo32hV5PpozlQBuxnVmxk/JoorChVwhaReR0OWuXXS8yfAOyIXwusLw9ErSbPljawCIlqL9wMZq6NxoDYhaUVC6bCgiHoNYls1uVO8Pury0cdPgxmAzMKpEQCA2dwpjCx1rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:10:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:10:56 +0000
Message-ID: <437a22ff-8e09-4627-9651-148684435600@nvidia.com>
Date: Wed, 9 Sep 2026 17:10:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/12] cxl: Validate HDM ranges before CXL reset
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
 <20260902072804.665639-8-smadhavan@nvidia.com> <apqMXYyHnu_jD4EK@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <apqMXYyHnu_jD4EK@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f491c-b3f8-45c3-3af8-08df0ecffc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MQ2Qt8gNZHkMm7dWFn/67ynvmGjrrINymKtQeMx9D0PNIDFwbd/U6PAN6HAGIoV+nquMaM0kpdFuwnercauCZQ8ATKXWH19fxjh7wvzR8uSKOctIcMuWC6Azso17gT3jFKr3p1d9kL9/Dlo+dUTd4BDpSVL7pWJgR3RmoH7fqhsShTSg//lmRikoGfEpM3cgqynvLUZpjVpNknDGiV49whOCTJEKKJw1bUrh4L+vKufReII5KSNp8oGqkQVGYVh6AjqvDGR1ReqcAdB78X9gc0IJm5ktqphkiup7M3V3w9tjLedfJEQ2lY2qnxAyWqfcdV2pfvdPzRidwxJLXSslU1t+Ezj5z2Em7TPzEwTfg2sVvKE42b2USyo0X01jK+l3af0Dn2YzUG+76+PI8xeQ2UkE2luByXJkolU1o7TOlYxeA4eswopnIY6bhennPz7w6xvZpd34eXCLJVPEsc78Gt/o/R2MqSeYP8BRUNfhISN+Z96fY1TEEssda1HMXbOuDY6SJ4zLeE+GwoIv7uZMzxOaw3bVR5w6/C4rHCgWDhZDHfc87WftHg4OLaoASU0DHG9WtJr6TJ6V/qKifa4i3LWHKS5mcc7UIF84J5wpw2EXOK6kdCErEp7fZHfP3KtXExL2FZlwlyso4IPjgQ+whYvSazBV4GoPo/qEOJVcCQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1TQnBYNkZxZjdoZ0pobzlPRTBhb0dWQWlqUXdwamtZcElyVHpPRW04djBy?=
 =?utf-8?B?bUpwd09RWktoM0pDOEpJRGcxM3BMN1VnekdQRkkxdUkvNzBKTkZWcjVQZ3Jt?=
 =?utf-8?B?ZnZ2TkNVR3FSY0s2RWE4S3h4MDZrNUJuU2JVZEd6OVpObUZCbjV4bGRLUW5N?=
 =?utf-8?B?akowMmxRQ1ZpUFdKcmtRSjdrd2V4TTBva2p4TkhYaHVkVEt2MUtnbFZ0aUNy?=
 =?utf-8?B?Ty9icVBTcTRFbWxOMDJDQjNwSU5oN3p1V0RsS1prbkhpa3draVdGMnMzK1h2?=
 =?utf-8?B?ZDZUek1RY0VGbExJd0FQKzNFc0Fvbm51YmJ4NDc0Z2tlSy9hMGxTTEtDdHZo?=
 =?utf-8?B?ckRVRVdoL3lYRlJVcWx4bEpKb1ZObU1yMGVKT2x0SnFTS1JMdjBmMVdhQ1Zp?=
 =?utf-8?B?ZlJzY1l0Tjk5K3VDSVp2S0EvWU9oajJWSm1vQ2ZSQ1J2QmNMdTVJazhvbzlO?=
 =?utf-8?B?MjJwSHlEdzlFN0pFSUtYT2xYRUFwQU5xQ2xnNDJvWW1OdlNObG9wOGlZMzFm?=
 =?utf-8?B?QmN0V29TT25UVkFCUnIxR3BBaXpUb0tReXIwOFBMYmI5aWQ5WWthRFpQZEZZ?=
 =?utf-8?B?SEF5cHAxWkp2TTVVKzE1b1JjRHlxNlRNcFI3ZjZkQng0VTR4TkdJNnRUUHV1?=
 =?utf-8?B?Y0tlY21abTM4WFA2Zis2RnhlelBUZlExTFB1Q0RTQkxsUEZJYjVEVlR4U3Bh?=
 =?utf-8?B?aHowRENWM2QwVW1nVk1nYlp2OCtzU3JSK25wLzhhRUhja042eTNhdXBlbEtQ?=
 =?utf-8?B?Y3FTMXg3SGlSeHplVmZ4ZmNkZ3dXelBKUnVxaGpiTGNhbWI3N0RsMjE2UWFH?=
 =?utf-8?B?SlFhRXZRY2pqUGJqUytSL1drdnJuTG43NXNxckFlTS85RHZiNWgwK0xXTjhR?=
 =?utf-8?B?c09sczFpek16cW4yNmlEZzhQMUZBd3htaWRnK0laOHl3d2E5bi9HdG1GaFli?=
 =?utf-8?B?NVNYRUJiRzh1QllER2g4TEd1NjRLT1VvaGFic3lTZzJRa1RRQXNORzVPN2hJ?=
 =?utf-8?B?WHJQODEyRndOV2lXYjlnQ1BiU3E1eHlzc2tjS1RyUDNtcWlHM3VDN2Fhd0pk?=
 =?utf-8?B?blIvU05VeVJTUVhJb01BT09XTjZNVzYyQjBON1ZBTmxYMWRTZU1FUjFOdldu?=
 =?utf-8?B?WTlXdVhpOUlGRG1FSVoxVng0SDU1TjU3MGlRNWcxOGdTQTNtVnZDeWgzeUZZ?=
 =?utf-8?B?ZU5HeDY2aXFjeHNxcmh2eitvbjE2b296UmNVb2VhZGlTMndIbk9sNFJ1VjBy?=
 =?utf-8?B?V1E4YkFraUlyeHFPMXY3NEJwV3cwWVVORE9nb1AyUkI3cDlEOVZldWttMXVU?=
 =?utf-8?B?UzlPRkN2Mzl5OUtrREJwTlhmekhBMWFKbTRrNGdRUFVTOU9wN2ZKVEkzSXV0?=
 =?utf-8?B?VGpzazRoN0JRem9HaHpQOTNuRm9iZ2IwcFUvT25nUnVpUXB1MmVkMTJZUC91?=
 =?utf-8?B?SkFRR0ZiaUJXR0JDQVhsSmRkQzhvQ1VRQnRuOENXMXRKeEF6S2FXWVJMeVl3?=
 =?utf-8?B?SUFoZ0x2RGM5eit6aG5NM3ZDcGZwb1c5b3E1SU5mL2FGKzlqcFpWQzJBV1RI?=
 =?utf-8?B?YU5VZHVyZmMxMEM1V3l6Uk9yclJMUUhoVlFvWlM0bXVsbURoSExLd2pYQ21t?=
 =?utf-8?B?NW5Dcm5DUElPSUhGbHI4bG0ySVZycExnWGxCSzRxSDd2dVZtK2kxWWNmMW9a?=
 =?utf-8?B?bnA5K3JrQVg2ZXpsRVNlcDVranpkYmxzQlVDUGdsVG85TVBRVWQwcEEvYUJ1?=
 =?utf-8?B?ckRnTVUxa25ua0IxYU5renhMaVlXMWZQTjIyTEJIblVUeUFSWDFvQlZsZ0cw?=
 =?utf-8?B?VWJpS2t1Y2pNNjdmNjVFRnVaTlVjOUFmTDdPalV5eGcyMjJkblpGTFJsSkEy?=
 =?utf-8?B?Rm5CUDJhbVRreStobWY1R1dWN1plSDBUb3NBaUZEcWhsTVNsdExkWXNIbDZ2?=
 =?utf-8?B?aldaWE1CQXRMU1hMa3ZWRHFzMlZuQjFPSEVFbE1PNyt1c0t2YUdSY3A1U3E2?=
 =?utf-8?B?K0RjOFVQb3gxWTlxelArZ2l4b1hwcnE3RlNGanZleGtaV2NQTHJET3BiekJB?=
 =?utf-8?B?ODZvd0F1Rmg3Y0pUbzFwNlhDUnVBbXZQTzg2VkxNNkVpcE5xSEczT21BU0kw?=
 =?utf-8?B?SE1PVk1CbHZ1ZGdqNEhHTVlGM3MrcURaWi80STBqek5oMXYrVUhjaE14SEtQ?=
 =?utf-8?B?REJoTGJic25malhpV05KTXFlbndZMmQ1dFMwc2xGdjduS2NscDg0cC9NMU00?=
 =?utf-8?B?VEtKckZYVzVkZ2EycEl4UU42VVB6N3RIR0lEN2ZOaGdUbUxRRWdGUmNaYmNx?=
 =?utf-8?B?UUZndVBwSWdVano3MWQ2R05adkE3bWN5bFY0WWpaNitSWEUxNkNhQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f491c-b3f8-45c3-3af8-08df0ecffc6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:10:56.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOPz/JDvPO0BNVlwTO2X6BPJO/Px89VEmOx7zBQpTKCLsvvX7pblcp0uJtPmlbyAfbWab3ubdDsuqP9DjzGemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 9/4/26 2:19 AM, Richard Cheng wrote:
>> +					"cxl_reset");
> 
> How does this function provide us the required quiescing ?
> I do not see it revoking existing PFN/VFIO mapping or preventing a driver
> from issueing a new access after cpu_cache_invalidate_memregion()
> 
> Want to know what prevents new CXL.mem requests between cache invalidation
> and reset completion ?
> It does not require the range to be offline or unmapped first ?
> 
> Best regards,
> Richard Cheng.
Hi Richard,

You are right that request_mem_region() does not revoke PFN or VFIO 
mappings, and this series does not offline memory itself.

It temporarily reserves every enabled HDM range and rejects the reset 
with -EBUSY if a conflicting resource owns one of those ranges. I 
documented this limitation explicitly in v12.

-- 
Regards,
Srirangan
