Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041363624CB;
	Fri,  3 Apr 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220089; cv=fail; b=cOEqoqXVUL0XBNZTpIDRzgS3ww0ZaprqIS3O7onfAT7DSaK+WayPebb6m8OXuDXHs5dMqadGXAN9B4G6EfX5noBKdiyfFnTmbz/p6xOw4dVbL6aJ2Og00fiQC58jrACBf1btOlUFwBngTNT/vTmvl8JKHzKzr5SpxyC25VHJHW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220089; c=relaxed/simple;
	bh=OwSuL2Mw4OASpBGNMeMx74jIryZPb1lTJP8uNWZlMuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NvmJK4tsnJB/walIrvfKnyfT18ujfvrCmhv++MidMeRtlO1jsmzUW+/wKsXSrXF33xTj9Sx5WbpbPGzKq5vK3Q8qUVc+DC/MjYaGntgKjFy8NpSZCXYtA4/V99S0i71jhngOa/RZ4nky15+Zb1K3gsxAKabdq85MfxxFS+lDaYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kALetQyU; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kALetQyU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDkNv4rCjLYfiw8EIN0kjC2/Q2yvpicQ0PQ7zHjRKl2uy+eFM/JZz9kQioUReOcikc6ChSSp/vo/a6REEmXD9ECUae0YT0DPrXJ1j4FDDYMdhcyosohEEG4Z69s8pK4GSqlsn1L5dV5Thf3gfPSjHdYTTOsqUV48TrkxVg7PvldpCksH1Yw/ZqSQZFOz6zt2fx0vwpZfCtxVU6kOvDhnex/b1fkfRz1Seennnr9A+YFSWtmV0Y+PFxQ0ULZZ3tQhLuJWEIFaZJnwiBaoJS1URfN5u64mfUrjKk1iaRihd01htvadx94ANBl9l4vwQP7HMCdrgVBfPNcIb+7xLyUv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kts5Pmj9D8kJHwQAvagqZE0PLkEokojA9BNrv31oxpI=;
 b=t/6hwaB7MQhciZsYL1lHcRTTkf1wEY3YBoyCjr19kDKw5ctY62yQM3d6d4NHQGpj+uEDag//AJ5f/9x4Sf23irQ7CGBOBLccKVVije50B+A0lm3hbJOb8vIpZsz1I1Zyd/yzZfpyPgMF0Uex8nu7ds1q7X53QK7Dv9gr0IbDWRhjAfX2v5FHRg/0Mtv0G9vsX8MZttnfyEmz2NXuzJmVl1dVnZ0AIhBVq9aRPFlegiGJaD+RwCW5hJD+gfPgz8Lq4RE1U3x2r6za1e2IBBey9yJntUkjidYwiMSO1bN82biPXYKEHm7JpcD+VQ/cW/HViOgjEI3FjIguVg5B7QBQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kts5Pmj9D8kJHwQAvagqZE0PLkEokojA9BNrv31oxpI=;
 b=kALetQyULFCASFZ+OxhtZblGJjW+aZbPrnxMWpyQGtT3Pion0Rv80Y0xgbks0FLOp2fNUNF0v8PYUX93gAqygynOe1XBJSiTfh5jys2eCZCwgm8AAgUu9fBxiIeQQnC6/Y3gRQ4G9M/DRfom7fSOTx0ABiNH2I3xEmCiePe/aMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 12:41:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 12:41:17 +0000
