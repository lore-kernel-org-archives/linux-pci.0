Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2246D567;
	Tue, 29 Sep 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711241; cv=fail; b=aU3IpQZUUvcjwaklnysUmISlDmdig5PBZqvWnjugFgx/brrgSnHHx2eJuoF9oOTTtGA/z2xn9ZbwkH0dEirBh6cV2eTEGUtB9JHF46E1hRiaKl3L7/IL1yDggFIlRptAE2nVZQVQJfvOHPnxzToAgWmNoGWdcuQmj/OPI5qw8+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711241; c=relaxed/simple;
	bh=S0IIw8g/K9Zd7P4lMSjHxUtLlx1AdScSp4+yojx7fLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhMmsmSynVrJGA6SQ66EeJfo3r45JxM3usXmORWR35UVvdWeX9m0dc2n57pgR5sRTyMxkmQyloxogC8jPLZNBY2G5lehW0kzTr7ngOXaWPnKoYnq/f7cvsqWsV2V/cPgdv4d+A3rykb/cM7l/uCVEJ6fR6APaLDlKXkyeL1kuJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HLzCtlbE; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLzCtlbE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFu56/dK0CtnmzBYzrkhYUv0FB1Opwn5YZYocDP+Q0KFwcpPGZQSiauC5wSJ0Gr/owYQG6YYmrNpOqGuB0wP99RzkKJyqasazFEP8pOXEWrLJDXvYyZU/+3zXuaHdefGiPSTUIlO58FpNnuJavClmdphbDpB/rJvTcAEzW4kWJ8oB6xvguPxZBQfsOr/IPy5rKCRJ4UfFf253m3ILPdGjUm4kYdzboMBIlgdbnrOrdvYgT1MmzqeU5dLfH9dF/1vGPyG86jFg5PO9kuXe8+55Wx0sCrhldX6fC8axy0orrCIWQFSWklQ5B0GjVaeX/DTWjJ/cJ6rfJJuK34Ec5EutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FJnGdb5j6DzzQLEZaScLrgjD/pzJxj1rr+Zp+vLejg=;
 b=gmvZSIPM2dvTuUhx8SOiGl5WMRkDBl8sI+dSEWIBaRx9AxLvTJENOqcCdKwvPyEIxCRM3sA3cTh2RtUEpbWUOpJgYLitgIM35XtJE14t/KHvr69BQ4E+9DsUFgIYgDhK6Yv3BqpHWIs6m6pUr9osDqNfAXJrbWDB8XdvYATmBRY2oIZ2GLTdpdmNQuDAwjYa/Z9tWJSF72vwtpbwzd3lfjBO0jiDG1COFIBlOalZVArJiOyAfHPOuUhinoyDHupIO8i78w6N50I9d6OGwo+ez/DwasDW83BgPLoOzKZ2pArW7o552qmrip4/3qMYHBhQvXh93ZglTsQbD0oxSgBESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FJnGdb5j6DzzQLEZaScLrgjD/pzJxj1rr+Zp+vLejg=;
 b=HLzCtlbE7z5FohsZ/DuX6vpPr69jJaU+ieiLnysYE1NnmnR0hLwo32QZOhYrPHJ3a4SkBAOczmnw8pnsY9zhi5+gI9EvIWZnSKkTbMFrkZak4cOj+yUeD8XHnGh2L5SfY50wFl6e193eErkcjsE4o4ddcG9wNQ0R8BUh+q9hZkAeyFbucTHrgMmMYvR/xHt++8QBfDU19V1jxSVPBDIMQJqP1GoKyEt2vlDUBsQaybe1zxNxkWEUBwv5YV4sbsLUVK+D86un8iINbL0GRFlXeAwr+cRUq0wkhP9r5ak1s17v4eaJ5ZeAtCa8C5do00aAnRCJEobdJx9pQAxwRK8Dxw==
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 19:47:10 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::26) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 19:47:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 19:47:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 12:46:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 12:46:38 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 12:46:36 -0700
Date: Tue, 29 Sep 2026 12:46:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <arwVmg0CHKKAZjCJ@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
 <179018862538.3334538.17643821143626392419.b4-review@b4>
 <arRTojIlWBOF57zO@nvidia.com>
 <20260923233920.GJ2545495@nvidia.com>
 <arrqLmlco3TeC/lV@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arrqLmlco3TeC/lV@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 921864be-d3e7-44ea-ee4e-08df1e62734a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|5023799004|56012099006|4143699003|6133799003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6AJE6N1Gt+7XzEV9c3kF7p1PevUX2xcvdzWiOA4SYKVtCo4geKBuWm0BYEve/+cKvEJu78FEVHvzEqs0t8VZIul52TSSk4orwZdQybUyM6Hpvamf8DBmaXV90v1fsZAjHG23LqNJj50GgHpTbSQCKy0EUpfMVuF4fV93Og4T/tf/Uqs0SC5jk+H20dBcK6lc/XUp5xsg8yjwFMur5ZwO18dHjzyltWZ/zItWn4cd0k0DU+4MC0dkASgvhX9kl45eG4tDwRVJVPzSifO7jo90R5l2VUwPkB4fktvOpphVz/fSa3xiy0bg5N2UlxcTFzJ+D9c3J1dUJPCOHS7AcIv3KC98JF/cZMDVD00j7ZHBqXnPZwPLcchx5ZZqbS3YZh0RsHBgVBG2Fazn0OFdLf7Un1pFOA7eZy9ANDUVrMFkYqiGmtWe4hMJclYrZB5kQOA5G54LLz1XTvR6+n5ugFdOYoHxTuTeedraPPq4P8+wJZ8ZisZx4+KWkugzNP/CClZX8zt7iKry4u8whMGV/ODT6n+bJRpXTy0NUE1hmgVL8d+aAsBBNJxfoLCNZmormJEnsHYCHjApJmBHjoJp3nvhTnelusO37e71ybvIsdiwrpIFc82tOClBLTupLpSB2y8pJp2rGv6X/8Hc2mjj0nl5XEBltUU4Xgk3RJ+ELobfsDk0qiSgQcxozwEdEvmcrNRfAU/gf/R0GC7kSoKaf9s/6w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(5023799004)(56012099006)(4143699003)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VsNCok/rsMhKx10MrppqmUGzbOd3t3taXI9WQMdZR/965Rj7jNZVfXeNevZw8KKJAONW3jZGJm9rAEU3yZ1ZLfubNFeNLSVeDmbzr4JPMSfyx6wluRTVk86NDY+0IubomhGZdAtEHQhkRryIfzwxPKZais9H2Ixpxv5xW8LHZeDNqOmaKqaTSZRohUpLgvuTWBDkow37fvARgkTjGSZc9fZsDWXIqOhcxMEsHkwK+P5mGOpolPN05Cqq/r+y93tsso5vbXbXRdHspytFC6xtaQuh0G85P6OwBVyZklmN7dkfJBcwnycYFPKpi+9yOeRyx9nw/604NKs1JJgOSHybRiHzTRwr+44HbBVbDK3o197nyaoe5H9t0X9ZiZQATjSHjw4Wgoq/UMod/xbMZRGAnKIPHXcdIn+8wTALnSCMDrLLIdJHNcr19w82rh7wnfTD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:47:09.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921864be-d3e7-44ea-ee4e-08df1e62734a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

