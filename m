Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA001E5B63;
	Sun, 21 Jun 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782069891; cv=fail; b=BO5OaCkhFzwIOH2bFCWzBZWojR8Z/IZ6HgVmUjc37uCMpYV5JR82wUYpY1Nw/iq364AVGseLBfLoa8K7qAESZEiKr8jOj+Q+eLYfD5zPZm4ZX0uOYDiZBgNQt3z5V3ksK9S6BJZTaq92MtwRN7vHZXek17ar2qpoOx1M60QXvOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782069891; c=relaxed/simple;
	bh=EJnJB4TNexEs66rIDKQIdjxhkrMy/ZQjAHO/SqorZ8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FARfmiJn73lS84I6nYQMvIRQHCMQk9NJGFg54ZKvkhXQWsdzIxs6eQU/PEvyOnCes3vj5VRmEaGsNmRR2m1aQITjs846Po8JoNTO4nk/mWsmJADC8/sFpcNtl/V//4IZAuLTFRJyhwwGXNs37JBByKO6pip86RphOYVFQ2hIOWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jEVaF73r; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jEVaF73r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkv9UDcHp3fh/k6pUSbpuTPMZDlm+1/AD3vjvcCBwHCaGakknqssV6UrD4O9CZKu3JDuxH/TXZ+FkoNlbVrTno24RYn832Q7wdAYrx+YDR4rIu0g7HPxW93zsF3soW8GX7jap12DDt2nQI3l+uWy0baAFYxEFYOjU3V8I+HbbKjaKq4FjsVLk3g1xjDH8ywOnpnDstjLNWcSxUaO2oXJR/srb1/aRkOHavMOdwI78zAuoOsuR+j6Um0Gb18VUIAjTD/skvh/1ODtU/sY/FJTPt7LJxQ3BMFH4huzU0SDWLaI42Rin+iza/jEyTnS6YcBabJJcJQauDJQ+P36YmsY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD9HUo7Ky0rdYDmYW35G6Gh64vhqna4KrRMkmO6Hlfk=;
 b=gzl1KC6lb3ZlXg0xNVb1aYJiQQPYMoS/+gjTq9pfQ3otD1pOl2tSCBzt9LJvvFBceZAldKr1zWQ5XUsDu3nH3Ot7px+WFlKRpVt1TKX1UxPTq4FMXxf97yhhAHxvneuy2Uisc2Ies4ABxBZ7UhJUGIZPwHTGxcBlN6Flq55XNUs86v2wfu96m1Uxhka73rWB0IehXV+gVeQLcRG5MT9sDa+A9J2SAT6UMNG5kbSzUsYngMl0KWz9jHngrqxuYE0lBK7rnAKgWkNAI0xh+q5aQOLc3f9OlmA12bYjjT7mRblfIVO5YOLDKrXxRyUsWfafNUvNck/Obth9WJF4uNoO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD9HUo7Ky0rdYDmYW35G6Gh64vhqna4KrRMkmO6Hlfk=;
 b=jEVaF73rpBx+4VJFtIvRpCCYgbmXvI1I91yNE9Anl5DCfk4UFHVPfSqHFh2NalSja+J/7Fww5nZlnzobwm7PAK7wJ7sis5kowvCoD8oqQq7vhaaFd+kSzVR1+m+EeQ34qGukoDFKobjvryeteHj3f9oqIt4QJhD4Qz4PNZ2l3OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 19:24:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 19:24:44 +0000
Message-ID: <1ad46724-18a6-4cc1-9c40-f34fbf0f0b7c@amd.com>
Date: Sun, 21 Jun 2026 12:24:42 -0700
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_6=2E16=5D_r8169_RTL8168h/8111h_fails_?=
 =?UTF-8?Q?to_probe_=E2=80=94_=22Unable_to_change_power_state_from_D3cold_to?=
 =?UTF-8?Q?_D0=22_=E2=80=94_bisected_to_4d4c10f763d7?=
