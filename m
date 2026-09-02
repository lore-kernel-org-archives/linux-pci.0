Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AA38A715;
	Wed,  2 Sep 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373197; cv=fail; b=RKuIRY8F2NGvnCiTUyl1RhGsRfjtXm1Py0n242RFRMAG98Dyv9+qKmNjigTnhYGR6WRIF++gYrLqIUvWNmWmwYaIP3639Js7PUMXNMAEsr0QOJqLnwXcPduvkTsXkd7+17ml8V8K2rlZpF9UQ/PUdoyR8JXFJ7JoRcsD5GzHx00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373197; c=relaxed/simple;
	bh=Know29qZ3qHbRMwPBJ2/9jz/x9/810tNLB0r6VpGJ88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XwBUbpdhgVSmAylV9VawvH8XOKKQJjoqpGIeqpjqiN6HtLOdyF6s2tDsC3dJgUlsX3g8q9worRVfBtSO6oEPVt/ujd6qUQOoBaNk8mslAYr5TFsFUU/zkhU9DBwixMsp9PYnxFWCG9UtlptxkE+cfWd9LVUhEoIJ16lo93W8uYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gkn2f8Kk; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gkn2f8Kk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REg7UHgHEuxfMxHUvnY7JbcIeADLDTdQaJmQm0RSygfovFyEcRK/aau1aotZPCfCVw1EPamtTZhUInHnu9KzXwNL/beuoMQEMRXp2di3fYOh0C4ARJFSAe7XQcC90HkeCPv2DD6IDl4X7nc0/tRaXFzarNXIl82ZHKWSb8WCgWPcLyOP/iuYRrAyG5q7FP54dIqHe8HLaFRKn9cD6bzeJY6reFUvicl4XTAtnvccMOZJv6U+Gm1hTBS+oOIEoZaPuCKfIFGFv351IJgC+f/judzCzvKS+cwBwAJze/SDXfndVWjOQFmaQIiprY0iL1kK4i2D3Oz0tUcv50UckBJK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Av5VMYwgfvClF4A1t/8q3RLS8TIC/AcdEu0bShCNIg=;
 b=cdR5bn/AmJkZmnNyFyT3eR+LXBqbX56dtCLqC5Bm6wa2tlSCcdW5r3zb7AeCK2Qu5M6cDP6exmL/7Z/4tlFM6qk7zaPZW/lUOEWNHBxxIv5nP1UVfWb9GS5d1w3oXgN7f7rRZc6L5RmRcVUlLhAd4ZV2ue9K5L3saMqWNfsWg/vjeg9jiNCdsDzPHrha7dFDgPi75rilEztE/PHvwM9gDbXDEFUk+2hwKUZYy+J8mUm2VwIWQr+q0o4tus8BvV+R/q/7JDttRjTuaD5pNm5A+sg5ud7e3Nf9l1TCeuS5BJ2F753TDEM3+wPjoVFBR7SP4EI2qPO+o86NyY2EVwpJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Av5VMYwgfvClF4A1t/8q3RLS8TIC/AcdEu0bShCNIg=;
 b=gkn2f8KkPteCDwzQUScXEcB0ArsnJObOD9A7FqWUKoMSx7Nq9zabkINPoNamt00ecEHnvkqIDOtPxXayZpxGnwDAPBC5FwIJ6PcdNKROLYPys7LbSPwzU9ffvy1HvHIIO1UpPis8fQ9nHCF9Usy40ZPdA6yIpAyzbIqiYQex2II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:19:51 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 18:19:51 +0000
