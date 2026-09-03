Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7C343D8F
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402077; cv=fail; b=CD6Tx8Uz9lJizWhWNtDgFHkbPCgS1bThc3PnUeV4fXvzGp6CZoVA1Wy6U6RO7uRgt0PE4KFdhkLjbM4EAHvgWvbnbYa5qkljgFziJDHHAKvZt8F9GQfOTl5AepmUxjh27cNLrQgpYT1SV8cGzp5PaYJh9d1tX1adTPo1Q1r3vE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402077; c=relaxed/simple;
	bh=blNLCiiHHPh8jcP32ITz1tCGwzLNsKZWrqbAyE0g8HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZo5J2YZXuVQoVoJCew4NpEUM1tNfaz9RaeNJOUzc+ZgSSlZ2DFXb8PsrwQWyzkERMXXVyDob7TRIXYxDcXHFePMnea77c3tR3cbODPoNzKlF+X4PuE1E2KfGdSK/6LO2GFjjh2C9YutZFRonV7/wdu/RGYG3hdc2Arj2LDVQkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TT57mFJH; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TT57mFJH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baADZyXs+URfta11ygXU9Jke+pfglxNmV2CpfkYWNK9dGl1aeURxxe241ffNeNG5jsExK5FztiEpqkxbwuUu09xDtmCINRZUQUskfoBQsULggpnKoDmpT5BgDqlVenBIobrJaJDCtXp9UdeaL7F3wyGoy6TOJMXWjKo5INJ/R1DM8J4y+SAmNKQscqJrBIAfBjuCE1JXidHcbgnJ/B8C8eCddIu3s8ApscxSbnSSjd9gfvuOB8BHiwW4fToYknQmgYgnz/ILlyRHqRYJzSuec/I1Tgdxp1zkXL8sgI2SV7HMOCeybyHReeTeYAV5Ck7F2h+oKIqY8sH78W369gvH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gqSN9GYR0breL9W9U36X2KDuDcnd26vaEAhpEYiA2o=;
 b=Lpjc80hJjBMnEfbLl2u0fEWebFFgpTOEf9rVcig1WsOxL2tpMpSRCctDUqXoFFotxjk61giFXAvXzMe3US91JpJ4pJ5801H9ALEpPBxBVHrlT8alAV3Qokwv0yQ9IITVFeSs40banLFgXxnmjm+WqGaDLMSOfXWsCa9pj9yrAHnNsvBKLVV5P3WKvtlWgS8Qch2bp5SJxpNWZCZ856tSPYXpUTco5sLBg2ks5lXHNGzl+FYEwPwCaH+UsbqAoxY4rpXzbn70YAU3pPQ1U30dulWABzaKvwwV7Grrz0zW9wWw8NGRPOilEmk3/wzlnjI3RQfwtWDAegoi3gxxQTe4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gqSN9GYR0breL9W9U36X2KDuDcnd26vaEAhpEYiA2o=;
 b=TT57mFJHID8wIRUeiJHtl07HhApdbb3xG8J2OzuS+lYdpY2kds2qWHGHP1fp8thB/c1ePxh0OMFU1npwRrFkIJ/i7uEhDz61LPhqyQw8fPLRQHpr/bhytov0v2T5VBUpUCQiGrtwINLVyBQ8gOrynhQ1amrK8UcCaBQtTXjt0N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by PH7PR12MB6586.namprd12.prod.outlook.com
 (2603:10b6:510:212::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:21:10 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:21:10 +0000
Message-ID: <80df7fbc-8c9b-4d2a-a9c3-b5ce5cd0363a@amd.com>
Date: Thu, 3 Sep 2026 12:21:01 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Saravana Kannan <saravanak@google.com>,
 Will Deacon <will@kernel.org>, "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
 rick.p.edgecombe@intel.com, yilun.xu@intel.com, Jiri Pirko
 <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260902150125.GD2890729@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0056.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::7) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ce4357-da05-42ae-e14e-08df096204e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4zZDhGHrpAisp/HGCpSDNC3t/cqpeND2xu6PdwrQ6LXULwWyGRShiyMZu3GIziNyoHdMC+SxH9WIL782cTwY7Mbd6hpVGf8mxXwOmqoWWNc4DPJCyJOHEhFIPxemtuijGPBaygjiyko5kxp8PCgivGIYhcPM5KMnkR8bKgVWh7qCY+c3wDU8TrTxgFocNiBoKcxL1m+wQGzorJlqmtP8FpxHIA6vLv3FOVZFMhVoXwx3t3pR+ZMqsjKMtaMRIGbL66KfgvY5rLy/Z1wOKmPSKg26OHtyRm0JQoQW6KCyxEFlXxBJFh3J2dvRcIYnRrb19nCzOM0mcaUpM/GZKBRbbgFxT7CyslbhvyF0ngNCBN1c98bMJUKYPURzOcOSC+qbUkPpp933BriI35IL8YJT563KbqqBguDILvMOS8wzujt3cwb6rQISpGfIvkUnEZThUGq7Sh1u7QQA15J3UkXHYXLgEXUB6fmzCMS+fvsDvx7rU9O8j2lh4D4aqaPSQACeeDbM8B2kmOxfRs4RmC2eD/z1AIBwGg+nGZ0bZAu8Ukw6gaj8JSYhE00UcxDsurVks2oQ9R3T0m+lT7vZPrInJQcRkZtAZqMUADrfH/FxUSdeLkwo99a0uDslTg9fGw+C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzF2QnU4Q3ZOYlJ3YnJKUk5GbThJV0RUUjI0Z1JUb0FCREkzcENvTmtxWFNF?=
 =?utf-8?B?d2t1Kzk1Q1BqWHE2MGh6aEw2dFBsMzVscHI1Yys2Wm50bzMrV1VYV0tTYmU1?=
 =?utf-8?B?WUQxZGdSZXU5Q2xEZkNENFJXVmpkRVpCa2VZMEFLQkR3L2N0d2YzTk9nYUVG?=
 =?utf-8?B?eGhqR0lQdTQ0dExwcmViL25ienhXWDRGSnVqQU1oUkFtSWs2TERIOER3aElx?=
 =?utf-8?B?Sjgzc0hDd21CcmhpNjhSaHlISVU1TWVvR1V1ZmlySzFNRXF2RktCS01tSXpm?=
 =?utf-8?B?UktxNks3SXRTNmtTbUt1c01Mem5JN3RoOUdEbHJJRHNtb0FId2VUMkx0Mk1L?=
 =?utf-8?B?YUIyZDhTbGRzQTh4YXVOT0pjM0NreXEzcStKV2h4STR0VGtNazBEcnFWaXZG?=
 =?utf-8?B?NjZvK2VUWk9GYnl2RlcydG42VS8rUEl0NGxNQkl6ZE9jRjVHR3ZZdWZsZksw?=
 =?utf-8?B?Vno0WlRzbTE2Zk10OHQzem43Qng4VVVaekZJRnpIQml2b2pKYy9uV2lWZ01E?=
 =?utf-8?B?S3dxb1hDamJLUm0xSmlweko1emRwbUhENHZ0MXdyNy9tT2dqZTFZTnVNTEtr?=
 =?utf-8?B?Q25IcU5KVDRhTGRMMFVRVnplZ3BMVU1MVFNkdVltdkpycE44K2ZtNWx2aWlj?=
 =?utf-8?B?N2VSWkZZSTFHbzhzdEE0K1NhbVRIY2FER0FXc1ZzeHBwek0zSkw1UUdSNjJD?=
 =?utf-8?B?UjlxdnA5azdIejJiVnllV2pJbzlXNE9xSURXU3B4cjNJMDk0c01JK0VTZEFR?=
 =?utf-8?B?bGxCY2dpNnd1bGE2MXkzRGs2YlFMMDNVWmdLNTRpaUl3QmtmQ1RMTC95RVlq?=
 =?utf-8?B?WkhyRUFhOHo2Q0ZNU0o2OEdUUkk3WGNYbHQ5V3lNemZlUFRFRjNJblY1VlM4?=
 =?utf-8?B?ZWYzZkJYYkwzaElWNjRGdFlJSlBPQktFaGt4bFgrYjE1NmtlaGZNNmJUamtF?=
 =?utf-8?B?Mm4vb2pPbUtFTjREUnQvV3ZXQStHOXNUK3RFZU1lVU9JMVpvUldTbjJQUUpk?=
 =?utf-8?B?Wnk4YVA5Rjd1bEltQnNnS3NYVUpGTW5WdDI4S0h6M2pnVXp6ejJIU3EyTDAr?=
 =?utf-8?B?K216MUlNZ1VnVk9SV1NyV2lweWJaZUJ0RURHYU9rZi9EZFU4eE1qaHdiZk15?=
 =?utf-8?B?cjBrK1RHWWV3c055TzdSaXhWWCt3SXlXV0o3WjFYVVo2QjBOYms1TWNxUk05?=
 =?utf-8?B?WWJvNy9WMmVwUkZHWE9ha2ZBa0ZvdHdPQjdOMEFiaFVUVy9SUzJmWjdUZTJ6?=
 =?utf-8?B?K2xsYjVILzNDOWtsbGsyRjhqQlpPZ2J3T01xd3hhOEdqenYzazk4M0dIb2w5?=
 =?utf-8?B?cmFkbk5vYVNGUEZkVTJMMCtaeENXY1p3WHNWaytyWmpLcWYvVUFYOVVWVFM0?=
 =?utf-8?B?bURhVVFRUmxEaDJMN2VSOU9yL0NZZUxxZ3JDQkFnTWxGellPVFVXditRN1lR?=
 =?utf-8?B?d3ZzdGMzckpGa1hxWitrdU9PanN3UmtZNTY0dGFtbVdab1owYXJWRWNCSXdI?=
 =?utf-8?B?b0pTd0o3OWRZdXllbWNIRWVBamRGTXdjOWtyRlJPQlZ2ZHl5QUJuNytFLzJv?=
 =?utf-8?B?M0dYM3MvT1A0YjdlRlQxVEgrckkrK1AzQWJpeURuQU9ST0tpNFVqMzlHV1Zt?=
 =?utf-8?B?RUE1dklCZnBSYUxrQTVWb0NjV2FJaTR1ZlVwUWY1QURvOU1MazJIcHJTQThM?=
 =?utf-8?B?MTNwTW1ReHdDSENGTnFoVGVJNjdNRE14OHlNU3B2dHNadE4xKzVXbSsrMzRS?=
 =?utf-8?B?cjFiTSs0VWpCVkZZODQwWHp1d2pHTkUzcGZQWHZtMjRIUjJRRkMzNnFlRkc4?=
 =?utf-8?B?RlQvRGR4MTdEU0x3YnQ5SVpUYTJROXU4em9IWXJCU3pjY2ZSMlY0STFCYXRC?=
 =?utf-8?B?c0JuZld3cVFNVW0xdkcxb2FRbU41clp2TmQ0SFhla2Y3bTVDT0VhTTNyZDA4?=
 =?utf-8?B?dndRWHRocCs2SnN3QzljUTJtL1ArZE4vTk8xdHB5b0wwV3pNTG1Xdi9YS29J?=
 =?utf-8?B?QjBuYnpuOXVURCtKeE5ISDdKWXQxVS94VGxGY3BkS1RrZDRwcG4zQ0JUaFlq?=
 =?utf-8?B?V1hlZnlsbk02YVgxWmUzMGtaTFVMa2VTTVo5bysvcEROTmIxNUQyT2NzQkE5?=
 =?utf-8?B?NDBSM0VBUUxiRVJTOWlJcVRWSEtvQlNsSTBkSzA3U0h5NmVTK3UzYW9saStX?=
 =?utf-8?B?c0daR0libUdJUFo1RDRWMmpIbHBJSDVSem8zcmRmQVpPUm9qN3JtMmVUVDVR?=
 =?utf-8?B?NmJxeEdxTG9HWDFMUGlrR2M3K2o4Wmk5RkZpSmhwY1NaUHRyZFBDVDZDQm9i?=
 =?utf-8?B?bEgxejNHa3ZSaW5BcE9tTm8vSlFKMlhEcE9Fc2hiR05iMGJmcExMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ce4357-da05-42ae-e14e-08df096204e0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:21:10.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrrQ0tT/b5gxXYNAF5ATwchu/bp0zZrGrj6jzK1vOGMPOATarwYE/FshFQpAnPzdYQ0hk9W6aZ9cJ2l9pCDbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586



