Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67D41C2E1;
	Tue, 31 Mar 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991566; cv=fail; b=IPOw4a+Jj+WtZh2MHHCcCHjgDXJe2m2c9BbIKRySCz04+nWgNqbUGmy4pTzsho7v3uz8hhZy5B4ODoU2LRKD17tObNBjSciEmDafPLfbMym1NqXShXGfVt5FuUTwR7IlLC6nBTZn7Ur/ZJfWxgtsPOCHARKr+xpV4NJttRKqWxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991566; c=relaxed/simple;
	bh=fOT87w+y8bHi59VVXjCpfp4U1fCe9gNOTTY027O4zSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LoWXKyefXTmmQRkEWp48xw0vBhSZdANVfjAh5TZo4MU0lRpkJBFJAS15eM3GSVst5QKEYRQAGqEMjKxNxRpE03bxspMspVpIIEtPnOhUCBLCzcbZ0LuWNkiZnrjwzHrPcwuqGGjBddBlbrOP+a00/ugHubk17teJyvtkyjIpPvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JoD9+EON; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JoD9+EON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwWu08Me6S3SHrxfiDr/OeuZtnMd23ZqHkpA++vAoW37BoEcewTBdngrBGKDkIxG3jbCrG9/GaWQ61QYfmYBNMBuCzq7ud3bsE6STlkEPXjEK9HrvXSwO8kddqzOb7nk3FR4iPb1iiaeS5fagqaeI2Z+nl7EoaV2xwEnrZaGM5EnoQmO8DrgcP044s1LzEx4cTq8TB0lfU0kuTAbR9GK5Z1qYgQbDUSktcUosmcVgM1xVggp5AYTx8R5ccZeyZihKrxW1DXzg9TICk4yKrYc9f/DMU7QJN+dBydIOVDhdSKf4UeMytBN3ZXfc9s8KHvzlUE4r/a63d4Pj5TVNe9LLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FWdSSKBN44DQ5zBfod4u0M83i6OQ6SP9HDfm3A3wVY=;
 b=AZHjQgo0196oxayxLZCq+AG0ex4wrjcrgIZlSHUXbaxhgFAOiUN4vP3A9ePJArJMl+7wBwQcuPQ/BYpiWD1cgE+eO/Arg0vmN/HuWvp/mrBZ9h5lTcmefMO8y2TA74YnpbvTY4R0MBDlO7dlieKgQ0AJQ8zRPxgzAHzWxDAWibbJmDAOd4oAXdh6ygl+Wsos2jwa1bNsRLI0s5Ro5Rad9YBS2kVV1MLeD2Ovy0XTjW+6Z+ucIss5iAsuP3auk3jl3wmFbOuJhOYHGSEmqzzj5EHEE9u5Z3b/8zhKyhF+O6C8Lxn7sDh+8PeM/A6+/dGNpNmtpBapmdEnpAczT73ETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FWdSSKBN44DQ5zBfod4u0M83i6OQ6SP9HDfm3A3wVY=;
 b=JoD9+EONl+DlDQh3as6QTJGEjjHuEkykJgKVRIHUkjhf1G9e1QLfl0Aj9J4vLPQ8BCtmNayXw1azb8MFWIgHy/0H2jkmd3+CyZ/K/uEjnAghxE6h0p5RWs+13mY+w7gv0Gh2RbNXQKnRyfCjWVAjDSlC5F2i+rPVNbLho7uysm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 21:12:39 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 21:12:39 +0000
