Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8843D410A;
	Wed, 25 Feb 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031603; cv=fail; b=PePmGzqpJjKnejydQ6Gmqc7ZDD+w3UgoddbugwGrWQFvfFk4ZZJ7me6xeRggfE5zhZQ2rgUcxW9YdRFf6Qm90edXC8wVCEsTFiNYHtWX754pSjB7DTEXEjsBWu1LV/I4I+GQrzpX1b4P1DLTLAyhdd5/8hTICRXj8KyaG7nTsx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031603; c=relaxed/simple;
	bh=L5hWGKlDJH69R6CpfElE0LvSgOqyKTlxo08dGqEgopM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6iTBPYM1Vu0JA9oQG3EB5WIoWOsclzt1Tl/Lm49pMzmqP+Qo+JfX7vTKzrbQ3E5xq6Vg0RwYpRPOJE3voNqzRbKo9VTFHnHCnLEJIaiM7opPq+tQX2MplYl/rsoNyjVkbLaMxIVlz3vaEwkuyWrtyIKAw1z0cHkPfG6GQYR5y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBPeg7Qk; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBPeg7Qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQTNrm7gAm/AGlnwGVYm/EsQJPaB4/TULvH8ilPRITyxMBZgF2FPtO3PqQkd7dEo3PxVxrttczK16kffR5Mb4/x4gs9/h7BSa/73B1P9XouWEV9duLAoQ4YZw0yUsgtPlsb4zyttNHx7c1W2Ja0ydnkrKqQ35LL3aN8RIx1dk9/7v2NOjVZUWNNoVgRrJjwo0ZvVdCn4ZpJ4cBq4c/Ax3bj5soEtgSnJBO9JahY7W1oo7DmVUbDgsWT7sHlQUwmhbsj33epDAOMIAjg5oyo3cWMKUHPoIasH/1lyLwDsyKpkODEuW3t2D8TQLaejqbqVbC8Z2Vq8nbv5BZv4zoL3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2qswtsjOI6E+igEMyxe/jzYclhIqcNVAOCVn/JXIRw=;
 b=EnA94e1Ao8f+qFVc7q3Rre/DDzPmjU/k5vY3DzLAlrN3F6nyQIGAbwbMGLB7kxzRSSrLeVSuA/G9xGcpuDgUROD3UY8gb880Dzqhi1tsIw+CK1viGWC2MHn/V4ja8vJE+3LQ38udfmswJ7WRKHeEcbJsUEpsqQ1QSDBaTAGrrlI9J5s8o8BEhARKkX9A4UgJfx8ZrSKBzzLj0lNyJMEaiY0+I1msN7EKES5OZwl4dLb3K7wRhsLJcjArf52R64V9h5fQw+SgvQsBpzfDxCD11jnXVUYcwUelNwbS7PtzeG2AJk7tUzKtO/NI74y8Lnsz4/3QyDhhPmerUTXdy4WYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2qswtsjOI6E+igEMyxe/jzYclhIqcNVAOCVn/JXIRw=;
 b=mBPeg7Qkcpm1eVrMJ0XtKmhCuNFr+5SmUt5DltOl0kT2+DcNb3QKMrtsd41vAwVDuhKlu2enMnMjoL7p+6MMzDLXDYKTKsAzBT1vOObnthvtEyHpiqQOZRvX8f3zCz3YmrML6ryUugsHl9jUdwPOa8l+Yeq6CF+/xPgid5u5qIzlPpIie4DVAj6M29JB1sUKcYvrrTJ2OQHepFyFmJ7XmJeKPPYYC2+V4HBRlOQfmNTFQostXuEuW9BYOUYpnkzuCBvSHISufBoLRQkCID3Mz5ais3JSzJ0YFj72f6+WLhx6rXX6NHn7/RqPckrCR4IXH1yW2fWfxC8WqqWbrmpkwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 14:59:55 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:59:55 +0000
Message-ID: <a02222aa-64a2-43b9-86f3-a31b4668206c@nvidia.com>
Date: Wed, 25 Feb 2026 15:59:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
References: <20260203004810.GA14073@bhelgaas>
 <0cd079ce-b658-4058-9d75-0e79987611de@nvidia.com>
 <20260223173346.GD25740@p1gen4-pw042f0m>
 <13979db1-4513-4841-8595-b30e42eb1769@nvidia.com>
