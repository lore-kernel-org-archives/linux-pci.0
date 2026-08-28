Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020E202C29;
	Fri, 28 Aug 2026 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888886; cv=fail; b=NPhad9sK8ZHYuQwja//rlt5UNIxXn9AJGc2qLw2jdeuzdpCra2qFM0sD+JcGDCzaemjDsyvMkf4laYd7S/WJcNGucRJEUaANt2wYHZal9tF14yOtnhgmB4118/Rbc7wDa3pETvVZHlHTznlQKlVIJuSx0A/YYO6NqvflsNDK2JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888886; c=relaxed/simple;
	bh=YDajpILVVrRRmwinTLq2RSg2hNAiHnmET5kLsJCEIV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEDk0SWq8jWyIMX0NZ4MFseAwhQocyfhDm1IOpezzCk7AA0y7kDtFGkKUopnU/B5z8IgizKsCkV0kS6IJgQpGZIBy1pbkj5aR0V/1ZpV8UizGMvdeoVWt0xICERcviMucERC+a31DWZmBbMdyip3aERGby+37NvcdioR7nKGoOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SsrkGBcS; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SsrkGBcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2nOEzwEKEOAvmh9EdLbEkqZVqkrd8LZRK1NHFS7vQdU+8Tr5Re7nefftLlG4vSrOzBISywNpvYm+WfNCz36ciaEYTlQ0qsa2HThIzNW0VG9sQH0LSia7x/kVXEd4azSUBtyYxuCA1P7u8Reym4S3TvraENcS8ifYzjKD57+jakVrzzOfgEh8idEM4+YROC0BHvIeJegSiubgbPZ7LtQmCgHobqq2OTUeqOThGDgBoQr8JRnubA9p00oH1oftrAkQ5/Ep9HcHRyjd/hYdDRfmWvd7F6xmyYMoPJ/BVbCNuSMRndORnV/XhaN9CUM4dDTukVrl42N81b3qyM7XkDhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzDxzgjF04gEqcK54FJQzoNjJ4TyJh1XxmSA7FQF4Rc=;
 b=h8zNzYHd0pErqgTjp/nIox3IxcJrfU4hr7cQSnfMt875/VzbNDDqd1scfRHunzvc2wET/Kgs66ifDjZAyawVBVKjlb8PBvqsRNCSGUf4uE5b10e0GtZUr/Ua7V51oSRr47Z02+YPjploZna40P5yecThQlCQAgTwQlmVxi4DpuGSOCfBuG2BfQOj+rRye6Hf+hh2ZRgB+YllA8q4qaYn2/xjJA0lfwYHAaW9P9R/yP43ksPUQgGU4FcM3r+Z19PUA2Y8pfyMcTmBOSmVKY8Jcl1Okg4UGCOMCcsHYa14cFenjSksXkYz0R31fq0Hn+U3DyN0f6YuKaStXddG60yAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzDxzgjF04gEqcK54FJQzoNjJ4TyJh1XxmSA7FQF4Rc=;
 b=SsrkGBcSdrZZK2w+nWsJC3c7oVfcmc+DKuTA4knZCgvtGuaaq5YwAzDRm4FeLLlRXM+3M0unEleKA+W6cwuMPvf68laDwj1OADoUbu4LKqGMt0EC+OBc22nUk8DN9jHo79ZquDjrjtFg5TPYm726okK/mOdmAjZXBKJG4QdY3LD0HC6CELrl8T3EsVqeB/EWWwf39DElmXmRcUkzc3S0wohD1vbGRKyVpTQFuTxlJ6f4QfI3mjmY8oBklOh+VRIjR0333+sn7lK9/nPAImWCwhmGLJjZRBFwnYm43/57ryof/82rkIhq+zsEC1dgITMYacL7NqOdqYf/vsW0WqqqZA==
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:47:56 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::af) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Fri, 28
 Aug 2026 03:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 03:47:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 20:47:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 20:47:42 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 27 Aug 2026 20:47:41 -0700
