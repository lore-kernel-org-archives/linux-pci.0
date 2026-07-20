Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B7433040;
	Mon, 20 Jul 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560174; cv=fail; b=MGGNd1ANawT+iZj2B+naehHro4EgIkp/nxQfIFCyCAw+6neDEjiGaktOG/uUjGKeg/0SUdfkh2sGNGgdP3gHMTtBbk8lrby57ttRoxoTBIRUKRizYkOVwTZJCrjI0l1IBx9rNW5YesWiif0GCb7vK4V6fwM9n+g6U2Ekm7nMklU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560174; c=relaxed/simple;
	bh=4pakgUN0DXF41sEAbFeFCPcCoLBdAotpwBq5ZqDKf3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M9dJZs+DFC4PQIz5e5+8UOMt05sS+yGHxdRGJjj9npt29bzz01Za5GmhGHfbbNsVIi5DLpfLXTSZmRy+979/Ewah4e0E2jXGSOJdJ0GESbWAmJEZSkjYDUReEO6slVVKHJ5LGFPmyi+A1nUHTeCvfsFCe6ZirOGZIecwejIu3bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DE3L+ujX; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DE3L+ujX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6TPO1dPkNgHb5N+rHzbGmZ6NcSY8UK+HHVhwz7R/I0EUJ1MdETm6mZKJ9cqHsBwuhA9lyttzrXwp9HBjxs9FGpzY0767OEV9HRV+FuMvahIj768xcMoOmw6xQLIqSd/trgiahuVCPU5q9wPWIioFEry9HPbRYGAiqbyFj5ATuzPVMvM8dnJVk9NNJpFaIZus7pV5VMFuFUCy3QGMBIq+ebkyLZbA2+ipPnI42/WZgNI1OtKtZHzLPdyG6cUi/5D2Y6rEwFmvjpcMtceTWwVEqdOaK7IPBTxBg0Zu1j8cXrqlV8IUwbsJki8+sY/TVX0kRAW7F2XJ3bpqjvGgN5Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v31109H7PgL/PEFYgE4LFdnr57IQWEd+5Om5Jq6W77s=;
 b=T/2eGU5p9F6Y9YRjOOj8h2KNDpZDkvB13y5kVV0eovAxoFR4oqJuVsFd7jBtxpumgF4Hz2e9ey7HwCBqC73Mc5pk2WEbYkT+ZFso+pQKkXsKW3TePCmgexGsR1wg1VbdYhLMtbyaC//9iO4oxlN5ORgnh6XnWKPEHTikJbR/nqXdkca8wEXS25VfAfCOJp2tO1nxNQfwtejXSFyiVk9YIlgg1p7d216GTu36lIDahISUk3UWiiew5ekG7WQpcVNT586XzygdqwDbullIXxqfqisEH3NSkDOPIG3eghSrIcv5/ZWUjAiaymfLZSiMICfkWOE2u1uT/W3Hh3Lyi/twzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v31109H7PgL/PEFYgE4LFdnr57IQWEd+5Om5Jq6W77s=;
 b=DE3L+ujXDOIfoSIgEYO5LJzss+FHukCP3YWaINBVzdD4v9gEOe6pOrOnGPSHdiZA6kDVqNWpKsrsccEG2OIavNg9imy7UhQUfv8Yga8PqbZ1JlKwLba0MaOrhdRBkH1i3yldj0TwflqgnDT9cIPcumxA4e6GRWBLAEFnijndxD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:09:27 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:09:27 +0000
