Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A5326928;
	Wed,  2 Sep 2026 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315140; cv=fail; b=R7SeWzAl9XVSXx84a4ZKuEE/UBVmFU0jHCCPpUVu/sst7MZlTwfctOahx342JMG9zerPqJTcCLOmWsiXe8yK3Twzi+cvYBSkvkSKp3Kx+UiymXCsOIsxEVgKQoj9UT4doZXyGeRRRulBaJQyyaaOWbQ0Tx4ldDRjhqDIXiKXcdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315140; c=relaxed/simple;
	bh=17aO1hnGToRepgxR6PYYr7NTx/TAGMZLpESLwSOQMOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2WowtI6LgeukuMpU/cXqXAjUyr3SSAFGxCazB/XLh9RxzYq3E5ayxU96P1n7zyD+n4g0xJ9lfmj0Lug6Tstk5JiFIYHHv2Er2bx/Y0X30cdEJHYRFJ9wL2eT5q0oEJk7F3X+/Rh9375+dFTblUj7E0dgOzzJetnlLdAFInC5HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYSBg9jw; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYSBg9jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5dfMRuwohOcFeEOuQPi70KmrwWB77UWKqrL7ESznlg4BiucsVO3iTVTm8sydDah3ydBGk+jQ8we0UKfPRk6T4gkuEprR9ydh6Y6up6jmkY5wGr2gTgQWaskAOdxu94o1NNmUI+/WN1xo9od+MC66F9tAEXbeqmfEhwui8GPCYMuMipeAHgcYHRfdG5G5hglmTH4zXvDOqBxeJl82/XMjcZadicBH2glyY7bJDkGUiyAw96jwtVkBBWvQiBi0sd9BiQZFTI6q3qaNZHwctaVgdFOSvHKBpgPLmSjJ1aoQ9GMojP19W8tJol108Tp8EADZgvMEFBEzUTulDt0pp7E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkm78YfnDg/GirXPOdRkEs6o05tZDyk86tebJIyEbfo=;
 b=ecH+xknWDAilWkKKgl+8uCM+S9xlgCtbWzrEhqZ8yDdcoSdFUX2dopeNJOerAxMk4UdBm+bIlHZ3s4Z2WEyYYDV7h9X8ALcCd97DxztKw19jCvOg9Q5X+Kr7uaoETMwuaeVKi001DgWz+1fEsoWTj5ZDSKMdlnKEvw7byg3puATDpitC7ohfZClFBoJGqbrTJdxhZh3CrLwkXulGqRidy6DlPN50fdI6hWbgsKIg0r4Xiz2oiCU1OQNrdD3UfmpRsoayY/SAa5LsPCGh/Y0UbcmClUndc+owpL4uqH5/EXGin2Y0pE2FfskO1oKChg4Jk46Bwh63tJx6NwsKQ/4ubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkm78YfnDg/GirXPOdRkEs6o05tZDyk86tebJIyEbfo=;
 b=qYSBg9jwJfcNhwij7jr2BT+HME1cYQ8LDDCK48/xgAt7F1ldw1jV0oHWkFy6DqA6BhBqRwC5SYR/ct7ZvPzbw7+EyM7jFJqpSPqaSMWs7xtmd8koHRISEVlkyBk9U4ZbplZJvWFFPrNKhWyre+vErby9yKf8HD/g0Mlb7EE6aZgoPqleojYgQ0Nxthe8e5IZtLhySsAtqPrV7Aof6MvaOrYw0KTuA/v4vKqGNASqD6ykzu6eFmlc0WeLcGE3xiQ8iPnCy/0t/31ChqJhRN8EYCvye/DuTu1/w2VODUmgl5+QCuXcrXqE/m16sii0VYCZ+I0EUVR4FXHufd+rddU4Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:12:11 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:12:11 +0000
