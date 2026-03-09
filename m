Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F03E1222;
	Mon,  9 Mar 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071957; cv=fail; b=kEkksmNShaNoO+CfUQNWBGm0qWcMO7DajosnRZrjqQUPm2b/Tp+wBJ5D9Q04cytAr7tBYCepJ3oJ2pOSELB9BFqA86UZLKNgtHe9DxANKJ1ZtXoh9lcp4ZgzpYFyPJK6XJF+cV7FoLDcty4f5+oRBQp4IA5E3n0i3T5BB+yJz94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071957; c=relaxed/simple;
	bh=d210dpF/C+VIfHhzRasoIhOpyhNH/RH3eUdT5wGdj4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+w0Q24j5r8ieJW3CRIue8FSPXZaYDHfF/+OChrYUMG1wd2LglY93csCTzZuSf430d6mz6NIJ006E2PWAVxtBupTdLx0xy6k3CqfNIrjAqO2HuhBSn2U8PDIR/j5L4n3uq+3WbWvjXGB/yFn4UUZqWzoa9ChzBEVe9CQ9CCJLtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlX7oqCJ; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlX7oqCJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuUMyOmCb4Tcr4XEnSoGcisyYbYDINb7zkaTs2Hkqs5z3e1omAqRSZXboQFieq8u566HxvtMM8kDMgTWwRLhUDA75Oepx6V10BIKDwemzgXlyGrQRw+9/HY6CtSK1zwxMD4Ox+Mzoz4Hc3Q4DHZ63pAAlTgOQZkFP5hcyRTCfrPxExyFasBGp6PLBed2qoSzigXHI934/YZ+TtOjmOWPWv6M9OxPHl8OOhmMItiZoYb5qNjfUqXfab1FdryhD+Nzlz4GpsTVSec6w/xcMilbqUod6YiS0Uy8RyPvj/cVbfssj2oNwQKtH2bR8WC8uOkaxAfjaotMwELI8fm9G8i7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCOH0FZ7acVXJXKuoGLx9EQ+XMDVNhB83GpTC/uRX3c=;
 b=eCyOLBeCZ4V87rfdJpfrlGRTQfupYeou6hcuzE8aedvzayijghjZvBRCJg9kIyRFyvjgc1HYVcTrInwOa/QzMm7W2YZ3Rv3lyWCp+qSoK6ox95II3x43tVp6XFTqSGbZQ4LIw09wBhu0e/9ACcl7oF53G31ALVO2wgdcuNXNEbMp7qwJslDInRh9mfAoLgPVJFfASUVIzHAhoPkjES1/i8e9W7yAPQq2hX2W/JM9vZWTSS98/AcQ4eR6F60O6GiTFRksnSkq9M3dc+r1UPxIU7vjZfuedBLAVcqGxoUf1X83rpvlppn+//BW00Co54lTn6IetSBsN4pEDqO4wf2Yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCOH0FZ7acVXJXKuoGLx9EQ+XMDVNhB83GpTC/uRX3c=;
 b=XlX7oqCJ+KafBHoabh0bSKNqSmYrBc2AkUF10YZiRdixLgReSUCrQldnwbdwr2JwQStnphNFDwcz2fFkmzdFzjOHnHmuesgT7c7SBbZGXUPt06CSPgkVDYbPtQPbfRtjpivlOR9s9/FYantwsd8XuyWS/hmyB8Y+21YpXq2Atj9Q2UuskZT5RAuHSVAFB+00RpZ0M3h4jPzhrn67/plMsWLeijA+VYIUsLx4OICHaeOpcsTlA6FAc6rPXRV2EkrZ8axUg0rEPNoySSaaDAZbm6/eEEJxfE2n3M0+N7m5bxy5D9lIVtYqlu1E6FzqmdWLIfPeZJ4WvMB5XMQ4h0gc1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 15:59:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 15:59:10 +0000
Date: Mon, 9 Mar 2026 12:59:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dan.j.williams@intel.com, Lukas Wunner <lukas@wunner.de>,
	Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260309155909.GG3717316@nvidia.com>
References: <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
 <20260305124837.GS972761@nvidia.com>
 <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
 <20260309113941.00007258@huawei.com>
 <20260309123148.GC3717316@nvidia.com>
 <20260309153339.00007b29@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309153339.00007b29@huawei.com>
