Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682CB49EC64;
	Fri, 25 Sep 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345448; cv=fail; b=BWCPEor/ZxAUwEC/ep6Kt+3EEnLGzzhBYdKIRRSe0RoS61hHO556p9vckPwpUN92ZLeVgLRj5QnPw/IM6MpteWqVPJeLExqKB2CnSnKS8U4C80lsJ1qjfQRI5Jy4EC/8tHrAjBJnKnvMbLEm8Wjud9FIMLS5Rh6gs3sgDWdXh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345448; c=relaxed/simple;
	bh=OLM3PtT68pdueqd2GdVH+8PvPg01Wcnfe95Cz9aOntU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXnne1bi8dOsZ66IEtSaVQaKhtyN0b6KslTLp45go86uyYTerOWQYO2WS2mPN0lW2vMfiIGZnifHt3Tf4caNUEW0hJxQznhxtzRF+qgERatOHWV7JEFH/sZOS0xBowBiJI89kIkovMfc9Ug7zztz4qCe0J5FOlV+EuanO6CeaqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNN6TCia; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNN6TCia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvWMWGLVMyyAd9jHu7BIeat9tK7+/2CRqjnj53VEeSD2PCZqG+98vW3SxnRzSz1Tr16K42Fi7WwsnurqmdzuddKSLbL55RDP3SPDdWhZmo0UaPzGRunwRRwZP7qwolz0VGgGfNnjtNUm8lGlWGpK35ovMqrwDjS/QYLJZ3HJ/ADozlqlLCfgh/Y6yaRqBFWF+lM/C93/ob1KHykeIcKvHtfoA/1m6aVJ0py/neztNco/FxJlaJr5TclmrqoGyskgjlO5VnswSJcmUMkYarXYjnw+vJsmNsXk3jerttQIDAzNU3UiBuDmD+GPnfZW0MFjuUuC6Tvq817MCEJohyAOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a5LdFAOPIZQDvp+limPS0SctqR7nFXwsGqsTNaZF3Y=;
 b=xRaugMeoNefX0FMWdaJBJCk50hQuK1ukvIl4M/BiKeIgvy0ThN6DUzIJNRbKklTHo1e5TMd7RYhIrVjGlXqM5rc0W8okoXVufeNaMQOCmA40GxoWs3bAnLyTevzrCTxeMJtvroK1u9CzZujAfBY9HG+64xgRM/Ir0uf7vcrWjQDp1z34nksJ4BqYGNlOu6UcfYxrRJt64JUx4svvCIJPvyKkfbh4VB9hEkjjcJ+Uv7scp+qmAICLK4HWWFUnpPNrdEVmlgDjS2DN+DzvktQzZMZefty2SVhHTIH/zMXATnlCrwQC5sj/K/rtobrFndjXE4/6ljsG13K6t5VmLNMvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a5LdFAOPIZQDvp+limPS0SctqR7nFXwsGqsTNaZF3Y=;
 b=iNN6TCia33CUudIr4V7O9zOfsr+ZrdYrBNeO2EnwDgRoj4yiRPS1g6RhYYA4kTH3APG1qyVKU+qt4FdstAtVVvO/vfi+JjDjz/YSy0U/Ny7ccwSnBhj/VI6jZTqCyun0eZxuY/3S0k+xfEVzKsHmLTyvcMtq4F4667qBr+iimgM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:10:37 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:10:37 +0000
