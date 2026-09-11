Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB72DE6E6;
	Fri, 11 Sep 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135762; cv=fail; b=rbF6D+xFgM9fPnRF7idZt1Cu6tFDBaTHF1zblxGtQ2rcrY0q9cTRlJO2lRBPg1CyLFThU5QeEtrZo2mnPC/zvNMna6QSSP85NEkH7SmOZYdLHzk0UB+c2u+LsFAeCRbZdAF+8QZISNWHL33g0E/2idKniWUKZfYBgTU6ZvxRWOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135762; c=relaxed/simple;
	bh=EsODgA5eMeIc7RPZK+1RIm02jHcGdHRR0m+VNlOAmbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1bcGmtEGJjzrvvHkstxPQvy51ptEqV9oKAbS1SC3IgG6BXY166LrEIhQ/nrUFKwGKFy709Mai5dSukeA++FOqXIHJibkJKcU9hFmvSlJM7KjCWAN5Ul4E5JbqrYSPHXIDrS3kTyRGSlj472IR6/8tCRELfjeGEC64y6Ad9dGG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2178IyA; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2178IyA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7pp/EQTTZKdO9HUB9p73ZiT3xdI8oi4M7niBn83k3YVG9vPqr4GcxhOMKCjWUWGJZQv2Hp9kolohIssSIL1jISX+UW7bgbLbtjA6PLjFXTxwr5jefvED+r3BLvaw9p31mMJ54lRmXqbbfS5/4cjGZShPCu3WQJacj/4VVWMXNg/gQEC+AWmRXGRtNU+vpWleyqqd37UUGmjprIsIwwx2je+Dv/FGDVNsJ6RJ/2Y3gSBxqE/xgeu3MX5spjxeaU5Je1a80GXvfD88IIaqL9+pGC2CK3WXf52VquCHjeXM0UYskY5u6UG3KbO1Csg/o/l8mmz1ZbpWqGfg8Dp2Iw9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS73trkfb+nuz9hoUveWnT6pAidZbjcZ1MS88QnRlh0=;
 b=vxmGjtMwtQ0b9lNrlCXIOYEzOkMyZ111slEzUQmB8L8Jfk8lUPrX6nYiSD9VC1/425zUf3xuunShQ59IFkpNSeLwWAcW/Myg7LzJaw3l0uKSDXgb2wBwYDchDEQev7vTc+M7KWcwOg8Io0pTMONHErnLjDiFNEWKPkgJJ4d+1dKx+ULAjia+rWUh0z9nG4Z86y9KDMOWfCOjOkZ/Sfi/VrKEOHjk3tEJLLK7cliw3P0vrUr7Qtcy4sO7sWp9u6nHQ9D2hQYebwTcT7NhsTNIqQ96G0jcIRnYcW0ixTAOZCOG898njtGpJXLkQah0OLsOZl1jYN9HqfsQ5KvlHWK5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS73trkfb+nuz9hoUveWnT6pAidZbjcZ1MS88QnRlh0=;
 b=a2178IyASqaevYveHjMGh5RDsofiF1TY5GGVAfAf4+BU0ezrSn3G+hgyo7x+D3OAV4/8lMJIZ1pwTbKNSF8v358LFv2qpNNda302/MwHxfyZOrFeYtYbdU1hN36cnpg2BpGvreKKyr9EkBvQ6fiXhct79zOPtT2pk6AIKfxeukc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:09:14 +0000
Received: from CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176]) by CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:09:11 +0000
Message-ID: <58e8a8f9-6e5e-4c29-a974-7b3d6413ab48@amd.com>
Date: Fri, 11 Sep 2026 16:09:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nikola Prica <nikprica@amd.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
 jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
 <9a71c692-66e7-4c5a-b98a-69ebae2e5bb8@amd.com>
