Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5E4AA006;
	Wed,  2 Sep 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365510; cv=fail; b=Q5dTFpdCtk9tVCjKNKEvqHtQu5c+5l6MWk7ca2iExdsbLN8q30SOGI7wtWFxqy4BS0oRpWvEj22z6pwxButcAHICAiS8bUHl9AELDz07fhEjnEgCuk3gGWiyzrdokGAMJyCAFsqTVwBP5+XNt8HNXNEH41KgWtioieQvfNnx6gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365510; c=relaxed/simple;
	bh=UfZi4xt+qaW2ArK5wET5ufqy8kQM6MMilWp5aMVuaJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jD3suWptipTRpuaMz+swx5M+eY1Qo93hCsm6g30+xdvC6ofQVd5UCxSjcuq0LcPt1IYgfUSWNMqP6uuYfp/egvsLbZ9G42PgfKTUgfypcT76xfu6kZnvyjhiIfjomkGy9u91kwXGhVEex+rWRB2HQ+5kNZp+wk8Ms1KhJWcWUY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vIpNP7Ak; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vIpNP7Ak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNZbTtB6nNnZcWWNH8TvoYtteahQqJ5098T3kLQf04ZkA8dybzIg0rt7NjpMrUJh37C7liN/lsJA0csRCKj8/TRkSQFzkxjKeOg+fQ3f5Nnln4EnK/oLvOhlQXN4Ftai5u5DyiLf1Y3rpcK7nC71FOCqi1Lr3ybFNbcM6Ifc/AUUYxAzaln4EuP/NNqeo1xr/UQCtuPZ6wgJb/oWcNh0o2TqisEr6HPkfXm0HtcUYBQ3MvL8MNZ3GC9i4P+huBX5TiHywaBQ15hE9LjMESJdtT95y0YIe+irKL+T+b9gJp4rs+TaK4Ht30rDnBGomplTCG6ssf1C19GxccYkOPdg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGwxH5hEAkKshkiI4lS6syXbpIxH0nHmop6PMt9aaV4=;
 b=v1iamvyWwaY+pul477rag4iFMi39jjkdSmHyVDVgAZpInfJzWm7SwdX4mlgFHOJCo8M/Z9S9PBtPBA801mNm0hSaHRBFlurE06m73cTBqQ07xUNwJzlNurkLeLB3Oo8FCU1IJ+z15+ua76tuvYg65o0vNlzRbaLkBUBSXOBzNueHsvZ4Uz91b4wE5/dwvB4WHwDXvrnMTWMNwRc74faU2He54ORflkAqxZEITITY5KkW788lA0wVQfCCRkh0YEyOiOa95pE+CdgD2YXWoJQOzH7Z9pGhc08fe+Qu0WfKCSasf/oNkHg48m9VC44Ul0LlXBoqz5DpjRdzE9vdIQUQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGwxH5hEAkKshkiI4lS6syXbpIxH0nHmop6PMt9aaV4=;
 b=vIpNP7AkoEki9dE1rn2sNPBE8ewxkdtDVHpdk1SSIeeXI7w/hOELZhnbSzHPp5CfxJd43GE3yG4m7oJ9C9KahCH3RktBy440/H4PVXWz+k14U4Bp7AiFEhmiKg4CYlXcm28+orXjfM/qeGx1LBDx01ScS5wXYp46QIDb3BrW+tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:11:40 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:11:40 +0000