Message-ID: <3b0558aa-a704-4afd-bc5d-e86fe4ca0128@nvidia.com>
Date: Tue, 1 Sep 2026 19:12:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-5-smadhavan@nvidia.com>
 <8d26e993-1c04-4609-be0d-f26449c490cf@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <8d26e993-1c04-4609-be0d-f26449c490cf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaf0d06-581a-4a37-529c-08df0897996c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1RXMg7+lPmpdFYtT4oi6CGpTdG7OwcEO/wCdQYeUqnUkRDMfdYAEjn8UZjEw0TIevCJjIorviOro3FN3rXlLpRatVSe5dRqx+IlGucAOkADZJKgwMiUmXwdj27qM/4KVebdworAVUy4e1NqnN8HCIM32XDzU7qSvH00KQ0u2MnwlkNPpUMtwiYG0zGXepx2fMTBXTbRYeUTmQ8fiKMgon/hCc4hbA3ehmnEQYd92yeVxjJMwBxm+PEwsysc1RHSB70Q4PicoNmAuP+TDLDzpvBVx7ZkLRzbVAOp6lbAFcr/J/Y4KVL0YjXV8ce2JWu4blvg2x0D4C1NHVPbKsCM4F2m7cP4keNn2GKBxAd4EVhaZXAf0FmgS8Ec526sVZoFBLv3HCIwCUTtU/2Q7XYyLd9tfYcKqRanWC6FsSbBcg+VDc/ZVKS6DZSyNqNE17+ucL5mT8ZD2JCGO1wTE3E9c7ATxRXEJjCpCqWTLkmH6WZRndx0dz3IVeQ8LPUta32mdSXNCw4rcVC6kqAMD4pn4s5UZH32BCl2LJ2KAoC5Pvohtk54ZW/YcdR7suQyPDKhyimOBSvRpS55KjrPXd2/noV4vG61KJ1yG2eVt9eRTDOjNJAoygbPeXpnWozZfkDHwG0T+gHTMt/vzEtZQ3Qf4IEVkPh2t3v8pBYeb1yElEvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJUOTBGTWQzcTVpczIxckNCYithdXhJSCtVREdwcmlEY3hselJTOGttUVNV?=
 =?utf-8?B?RnNSRmZwVVBmc3J2aXNIQUdjNktHZU1LbzF1R01xQStQQllXTEY2c2RKR3gz?=
 =?utf-8?B?Y3JqK0pDdzNFdGJBTEhQZmVGNEpiWWZCVlB6L3laOEcxazdMaklvcjdBTmRI?=
 =?utf-8?B?K3VhUFRIOTlqNC9yazlZS0xrM2NMNXEvWEtzRjR5R25nRmlSai9zSmtIbk1D?=
 =?utf-8?B?d3lHdW9qcENMZGdaWG5qU2pBdk1kd0R0LzMzM29lTWtuVTFReUpmcmx0elRk?=
 =?utf-8?B?OHdaSDZhNFRGTXh1UzdVM2NKYnlNelgzbU9wUjVsY1M2UGdSSElvT1Yvamp4?=
 =?utf-8?B?YjFxbFZBc2I0T3A2UytFb3hpZlJzd2o5QTcxcU93eHNzZjhpclB5enhGcUIx?=
 =?utf-8?B?a1R0N2h5Z3dnTVdGd1ZLS0hQQmxFeEkwRXNqc2lvQTNSSG1YcXNZQXplZ1pq?=
 =?utf-8?B?VXBrRGdVZEFPcUMzU2xiU0N4RDRKcWpkaTdMeUFBbUkrM3RsSW1wZUtHVEtv?=
 =?utf-8?B?SktpNXRoVkZPRGhrbWxhNCtCN0hRdm9GUDArOHBjcFN1R0ZRWWlpWkxTTzhN?=
 =?utf-8?B?Sk1ZcVRmOHpRNzZtRGh2bzc4VWdxcEUxU3VwZG1nNEpSdldRVm9xTlV4SDdU?=
 =?utf-8?B?dlFISDdCL1pPL0d6L3NGcHpWWVNrL3lrSmgxbEVHWEFidGpySXF2Sy9OMXRu?=
 =?utf-8?B?djdzL3VXcnY5MzArY1dqUnFVSmkvVm54ZUFYSmczTURpWGlaSFBmV3hMS1pK?=
 =?utf-8?B?Nm8rd1YwUXh3WDZEQ2NuS0ZpYVQrR1dYUnE0ZXJLVmVuTXB6QTdkQTdyR0FH?=
 =?utf-8?B?SnB1bDRqUzBLV3NTNmFyTlRTVE1ISnpMMDlyR3NsKzFyYUFWYi9KQitXT1o2?=
 =?utf-8?B?bHo5RlQ4RTE5QktGeUVsd3FBc1cyUXpaNU5aemI1NlBZTlpUejFnSVFqTS9O?=
 =?utf-8?B?Q1ZMVzd4NXM3dFRrSEt2d0N1MVpDZEhCZVJoYlRZc1lJMEpMQlA2MHdlWnl4?=
 =?utf-8?B?a2k5ZW0xbXB1NGZ1cno2b0czRmRMS0RiM0g2K1B1ZE9TdFFNUUJ4Rk0yZ3A0?=
 =?utf-8?B?dkRya0U1TVBLdXF4ZnlzMUFrc2F1ZXBHZXRSSHU0SytWOVVnbWowcUpaZWly?=
 =?utf-8?B?TnBYSS90T1l4OXk2NU9YdHMrRm1obDc1dEJlRzFIVkkyY1hTL1hFUnFWQUxk?=
 =?utf-8?B?TmY5cmFJTzVTdGJZZUJGNnlPUEwzMWh5Z1RwSXpRaGNoRXBxcFpTOHRHaVdj?=
 =?utf-8?B?cERrUVYyR2xHL1R5Q3o1RFpBeXluMHc0Y1d2OHExQUlkVFRNSE0wb3BvUFA3?=
 =?utf-8?B?UVd1M0Rhd204eU53dVlNSmZvWitsMkFOOEt4K3hWQm82YlJmUkNSMW43bU45?=
 =?utf-8?B?a1JHYW5CSUc0YXJ1b3FrTVZSaUpmcFdlSVNnbmM0V3cvSzhKckF1czRnTkd0?=
 =?utf-8?B?YVdxMGdGUHkwVTVNOXp6dmcvS2QxM3ZxSTMxTXpNcWV6SXJ0R1NxK0RnTVJZ?=
 =?utf-8?B?d01JMGFnekN5R1hQZmZ1OVdndEZSb091WTBQOVRpOE0xeXRlUWJIdlI5bjVF?=
 =?utf-8?B?YXZuajcveDlwWTJDRlZNM3F1Z3B4eWtHVWxMT2hRZGkwY1orRTVuRjllZDZk?=
 =?utf-8?B?YWdDUnJJUEJ1Z2F0V1dtcHNBbSs2RnE3OEF5eEZ2b3JMbGEwZmtxUTN5QUFF?=
 =?utf-8?B?M2lxb2dIdnpNendFU05uSU90SVVIdHJHaE9aeExoeG1odXljNnkzU0l4Q05G?=
 =?utf-8?B?RnI2T1pJNGl3d3A4ekZtSTJwV2NyMzZDRGR1RW1FcncyQ3kxeXQxS2U3OFFY?=
 =?utf-8?B?NFNTNU1vR21qYnlqV2xKWDErd2FkRXBZVHpBN1JOZEZTME5pMnZGNEU0eXBL?=
 =?utf-8?B?QWptUHBxV0phSWdxQkZMTTJnWlJQY0RLekpiQklxWVNINnk4VXdxb09DeHBH?=
 =?utf-8?B?R2YzVnBmb3cvLyt1TEVOcnNJVmsydHhrdUJYbGt4MGMxbGExaDUxV0JKcFBU?=
 =?utf-8?B?NGRRbEE0NVpVc2E4QWNFUzM0NWNCMTRKNldBWU5NdmUxa1hmVkVGUkJsTXpE?=
 =?utf-8?B?QVBNNW9GMDNkOWp6V0tjcy9paTlQNlBBaXdycHJ4aU1QelMvNXVuK0FlTG0x?=
 =?utf-8?B?dno3Ty9tTTZNZW5JL2VZaGs5eE9Vb1ljdktBUmN4a082cDJpM2RQTFRnSmt4?=
 =?utf-8?B?L2J1STFxUjR5MjIzN0dRc3lES3J1K3JzVjI1VXZBa0wra1Q1V1ViaURMalN1?=
 =?utf-8?B?TElVQUtmN1FhbkhEOE5nRUNiZUhzZmNCNityNXpmYWRXYVFld2xyQklQNnlS?=
 =?utf-8?B?UzBDNFRXbUpsUmxJQXlTd3dvczF0dzJrcXV1L2N6QWI2V0lCWDhSZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaf0d06-581a-4a37-529c-08df0897996c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:12:11.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixxbCuf2j89DidfJRRsdln3d6fv9XFgYDSFOR3qIGaIrYRBFj/EhKoI1IxV3hrgC+4Z9cDWn6fs7cP4HgwBKqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

On 8/21/26 3:12 PM, Dave Jiang wrote:
> Use {} for if/else since the else part is multi-lines. Although given that you have to set the id either way, maybe have a helper function cxl_decoder_settings_init() that does it so you don't need the else branch.
> 
> DJ
Oops. Sent this to wrong patch as reply.

Thank you, addressed in v11.

    - Changed the decoder-count check to return bool and renamed the
internal and wrapper helpers to __cxl_pci_hdm_decoder_count_match() and
cxl_pci_hdm_decoder_count_match().
    - Renamed the switch helper to cxl_switch_get_target_list().
    - Renamed the cache update helper to cxl_hdm_save_decoder_info().
    - Initialize the settings ID before the enabled-decoder check,
removing the multi-line else.
    - Added a lock assertion to cxl_decoder_snapshot() using a
lockdep_assert_held().

    After the refactor, the snapshot and switch-target changes now appear
in patch 1. The PCI HDM cache updates remain in patch 4.
-- 
Regards,
Srirangan
