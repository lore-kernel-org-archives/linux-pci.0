Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD83A71B6
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661924; cv=fail; b=N1Nf9Gre96ImNz3/Gb3KYj7L81fnXzLQHOeGqmtZjVt/cZKmWLjny/pZ1EGUUGvQOq69vNxva+O+UAtb1XvewxxHNe6k9FCq0ISRI1k3V406fGGwRiJQKtEzanCVntjoyWjXuY90qSmSl2WrPvakiXU+TsbvSqpSKPt1T0j7snI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661924; c=relaxed/simple;
	bh=jHhadrk2/X+IJnLvTU/Vx3L0jkSUM19kuthEGrOu2NU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQzqwTlXxr49zvcyphMhl8k0AcXsRqzZMO1+PKmnc1KHo7NsFbydpfbKu2Xcn58HZvzRlUBgVuGMOKZ2GFxzhM9TQHNA2LFE7KF8D/CQky/qgJCQk1+E50hrIa4c3rmJPYlNDHG/lBdIk6sFYpWOQCruy2x0lZMkmQDoRmklgkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpNTgI1J; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpNTgI1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXZFWJaKwR/Az3Li9Y73pWt4s8GEFRVVjwBniKoR4jcbGkmV8h0oVZWfVCvUD+tCxNP020QUXXF/oZM0zVzMuqL0NcgHs3q8gsttK6a/2XRWPxDe0jxquPwcEG2NHmD9NQcn4WozMemDBXCtO1bC/nQHFu6Zfkqz954IFnLdbYsRyc5QY+ieSwRYhdU+q88lw/KrQYAGaP1k1kO8cC2fd7Hc8j2YhmKyLhGTuvGR3MkjszWkB0PsCtf4JkexnSpDAHe6Ybl0fachE5qB1jOzrIifBlacRUGj6sBsxVhB27VhgfFulo7iaWHDpN75rx6MRwFfeAWot6VomaxBkjds6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ja4Pd4Ld2bZEhvFJQmroP7AGo0A35du+JadU9ubyVs=;
 b=RcJv3tbQCV/2izui35njLPloojwSIKIOCepmfJRDKMpDVBaT7aRHIokDdMzTasZdu4xzhQSJDTWXIyXzUrCS9/bizRNUrm6eYLEB0fSotN+coS1t7r5zqRi4mpA6l921EWzHYWOKSSVTO65NIjrwIP3xO0LboSqj65Pw43kJ8riErEUgJO6DDbaGDLynPVKrWCkviunYbD/KqzkIxYTU4nZz7QjmHthjFzTAX15gB0Jq7H0iQZ2CIIt6t2BjwVaxsRHAa6ml7Vhbzs0yUBtamp3hJ3D7s+so0p6Ft8oKJOuey7l4P3sEOPSTZhw2IZH9KTE9qLJLdha9zMlAK3IF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ja4Pd4Ld2bZEhvFJQmroP7AGo0A35du+JadU9ubyVs=;
 b=MpNTgI1JPpm+qKGz0LqUJxf3H5xoIEOU4SrGyEuHR5t6qmaoyG2PxsJypFDVRgTi4h0JpvOY8cs01r74V4CT92MzMfsTA2BCehdfOO+U7YeBWIh0J6Wu/Fw12aBdW8N2jTECJ11FpGXRm960e/hnaJiyt6u1BQDcfryErll+p8dr+G39YqBFcl9rvz8cBnQUKnpXycvqYdoB6iVUwrka/jSGFouRZDIhinaq9rGQQOYvWxnnsvyystTmQ/UYL2TgZ4q3aT5rvCfgoepejjLYblnygcX49XadWrOFKh5oHwm2LgTlidUbEK2JdWh4z++fl4ZgzmBNdzTwEw8lhs/kZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 12:45:13 +0000
