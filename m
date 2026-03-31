Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB138B7DC;
	Tue, 31 Mar 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983186; cv=fail; b=Gj/R+/NejACiltX4IUC/DT6YY4a+VVvyWiXoinpL/oa0/ugpsZtYgh6S4LjCBFra7XJIuOiGqbPyITMgBLZ0tvKFvfzMQr2gFtn0i4rt8Zgv4nQKILCvHCLnjxcNbF1/vsA+vqSMCIKtBSF/kMMBWRBFymw7wneu4FGYniAwcvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983186; c=relaxed/simple;
	bh=E65jzgh/mk0CaJydCeco6UJiYPHHgTJPtpJsrYW2Z8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qRe+Cz3cKuFHAwozcAu5SfO2BCu7oKaNHgcZC/1uM+dU9ccRMLhzgC8A0TTLUb+PswcBoR+33JXFCr/BhF106ZClRMn+p/v+h4GHj+uIFcsHGz6ImsoMVxpgr4Xs8QbD47dzWCo3LojVWcOAgY/j9bxZa5WCpqOcm9Z/5M4H96Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VcIw7+0w; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VcIw7+0w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHPAshsY3FSkwFYiNfJfBPcH7/4/XNtvC5T4t5zeGI2ewJ7z/DrgbdHi7qfp9punCSuNK0Va+QETfTRexUD9LS2N5zqQ/Zw7ohQeYUzttpke7lE2F8i1v5l8LtaKs6JH7TcvKia/m12YU0mNbohi+fGjFemfdYFFIUofEnGGYYvznuXEKKxGOguRlG5Z+tjkF1MtnhZUJttXpLFnbb7AckTVdodxhzF7JGxOEPGAJE5KSp1K2k4JQM16qMwp6DnGQPCpmTZ7F10gPbZA70XHQ0cBJRx1EC1J881trF3FV3Tp6S9V9wEYf2beKOo0nHZEiRvXyg5bTOswh5mG6NK8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbptmBZDlp3cr5bo6JeXfiVHthoq08h7dbQQxNup13Q=;
 b=aGwk8/8OkjOXw1cQdbJPladkhy3gJ7vx5IwNIFKmMA1W5Z/uC2fQt3d3vsodDWCznBRVozOMQ0b2ZLnLpnPfhNF5bC5RCYQXnd4KqBoBnEyZgj+ZOakrtGqo0b5jCBxWcE3vp3ER30SjjJYI4pAk/XuXXaJTuoi6+WAFZB+GqjRq/vUdjdA9Vdka2WeoOQg1Grt3JQWYeflVL5cRx1P8m+hwbbrQqRM7boEpfMyBDHQ/20/pXvnSnGamkm1S7fuWPxXfOKfDi3wX1fpHWug0Cx9Evt1Ja/XwFYb+P/o4nvthIp6iVLmh7y+CtAKq8BEslHX2wyX9OlxUlCN0zL/b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbptmBZDlp3cr5bo6JeXfiVHthoq08h7dbQQxNup13Q=;
 b=VcIw7+0w/OABQ/FueEAieQatmwfGVfKlWfo8VtGd0MnbGYGzuzD5LzPb7jxsf9j0n0pBWnYZ88bpPOY+5iL/u6z4OxFtm99AkxVby2HYHtOoR4o/EgUlU7egnaDP+Zl+b5OmfOqCg1TxNSr2oFe6zqSyd9XDxrZbuN4eZE5x58o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 18:53:01 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 18:53:01 +0000
