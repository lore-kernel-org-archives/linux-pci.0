Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941431B123;
	Fri, 20 Feb 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596667; cv=fail; b=jjAgt10wdpWEe0o4G/fk5Bwb+3Qci3PHk/utzb1BKphK9BiWt4X2VUOuAGj6XClPT0e9zJhh+xGmWZdTT7ZLknRVYMvX4fqxSUcePtuMsWGS01UTFm8tacQpuL2xQcuvHJCU8OG4RNdFRnsjE3sxNFIuu0nbyPqVScO1WFhIJts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596667; c=relaxed/simple;
	bh=qsv43KBZQ7qqtcibXp0uD0es+vdcGrp+c4D7M3SEomE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j4sCPQ2KFGa7U1IRrzz+S9XlcBe0+dSX5T0+BU9n/YziXyNDPPtMItuJ4t9gKUTXGta2iYrfzqXGg5DumKmlqafv9wr4JgTEaSqL47ZYT0PIWS6PqksoQMsH/OUd7JaHybwrkIsDs7O2K8pSI6TOm+VeSA86KKFkt9tOm0gtQaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJrIWz/7; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJrIWz/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2eZ2bkqwvYr9IYSD9cDfia1shLC1eXi/4zeUuiwT0r5ro9IjUdl3FY5FFXicThhXxggNvAZXbAzZ2mfJu1Xqzk0jJDaB8OM6R5szUqYgUNf/Rur6vGuVx+1GfaGH+x0DDxLKw+ocYjhReVnqvo/7/OTdSuH/IXb4+6Eve8leNLOXj4m6pvD5T5hMN4gFp6X6topp7zApkqT8l1WmambeAhFnzmVwL80Emt1PPUUOXi5SjveFArbkYqEUF9BHptT6wg8zUTRnBIO8n1uk3oHiWc+dTKCJnPnI3HNVrI87ApWhGaU1oeE6QT9SZP60Xh6f8K/tSwWBUlZLavUeACQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNJnm1Bqyk7apABxFcfd1366NqCm2mB0FQI5JNCV+6s=;
 b=DCe3pAOxFczoz1nCU6FOozX28TAB1q6y5w3Tl9lH8lYzQJI30KbRSUadlwJ0gTd3+dJv4VvXxhAEDgNC9MaRbYQkuTcSXpjjzrmD2CAkXMCvFOmZnFF/xjd1/t7E2ujoXqpyqbolXZPHwJXry06lIe1tX7Wh5ultr/HfiCpTGE6BUSf38eTn/keeKrktyEpe38HpKBXCBRzh7bRE7jpB4pat3bo+Vum4VbePbKkRfYLqCZFY0raRBnB0VjqkMYonsOtSXuvy1tMOxuUOkgAzyZHaBN9JBAz9ETzliZLpE30yAT1tELk+rHsv3ZZ7/6YZYu6NrYyCtuVTMxlQAynxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNJnm1Bqyk7apABxFcfd1366NqCm2mB0FQI5JNCV+6s=;
 b=GJrIWz/7OfKU3o4uwYRkPJ60tEOA5/jvsptIduWDhJFJJC73mnPI8n22OcOrtfdHUDEj2eUOv3Wqhk4EA3CbQUjMDa/hNBuptlhSzYoEm670I+uBjHUD2hUyNmYpq/JqTAB+KhZ9WVqCm99b2nnD4+GJSN7FCDwtRuh8uYe09j7Vx9rMcQz5RON/d5/clTTlLZowI2zFb0jnJIfATxXKGitrzVjxFy6vd8MA/ZpzlNaM+oy1znMECcHdPojlwWtgNUb6vTJVnN6yx0Z03WHTEupmIrJHLkPzyHkOu6QSilgCa78QOQt8tO0fRfzcsOgUchynIVQdsJva1ABZ+b3DuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 14:10:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 14:10:58 +0000
