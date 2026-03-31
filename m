Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF912371D04;
	Tue, 31 Mar 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986767; cv=fail; b=F7tQSJe6c/icj2ANCQBZ7ylepffUQLYrC4BidV2TSy+21btwfIz4wreyoOooXjQZ16F/8zrqFzk127VcZxAoNec9MbAtsYdlw9SC/xBbCVr0CcSETicoHJg6yBUz2ZVY58Xj0/W6vGqUlxSkawHL2usHeUbI931oF2zAjQSbS7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986767; c=relaxed/simple;
	bh=2DRYFZ/cC+cwVsKXz019nVXJqeHymmjtNwgXDg8Hy4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jrqjaz3U8pGn49VjJ7rtt2YLx7MfNxT0XknA6YKFs5sUAsN4ePIFaI1Ifb0HKyVNLm25d7I6IPA23BuqrPz4ZudvBQ908xmdG+Mp8mIw9PFcmYANYZaJJKgZDNBCAQG24iXL4Yd0Ny/TgPHW/v7bLBOWWcstbf6tMHKxorhDlcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xZnsZaBE; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xZnsZaBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnsHsYNm926EjTN9piR8t2eDYTJhiUjnEVuhA0nCu94C04fMs0hKMWUt+4CvHOo34m7H6IIqKwSS0sAqRuuysY3A/DdLkrpGtSvjutcXFJy0mkHMj6cO2gSqOI56KyOZyEOMHQ9CxpQm535XHgDGiy8Z4RTaY75698B7wcS2ZyXPm8PWwC3Ak+m18V0V5VabbQIbFvy4C+eY+A0R5he7L2owDOomrMGtE6+JcLmpVSzA1Hvg0cRv0KoTesh0Dj5c8kF7uVSeNmedRsyMELMsBEHwhOmno8sRkMYw+HIJoTHbyVGACIj2DwAd1sdRk0Ds4wMG+9kVg+hm8ENTpwrA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvVSsI9Q47OZjgxQnrU8KqOiRTkjDcTlx3MbZ11lIZA=;
 b=UfVxWDgJyuPZ5UfmqDfnrf0E87TMi4n4UcAqMj0tq5pb2CPsRd+yS2mHASImh6GrmAFnCWftba+71wDGYSUSMOu1nw4+vBB0HELO9A+oKmHEMjP3rNUQfl1u8JHoPXX8+d0gzStvl22QsSUFgU6sa9QpSMMIf8OyuDfWZUnqmez5yWhMHN8mfN7me9gspg4x4D1V0CAfzTwFnotBrX4fS+GWsaOScTfvg1G8v01AVFywe1g16pWNEF5gfI0+kuOlB5YXjrr72YQgF5NrK/Lha+/3I9H5fYKVayg1d9hCSid58FV4e+kbG+M00gd6FMpRIDW0a1lXrP6Pa2/hthbsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvVSsI9Q47OZjgxQnrU8KqOiRTkjDcTlx3MbZ11lIZA=;
 b=xZnsZaBEgILYn3Q+iyv6pj+FJ074OzaqM7l9PfJ/T35vcsYmhIOyhlH1/KSAzr7enVAyJB5Cai4hkNcvibRwtOkVN1nhPxITdUybnE8pbWRGKcLmvvn2iibM7uAvaO5k6W+4rLMHJteeFVDV1HySYTJ/gUnwU0x38hyQXv+7ZA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:52:40 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:52:40 +0000