Content-Language: en-US
In-Reply-To: <13979db1-4513-4841-8595-b30e42eb1769@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 792455a3-b4f3-44a8-1b20-08de747e8952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	h3WiiJuejrHiQSQ6qDqj5doYRvknTTDHioSd04ITcA5rXM9RPXIy8rq+igsvZjFLf6PJjQRjMaKcNMtlMnhYmcKF9givZA+4MkLFZc53hS0wJ3zuMDYx3oSSZ+ZadQFGiecIc+Mo1XF+H2wIX8ebcGxdnzIbDK/lbu0GrPtewDG2eGGmqH+MtsW3C9+vn+WFELKoOefSdXRRIRKS5lcvEXucXI4Jn5YI9TR9e9iBfCSzfNT4Sffzh9H0OGQap+/B1qVfVu1yGPzQnA0+V2OxXo+T9ZmZbHcPJsOvHiHZdmzOWHNZhTUQSyWF44JmU2lfubkTTEE3ttNhwM3Tu3O+MLDzw7F/Wnz4Tf4jSg1fw5CKkf600f/ePHgsaR280D6uQCDJ96r4WoRr3kfMChm1kaRd/OsIIpqYlBgSVLfdXvwO6Fa8AYkf1itE+xWGiReqnl+r4EP8C5maw9hB8nK29aqDjQSqolYSmJKyYodFsbUtMUp4VxgqDoZvF8oYULl70y2E4hPsVQZ77YhdspdQoh2lB1b7SQcgtLJnfBSFnif/6syDnaxPdP7/Xw6o//smahqQMLZCBn5Pgpc29GZoQXYlO2O8KKwirayJBQvKLif4bVeFAlA7l98PPaT7Y3gXgxCC5QNoRXkIruf5M9WmtrkFkcXCFMZjRCwRC0gZKnKU+0vBUPZPIuQ7K2LAjTjBYVC8Ftez0LTIK5Uv88wXIGZPo3xhprbKNs87562ZWKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGNOM2IxK0lxcWZXZndTUk9kVHpWRkdYcjNEbVNzMUwyNHdHdmtYYUNCd3JL?=
 =?utf-8?B?TWthVDBvMkg4c090VmpaY01xVjNsUnFWTVJEMlUzQ2wxQmVsQUV3ZDdoUmRB?=
 =?utf-8?B?d21ybXdSd0VGSzhsSk5PUmx4cXkxQ2dNbnR6TTBFQ3ZuczNFMkg4Vnc2ZXZH?=
 =?utf-8?B?akwzTUtwQjA1VEhxWEFHdFJxcTZCcVVEOWdGTjI0dlBpUytCWHNUcXFXNHli?=
 =?utf-8?B?YXVsZU84OHNHWm1XU0U0aFFFWjMvdThsTlFGWkxEQm9NQUNORjFVRk53WWxE?=
 =?utf-8?B?L01MQWpsU0t6ZXIrY2FUSU1yM3VxRHNXTzI4OHJDSjQxTHRrYTZHQ2NGM0Q4?=
 =?utf-8?B?Z0lNM3ptb3djNUpnUVVLN3NqM0szRVhoZldqRnZtTEJUWENsd2NnZE1wbzdP?=
 =?utf-8?B?V1pVSGlkVHFkK3F3OEYxb2h2SXJ6R3dDS1BIMjFEYkNPRkVvVEdBTk5wcmF3?=
 =?utf-8?B?bVhpTXdEYzZWVy9wemNHODB2dCtYMWQyWnlGSDgzblUrSjVQVjM4RGZTYTc2?=
 =?utf-8?B?UGhERUJ4dDBuQzE0VlpVYzdrWGM5WnFESFZFOFZiMktmbnQycFZpZzNUci9M?=
 =?utf-8?B?OUJGQkxqd3Vid2UvZ3JkTjV1akFna205RnVld2FXb2M3TmVaa25nVlYxRFY3?=
 =?utf-8?B?blJnN1hHNUxydjh1UGR0eUtCQ0p6d3FHZWZ0aFc0MWhTRFd0Q2ViTUUxTm1p?=
 =?utf-8?B?THcvOXowMkFubjRsL1B2TFBDckFhVGhaNUV3Q1ZwSm4xS3NsOEd0MER4dHBB?=
 =?utf-8?B?WHV6YWVmcnR3SHNtZ2RkNWp6bk5oTjBCL1JkOWcrMFV2anhiUlh0S0Zid1hI?=
 =?utf-8?B?bUN6d3pJSVkvMFVvYUI4aGtUTXVQdklMNWJXcFRIWS9XYjlocmJvVVpMQ2to?=
 =?utf-8?B?RDdEbFFFaTlnTkRhdTFyVDR4SVJ4Ny9lSkZqMzFicUlYc2hSMHpSY1ZDWXNN?=
 =?utf-8?B?a2lvL1had05lclJsQlZzSTBOZWIzczRVYW0rbTZYT3NkbjZvK3NFUjAra1dQ?=
 =?utf-8?B?QVA3Wks2UGVPTW1GdXNZRGFLK3JZWlRRaFZZSjI2eXZYRTFDRnhkRWoyRmUr?=
 =?utf-8?B?VURMUjVEcExZNVAxT1RKOUZKZnJ3Ym0vRFYrdXZNSlZjYmI4K0MrUkZnRWxL?=
 =?utf-8?B?Z2ZlUVVkNW1DaE5hemNRN1dEL0NVS0lGOHBxcWZCSzdiT2xHRzdvdG5DcE9L?=
 =?utf-8?B?SzNUejFBRUVwbjJNelE2OWR0UXZ4S201SWxUMjc5RUI3T0N3emEyQVUxRUdJ?=
 =?utf-8?B?VzRueEhtRVNFSjFyNURCQlE5bXEySHdJL01nMHBhS2JDR1lJaTdCMUM1TE02?=
 =?utf-8?B?Z1lhYndub0lDcXR6OFo5bVIybWZNdEI3UkpSYzlsVVh4ejk2aEU3cHFEei82?=
 =?utf-8?B?S1NIOCs3Sm5sQ0ROTzRpUkVHb05wdzRLQytULzNlKzRBcFE0SWMvaDBOWGZH?=
 =?utf-8?B?WFFKaVhJL01iRjlnRzZjMjlWaU9OVnJaa1VTS1kyUTF1NzlWQklzU1l5aWg1?=
 =?utf-8?B?aDBac0pOS2MzZm1WYyt5VlZ1NlpjeWxtK0pJV21Tb0VpUnJWaEwwSlUrcUJi?=
 =?utf-8?B?dnRXeU5VWDhsOXBXekJUaElLUlVUSStmWW1TbTFHYzFCVW5EUUFXdXdLQ1lh?=
 =?utf-8?B?TU5GVDJJRFNxVlpVYm1BdUdNL1dOWWdFUkRQZjA3NlhQWUM1RjV2QWlrRFVz?=
 =?utf-8?B?d2VZUER1bXFyRlpjNmhVZW14UVFTMm9uMTF2blBJaXFPZFdpSjZjMGE2UkNn?=
 =?utf-8?B?TVg5RURVeTB3UjhpTGpYWnJ0WFk2UEs4NTFmTVcxYzlQdjJoUW85S21HbGFN?=
 =?utf-8?B?NTNFVWJkdlloY0l0eWJnc1FnUjc2VXB2ZVdUczY3aWFudmg2YUkwT0U2QkRN?=
 =?utf-8?B?RngvYjRSWExCRUdsUW9icjdZdVBTdWFyTi9lb2lEcit6MXdNTUVPZ3c0Tkt5?=
 =?utf-8?B?MW1hRnlWNlNOdE9nUWpGR3ZUdm1ESUU1M05IUU1lcVNOTkl2QkdsaWFxMXZr?=
 =?utf-8?B?a1ppNUFqZHNyOFdLdjdFaEhMK3REUGpEYXZTQjJHK3pJYUVCRFF0bHl2QUl5?=
 =?utf-8?B?MFZ4WlhRaW85RWFBd2hGZFNWSWJXTE4yYzkrblpmVjRlcUxKWXdjWHdjc3lP?=
 =?utf-8?B?eHZDdXh5c0hpNlBteTdMU3VXN3Jaa2JQSUt4RUlXZVR5M1hMbWpuZUN6Y01V?=
 =?utf-8?B?NEFzV1QxSjJVdXN2eGFPSFF0TnRpeW83TGhPTWVJRUFoUmZCWE5RYmt5ZDZn?=
 =?utf-8?B?WkM3SUlIU2VzV2JMV2pUOE5Nak1ORFhEKzd4b05qWjcyOGZ2d1BpUmVFWEdG?=
 =?utf-8?B?S1FwNjN4VDdFeXRPdVg5UXgrV00yUCttUDd1WnFHRmQvUXdQaXFSdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792455a3-b4f3-44a8-1b20-08de747e8952
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:59:55.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmHI+B9VLeUCaXhbkgaT0U4nME/CDy2OmrfE/01CGnb+XYR6MnbnkGw7u6ru3cElEO2my+r84wMQjyxCYPyOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661