Message-ID: <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
Date: Fri, 25 Sep 2026 09:10:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Freeman Z <SHD-ISAC@outlook.com>
Cc: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925115041.GX106095@black.igk.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260925115041.GX106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4ec13d-0dc5-4a67-4391-08df1b0ec5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vi4HmVInQ4g2ZJj/5L+jMBdIogjMaT4Zwt31slPXJYNPmOf62tPVwnTQffLEcGHhBV4VBqTMUgVWDOxf8FfC7QBr21CkxwosbXUtjRHi2ZK/KGsThXJ3MYauUXsIZuURHD1PpbnrjyntlMaVti/gSMcarjP/8vuwgRh83eK5ah8kC+EF/mia7pgQ8haFkKbtEYNrekIXbposJTrtvjfsG0fuwMQbE4ckU/aAm61Do9ePJAO0DqpWE32QZGSBylkeIr1O2j5EcIkpYvc9OpyOsDx5mTWpwd3dPikKgB54rcZ17d8zP3abjJXIgTCykiDqFjssg3pq5dQK8VIeAPVx+amKPETJY6kf5ONkqMJ6EG0wmKYCtneiaHwNDttCfM7+Qp4SjDYjJRIv4UFoIlxlJ0nlCWXpWmsEJ1SBe3k9m9GrYK4/YkYXMvi8+fvESvbFlwpjps+h8QcEbFffP4Zh7QflYbhDng85i5xd/0Pz8DkSS+376X0YzVfkwPxNzpIRfCIbCEz49ZHNNqBtSXqnZxpxK/D8eq3/j6HfI0zgs5HOuJpTIz8JbOuhMWFsnhEyPvUGNTDb7KudUgKbRRlufgCUDpelh/D3DZ0657+Avx1KVirG3KHd1N/oCXfrorIu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0RQMW52SEdoMUZNSXRGOFhCalV5UDZVSDUwaHQ5bUcyZWhid0dXNXgzdEVo?=
 =?utf-8?B?cXUwZC9IMWZSbkJzdXFnUXlqVnBHaW9DdVdoZHhZUnJ3ZTY2ZlZWeGtMakNK?=
 =?utf-8?B?QkZkcm9hREk1dWc1VHViMDU3MWcyc3FHbXhHVjRGdW1qekl0M3kyU0ZyS1Rr?=
 =?utf-8?B?emZjeWJqUElMSGU1WVpCQkJab0ZhcXJNN3N2ZmE2WEpaN2k5eVBTUmt3NThF?=
 =?utf-8?B?SG43Vm5QM3FOOUp2aWJiMUdyT0V5dk9LZDduZ211cUEyWWx1WkRqc2JlU3Zp?=
 =?utf-8?B?c0JwZDZBVlBmTysreDBmV0ZJSnVvdkJpcDFxSFJUeGFQTnRPSmxxc2E4SVR0?=
 =?utf-8?B?RXo1UENuL1ZlSUVBV2dUTlBaRjFRMWhTUU1CTk84TUFtNUVTVjAvcnRLR2pj?=
 =?utf-8?B?WTI0a3JkM3ZFMzg3VzgyQUZzUnZvWHhSYWlHZU5SVGN2NkIyTDd4cXRWeVFw?=
 =?utf-8?B?TjBCVEtsRkV6YVc2SWt2WVQvM0NyYzZSV2ZuZjhxZlBLS1poeFdiNm42OWhF?=
 =?utf-8?B?Z3JrUzhZMVRWTFNOR2hucTNpZFFqZnVDWEptdmdOUTl2Y3U5N2JSTFl5cVlZ?=
 =?utf-8?B?QVJmVERxQzJmdFEyempPdDhDYzE5QzQwWDdLOXFBRUJqL3JLVXQ1WEJmcmw5?=
 =?utf-8?B?aS9nSURCc0lpT01wTEhadnRMTHJaTUdHZi82NERKYTRKdEJvcUxQM2RvKy90?=
 =?utf-8?B?Ni9HRDdHMHhEVmZLS1ZHNUdTQVlMWm1LbWwrTUxncUFrU0tMWVE4anYwV3Q5?=
 =?utf-8?B?RTNQTDhIL3dablAxR0dnc250czVtWjVwOGNrRU4rYm1kd0dwVnZseVcxcDRQ?=
 =?utf-8?B?VGk3cDBxZHF4YkVlenlweEVaak5YWlVRVk1xazFiT2hNNXhtb0UrWENuTjM4?=
 =?utf-8?B?eW1lUC9UcmgwbEZVOWVzR1pwMUdvVTNjazFpODFlS1g4Qk5YRnF6NXdhRk5G?=
 =?utf-8?B?Z1R6SVRKZDhtOTkvY1FyalpUWXdnVXU5djRjQnVzMkdudnYyVGJYRXRXWHE5?=
 =?utf-8?B?M1dhMmtVZHpObWltYXBibTlMeEpRYWlLcEdUNXdPazZlYmR2d0xsMnVEQkVG?=
 =?utf-8?B?RjJIMUVzcHBjbmgyNFpQTTIwcTY1bnlRaExPM0pYYy84NVdhZjFoVEF2T3VT?=
 =?utf-8?B?M3E2Rll4SXVzaXNtNDAyTWdWM2lUcFM4QkQ3VC96Z2FwdU9zamVZMjdKZHo4?=
 =?utf-8?B?MkhwbmRpMjMxZGFGTnU5YUk4WDQrakJMUjBVMmVhTFNxb0lLMnF0bHZaaDZz?=
 =?utf-8?B?WWRHNWwzanVZV1hGV3hNZFJBL2NCOUlKcmw0Q3Qxa2Mrc1liQTBpcXA5cDBU?=
 =?utf-8?B?bWlmTk9IRDUwT3lGenA5MkxIaUducFQ4RHhtK1cvSmFMS3daYk56anJEcGwy?=
 =?utf-8?B?UTJxcjdubDZkM3BFWVZRTTF4SjBnV2VMQUJ2RDkvdFdwUGNlb2FNR2xhcG9L?=
 =?utf-8?B?ZGNya2VjWEhoRHR2a2xENnZyb3BiMGRYRDJWUnoySldtTjRLeVN0cXBsc2JX?=
 =?utf-8?B?aENTVG44VzFQZURPNklYVG40U3pnTTFWdnRXRmg0WENWK1crdUdCMTBhbnFL?=
 =?utf-8?B?Q3VvdC9ZZzNWSUg2NW02WWtUbWZUcFBaZjRUeUIwNFowTkMyWFdxQXNtZ3BX?=
 =?utf-8?B?WFlsRlQyZlM5cFJnaHhsdk40Slg0dnVuL0V6SitYdlcyNCttNWc4T0Zabll0?=
 =?utf-8?B?b240aVFJY3JmaWZEcXRGdGlROHBRVE5abExTK1pMTFpXL3grL3hnNjVzLyta?=
 =?utf-8?B?eEtJVWxPVmp0aDJYRzJHTm1MazZhMm4vM0lNR21rT3ZZN1ZMWi9LRlN3UVJy?=
 =?utf-8?B?c2VPZ2I2R2k2cFozb0JKdzZKUnNpWG5iTHYrbVdmUW1QNzN1TEN1NTFOeU1F?=
 =?utf-8?B?Mm81UEFoQ3R4REk0R2w2cUw4ZTN2a2Q4ZmlCREtoRTYrMW9Wa2xqaXZQSUc3?=
 =?utf-8?B?RW1VS20yNlJmVk8rYTZiZ3VrQ3Z0WTBOVUdQSDZTMG9PcW04aEdSeGlETmE2?=
 =?utf-8?B?RXB2aU92dnJJN3FiLy9QSFY2Zjk4d0ZDbmpSZEduQzdJMkc2am54RG90UnZ4?=
 =?utf-8?B?VmF3ZnNIb1psUElyT0poUkxZME1ITlpHemtlRUJMUXBSMzZHVGFQN043Sndo?=
 =?utf-8?B?YlhWQjhSYThTeEtrbFZra3NENHVWd05aTnd5MDduaXRVOVlDVGhuZWFTeEY4?=
 =?utf-8?B?ZjRKTEJoakdzakpnb09zbGxmZ3o3dzVIUUpUcjAreWMvZWwzSnA0NWg1eE93?=
 =?utf-8?B?cVZQSXhIVWZ2ajJYSVlKMkU5ejh5SHZsVW5hQjV0YlZ1RmxWWnNGRmJoNVJN?=
 =?utf-8?Q?ZaSvtK8U+IRPygsAh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ec13d-0dc5-4a67-4391-08df1b0ec5a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:10:37.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bu6ywiOmRD0Qpv3CvALQom8dM9bGaPvEI7GjBs0po4DW+viJHndKax7gTyhqUxq1sO6I4bDlsZi8d0p/Ly4QbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

