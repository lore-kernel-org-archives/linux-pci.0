Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92F48AE04;
	Tue,  5 May 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997304; cv=fail; b=kCYFiPM1DlqTbFGDRCitqnRZqbZyhJVW2yUA1Wc6pD1SSx9N6GKMX92XJfFyOUitAXpvWnZFlX/bu0mdaYJJ9yGMTFHBCUqv7hQ+aIANZ8QWbR/MQPby07t6E4xrwMvoHReOb3EB/p2HI4uPSru07BtbsuATWR+6vAC1v41nasQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997304; c=relaxed/simple;
	bh=BnJwGQeHzpJzW2tu3rv+HhBz08G+PLSNJkzFdiLoEvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHj+893EuC0t1Z68MqQyjtyfLk27gX6bF3xr3AMwTvkWzvJpUdTLQvV8PAAl6clFOz48r9YMT2Xug2f3AQkJpFcO/vu9iJ+VH+ar8E7oawDRYDfxYQImRGAOs2wljzxg/2qz35bGgDs8Giw582h2rpW9W6RXwMH3dxReZb49PZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SOjQlL2A; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOjQlL2A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxb7fwa2uRIHAJOOmCq1VxvhlCpA0a4bRPsK4vCAhRLIjEXlKmQafWL0tJEztkc4H/eF45XfgfpN+R6yzDnF9XJd+cax2vZkRuifwJoBWVfgi1r+lsCpuo2v5y+edikA2Q4S92drdbitaFkc3rx8oGTWmr3KClm6v2m7jgvp6lKluzyEuRVKYgXhtd0HED4ra31GvRREcuybuokCSUp5SUQvVzhKPdsc0AEzfyJWSXoA342BXqfjA68/a3nqvIEK0oSgkV06CBSBDDhMb8X7IAK4f1qPAy6COjBJDDIORv+77eK8yooitUjg2eqbDdh+XDnk8MCObW1H5THF7YEkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byfEZ5W9SJtkJg6NKf5bF3ihDle7SKe/bD30J6Ex6LM=;
 b=xiL4nzZsdaPgXhBBl0fniiTXvD7CcNBtiIEKMSiwC+kT7y6QkcqIx+Euok0QYKArKRmTuWoFO8aqBf3Fcq+zFzbu58ZLGocPshKg6575EdBkll0mgLacA3LlAYwODClH2tUnN4UFXgReGyL02e8dcLb1Y3PZJehNhmCw12kn2B9zzRIZKUuWuTi8DHeJ6dOfTWRRx14kQgMZuWfklNUpQY/pZ1w1pnky8f4ee/miNZ4sEjS0UosvuwwSJp2qZejGElN2iJHMg5UkitMSz6J9mj6X13IXNZtXkROpAI9Q/xQLNWSq083olnrHEzAe27pcKLQWTg6caaHSR6fhgn/YWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byfEZ5W9SJtkJg6NKf5bF3ihDle7SKe/bD30J6Ex6LM=;
 b=SOjQlL2Al7JQYcJKrMdWGT6j6DGi5BfYfkse4YTzn3/M5E2sFiX4UCKnORJZAT+4MLKcS+3VLSgyNlziQ+Cr1RfYAKY6cRDr/Ym0u07/T5EEATep5abJgp+NbGeIaqcmKITlpSU0qJD+UVNI0zGn7bT01HxUl6WgrTZCCgge0g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:08:17 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:08:16 +0000
