Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4E446C00;
	Tue, 18 Aug 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051292; cv=fail; b=O8IePjn4BPzyaDQdvvgQX3i/a/ksi4JV9oQD60Cysw8ROd766IO7euKiqOXCN4gGKUrC7T1nIjnLMiY55YOHP893ar28TR84G3kuSGNvAuUdJ4Ew3seTMV8jgT/nRE1+MceAo9rgO52q99+cSx9BnunK+3xP5Dlhi4eoP0SviHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051292; c=relaxed/simple;
	bh=DxtWHHQOG0csMvtRFQMjRFzWDJwCNsC1BDXdfDzYuuU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDpLqXd6A17J3AD/4kz6qkJuQ9Mm1rGzaT8jnBteM4krh7Npn8wWrijWCZZND2v5xXdbdUOnApeG2YfqQ88cC/NyKPOkhQn/xSW0wmIq/XUEfm4Ki1Ha7J4+UgVAkhFAKeuOqMvW63NDDpNS/X6TfDDQOUKJ71nnkThoxC3tNdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FiilEh4A; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FiilEh4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXJ8LCuzT6OPJ17pyW6um1L2y3vlFMELKiDhcWkqcSlHC+OZ0aVCdFM6bJmCB1n9lKba+LCmtmMlq+sv9aZr5hN/mOU9v1++uMst4xnciqZwaiNoPVFMoD4s0sWF7cpne7EwgjFn7+rAxtV4uLtXV4jzIOCd3L7RhyjtPnlPvd5N0u/4wdqjoJhyOff0mAvCR4IGLvHkiY5nRAEcEON/n1Z3FLNskQ8YPDnQy3Eq4TF+On2ygHpJ6D0zgkR0O6w3CphwxfDtOcZOcsAWio2+lYuSDgo5jvUo1zA2ycMF09JqTdGrHaKFr+bMDxPxqF9kPkXxQx2h1QAFQElaE7Avcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=511tVD3Egtpb7MUwj1Mz/D4nXtyzWFpbiVd9kEgt0nI=;
 b=G6TjNEODGDPjnosJvgBdSTGniJr6m6su6oj6ntzrRjHVFzWkwQ+ywyovSQ/GYKegHLWJepXVMfslMXDXrF1PgNVCqEb1T3rvahzt0AaBLHpM5j3sIszZeVWlJB1T/42HlNZSJCKseKmTMMM0RaXFDSm7PNY3Vp//nGxpL0CDlA2WiHfwOKJDkEINk+1XIvh/rFQ2tHj1KnAa1Gd3PXQSth1bTHGRjTiF0teCzeVnKxWIWoRTMqKk+jWWw24QBKILXi2s9tXMJEqtmjnZYJ/j1oDYfK1iI1dr06HPaR22hYrJQsWVldI/F1Mk9uk7nv9TGj02NaGkGLJM7Mea4daz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=511tVD3Egtpb7MUwj1Mz/D4nXtyzWFpbiVd9kEgt0nI=;
 b=FiilEh4ADP9JpoLF95aEJ09IBZc4XqvyuQFkd8Bg+dOhW1/3J7FJXHjNyS7SlhNGWAmwfWYVKrvOY918FVcS4GTv/DZuqaWTsQG3b2xc1BmLoJetNeGfqCpvb8fyKitvARyCF9/doVDbPEWMLMfOcfm1JQumzFhkR18AC7LEiRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 11:08:04 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 11:08:04 +0000
