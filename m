Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84873BD64B;
	Wed, 25 Mar 2026 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435383; cv=fail; b=psYsXlSMV4g4/wYB2b3JgIxJ9VktbNgxLPViz/voUT01EbiJM0+fC4cUCMoDXrjjuKRnHdmbp6DvKUGAvlmRiVw8mOpX4ne1vArphzQklV1E28483kwQb29NwrcyeZYwXLI1kEfkydclHwS6sLs2UGuN9T+6W/UibbeBTxsqkw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435383; c=relaxed/simple;
	bh=JMHNKwgCG5LVOTUpjNBjbV1/J9hG0q0FpDEi5vwW73w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5Ko8aOpRO12/TI/6BNFq1m3WFb5I7OFNlvMFO/rX75oALPBMA7jEMHnF6KRRM6YdUetn6Vm09mdgwoVmbkj0lxalT6iAj/E3eep5qXedo/rBAZJPtUWv/wPi7Oo4HPsVm1nBRgmQRe4a4OgDB0VzP68SUnxRdbvUQGCKdTTDZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sA+wU58W; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sA+wU58W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTmbOrqoQkAR8b+Z6PPoii325VOzp1oJPFPVygSbac+KYVCgJMjrxudPZXdNk+9p0cfRfZD+hfiC4CjO90Xu08gtRB7cxWDD4eQX+5k7ZB0ODP318NX1QzKii9MFqI6Icnvu2GKfA0jyKDMIEejMlT7rGGHNhF5ofmQWo4mUryOVfbcIpH/Urnx3qEYZ+sp7l8iUKc99EtcMctmfFt3NwDrDUXf6UQA3Q1ZY8fSPfrDuTNxsHJkk8hrzcqNMRk+Wcsw27b1439JUefnj3n8pQ5UOikx0Zg1EnTyOayPW94Vtxz/mMQvTzsju29GNNWEFHbcqVzkUs1QkBmmI38A6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwzA/miEkBUAyY46anZnQYXrGPUyMbsJ0CBSA79scy8=;
 b=czCSMS7Gta+AZhDAudDtyGg7Y+k3dCrv7qoyKAtS9QDFM7kNQ0ew9HEuoL0X2WNppDQRNjV8fi/p2ia+rYSQLRLZKB9Zq8pPJfJzHnQf9r9sbEg240zrBiw41MLG//h/6gWwedbwbYEq0J/fSBWNenCHk4SH2M4BYc3zdDMc8cyAe3BK4v5oiKIDDYogkskGk/594IYQIslISqYcYEoHwJ3DvwbQE1exSLC90MRC+JkLCkdUF8HEdnU+0rqVCUbxZVhAU20eZyV3VNW3xljfUMlShDMxbHhTLwONYCSLz/bCR44l41JrxHDPjleP01TouXDDE0fOe+O3d6nMAmI/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwzA/miEkBUAyY46anZnQYXrGPUyMbsJ0CBSA79scy8=;
 b=sA+wU58Wks9vU/rGhCTG/oN5E1sNYCBR1dtO+pampwOkvOsaXYamNeBi+pce5KUHN7JrrH4zPWLwarlICQ9G8ZuSzXUhhSls+4L6m9Hq/sCmFRtggzyDfXoMdEbxcmTt7ZFMs1tq3wj7xsdIOTzdRQ+9Q/T8Bo5HK4r7bNgi87w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:42:53 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 10:42:53 +0000
