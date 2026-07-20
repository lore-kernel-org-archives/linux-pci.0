Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FE3C4B95;
	Mon, 20 Jul 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560002; cv=fail; b=pRNLiu7H9MRCAqI0DpLwcG6nPl0qrG21zgS6ZGEPMBKSDJPFpJS3YrcLYpNzXEbsUF0Eqj58mdr6pZjvfs/QJQUW/EzIewbMTjYswqAP54AqZfGo39nJSp+Hi6F0a8y5PfIrWBw/K/tzJ5R86dm/VX/ZS811PPkUXqyF0LjgcXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560002; c=relaxed/simple;
	bh=lGPmBCL6xJqD7cY+7wy/W7Z59SybRRswP0NlQswzocM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VdBcZ0b+kA294lQiavkZvq2rClKXiOy3rXi0PIhenwVLyQe3j1MIqmMp0KVx7fYOfwjkKSP2mg4I9qKwNN+XaeWU+8kO5cpNqIPURTUyQbCCDrnpMS1j6AnGEBLqLb2qCaRM/NtbjfG0RzoFP+N1DdCA1ju0pQD3/pYclMr3ojU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ADOCgQv1; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ADOCgQv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4F+uljPrNxPHrjrpjaVMuUj9OiiavmmCs2BpKfAaCahEIohYSbpoDfXs72D1pRPZrEir5nEvyDB6L9yhIceRiQA89DYU42PRtWOsXmxz7QDi3kysScxjCQv8UvXDCqOx/99VpLAA+QIOh4Ir8Qkjox93fHu+gff4xjCiBvQFlmJ+Sru4aFH0e0Dl6TD249/iueycZPsXC5T4ybG3WaJ5sWUj7HjIMNi4DiCkRBWXP7yS2KnFk7VPGndDvSM6JBaFeajYqT0j2lxvXBjIVuiQMkBH8820Rx78BEGXfSPKpbyJt7VKjFKAM4BLILmDCX2r/wGco5fl6HqY8SicDvzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPhINe9Wxr66S/UeQQ+im7wrkH4Zw2261Aou5vBdO1k=;
 b=GSzErZI/+v1SDXm9Qce8sYt0Hk1LGzt+Go4yAg6J2xwLLRd0IK9as33EQhewHkoqL932PN+TY59BwyzKYNBmWAlVLqgNn1yXVY7jwLDsZCl6BnzFZ/hlluK99KD41sQiO9ULWyATk1QPeedc5vAm3CDHwYQ3yUzWcoCkP214VazYRLooMbxZ5dLVShNXrNOEUhB82WY6H/WfaLQQyHXC24sEW/ffOibr8YPzb9yh5PODtQU0vbbtcsuglnpMByR7iUO5p+uDA97YiekI1rQVNUAXrr9jFbPRfYzIfuKbF29iG6vCI501n9zuiVI6K11UGDxxAPc4ax28fSjL/RVT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPhINe9Wxr66S/UeQQ+im7wrkH4Zw2261Aou5vBdO1k=;
 b=ADOCgQv152hHcx5XRM64pxDXbTuj54KPajCb/S1jNnVvpFds6fHjJ/dPjs2Z1ofcIy7H/bESbVmEMZN86PTbwL9557EoEsRGurjdsh+nEgMCenZnYPy31jBjemScs7z3on7+wvbRU3ZbDAk2T3B8SA9GFkCTlEeHHKzDcwJTEBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:06:37 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:06:37 +0000