Message-ID: <29383537-f9a5-4a14-88a2-0cf1053f991c@amd.com>
Date: Tue, 18 Aug 2026 16:37:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com> <anoHDRj1hFh9ftn0@SMW015318>
 <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com> <an3xf0TgbXhmYt96@SMW015318>
 <d2ba38d4-ef37-465f-a2cc-268c23a1bee1@amd.com>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <d2ba38d4-ef37-465f-a2cc-268c23a1bee1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef897ab-12a3-477c-47cd-08defd18f987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	sZSe2LBGfv7GznC8MbegoHoqBW9D8OfW3ohH8wO6VJR/3H84GQLzLZkT2Z1oSuyqLwGkqv/joRjdk4cIK+Eq+6lbrtJHAvpsSKmM/gDFuck2EzftVJsimDSN5ao2N3ja8OZ+GMH0RqcFRO84hn3D9jRmZKfdijMSCAKnhjeNOEg6qzEkEPXPdGM8xctGcUIvMDV760XrqyQlhkUkA+9vk9bZm5XY+LG5lZhTz1pK+ZcEkkedrFiAA+NDHWE+tsL5qTsYAU36TcCiXEcsYp+4U57z8kyopO22WzOZP72V/6DDE1WrHORsIeZMPgA5X1rX1D5NB+0BHH4YyHL/dwU5s61GzMUkpKvsi6X4jwn/SNh2XAT63wH7s3MfPC6m6lPEfgOb+5XDSqgSNfS83j/bQQ4SY2kozGn8Brj92vXlTqk/VgVH8aF4LmzTE5jUSC4+HzJrIZuv9pezBy2sG1HeUz04cGALbK6ueYmivxY6rXEA3fo1uhCosPWpkezc/M2WlhVM2DiCpTBzsd/J9L8dLNr629scg+RwlSB3mteEZbY6OkJd7RKk7xx+UVCm3HOau43wssWyr5pt7mky9WBQjyuLQ+haFLaVxfs7OMxrTP5Ds0GHHny+srCh0cbuvJQlOnHN4mA0U2ma5UJG5HkEBT+PXJq+vE1/Hf/BF2yieDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q25GWmZRNFV5ejVrY2FmajYxNkhxeUM0cG03eGNHaENIZ0dTanBnQzJFSk00?=
 =?utf-8?B?djBTUlRVNHphNWRwWG5Ma0xzYjlSQ202aXU0MFM0YWVVenJTazZuWGRJU3p6?=
 =?utf-8?B?U2hZU2lWdEJxYTBad3NUTXN1WCtsa2JRc2RLZ3p3cU5TOVZ0Q2tiNkgydHh5?=
 =?utf-8?B?R05BVWo5WmZ6ejhCSHNBNXY1UFZ6emQwOGlyVTNtWENOUFdoN3FSYTZMWVRW?=
 =?utf-8?B?WHgwSHloUnV1STNSeTZFK0E4MkFHQmZJUUI5dTVSZ3E0Zk1wR2JTS2ZDTFVE?=
 =?utf-8?B?cEhndjRpSmpacU1xT25ZcFNIZnczc3ptTTkxYnJ3ckk4Q2dQNUhxM0tGVXg2?=
 =?utf-8?B?UWtmZkoyTkpDV0R6bkdLOEV6c3hjYVFLYVFFSDB4VGhvOW9YU0pqYzgvYjBo?=
 =?utf-8?B?ZVh5VDh0SDdMc05RMmw3b2Zpdy8yMUlQNUZKaVRCUTV5eDlONE1rRUplNUdr?=
 =?utf-8?B?c01wa08wWDQxTVRoK1lzeldPczFVNnBDZTd3ZXVsMWI2SFlFUFVMNFhMYmZD?=
 =?utf-8?B?Sm0vc1N1UGI2NUJPWkhuSmY3U1BhS2FQekVvYk0rSVMya0ZGaWk2SlFVZC9w?=
 =?utf-8?B?UlFxdUYxQ0tqd0NRdzN2eERwQ3ZhUk1KY3Z4S1VSMUFad200a2VoT3ZjTGNJ?=
 =?utf-8?B?VFJqblBmaWxGbGs0NTdqWUZoL0t5TmE3VjQrb0IwZFdYVnpSZlpvb3VQNm5S?=
 =?utf-8?B?eTNIT1dHNjh6cU4yZUdyajFVaElManBXM3FNRlJTaFdtTC9qTUhCSGtlUnpU?=
 =?utf-8?B?cjd1RHVWNENtS0w3Q3JxenY2Q0ljVi9kZFhVd0ljSWdnbk82WDF5TiszKzl4?=
 =?utf-8?B?VnZrcWxzZm96NlNSeW82MWI0eGhheFE2YUJwTDcyaXBRUUR4alZqc2ZqNU5X?=
 =?utf-8?B?QVJDbFlFb0hNT3RTanhVWmZCcVV4bDZqYSsyYStQTXJzV24zNmhtVVJkanQw?=
 =?utf-8?B?bC9TR0VWMklnRlV0UkZJcTZPWHpLLzduV0xIbUR4dndoakR2Vm04Z2ZTMDVu?=
 =?utf-8?B?d2FIUWhuUG1iSFhKWUVqd1hKQXl4c1pUUjRFWnhrN3EwVXFUcTBNTmJnOGhl?=
 =?utf-8?B?TW1LcGxzRm8reCt3VmxzOEdyNWg4RHRnQjhtNXJ0aElVUmUyZHVLNFExb0ZN?=
 =?utf-8?B?Tkg3dmM0SkF5NHBXeFpvakxxSXRyN1p1aHlXc1dMN1RTM2gyRVo2SzYvVStw?=
 =?utf-8?B?SlAwRjAwdldnY3l4cXQxWHRTWGJ2cEJQdXVkZHBaSkt6M0NoY2xSTXNRK0JP?=
 =?utf-8?B?aEtUMmJTSDFCNlZScjNyNkMxUnhONlo5NWNwU3c0VXJWQit1aVBrZmdYMk4y?=
 =?utf-8?B?MDIxWjRXaWw4MXRMTmNucnlPdzRjL0lsc2hheHlBcENUdFdCVDdlOWwxWCtG?=
 =?utf-8?B?S0NQRU5NZXEram80bkt1cEJLdGxPd2Z1Qm5DS3R6N096TTRXS2QwYzBCNG01?=
 =?utf-8?B?MUNqS1Vvb2NrSTJJbG1GSkNjN24xaUpqbEVkanNid3c1ZGk0RjhjVCtWQzJ0?=
 =?utf-8?B?UjRKOGdNV29DTVNqWnNRT3BhZ3kzVDdVMVQ5MjJsRG9tNHpvZml1RU5pVmpa?=
 =?utf-8?B?YzRQcWZqaG9oNE1lTE9Ja2dhYjhUNXlsRUJ1OGc3aE9mYUJzQkVXdVk4Y1Vr?=
 =?utf-8?B?VlVueWpIZ3RPdUxMSTRNMFFKOU5KKzVxNHN6UE9DZldnNFpjYytoYkhRSTZq?=
 =?utf-8?B?U0NoM3dWUWVCOWNncjJCOHNGWWpsajdBLysrZWRDTGVXM1pJZjNrUkFCM21P?=
 =?utf-8?B?MnQ5ckxHVUdTeEFmbmlLQyt0a1RvcElpNW45Z0dkRHFTY2ZwZHArM2J5emZu?=
 =?utf-8?B?VllzZFlsVW84YWpydDUxaHllM2s3NkJmemlmbEt0SHVrbExTdTdObElLMm1x?=
 =?utf-8?B?L0l3NVBqS0pKcWpxTG1aY3RhbTV3bXFRSUp0Uk9FQWdlVHZ5RkZqd3VaZHdF?=
 =?utf-8?B?cE1KblJZVGVXVWpLZHRhYXY0T2NzenlWM3JsZTNRQVMrcWtKaURXNjB3SzJo?=
 =?utf-8?B?UzJFVzAzM2JHVWdyUkZNcUFiaUNyU0ZPM2hpUytkVi9sZzVsRUFjbnd3ZzRH?=
 =?utf-8?B?ZFJGQVIxSkVKamhyVUhNVXVINHRuZkxvSXIyazlGYW0zMVoycWFwbzJJSzJW?=
 =?utf-8?B?RExrTE1zYkhPeVlBRUtsZzVGd0Z5YllWWitOUU1nbTZ5a1FJaHROK0R3UTMy?=
 =?utf-8?B?NFYvNThjMGxvcnFnZUFreUlROWI4bURHWkVPVWYxbVhpbzF2K3hIV2lKbytN?=
 =?utf-8?B?N1o5bXJLYWd3L2ZVY3BkT2g3V2lxSjBrRVFUUk42WHJLZmxZWXJXNG1USmlh?=
 =?utf-8?B?T200YnFnVjNkdVVVVTNVdDlacWdJbTlrRDQwajhsTTNocXVjamt6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef897ab-12a3-477c-47cd-08defd18f987
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:08:04.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv4h2sne7gqnXcHfLOjLWc6nrqsWCDQ7lM7iwKIHULvYsublAljohL8OpO12Bm3rtchyt8UBWF4Nc4UxVSredg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