On 3/9/26 01:01, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
>> On 2/9/26 12:12, Xu Yilun wrote:
>>> On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
>>>> On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
>>>>
>>>>> Glad to see you all here to make progress! Intel can also help on this.
>>>>> Can we have a meeting to discuss on these topics? As Alexey mentioned,
>>>>> previously we had a bi-weekly call, perhaps use that for our first
>>>>> meeting? Or what time works best for everyone?
>>>>
>>>> I prefer we defer such community discussions till September, that
>>>> seems appropriate given some dates I've seen.
>>>
>>> Hi Ankit & Jason,
>>>
>>> Do we have a plan to schedule a meeting to discuss next steps?
>>>
>>> If so, we can figure out a specific time on the Discord channel.
>>> https://discord.gg/KKqC438c
> 
>> So I've been trying to find a time slot. Say, keep it on Thursdays
>> (USA) (kinda short notice), bi-weekly, we can do:
> 
> I've asked several people in Europe to help on parts of this series,
> and combined with China/Aus someone is going to end up left out.
> 
> I know people are anxious about their projects. In the short term I
> will volunteer to send patches (ie bug fixes!) to Linus in the CC area
> Dan was responsible for. Please email me if something needs some
> attention and we can figure it out.
> 
> To fully move forward we need to establish a new TSM maintainer
> team. In my past experience a consensus has emerged off list, I
> suggest we try that here as well. Several people should be
> recruited. I will also volunteer to help train and launch a new team.

