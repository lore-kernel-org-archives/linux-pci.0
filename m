Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E2352026;
	Wed,  9 Sep 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967287; cv=fail; b=O3XBMzPGA1ZNgahVa85tIKiGDX01KgpQFS70WFDf/YgCoWmkkdGtEtGHyVDdSydXF4sokVy7iqpAlLq0bb/jTxlrxUH+r62Ue/WG0T9iQLow8iDDfrJIw1c02kmuTFmpg64+O+ddw/B3GIGELCH+Jhjj7U6vGxQQ4xVIyHrxLKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967287; c=relaxed/simple;
	bh=fvxauK4kcU4PexVS7jwV42BwiUJUcFI2Xx5GgQ/oWLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTVJ+hBwdoZ1L9WFRE6C+3+y/btGt3vEjay3NSciUMFnPWmZaQQW0lgRVAlLZPV+be3dRAJMTJctvtzzTZ5V5sNneyKLvzmQ5WYcr7UwtBOi9zXBlbTohZJGCqDSES4o8xiPIrNkXl1uEzaEAieUpXDFRMxkTEoawkqGDsdBQYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=smhVl5HU; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="smhVl5HU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5RHYP+qSANzcwWldme+aICXPQRY6mOX4UXAYB5jUJT113sm5ZDnlCQPI0ciRDmAMcL+cAaZShhwZOxYUfy8zYmoX9Cs49eDvIBPPus3EG0S6LBOQ+NBT+ITC/iv4WbOjEfsyfggWL2MDBeMz0ee0CTIjW/BemZtnfccdOeP3h+Dmy/RzmRhE5UfOz4IxTASHszgzU1ALXPxkbM/K1Yo78p7o8PC+Y+5sCL7sFqMtzUO/ic0eIkTzLdEXvzmeSsh61N6m5REWIdXkXJW3YAxU0wt3GdPy5CEAwE6Qem7ycd2+FwOeB3bNVZ6/hMtbMxO9eltczYoEL/Vl80R4VyBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f6HF7eWlx14wNCY1I/h1idOdu2oUXP0TEoVB0fELKg=;
 b=iRBDvaKtI0XtAfaEFKZ9K+fFv/qrO1uz5moEC5tCFKniLheaZfxOIjSU0UlrttsD52Dj7zl/hWz19W/upvnwj0f7VuV2WfnNxSN+hTshSlQXBScTL9bm7F9+5Q7NoL3Gl/4ngb0s2kq6jukYuHRmmo4hNbzLMVawH3KEqZv/3Bi3F6mElgmNISKJS2OwkhAViJLhqaosVzDFCtszh8C4Fp/MLXGdB0YYijTM4JIDd4PDpzlNc6lHJU+mhLdfBNS/luqjPY1c9RBuNvRqQOQGYe+6sWhXS6h9lIfeCkvfjGK8WMADq+ZcBmjEb5uBU80H5FVqjwq88GvRoVfTduisNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f6HF7eWlx14wNCY1I/h1idOdu2oUXP0TEoVB0fELKg=;
 b=smhVl5HUEMA8oL1oxkZnD2QMqaIROutg2iO7y0REytbLk1+S2lyFKwuT4de822G0VmIdYP6jzt9IYsj3bdRMXLbYdqcOkkgmLLpsuRHCCWA3RCtK8SgTEGuzdFnlZBEIP0PZWxXlKJbWpSKu5G2eD30LYFH75Zhumha8BZgotDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 15:21:15 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 15:21:15 +0000
