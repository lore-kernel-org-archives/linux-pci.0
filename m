Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFD36B061;
	Tue, 10 Mar 2026 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172351; cv=fail; b=Zc/nfthFYEB38dVr9sTtgMG/aIj3TZUwu+sVc9xXUTDAoqcxXza/ZhRgXM0/L6LdO2dYUiMkBXfxkYo2z0BsADJOK9yAa1CDq4DTonDf1Lh7FV2Yyo0s8nCsz8yPpnJ58w0fH2hR3qWegawnuiXja2AL7nh0DdrlqQqtwHCHrZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172351; c=relaxed/simple;
	bh=5QnaEA09KpcJsAGzSTlVyvoSIPekfviAGhqcgGB1F8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1w/2j7CgJmWS5rUG5/xB7lBizs5Grno2n0THjVINPpiPIkbm1MBE8opCKly2sNfGe7SQTBFENSBctKno4KkyqslW7Vv+t2skTqz1Okqusvb8L6+B+xUqC3B499NWrd1PpSRxWCgu7AekyXjXCm24CB8tr82KRpzBfIuanfsp6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pu1lNzA5; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pu1lNzA5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx7YUqw7TLVD8hdvqeUdGe2Gbj8aBEHJR/XppXI+CugLj896jxRASq/0+iftmGil9QVzQQhQKyn1nFbNIosg+/8XtXo+fVee+LQifQOw0p1gq1LncIy2TZ7cczPM2v34b3oELyPmPqTvGuPeitzuVXlVQ/3oqljgrdRwpu8L6yg8fKVI/hWeeDbF5JJvPjutaNW/31iyjD/SrUg4YMI1Cn97Zd4ooPwrWdNZfVIwrF+OAHs/tWz4YCkgkwAYewGD1lPFkkTvX9I3TZC1X/G0rt2B72g3shn15yks/HS91A22lUMpD34Ck3nPGGE8Hn90LceCuOFPQlIhfGolIL/RHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atezk3Kg1qy1vyzY8wZ5SCHnTMyxR4AZ50gIvkhMu1Q=;
 b=SRQQf3E5TxYhdSIJzExNtMECVThcWM8az2NNhUylCOWY0JMI0MVlXVIrR4GI9EMhsF7HX8Zs/yz8egZPWjS9sIvs4x4LFLNTiGku4cNtU6utmCL7kz5jIyXSLCO3YMXeGIyOIPt1x5MQA+RjVnuCYQiFN45TPALiUkFLINn8WhmLJ5OjOqRgwLj/9E16wwKd0kY7mb1pGof/axj0wT+16wkA+5amLOr3x88Pg9rWIz3rlDcT+1bph/wq02bC4prqqu4hJtlLEoaJqmi+e8R6faI6KWQ2Fo5dDRt+/AAvw5LLtzqemYXgcu17kc8bkjvSiH9dfak3b4TddppOv62spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atezk3Kg1qy1vyzY8wZ5SCHnTMyxR4AZ50gIvkhMu1Q=;
 b=pu1lNzA5KNjs6zRPWD14xW066AXAGrW0kBbg+Wx5nQYFF277l3OUjYEyqRRtNX7U4s/2ULT19FG+OA2/QkWM4Y+5P55L5L8adIpYT/Ye/jcfIPTOqle1Zd4yeEE0yZfACUOeRiGtp68b9Bzm+HvG6CBo/knF3MVgUz9Iks+4jqPOyYQCV7/cl6UXmWg05uo8RwCqsMIhx60jGVN7iVaYuJbJ8lQI5IbMaPTMD/YrTdEneGM/mQgbmqoeuuwJyFPG6tX1c8oUkpQz5xNyIFe/ol02titAd0AlhEFKQxPk9aBbTP6WLeUvF2qJ+M/ooqg2CFqPBo/rNNUhz158gmAC8A==
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:52:18 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::29) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.28 via Frontend Transport; Tue,
 10 Mar 2026 19:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 19:52:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:51:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:51:54 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 12:51:52 -0700
