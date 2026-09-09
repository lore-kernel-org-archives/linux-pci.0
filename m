Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91739569F04;
	Wed,  9 Sep 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970393; cv=fail; b=B8FaxVwsA+CaweGcZUoeF1yGIzWv+yXhwWf7Hio58uZ/3XgPJvwttp/mAlW3KvrUOZJvJG3ZHf4ugZml74tsb5hy08WVxPFRt5pj/B2Gky13ksLd2SWYfndhb1vnpAAvHA3OnKaQMYdJhzfbo1Z8uahTlmV98Mooj7mo0uVCRTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970393; c=relaxed/simple;
	bh=MKF6oLkrg55x3VNnCv5krselPsDC32vqFWgdnQZOqgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DlddX7VAwDTiW1z5U4oM5NEOXLwnz2WY7b1uYMQPMmBtPBlFtJYYpmsI8CMrRUwQXD+G+VRInIU4YuDs1pPfIqjOtEKJsbUpgx6r2xwQmi7wVur8cbgSBVh2CAP/Cqt2d8CZ3OSqrAl4W3YVMqEtpiMVmcdL/Jopq/wuTnVRdgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwReehV0; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwReehV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGYk4mASqg0vNDoP7jm7BY9TMZAD9tQCiNJ66F/nq4LRxZ6sfnV2VY2kp1LZYyqIm5gaXXFI8U8n5akW0kFJSwz++eMH6mUGPwSPpUDbEwMdpKIcNjfhpMLRix9DohuVe5BnkBXC6GHrJPKVOpYP0dCpeCTT2QQ+RHzQvRuvfuj25DhuhxuiNAL3NbnTPlTlCfjn0p1Qe5aoQGUgD3Gn7tIlOCtvfTxa5rr9o7zagAgs4GxI1neeqzG2VZpVTZoE/pxbdlyNV19DoqLRTJ8MnLpLIshazARiQ1jKE2Ey/wIh4KIP7ItIWXWAkgqWiue6Eu+TUsRnQ35bP+QCJn1/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+ZKiS59+qvntzMHNx0qsVpnw8+bl9g/K/VSvBRPm9k=;
 b=x0gsC/DbVogZBFw0CtVFMT1y+9gTDdD4ox3bEb6jOuPMOoVBVMSSgSj+BSKHew9w2dmIhadJHJ3V3uT5kj507ckjCUdQkU+9auFuz2W0YjGe7fsX4AYKN6At9YZgK/yuDd1D1VPnqN4LT/qi581oWg1P+XPgpvRXZdcjHAOH97T83d99INmlA0hPpat12toK9CYmv37N0SvAFbuYxboT8g8b8DxAPsOWDVTMcAoGuQnzH07w9JC6OUCG4WLQSyVHA7zSncyDvtVRPsFjY61aa3RKwVVpWM7tYFrEr7yvqrHWpBHxSQgvfAx9vHbFXPJNHRMcgTz+JI+Q/k/AcnAHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ZKiS59+qvntzMHNx0qsVpnw8+bl9g/K/VSvBRPm9k=;
 b=AwReehV0sYIuP3Do3+IhgLNfw2ZhrwlDG0zH816XUfa82/NUMjDcqjpG1p2U9eINvcFs0A+fZDyfcKif4nO9028/qf05mT4XfD+bwkaGBzxrH1rsUteXSJGeoDFIDLkRoPzeiuSe3k5xReGdxDyEsjLgwKenk/SK0zEC3I6uZEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 9 Sep
 2026 16:13:09 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:13:09 +0000
