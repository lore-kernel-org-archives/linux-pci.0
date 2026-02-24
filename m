Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BF399031;
	Tue, 24 Feb 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943609; cv=fail; b=M+XNRWRdMXk+KQrT3HuM78LoYnPhHO6ukSZgT2zAuQdnLDhFx1LieBdq118JJHLpSwfOwSHfMwdmq/18FPuenTW3sTqqdWoAJe/sQF53b5hXBMq1wOXDaiEKgE3Era+4VRp4IaQ97VeJu3nKs+69tWr8+ebJKLegA00KZFye8IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943609; c=relaxed/simple;
	bh=ojXb1ZkKxn7pd4t2N9FmiimP1SQEhXw3TCknheE/aEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMgUibZpkXBBGNnMAGqHBZF+s7QPUuwlVDyy84MYj6e2JSAvhiaH+8MUEnwwIzeGX7uNt7R4svr66JwcrBfq4Q4W5M269nwBBQL8H0prPErX58c1YQUOKHKq0DtSxVlnwyFY1A9gAs+HmoZh5e71WcezR9/cU9u8+j0w+dNbEW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gt3pfGZX; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gt3pfGZX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuChyPGDW3K3A3GyV1fb/PQXUJGdpTIS2rDj0I58eFv5WUZBM1o5Zf89+UVcQE0Jk3c/utQI7PedsZPqJaMbw2fyZt0UkrZWFqvFv0YA3QON1Zm3YBWLfzLREjEbX9ufhlNznoDf1vMCobc0XqOSEZH1p0wUR9lu17dQX5JN1BExYUFwmwRKOs3qbfDXGsfXzZ//LAjY00PdEbpdcA/kLMVevryq1S9KeBswKzCMM2atUO+9WAocjc7K2DArwInZLTRZb4F5qcAwZijV6AkiC+MbTlSKPsCuofAVf8J3ZZVTUaR7/CuOHW6+0LMzd13PANKDS+lhp6HKN5An+TwJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aML12ZxwuAoO7iXmiJGkuuFDou8uB8RjjPb6T9nbANs=;
 b=wrCJ4FdHKVuYH52/OBHsw4Po0fJ/Wc+hMRXjfdp52BblM46J6s8p4rlxjawlR6RvCJys02ZxWGNTlvyv0yTQzKeHTtGhGXUSY0qejSjeEe3XNlU1nEULJku6149Uobq8Ix2sQc7KLbdKzFbYmRK8Umpp/Mae/osZgsIIRr6xzd+7bslZ2DkQ/oz10WxoqNszkZHhv3XREUWL5qtMXe88uIk3LzVOuEzeNfRMjvB7ralPcsrIC3m1ZgZQIYJKp8TQqhjZvhGEjAJwjfRBBJOkF3mXdGZFePRSjkkFIqxtiRx+rbI1is9kIvBwdx3iHPOUsMApZE3Hp3ryVW9Cc3fijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aML12ZxwuAoO7iXmiJGkuuFDou8uB8RjjPb6T9nbANs=;
 b=Gt3pfGZX75cGPw7UVKtnqaQm/UHj9RIOrddgWL5HdB+TAg2Z617WbgH1n4SitTllqosRyy9XlQ6piKrHGhlSSJJHw3I+JIMCXZ5XDMXjCngML+NiKguWk+AJKTHy2MgQR2c6FIB/Oup/Cq9WuSmSH3lF7sK51GNAPQjs2EKOmZ0d8RpWUAWzH4g2nRUE6Z3nSHtWEIqwyZqY7UY4CS3AAW8Orlx7FhZ1q6do8il6Lz4ORwL6lW+wH67066Ezgz9n3KwCt6UrvCvctMTGzAoSyhlAm5HAD/9NJpeqNdJ65992JDWA5eJWLYJsZq0YYWrsbVpVHmBDtH4Yo3FOKmRDtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:33:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:33:20 +0000
