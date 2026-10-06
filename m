Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A746D57D;
	Tue,  6 Oct 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297454; cv=fail; b=j5U098IsDgAgpNo7N3SWBAzhGbEc8+8mEA+lmKiAU1H4b3jBaa5xduB3HMEc8Zn1weM96r9NZEDHp0r5FRVfRGX6Ja814MYfyStUH4ZOdW85NS9N9nl2z8Ba3oFPIISnTHfGWF/SSLZL1Iejp7aW6JzbUnR9uixcY4sQc+ZcVEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297454; c=relaxed/simple;
	bh=TxT5YdXptfZI9cyjHS7tb4N0bLPtcK3+riJAFvGrYlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OdDD1WObU7ijSGZ7axHrZCP6oXYdTPYJdGJul6maK05KQq8eMMhRHuC3ONyZs2ZSnlwaQ4tog0ujHY/kuLwLYGF7uc7z0H+V3whnOaGvAJ6ZE5J9CiFrDWwatq4mtMKNpxVFoV4jtvFOADm9fOEcDE0udgBj7fvKMfHb2OXJUVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WTTQ36fR; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WTTQ36fR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+2BNFZIqX5tRTHV6zdAeDR+E0fAwCJejADGPQw2RNVuCM33cU99+le/dtgBxz5xAThsDp1Pv5FLoGNS4bEfDRR7eTwdcvneMaC9XCFpQ9YMha64+hhURIaipjSr9Jg5XS0HrmA5fNE1Hxypu55bu7CZNH71Zmz1gjXffYuJnhNVRwWFpfyPgFWSnCfqPf1vFbAgc2Z/IS6VQ00wLh4GUK2bMRZAJcbc05fi2n8JRXq4rYmsQN1hXE6sRQzLaM05jUArC6quw9pLgTiRD2sJ29vQvFcaGPvjip4iRP1gF3C7dGvaK0CT7IQw70Kn6rRxeJSg15ZydeRdgPUqcqf2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPSwPRvFlVMhFV8P4l7kLQGoFjpY58YolgBv5kWVDdI=;
 b=tgmOd7hCga0TpXFwzsRAI+lLnxogciL2MhU94lHbd3a1uFkPEsQnwlRBJzYmTAKSFUfuHkMf5DAP058hQn43kFLvvBLYsaLR0WWsuTpJiubhA2fWrvOdxI/IM/mwR96WPjqu2y0SfUqOdKX8shTMGODTrrwViHOtMN5i9BW6XGu06o+f741JX3UoGbYrGsjEU3S1psMmkZkOEjHh29k7djpY+u4KWASRdi+c6g0wT5WYzLeiaAgRwXrVdTa2elp+LEdED3vSkTiXFnOBfrY1rs5CIvx8hb5fqAsUtmnpM6387omXvGPk2jW+Gr9LpU79qkpBHTkmuzY3nq8GHv7Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPSwPRvFlVMhFV8P4l7kLQGoFjpY58YolgBv5kWVDdI=;
 b=WTTQ36fRqdJq2a/j596h3OqclKiIPuvgOelfh9nWVvsLlFTQVf2/KRpMeD5KK5NOo0FZZ+oJn+WopBDkSrJ3+dMCzqOMEOokZUBcMm7uvF1w83b0G6Y6XZs8YIifp+2EJD2tiZkG7yZfRQE7Fsj0KetjR6HHw8/0ZTwWhQhqD7s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 14:37:24 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:37:24 +0000
