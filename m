Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B334AB14;
	Mon, 11 May 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533455; cv=fail; b=vD93avf4+k+wWlBaWvGEgsJlmUNX01tkLoIiRyaJhagy6mZX67jM1lfnMLf1NLck4j25/a7Y+mCodQuRoyaL6tKq/sjR9wDKOdquESrXZ/yLLOxw/PI7xkwie6yK3Oi4BlKozK/bSsx3VuqlUaWAhwKFpDPLO3vw7dTRAL0Gl4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533455; c=relaxed/simple;
	bh=sJIY3FK4XBOKhZlxh0c7lCLw3Ne+UzObDjnlE4TCkMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYuXQRI71Oq9YaDNhYRf8jFxiHfWKH/NW4W/sIDWtZma9IBDtkTtIvY2uH4Iyx3D+/xUkDzyQiaTVeb3XjRxmWo+WLqlJLcsB/1DdaJI4F5VBYvAKa7gy7jCN4IT2fcoT28gJvTrdlImxPJyyJNvMYvtBWEZaMS1laoAf7gUNcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4qRsyuT; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4qRsyuT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIyCZ6D/OlA0zSc+uhp6v1zpHSqf0dPBA9uoz131R+tw5Ys7+9ySqJCU4tJmKsKKgFIyU5tRf9VtUQyKbgxFj0JnAc8U5eyqPyneVtPJGuoHxmZYoRbq9icE7fe3rC14hFq/yQYiEAoZdMgTNX2qrtgR3XNw8dcR37Z3JMrqpHiYtV1CqCCLMVlXNlUiDVUHDebKeTO9I46+DSISDdD9HYR763m/VEWVyCbLLPhicBUCTPUqRakZspLh8f8k7Gt42WwzOVElbnMys9/GHb2dP0Bbq0jcu6WhJlnLhbte82Clh4wmQuJeZeyoyAsYG3U+5/JfkyXfcMh1Rnx/GOyytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwkMC8zgxzALWRRwUJvpcs0YkHjDdpwho3WmWmfJgGY=;
 b=RO38qNhC60vNo3GOeMlkcBZOHcUOuekPByn60Um6UbFgwUEpexKhTgaGEJC94LoS//PsNHeyWSbjLKQa59FC80mAxfL52vWFWV5knCs7uPPK2R5dn/TFtmwu9QzbPOgAFKa8peSWiv958u/sR/xRGAwdXM78jVkmJNrgaCQ+5wE15cMuV2q80T+36Rxi/x2C1B0b5qFcAcp2KkJiGTpUmYOhtmVhoDP3M89jNOhqeAmUQg0tbNs1W9rpzVIJqQuMwxFlMDIlDgTcGOHfF21pn6GsB/n/mFdoJx994NQwSUYzOF7+Wuazmcy6XX83LtFo6iTq4K3NcUcm/BpHM0LVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwkMC8zgxzALWRRwUJvpcs0YkHjDdpwho3WmWmfJgGY=;
 b=q4qRsyuTcEhX/h58zi5QWL2QIOFHjNq3iJAM3czRsfyfFPLxfwCtScJDlnkKLTrgzngjJxE3vLdRtwKAYcoMWmDlCppI3XRDgfbD+e8oV5vu5zva0Pmp6/xge4kzKRjW9f/9Ym5KWytK8i9q0PoDeM/jfS9LU0CPIb8gLaGVR94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 21:04:07 +0000
Received: from DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e]) by DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:04:07 +0000
Message-ID: <8ab3325b-175f-4664-a046-6f4b1d472816@amd.com>
Date: Mon, 11 May 2026 16:04:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-11-terry.bowman@amd.com>
 <38155e50-c0c0-4f51-9777-243f0dd049ca@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <38155e50-c0c0-4f51-9777-243f0dd049ca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35)
 To DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9749:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: f64f1231-cde1-4450-bd93-08deafa0d6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|3023799003|921020|11063799003;