X-ClientProxiedBy: BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: fddaa0b5-45a5-46b9-b145-08de7df4cd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	znyNoKzzObUF4zZoAWI2FNmsY5AF7XV2Tltt/lnBoy2801PHU0G8vQJIf+T/6x8nWTaXs7+GfAg5pnG3W+Y2KUqhiK3h9e7sarEiqH6qdhQI9xHEDUfhQFFqn28M0yiFmW95n5ARJ8MxiUvaZ82dYo5TgdCONsLyP+zfBtX78gHpfy05Dzo2I1mFxjFJp6Z6LzYP0RtHiRJHYN2iPAaMoOyPLsvsHra+cczJMVZO/zVoTNEAo4F4kQDMz2DOkf8Qfg0jslu/2iFvr7bi6w6j5hsLkCAilikhP9JedLlZhpbRd1Pgyx2465RgjZehdtfS1iW9D+bppX7XScWPvjiamrP7jVALZuPN2nBm7p1fj6i9iVEapY9Culm/lGOcuTEldP7gLF1nslmXp4cHa//9YtY2mLN9NHQMBHx2lkMiEIwaMjQerDyi4VrjZvy62L8vdaD9A/95LtxDcunbr8yAsoGXiJkKWvAVjkCUcBi17k6Xmma65/dddrbhvjPJIM0t/3rV8eZTfyWTIg/dVxavlIXcxjVawy2H2x1RitDqWma5+yqYYegh+A6s+JhNEMx25X9hO2C5xdMLq2LyxJZOX6vaRvnjXIeQ1lm8TeQ+oogGnpwpt81Rut2LhpL8ICzUXGkdrYqL/RgeJ9IZfNOAKb8j8mpilU9ZejXfUMB8naiKIG2MH5m/RuUlzENGr67s+wdYb+/Ud6YoUbOhPm+6C4oPvyr+a17YSsUUB90xlB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFsY0+sKos+6ch5RZyP3yUULs/o1Ti+pBn/psH/u82bmEbVy8g0RyBDhKowl?=
 =?us-ascii?Q?kO4rGptSEGK57CW27pzYs4hZHIQPtqObgSRvMqr5zdc6zCxRk2oGgfV59Jdm?=
 =?us-ascii?Q?LM4z7Xx695yZ0Ot+egY4Q2xkTbAcJoquW4I7e2RJe3o429jWDrTQQpdhhvaf?=
 =?us-ascii?Q?MmOFHy59pwdeMm0HUksbs2tmQh35C85ZgzFK78u1aUKrrmEAfv6H6oNAkhD2?=
 =?us-ascii?Q?fiRBWoH3LsmJjVTa6N6yJnX8Bmdk0kidnA9UfjxOFyu0vVcv9ScVV9SgchOF?=
 =?us-ascii?Q?99T4+TtYurnhjdt0cVLaS3m34xDSlDJ4PWTIZ1SBOsbuFw5M3Iocenr5m/kc?=
 =?us-ascii?Q?1sLgzImDoUO8UD2wRzX0SRnLEoFSK2ZmrSHNiCGX3vrmDHBYsI55w76wWeQn?=
 =?us-ascii?Q?z6SEh6xdkJo1/l/0jzqA2Yolq53E43HBrCn1dZdoS8q8TGSVh1smuK5TID7C?=
 =?us-ascii?Q?Cdit0lkyOBmR4OvXgmxTru/r8ZGW7sOvc3VQIHaiMsg8RlTKEdA0dT188qoX?=
 =?us-ascii?Q?27chRVWzLkAyU5TJmqFsCkyZFztUNM7Tcpn8Baek2Y6jLtC1F6zHFm5/LCdG?=
 =?us-ascii?Q?rHbElQDN3yyGypDuMCXB5QJngIAgLHlBZtS9pNrKJZrJaJnnUI4Aq7jNWlxa?=
 =?us-ascii?Q?xlWCDr2t7S7S8VkyhSVKVDC1UuV/wvEVnq0qp1jMU3TqyXxy1XJ6UuHv/H0G?=
 =?us-ascii?Q?H8PtdJHwAXFC8Vj3Dv6ohhW9BMNTX9Sd6+R/qAg0XaxVJNCWi224yWVD/p92?=
 =?us-ascii?Q?ExKC6FNEfxvuHVCGiqKDrLd05ofqS4RUEG+OK7+8YM+UYFzRzPbTsZqLh6h9?=
 =?us-ascii?Q?eqL//f+6JlPPnzC/ZEcelGZbmnjN2PKBGvl2+gC3Zgvt2cnGhVy84R9aAvYK?=
 =?us-ascii?Q?aric4eTG9vqlXS7kO6e/01VRYpngkvVgvWRnYPtt79T0PGcFz1Y+QEG/O+pN?=
 =?us-ascii?Q?JkTAH0/jOqhND3onI5fhtdT8h+wcMuuvy9vR5pTc7WKyDGwUg+gzF1h55puN?=
 =?us-ascii?Q?Mac3DWTxpT2pHbWRTBG3LElWHZ/kDFz23nF0vcKEszHtRUQJW4zRR0DACXFO?=
 =?us-ascii?Q?NZyIorpyDEbsBm+3QIBWgzq5TkdLS2kHPmk8Sl1zRJf7xQxoImMxWNDPOcWp?=
 =?us-ascii?Q?uAwRaG1ZnALm26UWxWYDJcsQX/0qw4bQ6PCMASPTzIlOy9NCiMdLHQHK9JIm?=
 =?us-ascii?Q?nHlnOU8nynKyw5ndUHhNXD7bpAatUzU/y/Cn2j/6PmfrUPb21HPQbT7KklZP?=
 =?us-ascii?Q?aBSDeZxNEzvwYr3un4j9b3kbcUV6OwZ3vjy47P2z+voQ6K7u4h0obPFnn4UK?=
 =?us-ascii?Q?w2PivmgXxh0Xggip72P2KuyI2lrVFh5MFdzaOOipXi/CiweINrbfNWuco0EX?=
 =?us-ascii?Q?NeKeY8yCvv4kHb1uXjitXe2Gd+VARcwKY768hpI4h9dX8WjlUK9DFUOx7R2p?=
 =?us-ascii?Q?+QW4hM27Bgoixk748x/KD5A1pHSjjBwBm1ZignNhSI2o1oFD+WRcPjXjGyVU?=
 =?us-ascii?Q?//cojqI68erX48XsePYgGZlJJZOLoO3NDXa4hJ9txI/XjdgNFTbEH78ia7ct?=
 =?us-ascii?Q?xufgJiLExtqFSXucLLa3Z2rEa/Kd6ThSyvwf8+nneFmiLjWFGJS+wqP+Ut+l?=
 =?us-ascii?Q?pItZV8YDXxl41Zn5Kyvs7Og5aCT3R5b33xj0PMxj5qz+5CfBaIulrw9dKNcj?=
 =?us-ascii?Q?7mzr9/s0TLmaHGrAS2JckJsrVMtFCCKHIiOelDE+l8cFG7Pvn3A7UhCrSmMF?=
 =?us-ascii?Q?qt1ZvnLS9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddaa0b5-45a5-46b9-b145-08de7df4cd05
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:59:10.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmVE5MCmCSWWyThwbINICFnzxubi4Ot4S3sEtvehzX5aHfi7pvxuY6qyiNuKlDAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174

