Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509644A3F8;
	Mon, 14 Sep 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394107; cv=fail; b=Me5yIpTyqUXfs2V6vfPzo0rqgIaLTIJgQ/Nn/yUtWZlRvk5oJmT41oKuW80HzNvaqIZWPTgfq9f1cBrmXnPkUW5QCdhwoZKG5pPyy6Dkdvxka/SkiNQXE6n8it66DL9JItlhA9euT7SfEdyveeeDU+ifEpxtEdFHGYmd0kILzro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394107; c=relaxed/simple;
	bh=GDIvSAZfXjF/5311CE0u5L45Q5eWqDdA6lT36UA2oYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EXy1VKJIYUguwusWS+q7OKtdeTccNys2jJW/9LQeZtPGT5AKH2rrNyBdZlO1NIoi/hmWNdhu8Q0LlZMm+7h7THMdxhdz8xics4hBZ3HskDuviNi7z+5weUHfYj07frIA1oviAjtTIbKkwpG5YKPLxRobiqy5JMeTsEkaX4rmg/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2HgZzry1; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2HgZzry1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=royt5BZn4lXC5EQRU8n34BO2vnn8lsi72ezsHv1lGJTSbmXsbIjaOkxMr8OqZTD2yvtYzttHzVJyaOUtCbQf9i2o9ehZ2efFyfH/PMLiCuqKc3TDyk9xgNwXnHFTGavfKDAwN4H61qOf1OYrxA2gW4CoI0kGP9epwyaa0xIYmKkGYyzpBo4zPt6+ag+oR3y5f40QTHBnrFJnbhoB0ElJ2i/fSuuG2khSChjvjR3E2J/csgEvnidpbpfsNMr+kC5vP3oQhrJ6npBzfT+rlggnZ4vkpk9Gz1mV9akBhuaUo9+AH6/b+Domn5VWCjXnXoCVlBvTNMiR17mmCVYZkEtDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT+bPT6BT37CqHDlXg4gaMIsosMirdvJfmGWQF+NReA=;
 b=zUzn0tiUp1gbpkkvNkmaCjjYNzv4MvSCpW3oU4+PjFXJynPY06ZmsKlVofrxcf6DP0IY7l5HafWgiJNo//R7BZSd8pegDVWx5FasWQ+S1eHcBrcA+JubLvS2xYgNVHx/0xW4HWtlVpc/Pwg6Wwbyk82v3PjWpu4XwKt0VuSs0LPdchxpQVYm/VB+OHIleB6LYjif/I8yRxsJrZptd//SVVuK3LIy08ulFBdxqqpF4Pm8tXTPIyGEIyTl7Y/5/VEah4ZDQBrBLTmCGV+BXeogUpBpRNwmKa0uL24I4oITPuHXI2MpxV1wEYhu5Q4ZY/gknImieDiQ0DiIVEZ5WlD7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT+bPT6BT37CqHDlXg4gaMIsosMirdvJfmGWQF+NReA=;
 b=2HgZzry1pQWKKzezSJ1sERiApCDQ7W2AUwrZnygbHu+cQyRYaIFSJTEGWzMeZ5i4voQ6x0tgU7x4yg3Xw64bEHJhMQEi/5vd3a40FtjY1WNJZmbfAWV1N2BKcgzkXRzpmTyT6dhNV63L/xWVpz42StIUDcZwe1Q5EjlBwrg0qno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:54:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 13:54:58 +0000