Hi Frank

Could you check and provide suggestion on the comments
inline?

regards,
Devendra

On 14-Aug-26 10:33, Verma, Devendra wrote:
> 
> On 13-Aug-26 22:01, Frank Li wrote:
>> On Thu, Aug 13, 2026 at 05:26:51PM +0530, Verma, Devendra wrote:
>>> On 10-Aug-26 22:44, Frank Li wrote:
>>>> On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
>>>>> As per, 'Designware Cores PCI Express DM Controller - Reference
>>>>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>>>>> the channel separation mechanisms. Basically, the HDMA IP allows
>>>>> the user to configure the separation between DMA channel
>>>>> registers and retrieve it via the VSEC capability mentioned
>>>>> above.
>>>>>
>>>>> HDMA IP supports the channel register space separation from
>>>>> 256B to 32KB. Default supported size is 256B.
>>>>>
>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>      o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
>>>>>        applicable upon reviewer recommendation.
>>>>>      o Dropped 1/3 patch of this series, after review,
>>>>>        now the 2/3 is 1/2 of the current patch series.
>>>>>
>>>>> Changes in v1:
>>>>>      o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>>        The function now supports ch_sep_sz up to 32KB.
>>>>>      o Updated to description to reflect the supported channel
>>>>>        separation sizes.
>>>>> ---
>>>>>    drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
>>>>>    1 file changed, 17 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw- 
>>>>> edma/dw-edma-pcie.c
>>>>> index 791c46e8ae4c..5d7507a64056 100644
>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>> @@ -31,8 +31,10 @@
>>>>>
>>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID        0x6
>>>>>    #define DW_PCIE_XILINX_MDB_VSEC_ID        0x20
>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR        GENMASK(10, 8)
>>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP        GENMASK(2, 0)
>>>>> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR        GENMASK(10, 8)
>>>>
>>>> Don't mix code cleanup or reorg into this improvement patches.
>>>>
>>>
>>> It was recommended by you in the v1 of the same patch series that is
>>> why pushed it.
>>>
>>> Ref: https://lore.kernel.org/all/amDbGHRbObX-lt5F@SMW015318/
>>
>> You can fix the order by using prep patch, which just fix order, typo
>> or some cleanup.
>>
>> But not mixed into new feature patches.
>>
>>>
>>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP        GENMASK(18, 16)
>>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH    GENMASK(9, 0)
>>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH    GENMASK(25, 16)
>>>>>
>>>>> @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
>>>>>        u16                wr_ch_cnt;
>>>>>        u16                rd_ch_cnt;
>>>>>        u64                devmem_phys_off;
>>>>> +    u32                ch_space_sz;
>>>>>    };
>>>>>
>>>>>    static const struct dw_edma_pcie_data snps_edda_data = {
>>>>> @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data 
>>>>> xilinx_mdb_data = {
>>>>>    };
>>>>>
>>>>>    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>>> -    /* MDB registers location */
>>>>> +    /* CPM6 registers location */
>>>>
>>>> This typo fix have not mixed this patch.
>>>
>>> This is subtle change. Since the focus of this patch series is CPM6, the
>>> namings and comments should align with the appropriate name.
>>>
> 
> Can we take up this change along with this patch series as it is related
> to CPM6 only?
> 
>>>>
>>>>>        .rg.bar                = BAR_0,
>>>>>        .rg.off                = SZ_4K,    /*  4 Kbytes */
>>>>>        .rg.sz                = SZ_8K,    /*  8 Kbytes */
>>>>> @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct 
>>>>> device *dev, unsigned int nr)
>>>>>        return pci_irq_vector(to_pci_dev(dev), nr);
>>>>>    }
>>>>>
>>>>> +static u32 dw_edma_get_ch_space_sz(u32 val)
>>>>> +{
>>>>> +    if (val > 0 && val <= 7)
>>>>> +        return 256 << val;
>>>>> +    return 256;
>>>>> +}
>>>>> +
>>>>>    static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t 
>>>>> cpu_addr)
>>>>>    {
>>>>>        struct pci_dev *pdev = to_pci_dev(dev);
>>>>> @@ -279,6 +289,10 @@ static void 
>>>>> dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>        pdata->mf = map;
>>>>>        pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, 
>>>>> val);
>>>>>
>>>>> +    if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>>> +        pdata->ch_space_sz = dw_edma_get_ch_space_sz
>>>>> +                    (FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, 
>>>>> val));
>>>>> +
>>>>>        pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>        pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>                       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, 
>>>>> val));
>>>>> @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev 
>>>>> *pdev,
>>>>>        struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>>        struct device *dev = &pdev->dev;
>>>>>        struct dw_edma_chip *chip;
>>>>> +    bool non_ll = false;
>>>>>        int err, nr_irqs;
>>>>>        int i, mask;
>>>>> -    bool non_ll = false;
>>>>
>>>> unnecssary change here
>>>>
>>>
>>> Yeah, this change was part of some patch series I pushed.
>>> This change was breaking the inverted X-mas format that's why
>>> made this change.
>>
>> But not related this patch. Use a small sperate patch to fix these small
>> problem.
>>
>> Use a small patch to do clean up, for example
>>
>> reorder register bit defination
>> fix commends about CPM6
>> fix inverted X-mas format.
>>
> The 1st and 3rd can be taken in a separate patch series but the 2nd
> is related to CPM6 only so having it is beneficial with this patch
> series, removes the misleading comment.
> 
> I will push the changes after your response.
> 

Any update on the above suggestion?

> -Devendra
> 
>  > > Frank
>>
>>>
>>> -Devendra
>>>
>>>> Frank
>>>>>
>>>>>        if (!pdata)
>>>>>            return -ENODEV;
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>
> 