Message-ID: <f077b7aa-0f54-42d0-91aa-e8b021d4f787@amd.com>
Date: Wed, 2 Sep 2026 13:19:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 5/9] cxl: Update CXL Endpoint AER handler
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-6-terry.bowman@amd.com>
 <20260902140511.46F1C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260902140511.46F1C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:8:54::35) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 119e2f37-6f9a-42d5-69c0-08df091ec778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|4143699003|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vk+Qgjwe/1E87hIQH/+eLMvirEm7vwK6v+Pq3ei1HmsfxEW7zXbQPiKC9Kzo4Ykm0NwU1B7fA9HTMDudHNK0ePXBB/i4tce+hp2gc36DXhsNpNRbPTBranKT8IzvhVdPoMaoh3kMZnZQa11ZPfdV+N4B8ZFrVvPaNm6NYdNvgRsnQPkCq4j3h/1L2R8gwVLFHFFv3N0JVYDBdYBv3Kku3XvN49kIgHlVRnkODW8ObZgoVQHxd06gk63XGCLcV15H/XPMZuSEQo4JFyBMR/lx9Q+8JcwZLri0GIxp7UhMm0S91YKeAG3M9SS+ehXN5/cmTooP4gEp9ZXXAzMYETqL9GATat8ZStuXAhGgPruX5EjYm5Vmlzdz6Yi+P3Qi7EAGFxO4/SQeH1goXD0b3KBewgdfiSfmd8zmYMAT07pgCPfwKE+CfXXubmtUP7bzw4fwr/Bo4674ddL8JIUnYzSGxWJaFteTSlKFdV1itNNpcxZ58P8W/cJX+6u0+wTA+9M2MiEJMRDDU5Qg5G9DmSiHDc3G9ykdVA3OOMkPw37iS+jmkCX+LzU7NXBTuFC7MBBFpc5v4Tm/c1EtGx3wxZYUWMZpwqAbpfAI4YCfcYTSg4GxYngFYx2qcqTq/gle/M9N5y/EdcAiiYpO60wWHXBEoZk0SlPstJbQGyWecz7aKY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUg3TkVtMFZrcDJFSWRjc3U5aUdhVk5UeEpiTmxvTTFrU1l1REpyR3RLblhR?=
 =?utf-8?B?K2dhMnJKN1pKRnBoTFN0VUI3RWJWZllUNXIzQmtFZEFBL3V4aUhKblJ6ZUEw?=
 =?utf-8?B?aGdEeWE4REZaVk4zQWxCRmtrU3pRcmVhcER2cnhJcjZXOUlkVDJwaTVnOXVW?=
 =?utf-8?B?eHNVWStDa3JvYm9LRmNGRnBGRktFYU45V2NHL0xjMUl2eUdlaTV6bUt3cGpV?=
 =?utf-8?B?YVU4bWtEU0d0ZWk2RWtWMnZuWCtZVjN1cnNMdDJLOTRmQTJQY05RRzRKUzIr?=
 =?utf-8?B?QU10NnVLOGN2Nk9IOXZwOEt5a3hEaUMzaWdGZWJHbitCbGl1bS80ZnNmRkVK?=
 =?utf-8?B?eVRyV0lDaXV3VE55eVMyTUtDRHVIaVVaNjlYWHNJSWVOQnFIak9oWGo0U0Nv?=
 =?utf-8?B?bmordzJIUkxmZWpCcWs5T1kwWmVVMlFMckJVMGRXUmF2TFFFVkJ5QUZrWDZ6?=
 =?utf-8?B?Wlo2MUpSc3VSc2FwWUJQSkNKbjIreFV5ZExnK0VPcm5JemxOUEdMcFI3WmpZ?=
 =?utf-8?B?ZWNKeHBjZmovVU11WUJPTnkrbHpMQVBmZk9XdGR6WEdwK0lvMTJuQlp5eGpT?=
 =?utf-8?B?V24rTTdvOXN0R01iVFgwd1RvNWI1a0V4YkhJZi9EY0p1aHFMZysxb1prUm1s?=
 =?utf-8?B?Y1UwTno3Tk1NT29jTDRFSVpiWFNmVzNtZ3lrUlBQK1ZhSGN4UEU1ZDBCZUty?=
 =?utf-8?B?cW5jZXVGOE9najhFTldTMGVYTnN5QkJTOS9LcDExZVJnWmYyZ3ZzcElqRmZL?=
 =?utf-8?B?dFAvT3NvamUvR1poQXphZHQwUElDRTZRTmc3UXdCL3FkVC9oQjRiQTV2cFFP?=
 =?utf-8?B?S3NHNEIxT2xTR0hnRXk4Y1FVelptRGY3VnF3cCtEQ2I2WFBEVnlkSjA5Z3Nk?=
 =?utf-8?B?Wk1nUFl4ZEVzS05CVDE2M0JSTFJJTEUvb3V1THd0K1djZjJEcDFFeE80elM1?=
 =?utf-8?B?OVcxOUdENzZzZ1lEU05tcTVCNzF4VVV6cStxbzdqQjk1WmVpTXpWekQzL0xk?=
 =?utf-8?B?czJtZGFQWitmWjFxK05jcjljVE5lRlVhTGZHeXJwSkhXa2hROExtOWt2cHNa?=
 =?utf-8?B?K1Z4T2QvMVFVeXRyV3l2eFZvMFVPZFp6YlRyUDkzQXEyV3kzSjRsN3dncEJ6?=
 =?utf-8?B?K0R1UFhSanNVSGZLVXdMZ2taNWFDM1Y1MjVCNnc2QldLZUdnM0lMMk5GWGd1?=
 =?utf-8?B?K3k5bTkwKytYNlhrTElnZHVGMnZkNFBQODJFalBGRG9Oby8rTXFiY2xQZGhT?=
 =?utf-8?B?VkJ2RDdLRnFzbzFyNnZlcC9SQnJQRW53Z2JZV1Y4RlV4MTdzYUNqUDB2WmEx?=
 =?utf-8?B?emU3WmJVRDlhSlJoVHZFNlRaYW5IbWEyL1JsdkRQQ3dvRmROdE9YVktzQ0Qx?=
 =?utf-8?B?em14b1FPc0RpYzB6Wmh2RU80aGhZRkR0ZHBCTTdQWCswdldZeXVpcjBVRjJQ?=
 =?utf-8?B?NmdtOGlqcXJ4QW44TjdHNXRyaFJ3cUNiMG1ZNjFNTExkZ2hvR1JNbnA5U3hG?=
 =?utf-8?B?RjFXTjNyOEwvMVdLMGRVSTFmaklVQXlVTHp0WWp4VVVPeDRqV3lEQ25pdm0w?=
 =?utf-8?B?eStZblp1VHFLKzI1ekVNRkZhdkxka08wKzk4Q2IrbjRmQWZBSTR1NytVc2Nj?=
 =?utf-8?B?cGRNcmMzdzk4RjRneXNja3FIMFhWaEgzODB0OXlCQ25qZ2RrdTVLeG8xZHlT?=
 =?utf-8?B?U0xkVEZwRk5ERHRNMjZVdTJOa2E2UUl5M3dQeDU2QWIyNlJyWjJnTlpqK0tK?=
 =?utf-8?B?WXJyVzRaeU1NSkhQbnFmUDR2SDl0c0N0SG1QUW9lZVJ3WXBCRi90MXI2U0RZ?=
 =?utf-8?B?MHVZakQ3RWxFOTVuNlRBYk9vYUhvUnBsNnpCa0lxMkZBUE96ZGN4Vk5KODBR?=
 =?utf-8?B?dWVmWW55Z2xNcWZLenRtbEx5ZlJycy9vTUtuZkhTVjlCTDhSSUI4ck9GN3dq?=
 =?utf-8?B?eUhwQWVhQ1d3YU5tNVM5MHNjQ3pGcXpDRW80U2xBMlhQN1pXNWlMSm9TT3hK?=
 =?utf-8?B?eE5GVnAvVC85SFpmbXVzTFFoNFZ0ejdyR3ZKTHBXZFNxcFl2OXpiZjlwUzJX?=
 =?utf-8?B?RW8zek5jbml0VWVjcGgxcnYwWGRpZnlHZE95STMrSnhSdGZsS3hnWHNUS21k?=
 =?utf-8?B?Nm1FTExybkxvdVI2YkY2L0FXM2RBY0c2cW1qZHFkaXNPVDJkV1kyOElWZVor?=
 =?utf-8?B?RXExa3dSUERFWkhEM2ZzdXAvWlAyQzZ5ZmhVcUR3WlZwaXl4RGxDTnd2Wnk3?=
 =?utf-8?B?enRheGVGcVcrS2JaaVo4eERGUGZCcHlnQ09FM3ZEYWw5Q25iWE5VUFp3bDRG?=
 =?utf-8?Q?m2HqFc91/3zP7h6SQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e2f37-6f9a-42d5-69c0-08df091ec778
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 18:19:51.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvbA1xWjwPpmvEatsrjwnx09VWs8y/yAvLjtrMtNY52diaqw6wXvWmLEEphnKLcZlU51uWlexqgii/sQcZPq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

