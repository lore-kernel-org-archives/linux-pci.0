Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666E4657D6;
	Tue,  4 Aug 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851208; cv=fail; b=Xrr7/xkCO6s4SjD9wnW/SkoJsCBlWoEaQkUEG6Y40d5SWDUxH2En/Ztypnt2Ek21ib/MOalMeBtUc/2mliaLoHqHhOcKhSSRhxYo6QQ1hOzwBWiJD6KhZC2760WgRshTeLU1MXPyqQ2WCM7y3pSclGnjM+VktSbBoOA5QqwF/Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851208; c=relaxed/simple;
	bh=AOZKP/k//WujJ923G6ghGr7BdLqeuYzxd9oGqxG5Hpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvmxvZJ3IxnlRBUR/3mx1IpmIYjn3svcdh+gJ/XZpQgQzwE3MCfFlzSmEGhO8ueeqTAFLnu13e5aZaHTlwIao/B1L0Mz3M761Et30dyzbodrdJYqXT+dBSGzoUEP4kjGcobGRDQQFcV+v4IVR6hYE9ApefYfkjDBkfYsxB3QON0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6rB/Vyu; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6rB/Vyu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwDDjmeKMuxarDeZUo4cue1ayD1aguDqcc/ytPtf7S9HDp3yby6FvJLgl+DHXRF9Ks+i+VPNktuxhj5/TlQyBfXMcL+ceIQmSEMjqRx9AUke9uLkX9tjbn+A4WJROkPsPmrzjX/SZdL1TCgMHHm/iP8vp4krCcDskAh0CaTEBFfbrwfYb+OSQZ1xI6qFg73AkSCs3WNLSi4ENEEHxySgNPE96CWhYKTTOshFu0LD9t/gL5p0AsAfwSyGFcMddY5Rci6wDFvX0cWENm2QdF2yAwGsjYzOYhR507FveMXJZmcMcwc34aJtgOsZRQ1WZGb78OCPSvlJ9Wnqs6HmlEQneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N428DEgGO9Fjs4f5mbS4q8VoZNycV+vSVYxwULYa6X0=;
 b=glnj2FgPtqySgHyQHkVRMMfXKYv0tCPua991t6JBw6iFUuNcJG88JLiMqsIDY9mZQZmqFPunTRTAA/CRAoAk1juYbrnQK8mxf41cXlWJps1Tv1La45wRHacZYQfKpvmLeHG4lYf4PRVUL6iiNEWe3o7TiSuizR0tJzocr270woFiplrsAq52OG0lIj10/oZoSmniy9eXWJcIH69kPx0/9vIlJvSfMPZOWL7mt/0ViY06WXpqUr+2lnJngqtmBswqpV/CErU4t272I/P/SQFaq5eyoW5QwbAbukvjqsob3xIZorarFitFMcUVsr0Qt93qsdIOYYd3pB8/Ay13YZa6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N428DEgGO9Fjs4f5mbS4q8VoZNycV+vSVYxwULYa6X0=;
 b=Y6rB/VyuTXur/+URsxwwny4ptHO1xoo9WiQhNMzSYBd6yqrLoQ1zle041keMGnng3bVO/gsLo/hEON8eig6EyHAFxdIV972dssgHNblEf8r5aaLlugSG7UxtDM5tBmiQXe4b7XEFqr01GyqZD6vwoLxo4hqozQX9k1V/92h66Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 13:46:41 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 13:46:40 +0000
Message-ID: <c8129007-3fda-44a9-a43b-e8e9ab84f2c4@amd.com>
Date: Tue, 4 Aug 2026 08:46:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 12/14] cxl: Add port and dport identifiers to CXL AER
 trace events