Date: Tue, 24 Feb 2026 10:33:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
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
Message-ID: <aZ22rjP5uB8DeO/A@nvidia.com>
References: <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: YQBPR0101CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c093859-1292-41f6-dbb3-08de73b1a816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ro6GK2QyBrWSB8U3hDTBSrZEE91kcpSLvT0v0rs+0h4qg9prOuqEm5OKAYee?=
 =?us-ascii?Q?J6G9EguUW2Z7IBxx/tu2K6HuTs8f3qmLkXraB993p1lFZeuoOzGKEXdovTqM?=
 =?us-ascii?Q?UnXAtqFf7EQFI2butOimA4pJLqIzkD7OD2LcdbfmXdQqvFWGIrGNXgLpdMLt?=
 =?us-ascii?Q?YX1sheMl/42BFlrUOATASEfEtoFWJZ3s/IirsFy4lcIMp3da8fki7Ffz/fxT?=
 =?us-ascii?Q?Vvbx9V1LQl2bK7J+ZsdTs6DyEboTRObUHgtqPIehjpJ6TLOnomKH7xQEEssO?=
 =?us-ascii?Q?mHqPEjUSA36WDNLepoxNOmCwNPTqAh3MBO5GS7eMx7djX3zA8IGGDfcFhfrw?=
 =?us-ascii?Q?virm4IyxirBBUGqUL5AJedd7dZkaTO1x3o1zh9g+nho6zIuz1p54w7jhxS5H?=
 =?us-ascii?Q?y90FXch4HkouXWuKuNQ1e2kFY9lDQ9TsxczI0artOB5SS9fImjUL0WcQdGrD?=
 =?us-ascii?Q?9gTXTPiicRzm6qJ87gWuwwSa35A9pI+biovx+xXeV6uAld8bv9ZKVhAv4Qzq?=
 =?us-ascii?Q?3KYXwO47/n5vKeDssQipbnTB1C+C86ajZE0GrQLe0xO6GnSyP51iRP1c+Ha6?=
 =?us-ascii?Q?C29a408lbHZ0NjMWbHi27MfkgEIhQDoYT7xXBT/LExLzhi7oyAfv6+p0wfP6?=
 =?us-ascii?Q?5MAecN+hS+40oN9D6HRAaubqj5kGzggRUIl3Ad+BMGV2S5lAoTjs5IdMIsIf?=
 =?us-ascii?Q?ePsUObBC4vFOikKZ0n0M8wNMtk6Uk/dBytOXUWRk1fKWWVWCUAyMoojKjPYH?=
 =?us-ascii?Q?CTMx5QhSBNKcUWXHJNiuhZtxKA1a4i8V38VXjrFJNh3AnNMVrs+G0EfM9Cw4?=
 =?us-ascii?Q?mzlT8ijEdz8fgCKfXcPoaxj5O5K2sywbMySZLAeCz+4L9lo3FiOpQrJb4nv1?=
 =?us-ascii?Q?XddBYR4agT5xbVILwtTSXya1m9MvqJorMPNyZ6OYWGCRN0wPFwpDxDcKWqPM?=
 =?us-ascii?Q?745uvAJIIlHxRQN0idgbX+VvcuiTaiys80yAS2IjjuFUoCiaZCulMnaavV5T?=
 =?us-ascii?Q?RYb3wwL/kw+8rpwjbsUwtCEXO6wa2xRiJ6/xETH0NX88MPYpESPAItnp34XY?=
 =?us-ascii?Q?7GKFpKUPeYISrLWZp9xHc77eIWgNxge0QdOJVshAh4R99imB8oLJv/fTRRSi?=
 =?us-ascii?Q?tJ9s1FCC5RKzBlKM3ij6QLQc4lXMLDuvTNzAswTAdhXdokhav7BcFDrQGoFF?=
 =?us-ascii?Q?egQHPvKYfOhZmRoQ2tSuGgCFnp8hxbKgRZ2WA0pv1nWBj5FOMdnkp7FE4XFY?=
 =?us-ascii?Q?EbpTi2k0gCAfE2cXMF7YsF7TbrU2qMFicfq7tYbH1nfegYvfXzQhsosTrWJV?=
 =?us-ascii?Q?yfOAs2xdDdf3XXVoY3tfkNgzjsEtuPbMR4kMAd6N6/y56Re0jXKW9LmCjIBc?=
 =?us-ascii?Q?pv7Xll+wTpq0HOwv0vf5VssPcdnNVKZtmc8Gm1cKA83IeAARW1nbFsADUBhe?=
 =?us-ascii?Q?mlkmsyGItLC+qNFPCZGfA+4QtkX3uDr0euMDD6DBmlEWnbULsJJ1IzKrBsWh?=
 =?us-ascii?Q?xwgGb+MmGMxZua/TWH3Gt9ktYDEDD8PpMVAhzGa5V1T/wOmTEsmcHgduAqHq?=
 =?us-ascii?Q?PQCpPfHjDYZZIZJbsss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zANDr4NvZSzPPE65B6MCNggbAD0BtBn46sd7Pc4CQsJBmTZXLCpLl9aY/i+h?=
 =?us-ascii?Q?t99VZe0yFcdtd3Z0K3sSe6p8LEnU2BENqWlGc0832gEcZikOt9X+ZimFY6eP?=
 =?us-ascii?Q?moV8rQIT8Yv6+9JwGdOrXeatB8rFGO1Pyc4cYISiTNvyfM4BX2yTIEuBk7aT?=
 =?us-ascii?Q?cLpj2a2g0BSXMnJJguKg3+LuBDJ0WOBFC5yv4+KR542PNwnFu8xqO+Y28hH9?=
 =?us-ascii?Q?SHIJBIHFmZNYMDxA7ejlkGCfRJ4RJrtMkxDyWST5wndhE+qwRBk9x3a2bRmN?=
 =?us-ascii?Q?25KtrCKshbT3a/kbzGw4b6Xv8p6j7lZtR1K3NvIryMHpQYwOSrOZL5szCXvz?=
 =?us-ascii?Q?JgnOp1Bhr/dH2Hvl4m6lThzS3Xkdvnz302fTqWgQEYdShJSLrQ61SVK8hyzY?=
 =?us-ascii?Q?pslujSUD+jGrlQrpM1xBzzRlwNeklcD9wwgCIlfiJrf8BZ1xwCeQtrmiSN81?=
 =?us-ascii?Q?nKY+97HbjuSLWJCjrf/ags213KWhclcITm9PPg/+ujRH5ox1HbOkFW5DSgqI?=
 =?us-ascii?Q?QnrhJFEBDniEgh0sISoMYtDdRjUo5VnCIz4W0XHFIJZj1KC9MHAt3KZiel2l?=
 =?us-ascii?Q?t7jOoBbYfVA14OeTfM3M0PgBwlyjr+bA0MePl86hpQfyTJsDaB4uAUQhGror?=
 =?us-ascii?Q?xYlQVSHIG+Bn0QhoUFsF5bkhjq4pDOFsPPUAzjmOn8CMjxYihCrlY97WAv1I?=
 =?us-ascii?Q?asFz6Do4+lQG0mZYZyo1j4iNf62SbvlTsTMP7Hu1zjJKn63ACZzZYMwpRHHT?=
 =?us-ascii?Q?B89+ncGSRsTzm9eCTNeLUpwudlawkwCc1jtMtILRn74aYv0Odg+JLrdbjEOQ?=
 =?us-ascii?Q?/j7ZzGrJByFNSivIn017pumGyN26b7V64pz12jRi29BtGXymggOH5sOrMfpf?=
 =?us-ascii?Q?avY2ZcXSAu8YO2yzUYzI5aPPc/57yyfz/WHDXHzIaVtlmIBibyqwrJNYxO6Q?=
 =?us-ascii?Q?eyHFeT4VjARGFSb5rnJKRn8koVZJStTbQO5XwD9lWjetrdhFhEkBbEOlAU/d?=
 =?us-ascii?Q?oy7ap6VsEi/x9eCBVHk/A7Q4sF9bMBMvf9v3hmpvhmJIiveY8eWUWTq0bWX5?=
 =?us-ascii?Q?oW25pQiJ9FuB6A4pA8ki2z/bNeSmR/rKKH4uzrLZCQSHw4r3vs/rzS9fFI22?=
 =?us-ascii?Q?gCh0DnsjrRvOWPz4Yw0qo/tyMfuonUcEr49YOEytlZKrdeH8Fgs5wN4ZxKeP?=
 =?us-ascii?Q?1NjGSQVyoOc6y5U8pnBa9/WAN4EiUdCnzU0UIuge3JSgwHihzAUUOxsKz08v?=
 =?us-ascii?Q?6qtfgylszTueDA/ZsgNioWqz6frEylfdq7bP1ZkcZH/947Ht6As0KJSyTUnl?=
 =?us-ascii?Q?Qa8Xi0UCqQ6RJfE5EOkExN+Or3S32LeDheuj4BDOUnH9H40Xrpj3I9xkTCXB?=
 =?us-ascii?Q?h1BoXTC14jAy9Bnbg4lhrXn694/ITGyXAEjSlZR+Wt1x5Z1j+G5gvWxpJvBP?=
 =?us-ascii?Q?N8RjVaXBcqhECJFgC3SetJpgwqJp+SKCoXelsfdkiejb8Y/eKIkEvMhX2KlP?=
 =?us-ascii?Q?RbRtIn/26d423F5HgQ0jxD+p0quNu6Hu3mpAiszTG+iCIkpgmkGuxFs8TQI7?=
 =?us-ascii?Q?c0ae7AdQtQFYMdOwX3RU8094wPM8VozsPWsFnI2CmxT3yvrEaoqlv4qWL9Yw?=
 =?us-ascii?Q?3xixTS0moti4vHARyagY9Gyk0473Qdoi+jFvmPZbp+ZP3U1spXko6mZRjTgr?=
 =?us-ascii?Q?arTYMP6jIAr4JV1uixJD1b7Z/0yKbxxopHvtwfLEoIQHlrJctCtF4lnWH0RB?=
 =?us-ascii?Q?Ji7Jt07kfw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c093859-1292-41f6-dbb3-08de73b1a816
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:33:20.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RN0eRyMti9rBGXMqrfKMtqLFdNnwGIiqxM63W4QXukt/dbzprY89o6J94W4k3XYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