Date: Thu, 27 Aug 2026 20:47:41 -0700
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
Subject: Re: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <apEE3RDpSVNECSoX@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.5968833634148757858.b4-review@b4>
 <apCiweYENYZcBYiV@nvidia.com>
 <20260828000051.GA3922654@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828000051.GA3922654@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb2dfd0-d43b-41e3-dd6b-08df04b722f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rh7U7AHAZBaUSVIMTBh5s38OayhzJDg9SWXtSe9J+un+Y95aMNs8MZAESjBpb6+0BwBOCwULo+l+sdwqZu/1p3pQWM1bVshdKqOZFQlL7qfFMCOCXQF1PqY7rYmRtESesQKTruKgZ/BaOsrzYzhwwJO78gpKwGv/5LkyBUS4f7/6e8NX5ewaIK5PzuYgj88a4PNdsVFAkWka8+6O9W7VC5MWSTPbD7eYheQeZJ+ecxcQW5crq8utHSk9x8+tYRL7SM6tmX+9HWrc3dbKBg1/AmuLu0QTTgtlR/WUS3RSAO+b+jMWUAuBOwz6eLHZR+wIK1bZspbJcNlFdEG/zV3zfqkUA2qEt27RPW3UXfI4480bmBNgYjOyxOM7gVBFTvPMqKBNUeJlBLyidfILuN+lVokOrLugVHtpzQYzSy+HuYUCs1LQUj6s0RePgusnarn7KL1W0ktZNF0+9geZsnkrtCjsWeTIEeA2aw+FG66mYkPcehqoOTYAz+cXqPO6qyVgRWUJGFxA1f+UnMJTCNZqCdGDJZw5JkNp35jJ8HhyKX0mogXp5KTLA2K1WGnLT6EYlgA+0DyXzaQwdXgnDHY12fUnfKwft9pE7zQotciaMiFvMnhRHqNfxn8/cRh0CKiktC7pLs/3EOWBMEdYPtIhFH+CUJcIPnOyq84eA8GAdbg9cS5EYoC8HC6YU6qiLffmyj+JO6Xmc4jKlNVashaHYg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zWing2BSIv8m/UFLrxYFH9ac6uqAqQ0xLcbVYTLU3Lz/FvCLROeAUorNI49QYSBLlWzroGtjwOhm7TJRgHjAWIrPJOBZwb6u9ASjF+j6HdQr9Sz0rgoZnm2EmkIn7JA4vrI9yy0KNI8El1lOY4YmlsjnfhQUTLUR7BJb/KkDcc9RechY1QtwhP4H6lhXk1qD+l7powjkgcUZogK0l4T7gUcfj/qzTG5oJu8WuUgfj/8pgbFflrDcHkmootcqJ9+JlnboOG4JvfigT7JsbN55aObd7xPGg/iP9qu99a6M6ge6DpjScfLVF9/ZMCMd64W1YUI606PQ7uHEZQ3pE7OP7Hm2DaLgoUQ1fGS5uUMTkBRCa35DfNh7R/OhE/upqVIlADabiktVxlT7CmQ2hbdD0RuUDwT4xPwtC0WEpx7oT7b2DGAUFcPtnP+Q3ZGQshPG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:47:52.1604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb2dfd0-d43b-41e3-dd6b-08df04b722f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

On Thu, Aug 27, 2026 at 09:00:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 27, 2026 at 01:49:05PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 27 lines skipped ... ]
> > > > @@ -4979,8 +4979,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> > > >  	if (!dvsec)
> > > >  		return -ENOTTY;
> > > >  
> > > > -	if (probe)
> > > > -		return 0;
> > > > +	/*
> > > > +	 * Do not probe via pci_reset_bus_function(), which would reject a
> > > > +	 * masked SBR that the do-reset path below unmasks before resetting.
> > > > +	 */
> > > > +	if (probe) {
> > > > +		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> > > > +		if (rc != -ENOTTY)
> > > > +			return rc;
> > > > +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
> > > > +	}
> > > 
> > > Why not put this a little lower after the:
> > > 
> > > >
> > > >  	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> > > >  	if (rc)
> > > 
> > > ?
> > 
> > Hmm, the "if (probe)" was checked before pci_read_config_word, so I
> > kept it there. I don't quite get the reason of putting it behind.
> > 
> > Mind elaborating?
> 
> I'm looking at the ENOTTY:
> 
> 	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> 	if (rc)
> 		return -ENOTTY;
> 
> If the general point with these fixes was probe should capture all the
> ENOTTY cases under probe there should not be an ENOTTY return outside
> probe.
> 
> So maybe that should be ENODEV, or maybe probe should check it. I'm
> not really sure how config read can fail, so maybe ENODEV is the right
> direction

I think returning -ENOTTY is somewhat correct here.

-ENOTTY has two slightly different meanings in the PCI reset layer:
 1. This reset method does not support the device, try next method
 2. This reset method failed, but no actual HW reset was asserted

Either 1 or 2 seems a fit for this case, although worth mentioning
for 1, changing to -ENODEV doesn't change the behavior for now, as
cxl_reset_bus_function is the last function in the method[] array.
But it will be different once some new method is appended to the
reset array.

On the other hand, I see the probe-passing reset functions define:
 * @probe: if true, return 0 if the device can be reset this way.
And read failure can say that the device cannot be reset this way.

So, though part of me still lean towards leaving it as-is, I think
moving is probably the conservative correct thing here. It aligns
the probe path closer to the !probe path by a harmless read.

Thanks
Nicolin