Message-ID: <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
Date: Tue, 6 Oct 2026 09:37:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 Freeman Z <SHD-ISAC@outlook.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "westeri@kernel.org" <westeri@kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "S, Sanath" <Sanath.S@amd.com>,
 "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
 "Martinez, Juan" <Juan.Martinez@amd.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: ed315226-8b79-4507-7891-08df23b755f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gTJt5LFPRFlvS7ltQ34QC2wUYRNVzsxkn1tsvmJl2yqeZBUHQqg2Aamzpd1/f8hZav5XLAHCDZThlNys/vnHMQWtgUtFkI2LlIzuJ+cYBhhYFza3K074DJcfbkPO4qFu2bjYUvkVZD8ZMiSyx6ztbBOnMQZJ92zk4QlRjFLQy72ccLGeFtqXudg+jtDBnlA64BFQkdnsnygI8Z/6YvP7Ru8spCacyM6myI41IwbKjaa9TDVRwq2d/r8mG5a+tMKJy/ss/KcTGk/vLIq2gX0UjbvA8VZWMyYL+Pm+GAAFR6lgGUepSs+gop4JvhgmP6hQ3qe+AwYomf9gDSLkF/Uz+kTBMPlA7f8zu2rm5IJEzEbdayCVOp4lOqOlei4fsJNanSE/rjASsRzDPmshh1jnmiaH0I5Zd+EAJXi1XfDZBeDswPs3cBn9hJqdLYvBBOgKss/veMlNqylWPl1qEhUAUhotqgK87Vecx6R7HhYseYhO5oWtko47pmmqjcRU2NsxWu+pm+MdoNktsITbqWfOXqLy5GDg0txywEcS23ztoKZUeoGndztvv6H92sdsnbpPUcBbZxKKnu342fiBvcXQI9on+8eo7hr0FIyfHDJ/Qql4ulNuzt/dAHfJNPUiTTmbktvSkVSkckdZHUWabm9ewElscUVBU7vMF/8CHoH02t8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JPOURJS0hZaWxtMkhsYktyQXkrTXZaNFZHekJVbUtmNDNETi9oWm9CV0tH?=
 =?utf-8?B?bkU0ZlhJOUNOVkN5RXJpamY4YXdHUXoxdTJTNm5aaGxGMkwxNzVwclNxYUwz?=
 =?utf-8?B?T01KV1JwV3Z3amhXTURhZExrTW13aHBpZG4rSGtWNzM0czhUQTg3MUZFclRP?=
 =?utf-8?B?K0Uzd0RNRWh1c3NFUUJRcnNGaGhZODRDQVFNTFFQcmZzSGI0SXVRMVpjSmpI?=
 =?utf-8?B?VjlHZDZDV2RFNHdPZGplamJ3cFRwTHJvWUtJMDFub2NyMElOZXdFK0dTck1H?=
 =?utf-8?B?N0tENFR5UjNWVjlGQUZ0Q0xiYnUrcllzMUR1UEpzY2dQMEhSTGNnVHRBZ0xN?=
 =?utf-8?B?WWJNdFNBMVUyWGR6U2piTFpOck5TNEYrWVhSUUVYRUpHdnpWZ1krNS9TMktv?=
 =?utf-8?B?TUVoNlZFcWJvTmJna09pdWdhRXhGcGQ1WWZWTENYRXVzd1dMaEdKdEhLZWFz?=
 =?utf-8?B?V3dRWWovU2xpZXhtOWVIS0lTdVhYazNsMFREbHYwbUY3TmYwZG40VjZ2ZHQ5?=
 =?utf-8?B?ZEQ4ZGkvNTAxTnB4dWZaWUtiZEZsN1pSbkNKTzRsT1lSaWNsR3RlMElCTXNk?=
 =?utf-8?B?cVVTbVdHSDNETXBEbzNpTVl1UXlwVm1ZMHFJOEZ4WmZWanFFcTlHYVJ4S2Ev?=
 =?utf-8?B?VXJ0a2VrOGt3M21KS3BmbUtLenFpTGFWM1Z4VzBTOWZPbm5abWNIMnh3a1Uy?=
 =?utf-8?B?YmNSbVlXQUpMMHBrV2VkdWowdVZESElaTUJGeDJ2MmduNjhmWnlTMFRxREZH?=
 =?utf-8?B?N2pvT2d3QWRFa29PSnpKMGxxNy9pOU5kSGVydXRuSC9iUjB0dVhZUWg3TDM0?=
 =?utf-8?B?bFdRU3ZQK3VJenh6STFyVDBWTk5LS3JueWM0T054TEEzNWF6OCt2TzdEQkZP?=
 =?utf-8?B?WUpCeS8walQ5THRMbDY3V3FLTGdMS3d3UHArUzVmT2Zvd0ZNTk1qUWQxQ05V?=
 =?utf-8?B?Q2V5VTdmOVpMOFZXUE50RVdaMm5JbDdBRTIyS0NIa1lzUmRmUSt1VkN2NkVQ?=
 =?utf-8?B?czNsck4rNHdzRVZRWFJkSlpNNWlOVUgxYmdib1h6M0NUWU1aMlI1Ym5qZ25y?=
 =?utf-8?B?MXdURmtqL2xCSzZDNnhIQUdNL0RCNVBMdnpjU2Jtc3JUT0lwQWNpUGVSK1RZ?=
 =?utf-8?B?Rk5hb2s1cTkyM2FGNEhncWRMZUVLSzRKNURlT1BSMlFiOHlEWDV3RWZBZitP?=
 =?utf-8?B?RkJBSG0yOTVkV0o1elVBTUdETG1NdzhIWEtNYXludCtxbEZXYVdMMS80a085?=
 =?utf-8?B?WWJhVFozL1l1cWgxWXFBMHR0T2JqdFdxV1hOOWVQTm4wVWdEempCVU1jWkZ6?=
 =?utf-8?B?a2RZOUN2RGpXTG5rTzh2WXA4U252VzhVSnFJeGNTdjg5MzVLaURRZXgzUXg2?=
 =?utf-8?B?U3kzVnBFYkF1UVpJM2RqRHhtQ3VGckFyRnNSMGZxelZiVFlnVXM5Tm0zRDY3?=
 =?utf-8?B?MGxNck90aVFhYkxiYytQdmpWKzZDU25oblUxaDVsb1BoeVFtaFl5Ny9xTVpq?=
 =?utf-8?B?d2dBMjRtWUJXdGRnSjhncVpKZHVZVzVBSGdZVXp6MFFMTVA5eGw3ZWhFWC9D?=
 =?utf-8?B?VDhLaVk5MS9CM2tYbGVSY2N6bldMZXlhdzV0VWF4eGxFMExmSjUycjVYdnB0?=
 =?utf-8?B?S09SdndsUHpYbE8wNFZrYnE2WmVuVzlLZDUyODhEVGlGSVNaQVlmcjFvRjhT?=
 =?utf-8?B?ODViZTdMME12Z004VTBwRis0clNhY1dTSVFNS1RJQmVSRlZLYlNMcmdXeDkz?=
 =?utf-8?B?L1R5MEhkbHJtaWJmaFJRaFlDYXdIRWoxN0gwNHRaUE9GcWJqVyt3YlNCY20v?=
 =?utf-8?B?NWdEWWpDUjVSUlRURXpPSlZ1SUkyR1g3RlAwWSs4SEVHL2htZlY4MTRPRnFZ?=
 =?utf-8?B?UlUrcXhGelpoQWF0NU9QY1NKV2p6ZCtXcy9tcSs2NHdkZTNWbUtNb2Y2OWRK?=
 =?utf-8?B?V0hGK0JMSGdvbis3YThGbTRpd0tUZ2gwUFhMMHdtZVorUjRTT0lrR0d2L2RM?=
 =?utf-8?B?K2ZnMmNHdS9NOTdsR1NsQm43RHBGOWJKRkZPRkNqNjRBUm5vczJBQytwREll?=
 =?utf-8?B?UGxiTHk4N1NQbVJBK2tLcDFjV1FsVStiMW5uSWNTN3FvN0dwVnRRMjBISWpG?=
 =?utf-8?B?N0c5Zmp6VmZnOEUyMnBFUmJHTXRFSGhPOEhURnFPVlNOWnJ2QzRxNFdOc0VT?=
 =?utf-8?B?YVR5MlRvWXAzS0lLZzE0TjdkejdWNkExTW12dXl0RWR1bmZGQ0lwblVGQy8x?=
 =?utf-8?B?MDgwRGR0SHlQWjBjNFREbDJxVDhKZzZRUlZuUFJKWDRTeHR6Rk5BZ0xUNnI2?=
 =?utf-8?Q?oJJsE0APLGlVAxnJO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed315226-8b79-4507-7891-08df23b755f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:37:23.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+MjJsq1Afhsk8EuIapjgeQJc5VK6nFJxukymZnHUhxsWUEXSl1PWljm7/xmNomcve+kENDuBVZWJav6NHytlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526

On 10/6/26 09:33, Kovacs, Alexander wrote:
> AMD General
> 
> Freeman,
> 
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the tables.
> 
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD` (00:03.1 / NHI0 path)
> 
> But that more than like does not have any bearing on the root dock enumeration issue...
> 
> I am unable to create a case where I can replicate your fail on my test system yet.
> 
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick 
up reference code but has a difference in their design (for example they 
don't have a retimer connected to the second USB4 router and disabled 
the IP.

I don't know for sure; but my guess this is a strategy to avoid 
technical debt and mistakes when merging future reference code versions.