Content-Language: en-US
From: "Prica, Nikola" <nikola.prica@amd.com>
In-Reply-To: <9a71c692-66e7-4c5a-b98a-69ebae2e5bb8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::17) To CH3PR12MB7571.namprd12.prod.outlook.com
 (2603:10b6:610:147::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7571:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: ce92aab4-2f51-4f80-9d0b-08df100e40a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|10067099003|5023799004|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	srGFBZIfdTugRy8Tb7W5ObNm2f1q/2cVpBHX0YwmwYRRp1ojoaP1nopTjLJqFm21XGM/23exE0apfhFJd+591xDzr5RSQ15f37kL4x1RzGkBE6yVIFGfpUwinZp+Divx/qwLdjKKPEbeFWr9/v+iWtEMD7UyVwb/HBp6vjiq+FYkUjLpoevRFP7+dO0pgExuQHkL4q6ove02XIWqaHhN0O4B3wKJAyW2f+RH/R4x65yNGjp8Bp04jF1hdBspZqwF9tQy1RVhr7agu9ApvvTF3A1jjNBm8gwPn9DoTV1N9qOy0uAaP2ysRg3ycPhe5Y9lXT9OAv2zDZFvuD0/ZUJbXVMEmF9De6lMhKjuF5aKDT48mPvYJTH4PkoNs4SYxafR/7Mps4PHMhi5DSPei0WrosYBHcIj95RX22Rp2i3093Dqv5LXvNEeH8FcbIkwPvN9OLAymn7GVjmPXk+231fF3BOE9cx3aerQC+p6Oei/WKNOT8VQazCdGtwiMlIqtsqZRLohyrlj2kZ18q8Taa1O5PxBtwnkIPeT/6CgVRrimf9G2U/2MIUdIti5zXeSxKOxoUnNiaqSPtLNxufk5TCKJl803u4ax/jPlVVQBziNhj/pVKjmPz52hw85I76uCFt5cZ0yJwqIbbpIXMdt3y/RLbfVJB4hXxmBUym4foXX5Jk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNYWWE1Q0MxZTMwbWF5MkQ0d3dlQ1lxcm54YWJpZXNvMTZiMnZsUmhiNi83?=
 =?utf-8?B?cFBhY1dJMUsreFluRkw5Z21XcXYzUHhWemk1bFFQaVlPd21TbHU3QTVmQytx?=
 =?utf-8?B?YkNpVFhPQndpdktZc2lqOUMyVDlHQ0gvU0dBUkpSK3RiV01kdHlKaW90ZHAz?=
 =?utf-8?B?RUdNTUd1dHo5dUVmdDNwZnF0cGhINFFRWmhPSGVOTEgwZ3RpNGh0SFVTYWxR?=
 =?utf-8?B?dUZYSjVWSjhVQUZPODFxcHVoYkNDRkY0eEFXdzlwVHJ5SXdNRjl6M2R2bVdK?=
 =?utf-8?B?S2ROTC9qNjk4VGR1WWZwbUp6ajg3T05aWHhhSXlKMmpsNVFteC9iYlYrL09C?=
 =?utf-8?B?UThLL2xObEg1ZnpSYXFPbmxWYVFnQ1VoMTlzVEJNM0ZNTTJsNTVqS0J2LzZI?=
 =?utf-8?B?TmhVOVVITEVTN1pKWkZNWnRVVkdMcGF2a1RuaU5IeVNiSXJnT2pMVUVFbmNB?=
 =?utf-8?B?TERZVi9wYWpHYXNyczM5VTl1NGVqT0ZIRmZCb0RZR3BqSXlrK2R2RExJNFk1?=
 =?utf-8?B?YlhkUVpxRzg2c0VzMnV2d1pxdEFRYXpMQ2JYVEpZcStVU2xRc3N6VWZyUitm?=
 =?utf-8?B?aERpNmRWbHNxeU9IMCtnUHFBaXZzRHB4ZEhkK2RpSG9BcDIyYmROcFBybTh1?=
 =?utf-8?B?cU1KRzlQaGZiMDFRMnZHc1A2SHZEUjF2U0sveHJWWUE0ekxob2RleXNncVFL?=
 =?utf-8?B?ZnJxbDliVG8xUUhpbGlqQ040ajVVUEVzUzREOUdFbDBuTlo2U1hib0txREVN?=
 =?utf-8?B?emlnVHY0WnZqVm1lTk15TFg4QTBCcXMzVzd1RS81Z2dKSG14My9TeHZwMWVZ?=
 =?utf-8?B?RTF4dm5wL05GZlZ2MlVYa2Y0MkxzbThNQWJuNE1HaDVUeWlEVzRYdGp2Mnox?=
 =?utf-8?B?OUFROXRzYVpzc25VVzgrTDBNVDhOTm1WTkduR1YzZTFseFhGbTZYYlRBWEgv?=
 =?utf-8?B?cStnVmMwN3luTmxPeGJTY1hkVmMxVHFxS3krQ2ovN2RFOTJ0UnIvU2poQzJy?=
 =?utf-8?B?Q2VBZ2wvRkloeUtSaHhRVlZnY1lRTmliaWdnWGVkUTVUNEtQSzI5aTcwZjEv?=
 =?utf-8?B?NVdGcmZOVHpnNi9pa3RuK3RMbEVyWUU2V2NLNGlCNUVDOWNSRytaNDFtS0ZY?=
 =?utf-8?B?R21RMUxjbnV2d1FJcXQ0V2lKdFZKTmV5NmZ1MHpBcnRrUm5aY1VXaVRmZWt5?=
 =?utf-8?B?MjdFNWc1WTMwK285b2xkdmhWVEJSTVYyMzd2MGFyODdqZ2FYTm1US01RZUJB?=
 =?utf-8?B?dklWb0NQeXkvVWVmYnJWSW8vSVdwMVBHT1FFaWlBYjJoS05TOGIrZnJWaHNa?=
 =?utf-8?B?amRyR2pTZ2RqMUdaOTJsK0hOTGppR3dyd1lydnA4RnNjVVk2UW83ZC9MQ29o?=
 =?utf-8?B?YnprbzdyckdxV2ErcFJOckpRT054cTRhaWpGNC84aWJNRVNqancrc1l5UDJo?=
 =?utf-8?B?UFZ6RGVIbzdSSVZxWkRDdWtwR2doZHMzcVpselV2LzI2Y29wNmNUV1RSQmwx?=
 =?utf-8?B?Z1UwK1BjR3MzYlhoRnV0cjJXRlVuTW1iVjBadHpZTUhrZkF2VTAwRjNCN2Ny?=
 =?utf-8?B?SHk2QlBNaDI2a1daMk1tb1JjOVg0NWYvK2lLd3VCOXhlMnBMYTdkWStXQWJG?=
 =?utf-8?B?K1B2UENySXprY0pCaytyc2xlRWxCWUZtT0o1L1hUUWkxN0ZiYkRwWHNmUUNC?=
 =?utf-8?B?SDduZWtXbE1pa1o0M0tzcGVXRGRaN1hucmN5Rkd4ZGdEa0J6eHpCQ0wxMC9k?=
 =?utf-8?B?Z1B2N2xOaHBvMDJjbjBaV29YVDJXUVp2WFRoaFhXM2VRRC9GbDhIVExEZ29z?=
 =?utf-8?B?OG9mN2p3ODVzMEdaSHcvMFZvN0xxQ0RvckdsTmVDNzNQZFdaRk4xNEJkd3FY?=
 =?utf-8?B?RUtoRDlQaHFYalBOSUVNZHlTamtXNzNkRTBLbmtWbmVzcjZWN09JZVI2TGNX?=
 =?utf-8?B?K0tvOVl1RzhSS1JuNDE4WFo1Z3JEZ3hLWHQ5T04rSysxMTBjR1FsdlRUTDVE?=
 =?utf-8?B?SXRNLzRkN0xkK0wvZDJqWTFzY2E2OGhiaW10Q2FJcUc3L3hWOG9jM0FtaVNm?=
 =?utf-8?B?OEhwYlFOakpUcllTRlhkQkpZRmVuOWMyV1grQ3pOOUQ2YkhtQVk4TllYZzlZ?=
 =?utf-8?B?cmF3MjlvcDljUlQvU2tTUWprd1ZTbDg4M1U2eGRac1BIMVNVbUhiWDRqN05z?=
 =?utf-8?B?L2JVaVRKOHAwVldCZkNKeHFCdGllbXl4OVVLTTU5WThDRFZGaEI3WldkSlho?=
 =?utf-8?B?VnN3M1c4d0x1b2diU2FCclU5ME9RSGYxdWNVZ3VaenRMOFF0QWZBQzdCdkZN?=
 =?utf-8?B?K2h2TE4ydmVKSDFXMTgvcDhUSUlWZ0tKdVEzemtjNG56VUd4elFLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92aab4-2f51-4f80-9d0b-08df100e40a4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 14:09:11.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkfi99Un2Udxp/X4Ox3+xiJB5UXwBNKoC4sf7woLkcuTKqpTO+F6jk2KG1UQICTwCSAznLeoxSjIirgcSnjGyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185

Hi Bjorn, any thoughs on this? Do you need more information?

Thanks,
Nikola

On 9/8/2026 10:47 AM, Christian König wrote:
> On 9/7/26 18:17, Nikola Prica wrote:
>> From: Nikola Prica <nikola.prica@amd.com>
>>
>> pci_enable_atomic_ops_to_root() currently fails when no root port is
>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>> endpoint is assigned to the VM, but the guest topology has no root
>> port above it.
>>
>> In those setups the hypervisor may already have enabled AtomicOp
>> requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>> treat AtomicOps as already enabled and return success instead of
>> failing the Root Port walk.
>>
>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Bjorn first of all any objections to this? It sounds save to me, only a handful of drivers actually use this function and it generally seems to be the right things to do.
> 
> Then if you agree any objections to up-streaming it through AMDs GPU branch? That would make things a bit easier for us.
> 
> Thanks,
> Christian.
> 
>> ---
>> Changes in v2:
>> - Be more strict and only apply logic in headless device case.
>>
>>   drivers/pci/pci.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..62729ade496f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>   	}
>>   
>>   	root = pcie_find_root_port(dev);
>> -	if (!root)
>> +	if (!root) {
>> +		/*
>> +		 * A hypervisor may expose a headless topology with no
>> +		 * visible root port.  If it has already set AtomicOp
>> +		 * Requester Enable, there is nothing more to do.
>> +		 */
>> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>> +			return 0;
>> +
>>   		return -EINVAL;
>> +	}
>>   
>>   	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>   	if ((cap & cap_mask) != cap_mask)
> 

