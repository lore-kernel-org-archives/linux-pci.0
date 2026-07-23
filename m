Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB82F83B5;
	Thu, 23 Jul 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837009; cv=fail; b=IKMCEnweMiKL/fSkGkAj4NYUSiq9iiOXit6aD28kjxuMYNZ5DPZOVn3wyEp4+P4h/ocFU41voICqLJCpFfeOSigOxPVMq/VKDOeslzJJyO2Jfb43O5/bnMWpzSdpnaWCH1VcnMlKiHKvSwl/VAsVbc+dk9lovDLyGcjLzUMVLmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837009; c=relaxed/simple;
	bh=EeRREdHjx4BXT/KBtEL8LtZ6qmVFc+PlCJfDLbcxtVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObSC/G3P3tqR9mGnEpCLKAMnq3bqcIAo14/RWmKSztH3bTSiZ67ApmFMdb9/7cUZqD2NY8Fsc+lzoLRoNrTHa9USJOvhfTDNQnQiJo/lVg5fKmoxNaHcxumWwnWTd/OPZgBFzlsNILusmqCRKes2UceJc2xNGueEDlcF7nR2IEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vnz+LCog; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vnz+LCog"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVXzjCtcg7cvdiEIOlHuzrY1GCxYYnr2e/RJ4Viqtr1pVyD0yNcjtAM5rVkhtQV3LJBwpft58u5x/G1Cs1rzTYwJGXWDWtfoNk+vd6X/raEo8AeMiMIaMJwbqaLJbKH7TNiVdzu9bruKWRHovfghCKpCqhd2+XVfiJhl6NJ73Mzd+slXjb7OJ5jssHp9C5ur1soQ4T7TRbMBXxaOvxYkWNF2sKaijThBM3obBVK1Z44nBYC8CSwN27eAkvs5cqGlpRdAihB5tx/D375qhDNCGeMnnFyjkRQYSOqYTWopK+yBgGdsuhiakalaUJbzuWXlSbi3be6uVmouu0wz8eJ6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzjznGNaQAM8oo10culIEdTRNy+ruUC7se2dPYFQosc=;
 b=eYeCi9Ihty0/4x4GxWmREtUkSTIW+z4ALkJlO9wnL9wRs/fxARz8MypOCVFmnN0BWTRVlmcp0zZYnkD7gLUst7uZ6CCLhPSPaUKTzIZVUxR8bcVcmARwPRybsiAzhI57rk4cS4K1T9qv/+BafZld5a8I4FPGcdrXISCu3uidsN6PG0XrNF2sA8AWA3glSL3ZMvf6dZdcxrRsUnfddrD8Pp0uCGgcqTjQvCMmCQxmk9JP9vXjBA3t9TrMRsO4mi1NB3hPlPo+DO53t6ieAJRv63/YoOb+RgAvHFGwN/TYLuVRlY4rnGVMxaKxZYxnLrleu1epV6bVj5/E3c1I3TENgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzjznGNaQAM8oo10culIEdTRNy+ruUC7se2dPYFQosc=;
 b=vnz+LCogF5edT+VAMBE/8TkwvZdK/GKt/Tj/Dwahu5a/Vpac0faAiBcOEgpncvOTbDB7f75pMDaCegJ15DRFmGWyU7/LoiVDc5vGGeCVCHfwsbyUNAYmpVt889YXsjHk5XnESPu7GubwTZOseVAZj55ZGRRKOTvAFWccrLTJlAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 23 Jul
 2026 20:03:23 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 20:03:23 +0000
