Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA9368293;
	Thu, 30 Apr 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519564; cv=fail; b=fqq1FDDb86Qm+UIzZi/4c0WRaK6+GZlIxfGzAKESIrKcxf+7rjCA4+myGtaWAMIfo86F4fm69ybayLT9KI43VcTLClCF5ATd7l2OI9puCdNP3N6skaOTpwYlhEHJeibJHxcMgLAwMNKRFD3CLCbYqqvYUKw95CAaHoEMZzp0QEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519564; c=relaxed/simple;
	bh=b4CTPb16THBE+oXfllJDS6js9qxXxAUWUbIO3G4KEuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sFVTE8pJAH43yCMrd0UXNvHuU1wi2B+syfGcVEzy15gIb9qJz4JlX4zqHntOirKBF8/Tn3aqpi4XWIVO93bE/Lt5fVt9N/37xbOJaLlnFZ2LRNsd1P2UDY9yDOdMeHjCDc7b08qK20cLG6F5rRw20c6/dCC/CArbZSeF+68HACY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bjabJOEF; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bjabJOEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcikllRleRLNrHHHpuer3mQsHvd4hkJLo0AEvALTGjdXujHESU5ab1eCWbUzu5vJ1T2Za2VzeTwvV6Q3AeWMFapKQP0/jc3W4TQ0DxRX+pnB41o7G3Sn07PxRGjySXfB/IkfJhpRNzJai3GqFsLvYk5tpBSf/l39fCrI+b9HnlwEvnWS7ZL769Jam1QcuvzOg0QFjPYegxCuw6fzWeMULy0YZE5cREN5RHu2fP4MSfoFdoJIFEhIpzOJ48MjyMNHnAK9K8jXKhcc8PeaoqYkQGelTT+HlL6Y3CuyHx69/ZsDEOy4qR+vCAw7v4+FLaUeD4FrZb/b8mgJpiT9Qbwcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EQySIysQEQMGWPIvnSFOu4eD+p3jcEEinwmVBzMKQU=;
 b=A6PI8VULoab3ZPTmcWBSXdeEzHFA4jXQ5JBntUvTixsfIzT9EjMNsEMeJWWHvPFLaMEKJD9Z3yGFwrH9TYlZkziCpP4IzWbX6hPdKNF82LcEFGWJCOvIbZBAhods3u3fhFgNu4d4gzOqf0FTGKyh3tpjKNlOGA+vR9bIPuZRm6282kWdtFEOa5zxu/iZXVUqD87FzaDXR2sT2KLNocSksW6W1pJJh4pyQpD6blSTxfDF0dR5LFMptq15GmhykkWHuS0FX81PfNq809jetGI4ot2SP3Wea6xnZ5LExMnhJkBTwOyyUaD4E5O9dmeNSn+VY9ilAdYAXwN5CjadBRfa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EQySIysQEQMGWPIvnSFOu4eD+p3jcEEinwmVBzMKQU=;
 b=bjabJOEF1Wydcr7ucHwk/hmLegQDXYfsqfaICERFJffQ3S2GEU9KHAHxNbetLvsbVdUIvkm/1DVnoAX7tpYMJsdx0Sl/ATNiezDeYOnlrDFfs+JYPLJGUY0GSLjdsWtSPFTqijtKJmQf7IrQFsq5Fo70B0S44Zg968e/nM25RRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 03:25:57 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 03:25:57 +0000
Message-ID: <a5fdf8f0-4e8a-4d11-aa5b-fd132f069ff4@amd.com>
Date: Thu, 30 Apr 2026 13:25:38 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: dan.j.williams@intel.com, Robin Murphy <robin.murphy@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ashish Kalra <ashish.kalra@amd.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Melody Wang <huibo.wang@amd.com>,
 Seongman Lee <augustus92@kaist.ac.kr>, Joerg Roedel <joerg.roedel@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Denis Efremov <efremov@linux.com>, Geliang Tang <geliang@kernel.org>,
 Piotr Gregor <piotrgregor@rsyncme.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Kim Phillips <kim.phillips@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
 iommu@lists.linux.dev
