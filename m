Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877E43E083
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788805418; cv=fail; b=OCb74W5rTf70eXWz5XhcfIQJW/pit6B+Y63RzaObPih68ASO0Tfp1gA09emfCM1Ydom8xSG3wABPvMJOk4FIK7BDbJEow9ThWudB+mpvDhc25ioTQcp4Q8zHyM1GbXVgLVVzVfJrTEIWOoEHdbUEOoXQPatrqqVhcTBLax6VCsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788805418; c=relaxed/simple;
	bh=kQAgkkBJW+tCv7An3T7lBL5kRbbvjf6udu90MdRGkQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=srhPpG3NasOprlfMce4mqzfjd3IpivxaUB/X2D9LiVlTLhaZDzKvyjhAU0umyeyRZ1A54E6YbnrvHCzdT23DEYW7bloqYYDRBs3CnmUQAQwnTrRiros2NNPZzxx0yz+OYf3y3ursScVN8WrbKBj9dDJiQIX/2g0Yf+omo9yUtYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FJ9hONqh; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FJ9hONqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQysuUdimcv2KNLAP9BQqvGHDKxi8Yd/f+URahfz7pj/LjGg8JudU/+sjBG2Wx6seguvCLDCbOwmddI+WQ1j9CkmFTgCKxM6ReHvN37Mrcrg074EMSNu1uEV5D5nfHU+gpEaEG40shiG1xcJ3yLtCKxLfOL1jbDfE5mFmULDkUOLn+ZxZkAqloDPIhsKrAxgx1GK8agl8F4b6dJBzuNFE9q0QDkSGc3CBf0QokM53g6NELVu7xMh06tHUvO6+qS+8k3wcinL5EcI5ZE7W4ZdLwKT3vbmWpASOOBe+2WqvWGQ7DUccVtrNEVZ9wLkmeP8yLZC4kyxB74bir6coXk4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nawPk3WE8SkXlHfwUAmGM9WdDW3NtTNl8zKOKzY09N0=;
 b=yEjMSSNEP/u+dEdXrqyplutgWqgE3ZTUNLgXTZf/ws7PMG3d7HMf+dZTh28kkLQCa6Nce4g3ngmu+yIy1GsdOAspLizGMjw7ayoLHVzEN48Jew+f83lGpZN9SIx/SfLN4gkQ9GYO1J6lz4/dhs7lJw1FVjeN78uOO9XQXPDkWlw+XeuT64SwSLZFlvA38kbFkC6gkAfdwMucYteSvRe/HTjhs811yCga4NezrIXYsrQ6OQT8C4qFbeCEDOxi3OADiaGVlUBbQVOOGF/KU7pgsMbd5KGjgXG8l84Oux2Jqm9h9S52O+EKI+jkk1L6Ny8+8K6ce/9vOTwN733gPiezIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nawPk3WE8SkXlHfwUAmGM9WdDW3NtTNl8zKOKzY09N0=;
 b=FJ9hONqhbZaQu2sq8zxfyJBEGuavqrsysAJNhNuzBPxoSia9MVOqy8afN8ptYrt9j2SJ+u8lGumjfUIRZwHbakwZJHSMZxuoRX2czBkFLYfEzNBemLWGCV0yBMap61DN+DJFTPVk5tsoyGOTpqTXYMukqbfMO98/o+bo9w4YxRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 18:23:33 +0000
Received: from CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176]) by CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 18:23:33 +0000
Message-ID: <1cdcbac1-6489-4c28-bcf7-8c4c5a7bb15e@amd.com>
Date: Mon, 7 Sep 2026 20:23:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: sashiko-reviews@lists.linux.dev, Nikola Prica <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
 <20260907161546.5F3471F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Prica, Nikola" <nikola.prica@amd.com>
