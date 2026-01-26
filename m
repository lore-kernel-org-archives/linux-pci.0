Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0F27B32C;
	Mon, 26 Jan 2026 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455032; cv=fail; b=KzKVJTMlPZvfW0mlqiTmaO88U3lzU0dFkoRkQm6H5q9LvcYznV6oV5SRVvUN8l57TEqGRD8CS0aLmJjXmO38lijZ032jGl+1e1tjMDvwyeIfdIcqW5pUJOpEKs57tWE82rM1/txiHervfdjvKuRGWEvKzhrKgFW0D9a3Uh8nKik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455032; c=relaxed/simple;
	bh=VZv3V96Gk9JBLjtG5pymLrm3g17D31jfFNq4jbgev+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgLAWkvY349aEotPaS9G/Sa2icCUUMTQQ26y4DEyO+bKIKoO9iwrwHuLsIVO+bO7y+zUz/4o8i7L+IrOL3uyvvLyhlkxTkjRuc6ICHhAdCDUt7+vB+Wpf0Fsm3SzaYzZrbghY/l2VGkqrH/Ob9TFOh/EyESbCj11Ez+Esdff5Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GoHiioK2; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GoHiioK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sautmyPEFi4qPDPGd9H/Yss+2B2pdPI0BGws/vjCowNU64TTS2SP3NPVK07sIdnWfh2vJwlxhWd0Dy1JQeQ7aqWaRKq142n93V2i5zF5Ck2QHCPbyVZtxQ2Ow465xJ3u7HEzF+5BFnbNSWmKYskPLZMHQSQWPKTVB9EizRmUbloXTzX6VMl92E7h/QzVhH/LtmqMOBYAx67QKF/OVg5kNKt5Yh7wtfL8ARxGGhX6AALy3sKHvNd9/SVE/zdtGgOJwLm1rA3M+NZJ7QClItoWiLMBFw0/BGaLJrGZb4k6oQpuTt+fkU6CdfHZY8rVmiaNLF4iv/+MOqRBe9OpAVkBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkp3+pkFkXk2l6TyvhRc3pdtlKU4uiQfBDSsKCqWdFY=;
 b=Pq7qKtQBuEeru32XBfXREIUFILwH0U10MAkkI0lNgvitPbnm/FybisFGVC2IMyDxB0wP+3WzNUtTAj967DiX7nGMheGL0PTxZsJbhZVGQwC7EHkobFS2bux6XvHJrytmhNmzYuRLDka+X1HV/qqkA/JdzRfUulKWP6F8Q2qPXJE/QEO618Pcr0yWNXDycoJF1rLI6fdxl8B4uqi9zH8bJMbdAkxFrwouVG+KlxUAItBGCduxzTClVrBRcXfIoKdfYoJpntN6echCBPmOlJ4S4DfRHLEn2ypXMGuB3jBkiDSYltmQbDaWY7S9Lion3mVRXfJGmPwxLVQBapjg5je4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkp3+pkFkXk2l6TyvhRc3pdtlKU4uiQfBDSsKCqWdFY=;
 b=GoHiioK2vqlDUocsnIjyY7I7Z0NI60uPh3qRzur21smrGozv4lNf7eGAATdTOhu5er/v/ZBWFQeNY1JZGXpvMPJY/JTsQs9/XawttGGhhHxFX5rqLSBg8vcdju/1yShgXNl8XXVWuKKWLRKlKUNIW/a0w33gR64/5fNPwyZKA4wNIo8qSeKa6KBFGqLYgIScSVZj0tqRmEof93+eApL2Hf8iGNIcy4H3lWfjd76T/UhqdaLs9Jg4OIwX16fAeAZmJkoA3b1XJJgkQL02V8byoq/mffha0gqCZnGjvBvrxgn2Q1O1Ch9xXNoMZ/sFsZ6gBppSqB4dyPzVzeyZ1J76VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 19:16:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 19:16:58 +0000
