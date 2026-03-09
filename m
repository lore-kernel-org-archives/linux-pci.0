Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BD3A9017;
	Mon,  9 Mar 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059517; cv=fail; b=iEQFkcyR1FE21QPXvrsjD5HYDTccy/x6VJJB4wl9iApRjANjI8fqJxKQ0U3Vheu4r/pDHQBf18Z0CIo8C6ijxC6OQZbuJSF8Hhxi8amXgwqF3mOTp7E7PFTO4/lLoBnS8T9lw9aaJ0G8JMiKNke6dpigoFA+LKQqgsRyhUIRRLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059517; c=relaxed/simple;
	bh=4mS2OTuXwAWVfEZ+rzmtqJRIdjzP7P4Gzf2ZhVa07ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i2DlOZttD03sP5PzFAy4bWKfiwSksqcHSOnB3xhxQZ06ll1jp6TSpmjh3jI8F3XdUPZLyuqL1Jc1L4RoALBvrSPprC0pigcW04XjUzvjhI07Fi27h8i/pWvwyeffaOMhXtzPHb5dzdsrTW9jIJgxDbd/J2UWJO4FdSZtA0VY3C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fxgxPlgA; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fxgxPlgA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbK6u7sfwar6XxH6bn+uQFRpNib9ldyxaS7ATA9ihYZLZsX3DxEUhJjP/oUl4Lik3enWqRqhUwUa5FTiTnHoYH61HqKxBje16XFM0UibVWyknQN1EsJqbv554DQzU57cYXoiz6izOHhRoM725VrDV5W3V4G3X6QmfmH0jDMSq0MYkNvXuCz7L+vj+DfM0+/Sg9r9gaIxNrEHiACUbM7IbdM6N+fr05gPj1TbtXSFoPRQ8mvWUWic/mGziGAZwrXooWoFwDq2gUmhqypo2+B7JVeUzlLCZfYdIO/B5a0ROHexIAgoW1tsSzi6y5qA+rnaUx5FuIXRdOzUdFL5SXmkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUOF8GTL1a3q6TVG2Y6wwgNlHlqueQDcCJPTOLcW3Ss=;
 b=oD2exAGVQcBNdCd62k+R8Zf1xyui90ptuKKP8xpIx81BPfBn28ubKxHNqeP4ByEuTzkXmWaqG4D8lD60c+4w1uI2IDprOnrQiDqD1qNCfBMdXV/KFrqN/wZMv753Ft8ZHYeT1V9PM3tkiLEz1UVwsECWm+PNP18sSvmhEylO86Np+nPWsDo0YKfLJPewZh4TL1U7Rlie0/s/syGnxMu/9IJhfrQa4vJ24vePfzIgcF71wSSnPkXH5QUtexs4iSX2n9VFmWYz/xOSDVrrHU3mWJ0jKK21pb/eaCLCT+EBHyxrU+IGtba1HQqkFSre+Pj6Benmv8vhtkWb6O0aZeA2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUOF8GTL1a3q6TVG2Y6wwgNlHlqueQDcCJPTOLcW3Ss=;
 b=fxgxPlgAZjAHN+Zga3yvi4ciz+TmvqL8kjZl0K4xCpRYcIJCcaNlJchPuUrMqQx1pDueRW6MbKfS+iD+Km0vAAJPS3v1cb5YrnQBH0KE9ESmvy5AWgDmO31AYtyn5pSa/DAFUkCYEds0DjKz2rTIZXNwMfNKH0/oXXaG2B7tX5i/5TTe3F92xhwihZoc69JK15n99X4WBU6xGg/HrfUW43Awfd+FDHvtX7WnOKhujdUpgXw0bWLOsaCCi+yVX7P6hk01rOXL6Y38hSTBf2SJw9zdhg8tuhiArI7rEqLJfXwCTciepfaAYnN/2CFrvGnxqXL9DYlWu+E4If4b1xjJSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 12:31:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 12:31:49 +0000
Date: Mon, 9 Mar 2026 09:31:48 -0300
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
Message-ID: <20260309123148.GC3717316@nvidia.com>
References: <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
 <20260305124837.GS972761@nvidia.com>
 <69a9de4791667_6423c1006c@dwillia2-mobl4.notmuch>
 <20260309113941.00007258@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309113941.00007258@huawei.com>