On 9/25/26 06:50, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Sep 25, 2026 at 11:31:55AM +0000, Freeman Z wrote:
>> Hi Mika, Alex and Mario,
>>
>> I tested v7.3-rc4 with the following Ubuntu SAUCE patch from
>> Chia-Lin Kao (AceLan) at Canonical:
>>
>>      thunderbolt: Fix PCIe device enumeration with delayed rescan
>>
>> Ubuntu SRU posting:
>>      https://lists.ubuntu.com/archives/kernel-team/2026-April/166926.html
>>
>> Launchpad:
>>      https://bugs.launchpad.net/bugs/2139572
>>
>> The Ubuntu posting says this was cherry-picked from the corresponding
>> upstream submission:
>>
>>      https://lore.kernel.org/lkml/20260121060857.237777-1-acelan.kao@canonical.com/T/#u
>>
>> The patch schedules a delayed pci_rescan_bus() 300 ms after the
>> Thunderbolt PCIe tunnel has been activated, to recover devices that
>> pciehp did not enumerate.
> 
> Oh I remember that. It's a horrible hack that is never going to applied.
> 
> Based on this we now know why it "works" in Ubuntu. Thanks for finding it.

Yeah; great finding, this certainly explains the difference.

> 
> I think the real issue is that the PME is not propagated as it should,
> either missing wake or something else but that's what the AMD folks can
> hopefully help us to figure out.

My guess is that there is a race condition of some sort happening.

If we can come up with a repro on our side we can dig further into it.

Alex already tried to downgrade a reference board to match the AGESA 
version in your BIOS, but that wasn't enough.

Can you please share your specific kconfig that you're using?  Maybe 
aligning that can help.