On Mon, Sep 28, 2026 at 03:29:02PM -0700, Nicolin Chen wrote:
> On Wed, Sep 23, 2026 at 08:39:20PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 23, 2026 at 03:33:06PM -0700, Nicolin Chen wrote:
> > > > But I wonder if the point of this has been lost? Prior to calling the
> > > > driver attach functions the core code already changes the xarray:
> > > > 
> > > > 	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> > > > 			  XA_ZERO_ENTRY, GFP_KERNEL);
> > > > 
> > > > That immediately makes the threaded IRQ safe since it calls
> > > > iommu_attach_handle_get() which now fails.
> > 
> > Hmm, actually that's a sneaky cmpxchg that is only doing reserve..
> > 
> > > I am not sure about that. Looking at iommufd_hwpt_replace_device(),
> > > there can be a old_handle != NULL, in which case the cmpxchg() would
> > > not change the xarray?
> > 
> > I think this is wrong, there is no way it can work like this where the
> > attach continues to see the to-be-detached domain across the
> > flushes. No amount of flushing can fix it.
> > 
> > Somehow we broke it :\
> 
> I'm trying to fix this by replacing xa_cmpxchg() with xa_store().
> 
> However, an asynchronous iommu_attach_handle_get() could return the
> old_handle in the iopf path, before xa_store() in the detach path:
> 
>  - If a different domain is replaced, a driver callback is invoked
>    calling synchronize_irq() and iopf_queue_flush_dev(). And this
>    closes the window on any the old_handle reference before being
>    released.
> 
>  - If a different handle is replaced on the same domain, the driver
>    callback is skipped. Then, the iopf path could hit UAF while the
>    old_handle being released by the detach path?

False alarm. It's actually not reachable today. There is only one
caller from iommufd, where a domain reattachment doesn't swap the
attach handle but bypass that:

	if (hwpt == old_hwpt) {
		mutex_unlock(&igroup->lock);
		return NULL;
	}

I will send a small iommu-core series for review.

Nicolin
