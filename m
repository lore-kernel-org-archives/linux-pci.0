Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413333E009B;
	Mon, 20 Jul 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559732; cv=fail; b=nbdmTALmVqb8UNMBBt/p/YmttkzG912Ar1iObm4pm+yXZ5thYNO/lCyiNi679HSG/Drq9P819ciavvDPnM/jDeyj3AJ5dJ1P5g0xNlFVtKfM4FILjojvG5QywxjcCs93HTlfGRgL8QuaE/9WrxEG7MKsguPvHLjBhouuGGvi1p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559732; c=relaxed/simple;
	bh=+J8d8lOgaywum5D7CVqdLC6y+hnlin0mDySFTNcPW1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBsEQPOH7ZtfMPo/7Nx+apcZEfZ/ql7Z9csh8eWewu4ggmoYFOZcPVYVsiWdgay99Z7y0g3djCti0VyGPXAMgSJpVnd5OD0fL8VsgwfjrVY3HpXTERC2hQ5rvOLU0tUUeQNuV+KRDoSZx3lCsMwgox9IgFnZnfbkM0Q9LUV2Ajs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gT5As9+l; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gT5As9+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcidUobwNv99KdhOB8IxVBCCt3vQm8isoyQbL21Iw+HtWPLbqMLMQgQJ3IAvg2jX3rEqa9Hp9+utT/NlRDZPmrHMjRDfL3WgxvwXJlZDA1IBtxFaU9jloDxg66rWIBH90M0e7M6l6VMYr8R4jzm5JApFHcKjYNB+EHWl5mxGyZwQwphwieR7UsxYYH/D1bdriu7yWz7Zw/FGCtwiPEpG9nTZOvUZkCqv7Cc4BHdeH7JfqX8OYtwRg+/aRdqa/t71dnTfrI4tXFQConnWV5573wsW9alkeAgilJvzQA226tYGzNGB7IpUZqVlx2cd5e70IQDcGgrTpA3lijmYXToxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCXOS53iIBaPABN0gvwdJdTyd7c1N9zNW5hQj1r/Z78=;
 b=eL+B2+zpp/D+5izDeGSqH9jE4vT5pQV/J48lcAZu9/reYsSd2w4Qvwge7xNLq62pgiY3+Vx+s/J/d5hJsF8LUuP4XDBfmCjEe7voVbefaDCyyw/Oi1BkG2/ZP64tp97aJ8A5c2ryqhnHDhi3pnMgJryz4NgaeC31YCN8ev4SSZMFZYWWFYqqFt8Jza0Q5jK7LoZDhn1BDVpTJMofNYLkSRr9nx+9LVsxb8xnCNW2YPROAlDGGu+DSH9YLYe/FP6fayW5nlNGEVzij5c5UvZsUxbQ3TtwOcAlpjyrxK8t1Oat17yskHl0ovZuSB1CB2WfmzZecFU2gErhA56cdLpDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCXOS53iIBaPABN0gvwdJdTyd7c1N9zNW5hQj1r/Z78=;
 b=gT5As9+lQBUwaNPxA8OVkKXp2LlW8ZVmyGJ84pu75aQjGmAt0/60/TV7HCC5Lur/FY8BTFI0zac+WbITxOhg/xL3EtUrKo3T25wemclTsaQnVuskftz8aQAoflZ1v7bSVFrUegopm4AZ44tBIbuDlf7NU3O+xm1sN/0lSwJUCgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:02:08 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:02:08 +0000