Message-ID: <b47ef6f0-1aa9-4fcc-8913-1a3a1cbb0fb3@amd.com>
Date: Wed, 9 Sep 2026 10:21:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS
 handling helpers
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-5-terry.bowman@amd.com>
 <2a1ddf3f-64fc-426c-9453-93b9e034dbf8@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <2a1ddf3f-64fc-426c-9453-93b9e034dbf8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: f0734a02-e3cc-44c8-33cb-08df0e85fd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|921020|56012099006|10067099003|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ecIC37SqvaK4qN9nJO8kTCXDdjpMbiOaVv1QhXUIsg/zFzFtn4ihPWWLLwvBNWsTZaL5E3Ilsb7IqPC1SalYKxACM1pHhLpvZLzT9Kr3HdnKC102XvUDfGpNsMlnWhrdOfnStIO9ZR5xPf3fsxIQ4ezDA9MPdQ2pSk/NgqM7nAUrjVnaarvwza5ov1j6IFqJ8U1im0UjLjjrH5Ph+b6XoA4dG9Wyg7w6LmVPel1+n2ssF4uLo6lWLWu4SQ5c/d6bnS/0D3jQy+GmxvHPwhmJH5E2UAnldAPVPrmIbyW8AuyHFE4liaei/a5jOw0fo0Q2UbZOmV0RFBQidarr9ojwFAHvNyYCQt9XIB7cbdrYlELKXQmvMg6mKc3zjhxOmEeqKXBgD/nxj9TpVH6aS4Ka3JHUMXKPepY/Cty8K2jD7+NY6HKgP4lUnVgnlAk1Aj10l/BBy9RLaXqCp006gohkm5AHVCUEUeVxRTMy4scCVon0DgHJ1cEhYkRgHPfb6Nv+DcIe/p70dSNtlizWJkWnyMKUFX1moDD7CUxk/FLatX13EL1Hd9vID712lPn2lGSgBAKU/62mfThAt2cei8TpBW8jnkH9wmhO2FzjY5TJrHM8i9C0q9vJgl2shgqrxNZb47PNkrC9qJ1yWTnMH1ueHmQw4wH5UBVxS2ONpDeikrw19pj7u1aT3mWE5k+XKZW8Q1JeP7DfWzq/hIOXTfcCOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(921020)(56012099006)(10067099003)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czljSkVnenV3aHFEN0VWaFYycnJ2c1BEbDRLcFBiV0V2aFVTakNOOGRrbkpS?=
 =?utf-8?B?eUowQWF4VkRURjhpd3B6V0ZzTGFUd1hEM3NhdWU0L3pxZFNOV2x3Qmg1Zi83?=
 =?utf-8?B?QktTcTBXei85TGJ4NkhnUlF2Z0FOeDhrdW0ram4vQ1RYaFB6ajh0UFJXQ0FI?=
 =?utf-8?B?anV1Y3JaSjNjbDBpRi85SXNKUWlDdFgvOEpqNGRGVS8rdmM5WFd3dWQrdUNE?=
 =?utf-8?B?dFl3RTRDZmhvZVl1TERqN0FnLzJoc0xmN1k2UlhHMEZ5K21OMjRacTl5NmVs?=
 =?utf-8?B?ZFRhTmo2KzRzbjNyTUlnSjZjb3prNm4rVmo0MWVDeWZhM3FXdUxHczd3enBF?=
 =?utf-8?B?TnU2QkNDVjhuQ3hoNVZublFxbFdUeHhQQXhlQ3NudXpRK2dlVlZOY1RYSXR3?=
 =?utf-8?B?b0VZZFduWXljamo2dXhjUWxld0t6NXNKN1RZRDlQNUF2WFIraVBwRFpwMXla?=
 =?utf-8?B?TkZaVmVSVlZoU3hCblAyZzJqdW9WRHg3Mm1LNDJnRytEdFozVUdnNHl6NTdt?=
 =?utf-8?B?bkxIZlpqWjZteXlObnR2UkhmbW1GcERjSFVxY0VrRFBXQUJVZ2wreFVMTzFV?=
 =?utf-8?B?Qk1hVGRPMzVKSis0OGlyMG8xdHVPclhuRUxvMWVsQkVDMktUeWxnV1hBWHEv?=
 =?utf-8?B?VVlLakRVNm1NNzUrQUVXU1VVU3gvSkhzRkhjd3g1UEZBTUNBd2h0ODNuRzFr?=
 =?utf-8?B?QlVoYW9rMjNuT29Ea2JQVitWYnYxWnEyNmRTTGZUZjFDdFBqemVsdDVhZ2kv?=
 =?utf-8?B?TUlpdWc2cFRJWVhtM2FFTU5mbzlrTHJJcUsrWEw2ZWU5S0NmS2JSV0Zsb1Vy?=
 =?utf-8?B?Q1lyN2F1dTVVMjMyNXFoNkROV3piMHpmYnRKZkl6NTBpRVlxVm1ZUTdHZWwv?=
 =?utf-8?B?MUs2c1VRRXlEYW5HUHNSWCs3dnNmaHBPMExpRTlNMnZiaCtwaUUrbEtuMjlD?=
 =?utf-8?B?eFlYRGV5bXVaeHJndnNWYUdFQ2xCdlpXSHAxNFQ3WkRXWitUSEp3WXQ4NEZh?=
 =?utf-8?B?aDRHTzg4RUhGamtUSnM4RUtVNG5CWW1PRWFURlZabWtrL0dQcWsydXNZeDIx?=
 =?utf-8?B?U2xLNTlXU2pxcVF3aC9vd1AyWDRzL3RTbjZTdC9uYnVob3g3NDhOVXRPMVFj?=
 =?utf-8?B?Z1Z1bUxSL1Flb1JCU1YyOFprc2htMk9LWmtJS1U1UklEWVpRZi9Rd2xwbmM3?=
 =?utf-8?B?ZWNtV29DaGh6REM4RHQreDZtY0NBNHdxMERMNW5vUFU3YnExTkw5SGY4eXBC?=
 =?utf-8?B?cVo2MGZidmRST08vU1hvV3ozb0pZazAzRVdxK0pJeFRyYlAvcXFGOEtOcGNG?=
 =?utf-8?B?UktocjJjU2s5WmJoRC8yMzZhOXM1TzlmQlJxWlRDVnhMdGZNNmpYWnU1NGND?=
 =?utf-8?B?ckdBOXlEMnNScU1qdW03RE5Hc3YrSXBJWVMrTnc2RG9RTmNIUnRsZHBmaUJ5?=
 =?utf-8?B?Zk02WkRobjEwK2EveTQrbms4cHlSS0dyL09SK1I5amM0VVl2aFdvZlc5c0tt?=
 =?utf-8?B?eURhS1RkejcxY0t5bFdPM0Fxd1Q2WWZxYXhrNmtqL3FwMlJpWjJPN3BqZTRN?=
 =?utf-8?B?ZUpqNnJEMzFVUjBvZzhDQlFlSHo1QWUzbTkvTW1OdXRlMmlUR1AxSjFoQWlE?=
 =?utf-8?B?bFBTUEloYUZYOERUZDNLQjNzNTBMUEtVUVh6L1R3MVFFL1RwYzM5Y1g4UDBL?=
 =?utf-8?B?QlIyV1d4Z3J6a0x2dFdhTjVsazduUFlFWTVxQ3V4cDNGRi80TjliUWpQR214?=
 =?utf-8?B?U3dZaFVCTUN1RVV2aTR6NVovbDd2dlRYaTNRZWxXbUIxWHNvMGQzbWZBV01U?=
 =?utf-8?B?c1F2WllHcWVzdDhDa3JGQ3BDSVBla283MmRGbFhLOU1TOC9IQVJ3S283YU8v?=
 =?utf-8?B?VEtrZnRUaWlJekJTOThMNzJmNmpNMGxKUEkrTkpqMUJUQ1hZRVQ1dzNFem1K?=
 =?utf-8?B?bm5CUVoyNTBaY3pJWkNIallvTUY3emxTcDlJZTl1VlJPV3duS0xQUTBxZjYz?=
 =?utf-8?B?VXBqakRzSHIvbkVpbUtoemJ3QmoxbFNBNkFveTNjcVZJSHpGUmlWZXJ3SHNw?=
 =?utf-8?B?SzdicHZFUlVDVnVnN28wUmVhQ0MyTC9Yc3pEdHBTK2pTTFhEYS9ydFBRWnQz?=
 =?utf-8?B?VWIyYXhNazVIY0RVWjg4UGFSQlNHeStkWWJyTVp3OHAxYUU1UFVHQlFSM1Bi?=
 =?utf-8?B?Kzg2SkxHQkJCdUp1RWxpVTcrcnQ4VzFXb1BYdkliMW1OYWpBN2EvMk5PcUdJ?=
 =?utf-8?B?V3JWU1hqdDJjQ2ovbFdDZytqVzZEaml5TERwMER0Qmpob050Wmx1dCs2Qit1?=
 =?utf-8?Q?P0vXvQIqhBpQHeyQ14?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0734a02-e3cc-44c8-33cb-08df0e85fd0d
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 15:21:15.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHB/vcqQagraZdXr954PzxEumQJmYLB0LO02MmAUPEMkY9CMQikIvwrgK8bMiQce5KWZSEt9yd9WEvMjeStsbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

