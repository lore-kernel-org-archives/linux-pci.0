Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879912BCF4C;
	Thu,  7 May 2026 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178835; cv=fail; b=XhUhzTkoxBuGEhvZ0Fs+Fhk0DE1wFnYC5Q1WFIPONGoSOANygw4wfOxAdLEgeMMM0Ze8F/14zLPVuhKKcmVJSh0vns813wkcLYLQcsA+LJrhOW8ZFOe1gucsapACs6pCCvoN179U0mqvRz9a3HN+tbVa1VvjsaAtbSp/+YWXoM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178835; c=relaxed/simple;
	bh=BOw+KOdP+/IooSnAxxNUL/2tkQN8oJLCr2Wcp5JGMeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3Escx0PJefZxs4l1vE2Yh4DyX3U38YgRPRaH+CGe42wMBufmDdP0PPK5juHt27IlA0e72n5uC3d0I8GhgngqmhO/ZQ9zv9hmdbbE/QDcmoswQSNrw3Mga8Hu//FiY6rxvGbyWcGm4n2bBceNSN70lwx9zKhqt1zXyQBdt2pRVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6MN/bij; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6MN/bij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWGjKV8xqqQJMv+E7l3TzHr1gYGdu9aBMjWfYnsmItMVDUpqdOv1nCxcmFgCSBCMR7blbPmRjvs9ALhJjJ/t+wd+JKkwozJlccMu60/P9tPyUVSZjkgay0GVFhzLzb64/4VikwjfSuwUkolrOWhR4lz77HjBin9/1eBZ+3H+2eiuyEWpyfSXafdGVgSRtr81MeTOnkPJVQ9aYWrPJ+hFLDfIpy+3Uf4jlVVknJlsp/98E9A50FD7d3pBzStgJ33ip+5vm8uDhwhzH1B039DFRjo2OBoDqNTqD/NvdOJezlGJsIciwXpBSHKo6jbS3yXnjKtUsSglNE9IaZfVii+5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6zEJ3lJbeZs5gj1g8CVwzED4BGUBnr9Tspd8AEHJOY=;
 b=n0kCWKoKaY4jDQTPPcxlw1LqBZ8Vqchet+Wr7EPLNJHSTDVfwtg4RVou3wI4cySLjQFgKyQ5hWroGMPUxAvEK2LxG65iaz1XO/HoYHlfw1JBhebZpWn+5Ha7vc1s9XXgFrejvI513xpg89a/6FPKQBFrtsfXd0l+TKfQaYH1wNc/TZLazmMceyxsdn0n+MoMg39TAkwLkR8aNwt9EyxmJEgArvZS2SmdIntx1SANgAn5+6ChwXApqCWPPqMj7mlN2YBRKDYMk1fFobwgp4un5YjAcLeybJMDC+D5QmPh8rWt2y6nfHTuriwAco2vsp4e88sFA0XEbxHIGz5Dv7QFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6zEJ3lJbeZs5gj1g8CVwzED4BGUBnr9Tspd8AEHJOY=;
 b=Q6MN/bijgex95l30Ov+omzuj8Mt3bUOLDCrEovzXYPPj2PljPqEe2SJRlkF4vGYpoIR/k3yQI5R27/zso70+23knJtHF2qxeOQs/v4HRWAK5tc8Mzuk40IoRKMYQgrSkxzyKNerPUtLPWrvfjzR87q3zYoWZA1yx07yuSNHNbmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 18:33:49 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 18:33:49 +0000