Message-ID: <a1d41630-be4f-486a-8d28-d3040e2ac83b@amd.com>
Date: Mon, 20 Jul 2026 10:09:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-10-terry.bowman@amd.com>
 <20260717225348.720041F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260717225348.720041F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::27) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: e355798f-38f7-43d7-9d39-08dee670e477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DLm9HqaDECIyK6io+6WWZhD+s9axPDDLr88V/R2YGdJFkm0ms2+jXvXwFIFJr3VL0yXKav/aTuLrA6HwdN8tK7fvsM1BsJx91+N3qHm2wglyqy0euFLmnn9+LG+yGbh1FnbpF2pkx16JPEgbRMoA/7utO1/CYOBYZJY2Lex4pbqe73YtaVi9t9VAmIuqLFPRsC8JmenjSPX+M33NjdRLMytXaQjpqVz0stgk+qEZuLC22EQYxBEu84ep42260U9wkD2pqouotlqn/F/xOXiBxv98jdx4KY/9iFZMRxTBj/F3Hjod55BZbc77JHJnxz5RXmdcgrCkJwDB1WczCInzu6KR8XgPib5gfrG7HcI/7nhHguhK00T7gJQvJazwY3jYoqrRQIhqsZp6RqGlwPVTIFkJ4MkAJ8LulXBjcobgrYPfE5lUc0ClyJFix2NRW/stCt6yHEf5EnG7y1/7/RU7LKTQ0mBGuK/d4a/NSOVBqx2emP/GvFJA9l0uyS4uu4zZHJ2fRkoMKjjWLNNEMJEA4G2M1FsmqAXzRwddlK3Op85Wk80c0xjOTwnkVyjJj3vlWQPU7Yd2q7ig0MYSFFLIge3WSj1saz1aeKHhJdpikOQM/s72pwqFXWgE1oUNS0HhYB+1sqFdjjV+PZKIXC5e4zN9A4WcGnzRjNpsSZnDLw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlIZjJGV0xrT1VFQzhrZzJaeGgrVEwyTkROc21mUjhlVmlZeEZRTWY1Z1Mw?=
 =?utf-8?B?Wm9WL0c4bUNiQ21ZdU5pdEVMNzdDTFJIdlhMV3J6cy8yNGZYdGc2Vk9hLy93?=
 =?utf-8?B?MDB1aWhvL0RQdEsrd3I1S0UyckNNV0ZrMDJPVm9CSk9ZKzAxSVNZY3lBRnU1?=
 =?utf-8?B?UFBxQkE5UVYwRTNXalN0QW9sS1cyZXVSZGx0Z3RYenoxYzVIckZDSHpBbEpk?=
 =?utf-8?B?Tk96bzBBSldXZEJnNUJqNUY1OUREbXRMTnFUeDlSRmt5bUg0czArbDlJa3NL?=
 =?utf-8?B?bkdMVTkyTnVWNm01VlhLWHVzYnEyNVZVLzRmWnVBQTB5SGRtUlhTZHFCd015?=
 =?utf-8?B?T3dYMFd4a3J4V2xTYTRYYlVQRDJoVUZUYVp6S0ZIbnpQaWY5bDVQdllHdG15?=
 =?utf-8?B?ZG5kejV3WTNzVGhJVUo3MmhwL28wbmtCSTNEL1oyWUJFcUZzbTBUdWJ3a1dq?=
 =?utf-8?B?K1pyWnZSa2VsenZPSmYrZ1lnVlhwZTZKYytSVWh5UG1acnNQSFBXWjlYTGJ5?=
 =?utf-8?B?ZnJYdUdBY1VZMnN2LzRyblF3VkhKZFlZK2I2MFp2TlJsdWRmSlpLYVFpZ2VO?=
 =?utf-8?B?d01XWU1WT3RnVERvQXcweGNHMkZHZVoxUlcwTCtaYkM5N0hGdTRwQ3JTb0hs?=
 =?utf-8?B?VHFQWGQxSVZWYXM4SktSK1FKUlhKT09jZnp2Y1RTU3JBYktZc1V5OHc0STcw?=
 =?utf-8?B?NkZJT05zWEdhUVdjU3R4Zyt0QXFMZklrZkVlRTZjdlBydWtqL3hlTitFSWRO?=
 =?utf-8?B?Z3RYWEFUUmRpU0MyMnV0cUNHeGxaZWkrZXlRRTVHeTZpaXpSZElLUnJ5RXJM?=
 =?utf-8?B?NVlmbHZwR2tSL0c5NGhtaTlIKzJSOVhvemIvb2RqWTlVejdEWnllOGhPei9F?=
 =?utf-8?B?aHhwUmhZckp1Y014RDUxRU5Cb2wwMXFuTDkxZ0JJb0IxQ0VncU1wblRxQWpa?=
 =?utf-8?B?NFVPRnVRK0tlRFdlS2FOZ2RZY1lkM0VKckNWK1psNHA3TFpkcXNnVlJuWUpM?=
 =?utf-8?B?QzUvTmxvRnIyYm5FK0ZWaW1vVmcxQVpiV3VxekVPMnVJcWFtSy9SbGY1YmIv?=
 =?utf-8?B?dG05eWNpS2U4Snp4ckhjSFFFVWtuc09WTXFJb0o3dVkzNkV3Qy9WaVV6NHh0?=
 =?utf-8?B?dHNLbFkwcWpqZHdCSG4xWWU0TmJ6UXkyRmtPSzdGaGdtS2drTmhna0NsRUNP?=
 =?utf-8?B?WWQ2a2x6VU9IMmpzQk9KbmY5OVE0OW1TREN2MHdEZ1lEeGM3NndCUkVDd2ZP?=
 =?utf-8?B?aXRMeEtwM3FBbXlkaTBkU1Erc2w1UjlDSnZPSVdRTmVZNGtPQ1daUlorSity?=
 =?utf-8?B?dmN0OVdRdXVIUFAydDQ5V0VNTXFrbURncjc3Nk1CbG14Slp5cXgrVUE4OWNa?=
 =?utf-8?B?ZXp1eE1XRnpWeE1VV3ZRRzZaNVBlOXFHM1BwZk1CaDFsdklXZnNBdDlLS0FZ?=
 =?utf-8?B?V2U4Sm5ubkhxeEFtSUVFQkl3U1pMeXdOcmgzZm1xakxjWjIyMGxVREVWbWR2?=
 =?utf-8?B?VHBjcFlPd2Vvdi9Jd2U0aUxKZ01wZzJUazZsYm44VkVwMHJLYlVWSldLdnNl?=
 =?utf-8?B?dXZYY2dtaG92ajEvNHZnK2w5S1ZoTGk0U1BQL2NWdVVoNVUybk5WbjhqWEZ6?=
 =?utf-8?B?Y29ZZXF5VzJXenNoVy9vTERGcFE3cU8xcWtNMUQ5TnQzNnUrY2tQVFFXLzNP?=
 =?utf-8?B?K0ZOa0wrNC91dmI5d0trWHhjVzJyM3lyQmg3eDV6ekw1QkE1Z0EycFN2cmlt?=
 =?utf-8?B?a0NQcWtiZ3doNDB4N1pYSnlkbC9GV2RwaENZdmVmeGNMV0p6ZGJPVUZlWjV3?=
 =?utf-8?B?Y0tzdzNIK2lhWGhmZzVpYW5Cd05ORWRCTnpYZHJUTzRPM1JJYmI0U0U4NEJD?=
 =?utf-8?B?R3oyTHpGQ2lqSlF6RXhOWWJueitSMnI2WWFyVHVGNW1HNERhdjRnSm9IWjk5?=
 =?utf-8?B?TVNGTm1HMEZBZ2hzeUdwUWxCZE52QnEweHFPalpFcWxsWC9GSGhoWFNhZE91?=
 =?utf-8?B?dVJFaTBHeUpjbGVlcWhMcnkyTFRDL0cwVTFBMmZQdS94Qmk0UTd6Z2RZL3Z0?=
 =?utf-8?B?N256dnVkaExMQXRqRlRUWFhQZTc5QU5FaVp0VGFQeG4vMXBpV1E2bzMycjQ0?=
 =?utf-8?B?RTZraU10SVdFNTZ2cTFId01RVUNLc01sR1d3b3haRXNXUVFtM2RQbkE0MFVZ?=
 =?utf-8?B?Ymw1TFVianJBVm9TbnMrcUxXWUxKSzZyWExueW1WeC9aTm51aUVJYXBjQ1V3?=
 =?utf-8?B?TnN5bkVBOEt1ZzltNzI4WGdSUjdzaFVQenduL1o3UnZvYzR4ZUh3K2JCNURl?=
 =?utf-8?Q?stbRxHOBXS0BqCRT25?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e355798f-38f7-43d7-9d39-08dee670e477
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:09:27.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjQSt58EQH1FL/NHiBE1u9H6cCD1sugKJiRjWnFGZLRWaIH5s08aTK5Yh2ztIjUAHtBTgXOuYC/0/d08bM45WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On 7/17/2026 5:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional kernel panic on PCIe link failure for idle/unused CXL endpoint devices.