To: Richard Cheng <icheng@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-cxl@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Robert Richter <rrichter@amd.com>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-13-terry.bowman@amd.com>
 <anGYFW9WC40gaAjp@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <anGYFW9WC40gaAjp@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::19) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f05040-233a-4195-4d8f-08def22ed006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	d1UBPSbid0hn0pYmHwQ9HqI1QgQ2gtIHvGmlRPdptFfwHnm1NaNTU+7jVbJ++q8KSKA5QMUaUVB8kR7bJIcXzQU+j5zhYGU3nOJ4/zBwb+57A2vhcIKywbUI3LL+rg/P99qmy9Px17/hIshduM/xhR47v2WGz9Dbjb4m5gB4P5f9ZGC6b3E5cbPpQ786xmNsuBFRid8GHW1WCPBNg8evFhUfXZXEs79H31bL1cfm+cwJCQV6HNBW2ifeo5WnrnEmuKcjc5mNm/E2HxTc7/DuNU1bFo6CKxkmHQmtGJjYpreJDHqmH4YssZ7c6lzLBbqjFJgkgiNBkkCWAgnHWvSBpUBUF4i1xXXw5qu5TWXKwvhDBZl5rVEojJSe0vmAwUJShs7JYS71aAJxhsGUmJc14IH4SOXgcv5PJE/+s2B0z/dVnSQY7z5JU17eNSy861L5tZ60T84D8S+I/yrlhomK1p+uZWvkIz66IPUPLF/lPRkt1dGs/rKfo5aI5yyzxXeLJWPTZ1apDajDN96/GP9BkMMXY5qEAy/xybtptXDx9hmYnSkUdcgF3uL8uTAgtrwzSNNX6aMmHWzFTp0k+mpx8Wg7z3yfFoAZi0v6B8uQYhWpOrXSe5yb5Xk+QMhueilR7eibL7ZvSqoHQr+aijdZu9OLSwWNu1OlBth9DPdSCkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkZJenk3YlpzTTJkT0NFcG9rUXcwTUF0QWhqMnBsQmJ1eGFxRzNjZzVVZW56?=
 =?utf-8?B?YTkxWjExNStTWCtNWHpnUFZ6QURLeUFObDVXWHN1QkJTOUEzSGJGSm9GbmFj?=
 =?utf-8?B?OWtZQVRpTzFDRlNPc1VVOXIzYTUyZlNvVnNyczV6RXl4TjJ1ejdCbzVaeGR0?=
 =?utf-8?B?NWF3dlFpTVdNZ0hQZlFpaXFxbTRPRjJkUGExcmpkQnF0czYwTHphRVlMbWFu?=
 =?utf-8?B?aE5jVUowUDkzNmViWjdkK2dnNG5vYmRTdGh5SEY1dkplOW5GZ0wvdWlNWE01?=
 =?utf-8?B?VCtpc0gzVFVHcHEvaSswN2hZSEw0TjdJYko0U1VVelRZdkVOZmNEcnJNZU4y?=
 =?utf-8?B?NzErN0d2eVhoWFpld0l3aWJRUHFHUkdGUVFxeGJ3WEtmMW1wbTNEWWlwbU5Z?=
 =?utf-8?B?aUNMbjVTdEg3aC8rTmtPVTQ5VGNxRmMyRnYwRktiQW8rN1FWNE5SYkxRRGV5?=
 =?utf-8?B?WFdyOHRJc2RrdVlDZjE0M3NGRzlqYXVCcWg3cmdjbUhSMW4vc2p4cCtPYWVz?=
 =?utf-8?B?aWNZN0V3bGZXUDloczJVa3RGdkdOVTlzMkIyQVRsVnRrTDFMZllZbW9pNW91?=
 =?utf-8?B?QkRWYmc0K2VUaXdjTGVXWk1YL3dxb09qV21pdm0yOTVKKzRHRXcrNmtKblVO?=
 =?utf-8?B?S3Vock5jcWZIc2ZwR0tIU3MwYUZ3Nmc4NkhFeXBzWmUvbG5ZbVZRVmt3TlFZ?=
 =?utf-8?B?K3MyZGRERjNYWSt1WTYwajlmZmJQU2gxNVNZN2txSXdsNWFYUE4yeGVQVHBY?=
 =?utf-8?B?TE9kQ0h3a1ZocXU4enorWnBUOENqcWU3eGtiOWI2ZGdOUWZ1U1dPbXdXdW0y?=
 =?utf-8?B?TXFtZjVEQnlweHVHWnFIUElqc1N4am1GKzVkNFdtZ015VnJMNGZKSngwdEdP?=
 =?utf-8?B?WksreUZQVlU3WUduUDVwMXRUekxKdFhsMTg3bElsQmU0TEF3cU1DdFR5cG1z?=
 =?utf-8?B?bksyRzdtMjU0QWIzNE4yenp6VEFOT0NtdEpYQkpqRkcwVllGOHFWbnh2eDJR?=
 =?utf-8?B?YUkvakNiWnR0MjluQTZnV1ZiRXRueE5DbERPeUhaMERCZXpmNDFRaFZQK1gz?=
 =?utf-8?B?VXgvUmI4MVpkNGkxSTVwVERGd3F0UmJrVWtnUGRCcFdLSEF6TXpZYlRSNnNr?=
 =?utf-8?B?WVREbnVKWXdXZUQxUEQvaVk0V1NqREQxWDhrZk1BbGFsVFFmbUprM2pIVGlF?=
 =?utf-8?B?dWpkYVdaS0hmb25WUjkzdE5qbVBNeTZLZDhhc28zek5HOWFlUjFOWmFwTGt4?=
 =?utf-8?B?SWhqYUVWQnYyYzdzUEdveDd1emkvTVQ4ZkdpekFXcFVvenVWME9kM0JvZEFC?=
 =?utf-8?B?SUNIMzArQVdCY1JoOGl0cSt2NGQ0V0dpL2Fndk1zQys0R1FkS3BOQ1F6TE1G?=
 =?utf-8?B?dXpIRlR0Y0VMK0U1QW81UE9yaEZjR2JtQmdhQXBlM2JlNUk4VXdOcDNjdzR6?=
 =?utf-8?B?bDNkVjg5ZENlRWhSaWFwb0QzTnpWRzdRS1FaSlVPZ2pXdHZ3Ni9JOVhIcDJv?=
 =?utf-8?B?UkpZSDFkYldlYlRSdFI0M1pGcGF1bTlObFU1cHNsUkxuM1dTN0pBTFBQU2dm?=
 =?utf-8?B?NlVrcUtlRUVRK1B4TjMvNVZMU3g1MWhxZ2wvM1Z6ZzVsTGZFSGtrSFdwak9t?=
 =?utf-8?B?OWVhQmZrczdJMUltcDJWc1NpQ0RPUFN5ZkNxWmo3YVphbFNoazd3ZzJoTS9m?=
 =?utf-8?B?RytPNjN4cVppZjk5aEhkU3lweVhUMnJSSDRoTnNOQitlanc5WGp6NWI1VVZ6?=
 =?utf-8?B?KzVLd01VZjhIODBwa3lFTUYxaldnR0o0cGwyYjhvb21mSzJVWWk0TnlGYnZh?=
 =?utf-8?B?M0JtdEVoYURKcW9EUU8vS1NWZ0JhVmxzTDNvMEF3a3dYR0tHeldmSFQrMC8z?=
 =?utf-8?B?ZEZQWnBqWXFobGlhUERjb1c3YjhPUlh4UVRaWHEvaDErNFYvMlh0bzRVUFFm?=
 =?utf-8?B?ZTZjUzhvcWp0Qzl5YXNISWFqU09iVnJBdUJ0NWMyTXQ4bTNQTy8vNE9tT2dD?=
 =?utf-8?B?NnNKUDIzZjZiQ3ZxRldTTkJxOUN1V2JzUkdDRUhtNml3emg2RVNLZUhyM1Z6?=
 =?utf-8?B?SDB6cDJvUUMwSHM4R3NESSsvRHdSUlllNkM4QzRPdnVQc3A2dWlSSG4zSk5n?=
 =?utf-8?B?alprL2Z3TG16SFdiWjlrNUYyakkvbXBvQm1oVHpyQkQ5ZWEwOGlYSnVITTVp?=
 =?utf-8?B?ekp4N0tRZVliZ2tiRnh0dm45MVNYNVJuSnZvbkl3Nm5qVHE0QkxWQ0VlTUhq?=
 =?utf-8?B?M2tlWjl4SWp5eFllVjdmbUliMnNTdjlwUjQ5V2dkazdWVTAxYldOMi9KYW9M?=
 =?utf-8?Q?AZvjuhqiW8bPdwxA8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f05040-233a-4195-4d8f-08def22ed006
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:46:40.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1eB8IJogwuyoVs8DBGzjZCuPecK1lWhO4poLWcOn2bTOpVWWbVcF56V7XdMWSLVKDos2u6kUmy5/jRRBFTu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On 8/4/2026 2:56 AM, Richard Cheng wrote:
> On Mon, Aug 03, 2026 at 05:18:08PM +0800, Terry Bowman wrote:
>> From: Dan Williams <djbw@kernel.org>
>>
>> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
>> trace events instead of a plain struct device * derived at the
>> caller. The trace event helpers then derive the right strings for
>> Endpoints, Switch Ports, Root Ports, and RCH Downstream Ports
>> consistently across the CPER and native AER paths.
>>
>> The unified cxl_aer_* events keep "memdev" as the legacy field
>> (endpoint events populate it with the memdev name; non-endpoint
>> events emit memdev="") and add new "port" and "dport" string fields
>> populated for all CXL device classes. Updated userspace can key
>> off "port" and "dport" without a parallel set of events.
>>
>> Remove the separate cxl_port_aer_uncorrectable_error and
>> cxl_port_aer_correctable_error trace events. All CXL AER events now
>> use the unified cxl_aer_* events with port and dport fields.
>>
>> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
>> the unified trace helpers, replacing the per-port-type branching and
>> bus_find_device() memdev lookup.
>>
>> The TP_printk format string places "port=%s dport=%s" between
>> "memdev=%s" and "host=%s", changing the text-mode field order from
>> the pre-patch output. This does not affect consumers such as
>> rasdaemon that use libtraceevent to parse fields by name rather than
>> by fixed text position.
>>
>> For non-Endpoint events (Switch Port, Root Port, RCH Dport),
>> "memdev" is empty and "port"/"dport" carry the topology information.
>>
>> Below are examples of the different CXL devices' error trace logs
>> after this patch:
>>
>>      ---------------------
>>      | CXL RP - 0C:00.0  |
>>      ---------------------
>>                |
>>      ---------------------
>>      | CXL USP - 0D:00.0 |
>>      ---------------------
>>                |
>>      --------------------
>>      | CXL DSP - 0E:00.0 |
>>      --------------------
>>                |
>>      ---------------------
>>      | CXL EP - 0F:00.0  |
>>      ---------------------
>>
>> Root Port:
>> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
>>
>> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>>    first_error: 'Cache Address Parity Error'
>>
>> Upstream Switch Port:
>> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>>    serial=0: status: 'Memory Data ECC Error'
>>
>> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
>> PCI AER callbacks that are not CXL aware.
>>
>> Downstream Switch Port:
>> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
>>
>> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>>    first_error: 'Cache Address Parity Error'
>>
>> Endpoint:
>> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>>    first_error: 'Cache Address Parity Error'
>>
>> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>>    serial=0: status: 'Memory Data ECC Error'
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>>
>> Changes in v18->v19:
>> - Drop redundant device lock in cxl_cper_handle_prot_err(); the port
>>   reference already keeps the object alive and no RAS iomap is accessed.
>> - Swap order in series with ("PCI: Cache PCI DSN into pci_dev->dsn during
>>   probe")
>> - Add review-by for DaveJ
>>
>> Changes in v17->v18:
>> - Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
>> - Add comment noting dport is NULL for Endpoint and Upstream Port devices
>> - Add cxl_trace_* helpers
>> - Add CPER refactor
>>
>> Changes in v16->v17:
>> - Replace cxlds->serial with pci_get_dsn()
>> - Change 'memdev' to 'device' (Dan)
>> - Updated Commit message
>>
>> Changes in v15->v16:
>> - Add Dan's review-by
>> - Incorporate Dan's comment into commit message:
>> "Add the serial number at the end to preserve compatibility with
>> libtraceevent parsing of the parameters."
>>
>> Changes in v14->v15:
>> - Update commit message.
>> - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)
>>
>> Changes in v13->v14:
>> - Update commit headline (Bjorn)
>>
>> Changes in v12->v13:
>> - Added Dave Jiang's review-by
>>
>> Changes in v11 -> v12:
>> - Correct parameters to call trace_cxl_aer_correctable_error()
>> - Add reviewed-by for Jonathan and Shiju
>>
>> Changes in v10->v11:
>> - Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
>> and unchanged TP_printk() logging.
>> ---
>>  drivers/cxl/core/core.h    |   8 +--
>>  drivers/cxl/core/ras.c     | 129 +++++++++++--------------------------
>>  drivers/cxl/core/ras_rch.c |   3 +-
>>  drivers/cxl/core/trace.c   |  35 ++++++++++
>>  drivers/cxl/core/trace.h   |  91 ++++++++------------------
>>  drivers/cxl/cxlmem.h       |   7 ++
>>  6 files changed, 113 insertions(+), 160 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 5ca1275fd8f35..a55a4e409feda 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -186,11 +186,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  void cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>>  bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> -		    void __iomem *ras_base);
>> +		    void __iomem *ras_base, u64 serial);
>>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  		     struct cxl_dport *dport);
>>  void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> -			void __iomem *ras_base);
>> +			void __iomem *ras_base, u64 serial);
>>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>> @@ -200,14 +200,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>>  static inline void cxl_ras_init(void) { }
>>  static inline void cxl_ras_exit(void) { }
>>  static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> -				  void __iomem *ras_base)
>> +				  void __iomem *ras_base, u64 serial)
>>  {
>>  	return false;
>>  }
>>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport) { }
>>  static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> -				      void __iomem *ras_base) { }
>> +				      void __iomem *ras_base, u64 serial) { }
>>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 5183b3c532952..0254b7ec64c30 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -12,69 +12,37 @@
>>  static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
>>  	      "rasdaemon ABI requires exactly 128 u32s");
>>  
>> -static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> -					      struct cxl_ras_capability_regs ras_cap)
>> -{
>> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>> -
>> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
>> -}
>> -
>> -static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>> -						struct cxl_ras_capability_regs ras_cap)
>> +static void cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
>> +					   u64 serial, struct cxl_ras_capability_regs *ras_cap)
>>  {
>>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>> +	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
>>  	u32 fe;
>>  
>>  	if (hweight32(status) > 1)
>>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> -				   ras_cap.cap_control));
>> -	else
>> -		fe = status;
>> -
>> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
>> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
>> -}
>> -
>> -static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
>> -					 struct cxl_ras_capability_regs ras_cap)
>> -{
>> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>> -
>> -	trace_cxl_aer_correctable_error(cxlmd, status);
>> -}
>> -
>> -static void
>> -cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>> -			       struct cxl_ras_capability_regs ras_cap)
>> -{
>> -	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>> -	u32 fe;
>> -
>> -	if (hweight32(status) > 1)
>> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>> -				   ras_cap.cap_control));
>> +				   ras_cap->cap_control));
>>  	else
>>  		fe = status;
>>  
>>  	/*
>> -	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
>> +	 * ras_cap->header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
>>  	 * dwords. Copy them into the front of a zero-filled
>>  	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
>>  	 * event memcpy sees a full 512-byte source and the userspace ABI
>>  	 * (rasdaemon) is preserved.
>>  	 */
>> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
>> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>> +	memcpy(hl, ras_cap->header_log, CXL_HEADERLOG_SIZE);
>> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
>> +					  hl, serial);
>>  }
>>  
>> -static int match_memdev_by_parent(struct device *dev, const void *uport)
>> +static void cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
>> +					 u64 serial, struct cxl_ras_capability_regs *ras_cap)
>>  {
>> -	if (is_cxl_memdev(dev) && dev->parent == uport)
>> -		return 1;
>> -	return 0;
>> +	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
>> +
>> +	trace_cxl_aer_correctable_error(port, dport, status, serial);
>>  }
>>  
>>  /**
>> @@ -108,44 +76,32 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>>  
>>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>>  {
>> +	struct cxl_dport *dport;
>>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>>  				       data->prot_err.agent_addr.function);
>> -	struct pci_dev *pdev __free(pci_dev_put) =
>> -		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>> -					    data->prot_err.agent_addr.bus,
>> -					    devfn);
>> -	struct cxl_memdev *cxlmd;
>> -	int port_type;
>> -
>> -	if (!pdev)
>> -		return;
>> -
>> -	port_type = pci_pcie_type(pdev);
>> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
>> -		if (data->severity == AER_CORRECTABLE)
>> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
>> -		else
>> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
>> -
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
>> +		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
>> +	if (!pdev) {
>> +		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
>>  		return;
>>  	}
>>  
>> -	guard(device)(&pdev->dev);
>> -	if (!pdev->dev.driver)
>> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
>> +	if (!port) {
>> +		dev_err_ratelimited(&pdev->dev,
>> +				    "Failed to find parent port device in CXL topology\n");
>>  		return;
>> +	}
>>  
>> -	struct device *mem_dev __free(put_device) = bus_find_device(
>> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
>> -	if (!mem_dev)
>> -		return;
>> +	/* dport is NULL for Endpoint and Upstream Port devices */
>> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
>>
> 
> Hi Terry,
> 
> I have a question here.
> 
> Do we need the port device lock here ?
> 
> cxl_find_dport_by_dev() is xa_load(), and the free side is serialized by that
> lock. del_dports() has device_lock_assert(&port->dev) and frees the dport which
> in the end resolves to kfree().
> 
> __free(put_cxl_port) doesn't cover it, that's a kobject ref on &port->dev,
> so it pins the struct cxl_port but not the dports.
> 
> I think cxl_cper_handle_prot_err() might race cxl_detach_ep() calling
> del_dports(), and cxl_trace_dport_name() then does dev_name(dport->dport_dev)
> on freed memory.
> 
> I see __cxl_proto_err_work_fn(), cxl_handle_rdport_errors() and
> cxl_pci_error_detected() all take the guard first, should we do the same here?
> 
> 
> Though I didn't poke this issue out in runtime, I guess it needs
> FW-first, cxl_aer_* enabled, and a concurrent teardown. Not an expert of FW,
> let me knowo if something already rules it out.
> 
> Best regards,
> Richard Cheng.
> 
>  