On Mon, Feb 23, 2026 at 11:11:23AM -0800, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
> [..] 
> > From a simple case of 'what is here' in this set, the only bit I'm seeing
> > change in order to implement what I think you and Jason are describing is we
> > don't bother checking the cert chain in kernel for the first time: We
> > provide that to userspace to decide if it's good. If I understand
> > correctly, this will be at the end of the full sequence once we've pushed
> > through a nonce and gotten signatures + measurements.  Same as checking a
> > TSM provided transcript. That was sort of happening anyway if we consider
> > the .cma keyring as just providing a short cut filter if we didn't trust
> > the device provided root cert.
> > User space got the transcripts before it had to make any decision on
> > binding and could do anything it liked with them.
> 
> Exactly, the kernel checking the cert is not sufficient to establish
> trust in the device interface (Link + MMIO). If userspace is making a
> driver-bind or TDISP accept decision, it needs
> certs+measurements+interface-report and does not benefit from the kernel
> also validating the certificate.

Right, and from that position you have to ask *why* would the kernel
ever check the certs, what use case is that supporting, and I can't
come up with any beyond some kernel-internal simple verifier. So why
do we have a cma keyring at all?

I'm willing to be convinced there is some compelling embedded reason
why putting the verifier in the kernel instead of userspcae saves a
meaningful amount of flash - but I don't think we should start there
on the kernel side. First kernel steps should be to enable the
userspace verifier flow, which serves all use cases and offers the
highest policy flexibility.