On 23.02.26 19:34, Dragos Tatulea wrote:
> 
> 
> On 23.02.26 18:33, Benjamin Block wrote:
>> On Mon, Feb 23, 2026 at 03:10:35PM +0100, Dragos Tatulea wrote:
>>> After pulling in these commits in our internal tree we can see the
>>> lockdep splat from below in many internal tests. We are still trying to
>>> find an easy repro for this. We had to internally revert both of them.
>>>
>>> I noticed some similar discussion in another thread [1] but there it
>>> seems that these changes are actually fixing the issue which is not
>>> the case for us.
>>>
>>> ------------[ cut here ]------------
>>> WARNING: drivers/pci/remove.c:130 at pci_stop_and_remove_bus_device+0x39/0x40, CPU#2: modprobe/12956
>>> Modules linked in: mlx5_core(-) act_tunnel_key vxlan dummy act_mirred act_gact cls_flower act_police act_ct nf_flow_table [...]
>>> CPU: 2 UID: 0 PID: 12956 Comm: modprobe Not tainted 6.19.0net_next_e834b5e #1 PREEMPT 
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>> RIP: 0010:pci_stop_and_remove_bus_device+0x39/0x40
>>> Code: [...]
>>> RSP: 0018:ffff888164c9fd10 EFLAGS: 00010246
>>> RAX: 0000000000000000 RBX: ffff888188ff2000 RCX: 0000000000000001
>>> RDX: 0000000000000046 RSI: ffffffff8307e068 RDI: ffff88816bf4c9c0
>>> RBP: ffff888188ff2000 R08: 00000000000000f4 R09: ffff88816bf4c080
>>> R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
>>> R13: ffff888164c9fd27 R14: 0000000000000002 R15: 0000000000000000
>>> FS:  00007f52364bd740(0000) GS:ffff8885a9019000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00005622dbf749d8 CR3: 0000000169132004 CR4: 0000000000372eb0
>>> Call Trace:
>>>  <TASK>
>>>  pci_iov_remove_virtfn+0xbd/0x120
>>>  sriov_disable+0x30/0xe0
>>>  mlx5_sriov_disable+0x50/0xa0 [mlx5_core]
>>>  remove_one+0x68/0xe0 [mlx5_core]
>>>  pci_device_remove+0x39/0xa0
>>>  device_release_driver_internal+0x1e4/0x240
>>>  driver_detach+0x47/0x90
>>>  bus_remove_driver+0x84/0x110
>>>  pci_unregister_driver+0x3b/0x90
>>
>> This looks pretty much like what Ionut is trying to fix in
>> v1: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/T/
>> v2: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/T/
>>
>> Maybe try giving those patches a spin. I think one easy way to hit this sort
>> of thing is to try unbinding a PF that has 1 or more VFs attached to it from
>> some device driver. The "trick" is that SR-IOV has to be active.
> Thanks or the pointer. Will try it.
> 
Took the v2 and it did the trick. Thanks!
Is it worth a Tested-by tag from me?

Thanks,
Dragos
