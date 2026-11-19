Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124497;
	b=pxgV1GEVVOEu3ok1MJoYEy/p4xyLLOGJEcbf8t4slW93UCNHlYKn7VKNpyeii2fzcZQA
	 fAui6RFIU7qQKtCDkvQanjj+KVqyo6mBSRsC1MgVfpaNG0VRIcdt/JzQYAO/mQ9CRaG7n
	 9E3xNTsQTX376Pg+UhUUyL3GArtLaUOs9bPwNRni+COVEZLNHXBg27rf9iOa2XW/Y2XXU
	 D03lIj7chNsy4HzIeR/4TSNBltcCG5gGGEAs73rDOGpB2A+ii9U4rgucBkk/hChVhu0gR
	 hyGht/cBTEyOmG5HiqOWmmXZPBmmEJuTayDuV2jK1/JmRcJpTI56Gm0bksOlZzvcwYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124497;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=S/3w8YIzN+lp/yymMQ7EuJ/HZM7SFlw2iF6HrlOtdWk=;
	b=TENqK2dFWu0LTsYaZh+kaLYCQgDoP0B8/tTXM5qTqWqAyQBAeOWamxpadS6x5J1KjlTX
	 u2jVY/21dOUlebrjAE1rmykYftTEhwFwgUiDQkm5DuY65OBEpP186dUeF8iqgXkZPWcpL
	 VwyOhvaZEaLGT8wZKYMwjB7+Sf6gbpCW/RE0PbiwXCvvNoujOaO7narZT6Bx+Kq1fIkul
	 vItJRh82mrvrEoBL36aaCISD0qMEfol7BHqa8KDeXy42aaPgfrMqVi3g0hRN/23EMYKp0
	 twXrj93wvzWd5ExiiRMCtxt3VmSOA1rtkUCQYlwTTjjwEGH9MUUeseJieDHXwi5ZZGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3LEnm4rZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.4
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB9606A326
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 21:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAAB9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3LEnm4rZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovauSVP72PGpPMO1zpQOlRPe19FcRLHnm4gosd3chmq3K8uMv7LEAiLxXus8uFf5vZwrjvSdsBi6B9Mp3FkTPbkh/gNSSL0WuZPvo0qaOFrKMx4OxMxZ6BYnYA+A8K1xpzVQ1FKnEoH/Gg2YMXtHSRVUv+LusDAGa8T5uVQnHKNO3yzGkbj4AKbzKfToEbB8nPNQfwBIeUi/u8XwwhblSwh/ur1FJ/Li5iVT/fbeSQ3i4XLBPRVEAwzo5jEX3XNzabCanmDKJD6TmJecxUaY58nuYJLL2731khTXHflxORkW6lxxxGOOunaj3n/iLs+x7OUnQP2FMFoQ6CS52axRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/3w8YIzN+lp/yymMQ7EuJ/HZM7SFlw2iF6HrlOtdWk=;
 b=cI9HVfZCUYc1BJFM/SnWLGBXqn6NjqGgDWqBpcsJDEfmHRa4dH3lFn0Xh2suTlWkcIXEEjNO9PJgUS5p14HvMSUr10GJ46P6UkLu4AjQf08lQO0DYv5ai7RzpCHXKIDYeQpWrSYQntqASSTzHM5Xax0+XJAHSFwTga2QshJXme0Cglm47qSlNKIma51yyvKolRE05OCbBLwQ3zXtwCWw9296xPF5BeuEPxyOZzqRdjSDirCgKJ23B9ONHjhqJYlqFtDTVomBZmsiw4BGb4+hqZ//tOJ9eCOPAQP6EPOmRGTfGfN+QMvMYQdsoBvrpBq3fDybTSKZxDzVQMMBKX5r9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/3w8YIzN+lp/yymMQ7EuJ/HZM7SFlw2iF6HrlOtdWk=;
 b=3LEnm4rZSCE9C2Cdyu0DfF12kEEwfsIV5MeqqpWu9aUtUSLdELL56/oN2awzzX7GNPkP2ySCBec1BHhXx6qETVEA1IHuMDanuSudqJ2J1ReNZiMLNS/JxCV8Argl15fMWZaKNTqLjVMSZYPeO2h7zJcWUJiK8siOQtucc4DN8GA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by LV1PR12MB583771.namprd12.prod.outlook.com (2603:10b6:408:508::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 21:41:33 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 21:41:33 +0000
Message-ID: <55d93dcb-e9f2-4792-9375-72070d8aec7e@amd.com>
Date: Thu, 19 Nov 2026 15:41:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20261119195553.GA835692@bhelgaas>
 <73e3f0a7-59a7-47f7-9136-9d0b2660c4c7@amd.com>
 <CADnq5_MA9qEPSX_Bt-WToDh2x5R6VoTKxt9GAazsPcX3aBQXOw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MA9qEPSX_Bt-WToDh2x5R6VoTKxt9GAazsPcX3aBQXOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::29) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|LV1PR12MB583771:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b5e357-1dfd-4929-21cf-08df4685e082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	reOY9vJrRbNNh8oCneXEjgBVtb7Izs8FDPHrBtWjgH24XqvPXQhisRVkdAaqu2srYga317x3IZ+vvdc3jIh4QVDDt+J+eHkHqRw7cDd0tyI1gcmI/1PoBLHH5yGRs8jTTFVhicW5uH9TRntQa7ef3a1VY/S+ea0UOs/sIjNyIFe3RdgwItrFMVk1hdF3UwuJF8R1ZYJWJIK4ftlOUzo76S9/P1mR7xUzih4aRO/V9aBwfV5+clgKU1feX91EVWvYTqnXKwnTX+fmZM3Z9Vd01G4+UESByjC1+pG1m9XN+0iDp89g8et9Gt3UkEjqcrOh6cLFbI5QT8FAPgy2SVahMqPWJflQB3TpcC7T2OER74iu1xYN4facZO28/dsOQFajgjLNCiJMCeTIrIf3nr0WMCLtvXHzIUXYoc++bBsJFVGimE7BAAiZxA8HMVkypvlzwa0fzdyz/83NJvEXe3SX9TV2h5ORZ7f/xqoxwQs1nLFYXiQJn4+2TEFaUWVqu4BnwgWo1Bk/ao9LWh0qWA3kDhUomJ3FP/DqrGTEZvw/UCVyTm0exd//q6cFHiuMXI4vQWUzscD0KiKk0aoauUofkIPKf9b+CORxHw1bWlWiO1m0pVgWnUAwFeluQxQuB87NtRlQVAYORQ4mDgY1KNBNwlIGBkMRoQ8i5kqvmIVQ1dI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejN6NnZOMVZTUDFGbXZyeXlPelFHY1dBcTVXRjEvcGlTc0hZczRjTnZTTE9Y?=
 =?utf-8?B?UlgyN24vWmVUVmVvVzIzYmdMYmJlM2gzWXVOUmQ0SmxuM3M1TWRRTFp1dUFa?=
 =?utf-8?B?SkRHWExFTG90aE5QOU81Nm5LMDFJV2Z6SUt2TVZNTlZoNUFuYlNkTFd3eEhY?=
 =?utf-8?B?Y01Dbjg5WWdXY09wMm9xRVdrZWNodU42T3laWlAxTnRjdWpxMGdobVJWZWk0?=
 =?utf-8?B?dmx5aHdkM0plbU84UlpTWE9iNnhFcDhwN3JDZDVwU2prNnVScG9jWXZaT1ZH?=
 =?utf-8?B?RUg1V09adnd0ejB2bmtrUDFmbHV4UXBmd1NnQzJaNE5pWTlUd0lXbm9TTFM4?=
 =?utf-8?B?d3hKdkVrc1dodjRvcDdsOUpIamVwaVA3MWEwVHc3ODZ3Tnpuc25xUzY2emty?=
 =?utf-8?B?d0dCYk9YZzVsaHBlQzc5QWRJUTFTT2RRZytHUEhSNGdWeFBFVlBFWWdwZ25B?=
 =?utf-8?B?RmtRRjlFaGhLenhqKy93a0pSYUtPM3U5bHZMYzRmRmRad04yVnMvT0pybVdp?=
 =?utf-8?B?YmRYTklRVXh6WWMwYmdWVmwyMUxKVVRzaDIyMUg5M1VCWlJFbTZjQnVuMHg3?=
 =?utf-8?B?bFBmRlorZlBYNngyZThEbk9pZ1djUEFLKzhjK21zckNydTBYdzJpVktPaVpv?=
 =?utf-8?B?Vmt3Y0hERG5URmdVeHVCK1A0VEphMmNLTnRzRVNhQmVTazRKTEZjRXdrWmpi?=
 =?utf-8?B?MFg1OXdCenRib3l5TFIxNkcxODk1QW93Wm1tVm1Vc1VvMWhDeU5ER1JJNGYv?=
 =?utf-8?B?KzRFUFJ2ajhRTWNzbUxwVDNSNC9VdWhtYkZBYVFoRnd5dzdIZHhwRVFsbWdF?=
 =?utf-8?B?MTZ4VTVPd1hETFNSNmJuTGlpaWM4d0dBckFpbHFuVnBuWWRtU3ZKVDFYREFt?=
 =?utf-8?B?bzJINUQxQTlKbGtqc2kzWHZtT0lOeWN6em1pSmowZHgveHhieGxMNGpIdGR4?=
 =?utf-8?B?eDYvRm1lS2VleTdYbEhRT3hDWFlQZWFtU1RVRmRsZXpjYWhRZTNFK0FFRXkw?=
 =?utf-8?B?c0ljNGgvSk84T2dZMTJNMmpoUXpMb1BFWU50VGhmODdETWsyVU1oK1Jka2JZ?=
 =?utf-8?B?b1dPTmNoS0VwWWo4RWp5ZzBIYnA5YVJUTUYvQkU4SnV6WlRCNnRmdS9LVEcy?=
 =?utf-8?B?WE5kZXFsZ0x4cWpDOEZkUWR0czBKQWdicE5ERW04ZlpXSlBwdGNZeHNQWXUr?=
 =?utf-8?B?Y21kMW4zM0JiUVdFSlVRQXVsL2U2eW52elRGcS82SDY5VW5uVklXdlAza3BK?=
 =?utf-8?B?SUhSNklOSzJRY3l5SkNOd2hBcHBRbFlNOXpuam9kaFNGb1ZlWG5JVHl0SWNP?=
 =?utf-8?B?ckl5S0ZTUmQrUzR3YXVsbllOWGNXeWNoQ0hnMm5JYmJta3ptNE1EY1FMaHFz?=
 =?utf-8?B?TU5PWkdsbjBZNGdUcEZnS3NxRFc4Y1hZTndaS1lKRUpic2t6YngyUHMxVjNN?=
 =?utf-8?B?QWhsa3c5MlFKR1ZScEQvMHFQQWxKZWJVVitnVWtaYW44U3RyWWs5NG44QUlM?=
 =?utf-8?B?OUtrbzByTE5WeGVyNVFlaUtPak5vaUlTYzA5VHZOSHJodWVlaTVxUzIvQVdW?=
 =?utf-8?B?WnhTSVBrT3RuQU5wMlpPRUgrOEY1cEN6b0hXNG5UWDcrVGdpaFpwYWUzdHpU?=
 =?utf-8?B?Ly9wMFRhOFNkWU9ITHF2SUxBUHZOS2FNQlFjNjJkREpGdldSZVgrZW5rREhP?=
 =?utf-8?B?eDRjS3FMZ2dvRG01YlpxRFpzNFUxZHNPVCtCSE5PRHZIRWQxSW1VRVV4OWVt?=
 =?utf-8?B?UFExQ2hVWlhRM3BuTGhDWmdYUkhkYTBBZVV4dUZaSmxvTVVUdE1vU2VMMWpH?=
 =?utf-8?B?RkwzbXU2cU01dGtMcGRUSHQ0QkVKYjUzZUJrekcyTU1UdHV2d3E3UWE3azIx?=
 =?utf-8?B?b1BjbGtZWFUyVFNucWV4U01zaDBoKzR1S3piUHRPNm93a2VyU3Q1VmhBWFBV?=
 =?utf-8?B?YW90T1NIczh2UnBoK0g3THZYK0s5eUpTSTRkbDBTbk00T3pMM3c5Uk9XUVBH?=
 =?utf-8?B?bXZCS20xUXpUUTJVdDFsVjNGL1N5L0ZNTWI5aE1kWGh2QTNiWk5TTThieTFH?=
 =?utf-8?B?VldFWjFwcDNlSmdURDRpb3Yxa2l6QzI5WDM3Q3lxbGZyNmx0aDQybXZXT1A4?=
 =?utf-8?B?VW5ydzl6UFFBL1czTGRJNzlDakVZUE9makJucStOcmhldFFabG5zSGgvczhS?=
 =?utf-8?B?cmJjZ3VWSlpneHZoTk8ydWwyM1lhZ2ZyS3hIQUJxeWdYYUdCRy9DVnNyNU9B?=
 =?utf-8?B?Y3d1eTZkVHI0VzNBa3hDek1wajRzaWcvbGtuaS8vNnQzbEtaRndsbmlSMWVr?=
 =?utf-8?B?czhoSGFySStFM1dqaHVCeW9kRVpMZDk2TGU0elFqV0hxNGdOd0FuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b5e357-1dfd-4929-21cf-08df4685e082
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:41:32.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m8SqAfNs3q9V82Ydtxpys6cIL8NEv2V4BfD64EoEiuEdt8fiTteusNMo8fLAazMrSjd31NrU0CbhdZY0O25/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB583771