In-Reply-To: <20260907161546.5F3471F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To CH3PR12MB7571.namprd12.prod.outlook.com
 (2603:10b6:610:147::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7571:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8406134e-85ef-40f7-38d2-08df0d0d2004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|4143699003|11063799006|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yfgWmszQ9shVRARLkQjG5W/+jaRpHHkr3I8Au5XFYopNT5Ga3p1rP73UPvGMiuZN/zSWZRXraKhSobwzgC3eklLdYTC2gJ6H0Te0FEWJhWK/1XBQtjSWmeE/30LGFsa91HRdD17Fx2fFq7e3Q35V+Wo91w5awjhAHoqbeATjm0mllwvweJ8WnUhEg4ZV0eezGyqBJJ+5nr6qJNx0xwuM6ih86hWcXL1HrBEs3epOPcMJGrw3ZdnmOGJzd2HNdJ7AcEi1NrdiaTqG7dOrbP80R3KTD+Nspl28IBGTBJL6kM2aGzU3838HXj8LjCWW0AqA8JQmSoog1XqMjNnz++Zd23QkpOlEFyneux9ljkjSUDCwesVMGyIbv7kPj5WrVqARBaSi5WqPAMELNWoCKFd3eZ1dswrrk8nxf8XhAkYkqUtqqNyoQ0kRFAo0yDb6GIode9QZUcXjrg0bZY37BvqycRMSbyxogzY3wJ18gM1gQXdwywuP9KE5RkRPH6N7FMVKjCjME0v2UFHFX+R0WgOmnTwfSA9i33ROcT2Mcqw64wPa8G7dI2+CyDtFeN4gOmsP1MwOpUtA4nno78q8A6HTK8i9gxGt0DA28GxaSdCz7xQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVBQkxIQkFMaUJiWFBMM2I4MUp3VC9HYThuRDBRTHJMTUZFNi9QYllVQjlL?=
 =?utf-8?B?QzZKVGpKczVJU2xFai9DRVk1Rlk0eDBBVXVZTVpscjdxN01tU2x4Uk1IMjli?=
 =?utf-8?B?QXZ5WjhuMmxLYXdKdCtKOXMrR201UFpTR2s4L2xlVi9PbytENDAwcFFRc1N1?=
 =?utf-8?B?eklnMzdSVGp3MHM1eHJwbDRBRHN3aUNySnNPZzMwRndYWmhoTzB1VVhtZ3Zz?=
 =?utf-8?B?UzNucXNRclpQL3hVSDNkL1hCd3pBVnBtSDFOUGd1QnFtUEdqSE1HRVo1Qnho?=
 =?utf-8?B?cFljMzRMcDR0UmZsVkZWRXdaakl6OTU4MzJBQ0RlQzBhRUhsM3Z6WmFoN3ZU?=
 =?utf-8?B?QVcveWVWaUFLSW9VdG5XaGw3T2Mrd3JhSStJYnNCYzFtN0pScjJheVBiTkxJ?=
 =?utf-8?B?T2s5a1d6Y0pxblEzMlkzZTM0eFFDV3VueFBWdmZ3dHVWaDQ3R2kvNkQydGtx?=
 =?utf-8?B?eEw2RFpOM0Z5MjEyT1JuVGxpWUdnWnVEV1dzTDFCa2lzTzgrNmNrY05YcFNS?=
 =?utf-8?B?MWpTLy9Mbm5NZ2NzUkFJRFVCRVVvYmQ4OGtxSUpiZkY1dXRYTjMrQVRxRXBo?=
 =?utf-8?B?ZnRTSDRIQlg2K1o4TmVyMXJNU3BNWnpZOWJDS1o1Uk85T1lhZExsR3dndE4y?=
 =?utf-8?B?cHRkYXk0ZER4T3k3cHNjVzlLVVcyVW03THFqNEswS3RzZ21SZ0ZsSzdQNXNy?=
 =?utf-8?B?SnZYMmdvbExNWDdETGRrY2d5cVRhcXpzRkJ1b2RIaDBuZnBxVit4SGVFdU1a?=
 =?utf-8?B?c0hEcm8xbG50cEE4cG9HejBOV01Ha0I4ZVR4aGxhVzJaU3AyODQ3ZUlMai8r?=
 =?utf-8?B?UFNpYXZySkdwOWN5N1c4N0U4ekF1a0VHZkVrbXBlWEhoWTJ2aHRHRUllUmFY?=
 =?utf-8?B?S3NhL3ZvWEIxaytKU0ozRmFsNVlRK08yUXNWdlcrWVJ1S0pGYXNWM0dtM2Z4?=
 =?utf-8?B?cjZHRHBiWVEyZVppeTBwVm94UGhJTjFTZTBLTjhKNStJajZwK1V4bWtEMVZH?=
 =?utf-8?B?SkVOTldpWHRBeElJdTNWaFk5YWFoYXVFM0hGbjM0UExWaGFPSjUrOEZqSEN4?=
 =?utf-8?B?cUV3Yk9uUkVxRjdjYklXYk9ndk9vaXJNc08xRXEzY0dTaVdRTGN5R2F1bFlH?=
 =?utf-8?B?MjFVOEtjOVRGZnhoZUtRYjRNZ3BRSzNXS3JCSzVSRnVDbm5oaEozR0VqVmZp?=
 =?utf-8?B?MHFKelRxQzdMdFpER1hVU3ZlV3ZIdVhRMHdxTVFCemZYZm84Z1NXek1KMDQr?=
 =?utf-8?B?WHdZeDRFZy83UFVNeDBJcjJHSHkyRmZkcjJKR1FWS2JFVU5YL0U0cTBVWU5X?=
 =?utf-8?B?L2lQU1poL1p2ZGhUWFVRNjRqSzFIUHZXUkFnR2JIakFTbklDQ1FKcDE4elFD?=
 =?utf-8?B?R1JBVEdMdWhzSHRLRDhkN2RNejJBaUp0K3BQdHQ1S2pieEdrZUwyQWZXMjRm?=
 =?utf-8?B?NmNoYktwNU9NRzNIdTRTMzVIdkZTOXZ3RnpNYVBueFQ2aGJ2UlFiZEp1MG4y?=
 =?utf-8?B?NWYrV3UvSjU4dlg2WVpKcXd4dThUV0NOQzNsODY3cEh0bVNTTXZTcmtldW0y?=
 =?utf-8?B?bnk0bjk2VzJtZWlxRnNpZVFNY2lCZTEzS1lsM2hzTUlBRmRmWXo5aGJ2SGNF?=
 =?utf-8?B?eEJ3bGkwemF2NVhNdnVZaWJOS3FLYWE3UHp3R1hKOEdrYXNIVXVHL1B3QzMy?=
 =?utf-8?B?ZTFyNEpKV3lWSFhjVGltSmlOK2RYREZZalN1QzJrdjZ5ODFOSmUwTkFkZDBF?=
 =?utf-8?B?bWRUSlZhUWhEdHl2OWVUbWVsOWVIdldhbjJvNCtZMU1IMlpLZ3FPa2pidnUy?=
 =?utf-8?B?YWRJeTFhZm1yWHNZMElNZ3R6T2RobDJuU040ZlBVQjBERmVBRmtGM1Z4aFFi?=
 =?utf-8?B?ZHZQWGdjcjk4U1VGcW4wWEFEcnBYcXBpUmhVYVZUQ3h2Z1AyV0gvbkY2M25V?=
 =?utf-8?B?WFdkZTNsYTJLazZteVBsRCtqWDR6ZnJSMEdJN1R3TkhBeHhscEM3Z0p4Slhs?=
 =?utf-8?B?N0ZtaW1oUFlLV2IwS2puNzZkRGV1d0NOZ3dWOWdiZmVTWUJlODBsWHpra3hr?=
 =?utf-8?B?QVVaNmhkK2dtSCswbTFNODBuUXMxeDZyNENkZnZFUGt4UnRwcXh6dGl6Z1NN?=
 =?utf-8?B?eGFMN0hLL2RqM2FRQU5qMkx3c3RSREJiZzNpR0Y3Y1FQREg1R05kUjJSRjd5?=
 =?utf-8?B?NzJFTTVXWTV5eXo2N2gvMlQxUWRVMHM1RFhpK1A0SzJRbU0yMFM2RUhxWVdk?=
 =?utf-8?B?UkZYL1pJTVRjSUFZdlpxejJtRWI3K2QwTWxXMWkrSWl0dmNSVXNHY1FVUDR1?=
 =?utf-8?Q?IfPld++8q66hKhIzPE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8406134e-85ef-40f7-38d2-08df0d0d2004
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 18:23:33.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFJdqG6Nl7sALPaywhn84YwutLo/Pu4dBo+nGKqt9NwhCt0W35vjuhwsnLixcy6QTGtbu5crcPS5KkomInJX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562

On 9/7/2026 6:15 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Bypassing the cap_mask capability check blindly assumes all requested PCIe AtomicOp sizes are supported, risking Unsupported Request (UR) errors.
> --

In a headless topology with no root port, the hypervisor owns the device
topology and is responsible for presenting it to the guest. The capability
mask check is not bypassed blindly — we rely on the hypervisor to have
verified AtomicOp support before enabling the Requester capability. This
is consistent with the existing trust model for passthrough configurations,
where the hypervisor already controls which PCIe capabilities are exposed
to the guest.

If the hypervisor enables the AtomicOp Requester bit without verifying
target support, that is a hypervisor bug, not something the guest driver
can or should guard against.


> commit 23f7770048aa6bf9d34e0cd8e0687398f5697661
> Author: Nikola Prica <nikola.prica@amd.com>
> 
> PCI: Accept AtomicOps already enabled by the hypervisor
> 
> This patch modifies pci_enable_atomic_ops_to_root() to support passthrough
> guests in headless topologies where no root port is visible. If the hypervisor
> has already set PCI_EXP_DEVCTL2_ATOMIC_REQ on the device, it treats AtomicOps
> as enabled and returns success instead of failing the topology walk.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f80..62729ade496fc 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>        }
>>
>>        root = pcie_find_root_port(dev);
>> -     if (!root)
>> +     if (!root) {
>> +             /*
>> +              * A hypervisor may expose a headless topology with no
>> +              * visible root port.  If it has already set AtomicOp
>> +              * Requester Enable, there is nothing more to do.
>> +              */
>> +             pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>> +             if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>> +                     return 0;
> 
> [Severity: High]
> Does unconditionally returning success here bypass the capability mask
> validation?
> 
> Guest drivers (e.g., bnxt_re, amdgpu, or vfio) call
> pci_enable_atomic_ops_to_root() passing a specific cap_mask to probe whether
> certain atomic sizes (e.g., 64-bit or 128-bit) are supported by the routing
> topology. By returning early, we skip the cap_mask validation against the
> root port's DEVCAP2 register that typically happens right after this check.
> 
> If the physical root port only supports 32-bit atomics but the driver
> believes 64-bit sizes are supported due to this return, could this result in
> PCIe Unsupported Request (UR) errors and potentially trigger fatal Advanced
> Error Reporting (AER) events that crash the device or VM?
> 
>> +
>>                return -EINVAL;
>> +     }
>>
>>        pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>        if ((cap & cap_mask) != cap_mask)
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907161701.454364-1-nikprica@amd.com?part=1