Message-ID: <eb597d49-4484-4f6b-bfd9-1161afc558c0@amd.com>
Date: Wed, 2 Sep 2026 11:11:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error
 flow
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-3-terry.bowman@amd.com>
 <20260902135709.E759F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260902135709.E759F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 8023de8e-28a8-47f2-8ea3-08df090cdfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	f7e5U3CXyU9iZb+/BSoCuwiRxfYUsK/XWsUXpR2Lvso5a4Q/8HrRkR4Ww0MHAouDmRu3hnZspfZzYFx4fwEiuV61HlruoRR6SPvFmzbYOZBH1HnX6pJCTeEVrbSie3vtbcUD8Q5i52vbE7nN5B4A84boM1Ue/ECUH5J2INVz9OVZXeo12aGJ858H5ZV6YsZImxhpudhc7Y6pLiEGFwzS/2GcSIKBHEZ/rtCPUX3fhv6VRVq1qO4cv3Z1iZxPAhJrL5Fieq7EaFMnBuK3P8DGemi2yaV1zfSXuqOPtT7Y5OuoIvRf5RuN6qqHlgURziGjr9DbhPnaT1NyQj//Xj7DuZ6En68QhoAbTJbNyUHX+6qtRQyFE0+QK2AICpXC0uodGbqi5zSC4EJ/HLNEqbXIQzgO3IpQvjVoA2aZ4zcN6En+2eqbIqg9tal2NL0BB1DG6wZPdE4n+3a3JrRvS807sJAd9ZypDoLjEcn/M5O4sHIr/XigAkHUh5PqEwnlQlWjlIvxMK7M12Ct7OUK9Y6xUhSMDGBtvj86gIMVOHKX5rdg1ySiJ/ESa3wAxCm7GPYoly0zQSw9vJ6FxHI7slvfIX9siuH1BCK98Wizvb86uE7pdGij1x1OhLQocdK1+aVljLqiw2fySoZOxHV3AsUeXgU/TTl1712qzfcDladJxpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck40NXQyMFZPbVhSYnYweDAzNy9DWElpS0F2NVVrd0VBVmd0eXBKbHpJL0Zn?=
 =?utf-8?B?ZWIxMmhjd29KaEJaNW5pUXNUelh3YnFNUDc0Q1luaEpvTWxqLzUxaDE0MU5k?=
 =?utf-8?B?ZkpCT1FwdzgxMDNTbzlDSzNtZEg4QXpjTjlhdVBQOHRQOGZNRnVXWTkrZVlC?=
 =?utf-8?B?cllVWUNUTzV4bks4cGlBVmR1QkVvSkZXRzV5UWFjYjZqTENEZWxEL0dWZGU5?=
 =?utf-8?B?YlNNTXpSNy94cWIxUWVpNGZPYnMrS2hpdDlGb2pIRHVGcXhpUGJrRTBqZTBy?=
 =?utf-8?B?RDZuVXpXbTNBbktNRDhuQjhub0E3WnZnM2tMVkZSRFVXK2ZoNHZZejhuMmFk?=
 =?utf-8?B?MnN1TzFYcXoycHUxYjZOUURpZnRENnAxWmFoVEtlTllMTkJIS25hRFl0YXM4?=
 =?utf-8?B?ekJ3dnExQU4xOHdpRlVsNzYvNk9KK3Y1LzR5TzhoT2wvalc5aXM4SHRja05w?=
 =?utf-8?B?Tk4ySnBMSTlsMnkyVkVabWkvWVp1Y1U1Um00SFR5aTd5aStTQ3RLVTZOeGtZ?=
 =?utf-8?B?Mm14WEY4QUs0bUFEbjh4aG04eDY5KzZPLzlQOUwyM3ByMDMrYWNVd1Nacnc1?=
 =?utf-8?B?TDFEMTdidzQxRGczL25iR2ZNd21JNEtPMW1FZndGY1A5V2x0aUMvSFBic3pF?=
 =?utf-8?B?REp4WkZUVDd0Qmx0bFh2cFlvWVg1dTZxSElUY2RrbTA5NllZZTl3dXIxWEhI?=
 =?utf-8?B?VkMyYThoeERabHhhRGh2UDN2cEp5ZWt4SlBnMUxNZCtPcGh0K29hYlF1Q0RT?=
 =?utf-8?B?TFpQZ3oxdUY2TEJHVVEzYVEyMFNreU9vMkErNjh2ZFlsaFhqT2wyT04xekQy?=
 =?utf-8?B?V3F4cURBbHgva2FjclRGelZvZloxdmhSYkVSNnB2SDd5RjU5Q2hYUVpCR1ZF?=
 =?utf-8?B?bkNKUDdYSWo3L05TeHdJdE1hUGRVeDZDaXRIQWkzMFJ4elMzcGVGSTZBcEVs?=
 =?utf-8?B?VzNpN0Vrc2JmaW1oV1pjK0tJSEptcnhlM0puOVArajErc2tISHRUdmNMYTla?=
 =?utf-8?B?UWY5UUhFRkRGM1NnMzJldVNtMHBYblllYStyMFlJMkpZb0dLTTFzZElpeDJo?=
 =?utf-8?B?U3VLaHIwai9SQlltZmNxK1dMaTFYKzduNkZYZmVFM1dYdVVKc2YrL1VjdVli?=
 =?utf-8?B?MWI3SS9TREdsT0FuRU1icVVqS2RLZzAzdisyc3dDMlpyeW9sSlhPSW5IUVIw?=
 =?utf-8?B?SDBXdGw5eUpKdFhhVm5yY1p3UEZKY0x6b0RQaGZTYVhvYml2ZjhpRURycmRE?=
 =?utf-8?B?Z1ZUcUZmWTVpbFNIYzVIajVTTmNjZVg2MUhIVEZFU0xONHVNRkVITWNpTm5w?=
 =?utf-8?B?Y1U4YUV4VVMwWUNRek5uYm9telZQb2dkTHFPTTBFS3RaL1VhYnZSdjdad1Bx?=
 =?utf-8?B?bzB3NTZ0L3l2VDcrWERpU3VhbDJUZGpCdmFqZWE3a291YVN4UllqcXlDdERx?=
 =?utf-8?B?M3BqVytwQVdTaEdPOG13QnFUeFo4OHNYUlFoclk1dk9ZcVg2S0JudmovaTFQ?=
 =?utf-8?B?ekhtZ3RyS202a2dhcUREdWprb3EwVjNXakFUcjRXSnl4djlRZ3MwTXBQbnB2?=
 =?utf-8?B?ZjdPUDZmRFhRaVQ3Vk5sdktSS05GQVBjalRPaXRoZXNMK053bXZxWExNYnRv?=
 =?utf-8?B?N0xCMlY0YVZQZU5vL2lKYWxoeFJrMVd5ZWlET0tPUUswVGt5cEJVdllZZ0ZR?=
 =?utf-8?B?alVEZXMxbUwzUVJUbzNucm5lQ1RLSWhRWFIrbXd1dTBkd3hyQ29sWVVyVTVG?=
 =?utf-8?B?MWJaVWltQkRBY1J5TmtQT1JQdEluNVJIOXZrZ3pyZE5hMzQrR3BuMmUyODhS?=
 =?utf-8?B?aGJYUWlCMjRyMnh0dG9WSFR0SjBnUjQrSGVleE1SSXNRR1M2NElZcGJsTmVz?=
 =?utf-8?B?QVBJZU5OQTkvQng0Y2swTHVCeVFjVjJJTXMwMlZqVHpPLzR5c21zeVlYVWEy?=
 =?utf-8?B?OW5IcUtydjdzMlNiaXBMbUtrcHl1NEpFOTJ2VVd5OWM3Y1JJQVpHc0NJYWpa?=
 =?utf-8?B?bkFpYnRKVmVSYXFQeENVdEE3bWl0TldBY3FiOGtUYjM5U05pbGdGTG40bCty?=
 =?utf-8?B?MzBIc1hVUDB3RE1qL2JBMnI5RERsUTdweXFycGU5SjIzQ3hRdnNhdDBkWlRH?=
 =?utf-8?B?UzE0eFgySWJXUGV1Yks1eEhRRSs0RThaTjZzZGJ1NFJWUmFkbzloL0J4VnNm?=
 =?utf-8?B?UkJyVzcvVjJLdXBaUlVKR1RMTWt0MW04OXRxbWw0MDVRbTdZWS9OLytoZXlH?=
 =?utf-8?B?enZMbE1VVHlpZDJRWHlpeWV1OTcxeGlPMzl6eVVZcDJvRzBzNUh0VUsxV0V0?=
 =?utf-8?Q?PrPRTmhEqVtiCte9dr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8023de8e-28a8-47f2-8ea3-08df090cdfa6
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 16:11:40.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aw34UMRy2pudUDfw2d1P0ZUayCIZ36p/QANlmntxieuBtHRWdHOh7Q3ubgnD0+8rwRBSBLPOKs1rMUqVlaiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467

