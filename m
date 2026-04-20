Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCF3314AE;
	Mon, 20 Apr 2026 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729059; cv=fail; b=UlhdffJ8Gz/D1lDJNLTArXTvV/yw20Ib48YE8qh2nuWQ1etOGKlL71V36ugjqaYMgEZxwCiuXuzrAW+dEiZ49JAvKRMEztmdx/sAyQczSx8CB4b1I5JqS+vgKCgAQ54KcC065+y4bVwIz0MbKP67DKW/EEw20kEkD7AREnc5T1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729059; c=relaxed/simple;
	bh=lUxl8u5UL60XRBC4wkw0skaS8x7xgr9uT/6wBKUibQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEggIP6TcA95jXZ3Zqf5+ZMqQq8P4LNZUoiIezIWY1RqnK8mC2kAx/rEUU5wR+Kov5CQDo+yezZoJUZb3cPNcHP0a558+kKDQLhhfoNB8FkUXPZNy1+iwLrnsfwIfUDrl/xQcw1uObUX7z2ZbrM3SNx2z8oWqMVa1kZfePbK82o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtKV6CLX; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtKV6CLX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMsEyLCOxjyiKHnYfyOUbdjiBwKmRT4UvjFSnvf8YuN6cTcFZirvR9p3J7PtXMc1bmSbaIOyrala9L94+iSNX2i77shjavZA+M2TqfuDNHnZCFnFDqc4R8UhAX77qsl9iS8A1Bh2LYkIb4rDTscB1iNUvU431PKqe/bG2j08qKoCtVKBGJTiWwhEUp9NLGEWxG8dBxcqrKpplpFbZTSTyS7K4ze5ZpYa7WKzo1x9KmveF+FqXvqbR7v5k0KEAlnew+hEE5X9uDnKZ1AMVD3rcSb/dC/JDG4yIaVGThs7uP0X3hQuWGW0yXPw8dWfFJi3Xn4FvxtIfN2HfluKjEAiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtEluWZPYvBCPb2IBYLvdw4k3lO8B0otgVJjzIBKqXM=;
 b=iUcY2UehSBR5sl7HzcMWIpOJLO2dKogvmJaTnJFS7KZ/uYxa1Ii6/vHwTlzP2uMWyJWNTg9qeHupgoPBGrdGJevrrRvd8eP1eslbi158C4OKJfuiaRHXu2yLKvNeQOeFA+of/FfxuA/Bp3PfB71BqH3ZeGBtK1TQmCPFhgZN0arBEKOiVWLCqYfNNKUGoLSTK0M/wPLQK4tpDtmZ5L6wBqxH4BLzijQ8EWgHVwoCESDRBZiOkOmoFkBSoQ/H9jv9t7dtAc61VoOCd5YxR6FQENPCRZM43CQtfYBvAbfXU7rVnu9AVLpQIMmHSpPLK48Zi7HVCA/fLZTFCPwD6eJz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtEluWZPYvBCPb2IBYLvdw4k3lO8B0otgVJjzIBKqXM=;
 b=qtKV6CLXLBHzKzhUcSx9DDi33jaOvNfN1+7n0sfFlm7/WpQFzXOEEqBJi//D0ocIYNO+1Yz89nvN+60K6OwCtVYkM6xmffdQ3cKpzy3drl4PUdc6hszqS2QjNzcMlkKN/M+L343+q1A8Ri5oo/ZhVsA09Uxkr4uZCXxYCCoSXDbScr2syXOqrEuE5sK/y3ipE5EVmlQRGfv+rXH1iPH9pavjYYEmZp3c4K7ig/wwRmwMfP5debTBWcbhm0hxjK+OInC5MOHkAcfT/4edcq9gk9mp+xGW2PQs4nj7OMUrY/9jcrikhUewD1nPZgQtbSYwDI+Nn1sSn6Z5f4+dKBPHtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 23:50:49 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 23:50:49 +0000