Message-ID: <8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
Date: Thu, 7 May 2026 13:33:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 djbw@kernel.org, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-3-terry.bowman@amd.com>
 <20260507190836.70197e24@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260507190836.70197e24@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:610:33::19) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 02863f24-379f-4244-97a7-08deac672e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	icc3+kVOxrvUN87eatPXNN6MXRtyYonkUD3QMjmhBmys41AXs5N7kK39pKqXIFZPJjyiH/BCxHBYisilYfiT+sZzx9h5IrHXGTxjXzuxhgjzLfnr33S+qeKPryohrvKJlPJaglIGMl8/LwpgIOyHxdAS7reiHfbgVR5rg6QJwtsRZY5lsiKr3LOgFpK2esid1AZa/9hvjJVyy6Ks9JaR+0uUUyIo6MYv7pW3sTdy43e9pbPfdzkr04Ot7dPkOj2fL6sw9CVHln5Ne39XBuj2WiRyRXi26WeDp9vVCKJw/f7EDqrrnfTdXViZV3VqLp9+ZtSe7/J9AsTa4HRDu1oFUhFeMwAO0CJKmmJzZ164zcrRJHnNnGVQa+WurVQV+QvTgz9EBYXcy2eosB3N86H+sU7ZOE7is5u8c+yY7LV+Klg6ocATFs5kQPKBP5KJ1c+oS4un4d21Bu3hFpsQM1xi4iVdQIUrjbPBRetevroWpukBV/I/g8ed6zpJJ0QoYSCuixWjN45ouwn8emr7G8BCmlI3K3TyLGGf8FCZPV+4M4D0Eols/o3aHv4OpsfrHxnVWMkEbaLZziKwO1egGGCzPKCtruYIe1Cw1RWjddLP+ozaQJMOdeVsjZ5Bq8y0p/rFtp52QHyMpCpgYKd8ddxYIcLnh10YvNeMdsKJuIPcGMdsb42TrlXRP77WVrAepgdK5kkMLn/ncCYRYMIz8y4O0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0hCVGdwSGt0MGZsSUw2bmR4TWE2ZkFtT3NwVlpxMHRZb2JPUWRiY1lYVnV5?=
 =?utf-8?B?a05jNERYeit0RTN4dFRyaWVDdXdOOEpBVlV4eTRWbE5rWER3VWROY3pHS1dH?=
 =?utf-8?B?ekExaS96VEk0cWw4cjFSZFJmakNaRVM3OWhDRzJVUTNLamJrVkRIeUpmZjNR?=
 =?utf-8?B?bW9ZWmlTeU44RUtLZGd6aitCY2FMNDRvMGhGUTZRNkxoUXhnLzVXdjBBNHc3?=
 =?utf-8?B?cUJrazQwSVBjZ0dzMHI0THp6aytjdG5iYmZwbG1saWZGZjBIUGZBKzNoSmFH?=
 =?utf-8?B?NDdnS3pJdDhMVmpLeTd5NEUveGxYUnU4YkM1QzBiQjNnTHJzR05NYjAxRkJi?=
 =?utf-8?B?VEUxV29VczhCY1JTNUJvVUFhUUdRWTNpZUVHVm15ajJBSFRwTnovVy9ZWW5E?=
 =?utf-8?B?RkczZUNrMm56ZG00Nmplb0VHdGFRS0hCa2ZWNnl1M2VVNlF1UjZxREtMOWxP?=
 =?utf-8?B?d1FWOTdlVDdQL1lIL2Vic21TTkxnZ1hyZDRjaDkvMVVWeGR3RUZSNmVCY2or?=
 =?utf-8?B?cjR6TmdkOFljMVhMVFFtVnA2YWwrUnZadGFWcFllN05LWlExM2E1ZlFDN2ZI?=
 =?utf-8?B?U09ENWRhaWlDbmJuRHpub0xEZHhnYTk3OXhheE5PVXZZb21vMjdndzh4aHl2?=
 =?utf-8?B?ZjBXbS9SU0hwNGNkUjZ2dGNpbXdieVhsMzh1cGlkcXdWeWRMNi9CUThIS2Y1?=
 =?utf-8?B?T3ArS0Z1c3VCMGR3MGE4T2J2c2xkVTVLZ1hYRzE4MDhBQ25CKzZpc1hGRys0?=
 =?utf-8?B?V1N6aUdIZzhVdm5YUHZUbTFMRGhCaVZ5b3h6K3VVVW5MZFlrWFY2bXVIREt3?=
 =?utf-8?B?NDhYajR2d09nNENHVm43Q25EdUcxbm5XbGkvT0JtWXFZd3VoZzM3WExEcHBK?=
 =?utf-8?B?QzZWeEhzNTV4blpYQkEyTy9oZUpNN3Z3bWZTQUFCVjdNUGx6QlNGZlZialBZ?=
 =?utf-8?B?SWpScXpOK3N0YVB6U3NEbStXQnV3bWlLVGh0bHN5VHZWVnZJell0UXlhT3RW?=
 =?utf-8?B?WnJCNVlqaVdPdUxXNGV2NTdqd3U4cDZNUWpvT0pFTUtXbnBwaHZCNlZaSnlR?=
 =?utf-8?B?V2hqWEcxTWxPMXVWOGttOXR4aWF3YXVPZjdVZEdPMG5adkYyc1krZE8wSXA2?=
 =?utf-8?B?dXI5S2tCVUpFeGNiaVU0Tzl5T213czZOZU9RQVpNV2xmSDVNWW1hOGFWUGdF?=
 =?utf-8?B?MjhkWEtuSnY3a0hlTVRmWDd4cXFrVSt3aVBwbjMzWlc3QXFPZks4M0QzekNm?=
 =?utf-8?B?QnREbU4xcXd3WDQrY1VOLzJZeEE3TVZaeUpiN3BjMnNybCtzTzZXRGxLU1ov?=
 =?utf-8?B?c2JwTm96MDF0c2pUV1orUXMxS1lpMkgxRmp1QW9wenkydC9HTHFGdkhyL1hS?=
 =?utf-8?B?WmNKaUJzSW02c2FWYjl5TzBObE1TYTg3c24vR0llQ1JzUFJ0YTFieHVMdHVM?=
 =?utf-8?B?Z2RZUnRkd0dMNVZtSTBYV0tlTFRnRmV0TXBhdHVhL3MwZWNqVHZJV045MEtX?=
 =?utf-8?B?SnBlcGFYQzIwM080dGxTbytJZlMzWkk2US9RY0p4aStRNlFJWWlRZmR4Vytk?=
 =?utf-8?B?cnNoWHc4TktHbHNQTklSOHczWmVoeHp1Y2M4RG9PczFGTm8vZW9JVW9DZ3hQ?=
 =?utf-8?B?dGwwcWdYNmpkcVVTRFhzM091NmxRRm4wdEVjcktRWUdXOUl4TDlRN2Z6cDlJ?=
 =?utf-8?B?NGRaSURJQkMrTFM2QkliMTlnMXA0U2NPQ0ErOCtBSDVRZUlVTWxMZnJlK1RL?=
 =?utf-8?B?K096V3VPVHV4cjNFV2tMTUYveWxzNkVpK25NakNwUE1KSzRlQkpZUEVMbkN5?=
 =?utf-8?B?S1JOb3NYSCt4Nm1INS84c1lSNmhlNUZremdFOU9ibVZRSHlpUTVQMHJ2MTN4?=
 =?utf-8?B?dWQySTg0QklxY29JSjJlUzF5WE9wZTc0Vk4yb2NHOWlGMjI3SDlkOVB4V1lj?=
 =?utf-8?B?aHcrZm96MWJZeVpXQ1VVZGFRUWs1RFllYnFXcTEwelQzTEh1L0xqVE1KbjJX?=
 =?utf-8?B?Z2xYNEpDR3dJVVdidXdYYjltMXhqT1lQMTRXejJuYjhYeTIzaHpIRUpCUlp3?=
 =?utf-8?B?YjUvcmo1VldmRGZQZXpacFZpUXdPOFZpaGJFMElYSVJvZXJoOVRkNUlObDcw?=
 =?utf-8?B?Y1JmZEw2bllRYzRRNVoyOXRKcXd6M25Ea1NrKzArVTgvT2krRjZiaVhHSDBh?=
 =?utf-8?B?ZXRDWlZlSWVaeGoxb1d0RGhGNDVKaWIzNjF0NExIWmJkY2lrWDNuZUcvL0Ew?=
 =?utf-8?B?R3J0M2xxL3J6WXlDb1U2aGp4MkVHREo0SWs0Mk80cTlKWk1wWjJuT0pIZzFO?=
 =?utf-8?Q?AmByK2nMThLEmfk4ri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02863f24-379f-4244-97a7-08deac672e2a
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:33:49.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJi0M/+1UZ3nhdx5TEcZazEMoiQJgZFemh3JOk3kYB7f5b659gYFCF8zPjrvWcC3wL2Whc+Ot2PiNbt0TFIZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

