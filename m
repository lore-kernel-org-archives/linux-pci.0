Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65733274FDC
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514078; cv=fail; b=oSwvR4V3z/Ovs3IlXXxktmsB+2wOruY9kivEXYWc/s9RGw/0jxuLxVbjU+qU0G/YB1wLFLXf5HKZxIpSMNiWdIqTLyAH7hzdl2F8iKMW11yGfMRgn23nPi+gvLibBtw3uPAYMxAylLqXHyCXYYX5iUOD+vVj4GoA9P/zr1MPvsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514078; c=relaxed/simple;
	bh=D5RR+YrrC6RBvEuMtHpBYCQiqL1huWNWfIZUaDVq/Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnBAwSkru38HATKxtuTo5JFMSiMN2axPr/5l2xv0boSBWuHr/RNFn0eaxVuKzT3bK8z/iy25z+1Ad+MLgzc0WEFYjqtdt75VTOOv1OMIiP5MaQwoSXFIhz22FFdoR3m+LcRI2hghnr2atJiNTQAPLqlx8w70GA4gWENAQHcC4EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=djwDTTd0; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="djwDTTd0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy4f+718eNOrOEStgbPK5Ry/v02ApHmjFtsmnQw4CpGxSgVLukBkxP2fUBomVtiQ0FkvTIA1DzJz7yA4zxfIiRrfBDoA4TpnYLz/8L5EqCCqnaxEIVV/PgpE/tulgKCrnfIJ4LMWtEPFqGBRPFz0TErUoknXRBTtg9GGHrs8tXYceaqbyw6L09KhNBs1+UfZSS34fGp8a1xMf108cWqRXfnjMJjQd4EzRGU/5DqUa69cqnmXD/a4qqeRxxe2m5p+p8rqN4cU0+PBijO3DgsZy7X/lBxWc0qM2kOBNuQL2GVja5d3cYpJU0xBj/FjV5iSgsvMZrrqMg6W7b+mgUJUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUvHL53Uuz+/KT0v3p28CcHmkS1DQsq+iGLFAhNk8cA=;
 b=gSJAYSgfCy6Ru13KAkm5CxhfLBHFxGuw69iHIBh3r4M5+oLLO4WX7+2hwWU+xt+H/r9P7hf+Q750SjAIl1vMCBthzKIbYJs86CjdsJJUq+CLJW81JdVB16JSD5jYbPtJzEI4C84Tbm23LDbREz5rzelXjEqwKArs+aXLy8v18ZdbD/07CVSCEz2dRSqn5ah1u30DvAn9PfdJ+Znn7Qoc68iXPKfZhpoRMkQcCmo2JbQX1dIK1aJN5JBZFKeOHCUQCpKGv0ZEYLYNWTbIpuwaBniDE9DKUnXyZwWHJCR4KXSwenD48XFDaT3MoyasemuGLrTbI+q4T0nr00KCqBRz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUvHL53Uuz+/KT0v3p28CcHmkS1DQsq+iGLFAhNk8cA=;
 b=djwDTTd0EPPEdX64G51dhQKL9Qkmv9tWceuFySYuTQOLdH9626xqO+1nFiXSdeMl6DRx8grRBPaP1eshlqwQ4SaXI4vQ0PCuVDTG1rrCtDh/oGJl3CrlKf7qAfI6nX4hJ6DyVJWu7+5yh2U/gBUpR6JODIVDS4/6rrjjjGk3XDLPBuKp8rpFV18+n3TqrlGgQNvNF3Ebttl6Oyd8skWxG2HoKg0QpqRRjUTFI8sIud++0wfnW1o0iv6a1f4aE1S1PUY1CM+WtnoZJbdp4hzKzqnnbCRhicbV1zcmKd+2s2uLsET/KXwa13KHeiIRk3W72WOE0eTIqmqxO6ykQH5eng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 22:21:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 22:21:13 +0000
Date: Mon, 6 Apr 2026 19:21:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260406222109.GQ310919@nvidia.com>
References: <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
 <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
