Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354E47042C;
	Tue,  4 Aug 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860426; cv=fail; b=H4SRZVKYYDd5rMphS4Up+F9OeVjxFbvKOhr5G3cmBLf7dimYcZnunbdNTmqtDJi1+Qls30vRDxPRw643wKjlKk7OQ54a4er/hXrgADuOx3mHHCeRZTbMdriw6dOo7ucOkIlFmmVPRZimoHkFmlLbftqNT0uGbRx8ofyHb2+h4FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860426; c=relaxed/simple;
	bh=C7CKP7Rfb2UuNSpbtJwb+fIhwHn6OYHwbHNndkaC8MM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GaJsTQ89eGeOuYHG346OSaX5AlpilqKPAaXIqL+vZo5JLfZIUX/MUj+Bi95Iw91+ALtVP96GxlfnNVTqdLIuo52QeU1pe4WWN5vHGfjJitavaM+9az+BkFuHKsx7N1Ng8DFz+udbclkQLwjSHibRcwDK6hGgOR2V0BwgGhdMurk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NekRAiz2; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NekRAiz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KclcfxkPg7XiEgsg7cG24JjOmyIj0B+h6k62fhgsQNxq70vpGnEslgTs1+HFrnI0U0GUpey9V+B/AckktTQy5CBU3iuPaa3eUqSTdqgpwjTyzHgs5EDIMEeM4EHpUa+jxc7Bv0CS6j1nBo5QutZE1RaQdJcHbwoLHUk1nbfFc8XoH8gHsYQLiVF84gDvaMADFg4o2PKiHklSnQZMPfjcC0txUANGU7EmilSm0GVw8FORKSFoccMGRnALoOBa4FjsM3L+pP3PhsQ4Z0sRhEQ3YJ1eSf2vwxJvmmVZ+WqFg1SE4oaJgEdxzIkszbODzZQ9m/7I4cGGOetOTeR8NFDzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6Iq5GjPyMTElVSwyPn03ZcRxVvDJqEJG2TO0x9g0PM=;
 b=SSGm1CY3CUhjkbMS3UJGq//SGOZuKZrXWOzDYhrQXqXBbg6P+Uqb5nhv4m7OVC3eNWMTrAt6cY/W0tL7wH8AX7aC969nZH4DYVU2+1pZqt6yAvNro+p6YSnpeOdCJ5qZ4jxOJWPjg5zIxKTeKoSKYsxEnFVS8kzxZ4d2yc14BV06kp8pgag8OZUYiVkoPyIU9huw/6WTSXHCI2ZzUmf/DGJ74guBqc08S7tBUbES/GHje4X53b7kkIqzXj1U/twlgbgqANErnN7LkSMPcoTxzoFO9a7rYyoFkUoa0KzhjfKL+uMUMvtnaLgm7T3WhDj0amnRtecYPAcKk1YH8CZ0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6Iq5GjPyMTElVSwyPn03ZcRxVvDJqEJG2TO0x9g0PM=;
 b=NekRAiz28Arq5oK18fI8LhASHH1jOUqC1nCU6gnWfpUiBP8PrO7LrZQFYS/JhbfisLghv/jrzsNUgPAPKfIhomNXRT/HOWeGZXmgYjybHSw3h+kFKO/dwJfik6HmFBtFf/vzKrTe5mcrD4ZM6mjTqI3E1gehaKzXtHY6+jE3JPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:20:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 16:20:20 +0000