References: <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
 <20260228002808.GO44359@ziepe.ca>
 <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>
 <20260303001911.GA964116@ziepe.ca> <20260303124306.GA1002356@nvidia.com>
 <5d669086-a5c8-4e55-8108-a9fff41cf094@amd.com>
 <20260304124316.GL972761@nvidia.com>
 <074633eb-103a-4452-9aec-6cd61e82f0cb@amd.com>
 <137e5595-390e-49a7-8918-9ca057f7ebdd@amd.com>
 <20260420235046.GA3199414@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260420235046.GA3199414@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0022.ausprd01.prod.outlook.com
 (2603:10c6:10:31::34) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 70119e87-0799-4774-b53e-08dea66831c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sH/ZtkU61USPI5Ia8NjvikBZ5MWt8Kbc7ZouTfGP9THneO1HdeHY1JWwBZq9yuD8a7vcjx7NH57b7QgpYFEgddKIPLcNIs4On8SGc5g4aLnStu4LPW2Sx0LKpBN2GYbGs1nQd1nF2sKROkX3OGmT1Bm7HqlYzihApyZ8RorL20IgOQhkSppdOVteQSa2x4hqVhGKbI8H1Sq5RyVPiKj3rYKX/a3oziMxWsDqooO02NC715OH9RILs12bFArBhJvmbUR6wdBRqhPpl2Vsg925a6+CbYHMWu6Iwe4aPs6K45d4bUeJsaX/Q+b6ngApzssukRWgvEjEn+Wx8xXrV4Sqb0IAt3zTuwBUX9w79upeYLL/z+f+44ZU6NXU5GyiZ1Nd5SntzVIbCwAXeV+SSq7I0rnLwTiydWoSyfVaq/Uy7bBTt4ZhonzujM6KsJXht33eUlYgtCebVA8zxBW4189tx3LbZmsBspmBgBaFBQ4DB1iu4GPmpaHm/PprL7EJ74iTi8pg+fA9nNFY+VxTcBvzKhHIG4LTkjMUb369YHFKTxrT3CZ4gScu7NHynQ8KqZNWXZk5164kh4FSkNIkCpU31NLtiPx0sagwJHQr7PRVrGH1hHVqkW/pityv+8R6Gd59Uph1K+AhV6rWDv2KqwwjmrxZTQt9JlIQDKdbrWYOji6Eci7zNoTvP35NhxUvSBTOnQ67RsjU7M/yxHJq8nAYQch8jAgac5qyJcravqxREwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmY1VmJXMjdtcDUxZ2tlK3FDTVZqVi9IaEs2VHJSOHFweU45cXNkR3I4M05k?=
 =?utf-8?B?SE16OXV3TEJXa0ZmdlBWNkpGdVJ1N3RKUnNQZEl6b2VldjBEQlc1aGlvbm9i?=
 =?utf-8?B?Z3g4MGpQbEpvUzhTc2NKNkxOejdHUlVFVkoxbVgzckNsdVhGRDNPY1pzN2lR?=
 =?utf-8?B?UWhZQ29pV2hGa3VaQmp1TEt3cjg2ZFhleGVmRDVBeXVpQmk1YjhoNEtXdkVv?=
 =?utf-8?B?azljWmh1ZXdqa3V4YU5aZktSR2dwRVBqTFNvYzRMT1lJTHlFQ0k4YmZ4VkN4?=
 =?utf-8?B?UHFRUHBZWDRUWWs0SWpud0pWeWU4RFArZisyWHdrNUwwaVY1Y3lIYmRpeG9J?=
 =?utf-8?B?a2tnTVhtNFVlcWE0VWhSbWV5WFZPVjRIVlV6aEJxQ1BHVUVoRGg2TTZEWmYy?=
 =?utf-8?B?NUxYem5mZ1kwWmxrL0FicjFXWk91SzZWdkhUTy9TK2d0UXQxcXhBODFUSmtE?=
 =?utf-8?B?aUwrem9FY0ZHUTBaVnkrWkkzaFhPc3lDVDhBN3Q3MXZpQVJ4dE9Oa1RHVTM4?=
 =?utf-8?B?cG9DRnlxWU44NmJIQWd5N2h0UXorcFdBS29hNmx1aGFuYzRXa2ZrdGsxSmpi?=
 =?utf-8?B?aStYQ2FleXB6OXRoaGNsVkZGS2F6QndPZnNVclo5cXRQZXoyWHZaUFF3a0tN?=
 =?utf-8?B?cnZnTG1qbFMxclA5QnVlQ1dLMDA2Q3JNN1JGc0pyY09xZlphaThid3RrTFNo?=
 =?utf-8?B?NUhKYzdXVFozVE56K0xUN1hnT1ZEQzliNzJKUjB6U1NRYlBoYlEreWJ0S2xL?=
 =?utf-8?B?VkN2UzVJdzNoeHJIMUNZMTBYTEdyYXM3YSsxcDlZQ2IwN3RjdlNITnZEU3hi?=
 =?utf-8?B?Yk0xNVJZZ1d2N3h1LzgwRTJrenE3L2VBNkNpMGJSNnAzcGhKZlk5NXpnZ2My?=
 =?utf-8?B?VUNqbHBLcjYxU0JIVWNNcDA3WTloeGRlTTZidkZ6SzM2dEpSTGJGRUg3WnJp?=
 =?utf-8?B?Mm9qSDhyVDBZTi9yaVozR0pJMFNjdExLNHhxTlozNk0rZ2JJUkd2ZWRQaURQ?=
 =?utf-8?B?a3JvclI2QkdvTXR0Vy9hWHoyMFVUV1NsZDNyTkZ1VHA0Z1VrNWtMVWduOW9q?=
 =?utf-8?B?bXFwN2tmWmNZcGd2dHNTWUV5S2NjMjEyUkpxK1VqdjhtK3M4cFRJRFRva0Zr?=
 =?utf-8?B?N2QrTU1lekZCMklBUSsxNU1RRUFiNzNlMmFLT1dMaDdaU2VIN1FOM20yS3Iw?=
 =?utf-8?B?OWZZOFQ1RUREd296UUo5YnV6SUg5dThvOXh4T0xhdjZVdXRvLzNvWDkyNG82?=
 =?utf-8?B?T1VNMCtzalZIN1hJS2FwOU42NFNZbmIwN2d2WU0yblBCK3N6UkZzVHY3Q0o4?=
 =?utf-8?B?ZlBqS0Z5SEhEN2dMT09CcUFrUk5OYjVpN1ZhOGh5RzhrTSt0VFF3ZzdpdzMr?=
 =?utf-8?B?NXVsWCt0OTBXQXcxTk45ZGYxTmpuT25FdFArMDRVMVNWMDIwVWl4eHhtcWl3?=
 =?utf-8?B?QXhSOTltdHB4Y3E0VG5TYlBvd01saGVvQndLV0piWlRZYmVuV1RnUzRJVEtj?=
 =?utf-8?B?R1NnYkQ2QmhhZHJpWXh2MHFuUm9sR2xzeWNRWCtpbE1UTjZ0elNBTG5OSVdP?=
 =?utf-8?B?Q2ZYVEhnR3QwUGJtL2ZQV0ZxT3BlVTl0Y2tudE5MeEJ6L3o0bVBMZHRnSnFT?=
 =?utf-8?B?OUs5cXI5TU5CMjRTbFdQOVErcW93bXc3Y0djZ1lmOXc3SVVjRXkyL2s3Zm5l?=
 =?utf-8?B?Rno3UVlJa2pxejN6WWg0UHJTN3FTa0t6eE93U1JkbTV2eHN2d3dMek9VT29p?=
 =?utf-8?B?TEpOVnUwN1VBR1dzT2p4R3hGSk5TcFRqcThXVGZ2YXlKMHVIT0Z2bWxOZ05X?=
 =?utf-8?B?a3FpY2U5SVhoRnRCUnUyQVo5eGVKa0liaUh4Tnl1WjRic0NpU1dLZlRTaE9p?=
 =?utf-8?B?NmNTZkw5WUxNT2paYTh4Nk1KZ2lpNDVKZDhQWVI1OGwyMVRkdHRkT3hTYWp0?=
 =?utf-8?B?eGFNRlowUHJQMEdFeGw1blpFM1FQYXFROWpRSjZOWnJoaUJmSDM4b2kxWUF0?=
 =?utf-8?B?ZHBGbWNjL1BDRWRQZEpWOVJhRDExbE1YTVMxRWVueE9zUEU2d1l6cXgrVWVO?=
 =?utf-8?B?NEVlQUJ3K2oxdXJ3ZmdlWEdFbk1oa24yM2tVeUphcS9Pcy9NM2xDSWI1RUdO?=
 =?utf-8?B?cTRKdkoxVW53U01iRWNzMTlSQ3BBSFdtOVdXMDJQcTEvdklHQ0ozRHhPTGcx?=
 =?utf-8?B?RzkzNlNnWmFsZGk2VTdlclRSenJsdXdYZnRXK0FYbkhlTm5xQVQ1VU9wV0wr?=
 =?utf-8?B?V2tYbTVXSWdzaTI0MEt4ang4NFFVL1l3cFppOW9PN3UvYjZHOUNYOWRLQzVq?=
 =?utf-8?B?dHZKcW1JR0ZzaDhiQnByZ0E0NWZhQzRHMEtjT1FPMnVuTTlCNXptQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70119e87-0799-4774-b53e-08dea66831c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 03:25:57.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ahO6xdaLrQEj/IDFikBzGPdfctReHvAhEoRAKx2i5leNLWco+rcs2/bzvogJJUKkB4+qoSYbNp+xwCBAWYJTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328



On 21/4/26 09:50, Jason Gunthorpe wrote:
> On Wed, Apr 15, 2026 at 04:32:14PM +1000, Alexey Kardashevskiy wrote:
>>>> So the DMA API should see the DMA_ATTR_CC_DECRYPTED and setup the
>>>> correct dma_dddr_t either by choosing the shared alias for the TDISP
>>>> device's vTOM, or setting the C bit in a vIOMMU S1.
>>>
>>> Something like that?
>>>
>>> https://github.com/AMDESE/linux-kvm/commit/266a41a1ea746557eb63debce886ce2c98820667
>>>
>>> With some little hacks I can make this tree do TDISP DMA to private or shared (swiotlb) memory by steering via this vTOM thing. Thanks,
>>
>> Ping? Thanks,
> 
> That seems approx right, it is broadl similar to what ARM is
> doing.. But the address map changes when switching to T=1 for AMD?

Well, at the moment, in my WIP tree, I map the guest memory in the host IOMMU twice -

1) from 0 offset (and this is shared when T=0 and private when T=1) and
2) from vTOM offset (say, 1TB) - and this half of the mapping is always shared.

Thanks,


-- 
Alexey

