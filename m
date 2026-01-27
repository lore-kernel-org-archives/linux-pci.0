Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D535C1BE;
	Tue, 27 Jan 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525352; cv=fail; b=MGgy4v4R33c4XoI+Q5GCjvOIm3c98vJuvSa53FW/g7+MhYhw3+gRuq5Q7fzm1ILcgqFHVRuujuGmIFt5Sp0sI3uFEok7D/ua5T2yKlDhD0BeOJ4S48W9qGmCHrBl+zIXeuTAinjIAnmrjskQ16K4XlsxnSmf3NJBe2kAZIaelr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525352; c=relaxed/simple;
	bh=YfJzSe3IXAuRIHgetbOgx6KG3izw51Q++3BVzVsuym4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f6qf8jhZBRMTbQjZESAM4vmNTLiOQRSohblQ3kDvp06tyA4On3GI3uceMkOZ3W5Fh56qSBSoMh4tz1oMRUE0xrvRT2d1ISZSaYbzsSWGqSps3Iu/XC/vACuR3F/KHonCtxwjuGitMq4KkCw6IKGmKh6Ak41XX9oy19OI6c1b6Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jHQCJatw; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHQCJatw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKFXQc+jT00WOYyGm/giMmcofvSYovvxPm9xc987vf987izPlxIWRBFYH1KtsTzhIT/GF4GQ2+GqFrcwTBkB0Ur+37ZzrKG31RaaR7RyNaC+fO2Wapure6OWHL7rSsNdzhAvHx1YRUTXBvv0M/8u3vFgIfUfdrzVDBXmGyBRk7ve060e/n9RmvFI5rmS/52qU7DJNBoTof9PxkBvbd+4+1fD+jib45udRLpsS32yxQePNfUgU4hE/1C9qLxK3soh2+lshonOwe5HcghUoAnSosDmI2ITbmQyl9vgnDJ1iZAxhrIG33fmFmFeDe/Do1XhcE2jkM8R3rvSIN19INC1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfJzSe3IXAuRIHgetbOgx6KG3izw51Q++3BVzVsuym4=;
 b=dp9OD8+2bueR1LG7Uhi8ZBZJhPvuNgRzGV73u5vBSDQtEbIp4CdNOy1QYqX3g/fGtZYTI5GoMMp2x6quynU/Qlv8/SqIFOm/Be30HSg1b5o/yfKW9ki1a6pF+O986/kaJ2pzEFAXh8hZj3V002iNafiCSFH2WIgMcTXg04ZOzd6i3sBDfS/dMGHa0kHFO9i2OQqSGQmAFIMIsOLu52VYtrwFCNoAXvVEeFw0PAbcwmR+5g9vy+PtXxnfmNm5/DfWCJvUGkyrFU9/c7fv7FSyP+RIgcv8z+zoEb17w/IK7Kv995FyiDcAHnNyM6xWjepZJXF8mL8FRxADsSwS0QRhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfJzSe3IXAuRIHgetbOgx6KG3izw51Q++3BVzVsuym4=;
 b=jHQCJatwCiITs3ddrKtA+hPvIEXb4Ck9w2xU0DMIsD4SYA8KbQqNnK9kedvgogY3r/RX1MK+me15icKDuHW0X42Lb40nhdB1ohdXuKcfXVt4VPPyQIUDAMaAADnod+aygC6QzvJyOUFEuOc6CLovKbYXNHnkPzDD2xsKbUTbZx+Vho6hqc4mFVdfToCQdx+DZOrr3ONBQVNisCjb/0O/C764yBHTD94r4m5C6AXlQbOniUOuaHYY2ZHDpBlSKXNjv/9d6Mql9TfpqCD3dbB4Ct08N6HkojTCarQdyqStgiZgp5qs3ziWhq6QetkeUfNHudA8LrdzbeZSaQmA/QToeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:49:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 14:49:05 +0000