Message-ID: <678f2b92-8f7e-4a6c-a66e-c19434de19f4@amd.com>
Date: Tue, 31 Mar 2026 13:52:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/10] cxl: Update Endpoint AER uncorrectable handler
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-9-terry.bowman@amd.com>
 <69c9d04baa431_178904100f1@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c9d04baa431_178904100f1@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0184.namprd05.prod.outlook.com
 (2603:10b6:a03:330::9) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: bb22a29a-2e7c-4110-659e-08de8f56bbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	e8FSS3Vbr055pcEqjY5PliH7ycUzlyDUtm27dAoUqZAjojRuJ6gFR+xaOISZkJGRqghIHEhphUc0RTAKG9tg3VK84MFERrlBYA25nyq418F/I/dDXUCFULov2Cqy2QuqY772xB/QX7xywM8cdy9a8SGdKScDiWQ/65pTtp/RI54wReLRYZ9ek+y8ADOerApK2y2leXTP8ZxackJjEw8piOzohrsLyHe1oZtbBH+ipJLO8hcvWzv4SElkegPrzSZvY8nwteXtHqAW8jG5dyd71RebS0SMkw7VCN2ggkwcG87nez3aAEKs3LdSiT6px8hY8tZyi/2S6s6LyAQspGLsxyXr96hEZ1l/NRsxq8qf+gesrl6GmWGmwTrmDAIluu7xH/Vji1DIQgNSR2urVp8Fx+LnJ3HBmPLB9rjpdTtgjbFUAEEz+gQM253IgFGH4zjxo7b/X351+NxXBOE4UMSfyk+vxsN6w4yMJeRAhAFLwuO2qePFrG8YH6GlDEmP83Pu3wD6UZ6TwF1wH/ax4ioqnY+MkP9ilQp/iergGkLB59mVoApLgMYucdFCJlBLeLq9i/8qDrqoJBqSlLtLAUXvYWNXdPwqHwP7nisCi4xJSE/iFK9BODH6nKfjPX06qO/lQ5xpGEQ6PVfS3Hs+Oh6srKqgLJvx+8C1GxCNSPoYBBpl+/IybWwLNCORqTQQObYAy/O75I7acIXKhvfXwPlZ92+ubzRyQbNPZLOMnIomZJ15UwJqTxNpIAWlgvjEZo/xOT4HHKS475UUek6dWdT/9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzlmazBWb3VtRUdNemNYS2RML1hVekFJUDhlNkg4a1d6Kzhqc0Q1NTZreEtD?=
 =?utf-8?B?ZkFGd0dOeEhReEw1ZGlmUWxvb1VWakoxY1FDeGRwNzVVV0pidy8rNXRORlNw?=
 =?utf-8?B?aE9DSDIrQnpaNk5EU2VIRkJEVjAzcU4xMG9pRFBTTVRGZkZCdVowWHp6QXEw?=
 =?utf-8?B?d2lYYVpHcTF0T1VEMGNuRmRqZS81SklTTzJTWWt0VE02WkxHYWF1Yk9OOUdJ?=
 =?utf-8?B?VEQ5Y1VjZDVhSVVUajJPTlRVTzRxOG1QcFd0RkZlVmhuSDFmYzRwYjFoQVNT?=
 =?utf-8?B?S0NoY3kvQWZSZVE4M0NycUozTy9hcTZ2SFlodkFrY3ptWmJsNWFidFdiYnd5?=
 =?utf-8?B?eDJTQmdORm5LOFdIazQ5Qjh6aUZWWDNvVHZYQnR1TmRNRHd3cjBYcDIxajds?=
 =?utf-8?B?ZmRidzdVd2RwbUd1NFhLbEErOGlzK0FLUnNtVHpIMFlVa2dNakxlb3lYcjBy?=
 =?utf-8?B?eHpnWXI4ME5VMkQrVFZ1dVJGMEo3SVl6RnZ3WFhYVzZ0L0xmYkZyVFlZVW51?=
 =?utf-8?B?NUpsVWQwajRmRm1TYWVqNmxnbmhhTU95d1RKVXNuNFJIaE1GMHkraUxPWDJp?=
 =?utf-8?B?ZkM4ZlZMSWxJS0c5MkZKcWtMZjdxZzY1QVNCTVE3Rm01eXJ1c3hDQjlDS1hC?=
 =?utf-8?B?VnEyK0JMV3V1N3FXM1VVZi9Xci9ucXpFVWxaU0NSSjVmaGZHZVpPb2YxZVFL?=
 =?utf-8?B?RS9rMitCcTZucEhWUTZrYnNOWDBMY3dzZFEwQVlHN1hhcmJkaGFPTG11Z09v?=
 =?utf-8?B?b0Q4d2M4VGJjcVhCVENlVmZ6VW9RdDlEU2NPbEErT2ZWSGNwQVhqRS9iQW55?=
 =?utf-8?B?bkFCOTdQcmJMY2dJRlJHTmFNbDVGSXNSeXJsUW93RFhJa2R0WWs0WHc1VjVP?=
 =?utf-8?B?cUhFRm02dzZzTDI5U2w4SlVpRnQ4aWhNRS80ODI1R3ZhNEd6UFkvMjRDK2l4?=
 =?utf-8?B?dmR0UGc5d0NiTisxbXF0R1RsU1IzWmYwMkV5M3Jmbm9IaWwvNWZmTDJNR2ZR?=
 =?utf-8?B?Q0JZRC9FQ0VxcW5wS3BkZGZtNHRScmpzYnAwMmx2b3hmeGd1cVNUbFNBclRO?=
 =?utf-8?B?TzVLU0ZpSHUrVWlQa1Bwc2FzZmtyY1Q0V1ZBcmhLOW1JZzRUeS9WQ0NxcHFs?=
 =?utf-8?B?VFBudHZ1THVTTWIzcmFjSmsyR2dpTnNTMmIvKzVhaCthSHZSeGwyOXd1TFQr?=
 =?utf-8?B?OUpHTjlHR3NjVWkvUE5VbnhzRHFNemFqVE1HN0xGRStIcE1CNVEyTHJWMEVw?=
 =?utf-8?B?czYvMGJJeitXU1JoSzRkRTg4M1ZOdlIrY0R3c3BnaVVWSkpYN0RBTHUvZ1p1?=
 =?utf-8?B?NzdKVXFjYzZ1WnFzQjh2MEhjcE1jQWt6aXFEOTNRa0xUdUFLcGkyQXpZTDg4?=
 =?utf-8?B?REpwblB0dWNod1oyYlNGZWVLejRJNE90S3JSNG5COVg0b3p5Z0orcGpjWlZm?=
 =?utf-8?B?QzVuTlFORW80bkpEMjA0dVYxTFpsVXJGaXF4T21GSWYvbWNUeG1RSTFYS201?=
 =?utf-8?B?WTNQTW9XSklDYlhvRDhOdEVPeGpZYXBqOUNBdy9jTE1kSUR1WjUxcEVJV1dn?=
 =?utf-8?B?SW1KY21tblBLbVZYc0lFTk0wVDVJVDcxQUJTb1k4RUJ2Qk43Vkg0cGhQbHA2?=
 =?utf-8?B?Z1ZYajZnczNRNTA5cmFrOWU5b0RUU29wbkttck1PM1puemRhWDJJK0NKc2Qz?=
 =?utf-8?B?eGhGS0xTUjdYZG12OXMvV24wdVhsQmF4c29LUkNnTjBVaStUdjg0c1RmYVhT?=
 =?utf-8?B?TjIxc3kzZmRHZTAzZFUvelhnNkNaOEVZUXoxcnFnVGM5Z05hNWNLU09SR3FW?=
 =?utf-8?B?TGN6d2F3ckFXUW5TenhHMVlMVEl1QXZwV21qZE9yQ3hwNXNWcEJuZ1JGY2lT?=
 =?utf-8?B?bzgxeTBkNXVIOFZQalZ5emRsSkNOQmd6UERsZExDNCtiYzJVdzdaWUFramJV?=
 =?utf-8?B?VkZaUFMvUWZITzBwVEU5OTdnWlI4VWwrbjZGNVNzNFVodU0rZmkyZGpyZDFG?=
 =?utf-8?B?TkdMRWxyNzhrM1AxVUhpb1NwS0xueEhDWFRueHN6a0RwSWNaZXJ1c2JZRXJt?=
 =?utf-8?B?UExJOG9hM3pYTWdCVUZDak80ZTMyK295dXM5cFZmWllUVlhYU2ljbUFMajAv?=
 =?utf-8?B?SVBKc082WVp0SXZicGd2cXpBeWFXbVVXN29hcldoTE9aWE5MbHJBT0ZmdWhU?=
 =?utf-8?B?UlovcW9yZHdPeUg2S3R6eXF0ZUE3Nm9RRjZFQ0pWTGp4VEk0K2R2cjdCTnRu?=
 =?utf-8?B?SHl0dWxTSXZjcGdHRkRNZW1vT0xud3p3WUlYNHNGc3NxQXB1M25rMEdXZkxo?=
 =?utf-8?B?dlh5TU5na01JMit6RFBYZGlPbzZ5c3ZvQXZvSWNKRnR6ajU2S0lEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb22a29a-2e7c-4110-659e-08de8f56bbbe
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:53:01.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2y67JHaW96Rsv9btJ0JHMfoKmjCIGckkAH1ecd5RbF74BB5pK7NTa+1Wgk3unbxzoGNKu+VEmnvpT2+/0KOfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