Message-ID: <7cbbd2be-f381-47c0-b94b-5a38978d68ec@amd.com>
Date: Thu, 23 Jul 2026 15:03:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
 <20260717224321.1BB411F000E9@smtp.kernel.org>
 <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com> <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:610:118::6) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5d0458-b433-4c2f-bc58-08dee8f57361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|5023799004|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	c5lrYci/Piwzu+2Yp938LqfhgOLJXzyiyQSOAT9UAV2WBXx4iur/CgTD7yGmUdsmWOVSt1iE0+06n756d4kQLV+LGjWs1KGr6MpX1qpwrsPv2VtxtaAoFLkFl8xQEYCG7lLZjhveYPeHYPWN1bzohzsDPnHg/MUtamOtFSnlxgraeBpJBIvaLimcE0WToJHf4bjH4qjT0hk/4yPE4zK91w+snXEbfHbmD0GLUjVrxzobfMjUzzGfnz4zjbta5BU96XVmnoFiP3bkulNQSSe5Vg8tFKRTfFG7TWNWXg+3X7G7s0M6sh02v3/ent85PGK84ybMgdKAxfNyGitOrSAxn2v9rT3j3WKE0QDNz1XN8+x+6o/dQIODiENDCzVgxiMScqNElFWUR6SvsuQ8Pq8w5DC2ND0HuhYIFp5jR7M0qGJdw8vfTpOlttIz4zIVGqJV67Mj/p0zM1z4hDDmTh8wK47vDNpL4u4S+pz45pb6o6qrky3TCnZY5U1Los5FcddzSNiSaO4VtYqQq7m4ZeMOGVLoU3Rpw7qp9R+SreH+cOdn2RPLvgafj3YcBn8zBI0mgp0LDIvgtVqNGSBYlgUI0lxIb0LU19W/qwFRhOWUlE0HcWeoMCr2fwbDomND29ZCjtoU1YWRBhbuGLNrNhLSxtofm7+/y6GTs2+cAMEQ62Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VKTG5lK0F0SDFoT1VGOGVJSDkybTMyYU5xb3Jtc0g2OXdCZmRIK3dUbCt4?=
 =?utf-8?B?cTFzS05QWmt6anhkOHNrQmRDUnNtQzNNWU01cXZLMFNkYXd1Tm83Ly8xSnFh?=
 =?utf-8?B?Rm5sVjI5VmJ2ZldnNDd3cUZUWHZtOEJFNlpiWDk5WnhjZnd1NDFaaHdRKzdC?=
 =?utf-8?B?dVlZS1F3WmFBNHlsUHlvTzRqQnExeFhwMnhxQjRFTzY4UmtsQVVxeDA5NDhH?=
 =?utf-8?B?SC9mRGI5bnIwY2RlM1NRSzNEQjIrdWxJa0ZUNkJZejZaUHpxZHIvMmYySFln?=
 =?utf-8?B?emFuT0JBWUM2NDRnVVl0ZmFSdlBtTHhTSjg2cDdRNUYwQjVuN3l0bUlXNDhs?=
 =?utf-8?B?MGVwaFZseFMveUZPSTBzaEdmR2t3V0pkblVvdTJYM3A3cWh6RFFpVjZTclJx?=
 =?utf-8?B?NDdmdlVlRUo1cElUdXIxR2ZTV1MzRUlMakc4VG5xQzdnTWdlS0ZVMTJCZmZx?=
 =?utf-8?B?UFZtREhOOG8xVHd1MGpGRWlOT1B1NUlnWUVadkhMZE03ZnB0ck5xV1pUYnh5?=
 =?utf-8?B?aDBYQXI4MUh5cDFBVVZZVkJRa0VOQVNKcmg5eFZYZG5qTmVBSXl1bVBsTGxj?=
 =?utf-8?B?eEJ2aitSNVNacWFqcXZBKzRZSHhhdnRXMWI3UTQvMWNpZUwvT0l6eWxKdHZQ?=
 =?utf-8?B?ZWlYN1EzU2xvR203a2VOQmpKeC9PVElLNFRWWjJGcFdyNm5QM0diTXVkWjBQ?=
 =?utf-8?B?YmZldkh5OGFSVnExdnNrSUthK1B6OFEySy9WaWplMm1hOXA2elgwbHZkc0lj?=
 =?utf-8?B?ZWpubUhOOTRNSWN5VzFrMVBTRk1KUWc3WG5TdWFhTkhjdTZ2WHVETnVDT1g1?=
 =?utf-8?B?dGFzWGpUM1hYTGtJL3krQ3lxWlMxRlVzTWJIbjJtYm84aFI5KzFMZ3hPWnJr?=
 =?utf-8?B?eUR0ZnBYTW13cVBLWXA0TFZNMml1Nmg3bE1jM1Vzc2Y1YkNZMGVicTdIUVpU?=
 =?utf-8?B?cnZuVTAyN1RUd0xxdEM5QUV5L3dKR1EraHVmQ2tsT0VOOU9MeS8xeS84cVBT?=
 =?utf-8?B?NWJ5R1A0QXlCajVqb3ZWTmlhUm1WcnZZYjY3NWphOUFaeEJ5dzZ4S3I5dWFq?=
 =?utf-8?B?THlJUUNyLzhDYTVnY0tlaXAySlJGVC9OaThxeElPYzJONnlNdloxSUJaaVU4?=
 =?utf-8?B?bFlFOFhTMXIvYmdlS0I1UkEyb0R4V0theFhYS1EwbXZnaWQzZVZSWE9GWi9T?=
 =?utf-8?B?ZHV3aHpmV0U5eUR4dDdzK2xYT052RThBMHVkMkV4UW1oK21zZ25qRXFRUnBI?=
 =?utf-8?B?QllzUWw5clFvVE56ZENqNjR1SmVZcElISGhlajNuNExPTkFuUCt0M0wyUXVp?=
 =?utf-8?B?amtZVnpHWkJ0ci9YKzRmUHNFUXFLcitkYmpLY05QdS8wUlUrMnpiZ3VNR2N5?=
 =?utf-8?B?NmJLUmR0aFphd3R5N3haenVaWnQ2d3krMU93cnprcFFXZmZjKzdvaUZuM3J0?=
 =?utf-8?B?d01MNTJUZ09mL3g3NTJmTVpiTU95TWNPZ3ltUUNkRjlkeTRYTjFPWkcrOUV6?=
 =?utf-8?B?SnBNdEdPbnpwUFByMUlrYnJXNHQvNWgzam9aNEpOT3c3WGkydXdrMVpmcEli?=
 =?utf-8?B?d2JucVk4eEFxdkFVUVNXSi9sTXBHK2srdGMvN0VneXBIVlRzbE9mQjVZUUw3?=
 =?utf-8?B?OEt4RWp4NHdwOGdzcVNpdDdBdTlMVTFrNXZVa1M1WFNkbVR1Y1dhV2NPWW5o?=
 =?utf-8?B?Z2FVSGJTVHhtTDVtMEx1L3BrQXk3WERudUc4aGg1NTk5bFczWHJwUGVzUmdH?=
 =?utf-8?B?VmdRZlVZbDZxQVpNMUhpQ1duV25ZWWRnM0c0TkcwcTdBS3E3YXNmTnd3TzZE?=
 =?utf-8?B?OFBJUXpoM09hb0NLTXFrbTNTZi9TdHRCd1BWN0tSck92K0FiSy9EcFphUXRJ?=
 =?utf-8?B?ZVNxVjNXMWx4YjJNQjEwTVJ0TjN4M28yblBreDI3dWRLUmdxUithR081QTd4?=
 =?utf-8?B?Z3hzL055ak1OenBCTUxmTVhGcHcwYTNuSllhaFJNREJ2b3M4WHY3UFc1NUIr?=
 =?utf-8?B?NmxyK3pXZHA4YzdWcVI4Qm1WNnFyQUpOWGdaYnFvc0FMd21TWFFra3FYQWpt?=
 =?utf-8?B?UHZ3R3JpRFpZSEhtUm1IakltUlB2K1NGU2VhRHZrWjVwMmJNVktkN01QSlEy?=
 =?utf-8?B?eURFdHdhMUFkRjhESXVxM3pnOVdZYmVLcjBMUHhOMWN2ZHZXM01VK1gvdjRl?=
 =?utf-8?B?cnhMQVU3TGU3RVNURVJwcFh2MUUzejlQdkg1UmFkKy9XQlBONlBIZkVJdVNC?=
 =?utf-8?B?c1pDb0NTbFN0bFVoYmw5NzQxZm5DcnZEaGxobjh4TDBwV2VPczF4dVBXc1hQ?=
 =?utf-8?Q?aJHXZmOPn3iAGvp/R5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5d0458-b433-4c2f-bc58-08dee8f57361
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:03:23.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrD6Snl32efBXy3sY3c4ndUeXmAzirRRrzEwGkbTc/4pJhYr7HBm3nE0gZLHGzmzFQDpmQ2amVducLJUiUEulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