Date: Tue, 27 Jan 2026 10:49:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260127144904.GE1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
 <20260126172020.GP1134360@nvidia.com>
 <0a60797a-fbb9-4a83-adc6-ad62baf5915b@arm.com>
 <20260126190935.GV1134360@nvidia.com>
 <aXi5W-7b2odQQtqy@willie-the-truck>
 <f08595ff-f36e-45cc-8ea2-dc678f59c7d9@arm.com>
 <aXjCvuBFCDBi7jUD@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjCvuBFCDBi7jUD@willie-the-truck>
X-ClientProxiedBy: BL1PR13CA0373.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 944eef36-93f0-4559-606e-08de5db337f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LunC0c80DZhSYpeSpTK5mGIoOHcBtbQrNbcu7RTRtQGshmwRBMbWYPLhWCbU?=
 =?us-ascii?Q?u2W+nfp1IGwwIh83+d5F1tXYkY3wzlWhnkprszafIVRFQuNX2kDxkC/z0Mym?=
 =?us-ascii?Q?8RbdiDsSiKM5ZjtpldD7f84fHnI374bLkVklwf6o1PNRxAGUNwytkcNp9o7k?=
 =?us-ascii?Q?J/iqgS4HTgcnxpLNru13Dd1q2ogPuaUzMa+0HCB1QlIIPKzhlbRwrQdGy8gc?=
 =?us-ascii?Q?ZzW9f8w/Zn15LSOnpG4LNgWH8NI0gVHsxpzbM8FvuBN1I4ddD5nyDQ8R/86L?=
 =?us-ascii?Q?b47O0Ms+7N3leuSUGm58yFgvWggF98jeVzMnvOkN3PaVOoy05+OFxTbwhukJ?=
 =?us-ascii?Q?hp/6swDY/3Zg9mfqSfe1IBW23rfflCeYOCJI5VYgYk048Ep5zyxQXCqw5nyJ?=
 =?us-ascii?Q?Ldhj0mn/sKPDwHyq2EfXu08SbuPWMUkk02cCL3mpeXoo4fDxjmQyN505dOLv?=
 =?us-ascii?Q?DaSLy/2erIG5jiBGLGY94OM62X2c/k32orpP3nWisyrIDLnTYYVASP6hTFbH?=
 =?us-ascii?Q?q2mBUw+G+PTmBNqSm/LNEp4IROgYj38F+YF0w1R9udY734lLpriHDZCau3RV?=
 =?us-ascii?Q?ANQFPf97fwDV7/786TaBI0bZjkC7tbTLPtM0VJ+mQ4Wuxb1BVYkDkbOTrNQB?=
 =?us-ascii?Q?ZpgrTVPnvEwmljVccQyRNQ85W0/43hUwwO0SYp/KAMvlz4pn2yIDw9yLP17T?=
 =?us-ascii?Q?CR4xkjcU8b6HqYqZDt/73aELwQpwdJSqrG7snXVRtpn/6FotCKc9AZ1HT2um?=
 =?us-ascii?Q?IdCdyxCPYCjXTVYcl3VuNs59gxGEjtnCyXFG+PWyMWR8VwZM5fWvYDxB0fL4?=
 =?us-ascii?Q?MrqiMuCQ/ft1UEDHATZUwvjgZHgFYSezepjvODCeP8xLGNp6BHO8uMggQbJx?=
 =?us-ascii?Q?G9xnTNjrOYug3xnH0MMdHOy3MVyDSAj4DFU69DVHDXGESKvu7aBYizanNMg7?=
 =?us-ascii?Q?unRsj4mBqT9TFk1weS1kYpC2T7SlaTST4YCoq4Y8ten7bD5UukhDU7NMaPuj?=
 =?us-ascii?Q?iO+2EzQWEWMFyM17mHsFuOUrGHFu6rzSDepiPUGYilWKOK5JCctzFYcoiyM7?=
 =?us-ascii?Q?cDFHlDpdVKrWRUM1q2zh2Gr5y4uUemMXZOldpv5BrEgWyW6dkoC943EmoTS3?=
 =?us-ascii?Q?XUCW7zAEOUoY6heOSVvA/s+mEJqEWAGFSd1YW7g95QAC0koIz0sUIiMMzyHl?=
 =?us-ascii?Q?+2P4MzTmsaWeh8BqCu9qHY6iDxHq+CCJGc8rAG0mmOWnMNz67yJUlVSRG4Wi?=
 =?us-ascii?Q?DMm/bfD4RvPrWWTtKENR2eKcD56sDWv4o6HnyED+Lg0wifnaxfGLi9mwz5WX?=
 =?us-ascii?Q?TWkXUubnEYW3fAWJDjjiZBFKoQAz8sHSmFqm9yvGIbKdsaPXXj3OYCO+Z+1j?=
 =?us-ascii?Q?fmD1jxJKfwlRTZTwkxq+26760i+00mc3+GpHPXuWNd+/tIA4LJqym310YdGU?=
 =?us-ascii?Q?osSi31EY531IxNsKpKu7/tehGb70n45DV+kj5pLxMZs9yamFvcRqHWdE8FIp?=
 =?us-ascii?Q?9yA2tdnLIocfjpvZrOLSViHEVRtNFuN9IE8cjGSwzwmDC2CegO6JihrnsMEv?=
 =?us-ascii?Q?8Pu4rEKOhwRzUm6i7Sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wD4iRyI0wivVdjUJIaEn+Oh6prgAuLd3qMsY4SECwSZ8Y+RRkFP+0aw+OYjK?=
 =?us-ascii?Q?w3TNJzwgQC0R6OqoJsSC+8LtDVrFIQL8f+CWO+hJnIOt69r2W9wrGaZ8WM2Q?=
 =?us-ascii?Q?AAwLJiO3K6x1npM/5tsEH3pk5hMVIGkjeqjf8JCsclUjex4zRWPDa3JvTEKN?=
 =?us-ascii?Q?rbMDwWMEEjirAgBKSFnb0Y1pioOPnxqUeyhTItlX6/hrcufkT8zF3MVmOqYW?=
 =?us-ascii?Q?iT1IPurP/PCuNF1cI9ojs6bdGIeJumqqPtgXHpuehsIQ0J9opkOd+QQpkyy7?=
 =?us-ascii?Q?kNpH/cmwrmIdYOxJMFS97GCFtTze0HU5n53f66MVNYs5BhT12HbRO1BxCYpU?=
 =?us-ascii?Q?JvZ2saI+mHf9qWiplRtW5UZYClFzcUaEO/SwDg+UZKVOMKAfECKRkyCW7/Rq?=
 =?us-ascii?Q?dqcFuq5GlD3X+0cZCHIv5zDMeUPlUBjuQGD7qnB94ju9C/siKnOKHHdPxfu7?=
 =?us-ascii?Q?aDq8ZrT5tdek/oqkHr1rzupIQDQwCaM5mvU/vQ1IllP1Pz5sWYGp6vwp1daF?=
 =?us-ascii?Q?zp7l//OeZnsmieg3Cg6qL56B983kHrktcuKCvubjF/ulZrHTy3Ro8R7Yf30D?=
 =?us-ascii?Q?Atla+4g3NNjriZQxYIbcDqQV6rNKfCBAWbPAhcere2vnrTa8e14u/ftJA2wW?=
 =?us-ascii?Q?0Udm05fsxQmNi5qM1sxdMEAQJAbfs6UyMRJ7bupPUQzkNAPFMsuNw79tIb3B?=
 =?us-ascii?Q?slVnPuKcPRQYSYFZXvC1iEe0Xk4bIqg9JoImq6J8FFcBQz8O00y7Ok+lA1uR?=
 =?us-ascii?Q?2sIjpnAI4Ao3Pal6zM41IEXiWroWe1OFjisbYFLnPbuI5SMlLZlgpHbWnyQQ?=
 =?us-ascii?Q?X6VJDg4YYRYbjYNeOA+G+oyN38deSxF+UPwlwy2v3IRXvFvSAjmuqQFLJz4w?=
 =?us-ascii?Q?1VqmUFCycVrFi8rxZGQjKnCHS5p/xyZV+FlM/kQQzTcZzxihseYFcsWq1661?=
 =?us-ascii?Q?9SyPipI5vchX3kYPeHY5bRtgXsts32h1E0SVwGc+aJpA4Imac3wzfytindDJ?=
 =?us-ascii?Q?K6r4el5dj1rh9eTbFE2fNAroNJUa5euNbbLDBEigVRubyTushOOl6edcFhUK?=
 =?us-ascii?Q?mYCXyZYtccklJqb3sn1sqb5JzLdXy/qJl9LHnZf69aNkENxkKo5qS8hbZGkO?=
 =?us-ascii?Q?tLN2NnbYta0w5JZlGhfD4yxFsFYIWSVaxcJk+DEzVFsboCaoI5TUT2550FZ/?=
 =?us-ascii?Q?g22wLZV9thZkh6a/YZ7MhS5gruKyA1EqPnjFQZa/frTAaEH2faKvWUFkkHjt?=
 =?us-ascii?Q?XFWvqPK8MVWYh3y1oZrNTpcfpQR8wa8bdddYTe5P+nx+j0ZdDFxmeRX2GY4z?=
 =?us-ascii?Q?rbKNU2mG8jMk3ouMUjdTMqUSU9y2ito8iC3m1onKupXW+Pxrs68eytKcZ94+?=
 =?us-ascii?Q?tn2yubaPxMVGptAwYgjDdiudlJ6oUiuGbDZWwgwADK0I9tduRCNr1AdzbPUI?=
 =?us-ascii?Q?Mp8iBOf4gB4YTv6bBCApMb6UdCdH0cWhmXJ9gkq73L8aCgV/FT01qqvtxWLi?=
 =?us-ascii?Q?VUPbbrWkYWdqKp61J8grEjBh+mE3dkmlet1EEZVkhUFVey8WL3dYjh93p4lF?=
 =?us-ascii?Q?/OIJIa2ce+UVq46yI1mMty7F1NIm6kdR7TU5qrPhyiEFFd1RhIziDXSaumWF?=
 =?us-ascii?Q?R04bp41I6lSutAxQBJmmmgZra0/Fw5Y4t0/TA3yW8mdXUbEu4XnekU1zpPId?=
 =?us-ascii?Q?2SOxUIJG+cvgLsVqwRZsiOB8vHYzaUeHiIDWOlSSrj+Ye2nKDVZC1UcbIsjb?=
 =?us-ascii?Q?qFYt+YvdjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944eef36-93f0-4559-606e-08de5db337f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:49:05.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOOrRPOAE3YAo2hHxfnnUYbcockIkO0yXuSA4rqfC6Yba2EaFbsmITTSCZakAB4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

On Tue, Jan 27, 2026 at 01:50:54PM +0000, Will Deacon wrote:
> Argh, I had conflated a transaction using SSID 0 vs a transaction
> without a substream at all. So I think this makes sense now...

Yeah, it is bit subtle, but as a SW choice the iommu subsystem
reserves PASID 0/SSID 0 as the "untagged" translation.

Several HW's force this in their implementation (ie AMD)

ARM however includes a "Substream Valid" in the input bus. Linux
doesn't use the combination "Substream Valid, SSID=0", that should
never occur.

If it wrongly does happen then IDENTITY will generate a fault, either
C_BAD_CD (due to it being non-valid) or C_BAD_SUBSTREAMID (due to
S1CDMax disabling substreams).

While PAGING will either fault with C_BAD_SUBSTREAMID (S2 paging
domain) or success when S1DSS=b10.

Jason