Date: Fri, 20 Feb 2026 10:10:57 -0400
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
Message-ID: <20260220141057.GL723117@nvidia.com>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZgbukYiIxg44_e7@wunner.de>
X-ClientProxiedBy: BL1PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:208:2be::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc05492-cbed-4893-3cd1-08de7089ded0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZB0F4McuHtZSwwL/bAFSl3rW2hvZc1PW3DnE53zO+AymrCX2S6RPxeRwjBC?=
 =?us-ascii?Q?PF0Flw59YbGeXJQ5PhYQcxfQM+Gs3jHgBJYu/2iqgQxCwVNjD5Ld8iJfScXf?=
 =?us-ascii?Q?2c8VYhslxddCQZWB5U8xdsF4w7LG3cF5Ocphr+eDsgSe58761RxyqNZkaaar?=
 =?us-ascii?Q?KNvzWu2IKTiGSf8pkri/4altIfmdfb3acS2uMIbM/o0S+aUSm/nEQOJaU/gz?=
 =?us-ascii?Q?qFUcvKLBDt8ckzgr+m/4ITLJlGMgyYFQj9RxGY1ireLc9iYmq75OFdauP+Yk?=
 =?us-ascii?Q?wBcEyA2ISY9EOA5soZP/ewi7Hix+mhJW+hKRbUJ8wogKznJ7TQZsPuA1LdEs?=
 =?us-ascii?Q?SRSUYKILh+UlJKfs0/YxeZz7FYAPk5GQvf/JOuXqr/0nNgo6/MyK6kI3TeVr?=
 =?us-ascii?Q?kN4wIWV7qFywbcmsVk1Ip/JiIC6+2uQFGwqcRViqOfIsWuT0qQsF6LksiM2T?=
 =?us-ascii?Q?naLXNLjzGUrPZqPw0PI6xE3kyzqJdY9uuEOfz03mWDRwuaOybKVHLcilh9Vt?=
 =?us-ascii?Q?d7Evi9yJfRDDa981ToJv1ZG+o9Zp23UBCPPykEHWRFkuAKSml6AKg8d2uAMp?=
 =?us-ascii?Q?e+Jf5kuUAjfygZOktvkRJy/U+W2czBPsDn2mZMeDLn2oia5Vu5Ta+48FysjM?=
 =?us-ascii?Q?NF9/g+13yheCxdb8tO4cF1BkI9Pksu9kw8yYnftqa5E/MITWXJ1t3krbtEGv?=
 =?us-ascii?Q?iB/yvx5WOJhjx7LGBAisFcG/PsjkgRiWF8QqeJahmosHpHuJrRnstRGxtWjy?=
 =?us-ascii?Q?VvV1YTz42mxUDTWUIRN91xMAsDivFumIDEmKDXSf+vRnqcKfPWcT5wxmxwmT?=
 =?us-ascii?Q?PlGlg34itcF5JcUtQqlgzAgBHPtJ/FlYXrp9Y6EwGfgytD1i+t2HKB3q2old?=
 =?us-ascii?Q?sZOiWUkAjA52yAYzq8HokH6vBrqq/WwinpP4+ezvgb8kXdbziCo13Ml/H/RN?=
 =?us-ascii?Q?vDidVXLTlJoxLvc6eZ5FxrssFNSCkbTL4eFbRMdDlDsC2w+joXf9YF9rZ7oY?=
 =?us-ascii?Q?TpjTR67gmUP1naKGNCPVNoItEInE93gzj+5OoERYS+xiEEkSCKxyKqjVYfrG?=
 =?us-ascii?Q?AYecDm2GUz26rAhFOKzV1i0YqAqF3Km+62GSBkHRfNmJTbb7KjaB/v/w/6jV?=
 =?us-ascii?Q?yCw7abU32ySDm0nDgBeqKwBRsrXZ3xmrSJMGSrcDMN+Es+6eEuPwFsQCLz/3?=
 =?us-ascii?Q?8JFpAlfiUbu4SjWMvQow6sn66H5Wtxl5tSMDX3SyTmuR4EQ7+3i+INWrT8ow?=
 =?us-ascii?Q?BzSx9I+HvKzFjE8S+EQ118KDFgKYuUyBhGCwZt1iEKiHKMDZhVJ2J2eftLHP?=
 =?us-ascii?Q?F1coJin43t3LNkz7GHhAawWSQGfbLpLkBEzFlNIzR/02K/IOzhx/j0HVjKmS?=
 =?us-ascii?Q?i9wVtsOr9tAk4zwE8Bane1/te/1dj/VaKAqdQZYVzFFAKDUx/NY9ZoJcY5xq?=
 =?us-ascii?Q?CvXmUd6V0IXiT0S7z7zkZ4OO3Zz2+lGFq7PqDU7RbFChNeEcC7Fceqjb4SM4?=
 =?us-ascii?Q?SDp0x76itvgkXM8QFH6dne+WYfbZRK2E6pIFIwVNBCdBWPMrkyxJgnwU6RmX?=
 =?us-ascii?Q?KbCNdy4XgyOKYXNuJGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3DKg+j+hd4nccPcwC4RSjO1usMdcw6qmKDSmk6jy/7Y/BM1ilihtblpUSqs?=
 =?us-ascii?Q?8Hdadc4UXtyilxz1B1iQT8YB3W+7geWJRkmcp/hNX8HLbY91xNjBJGFlYLlL?=
 =?us-ascii?Q?VqSMqjGlB9L4+63MTodXOCdk4Eh10gCQZDyskyyvUA/7t6aFf+TCKAGRrStZ?=
 =?us-ascii?Q?CWMBY6Cu6TGqrlL5E5GRTHzoLXKN4Kvh3q3HeTV6BRMVbrldgmJkb/cZuWui?=
 =?us-ascii?Q?KzIZFSOIwoP7MlsUZWZoEk7CHTpfkvExeBtksIH/4xkofSH1M/L62X0tJX+U?=
 =?us-ascii?Q?RpDlAAMZW+elopj9fi02ikVm5/2rNOdwRN5FHHsW2DhIYRl424zZ+AWUwWZ8?=
 =?us-ascii?Q?o9LMJrVM+syLVe85koZJI1p3f07rl6GhPbBKQZRvCF3HVMAS10+NINk9MJGD?=
 =?us-ascii?Q?EVgquZUJMFlSTm210QuqzV6MN0jWfwVS0yiWTSKAZr1b0ix7itfdT7r+mNWk?=
 =?us-ascii?Q?xav+SzYc2hqgLvviZN2tDlKS9TWiYGNljo2NYb2NymN3ryooBoY9Tw41fjDz?=
 =?us-ascii?Q?pL1Ky8rg3VLWQnqlJpDUYmecoEJQaNwBG+Ub21FIirQ9GWi9Cflw6E9AeFJu?=
 =?us-ascii?Q?HtfKWdhoqQawFijnl0ylHxqL7GWjxsnhSPMp0g4O9onB0FQ0ymauk/asxElw?=
 =?us-ascii?Q?M4clK6vqlE0Pqh8V48OkahGipTA0uTmNlVnfLJ4qxLnZeHMTZK92K1VXU75K?=
 =?us-ascii?Q?Air9CNgKhAQIcNSMVjjxR1ltL9w9Hk8i3RpWwFO/YS0pfz1mddu8vEi5m5lD?=
 =?us-ascii?Q?f7EP7d5Y4/ZKZt0VVte56WfOzPHVzQVoQ1YbSZ6oNpXGGmbv2RCGziqJFsVU?=
 =?us-ascii?Q?5K/PXkTkY0xMLuupwR0bbxrH1GX7/g7HXjprl+cyLm1Bu8WQLK67vmMF05JH?=
 =?us-ascii?Q?7whM9QHXUBLRjYVUAMG+E1zW9VSbir7zCPIjakLdP86LgNucenITZ2g/Oew1?=
 =?us-ascii?Q?6ay1Y5jMenMp81DBRyGR4YtxIKXumQSIwVzWolPvl8cWfjsKQ5gPqfWSHDiI?=
 =?us-ascii?Q?VE4R1/gKpQY6i6gRW5htlvMdVGC1lpCN2unQFYAo52Y6QEFpVEeE+1v/n7Uu?=
 =?us-ascii?Q?KPhPIYMubKEOS3R7uUuH8AUHzoMPnEgfs6P5uUOIkolanEQgnVfJ+b9EfO40?=
 =?us-ascii?Q?N795vxGc3NifTSUoM09CGchFEMgjMPLN5o0qtwAUekOgOR0CJS7ZMvFfnc6O?=
 =?us-ascii?Q?v7lJeyeBk5acEPj2NGjRVIypOhuAM9e5CdAZV0UGXPz+RfdGev8zpu+PQAGz?=
 =?us-ascii?Q?nvzB0srwg4MnyqS792vdF6f+bOOXyoGVJ1bx/KSchBL8g3T4XNq0FLrKuGHO?=
 =?us-ascii?Q?bv7xISyRduNw6H4E8DvZzOd2BJQCAkPhGGhIzOEr5cJ8vpFEMhT7o9gUzH5/?=
 =?us-ascii?Q?M6rxdKj8ePpGawmyRUplGmeqwFM7PLo3Nid/CfSfYgB9LSrnBL52bDSFrhGt?=
 =?us-ascii?Q?B5WuIjccQrLkRN8EIL1dkyuSL4nRJcvXLGMmMNzqsWrhdIxytE7ij3JQmZPF?=
 =?us-ascii?Q?xIhEceCfRf1eMRy6nPO8eqc+gi16kJpoJzfrPnU2ljnl0Wg5IE0SwDLjJIFX?=
 =?us-ascii?Q?n3qoyZ/tHWlDSgBYAIOTH3MJbe5adEiehxCZI6NrXN4S2NMWmZml+OtBRjgC?=
 =?us-ascii?Q?HAMpKwCVFmqSKlIZg3KVmTjRaVZc1Y3SfjtxPqGmi7Vtx4Dblsrge02Npgpo?=
 =?us-ascii?Q?Xntd7NxzTdW6vUJmgyX3w8gbvFfytJlvcFQ7qF2Nt/CaldZgzclWusEFVWA4?=
 =?us-ascii?Q?YNpiv6B3IA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc05492-cbed-4893-3cd1-08de7089ded0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:10:58.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGNFNDaOdayNa3n96N/ynYZzpLxD/VPXEuw5Y7FhdyeiYOV54qKjEoGNF7Hnnf8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