Content-Language: en-US
To: Thorsten Leemhuis <regressions@leemhuis.info>, Josh Perry
 <josh@6bit.com>, bhelgaas@google.com
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 regressions@lists.linux.dev
References: <d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com>
 <e8acc151-19f3-4823-83a1-e0906dd9f0f0@leemhuis.info>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e8acc151-19f3-4823-83a1-e0906dd9f0f0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: e6213ddb-de95-4084-2a7b-08decfcabf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	0UtYse08/d08dyoH0uvIugx4l9QLYMtPQuD74Map1dEyLO1RBziFC2Yxw6jfSRrYSowgCCAx04vfUn5I1Rcpfy8hmXwZ01H1xl+bxIxPrtqcxLUYq3TtU2fDLIpCBnVG9pI+2mPRJec74OZU4XxcjO95ixqcytovKLu0pEDUiKxiqqUAd7RrEvy2sGOV9jTLvnDXQcMyg19+8hZAJ9A9MEsKRZLg0ptdmJjyATku84QtMktWiMR8YV/mEhvDAwjGnnDgZoOoTp7JauBcP7V/02N8zplDP9Y/CuvA17jQwNx2CS3racUj4nrnRGTZgXmt/ScIcq2IZNrRe/P3gW02ba7oO60I1E7vCVZlee3JxFhHjN1b7+Fnml4+G4Mna0eZ/G3HzoFGpN29DevOL4H6P9XVqHi9HR1Uk+8zmatQ+T5vXppHocbq4gYhhAZokUopDQuCR5AYJg/7O9zMkVJoqDy7vvRXMoiej6HBWbNFWbL4g1Q+48rXYVZcgN2aKu7N5o6ScsTb5jVayJOwBJtiYQ77x1+QASMs2a1BNxAnV67nWzyCTihMff/rxEDaHJ6TtX1mNoDPqJcFz7SbE/DSu9uFW1gEA9JMsKkTgAv17aGF+HnoyVsOB8KQhzVeMnEjd25PtUSLgcYksaAGtg/xE6+Sg8FwPl0v89FACxMwK4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhyTVd3WWdWaG5NdlQ0MTR4UWM1dDhnd2JvdEgrMTBVYUs1cU11ZS9iQUQx?=
 =?utf-8?B?Vk5iK3cxd215RUxHZm9mdU5TTVNjNmhVUEt0NS9BVEx1WGJ6aDM3dVhLUTlk?=
 =?utf-8?B?a3hxNE43dHdhVHBqdEhZdG4xWEM2eTFpaEtFaU83WTdscE5lY01DUWFtSSto?=
 =?utf-8?B?djhsNXQ3STJFZXNhT0RKTHJLNzIrb1JXeXJQajgvbEpjeDcwdk9aTWdIbWVt?=
 =?utf-8?B?Wk1IWTJGekVoNFlXZmhBOUg2MVJzQXRJdGo3MkFFK2E5WS9CR0tFRHBCUXVn?=
 =?utf-8?B?QkEvVVdXUFIzdGlobXNtWThsWUIzTmpqMUNqSDBUQnI0Rmp3U1lkbmN6SU9t?=
 =?utf-8?B?NEpyUm5iakovblNpWGM3bVFXV1JVWXo1citXV0JIY0dPL0p1dU5ONWoyUWg5?=
 =?utf-8?B?QkcrUzdpOWVGeFhuNXp5YzJWdURYSEU2NG8wR3RrQWtEdVlTV2JVSWpYQWtK?=
 =?utf-8?B?OVQ1OGJHR2xBVENQRlM2eFBIa0NIS2xWTElGdGlLeTZZVy9PMlhIS0drTmRy?=
 =?utf-8?B?R2ord2RDemRRdHdwZ3dZTlEyay9ZbzZuK1ZaY0QwUHhyTHhXZkJMTXB4RU94?=
 =?utf-8?B?bkJqbFJUMGV3RHNxcDRjdzdleTN6MWZuU2tuOVNEdjhXcWFLVVlLcXZMTVhT?=
 =?utf-8?B?OHhITVZEK1NWU0djRFUwRG5lbUljenl6ZjBxNEt0N0RiZzJTY2kyTlRXRkor?=
 =?utf-8?B?eE84aWVWM0V4VGdzWndsWHRqa2VRME1YTUpqWEZhd3BSQnFwSDZMNnA3aG1s?=
 =?utf-8?B?UlFMMy9jdVV2cmkrdlVjRk5mNXp4dnRIYWQzb3hhU2w4Y0I4bmZtbEl2TjBB?=
 =?utf-8?B?MDN3anlMRm8rRFFSdzlORllTM2EwSDNrTzNQc29oK2tWR3loTW9EUWdReEJJ?=
 =?utf-8?B?VENScmJ5aXJxbUdCZDVYenRHUXNWUFlTQmlSNDAxQkdBR2Y5RnZvbHFlL2k0?=
 =?utf-8?B?UXIrdzNIcitQRHFJR1FLQldaTjQyczVHbDFDditZQW8ra0pFdGdmMnhvMGZZ?=
 =?utf-8?B?blliVGI4RjlCSmRNUzkzWkFKN251RWVyc3B0N0l1dGVFWkQxc2xqYm05RUZj?=
 =?utf-8?B?dStwTUUvQXZTOUpRcFl4a2ZYQmtNeE5kMHJadExXbVNZYlMrc0pEUzBLZmE1?=
 =?utf-8?B?UFdsSW9NOUw4WUR6Ymw3a3RUQXVtbXhxZHJodTBSOEN1cHVCcVJXWHZ5OFV1?=
 =?utf-8?B?YUlKUHRjZFJoUXdjbnA3RWJPa3NmUlZaK1E1MytmbGc4MjJoNWo3RFIxSEFU?=
 =?utf-8?B?WGRKekV4UlgrUm1idnd5NytUTWh2K3l5ZUpSZXgwVzUvV3h3SytWVHRxMVVR?=
 =?utf-8?B?Q3FvbS8rdGdXbnViYkhsMFRoaUNVT2ZaczRKL1Mwc241MFJ5eGdWdGdRd1Jw?=
 =?utf-8?B?Y21PRzVFVXNlMlRXc1MrS1RUNkllNlhoNm9GRXMvcm9xQS9LVVdxR25ickFF?=
 =?utf-8?B?RDg2UGNKQWR5aG1lV2xYTWNhUjRPbFlVV0VjVThhdCtvVXlmWWpnWVJUYXh3?=
 =?utf-8?B?bkFVaFcxUStoc1FyMmlpbXd2Z1JiY3g5c2xJM09yL0ZuVit2Vjdnbng0WG5P?=
 =?utf-8?B?dE9OQ2NSalY0elRkZStIcHVGR2xNUXgrc3pLUStwZGR6ZXNTaGl6eHBSTWRZ?=
 =?utf-8?B?WDdwNzI2REV2a0RtakRtSGdOc1F4Qi81VzJ0dnoyRFNTV01EZ3M0T1VzNFN6?=
 =?utf-8?B?VU1CRDVzc0sxSmlTV24rSjdGNkpzMEVaUm43NDNOQWRmTWtZRVhHN2NXMGFM?=
 =?utf-8?B?dllhTUJ3R3ZrYjlkRU14amVsYlQwcHNwQjhpMGJqYkN5dGZFc1ZFWUJJT0tn?=
 =?utf-8?B?WWR3TGdEcmpOWFFhRFZ3aHhBVXRwNDhhc0dnQWJyK2VzYURET1Axb3kreng1?=
 =?utf-8?B?U2YyUGQ1MUY3M2hxSG9tWkk4N3VTME1oNzAvd0ZXclczWmlDOE9RWDQxblBk?=
 =?utf-8?B?a3F1a1JDUkhBL2h5L0RKalFKam1IVzg5ZDdVR0V6V1A5MFE2OEpsSUM1YjZ0?=
 =?utf-8?B?Q3Q3Yk1hZ1d2cDZnbDFXOXJaVytZcFRGS0crNTcvOUoxMG5UQ2lBL0wvTlFl?=
 =?utf-8?B?SEJFei8vcXYvZ0JFME5Ja2VEZVUzK2ljajZDTlUzc1A5SVRLL1BMWjdrQXZ3?=
 =?utf-8?B?T05oanpSRmlmWHc5aTQ2TENIVWdrWGFSek44clBSdUkwbW9FdW5lQkcwcFNP?=
 =?utf-8?B?R0FFcHpJRDFFdm1veGI0VWVwWHFxZ3RGb20xL3c3RForR3B2alQ0a0lyOFFK?=
 =?utf-8?B?ZWJnOXV2MlZXUHFURktYbzRoWlJ1SEZ5djdCdVhMSzNvY2loNWtUNDQ0OEZR?=
 =?utf-8?B?enlKT2MwUExSR0NSR3kySUM0RUlkSG5KTUxINmw4cURUbThSQXNXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6213ddb-de95-4084-2a7b-08decfcabf9a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 19:24:43.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxCgCH9w3NdrYOZkjjfgOAikP7iAfA47TYAn0QUsHb1rocKv8qzwBx30bbJONJ59Xv0JytgILefqGGA+b+yvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851