Message-ID: <66451f43-5180-4832-931b-f96de6dd65e2@amd.com>
Date: Wed, 9 Sep 2026 11:13:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
To: Lukas Wunner <lukas@wunner.de>
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
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com> <anijY3eTVWSqHLxh@wunner.de>
 <apkxP_fydVjpULaT@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <apkxP_fydVjpULaT@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:510:f::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5b12ed-13e7-465f-c4f9-08df0e8d3d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2E66sf12XBr++rXpsxY/p1vpTC8NmX5dClBGutQXatOu2UXqprInbDNLymYeWOCFcxtE0HL+3yS9i8hboCUWD2HvaUNPI4vkp5rL/iTy8IUN3r+5halhqxvKhrUHdlP+R1xYNK2yPZ/Nwx+BefL2jqSNy6dbVzmuZjUubBWShgCNo3sEEGIrbNOGzkADY19Wjwzmf0x8tP4AHMgFck6MG04ftHu68xjgKlJKZmFJ4aIDvaznKjP5SLGLO5Q/4LHi2mlpOBxxfu7vW4u+RJ9w364+wT7i5kDsPUjuM+WSWY1vrKKTsxgEjrrKIhl45cZ9jl9Wf2gqfig7lv4KmseJlseI97M9JFz86zbwHZ/Xzpf3RPIM/OHI9gdrf5tw/oz1tZD1tcmpFygtxjfQsC6qsjFXdPGyjCcdUdyRzQHGCw0s6e4qy8ECmfeavDu6Q9lI5WU0Pp3RID+6ZCTDeNo6gbADZszM2TQzFa0Ll3+M7fm5SfkYEdHk9ILPqcpZ3M5kNPI6X7xhAPCYVMFCOik4CO847DquMxEbWLzIBf0+3hIpDbMBH/9yewLlu1V9VSQxYiz8+1eOdna4JlHQiHcageAFuE/g5CCF50IFwz9jMoN/x6Yi46Z9CWCV2SF0cgRGN5wYJ0Z2Yolyl/eHpjyMTBQponXZc2WwaZinYqVfQdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1BRRGdsZjVFR3N3ZDRsUGQyUGVaL2dNRWlYQmxsMnAzb1VyQWMwMSttY0pp?=
 =?utf-8?B?NEdtSlJ2REQxVElsZG9FbnZDdllvckR2d0JKZEpTM3FhbWxkeFF6dG9FdGt4?=
 =?utf-8?B?UmhQUGZiM0hYZ2NGODVjWlB1cmQ1dVBBY01nQ0hXclFVWW9sU3ZMZit6ZDJV?=
 =?utf-8?B?WmF6Wi82YU54QmptU3MyQlZHQ2pjOWp2bFZreXVyQzdUTGswMmlrQWR2cUlG?=
 =?utf-8?B?RlNFbFdSbFhyS041TU4xcmI0VTAvTFMrWHlpeDVrdzczaW9USGVFOWR3YWxX?=
 =?utf-8?B?R1dyazFmQ2xmZE9oQnlLQVhWSVBpSWtrK1BMaWdkUXUrMFI2dHNWOEVsNEtI?=
 =?utf-8?B?UndUUmpnbUZPNzdvM0VDQ3BBaWpZbSt5OFByTHdZZkhPaXpaUDJ6bThHWTVS?=
 =?utf-8?B?Ulk2blJicWNkWFE2RENsVDl1MXpMeWVuNXhKUmFmNFBIWkRJTFBQemEveW8r?=
 =?utf-8?B?R1Rmd0c4dlJkcUxlVHRJeWxNOWg2UnQvQ3RKQlJBbDdKZUlXc2p5Slc1ZDZv?=
 =?utf-8?B?TGZRNk8rLytKNDZaU2plNlE1ZGFCUS9uSFd2MXAxVlJDaW45SUJUUUZWdkg4?=
 =?utf-8?B?T1RCRVZJeEowb2x5MldJdk9kNlBmZTlldHZtTkZoMnpXcTdkNEZoQXdyUCtu?=
 =?utf-8?B?WStCRE81ZWM5cnN3dmpnckY3ZkMyd2hxdnQxQmcvdE9KOU9IdVpqOGpGSTJQ?=
 =?utf-8?B?NE5NZ2tUWVo1VXJhYlFISXYzTUJSOXZOU2NicTFlYkNqSmNFNFNSWk50SGx1?=
 =?utf-8?B?YmwyOFpHVU43QkR6M0hFaWEydEFJM1VVRzJJYlFFZmI3elNwb091SGxXNUt3?=
 =?utf-8?B?UU91aTc3SU5Ba1hCZXVBWVYwS0tBaGh1d2tyY0pvMGpST1lRbWlhM1pWeHdD?=
 =?utf-8?B?MCtVYUNzZjVqVmVWTFhwMU9XN3JzVmErbzR3VHRSVGZXVEZNS1lQUWNmMVkz?=
 =?utf-8?B?WGZiN01BM0w2VXhlR0Jqa1JXbEttZlNOaVFVYi9ScWxnYXZlOTlwSUdUY1N0?=
 =?utf-8?B?RHFkTGhCekc1cDJRNCs3SE10UG1IZlBhMDRwUGhZaDZpTzdRZWM4U05OSkgv?=
 =?utf-8?B?bnhTbzlKb3dpanlGV01mSmQrVGx3VWFHUFlaM3lNc1FIcytpUWJWdUpCdFdF?=
 =?utf-8?B?U1ZkRlZpNGxuajNEWkJUd2gzSUVVZjZwUGlmQWpBKytYa2hEYlZyWCtkT29W?=
 =?utf-8?B?QmR5LzhIWE5SVnl6VkhqSm1CNVZVOURQMC9rcW9EamR0UDFKaCtqMFNqdVY4?=
 =?utf-8?B?UWpyVFEzTG8vWStaNDdDQ1dUUXg4SWJSSXFsTEU2MkpPUkFsNjZrL1BNVGZy?=
 =?utf-8?B?TWtXSjJxWmw0TTFBcE83c3JJVFhEOEprbW1mbm9BUyt3cGsra0k4ZFZOTXUz?=
 =?utf-8?B?d3pUNmZRcXVmN2MzSmJsL0lNWHJJc2llVzVqR2lJdmNOaXdFaTI2RnpWd3Vq?=
 =?utf-8?B?VmExV0hZTm1MNjI2dlV1d0prM09Sb2k5UTBIVGZCaUFYUURMdXlHN1dERStW?=
 =?utf-8?B?UWFvSk9wWCtTVGNDTUtYL3NncDlMUmR6L1JmUG1pVFB4eWRxVWdMRTBNU0NO?=
 =?utf-8?B?Z0FvWUxkS0FWRERHdVhRdlRvSW13RGRmMElJaTdyV2MzenhjTEExMy9MUlFO?=
 =?utf-8?B?V2wxU3pBZWI4T2lIdDUzT2pabTk5RFhtamJoSzVob0lkbG93NFZEckhhVWpl?=
 =?utf-8?B?WWg1TGduOTYwcnkvVnd0REhsYmlsT2VTSVpiV3c0eFpaWEVGTTllQlVFZXhk?=
 =?utf-8?B?Slpmakl6M3lWVnhEcFJGOS8vZHl4MHlOVFBocG56T01EMk1sWEtFcHRCcldx?=
 =?utf-8?B?SWFFbldQRHEzejU5Zzh5dHJUV0tOU3MzOHhQc0htTmQ1VUZGTUxSeXlieG4x?=
 =?utf-8?B?K2VlQnZ1KzV0K2lZbUl3aWQxRU9QRVRQTlhncWJwQlJkUG9uMFA5R1lHTkc0?=
 =?utf-8?B?czhCVHlrUlpTRktOMmpYUENLeVVWVDJZMzRrc0ZWWVJkWWlmN1BZR2syMStp?=
 =?utf-8?B?USs5dk40K1k5MjN2SFpmbkwxR3RsZFQ1cG82NVlBZ2YvNHR2NnZPMlEzMDBO?=
 =?utf-8?B?MjVjanREa1Zmc3Vob3NUOXJqMWwyRHU4ZytmTndLU2xXYlM3QmEvMUpnaG9p?=
 =?utf-8?B?T29QZlRNeGl0NVROdmlmMTlFeUVYSkFmUDNrODFFUlovcDFBWDFRNUFpUDU3?=
 =?utf-8?B?VkRDUVU3N2ExRE9Lemo3RGkxMlpEbmQ2L25VYytNNFJBWlR2SXhybVBEcFc2?=
 =?utf-8?B?MU5iN3F6bWFta3hYa3AyZ0xEM1JNdVh6ZUJjclF2UUdiajBYU293U3U2aXU2?=
 =?utf-8?Q?yL+xSvnMr6IG1gCfvw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5b12ed-13e7-465f-c4f9-08df0e8d3d89
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:13:09.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEulHIHuKyqg1HQbo5Uhm06gSKjgron0q4wyp3OZ4/p2pXvbWbeZsLbagCo8RtBaWm24GHqe2jhJt8gxfme6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188

