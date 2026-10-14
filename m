Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578A3C456B;
	Wed, 14 Oct 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010234; cv=fail; b=Te7EozGrqjoml87pel1hrETEPgL5N0TxvuekcHr1lN1xZdHNsnw1T8SI5TqjKpuTr3ZCYUIFUSsh2eEdAII37bgTkdxeSHskO5C7nHXqDup3A5lt5WosgK7KRqdbLJwZauHEr7Fk25Qb0q7WBWndnpoB26y9UwrP6dwoZltX2E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010234; c=relaxed/simple;
	bh=6E0jgTVpvuCe2f+K3fsDTLGZ1udVZQJiRAu9ukVnGeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CY6pmm+uGh+gToEiTAdvvAy+KQPGoQX3f9si8DiF6ygm8WqHd+mTcnpPoY5Yfdp+eP78TPn1XqsKI3nAkurbQ3B1sfKuY/Ww5n6eBxHycwU0bAJGPyv9xucFSPnq0tDBU3B7mtYUw3ceKD96ZDLYrScu9n1zI5zPqjpjbkl5o9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dK2oGqIU; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dK2oGqIU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAog36LEdDGAT7pLK2UaypZpKshxxL7ojb5mE+pm5qGnjPLS1UjgLwHWdKXPnbs9soeeIE64rUiDO+7M5IhTJ6yQ5Net9ze69PF2mmLyrS2fTwBZZQ3E7pfwDqGLTUeFlwA42PH05GKc7nWjYlllKEv+2odw/DIBqQLRxd2pYWQ/lpbV+gIb7Rw3HvFSn4OKwJBF1zj+0jQq6Vlj8U65KDefKjCEH+kEf+jBjrZBMNMOHtE/LkhDDF2ceGi731mdNtdbkkSg6I1yIjx4wYaQsj2cJ14wNB7qLx1uU1K1ERJi5As7VzdVY+JaLVF2nVYeg8FdcNCJUGC6tTiM/RchuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81LkLubnJjNMJX4rwCIjUVsrIVnYwwfBfVlcAkDgHTE=;
 b=kTDnmsxTnrikqGykY68DePgzxbrsM2Rqc5pssFVwQvPChh3/PNYHrXe4VDlz/4+ebyV7xWPjM+fnzGWWCK1hJr5Jj92YBGzyyomu8pabsLjRaoliiR9BSU4d8LAJYbUPBL44mwZJ1xZYITf0nxiI4CJgYQRtJijQ00L5SPxUQuNdsUtGtg63u5OmLyUelFmcRgo6XNzRN1SbJjPN9dMrOHTJ/INtMoEgqZIzCkAsrphVP/n5WOwD4vWIylyfgslk5EqkTjar1y5PE9780ma9UVefHwLcFpwuoWGo1CnYOzqRoc8LUwRJgNn5+bu2D8Yn+M3vRW2Oc7RLVJXps6oSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81LkLubnJjNMJX4rwCIjUVsrIVnYwwfBfVlcAkDgHTE=;
 b=dK2oGqIU5Pt4G6818p1mIbo9ID5H9DDMVjqf60amA3mX9nLHEuWTjFBrnKxhuv7oQd04Z225vw3xCXOrarW+MwygByEX/kGBUpITg8G1Kj40FkVrbpZvIctVaNIx8o5UC8ikF8ylTJDmHnURiQIQaamQUkZlN81VP4UjMQhCy2U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 20:37:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 20:37:04 +0000
