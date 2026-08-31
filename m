Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC444BC97;
	Mon, 31 Aug 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198771; cv=fail; b=r+M9C8OMMc5jr49w4UhfqLZum7IyTKmFt+IGKtmaloadV2nBJN9dMBbWVZUF+hMril7i/zq9DRV+J5FOvxfIBPd3+nllfyBFiQowoDh35cfs6Et0zfMaZyjTKOXK9RFEEPtqkLe1HpgJ/bJzpiPqou9yen4FZN265oA88Zj9iZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198771; c=relaxed/simple;
	bh=ZwI1iF6iHExdNwducLeBgLiR4Bp2nINR4bzBWisxdKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZSjKp9gzZOc0j0LNJPaoM94ZfeKhmco451Qtumzsf5Cpf7lIMBrp7iWPBLDu48GH997rBGcjmVHHSS8Q/M/Qxkh2TF+T/dlnqy2THxm0FB2cVFZKQvIWuiQTzcppjBXTzn+vSsyGu8NeNDcPfEroS60QHAoLw70CpQBtlw5xts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L/N5lE9M; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L/N5lE9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLeBQw+pVFdSqlaPUOFQU5a7AVmA/uNICNnze3m7YEDdfrEODJMaaUM5eMrF/WJ+JLz4P7gAzE0VunJSLkwY7EELwLVbKow761sdhu3TOIv0fAIjhEj8N/mdpf6uL7Zb98GrdCvzQVi7ko3a+Zw0aMqwkvR9BkScvERpYk/po1BVL5FxR9kBE0WX6SK9Qs4n/Y7fNhvn0hSQYXL7/o0rRrp6MmkXjgNUWq524OChf3Rdqmi+Zzh/bV1Fh1gysHHH9zhoh95YxdGzqnaBxiaSxFWxjpvvgClOrl0Npa8EJVRUJV95JdxY2zIB0iGnugjE203ggaFg/WuxR2S+v/QZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VuoMY1oLs9wajwvZ7DBlxcA4A4J8xPNWM9kO7kZW3M=;
 b=aLsY6Bd5hnHjm5Sx5LvH9e5n+KLWkJw+XwNVDeF6x//Re33r1EhGs4rq24MCJOcV6CMAr5vE6pSMzbquWtGkQx6yKM+8vq4RRMRMHWvF1EynnRMK3fvCBBQIOfOoNqxMr+xyF4EB18b0+zGlNEeY6prR/GHaifagVp/atBQP2KflQ+dKlBDuqt27SE2EavO+9kQ35FD/MsUuuwl/mM4tGGaPkHjnpCnRG9v5AHQ61OAlDQYDcSKJBIgrxZUf3Lx0gLtCE9NaqyQ4qaEYEduWt4gU5EpSfDDAJ6Z4IXQK+Q40P/HKaXRom4dUfmx6M+vBa8pdGQ5VSRk44evQ3xFpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VuoMY1oLs9wajwvZ7DBlxcA4A4J8xPNWM9kO7kZW3M=;
 b=L/N5lE9M7q7kxs3JE/8pY2XKYjYrGp9Wp15bkR5bowOAwisIZr2VXBJKw1w6347a+WdaxJxc5KMPrWzeAOTXm/0HJy+QBCy0d9xjoqtuo6E1NsH3fQAU7CoI9fTKFPD8S/vmzohDCPsb6XfAaO9rlnHKzH1kjBx3NFW2iRiNebY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:52:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 17:52:43 +0000
