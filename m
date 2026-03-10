Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B923563F6;
	Tue, 10 Mar 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172678; cv=fail; b=C1iBeB2nOVfMvNiMmk7IhqdvhkIeNn5DjsGWuXCVZneavZNba7/SxEvxNQZ3us+/URHEV4d7IdbFIXtxVpUG1E5bHtLSRK1hEJBwm6T4v7D4V+uIOcm+vI3a8E3lOUeOSdzgpvwwE9bDi0P66zVKmilw1aaPQ8WH7vK1dKMwstA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172678; c=relaxed/simple;
	bh=WyKMGc3ptOCoQawJix4Yvo+1R8GkzKS83DyP9nBPGwg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU6LYFLEuMmJmXghKV8t09h9nfYfmJ1JEpgOPPiPpQsaLzegXZFbxCeIiKhSZU3kB1VKp9ykiXfcbZA2fDtOydsvTgEv9n+TqO2D5egIvrpcVwsiUp++VcxxQQLZooBv0JQcXpgCD4QLoJtJhqA9oIKG7A3f5XzEpmVmk0aMG+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWjQqXNF; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWjQqXNF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNdtaIA/PA2tupSQ5PIFExJNhK3SqmEYatKLQJL0xzc+rydO6zXYhY+O9w65Fa1qP7xROl2wu75TQh4VE+dq3ku86ScqBZ+NKuUE3s6NAF9SL8iQ6g3poHMTwm80ZLHmro4otrXlF5i6AY/QmCNq7EutTiESb4h3WD/5zHRdSij2hkg13orpYmyfQX4UgJBRAHivSzoJWbIXE4um97eK8sQrZRViyB9Uniy6fJZ5rpV49sXm0XWbTagX8rSCZRq/GCJFe5eIc/5FYTBEBWvXUrSj5CZXBwKAeCDEawQewA3/D/wxY3o/MY4FY1xBVhK8Ufq1D8otlXbMXTlYp3kLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k5NkOCyWw6/1ptZe6AutfIZgryJFTNiAsw7xkQhZJQ=;
 b=n+mVXjTRtr1c6UUmaKqejL6HUa2YhZ7aD8cNrgFQfozodhs/JjbDHNijEmLYGl6H/P4jv3+2jQBzXrHuXU4oWwZemH0dr+ENW6mAPdk7siZajloll4ZyQqXoziYiG8kivOmcYd4iLb6QPQxzIR+vVPYtWnfeNaLDGuKyFIeKCjXuD5j8ipDebDcvgQnApyJMOS/M5hRI82kOGKJQRlyqYec6q6H0UPTvCkh44CFwmj9xVSJg0lVyABm130NJvbZobGvj3/U5LqDTIOfrmzYcn/Kv2kORJKR4HT0jQTRBzTYAACz4gTRN/BPtBjcYhywjoQH67S6071X7/HIcCgI/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k5NkOCyWw6/1ptZe6AutfIZgryJFTNiAsw7xkQhZJQ=;
 b=FWjQqXNFnSbsHlEfkk2CLk2NkXitGvSqmNLGEPdsWj7mGNDZk+1jYmupKpErMCeFkmEQVWWtDae5Gb8s6fA4aL87m8xotZ9UM3fy6ulxk8nvRYWuMVsSfLFSgH1kNzJCYmg7WrccLM4rm6g6IoRivVgXJIDfVD85t6CQjfpAF5rawhMnkzESekJWEN9ncXBiHgoMhYyD55WLyDEq6cpg9LeWtRobjk1kQSPMPbWDYe08F2A827YDbhtm49qUrcuT4aMTokPMEckUpc2Ixfa9Db8zI+PhezQ2fYkukZYEFxflOt6j8Z43PTDASoouPIMZK76i8OxetkyFdC2FQyI5TA==
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Tue, 10 Mar
 2026 19:57:48 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7e) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Tue,
 10 Mar 2026 19:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 19:57:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:57:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 12:57:33 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 12:57:32 -0700