On 3/29/2026 8:22 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL drivers now implement protocol RAS support. PCI protocol errors,
>> however, continue to be reported via the AER capability and must still be
>> handled by a PCI error recovery callback.
>>
>> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
>> new cxl_pci_error_detected() implementation that handles uncorrectable
>> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
>> be added in a future patch.
>>
>> Introduce function cxl_uncor_aer_present() to handle and log the CXL
>> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
>> the AER driver and require logging here with a call to pci_print_aer().
>>
>> This cleanly separates CXL protocol error handling from PCI AER handling
>> and ensures that each subsystem processes only the errors it is
>> responsible.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Assisted-by: Azure:gpt4.1-nano-key
> 
> This is not a human. If you want a tool to do some of the labor of the
> patch I as a reviewer want to know what labor is performed. This tag in
> this case tells me nothing actionable about what needs reviewing.
> 
> See: Documentation/process/generated-content.rst
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 254144d19764..884e40c66638 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -393,34 +393,41 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>  
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> +static bool cxl_uncor_aer_present(struct pci_dev *pdev)
>>  {
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
>> -			return PCI_ERS_RESULT_DISCONNECT;
>> -		}
>> +	struct aer_capability_regs aer_regs;
>> +	u32 fatal, aer_cap = pdev->aer_cap;
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(pdev);
>> -		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> -		 */
>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
>> -				    cxlmd->endpoint->regs.ras);
>> +	if (!aer_cap) {
>> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
>> +				    pci_name(pdev));
>> +		return false;
> 
> How did the PCI core generate the error if this capability is not
> present?
> 

