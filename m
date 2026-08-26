Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2A343D7F;
	Wed, 26 Aug 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743714; cv=fail; b=mkCC9I+eYdfUyyT15tio+g2hf6WCjChWA9i7OJRTIH03c/taBZ+nGJ2hTj+h/nTOQjz2pKj6+xjxHH3uK6ZjKwj+pZ7qrDebMikWVCrozuEzy8lmztciIGD2aV2OO0pdOSTnbmMLMmeBv2wLbBLu/fYEB1jI8Wo+H7R/C9eYtsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743714; c=relaxed/simple;
	bh=ED85NIl1Jm8L3y4XvkitpZ4z50egid014x6jN0YQUkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Df7SIhGiYOPDvUB3wxkq+/wkHCNuwMumCttm2UadW5DpPO1s009QF502hOzHnEQI0CHC/7vXEeHkMp51gCgaQE9BlAhy9xYPpzzDzEvbGBQ3d7KLnQ36PrT9wYTN9abMXaLsh75tlK+VMHKssRl9xpppG3jJZBUNpr+Vif3DDdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6/Eqn0A; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6/Eqn0A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p417zAjzBWDOjPdRfqL+hCnhDpB/j9a/kbtRsjLS7lBs4Y1s/sF27Kp4OBH2oFy32BJz9twECRfmo4TihJfYGo6hrIuBGt+JRla8Xfa6g384tFb4RN1ufrd6VL+ymsRIxzP//kxf89/B0dbgzQ18qv+VBA1olX2BZyq6cNNxqMT2VMrsHlxKDToEQh4R6t46Ct3bInXPK3NROZ3R4HwuTBYWa7wdUG93/C+bnR89stPKhqTRtKFPDGMuxMBt/pzWfIq80M4LRmDvSg4a0/Hs3eKOw90gDCnprylT1Ekfm4DfJUV1WDtFFVIq2AUAB4lHJ1+cULPlPl/TobLeHoygSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko/296osBhFa2IPnpcLzb/A+Mz3f5a1PxBYVMBcQ9+o=;
 b=uR9h9alaxF5ORzP2AuZ8zXAazYfSb4rBBOT3HkT57Zbce3361VVtxtsSFCqDXIva5U0OQi7VM024HvWF+mGV9+5i+T7OqU5bGvJrSE7LVvFhEnOLPgLW8nuy5rF5vLaAnPH02JQasnGAunE79CHfFCatUHgDQCTCj1v0WaqJCxLg0w5PtgeHrrWNBMjmDDIrvhgdh4DybH5OgoHhwwJZBnF9XoOq0mZr09l8yj2h5gksyexBnMlcyTPvXMyvHsXT+/U/LV49wtDtWyBzWo9QMzI0Dy/jxZIqaixGCPlFGCY4XdZyFHkxt8zyDTO6ZzToLas84DjpaPgaqBfxIViwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko/296osBhFa2IPnpcLzb/A+Mz3f5a1PxBYVMBcQ9+o=;
 b=q6/Eqn0AU6P2KDRAfJgN9GRlgTE2564B1ChoyslevP8f8wg14JbbfnqkG2zxxX45UNj3Rsz88vttkhxeZETdInmp9HT90UfjEpj4dd430b/sHkJB61aoA86P2nybSsFMwbqPyZvEq7w2MhSUCTnz/38DdeOyFy6TTWqxqgQMEWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 11:28:28 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 11:28:28 +0000