Message-ID: <66ceb34e-17a0-4ff5-8534-9067d4e9b32c@amd.com>
Date: Tue, 5 May 2026 11:08:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pm@vger.kernel.org
References: <20260505160525.GA733339@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260505160525.GA733339@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: e88d4a6c-9eef-4183-95be-08deaac08491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xybCIyPg2Zy1bf+C2om1h9Rg3bjlXnnVuwsOvHkTjX9L9J/URuBd2wQ4vVhregF9z3RaB9wdVoFtJwHn9AFckZ7pM9IODFfs0G+mNZL8UjzENYUqGr4FKGtf4jmC+hl/I/taNTcVEzovjlLdUiQNY3qESsbmduGNaRGv2LwizdwsUGFeGObCzCyE4FGrXz6UXCcd/h/8wuKoVVLkhqqbcBholFvmHI9Dhbzsd0UHhbaaz9og2HsarCtTlOZj3leFa4ioi/BLB+7z/7U110TJM0IgFNHWjkiBnwdTL8HQCPbPxioRgFdwrutU0PntIOORrBip0khc+R8dqCW/FMROzMdafg7SMKyhp4wxhtEDyZFXbjRQgomnioPF3vcu+8aYUJwOvSJazcqs2CUGEpacrP39l8TVE07iKC5o8g6hUcX4uzo7fyptsZ5dLRm/lCRioKlRmnieTj2fuFs2uLAaYvfqISwfQWQsvI5Tg5cVJ1pYJex+BsthRSBaW5iB3qKG68b8MRmLXCg0f+Kq2YJ7eQkqfemGzyQI3gh1GVawmDx5bbKD6+tmQI/DAFierKo9mCs2a//hvRBWijI4RHUi8Y3EUQFouH4SzAMjSRIqsyGY3ZJBTV0KRR/E8MMMycUMla6pZw5UBcobCWXnFRoUJIos64DVPea+A3zcGn0hdsGkmwLBQXGVceikEu/ybWlb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZsZkI1MDFMZlZJWTkwaFVoeUtzNG9uMVZGRWU3ZWFJMENKZm5weWZxbFFE?=
 =?utf-8?B?Y1ZHMTM3bmtYTlRwc2FJb3VXdDNJL3hxYUo0T0c5TmNMaVcxbW5NczdkdU1y?=
 =?utf-8?B?SGJDTDc1SC9uajMxaVRIRFBwbVFxbTViYVdWUjRUM0U4TEtjK0lHRmdoV2VB?=
 =?utf-8?B?TVFWa0psZnBWTFNtRll5ZnRoRWRHZTV6Qk81Vk1DK0VlWXQybkw5TktEcVBW?=
 =?utf-8?B?VWVnU29KR1lpdUpxQzBpU1RKZC9DN1RNVVdqV0ZuVDJXNWZjZVhhL0RyTVVj?=
 =?utf-8?B?UXBnLzdxZDRPeDB6eHlvOWNNc3R2R1I3TFpOZ2ZHelArajR3VG5yZ0JPS0xV?=
 =?utf-8?B?Q2h0ZDZHWU5NTWw0ajhHVHZOZTRibEhodXdrVnFSdFI5N2dLZmlqSkVkUzVJ?=
 =?utf-8?B?WlhNWkE0dmg1emRpRmI2TzRBcFNneU1SMlpHRWxSZlNoYU9sdjF5S1llSWxH?=
 =?utf-8?B?OFpBRDZRc05ycGxxK3UvZUR4OTJRMGdFdEZMTWlCTCtTd3l6aXJDZFppMmZw?=
 =?utf-8?B?UGY5MU1pTjdFM2tYdllJUDJ2R1pRNlJldmdSa1pGYzJUVU15SDJCNDJhdTlH?=
 =?utf-8?B?b0x6RzE5R2gwR0xxeVZYTGNnblQrVHRXeFJHM0NJejliUUoyNy83R2FDUjBu?=
 =?utf-8?B?MUNwakJleEE2MHVBd0JTcVdNeHdyN3cwWG9MWUpOS0greHFRVlZaQjk2K0pL?=
 =?utf-8?B?cjZsMmExR1lDa0xXUHRGOHd5K3FneU0yV3RtbFQwdG03MnhwVVlmWXZTMVNv?=
 =?utf-8?B?VkVvcUFUQVpSS2w2TTM0TzdOOTZYZnlGTlJTUnJHSHhibXBkR1JRRk9aQklH?=
 =?utf-8?B?WlpZUzlkcWhZaWxURW5EbHVNcThxa1NGQXB4dmZDbHc4RFNaaEhTcnJPZ0U1?=
 =?utf-8?B?bS9OSW55bjNqTjExS240NGN2WG8zaStoem0zb3k5NWRZeUQ2N08wK2Q4c2Va?=
 =?utf-8?B?QmhDZW4zaEJCNFRmOWpSYllVNURTU0NSNXBIUS9GbkVHa21LL0RoWS92VjJL?=
 =?utf-8?B?MHJKT1ZuMkF3YjJVbC9XMnR2cGlPdkxOQ01QWC9wTXlOaVc2Nkc5U0k2MmRP?=
 =?utf-8?B?bldMaDYrOHRQTkdmWStUbGZWWTZuU0Y5T1VyK3dDUFp5WlREQ0R6N01ZdDZs?=
 =?utf-8?B?eVpZYWVrUTUyRXU5Z3FPTGo5THF6TWFPVnhYUzhSaExQTEZkMGo0ek11ZDhs?=
 =?utf-8?B?aGdveWVSRjJpMWNQSjBZSkhQekFWWWpPZkNIY3E2dFFkN3Jpck5UQ1hUdlNP?=
 =?utf-8?B?czlQbys2aHI4Q0V4TFpLbnFqRmZ6d0pqVHhwUGdKZGMyMmhWRjdmbXFtU3Jo?=
 =?utf-8?B?QnR4WHBpaEU5cnBKNkM2TjBxdklham1VMVl4L0lZYUNpb2lsL2U1YXI3RWFo?=
 =?utf-8?B?dmpnQ1daTDROR1JXaEFFTVJOMVFDMms4anhQcTFzR1NmT3RHSmQydjBUNUpN?=
 =?utf-8?B?Yk52U0NRdHQ1YlJlRDUreVk3cEtYSHY1Y09oY2xreFZaSzc1SU9DM2V6R3Aw?=
 =?utf-8?B?WFM4Q1VmK0lPWlJOLzJQMXcvNERvVDdVOHVtNlM2eDlOQ3Q4bUFTSHJOVDlO?=
 =?utf-8?B?amlDN25NUjRMM254cjBiNm02S0FGY1JkYlBPc2RwaDlNak5paXA2Q0tlZ0Vi?=
 =?utf-8?B?REF3d0Fqa0hudnBLRi90Tkdya2JOYVcyRUR2elFHT2MyYm5OcnJQcno5MDV0?=
 =?utf-8?B?RWZVK3g4V0wyaUsxR0ZGQWRJYjlzcndpMmR3WmFHYjVJTUM0dTJOREdIL2lo?=
 =?utf-8?B?WnN2NnZLRC9nT0NTOTRuNzBSeGxlcWhldTVpUXBwZ0xQTXZFemg1QUpjZzQ5?=
 =?utf-8?B?RlU0SmMwVWZObG1BL1hPNmt0RDY2VWovU2VhVkhzb2YyeW5GUUUwWnpXWkJE?=
 =?utf-8?B?MG9TRmxYZ005N2p5SnpUWHlMWnViN1R5bWR1YmMxd0VDL1RBTW1CZkttMXpQ?=
 =?utf-8?B?U3lmU1h6QzdIQUNSbmlmR3I2N0JmVS95akVOeHBkdm5QN3hIQUh5NTZCM01y?=
 =?utf-8?B?NWJQRzNNdXRFcGRIQnZTaWFwVTZtWHhrOVlCek1pY3hEaFdhN09HaGdQZDMv?=
 =?utf-8?B?ejRrYWppYU91UTFyenA2dFVqbzlVSHFTTW1BMlVOZC9KSnU0b3c2L2RuakdR?=
 =?utf-8?B?Z0xiRitwQ0xMY21HdGtsTjRiR2d2NzJUcTl2Mks1L000NVBUZkxRK05rK0l2?=
 =?utf-8?B?Vm12RG5XVTdkaXZVUDdCZHR4cjNMREltZE9McUdSMEY2ZWFGbXh3MWFmWWNh?=
 =?utf-8?B?UG8vaFNOYVhhVWxHNFZ0V0NRUjA2MzNFUXk5cy81QVV5VUpMdC8wR1RxSUN6?=
 =?utf-8?B?b2tzLzl0eVA1cGdjNDdtUlVZSXZZQ1daY0pObFdRdXA0c1FWYjVPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d4a6c-9eef-4183-95be-08deaac08491
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:08:16.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9ispOoSg7ei44jWEDWYiqg8uFfUg95L3nDo9l1jNo4ZiWFfTW83pMAQi9v8figXu5nVyQdTB87Dupc7F4TrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845



On 5/5/26 11:05, Bjorn Helgaas wrote:
> On Mon, May 04, 2026 at 05:52:46PM -0500, Mario Limonciello wrote:
>> When comparing lspci output between Windows and Linux for hotplugged
>> Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
>>
>>    Windows: LnkCtl: ASPM L1 Enabled
>>    Linux:   LnkCtl: ASPM Disabled
>>
>> This difference in ASPM configuration can cause behavioral differences
>> between the two operating systems for the same hardware.
> 
> A tangent, not a comment on the patch itself, but what sort of
> behavioral differences are these?  If ASPM is working correctly, the
> only differences *should* be in power consumption and performance.

This originally stemmed from a significant performance difference that 
was observed between Windows and Linux with eGPUs.  The link in the 
patch points at that bug if you want to look more closely at it.

I was hopeful that aligning ASPM would align the behavior, but alas this 
didn't.

It was still a difference that I figured we should discuss whether it 
should be changed to be consistent.
