Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E24FD78D;
	Tue, 13 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911019; cv=fail; b=ZgWkUArh7IRI70lAzohSw+blSwf4UIz9KD2U0nSPTqx4a0JJ3XDIsrKM344io3X4UlIiD/+8ls3/fpv+vWep++4XrPDQovlCCKL2LBsJacwsTdSSiji0WqoYw0RCPa0CVP/kPKa9Ro41FbSZh3vodeqgLSKatTFdrVPJ5mOu1ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911019; c=relaxed/simple;
	bh=u4GbV/U4Jy2yZKk0wsj/7aKuL0YuqTRRModoj2G0qoc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orsFPAp25BXWQspilG1HIlILc6Kaan+kgFzOTQeXl1JaDcv8H20mqh831g2QlQDgzCwq8zmIzR52MyQccNIhkMPpt4M42JcRcen4Z2vuj/3ZiPO1dlc0K4/Qfn4kGwFgiVY/ROHhZffK8x1/Pky0TdMh/1hcacvrzhJLCqIreRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O9l+R/hV; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O9l+R/hV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L63qhx+llwpjjmhGJr7iSZoY1pT3TVL9CRJqk6e1j2FLSpGGTRrvCWlpX/eWVjkioMUbeq/2At2KtYvPU6BRLsUX9ZkRhtZU5ERPpAv+Yl/JvLP0kOE1ucH6JTYma1dKuTBcCd4WeUfnlbYVM4Uhsl0vIw8g1kOd+zAbNotcCF2tjI+cJFzU4CgI13K7lpYFw+Pa2pGTLPqKuZEIxs2p5MhPLzryspH8zhI7fwpr2TgerBGbB0s8GvERA00b/LAjVe3zRhbGn4Q2+lM0OXFaUxjRDQdvLM0BioWFldrXZFfwRxGiFOlrnTyT2B/QAidLUb8UiOUQd3oq1+W+dhQYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF5A4LWpo1rrwiMzr6AhBvxL7/gerOQ2Dk50oTFzea4=;
 b=eS/LIgUxd3g0BbAGVzIVuAIzIPxvJuuOFGnxVDqpvtcoTMTdgWWTuK/rtCzraYoXNZe3mvGSaQk02Lr2bvAnkMNBXYp18gb4JUbw3x397Wgj+6gCaoJCvZGmBw83r5hoAum7JINMz02ffqyu7+2u6YaDgTIH86RkmzZ91Hh6rTycyMsaPZb2PhVVVBRJBX2F2htVLS1Yf603L25CkCFhGfXUN2MuqI3BZffTgdZi4xCrDUvGouV+S/KxCf9ifdpOEWgxeDsByej0ItNrgtMuHLtYpVAYa7eM+HjGvr1Gqgl239O29xhRacCbUy7N2k/JtTfb946Ix08t+nydDo92uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF5A4LWpo1rrwiMzr6AhBvxL7/gerOQ2Dk50oTFzea4=;
 b=O9l+R/hVluw+ADH5M3UIEo15K0LiX+8f4yNh+KpH1AGeYQJ3ZMSKlNLVhCo4YUnKBmUWFDF3xqlIMvwjfrZy136qxr6M4K1kua0grTUbfB3Up16wmuFjW5of9C/ADgmmwCK9WIrUrNeqosaSw6nC5ExzVU1YflXyfJ5zJ5w8xCw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 17:03:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 17:03:34 +0000
Message-ID: <ed19c161-9703-4967-997a-b9054e92a216@amd.com>
Date: Tue, 13 Oct 2026 12:03:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
 <e3895e35-a0a2-4c32-8ebb-f726a8c8caae@amd.com>