Message-ID: <2631bfe3-7123-4f44-b34e-8fd697c7dd2e@amd.com>
Date: Mon, 14 Sep 2026 15:54:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: Gerd Bayer <gbayer@linux.ibm.com>, Nikola Prica <nikprica@amd.com>,
 bhelgaas@google.com, Niklas Schnelle <schnelle@linux.ibm.com>,
 Alexander Schmidt <alexs@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
 jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 Nikola Prica <nikola.prica@amd.com>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
 <85a220af90568124bd4e7d354a8741b612955595.camel@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <85a220af90568124bd4e7d354a8741b612955595.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb168e8-47d8-47de-fe3a-08df1267c34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|5023799004|11063799006|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	anECO1MF4pb3AH7sPAa6lki2udUVOZVCUuvSnxvSxAJ2pk5THNmsiCRUvmhhn68T8i0HrELqXsJDWlInY3ghCGWSDuTOtMaqEJ7LZrejRvtUIkkQCa5QXVgcWYWJ3atsk9ujBpa03XMOQalp0XW4VeA1kK1HsyysTUx407VYeHoH2nJVkf5G26tTH4hrNiUyGkYcZmv/bX6yokB+q6etLXFJHtecY5d7RQHMSbezP2iMIRVceJakgKBgycNxvFQXml1p3TuHeB9Nv3jYFLXb2Br+PrB6R2San9SPS7N0wAWYWD/1LNAw5zms6jbOznfwC/PqBpiPx94NcsOsO4MsGzCz2mREZmDtyiD2XynDtxvETP+1y5YDYLDupZB/nOMndxIaz1nFzM5/YaiZ/GUldeairDwu6ZUZT8rzHZv5SzQslsPoNwL/LLtZjhJ5CAmFfiHvyOEbWSZ60onntSUizku0EY/1E6XvuD5YO+UHcsJfTJakS3Xek1TUtOSpxMS24iIPMvdaOxgelSUKhi8qPMDjyKICvFmZXks80T/MjQ7m9B6+ZFJ237FNmDBeToKPP+H2qee7MjRmWz1MZzrulWFY7vBwvBmpIr7z3BVgkr2I4XRmWBlUQkKwMvOmIXZJJ34bw9PWZvegtSNAUW19udncJatS2EluK73Xs7ELT6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEIrR0dJVTBIdExoRCsrMzZGMFdrZXFMcWhhdkhtUHBUdG5yb3k2UDM3bldG?=
 =?utf-8?B?SGxtaDJpRzRmNGYrNE13RVgzOVJPV01jLzNtUTBQcFRmYlAwMWhGOGVma2p0?=
 =?utf-8?B?NTZiRjdzYzVJWUprSmNKcmk5N0RPbnZZMGFrL0pRRGlObXRvc1FySXJsMFFO?=
 =?utf-8?B?R0NIUlk3bkxYZVVNUy81Z3pKKzBrVE8ycVFuMEhXeHF4RmFtSmc3NnhNWnFW?=
 =?utf-8?B?UGptR1ZxZy9ONTBud1FqQ3B5aml2SVEycDVNVVdVV2U2U2J0bC9mK21nMlBu?=
 =?utf-8?B?SjU3NkVYY0JQRndKR2VKYnZ6TWJtZDNRRzRReU9OT3VqVkxGcFhMSEs2dlZW?=
 =?utf-8?B?dGtvdzFXckIweU9nTFNycUNDNWFOMWpTRWs2dlNsMTFrZmpKbTdBaklzU2F3?=
 =?utf-8?B?STRYeEp6bCtheC9jeEdWU1pzNmNFeTJhbHJ2MGNSbWNBVU9XRncrQkxTdlli?=
 =?utf-8?B?VmwvVHpaeVlkaERiaCtpTm01VUxaQWRQc3R2TzZIQ05LWGFCL3pHU0VPVVZD?=
 =?utf-8?B?SXcrazBNbWIvV3FoTEVzS043U05oRHY1WG5hN2Vrckx3S2ptZkIydDR1VWZE?=
 =?utf-8?B?bC9xSzBWV09EZExKT0ZIOS9ZbVRaMERUMCsxdVE5SVE4V09USEhDd1p4UVBx?=
 =?utf-8?B?d01SZnE4aitmbVdyNGFPZk5CZ2pqZ1VKeVRYUmFpRWdyVHpNb01hb2syOWli?=
 =?utf-8?B?bkJxcjNUL3llaHRwRHpLeklqcE0wNngxb3VrbWJTTlQxNHFNMUQ0VVgrNnJJ?=
 =?utf-8?B?V3ROSmFhS0xCSzk3SUYvWVhpQnlyUUxvRWlhcFM4RHF1bVR2V3J1RWFDUmVl?=
 =?utf-8?B?OUlvbk41SUJYc1piMlNwQ0Q1dVh0eGxtYWJqam1ZUVBDTmZSTUduSTMyM0NN?=
 =?utf-8?B?RS9tZ3RsVUQ5eU1XeUJTT1o1SVRSblNIM2NzODdleWhRVjJ0akp1S2JLSzZ2?=
 =?utf-8?B?UG0xT0pYNGVvV1lieEdXeW10UXpjMFl6aEV1QlF6ajlPb0FlWkJuR3VOaHFU?=
 =?utf-8?B?MmkvR1FSdE8zc3dKUFh2N2JPUHZwVE9YNzErYWxKLzNRSzBYaE15bEdCei81?=
 =?utf-8?B?d3dWcThkRy9WY2ROUHBvSC90VEgzcnYycG9MUUFNSDN6N3lQdlpwaWFMYUpW?=
 =?utf-8?B?MzJnSVRiQW1RdlJQUFFlZG1XNVlyaWRLK0lhSHdPSzFQcGNtOFRTSjljOGVj?=
 =?utf-8?B?WVgvc1NPa3NWcnVEakI3L0k1Ui9nMlJ6YXVpeERRZzlTUlR2Sy9xcm9VaytC?=
 =?utf-8?B?WmU5eFAwZGMwNHZBNzE5cUNacE5SdkVkWStOYkV2eFVTSkE5Zmk4STNkK2tD?=
 =?utf-8?B?cnBnOGpWcE9zcUtxcUMwYm4ycXVERzVwUEwxeHN2REkvYXVOMUMxV05xbms4?=
 =?utf-8?B?Qzh3U2NQbENSZHVwMlFwaWcybnMxRFVUVGE5RmVBNGdjbHZQK1dSNlVuelRE?=
 =?utf-8?B?SG5UUjhETjUrV3pWWXBFcnpFWTZ1eldJMTFvb3IzWjhmbGhFc2YxMllpSzli?=
 =?utf-8?B?d1JuQjQ3M0RnMzJhbXBHVXJaVE1lWnBEZjk0b280dUY1a0VSTXdQMlVHOU5D?=
 =?utf-8?B?RHRXcCsvRXp3Nzd0SWVWZFR5MVNGL0JiNDlGMDdxczdjblVKZDJOUlpkWDI0?=
 =?utf-8?B?bGo3dGsxRTRSMUhVZ01JbWhMWW1YcStsWTdVdmEwTDB6bXhBenRyQzRvaU8y?=
 =?utf-8?B?aUdQMUorMzlHVE1jVHBETzlmTFVhTXdzdlNuU1VHcW5ETzlPWDJSdkltdWx3?=
 =?utf-8?B?a2dsa3p3aUlxUUl4ZlJKQm5xUjgrSHZkZzlnZ1RNd0MxSjByeG1odkFqaDZ2?=
 =?utf-8?B?akJ3bDFCby9UM1pxQ1JWZ2thaHpNUEpJb0tQdGZyOVl4QWNOL2JKNkN5V2ZX?=
 =?utf-8?B?TXRPZnhCNXQwZHhlTExxcFpmLzNCWXBuYWlpaW10cGVlYWNsWGdjd0tHdG1v?=
 =?utf-8?B?VlFtZ0pTcnNOWkJsMTVhTHhoQnJMRStCZHlIL2RFS1o5QXhFYUlpaHM0NFAz?=
 =?utf-8?B?Q1lraFFzSVpkRWZwSll1V1UzL3V0SjN5NzFrdlVOUktHL0hKWWt0Q3psSU93?=
 =?utf-8?B?clJJc3ZvUVFGSFJMRTJEWFFhelVDZmRvUXNoOUlHM2ZielNiY0RIV0U3aStY?=
 =?utf-8?B?Tkg3L096LzJGNEhrcG1CTVU1MzNWTXFhUkhmTFJxd1BSSFBXVWZVbWgxc3Nw?=
 =?utf-8?B?anh1VFVBNkp2ZkM4WStDTWFzdDBTakNnMkZScGRTNHl1NzRyWEppWkwvbXRU?=
 =?utf-8?B?UU5lQkJkdlhTRzM3ZVdlaWFKTmJoMjJvYU9aLzhXcXBiWmIzZVV1OVNzRUtV?=
 =?utf-8?Q?fRFkcr2G6aRpyElbQF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb168e8-47d8-47de-fe3a-08df1267c34a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:54:57.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVXvnVLcyX2ziNEtcEfpxWpMccvQbtwQ0KBFhOUHxU1l+xMVOO2EnboHy3M0NtBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