Message-ID: <fc296cab-f983-4f01-a71b-3ecbb9efde1b@amd.com>
Date: Tue, 31 Mar 2026 14:52:35 -0500
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
 <678f2b92-8f7e-4a6c-a66e-c19434de19f4@amd.com>
 <69cc1f1e5c432_1b0cc61002e@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69cc1f1e5c432_1b0cc61002e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: bb82cd13-eacc-40fb-c623-08de8f5f1102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4OeHy9rYilT/8ADE7C0SKU0M+pESFrhOyw0w/ZT4jnmeoknAhDo+B0nlW1jdRcOLS4aqLV31GPrxsRlkQo0/vSzBoL+XeDmp7CbjyTfTdXbYaJPlRtYk9j/7Ll0duk0tx+c2jBpjGSBf08nTlV614O8FQ+R6K+LWrdBTVL1jL+167RSep7Jx2U1QIX2QkQ3c2Rvca8DaadRGL/34O/GN14iBLVMm6TClWtuyaZrypxjEekbH0zK8NroyPOpFfkJ5QM7MkLuRt5C6M4tHCVIq5R9guXDOgTZ6TQTZM2oCu/TMXc4PHLATE3pfHVi5703wauevR25BPounG0Z8+iyFBtfrizo0LVzbiQk380eM/WG/2PDVm5xHQk39748D3aivNjcni92LTO/CIIS4fPNvwDZV3tjbcFpomzbVBz8nQLgYXhcEmOTgDzfcdjMJliQztTKHrdwwln1OadFDNLQzTeZ5qTQJ17A5G/3zr6qL9pi7noPJY6er3L8cPMAJwPWz2Hit8m6bbFk4Q6/Tpd0dQVdLLxs6f0qm1UJHBFYY/Jdmux5n8ZGlAe13cQhJjrsT7ZOcj2wf8K9J5S5MKUQdpeFMo9EesQvt0E+hlqHln1bC170x3kprwnoOM/6kdI6cul3BrHz8eRX5+A56E6diCxcT/o6ktvCiH52T/ApULWusfHdTLnngQWosnL/99zTVnjSdgmVWoIudQwRE8qJ/aZh7iiyuz6C8QFC2n2h8PXATfZ1yc4M4WcpjHAq+RWMQhqaMs9GIigEPiN1XeKDVjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ynd1OGtFa3RCSjhLRjNtcHpFb3VtVFRNeFo0cy96cUtLWU8rc0hHWUlOd1dO?=
 =?utf-8?B?ZU1QbEdVL0NuNG9JaGlkbHFvQWJIelBIcm1qZ0NBZVdRMXJYRXBuQ3ZZWkZN?=
 =?utf-8?B?MDV5MnJZUUU3TmZNcXFDVHJRUlczRDNkRXBvL0hkb1BrNS91emtEc2k3M3ZN?=
 =?utf-8?B?Q2hXOC9lWnh0L2hpZ08xNG80TldqQnhLZHNLc3VzTkNHMlVjRVI5TU96ZUcr?=
 =?utf-8?B?SktzbHZCUmhLQUJHVG52Wm41cFZHS0x3Q1dOTUNmU1RHajUxK05CNVJieDFa?=
 =?utf-8?B?N1I0RkcyNi95Q2xrSnl0ekJEOTM4dFV2T3dQcDZlZ3B2NW52ZklMSlkrbG1J?=
 =?utf-8?B?M2lXL3pGUWhpSWVPTjdDNkpPNmFnSWN5bFQrMlZDaTd6QTM1V2JCZlV0emJM?=
 =?utf-8?B?VU44eWE1WVVvZUk1MXpOcU5YVTFkdTFrSUwwdDdFTVZST3FiYVZTcExSeEpG?=
 =?utf-8?B?OXVaSllid014QXpDNXgveGJuMGlkTGQ1eSsvZzZlM09rN1c1cjJ3YkxjdFh1?=
 =?utf-8?B?bTljNzRkVkhtZjI4V3pzY3VsckJSSHFLQi9VNWpPUm1jSjlCSmpYaGYrNGV2?=
 =?utf-8?B?Vm4xd2pFaW1zc3JJOURKTzZCdDFzOWYvVzZhYUUzNEc5UzhWMS9KWXlPdEZX?=
 =?utf-8?B?ZHdTMHpiZnFzTkFxR1EzektxbmlXRnJRMkZGZ3ZldUhoWUlFc3lGcjRWaEpR?=
 =?utf-8?B?Sm83UkQ4bXdVc25SYTR5dkJxczVUMld0SmMzbnNBZ3RiNTRiTFNNampFREsz?=
 =?utf-8?B?NnYvSWNpbXlGVVVZdU45THBPRjhocjVUUVBtOVdsQ3EyOXcxODYxSjM4WnpT?=
 =?utf-8?B?UlpXWTljemJwcHNzT3JkQzZxQkFmWlBZT2t0VW9Nb2ZiNFM0RnRnWHlGN3VN?=
 =?utf-8?B?MGZESjVnK1NQZzdhOXpXVy9MNld6QjJjYTVGT3VHWmVzYlJWY1k1UU9hQjdC?=
 =?utf-8?B?L0hrL3UyVVhmcFp0VC9FODAzS0pWS0wzc2FYRzhueG51Y2QrVWFQU1l1UTMz?=
 =?utf-8?B?SzdDa25oOG5XekFCUDdqWXNxemVBSlJxa0poYmNSdkN4MzN0MkFNbkpPTWRQ?=
 =?utf-8?B?TWFHZTdhb1NNd1ZRL1Z4TkFSTWdzbFNOVEd4VEFUZk82WlNyS0xKVy92cWw0?=
 =?utf-8?B?RFVPTm1HNXlNMiswUVUwUWhTeFo4WVJqd2F4NE5qRE9xZE1SK2s5YnRuTHhR?=
 =?utf-8?B?ZWJkZDkxZjFHeFVucFVEaEpTSURDRUNtZzBJYWJBL0tHakROWkN3dVpwbExF?=
 =?utf-8?B?NG45WUplejFXSnVJeXNzeGZzZ0Z6NGI3V1krZE51K3dHVVlJZVFzeVlRM0x5?=
 =?utf-8?B?YWltcElnOWErVDlzSnExVmJKUmdpaVNQalp3MDAzSjF6czIxdDJrSEdzcEF1?=
 =?utf-8?B?S3lsYkk5YjlQbm56aDlFbzZzeDBaclIxbk1rVElBZTJJV0czTDNHeCtHamRJ?=
 =?utf-8?B?UU8vdG4yUFh3dVhkNlpINFVVQkFEYTBEdEM3UWdQZ0x6Vm45UEdCT1NMU3d4?=
 =?utf-8?B?dDNwSjdYcmpwM2tnWFBuNVBsbUo2SEhjS0pLWjA0Y0lNVDlHWmNmSk9uUGtH?=
 =?utf-8?B?OVFtekZ5TXZKSmdTaGNkVmtJdkc3ZHRJK2drTy9GQTJ2Szd4TDV6WGx5R0VE?=
 =?utf-8?B?SEptYkkyTG9NM0U3MGVSREo4WlBGQTVyOXR3VC9GbjNTNk4vQjJzbHpkTG93?=
 =?utf-8?B?MTFNb3R2U1FHaE9ZVmhMaHZpWkFMZGszazJscyt1dzdRNWdEYTZGc1M3KzJB?=
 =?utf-8?B?SmVvdVNad1FEQVdMRUczbjM3OEdqUm82MFBOamN4dlRocWlvbVprMERHS200?=
 =?utf-8?B?V1BGK01FYTFSQjdVUUxseEM2Q3U4YUNHTmxyNXRMTmF1N3B3QjlQZHhuSWh0?=
 =?utf-8?B?eDJuaGJFdktGMThLTDl6WTBFdldtSU1zOU1GaEpsTmlHQVBuSGhrakM2UktG?=
 =?utf-8?B?S2NYT0VyNVhlc2dJOWl6M0dzdmdsalBCRmJmV21hV01taEt3Ry84M0wxTTN2?=
 =?utf-8?B?YndmbnJDekloT1UwbytkYWduY1E1UUJvenZzUk1TL2piT3duUGQwRm9ObWFY?=
 =?utf-8?B?dk5lanNXbitKeHVncldSeGNCNUxLMTBjdFdLT21ucDNkd29mL3hiYWdmck16?=
 =?utf-8?B?L1oyTVNHbmE5QzdpQXoyb1BzdE41Z0w1Mk5FbVZLcGNXMUg5WmdrUE9BN01t?=
 =?utf-8?B?QTVWbVlYYk1NZkVYS1RMSFJxODYzOC9teTBXc0pHL0JjaHZSSDB5S2J5Ni8x?=
 =?utf-8?B?L1NuL3d3b2hNcWU3MzkxWnR1dmltTTRHUHJlM0dxRTlVSnFPbTZaSnlCMGFL?=
 =?utf-8?B?a0JvUkJjdlc2QXhYWGd3ZmFXZmJ4YVBwL2Y1TWUzZ2xRa2g0dzhkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb82cd13-eacc-40fb-c623-08de8f5f1102
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:52:40.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1vr7LE1oRl2V5vGcOUTDhprJkNKN3Uk61ZymKoMPuiaPKGJcyrv1zGQeOSWbidW17ASRVHxhG7NUhqtZKptTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800