In-Reply-To: <e3895e35-a0a2-4c32-8ebb-f726a8c8caae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:930:2::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 1438a77d-272f-4a40-dbe5-08df294bea59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|921020|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JcnSFUxLS12B9NatHimq0E2QtkUOb+hk17kAuwGz9cNrSARHYY+6SGeFYYJQybIgtz83BMGT6wXUEg/J6Y8r8QsMmkIbNcBKGj4R8aOptIU61wtvZEZ/dn1nVO5crTvuwBoumbnSb0zBR+tVP3epd49VIQu/uJtGtRFatL8GHK+2itll+hhfnW+PXvSlJscxjkYB4pXygevv0sX6aJA8VhlEEiP4klvU0YOfWHLGZt7HhK/ybHBvT9UCKoLSr9Oznmj07o2KCXeebBbKkkQP7vWVfaU66RTNDc52m/crYkvPJwEwssi3gn9pgMVRwtFdKeZ5CkS4YZScVFBE5O7TjqWS63dHgshsHW+lB3B3dcQzk2wxz2SwU/sDY3FIFFJDcYGqDoJ6ORwl40/ymkpG0JQTULPXZbDt0VEuOLsZO7Omu1OAmaPSP7MY+HApmFefctmDRNDSKz2b2btaN+i1yBv80SopqmwRb3ea6e3JYDcTWYZl+D7dMA1GMFtvdrh06lk2Zrkn1WLr1TJo/nHS9vvWeYdESB2BsYB+c8bXMVUgoxyqUkeIzhQ2nRjo5wTNmU0KyNf0R/VU4fOm5jqLAwIlFx3S8bKSHkxGiyO/1R3eyvnKRSs3pChSEt5TZF7i2xdR5/kVaimYcDhzUzmlCDBh3VtqiDIWUpvanEiGTpk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlN2d3pSK3dXS21zTXRVL2tTdzZFTVZ4K2M0RVkvL01EL0dOVzMrRTRhd29m?=
 =?utf-8?B?UEY4czJMQ3E2c2VnTmhUbXlXMjQrN3E4NkdlY1hndnZpSzl1Qkk4N2Jzb2F1?=
 =?utf-8?B?R1ViYTVpNGd1OUFsZndpanppZzFIQzQycGlWbG1ZcWwrRDgxUExZMk1PWCs4?=
 =?utf-8?B?ZkJQMjdKeFEwejYrSFlGTzIxa05CNEVXdXM3N2xCWFpDMWpaTS9OK3o2aUsx?=
 =?utf-8?B?d3ZKNEF1dDdsemRBUWlOcWh5QUNjdEN4dTlWeHlrb2ltQXU1RDlLSGRMY1ZI?=
 =?utf-8?B?OFFndThIeFlxMFh3RGtyaElLYVlDckFyUFFzQ1d1aXFDU2RsWXdTa2UxbkRu?=
 =?utf-8?B?TE1HRzlLa3pEbExhZUIwOWlhNm1iWXRoL1Vad0FISkNkYlgzc2ZzaHJRWFY2?=
 =?utf-8?B?dStMTXRQSVNiT1Q3WG1hbDV2VEdkaENkVXZSUWk5MlZGTUs3WXpEaDdwWXlS?=
 =?utf-8?B?OEtiZHFtbnBDM2RYcDBNUzZIcXI2Yk05MDZnZzJyd2xnbTkyOTZJOWhIUVh1?=
 =?utf-8?B?V1RQdndFQ2dVdzEwM21Kd25waXhJVVNaVVdRVGdZbzVlQlVlYk4xNndsNmZv?=
 =?utf-8?B?Y0J4TTlDMXcvc2lTZXFETEhKdUN6KzJhQzA5RmowbGpGd3JpdmpuVFJITEJo?=
 =?utf-8?B?dmtoQ3FSczVORUpLbjdDQ1ZnUENMUDM0cHZzNGVDakEvMFdxanhPNjNJYnhT?=
 =?utf-8?B?QXpDMWx5eVdPd2ZMM3duVlZscE55U2ZEVVJiWFFuZUxndzRtOFNuSm9YZldt?=
 =?utf-8?B?a3ZvaVR1MGVTVzZLNlpCY3BpTEpMbkFVK242Z2pBR1hVUTlGQ1BzZi8yeUtw?=
 =?utf-8?B?VllUMk1oSnE3cDNDc2FwMlRIeWdieVN3VUM4ZUI4L3l5eUVYMXpwU0V6VklN?=
 =?utf-8?B?dHR1eE9RZnpwaXZ3cVJsRVRKNUozYmU1STlwVkFCS0UwWGNpS202OHNudjZS?=
 =?utf-8?B?MEwzcTFyNjdnQ1NsY2Uva0hGR3FoeitCdXIwbit4dzdCZDhkVmQvS0tWZTFn?=
 =?utf-8?B?M1U0Wnd1YllaeEhySEtoVnNja2Q2ZHM4ZkM2bGhkbmpUZ2lpSVBMck43dWd2?=
 =?utf-8?B?ZE82eFUzYVFyd1NNNUsyQWJXcW1VRStvb2d5N1p4UUU0MEdnQ2VxaU11QVdT?=
 =?utf-8?B?Z3MvM1UzZlF0OTEwTUxXbWpmYU94c25FK3Ywd0orcnV6T3RoVmZJdk5LT0F1?=
 =?utf-8?B?N1JUeUFvWXFsMDNXUzU3RVczNVpHQklVZ1ozUXB3THFMS0diVWdPc1EwbUZ1?=
 =?utf-8?B?R0g2MnVoR3BLc3hMM3ZyZDlYV1N3a0NsR09PV1NwK2QxNmJ6QUdMVWZvUC95?=
 =?utf-8?B?aDQwbnJYL0gxS0RqdGhDYk92KzB0aS9PdytPVThsL1JxZUtwTmlaMXN0bS92?=
 =?utf-8?B?QlhJWkJMV1V4T2I5RVJVUUo2NHZNUmd4cXBOc0M2S1A0bHdhL0Fhek5ISkVa?=
 =?utf-8?B?OEREandLclJyVmlmWEdqSHFKTmNYTVhBbWQ3aG1SWlZ4TE1iaGhxMzRCRUZR?=
 =?utf-8?B?dzI4MUlaSzZKS2VoaVgzKzczRTBQYStkZ29kbEs1UFR1d1Vza2ZGN1F4aUlG?=
 =?utf-8?B?Rkg1S2x3cTgyVW9BYVQ3cTdHUXVKdHAvZ0NaemJpdHhuUXZCK1l0T2plVG41?=
 =?utf-8?B?UDRNSkhodTN1YUdqZ3F0blAydjFwa1VnRjRXV0dvZWVjRnJrcjViU0o1MnhU?=
 =?utf-8?B?U0V6N0M4VVJnSjZWTmduVlpFZUQ5a3pZRDZKamdyN3ZUcFU0bWdMSFlZUkE1?=
 =?utf-8?B?cGxaejdmT0UvMHpxMUNDMjRNNGVxekt0UG54b1hpS25HWWhSWFZSbDBsN1gr?=
 =?utf-8?B?L0VIdlR2bHV3Sld6NEgxVnhmVTdPS0NndGlTM1pNMDJDZ1RFYjNZTmJLaVFm?=
 =?utf-8?B?L0RVdjJ3TVlIZE9zV1pjVzZGajJtVGRDZW8wdVhEQkhKSDdRRnZPbmxzNWRN?=
 =?utf-8?B?QWd6SEl4cXVQN3NxZllzKzhnVDJDUlZ5UDl5dGl2VzNpeEVQVEpFZWxzZFBU?=
 =?utf-8?B?YnJTTnlaVmtQV3hVN0lLQWdCeUV5RlM1SDZsTUFEZ2M4S3RIOVl4Qkd1OFNi?=
 =?utf-8?B?T2dYRmhvWkhtWDVOU0lPTFc2YkRMcU4xOGkvNDc0OEJkNVFHWU85c1dyMEpH?=
 =?utf-8?B?ckdaRTJubys1cnZIMEkwVkNuSlBBY2lZdE5Xckc3cGRGbWtxRmpnbTFSeXpC?=
 =?utf-8?B?MHNCU2NKTGY5T1pjWlNIakh2ckRMMDhkZXUyWTVkcXlNSFVTVUJaUXNIYkhL?=
 =?utf-8?B?RkdtWG1sZ2IwZ0tyTjJXZzNRTDdYUmtlL2lGWFdYZ3BNOVBSMlh5SWRkQkFP?=
 =?utf-8?B?ZHZSQ3lJdXVaRTdQc0tuM1JBbWJGb29WN3VrNUloU0llN3ZGeUZUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438a77d-272f-4a40-dbe5-08df294bea59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:03:34.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz9p6e3LDLMcJkb3ER30VgaiYr6q9hB5pW5KCXgbpxS6W4kNMwOY9UeWEi0dh8k65xTDXLjZJxYUjkUk0nzG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745