X-ClientProxiedBy: BN1PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:408:e0::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: d51c3c43-4922-4a0b-2eac-08de7dd7d60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	n2RJtpvGfNuyg+xmHGrdFfUKBCyw6etXXxlLOVsPCTZQnVHeCmdRm+ioE7BmpO4CgXKmJhkjW9MoQm1OBetyiYQWy+bTJhhj44yjibvDVPUYMoBMb9BpXbuVEd6hvX6uHlsMK7KcjfpujRPoCLqz+yjau4O9q/qUF3Ganc/JWHyPKNufhIdXnx9vK8aNZHEfH0GOLPtarJEiJflS5kMl9bm4ozoMfteaDdtDSNC5ze0JKXFYxLnZ+wfeDjmkqbVCQsPHqARHcZFqGD8k5MJeyYZm/kXHlkp9d0MBJHUmaM0ZuyrX5XLBCGzWYUbH93y0aXIa47alsDrNCJfBerrAmdBWCkLjCc4p1Y62N8gaHqHkmgqHP9FOkIvAZEBuC6NW5bPn+Pp9JqvrePkNx+PypjVFWkD8GiluXTpowa994PgH2B8XyrqspX0/X2jZAVecE74eOZXIVJtkOhfxJpZL4JS5WJrONrMvQ7TJ1zEcRz2roWc1LtELt9fnwOpPxXa/JGA92esaQBc4wwG0SsY4wxgujfK24MhkHOxiWVKLjk7jANrvXG5Cn7f14drHLC+zQ6sorsh9VFEk3jDHaqE3VCJ/zXKYx9fg43TGAnSPibZzDSpxWhTW42M9B9z5giBVFmUyRWGmfVo0uDa/9/rvhb4wpAW3e0vmtc4sj1KSS7CvQ1oYPD6CpUtJBCQ4rxyaG8bswrLooGMd+FoH+7jnn4WV22qDmAdHByioM1hAZds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEi9JRdR0tYdt5BnTU6b1Netgi7fywH7srNAPjBJ8Fl7nZsf5V2W177cHoUF?=
 =?us-ascii?Q?JxliAvxp81X5mEoicFBDdB7JeBUaOR1Q9H4/ADri6sZ1GHVCzmvlaAD8oI/w?=
 =?us-ascii?Q?Gp/U7DJNX4BLNpZVcpfPOK610taRwbRrtLkb+Q6h92sV/boqK326AexoktA1?=
 =?us-ascii?Q?jfT74HLWesUBZ5jxU2sxTVHklrC0IxzeKHkMn5kDRkErkb7GKjz3VfiDhO0A?=
 =?us-ascii?Q?rqIgoQvAXBYfmZaThpX6Y3j41xiwhZoI3NmVARDoKJtfZNaSmZyNTnbiDlVK?=
 =?us-ascii?Q?j43AFltcBsCAKRLc4P1zmQt+k0sT9P3mfD7wrwQIY1ljkBAyogh5ZDjSTJ0O?=
 =?us-ascii?Q?Bl2uDVfAPrK0uLZX4K4W786B6LalrCAlNnBJMNlIRvMJwVZmk+ytZLBRozbP?=
 =?us-ascii?Q?QvbZH7Kh73/Z1Y4p/vW+FJ0jm5cYTetIG9cW4LQcpUkzF79uY0ERAgM9Wj1K?=
 =?us-ascii?Q?kA6q5H4OStsR3GMWkjY5sURhL9wQmFkbtp26F78QO/fduArL4xIjHW6p2Enf?=
 =?us-ascii?Q?u6PvQp58Ls/IpXTWvSE4tJNXRT3LhICCZ1cJCLR+154fmQhZOih8a4HHRNM9?=
 =?us-ascii?Q?uP728PJeLzVyIrDdfQ2yLQTMwo3I4DK6vsT+K9BjNbU5DofNf11GPrD6AfBv?=
 =?us-ascii?Q?WrD0HkelmkjVAl7pihIMy7DsKC5W+tqk2GL1aEdI+3WuM8zwJVS9ZjPyEIIX?=
 =?us-ascii?Q?VuIOoJB1ceGHvZ9BrckSj8aMHAObBqDgWJqR7QcFqCeWFpLVsuIGbs/izVAr?=
 =?us-ascii?Q?1zG6kC3wHVmFMH8hYL1qhRbVpFtfKKdGaloEICnCB6SF43CL69iGFdla87tB?=
 =?us-ascii?Q?KlIfLT6vYCtWuwnHTU7OO8/bh/ecVRQbQh67CYtVn6HXYTSDYoS89Acd+9Yd?=
 =?us-ascii?Q?3udYe3m5QrBII+/tYYkx0hIxJjqm90y6fprAT3CxJbAe9IXWA2ApA/06rvkH?=
 =?us-ascii?Q?v3wy+0dRiNwAXltMkwgwWImYZEmtsicmDD1MwM0MhX3w8i+Tgra0OpR0LQnH?=
 =?us-ascii?Q?k4xeMxRD/A3/TBpSPN+Um1yWb8H18LtSOuXfoQDmrONG752sGs9RvLWxuK6B?=
 =?us-ascii?Q?65sNFg5LcbxkaMWfAnuve3OxPh0LegQYOFoJqE8Qds8LwU3NQpNmgmRNtJCR?=
 =?us-ascii?Q?DIrAHGZYkqzSoIgs+TUwvcBiQTSTZgUNJ9JRl7SZDWOkqxlDbiDqm1IASC4i?=
 =?us-ascii?Q?8/7pNdAKof7t4ZMW+wbBE2jlIePayzByzya9Bm732yQGqMNMDIGHsxAW+v2O?=
 =?us-ascii?Q?PD5LlbNFER2mBAKVL2BQ9+n8WsYi9cGA4SyfOMKBy9R6FGs15CFVEXzCXPQC?=
 =?us-ascii?Q?rilf4gZW90J07560fSlW1atTgY+YHIidy0XngGwMFoHnSUjMpRW0Rd/8GTSf?=
 =?us-ascii?Q?wnYGTWwZCU1pl9gdnSi8k07rQ9SpgUDtjHazKEKwB6ahi+X61oJ8SucGK1u/?=
 =?us-ascii?Q?omfOkfIIE88mk4p88xMc2l3M4VXsrOj3je0rRgiPrXNPf3Bu0Wks5onPLZBG?=
 =?us-ascii?Q?peyOesB4LMA6RPkF7XK/8IZQcM2a7IahMeg2M7Hee+wv2DK4q+i7Yh790vmS?=
 =?us-ascii?Q?ghZJSmod6hIyTrzjhytmqCCIcCapAVK1+nDqdmxqTutRxzpk4gGPRPnx6Tbk?=
 =?us-ascii?Q?N9fUo9+ZthY4qtu1Kfcj5CNmrd1LRpswPwAgoPow8xGSZZwHf9NqYH5VyRFz?=
 =?us-ascii?Q?N27GPCmGilS0KXqD84Fz9VUTsB9tvgyEcz/mi0YZogMVbESJ00varGkRLe+O?=
 =?us-ascii?Q?ncWIIOH1Kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51c3c43-4922-4a0b-2eac-08de7dd7d60d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:31:49.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE6m4jGgnie6m326zoq86yjvWIPlNFN5i7RfT+Y5fzZb0tiM7MTH4Ff4Ofiwd18l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On Mon, Mar 09, 2026 at 11:39:41AM +0000, Jonathan Cameron wrote:

