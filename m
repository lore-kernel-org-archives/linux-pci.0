Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4E2F745D;
	Fri,  5 Jun 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696593; cv=fail; b=kudR0BGW5mj0Rtw66t7OzTZwlUASpTBuYeaF3VIcL4Dr8+xEhkbLpKpoOr20LFVZlFAy+oVdcHRNn8krGyruEddl+Wh0W+LgNmT/Lsd0+QCM0Yql10CE0bfJwRGMQy50ZITOS2JJjNfSi6lZ8y+P6uDKvIgsmTI/amXoGIygnvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696593; c=relaxed/simple;
	bh=wzwAMj7h8/fX0fFvSfro6o2R5l9JfBuG/Lf5XcfwaF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw8ABQvvOHUNu+65oFY460QluIh5uc3cbp6/QDlgQcEbr5L1jSKfCTNLp6xJ0FECu36tRUzZk6caHmDJOCb42VsAK8WcqCMwSInBVNQQNY1PW5fTTO3ccdAywSU/nHOCh0iEhpHJl63eRj1dMd43pqrm+bX57ErMdBvL4lmdmRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+IbS9JL; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+IbS9JL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsXhR4UYy5iyI5ABV4Vm4ZbdSKuSDN7Js+FStUMglwsIPPlo5SSn6vKMlTycXTZsmWu2aN9knSgksRZrtXAYE8xnqTL5z0iv3pPQZLySlaPA5hzNxdpR+7tjvjydIsbhqnu1uGxMxrz7MmMiCaH8X12aL4/aR5JDIuHpbo9Ju8lfbI4RCDqi5VPuiT2MfZl7FkQ0Bq7K2IS3yuJwvrC5m0zpRaUFAiam1TvJa80zSvlGK1jsvkJehsOpn3vuNwmXm7VfIiyCqPQKbGBgw4aH+vK5qWRr9vV8xqvuvsg6aX0xWBS6yup0lwIjvEB8SuExTZKqSvyDuhF/VP/851tnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE0Md98pudZWMbItmpFfbAzubbC0Gb9q7XvgkEpElx4=;
 b=YW5jsrJSQt8gHQx+hdfk34I3oY5JK3ksuglRbB1WK76PxRUSS+D9rZHbeFFp0sqyS0VSM9vgWXjj58lROE3zosudkSQrwe6/BiIcu/dxf+FEqzXEV6bsagQH9Ir3cUYyiskwIj0Y4jtLKLqM0BlTi3ZcXTBaT7SfGo4f/HA45fZ0WVgj+bnwdxj3ki65LB8/1anbZjfGN7ksq/8bSHD45xZxN8DaNTUxTpRExgcOL0NeFUSxnwD4CX9GlKJfN+FtZyIbQa201uiBxkFP1fk/dgiFZco6VUz1yGCauuRjeE11i8bxRQPK1EHs++Wg2nkUG1xcwwsknZtF7Cyj1L3efQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE0Md98pudZWMbItmpFfbAzubbC0Gb9q7XvgkEpElx4=;
 b=Q+IbS9JL/o1/2FrwtqPBEiJWypUZE4Se6AQXjFmU1qWNsik4qhwtd5NEnYtcyW6v+ZFAvmDycZcg+g6XYUh1ogixiSGk8tapPIpl28adrjtfrFwBUnkA7gnDsZ0PRB3jdGcSPLolfrob/IYHANJspZ30EhIJCY9MfjRRcooAyynY1kVNQ0zDg4EbA8GGLuxn8FxD1TyBUhNeE3Pca0kclcYDo2y7mSpRa//kaUebnh3ST4KiWkNelenNolu1auMPO2oq8BtSvrnSjhzXZAyYGq31kzHjpsHBG5KfgfB9BW+KnghVPdq3H098LUZi3CMBEmn0KN6wqXHBqmZVIxxMpA==