Message-ID: <074633eb-103a-4452-9aec-6cd61e82f0cb@amd.com>
Date: Fri, 3 Apr 2026 23:40:52 +1100
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
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260304124316.GL972761@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0121.ausprd01.prod.outlook.com
 (2603:10c6:10:5::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eaf4da-a1d9-4c8e-78f6-08de917e4c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BHib03mp20R9R1O4pXzb8KnCRzbaeHJJmyVQuop4OflKhwyf3Jnx2fIvssLPdyAIWA4J6GZBG5qDCWVCz7T1TK5+rrT75I9a1b3CUuS1FE3KMW/F2USdBXOh4OrGhYX0MNFO3/83EuM7M0otBmeBU8ReR/6sRoRfrS+zfI4qMU8N0kv7qxf/ROHpvgY9Ahp9+AxXcigl6TJfet7LbDSFTpEZAdjGU4Y/YV7/Y5FdTthlclBT2Ie7pcn7YidWlbfs1LFKa/Re0URJwzzMVDz5C5X/1OvXoLEocS6UbOGcz5zUUeHeffKdlIt/EwBJPwn8VSaiosRJdibs5cJ/nbbA4ZHTIOCuCDloLgVi+mfYKGoxDelsLRQizDPhQNu99M5PYHevrZKHON7K764QMp18Xtl3sJost0CfzqUrDNhcp/Mpz9hIaQxGDMUJ6+2oxJ1EDRCJiHpq0/VKFOhLHBf8qOpYOJdvUBI19/8uBlAtAlX7pW+Oq85FdRGw5N7qZdpPY3ZX32ZRVtCe2t7iB9V6yKODi21LgNUogMDJXkTNI0cqEU/AhNH6abCZXTkO5ELWG/hXKpbCYsC4lM76tIDCikx6uzD3CyWklGqTRZ24R0s1NKQ2Rdr/72Tf9PPVzz64pTkaczkFgpj8WCkEAYVSD2V6AgWd3PiL3NZE5QmUO3RNpWalo4ojWGLqPKXmGTx0qO54Q618XSofo1fBTJWyKl6phuDLAHAwiEWUqjZmhpW+rRlLHLSxaqeob8gfAyMK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFRwQWJac2ZWUUJHTnR6T09RaVgwZFJzR2ZZdThwTi9WSjlMajRxSm1nT3pG?=
 =?utf-8?B?enNCVDBSVlB4cXBrK3hselZ0K3RySUpwTjRGbEVqMUtFbEtWUFRjT3JyNmRU?=
 =?utf-8?B?d2p5QnEwL0VKTkdmVlI2bWtraFNpWkhqZEI2dGVsUzNHRk45UUZDbmhzNVJW?=
 =?utf-8?B?MnlhQ0VlQlJhUG41RXRERjc4WVNEZmNYYWEwbmt6SlViUGVzNW5kVUNJRnNu?=
 =?utf-8?B?ckxhNXNXNEFMU3pSaU5paTVTbnl6U2ZqMGkxeko3UmFGckpuMTNhWFVUbi9s?=
 =?utf-8?B?S3dyczlacVdjek8zVktRcXYzTHE2ejRkQjl0MzkrQWdwY2VUWFBkbXJRR1ht?=
 =?utf-8?B?VkIzMWltUnpZcnVmbHY4V2hwZDVDVGo3TUsvNXJBeC9XakpZK0FId242TVN0?=
 =?utf-8?B?WlVNREQvYWRoa3Z5S0ZFZ2twN2oxVUdFc043Q0RTZXh0YWFUYTVNSnFYN1RI?=
 =?utf-8?B?dWNTUTkxa0JXMDhUK0NCbkVmNVFJN2pnM3dodHZMbHBwUkhjb3dVbGpmVXBa?=
 =?utf-8?B?Y2g4T3I3Z1JJNVNmTDJ2SmY2SFpXamluelN1SnpoSHM2c2VxMThDQ3ZEKzdy?=
 =?utf-8?B?eC9tV0FIam50djZxUmhTQTh2NlFQS1VCYVlQZ0dSQVdhbGgra3MvS1pLWjZL?=
 =?utf-8?B?T1FsM2lOMEI5aG9uRmFUN2NKWEo4V1IxbUZjMHB6M09wb0JBWVlIeHJ0Ni9l?=
 =?utf-8?B?d0d6YmsxQmpwYXhVdHBYcDNLb2ZZOXFZWXd6czkxUVVtajhtMnhyUnREbHFs?=
 =?utf-8?B?SDNsaUdrN1M2U1JaTkE0NXdYUk9nWmladENGZ2ZIdWFMY2VTaEZiWFd3N21Z?=
 =?utf-8?B?RVRFaGZ6TEZpVEh4ZlFIZ2I5eFQ5bStwcTk4WFJyYStSWWltSWd0N3M0VjFj?=
 =?utf-8?B?THlKbmUvb2lwZDNkUGRrckNvZUltSEZRVEJLT3E0bm16TStrVWJhajJGUGF1?=
 =?utf-8?B?VEJ6ZVh6OW10NHQ2eXhISTEwM3BWVFhJaW9WOWFyc291QzY0Q3hDRTdCaWgv?=
 =?utf-8?B?a3R5dGhDZUhtU1hCRGxHMDBPMDZNRGlHY3FqLzZsRkhyOWVSbjd1Y0c4TWlR?=
 =?utf-8?B?YVRkNFVxNDFTSGswREdIK3diY05ISjZXSjhjRS81Y1pmcktaZWhRREkrS3ZW?=
 =?utf-8?B?Wld3WlkzdVg1aU9NaEFiYnAvak5IeHQrY25kYy81Z1ZkNUhTZXczeE5iblJj?=
 =?utf-8?B?c1VsZFo3WHFWS0dBTlBJYkhvNW5nd2JHYVU0NEt1RWRjdWxyOElxS05NYnFi?=
 =?utf-8?B?S3BzRHVxZXF2aUxtOS9VYnVGRGhOY1E2TWJEbnR5NGpUUkUyMEZFdEhwOVVZ?=
 =?utf-8?B?SU91OEFXL1ZqL2gwRFVGa0RxVnhPVVNUbTVtdW12T2JSL3AyZmZMdWgwVUZI?=
 =?utf-8?B?c3pvM09zZmQ2YlFPQ0FZUUJuMTl1SFpCTUF1M3JmaXVtSzRNeU9JaWY1ZXlS?=
 =?utf-8?B?RHgvOGxqSm54SWNSUGNtR1ZmbmZDQ3BGK21XOHhHdlZ6NTZ3RFJCNUx4eFBh?=
 =?utf-8?B?dHQrcFh2OSthZFVha28ySTc5NnROR2lMNXQ4dVdTcGZoOVNMWUo4SkhQaWE0?=
 =?utf-8?B?OXJDSTJLTXp4VjFoZnE5NUZpNXlmc3AydE5aMUdCYVEvTW5iQy9nUjBQek82?=
 =?utf-8?B?R0UzVmFQbS9SejRCbEhNWkhDTGxialhMTzMrTzkvQ2dBZjdyRThEeWJUdlhZ?=
 =?utf-8?B?MEl4alJFQ3hUeFhQaHJQTHRwYTBmcDYxb01LMkxRc3Nwa0s4UkdNeWp0MFcy?=
 =?utf-8?B?Nk4vcy9yR0p0cmk1K3pUaU9qcGJzaVZqR2plWitVNE0wdzMyTFB6WldndWZW?=
 =?utf-8?B?dlh4SDFhL05sdmZDSFNzQWVVekZpenFCeVBzSlNzeGJxUVI2akZnMDFHK3A1?=
 =?utf-8?B?WEdyQ1lxS3pwaFkzQ3kxOHh2WVFtQlM4akZ0Sy9TZm1neWxQVDNDVTk2dGg5?=
 =?utf-8?B?cHR0dFpSQ2V0NitlWnBCMW5sbDZINVlUb2FIa2N5a2pQd0tCd21IU0RWcUFx?=
 =?utf-8?B?ZHdPODB4TXNJb3AyenJVQldEMTNpOU95N1dTVzZ3Q1dYd0pqOWVHNUhwY2ZH?=
 =?utf-8?B?TlhFZUczczlxN1VHOHgxaDVCTUlBcW5uVnh6RmU5akZ4WkVMY05jVTVtbGZD?=
 =?utf-8?B?N2pzWDRiM1AwMlRpck44Y0RrMHMzVG5BbTdvL21ZZVNPUnpmVW5oYVh6RzBk?=
 =?utf-8?B?YURFbkRGclU2ei9VVFFXSzJkRkk4bEUzTDk3WnRnSzMyVXZXaDB5K1c0dUtp?=
 =?utf-8?B?MjZvNWlMb0RpOGtkODhuZ3hndzZvUXVUTnZ2bCtZQTlROW5sWFF0eDExU3Bp?=
 =?utf-8?Q?RL7Sh2/p2qau1rtmgg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eaf4da-a1d9-4c8e-78f6-08de917e4c5d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 12:41:16.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqsq1r3HLirSk7SU8IsPwTT3jGRDB+4sRYyuCuvhhiP/H9nAKUPo8aKoSBJoMmtWONpudIGIYP73LQ1S+6fI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281



On 4/3/26 23:43, Jason Gunthorpe wrote:
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

Something like that?

https://github.com/AMDESE/linux-kvm/commit/266a41a1ea746557eb63debce886ce2c98820667

With some little hacks I can make this tree do TDISP DMA to private or shared (swiotlb) memory by steering via this vTOM thing. Thanks,



> 
> Jason

-- 
Alexey