Date: Tue, 10 Mar 2026 12:57:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<Alexander.Grest@microsoft.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abB3qt3QTroym7D+@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <abBzyKNZRzRykRV5@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abBzyKNZRzRykRV5@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: ed772e1e-4989-466f-8519-08de7edf4e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R7zdy2A0azbPjeXW0f8mGW7WiHCUYaK4jFBanXtEJS2gZSusfaCkV7nL6UA6yuKOqf2fKJ60EhJdWiNUhnlPrLkiuXLOG8IYguwosmguiGhOCtNmqXJdGPyD8gV/hL5a36TVyf19ik+URRyYOM7HXoIdKNx203luFl85l8OGnuItKMr04kG9U5qpVbxIgkSMOESs/UvwjZJG/wrtj5lg2GQoynL1CFMAgmgE07mW3Fqx8LzNH75WMm9E4o+nkJAbC4JNrWHoGC2VA/OSafeE8dbI5uHynWEf8EkL+/iJT59zZZr+gB68aHMiZ3lvsdaNOl7zfKkeTDnDE52x+TPBi/oqIA48oqwPV6aEa2DQw4RRtodlt2PMrwwV41we5V5vTTC0bHqqUpoznTsbeJsX2avf163fIieaLIzcFrviKtsL8KWQ9Dt/pweXesFCj9yY3zbFkARArpb6c+1ruXqvsS7oOlx4nKHlMK0A5ZnC9B731OzIglSNiZOiEVeVHbHVnziAJZwEtipHT+4RsQ9F//W7iqRE93A1yw52D2TCFhJVqZBF2sMtDQa4iYwgV0YDFdXrjKX1sp2v4Tnp3z+8Uyuv7BJ606AM8BINLXa3WCnGtbFa4DY7zJg+iaTSe7ID4L81b9/ecjjaG0PtByaGaNnZd+M5cF9/PfU6kt0WfBcQV6pAumsVrbfR0es40Kblk1uQnTtROR5Ss+DS/KI4OccxCX5Dmwg7RtxpfZxc5ILZOrYTySB8mU5NMwMmkQqcr1ujBoyt/l3qx36v9KfGkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B7fUmqNC+6hVRyKA6xjUGjnap6nIYzSXycdbeTCunWKwAeqinLXdejRxLgdyrvNwY+Hy6T0mcv+RUy5axdqEZThgo0Xoh7m9WFs2xFdoxbiJ3DI6ABj9fvHScmui2T4ufqIjcUzmcQWpMiB7h39jvhkje7nEJ6AXwWR9GHfTQ/YIGmHsf1t4Cdh0mpAbQSljwpDJrRSCs9yNwDnIM1RhShsmIyzbv817BzSli3dsv7lZfDfZOlJ1tWQR6ipeazePlaCU7iZjfWvGiLwu60m/L11C/y5wuvFhsO5+bkA0UnAijEwGI//CtCVkq2Id86q+ByNkjX62tiltTCOfQGynxBukjwzQmBnpXtac5Sd/kL3LIcDeR+LvblP781ZQShlFvzS9n9jjY1xb9/c9h1rm6IyBfCOpWOMpHN15MU3GpSkvdbFmNLrmu6Be51mTgaLB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:57:48.6107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed772e1e-4989-466f-8519-08de7edf4e1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

On Tue, Mar 10, 2026 at 07:40:56PM +0000, Pranjal Shrivastava wrote:
> On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > > 
> > > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > > are also matched. Actually, at this point that NOP ISR has already
> > > > > finished.
> > > > 
> > > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > > something, but if it works replacing the NOP with flush sounds fairly
> > > > appealing - though can you do a single WORD edit to the STE that will
> > > > block translated requests? Zero EATS?
> > > 
> > > Yea. I can give that a try.
> > 
> > This also really needs to go after the invalidation changes because it
> > is feasible to also edit the lockless RCU invalidation list from the
> > ISR and disable the ATC for the failed device too.
> > 
> > > > Also, will the SMMU start spamming with blocked translation events or
> > > > something that will need suppression too?
> > > 
> > > CD.R=0 can suppress fault records, but we would need to override
> > > that in every CD of the device.
> > 
> > That's too much to do from ISR, but maybe we can do it from a WQ..
> > 
> 
> (Skimming through these, apologies if I'm losing context), shouldn't we
> do all that (marking it as an inv STE / abort STE, suppressing the
> faults) in the worker instead of trying to reset/recover the device?

EATS should be unset asap to avoid memory corruption. It's best
to do in the unmap() context where the page isn't reclaimed yet
by the kernel.

Worker thread will be a bit late, but it is good enough for any
further step.

Nicolin