Received: from DS1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::16) by
 SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 21:56:26 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:242:cafe::68) by DS1P221CA0025.outlook.office365.com
 (2603:10b6:8:242::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 21:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 21:56:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 14:56:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 14:56:08 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 14:56:07 -0700
Date: Fri, 5 Jun 2026 14:56:06 -0700
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
Message-ID: <aiNF9kzjzDY/u1NG@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
 <ah3udmX5SIO9lAXR@Asurada-Nvidia>
 <20260602001547.GR3195266@nvidia.com>
 <ah5txKCvspL8zMeG@Asurada-Nvidia>
 <20260605194259.GE1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605194259.GE1962447@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cce636c-5e0d-4f55-4378-08dec34d4a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|6133799003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kWYh64XT6jWgjeqwkAXffr1Q1PF6L4T6tBSB9b2BGZ1UK6rS/GLxD2w+GRlDBdxZU5ZUzgl3rHYaG+srL7PrdTKWoMvomrGh/w7hdVIUIIqE6WxnGFbz2iS2ebsNPCmt1bi9bnugxLXUkWZB8nDGOKiIN9+iOYZK1PO2Vr/1oWrppBo48/E1Ns3QD1TFE3d9297bw2E8BPXeexKvajSdJ2fBuf+5NIt4OS/TlshRkiAXnlkkFJVJXVGYR94pgdWLjf2n2SVPCGXeKjmmtzFSR8t9F9uhjOKIjHvncAJVx3XWxUA3WDVJqaoXc00QPXfTgNSv6qCb36OSkhl844MswdSEZl0M2uFMbfbDhUU/6KwO6G/YvC1t8i37JC7xrPbNFk9DnnUllHh87dcbpXFE4ztsxu5YZbOkUwgWy9aa8gQQOlPmIL9UVrI+fhiync18JSXtrjmM8Nslk4Uc9yM67jiroCS6y6pe5VoijnyKiWvNP9CBvlF7kfKztw562lkO+aW0nd6YJtsWVk6SMOi73MOY+fJ50KY4Q+uHRJRyc/FeT4CrQOAFgVYR8YUptpCh2kdq3PQl/PHhhh6KOGYwEUf/9KPIMnvbMMkBY3UrEUbQdFO5uB3OGh6tnBNhewVrWKvokYxm9K8WR2nW9nARv9f802y4udzMn8EHY0w9j0XlH2SpJ9LIAfKLA8qTrq8vSnUm7tdIMEJTzhWibxjhIzqRHuZgOV8zN4nBB0FRmss=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A4ejibje7oSZtyJKVdoGrdIlILpl0J0KqobTYIarvo8szqlmhSJqwkm6ncpR5KXgnR39ZDCb62rBnkv5yBxxOH3JCETMTVauMUzIkd7iFhv1UAdLk2klu/z9Kn8w5oyfJlZZEvlClkjevXtqTUXL00BuD/HInO2yXqz5H0RPoDHiH3qkJ/i/WCweWyfblHX9H4WEuS38bkWKhAPnGHZfiODQl3EAVtIOB63hSfoafiBS8YuYtWU50SVHaZLemNVq6d6N8M3s4Kne/6mMiAk2XJFVYiWAA387EmFJ9iLGWVDuGo4qVZz2NarZaKAJIaEUnYxU2tpylUlKw3u6+LV5ZoGecUCG+I+YsZEHfMUkQGbRZjemu/RNnVDIC9UR4tznSlyfb0fwGh0rUMrhmEmKeJJt+Re1zoGKCamqBeJDqDkfrnith60UqvWrkFeCAdfE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 21:56:26.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce636c-5e0d-4f55-4378-08dec34d4a7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Thanks for the reply.

This is indeed a very complex and sophisticated topic..

On Fri, Jun 05, 2026 at 04:42:59PM -0300, Jason Gunthorpe wrote:
> I don't see any of these options as appealing. We have to maintain a
> few key invariants, and I think it cannot be done without a way to
> find all the domains that are using the STE.
> 
> One way or another you have to be using the invs list rw locks to
> synchronize the EATS state changes.
> 
> It is okayish to be sloppy when turning EATS off, but when turning it
> back on we do need to cycle through every invs list and toggle its
> lock to ensure that the invalidations are synchronized before
> EATS=enable happens.

I think the core guarantees that "cycle through every invs list"
happens: a PCI reset calls reset_prepare() blocking all the RID
and PASID domains and removing ATS entries from every invs list,
and then calls reset_done() that re-attach RID/PASID domains so
freshly new ATS entries will be installed before EATS=enable.

So, I think the enable path is not an issue, though the disable
path or the invalidation path would need "a way to find all the
domains that are using the STE".

> Given you must have a way to go from STE -> master -> all invs lists
> I'm not sure either option really makes such a large difference.
> 
> If so then adjusting the invs to disable the ATS is pretty simple, run
> over the xarray and set them all off. Yes you could find the master
> through a SID lookup with some locking adjustment.
> > 
> > (1) Per-invs marker: INV_TYPE_ATS_BROKEN + master_domains
> >     disable_ats() in the timeout path walks master->master_domains
> >     and flips matching ATS invs entries to the BROKEN type.
> > 
> >   + invs walker is free (one case label in the existing type switch).
> >   + No lock or pointer deref in the invs walker.
> >   + No master pointer stored in invs; no lifetime concern.
> > 
> >   - disable_ats() walks every (master, domain) and marks each invs
> >     set; the list needs locking usable from atomic.
> 
> This doesn't seem so bad

Yea, the only thing is that the disable path has to deal with a
complexity from going through a per-device domain list. Maybe it
can reuse iommu_group->pasid_array by taking xa_lock?

> > (2) Per-master flag + streams_lock
> >     invs walker resolves SID -> master via streams_lock and reads
> >     master->ats_broken.
> > 
> >   + Single source of truth on the master.
> >   + disable_ats() is one WRITE_ONCE.
> >   + atc_inv_master early-skips via one READ_ONCE.
> >   + attach gates ats_enabled on the flag; a concurrent quarantine
> >     race can be closed by a short post-attach re-check in commit()
> >   + No master pointer in invs; no lifetime concern.
> > 
> >   - invs walker pays streams_lock + rb_find(SID) per ATS entry on
> >     every invalidation. Measurable on ATS-heavy workloads.
> 
> Doesn't consider how to enable

The enable side is core-driven: when reset_done() re-attaches
the device from blocked_domain back to its RID/PASID domains,
the new attach_dev callback (old_domain == blocked_domain) can
clear the per-master flag. If the device is still broken, then
arm_smmu_atc_inv_master() at the end of attach_commit() times
out and re-triggers quarantine.

The flaw lives in the invalidation path as it must translate
every SID to master using streams_lock + rb_find(SID) per ATS
entry, which make it very less attractive.

> > (3) Per-master flag + inv->master pointer (v4)
> >     invs entry carries a master pointer; the invs walker reads
> >     cur->master->ats_broken directly.
> > 
> >   + invs walker is one READ_ONCE through a cached pointer.
> >   + disable_ats is one WRITE_ONCE.
> >   + atc_inv_master early-skip via one READ_ONCE.
> >   + attach gate + post-attach re-check, same as (2).
> > 
> >   - invs holds a master ptr, so release_device must synchronize_rcu()
> >     before freeing the master to drain walkers under rcu_read_lock().
> >     We dropped this from v4 for that reason.
> 
> synchronize_rcu is not right because you have to have gone through the
> rwlock so there can be no readers.

Ah, I think you are right! When release_device() is invoked, the
device must be already in the release (blocked) domain. So there
should be no domain->invs in the system holding its ATS entries.
And the enable part would work as (2).

In this case, (3) seems the best? It's fast on every aspect.

And I think it would fit we plan to generalize the invs design:

struct inv {
	struct arm_smmu_device *smmu; // => struct iommu_device *iommu;
	struct arm_smmu_master *master; // => void *priv;
					//    (dev->iommu->priv)

Thanks
Nicolin
