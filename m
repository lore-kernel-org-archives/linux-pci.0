Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A5350283;
	Thu, 19 Feb 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522785; cv=fail; b=D06+3+y2quvVvD+BttrACXjkcX9EAsdlihcjDQ+YwjQeYhnQRt6XVT/7lpFbaOxfTmb8u/ltpQ43hV2w4bcSSgqYXEwVoHHOdb0H4eYK5z8GF8Xx9t8hAF5Vv+sO9SkINYKJ5FhIOsG8hFKEOOWQ2vsUrGcv18vSqNyMDG1UeAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522785; c=relaxed/simple;
	bh=RalknU25WRukIPrisWRfQnsomsCcHJRXlPzsmZtyXxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjGPzPrguhTPzgMrYVBH//ucFWOMDn24Vu7tnn5kWecqy3twH0DEZsoANkxRj/dVdr/+ghBVN6aTFcJf/wUZuOLq8llVicOB0d74L/R8VyL/fL80OLAOz2lUA507U/13Yc/UhW0aHxzKmVp0tcHreG43CWgYZhE2gAeCvlTppEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0P6HPba; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0P6HPba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=julMC2v9SRgUsEsy00BDOaOisiZjhy8d03ESXUEWsqVGRuAmApaBVEMs+nfNk1vIvVTd5zgCGL2TBe5FImQI/AnqmXFQR0ZnR7fgdP+FAI/bvgz2OImqXIPMccSxFFb8qeXCfySdpFqbvgE6Ytp6wBNPPH4Wdnd8gIxYq7qYmEGeTZpY/fd4JYSDvRVTkPyZzJ3xO8rR633t3FD3KaUzMzIAeb8wgACg7vsQw/nJPTRqiTY4f+b4uXEi0Mm8KwQyMuHaFsPd+WeV11RzLXsu6Z2ZZDqBk5jVFXz83Wy22Gj3vzZ2ojjx/fFbSGYuKZRaFsTMr+uCaFfYS1Dif0Pq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw2+9OXab1k6SkQ263awoFtTgp2pv4/zABtFdW5EQgI=;
 b=NI4oXnA/X1JEOnl97B+Qyb7+v1v7SItiK/7R6DnWwxYE0qX0BTzhPWwMFaVmMKiI7LH6PS3YmLkY8idlAlHJ72/XpIvSrKofVOThVXIRHKfLZVF+BmkOVcaQg0N2xajZFPbsB911Fv1WQed8XSPmxCoBBvTIofTBsJU9EKrJ6GVhd1GRUVXPjl9vtTLi2kgnEu8Lg64DpVGGO/KCY1A6xuwULAYPGTmKv3PSgVMmrcJpp/eqvgMucn0m9OUbmlxXcQM6Stmjr4JSFaFExGmhtV2RiEA6KY+KPgHMpp4peD/veel80p1uF7RraVcXfIrLssVEEhBAv5M3jXZZpEiamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw2+9OXab1k6SkQ263awoFtTgp2pv4/zABtFdW5EQgI=;
 b=N0P6HPbaP/Roq5OE88oybE0l26CUTjef9QISBM/pcstJSiYb0k+4uxi8yYotNIptE56QZ6bazz51fJ3cc2OXqPEQ+vNbHzcue6s+NUkfPXA1xwEloshhse9XXcHc+ycxs+lMh/AYQ4vkpEQe33GZVKs9LiNIqfp1S5YYgUpXXYSCpZPHu/23WyY6FqnzajEp3ilyw1vCYfDT7Yr6m6g1xP9GrguE6+UMAnrlE54kpe9w88ERNEk2deho0y+yJsFYin/mV5Vxe+sRh+d00FMZDOSnsoIU91Lf2hwWAHqzqmuxW6INPttzI6beroRBQLwyXHRtx7x/oEgBWQ7PwZBSsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 17:39:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 17:39:39 +0000