Message-ID: <1ca568f6-b9f5-45f6-a362-5ba0be8272f9@amd.com>
Date: Tue, 4 Aug 2026 11:20:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info()
 out-of-bounds AER register read
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-2-terry.bowman@amd.com>
 <20260803224230.85CD81F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260803224230.85CD81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DSSP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::8)
 To CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 363e7e5a-8f9a-4293-78e5-08def2444772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	caWBhTClJEMVpDTf8wYS+FjG+wglVujm/FRLwSfVodwrnjDSNNZ73Z/QhlGsPm1o7G8sSFzKCb/1m0q5grnwBQkYOWA7StOtxg5h7zwx1ObCGnFaErC2ujlH8O0QktV9yNc94fZGb6zVNzoSZL0l3ZDJus3BZhzfvorqi3G22jztXF1mDIUjkaGr3MAvOGHQRNftJ/iLfuTNDzqQrKx27USJKJe4jXUp5+rNzv+5ZKTKunfQunPKCdx+s8PZYwVh4Cal/HIW4cro09A6Ta3uTqI3xc3jbvtJu3Yi2POrL+qKtH6A/PP23qevQbBaGCY5aNvQx+PIQj/7BU1GQjbRK00ojUiitryg8i4ylyUDOyJpcQps9+mRJzvscLyUfMK2SYFj/XlRNbwp98MWu6b5H6Ey/TrR/cNnOXoSzJUZ+qxTimGF+mYtuym1leA5nvRss1QP/7i2C0PVe4HAkMqfFW5y7Gvs5WW4REJHJMlxP+TZAHE6tAmbv/YoerTwnQ4O2XYwcaVUPIuw4T2D0wqRoLCsi3G5fgGSXoU6lgKTh39+1Zdoe495vTuGLv3TpTH7JnGawpDZmPzchGUiPOD4m1QL/+xPgrn9+Uq7gce1kTxqDzgpSIxzWgHfVbqsOL23x2K4xrPIdXqYKqYQP/HX5mhkEOUd+SykfLqphWMFqlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NuWkNrRWR6RXgyQmsxNE4xWUhIZlN1bzRaa0Q1T3Ftc01rNjhEbVEvSGdG?=
 =?utf-8?B?MzhQK2MzZEJkKzZNTlBBR20xL2N0d212alU1ODMvSW9iSHljd3Evb1RIcU5M?=
 =?utf-8?B?SlYxeUUwVXI5Qkd5S3JZZXZUdm1qSU8ydVBvT1FLbzVmeXZyVnNvSEZkRmMx?=
 =?utf-8?B?YjBuZ05vQTZlcVN3bVQ4L3hSUzBoRnRvQjQxRjduVnFnQk9majUzVi82MnJL?=
 =?utf-8?B?ZWt4QnVwcWFSWlJGSkpjQm1RQ2wyRDIydFkxNSsxQktXRCt3YzJXYmxZUGJl?=
 =?utf-8?B?VEFZQ0dxc0o3VDlxMjdPajhydXZiQXlBR0FjN3VwV2VwY0YyMytDaU1qVHF2?=
 =?utf-8?B?cTZqbzlkR2dwTGliN25udTZ0UnJXU09KUERnNlJtcXh0VWtEQWJkQ2ErSUND?=
 =?utf-8?B?SmxOT1QzejQzOTUyNlU5NThBQ2pXd29XWEJtRjdoVGYrOVJQNHNGQUVRYTgv?=
 =?utf-8?B?STFndzFiUElFbmx2elBwbGk4YlM2N2M0d01wZ2VubVMvNUY5UU9POStyZHd3?=
 =?utf-8?B?SHdZSG9WRSt4WkRaYnlrT0tTSENhb09BRVFsb0dka3J2SFZ3aHJtMG9vcklP?=
 =?utf-8?B?ejZIK1dBT3pQZ0U2bnlOcFgxY2pBK0FOaHNLTmhWWTZEdW43clBxc1NaN1JE?=
 =?utf-8?B?OTliV3dBVlN0SE5LOVAwTVNZNlRYQUpLdWVmUUNPbHhRZU1IUXgyVFpDblRJ?=
 =?utf-8?B?WG1nRUhsMWp2U0ZDWThQNkhiSHRab1l3cThZc0lQTVRHMVRnQys0SmIvcDFm?=
 =?utf-8?B?MFFyTVN4T2N6UlJrU1lIWWY0eTMrUStSVG5nbTI1TkczeU5SV1dRYmNpWHZt?=
 =?utf-8?B?cFpvZi9PL2JLdkJ1azcxQkJpQWVvaElGUFduSDFhc216cW9Lc2RFbzdvQ1d4?=
 =?utf-8?B?RFJ4VmVDdm93cEFLNldISDd1MmZDM3BrZmw0UFpRQlVnK3pGWFVsMU5LUnVm?=
 =?utf-8?B?TWh2elZLS1RsdkxtTzhhZHZzYmQ3am93U0w1eGlqWmhEc2ZacGxxcXZTRURG?=
 =?utf-8?B?R2NQUmErdU5ocjN2Y2xnRFI0NTBJdjIvQXFEL011VHlQZWptK0duaEpQWFNu?=
 =?utf-8?B?cldFckdQdUhCei85R20vSUEvQ2pVS21vVmorekQwRUlsZ1U1MkxhL1FLbE9m?=
 =?utf-8?B?Mmlua01KNlozZC91OFZuUEdsRmVTR1dBTzY0RUN2OXBTeVVja1NVL1FMbFk5?=
 =?utf-8?B?V0g0N1UwdzQ3Y2gvcVVvdVcwYktHQ0tyYkNMSUwxb01sWDRUOWYvbEpuVnNv?=
 =?utf-8?B?aGZXbUhjTHB2V1NieUdNcE5uMmo0a1VRL0VEN2M5QWRjdEhLUm83TnVUcWVR?=
 =?utf-8?B?dnFLYVk2WnpvRDM1MDg2MEdSTjZsNFBoY0djWmVEN1VqUy91alpZZG1KOWVH?=
 =?utf-8?B?WWpCUnlIK0lIeUYwTlROaS9GVXFBa1QzS0YwNnhMV2s0clpFQnhpeVdjRFNu?=
 =?utf-8?B?dExkR3M0MGlmcVZCcDkxc252Zmh3UEUwNmJNd3M4Q2dDdkZHKzU2M2Y1VjIx?=
 =?utf-8?B?WVErbHdLNWxnZHpqNkgxMmFUMGh4SDFrcGxoaW8veGZwVkhqV1gzeXhpUWh5?=
 =?utf-8?B?dkxLT05BT2lrT1Q5YTlLUFF2S1J6N2J2NWc4WXpubkN6R0p4bXE1eWtUbGVI?=
 =?utf-8?B?dFozSW5HOEpqSHBKQUh1ZGthVTQ1NXB5aVF5ODUvNUpNc1hvcXZ5Qi80czJW?=
 =?utf-8?B?L0tCeFV5Zzk0V1puT2hiNWZhT25vdEkzRVhIZGVpZDNUWjB0SGRWUW9IMjVQ?=
 =?utf-8?B?bjQ2VVBkZHNaSFNLNjJVeno3QjREc2JmV3A1MnlKQVMza05ub1MwRjNsZG54?=
 =?utf-8?B?VnFEZmh5aEw4Szd3WmJHNE1DaTUyTlFrV2hSYkU4SmZzVXpIY3FkbThleHZQ?=
 =?utf-8?B?bzFWbzdqUkhtL2hqNVV4N0R6WVJ2NXlNQ0lrUkNRUHArbjVtV25mcXZVUkxj?=
 =?utf-8?B?MmJkUkFoZlFDNDBwRTk5bmpFLzk0NWhzdHNrd3pWNUwrT1VMQ2dXM29wb1V2?=
 =?utf-8?B?OE5wUmRBb0V0bHZXUjNWWDZnckYrNkJjbW5WQ0RsSHdnWDRWN0NscnBrWUVh?=
 =?utf-8?B?MXlGQ1pqRGdTaUh1TjFMT2dqZkFVZzAwNEVEckQ2aG56WHp3b2Q2SkVxdzht?=
 =?utf-8?B?SnNKT2JDTk1FNjRmYU1XSm5WVU5TZXZxYk1QQkNXbFM4NmpEODNvR0NQaFZh?=
 =?utf-8?B?aUtlYW1tS0htU2RvcmlidjFwejRhUlR6MTN0bjROaCtzU2lnaUdEQUFua1Uy?=
 =?utf-8?B?dzREaG1NampZcnZ1UFp4V3hzUnFPNWVtU1JxQ3Z0Rm5OR3R2NDFId3FId0ha?=
 =?utf-8?Q?FSam9HY7L35sMBUMyV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363e7e5a-8f9a-4293-78e5-08def2444772
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:20:20.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzuxV0t1VruH+lVu1pW9nrD1h+aUdYd9BtfmirJ1RYbb+O/JCImTZeTFyGWAH30iKCNlzTY/ylMDFsX3XtE5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On 8/3/2026 5:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] cxl_dport_map_rch_aer() requests an MMIO region using the software-only size of struct aer_capability_regs, over-reserving memory beyond the physical capability.
> --
> 
> --- Patch [1]: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read ---
> commit b208d5e7d4a18c48dd06f33bc3c5667e9a2c13dd
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
>     
> cxl_rch_get_aer_info() copies the RCH Downstream Port AER capability from
> the RCRB MMIO block using a readl() loop bounded by sizeof(struct
> aer_capability_regs). This struct is a software layout and its embedded
> struct pcie_tlp_log is larger than the on-wire AER capability. As a
> result the loop reads past the mapped AER register block.
> 
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 0a8b3b9b63884..8a3965edaa12c 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -58,13 +58,28 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>  				 struct aer_capability_regs *aer_regs)
>>  {
>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> +	/*
>> +	 * Bound the copy to the physically-defined AER registers (header
>> +	 * through the 16-byte Header Log). struct aer_capability_regs is a
>> +	 * software layout whose embedded struct pcie_tlp_log is larger than
>> +	 * the on-wire AER capability; copying sizeof(*aer_regs) would
>> +	 * over-read the RCRB-mapped MMIO block.
>> +	 */
>> +	int read_cnt = (PCI_ERR_HEADER_LOG + 16) / sizeof(u32);
> 
> [Severity: High]
> This is a pre-existing issue, but since you are fixing the oversized read
> here, should we also fix the initial mapping size in cxl_dport_map_rch_aer()?
> 
> In drivers/cxl/core/ras_rch.c:cxl_dport_map_rch_aer():
> 
> 	dport->regs.dport_aer =
> 		devm_cxl_iomap_block(host, aer_phys,
> 				     sizeof(struct aer_capability_regs));
> 
> This uses the same oversized software struct size to request the MMIO region.
> 
> If another CXL Extended Capability is densely packed immediately following the
> AER block, won't any subsequent driver attempting to map it (e.g.,
> cxl_dport_map_rcd_linkcap()) fail with a -EBUSY conflict and break device
> initialization?
> 
I will be adding a patch fix to v20 for the existing cxl_dport_map_rch_aer() 
issue reported by sashiko.

- Terry 