> Anyhow, all that really says is I'd like the internal consistency of
> the SPDM session checking in now.  Leave checking we actually trust
> the cert + measurements to user space (and all the stuff below
> on recovery comes later).

I think kernel doing internal consistency (non policy) checks is fine

We just need to be careful to construct things so it is compatible
with an external verifier. Even in this bare SPDM mode we still want
to hook it into external verification.

I don't know alot, but I understand this requires the nonce (?) to
come from userspace? I suppose the flow is the usual crypto something
like
 - Kernel negotiates a DH session/CSPRNG with the peer, generates
   symmetric keys from the CSPRNG 
 - Kernel forwards a nonce challenge and peer signs it, somehow mixing in
   CSPRNG data to bind to the DH session
 - Kernel checks the signature against the public key and confirms the
   CSPRNG and nonce are correct (only kernel can do this since the
   CSPRNG must not leak out of the kernel)
 - Kernel forwards the signature from the peer to userspace and
   userspace re-checks the signature against the public key and
   validates the nonce is the one it issued, and checks that the
   public key is acceptable. Ignores the CSPRNG data.
 - Presumably in a real TSM there will be a merkle tree signed by the
   TSM's platform key that binds together all the TVM measurements and
   the SPDM activity so the verifier can see a complete picture?

   ie that the verifier pushed nonce A authenticated SPDM session B
   which is part of PCI device C that is part of TVM D.

   Should kernel be extending TPM PCRs or something in this bare SPDM
   mode to provide something similar using the TPM to produce
   platform evidence?

Of course all of this should try to align with the way TSMs are
working so we have as uniform as possible uAPI for evidence transfer.
Though obviously a kernel SPDM has to be distinguisable from any other
TSM from a verifier POV.

Jason