This was taken from the AER driver likely for GHES support. The aer_cap check is not 
needed here and an be removed.

>>  	}
>>  
>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
>> +			      &aer_regs.uncor_status);
>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
>> +			      &aer_regs.uncor_mask);
>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_SEVER,
>> +			      &aer_regs.uncor_severity);
>> +
>> +	fatal = (aer_regs.uncor_severity & aer_regs.uncor_severity);
>> +	pci_print_aer(pdev, fatal ? AER_FATAL : AER_NONFATAL, &aer_regs);
>> +
>> +	pci_aer_clear_nonfatal_status(pdev);
>> +	pci_aer_clear_fatal_status(pdev);
>> +
>> +	return aer_regs.uncor_status & ~aer_regs.uncor_mask;
> 
> Is the above doing anything that pcie_do_recovery() is not doing?
> 
> For example, there are zero endpoint drivers in the kernel currently
> calling pci_print_aer(), why is cxl_pci special?
> 

Device AER status is typically logged in the AER driver but is not for Upstream 
Switch Ports and Endpoints with UCE fatal errors. The call to pci_print_aer() 
is added to provide details about the error. The logic behind the change is if the 
AER status is already accessed here (to be cleared) it can be logged to the user. 
pci_print_aer() is used to maintain consistency in logging.


>> +}
>> +
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t state)
>> +{
>> +	bool ue = cxl_uncor_aer_present(pdev);
>> +	struct cxl_port *port = get_cxl_port(pdev);
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +	struct device *dev = &cxlmd->dev;
>> +
>>  	switch (state) {
>>  	case pci_channel_io_normal:
>>  		if (ue) {
>> @@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  	}
> 
> I am getting the sense none of this is required. When the device is
> trained in CXL the bulk of errors will be CXL port errors, when the
> device is not trained in CXL it will not be in use. For that remaining
> case, why does the driver need error handlers?

Uncorrectable errors of CXL Endpoints and Upstream Switch Ports are handled as 
PCIe AER and not CXL RAS. This is because the AER status is not read in the AER driver.
This is not read in the AER driver because the links are assumed to be down.
The AER driver directs the error to be handled by the PCI path instead of CXL 
handlers.

- Terry



