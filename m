Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2619F13F;
	Thu, 19 Feb 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505003; cv=fail; b=RfHoKfg4nXqpy5nPX1aOSnCoG0XVAlCBjiBNrzETbPjl9SNxfhNexXU1IxIYNvU016H1W+A7ZNQZSRBUhPLibJs3FXAZKd8tLbfvkqXXkLCKJrHSmM33BOytsp3skBlXcnCZe4qmc6uXv+grwzwQOSTvZFHLOJLnxfqKauuir2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505003; c=relaxed/simple;
	bh=dyyQIPVfD3wjVXiMZsoElJNd0yLakzX7c7L9sGi6uJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0jvEEw/VyX7otDgLho83367wF9qEqCt83V2Yo87TES1IpTi/tlSySHbr+Kzl1Nh+xC+SLAB2LI2d7raJag7Jg0eYyczGtm8heXErKdJ4JiWNAe1eMQYtdUzydUmZIW6W+pYNsGx2DyIeyKlJlob83h4KJME0Physa1ruzoaBF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTapgN+r; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTapgN+r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGACbvdm+RSsbeAGYhHzja8OkDfvsqLYmdiajKtGdP9CslhoQJRib2Gc5h4qsd6+oXSxJyva+/5DsFeewCqj5yKf7hFpmKKnxlAi/yRCgkeN+t1JVIfmyShQcU8VA7XwqgdAIKI81KZHcJuzUdKfd/Yq9IMaFMVgM3yuM0vVkYKxfXvBHPgwk3dIycZL5sv/QKJ7D4tqRyOSgS8SgHZB6PmC7y/FnmF9FMGzPLhg8KMkl7sEosGgSRq08HAbCW5IZ+lazsy4Ix+iopYrfsKXBMl/1hhgnp29P/HiDQZjDwSv/AuC0jeU0jYPOcnMESTTMPmGK+cKNvYZsjXREVkKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh15afOJ5vx/DgFsjBUdK4wRb+hmQcfT9F+NuEhRAak=;
 b=iH917OSELoHQF3zTHSQYxZH9NlTja4PPogPA9cCUMv0ydSGKyoSSKSzqaFzRWHnID6Rf3wCilikh2PO2z7S3hlU23hkSLVcLPqCnFCjV1nLa9AAP2EqEBxt9rbUS8GfWPTM8qwVOmxxLuOynWgDhK8UI5dzu6A2i1d4Ew9H/2B0pmQ2NT6nN8xVzzPsQllWR4DJ+kxXd5fvALBUaxg573pMyRtSc51KoqC5K/AWV44lP+Nztc5YomkKGQevhfzD0FYtyOe6cszeW4E5HBUlg4DhC2Ze9TsM9d/Wq4VSoXxSnuSyGXvpD3Ddii/o/xE7KjddzbSofjt2+eFVmIlt1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh15afOJ5vx/DgFsjBUdK4wRb+hmQcfT9F+NuEhRAak=;
 b=NTapgN+rrz0eFp/jGi7vH8BI/Eaanpj6TGBobb8q92IMSKWmH1dEtsSMF0ZsvZPbu3iY/ewzEfC9I7N/7BmAZY2O4Li7qLz+FU52MpLYBPFTHMJTWqER2A745u8BjxecF4+9YCuXv9ZyTKWCdqv+SYiFUYYpi5FaCFfJ/ByOWN37IjNmXkya2tZrR+g514UXlEqrBJTJsGNoEPRdxPr+QoRiBSZhF/mB4pIbWvxpI9zMeI7oie81cAEfw9lsZvckP1zIJQ9eARQwtW6nDRwneFmHswcE/rNMYQjkT1197Kr/SkHeMaEx4p5HbVDWYDnfxbvSvMS2Pq+2CAfv0hJLzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 12:43:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 12:43:14 +0000
