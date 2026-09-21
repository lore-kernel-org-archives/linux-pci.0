Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E544B4039;
	Mon, 21 Sep 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004299; cv=fail; b=XeqwnBeaB+G0yooATrwDzix8YSAi+diXTivAMxv/whFJ0JQ08UWqeupfKFOgGTtn0MBrvKrxWmyfKBy/WwoYarNhCFwoWKX13uQQ+vHtS2f9lbNkA1kAnX0jAYWkG5KiDJSEROy6zEBQYFykC6eKLbu/PX70p9iw7A/McAgk+8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004299; c=relaxed/simple;
	bh=Fag+yebWxmSmCD1/Hmi9jmBtxZ2sbYSQeZmyWjbT/GQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C9+NR8ZTKpkWouNJH7e/SsK6qrW8Ks/5okUVPaDCJyGP0oLiy0CNYjWeS22fsxIWgP/RJLnaCP3ksOnrd9/x43q8Y290G0fphLUmJFEssvN+Jzyz8Nq1PwqHVPpW1QAAVVvpJb2wxbS3t3/8NHuhphUkpIQkFfppYF0BSoCcgxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T9pC72Nm; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T9pC72Nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNHpAQYv+yHcK63R/Sl9js08dHwpOzmjaKB8jvd34J38NHZCYiEGO5vkxAL6QOUj1DH75mobrf1XLJ5pHzmpxvVRcqwyIPsMoN6mOoWvROO3MbumZj40fP+w8fA3QivAHpI0KTuxfDr38RIJEJKH5+ZN8S/lnHYsu8n1hUvKP9Pmw/RWUul29KSIU4zm6/J7Qea5h3+laN3EfHE3eXMFMV+K9xNiCezW3O3T01Om487pe2ddNghqJOd0ql/oiZb3IpYIPEkTj1R+x9ifOym+2Z8kBn4AscW9JYsZWy2QsbAzJEWVU/kz96weCpsiU/se3fdbcCQAz+oHCIRnakCspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuyfzBdEtTrMMVhlF2X1WDUuYD82bIsnSmfHPWtKdoI=;
 b=CvtpCl/NPxXHNwpXY9qQeBCm0+9R+RSPeKJMTjh3wzQjLJOOjdXr4z8mdT6jYw8PtRALkvUnQMTwbW+KgVrWQomJPHREvhsNUUzZ5NMbz19wvyvjCgPR79JAi7S05N47lhAsVZZPC/0ppMKjXtXcjx5EnGEdIHO1gMKkKPLnn6YaGCR6mldExsFjmJjo6smmGf+nUTy28ud930pWClhfQVL8F5gDQ8HmyN+m8TsJsmVAiLMOtVR9E8dpalXD8V0H/0b/9QgPr0UJEL1934898iLXFPkc92Nx+JxCxZe1hIKcuf9Wa1hxmZrd4kh9okmcRVlErczegYL5HNVeDvGgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuyfzBdEtTrMMVhlF2X1WDUuYD82bIsnSmfHPWtKdoI=;
 b=T9pC72NmHXNIhh2c3468Tqq6HsULdTTxyFx4rcToOtifHLfILqMAO4bmZ9SaB1atjue3zOeO4TbXz9Kjvd+fA+fwXZu517gn319OlvZ9T6dQfReFX5w7lCBj/Vnw2o8uEygqSN9qyQZXfHqcTvvQnLntji3X16z8wIEF30KTJxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA3PR12MB575744.namprd12.prod.outlook.com (2603:10b6:208:61d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:24:56 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:24:55 +0000
Message-ID: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
Date: Mon, 21 Sep 2026 10:24:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Freeman Z <SHD-ISAC@outlook.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "westeri@kernel.org" <westeri@kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sanath S <Sanath.S@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 "Kovacs, Alexander" <Alexander.Kovacs@amd.com>
References: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260921050450.GM106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25)
 To PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA3PR12MB575744:EE_