On 11/19/26 15:40, Alex Deucher wrote:
> On Thu, Nov 19, 2026 at 4:31 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 11/19/26 13:55, Bjorn Helgaas wrote:
>>> On Thu, Nov 19, 2026 at 01:21:19PM -0600, Mario Limonciello wrote:
>>>> Drivers such as amdgpu and radeon need the bus number firmware assigned
>>>> to a device to match it against firmware tables like VFCT. The PCI core
>>>> may renumber buses (e.g. with pci=realloc), after which the runtime
>>>> number no longer reflects what firmware programmed.
>>>>
>>>> Record the bridge's secondary bus number in its struct pci_dev when
>>>> pci_read_bridge_windows() reads the bus number register. This happens
>>>> once, when the bridge is first enumerated and before any renumbering,
>>>> so the value is what firmware left at FW/OS handoff. Devices behind the
>>>> bridge can then retrieve their firmware bus number via their upstream
>>>> bridge.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> I assume you'll merge via DRM?
>>
>> Thanks.
>>
>> Yeah, I'll merge this through drm-misc.
> 
> Might be better to take via the amdgpu tree since it affects radeon and amdgpu?

Sure, that would avoid future conflicts I guess too. I'll submit to 
amd-staging-drm-next then.

> 
> Alex
> 
>>
>>>
>>>> ---
>>>>    drivers/pci/probe.c | 1 +
>>>>    include/linux/pci.h | 2 ++
>>>>    2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>>>>       res.flags = IORESOURCE_BUS;
>>>>       res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
>>>>       res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
>>>> +    bridge->fw_sec_busnr = res.start;
>>>>       pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>>>>                bridge->transparent ? " (subtractive decode)" : "");
>>>>
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index aa3765a20a96c..4c1b1e557a607 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -363,6 +363,8 @@ struct pci_dev {
>>>>       struct pci_slot *slot;          /* Physical slot this device is in */
>>>>
>>>>       unsigned int    devfn;          /* Encoded device & function index */
>>>> +    /* Bridge secondary bus number at FW/OS handoff */
>>>> +    unsigned char   fw_sec_busnr;
>>>>       unsigned short  vendor;
>>>>       unsigned short  device;
>>>>       unsigned short  subsystem_vendor;
>>>>
>>>> --
>>>> 2.43.0
>>>>
>>

