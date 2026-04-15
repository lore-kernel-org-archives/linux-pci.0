Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD32372ECE;
	Wed, 15 Apr 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776234766; cv=fail; b=M3KU+ynNfg++gztr3zXFwvS6TkpCAlA3wUVipTmhLCN5Lub35Bn/h+uTk9cNoJYm5mWvuGLghRKE7FWy3MY8CkyqMMRvZmwNVhD0VdLKHi2Y4su0yLT9uh65b75y8NA8+G5li/XBtuo/dZxaPoZFCvZOdFa8J1fzYyNGVKe6R3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776234766; c=relaxed/simple;
	bh=URXsEWWnNqdVX+pV6JNU+SEVlHOGYtJmNUJ2/atkYN4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qvc6w2yt00iVP8JKtTLRxUQHBV/2a4u/IS8JMg/19mRw3TiYkj/gJ/jgix/c3kI2P40PNky+BzeyXWHP8VibeCuVGDxx6IM02/EeJnB7k+5qddnElGThQWO5lppx8x2HAJX7KiKA8NNgTYV9WjzL+BOuZNLcVMqlf0XhPnd+WIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dG5YyrFp; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dG5YyrFp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSJLBsNtrgwzrC9eNOYQ37fos0vl3g+cuOhPS1YZhaYcaeSMnvVaVHrb7iyXXQbWdZedCjHwxes2zS41aYCqT4cHOncPva1e8yPvIk6CbRnh5K/Hn472T/ubogPhK4keTvkFrFgXn9uBSVpIKnjnQcHyxHNIakxIN2RrY0LALvHAtcwhnkMF9DHouSp1pwoq6v7e9lsYdWMGALNmfWOlGfrznvf8/AAkE3W/yDgSQUy8UNwyNCA/GGkY3WEY2wskaz0ADJjo58Au6fGc8uhxxEnqSGPydMD7lUcZYpStj99UkIN54vjEEjP+0zgY1mZLvIQn/us2a/G0q1JG/Ivo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ETF5DHBD5LFGv45zswAeRt5ox9CSIMaHnuIVyHlOOg=;
 b=OixRetPAa8bKjgDDGo3zMNK5EKw0rqFUGTuyzccJ2riJ1VXii6IXK66PZzRIescMeqgRodzQy50TRMTT3z1UPanGsP1CYvSXvS0yxoAJ/qwGNjNtzntNHxkaxO3n0h0KhF+UCQvFVwEtU8iIu2UJWoslRvBYc//v1bgFldUzVIGjOS/VdHd/DVCsjgJYmaNyN4DYb6Kpt5X7siMjgOzgYS+Xd7i21s03rLbXhrPcGjZVVvyRtJXWSv/CPYlmv35tWqW5ATGcvPk+Zp3mxFIXdZkv9C9i7o/WJjBCM+5OkUcPJ/Jgwf4gskRlcSWxY0XE4An4vcuNyIyQSSJf9zUgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ETF5DHBD5LFGv45zswAeRt5ox9CSIMaHnuIVyHlOOg=;
 b=dG5YyrFpA1OcuWGynSin1swAi2wU+R3DHGQKfxGRIWuIDlDxR5b5gvNRRR0/PW2wP+9DaKJrvirfhqPNfbuNDbzb0WiLH30yqn8MgcuxVO22WTWjHq85XrDeuoVQS9L2pLf8JBu70yyldvLf9/ApBuwvQafiZ11Bi8mcku0JfIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.35; Wed, 15 Apr 2026 06:32:39 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 06:32:39 +0000
Message-ID: <137e5595-390e-49a7-8918-9ca057f7ebdd@amd.com>
Date: Wed, 15 Apr 2026 16:32:14 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
From: Alexey Kardashevskiy <aik@amd.com>
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
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-5-aik@amd.com>
 <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
 <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
 <20260228002808.GO44359@ziepe.ca>
 <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>
 <20260303001911.GA964116@ziepe.ca> <20260303124306.GA1002356@nvidia.com>
 <5d669086-a5c8-4e55-8108-a9fff41cf094@amd.com>
 <20260304124316.GL972761@nvidia.com>
 <074633eb-103a-4452-9aec-6cd61e82f0cb@amd.com>
