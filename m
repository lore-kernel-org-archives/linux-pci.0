Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013075.outbound.protection.outlook.com [52.103.43.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124549480B;
	Thu,  3 Sep 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438248; cv=fail; b=tpKAjYPT0k7MgOyqJLWiwfXUPJONv9qVYSJkp09wAkVRenUYq+uA5mWJ1DTjlbDrDtVvnAjGoH2rkJARLbBvV7KpQNFHM7PHAL65gFbrT3J3JyJfCoepY+/xiUZgb+2OnTX1iGL/bIBoKeBW3Tc97Kxq2jBeDFauSVXow3dZQyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438248; c=relaxed/simple;
	bh=OT1o+4Ck0ybLdsfLkZJImaJRhHnX6ndnTHi801YBZic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIpWIhTe6lYGm+W9U3pizZAii5OysrxdTDJyQzxAeMo05miV1xa00di5yLEvXMxhnE6jPigNg1UVNML/0h5Re5j6k+1FMUsXUnaSNjnnnCdymZxq10JFdQvA29Chs5NRtYjnkLUyhXiDih1S82Fpcs99LRtHQVDItzBC3ZhoBhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=klCdYLvT; arc=fail smtp.client-ip=52.103.43.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="klCdYLvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEhorV9xrYyEQrrmHReufr4EvNrJIEVEypbwZjUzxS8Snz4sTMHiSaADeYCbwS/XealFgMkwqKw5yiZBryYbwLsv5i6HXYkxByWExMLgM++lKwRpjet5Uamzaxn2rQqF8xrxJ/J4+6HfLsshfIsxJdvOUR+XudTwPG9pCgWR4jPWuYmYNIQbyQS/o3Ksl77vCr5u67cFPRGV1SLRsSoJJjhlbBgyIHDbIDugafY0KwLSVnZ7V77S5fWULwkxIPywuZHYGm4Q5Zz0bbEsoCK/osqBTvmapzvzSX8A2wk29f2ZsD22qdHH6xt2mJ+7Ex3MdkL0AjOrSzk90A2R7w9+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1+7e6X1eNx+XcgSDX3h470WB5RhajddVUiVTs/AeJw=;
 b=rGM1s49LqnTTJ8fI+lYG5/LjkxIj6lCd3NxNkZbvIQyi/rTzfPle8Ah6Rd+aLEf8Zl6eCV2ly2F3JVIf8fzQWzpUeKMPI/O4qN8ifbFvENvmrbk4MnPL6z/t3NC9NrnGmYlpzPhGm3c+9tsfd/vJ0wNnQ6LZLBbMl50eUcpcSDrs0k/BIs/h5mp7rOGVefgVITp89VKYYEg8CtDjulwl5bwOrbMCG3iT5dXUCoHJLASf4OLFX8zQ58wjDIVhQBI2/Zm66PoQf1RerJyU9ZoQjZ4x+t0rxrIHHnAcTq5KQFU9rdA6y/PbTeOsEGFqRv+SQCo6tAm9DVybVK+PpSuFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1+7e6X1eNx+XcgSDX3h470WB5RhajddVUiVTs/AeJw=;
 b=klCdYLvTncDPFReevlaElhbBKd8OI+eq1scnvImkwh+EvGcvdnbnadra5/cUuIRM48OuRs/ixMMtJ6UhdrDApA6sg+X9dcqFlUZSjPfYter+YQZmh9V6i+2uNiJywCHmda6rIvvEfIN7zUv8nBe7E+tZI3vDIy52Qx01if4egqczn50qATXt2rcMnD6F7B24+Nn17gQFaM+qplHVzsVwaf129apbO6sDYcBpr7m84yvxRYj0IM0/MdZIt6YB/jVcZMAdKkeJw+jwx5oEovU9f8PV03938ZPizHtyalUNutk1a9xkdRDh9rsxhLHlV0u8kbs35i2QmA04PB+p7k82XA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SG2PPF56DBE66A6.apcprd01.prod.exchangelabs.com
 (2603:1096:f:fff6::422) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:24:04 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:24:03 +0000
Message-ID:
 <SI2PR01MB4393034C88DED5A269CA5BD5DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 3 Sep 2026 20:23:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 bhelgaas@google.com
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439380682B8703CB5340AD59DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260903042653.8A3791F000E9@smtp.kernel.org>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260903042653.8A3791F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0014.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::9) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <9c3456cf-aad9-4f42-9313-fd9216ace20a@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SG2PPF56DBE66A6:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc3feac-7654-4f55-46a3-08df09b63cb6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|5072599009|51005399006|15080799012|6090799003|41001999006|8060799015|23021999003|19110799012|37011999003|25010399006|4140399003|40105399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y243N09hdXpzQ1BzV2FMS1Bud0RDMVl4a2IyZ1JqemU2MlRBNm1td2ljZ1Bu?=
 =?utf-8?B?RmRvbmc4K3dBUU1IeFJOWEIxaUVEOGIyTlFDdUw0dGQzWW5DZUJHYktZL2I1?=
 =?utf-8?B?angwemVhME1XNk1LZDd6dXBOeGFFUFNVSlYrVzIzTE90Nk1jTU1tbUE2QkdG?=
 =?utf-8?B?VnRTZGV5aHBLNlZJVEFCNCt0K3ErR0JHcE5KbDNWd24vUHhwTzBuU05uVjFD?=
 =?utf-8?B?ajNtVGRMTUpqTk9GNVBSV0VocnZERUtHNExNRGRCL1lRV2l1bFY0dTJMaWly?=
 =?utf-8?B?R0JlUS81TFpJcEllemhuVFRoLzBRN3U3SW5WeWc2ZEFidzlKQng0RHlST3JM?=
 =?utf-8?B?cFRYZTVVZVoyRzUzb1p6c1BuQU9OS01FYUJSZ0RKTFZiOWJjdWxnakpXcCtE?=
 =?utf-8?B?ZnpMOThSWmRiNVhYM203empWN1pBblI1Zm5yNjZncjVmUDRweFlYbytIdzV5?=
 =?utf-8?B?VDRwSmxpeWJaRnFyQzBBUlRLUVFxb2YrWFhWOUU1cngvSkRZelJFWlJBZ2V2?=
 =?utf-8?B?YWpFZ09XWHVGSk9CRjZyMEwzMkVOMWVpT3pBMW54YnBHMS9vendOYWhnbEE3?=
 =?utf-8?B?S1dmSm9kZlh0dG14MTMwSTgxOU1YSUVidC9ISzNmTHZmQmpGY2xkQTcwbER3?=
 =?utf-8?B?NUJwU1piMGhoYmU1b1VvdjRTMDhyQ1hMNFFwSkZ2K3lBRXdOaWZldWNvOGt5?=
 =?utf-8?B?a0FpMGVtNUwrZTVKbEkveTdtaGRaa2w0bTNKdytYQmxHOTJBeVlhVjhNdzlZ?=
 =?utf-8?B?Um01UkhDYjl1a2RkSlozTmQ5dElLOU9iSTMrNjJwcXV6MmNDYWZ0VjF6YThq?=
 =?utf-8?B?UlBpNGxWQkpjdTJlWTZWbGUzcGFRYmRYM3JtaUc0VG14RnRLR1UxZDlMOVpC?=
 =?utf-8?B?dGFYOE9JM0VqSnB1TjhUU3VXMjA4cVBCRlFDL3h4a1BncC9UNk90YkF3MS9w?=
 =?utf-8?B?YkdUT3ZjYjNjKzNwYnc1SjFEckZDaWZ3UGJNVXFZQVhGZldxUXc4T3hYTXZm?=
 =?utf-8?B?ZVE4R0MrNXI4UHlFVFFtMDNHck5MRVFKNjArckdmWUFUN3pBM1ZmZGthVDB3?=
 =?utf-8?B?cWZXd05kdk40KzMwTTF1ZFp2OXVHY3hsMndjVTFQVXRPTkJQRDRraGRPSXFj?=
 =?utf-8?B?MXJsR0NubzR6ZDFScXQzMmliWUFGYlVZeUpGZFI2K2JmSDFmalVIR3U4MFNi?=
 =?utf-8?B?RVVFbm5odmgrT0hHRENNSm5mZ3dtendEWXhlRVZPNzBnZHYxZ2s4REt1M3Rn?=
 =?utf-8?B?OEM2aDlQc1JubEZ3ZzVIbXhkZnBZK2ZKc0VNUUt3L0lyOFZVbXliVlo1RWMr?=
 =?utf-8?B?V1QyTG5XbGU4cDhpK2Y4aGdnRm9POVdRN2hOS1hBT2hBb1VTRThrdmc1SUty?=
 =?utf-8?Q?XMDqBcOZTmVL44uxCQCWeeJQa0rgumrM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk00REhvZEF0RkxqRXo0STJWMkN3ZjFOcFBFdzFPdnJ4L0tpamZEemVFbXg2?=
 =?utf-8?B?VXZXc3Jna3pVcmNhRzBsNVMyc2FUUXNTMjN4U2JyTlljVjVoaVU2STFkTXp6?=
 =?utf-8?B?WXNjQ1hTQWY0T2wxYUtzYStwMW5uVWZwYXlUL1o3NDBEUnFxSXJVNURQbm9t?=
 =?utf-8?B?V3loOW1OY1pKTEQ1MW5JdEg5N2pZRTJ6eFVacGlwYm9wY2tPK21MRDBUYUEw?=
 =?utf-8?B?R1prRGg1cnB1N0xuTjFIeEJjNlM0bkJMSXpnVjlMbEhWZGl4MHkrQ0NPZWpQ?=
 =?utf-8?B?N1QzdEpVdk5VK0s4KzBGMmhzS2VETSt4T1JSbWtnVFJWZHV2N1gxc2NoZHpw?=
 =?utf-8?B?REVCNzNKRFhxWGlLcXNHZGNLRDdpUTFOMmJ3UjdjeWlORWZtd2FGL3VFUFdu?=
 =?utf-8?B?dzFxaWxMWXV0SzRKOFhsRzBSb0tPbGpKNjlTdzNnM0VYam0wUWJqRWxTSFFo?=
 =?utf-8?B?SzZMS2RnbXVoMTBmcnoxZE00bzVGRDIvdXcxQTdXNlR3ZDBmNU8wUTF2blcy?=
 =?utf-8?B?SnR2c05zZ0Jya2s2RWZseEwyMXR3dEQwM0k2ckJDRWt2a2F2RjRZT0NxK0xL?=
 =?utf-8?B?ZGE2ci9UY1J6bzZ4aXUvNWdibmt5K1RtSXFiZDBWRkdVNFN1T1FIcjJXR2NB?=
 =?utf-8?B?VndMOUVTWEtNMC9HbDBoQzN6eUpWTXlnWm9pY1NScFEwN1dwb3dJZk1MUkZX?=
 =?utf-8?B?Nk1vMFhFMExaeUxlSXIzUC8wclhYQnBjU2hQclliS1Nmck5KaDU1b2xXOCtX?=
 =?utf-8?B?cm5LK2gyd0d3K0JqeDVkZVpsL0FCbnZFeGMvOFpnbnhJTjVjeUVTdzZ5c05s?=
 =?utf-8?B?Y1BlS0pGVFR2RmZjemlWa1p5Ylp4SEU0azZ2TTg0a09QK0NJN2RrUzhUWkgz?=
 =?utf-8?B?QVdhcHZVc2pBaG5zTVIyTWxkNjY0ME5uaEhGWlNSRzhGamVubDNEMnhPYkRT?=
 =?utf-8?B?VDFOMzE3aS92MS9teS9QVHJ4OVl6dUFxSFROTjNRR2Z5M29NSThmQlZsNmZr?=
 =?utf-8?B?MlVWdklQMkEvaWlkVUxaWSs4a3FCemQyNCtpQWd6Z0tkYkVFdXZkdUlveTU5?=
 =?utf-8?B?MjVUY0k4NVZkOGRzcnJ4NHpqQ0xBNGpwUzU2NHpvbzczRkJoRkxtWTc2WjNC?=
 =?utf-8?B?dTRmQkpJWUlwT2dISDZYZGpubFFyZ3FKamtuTEtIeFE2ZW1scHEzdmxSMGxJ?=
 =?utf-8?B?My81azdFRVUzRzM0dUFFZHN0M3VNYUdhZlZ0U3RnYlNoSTNVbGR3OXdpS1dT?=
 =?utf-8?B?L3FRN1NvNTRONFVhY2VkcllxOU1oYlMvV20reWpVclo5LzRlS0NCcVV0NnVF?=
 =?utf-8?B?Zm1CS1h1Y0phdTNicUM1UHhLMUNuZEpnWEQxS2hmNGNqblgydjA3YXlIQTE3?=
 =?utf-8?B?WWE2d3hHVlcrNG93Ry9oMUE1L29Ib2FRVFpaNlZzb1I4RlIvWE9adjlUL0li?=
 =?utf-8?B?djM4L1BBRGYwMzRjZTVMeWtsTHMvRitKYjM4a3cwNkdxaGhNUkd3eWtBSWdQ?=
 =?utf-8?B?ZWZ2alI0ZG5xcUpkTUh3dVVIS3BWTTE4cngyM3NheG5hV1BpNmRxOUdTNDhS?=
 =?utf-8?B?V2RubnpSSVBHVkZ6blI2bi8vckswaDQ3dEVvQy9pSDVkSjlqZnk2UFo1Y3pV?=
 =?utf-8?B?OVhBTFhTRDBrQWJsNXQzNzdzcW9XSE1rbWlCQmxrSXJkajJ4c3NzcFRhRWdu?=
 =?utf-8?B?eElYbVE0OWZsRHptaVJJL0pwd3FLLzdFREpzT3g2WWxUT3NyTE5LN0F0b01p?=
 =?utf-8?B?NklOaDdCVldVSS9Wb1pZM2Q5RVRuKzl2U0ROY0NnRmsxYWZjM0xIR3VTUUJh?=
 =?utf-8?B?K0s4L1ZTZDNHaUQ5a21oZmZSbTcyM3NmVXZ5ZHh2aWRPWVptUXV3VTF4c3FH?=
 =?utf-8?Q?PnOQWOi2mz5uI?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc3feac-7654-4f55-46a3-08df09b63cb6
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:24:03.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PPF56DBE66A6