Message-ID: <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com>
Date: Mon, 20 Jul 2026 10:06:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
 <20260717224321.1BB411F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260717224321.1BB411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 722e7b60-251b-4120-a271-08dee6707eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ydkWlPgH1c2RIOzk/KBMkUrusTow6ecgK2u6t1HzHbncIJ5OaE+UZPapvfLn4irYB2HUsJmR5KbVar2SmKAB51Xx9BVpy2Za0YWHAtPPb9S2tAZc/oKKZZZKKt6euaTny2JylbbqQ4qVkQtHI6UARvHf4li3adPxs5lLoWEUf08ffa2GZgQ4lMXyR/NF1Sb5U7vE3A39ETMolxH4wIUvXArg1VluvJBqjikxiiylBVMKc/EHTeJeJAGRvfdokgVR5oBJ0ooHxON1vx0GxsCftS9o4qLqsvASe40Evw3469kGzeroRaLryacX8KMIeTksW96YLEbtUp4CW+dFkD6yAz91h4bbf8Hsg/T4KNyrQvKff/h5lae+EhIEnpcRj+R6Svio0BtDG0MI4OajjUIk1UXjLGEkAwPPOs5KiVD0D94RE3GNhp+CXqBFeLbyvPVRfF4NU77r4GJnhaHfqj2RSYbvLDAPuj1oERkOumDjQJxjqcdz/5ChtJIQGe18fhksuPY/qDHoBh8w3bIdWgePYPtoaKkYnG1Dl2xVlNqixDfZd8kt/c5HK5SSTvIXaJ0EPQjbOPqL7QvSwpGpdl+nnpZyITeMmLfYFd2SJA+sw3Riuyv2b3ndr1Zkpbm/lNnfP5/zru7R7keyVOUQmnedaCXYzfS3EG8KrbT2iWyAR4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZvK3diRHl2VTQzRHphMUhqZHI2eWdaTW9CUlNOSkFQZEdWbDE2KzFZK01a?=
 =?utf-8?B?UTBoLzYvYWQ2Nm5sTFhyam10QnFLV2xMckZCcHhlQkIwUzBJVW4ycGhqNjZN?=
 =?utf-8?B?RzhUSStRcXNCNkF3MGExTVdxbzdLNDduRDdzUW93aDJUa2JXNWpETkplQmt3?=
 =?utf-8?B?bGNiZGNNQzhXSTBHWlFKQTNYVExZTk5aOEpkT0w1VHVSWkRXUzhiRkVQR1lE?=
 =?utf-8?B?S2NHU05KWW0rYmxONkJrSzIyZFlrekp4MWNZekJMV3dSZWFzZWk5VURaR0Jk?=
 =?utf-8?B?c2t6UEFraTYyako3UENIY1MyMHJwN3JEZVMxTzNpYXhrMkdWc1c3RFFrZkJl?=
 =?utf-8?B?cFFBOFZZV0FiVWN3cE9kSjBnL0VWUXZoL0I4NSt4L3ppdklGSVNNRHp5WkNu?=
 =?utf-8?B?TFBCU0VEblJDejd2VGR5UElna09kcVpET2ZybmhUcy9mdGpMeDY2c2tZem8y?=
 =?utf-8?B?VVliUTB0b3oxOFRncmRnNUZrVGtRL00yeWFCY1U4N2x1Mm9lakhaaWlEVmNM?=
 =?utf-8?B?cGZzRlNxNkFQRlRCeVhPMktWOTMxUDdRdHFzOG4zK0Z3M3N1WVJ5ZE8rZTk4?=
 =?utf-8?B?QWM0dkRWb3pYYWtGVm0yc1VPbkJIUnVVbW5IM05pZUc1KzN2OXRYRUM2Yzl4?=
 =?utf-8?B?ODlnNE50eVNpYmxlRGRqR1FiVFdCcVlCT285YjdjYlJQa1Z4a3kzRE53M3Rh?=
 =?utf-8?B?eWhNQldtSVRLeFBhM2I2aWoxWWpGaCsrNFl3YitoSU5JOHRxM3BvZ0plaHlI?=
 =?utf-8?B?N0dQekZLZlk5d2R4a1JDSUxvZHNXWDNaR2hVTEtkYWt4ZXNRYy9XelJ4Vy85?=
 =?utf-8?B?N1QzL0N4dVRXQnl6b2RDbDhwcm5TdiszUVc2UFpwWVFHQmc0S0ZNdTdMNlRo?=
 =?utf-8?B?QUs4bEtqVEhQcjBsNGd4TGhIeVNxdS94QW5oRWVtQnZLNjZuckdnc0J3YWpS?=
 =?utf-8?B?aC9rTkRjL0d4c1phS0IxcVd1Nms3OEdIcXk4RktJSWswREJySkJSQTgrQXNu?=
 =?utf-8?B?S3RqVjVYSUhJOFB4R3d2akpSQ1VHSkFHSmp0MDMvcHhyc0tvVjVTRUlzZlFq?=
 =?utf-8?B?RDdPZUkxVjZpMnNOVlBRU21PcW9vUy9HMTQ5Z1Z3Sk5tUmdSMHlBNUVVU1d0?=
 =?utf-8?B?d09QY2ZNc25nSlNBaEJ0cVZ2RExpWDg5UkNiSkRObXc0ZnNXUFdaQ2NCUExj?=
 =?utf-8?B?dnM0VEdjbWt4RmpzODdkYy9BQXV6UUtGa21YRFhqYlVENzd3ZGlkSmZ1MDZk?=
 =?utf-8?B?OVFjdVEvOWIvYnRPUnBtaVBaS3ZiL0pXR3dDQTl2T1JDcVZxNjBRMENlUVBZ?=
 =?utf-8?B?N0dHRDgrTzdkeDduYUwrYVA1djlRTjZKVFRqQ1BqRDJKeVpnK3ZiaTMxUFNM?=
 =?utf-8?B?TWI2akFxOVo4REZPVGdPRHVOMTFXQXZLSngzeGdtcmlremlXbW96ZjNDY1ho?=
 =?utf-8?B?cVI4dEh3VFlxbjhyYlVRUVVmT1BNd1oxSG5YdTlLUXlvcUYvYXFvdHpBWlZj?=
 =?utf-8?B?VE5lVmFlamo5aDFaYUVqRXhsQVFzaWJ2UElhZy9YL1hXbmlxY3BaZkZoMzV5?=
 =?utf-8?B?YjlIWkkzakFZeDE1ejYxSU95MWxRY01naDVNTlRJTnc1RFN4amZ3KzVvV3Vo?=
 =?utf-8?B?ejA5UURkeUJnRUx3TTN0OHlGK0xhQi9LbTQyb2FQOWIxWlRzNlFNOWZtQndM?=
 =?utf-8?B?anVBem5acUI2MG9mWDc2U29rTnlUNDcxcUJTQ0tidzFZc05zS295OFBqdXp0?=
 =?utf-8?B?WlMrcE9RaVJHbkdqMUk3ZktMU1lRWXhEeERDc05Sd0VDUUpyZVppWUlvRllK?=
 =?utf-8?B?MCs2WUkwMWlnTHNpYjVLcDJXNTMxQ1FlR0pqK3JVRUNqSEdoaW40dHFyN0ZW?=
 =?utf-8?B?V045R1VLQ3FuYWtWVE9rUTJIZ3ZxZFlLWTB6QTA1cnBwYjMvby9ySHB5TkRH?=
 =?utf-8?B?N3pCY0FEeVQwbG1vQ1BhdWlTdVVtNmdyZU5YNWlIREhsMHNlL1JyclBqUmMx?=
 =?utf-8?B?Wm5OUSt5bkQ4Vjg5YStQRUdDaGtXdzJMSVl6aUdMRnVQNkl6YmRRWWF6QXMy?=
 =?utf-8?B?T1ZEQW5TaCtlWHNSbnovSHIrbEJMNVFIZVJoMnNMeklBWkpMZ09yRE53aTFS?=
 =?utf-8?B?Z1pmMHExamNpZm95Wmo4bWxxak1nMEorUldaV2x5QmpNK01ERFdESlpsRkZW?=
 =?utf-8?B?cTBySDd1K244dUZ1RVA4U3BTWEFlbjEyZDAvTW1sZGxCYzNaTzd4Mjg0NkVX?=
 =?utf-8?B?OUs0TXVrQkl0NGRLMndyRHhCQ2xHb1ZzVmZYOWJVYTh1Y1p5SXZ3QlFSZUNo?=
 =?utf-8?Q?IR5HZLtfmWXSaJZj20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722e7b60-251b-4120-a271-08dee6707eb9
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:06:37.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gi6weYSBvZ8iEAGywLAKFdsFRqweRakBhXpDDKHhmhcBAJeawAYP7TU8Za2dPf8tQ13uL6fkESWB88KJ01nKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On 7/17/2026 5:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Removal of explicit PCI error handler forwarding for RCH devices leaves RCDs bound after a fatal PCI error.
This is a false positive. device_release_driver() is called in cxl_pci_error_detected() 