On 9/2/2026 8:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] CXL protocol errors on RCD Endpoints bypass the AER-CXL kfifo, leading to dropped correctable errors and UCE race conditions.
> --
> 
> commit 6e514f9fb46669ba2eab05ced2511b382df00bce
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> PCI: Establish common CXL Port protocol error flow
> 
> This commit establishes a single CXL protocol error path shared by Virtual
> Hierarchy and Restricted CXL Host topologies. It routes CXL protocol errors,
> gated by is_cxl_error(), through an AER-CXL kfifo to a core consumer for
> logging and recovery to ensure synchronization.
> 
>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> [ ... ]
>> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> +bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> +	struct cxl_rch_error_ctx ctx = { .info = info };
>> +
>>  	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> +	 * An RCEC AER internal error indicates an error in an
>> +	 * associated RCH Downstream Port or RCD device or both.
>> +	 * Forward to the cxl_core module for handling.
>>  	 */
>>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>  	    is_aer_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, &ctx);
>> +
>> +	return ctx.enqueued;
>>  }
> 
> [Severity: High]
> Does this check accidentally skip errors logged directly by the RCD itself?
> 

No. RCH and RCD errors are reported by the platform to the AER agent using RCECs.
SW must 'discover' which RCiEP(s) managed by the RCEC have an error.
 