On 9/2/2026 9:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 

The following 2 "new" issues are invalid with reasoning provided further below.

> New issues:
> - [High] Self-deadlock with PCI AER core via device_release_driver()
> - [High] AB-BA lock inversion between PCI AER core and CXL port uport_dev
> 

The next issue is valid but "prior-existing" and I recommend this is addressed 
later in a separate follow-up submission.

> Pre-existing issues:
> - [High] Undefined behavior and truncation on BIT(63) during dead link RAS handling
> --
> 
> commit 2f0ed965e221155153683db0b8960c5aeb8afd4e
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> cxl: Update CXL Endpoint AER handler
>     
> This patch renames cxl_error_detected() to cxl_pci_error_detected() and aligns
> error handler names. It also modifies the RAS read policy to be unconditional
> and documents the behavior on dead links.
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index e307361bb39e4..bf479fac08565 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> 
> [ ... ]
> 
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> -{
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> -
>> -	scoped_guard(device, dev) {
>> -		if (!dev->driver) {
>> -			dev_warn(&pdev->dev,
>> -				 "%s: memdev disabled, abort error handling\n",
>> -				 dev_name(dev));
>> +				 "%s: port disabled, abort error handling\n",
>> +				 dev_name(&port->dev));
>>  			return PCI_ERS_RESULT_DISCONNECT;
>>  		}
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(cxlds);
>>  		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> +		 * The CXL RAS uncorrectable status is the only signal here
>> +		 * that the error is a CXL internal (protocol) error. A set
>> +		 * UCE bit confirms it and triggers the panic below. On a dead
>> +		 * link readl() returns 0xFFFFFFFF, which sets all UCE bits and
>> +		 * triggers the panic intentionally.
>> +		 *
>> +		 * If RAS is not mapped the read is skipped. Unlike
>> +		 * cxl_do_recovery(), which is reached only after
>> +		 * is_aer_internal_error() has already confirmed a CXL internal
>> +		 * UCE, this path has no such confirmation, so an unmapped RAS
>> +		 * block cannot attribute the error to CXL and must not panic.
>> +		 * The switch cases below then handle AER recovery.
>>  		 */
> 
> [Severity: High]
> This is a pre-existing issue, but this patch explicitly documents that
> reading the RAS registers on a dead link returning 0xFFFFFFFF is
> intentional.
> 
> If readl() returns 0xFFFFFFFF, inside cxl_handle_ras(), hweight32(status) > 1
> is true, so it evaluates:
> 
>     fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>                        readl(rcc_addr)));
> 
> Since the dead link causes readl() to return 0xFFFFFFFF, FIELD_GET will
> extract bits 0-5 and yield 63. Will evaluating BIT(63) trigger undefined
> behavior on 32-bit platforms and silent truncation on 64-bit platforms?
> 