Date: Thu, 19 Feb 2026 08:43:13 -0400
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
Message-ID: <20260219124313.GE723117@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <20260219005614.GC723117@nvidia.com>
 <aZbZP2-CadoUR2Wo@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbZP2-CadoUR2Wo@wunner.de>
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: ae53c1aa-a924-4998-7e32-08de6fb472d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O1YhdRbQgkdu6A3hz5xD6e7wYEr0q9kGfsI8QpWLyuINrYK1+azrCCaxHocj?=
 =?us-ascii?Q?TVUYADFoxoqJdkzYg1CJbtL91YmFs8d80/t0yYQ+MYj5T3FGRECwOH2WrkH3?=
 =?us-ascii?Q?HfMWZkNzywwYi9/lrIDOWk7oTwisjsskC+apX5to7mg7bbvFtwNt3GcH8RUu?=
 =?us-ascii?Q?AIzO6CkiXlzRbu+V61tUqaJ2L3xFzU0LfXbO8t8S5bgRbYhiKGWQMcPECiBY?=
 =?us-ascii?Q?fz3tZkDJLpFtFwvJVt2QzdOzj73RzjFDc9Io5g70jSjTSC/AKOSLZzjkG2pX?=
 =?us-ascii?Q?ElA6I11jjWrEG/9eIueGoWzocytmHwFcvH0FAmiAG75KzhDq8EuoCN/57FRJ?=
 =?us-ascii?Q?aMT7W/uzExhZoD0avSfpVqGvaGjXiRmFjBC7ul0TBCoYouIM7iIn26WpOkYM?=
 =?us-ascii?Q?OsUO/D1V2CaXKGkMwQJhIutJLa9fbnfH4ysxEBHG2fZGOMZHKkJfLh3i9NxI?=
 =?us-ascii?Q?dULbYjtli4QB3FHR9JxjsjJjvj5zmRe9N8S27xDy8f0oadWmCJuhSkmxnGZd?=
 =?us-ascii?Q?6wHxupsPZ0Ve7uGpu5srqY30jBuMUTWS/hMRataZlJhQvEU7Ez2EIy+WEBiF?=
 =?us-ascii?Q?SjNhx1G6+SHSuzbguZoRRRoa1iQFXUYvAgyqSYMA7naD+Hkl/ROkAZHSIvIK?=
 =?us-ascii?Q?7zY7ZQubBpPzIaB8YC3wAw+ptSBBhmJ9rth75HgJLHjGPOj01iqUL0gQUHJV?=
 =?us-ascii?Q?E47D7pE/mz3OC16F4gD4oViR3y4v7CcjQq385nlmc+l1t6ZMIcQKP+SiYz3Q?=
 =?us-ascii?Q?LEAf5dhjIPEWDu8wy2gXvbaQpT3qTepuDGCNn/Cz4e3Xvt5B+C5N6E84ZaPk?=
 =?us-ascii?Q?+anx9oxLPrqejEdbMWiFvcUP0+yZO1D+JvnBjUIlh5WpygLsWE+39iN/pIoR?=
 =?us-ascii?Q?ktfOGlYB6enXYmRI2YubwfDz++nvEw98Gan1re5kc1jJ0uIbdKri3YTZRcgS?=
 =?us-ascii?Q?WqM1zKs7moLdwDUoM61zCi3ryFmh3yVxMHVsAZowRMyVguQPwgzCnWzBpYVi?=
 =?us-ascii?Q?tg102nJUVT4P0HJcXW8aVKVtqGxqvwUye+1GvGtSu7OmAt+hXAjCwDPMiufr?=
 =?us-ascii?Q?XY6Ef/Rhckxf4nT5iHW9SgxQlsjYHC1iwdM+yWMIfTqc2rScfvhZKdiPDhQw?=
 =?us-ascii?Q?wEDuvlm/EcsjTBOBiqDfbxNA1y0oSxvjjO5adRTsM6q+cKlQhXPonaYP8pj9?=
 =?us-ascii?Q?sWJORVoSnqQU+LvsRFG4vfc5a9Kkke/OfQa2vknVd21Zmv3wxAu6x4myqNqh?=
 =?us-ascii?Q?xHbo1hU/ItgzSUjWI/5qTp2A3Q8xwWBGD9pgqK/wnou1B6QCWUDtL8aOdy9O?=
 =?us-ascii?Q?8F8CrryVcd3JhRK+9L2nxP8k1W6REbWYvFCt/0vpjEDFkNmfiaiKvdVMrNMm?=
 =?us-ascii?Q?VbTbuk2EFEm8BkvjfFvbPP/8swVAeVKTlRiiGjeC7GGNeGy2JL5ICr86mshZ?=
 =?us-ascii?Q?lqb4a+daVzQ9DJ9n3/twIjPZ6EmlT1lrq/GeidZ9uHY4Ov9cluaUPSFpIv2y?=
 =?us-ascii?Q?kefO8fhpiMgkzm51/oJRM7gP1Oi+IrQ6ydFP1/zUVJ1D9bnip/w5nl+g+4dR?=
 =?us-ascii?Q?wCLtkcXv2pPZdmRlbps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fSqkz/WVWB+qY+PB7/k0L40vc1jgRgsM/xXgGLnUnWKXljhrMI0mMsZyzFQY?=
 =?us-ascii?Q?in2qlbotSXC3fjuaWHK1NmUDiquCyrdBATqpUKWaW9fWxcwXPIbEbxwTBWFC?=
 =?us-ascii?Q?h9mBapR6bOLqQ2b0sybVtqUgO04ZgfKvqnCuHVNcZrEkdJIaGdl6gS4Akwvm?=
 =?us-ascii?Q?dWtMVT0ZpUJbZQg8nuGfvYYgQI66HItnQt7D99HMyYE1O1/OmeNS0jz1y6rQ?=
 =?us-ascii?Q?sEWa5eAvToCpFH/dqkOSE4QZI3MLIdT34f2HJi1C/6g/CxlMwC6lDNqOu6rs?=
 =?us-ascii?Q?wNZbM7hmE12+8fNUWmwSSv+ZmsxLm2Q8vKD0T0+8eGBv6jdD9w9+Uh5qZ4bl?=
 =?us-ascii?Q?EEi8awzSkQrkqfuCEGJYGqWNhUExoJbLO+HXT1ZrRBwypStKe68CVPdHW3BI?=
 =?us-ascii?Q?mCe07+ymRmv+3RQBafw/5kca3RZ9DG9cG6rMe8Xwp+BQV44eAT4tg6M/vgRI?=
 =?us-ascii?Q?6DjcAjagmCsSUYQzlI96poofJDtRyKNJLl5s//E71nDmELBVkqwCJtyoNHlM?=
 =?us-ascii?Q?PCRfPNEHFDaLH1571G95zBiNTiJmploP9Wmqe0ct0V0ixDeTAhTk//4NI8rR?=
 =?us-ascii?Q?5rTVOoZe2ST0jqf+G8fbJbigfY8dIxfpXCmOAr6vw39kd7Keut38c+msgN50?=
 =?us-ascii?Q?o0JkniegMPBrUqNuF5F3RUkWj0lkwkh9LECVy7jQhnRg6inaF61YPsi4f+Ue?=
 =?us-ascii?Q?P9Q3eNzh5IGyaiz3XEoUsj9n8ZrEwfiXLyaG1NtclJG8XG4TrbMq58IvdhVH?=
 =?us-ascii?Q?zSHRWtwqCc2mFrBGRjsYvvoCw49e+TepFhHh+RoOiYzxoC8C/fXQDfQ062jU?=
 =?us-ascii?Q?AoqcahEZH7PKcBF7Wvox2j2sdzy0XB3+LssxE6W7KJCbe7ahdEOzDQHDj27T?=
 =?us-ascii?Q?WK1q/YmlIOaIrA1gJnOVu4yfvV7BcvmDW43GTQ+rYDCXQu6GpXTg/zVrszzP?=
 =?us-ascii?Q?xySPb2YCFay1lXvXelsYLIzcTzE+mq3tk2RgJHjc9vIKV2NVI9tI6y/tIrrP?=
 =?us-ascii?Q?LsSFrhdYSTeyPV6hf2QwFpXVBnOcrMDtnIpQxbybmJ7op2KTGOrT/jzpH81P?=
 =?us-ascii?Q?v1NbOxuFSbrxFxugJ+tkumJM7UTrS1N2+stmGW21dZZiVuqXq3SHj8xj0T+d?=
 =?us-ascii?Q?ZwIfPbGUhVMYwSvJqHv/ZXTwCy0l4IHsKtt60cbaCJvUMql00IiFzrKZLtQs?=
 =?us-ascii?Q?FhN+I9TQuYA5GVcEpvi/kOcIiobbnyaVqHVqjdA3/lOrBLxg0PevpFN3WH5r?=
 =?us-ascii?Q?rDquVzyRlThaind3/up2kZ0h3bIlrv3Vp83SkgIVYmyyTgd4Gxk7ucbNriOj?=
 =?us-ascii?Q?YbL1O/5gH1ps0YOuGgrv2pKCTVqCIPqij3nZHQ+fyNr6Z3IpROvD+cdhrhlr?=
 =?us-ascii?Q?KJ/hRV2p2IUgktqREAk+Wq2jWEi0kqIW/4ET2/MSwJIB+ujfpOyrENNrplYs?=
 =?us-ascii?Q?CYfvIbCCj0vCOgJc3vtxQUIGGlSN58DX8cbjSfaHNdYpQ/gH0OQXP+btLcFg?=
 =?us-ascii?Q?kPS6ykLcupENz9lobE9U3Sw1OlorKSlsd5Y/O6qTCro5Y6yxO8x4lxNwXa4d?=
 =?us-ascii?Q?a64wnMRqM75+EE5FOKkox3k/shFQayCdohkajnGfLLZF5fp8TgduSBG1XeoS?=
 =?us-ascii?Q?vlD8h+cBOYu5o/PSrQ+gKyQRPyfiXE4bIMz/ldak6v4413r6q02GawacoKGz?=
 =?us-ascii?Q?U1B1Q8gY8/9v7+snv/6X1eshZa1H8TzgfRQYXydJ192BUoR+3dosfFR/hNrj?=
 =?us-ascii?Q?/RxhyxpfYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae53c1aa-a924-4998-7e32-08de6fb472d5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 12:43:14.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wB/9lIkrT94Nool13/r5olSPplFBwTEZGLKv8FbgPBOZz8U+DbYeOKj5dVTOFVU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

On Thu, Feb 19, 2026 at 10:34:55AM +0100, Lukas Wunner wrote:
> On Wed, Feb 18, 2026 at 08:56:14PM -0400, Jason Gunthorpe wrote:
> > And not sure we should be dumping any certs in sysfs if the plan for
> > the other stuff is netlink, it should be consistent I think.
> 
> It has turned out to be super convenient to expose the 8 slots with
> certificate chains in sysfs for direct examination with openssl and
> similar tools, without having to go through netlink.

Honestly, I'm reluctant to add permanent sysfs uAPI just for temporary
debugging. Put it in debugfs.

There should be a tool suite that runs on top of this stuff and
presents a sensible user experiance, with man pages and so on.

Having to find/remember some baroque openssl command line with a
million options is not reasonable for a production kind of
environment.

Jason