Message-ID: <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
Date: Wed, 26 Aug 2026 16:58:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com> <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com> <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ao3oHn8HiXIx5Wrl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0061.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: a830e9a2-b7b4-47c9-5484-08df03652681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|10067099003|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UsqXEcMm9bPmgHcWW3ofCYF4e58Kaptj/FuV/w0lx16dOWVp4Cn21C9t3uFCrMmzNZbwDV8i2biimJUjbuIp/v9X29//8IE5ZRsqyP+IvBRB50kaIbc8nz0m9d4Qu9S8aIVB7ADgaiAdZ7FOLYg4Am4Eagn+aSLWBT88/RfTywZ1JP6sLdVCYIEDzGJ+ucI5cIf3szR8hF7ijHVvcdIeHmvaziKSkHxzMhp8yLXDvVsoeFBE3mHxQfBCxOQ7Ii1+wMK1+d0ouEWZLi/75s9DS1QkRP75ViS1jEGYEY7D2AFJDSlO8ChFk7oawoLDAV2F+J7BWYsznBjrsfJOylfywgxKVn7bPvnZgcOWu6tcfCoYnpORUCfK3wvcM4dVC7oVU/ACXtPJw8JQbL2b9ZgEXbLQcPaCegLSDCiEg7Gjl1+vSotFRdKTkCl6YiFBPvqvWIglnvngAxSqr50c/5jBSLKDlIYJ/ixm3YyIvbCKaRNaXt8t0PMtd6p+k9AarI76g038mAeqnZCzM2xGjj0JaHDB/PFa/mNipJl5zWImu7g4AUHUmxNhRzX/RP0edxDuodLsX89Aaut59a4wk1XOJnwq/5KBam+mzsmFps2dXCNs/WJZjUCX/6dUHgPWnu5Ozqe3keWrF7XpggvsqfPoYmWBk7lQ98SEd/VfiQBqSdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXIydEFDWGUwVU1VNkVlSDMvQXJ0MTZWc3prc1pUZFQ4d2h6a2VnaFpQN3lP?=
 =?utf-8?B?aWVwL1prL05MNVMwa3QrRUM1OGRGUVA2NDVVVVVkYlJTRlNmWUxnSGRiMVQz?=
 =?utf-8?B?alE5SlBzRkQvMUgyaEZtRXEzVUx6TlgxczQrbHZzZ2IvZFc5eldtek5aNEli?=
 =?utf-8?B?ZjV4RVg3VThLYmdNZ1VGMkxOdDF2K2xWc0N4bGpVNVNVU3JQb29WQWoxaTdx?=
 =?utf-8?B?MjNscytlMUl0Q0N0MWN2a09kRWFPQVBwMjc1bGFBVDVkQXJ2bm0vdzhnOVp2?=
 =?utf-8?B?MzRlN1NxaWNLV0hONDc0RHV4dHQwc0tsLzZnakQ4TjE3eC9kOEViNVJ3N3VE?=
 =?utf-8?B?OEJkOEpxcjgrbUJGdEw2NHdLQXNsRFZMTlpwNjh5YVFhLzRaT2VReklEMmF2?=
 =?utf-8?B?QmhzZ0lOQjNQR3lYYXNvTlN5OWRwd2NwZlFwOEdUZUpZRnM1VG8xMUhmOHBs?=
 =?utf-8?B?OUdCbmJEVnlieU1ldjRYVDE1cmYxS291M0NJVS9zU204YXJWajZabW54QXRv?=
 =?utf-8?B?eEhmRGZzL1prcVVGWmZVdUEyaS9VK2hSK1VIaUxlRGhOZlJwbDJiZkhBUk5a?=
 =?utf-8?B?ZGpmQ0lJc2Y4NnhNUGRlb1dpSStCZmwrVDdLZEEzOWpSWnp4K01mOUIyV3pP?=
 =?utf-8?B?QjFkNjFaQXNSUFIxRGJQVlZOVlJoTWZzYUI0aURFbXNDRFpSSUJVb1lSMEN6?=
 =?utf-8?B?UHJ3d0xQbTFDOVFlcjFROXNESXVBR0JzM2IrRVdOK2dGcGNkamVIakJ0eUxp?=
 =?utf-8?B?dFhRU0dTMXgzTkU3Z2tQSVZDQlBmRWxKRVl0djc4VUw2VlptcXpudENqbFFn?=
 =?utf-8?B?d3dUalZFYUZhMDY0TTRlMmF2ZkU5MlRGcVQ2QjhVTFhNLzdOdlB2ZHJETWRO?=
 =?utf-8?B?cmxTYkJCK1RKaEVaT1ZuSytlUlB1NlM5a2ZTRTh6SGlORlgwRmdIdFMrSmFh?=
 =?utf-8?B?UGtWR0ErYm5UaTJSZmhDa3FobkdTOW9QSnE3b3RacXIycWhuMUYveDRTckVW?=
 =?utf-8?B?VUJ3cWhsTk9UcGZId2x1U2svdnJKaG1IMzJaSURaYm9mZkI4eXB2eXdldTdn?=
 =?utf-8?B?OGVucWxSeUpaR0xOcGMyazdidlB3STFsakxLSmNhbE9HOU1PdXByUHhpZ1pO?=
 =?utf-8?B?ZWNTd1JDZ0JHaWROQ1FBZnJtdmh1SkJxMCtvVVJwS0RSdTI5S2xOTUs2Zlgr?=
 =?utf-8?B?K3ZNR1RZaFRJMjYxRUphMk44VndVV3ROclgwMkZCZFpkbFZuY2lKVE5OeXJh?=
 =?utf-8?B?YjNtUnNwNjNyaEFxbGptRm15NzlxOEprOG1EeEdlRnlvMHhhTzdldmJHYkRS?=
 =?utf-8?B?SEpXYk5STlFyTUlMRWxicHBJb3VqckF0M1VZYnBUQ0hoM2ZJT2lWdVA0RzNU?=
 =?utf-8?B?UTJtUzk4TWdFTFlKNXl3d3IvckRzMFJHRWo0UHVsMVk1cHFGSzcrT0JoMDFH?=
 =?utf-8?B?elB6aTNtY050SVpJQ090dGlESFhiZzNiMCtwQkx5N3N6R3NscU03NFR1ZWxs?=
 =?utf-8?B?Yit0dlNsczJuL0hSVGpmUk1nUDhpTGRYR1BEbkxXT2pybk1TOWthaEZ4TW5M?=
 =?utf-8?B?b0xKTGZJMGxkVWpPS3NFclNIbkpzMXAyMlZwRkxkNzcybjJYL1MveC9ZaVRZ?=
 =?utf-8?B?UWdwa0ozLysrWXlNbFpoYlk0UFVKckJ2Uko4UFhrb2hLVHpodFc5NXQ1S2tD?=
 =?utf-8?B?WnN0VndkTng0bjRhMWNWNEU4T0FSMHQwOXdxT0hrNEpYNnNtVEhKRFIvUjV0?=
 =?utf-8?B?K2R3dC91aktZWndJTWV0eG8vVmlNU3FDR3hlVWJFQXh1dXpjNDBmNzQ4YWQ1?=
 =?utf-8?B?Q0ZvWWpnbE5hR1I2U1YrT2pWTVpmTFNyU29JQVVucXhQRm5oV0R5S0NvRmF1?=
 =?utf-8?B?R09VdkM5blV2K2h5MmpieWhyRzNMWUtkSUJESHI3UjZZTkdZYlJqSTVKOWZt?=
 =?utf-8?B?OEUrT0VPUEZuaUFmWFI4S25xcGJGdDZNcmNvQXhDODNJdDVLMHNQUVM5M0JR?=
 =?utf-8?B?YS90RTE4VElKN1kxcks3TjRKeEl1Njdsa1M2ZjI0SXlyWFNoSDZJbll3VlY0?=
 =?utf-8?B?TFdnWE9SWnBtYitBeGxFdzRRbEJIZ25HMTNkbkY4QUFFTTJieUdEYlUranBp?=
 =?utf-8?B?RnpqQ3RMM3pYMDJScG1GZW5FeFR4ZTEyM3pIcEphSzNkcUZOSkl2Rm5RTm5T?=
 =?utf-8?B?MnNGdVlTTlVMOFUxbUY3YlkxcDR0K3czR3VpNUY1bTRKQ05kOW4xYnRJZkNI?=
 =?utf-8?B?Z3ovYkdLMGJKMnhxYjNldFFtd3ZVaXpLQ1VYbHhyL3lqeFR3MDl6S01kNTNy?=
 =?utf-8?B?blJSQnQ0b01XcjY4SlhhelRtYzl2OElQbjBXcGRMZFI4S00rTTBvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a830e9a2-b7b4-47c9-5484-08df03652681
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:28:28.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5QEtbA2B0xPa/5/Cnow5sLRgw9he3E2QoolzwOcabMbludv6U+JO3w41gKDh/27ZYrNDdHIjrHpybJmrLUSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

Pranjal,


On 8/26/2026 12:38 AM, Pranjal Shrivastava wrote:
> On Tue, Aug 25, 2026 at 02:53:15PM -0300, Jason Gunthorpe wrote:
>> On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:
>>
>>> I agree, but I wonder why the existing code used memset here 
>>> (in ignore_device):
>>>
>>> memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
>>>
>>> I was thinking it might've been done for probe failures in a kdump
>>> kernel (normal kexec would've called shutdown for clearing all DTEs).
>>> (I see this was added long time back and existed when PCI segments were
>>> added [1]).
>>
>> For kdump you'd want to keep the original translation running in this
>> case.

If probe is failed then we can't do much. Why keep original translation running?

>>  
>>> Are you suggesting to remove the DTE clearing from this path entirely?
>>
>> Yes
>>
> 
> Even I'm not sure why we had this memset here, I'll just dig into
> the history once if there's anything. Otherwise, I'll simply drop this.
> 
> Vasant, please let us know if there was a different context to it?

Looking into git history, it looks like, during boot init_device_table_dma()
sets dte.v bit for all devices. So probe fails then clear everything in DTE.

memset was added long back (commit 26018874e3584) and we never hit any issues.
Hence I guess no one bother to change this.


-Vasant
