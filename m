Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C650EBF9
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796788; cv=fail; b=T9PsiKTve9P9swUEWN48Nbzt5C9Sn9H+q9Uu3iH5XPPTWtmZMucY+n7pnX6V/565z3fIZERslZH44zozKWtUPTv/HXb6hj84mAxvOFjRZYjO+VJgVgz0l4hIn72WSH/wYMuVN+mF9sU9lvlWiROl3L/B5cEDh+4VYw4nP4saX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796788; c=relaxed/simple;
	bh=8RvbmimFpgCp+Awf0vRsymWT0K8SxszMn0Z/I9mcv4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FILRUq5drxrCvnvnNMN++wNKAPDT+GGRXE6122muQH5qm/MN5mJIyBVpg5ceVVtanjq9ck2h7ocSXqD3oMPGY249qKTRNwo+e92fnxfcoMmWmkcA6t/dPDKxLi56ncxdX7K0B8eHhVUwy+9rnRYnZpnngYF9DNM/Ysv0D7rS66k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WXUQBXZ; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WXUQBXZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2qJrCf/MlpfOwz2ok/lr+pt3Ypg/vJf+ZNLS0ji9bToPwngSjGTTjo3eM3YpEc2Hobus+pYH66Wz2UClDiSEiHFv7AARsQe9h2fROKrsX8bzM1VBTNNsR0+jlqcsC3vgAnzuO9PmUHGyxQaiq3k01eQSb9TKxBIDLG3i/0OwRFcZKi5wVYQM7xpAN6HPFpWc4waWBIdNfuUTS/GCIRWc6Fm6QVlt3mUCMIPvq+GfRxxTR0ycmjuflM9zZ21LdOuDPbd/02GcikdV00RdnRT2C6eKkFIrxQrEDnT2jV5qcmg0WycO2/1iIY3OJ63W1BBT1kZIcoKtBGgaLjHR0a4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c0QyidH/Y+KNIIrB+qCQM/NxhFBmkDEPY3lQM0LE+E=;
 b=jDD0os/VUMTvhY4088DVvR80a0xBGqwXKKs5vUCOCyC3IV+0FWn8esQvc9SQkYz41p43W9W2rO+TXTk/DIdWqtnV1mkyCnbPhNn9i7/uiR+ZgRGQxF0JxYNa4wTGIfzKTEWP0ye56zVH3EgPGJWe22CWZs8qYunhfmwxiQrtZ0wKmb8xTjJnvnMMVDA+6warE3MR2CHNqSGLw+HNEg2TLiDVr8PYkS3B7JVRbeuVZiQSCY1tMBQD4wvkJQjHl+G0Dl9TGvUceIBa49HjDvZFukRLf9Mv+2K5EBOLoZ/tpEDFBwSadQCSltEIpA5Sz1iAGn8r8gRC5ufLumFZyxsc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c0QyidH/Y+KNIIrB+qCQM/NxhFBmkDEPY3lQM0LE+E=;
 b=5WXUQBXZqW4UYXU3cCGXEjW8sAnKBB6DsIgE+WKDS9dbzmV9gyJenAGzIRfbCdO4XQs8lJc8WS9VOjRPns3kBz6TrzCIrCjG4JYTDDxFErs5CaXUNiNfCSph2fVHf/094gjOJsVA86a8yjAwXZV0iC8qFI6/SvCh0r/qJPJfoCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:59:41 +0000