I agree, the analysis is correct. On a dead link the First Error Pointer
field reads 0x3F (63), and BIT(63) is undefined on 32-bit and truncates to 0
when stored into the u32 fe on 64-bit.
                                                                                                                                                        
This is pre-existing: the fe = BIT(FIELD_GET(...)) encoding in
cxl_handle_ras() is unchanged by this patch, which only reworks the
surrounding comment. It's also diagnostic-only - fe feeds the trace
first_error field and has no bearing on the panic or recovery decision (that
is driven by the UCE status mask, not fe), so the dead-link path documented
here still behaves correctly.

I'd prefer to fix this properly in a follow-up submission rather than fold an
unrelated fix into this rename patch. Something like:

    u32 fe_bit = FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(rcc_addr));

    /* First Error Pointer is only valid within the UCE status field */
    fe = (fe_bit < 32) ? BIT(fe_bit) : 0;

>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
>> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>>  	}
>>  
>> +	/*
>> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
>> +	 * silent data corruption.
>> +	 */
>> +	if (ue)
>> +		panic("CXL cachemem error");
>> +
>>  	switch (state) {
>>  	case pci_channel_io_normal:
>> -		if (ue) {
>> -			device_release_driver(dev);
>> -			return PCI_ERS_RESULT_NEED_RESET;
>> -		}
>>  		return PCI_ERS_RESULT_CAN_RECOVER;
>>  	case pci_channel_io_frozen:
>>  		dev_warn(&pdev->dev,
>>  			 "%s: frozen state error detected, disable CXL.mem\n",
>> -			 dev_name(dev));
>> -		device_release_driver(dev);
>> +			 dev_name(port->uport_dev));
>> +		device_release_driver(port->uport_dev);
> 
> [Severity: High]
> The AER core calls report_error_detected() which acquires
> device_lock(&pdev->dev) before invoking this driver callback.
> 
> Because port is resolved via find_cxl_port_by_uport(&pdev->dev),
> port->uport_dev is identical to &pdev->dev. Will calling
> device_release_driver(port->uport_dev) here unconditionally attempt to
> acquire the exact lock that the AER thread is already holding, resulting in
> a self-deadlock?
> 