X-MS-Office365-Filtering-Correlation-Id: ae85179c-6835-43f6-73fd-08df17f47d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|5023799004|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j3lC9yzmdUs9psne4CL/ul9mo8fxfdV5GhhWfQQblmnKWF5eY6ykTGfjou8+jZ7IiVMhkwZYhJEu07g0kjTSolX9fJKqsNHvIFEM2XEiH8fbhE5xwf/OMDqyVsdjFngmvgdEWAdch4Z/8R1VzYgfywWkJGC4AZT5BDjW6pP+0S3RHFykcxnxbcHCK+Sf15NLuu6ybY5BiC0528X4NLTFeTURBe32QZstUCayZ/Yhnre6ezkDFTGWp44Dh+PuOAiQ8tgaiLIl+2kxHOFMyIoAbOMBkpCMCo89yvVx2fCCAgR72qhGDA+x6ASRh39TAzgSZHlkQz8io2FAEK2YAFwSaQjRD77C0zan1bZi4H+/+7YFyH8PSw2OG0/K6e16CxqZGkHkkKRFmMxPbBAmra283VTODogp0xJ77HJt359VY75+NxCvZUzjC8k8nfBWPqaQUjEpyYFYXT+bmK9zPhr1Hfd79O4NFcf+RldmTo2VBjxzVu6NwIJ9D9kf+N/mPIW3AwSisMply9PtAFIHoz0O1ta24hgoGs/up2FyFALgv2eqSZvB+9kFmFlrhuqNNYskuebjGNj+YA9+V2DSnocTfQFDfkCOicknFF5AyyyM0yCKM2khilaf+N9si8P+yYTGCDYiG5ZMSwgfYLYR2cgbpU43OrZnShB3QcAVPrOWACM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(5023799004)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTNaL1Q3TDRvTjZDM3JCS2FkTlZFMnc3dzNIeS9sRjhjSC82SG5yaE5aMjdn?=
 =?utf-8?B?blNaRnZ6KzJ3RUlJYTZJc09NZXpzRGlhVlVaMzRZVjNpejNyWUJiSkNPQ0o4?=
 =?utf-8?B?MVJCU0hWUERTQUpxSHAvY2VIQUxIN2FlRTJ4QWJ2N01Wc2tGWkJqeDl5cFFI?=
 =?utf-8?B?ODR2WDdNaHF4UHNteFMyUHgvYWNnWFZRa1NUb3FqWFdHTUhoMmJ6N1orUDg1?=
 =?utf-8?B?MmhPY1VIQjBJWWNuYzRCS3FnbzhMWXZqNEdmUDBLQ1hQZ0FDNEFRMDBIMGhW?=
 =?utf-8?B?OVZBVUk0R0ZqNHBBWE0xVWpZQ1N5TTI4ck1XNXNZOUJRNnN5VElNeGRkbUpS?=
 =?utf-8?B?bkIvZkNzcG1Gc3ZteitIT2lxdTlSQzA1U2doWEZPZUcxblJYTjA2ZWVkclJX?=
 =?utf-8?B?M1M3cVBOUkg2RGc4VmpvNHdpWXBLazZ0bEd3SnZkVGFGOUlGQWZkZmFCUHZs?=
 =?utf-8?B?eGNlM3JmZDVHdXlTM3Z1NlQ5NjZ3R1c4M3Q5NVlxdVhDWXp4QkFTR0ZDbGgv?=
 =?utf-8?B?UGRkOVpIcHBCUVd3MmIwR3pQbFdxSmZ3RWR4MzEwdFdOcDgyWkJXbVVEYU84?=
 =?utf-8?B?ekFVeWtuNEpjUGd2UDhRQ2RnYU9WSURSNGdSMTNtN3RCQ09kRUYwRmtteVZZ?=
 =?utf-8?B?WmxxelNCeXd0L3k1WncrUzdMNnNvT2pRcUg5emZJUE00RUMwMERkT0VoSWxI?=
 =?utf-8?B?NXIzS05TdGJ0Z0lMV1dtM3BiTkVjQTRCbDNWeDZ5UFVMZmQ3RkpBdFdUVEdF?=
 =?utf-8?B?bjY4NkNMM3dqc2p4TzhXNFdIVjVCMWQ2TkY1dmhTaUZiTm8xTnRSa25OQVNO?=
 =?utf-8?B?VDE3NHFqUjNqZTdmSnM2NnBhK3Z1UW1MM3BOWjVJSlhGVjUwY2FJRHA0dFVN?=
 =?utf-8?B?T3dhcmpod2xoWlRIKzI5TG00b2lPRnVPYThjdDJVWUNYY2xiMFViUnNPTTll?=
 =?utf-8?B?NjdzaHByR3J2OFhCU1Z0YjlEMklEbkZ2NEhpVUdBYXE1M1k4V1lROTdkVGtZ?=
 =?utf-8?B?V2JRU1Jodm1odXVZVTdIVEI0aWVGMWo5MmNtTlNzNGFUVU5XaUpza0ZzMW10?=
 =?utf-8?B?bjNSc2tIQ1dEQXNwYWRweG44VGJYQmJGSVB3NnUwcXNuZ3dPVWEyVGpLM3Mv?=
 =?utf-8?B?VVRZWHdaTGpmQ3ZuK2pMeDIzSXg1MHNEY1hYZWdRaUsvaG50VzZZZ0VaVUM3?=
 =?utf-8?B?VENQKzluaGFHUjdXNVlGcnlEeFJMVXdCMlliUCtERGNMUWhuVUdWRzZhZEM0?=
 =?utf-8?B?YkhJaWJUZlZCYXlnLzdnUFljcmVMd0NlOFNFTkRPazAySnBoZTZWMVo0a0FV?=
 =?utf-8?B?dHVEWlpEeFBFRzVxNUxreEdzTzMxRFNJQm9SNk9kWTh4SGhYN3RtVnB5VUE1?=
 =?utf-8?B?Vk5ZUktHbkNwdExHcUxYcyt4NmtnaVNtNmhJaEZrQlVkNVNPR0dxclVRdi9z?=
 =?utf-8?B?SzJ0YUppWitvdEEyai9ESnVZZURsMExtZGFiRll0SHU3b2ZKV0VvaVR4WmN5?=
 =?utf-8?B?amRDUkErVmtNeSthRDZJcnk4UU9iSVc0ZkdpKzJkN1ZsaTMvdHUzZFNvcXZV?=
 =?utf-8?B?UFRnbXgyQ1Y2LytBNkJvM2FxeXVVaHBDSmNiRzBIbFMydkxmNEZscnRyZUtL?=
 =?utf-8?B?dGdjQ1ZzWmI3dkp5K01VczBHcmFhMTNXSUgyamxSUmJNeU00dXhxOW84OFU2?=
 =?utf-8?B?SkxjemlRNlJ1YlpwUTZ4U0lIb2lhYzJQdnlqL0xUcWdnNHNxVFRpRnVTM3oy?=
 =?utf-8?B?cUZUQlgvZ2JreTB3bDVkZGFORHhtd1pFQWEzWGZCWFJOdUFOYVNuclNncWpk?=
 =?utf-8?B?RnExZmF5NENVeW9WcU1vYWN2eFdTM3V5YXRPZHhlcmdtOEQvcHI5L20rZmFF?=
 =?utf-8?B?SDgvY0g1MWhuRVF2b2RSRWlHY243N0ZkY0dDNTN0SVY3T2pQcWQzMFBOR29Q?=
 =?utf-8?B?TmdFVmpyVHR5RW1palliWEZRaU16UVJEY2pxSmxtNUR2WXFTa3BqS3lRQ1Rl?=
 =?utf-8?B?Z0tKWDlsajQ1ZmFIMXBVRkd6LzVIRDc1WUo2SVphRmJlZXZidE9UNUpnSjkx?=
 =?utf-8?B?K3lFNXZldFM5NFY2RG1MMkJGSjA5TDFZdWwxaTY2VHdUK2Npa0hRUVN5dXV1?=
 =?utf-8?B?KzZnNDBpSDVMQlE5YTMzeXgxL2UvRFoxSlEzM1k3YWtwNVdNamJtVG1QaGRm?=
 =?utf-8?B?SHdEQ2wvUDloWDh3M0hUeW00NmJybFpFOHVWR3VkeEdVelN0cS9WYklsMXEv?=
 =?utf-8?B?SVRWNGJ1QzdqejFveStBQnZZZlVaK0xQaWRPMGM4cTZwOXFtV2x0Ky9tdTRx?=
 =?utf-8?B?ZEhOTFJBSVk3ZVBNazZ6UWViZSs2TUNVREFEb091S042Uit4aHFRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae85179c-6835-43f6-73fd-08df17f47d97
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:24:55.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPhDyRRx3Q4m3xiSMDGTQm1vimwpRsO9Th75RrfeaLeExYmTOn/Y98Bduab9zaVVKjG3UnLEFwxZ1qPez0gcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB575744