Message-ID: <e4e1bb5b-2cc3-452c-9499-d74aa41965e6@amd.com>
Date: Mon, 20 Jul 2026 10:02:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER
 work locks
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-3-terry.bowman@amd.com>
 <20260717224919.9F80E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260717224919.9F80E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0200.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::25) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: e51d2dd6-5953-4025-e4bf-08dee66fde5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ShSJGqsB0c4dXjwtF4stSaIXwd2cIxYxoNt9QihmkAS4Tr2rqQ5tdg9aWV7dj4OYd/mux12ea05XuA4lgRggC5TLIvokwDxFrbGKXCMFyGhPsXQMuC4PiIOLTSlAgIJhDbBJbHTalAmMpUkcCkKV1DmJM/8dLor0kTvlAybC2SoQ6envg4cxl3WY3jqIRXXR+NTtjww0mGazLkct2SMliss3XWQkCbJN+euZleBVbyCrwBA9FaTZ+tRDfXJjHSKZVEeiIWBSGKq6k/5K0lzYjALR50v+N4FxHAa9V0+WbpIRUa5nrpaFDavFT8xiDDpl0iSd8PyCRw3jhww68dgT8FF4CdVKGweYRs5gDQsv4CMPbcU45vd9Gz90ch7DpdfXVvXfE8B0G2FWJeuJW9LQPS8UUStYkxbyJR/jLxX4S7tM4ZrYAuYK3f8nDV7lWUpuwfIg032Rq+GcWYBKCeXYJcIzu9Jw3sK4im553EEbYpu5osNICq80DV+I0HoJ6FfBCFanTMGX86heV+08x/WhY5X+q7vVnEmdkl58hMsKSUHqAVx4+pPF7RkTFrODZ3OJ5sv7XAiGBkJMy9KEZracOOzvQ8nAPTlg2C6uca+TUtDfarwVicZiKn6ppiA8TWW251a4u/PiJALhyuuf+04IpM/aFhRshDnrzvSriF46ClQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU93blcvOGdmSHMvZG5DN2FpMEl6OTlBYWZVeElpWGx4ZDQwMGF3VzhabGRJ?=
 =?utf-8?B?M1NEVUl5cERuK2R5Qzl6NklCMHRJYzJuaEZVdjN5U21STFo4akM4eTNCc1pn?=
 =?utf-8?B?bEYyT2lsZWxtUzdQMFZYNUhTdEdBS2p4ZVUxaTAvUlc1QTErVFhzTDFLU2h3?=
 =?utf-8?B?U3lQck55MHpOQnRmVmNzOFNVUThuMm5kK1ZNVGlLRUR2UGNXYTVXUUJrV1A3?=
 =?utf-8?B?L1hYR0VkdWtLU3A3RFplTHZMODRtYytuZ0Z4L21vc3lPV2Zubml6TVdNQjFp?=
 =?utf-8?B?OTRCYW84dm5ZRlZHeStuYkVLb21TakdiNTZ3UndMNWhGZ3l4RDZZTkQxL0Vp?=
 =?utf-8?B?dEdGbUxsNHZtc0ZkZmt4UzNIMk8zR0NBV1UySmFtRjhTZ2w5dDBYMnk2NU1C?=
 =?utf-8?B?KzgxV09CUWZWMkhjTCtiTTdRQWdvT2E3UnoyTlhaRXk4dHpZWGtRMko0Y0dl?=
 =?utf-8?B?bjJxY2dibHRWSUNQK21wRzczRzl2M0VpdURORit3Zzc1aGRpUHdScGZMTUYw?=
 =?utf-8?B?bytncmtjUjlkbjBQT2RkMjZQTHZodHEwR3dLWDVpdmhlT1BzbTB4WXViYzVw?=
 =?utf-8?B?WmFoUjlnQXJmRFVTRzFHeUQrT2dqcHl2d2ViVStwSVJPWWJrN3RlczZRcVpQ?=
 =?utf-8?B?RTZMUHhCb3YvOUQzMk1PRTlzZEYxbWlmTk50dFY2Z2IweENaa2M1OVNZZkcz?=
 =?utf-8?B?NG5yTzcwbS9iV01md0J1b0pqVnFLeE5tc05QZkVTVTA3THoxZTVUS2ozVDU2?=
 =?utf-8?B?UjBMRldNSFdadlF4U3VzR2d1K1RoRnpEODJ4N2lvNjZ3eklsaWdWRzcvQmwx?=
 =?utf-8?B?SGY3bEM4aXpTeU5qbGk5YmszSUc4ZG52MDc3NHZEN2ZuMnA1SXJiSmV6RlVj?=
 =?utf-8?B?WGFuUitqOVhnaE5lc0F3QWlKT1lKUWxEcWhlN0lmQlpEMzZldGJrQnJIc2lK?=
 =?utf-8?B?ak5ZZ0ZuQmdidk9pSWJQR2lQa1ZTWVBKaVZYbkFiUGtRT2lEZU4xUlAxL1l3?=
 =?utf-8?B?WW5XVHQzZ1lIek5TamhMMWd1ZkIySlRaODY0MTB5K0lBRW93djQ5T0V4ei9v?=
 =?utf-8?B?b3FZVDE5ZS9MMnVKa2xtNHFHQmRNck94S25rc2JlcjcrbzVzMlhoSGJUSDFi?=
 =?utf-8?B?elhKeTE3emZ4Mm5EOEJ0dC9nK1habTMzMFFYOThpVEZMeGkwVGxmZHI0Tmd2?=
 =?utf-8?B?bzFPRUMvMEhsczNTMDJQWjdnWWJURU5RSWdPd2JZN2tMQ0FNbjRsVE8xYUtx?=
 =?utf-8?B?OTNwRGxxN3FmUEp6aUx3VVdWb2wyQ1dmcnNYdEg2S29KQkszNUxQU0k1Nlhx?=
 =?utf-8?B?Qmc0eDAzT3lEMnRSWGUxVE95N3FMZmE4dXpkSDgxVW5WVEtLV0pRYnppeW9t?=
 =?utf-8?B?LzZZazFyNS85NURkbldjd1ppcjBGa0p3RmdxYTFMS1psbDVEV2ZjNENuTDVO?=
 =?utf-8?B?UTYyYlBrUDNTVDVHZlE2QzJkcmVjbGZiN3FuRnJaTW1PYWphNTc3OWRJTnJj?=
 =?utf-8?B?Z1hpNC9oMjd5STVCTTNjMWtSZjZzY2U0UmxGVUdJVHZIYlRkVjZyNE5obmtH?=
 =?utf-8?B?Sk1KbWdCSnhZTmZtaXVJTW41eGo1MVZFeHdQT09sYXlrdXR2ZzQrK0hHVUR3?=
 =?utf-8?B?ZDdYSCtXL1ZmTCs0ODVGdmtWUkI4WWxVTjR4Y0tSK1RKMGpvZkgxcWtXSTYw?=
 =?utf-8?B?dnpjREZRT2R1VGxVZlFkNC9UZ0oxbVpFQlBXQUloOFFvZFlNNGovelNTRDNH?=
 =?utf-8?B?Qlo0aWd5N1IydUU2eVp6NHdpSXdUb25GR21FaGtOL094L2pacGlMU1kvenhX?=
 =?utf-8?B?bVlHbVdzZGtxRlREUkwrYzVaUkpmK1E2QmZxVVZ1VkxTelNrWUYrR285L01w?=
 =?utf-8?B?WnJ5UmN2L25DUVJlRDE1YlExWWpBVWZTYk4vbXhUU2o0L3BkVU5qWHZ5eDZM?=
 =?utf-8?B?YndBUXNaNGhENk9UU3FuT2Y3bGpEamYxWFd0UUp5OGQzc2orL2p4eUszU0Nj?=
 =?utf-8?B?bU5EUGZVdzFSRG5JZHhPNGVoK2FLRkg2Nnk0UmgwcUxVUjhKeEt5UzNablpF?=
 =?utf-8?B?SVFaVmlBZEIySkpya292TlJpS3ZxQktMUmNqV3BvbUN5b1N1MkgzMk5FanhX?=
 =?utf-8?B?YmZvZVVvYUpVcXRxako0eDZRQSswVjRjZ0RXanRWZW13YXpQc2NpcVVmblV3?=
 =?utf-8?B?c245dGZlcGMvRkhQeUJuSzMrQTFsQzM0M05iS0ZKS0krUGpMRGtrbyt1MUpj?=
 =?utf-8?B?NGxpalVZSjBsR2ZTN1VYSUYvYW5mOXZxcjlSbXE5dmNtUk5mV0JvK0pNWG5Z?=
 =?utf-8?Q?vaeZHe4ldn6G5Y4ZP5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51d2dd6-5953-4025-e4bf-08dee66fde5c
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:02:08.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkZceIDZ3KA9Mk3H0kKb3+C6XCumlEzibiSHuVeWul++36+4tyreoIfZP479HpFUtwNzN4stBfl84rRzBgajBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6