No. For a CXL Endpoint, port->uport_dev is the CXL memory device (struct cxl_memdev),
not the PCI device the AER core has locked. 

The AER thread holds device_lock(&pdev->dev). The Endpoint Port is hosted on
a different device (a child of &pdev->dev), so port->uport_dev != &pdev->dev
and device_release_driver(port->uport_dev) acquires a different lock. This is
true for both VH Endpoints and RCDs.

>>  		return PCI_ERS_RESULT_NEED_RESET;
> 
> [ ... ]
> 
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index e0e01aa5eba6c..bc6cf50fcc926 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
> 
> [ ... ]
> 
>> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>> -{
>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>  	struct aer_capability_regs aer_regs;
>>  	struct cxl_dport *dport;
>> -	int severity;
>>  
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>>  	if (!port)
>>  		return;
>>  
>> +	guard(device)(port->uport_dev);
> 
> [Severity: High]
> The AER core executes cxl_pci_error_detected() with device_lock(&pdev->dev)
> already held, which synchronously calls this function for an RCD.
> 
> For an RCD, port->uport_dev resolves to the ACPI root or host bridge, which
> is an ancestor of pdev. Will locking this ancestor device while holding a
> descendant's lock create an AB-BA deadlock with concurrent device removal
> operations that lock from parent to child?
> 
To begin, RCD doesn't support hotplug, so the concurrent removal this
describes doesn't happen in practice.

Beyond that, I think this is looking at the wrong pair of locks. The concern
assumes an established parent->child device-core lock order, but the RCD
pci_dev is not a device-core child of port->uport_dev (the Host Bridge).
They're in different device hierarchies, PCI bus vs. CXL bus. So there is no
parent/child lock relationship between these two to invert on removal.

For a real AB-BA we'd need a path that holds the Host Bridge lock and then
blocks on the RCD's lock, and there isn't one. The Host Bridge lock is also
unavoidable here, since the RCH Downstream Port's RAS/AER registers live on
the Host Bridge, not the RCD.

-Terry

