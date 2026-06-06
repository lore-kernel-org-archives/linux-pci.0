Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADF1F4C96;
	Sat,  6 Jun 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718675; cv=fail; b=Waf5x4qf/hg3B/FCLhsQZmhw7JfChvKDoLT9lPm/CHLxgKpkQg71pG+zi8NrzrKGO0YDu7hdh9py+27ke76+MAzJapzIqV2WzNyqNpERKkYiJCM/9fNmexNo8dWqPqo7wYjqcxlGKrYAPSEWcXCaiJEHZtffZM1lyOLIXWVObu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718675; c=relaxed/simple;
	bh=lzkg2HL7RJ27048SfR4YIHFyLwViaQbwpW8DdBuyG84=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMwVVpuSAp2gGBg3i4LzQhj6t/rWV5M+3pYRRUtuJifG2Uh59Ipkb7XkCCLml+NX03GffgnEWGz9oM2V+ll3/rKOme1EwpQLbeAfx/IYRb4nU5NYUlmQyjWptoQfHZPJyNaVzewz+TPPPUz6V42IqgveiigEDzW2u5CVj6KkrEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxnN5qIt; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxnN5qIt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNrPRiuTvnnVYrQFKlBn5qZDkNIYkmpSAxlDMjk1f++swGZYcZo5eJ1JQZA4hSoGGLMjf2/hYnSkn3RW1ouyanhaoL72+DxVTpuujUSx0mMaaN2pG8ntIzQ6YtpRcRTNdsZF6f9aAwqusPJvhGI750JAz+T38b7uFJ09AROc8hYDfp2IpwXBWkcco/gvwDGKL/81b0tkcdlth6K8OiAQyfR9hv4XX5fYoOtPgR/R9WhEzyTvUt/EHzisCP6UjQIiyyIRYnt4FxLiHhdyqdgmqmLqCWtgeAY5ykRhyM8XWKmA3MoqPxlUshSD7ihwCF64U+dwqyt9tqDma/4lmdvMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VXOmor//04BDemaTqc1Rc/Ksp6hiQAjgr8j/qI/qZo=;
 b=TACtcDt2w5TJgyina+P2DkwbXpsFp5VzBZrRT8V7+UbYadDyXDpxp8yck/NWtY3QCMO2xQ3OFm7fDo8m5hKPNLrDxD0ExNGdZbhJKylzM+9NZlM+1VWCICNlzv3SnX+sGRwJ4epd6z15J8TJPxYIb4zHCWY6d9y8K4qeSk7QvAcSDzNJO0TKrII/td4n2EtJ5Wy8ODx9B6jJBwmZw6qXrszoHB3DgY7x06dCd+KLp8myIdchCZ/dNR454PYc3ID2C18LRo0nQNzw1km/gV2d60H5CqFZh5daoWwnTXmyo/b84dVdwBHk0E9uabta+dP0RKYtW+BmieUaZ5e+uQ71Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VXOmor//04BDemaTqc1Rc/Ksp6hiQAjgr8j/qI/qZo=;
 b=jxnN5qItIZW6EaimPQPInV+ciVU9eFXdlPh2hTW/sX5ORIVL8dAE9zqwYEOGrnLwCRySMlK3wAE6bL+e91cyOBBztXRqVDl6LJFGf1gLz7v+fK+6qSTvIput0VeUgeGaX4lrhRyqzz80qM9jPGTZFsEIShEwI28QaYsKHUPqg34ns+Vp4AHlpokF0584kVaMfS3S3Zan8SoaBc27jJFLBNjldm7xX9K5zBk9c97fXKnaY3Yn2EOYx1MVCCHikQQimvukoXuApWeQ2HTBScMk7wnaR7y4USFKMFXJ6nY1RuLVQvE/sa8YbK5ynzGNvGlw7HGERRjIuG2GHFJZmyTWeA==
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Sat, 6 Jun 2026
 04:04:29 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::7b) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 04:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 04:04:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 21:04:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 21:04:12 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 21:04:11 -0700
