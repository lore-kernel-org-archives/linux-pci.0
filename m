Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02E38B7B0;
	Mon,  1 Jun 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346515; cv=fail; b=qKF+rCcNQEQ5dsMzR0RNiCMFGgc4Vd4tQe9Yxn/Z8txVE/qfsBERAD/DBz7FJ17qZNlkEAXOLhuGr3ZQ48bihSuoaKqteV09yaRxH+ZPz0GySXilPE1HYO4dyGxGqsP9m69anLt6rMtdKND3jYusnGT2Q205qBYLMpAEyPnY/Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346515; c=relaxed/simple;
	bh=9uqS1Yu/M/NrBZldnhHpnTZ0/czW1Ptg9kzd1z0qLVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz22pNYYTa8c/ru+2EzVQhS7Egn4P9O46Rnn02bhIoO7ZC+8E42ob40M7p25mVAJCmUZE3tPVY4Pnx+/Yt/OGKeYWJyCOP9E8ybgIPUeDONT41suBi7o7xJNNrxgqY8PPjm0AVJx/R+f04P9ppCn+TITDixEVW9/z/Bpm3muF1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3gwUh14; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3gwUh14"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+eZXHnkO5BM0Nj5jqGB3Oa0SVrLe1gtRHOhUV8ViIY+1UCAXJQ30MpG3t6BqCjtIdUkAXLEvQMXmMa50x6OKifxhHLQTidY/mmdCFWIm+mQvc4r6+iQMKahQev7GZxBw9iiYX9//0NkdTVEX0jhfeb5qcOGJNPH8S7oCu1lQT8YTtfLvNJNi1yF7iwN61nKLZd1VjsYymqCtlDEzCPu88VGjU7P1MauirK0HE/qM4JV98Z9KZHFYy2Gl+1QTroaOenlcehTAOztS7gSnd+Rt2sHHW5rgxmhliaiV//eGPeZU6COaIPMCD0UbRFHvZEROq6x7F6+C0F+/T8VVFThhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhhQPo9WaG/eRD41i9XfcotKeo93onOvLDFWGFFbTxw=;
 b=bbu7xMqOfAJM5AMk7/o/u7o6J+CsovXELDXQsnHCtyT9BBkPVXPbeFF7D1B2GPbJw3ee1VTtHDL4TiX8WglTiTmy8D+7n3GQ8kfW8a5deVpvE8bXyTXdSLebbVGtgAKJvn80yQ/SSUlKSJTXMpF47K9cTmHmcFB1mF4MWGD7Y70IDMxy9lmHztS4NPaTEW1Ky1rEOFqjyABUAJFKv0J+WjVNittrBkMVaENxSrcJk/GH8kt3Eku4DWOYcdrJoY/LLNwdm5L6RpcTfxaXeW7S5L5VwGAawLv6EtH6WjElH65Y5NQ9tc11yUvCWLDxyEmpljUg0yk1+z+oa6qOnC7aGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhhQPo9WaG/eRD41i9XfcotKeo93onOvLDFWGFFbTxw=;
 b=M3gwUh14tirvErHGkoVOkxMrb/CIRIlKpxsK2lTO6pkt1zOrkHv/kMIg83lEZKGtPInkdxJrvhbAAnLJiCU5pk8CQby1iBnLM+HFaYYoCZj/HC1RLPuV6ZXt1hLt2tzmjD9xAja+6WSSbv4UgfBfEaYDbzTH4ts1z65t6C4bwOxbpAr/11QmaVkFzH5l6CBG3IhKHBlJ6/svjQSaiONkoSNSr7941gu5QCuH54QDGUcVw1s/+csTtq8zKfx10IxtU/i6w516mO+seyCO4SVX1W6LhcQAc+YH9Mwb3zZfktKEFSJfuuiGlASxNI0G0u3zVokb3poIBAyo9uv519dj1g==
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Mon, 1 Jun 2026
 20:41:45 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 20:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:41:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:41:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 13:41:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:41:28 -0700