On 9/3/2026 3:35 AM, Lukas Wunner wrote:
> Hi Terry,
> 
> You've submitted v20 of this series, but the following
> questions haven't been addressed yet AFAICS.  I'd be
> grateful if you could take a look:
> 
> On Sun, Aug 09, 2026 at 05:57:23PM +0200, Lukas Wunner wrote:
>> Am I missing something?  Is a scenario ever conceivable where the RCEC
>> receives a message with different severity than what is inferred from
>> the registers by cxl_rch_get_aer_severity()?
> [...]
>> These so-called Advisory Non-Fatal Errors set one bit in the Correctable
>> Error Status Register (Advisory Non-Fatal Error Status, bit 13) and
>> additionally one or more bits in the Uncorrectable Error Status Register
>> (see the commit for details).
>>
>> cxl_rch_get_aer_severity() is not able to cope with such errors and
>> will incorrectly infer that the severity is AER_NONFATAL.
>>
>> Now I *think* this is not a problem because Advisory Non-Fatal Errors
>> are masked by default and the commit only unmasks them on regular PCI
>> devices, not in the RCRB of a CXL device.  Only once bit 13 in the
>> Correctable Error Mask Register is cleared in the RCRB will
>> cxl_rch_get_aer_severity() fail.  Right?
> 
> Thanks,
> 
> Lukas

Hi Lukas,

I’m sorry for missing your August 9 reply.

Thanks for pointing out the issue with CE and UCE errors reported
simultaneously. I agree this is a problem and have addressed it in v20.

In v20 I remove the unused `cxl_rch_get_aer_severity()` helper, take a
snapshot of the AER registers before calling `pci_print_aer()`, and now
handle the CE and UCE parts in separate blocks. The UCE status is logged
unconditionally, which prevents a fatal record from being lost under the
advisory‑non‑fatal path. These changes directly address the scenario you
raised for v19 and also cover any other situation where a CE and a UCE
are co‑logged. The patch is here: <https://lkml.org/lkml/2026/9/2/1629>
(v20 3/9).

Jonathan added a comment looking for your feedback on if the issue should 
be solved by changing pci_print_aer() to be non-destructive instead. It 
is here:
https://lore.kernel.org/linux-cxl/20260908020608.56e8c443@jic23-huawei/

- Terry