On 3/31/2026 2:23 PM, Dan Williams wrote:
> Bowman, Terry wrote:
>> On 3/29/2026 8:22 PM, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> CXL drivers now implement protocol RAS support. PCI protocol errors,
>>>> however, continue to be reported via the AER capability and must still be
>>>> handled by a PCI error recovery callback.
>>>>
>>>> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
>>>> new cxl_pci_error_detected() implementation that handles uncorrectable
>>>> AER PCI protocol errors. Changes for PCI Correctable protocol errors will
>>>> be added in a future patch.
>>>>
>>>> Introduce function cxl_uncor_aer_present() to handle and log the CXL
>>>> Endpoint's AER errors. Endpoint fatal AER errors are not currently logged by
>>>> the AER driver and require logging here with a call to pci_print_aer().
>>>>
>>>> This cleanly separates CXL protocol error handling from PCI AER handling
>>>> and ensures that each subsystem processes only the errors it is
>>>> responsible.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Assisted-by: Azure:gpt4.1-nano-key
>>>
>>> This is not a human. If you want a tool to do some of the labor of the
>>> patch I as a reviewer want to know what labor is performed. This tag in
>>> this case tells me nothing actionable about what needs reviewing.
>>>
>>> See: Documentation/process/generated-content.rst
>>>
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index 254144d19764..884e40c66638 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -393,34 +393,41 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>>>  
>>>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>> -				    pci_channel_state_t state)
>>>> +static bool cxl_uncor_aer_present(struct pci_dev *pdev)
>>>>  {
>>>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>>> -	struct device *dev = &cxlmd->dev;
>>>> -	bool ue;
>>>> -
>>>> -	scoped_guard(device, dev) {
>>>> -		if (!dev->driver) {
>>>> -			dev_warn(&pdev->dev,
>>>> -				 "%s: memdev disabled, abort error handling\n",
>>>> -				 dev_name(dev));
>>>> -			return PCI_ERS_RESULT_DISCONNECT;
>>>> -		}
>>>> +	struct aer_capability_regs aer_regs;
>>>> +	u32 fatal, aer_cap = pdev->aer_cap;
>>>>  
>>>> -		if (cxlds->rcd)
>>>> -			cxl_handle_rdport_errors(pdev);
>>>> -		/*
>>>> -		 * A frozen channel indicates an impending reset which is fatal to
>>>> -		 * CXL.mem operation, and will likely crash the system. On the off
>>>> -		 * chance the situation is recoverable dump the status of the RAS
>>>> -		 * capability registers and bounce the active state of the memdev.
>>>> -		 */
>>>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
>>>> -				    cxlmd->endpoint->regs.ras);
>>>> +	if (!aer_cap) {
>>>> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
>>>> +				    pci_name(pdev));
>>>> +		return false;
>>>
>>> How did the PCI core generate the error if this capability is not
>>> present?
>>>
>>
>> This was taken from the AER driver likely for GHES support. The aer_cap check is not 
>> needed here and an be removed.
>>
>>>>  	}
>>>>  
>>>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
>>>> +			      &aer_regs.uncor_status);
>>>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
>>>> +			      &aer_regs.uncor_mask);
>>>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_SEVER,
>>>> +			      &aer_regs.uncor_severity);
>>>> +
>>>> +	fatal = (aer_regs.uncor_severity & aer_regs.uncor_severity);
>>>> +	pci_print_aer(pdev, fatal ? AER_FATAL : AER_NONFATAL, &aer_regs);
>>>> +
>>>> +	pci_aer_clear_nonfatal_status(pdev);
>>>> +	pci_aer_clear_fatal_status(pdev);
>>>> +
>>>> +	return aer_regs.uncor_status & ~aer_regs.uncor_mask;
>>>
>>> Is the above doing anything that pcie_do_recovery() is not doing?
>>>
>>> For example, there are zero endpoint drivers in the kernel currently
>>> calling pci_print_aer(), why is cxl_pci special?
>>>
>>
>> Device AER status is typically logged in the AER driver but is not for Upstream 
>> Switch Ports and Endpoints with UCE fatal errors. The call to pci_print_aer() 
>> is added to provide details about the error. The logic behind the change is if the 
>> AER status is already accessed here (to be cleared) it can be logged to the user. 
>> pci_print_aer() is used to maintain consistency in logging.
> 
> But cxl_pci is only attached to generic CXL memory expander endpoints.
> What about other CXL devices, what about other PCI devices that would
> benefit from general AER core driver handling.
> 
> If the driver is not going to do anything be generally log the error
> that feels like a PCI core responsibility.
> 
> What am I missing?
> 

The USP case needs a PCIe UCE handler added.

CE are cleared by the AER driver. UCE are not cleared by the AER driver and is left to 
the device drivers' handlers to clear.

>>>> @@ -441,7 +448,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>>  	}
>>>
>>> I am getting the sense none of this is required. When the device is
>>> trained in CXL the bulk of errors will be CXL port errors, when the
>>> device is not trained in CXL it will not be in use. For that remaining
>>> case, why does the driver need error handlers?
>>
>> Uncorrectable errors of CXL Endpoints and Upstream Switch Ports are handled as 
>> PCIe AER and not CXL RAS. This is because the AER status is not read in the AER driver.
>> This is not read in the AER driver because the links are assumed to be down.
> 
> Why does the cxl_pci driver not also assume that the links are down?
> 

I took a best effort during the fatal UCE. It is calling panic after this.

- Terry

>> The AER driver directs the error to be handled by the PCI path instead of CXL 
>> handlers.
> 
> Right, becuase a CXL link is not found. At that point is just like any
> other PCI device and unless it has some specific recovery action to take
> it does not need to register a handler.