X-ClientProxiedBy: SCVP298CA0007.CHLP298.PROD.OUTLOOK.COM
 (2603:10d6:300:14e::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 018dd386-f748-4caf-fc3a-08de942ad023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/JnirPQs8ivxvhCm1yXG6/Tbe0K08IvAUSclGNDTCPER86htsdA5lgJyqc8zfFNj5AiTyI6X45Sonn2Y0VZbL3HPRicQdOiLuq9tCykzvKyJxjhMMEkoQ/yDu0GJ/Egw+AaKj47O0p5kfJPtmQZ6oQKSFkyBbdqDRaW/22iscXW330OnNXt8pER+Mg/NsWysZ9kfd3VW+DNCV+WAJQyqR4FEsVzLYclXAraxePkZUd5cwx0c+WLvndEm2MymsgTOAWYJX4hPb8o5p6fjMjQck5D7Sjj0IIMpAWiMKHUEkN/cgNVRR2EbN3hlrhl8KmwVSLa14X/ldPIXKiK7bv0Ou+mkV/++JeldlG9lJ13bMBxK1QZ5eo+/SyQTsC50Ri/FlPjIBKwSRqtI0GH4qDeYiN7p9dV3zeCJp4308G7lJLEgGEDCuNZiL57CGfxeJktMv50nolEHvevMzC410snSPFobvSsKnz+cbvaTWJItZOI15XJf5BYIJ3ustQWHsv2vtEXSL1Gh+/ZdBw7aLiGwTZy3sEL/of/8YTsTYkxbjg/iVbtrTRT3LShqSMROYGKdSTVOzapGozKdUvo2VuEijWM+KYT0qGIpSdO1F+31//YjhnAvlUaVwe/Rzq2nnu32xOjI7YIdOTc9a02azusujyvZ36n4FVLwodq4Trs2R9Aw79tG5jOkp6irjYRany5Rt3T5tlXQMdXMNkLpRvx8DY1KeNPKzcHbukhFiG4yedM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/Vxsj6T7iLzZqiRFFtbkA5CEbvNJ+U/nM4qp72A4huht35eNNWUTsipK3S6?=
 =?us-ascii?Q?PRM1WWa8Md1v/w7X4Z0sS9Oc9vCbppi0iZC+QZTmm4IiPCKF3bViBYKcADiz?=
 =?us-ascii?Q?6jdXF8JKm8054GUf6M2z4afgXxsNM0ztaAZtT+CDMuzDmDdjw8mRUrVciX8H?=
 =?us-ascii?Q?xTG0yT2g3+pPOu138HbYEH8cPOIrMHtGIoo+/nubJqnMj+7uT2Wl83tpnBLm?=
 =?us-ascii?Q?eF4cyAPDk5gmxNeppYD5/4rdLIwBi8GYfS/C+bv7FwX+ooZKKwPyjmevaNHx?=
 =?us-ascii?Q?usznFO7wKahYR7Dx0njs16fyiehQuf0I+1gEG8NntPGMawown7cdzQf2d7hY?=
 =?us-ascii?Q?STny3e9Nzx7qhhkC9WH02rqTz5nKzI7iG+BZi9lNcijBayzU4H7Z0m65bHcb?=
 =?us-ascii?Q?IeNPlb5fOHR9eITHmZ7hN1QVA4BnD6TWj5urKMRyCilAiA12zP42KlZfw06S?=
 =?us-ascii?Q?qm9MfF8E4sXkubQa18P2Gyi5eL2nC6N7YhzM/fL9sepaWks8L0XWaU+xH6ff?=
 =?us-ascii?Q?ZRDzAKs6hV0QeTytz/ZbCiuvHNheyVm7RsNwL1LPQ/9HPg+LpH6ygF2DQJB4?=
 =?us-ascii?Q?wxiPhzKhME37BPeOZiNu7L0NJBAxOI0AAGzy1sXgOen6ra89ts0wOBir8fAD?=
 =?us-ascii?Q?OqwCbLjp4z+SQlLML/iRzMvfQ+DVsYEkJWb2EUKowAeiFBlRiowXj19O9cju?=
 =?us-ascii?Q?KCz1LQdsvpjcy6BVoyznVLPHNVsonO/JFTVazyO0rzN/As+SI/nKoYZaOL7Y?=
 =?us-ascii?Q?qlTMPMvZjmzhL2H/XoUiX1QlvQ4kGfpBVBlSk8T51Xg949GetvRMQOT/NY9Z?=
 =?us-ascii?Q?AtAxB7vKH/WdFmUFPDiNq0MKdaCRFReelCDxo9GMSJv1y+QVqt49OLMFjUnh?=
 =?us-ascii?Q?a7Mrk9Njcni66VLwp7uN2g5juPE7wDbeBlhQUk0rwhmS1EDbMcjVeJAJEcFj?=
 =?us-ascii?Q?f5NVkRhfKDUKrFpbDYDw72BOTuC6LbFGJmWldCEohEws0GbmuedKGvtB9Kud?=
 =?us-ascii?Q?fZUBYHZ2Txa3vjpVdO6O0pzSlWyaOkK8dLrV59MGYLpTJfstjwf1oPnjXkwl?=
 =?us-ascii?Q?wMdSXbiHk9zVwvuCZeI88tW2ZEb1JWDnH7Pw4b/NL+lFjV2hqjM2DhPvLELl?=
 =?us-ascii?Q?rdnzFFh7jbXnXSfKbpx+JyBZAZQEj3WHQ/tnwhQUOKtw8ZT+EKlLPMMI+zw5?=
 =?us-ascii?Q?VC1UjXK/sjIOAvQHOxQlDExPbneOFd6ErK0y1JkMHSeDnXQa8u1ebRJFcT/c?=
 =?us-ascii?Q?S45HyFZIZetCw/aSTNPKo24nI6XS027Fx4dDQ6vFtV1v5KDFaIW1AYIE0/xq?=
 =?us-ascii?Q?RyrRGykAxSUjDLBbghPptEvZGPMh7lTiszLk38Ym6gRaWlK8jJxKsOg5NLnF?=
 =?us-ascii?Q?9QVcEaLPDCbBykXwuZacavUgASlqdP3XV6ttJyjGSknwLjpERaT5FBn/2H+5?=
 =?us-ascii?Q?16KehtWPHx5AFwnNFYju/z4+Bos54zdsSIylIvQCa1zjNhC7mGdF0JuP84fw?=
 =?us-ascii?Q?zCZHY6J2WwCfys8qj59hyzOwZKRDeq6oaqe1nxYFhSR8HR+iAK2zWEhanlGK?=
 =?us-ascii?Q?Aa8wzJdR/g4HKTO8H+7holcehrfwgJixKBh8ismqZ//Jk9d/EHlxuciYjxBY?=
 =?us-ascii?Q?m9x9G59TnhhA0r/7lDGDth/Gx4NkJJ9Fp3ENy4SyJIJ5aAvcEo0MHkUS49OA?=
 =?us-ascii?Q?znwOSjhVBVLU/FLgbETpcy50zKVKlLF782OO5EREzJlBqNQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018dd386-f748-4caf-fc3a-08de942ad023
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 22:21:13.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY4vcNKp1G0YxvhO2eYZ85DdNsKxyNNlHuip2paWjNv9uedh90aK4QmstVQjmn3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

On Tue, Apr 07, 2026 at 08:08:51AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 4/4/26 01:08, Jason Gunthorpe wrote:
> > On Fri, Apr 03, 2026 at 11:41:25PM +1100, Alexey Kardashevskiy wrote:
> > > 
> > > 
> > > On 30/3/26 22:49, Jason Gunthorpe wrote:
> > > > On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:
> > > > 
> > > > > What do I miss? Thanks,
> > > > 
> > > > You can't tell where things start so there is no way to relate the
> > > > offsets to something the kernel can understand.
> > > 
> > > Reported ranges have BAR indexes and start addresses (with the
> > > reported MMIO offset added), and the first reported range starts at
> > > the first 4K of that BAR.
> > 
> > I was told this is not the case, the first reported range can start
> > anywhere in the BAR?
> 
> This is what I am trying to clarify - if all ranges must be reported
> (as some think this is what the PCIe spec says), then no, not
> anywhere.
> 
> pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
> 
> "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."

I think the argument was something like it didn't have to report
non-secure ranges? But I don't know, it was hashed out in some thread
for ARM and then I know our folks looked at it and nobody pushed back
to insist that every single byte of the BAR had to be covered by a
reported range.

I wouldn't take the sentance you quoted as confirmation, you need a
sentance that says every single byte of the BAR is covered by a single
reported range.

Jason