On Mon, Mar 09, 2026 at 03:33:39PM +0000, Jonathan Cameron wrote:

> I'm not sure exactly what our security model is in the native CMA case,
> so what software we can trust on the host. I.e. does the DH session actually
> need to be between the kernel and the peer?

Yes, absolutely a DH session is required in all cases, it is the only
way to generate a PCI encryption shared secret and exclude a MIM.

For native the verifer should be able to measure the running kernel
using the TPM, and then confirm the measured kernel and the peer have
established a MIM free PCIe encryption, and finally measure the peer
device.

For instance, imagine an enhanced version of "Network-Bound Disk
Encryption" where the storage key is not released unless the server
also validates PCI properties (physically encrypted with no MIM, right
devices, etc)

> > I suppose the flow is the usual crypto something
> > like
> >  - Kernel negotiates a DH session/CSPRNG with the peer, generates
> >    symmetric keys from the CSPRNG 
> >  - Kernel forwards a nonce challenge and peer signs it, somehow mixing in
> >    CSPRNG data to bind to the DH session
> 
> We have a small amount of context (8 bytes) that we can put anything as
> part of challenge/auth (alongside the nonce) It will part of the signed
> response. Would that work for something from with the CSPRNG,
> mixed so that you can't go from that context to the CSPRNG value?

I assume SPDM is doing this already somehow otherwise there is no way
to setup the PCI encryption keys. The fundamental purpose of the
signature is to exclude a MIM by signing something that proves there
is no MIM, and that is usually a value that both sides independently
pull out of the CSPRNG. If they derive the same value then they have
the same CSPRNG and DH tells us nobody else can have it. But there are
other approaches too..

> > Of course all of this should try to align with the way TSMs are
> > working so we have as uniform as possible uAPI for evidence transfer.
> > Though obviously a kernel SPDM has to be distinguisable from any other
> > TSM from a verifier POV.
> 
> Agreed. Very interesting to know what exactly is going in the TSM
> SPDM exchanges as hopefully that will reflect best practice. If we
> are really lucky they won't all do different things ;)

Yeah, and I don't really know the details, just have some general idea
how attestation and PCI link encryption should work in broad strokes.

But I know people who do, so if we can get a series that clearly lays
out the proposed kernel flow I can possibly get someone to compare
it..

The baseline I expect is a merkle tree signed by the root of trust
(TPM or platform TSM) that encompases everything down to the required
bits of the SPDM negotiation to prove no MIM.

Jason