Message-ID: <da239633-c789-41b6-ab92-ed1575f0d19c@amd.com>
Date: Wed, 14 Oct 2026 15:37:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
To: Hans de Goede <hansg@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org
References: <20261013224010.GA1589480@bhelgaas>
 <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 3175e16b-0fd2-4d57-10fd-08df2a32e7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	emVOPcSFDDHezRNWTIZEZ4D6XiPzw2azcenGlaNzlwvABEU9SlTbjYL/50FLfAYHyb5IHS4zOrx/PX5SOiBjnZmhkaJoRg75N8mmL22TESjZNJS2T2ZtM0mfWP7EKQZ4rs6ZaLBqCZ2Q6Zj1csWcDFmd8e1G1u+O70XA9GOocBECJ6fNebhGG1awyD6vIquhMwsGDEx9/ZIOTDM7Z5wMu5yWYIYgta2jceFeunoWJ2ESQUnRmZ/svC3rz5H7VJADsgy3cwW958KeCMOA9+MFBK7Svh0XxwcCW5t4d2Ya/xMKc0HIUPYHeuuRv4OzecEb9f8dQQy1IJv4xfxX3w995E3iym2kYHUy/YXasD5fzDQ4vypcULkDQmaJ294slOesUD4fwTHpBcZL6cnVJhIZwrGELtAn4q5zkp7ciAVY9iOZxbMg+YfcXJqln9Iu9bxuZj5xwuTDzeRa6tOKYGr2mi2Wg3vG8U5pxXBTXlbvU5atm6lF6YnA8M9s0RL1wyW7z16A/4/ieV7gByDJUrFgXIVaHkTa2fgahituSHzgg0CNmuvhEte8oZcpvSTJQqUnH/TXnFRU8044Xlbrlyi7XjALBXSlij/uYYxdpRkpw31aZ10ZvGADtPz91MnQdXqe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEhKSnpmaFBZaEEwVVFNbEFHb2xaaG5aT29hd3lIQXA5TUJQYkJJVHBHd0xY?=
 =?utf-8?B?c2E4OTc5K0orQnRzSGkwRHoyKy92ekJ6dXdsUElFa1FhZHV4cTMrOGNvT2lx?=
 =?utf-8?B?UnFGK1dTSTB0SDBhTXdWckVobVR5SlFtM3NKbjZsMERhZ05GZktMZ2U4SlVB?=
 =?utf-8?B?aWNiWkFSS1ZCelpPWWRLYXZGNytpZURESlFad0Y3M0txdFR4alRxbW0wUC9U?=
 =?utf-8?B?NE5NZjA5VElGUXlWcXpib2lHek5wK2U1bTVINlhURTdRS1FiaWExOSt4Q2V5?=
 =?utf-8?B?Vmsvd2NjcVBSTFUyTlFTY2tmT2ZIZDZmUHVXaWMxTGJrVWdpSEJjeVRCc1Bz?=
 =?utf-8?B?Y0R4NGVEdVJkbUJTV2FwMXFuS0NBL2M3dlZhS1lhdzhyend2UkJ6RVZwOHcz?=
 =?utf-8?B?V1pscm54V3dnYzdTWW56T3dhYXQ4aFluSGdDemdyRjJKalNLQmRId0dwaURz?=
 =?utf-8?B?T3E4Nlh6Zk5xRlRoSWtMZG5POWxic1FLODRJQlpncUNTbGliZnNpYm1JR3Vn?=
 =?utf-8?B?N3NhRzltZXJyaXErQjlhVFIzRGhHVWlSN3ZZeTd4b1lOSGgzM1h3c3ZJcDAw?=
 =?utf-8?B?UjNFd2JiRktDR0JwVUJMZnRzazQzd0xFeG45a0Jzbjk0QnBXNk9XQ25tRFI1?=
 =?utf-8?B?aGF6dU4wV0dSSVliTGhseGluZVd6enRmekJFUldlVnhKbW9qQTZ0R1czSGk2?=
 =?utf-8?B?SGp1WTU5OU5yNHZJbjdRZ05vczlwRnBZVCtmRGFGRS9TWFlJNWhSN2FqNEs2?=
 =?utf-8?B?cHRYQlB0Y2srdE5YNzdVTlVWQnc0WXFkcFhGdnpkL01EZDRXc3RVRjhON1kv?=
 =?utf-8?B?bTY1RnJiL1R1Um80RFNPZUl6b0lkWjU4VWc2VnROUEV6S3hMSVFNU0dLMzlR?=
 =?utf-8?B?TmNMQmtwamVFK1RSeDZwa2xML1dualluck5Yeml6cnU1UG9RQlpPNmtMemVr?=
 =?utf-8?B?SzVsTzRtVHA3OG9NTXk5M1lDT0FVd2diMGUyVW05ZTRpakUzODhSamVkNzVs?=
 =?utf-8?B?WWtQUS8zZDRNOWJCWTB1NXBLK0xRcGpIUk0wVENZbmEwSHVhM2lQdjRuNzFa?=
 =?utf-8?B?WVJoUnppUUJHblZIK2kvSFg4TkR6MmhZWFo2T09DVnRSNVh4UUp1aHlKWFYx?=
 =?utf-8?B?NFV6TG9JN25vaGIzai82dVZRNFpqcUJtYmdqdncwajhNV0VvUjVsYnE2Y2d5?=
 =?utf-8?B?RWxsQnB6ckZGNGxsQ202NHNGT0lHNW1UWGNzMEc5SThGYWtLenVjbFc3RkZs?=
 =?utf-8?B?KzN5Y2ZuWVBpb0ZzdDlscEh1VUtIQnRuSzZhUGowOEcyTGRuR1pGQjlYVHp4?=
 =?utf-8?B?YWgvUTJPb2VCZUdkdlArQWdGTWRJUENnMmhodmtNb3VmZDF6WndoZVdzRGlZ?=
 =?utf-8?B?UURDZWJqbW1jZUJRSjB1UU1tcjN6bmRiVXIxejNWQ2dvWGM0b1lTOHhJNzVC?=
 =?utf-8?B?ZGwxcU1hSG1xL2dIbTNDd1VDMnFqMDZpNm0zUjY1eTR5QkpyZjk3eXUrQjBH?=
 =?utf-8?B?d3FBNHlBRDMwcVhkMzREUUFiWUhjSVI1cTg4RG05SzRSNS9MaDBsMUZ5OHZ2?=
 =?utf-8?B?S3lML1cwSXR3Y0R3VkhuMHdWRFVmZ2pscVdxazQxUXNpRGo4dENKd2hMV3RU?=
 =?utf-8?B?c0c2UDJGbmg2QkVBbVkydk9WdCtCUUJjaGpWZjd5b0NjdHlBUW9KREhxQWt2?=
 =?utf-8?B?R255ZGFUcDRQdDA4TEdDQnNvNXRJSnAwSHRhM2JOb1hUZVk1elB1RHUySmZN?=
 =?utf-8?B?THBLR1dHZFNDbC9XZ0k3Z2szQnBoRW1JdUo4VHZvZ2RFTXJMK0RuMVdnN01I?=
 =?utf-8?B?c01HanFGKzJFVnZMWExoRFNQOUg2M3ZWMXlXaXNjRXBuTFJFN01pdFhheGc4?=
 =?utf-8?B?K015WTZFc25EQTR2TzZjQkRld0lLUHhMTjdxWFArZllLSEFRUzlIVWVXYWNh?=
 =?utf-8?B?TWxETkozekR6ZEMzUExjU3BaWlNyK3JwZTVoZ1I1SG9UUGNwdVNnYjhYb1hq?=
 =?utf-8?B?VXRLNFFGLzV2WVRTcHRtdWh0Qy9lNDlSSFJ1RmJuRGh5K1dwb0duNEMzSnZF?=
 =?utf-8?B?YkRFelh3cjdQb2s0MHU5cjArdzU3dFZQR016N0RLbXhBbVJRTE85dG12YWhs?=
 =?utf-8?B?SE5IRWVkQmd5cUdTMWZEMFdDRW1helBxdGdCb01lcThWdlc2SEM0Zmo2b1ZC?=
 =?utf-8?B?Q09FMktNcllvYUxjbVFZb2JLT25SOEd4VWZseXU3M2ZlUWxQc3JwNFJlV1Ry?=
 =?utf-8?B?dm5KaGw2TzNiaDVxN1BGVVNOVjFNZTRaeUZEb3h0T1ZETHhUc1h3VkVudVVL?=
 =?utf-8?B?RUdZWnM2eVlFSFVTK0I5bkpOZ00yQ1VOVWdpUnlyZ2tZUVJzNURQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3175e16b-0fd2-4d57-10fd-08df2a32e7f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:37:03.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogw9d1AUP73qdNrmYfXjlHU6qBKoDDfBW8ZImrLzIPXKTTPMusZ1ODjfHpQ61V1VEQKXPEtkvS5xRd15dyyIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771