> 
> Pre-existing issues:
> - [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_find_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
This is existing issue and is not planned to be fixed in this series.

> --
> 
> --- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers ---
> commit 6a99c70b18865d01d350aa367342e701ebe6dde2
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> PCI/CXL: Add RCH support to CXL handlers
> 
> Restricted CXL Host (RCH) error handling is folded into the new CXL Port
> error handling flow. RCH protocol errors are forwarded through the AER-CXL
> kfifo, and the manual CXL.mem error handler invocation is removed.
> 
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>  	return false;
>>  }
>>  
>> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  {
>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>  	struct aer_capability_regs aer_regs;
>>  	struct cxl_dport *dport;
>>  	int severity;
>>  
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>>  	if (!port)
>>  		return;
>>  
>> +	guard(device)(&port->dev);
>> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
> 
> [Severity: High]
> This is a pre-existing issue, but while this change correctly closes a
> lockless Use-After-Free window for dport here, does the same vulnerability
> still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?
> 
> In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
> returned by cxl_pci_find_port() before any lock is taken.
> 
> Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
> entirely locklessly, and then the function takes guard(device)(root_dev)
> instead of the required &root->dev lock.
> 
> Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
> unprivileged local user trigger a Use-After-Free by reading sysfs during a
> concurrent device hot-unplug?
> 
> [ ... ]
> 

This is existing issue and is not planned to be fixed in this series.

>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>  	return (pcie_ports_native || host->native_aer);
>>  }
>>  
>> +struct cxl_rch_error_ctx {
>> +	struct aer_err_info *info;
>> +	bool enqueued;
>> +};
>> +
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>> -	const struct pci_error_handlers *err_handler;
>> +	struct cxl_rch_error_ctx *ctx = data;
>>  
>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>  		return 0;
>>  
>> -	guard(device)(&dev->dev);
>> -
>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> -	if (!err_handler)
>> -		return 0;
>> -
>> -	if (info->severity == AER_CORRECTABLE) {
>> -		if (err_handler->cor_error_detected)
>> -			err_handler->cor_error_detected(dev);
>> -	} else if (err_handler->error_detected) {
>> -		if (info->severity == AER_NONFATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>> -		else if (info->severity == AER_FATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>> -	}
>> +	if (cxl_forward_error(dev, ctx->info))
>> +		ctx->enqueued = true;
> 
> [Severity: High]
> Does removing the explicit invocation of the err_handler leave RCDs bound
> after a fatal PCI error?
> 
> The standard pcie_do_recovery() on an RCEC does not iterate over its
> associated RC_END (RCD) devices, so this manual invocation used to handle the
> CXL.mem driver fallback. Now that errors are routed solely through the CXL
> protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
> panics on uncorrectable cachemem errors.
> 
> Does the work queue replicate the PCI recovery state machine's fallback
> behavior, such as calling device_release_driver() to unbind the CXL.mem
> driver on frozen channel states?
> 
>>  	return 0;
>>  }
> 

The change to forward CXL errors through Kfifo using schedulable work is 
intentional. This series does not exactly *replicate* the PCI handling.

The device_release_driver() is called in cxl_pci_error_detected() for 
pci_channel_io_frozen. cxl_pci_error_detected() serves as the PCIe error 
handler for Endpoints, including RCDs.

Terry