Content-Language: en-US
In-Reply-To: <074633eb-103a-4452-9aec-6cd61e82f0cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0d18d7-2b85-4aee-3b72-08de9ab8ca02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a5QpK8V+G+o4B5VgSAIu+YByeTX48uvj6NTfXBgVyh/VYYwqszSPUOUVRindkqa+Pr1wqT9scQo4Z3T20rueNPqooaTYq3M2uF6sz56J0sZT2q8hsVFArfeYkMOE53Yd+UZ+hyFbwO9vkjubvzOumd9nFQOxNTyzYPuzBkUy+H4HEsrjbsH2CPYOXrTeQTDsu/o3ztmWeL05hckQoY8x1z8sky9IHphFQPxUNXBUlVfdWVZKEdcqy/nRANOh18ZQ9klhMh44KGMWQW1bkcRYZJnw02LoNm2vZAeYnIU41dF5XqA9rxmLi9+sRBeaARBWCbTyiEGMZczfAaAT0ep+UyJs+5p1QKqK75kHa2+1Ya8g3FnjuU4cMF5nRmwDWsJ9wX3r68vZ3SuxXpMu9kGMkXKVf7vcbMtJ9J2ZuPALY4U+LVKs3XvTovhcFrMu7+QpPosupIFmwFarhGuBKDJnRTOeyPB4O+lFXqDUu1GoZhcHsQkqazKPVQpRJ4sHBXCqFRbDhSAbSzrs2CRxgoPMtlszOQEXV7MJ5vSQFMSrdEEOYxMpmHZx/aAFpXjf9hKv7yUZ6GAwTMB+zweSshQJU9TeyzG182FHDIm4TEYgmoNYGzhBJP4gqfkhyKNPIAzzyeBeN1+e5s5Ic3LrgGoyDJc/3rOdg9501IsoMyppTEkuqwtHfI1XPKplx5qth9aW6CLbk3bah8xNsDpK2LxLvLnoslNgR60xY4OFJYA+uXsn3/VyIv4d2IrXI7RVfBNX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVdmMXR6UEYyY3A4MEtXdEtHVG45K04zL1NvcTZIZTFVcmllclRYWjhNZFJ6?=
 =?utf-8?B?RzQ1Njd5OEVtYi8vcTNuZ3BnVDdHYXd3S29FaU0rV0hMc2h3MUsybGtUbFZu?=
 =?utf-8?B?VUFJdUg1NmRnUlYxTjNnRmxUUWFDOVF1dCtLWEtjR2FuY2JDOVpDZHJOMjJ1?=
 =?utf-8?B?RExwZmNKK3JxTnlLQ0VBTkV1S3VEOGk5WTdjMGtVcnBNSlN6Ry9rVVVpTkZ5?=
 =?utf-8?B?cnJFbWZqcktWVVJNaVpQczZqWTVMTSsxUHV3QTZ5YWxRakZpTk1za0oxM05z?=
 =?utf-8?B?NkUyNHBIQm8yV2puTXUxcGVlcUx1Q1c5cFpPTzM5RnpvdXZFYko5Z0pTdXZj?=
 =?utf-8?B?N3FIZE9Rd1kwNkpPTng5LzF0cnVBTE1MZHdJVDd1UnRvRlIzZ1l5NDlTQ2V2?=
 =?utf-8?B?YUV0QzVhc1pOWWVlZS9RY1EyL3ArMFhhK0ZEYURuOEk0QnZnWHR4K0JKSitW?=
 =?utf-8?B?UGt0UE5WNVRtbkU5bUY1TERGNk5jVnFLWC95SWdrcS9uREFCUDRvSVorZXpr?=
 =?utf-8?B?MTZhUDRaSGxSckZpOG5vNDFxN2J0V2Y3MmdDcW15Znd6R0NMbkFPYWcwRDJw?=
 =?utf-8?B?OGJDZ1ZiNEhja3YxclhheHBOY1pxSG10Tkl6cWxVaGZxMXRIY3Q1b3h3dXVr?=
 =?utf-8?B?OVpoN0ZNOTd0OEx5RVQ2THErRTR1K1kxUnYyR0lHUFlDczl6Um1Kcm1lNklR?=
 =?utf-8?B?MFE4c1VTVjV3MlhUQUYvVXNCSDJkd3cxS05QaU1mMUtOVlJ5OTc5b1ZMZ2Vi?=
 =?utf-8?B?eGM0aWUzR2Y2aHNTYVJtcnFFVld0cFZYTG5GclpYZUtjYmNjNTRkdGVIcjlK?=
 =?utf-8?B?VytjYUY2RTljcStya0tjNzlvV003cEFDS08wNUExZjV0QzEyMGhjb3IwdTY5?=
 =?utf-8?B?cjhRcXR1YllabVk5UzlBSkMzelkwcy92a2xrVjlxZFo0QUphbzdWWXNVZUxj?=
 =?utf-8?B?Qjd1Qms0L05MU21laXlwcTVxUTFTOUp2SE1iYTI3VTE1aTRCSWxDcnE2MzJ0?=
 =?utf-8?B?T0hFdG9TaFZ4emcyZmc3ejNGZHNHNjFYS2s5aDM1aTZqQUxjN0ppNVVPYlht?=
 =?utf-8?B?KzEzeHlScXFjaXdlWnRoV0RPbEE1MTgzc1J4WlBNZ25rZ3UyNFFEZWZTaGFq?=
 =?utf-8?B?bVFCdEJzTVFTajA1Zi9ldEZEZ0tVQVVBNzJGS2NxdXdvTEJleC9JNzFWNjk1?=
 =?utf-8?B?NkZTOW1CR29sUkM3SDNYS29RWHdSUzBFWEQ1UW5OQjNONmlSdVhxMU1qMUo1?=
 =?utf-8?B?WEEyVUZlNWNOb1ZOTE0ybzduWWtLQThENFBWTHVseUF1a0VmaCtLazJjZ2o4?=
 =?utf-8?B?b0JYTXVsMHBkc2tPbGVWbjk0V3BPSENiQTRMYTB3VFA4VHpNM1BDU2pLYUt3?=
 =?utf-8?B?NE9EMko5eDVmbEo2TVFpQVhXYS92TVJLMXU0ZGdxclBaSy9NeXR4cEhMZDh5?=
 =?utf-8?B?Sjh6ZlJQdWo1WTl5N1FEd2dtd0Q2Yzg0N214M3JXSThnaUxPdU93a1ZOaDhm?=
 =?utf-8?B?Tmgwc1NscXR6TTduL21nbGQ5c29JelNPckx0RFpLSkFsYUM0bXVhY0lyZ0ww?=
 =?utf-8?B?K09RbU5NWDNNSGVXaDFyWUtzU0dKNmgvb2U1bDMzcDMrdnBJMUcyTDBTNDh4?=
 =?utf-8?B?TG9nb0MyYThZbXBKYjd2VG5JdFFGSGhyYWlZOC9OdDRKelVjZDh4ZnpnWHJN?=
 =?utf-8?B?QW93ZUhOenEySXFNdlBxVVhGTU5pam5JaWVHeU9hNUtzVlp3dC9vbW5nTkZh?=
 =?utf-8?B?amphVzR4Mk5WZXdPTjByVy8wblZaZmFQUHRVbDJqbVNGM05WaVBMQ0xjQkpX?=
 =?utf-8?B?ZVRZQ3VsRHVpZXp6N1k3NWE0UVhhNk9RWUlCSnRwakFlM1hpSGx0NkJkWmtQ?=
 =?utf-8?B?WVBqWWRyQ0NNaHNycDR3ejFObWVIU2xrSGZVUkNhaGI5M2dLYlh0cE03ejRE?=
 =?utf-8?B?emVqcHF5NGtGUkRmWWxvY1JtS1B3b1hicU1seU5NZEFIblEvVUs2Ym5yUlA5?=
 =?utf-8?B?dHVJUS94cnRsUGdoRFFwbEpFbGNRSmJpeHM3QVBSZHYxL3RSb0RiMVhNREda?=
 =?utf-8?B?MU1PZGhkYURTcDdXTzQrcjdIWVNveDAxWG5jd3lNM2dpVGZjWm51WmcySTcx?=
 =?utf-8?B?bEs3TW5YQkxnN2RaMnBzMlNOUVg5akFrU0h0YWx6ckVRbVRPZzk1WHRYaE1D?=
 =?utf-8?B?bXRCeU1FYnk5QmxMTWVrb3JjWG52eThPMVExM1lMSW5BcVBNTUNCWHFKbXFo?=
 =?utf-8?B?QW85VDNwVm5lc2ZaTVR3RHVuZWhueHZYNnE3SlFHY05mSDJKWkE1aXhsTEtY?=
 =?utf-8?B?RHZVVDZnTWt1S015d3FnSFhkaTc2STYxeXlkb1ozMXBTbzhZeG5Sdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0d18d7-2b85-4aee-3b72-08de9ab8ca02
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:32:39.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5OC5yMGARZhPPqDedDPBi3Tet16Et0uJHjojwXA+9DCH3ZszqVyRPXCnGevCH8OtIx8yEpUEhnyfe408zg8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062