> When an RCD detects an error, it logs it in its own AER capability and the
> RCEC raises the interrupt. The AER driver's find_source_device() then walks
> the RCEC's children, finds the RCD with the set AER status, and calls
> handle_error_source() with the RCD device.
> 
> Because this condition strictly checks for PCI_EXP_TYPE_RC_EC, it intercepts
> errors from the RCEC itself (like RCH Downstream Port errors), but bypasses
> handling when the RCD device itself is passed in.
> 
>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>> --- a/drivers/pci/pcie/aer_cxl_vh.c
>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> [ ... ]
>> @@ -54,8 +54,22 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>  	if (!info || !info->is_cxl)
>>  		return false;
>>  
>> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>> +	/*
>> +	 * RCD (PCI_EXP_TYPE_RC_END) is not included here because RCDs
>> +	 * report errors on behalf of upstream RCH Downstream Port and thus
>> +	 * require a unique discovery detailed in CXL4.0 spec (12.2.1.1).
>> +	 * The RCH device error discovery and RCD forwarding flow begins
>> +	 * in cxl_rch_handle_error().
>> +	 */
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +		break;
>> +	default:
>>  		return false;
>> +	}
>>  
>>  	return is_aer_internal_error(info);
>>  }
> 
> [Severity: High]
> Since RCDs are excluded here, does this bypass the AER-CXL kfifo entirely for
> RCD protocol errors?
> 

is_cxl_error() is used to verify VH devices and is intentionally not used for 
RCH/RCDs. Below is the flow for RCH/RCDs:

   RCEC internal error → cxl_rch_handle_error(RC_EC)
      → pcie_walk_rcec() → cxl_rch_handle_error_iter(RCD)
        → is_cxl_mem_dev(RCD) && cxl_error_is_native(RCD)
          → cxl_forward_error(RCD, info)   ← ENQUEUED to the kfifo

CXL r4.0 12.2.1.1 addresses RCH/RCD error handling and provides contrast
to VH mode.

-Terry

> As noted above, cxl_rch_handle_error() skips the RCD device. With the RCD
> also falling through to the default case here and returning false, these
> errors are never enqueued.
> 
> This results in correctable errors being silently dropped without being
> traced or cleared (as the legacy cor_error_detected fallback was removed).
> For uncorrectable errors, it bypasses the kfifo's synchronization, defeating
> the race-condition fix and leaving the system vulnerable to teardown races.
> 