Date: Thu, 19 Feb 2026 13:39:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: dan.j.williams@intel.com, Alistair Francis <alistair23@gmail.com>,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260219173937.GH723117@nvidia.com>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcnTnYJ61Kma0yd@wunner.de>
X-ClientProxiedBy: BL0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:91::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: a12c75ef-bb8d-40f5-5836-08de6fdddb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toTeM+quzU1LX/cQbjbPG42yDXB2y2+359FTTW4dnb4JPodApJ7jaKM7Ie8q?=
 =?us-ascii?Q?83nkiA1a5vWagNyYvOjEKKWvOwlhOIzNTojf8UdhW5/rplsRtLzmevngIdye?=
 =?us-ascii?Q?RJ7+9JrGlzPvnaJxfWShEBmWV/LpREO0MHqteKK/B4x0Viwwts/r0EuJzpBz?=
 =?us-ascii?Q?x/+62RvOdrQZU3+wza4XFL18p38PV53TWqLD5RywHOKzJkvU2eSSZp0rFrV4?=
 =?us-ascii?Q?2xOLdAXuo/uGA8H6XVJyUeNCOYxFHaOgqFJnUxNafzSDeSMvHZvgpzmmXVfW?=
 =?us-ascii?Q?nnhwsERnFF6kw8KNQHRhSHf+1W1t8lFItxxeyfmimetN3i3uUz4vs+ZhRRyu?=
 =?us-ascii?Q?bBgTW9R055f0S8CJ0AOXnjz3wH0eF8ADN4CoS5wIt+etsRxlsTh6As0WEZ6F?=
 =?us-ascii?Q?25jgvvhsI5QZR9LFZS9D7Bn4lnkJBKYU3O3XOq1dBO2QxmFqFPPDnPr3G0dR?=
 =?us-ascii?Q?oGffu3xRTYPdhMwitbLIdpR6NWBZird/w8AUdZxPx5CpEB2mjI7CsZ2p3MEd?=
 =?us-ascii?Q?ViUvQKZhHBNftntCdaQSn25qWhQKPerz2BZvlYGzClM2pxHm/E+BeJF8Ue6y?=
 =?us-ascii?Q?Yz3Pi/k4Zq6iR6eMPHXJmtJGTjKm1FTPLeIRHjo+d5XMFaO+yLYykXKqD184?=
 =?us-ascii?Q?t0VpahViYKANmz3rp7iBxa+XbTMFcvHT7eCKYBrFObIt2+lOOX5rcZGRV2Rc?=
 =?us-ascii?Q?1nuCBjrpbvHBblVTLVLWgmDT8YhmPgdOcATSyPcjypTW45cmtW8Ui0ueMYc1?=
 =?us-ascii?Q?WHv3Am2Dyi5FjHxYIAnrxHVeopjWsJPd66QEQwmoTyR9Nngd21TN30MQfcyH?=
 =?us-ascii?Q?17RA92P+BBGmtIn+5QUtjuLPXptJFCoTMETMVcaRgFV0ysgOpYv6vHeD0qL9?=
 =?us-ascii?Q?tnxMy4C3K+Bv9ZbhdKFsr6RdPv2q6D67Q2T/bGDKQKS4KoxfHa7YSW1vDzet?=
 =?us-ascii?Q?XoVrg4UJO4NV9GpRVgUC1Lo+s3NQXpbdGSC14lGSwIL6ENgekaJWG0Z/Naec?=
 =?us-ascii?Q?XTRg7pkS3MMnqhXgnA10RATtYAb25cTsfrq0BywpJkDngs8L+oWlsVDCVOvJ?=
 =?us-ascii?Q?tDQZF5rz0eQAE++TTSPCk5zoCoM9AGayH76HxN+nP3gUFdSsrHWeHrB1x8Ih?=
 =?us-ascii?Q?V2Kom06kLpr6/Im5NgDWWH3CY2VSSX2/Sneyv7PvMvIpn37E//anieglWINV?=
 =?us-ascii?Q?6VmbzZ2tt9FmdgnCekbyGGE+uXfVJqf/CiTk/TbCY4A3KkJAbXWHQ/ddhYcs?=
 =?us-ascii?Q?XSxsXg6KZNPs/uMzk6DN2z/KgHABLgaRJMk1EJvwjoxBniYJQsrIqLg1yz+1?=
 =?us-ascii?Q?xLvDbasoW+7y0ZlntQvAjpLkye3DrTWBctFfUN+6vp2vZF8kZWP1xFMBikZF?=
 =?us-ascii?Q?OngwXOwuOGs7/dmlJMcQSkFuopulvfBCyBfFqIzQUAZq3D03vqXeb5toENqh?=
 =?us-ascii?Q?PmsIeovDIbtqALdrYQJO53KjvkFjlIzIrUU7nw3lrizjVf6N8+954GBAWoCF?=
 =?us-ascii?Q?rVZVMF+B2t6HImJyIH2ONdBu7+uMCYJjb+tu3BpaeBNK+GpvQQBnl9KYw62p?=
 =?us-ascii?Q?DC4qAR/z/1M8EbY9j+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlcJ7Jc3ygWfxI3zlFYiR0h5GfskmkWx9Y5EdG80RoE2yIWZ/QLsYuJGf2sb?=
 =?us-ascii?Q?B59w+EYlfdfJrDPUqCY/VUV051o1DMvF4llSaEUKcL/qvwAIxshcsV+1a9PY?=
 =?us-ascii?Q?ZJJezxng9+6lyR4mtK4+fw4Tev90yAAq8k8DAZ7FtY0+xRqUPh5B7NhCzdha?=
 =?us-ascii?Q?1Vgo+6lUtExTSuYCcSj7tKR9IjUrQIgk9cxPkxkDgryODLqFdzKhYNlLsHGg?=
 =?us-ascii?Q?wJJlOSUvA9G1Iko9bAns/igqn5jbF9p9dDPYSM9dm4+zBTv03jxfB9pNWsnA?=
 =?us-ascii?Q?36ZHsLrTNJokzxULLYEb378/Wmw/kUB2zUCIZJjLBHbPWc9aR9fTH8cu+5dW?=
 =?us-ascii?Q?mojV1/bJKuMthpG224L64ujcEUA/++EWwCKJm7swbI8NIYvR2SCFCGyxF7Oy?=
 =?us-ascii?Q?JcD4QInzZTC82uzJpdj6raE6cGKb0IKvAUXZI70j5yjOSY4PPXRGN/93Mz5r?=
 =?us-ascii?Q?S4JMYdBkSMz35cGUZY0i9/Xl5QwC/bKYeJjwN+ZnzAAC0NncJsYj0s3OetGQ?=
 =?us-ascii?Q?rUvuD0pS/w0JAyB+xiawHEycVbe5cuko1qBDMw2W0EZnhhsWeqCWoCLJmi+d?=
 =?us-ascii?Q?33CaJM9V5BI00Q+665HnCjhiyM6VkrbS5vH0BousJJ/+dFkdjbYSwhunuzjb?=
 =?us-ascii?Q?390ehmjZsCc6/9Tm9KAGtQ5BDZ9rmmfTfo416RUu/k6f7KwpDgxkljW0nuRv?=
 =?us-ascii?Q?mrmg/5iho0q8mSr/zGankW+BRhP7jjq4c0vfu7gMsvBCaOr1Jmo5bcysYcV4?=
 =?us-ascii?Q?EMB+KO1rGAgP0RwRGc+Ks+2zeZ5EqSBAnRe+H+KO4cGv5wdUqmnxV/DS96fK?=
 =?us-ascii?Q?jyX6z+KSOHzBsYF9dt8UUVfa9ckms59ZGQfeHDgj2+2W88WqvV5xwfDRJB0k?=
 =?us-ascii?Q?ahVdIgsGRIuArhf+Cg3jk3S59WVToCdqZ0XYcvl88msCEzxtdz18l0zDk41R?=
 =?us-ascii?Q?5GG8IwODhHFrG1xOLIBUiSM/G6ylF7jTAR0FCBsMf/UJlt35ZMC2qg5cvPS4?=
 =?us-ascii?Q?tSXxNF0oVlzOA1r5HyD3HYyl07iJALB98CPEUU8ZDnG+adrzS94cS+QFMYzk?=
 =?us-ascii?Q?7XEv9937V1dFRZspWoSTfJvn0PUt3XgRndLD7pIZJvvJzMK+9euYDuwihv9D?=
 =?us-ascii?Q?NRlnbc/ojk/k0LLxRrkahKhYaJmsqQ86JtIVEcC8P755vjHwEYMSBP+B2ZBk?=
 =?us-ascii?Q?DnUob7otE/hHZgPsMUtQpZkHLGqpf0JygP4eW1NgfUYKFE2zyBH8nLzvr4Qr?=
 =?us-ascii?Q?7zLzqdYAJlRpkh4A8hWJz+GNWn4jP3mU2KO/I1xABPhTtuwb/YvLlRxTLi/A?=
 =?us-ascii?Q?2U+cxNnSZ6FYyuemFuiTlm8GyNnpUyApO3weWzLPy6A5PTVNUBav07uHLcCI?=
 =?us-ascii?Q?nCK7W3LYZdCAlavOlcz+Xqhr02zQh4rL4AVbRGIueXRK5aKTgwpsNYiBilu5?=
 =?us-ascii?Q?C2x4BMyNhlHlPn2vHjlXpy7qGYmg0aAGlNNnCWlChRJ9ygg4mKDR8TLEf719?=
 =?us-ascii?Q?n94/tRnw/3TT6rfmAJdym1qx3iCkppKVsOp8QnsXdE5sMtmfEMVCrQ2jAV6Y?=
 =?us-ascii?Q?gg1AXUyhGoxf3KieWN/PkknVxnrsk67d+C86zkbFlg42Erun+o5UJOd8PpSC?=
 =?us-ascii?Q?w8b2NF1Ceg01XusRuH+DYz5OjarYpJFKlyJ0dtk04eZ0yulitYtoZrAGxYTc?=
 =?us-ascii?Q?GBA2Uyn3Pkl8ZqmnmG8NQNydyBlXw1exU/TU+eP1rziU9UghRXNIh8giix02?=
 =?us-ascii?Q?93fqog/WFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12c75ef-bb8d-40f5-5836-08de6fdddb5c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:39:39.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daYF6Gfg6KnnEQAEOAV4VZVlf9DRaolw4XiwjO3+Hgci5ewwM+ShqJ/JLHCnyHYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