On 9/3/26 12:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but user-provided ACS command line parameters silently wipe out standard IOMMU protections (SV, TB, UF) for unspecified bits by reverting to hardware defaults.


I plan to keep the patch as is unless someone sees a concrete case that warrants
a behavior change.


> --
> 
> commit 62951886e4f26a51d147451d4aa7384b487c2ff6
> Author: Wei Wang <wei.w.wang@hotmail.com>
> 
> PCI: Refactor disable_acs_redir and config_acs param handling
> 
> This commit splits the intertwined disable_acs_redir and config_acs parameter
> handling inside __pci_config_acs() into dedicated functions. It also improves
> parameter parsing by checking for a matching device before parsing flags and
> replacing complex string parsing with cleaner loops and switch statements.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 587c013f04db3..6cffdbba99d34 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
> 
> [ ... ]
> 
>> +static void pci_param_disable_acs_redir(struct pci_dev *dev,
>> +					struct pci_acs *caps)
>> +{
>> +	const u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
>> +
>> +	if (!disable_acs_redir_param ||
>> +	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
>> +	    !pci_dev_specific_disable_acs_redir(dev))
>>   		return;
>>   
>> +	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this overwrite silently
> discard the standard IOMMU protections (SV, TB, UF) established earlier?
> 
> When an administrator uses pci=disable_acs_redir=..., pci_enable_acs()
> first enables OS-level protections via pci_std_enable_acs(dev, &caps).
> 
> However, because this assignment bases the new control register completely on
> caps->fw_ctrl, any previously configured security bits are erased. This breaks
> PCIe isolation guarantees for the affected devices.
> 

This mainly addresses how to handle the "x" bit.
kernel-parameters.txt mentions:
"
pci=config_acs=10x@pci:0:0 would configure all devices that support
ACS to enable P2P Request Redirect, disable Translation Blocking,
and leave Source Validation unchanged from whatever power-up
or firmware set it to.
"

So the original intent was to leave the state as the firmware left it.

Regarding IOMMU grouping, the impact should be minimal since groups
are made later from the register as actually written (via
pci_acs_enabled()), so there is no false claim of isolation.


> [ ... ]
> 
>> +static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
>> +{
> 
> [ ... ]
> 
>> +	invalid_bits = (enabled_bits | disabled_bits) & ~valid_ctrl;
>> +	if (invalid_bits) {
>> +		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
>> +			invalid_bits);
>> +		enabled_bits &= valid_ctrl;
>> +		disabled_bits &= valid_ctrl;
>> +	}
>>   
>> -	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>> -	pci_dbg(dev, "ACS flags = %#06x\n", flags);
>> -	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>> -	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
>> +	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
>> +		enabled_bits, disabled_bits);
>>   
>> -	/*
>> -	 * For mask bits that are 0, copy them from the firmware setting
>> -	 * and apply flags for all the mask bits that are 1.
>> -	 */
>> -	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
>> +	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
> 
> [Severity: High]
> This is a pre-existing issue, but does this assignment also inadvertently wipe
> out the IOMMU protections set up by pci_std_enable_acs()?
> 
> Similar to pci_param_disable_acs_redir(), when pci=config_acs=... is used,
> all un-masked bits revert to their fw_ctrl hardware default state rather than
> persisting their pci_std_enable_acs() modifications.
> 
> This could potentially allow DMA spoofing or unauthorized memory access on
> devices where the admin only intended to tweak specific ACS bits.
> 

Similar to the above, RR/CR are already cleared by the admin's request, so
subsequent device grouping will work as expected.