Received: from CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176]) by CH3PR12MB7571.namprd12.prod.outlook.com
 ([fe80::7a06:d977:dd3:6176%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 15:59:40 +0000
Message-ID: <d22d089d-7539-4555-be84-29bcd519c224@amd.com>
Date: Mon, 7 Sep 2026 17:59:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Accept AtomicOps already enabled by the hypervisor
To: sashiko-reviews@lists.linux.dev, Nikola Prica <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
References: <20260903121218.4955-1-nikprica@amd.com>
 <20260903121217.23F751F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Prica, Nikola" <nikola.prica@amd.com>
In-Reply-To: <20260903121217.23F751F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To CH3PR12MB7571.namprd12.prod.outlook.com
 (2603:10b6:610:147::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7571:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2ca32b-a2a3-4078-3a74-08df0cf90656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zrtaTlZ0/p9RPHwmysezANuOByHoKRmlaScmsxo1rllc3R0L74248uOz4sxWFo09qCPmS2mmcuX1jwxbpnBjzYMrUdMgOk9uo0Ckmzki8+NUsKDcHmjb0WVGk3Rs+nDgZnThbAYVITy2gDyyDtzyCQzw2qT33eBlr/mrghkDq+suLtldLHRAqs7hYKXmjo1REwpmSM0fTgJ9ATaqXebsFEXXG0Pt3A0yiCecBAWEx6lc5V77pwGv/SqX8NREaHjnoY95LqG1pnQcSMc0P3ve2eOoy5DpZHM/XXV+V3QlCd7LPr3mp951yzDxESvkH9Gsp0WtZn7hhFPcaNB3Foyg3Sp4hu7lAbD60GVBMfk2ftAELZA1HTUqafBfSl9H8nHfD3IBMxY6qkXrE4xOYwjFywKilt8SC49ymVMRvP7oVyw7nGsBrfKKRNpaUUwxk5P+whYKEYtWZ+5V8wg4yHnF/2e+4vOPA9jlQVWHRIzwpLaqn8/5x7yIHHyXhdxyscE7aIeATY+e4uA0IL02boKtYZ/Fx//ByuDQHU5ScCSIDlLxSDk3Eadch4uy0KocNfbqvcgRKJMAu3HaZOBjjqVoN+48SUj5FSIvy2pUu5ypzVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdwK3Izek93Wmg1Q1F6WStDNWlmWmVERmtTWGJya2ZpUzR1cFJ3ejROTGJz?=
 =?utf-8?B?dWxhcXZHb3NYYVZCaGM5SER3dnlacldQdzVWQlJxeFpLeEdLczR2QUpyZlEv?=
 =?utf-8?B?eERXZ2xhK29obDkycCtha0xPZDZhUHlXcFRVRkdHWXBFd0VINE1mbGU0K1A4?=
 =?utf-8?B?a2ZXUDN2Q3MwaVRycndXZTVvTEFMc1RtUWJnQjgzNk5qVjE0VUxTMU5vL0Zr?=
 =?utf-8?B?eDZmaXA1TWRjOWdVNW1LR3d6OFFHdVNvNlNaT09VRkFLZHVwbm9DNWtScXl2?=
 =?utf-8?B?a1lEcjNzcE1rUjV0UENmejg5b1Y5NzlQWkF0S1NiS1ZvaWpkdzkxOU8vdXYr?=
 =?utf-8?B?MVhRWjZlQm9WM1phR2dXMXZVWWZta0RrNks4dXBTSm4xVjFjK3owZXdVM3FR?=
 =?utf-8?B?UUFPZmZFS2gxS0UzVm9QU2ZqaVJGdVhrUDJmWHBUSmZ6dUx0dWtBeDM1ZVhQ?=
 =?utf-8?B?RDk1MWV0cDVZd2dFR0hzeGdvUTRuUjRqWkZ1UmI2Kzl6aXBoS3B0S3JVWGxo?=
 =?utf-8?B?OUxpR0lDR3Fpc0RsK0VneWlkcWQrTi9qNy9nL1JwZzdlcW1XMFRlOFNBdnpQ?=
 =?utf-8?B?NllWTXNBWk5xbWdXWDUzWjM5ampGRzBBL1IySjIzbHdWcE50c0NNdUY0SFhW?=
 =?utf-8?B?ZGJuQkN2U0NDTnA1NjZ3VlVodVBrL2IraUgzTXhQODhkM0hFVkFmM2tXOHJF?=
 =?utf-8?B?TnQwTENuRTFBV01nNDdINWJQazUyditxalRhMGtHQVF1UzhCK1J6djRlUzBl?=
 =?utf-8?B?WEpEWnBOZ2FTcThHUm94REFOVEgrMUc2bUJFVGNCay9ISldZblJSK3c2R2JL?=
 =?utf-8?B?Q2ZmdmNJdmo5Tk1HNGhaMVI0ZmNrMFJmV2RjY0JJSXZsTnlaaXFVdklPV2Z6?=
 =?utf-8?B?blgvNjc3WWFnNDZXUlJLeGJCMnJ2cURMTTNkRGpRdm13WW90Mkk0NTJYdy9K?=
 =?utf-8?B?cFMzcnQ4ZzRGU3pOYndDZVpHbXpUc0pDV2M4Yzh4QXkyeXZ5YUwzaHlHRTVp?=
 =?utf-8?B?dTc4ekhFRk5PZW8xWXdPb3RYYkk5VGFUS3ZsWlhReks1UlpVam9xbndRRmRP?=
 =?utf-8?B?ektITGR6MGh0WWFWZHp2MWc2WFU4OU1yUmlNbzdBdWFFU1VVSm40cDYxOTE0?=
 =?utf-8?B?RE9XY2pJWDVtYkJJRHRaM3pUcVJNZDVsa1VMN2NCb1ZCaWhiWUZHcmlQdmgw?=
 =?utf-8?B?dy9FOEJnaXVEcGFSSzFBbXNXUnpQVWw0b251VUpNZmhzeGdMWEcrNGZLZFhN?=
 =?utf-8?B?Zm1xdW9hZ2pFSFNoMHI1czdRRjJJQWRGOEpBYURieWNneml2cXlxZEl6bnMv?=
 =?utf-8?B?bnBvUmNTTWozcDkwa1FhcHNFYzhwdDBURWlpMEE0TmRDdVg3bndlTjdMZ3dJ?=
 =?utf-8?B?QWl2b2t3aE9ETzJGaDV5YjdZMUtOMzNRSVBnTEhDcHhHQ005VnhQRkhYNTFF?=
 =?utf-8?B?c0pnVlczeHQwWE5LWUtvQTVrMXBKNlRCQUVRV1pMYmd0OGFNZngwUDN5TUZp?=
 =?utf-8?B?TUkzTVdSd0ZnQ2s0aWRweUpjdDNUbWdkYnFhUEZycFFVQkpOQ1NaZ2MwQ3lG?=
 =?utf-8?B?NlNCdVZxK2VtRkpzM1NnT1hDVkJZR2EzY2JvcXN5RHN5VWVuZXIzck00ZFpG?=
 =?utf-8?B?Q0NrbnZHU2UyZWVZUi9vTnN3cDRmalBRaURFZHpsMnZXY2FQbDQ4LzJzamMr?=
 =?utf-8?B?dHVTUXBoWDQ4TlpXVTY1alNwMVgzR29JbDNrSjJybE9HbURZa2JQOE5CdjRQ?=
 =?utf-8?B?RG9IVUpBN1hENTJJcUtyaWdUb09HWUFQM0d3bmJqTHFoMUoveWxEeW1pOVVI?=
 =?utf-8?B?bHM0d1RBRVZsOUhQeTNEYmYxeG5YN0hocXFCQjg1aktTcmdNdlUzMUswdElt?=
 =?utf-8?B?aE5FVzlnYUJxdXZ2b25jRjhVYXhxOGNzS0Q2T3BBTXRKeEtsdEFpQjNLUlNm?=
 =?utf-8?B?Ykh4UHBYN0NoYndCSGhHWHQ4MVZrbWJDTHZsNjY1VFl4Ui8yRjRUWHR0MFZQ?=
 =?utf-8?B?VTZubUNPcGdlOUxTNWlQYm9RbEF3Mi82YkhVVWNYMVVtUnlxZExkMTdycXdV?=
 =?utf-8?B?K01lZURwOFBZcVZ4Q2dLaWFRRlRWWnlXTWRFVy94TERHRTZjalFRSk92cUVt?=
 =?utf-8?B?d1N2NHhuQWg1bWdDaEJic2RWaDJzallTQ3gyK3ljS1lUU2hXbURhRmx6QkZD?=
 =?utf-8?B?bFFKNmcrRUZaR3lwNS9qRUVaTG5lVDlyR0lwb2FPcXV0N0lzWFYzMm1XRVhs?=
 =?utf-8?B?bGVaOUlrbUx4OFpqSUExRWluYWlBM2x5UU9VWGdOajVOSmF5Mi91b3R0Z2xQ?=
 =?utf-8?Q?AUXvsdzKNlxbN7qU6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2ca32b-a2a3-4078-3a74-08df0cf90656
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:59:40.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ3k9QbQbOx11d2cSx3B97clloyVbe7CUvC6YK/hQ14q+LENDfOQBpZ55omiCDQ5FOoaMX3l+Dj7k7KVRauzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Ok. That makes sense. I'll address it in v2 and incorporate Christians comment too.

On 9/3/2026 2:12 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditionally returning success when ATOMIC_REQ is already set bypasses root port and bridge capability validation.
> --
> 
> commit 174dddecfad7749ccba344bb23492b342569e86c
> Author: Nikola Prica <nikola.prica@amd.com>
> 
> PCI: Accept AtomicOps already enabled by the hypervisor
> 
> This commit modifies pci_enable_atomic_ops_to_root() to check if the
> PCI_EXP_DEVCTL2_ATOMIC_REQ bit is already set by a hypervisor. If it is, the
> function returns success early to avoid failing in passthrough topologies
> without a visible Root Port.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f80..7c62c7f317572 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3768,6 +3768,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>                return -EINVAL;
>>        }
>>
>> +     /*
>> +      * Some hypervisors already set AtomicOp Requester Enable.  If it
>> +      * is already set, there is nothing more to do.
>> +      */
>> +     pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>> +     if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>> +             return 0;
> 
> [Severity: High]
> Will this unconditional early return bypass the capability validation for newly
> requested atomic sizes?
> 
> When drivers or subsystems sequentially check for atomic support, they call
> pci_enable_atomic_ops_to_root() for different sizes. For example, in
> drivers/vfio/pci/vfio_pci_core.c:vfio_pci_info_atomic_cap() (around line
> 1059), the code sequentially checks for 32-bit and 64-bit atomic support:
> 
> vfio_pci_core.c:vfio_pci_info_atomic_cap() {
>      ...
>      if ((devcap2 & PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
>          !pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64))
>          cap.flags |= VFIO_PCI_ATOMIC_COMP64;
>      ...
> }
> 
> A similar sequential check occurs in
> drivers/infiniband/hw/bnxt_re/qplib_res.c:bnxt_qplib_determine_atomics()
> (around line 1001).
> 
> The first successful call (e.g., for COMP32) validates the topology and sets
> the ATOMIC_REQ bit on the endpoint. If a subsequent call is made for a larger
> size (like COMP64), this new logic sees the ATOMIC_REQ bit is already set and
> instantly returns success.
> 
> By returning early, doesn't this bypass the cap_mask checks on the root port
> and bridges for the larger atomic size?
> 
> Could this cause the kernel to incorrectly advertise 64-bit or 128-bit atomic
> support to VMs or drivers when the root port only supports 32-bit? If a driver
> or VM attempts to use these unsupported sizes, the root port would treat them
> as an Unsupported Request (UR), potentially triggering a fatal AER error and
> crashing the system or terminating the VM.
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260903121218.4955-1-nikprica@amd.com?part=1