X-Microsoft-Antispam-Message-Info:
	TFxlcQCzeHDwK+l78mqoO2xdgKxWj16rta+gzXyRvnWT3pX6qoy4VpmHWBBovDdq52T9agXe0m6Kmgcf3GVrShh/O/E5XCY9sVpH3qbrt5sFbdT+2G9Q10i/TCsW/DtFckDkUxbKy3ERXyEIr4Ov3sHjU+2dZPDXl/c/zbX7yWHJRlHMgpfi7URLsviwtMF5AbEDifbCXAIHTIQGDLSsWvaiBzMvv8Od4QgYqVvOaw3WiDHZJiDx5N8BWHDYlM4qZVf814k5qz09ZSP7/OTp7aJyUY7Dj7mu2wtRc8zIFIsOjdRxGRx8veH6d6RO4gZPZDuMP98RdbNXTF0ZSFUN97ALlNDitp2QjIrZr0kS3bjHMS0rEjGeSOT+OzFYIS2UFYKpbOEEY43UaUkLPKlAGDqWNQLQnkax892E1vdUVrQ3kSKcoTuGJhLJJcwi7SqFgP92ivgmZm0J4B1Z2wmp2ZmYghNP8rsgRf3Cz/KhqMrEcJM2OKcUCSWgoGL8U4/xLOPYqr8sgswCVsjLnAeuwtkNA8wD/P4og+O3PYxOsDfnFK3v+4FtFzwQtGfIMh5i9flMzNOOJSF4HOVRMPXAAZ7qA13FqoC7ArXMHLMl6jrRwTgVrTmsjIWpHWHHiEnPmYphZioXXWDXyzw/4nHWYFjYzeJtL89VPTOWmGLusTngdJXHhUlPIha9qNP5kcx6Vr7r5QcFZ8PEpH8hNIKps8n/xd0mtLqbvLZaWsz3gzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9749.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3023799003)(921020)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVQxTnZKdzlpcTBNMXJoQkpZQlcwa09vUDNzY3MvYVl1Ri9nN21BMVh1dU14?=
 =?utf-8?B?SmNtdGZNTEdjNnUrS1BSTGRDSUowYzZpOWxpSTNLK01RQkZaTmdSR2NwYUo1?=
 =?utf-8?B?SGhnQ3RuUU4vaWlrQUFVdy8xekgyVGxVUWF4SzJNblByN2ZtbjYwWjFYWmZk?=
 =?utf-8?B?QW5kRG9nZDAzRy9jZ0xoNHB1Tmt3emF2UVorNlNsaFFHVjBDQXNvQ256cUky?=
 =?utf-8?B?cllRMEVSV21jMkdtWEJqUkZReWFxSXZqWmRlK3dxeXVEUVc4RnNqLy9tWGhn?=
 =?utf-8?B?OWVkRVNkMUJDQ2VtaERSL3hYcTdvVEtVU2JIRmh2azBIR0lZVTZlOTd6Q0xk?=
 =?utf-8?B?RU5pRTlhaTVpVzN6eVpIVTMrUCtjaEFkcFRnQVNyTmR1TWJ2Z2VpM2VZVUkw?=
 =?utf-8?B?b20xTkNtVkFsTWNTSmpraHVKRGlTUzJubWUwaVEyRDVSV21hN1dmZk5HYVUz?=
 =?utf-8?B?SlZRWWpmVTAyTUUxVXp6U0g1eTlQK1FxTWxHQkdaRmZCQk5Scll5aWcxSlp0?=
 =?utf-8?B?RGFRQzAzQTN5K1lzRWdWZTVOd3NzNzlVbkZSdnljRFhsczI2TVpHMkJjeHV1?=
 =?utf-8?B?TzN6dU13WTBNVDNTK3hiWkx2bGVqbHdvSkFQdkZaVldOVHY2VFQrbEhUNmkz?=
 =?utf-8?B?a1p6YWwzUVlYYnp0bDJmK0pOa3ZzSGhGaEQ5SG5WbG9TTXZRVERRM3FQU2lh?=
 =?utf-8?B?Rjh6RHZoczN5d2lpUW1aNGZtUnNaL3V2dHFCL1FPSHd1dlJFN3NzTHB1MkZr?=
 =?utf-8?B?aUxLZFlDemdya3RBVlpCWnhnUnlkSHcyZ0VZd0FGKy85OWx4M1huWWZqMWZm?=
 =?utf-8?B?VERrekxoSU5RdFBSdlVYcXNjT0EzK0kvZzc5ZVFPQmRPK1NtOW9WQjdvMDl6?=
 =?utf-8?B?c1ZBbWlPU3hjWVVBSS81S2x1SXUvYnF3Ylc1TWM2YVdGVmVIZWpSQkZDQnNj?=
 =?utf-8?B?Rkg4Y2ZvN1g0SU9SNUpTUFVVcTYzQUZ3VFU5blR5V1czRFk0alhDZUsvZzFS?=
 =?utf-8?B?ZEE3ZHNEc2RjRTlvQnBhMHM5UDJVMHZobVRJN0tKNDV0b2dJVC9GVGZMMVlG?=
 =?utf-8?B?K2tCOXgvYmR5bU5TNzFjYUwvNGVyOHVTK21KcXVaeGFMNWJ1WWxlZHROV2Jx?=
 =?utf-8?B?K1IwVGg3MCt2M3RibTFQUkJrS05qSXF3UnFFRDM0MlV6R2l1V05jYVY2dDkx?=
 =?utf-8?B?UE9oemk0dy82K1gxb2crTFhkZkxYT0ZaZVAzMzBxK1RXN1duNURUeUdVcTIy?=
 =?utf-8?B?b2JZQVJjQXV1bTBiZDRGV2NIbERHZ3Z6TDJWR3pkMnlvVVZzRTdvY3NoVitL?=
 =?utf-8?B?MHpYSWhMclZnaGhDRGJWNzFBTThCUDFWdTVzVzNSNi9vb1RXRUNEdmNhOHp3?=
 =?utf-8?B?SWNMeXE2THQySE1MU2F5bmZTMFBMSVF1aFNtLy85cExqeEdIRnU2Z1FzYTM1?=
 =?utf-8?B?N3NwaUgwVExQc3d5OWx1VEtDV3NEUlBVNENSR0Z3WHNLbmRxN00xQ3hONTAw?=
 =?utf-8?B?MURENlUrRDMwb2VoWE9nZlZlbHFRM0ozNEtDSGExRzRhU0YyMHFWQkJEejhU?=
 =?utf-8?B?ZEVTY3JnQ0VlY21uWVVEM3FpaFlXbTl4OEg5cStJRnd0OFYvRENtUnJFWVZB?=
 =?utf-8?B?UVVZYzAwR3pLV2ZGcWM2WXQ2b3RJTUwwaFY4ZHU3Y0o4Wkt3TE5PdkFCaE4z?=
 =?utf-8?B?VHFlSWJtMy9RVElnYWRGa0V2VXprY21ZN0hsakFNbUJHRC9leXREZDA5dXQw?=
 =?utf-8?B?VVVMU3dUWFpEaFE0UklKcVUxOU9QM2NtSVpmWFpzbXVZMXdLUFRuR0FKTlk0?=
 =?utf-8?B?VUJtREt0Y29Ua2svWnpjVCtCakpxckRTelZTTlBXZnVtRndCaUIrTEFtMzU2?=
 =?utf-8?B?dkVVWmtGOVpzNi9wNWNjNWxXemhFSFlWWlR4Y2ZjL1NhSVUrWXhRSFNqL2RH?=
 =?utf-8?B?SnM3UWoxSTNjei80ZGtxTkU1SEhIeEZMT0tBSWhHeGpaanpocld0WjBJMitm?=
 =?utf-8?B?VGNFMWRQS3ZGeUhMS0FTR2JUZENPUWNNNm9mQ3p5ZXd2N2FiNzJ1LytwNVUy?=
 =?utf-8?B?WC96Y0UyN0YyNTNXbkZJMkphRTRueHUwK3pzODFoNmtxbzVZWFV4VnRKWTZh?=
 =?utf-8?B?NitxNWh1eXJjbFlmd1J6TFN0TTJuYVNxV0tKb1phNmIzcGNvQ3puWHVQSzlP?=
 =?utf-8?B?eXAxcE1yaS9GcnFFM3Y2Q0N5azJocWM0bjJGRGRSNHo3TTBtUEFKU3ZBOUxx?=
 =?utf-8?B?UkJkTjNSZkRXcEcvZjNBcHJrcTFYa0xzZ2F2QUtkV1o5b24wbDlYdTRlanV6?=
 =?utf-8?B?NnlNejlkQlRRb1NvcGdCbGNTY0pONC9HM0FkcWVqQk1WTE1oMTFWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f1231-cde1-4450-bd93-08deafa0d6e2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9749.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:04:06.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwhnA6mYf2c9IJlE1Tka6Yqh73l26E+8hJ3qOZceqO5SlcD8klyA8vJGANjihWo8yrdnbt7wvyGKmJG8cGxbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