On 9/14/26 15:41, Gerd Bayer wrote:
> 
> On Mon, 2026-09-07 at 18:17 +0200, Nikola Prica wrote:
>> From: Nikola Prica <nikola.prica@amd.com>
>>
>> pci_enable_atomic_ops_to_root() currently fails when no root port is
>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>> endpoint is assigned to the VM, but the guest topology has no root
>> port above it.
>>
>> In those setups the hypervisor may already have enabled AtomicOp
>> requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>> treat AtomicOps as already enabled and return success instead of
>> failing the Root Port walk.
> 
> Hi Nikola,
> 
> your patch got me interested, since it touches those parts of
> pci_enable_atomic_ops_to_root() that commit 1ae8c4ce1570 ("PCI: Enable
> AtomicOps only if Root Port supports them") has modified.
> 
> I like your solution for putting the hypervisor in control of the
> enablement of Atomic Ops on root-less PCI functions and did test your
> change on s390/Connect-X, successfully.
> 
>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> 
> If that commit of mine regressed your use-cases, you might even want to
> add a Fixes: tag?

Oh, that's an interesting point. I wasn't aware that the root complex check was added so recently.

So indeed question @Nikola did that worked out of the box before kernel 7.1? If yes then that would be a regression.

Regards,
Christian.

> 
>> ---
>> Changes in v2:
>> - Be more strict and only apply logic in headless device case.
>>
>>  drivers/pci/pci.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b2879a6be5f8..62729ade496f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>       }
>>
>>       root = pcie_find_root_port(dev);
>> -     if (!root)
>> +     if (!root) {
>> +             /*
>> +              * A hypervisor may expose a headless topology with no
>> +              * visible root port.  If it has already set AtomicOp
>> +              * Requester Enable, there is nothing more to do.
>> +              */
>> +             pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>> +             if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>> +                     return 0;
>> +
>>               return -EINVAL;
>> +     }
>>
>>       pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>       if ((cap & cap_mask) != cap_mask)
> 
> At any rate, feel free to add my
> 
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>