Date: Mon, 26 Jan 2026 15:16:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, robin.murphy@arm.com,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260126191657.GW1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <09cb6be1f8f7472a2f1ccab72154cc6e22cf570b.1768624181.git.nicolinc@nvidia.com>
 <aXdgljWHHPVMTmya@willie-the-truck>
 <20260126172020.GP1134360@nvidia.com>
 <aXe1J6Rygrvoz/Wo@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXe1J6Rygrvoz/Wo@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:52d::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: cad5269e-05be-4366-b35b-08de5d0f7996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0Mw/OoL+GhKEQCAGxRBB+bO7O2rOuXSSNTwSC0pITa8M/e/q6+uDNGGWcMF?=
 =?us-ascii?Q?APjizeq2z2c20aIh0wxejLVYaGenmA9rsqC387rF9t0L/MLpdFmxQEjDhusb?=
 =?us-ascii?Q?038SselZhSLIGsQGArmEJaldhSDvTBk6p/x8wt+ony/aSzz/XFr1f9COW72J?=
 =?us-ascii?Q?E254u/UkotVjPyBCe+4OlaVUclllQC2g+JrXoR2VYOBKVMTk37wxsy0Pyryj?=
 =?us-ascii?Q?o3Di6eiw9h1EnQTnBdA9qXtSh9r79BDCW4EIUnrQ8TVkYuIvDPQ9GNKFZ9AF?=
 =?us-ascii?Q?YAr0su2Ru+iU7xYjbWdCOUG+IcpvnN5z0MXTno49EUypE2wL0fTn8j3UC/Mu?=
 =?us-ascii?Q?395hZ3oJoH1z85zGFpHhqCdfp8RaSLlqNfjPudkgvFaP+DmTMZA3FYxtJoif?=
 =?us-ascii?Q?oTNm4nD7uQdDhVX8F3AQrYcjpkhOZVryNl6XduokcfYrnkLPan+tiAgxc9Tk?=
 =?us-ascii?Q?PU4VM5TVN0Gb8vGK6uKMAdG9NrUw8SYtJPyGjsDMCIe6phq1yamuEDq+fip+?=
 =?us-ascii?Q?ooRgfCQT0XzG4NOuwGQNhEP1Yi9NLzLHZQPA7Khw0afBL5+duzKCQJ+t25Nd?=
 =?us-ascii?Q?DfKCx3NEbTNUUCAQUhrXmHIig10Wc/UZ2QL0CMoYcOkpIqqU7cbxn41YKxFN?=
 =?us-ascii?Q?bF6Wpkdq/IHh17FpMCPpeIQlQDA1+b8QdvykmY7HICxcd+4jXW5Wvbpx/fKb?=
 =?us-ascii?Q?MOjtQIOaKKRWxsppjKClw8obuppSrncHyN/QfI+nOng85zBZFmJcbTdLR7gE?=
 =?us-ascii?Q?L8ILzC1ScsWWj/y3QNHHXxofJQ1kHEaQ2fChwBiGrzxAmPN+gjvblpFav8Ez?=
 =?us-ascii?Q?AS5x3J/LVLn+0AFgZPiymlfEtQFQoBPUKL73B0gwj7ufcxNJCpUfxlGckIiE?=
 =?us-ascii?Q?rFc3BYJvkUPT1MikmaJOoJu7TkUxEclNRiYxacobswanG6uacer7zmcLph6c?=
 =?us-ascii?Q?PFQbrsm3i4WOlr0fmaM5MwTdYO83TiKjSMTFscBOWFSZdonjQZ2LisCBOMt/?=
 =?us-ascii?Q?PBHY7VtNtL5qaSB26k4Io3QlmDfpYomrXxf6eYA6hqXd0aK+ZDm3EEqKydPS?=
 =?us-ascii?Q?9EqfsTK+CYs/hX+N3PjPt+HOf6f9eIsJOo23Y7vZgtoYRgm5PEZ0FU6YnSEP?=
 =?us-ascii?Q?eGwfSJBKHn1hPJiSHtxFDh5jBpBQ0YBP3E3oKl1FOC0b1lxvjKDlKwh/QIi5?=
 =?us-ascii?Q?ZoM0jRwLiEvM2iuIzq9sEHDcn0yIfUhXiTeQRLUagLF4tA9/73gE0lSm6iH+?=
 =?us-ascii?Q?1ttBiCIdfL3YUdBK1dYRQ95BVS4OJRRtuZMRHNT20QofH72yfdemDUmbsKY6?=
 =?us-ascii?Q?seSlsl4RWX4Bee3dIetCiwxwlkzsw3XUKg6NkpH3v5dfp0L5p2x3Nh9GKC7h?=
 =?us-ascii?Q?mvI+wokl6R1uFaRySNN8fVDag7E/CUBTmY15The0iHeERXF4yJ17EVJ1MxPP?=
 =?us-ascii?Q?f9FkssJRhbGlx1hBZ5KvNNvRP8Tj/Cz1OsMrt3fHqg3vzqv81qON5+g2H6yz?=
 =?us-ascii?Q?LQpdOGmhJw+JAwiyplEY+fBR1sZb+pqvtX2jEFISbhFPoKpdXlGUcMm5IjWU?=
 =?us-ascii?Q?1kt6iRpF0nHVW3HtPgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OpcKP51e3mVuo7rijhkCGqERXaeJ6k2HkXgsXZjcaS5YCF6krybDvo8yX+My?=
 =?us-ascii?Q?GSceQQ531XPQut0V1/c1xbGVc4ad9+wQGzT7X9zMOI0lS8sPWBi1SdEjh6Vz?=
 =?us-ascii?Q?8y+KLZxsNDJZ6hHw+xywd0qlndTzvbZbQHpFWxT6WQBZEu7jzvDl3j33LBK8?=
 =?us-ascii?Q?dbTli7dPm4nnOxvjwz4D6VN7G0oAvrSCqfFDyxczeDOcdHOhgVuIJscw8NXR?=
 =?us-ascii?Q?+5o6lEMc8baaalhKZJT/P9+QbyKJ5ye3YhZ/4hk1TXZvxvA/TH+Bo/pcqS0n?=
 =?us-ascii?Q?H9WrQ/CLiDhpoFHlxdbnnmol4Tim+SDstLcow9w1CYb9MIcCFE8/9655fCsh?=
 =?us-ascii?Q?uiFxfbokzH/m4x2UCz7mQ5COySIJPATD6ibqz33+gXd3GwlVgztc/fQtaaqM?=
 =?us-ascii?Q?qlgBcNM//cak5S69WxL2P2EJUhfHFRrDD5EwjsX4zP1up4z42JLD2XDB3CFi?=
 =?us-ascii?Q?4Pi9fOnY/8YNloyRhjv94G0U6qXNhZXjwijR16Ic7Ka11cArn1v4G9A6yDip?=
 =?us-ascii?Q?DMMw4ANnUaVAt+r2uObGULTznaceWUyt0Gi0pPO5ZzzXV+Fd96N6oChbLjNA?=
 =?us-ascii?Q?4OfBwgAIaVF6occ3YvJbqFVA2Bn88Yt6L/eJqvT5YJjIzf1dAoBvZNOeHfQW?=
 =?us-ascii?Q?iQu+ykT4rJAsdTiXQdgwvuPcr6Lt7q1JMRbV07eCOuqZ4Qpylb5N7fUrAB5p?=
 =?us-ascii?Q?bc5BIT294wwjhZuG+AioIV7GqlFwqFKvGdFGX7RWPzY1VQLuGN3pojwTrvjG?=
 =?us-ascii?Q?ux+7MbJwEtt5XmQ5cUbyBzv//ikgJ81Bs9PLCl4vu30dcz39uI5twOuPlpSb?=
 =?us-ascii?Q?4XSFngXf/V/tkI1mlTzG5lXFbSSNgBeB1Wp/bW+sdbZ0P2MkDfGEWTpLnewC?=
 =?us-ascii?Q?t6TSUiPCrVK90tDpKGa5/u3x68dgm6AAm5gwHjFun4j2utLAbOuixNNGBTzb?=
 =?us-ascii?Q?Q84fZN5d2jaKlbw6t51a4iUKzwKjFfsz9zaORF4p2IPpBCsanYCH2EqHZ+4v?=
 =?us-ascii?Q?Bx1yESSrqcg06sThpCg3gNKOxXEmRvW1H068yQgHLF06QQNEbSJcrCtvVzEH?=
 =?us-ascii?Q?sLjqztLYSf6j59rpW1SwSAmfI4YBofcUJlTQduY8UxrFYOSQckBLiTPIEfPu?=
 =?us-ascii?Q?nLR2t+kNkkQ3vfNZmuS+Vco/A7BNMoIDbsWKQUjCiHYjpAxP6ZqvfaIVlvpO?=
 =?us-ascii?Q?ohiZp9PqSv7DQwMJjg2Q6yUwMvAyRUfkKZOX/+Dn0ZhoSiB7lA1yWVl9g0iI?=
 =?us-ascii?Q?5Bf+md+iHYnIBiDegz04FMoy4Ni/Wq6z9N5rxGbsY7lRCRhVUKqgz/VI+zbX?=
 =?us-ascii?Q?/xE8aHHnO58/125nH4cp6ivInaCFAIWUV4EMZrtLqFpzGfA3kLwehgGmSP6V?=
 =?us-ascii?Q?A3ermqGrIMEe/I/bVrAN9BKVt4dv+E0WSgwy1PuCSJV1ew39EKXy5N6gBBZQ?=
 =?us-ascii?Q?bbeg/AwYw/iI/y+vfPaXqz5de7FQxcMOVTPoMrhpbdc7rLI+QwrNOmi4qqfG?=
 =?us-ascii?Q?ijz9BklLZQDCBwfaIbzM8+tRakEdgBrLfdfGV4zl+VPGe1mASor27q1Qz0wH?=
 =?us-ascii?Q?NdoJ4EYA9+Mz+qK1qIhMZJbQIwPEA/OubJMLzlaqPT5tLaUteWSNGeOREN+5?=
 =?us-ascii?Q?apqRChv59k240Nuwq8N78kcIcVdaA7yt74eZmulEfhQ5hPV4BsTayJLZm3Z7?=
 =?us-ascii?Q?h76erS6h6o3hSCG36C+AOd+uV/3vZMmvHqwFlVqNd8bjG18EUEHBFpBl3bOd?=
 =?us-ascii?Q?ZYdnR30t7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad5269e-05be-4366-b35b-08de5d0f7996
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 19:16:58.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NmpmP2ZoWV14vdBfq8Duu29BOrFHU7efD/PxLusetUVyj4F0EdsvE7H4CuyQWVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

On Mon, Jan 26, 2026 at 10:40:39AM -0800, Nicolin Chen wrote:
> On Mon, Jan 26, 2026 at 01:20:20PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 26, 2026 at 12:39:50PM +0000, Will Deacon wrote:
> > > > +	ret = arm_smmu_alloc_cd_tables(master);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Were do you allocate the second level entry for ssid 0 if we're using
> > > 2-level cd tables?
> > 
> > I don't think we need to. The entire design here has a non-valid CD entry
> > for SSID 0.
> 
> Hmm, whether we allocate a 2-level cd table would actually depend on
> the "1 << cd_table->s1cdmax" v.s. CTXDESC_L2_ENTRIES, right?
> 
> If the device supports PASID and s1cdmax is large, we should prepare
> a 2-level cd tables, even if only SSID0 is used at this moment since
> we have to support !0 pasids via potential SVA domains.
> 
> In all Other cases, we would prepare a linear one.

Yes, this is what arm_smmu_alloc_cd_tables() is doing.

I think will was questioning if this needs to be
arm_smmu_alloc_cd_ptr(master, 0);

To ensure there is some memory under the SSID=0 case, but it seems we
don't need that.

Jason