The LOW issue is valid and the extra cancel_work_sync() needs to be 
removed. I propose we fix if a series respin is necessary or otherwise 
fix in future. 

The preexisting HIGH issues are GHES area and to be fixed by owners.

Terry 

On 7/17/2026 5:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] The patch adds internal cancellation to both unregister functions but misses removing the redundant `cancel_work_sync()` for the protocol error work in `cxl_ras_exit()`.
> 
> Pre-existing issues:
> - [High] Fixed-size memcpy in cxl_cper_post_event causes an out-of-bounds read if the provided GHES CPER payload is smaller than sizeof(*rec).
> - [High] Missing bounds check on untrusted dvsec_len in cxl_cper_setup_prot_err_work_data leads to an out-of-bounds read.
> --
> 
> --- Patch [2]: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks ---
> commit 70fa064ce36bd35723148aab9a91c80d0fbef760
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
> 
> This commit converts cxl_cper_work_lock and cxl_cper_prot_err_work_lock from
> spinlock_t to raw_spinlock_t to prevent a deadlock between IRQ and process
> contexts. It also restructures registration functions to warn on double
> registration and clear work pointers before cancelling them. Redundant
> cancel_work_sync() calls are removed since quiescing is handled internally.
> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3236a3ce79d6b..ca7a138c1ff2e 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
> [ ... ]
>> @@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>>  	if (cxl_cper_sec_prot_err_valid(prot_err))
>>  		return;
>>  
>> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>>  
>>  	if (!cxl_cper_prot_err_work)
>>  		return;
> 
> [Severity: High]
> This is a pre-existing issue, but does cxl_cper_setup_prot_err_work_data()
> lack bounds checking on the untrusted dvsec_len?
> 
> If firmware provides a CXL protocol error record with a maliciously large
> dvsec_len, could this lead to an out-of-bounds read when calculating
> cap_start?
> 
> drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data() {
>     ...
>     dvsec_start = (u8 *)(prot_err + 1);
>     cap_start = dvsec_start + prot_err->dvsec_len;
> 
>     memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
>     ...
> }
> 
> [ ... ]
>> @@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>  		return;
>>  	}
>>  
>> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
>>  
>>  	if (!cxl_cper_work)
>>  		return;
> 
> [Severity: High]
> This is a pre-existing issue, but does cxl_cper_post_event() have an
> out-of-bounds read if the provided GHES CPER payload is smaller than
> sizeof(*rec)?
> 
> If firmware provides a CXL event record where gdata->error_data_length is
> smaller than sizeof(struct cxl_cper_event_rec), this fixed-size memcpy
> could exceed the bounds of the error status block:
> 
> drivers/acpi/apei/ghes.c:cxl_cper_post_event() {
>     ...
>     wd.event_type = event_type;
>     memcpy(&wd.rec, rec, sizeof(wd.rec));
>     ...
> }
> 
> [ ... ]
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 267c679b0b3c2..7c6faee7f85ed 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
>>  static void __exit cxl_pci_driver_exit(void)
>>  {
>>  	cxl_cper_unregister_work(&cxl_cper_work);
>> -	cancel_work_sync(&cxl_cper_work);
>>  	pci_unregister_driver(&cxl_pci_driver);
>>  }
> 
> [Severity: Low]
> Is there a missed redundant cancel_work_sync() call in cxl_ras_exit()
> that should also be removed?
> 
> Since internal cancellation was added to the unregister functions,
> cxl_ras_exit() now has redundant synchronization:
> 
> drivers/cxl/core/ras.c:cxl_ras_exit() {
>     ...
>     cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>     cancel_work_sync(&cxl_cper_prot_err_work);
>     ...
> }
> 