On Fri, Feb 20, 2026 at 09:30:50AM +0100, Lukas Wunner wrote:
> On Thu, Feb 19, 2026 at 01:39:37PM -0400, Jason Gunthorpe wrote:
> > I'm arguing there are two very different steps here that must be kept
> > separate. Verification is done when the device is first seen and the
> > kernel is told it is OK to use the device.
> > 
> > A same-device check is performed if an already verified and accepted
> > device resumes or RAS's in some way.
> [...]
> > Hence no keyring should be involved in resume.
> 
> No, that doesn't work.  You cannot rely on information that the device
> presents.  The information may be spoofed.  The only secure way to
> ascertain that the device you're talking to is what it purports to be
> is to ask it for a signature and verify that the signature was made
> with a device certificate which is signed by a root certificate
> that you trust.

Yes, and in the most general case the nonce/etc for this must come
through userspace from an external verifier agent.

>  And the way to trust that root certificate is to
> add it to a keyring.

Not quite, the way to have a *kernel verifier* is to have a kernel
verifier use the cma keyring in this way. If you use a userspace
verifier the kernel keyring has no role.

> There is no way around that.  What you have in mind could be achieved
> by generating a secret token after first authentication and then using
> that secret token after RAS / resume for re-authentication.  But I just
> looked through the SPDM spec and it doesn't support that kind of
> thing.