Message-ID: <bb909250-14e3-4a0f-a017-44731ee0f5a1@amd.com>
Date: Mon, 31 Aug 2026 19:52:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Geramy Loveless <gloveless@jqluv.com>, Bjorn Helgaas
 <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 31906055-d436-4be5-4e1f-08df0788a8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	5rBJAoK3ESiqn+Ne2deptUGnPLdsYreP1e1Q2Ie2Nys0p2I7BNuiXfIVWvILOhvv863I1+jtueaevEEKBZIjzJozTC8Nlj7rG4J0m9tsof/o+qglPQCmt2xbVVwaO+UzOmOFtSU9xDftRj3W2FF7hTZZAv6DajOgug6R1U6JcohMVH7PjbrLWmB+yODQdhWakkoAPShtLQ75fjwJR2GFIOOdzLvqSepsU3savzuPjI33rvdm6MBqoXHceywun2M/MHiaw0+Y2eLFaXrodBSLiNp1eH5r4DiA/im6RvPcUVKMbXKMtF9T1ZnzQYLlfGfHEesN5eaF/CV+Xpv7zaHr4+GxH1tyKeDQCfzOdWFcLBnhJPsJ8WuRQgbtHJcR+Uq3R7xBYHoWKqL+ego3vP+TxumPO3Sgd6ZbtHhU09cDdo3yvjcWM6fmLfMHUk8ET9wFC0mlPKkTY1flc/tNSn2UOqrG5U4KAjAMKHRJ3cbYwx9p/veYuhNT4rou+NgJN5Cp8C1iRQnvsLTKpOdv920vpusjHwJWVAhOwIvQ0cdb9DbYLO5B9EL2Wxg/cNDgTCXLOmiMRaGFJBPj8JXEiJWi9klfHUM0ApV3dcoo/vAiZlZAVyeY8zin0pMRqg1RgYZ172VVGMW8IZr6wlKZBkGmavC/W8mfoKJCI462Hnf9VTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ordHkzMVI1d1lkQlhWZ1BvcXN6WVVrTlJ6UkVtUFJLVFluL3Y3Nm1VYWxi?=
 =?utf-8?B?aHBINXQ2Y1dZMS8wN25qRmp1WTNYZXdKYTdiV2EycnhTVzg2b3hFd0VDb01W?=
 =?utf-8?B?THBvOGxhUGw3dW5iUXBCcFIyQ0gzTllnN1hpK3lWWFpVNnlwaWlKWXEzMTRa?=
 =?utf-8?B?TXlDS296SlJ4ejhuemR1WnkvbWFSTi9DeHd1Z3NYS1J4UVN1WUt5RzJua2c0?=
 =?utf-8?B?alFIUXBQKzluenBTNlBiYmZyMXQ3TzZ6dW9qRkI3Y2hWK0NHTzk5ODB6NUQw?=
 =?utf-8?B?VVBSOHluYTMwMXArREFVeVA1L1hzVmJlZG9yNEZBRjhONnc5MlRVdDJBYWRp?=
 =?utf-8?B?aVdvQ3BNTzBVVFg0UVBUTG5xaERMY1ZKcGJDSFd1MHVVb0pXdlBMNEVrV0JI?=
 =?utf-8?B?cCtDVGdXdVdWTkFVSnZ4OTg3OHRWbVh6aFhPUVhRaTNpQ2VPc2NPaTAvbHAx?=
 =?utf-8?B?dE1sT0VpZzh5ODRKUXM1bVhUVncwbXVNak9ybGFQTkZhNm1uOUZPaW9hbGRs?=
 =?utf-8?B?cWorMjNySWlPQVNtSmM3Yk9pZFVkYlBWM1M4bXhqWWNFSEpPeXd4cEJRbGUw?=
 =?utf-8?B?MnhhMEN3eVRzL3ZYdE5jTWRQSWlhQXhIbmtqLzFaWi9hSEp2Y2pURnk4dVE1?=
 =?utf-8?B?VXVnRjd5VVFyajFnRFJ1SWtsSmhER0t1anEySDlHaHZ1L2drdmZ0TWpiQjUw?=
 =?utf-8?B?R0pmM1FseGJxVUFtcUgvRlNIRXRvZVMxUDdkNmRITmxXZjFJT3J3allXdEVo?=
 =?utf-8?B?ZWV1TXR5aThTRUhuc240OFJWUzlPT1VsYnA1WmJXSzA0Z1g0bk9QMi9jNmtt?=
 =?utf-8?B?elkwdEtLS0gzY3JvS0p6OVBscWpwWWFlTW0vN2JOT3YwT3ZPYVI1RCt4M202?=
 =?utf-8?B?OXVLM2NPZXFkci9ITEVMR0FGMXNnZ2ozZDhUcnFMSE1MQ0tWckFjSVZkNGpR?=
 =?utf-8?B?ZkhOYWQ4bWxnMUY5V2VWVHVaS1FIOGMzS25xNWhFdGZ2NXIxbWoraTNISHE4?=
 =?utf-8?B?ZDUyMi9IL2pjNHZpL0FBN2NDMmh1TktvcEgzVzlyY2dxb3NSaWtQbzhiZkNq?=
 =?utf-8?B?WUlFam1FSHdPakU4V296QXVpUFc1Y3hLM21ZSXVHaGJjNkZrV0xrbnUwWDhH?=
 =?utf-8?B?OUFrcmFuV3ptYkc1SGl6MXNHSW04OHBOQkRwQ0FYazVscGRLWEpIZmNSdkw5?=
 =?utf-8?B?ejN2ZXhEYWY2dUZnVHYwMnFHajdxMzhYMTVXS2w2NmNmUCswampZdFA1L0U5?=
 =?utf-8?B?TUZxR3V0NlZkVVpmV2FFeDhVLzFRTVdGWW1zc3Fkd2xXMnVibldBZHB0WWp6?=
 =?utf-8?B?dU52M0ZMTG54dHBYN3hMZlNzQUJaclJtK2J6bFB2SEEwd0Z3V3o4bjRKZ202?=
 =?utf-8?B?NmRsSE12dm1CZ3h5dThwbHNHUEZmdEdqRUZnNVBSR2RuckltcjdMRjROb09C?=
 =?utf-8?B?eE9lVnRLYzFEbWozYnErcHpHdnNGUk9qNGdyaDFSZCt5cDM1UEZvczhPYkRY?=
 =?utf-8?B?RE5kVEVON1dMNW12ZnBiNTZUVlNZV3hQdnhJcFh4UWxtcUdTcVBnbGwyK1ZL?=
 =?utf-8?B?TE5ZY3ZwaWtzanlCSDFzYm5xcWdXbmZhSlZLS0dselc5VG40ZExpdnJ6YkQv?=
 =?utf-8?B?M2JZSnE4SnJFejY2aEFYODhtUjlNbmQyVjRIN0hnV2k0aXZhMll6Y0ZwL3VN?=
 =?utf-8?B?cWhHZlJja1JNYkFKY3AyS1RBSmNhZjJDRHB1N3dJVmFwc0l4dHNXME1lZGVn?=
 =?utf-8?B?NzUvaUVsdCtsc1lwcDIyR3g2VnVYZ0hPSm9pR1l4UkxMd045L3ZzTEJEU0Ft?=
 =?utf-8?B?VTU3VXBjcWxKdEZwNmtUTUxkN2JlYmhxWURXdzNDS1VMU21mbm93SGVlRGlt?=
 =?utf-8?B?VFMybFV0U2xsaHpUa29KNnZUbjhlMzRoeFRaQzdaek9pS3hDWUt4TWJUaWdU?=
 =?utf-8?B?c0pIR3J3aGdCNEIzS1lVbmwrY2NUNkJEenFQQS9kZGMxREljd3J4aUVhTEVt?=
 =?utf-8?B?OElvaURtVnkranBYOU5QdUlkNE5qWE02cmlqMGN0OStJWFVQR3poUDBXVTdq?=
 =?utf-8?B?d3JpVncwSnFFbHBUV1BpVGVRZEZxaWFNeUU1SkZWTm10TVZHdzRPZjZBSzBE?=
 =?utf-8?B?czJleTgydjdLZXlldUhGVWVJaGJjRkRETmladEtOc0FCUis1b2piODVKaWUx?=
 =?utf-8?B?K3crUkVVbjhQY1FEYWFBRldJMHlaeWJ3NGdOcmFwUGlTNWtqbGR4UVU3bkYr?=
 =?utf-8?B?QnFYVTU1dXhjZUxZMzMwc2pldS9aMzRHdjVEY2dBaWlSVG8wbFdNbTRxTUJB?=
 =?utf-8?Q?Z8SMysBnGZFu2OklNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31906055-d436-4be5-4e1f-08df0788a8a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:52:43.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhA60U2j5H4ugvw5Z52SLGJ7l63fO4g1aL7j0qYdVvo3wmwBYLheiuDuwW0z+HpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808