Date: Fri, 5 Jun 2026 21:04:09 -0700
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
Message-ID: <aiOcOehTZn50hfIK@nvidia.com>
References: <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
 <ah3udmX5SIO9lAXR@Asurada-Nvidia>
 <20260602001547.GR3195266@nvidia.com>
 <ah5txKCvspL8zMeG@Asurada-Nvidia>
 <20260605194259.GE1962447@nvidia.com>
 <aiNF9kzjzDY/u1NG@nvidia.com>
 <20260605230315.GF1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605230315.GF1962447@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ab583d-c853-4b4e-3ed5-08dec380b4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|6133799003|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WDgJrqawc7zQ20MgA8bW9XjA+FspPqVJuVYz4EioNxLvkAPLjQF+AjT+0wu1IZQe3PMs//vYsEcW9JwiORSFzReBcNsfcLdjhDDo8f+C+3MRrvm3qjYc8F7InLZtsLhRQW+YY5Ev5Olfmj64iAyoG9R2kjzN8R3Lak4/mbbn/2ul725ccglewOFKwsJANAe4l38HCGHSC/dNqDgV99pLrNyZUuzyY1B83I5Ao58S9vVc6pMMUySNJacU3Qn/2XufpflqpynK1edFnQI/7PZaMDiQ1BtqP9OOeq5979iYNS6ZoMWHjlUp5/fCi5co8NRfckBq5yGI7q/yuxAim6Uej/4iUbZJ2Liq7Jexz7szV6kd765YFtuSXZV2N7C3ZpZuag20PZ+MPUktvc4W2nAk6MoHzkTH3G59jIayBxVrx8a8Knvlqu2vzCRmdXf8JGrYaLDOC+2sb7h/kDXsD2yxYHV2uPHUmsvTbjti/A/nfk+gkw9Yp86NlmPGIf5E3GcXuU9sbI2XgvDXLMAQiC1S0dwW9E8B0REuBBzO/ClDLA+wch1V1567mb8xW/X7RSK0lW8QqfPWrfW+ohyBhPVhaelEfdDAeQStT3sOL6d/yfx13q1Pi2yefhE0n/ANLGsIdhy5yU8OE59gJ+TMzIgYStJBx7SFBsKsx7Tf1emXwMqSYltoBPYF8pA+VCbHAKu7JkxvY1TISPZssErGQDTXqvS/KdN788lvsQcW5DdPveA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NF6oyOiYMM4uGBMfUX28csn7m3yaWVI4Hle9dLq/YsTJzj1ZE8P2Cdf7aQwrsgWheyYUHcB7fdp2SZjj0XNPERFLhqclrjV63DDFq74PpHJnNvLSbeEXVHx7/Dyhi+5yUqs/l+HXz6CFcNTs8V3P+7+kvG+E2o35fJnfNcQSagjPT8CBPeywwQKqyXoEQy7vncKw+hp2H0ljSrHC3nZDwJ6JBagfXpOmZnQoux0QbNuXl/kzKfuRsAXHA2zgf0IDWHuYaQSKdv2o0lT7DRR0Qqk8tmYPTxBgwHTKynuswHobJnCLWpa/TYHoOV82ZYH2kzPTHxsH0HsgAEble2oDvSON2NoF1N9UCgtBYZrkm6G8URG6rurWVNhe+yEb9MBhoPpvaHkYzZ1YtWTyyUY9wWwgW/m1kcwlOVJeCs3klO105rvvWC5k7FT1kfV/hqf0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 04:04:28.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ab583d-c853-4b4e-3ed5-08dec380b4b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726

On Fri, Jun 05, 2026 at 08:03:15PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 05, 2026 at 02:56:06PM -0700, Nicolin Chen wrote:
> > On Fri, Jun 05, 2026 at 04:42:59PM -0300, Jason Gunthorpe wrote:
> > > I don't see any of these options as appealing. We have to maintain a
> > > few key invariants, and I think it cannot be done without a way to
> > > find all the domains that are using the STE.
> > > 
> > > One way or another you have to be using the invs list rw locks to
> > > synchronize the EATS state changes.
> > > 
> > > It is okayish to be sloppy when turning EATS off, but when turning it
> > > back on we do need to cycle through every invs list and toggle its
> > > lock to ensure that the invalidations are synchronized before
> > > EATS=enable happens.
> > 
> > I think the core guarantees that "cycle through every invs list"
> > happens: a PCI reset calls reset_prepare() blocking all the RID
> > and PASID domains and removing ATS entries from every invs list,
> > and then calls reset_done() that re-attach RID/PASID domains so
> > freshly new ATS entries will be installed before EATS=enable.
> 
> I think this whole thing is so async and racy this is not something we
> can truely rely on. The driver is going to have to make sure it
> doesn't get turned on accidentally while the CD is still populated.