On 10/13/26 12:00, Mario Limonciello wrote:
> 
> 
> On 10/13/26 08:09, Ilpo Järvinen wrote:
>> While testing the resource placement changes, tests hit a case where
>> igb fails to probe when BAR 0 is placed at 0x9c000000:
>>
>>     90000000-9cffffff : PCI Bus 0000:a0
>>    -  90000000-902fffff : PCI Bus 0000:a1
>>    -    90000000-900fffff : 0000:a1:00.0
>>    -      90000000-900fffff : igb
>>    -    90100000-901fffff : 0000:a1:00.0
>>    -    90200000-90203fff : 0000:a1:00.0
>>    -      90200000-90203fff : igb
>>    +  9be00000-9c0fffff : PCI Bus 0000:a1
>>    +    9be00000-9befffff : 0000:a1:00.0
>>    +    9bf00000-9bf03fff : 0000:a1:00.0
>>    +    9c000000-9c0fffff : 0000:a1:00.0
>>       9c100000-9c17ffff : amd_iommu
>>       9c180000-9c1803ff : IOAPIC 8
>>
>>    -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) 
>> [size=1M]
>>    -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) 
>> [size=16K]
>>    -       Expansion ROM at 90100000 [disabled] [size=1M]
>>    +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) 
>> [size=1M]
>>    +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) 
>> [size=16K]
>>    +       Expansion ROM at 9be00000 [disabled] [size=1M]
>>
>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
>> ------------[ cut here ]------------
>> igb: Failed to read reg 0x18!
>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at 
>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
>> ...
>>   igb_get_invariants_82575+0xff/0xf00 [igb]
>>   igb_probe+0x3c8/0x1190 [igb]
>>   local_pci_probe+0x3b/0x80
>>
>> It turns out there is a 64kB iomem black hole at 9c000000 that returns
>> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
>> card is placed into that address, it is similarly black holed.
>>
>> Mark the problematic 64kB range reserved using a quirk bound to the
>> bridge found in the problematic system.
>>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> Cc: Borislav Petkov <bp@alien8.de>
>>
>> As an alternative to this, I've also tested reverting the commit
>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
>> that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
>> entry in the resource tree.
>>
>> ---
>>   arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b301c6c8df75..cc463bf492b6 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 
>> 0x1571, pci_amd_enable_64bit_bar);
>>   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, 
>> pci_amd_enable_64bit_bar);
>>   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, 
>> pci_amd_enable_64bit_bar);
>> +/*
>> + * TODO: Remove when/if root cause is found.
>> + *
>> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
>> + * address for which all reads return ~0 blocking an overlapping BAR 
>> from
>> + * working.
>> + *
>> + * Work around the problem by reserving the space prior to making any 
>> iomem
>> + * allocations that could overlap with the black hole.
>> + */
>> +static struct resource genoa_black_hole = 
>> DEFINE_RES_MEM_NAMED(0x9c000000,
>> +                                   SZ_64K,
>> +                                   "reserved");
>> +
>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
>> +{
>> +    struct resource *r;
>> +
>> +    pci_bus_for_each_resource(dev->bus, r) {
>> +        if (!r || !r->flags || !resource_assigned(r))
>> +            continue;
>> +
>> +        if (!__resource_contains_unbound(r, &genoa_black_hole))
>> +            continue;
>> +
>> +        if (resource_assigned(&genoa_black_hole))
>> +            pci_dbg(dev, "iomem black hole workaround already 
>> applied\n");
>> +        else if (!insert_resource(r, &genoa_black_hole))
>> +            pci_info(dev, "iomem black hole workaround enabled\n");
>> +        else
>> +            pci_dbg(dev, "iomem black hole workaround add failed\n");
>> +        return;
>> +    }
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, 
>> genoa_iomem_black_hole);
>> +
>>   #define RS690_LOWER_TOP_OF_DRAM2    0x30
>>   #define RS690_LOWER_TOP_OF_DRAM2_VALID    0x1
>>   #define RS690_UPPER_TOP_OF_DRAM2    0x31
> 
> I guess it's good we know the root cause is 07eab0901ede. If we're going 
> down the path of making holes in that we may well put the hole in 
> efi_remove_e820_mmio() like this (attached).

I don't really like that though.  If Genoa is affected I would expect 
plenty of other machines are too they just haven't been found yet.

Can we roll back 07eab0901ede and add quirks for the busted machines 
instead?