Resume/RAS is handled by a much stronger same device check, not a weaker
kernel verifier with a root of trust in a keyring.

If somebody eventually wants a weaker check on resume then come with
that explanation and justification and lets talk about it later. I
would probably offer an eBPF policy hook not a CMA keyring though...

> > For that caching the public key bit, I'm not clear on whether you intend
> > to do that from kernel side (which I think I'd prefer) or have user space
> > squirt that key back in again?  If we are doing it in kernel we can
> > at least always verify the transcript is self consistent and refuse to
> > give anything to user space if it's not consistent (other than debug material).
> > By self consistent I mean we verify the signature against the device provided
> > cert (might as well verify whole chain as that's trivial given we have to partly
> > parse them anyway to find the cert).  I don't think it maters hugely if
> > we do this in kernel beyond advantage of removing a few foot guns and
> > simplifying the userpace interface to "I'm fine with the provided transcript
> > for use when I'm not here next time" write. Disadvantage is we use the
> > cert parsing code (which is there anyway) and parse it all twice - once
> > in kernel and probably again in userspace or at some remote verifier.
> 
> Right, the proposal is cache the public-key from pci_tsm_ops::connect()
> and at least require that the resulting transcript from that session
> establishment is properly self-signed. No point in continuing with a TSM
> implementation that is not self-consistent.

I don't have a strong feeling either way, but agree having the kernel
do it automatically and magically seems overall better if it is
possible.

What I want to achieve is a very strong robust 'same device check'
such that if the same device check passes then the userspace verifier
would accept the device again as nothing it could be sensitive to
would change.

As I said in the other email I expect the private keys to be unique to
the physical device so checking the leaf certificates is most of the
way to a same device check. You then need to confirm the FW
configuration of the device is identical.
 
> > Measurement verification (in kernel) is potentially a trickier bit of ABI
> > design as the space of what might be in there and what matters for a given
> > device is complex to say the least.  Only a small part of that is spec
> > defined.

Yes, I suggested we may have the device driver contribute this. From a
kernel perspective we can set out what 'same device check' means and
the drivers have to implement this by processing thier own device
specific attestation.

It is not the same as trying to do "measurement verificaiton" where
you may have a broad policy of what versions and configurations are
acceptable. Here we want simple "measurement has not changed", which I
think is reasonable to do in the kernel.

I gather these attestation reports are complex to parse so it would
make sense to do all that in rust...

> > I can see there may be some use cases where we relax things beyond this
> > (potentially including .cma keyring and root cert only)
> 
> So I expect there will be an extended tail of problems to solve from
> same device and same measurements checks, to full recovery into the TCB.
> A .cma keyring may be a part of that eventually, but the "as simple as
> possible, but no simpler" starting point is userspace device policy
> wrapped around self-signed evidence.

I'm also willing to entertain a cma keyring, but only with a strong
justification and fitting into this overall security model after we
establish the initial basic flows in their most secure versions.

> If the device interface is adversarial, mere trust in the SPDM session
> is insufficient to protect against the type of attacks that re-checking
> the certificate only after reset/resume is meant to mitigate.

Right, if you want to exclude physical attacks checking certificates
only is clearly not sufficient.

Jason