On 9/2/2026 3:57 PM, Cheatham, Benjamin wrote:
> On 9/2/2026 8:39 AM, Terry Bowman wrote:
>> From: Dan Williams <djbw@kernel.org>
>>
>> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
>> a struct cxl_port * and optionally a struct cxl_dport * for the device
>> being handled. Passing a generic struct device * requires is_cxl_memdev()
>> to distinguish Endpoints from Ports at trace emission time. Threading
>> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
>> dport/port branching for cleaner trace dispatch.
>>
>> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
>> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
>> emission logic is split into three branches: Endpoint events are
>> identified via is_cxl_endpoint() and emit with the memdev, dport events
>> emit with dport->dport_dev, and Upstream Port events fall back to
>> port->uport_dev. This branching is transitional: the follow-on patch
>> ("cxl: Add port and dport identifiers to CXL AER trace events") unifies
>> the trace events on port/dport and removes it.
>>
>> Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
>> Port and Downstream Port to the refactored functions.
>>
>> RCH Downstream Port correctable trace events now report the dport device
>> (dport->dport_dev) as a consequence of threading Port and Downstream
>> Port through the RAS helpers. The following trace event rework ("cxl: Add
>> port and dport identifiers to CXL AER trace events") adds explicit memdev,
>> Port, Downstream Port, and host fields that provide full context for all
>> device types.
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>
>> ---
>>
>> Changes in v19 -> v20:
>> - None
>>
>> Changes in v18 -> v19:
>> - Added review-by for DaveJ
>> - Update commit message that three-way trace branching is transitional
>>   and removed by the following trace-event unification patch
>>
>> Changes in v17 -> v18:
>> - New patch.
>> ---
>>  drivers/cxl/core/core.h    | 12 ++++++++----
>>  drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
>>  drivers/cxl/core/ras_rch.c |  2 +-
>>  3 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 645824167f788..4f6b4702deb38 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -187,10 +187,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  #ifdef CONFIG_CXL_RAS
>>  void cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
>> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +		    void __iomem *ras_base);
>>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  		     struct cxl_dport *dport);
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +			void __iomem *ras_base);
>>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>> @@ -199,13 +201,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>>  #else
>>  static inline void cxl_ras_init(void) { }
>>  static inline void cxl_ras_exit(void) { }
>> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +				  void __iomem *ras_base)
>>  {
>>  	return false;
>>  }
>>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport) { }
>> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>> +static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +				      void __iomem *ras_base) { }
>>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 02c791f149270..e99dcd028b738 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -227,20 +227,19 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>>  
>>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>>  {
>> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>>  	void __iomem *ras_base = to_ras_base(port, dport);
>>  
>>  	if (!ras_base)
>>  		panic("CXL: UCE with unmapped RAS registers");
>>  
>> -	if (cxl_handle_ras(dev, ras_base))
>> +	if (cxl_handle_ras(port, dport, ras_base))
> 
> I haven't looked ahead, and maybe I'm missing something, but why not have cxl_handle_ras() just
> take the port & dport and call to_ras_base() internally? It's not a big deal, but it would
> make the call in cxl_error_detected() a lot prettier.
> 

There are currently 2 callers to cxl_handle_ras() and they manage a NULL RAS block differently.

- cxl_do_recovery(): For non-EP and non-USP CXL devices the AER UCE internal error bit has been 
confirmed present and panics in cxl_do_recovery() even when the RAS register block is missing.

- cxl_pci_error_detected() (Endpoint AER path): For EP UCEs the cxl_pci_error_detected() is 
called and does not panic on missing RAS block because the error was not confirmed as a CXL RAS error.
The error could be a an AER error instead of CXL RAS.

I agree the cxl_error_detected() call site would read more nicely. I kept the split for the above 
reasons.

> Either way:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks for reviewing.
-Terry

>>  		panic("CXL cachemem error");
>>  
>>  	dev_dbg(&pdev->dev,
>>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>>  }
>>  
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -252,10 +251,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>>  	status = readl(addr);
>>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		if (is_cxl_memdev(dev))
>> -			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> +		if (is_cxl_endpoint(port))
>> +			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
>> +		else if (dport)
>> +			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>>  		else
>> -			trace_cxl_port_aer_correctable_error(dev, status);
>> +			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>>  	}
>>  }
>>  
>> @@ -280,7 +281,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>>  	void __iomem *addr;
>> @@ -307,10 +308,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	if (is_cxl_memdev(dev))
>> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	if (is_cxl_endpoint(port))
>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
>> +	else if (dport)
>> +		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>>  	else
>> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> @@ -344,7 +347,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  		 * cache coherency is already lost; continuing risks silent
>>  		 * data corruption.
>>  		 */
>> -		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
>> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>>  	}
>>  
>>  	/*
>> @@ -375,10 +378,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport, int severity)
>>  {
>> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>> -
>>  	if (severity == AER_CORRECTABLE)
>> -		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>>  	else
>>  		cxl_do_recovery(pdev, port, dport);
>>  }
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 285eed5b828b9..bc6cf50fcc926 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -123,7 +123,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  	 */
>>  	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
>>  		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
>> -		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>>  	}
>>  
>>  	if (uncor_status) {
> 