Message-ID: <37dcacd9-4e45-45ac-8a0e-c55e4aabb51f@amd.com>
Date: Wed, 25 Mar 2026 21:42:32 +1100
User-Agent: Mozilla Thunderbird
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
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260304124316.GL972761@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0128.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 9665acb9-6d6e-43ce-31ed-08de8a5b44a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M9Yjx21N3iQ7UkW7URIjwrgT3etNxSRS6Cr0WTsr9f06nUTQzHQydPRYWmzxUAq+9k20BLXScEWvLgt00M2Mbd8h6gy07ITIFTYY1Z8Xkzx/35vdWl/qHc3DFi/aj6EhwyCIShQcpNy7vH6kxi5+TkTIXqfRCzByMyDFNtdmNr+o3BpG2HAV82Spr8rmXoQcJLuEuapgZBwjglgK+dVRdEvB4Psjw0I95+IqnwyETYpM409DKzhlPfIfqVHvkmHtHxgPcw58H851JMjvz7hlAFgs0+9mtlnhZemW0NdJQ/eXx55Alg0rnKQoULygNZecAGmtfvzEcKFoP8zgkik5uO2xBdq3D0DZy5o11nj6bF3Oa9aaUQUOEmJSvs3aVloxqM9DZ4DYjLITR3/ZFLmUDs7gZv/jN8GgoGhldOFPKBW0h3xGmPsSlP4pXGaNNKnZD6PfmLj0YZDaHdo9H846ef366qBQLP1+hapiFjFgThX+4xYgXh9Ri8SPba/WM2U6tqohi60gHyyJX/0UuUFVNWPEWfkvjTqV8IHH+3dNyBIv+rHJ9P4Vr96mWzZUxPciUoS/R4RVJOT3/34peMuhoJE5/kBb8fTELrptRT5K0iBovtOhKYMdCGoQotpfwp57EcsRQDmsGfo8PICNnLe9VgXlSsvlkvsxH+yqcFrMMWS4y/MRiQr1enH8t8XY8TpfPydg/NEL4BSPuRWpcrbrFwQFnxX/faPloWEyoHUirRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFOaTFYMzMwWkh4K3pIZmZoeUMrMVlMZHhySlBZM1o3NmdxQVNnSWF4TmJW?=
 =?utf-8?B?SzJFVVBKS3I0aTY3UFlobXFGUjBsSS84QWlFWUE2UGdMYVlvOS9FVFNDYkJy?=
 =?utf-8?B?RElVbldieENwSU1YZGw5UEVVRTg0Wmd4ekRwdklFTmhKalg2Ly9WUkFlcnhx?=
 =?utf-8?B?b0VXdkI1VTZERXpQU0M1c3JPNitacStIUWJhbkltdERudmRpcWtxU2MwS2hr?=
 =?utf-8?B?c2hhRER2eFZ4UDg2bXdaSVkwVzFKelZtSlAreWVTZTZPbUdQN2VUNlg3K0Jt?=
 =?utf-8?B?eVBXRFF6WkVwZG9GVGNPb2k0K1oyM2RpQjNzY2dDQnBqeWV3U2wyTHoxb1c0?=
 =?utf-8?B?L2lvb2E2RUQ3Wm5INkwyMmF6bUpxbHlXb0R3akJTcURUTjFoQWhnTmgxakVx?=
 =?utf-8?B?ZEJETzVCd3JoZitGMnNONjgzQzBiODViVzNjZlBsVEJueE1mVThyLzdqU3JH?=
 =?utf-8?B?VHQzbmtBRjd3bEJlMmlnNE5qOHdyb3p3dFJVM2xoQ3U3TGZPN1dJQTVLQUVl?=
 =?utf-8?B?cER5c1VGVVBkZDdSSUFqUHN5eVRWNmtRTk9paXRXMWVGQVRxZm9YNDVrUE9V?=
 =?utf-8?B?bWI0T2JCb2t2a1dFYWY5ODZwRGF0c2cvMEw1bHNNMzk2c1hObVBibmpINGU4?=
 =?utf-8?B?OWgvSEhQK2crcUZtSjR6b0lHejl1VmJ5cnp1YTB4cWp2amtzUnY2ekRTUTZp?=
 =?utf-8?B?cWJZNlIxUkNTN0drZXZJdGx5Rjc0ZTY2L0s4MGQyWGFqME0rL1ZrdzNYT1BQ?=
 =?utf-8?B?bW9RejY4NTlGWkJoNEczcCtBTFZJMGxISXZ4TU5yby9ZN3JlN2xFL2lvYkti?=
 =?utf-8?B?YjJBL1h3c09lcnNMa2pYTmF3TnZIaGNINDJoeVZUdk45SzFnYnJFUzZrVVF6?=
 =?utf-8?B?U05icWxQK0ZJZWd5MWp5THdwN3BUdGtXTmZPWlR2bzk3SVYyL2xrWXJ6UVNo?=
 =?utf-8?B?RE1veUJoNHc5dDRhaDRvZXdWV3Zoa1hxaVZuMyswWlVpWDJ3SDFsQU8yVHlp?=
 =?utf-8?B?WHRsOGtRbG1OVTNxcFRxT2U5dXFRVGg5WlQrd1dBajgvc3dkSEhuRjVoWENJ?=
 =?utf-8?B?ejdRdzcwVnV3bFo0MG15QzB4eHdkc0RkRW9lZUNMMk94bkhEcVRZUkpncC9N?=
 =?utf-8?B?dE1lL1huUnYvOUZvWWUrYzZSTWwzc29EcHVtN2RxTytSWmJWaDRHWUc2QkpE?=
 =?utf-8?B?Qi9PK0R0aExkVGdFdlhUWWJFMjBDUGFTTWpuUDJmSktyWHhPbG90NTRZaVZk?=
 =?utf-8?B?Nk5VUkxSdmRRVnovaFBsVkluejJ5Zzhqa25nOUsra1JJTXBpRFlETzh1WjUw?=
 =?utf-8?B?cHhIc3lvbnJnUjgrWGdRUVhTbXZpOTFHenhHUkMzL3h2cEJTdUVocFBqY25L?=
 =?utf-8?B?SDVQSUhpNVgzUFkydDA3TEsvSjZnL24wK2lDL3BTQUtnSVpBZDNsbS9zL0xz?=
 =?utf-8?B?NEhROWdhR2RBWEtMM0o0R0FPd3Z0ZkgydWhaUWNPYlBQd3l5Z3piYUM0MmJQ?=
 =?utf-8?B?Zzh0aVlXOEVCRmlhVTZzeW9vekl4aGxlTTJ4UmxjNUlVa2tKclAwZzdrTjhN?=
 =?utf-8?B?TzQ0RjJ2U0VGQU9ZTlBSczZmYlRDczd2dEliQ0JaRlVwQTdEeXh3NnpKdm1H?=
 =?utf-8?B?RkF3bEZ3R0hDdk5RZXRWVFBWNFJadUljU0lDM1FMam1uaXpSeDhZd3IrS0xK?=
 =?utf-8?B?MjFBaGxGc215MVBFTWtXSHcyNFIrS2tUS2l6UkJSTUIzV21RTUhQTWtzQWIx?=
 =?utf-8?B?S3M1ZDhMenViK3FqWlNzV2JLRDZRN2dHdGtqdFJlVDRhU3dRUFdhODU0cFR6?=
 =?utf-8?B?R1pZUUdQbnhUZllXVDFzTERyNjFCNVdneTcwcTVTazdiWmRWYXpYeEdlcXhV?=
 =?utf-8?B?b3lucFhONVBZaVRTd25mUjFUVGsvV3JQT1lnUGtDY2VTNjhwUDdOWk1sU0xH?=
 =?utf-8?B?WTdPL3d0R1Y3aERuZDJUd1FwNHV5WDBNRzhnQmpkQThoQTNaamRYVkZCZUlH?=
 =?utf-8?B?SGRTdG1idW1JNGtORU5IOUsrVDV0dVQ5TE1EYUhCR0NZU3RGRkNQVWkzVW1i?=
 =?utf-8?B?MnBYdWVvSHI0TnQ3Qzd6T0xJK2FqWS83a0Zwc3JlOXhXT2c5OUxaa1BmQm0y?=
 =?utf-8?B?OEU4aERHSE1oMjQrY1FXK3duNmdHbEdBdDM5UDBhRUd2cFdWVnEwMkdSNE55?=
 =?utf-8?B?QVdySU5VU0RSN3pBNnYyQ05PdGJMUU90TXAxVXArOWxnNUVLZ3pSN0xadDJG?=
 =?utf-8?B?M1QzbUFwOUVIQW1sZnJ1MzNVWkNWWFUvaDJoaHZLbStseG5TSGl0MUZHbnJW?=
 =?utf-8?B?ckdkMzVkYzZwRVY5eWxKcjQ3MjBqTVo4VzRkNHZRTnd4aUtka0dDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9665acb9-6d6e-43ce-31ed-08de8a5b44a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:42:53.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FITFGEl0viE+cF6l/oUKjUqCIadd9uGmLYRbN81pSiBNbWYTgfunZ143ZgFqqC5+nltDyqkvEFI5iKdEAFklKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439