On 3/4/26 23:40, Alexey Kardashevskiy wrote:
> 
> 
> On 4/3/26 23:43, Jason Gunthorpe wrote:
>> On Wed, Mar 04, 2026 at 05:45:31PM +1100, Alexey Kardashevskiy wrote:
>>
>>>> I suspect AMD needs to use their vTOM feature to allow shared memory
>>>> to remain available to TDISP RUN with a high/low address split.
>>>
>>> I could probably do something about it bit I wonder what is the real
>>> live use case which requires leaking SME mask, have a live example
>>> which I could try recreating?
>>
>> We need shared memory allocated through a DMABUF heap:
>>
>> https://lore.kernel.org/all/20260223095136.225277-1-jiri@resnulli.us/
>>
>> To work with all PCI devices in the system, TDISP or not.
>>
>> Without this the ability for a TDISP device to ingest (encrypted) data
>> requires all kinds of memcpy..
>>
>> So the DMA API should see the DMA_ATTR_CC_DECRYPTED and setup the
>> correct dma_dddr_t either by choosing the shared alias for the TDISP
>> device's vTOM, or setting the C bit in a vIOMMU S1.
> 
> Something like that?
> 
> https://github.com/AMDESE/linux-kvm/commit/266a41a1ea746557eb63debce886ce2c98820667
> 
> With some little hacks I can make this tree do TDISP DMA to private or shared (swiotlb) memory by steering via this vTOM thing. Thanks,


Ping? Thanks,


> 
> 
> 
>>
>> Jason
> 

-- 
Alexey