You mean the driver needs to ensure that the ATS entires in the
invs list would not be skipped when STE.EATS is enabled, right?

Otherwise, INV_TYPE_ATS_BROKEN + per-master domain list cannot
prevent a concurrent attach() from turning on STE.EATS either.

> > > Given you must have a way to go from STE -> master -> all invs lists
> > > I'm not sure either option really makes such a large difference.
> > > 
> > > If so then adjusting the invs to disable the ATS is pretty simple, run
> > > over the xarray and set them all off. Yes you could find the master
> > > through a SID lookup with some locking adjustment.
> > > > 
> > > > (1) Per-invs marker: INV_TYPE_ATS_BROKEN + master_domains
> > > >     disable_ats() in the timeout path walks master->master_domains
> > > >     and flips matching ATS invs entries to the BROKEN type.
> > > > 
> > > >   + invs walker is free (one case label in the existing type switch).
> > > >   + No lock or pointer deref in the invs walker.
> > > >   + No master pointer stored in invs; no lifetime concern.
> > > > 
> > > >   - disable_ats() walks every (master, domain) and marks each invs
> > > >     set; the list needs locking usable from atomic.
> > > 
> > > This doesn't seem so bad
> > 
> > Yea, the only thing is that the disable path has to deal with a
> > complexity from going through a per-device domain list. Maybe it
> > can reuse iommu_group->pasid_array by taking xa_lock?
> 
> Maybe the locking seems tricky as the locks might end up nesting in
> weird ways.

Oh, that's thoughtful.

> The streams rb tree and existing master domains linked list seems
> appealing if the locking can nest acceptably.

Yea, limiting the locking at the driver-level is more manageable. 

> > > > (3) Per-master flag + inv->master pointer (v4)
> > > >     invs entry carries a master pointer; the invs walker reads
> > > >     cur->master->ats_broken directly.
> > > > 
> > > >   + invs walker is one READ_ONCE through a cached pointer.
> > > >   + disable_ats is one WRITE_ONCE.
> > > >   + atc_inv_master early-skip via one READ_ONCE.
> > > >   + attach gate + post-attach re-check, same as (2).
> > > > 
> > > >   - invs holds a master ptr, so release_device must synchronize_rcu()
> > > >     before freeing the master to drain walkers under rcu_read_lock().
> > > >     We dropped this from v4 for that reason.
> > > 
> > > synchronize_rcu is not right because you have to have gone through the
> > > rwlock so there can be no readers.
> > 
> > Ah, I think you are right! When release_device() is invoked, the
> > device must be already in the release (blocked) domain. So there
> > should be no domain->invs in the system holding its ATS entries.
> > And the enable part would work as (2).
> > 
> > In this case, (3) seems the best? It's fast on every aspect.
> 
> I don't like it mainly because of the sketch enable side, and if we
> tighten that then you can just do 1 which doesn't have a perf impact..

I agree that per-master flag alone would be racy. So, for it to
work, it would need an extra spinlock. This v4 actually added a
pairing ats_broken_lock to fence arm_smmu_write_entry() in the
attach path, while the quarantine path is disabling STE.EATS and
setting the per-master flag. With that, the driver can ensure:
 - no race in STE.EATS update
 - consistency between STE.EATS and ATS entries in every invs

> But still, I'm not sure how all the asyncess and races will resolve in
> any of these cases.

Maybe we can try "INV_TYPE_ATS_BROKEN + per-master domain list"
first and see if Sashiko might identify some corner case.

Thanks
Nicolin