On 8/31/26 18:58, Ilpo Järvinen wrote:
> On Mon, 31 Aug 2026, Christian König wrote:
...
>>> 2. Pack Oversized Windows (BAR Demotion): 
>>> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
>>> to be assigned from the non-prefetchable window. By clearing the PREFETCH 
>>> flag on small control BARs during enumeration, they are placed below 4 GiB. 
>>> The prefetchable window is then cleanly sized to the large BAR alone.
>>
>> Interesting hack, shouldn't really matter for AMD GPUs but that is 
>> something more on the heuristic side. 
>>
>> A perfectly valid trick which is done by BIOS implementations but what 
>> the Linux PCI subsystem still hasn't learned are back to back 
>> allocations, e.g. something like this:
>>
>> BAR0 32 GiB of GPU #1
>> BAR1 2	MiB of GPU #1
>>
>> BAR1 2	MiB of GPU #2
>> BAR0 32 GiB of GPU #2
> 
> Assuming you're oversimplifying the layout above, this was added by the commit 
> 9036bd0efcb6 ("PCI: Align head space better").

Oh nice! Yeah we had quite a number of bug reports because of that.

Usually hot unplugging some PCIe HW and then re-plugging it caused surprises when the BIOS assigned the resources initially and then the Linux kernel on re-plug.

I need to dig up those bug reports and add a reference to the commit to let people retest. 

Thanks for that pointer,
Christian.