On 7/23/2026 12:35 AM, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 10:06:34AM +0800, Bowman, Terry wrote:
>> On 7/17/2026 5:43 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [High] Removal of explicit PCI error handler forwarding for RCH devices leaves RCDs bound after a fatal PCI error.
>> This is a false positive. device_release_driver() is called in cxl_pci_error_detected() 
>>
>>>
>>> Pre-existing issues:
>>> - [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_find_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
>> This is existing issue and is not planned to be fixed in this series.
>>
>>> --
>>>
>>> --- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers ---
>>> commit 6a99c70b18865d01d350aa367342e701ebe6dde2
>>> Author: Terry Bowman <terry.bowman@amd.com>
>>>
>>> PCI/CXL: Add RCH support to CXL handlers
>>>
>>> Restricted CXL Host (RCH) error handling is folded into the new CXL Port
>>> error handling flow. RCH protocol errors are forwarded through the AER-CXL
>>> kfifo, and the manual CXL.mem error handler invocation is removed.
>>>
>>>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>>>> --- a/drivers/cxl/core/ras_rch.c
>>>> +++ b/drivers/cxl/core/ras_rch.c
>>>> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>>>  	return false;
>>>>  }
>>>>  
>>>> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>>> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>>>  {
>>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>>  	struct aer_capability_regs aer_regs;
>>>>  	struct cxl_dport *dport;
>>>>  	int severity;
>>>>  
>>>> -	struct cxl_port *port __free(put_cxl_port) =
>>>> -		cxl_pci_find_port(pdev, &dport);
>>>> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>>>>  	if (!port)
>>>>  		return;
>>>>  
>>>> +	guard(device)(&port->dev);
>>>> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
>>>
>>> [Severity: High]
>>> This is a pre-existing issue, but while this change correctly closes a
>>> lockless Use-After-Free window for dport here, does the same vulnerability
>>> still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?
>>>
>>> In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
>>> returned by cxl_pci_find_port() before any lock is taken.
>>>
>>> Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
>>> entirely locklessly, and then the function takes guard(device)(root_dev)
>>> instead of the required &root->dev lock.
>>>
>>> Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
>>> unprivileged local user trigger a Use-After-Free by reading sysfs during a
>>> concurrent device hot-unplug?
>>>
>>> [ ... ]
>>>
>>
>> This is existing issue and is not planned to be fixed in this series.
>>
>>>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>>>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>>>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>>>> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>  	return (pcie_ports_native || host->native_aer);
>>>>  }
>>>>  
>>>> +struct cxl_rch_error_ctx {
>>>> +	struct aer_err_info *info;
>>>> +	bool enqueued;
>>>> +};
>>>> +
>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>>>> -	const struct pci_error_handlers *err_handler;
>>>> +	struct cxl_rch_error_ctx *ctx = data;
>>>>  
>>>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>>>  		return 0;
>>>>  
>>>> -	guard(device)(&dev->dev);
>>>> -
>>>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>>>> -	if (!err_handler)
>>>> -		return 0;
>>>> -
>>>> -	if (info->severity == AER_CORRECTABLE) {
>>>> -		if (err_handler->cor_error_detected)
>>>> -			err_handler->cor_error_detected(dev);
>>>> -	} else if (err_handler->error_detected) {
>>>> -		if (info->severity == AER_NONFATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>>>> -		else if (info->severity == AER_FATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>>>> -	}
>>>> +	if (cxl_forward_error(dev, ctx->info))
>>>> +		ctx->enqueued = true;
>>>
>>> [Severity: High]
>>> Does removing the explicit invocation of the err_handler leave RCDs bound
>>> after a fatal PCI error?
>>>
>>> The standard pcie_do_recovery() on an RCEC does not iterate over its
>>> associated RC_END (RCD) devices, so this manual invocation used to handle the
>>> CXL.mem driver fallback. Now that errors are routed solely through the CXL
>>> protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
>>> panics on uncorrectable cachemem errors.
>>>
>>> Does the work queue replicate the PCI recovery state machine's fallback
>>> behavior, such as calling device_release_driver() to unbind the CXL.mem
>>> driver on frozen channel states?
>>>
>>>>  	return 0;
>>>>  }
>>>
>>
>> The change to forward CXL errors through Kfifo using schedulable work is 
>> intentional. This series does not exactly *replicate* the PCI handling.
>>
>> The device_release_driver() is called in cxl_pci_error_detected() for 
>> pci_channel_io_frozen. cxl_pci_error_detected() serves as the PCIe error 
>> handler for Endpoints, including RCDs.
>>
>> Terry
>>
> 
> Hi Terry,
> 
> I agree with you on this part, but what I can't find after this patch is the
> path that invokees it for an associated RCD.
> 
> you replace all error_detected() for associated RCD with cxl_forward_error()
> and queue CXL RAS work, what if a fatal case where it finds no RAS UCE?
> 
> It'll return normal and RCD driver will remain bound won't it ?
> 
> --Richard
>  


Hi Richard,

An RCD with a fatal UCE will call cxl_pci_error_detected(). This is because the 
AER core doesn't read the AER registers for an EP or USP with a fatal UCE. As a 
result it fails the is_aer_internal_error() check in cxl_rch_handle_error() due 
to the missing internal error status bit.

In your example the RAS isn't mapped, so cxl_handle_ras() is not called and the 
subsequent handling is based on device state. Do you feel there should be a panic 
regardless of whether the registers can be read? The policy so far was to panic 
only on confirmed UCEs. I erred on the side of caution with the thought that it 
could be made stricter if needed, and because an AER non-fatal UCE can potentially 
recover without a CXL.mem error. I'm inclined to make the unmapped-RAS case panic 
as well — the Port/cxl_do_recovery() path has no channel state to drive graceful 
recovery the way the Endpoint path does, and a Port can have live coherent CXL.mem 
downstream, so an unconfirmable UCE there risks silent corruption. Interested in 
your view.

You've also pointed out a real gap: I need to add back the RCH error handler call 
in cxl_pci_error_detected() for the RCD fatal UCE case. Thanks for catching that.

Note: the RCD and VH EP non-fatal UCE does get passed through the kfifo and calls 
cxl_do_recovery(). You were asking about the fatal case, but it's worth rounding 
out the non-fatal path too since it's separate. The plan has been to treat fatal 
and non-fatal UCEs alike with panic once confirmed.

Terry