Received: from IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0]) by IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 12:45:12 +0000
Message-ID: <9b166536-d684-4f56-a197-cb0390b40b72@nvidia.com>
Date: Tue, 25 Aug 2026 18:15:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI/MSI: Don't touch the MSI-X table while the Link is
 contained
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260817195626.3091331-1-vidyas@nvidia.com>
 <20260817201203.34B9E1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20260817201203.34B9E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::12) To IA0PR12MB8351.namprd12.prod.outlook.com
 (2603:10b6:208:40e::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8351:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 16332ff2-e4f2-4b73-d837-08df02a6b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|5023799004|56012099006|11063799006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	yLYLUxYowXLHcLWR+Q85Sy3omKrxHjGqqoQOtOZMft5nCJLVCeNl4kYySoJnZs36yD+WqD5PsHoXP3WVS5vph85tT7lsZVozYMMhAhMkzZGVJq9kY401KYXBzVg+IuZd13O9Y5gislh48W3d0yBonGUbW4QDBfNMJV3i0qkj77Rhgz5Zk1wTzBXtgJkTOnrvSPT9VI7li+vLp9QvnGGO4y6nYWNu6CbqHP3ONhOR+EPVmxQ/Lunc2THJ5CqhTJRqE600G14b6AbbcHcJCWBB2KsMVI69CeoIZVu7ZiKuXtQlDups3Tpz7LRQSE84dDpaJ9Y+pLa9nRK3zJLBYx/xy2IeorVrC9cV7CXeYJD8NqnK/4ApYp+bPq4QJkU1zNEsCusEkEP/WmLkLOsnxHk9jZnIx8jGbmLfCidnExdyZueQ5IJgQRpvrJmF2QSi/y6ILMtTR4Vp0m9shUydAR0RF9sqQRhZAPq8ypM6xXHn8HQuMWYN6YHE5jTIPyxpz35RQAsNVW4pZFT3xz3IfmfSVM/ND8yCp0g7WwRy7YprN5DiwZr+dFa7L83lrhk9VAHRC3m1TUUJwiO3A0SVtdtkKkoVAfC6YbtoRGwdueS4ExAZ1mU3xBEapgi7hKIZi8pnCga1ejFRAbIa2WRGE+7Tdn0QTvuzxbS9RN4qeUJaMj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b090M2lZMmV2eFpmd0NCNWVLRDdWUHIyamluNG1Ma1JwM1A5TjBpTUhwbnYx?=
 =?utf-8?B?MTRLYnpaa01MYzZ4YW1lVWtKL1Y0QUlPUHhSVW53UDhWQUtMVXY1NmZndFQ1?=
 =?utf-8?B?VTlKbW5KSjdXYlNmV2d4SmVXVDNKQWNVNlhWTXJJTFRYQ25uckIzYnZzcUx3?=
 =?utf-8?B?SGNVU25LQ3U1TXEyaExXRURvdk5FWjNPb2tPZ083RERIM2lEWmxWRFBPTGpG?=
 =?utf-8?B?V0RtQ1RmZDBqeFRqMWlhLzMva3I0M293bzl6bDZvQU5YL2NORU1aQVl5aUky?=
 =?utf-8?B?Q1QraTA1UCtXczBnZThwYk1SUWIxYTFWREVJUjJtMTh3SEFPc2EzNU5rNkhp?=
 =?utf-8?B?MVFvR1o2ZjNySTIrTUdmeUV3NkJndDRxS1NLSWZVV09JamhTOENmN3VTZEtJ?=
 =?utf-8?B?OWs4VFFnR0ptOHJtbHhnWVppbzV1MVN5eExBeWNITlZNd1BENjRkMkpUM2ts?=
 =?utf-8?B?Z3d0cFVoR2U5QkZZSjN3bW9UNFF3WHQvN1owbnV5M0Q2a0pMZGg2U1N6ZVBQ?=
 =?utf-8?B?dk1MbThDakJsZWRGcEhyY0JPN1FsYUExeVJHdVpSVkFMWDduSU52c1cwdSty?=
 =?utf-8?B?Tk5RQTdXdlFFa0hDTTIwVWVSZDBsWVVZZXFjL2FYcGpzbzFyV1MreUxQbGls?=
 =?utf-8?B?d0d2QUlHcWNNMjBBVDZLNUtWMTh1Z09DLzNpOXY5UkhkekxaUkphbnpqa1Zy?=
 =?utf-8?B?aFZsTER6Y29XMHh2UDNsY2N2c25kNmVOS1AvMG94emVZRkRzQnhMNVh3cnZp?=
 =?utf-8?B?aDJQNUFCQzhVRHBLbzZraXJYMkplREx4VVQ1dzdXb3F4eEpUcGg3V0dJNEFG?=
 =?utf-8?B?Q2I4SEJ3ZDBWeDYyejBlNnBtK0ZpbHJhODNmTXlvanZPN3N1RFhNbFdWdlJI?=
 =?utf-8?B?R2IzMXRnTCtaZU5qUmdyYTNPaitsUUpzendJQkJ4RmZqRXhiMjgvaTlWS0p6?=
 =?utf-8?B?SThGOGhXM2VBRExKbDJUdnpuVG9Jdy9CTXFKdlpqTTcvSjZ5Mi9zMEM2RjB5?=
 =?utf-8?B?UkFiY1hkS0FOUDNWdm5EbDZIUmF4MFczZWl2V2Q1L0pVcUFSVHFDN1M4R2Nx?=
 =?utf-8?B?YnRnZ0tobThoZFFZaHNjZzZCUHBJTWEzT2tlNnpLaEpjKzRiNTduaFJXYS9V?=
 =?utf-8?B?TjZTVXd1MzNOLzJOVGROMnVCV2FyTzUzck9XWTYxaFVGOXJSOUdzOHdmY3NI?=
 =?utf-8?B?NlRiL0RlZDJ0LytqSVZvQkhMRE8wbHFuSW1hS1c3dFVMeEk3UEhORnFKTkh2?=
 =?utf-8?B?dVJhM0h6YTc1S0ZyalpSQTdONmpoUy9UcGhJdm1Mc2psd1BZMDB5OVcwV2lK?=
 =?utf-8?B?L2t5MW5SZXFlaVhudUZuZE8xV0U3WHFXbGdENDU5c1BlWW95VzM3b28xRjVp?=
 =?utf-8?B?c09ndFlsZ1pEWnNDV0lVMGxYbVJNRUNpakJsRDRsN3BhRldxV1R4SXNJaFRF?=
 =?utf-8?B?alY3OEREb0d1ZGVTM28weVFTL1Z6ZERCRzNmVHJIZ0x5bXJRZjhkZDhySDRv?=
 =?utf-8?B?QUdpRjg3LzZmUzNDYnNBKytGWmJabWVMWWVjRmd0eWJhK1FNOERyMGhyNFVk?=
 =?utf-8?B?M3lvK1piRCtyUkt5cUdZRkdEWTN4U1UwTWFVL0llYzF0NkJ1b0ZhYmttdSs5?=
 =?utf-8?B?Vyt5eDJMOGlXSDZEMEwwckRyYitzSStBSEJrME56MDZTWjIxS3Q0cW5QZGR3?=
 =?utf-8?B?Qkx4ekgyQjBnOURwV2l5OGVuMXhXQmpYU3F1RThGUmhkSGJPZDAxV3dWejEr?=
 =?utf-8?B?K2lGWDhtV3ZaS2V3Qkp2RlJza1VPSTh5MmdRWmlHZFc5bnQ4Y2hGblhic0dU?=
 =?utf-8?B?eS9LNjJuWUZaMm9LY0ZQeFVvV08yZWNkYlRvL2UzSlNqTHhsMzgvYjdMZmxQ?=
 =?utf-8?B?QnQ0NjJLeVlzeTZvRm9EK3ZNTWcrd0VMMkhvQnhIUFBGQ3dMOGtHM2ZYYjZh?=
 =?utf-8?B?NG9OVThPSE44UnZUMlBLRXMwbUV4VmFhcTltaWFzcThHcHREUTViMVhFM3pW?=
 =?utf-8?B?eHV2ZnBUQTJ3UjJNNm04MTBSMEJFTEhVZm5BOGJ3azBBSnV6RDlzdXU3dXMx?=
 =?utf-8?B?czFqK2lKMDJuQno5NkVVL2o5aUR1OEZ4bkdIZE1oVzNCSytUQk1qVHJWdW9y?=
 =?utf-8?B?RmgxZTVaWGZzWWNKNHozMTc5cHo4dWY5N0VRMTViWGd2ME04UitjUnJES2dt?=
 =?utf-8?B?N1cvM0VhdnExa1FIcXFuaUw4ZU9FRHFTeFRObFZRU0FOSStJMTZJZ2JCWmNG?=
 =?utf-8?B?cUFpMEJmZ3BqUkZITFR5YUhsMktzbnAxdE1pbjVMa09oeGw1V1ZEd2FrWEh6?=
 =?utf-8?Q?YPovVHZP/bBI9ZHBCG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16332ff2-e4f2-4b73-d837-08df02a6b45c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:45:12.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC3ncYj6rUQKS0DKrt784gk558QPoiOOwadVvMe7sTFI665G6HS3aSf450pxVkQ3YJ9y0ouz1+JPH17cjhex9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On 18-08-2026 01:42, sashiko-bot@kernel.org wrote:
> External email: Use caution opening links or attachments
> 
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unprotected `readl()` operations in `pci_msix_write_tph_tag()`, `__pci_read_msi_msg()`, and `msix_prepare_msi_desc()` circumvent the MSI-X MMIO containment fix.
Thanks for looking at this. The three sites do exist as described, but
they are not equivalent, and only one of them needs a change. Taking
them in turn.
> --
> 
> --- Patch [1]: [PATCH V1] PCI/MSI: Don't touch the MSI-X table while the Link is contained ---
> commit aba17efd26855fb96d48aa82a9f367120d469a3f
> Author: Vidya Sagar <vidyas@nvidia.com>
> 
> PCI/MSI: Don't touch the MSI-X table while the Link is contained
> 
> The MSI-X table lives in device MMIO space behind a BAR, so it is only
> reachable while the Link is up. While a Downstream Port has the Link
> contained by DPC it completes accesses to the table with Unsupported
> Request, and the read returns all ones.
> 
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 209373c92e9e1..5612cf2ff2800 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -249,7 +249,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>>  {
>>       struct pci_dev *dev = msi_desc_to_pci_dev(entry);
>>
>> -     if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
>> +     if (dev->current_state != PCI_D0 || pci_msix_mmio_unsafe(dev)) {
>>               /* Don't touch the hardware now */
>>       } else if (entry->pci.msi_attrib.is_msix) {
>>               pci_write_msg_msix(entry, msg);
>> [ ... ]
>> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
>> index 0b420b319f50f..e372e9c875087 100644
>> --- a/drivers/pci/msi/msi.h
>> +++ b/drivers/pci/msi/msi.h
>> [ ... ]
>> +/*
>> + * The MSI-X Table lives in device MMIO space, so it is only reachable while
>> + * the Link is usable. While a Downstream Port has the Link contained by DPC
>> + * it completes these accesses with Unsupported Request, which the Root Port
>> + * in turn reports as an RP PIO error and answers with a DPC of its own,
>> + * taking down every other device below it.
>> + */
>> +static inline bool pci_msix_mmio_unsafe(struct pci_dev *pdev)
>> +{
>> +     return pdev->error_state != pci_channel_io_normal ||
>> +            pci_dev_is_disconnected(pdev);
>> +}
> 
> [Severity: High]
> This is a pre-existing issue, but could this regression still occur through
> other unprotected MSI-X MMIO accesses?
> 
> While this patch successfully shields the vector control write inside
> pci_msix_write_vector_ctrl() using this new check, there appear to be
> unprotected readl() operations that still bypass it.
> 
> For example, in drivers/pci/msi/msi.c:pci_msix_write_tph_tag():
> 
>     FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
>     pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
>     /* Flush the write */
>     readl(pci_msix_desc_addr(msi_desc));
> 
> The flush readl() is unconditional. It bypasses the safety check and
> would complete with an Unsupported Request if the link is contained.
Agreed, and this one is worth fixing. It is also worse than you state:
it is not purely pre-existing, because this patch is what makes the
write conditional while leaving its paired flush read unconditional. So
after this patch the function can issue a non-posted read to flush a
write that never happened.

pcie_tph_set_st_entry() already propagates an error by disabling TPH, so
the caller can cope. I will bail out early in v2:

	if (!pdev->msix_enabled)
		return -ENXIO;

+	/*
+	 * The tag update below is a write to the MSI-X Table followed by a
+	 * flush read, neither of which can be completed while the Link is
+	 * contained. Let the caller disable TPH instead.
+	 */
+	if (pci_msi_dev_inaccessible(pdev))
+		return -EIO;
+
	virq = msi_get_virq(&pdev->dev, index);

> 
> Similarly, in drivers/pci/msi/msi.c:__pci_read_msi_msg():
> 
>     msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
>     msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
>     msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
The only caller of __pci_read_msi_msg() in the tree is
pseries_msi_compose_msg() on powerpc/pseries, which already selects
between reading the device and using the cached message based on device
state. pseries uses firmware-mediated EEH rather than native DPC, so the
escalation this patch is about does not arise there.

More importantly, this is a read whose value the caller consumes. The
write sites are safe to skip only because msi_desc::msix_ctrl caches the
intent and __pci_restore_msix_state() replays it once the Link is back
up. A read has no such fallback, so "guarding" it would mean returning
uninitialised or all-ones data, which is worse than the UR. Making it
safe would require an error return and propagation through
irq_compose_msi_msg(), which is a different and much larger change.

> 
> And in drivers/pci/msi/msi.c:msix_prepare_msi_desc():
> 
>     if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
>         writel(0, addr + PCI_MSIX_ENTRY_DATA);
>     desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> 
> If an IRQ affinity rebalancing event triggers a TPH tag update while
> the link is contained, or if the link becomes contained concurrently
> during MSI-X initialization, won't these unprotected accesses still
> escalate to a Root Port PIO error and trigger a DPC?
Guarding this one would introduce a bug. That readl() seeds the
msix_ctrl cache from hardware. If it were skipped the cache would read
back as zero, i.e. unmasked, while the hardware vector is masked, which
is the reset default. Every later mask/unmask decision would then work
off an inverted cache, and __pci_restore_msix_state() would replay the
wrong state.

The specific sequence you describe also has no deterministic path.
report_slot_reset() moves the device back to pci_channel_io_normal
before it invokes the driver callback:

	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
	    !pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
		goto out;

	vote = err_handler->slot_reset(dev);

So a driver re-enabling MSI-X from .slot_reset() runs with error_state
already normal and nothing is skipped. That same ordering is why this
patch does not break pci_restore_state() ->
__pci_restore_msix_state() during recovery.

In principle yes, and that is inherent rather than something this patch
regresses. error_state is a notification set by the DPC/AER handler
after containment has already happened; it is not a lock. Containment is
asynchronous, so any MMIO to any device can race with it, and no
placement of these checks changes that. Closing the race properly would
require serialising every MSI-X mask against containment, i.e. a lock in
the interrupt masking path.

What the patch does close is the deterministic window, which is the
interval between report_frozen_detected() and report_slot_reset(). In
that window the kernel already knows the Link is contained, and driver
.error_detected() and prepare-for-reset callbacks nonetheless call
pci_free_irq_vectors(), which masks every descriptor and flushes each
mask with a non-posted read. That is reproducible on every contained
device that tears down its interrupts before the reset, and it is what I
observed escalating a Downstream Port containment event into one at the
Root Port.

For v2 I will also rename the helper to pci_msi_dev_inaccessible(),
since in __pci_write_msi_msg() it gates the Configuration Space MSI path
as well, and the previous name implied MSI-X MMIO only.

Thanks,
Vidya Sagar
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817195626.3091331-1-vidyas@nvidia.com?part=1