On 10/14/26 04:34, Hans de Goede wrote:
> Hi,
> 
> On 14-Oct-26 00:40, Bjorn Helgaas wrote:
>> [+cc Hans, Kai-Heng, Andy, linux-acpi]
>>
>> On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
>>> On 10/13/26 12:26, Ilpo Järvinen wrote:
>>>> On Tue, 13 Oct 2026, Mario Limonciello wrote:
>>>>> On 10/13/26 12:00, Mario Limonciello wrote:
>>>>>> On 10/13/26 08:09, Ilpo Järvinen wrote:
>>>>>>> While testing the resource placement changes, tests hit a case where
>>>>>>> igb fails to probe when BAR 0 is placed at 0x9c000000:
>>>>>>>
>>>>>>>       90000000-9cffffff : PCI Bus 0000:a0
>>>>>>>      -  90000000-902fffff : PCI Bus 0000:a1
>>>>>>>      -    90000000-900fffff : 0000:a1:00.0
>>>>>>>      -      90000000-900fffff : igb
>>>>>>>      -    90100000-901fffff : 0000:a1:00.0
>>>>>>>      -    90200000-90203fff : 0000:a1:00.0
>>>>>>>      -      90200000-90203fff : igb
>>>>>>>      +  9be00000-9c0fffff : PCI Bus 0000:a1
>>>>>>>      +    9be00000-9befffff : 0000:a1:00.0
>>>>>>>      +    9bf00000-9bf03fff : 0000:a1:00.0
>>>>>>>      +    9c000000-9c0fffff : 0000:a1:00.0
>>>>>>>         9c100000-9c17ffff : amd_iommu
>>>>>>>         9c180000-9c1803ff : IOAPIC 8
>>>>>>>
>>>>>>>      -       Region 0: Memory at 90000000 (32-bit, non-prefetchable)
>>>>>>> [size=1M]
>>>>>>>      -       Region 3: Memory at 90200000 (32-bit, non-prefetchable)
>>>>>>> [size=16K]
>>>>>>>      -       Expansion ROM at 90100000 [disabled] [size=1M]
>>>>>>>      +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable)
>>>>>>> [size=1M]
>>>>>>>      +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable)
>>>>>>> [size=16K]
>>>>>>>      +       Expansion ROM at 9be00000 [disabled] [size=1M]
>>>>>>>
>>>>>>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
>>>>>>> ------------[ cut here ]------------
>>>>>>> igb: Failed to read reg 0x18!
>>>>>>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
>>>>>>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
>>>>>>> ...
>>>>>>>     igb_get_invariants_82575+0xff/0xf00 [igb]
>>>>>>>     igb_probe+0x3c8/0x1190 [igb]
>>>>>>>     local_pci_probe+0x3b/0x80
>>>>>>>
>>>>>>> It turns out there is a 64kB iomem black hole at 9c000000 that returns
>>>>>>> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
>>>>>>> card is placed into that address, it is similarly black holed.
>>>>>>>
>>>>>>> Mark the problematic 64kB range reserved using a quirk bound to the
>>>>>>> bridge found in the problematic system.
>>>>>>>
>>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
>>>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>>>> ---
>>>>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>>>>
>>>>>>> As an alternative to this, I've also tested reverting the commit
>>>>>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
>>>>>>> that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
>>>>>>> entry in the resource tree.
>>>>>>>
>>>>>>> ---
>>>>>>>     arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 36 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>>>>>> index b301c6c8df75..cc463bf492b6 100644
>>>>>>> --- a/arch/x86/pci/fixup.c
>>>>>>> +++ b/arch/x86/pci/fixup.c
>>>>>>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571,
>>>>>>> pci_amd_enable_64bit_bar);
>>>>>>>     DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
>>>>>>> pci_amd_enable_64bit_bar);
>>>>>>>     DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
>>>>>>> pci_amd_enable_64bit_bar);
>>>>>>> +/*
>>>>>>> + * TODO: Remove when/if root cause is found.
>>>>>>> + *
>>>>>>> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
>>>>>>> + * address for which all reads return ~0 blocking an overlapping BAR from
>>>>>>> + * working.
>>>>>>> + *
>>>>>>> + * Work around the problem by reserving the space prior to making any
>>>>>>> iomem
>>>>>>> + * allocations that could overlap with the black hole.
>>>>>>> + */
>>>>>>> +static struct resource genoa_black_hole =
>>>>>>> DEFINE_RES_MEM_NAMED(0x9c000000,
>>>>>>> +                                   SZ_64K,
>>>>>>> +                                   "reserved");
>>>>>>> +
>>>>>>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
>>>>>>> +{
>>>>>>> +    struct resource *r;
>>>>>>> +
>>>>>>> +    pci_bus_for_each_resource(dev->bus, r) {
>>>>>>> +        if (!r || !r->flags || !resource_assigned(r))
>>>>>>> +            continue;
>>>>>>> +
>>>>>>> +        if (!__resource_contains_unbound(r, &genoa_black_hole))
>>>>>>> +            continue;
>>>>>>> +
>>>>>>> +        if (resource_assigned(&genoa_black_hole))
>>>>>>> +            pci_dbg(dev, "iomem black hole workaround already
>>>>>>> applied\n");
>>>>>>> +        else if (!insert_resource(r, &genoa_black_hole))
>>>>>>> +            pci_info(dev, "iomem black hole workaround enabled\n");
>>>>>>> +        else
>>>>>>> +            pci_dbg(dev, "iomem black hole workaround add failed\n");
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
>>>>>>> genoa_iomem_black_hole);
>>>>>>> +
>>>>>>>     #define RS690_LOWER_TOP_OF_DRAM2    0x30
>>>>>>>     #define RS690_LOWER_TOP_OF_DRAM2_VALID    0x1
>>>>>>>     #define RS690_UPPER_TOP_OF_DRAM2    0x31
>>>>>>
>>>>>> I guess it's good we know the root cause is 07eab0901ede. If we're going
>>>>>> down the path of making holes in that we may well put the hole in
>>>>>> efi_remove_e820_mmio() like this (attached).
>>>>>
>>>>> I don't really like that though.  If Genoa is affected I would expect plenty
>>>>> of other machines are too they just haven't been found yet.
>>>>
>>>> That's what I'm worried as well. My own testing can only cover very little
>>>> ground here.
>>>>
>>>>> Can we roll back 07eab0901ede and add quirks for the busted machines instead?
>>>
>>> I had an agent dig through all the reports linked in 07eab0901ede and
>>> drafted up what should be the remaining quirks for a revert.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess
>>>
>>> Bjorn, thoughts on this?  I'll send it out if that's the way we want
>>> to go (or Ilpo feel free to subsume into your series as it's only
>>> really exposed by your series at the moment)
>>
>> I would LOVE it if we can use those patches because it's way less
>> magic than 07eab0901ede is.
>>
>> But I'm frankly terrified to touch it because I'm skeptical that two
>> more quirks are enough.  I just expect that whatever strategy BIOS
>> uses to build these maps is likely to be used on many models.  I do
>> hate 07eab0901ede though, so I would love to see it gone.
> 
> It has been about 4 years since we came up with 07eab0901ede IIRC we
> had a huge email thread with a whole bunch of attempts at fixing
> the issue in a generic manner.
> 
> IIRC some of those attempts tried to identify the exact problematic
> issue the quirks try to fix where there is an EFI MMIO reservation
> covering the entire bridge window.
> 
> Maybe we can dig through the old thread and see if with the knowledge
> we have now one of the previous attempts of fixing it from the thread
> is better?
> 
> I agree that needing to go back to quirks is likely going to be painful
> and break a whole bunch of other systems. IIRC 07eab0901ede fixed
> a whole bunch of laptops having issues around the time not just
> the Clevo NL4XLU and Lenovo Yoga C940. But this info might be spread
> over various bugzilla entries, etc. + some models where likely never
> reported but just fixed in time for users to not report things.
> 

So I did have an agent at least dig into all the linked bugzillas.
That's how the quirk list came up.

Whether or not this series is going to help any of those systems I think 
is a totally separately question.

Could we perhaps loop in a all of the reporters from those bugzillas and 
ask them to test Ilpo's v3 series + the revert?

BTW - I think we would want to roll back all the e820 quirks for the 
purpose of this test.

Even if it doesn't help we might be able to get a "live" failure from 
someone to iterate on trying to find a better solution.

> I also wonder if given we only have this magic black-hole on geneo/zen4
> if it would not be better to go with Mario's original approach here ?
> Esp. since Mario's quirk is chipset based where as the other problems
> seem to be model/product based so that is 1 quirk vs many quirks.
> 
As Boris said - it was found on Genoa, but there is no reason it 
*should* be Genoa only.

IMV the firmware on that Genoa system advertised not to use the region 
but 07eab0901ede says ignore the firmware and use it anyway.  So we're 
adding hacks on top of hacks if we go that direction.

Our ("collective") goal should be to get rid of unscable tech debt not 
add more that's even harder to peel back.