Message-ID: <60ec8dbc-e081-4cae-99fa-c3042bebc996@amd.com>
Date: Tue, 31 Mar 2026 16:12:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/10] cxl: Enable CXL protocol error reporting
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
 <20260302203648.2886956-11-terry.bowman@amd.com>
 <69c9d4b8e08f1_17890410047@dwillia2-mobl4.notmuch>
 <e2583442-55a8-460b-90a0-7b56db0722dd@amd.com>
 <69cc1d7ee3088_1b0cc6100c3@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69cc1d7ee3088_1b0cc6100c3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ab8944-0870-496d-c7f6-08de8f6a3d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	REF0vTSq94LqQ9il2yP4xaSrAmEyIh9013i+BDjmvfL4pTzjSnb1ufiE9O1l61Jae4B15BmbFV+PWSlyqx1bBs2IMMyE1hw54CrHd2vlFwWIAN4BqE0ThN1QrXLM7W5XHESk5O9kHjegOFfz5K01VEIOo/332oWGLzT/XsxVSFgyjRupde3AYrJdgvF750arM+OeUwPaovyjYfUUaHyD2nAR17QhmBJqjghK1qK/zbA9eJRmQHZnOGNnt6AQsCpBm6Hkm8qCNAu7cebMtyevO6djBEPnWhTyeim/CBPE9ibP5o3MSziz4vJj3B7KWzEPDqYjWkzl06hIdEUclOGEvdiieorhdMdM01aKueXOCTrJ9v9KnAaZ1AEq6nIj3uGvZU6jtg4MDx/HRxZBPwNp5JmitKRXEmiwQFcvV9uD1kOB/0zVX8SMwPqyJzgmc1QWTdiZVKPKsPhI6X06GWQIEnF2VBHjwA5Y4mNBVLwZPFk/x0F2anN1hjazdCV3FdD4Ue2Jfcrm5vtN7/s6odhx/gTCMFw05pB/BVikI7fJUkZbg+3wtm+dGNUI1fkXxY4UOf1Ug88zy87ehNudRnOaqJuNmhd8hMt6GMzK+bHE2ZiWqC9PGf79GpT/8H3OpqJmhc/1ZMlPU6ifNen52QCrIVUxdmqJ5nTSKI9nK9tHfexk+IQ5dSeLiJUmWA+Gd1BmOCByxzeLd74Vq7NiJAGSeA9n5tD0T5ss32TVcD8rSqwH06Qc77Aos2S2Dlyl0P1Sm2POTFmbNu8Vc5Rtq2IR25qpG9QhKiC00V6KvS5AJ9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU1JUXMyaFBqUm1Nb3M4V0ZGTlZNekkzNFNFWDloS3ltbFFLNEFHUmdiOHhq?=
 =?utf-8?B?UmxoOWlXMnBHMk5yOVhrU0MvdmpML2pOeXFWQnhVTlcvSWNDOTRDYnpJNDdi?=
 =?utf-8?B?c25zdUZGbVVmYVN2RWRCdFMvSzFKYkRLaWliSEFjSFc1cllEMEdkbjZFUnFQ?=
 =?utf-8?B?V0NCM0t6YUR6b0xpemt2ZExwZjdaSVV1M2VLbks4MnFYWlFjelc4aXZVOWs0?=
 =?utf-8?B?T3RIV3RPVFBJREU3OFlTK0QyNGNkTE1vZ0R6R1hveDVmeDJZVFpnQ0lDbFll?=
 =?utf-8?B?R2RPcXdvRmYwcmJrZHp1QUJnWjJaa3ZRVlBuUnJyTXhPTVFJVHduejhjU3pa?=
 =?utf-8?B?UHRuVE9yeTFaRUxpelc1YlBmVlVMYkVjOTRhblZQczhUUzhhTjNQMUppZ3J1?=
 =?utf-8?B?THhrVTVJdjRXWHdVbDlmcC9jOGF3RERhSTFpUjY3VDNGMUlueVJ3SVd4ZWFL?=
 =?utf-8?B?Z0VUc0FJNVB3aG1teXZ5TGU4clQwRHNjcmlSeDRWa0YwRjFWMVlLZVpoTmd5?=
 =?utf-8?B?SWZOdUVuZkNRUEQzbVZDeThoWG5sV0Z4K2h0WWx0Zjc5M1kzSDg5L2RTUWds?=
 =?utf-8?B?dGZXWDlLNzkvQkVwcFZxN2ZzdXVSNUNoWWg5bHhaYnkvRDFxbkhKeVQyN0tM?=
 =?utf-8?B?cHVXZHVyejI5NloxTWs0TytYMWlGOHcveGhtMmJQS2VlaHFBMGZRTkNyM0lL?=
 =?utf-8?B?Q1RJSjJqcUl1eHpDZDRZWUxZWHhNcllWaEp4dFlDa1JVYlBqaWdaZW4ya3A0?=
 =?utf-8?B?Y0xjaDNUMVBNTHBHMkJEVmxZK2tFTk0zcFM3am5aSTI3Z1U2cnRIcktubjNv?=
 =?utf-8?B?WlhzSzZGeGdJbS94K2RTU1FySnJlVmxkUGxOdmxhL2NtQ2R6NGdpTUVYRWZU?=
 =?utf-8?B?MWdYckdoTnYxTks4NkF0WEVuZnR2R1hZOGZPVFh3QmFwQTJISXhxclVHRjEw?=
 =?utf-8?B?Q2V1ZFJ2R2hiV21CdXJVb2lKVE1TQm9KdWVsWU02M2NmMEVmRm02TUErbmdw?=
 =?utf-8?B?bFp2emdPU2V2YTVRT1RaZVNkOEdLNnNPWXJSZENjeXhIVnFpOFpkanhOR2tn?=
 =?utf-8?B?TkJaSUdKUFRzbUhKZURqR3hVNkFJUFAvbGxTYWVzWTdRVXI4V3k0WURaUVhz?=
 =?utf-8?B?NCs0U09Vdys4TnR4aVpZTGc2RmNDMmJQQkNCWWZManQ0WmwzWWI1WEk3VDNj?=
 =?utf-8?B?SUpFaHNsUVZzd2V0MWtjbjNweWZrR2tmWDFPR1ZrOVlPS0FzZ1RJYnRubk9u?=
 =?utf-8?B?RE5adXkrandCYkg0U0RtSVgzZDFlMW9uNmhOWFIwUXpuV2lJNG9tR2VhZ0Zn?=
 =?utf-8?B?aUY3eTRDbDhEWk1tOUpMWWw3ZjdjVXNlM1E0aUFZWjJuVG5hTDFJbHk4VlVK?=
 =?utf-8?B?d1B6M1J6VHpXZGVWbUdtcUNSbmgzUlREcXo2aElwQTJqSFM2dXV2c05EZWxN?=
 =?utf-8?B?SEN1azBpUWJ6dHZPQ1hOc21GbmlsTkJGZW96Qm9TYjdPYjVsbWd1RUdVTWpO?=
 =?utf-8?B?OGhISDV4aFB0UWd1T1BiY3BCVk1HZjNWTUhpQ3BVMXgyU3Iyei85d1MrUnpv?=
 =?utf-8?B?MW5LSmtCRENxWkw4RDJSMEVzZERnTnJCNDhaWGxNMUFIbkFqb0szWGZ3NUU4?=
 =?utf-8?B?RHJjN2E3OVcvdGFjZk5BZWxFc0ROSDBsL3NoU2Z5b2ZWc3p1VkZpSWRVek9y?=
 =?utf-8?B?WVVJS1VRckdRNUduRXVOZUJiaW5lNjRIcTRUcjQ1RFpVOTRwM0dlaVRmQXRa?=
 =?utf-8?B?YkVFcFBJY2M2NDRrMktScXNMdFpRUnZ5WXhhS0g5TG0xbmtKR2pMaFNkWnBw?=
 =?utf-8?B?Zk92SUVRM085UGdueDd3dFVLZGJBYStPZzhPd0J5T0VyZkY4dUJWcFJadXM0?=
 =?utf-8?B?Y3VOZnd3bVRYUjdzeEs2RXZPTmhtSWQ1RmlXL1BnZXN3VmdPd1FuOVhkc0lZ?=
 =?utf-8?B?MTBuMjM0UHc2Vk9ibjRiSE95SEhTcE53TzFGYWM2bUNjamRLYldEUEZ2T29E?=
 =?utf-8?B?TDdKdURuc3MvbHhMRFpyenhSb2ZnV29LaStiVThDQytJbFJ4V09WaGpQeElT?=
 =?utf-8?B?c2lsM1dXV1JPdzJWUkduSFF3Z0gzSmZZeUpSSXlzY1gybWpDZkliVXo4Rmxu?=
 =?utf-8?B?RUFKRzJzM29kdm83TUFHOUQ5bElYNDJFQUdmbE9VUGpCMVdtUkc5U2FpSTlU?=
 =?utf-8?B?WUpDNG1yKzhHWUpxN042cGQzdFl6REJ6bVEyVlhHVk00K0NFTmhVMmNDV2d6?=
 =?utf-8?B?Q1FrSWFxaGpFbWhpd3RFcWNYYXdYWFpJclIxOXBtU1ZNQmYvVEJUVFFIVzE1?=
 =?utf-8?B?QXo0bVJta2U3SFgySnZUL0lOSGtsQSt6QldkQ0JVMnJmWEM1V1JNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ab8944-0870-496d-c7f6-08de8f6a3d8f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 21:12:39.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+vIfbWB/HcEBiOCMbVqElXmTYAeyZZbKE+9bmKOE1a5/frYBgj0mYqvKAdcBbu+QPzn5BPBd5z5nSIgFuZnJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