On 04/03/2026 23:43, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 05:45:31PM +1100, Alexey Kardashevskiy wrote:
> 
>>> I suspect AMD needs to use their vTOM feature to allow shared memory
>>> to remain available to TDISP RUN with a high/low address split.
>>
>> I could probably do something about it bit I wonder what is the real
>> live use case which requires leaking SME mask, have a live example
>> which I could try recreating?
> 
> We need shared memory allocated through a DMABUF heap:
> 
> https://lore.kernel.org/all/20260223095136.225277-1-jiri@resnulli.us/
> 
> To work with all PCI devices in the system, TDISP or not.
> 
> Without this the ability for a TDISP device to ingest (encrypted) data
> requires all kinds of memcpy..
> 
> So the DMA API should see the DMA_ATTR_CC_DECRYPTED and setup the
> correct dma_dddr_t either by choosing the shared alias for the TDISP
> device's vTOM, or setting the C bit in a vIOMMU S1.


I can make this work by using some high enough bit as "Sbit" in vTOM to mark shared pages but I'll have to decouple dma_addr_encrypted/dma_addr_canonical (not many uses but still scary) from sme_me_mask and I wonder if anyone has recently attempted this so I won't have to reinvent?

(a reminder: below vTOM address == private, above vTOM == shared)

Thanks,


-- 
Alexey