Hi Richard, 

Yes, a port lock is needed for preventing dport being freed here. This could be a 
use after free in the path's trace dev_name(). Thanks for pointing out. I'll fix 
this in v20 with adding: guard(device)(&port->dev)

-Terry

>> -	cxlmd = to_cxl_memdev(mem_dev);
>>  	if (data->severity == AER_CORRECTABLE)
>> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_corr_prot_err(port, dport, pdev->dsn,
>> +					     &data->ras_cap);
>>  	else
>> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>> +		cxl_cper_trace_uncorr_prot_err(port, dport, pdev->dsn,
>> +					       &data->ras_cap);
>>  }
>>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>>  
>> @@ -232,14 +188,15 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>>  	if (!ras_base)
>>  		panic("CXL: UCE with unmapped RAS registers");
>>  
>> -	if (cxl_handle_ras(port, dport, ras_base))
>> +	if (cxl_handle_ras(port, dport, ras_base, pdev->dsn))
>>  		panic("CXL cachemem error");
>>  
>>  	dev_dbg(&pdev->dev,
>>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>>  }
>>  
>> -void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +			void __iomem *ras_base, u64 serial)
>>  {
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -251,12 +208,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
>>  	status = readl(addr);
>>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		if (is_cxl_endpoint(port))
>> -			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
>> -		else if (dport)
>> -			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>> -		else
>> -			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>> +		trace_cxl_aer_correctable_error(port, dport, status, serial);
>>  	}
>>  }
>>  
>> @@ -281,7 +233,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +		    void __iomem *ras_base, u64 serial)
>>  {
>>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>>  	void __iomem *addr;
>> @@ -308,12 +261,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	if (is_cxl_endpoint(port))
>> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
>> -	else if (dport)
>> -		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>> -	else
>> -		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> @@ -354,7 +302,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>>  		 * cases below handle AER recovery for devices without active
>>  		 * CXL.mem traffic.
>>  		 */
>> -		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
>> +				    pdev->dsn);
>>  	}
>>  
>>  	/*
>> @@ -386,7 +335,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport, int severity)
>>  {
>>  	if (severity == AER_CORRECTABLE)
>> -		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pdev->dsn);
>>  	else
>>  		cxl_do_recovery(pdev, port, dport);
>>  }
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index a5c62c71060d9..a371174536a8b 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -113,7 +113,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  	 */
>>  	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
>>  		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
>> -		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport),
>> +			pdev->dsn);
>>  	}
>>  
>>  	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
>> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
>> index 7f2a9dd0d0e3f..df42d119c53dd 100644
>> --- a/drivers/cxl/core/trace.c
>> +++ b/drivers/cxl/core/trace.c
>> @@ -2,7 +2,42 @@
>>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>>  
>>  #include <cxl.h>
>> +#include <cxlmem.h>
>>  #include "core.h"
>>  
>> +const char *cxl_trace_memdev_name(struct cxl_port *port)
>> +{
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +
>> +		return dev_name(&cxlmd->dev);
>> +	}
>> +
>> +	return "";
>> +}
>> +
>> +const char *cxl_trace_host_name(struct cxl_port *port)
>> +{
>> +	if (is_cxl_endpoint(port)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> +
>> +		return dev_name(cxlmd->dev.parent);
>> +	}
>> +
>> +	return dev_name(port->uport_dev);
>> +}
>> +
>> +const char *cxl_trace_port_name(struct cxl_port *port)
>> +{
>> +	return dev_name(&port->dev);
>> +}
>> +
>> +const char *cxl_trace_dport_name(struct cxl_dport *dport)
>> +{
>> +	if (dport)
>> +		return dev_name(dport->dport_dev);
>> +	return "";
>> +}
>> +
>>  #define CREATE_TRACE_POINTS
>>  #include "trace.h"
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index d37876096dd7c..910aceb2ca3ab 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,44 +48,15 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(dev, status, fe, hl),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -		__field(u32, first_error)
>> -		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -		__entry->first_error = fe;
>> -		/*
>> -		 * Embed headerlog data for user app retrieval and parsing,
>> -		 * but no need to print in the trace buffer. Only
>> -		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
>> -		 * the remaining entries preserve the 512-byte ABI layout
>> -		 * rasdaemon depends on and are zero-filled by the caller.
>> -		 */
>> -		memcpy(__entry->header_log, hl,
>> -			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>> -	),
>> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_uc_errs(__entry->status),
>> -		  show_uc_errs(__entry->first_error)
>> -	)
>> -);
>> -
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(cxlmd, status, fe, hl),
>> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
>> +		 u32 status, u32 fe, u32 *hl, u64 serial),
>> +	TP_ARGS(port, dport, status, fe, hl, serial),
>>  	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(memdev, cxl_trace_memdev_name(port))
>> +		__string(port, cxl_trace_port_name(port))
>> +		__string(dport, cxl_trace_dport_name(dport))
>> +		__string(host, cxl_trace_host_name(port))
>>  		__field(u64, serial)
>>  		__field(u32, status)
>>  		__field(u32, first_error)
>> @@ -93,8 +64,10 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	),
>>  	TP_fast_assign(
>>  		__assign_str(memdev);
>> +		__assign_str(port);
>> +		__assign_str(dport);
>>  		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__entry->serial = serial;
>>  		__entry->status = status;
>>  		__entry->first_error = fe;
>>  		/*
>> @@ -107,8 +80,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  		memcpy(__entry->header_log, hl,
>>  			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>>  	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
>> +		  __get_str(memdev), __get_str(port), __get_str(dport),
>> +		  __get_str(host), __entry->serial,
>>  		  show_uc_errs(__entry->status),
>>  		  show_uc_errs(__entry->first_error)
>>  	)
>> @@ -132,42 +106,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> -TRACE_EVENT(cxl_port_aer_correctable_error,
>> -	TP_PROTO(struct device *dev, u32 status),
>> -	TP_ARGS(dev, status),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -	),
>> -	TP_printk("device=%s host=%s status='%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_ce_errs(__entry->status)
>> -	)
>> -);
>> -
>>  TRACE_EVENT(cxl_aer_correctable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>> -	TP_ARGS(cxlmd, status),
>> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
>> +		 u32 status, u64 serial),
>> +	TP_ARGS(port, dport, status, serial),
>>  	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(memdev, cxl_trace_memdev_name(port))
>> +		__string(port, cxl_trace_port_name(port))
>> +		__string(dport, cxl_trace_dport_name(dport))
>> +		__string(host, cxl_trace_host_name(port))
>>  		__field(u64, serial)
>>  		__field(u32, status)
>>  	),
>>  	TP_fast_assign(
>>  		__assign_str(memdev);
>> +		__assign_str(port);
>> +		__assign_str(dport);
>>  		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__entry->serial = serial;
>>  		__entry->status = status;
>>  	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s'",
>> +		  __get_str(memdev), __get_str(port), __get_str(dport),
>> +		  __get_str(host), __entry->serial,
>>  		  show_ce_errs(__entry->status)
>>  	)
>>  );
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index ed419d0c59f2f..f1ef8b78db18a 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -125,6 +125,13 @@ static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>  #endif
>>  
>>  struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
>> +
>> +/* trace-event helpers */
>> +const char *cxl_trace_memdev_name(struct cxl_port *port);
>> +const char *cxl_trace_host_name(struct cxl_port *port);
>> +const char *cxl_trace_port_name(struct cxl_port *port);
>> +const char *cxl_trace_dport_name(struct cxl_dport *dport);
>> +
>>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>>  					 const struct cxl_memdev_attach *attach);
>>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>> -- 
>> 2.34.1
>>