This is a false positive.

The comment addresses the corner case when the device is removed from the bus
even momentarily or transiently. In this case the memory coherency will be lost
as cache lines will not be accessible and continuing operation risks silent data
corruption. The kernel panic is intentional.

-Terry

> --
> 
> --- Patch [9]: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler ---
> commit 01bcb4332c20e7d1dcce013851a595e79f03a892
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> cxl: Update CXL Endpoint AER handler
> 
> This commit updates the CXL endpoint AER error handler. It documents the
> unconditional CXL RAS read policy and relies on this policy for CXL endpoint
> error handling.
> 
>> Document the unconditional CXL RAS read policy: on a dead link,
>> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
>> triggers a panic. If RAS registers are not mapped the read is
>> skipped and the frozen/perm_failure switch cases defer to AER
>> recovery for devices without active CXL.mem traffic.
> 
> Is this assumption about RAS registers not being mapped accurate? 
> 
> Looking at cxl_endpoint_port_probe(), it appears to unconditionally map the
> RAS registers via devm_cxl_port_ras_setup() for any present endpoint.
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> 
> [ ... ]
> 
>> @@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  		}
>>  
>>  		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> +		 * The CXL RAS read is unconditional regardless of channel
>> +		 * state.  Any uncorrectable error bit set in the CXL RAS
>> +		 * status register triggers a panic because CXL.mem cache
>> +		 * coherency is already lost; continuing risks silent data
>> +		 * corruption across interleaved HDM regions.
>> +		 *
>> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
>> +		 * UCE bits and also triggers the panic - this is intentional.
>> +		 * If RAS registers are not mapped the read is skipped, the
>> +		 * panic is not reached, and the frozen/perm_failure switch
>> +		 * cases below handle AER recovery for devices without active
>> +		 * CXL.mem traffic.
>>  		 */
>>  		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
> 
> [Severity: High]
> Does this regression cause a system-wide panic for idle or unused CXL endpoint
> devices?
> 
> If devm_cxl_port_ras_setup() unconditionally maps the RAS registers during
> probe, cxl_handle_ras() will always execute the readl() here. During a
> transient PCIe link failure (like an AER frozen state) or a surprise hot
> unplug, the link is dead, so readl() returns 0xFFFFFFFF.
> 
> Because this sets the uncorrectable error (UCE) bits, cxl_handle_ras() will
> return true. Doesn't this mean any transient PCIe link failure will now
> unconditionally crash the system due to the subsequent if (ue) panic check,
> breaking standard PCIe error containment?
> 