The kernel just records the information the device presented and
checks it is the same. Yes on the same-device check it will have to
make a new nonce and push it through, but it is only checking the
results against the previously cached information for this device, not
a general keyring.

> A userspace verifier is incompatible with authentication after RAS
> and resume.  It's a technical limitation that you'll have to live with,
> I'm sorry.  If you could come up with, say, an eBPF verifier that
> user space loads into the kernel, that might be a workable solution.

You are ignoring the proposal - the idea is to NOT VERIFY on resume,
but to only do a same-device check.

A same-device check should have no policy components that require a
verifier. It gives the device a new fresh nonce, obtains a new
signature, checks the signature works with the previously cached
public key(s).

IOW the resume/RAS acceptance criteria is that the second nonce was
signed with the same private key(s) that the first nonce was signed
with.

In many devices this will be entirely sufficient. It should be common
that each physical device has a unique private key with a certificate
chain to the manufactures secured certificate. Since the private key
is globally unique proving the device has it during resume is the
majority of a same-device check.

From there the kernel can do additional checks, sanity check the
presented certificate list is exactly the same, check the attestation
report hasn't changed to ensure the device hasn't been replaced with
an insecure dowrev or something. (possibly the driver will have to
provide some helper to same-device check its attestation report)

No need for spec changes, no need for a key ring, very different flow
from verification.

The kernel should simply monitor the signature requests from the
verifier, internally confirm the reply is correct and record all the
public keys that were successfully used on this struct device.

> That spec section does not talk about user space verifiers.

Linux will have its own sw model, the spec is just the protocol
definition. In the CC world everyone just knows the verifier needs to
be external.. How else could it even work?

> > This is also not a very realistic scenario, there is no point to copy
> > a certificate from a device into the cma key ring. If you want to
> > trust the device as is without any verification then just accept it as
> > is with a trivial userspace "verifier".
> 
> No, in the above example the device is not trusted "as is without any
> verification".  The verification that happens above is a manual
> comparison of the fingerprint with one provided by the vendor.

"manual comparision" is some debugging flow, like I pointed out at the
start.

Jason