On Thu, Feb 19, 2026 at 04:07:58PM +0100, Lukas Wunner wrote:
> On Thu, Feb 19, 2026 at 10:31:29AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 19, 2026 at 03:15:34PM +0100, Lukas Wunner wrote:
> > > The way this works in my series (and I presume Alistair's) is that
> > > trusted root certificates for devices need to be added to the .cma
> > > keyring.
> > > 
> > > This can be done from user space using keyctl(1) or some other utility
> > > that can talk to the kernel's existing keyctl ABI.
> > 
> > I really don't like this from a verification perspective. We don't
> > want the kernel checking signatures, that is the verifier's job.
> 
> On resume from system sleep, the device is put into D0 already in the
> ->resume_noirq() phase and drivers are free to access it already at
> that point.  However a verifier in user space cannot be queried
> at that point because user space is still frozen.
> 
> Likewise after recovery from DPC or AER, the device has been reset
> and needs to be reauthenticated, yet user space may be unavailable
> because the device that has been reset may contain the root partition
> or may be the NIC that you need to query your remote attestation service.
> 
> There is no way around some form of in-kernel device authentication
> to accommodate such use cases.

I'm arguing there are two very different steps here that must be kept
separate. Verification is done when the device is first seen and the
kernel is told it is OK to use the device.

A same-device check is performed if an already verified and accepted
device resumes or RAS's in some way.

same-device does not mean run a kernel verification against the kernel
keyring, as a second verification could be tricked into accepting
something that has changed and defeat the userspace verifier.

Instead the implementation should capture information when the device
is accepted by the verifier and on resume/RAS it should compare the
device against that captured information and determine if it is still
the same device.

The key north star must be that the userspace verifier alone decides
if the device is acceptable and if the kernel is configured to
auto-re-accept the device later on RAS/resume it must not permit a
device that is different from what userspace approved. In other words
it is not a verification on resume, it is just a kernel side
confirmation the device hasn't been changed.

Hence no keyring should be involved in resume.

I understand the tempatation to just run a kernel verification twice,
and it is OK if your use cases are limited to a kernel verifier, but
it doesn't compose very well with a userspace verfier at all and gives
us two very different frameworks.

> > And a general keyring based proeprty is not at all the same as 'this
> > device must present exactly the same certification and attesation
> > after resume'
> 
> Well please be constructive and propose something better.

I have said what I'd like in a few ways now.

> We can discuss a way for user space to force the kernel into
> considering a device authenticated.  E.g. writing "force" to
> the "authenticated" attribute may tell the kernel that it's
> a trustworthy device irrespective of the .cma keyring.
> So you'd perform remote attestation and if successful,
> tell the kernel to consider the device trusted.

We definitely need to ensure we build something where userspace is in
fully in charge.

I don't have an objection to an optional, useful for embedded, kernel
side verifier that uses the cma ring.

What I'm focusing on is that it be coherent with the whole complex
verifier flows we need, not just its own seperate different thing. So
replacing the userspace verifier with a kernel verifier is no
issue. Making it so you HAVE to use the kernel verifier to get certain
functionality like RAS is objectionable.

> > >   # What's the certificate chain in slot0?
> > >   openssl storeutl -text /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > 
> > >   # Fingerprint of root cert in slot0, does it match what vendor claims?
> > >   openssl x509 -fingerprint -in /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > > 
> > >   # Looks good, let's trust it:
> > >   keyctl padd asymmetric "" %:.cma < /sys/bus/pci/devices/0000:03:00.0/certificates/slot0
> > 
> > That's exactly the baroque I'm talking about, no server admin is going
> > to want to grapple with that..
> 
> I used to be an admin for 2 decades and my experience is that
> openssl usage has just become muscle memory, but YMMV. :)

This is also not a very realistic scenario, there is no point to copy
a certificate from a device into the cma key ring. If you want to
trust the device as is without any verification then just accept it as
is with a trivial userspace "verifier".

If you want a kernel side verifier the realistic scenario is to bake
the permitted certificates into the image or kernel and/or have
busybox load them into the keyring at boot.

Jaason