On 5/7/2026 1:08 PM, Jonathan Cameron wrote:
> [Some people who received this message don't often get email from jic23@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 5 May 2026 12:30:20 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Dan Williams <djbw@kernel.org>
> 
> +CC Mauro - rasdaemon related - see below.
> 
>>
>> CXL protocol error logging uses two parallel sets of trace events. The
>> cxl_port_aer_correctable_error() and cxl_port_aer_uncorrectable_error()
>> events are used by CPER for CXL Port devices. The cxl_aer_correctable_error()
>> and cxl_aer_uncorrectable_error() events are used for CXL Endpoints. Update
>> the trace routines to use the latter for all CXL devices on both the CPER
>> and native AER paths.
>>
>> Generalize cxl_aer_correctable_error()/cxl_aer_uncorrectable_error to
>> take a struct device * and a u64 serial argument supplied by the caller.
>> cxl_handle_ras() and cxl_handle_cor_ras() gain the new u64 serial parameter,
>> sourced from pci_get_dsn().
>>
>> The CPER path keeps its existing Port-vs-Endpoint dispatch and passes the
>> new arguments to the unified trace events. The CPER path will be folded
>> together in a following patch.
>>
>> Remove the now-unused cxl_port_aer_correctable_error() and
>> cxl_port_aer_uncorrectable_error().
>>
>> **WARNING: ABI BREAK**
>> Rename the trace event field "memdev" to "device" so all CXL device types
>> (Ports and Endpoints) can be reported under a common field name. Note this
>> is an ABI break for userspace tools that key off the old "memdev" field.
>> Specifically, rasdaemon's ras-cxl-handler.c looks up "memdev" and bails on
>> NULL, so an unmodified rasdaemon will drop every CXL CE/UCE event once this
>> kernel ships. A rasdaemon update is needed in a separate series.
>>
>> The need for the field rename was discussed in v16 review [1].
> 
> This concerns me (sorry I wasn't paying attention to the v16 thread).
> It is a userspace regression against code that is out in the wild and typically
> not updated in sync with the kernel.
> 
> If you are suggesting breaking ras-daemon at the very least +CC the maintainer.
> 
> To get to a unified tracepoint add a new one that does what you want, but
> maintain the existing ones as well.  Userspace can then migrate and maybe
> in 5+ years time we can delete the non unified ones.
> 
> No actually comments on the code, just left it all here for Mauro,
> 
> Thanks,
> 
> Jonathan
> 

Dan was clear about using a single set of CE and UE handlers for all CXL RAS 
protocol errors. While I understand there may be concerns, please direct any 
objections to Dan and clarify what changes are required to avoid this 
repeatedly going back and forth.

[1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/

- Terry


>>
>> Also, for CXL Upstream Switch Port (USP) and Endpoint (EP) fatal UCE,
>> the cxl_aer_uncorrectable_error trace event is not emitted. The AER core
>> only retrieves PCI_ERR_UNCOR_STATUS for Root Ports, RCECs, and Downstream
>> Ports, or for non-fatal severities. PCI config reads to the source device
>> are expected to fail otherwise, so the AER core never reads the status
>> word, is_cxl_error() does not classify the event as CXL, and the AER path
>> handles it instead. In this case the AER handler consumes the event and
>> logs it as an AER error without calling the CXL RAS handlers or trace
>> logging.
>>
>> Before this patch, Endpoint and Port devices emitted different events:
>>
>>   # Endpoint (cxl_aer_*):
>>   cxl_aer_correctable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'CRC Threshold Hit'
>>   cxl_aer_uncorrectable_error: memdev=mem0 host=0000:0c:00.0 serial=0: status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
>>
>>   # Port (cxl_port_aer_*, no serial field):
>>   cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='CRC Threshold Hit'
>>   cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
>>
>> After this patch, all CXL devices emit the unified cxl_aer_* events
>> with the same field layout:
>>
>>   cxl_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'CRC Threshold Hit'
>>   cxl_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'Cache Data ECC Error | Memory Data ECC Error' first_error: 'Cache Data ECC Error'
>>
>> [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>>
>> ---
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
>>  drivers/cxl/core/core.h    | 11 ++++--
>>  drivers/cxl/core/ras.c     | 39 +++++++++++--------
>>  drivers/cxl/core/ras_rch.c |  6 ++-
>>  drivers/cxl/core/trace.h   | 76 ++++++++------------------------------
>>  4 files changed, 49 insertions(+), 83 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 82ca3a476708..132ac9c1ebf4 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -183,8 +183,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  #ifdef CONFIG_CXL_RAS
>>  int cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>> +bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> +void cxl_handle_cor_ras(struct device *dev, u64 serial,
>> +                     void __iomem *ras_base);
>>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>  void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>> @@ -195,11 +196,13 @@ static inline int cxl_ras_init(void)
>>       return 0;
>>  }
>>  static inline void cxl_ras_exit(void) { }
>> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static inline bool cxl_handle_ras(struct device *dev, u64 serial,
>> +                               void __iomem *ras_base)
>>  {
>>       return false;
>>  }
>> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>> +static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
>> +                                   void __iomem *ras_base) { }
>>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>  static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 006c6ffc2f56..d7081caaf5d3 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -13,7 +13,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>>  {
>>       u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>>
>> -     trace_cxl_port_aer_correctable_error(&pdev->dev, status);
>> +     trace_cxl_aer_correctable_error(&pdev->dev, status, pci_get_dsn(pdev));
>>  }
>>
>>  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>> @@ -28,20 +28,24 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>>       else
>>               fe = status;
>>
>> -     trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
>> -                                            ras_cap.header_log);
>> +     trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
>> +                                       ras_cap.header_log,
>> +                                       pci_get_dsn(pdev));
>>  }
>>
>> -static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
>> +static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
>> +                                      struct cxl_memdev *cxlmd,
>>                                        struct cxl_ras_capability_regs ras_cap)
>>  {
>>       u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
>>
>> -     trace_cxl_aer_correctable_error(cxlmd, status);
>> +     trace_cxl_aer_correctable_error(&cxlmd->dev, status,
>> +                                     pci_get_dsn(pdev));
>>  }
>>
>>  static void
>> -cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>> +cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
>> +                            struct cxl_memdev *cxlmd,
>>                              struct cxl_ras_capability_regs ras_cap)
>>  {
>>       u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
>> @@ -53,8 +57,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>>       else
>>               fe = status;
>>
>> -     trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
>> -                                       ras_cap.header_log);
>> +     trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
>> +                                       ras_cap.header_log,
>> +                                       pci_get_dsn(pdev));
>>  }
>>
>>  static int match_memdev_by_parent(struct device *dev, const void *uport)
>> @@ -101,9 +106,9 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>>
>>       cxlmd = to_cxl_memdev(mem_dev);
>>       if (data->severity == AER_CORRECTABLE)
>> -             cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>> +             cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
>>       else
>> -             cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>> +             cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
>>  }
>>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>>
>> @@ -183,7 +188,7 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>>
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>> +void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>       void __iomem *addr;
>>       u32 status;
>> @@ -195,7 +200,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>>       status = readl(addr);
>>       if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>               writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -             trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> +             trace_cxl_aer_correctable_error(dev, status, serial);
>>       }
>>  }
>>
>> @@ -220,7 +225,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>       u32 hl[CXL_HEADERLOG_SIZE_U32];
>>       void __iomem *addr;
>> @@ -247,7 +252,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>       }
>>
>>       header_log_copy(ras_base, hl);
>> -     trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +     trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>>       writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>
>>       return true;
>> @@ -270,7 +275,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>               if (cxlds->rcd)
>>                       cxl_handle_rdport_errors(cxlds);
>>
>> -             cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
>> +             cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
>> +                                cxlmd->endpoint->regs.ras);
>>       }
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>> @@ -299,7 +305,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>                * chance the situation is recoverable dump the status of the RAS
>>                * capability registers and bounce the active state of the memdev.
>>                */
>> -             ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
>> +             ue = cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
>> +                                 cxlmd->endpoint->regs.ras);
>>       }
>>
>>       switch (state) {
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 0a8b3b9b6388..61835fbafc0f 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -115,7 +115,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>
>>       pci_print_aer(pdev, severity, &aer_regs);
>>       if (severity == AER_CORRECTABLE)
>> -             cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>> +             cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
>> +                                dport->regs.ras);
>>       else
>> -             cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>> +             cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
>> +                            dport->regs.ras);
>>  }
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index a972e4ef1936..6f3957b3c3af 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,49 +48,22 @@
>>       { CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }                         \
>>  )
>>
>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -     TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -     TP_ARGS(dev, status, fe, hl),
>> +TRACE_EVENT(cxl_aer_uncorrectable_error,
>> +     TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl,
>> +              u64 serial),
>> +     TP_ARGS(dev, status, fe, hl, serial),
>>       TP_STRUCT__entry(
>>               __string(device, dev_name(dev))
>>               __string(host, dev_name(dev->parent))
>> -             __field(u32, status)
>> -             __field(u32, first_error)
>> -             __array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> -     ),
>> -     TP_fast_assign(
>> -             __assign_str(device);
>> -             __assign_str(host);
>> -             __entry->status = status;
>> -             __entry->first_error = fe;
>> -             /*
>> -              * Embed the 512B headerlog data for user app retrieval and
>> -              * parsing, but no need to print this in the trace buffer.
>> -              */
>> -             memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> -     ),
>> -     TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> -               __get_str(device), __get_str(host),
>> -               show_uc_errs(__entry->status),
>> -               show_uc_errs(__entry->first_error)
>> -     )
>> -);
>> -
>> -TRACE_EVENT(cxl_aer_uncorrectable_error,
>> -     TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>> -     TP_ARGS(cxlmd, status, fe, hl),
>> -     TP_STRUCT__entry(
>> -             __string(memdev, dev_name(&cxlmd->dev))
>> -             __string(host, dev_name(cxlmd->dev.parent))
>>               __field(u64, serial)
>>               __field(u32, status)
>>               __field(u32, first_error)
>>               __array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>>       ),
>>       TP_fast_assign(
>> -             __assign_str(memdev);
>> +             __assign_str(device);
>>               __assign_str(host);
>> -             __entry->serial = cxlmd->cxlds->serial;
>> +             __entry->serial = serial;
>>               __entry->status = status;
>>               __entry->first_error = fe;
>>               /*
>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>                */
>>               memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>       ),
>> -     TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
>> -               __get_str(memdev), __get_str(host), __entry->serial,
>> +     TP_printk("device=%s host=%s serial=%lld status: '%s' first_error: '%s'",
>> +               __get_str(device), __get_str(host), __entry->serial,
>>                 show_uc_errs(__entry->status),
>>                 show_uc_errs(__entry->first_error)
>>       )
>> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>       { CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }     \
>>  )
>>
>> -TRACE_EVENT(cxl_port_aer_correctable_error,
>> -     TP_PROTO(struct device *dev, u32 status),
>> -     TP_ARGS(dev, status),
>> +TRACE_EVENT(cxl_aer_correctable_error,
>> +     TP_PROTO(const struct device *dev, u32 status, u64 serial),
>> +     TP_ARGS(dev, status, serial),
>>       TP_STRUCT__entry(
>>               __string(device, dev_name(dev))
>>               __string(host, dev_name(dev->parent))
>> -             __field(u32, status)
>> -     ),
>> -     TP_fast_assign(
>> -             __assign_str(device);
>> -             __assign_str(host);
>> -             __entry->status = status;
>> -     ),
>> -     TP_printk("device=%s host=%s status='%s'",
>> -               __get_str(device), __get_str(host),
>> -               show_ce_errs(__entry->status)
>> -     )
>> -);
>> -
>> -TRACE_EVENT(cxl_aer_correctable_error,
>> -     TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>> -     TP_ARGS(cxlmd, status),
>> -     TP_STRUCT__entry(
>> -             __string(memdev, dev_name(&cxlmd->dev))
>> -             __string(host, dev_name(cxlmd->dev.parent))
>>               __field(u64, serial)
>>               __field(u32, status)
>>       ),
>>       TP_fast_assign(
>> -             __assign_str(memdev);
>> +             __assign_str(device);
>>               __assign_str(host);
>> -             __entry->serial = cxlmd->cxlds->serial;
>> +             __entry->serial = serial;
>>               __entry->status = status;
>>       ),
>> -     TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
>> -               __get_str(memdev), __get_str(host), __entry->serial,
>> +     TP_printk("device=%s host=%s serial=%lld status: '%s'",
>> +               __get_str(device), __get_str(host), __entry->serial,
>>                 show_ce_errs(__entry->status)
>>       )
>>  );
> 