On 3/31/2026 2:16 PM, Dan Williams wrote:
> Bowman, Terry wrote:
>> On 3/29/2026 8:41 PM, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> CXL protocol errors are not enabled for all CXL devices after boot. These
>>>> must be enabled inorder to process CXL protocol errors.
>>>>
>>>> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
>>>> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
>>>> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
>>>> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
>>>> correctable internal errors and uncorrectable internal errors for all CXL
>>>> devices.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>>
>>>> ---
>>>>  drivers/cxl/core/port.c |  2 ++
>>>>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>>>>  drivers/cxl/cxlpci.h    |  4 ++++
>>>>  3 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 27271402915f..c33d58fb7264 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  
>>>>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>>>>  
>>>> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>>>> +
>>>
>>> Why here? devm_cxl_port_ras_setup() will just redo it, right?
>>
>> No, I found this change is needed otherwise injection fails.
> 
> Sounds like something worth fixing rather than sprinkling an out of
> place workaround. Port resource acquisition should stay logically
> grouped. I am also missing where this masking is restored on exit?
> 
> I have asked about your test scripts in the past [1]. Those scripts need
> to be integrated into cxl_test proper, or at least contributed on the
> side such that anyone can clone the tests and run them. It needs to be
> the case that incremental refactoring work can move with confidence by
> simply running the tests. 
> 
> [1]: http://lore.kernel.org/68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch

Hi Dan,

I sent a tgz in response here but the Intel server blocked it. I emailed it to 
you and DaveJ.

- Terry