Date: Tue, 10 Mar 2026 12:51:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <Alexander.Grest@microsoft.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB2V8VGfoh5yO45@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <abBt8qj8QpkG-Fwh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abBt8qj8QpkG-Fwh@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: b31fa2f1-d712-4f7d-09bf-08de7ede8958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BvbGjtXFZOkVZLwl+godUDdZ2FEeEtbE8hkls0HfL3RuA/LWrbr9YHMrmoaFJGc9ga1tnKCGiWxZ+VbW5IhEryGR3rl8abehq0IB3fi7sHKnLaKRQWzCfT5onzfn3DFbl5f3hTzfX3DkN+N8MXL7m2oYLP94ZlAT9Jwevcwtt/7TmigYEs73yy2VFRIEuurSNiXp6IPZ48DrXyMYIAcbl36pp1hZiosNeYj9i6UwTEl+ZDv4p7l1u3RLxR4WaohGRgtGrEqL7w9LH9RLrQXvOox0hxr4sCApTLv5PGKDNqi1yTSTa+wl/wuXq+wcCBur5HmPY+b2KwTx/aK9xg9+QrltSd641vimB2jV5WMB6s/hqkEGxD7HbvfCb0005CCuRB+8Hrw/0S8gfPvGgQ6L/sy1bQ2SAPzawsenCJVL3TaB35hfAm+UAEHGCBqATnk1js1GvNEeet5Q6GtnD3IOp/VYQOowhICEt3OMHL1V9OhseFN6BgacMDXVyOMfhhxLQwotzdgfoLn9g24VzucvW4LV0HmraW3OWh3BaYlYyIEyYvD4NLpakSRgd/D1Q0RySEfXCttypn6edypxAKek/YsCTrfo6XnTJ6iCkR8ev7OpI8ndbb0mIcElhpmbKZYvMuIHAs5SKOhFeFksx59bOmAq9jv4d/+i0f3xg6FHn+bvMj00K4+qsZeFT00pVTqsQsFJgn1FcX8Pvr3UeFa4JI2jjjXt+GSzerZQ9/u19jJ60SdpVo94ooHyduRU6drmMfboDTGKwTdu9gER+sMh/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p9RaKJPRBIrOZ5eHnRykh+lzkdMGHD4+vxnpr4bkcvdxy86fRTaSU1GJcLMosNYreelCsLIu1ckzhc0b6l1OEvwKvDv80Z4dN+cG0llqZSC9mYh4QnAD0IcLH1b/0olsnyRHNbhLChR0JGYYajoOACIdEfm3mseqSdK0Hs4FXMIiTBZiZWMc3J7Jej5xigbcRQaoD+5DI0cxw9iKdxDr0Ur1kVAIVYaoZrwOXnOXUAAbHKH1UIiObB50owYSvXZUbPE0FKGV95EFjscTXq8Mztr1bLYMngfi0fL1lSMabOtdsJ/QLRQOOoSmVc4mZck1XWKt9OAbnLfl/HGDHO6qoAICi+LIFBGNB1LeWsGqMz/DpzHWTZ3x1PO3hpB+vLTMRQ+CUGLiOWoz265wIWjc9eagbeRVBO3INbh7ljxW45MP3qkdmnAiNh8VxTebFH4a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:52:18.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31fa2f1-d712-4f7d-09bf-08de7ede8958
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

On Tue, Mar 10, 2026 at 07:16:02PM +0000, Pranjal Shrivastava wrote:
> On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
> > +	/*
> > +	 * ATC timeout indicates the device has stopped responding to coherence
> > +	 * protocol requests. The only safe recovery is a reset to flush stale
> > +	 * cached translations. Note that pci_reset_function() internally calls
> > +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
> > +	 * if PCI-level reset fails.
> > +	 */
> > +	if (!pci_reset_function(pdev)) {
> 
> I'm a little uncomfortable with this, why is an IOMMU driver poking into
> the PCI mechanics? I agree that a reset might be the right thing to do
> here but we wouldn't want the IOMMU driver to trigger it.. Ideally, we'd
> need a mechanism that bubbles up fatal IOMMU faults to the PCI core and
> let it decide/perform the reset. Maybe this could mean adding another op
> to struct pci_error_handlers or something like that?

Robin/Jason already had similar remarks (to most of your other
comments as well). I have acked their comments, and am already
reworking on these.

> > +		/*
> > +		 * If reset succeeds, set BME back. Otherwise, fence the system
> > +		 * from a faulty device, in which case user will have to replug
> > +		 * the device to invoke pci_set_master().
> > +		 */
> > +		pci_dev_lock(pdev);
> 
> Why are we using spinlock_irqsave across the worker? Also, why does
> atc_recovery.lock have to be a spinlock? The workers run in process
> context, and I also don't see anyone else take the atc_recovery.lock?

I guess mutex would be okay here, since there is no other place
access the linked list. Pairing a linked list with a spinlock is
just a common practice..

> Why does it need to be irq-safe? If this can somehow run in irq context,
> we also seem to be using pci_dev_lock and streams_mutex across the
> worker?

pci_dev_lock was to fence race on the PCI level. Yet, the entire
BME call is probably not a good idea. So, dropping that means we
won't need pci_dev_lock.

> Mixing mutexes with spinlocks is brittle and invites 
> "sleep-while-atomic" bugs in future refactors..

Either streams_mutex or atc_recovery.lock was scoped for only a
few lines each section. Each was released before the other one
was taken. Where is the "mixing" or "sleep-while-atomic" case?

Nicolin