+Alex K

On 9/21/26 00:04, Mika Westerberg wrote:
> Hi,
> 
> Adding AMD folks in case this is known issue.
> 
> On Sat, Sep 19, 2026 at 12:39:37PM +0000, Freeman Z wrote:
>> Hello,
>>
>> I am seeing a reproducible USB4/PCIe runtime-PM problem on an ASUS ROG
>> Flow X13 GV302XV (Ryzen 9 7940HS / Phoenix) with a Kensington SD5000T5
>> EQ Thunderbolt 5 dock connected to the laptop's USB4 host port.
>>
>> The failure is reproducible with the official Arch Linux Live ISO using
>> Arch's stock `linux` kernel:
>>
>>      7.2.2-arch1-1
>>
>> I have not yet tested a self-built kernel.org mainline/vanilla kernel.
>> I can test patches, or collect additional traces if requested.
> 
> Can you provide full dmesg with "thunderbolt.dyndbg=+p" in the kernel
> command line?
> 
> With the below steps (following your description):
> 
> 0. Drop all non-standard command line options except the above.
> 1. Boot the system up, nothing connected.
> 2. Once up let the TB and the related PCIe root ports enter D3cold (don't
>     run lspci it will wake them up but you can look at the runtime status that
>     they are all suspended).
> 3. Plug in the dock.
> 
> We should see in the dmesg the PME if it works as expected. If not then it
> may be that there is something wrong with the wakeup path.

There was something like this that was reported in the past, but it was 
a race condition of some sort.  It ended up being fixed by a non-obvious 
optimization (I forget the specific commit).

But it was definitely older than 7.2, so it sounds like it might have 
regressed again.