On 6/17/26 01:32, Thorsten Leemhuis wrote:
> On 6/12/26 03:07, Josh Perry wrote:
>> #regzbot introduced: 4d4c10f763d7
>>
>> Since v6.16 one of two onboard RTL8168h/8111h NICs on this board fails
>> to probe on boot; the device drops to D3cold and the driver can't bring
>> it back:
> 
> FWIW, that commit is 4d4c10f763d780 ("PCI: Explicitly put devices into
> D0 when initializing") [v6.16-rc1] from Mario, who is already CCed, but
> looks like might be on holiday or something due to inactivity on the
> lists in the recent days. So it might take a few days before this moves on.
> 
> Josh, this is not my area of expertise, but there are two things I guess
> might be helpful:
> 
> * retry with 7.1
> * upload "dmesg" and "sudo lspci -vvv" output from working and broken
> kernels somewhere (like bugzilla.kernel.org).

Yes; please retry with mainline.  We already had multiple regressions 
from that commit fixed, so if you bisected down to this commit then it's 
plausible that there is already a fix.

> 
> Ciao, Thorsten
> 
>>    r8169 0000:02:00.0 eth0: RTL8168h/8111h, 00:2b:67:48:40:01, XID 541,
>> IRQ 137
>>    r8169 0000:04:00.0: Unable to change power state from D3cold to D0,
>> device inaccessible
>>    r8169 0000:04:00.0: Mem-Wr-Inval unavailable
>>    r8169 0000:04:00.0: error -EIO: PCI read failed
>>    r8169 0000:04:00.0: probe with driver r8169 failed with error -5
>>
>> The board has two identical RTL8168h NICs (both XID 541): 0000:02:00.0
>> and 0000:04:00.0. Only 04:00.0 fails — its sibling 02:00.0, on a
>> different root port, probes and works normally on the very same kernel
>> and boot. The failing NIC then does not appear (no enp4s0), taking the
>> machine's WAN offline. This strongly suggests the problem is port/
>> topology-specific rather than device- or driver-specific: the upstream
>> port behind 04:00.0 is placed in D3cold and the endpoint cannot be
>> resumed to D0.
>>
>> Hardware: RTL8168h/8111h, XID 541, PCI 04:00.0 (onboard 1GbE).
>> Platform: Lenovo ThinkCentre M90n-1 (11AHS0B200), BIOS M2AKT49A
>> (2026-03-25, latest available). Firmware is current, so this is not a
>> platform-firmware issue.
>>
>> Bisection: v6.15 good, v6.16 bad (verified by booting both). I then
>> reverted 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
>> initializing") together with its follow-up 907a7a2e5bf4 ("PCI/PM: Set up
>> runtime PM even for devices without PCI PM") on top of 6.16.7: the NIC
>> probes and links at 1Gbps/Full normally, with no workaround:
>>
>>    r8169 0000:04:00.0 eth1: RTL8168h/8111h, 00:2b:67:48:40:02, XID 541,
>> IRQ 138
>>    r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>
>> Workaround: booting an unmodified v6.16+ kernel with pcie_port_pm=off
>> also restores the NIC, which is consistent with the upstream port being
>> placed in D3cold and the device failing to resume to D0 after the
>> explicit-D0 init change.
>>
>> The follow-up 907a7a2e5bf4 does not fix this resume case: v6.18.33 is
>> still affected (retested today on current firmware).
>>
>> Happy to test patches or provide full dmesg / lspci.
>>
> 