On 5/6/2026 1:00 PM, Dave Jiang wrote:
> 
> 
> On 5/5/26 10:30 AM, Terry Bowman wrote:
>> CXL protocol errors are not enabled for all CXL devices after boot. They
>> must be enabled in order to process CXL protocol errors. Provide matching
>> teardown helpers so the masks are restored when a CXL Port or Downstream
>> Port goes away.
>>
>> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
>> pci_aer_unmask_internal_errors() and export both for the cxl_core module.
>>
>> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
>> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
>> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
>> @dev so teardown callers do not have to special-case it.
>>
>> Wire cxl_unmask_proto_interrupts() into the success path of
>> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask only
>> runs when the RAS register block was actually mapped. Pair each unmask
>> with a devm_add_action_or_reset() registration of
>> cxl_mask_proto_interrupts() scoped to the cxl_port device. The mask is
>> then restored when the cxl_port device releases its devres. This
>> applies to Endpoints, Upstream Switch Ports, Downstream Switch Ports,
>> and Root Ports.
>>
>> Co-developed-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> I do wonder if we should save the original mask values and write those back rather than blindly remask everything when we are done.
> 
> 

Hi Dave,

This is only masking/unmasking the internal error bit. The other mask bits are not 
modified.

- Terry


>>
>> ---
>>
>> Changes in v16->v17:
>> - Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
>>   and cxl_dport_remove(); the devres action registered alongside the unmask
>>   is the sole mask path.
>> - Update title
>> - Remove unnecessary check for aer_capabilities
>> - Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
>> - Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
>> - Only unmask on successful cxl_map_component_regs()
>> - NULL-check @dev in cxl_{un,}mask_proto_interrupts()
>> - Drop static and declare in core/core.h
>>
>> Change in v15 -> v16:
>> - None
>>
>> Change in v14 -> v15:
>> - None
>>
>> Changes in v13->v14:
>> - Update commit title's prefix (Bjorn)
>>
>> Changes in v12->v13:
>> - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
>> - Add Dave Jiang's and Ben's review-by
>>
>> Changes in v11->v12:
>> - None
>> ---
>>  drivers/cxl/core/core.h |  4 +++
>>  drivers/cxl/core/ras.c  | 63 ++++++++++++++++++++++++++++++++++++++---
>>  drivers/pci/pcie/aer.c  | 25 ++++++++++++++++
>>  include/linux/aer.h     |  2 ++
>>  4 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 2c7387506dfb..ff39985d363f 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -190,6 +190,8 @@ void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>> +void cxl_unmask_proto_interrupts(struct device *dev);
>> +void cxl_mask_proto_interrupts(struct device *dev);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -207,6 +209,8 @@ static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>> +static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
>> +static inline void cxl_mask_proto_interrupts(struct device *dev) { }
>>  #endif /* CONFIG_CXL_RAS */
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index a98ce0f412ad..b45e2b539b5f 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -66,16 +66,59 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +void cxl_unmask_proto_interrupts(struct device *dev)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	if (!pcie_aer_is_native(pdev))
>> +		return;
>> +
>> +	pci_aer_unmask_internal_errors(pdev);
>> +}
>> +
>> +void cxl_mask_proto_interrupts(struct device *dev)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	if (!pcie_aer_is_native(pdev))
>> +		return;
>> +
>> +	pci_aer_mask_internal_errors(pdev);
>> +}
>> +
>> +static void cxl_mask_proto_irqs(void *dev)
>> +{
>> +	cxl_mask_proto_interrupts(dev);
>> +}
>> +
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  {
>>  	struct cxl_register_map *map = &dport->reg_map;
>>  	struct device *dev = dport->dport_dev;
>>  
>> -	if (!map->component_map.ras.valid)
>> +	if (!map->component_map.ras.valid) {
>>  		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		return;
>> +	}
>> +
>> +	if (cxl_map_component_regs(map, &dport->regs.component,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +		return;
>> +	}
>> +
>> +	cxl_unmask_proto_interrupts(dev);
>> +	if (devm_add_action_or_reset(dport_to_host(dport),
>> +				     cxl_mask_proto_irqs, dev))
>> +		dev_warn(dev, "failed to register CXL proto-irq mask cleanup\n");
>>  }
>>  
>>  /**
>> @@ -109,6 +152,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
>>  void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  {
>>  	struct cxl_register_map *map = &port->reg_map;
>> +	struct device *dev;
>>  
>>  	if (!map->component_map.ras.valid) {
>>  		dev_dbg(&port->dev, "RAS registers not found\n");
>> @@ -117,8 +161,19 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  
>>  	map->host = &port->dev;
>>  	if (cxl_map_component_regs(map, &port->regs,
>> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>> +		return;
>> +	}
>> +
>> +	dev = is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_dev;
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	cxl_unmask_proto_interrupts(dev);
>> +	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev))
>> +		dev_warn(&port->dev,
>> +			 "Failed to register CXL proto-irq mask cleanup\n");
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index b9c6c7b97217..eaa36fe0eb31 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1151,6 +1151,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   */
>>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>>  
>> +/**
>> + * pci_aer_mask_internal_errors - mask internal errors
>> + * @dev: pointer to the pci_dev data structure
>> + *
>> + * Mask internal errors in the Uncorrectable and Correctable Error
>> + * Mask registers.
>> + *
>> + * Note: AER must be enabled and supported by the device which must be
>> + * checked in advance, e.g. with pcie_aer_is_native().
>> + */
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +	u32 mask;
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>> +	mask |= PCI_ERR_UNC_INTN;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>> +	mask |= PCI_ERR_COR_INTERNAL;
>> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
>> +
>>  /**
>>   * pci_aer_handle_error - handle logging error into an event log
>>   * @dev: pointer to pci_dev data structure of error source device
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 979ed2f9fd38..c52db62d4c7e 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -71,6 +71,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>> @@ -79,6 +80,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>> +static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
>>  #endif
>>  
>>  #ifdef CONFIG_CXL_RAS
> 