Date: Mon, 1 Jun 2026 13:41:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <ah3udmX5SIO9lAXR@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601123231.GG3195266@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df27cc5-5664-4047-3334-08dec01e3249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oyVtYcm0saEqQf0KI05gxYAr+x8+ufAN2Bf6EJ9FTlHykyZ7uiCx3rUUW4O4XjdZraWR45jriihk1tVl/OntlPAIr7LdV0xS/apKKqKBQu3yKuUuvO4IEupJwYh7Lz2gWEVNGNdNimzbae22re0ugjCibKdnMIpF9ftY8jJmrtTUMp1IoHM6rDzEyhuVIeRk/DRQKBfz5/DoJsY/niRmXjFmzNH3w+ofWXUMsy+YlIWvmg/IbFEsH0R4CpgKUE1I0H62YiKOnI7BLfuMMRBHN2Ntfs905D3STeHSH+VOq+lEGRcVykjV7SrEdGfmgBjE+QMsgyOKTh/L7zopsAYVsSgSZZs3nVrd6ZTVeDtOfJF4g9L5SkV9fBIa8a0vxbfbS2hAIPv9ydNkYnFdCKFvvbfQjMc7xnd/42zUNRQ8M5N0Fat8CTFRo4xCvNl/rFWUgGUATcMIxCS5p5FR+G6MG2XEkJAKU/eO3AZOo9K1HFaRH6hykCbM185J8KRkSOPOgonYAcOHDl9qh5drqqNGMx7TyFBQN0F3dFQnO8Ngz6JXc3e25o49iQifeaUg7OCb+oz3BbF+SY8eYuu9htBJRcoEqktqWJRP89r+QUPktgSbukYArRk7xnYt6mIm/YflsuDsnfE3OrHGCXoxNwWW+r5anChBsNcNvAuMSjnA9aaTVHRiymPPUs6X4TxQ75hQz7luO/vZvxRyml3amDAN3wwjMHf4w3Rr8oAArdiSydI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	icSMcEJOV7TMcyg+j+xK5572Pab56HU5ni5AAima9lGnAP4F+w0yF3rNOyagX/TGKzieCixngrA8rqrEqVJ4/0euMPSr6t9aUj87A/8FAE5OQiuq+srdU5HvQPLckx1Q6uGcikTl+Ec2Ls79zjBiIvN2ZV2gby2TIorwaiu0+wYBM7BZGM0og5ezZXFqqpuw28yXPSSVWy1foqt/Q5s3v3A5BC7jQMPZi4ri5WikkAHSeL2W5lTeblbkAsGBDlwfhGFPok/FjsVQNpxWDWYJOgrVgRsvCLo3XqkiIvrSidL5ijbTzTaL9Or+HTfEoSzera1/Zs0qx10yOoc7e80R/G3jGL0y1V+uGgipWGolHuyfKT9g3oSRs8OZuT7KO6MFY+L/mDgohldwdZeK2lWo0c/uBZMF9XM9Avqw0oHLbN6eFyle7m3F3mvDDmx0lW+l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:41:45.6922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df27cc5-5664-4047-3334-08dec01e3249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

On Mon, Jun 01, 2026 at 09:32:31AM -0300, Jason Gunthorpe wrote:
> On Fri, May 29, 2026 at 06:27:40PM -0700, Nicolin Chen wrote:
> > On Tue, May 19, 2026 at 09:06:58AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:
> > So I've tried INV_TYPE_ATS_BROKEN: during per-domain invalidation,
> > each batch is built from domain->invs so it can carry the "invs";
> > if the batch times out, we can immediately mutate its ATS entries.
> > 
> > But I realized a limitation. E.g., if a device attaches to two SVA
> > domains on two SSIDs. An invalidation timing out on one of the SVA
> > domains could mark INV_TYPE_ATS_BROKEN in its own invs, but not in
> > the other SVA domain's invs?
> 
> You'd have to mark all the S1's sharing the STE.

That would be a bit convoluted as we would have to go through all
other domains' invs arrays.

A master (that timed out an ATC_INV) might be attached to multiple
domains (RID, SVA1, SVA2, ...). Also, we currently don't have any
per-master reverse-tracking to its attached domains (master_domain
is added to smmu_domain->devices list only for now).

So, two things would be needed on top of what we currently have.

Firstly, we would need another per-master list tracking all the
attached smmu_domains. Maybe reuse master_domain? Let's call this
master->master_domains for now.

Secondly, locking. We have two paths that can trigger an ATC_INV
timeout: __arm_smmu_domain_inv_range() that takes the rwlock read
on the current smmu_domain->invs; arm_smmu_atc_inv_master() that
doesn't take any rwlock. When these two paths walk through the
master->master_domains, we would need to take different rwlocks
for those domains. Also, the __arm_smmu_domain_inv_range() path
should skip the invs on the current master_domain, as the rwlock
is already held.

I wonder what's your opinion about these?

Given all this complexity, I started to wonder if we could have
implemented the invs as an RCU-list than an RCU-array: all IOTLB
tag nodes would be still allocated to add/delete/read locklessly;
all ATS nodes would be fixed in the master structure to add/del/
read with the rwlock. Then, a timeout occurring to either path
can simply mutate the ATS entries on the master directly without
going through the list of domains.

> > So, it seems that master->ats_broken is still a cleaner solution?
> 
> I don't want the invs code touching master, that is against the entire
> design.

I think I can understand the idea here: we want the invs design to
be in the common code, so anything that's driver-specific (smmu or
master) shouldn't be touched.

> Maybe a flag in the invs list itself is sufficient.

I think we would have to use INV_TYPE_ATS_BROKEN than a per-invs
flag: e.g., a nesting parent domain will have multiple ATS devices
so it cannot use one flag on its big invs to separate the broken
devices from all other healthy devices.

Nicolin