Date: Mon, 20 Apr 2026 20:50:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: dan.j.williams@intel.com, Robin Murphy <robin.murphy@arm.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
Message-ID: <20260420235046.GA3199414@nvidia.com>
References: <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
 <20260228002808.GO44359@ziepe.ca>
 <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>
 <20260303001911.GA964116@ziepe.ca>
 <20260303124306.GA1002356@nvidia.com>
 <5d669086-a5c8-4e55-8108-a9fff41cf094@amd.com>
 <20260304124316.GL972761@nvidia.com>
 <074633eb-103a-4452-9aec-6cd61e82f0cb@amd.com>
 <137e5595-390e-49a7-8918-9ca057f7ebdd@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137e5595-390e-49a7-8918-9ca057f7ebdd@amd.com>
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd0ea43-4dfb-4e77-16ae-08de9f37a5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BLVjFTAlBSI7P0kFwUdOAmCBWUCtTRHuQIgQWDVKeJYjMdsK2KjHGqxzfdNqKGXzX6VymSkhElSxheRQqu+v//IufI2rJ+CrRfXTDcP9k6A5r3ayX1e5jHCFfetgC91rjZJ5i+ePF6d6dsMbhRuL6c7+fO7qgt05EignyEq6T4+C4+ltyd+VuS327Mxfpge24yZE8BkIkKVW0shr+C2yVeB8/qAU4AGmLZhZ5+z672kroYHYmScPsoQp2MgW0EV2yVWfiRLURG1/TId8V7GBzyzVNNoe7Veb0yPC4ObeKO8OcmfEP44FSJIK8BtH7mXNdfaEXooWoUJivETZTO3JyBdGiNp0uozr3SADoQ5UWrg5sM1w4+ejlNTGlsz2swwOseOK/0kw45hGilQeo2g8iyMA2NfZYcF4B9ARDm0VMLISRKcslmKksz8hpMUr43g6k7V2t1WbWwfKCVBV3dG3ypyGentAfw2kLYYvD305Qg4LVnKRlOdmHxwDenVThz/Ipu7scqZVsWk+DyfcofVSCmZQzxPLcM6HK2tPX63K9LcjyGbGNikbRdbLVMs2SHgp1XFEznPFITz8mxPF9WGiuX0g9BITLdqarADL95eiblOhX0NLlDn2l2bdOTHue8n/DJEW2YqrEI141ERi6zmNxDTWkzbsUz4ZJnLhwmvVFVgqTgKvK6arkV7rTvQQwmMiaWiyc4oT4+q1b4W8/ZYyuX35VuGpIXE+bvjM5rjnsgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EbT4DmbqLSu3wfxyF6buvKo0xGMC1w21XG8rTZGfVq+n4971pBv7/ADfmhhl?=
 =?us-ascii?Q?4bEP6V5VcTzJsDKSaS/5wRx8xX0/4akWuWPd6JwcpPkIlH4vA5De8S3C06hm?=
 =?us-ascii?Q?5SmM+xASDSAi1jJ2zR/0vjhUqK+oon7zESQsd/hMq07j+4WKcHutV5F51d4Y?=
 =?us-ascii?Q?fb4H8uQOJnyRwYMvWfgD3q2RzXMtgsw6Re8i+ACbKcKklZ6Fvg6ipetXclfX?=
 =?us-ascii?Q?rrNI6suivRTKO/g9ABT3O3XYiSSJuwwuVA6yIiP21PafddQPQB3ykqu7KRa3?=
 =?us-ascii?Q?d/0g/0yJNj5uQwjO0uzZwLJsGV0Bf9k8r0bUwy2F/T3XyabxAUqzsXEJr+Sc?=
 =?us-ascii?Q?7TocTjDUm+XCFK7gaQ9ArZtVCIxP3386cY3Js2IfMuZDmr7S7MlBK3sFNdFE?=
 =?us-ascii?Q?oN6vK9SUfIDUgK0NeLw+RI4QGlqqtR+rzlTgJyEzlExcp97fxBLhjUbOddr8?=
 =?us-ascii?Q?rJsLzcWtplRwsM3f/PGQQqStG3gCUaKHuWwh+Ko+IBOh2UVNfnQHc5NDyweo?=
 =?us-ascii?Q?FWJal7LPASkLaIAaXofFNIPOnpd4vxKJ+V6WsnQHzft6t967GhjWo7yVECFX?=
 =?us-ascii?Q?sS6ZcjRCpqGBhzapHtCS+8hwrqB1in16KnfBLSG39UBf5JGygBHFtPhpOd0m?=
 =?us-ascii?Q?rGcjWNsh2OhE30T2FJca5GvD0LLNCxrQng2WPczAp5npIHVxQ1fEu6XfLmlo?=
 =?us-ascii?Q?hqQ3JJxPOK8rxcg03CI7KsT/nssWYzLmCU1lju6SUbwGBuMY6i1X2s9uooEA?=
 =?us-ascii?Q?3n867H25RNYNRwM6R/iBcvV2sGywL+PT2FNrOBKszqzM3H3sw3d93Li+ECwt?=
 =?us-ascii?Q?Is1T0CA3KQ7H5zCjRrqm/2/Q9N77PkqzKrJPkDQsNLBfFXw2DVeAmvBuHCiZ?=
 =?us-ascii?Q?ONYmT6YsZ6fGx+cIt9yUAyHoX5T1h/OJSeDukYchY/4RLjtnBTY5RBoHb6Bn?=
 =?us-ascii?Q?erzrvTW4AzmqX9VGM53RvVEkW7j3k5hGMOb9eEy0WxUZTlWv4AjecD4sIvhU?=
 =?us-ascii?Q?qbAWu845oVN25w+Yuvp64rMpsT7c5ZBDhFbu+wtdm8mBJ41mPcoA7XfOhsKt?=
 =?us-ascii?Q?G//vdUriaMixQ/dyQ8NKOoNpS3/Uty/9BRZjrlPoaerJ1IH93ICDVTaY49Fv?=
 =?us-ascii?Q?BA25WHlQnpoTROy/YUlKOg7MXoD+8n7gnKMaRrAxtpHRa7gsm35b42eDZA6O?=
 =?us-ascii?Q?MoMS9HO0xARQHhSeuCXbu8ciTBVYCKh9E5ox2X+BgKTgpbcLSSxgv2c1dtyb?=
 =?us-ascii?Q?6QeWIV6ZMUk+1hE+m+YTSCULCbS0nFAvL9AEBDt7GJlpENPII6oZru3dBlHz?=
 =?us-ascii?Q?ApwWDaoZ2Bth17M77oNvEs18VWYNTiky/tvMLyVcNX2qfTB8Hn9MqOPNLSIX?=
 =?us-ascii?Q?7nsRSt+T2EZEiY6WQDJXCG98xhYC7HRBal4S2TikYWZ/LSs9ivk5wUoKOgCu?=
 =?us-ascii?Q?ejqx7ag2BI4aAUFOAbHUfTmPdEsy6PxQ3RTod7ReuEq/8laecmIzO3iNlczz?=
 =?us-ascii?Q?61a/j3NY//0o8PTTPmwpNFRB36u14jsU0gkOb8qAYQVGR4JmWWWSU4Ty0csz?=
 =?us-ascii?Q?emhMToVJuOjrytnt3W96P9w6xEtXvO43k0av935K+w3013PU1CIg+V3Oe2Zg?=
 =?us-ascii?Q?F+LMENWjIGjPwhNkjJWR/a/wyRhsTMRAiq6PzX0bHZhx/6nGMefwfq1wRlTr?=
 =?us-ascii?Q?TkqO1MFAhq45B/+eCp53GM5nEFOzkE6I89pOUsbRKvAvftoH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd0ea43-4dfb-4e77-16ae-08de9f37a5d4
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 23:50:49.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7obP3l/Klnfog07902aRxR+yQfj4H6Fg8JVwFz4AmTla8CZVaC/fW/FjCNTg0jMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890

On Wed, Apr 15, 2026 at 04:32:14PM +1000, Alexey Kardashevskiy wrote:
> > > So the DMA API should see the DMA_ATTR_CC_DECRYPTED and setup the
> > > correct dma_dddr_t either by choosing the shared alias for the TDISP
> > > device's vTOM, or setting the C bit in a vIOMMU S1.
> > 
> > Something like that?
> > 
> > https://github.com/AMDESE/linux-kvm/commit/266a41a1ea746557eb63debce886ce2c98820667
> > 
> > With some little hacks I can make this tree do TDISP DMA to private or shared (swiotlb) memory by steering via this vTOM thing. Thanks,
> 
> Ping? Thanks,

That seems approx right, it is broadl similar to what ARM is
doing.. But the address map changes when switching to T=1 for AMD?

Jason