I would learn a thing or two.

> I can say that several people from NVIDIA are working on the ideas in
> this patch series. Ankit is setting up a team to focus on upstream
> patches for all of CC inside NVIDIA. I've asked Jiri Pirko to work on
> the PCI evidence uAPI based on his deep netlink experience, and Leon
> Romanovsky to work on the binding problem/adversarial/trust level
> driver core idea. They will share their approaches for solving these
> problems as seperate proposals.
Sounds good!

>> Scenario A:
>> Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
>> Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
>> Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
>> India (IST, UTC+5:30)		19:30 – 20:30	Day 1
>> China (CST, UTC+8)		22:00 – 23:00	Day 1
>> Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)
> 
> This is the only time Europe could reasonably participate in,
> obviously it is not OK for China and Aus.

What range would be reasonable? I prefer midnight to 6am, for example. At least for now, Yilun (China) and myself (Australia) are ok with these times.

Let's use a tool: https://crab.fit/iommufd-tsm-call-593432
Please vote.

And later on, Australia goes into DST, the nothern hemisphere - off DST (but not the same weekend, of course), and we'll start this all over again, may be.

We'll still have the tomorrow call at the old time. Thanks,

>> Please, comment. I find these calls pretty productive syncups. So
>> far we were not having Europe in these calls.
> 
> Calls are undoutably useful!
> 
>> Alternatively, wait until the LPC in a month but I suspect not
>> everybody is going to be there.
>   
> LPC is not that far away, I think we should have a goal of having a
> consensus for or at LPC
> 
> Regards,
> Jason


-- 
Alexey

