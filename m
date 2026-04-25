Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F231BD9C9;
	Sat, 25 Apr 2026 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078317; cv=fail; b=FHOh+X/ULyzP4CRo3C3ptpuYDd+JNChg7zBXfo5Ei0RlTjw4sQLnQFnD1jm2sHdF/Fh1IDhapsykKtWTTkPtLfoFFlrpGv8SsV0VSksgDfmhLE9dfXlNdiVdzYTHOes02tHxg5J62WLYgOtbSaTjiNHgbed/22vf6X4SAUucvBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078317; c=relaxed/simple;
	bh=jOULSSth7Qp2y84r/rb149go3J0Cau968Gq1QESCRYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOhBQN2/2xncenoMsLeMahZ3Ifn0vIm0PjWqUcMoVwCty2HuvLiigHGQdwmpYhMLLmkyvsgTc6jHU4nKniY4i/ScuibiXeR9pOQ9LGTsTwQVTB4ksWg3NWkQUBqwOrb47Lak4BhYGCn4uABP16YwiFsgPT0Nw1B+J+jRaCvF0L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMg+r5bF; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMg+r5bF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gENPDpY195jqB2bTlj3VRzQBMmXioYoA4RlfSPXUcU2CzH7MZIA70ICG30BH91/OpT0+yJ9hneZhkWYRlPsRyC9+0eLGvdhHqDA82VkoUiILtByYcAAOft509+TSG0tiuaVHRhjq5BRv24P91ovpsYAsz1RdGpE0GX2s0q1ivss+pokgISpi9629V/RPQNPdUzb5P8xIeOJ3/DdCNmlxTe0x9CiFmA9WjRDy8e1GPwITQxFW5uGLx6da8xYGVGzSAE9JllkmJ8ZOsZqg9ZRQPtxSOEcTZHEPN/60lijkllPvtmA20ZjXQakyCLaP5D1wtUmQAKm1/sE+36qm190rMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ClXLjb0gpBaRqcFE1LjnEvb3ZPPqJV/bZdFw6swByA=;
 b=xIErcHz7eCz1d8fWxCvbnU9D7lb01Q7t8kDkiJwXKJmLd+woCY9rlQeWcXganXB4p9rhRl2tLQVJqD2LdYmsf2vLDk2FJVj9biqvYrFm5DdlV261oz6IheSTJWGhXLWAaYzLgnVLsx41wsLBlc9h6noB3dRyUcu1MmKWS0N8DiR4lAbmzfJTOqQPXyLHXp/Ea9BZrCc2s0o1NpSIdAMsIS03FabzetVAovGHxz0mP4/MAufS9zkbehnz8KR8atuxp1bLK4ErnFxgitvNaSbh34catzWdWbyh4x0nv2c/KDeodPsEXNt+H10DsDv/34dfyi0+5ejxSeDyUHrLEXCATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ClXLjb0gpBaRqcFE1LjnEvb3ZPPqJV/bZdFw6swByA=;
 b=cMg+r5bF5Rp7XIBeh3x+Kw4FkHuYgBAnp35PSnOjZ2bD/AmPTuCo++4w9GSTz+yLAdNQDOMl0c+2DLkToQsS7WnWl+1zJY3wY6JBRLfv+eapzrj6Ieg0F26DW7M6gqLUbhglgNchKK7CwiKUhCZpC+LxNBQeXrCUovacCce+Ah8EzuDk9wqfgXKVMjnHb5eIA20E2hcUcYA21B9KC7XLnCn2CZfFHZqSU6MfhedjDfi/HwDdltpIXnDqF6Gw/R/ScO74Pt6/5coL2vCgAOOzktXCvqcutNxQDHpH0bNAS6vt+TmNzONO0sHZJZ8fp0jL3sFrstW1KiekR8shpkJmKQ==
Received: from DM6PR07CA0126.namprd07.prod.outlook.com (2603:10b6:5:330::9) by
 DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Sat, 25 Apr 2026 00:51:49 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::7f) by DM6PR07CA0126.outlook.office365.com
 (2603:10b6:5:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 00:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 00:51:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 17:51:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 17:51:40 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 17:51:38 -0700
Date: Fri, 24 Apr 2026 17:51:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, Mostafa Saleh
	<smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
Message-ID: <aewQGSVwfgFov5Nu@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
 <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
 <aerey+ULGG589rdi@Asurada-Nvidia>
 <20260424131148.GB3444440@nvidia.com>
 <aevAqKFq7ATYk3+i@Asurada-Nvidia>
 <20260424225820.GN3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424225820.GN3444440@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 008006bd-c31a-4f6e-f5ea-08dea264d582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yvQqGv99CmWbAaplAG2f2VLh2IAXAhelsVViiyvytjQphxr7/DZSjva8QyzsjQV3HO9iTqQE7WH+XVOO8pEEecHHzUqQiKhZDIUHVRzdGRqMKPNivWMtj1PIHCle5WqG6at0/563YHwIJuU2ctZPAFtiLU9MSSSRE2wVMBrbek+Tw6gjb+0bUeFCFp/ToPHg68Jjw7subvNKEJDM5AoH6N02GWhzD8BXS9jEpL0ANXfXP7QLAA2zX5/4AZSdBKfhYmXuVfO0guDzDqqo57yKDno+C/F0Q27d1N+ZaSjdyKPezUTipWpUeEc16FFY2mcS660Mnan+teg4pWgN27wtSGhGAuOlYl+qmwqFhed+tYMD6UtIS/lM3I7tuE5W/6DfXRIerjLKdfjIBDHHzACqDj4+xLffCyHWuSL6lph8UDKEOnSL/49VS3pyCGQmjd437Mv58p42ZHlIx12O4seCbx1YW6JGE91lspmOw1On5joWi4asQVMoRh9l3zBcOIOpbibFRLPLquQPSfTlhHcV6ZIEVb+X9KSvQehqTM/NjFveH3YVkS3BBb0lHC7W7zWgmdheMPBTMNrKLhUd0IH6pw2xP0nIXnwXzmf1r5I89JzGiL0kmtqM9OL2nHoAn6QIWiROucl+2eFHKe34iUCU5ZXzLNXY3kI/G2p0zMPJeWwSIulJHjXtD2AYyuGOpzzIeqL6pnPE6rffZNVzBUFs/TVaT3WTeIGYnYMuQc7qwc8FgD3Ze8wO9pUrKIu8S8/Uf7xo8xzWWp/LagzBRQ2Few==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FypL5IZRuEq7AP/ndOT6DTOQjqw/wd0yWkiUQn3yeFjMBMnJLITpu2vNEBP7tm4r0RXiJ5zTkuyqE2Mi+eIj55agZf8IOkUg3Yf4zQt4ELoEyyT45f35Cj53TqveCvyLdoPUgBYCIZ+43E1fydgtkU2uSjU3aV5a1a0hn1WWItSoWj4lsNCGqMviLywqBrMP58ig07qPRwxxBVtMmzSQGzZYDFTSdvgEq3tCgjaWIabgDI9PdSIwabR9JXBmMJ/erX6Tub1ziNqs/j1gn+mtQmH6r0b+aI15zGmN3g8N7f+RR59oH3XAhzthpIenMdF+lpQMJPkvzYpKOLtk1DWMbGHUKo84x7Y3T+E6mVVbJKo/tZHGI11GmJi/f4DnLpC1vNJsMp+QWUC6joYl8a1a05fql/6xsY0lvHzR2LkPQclwtK9QFEZKSaTLlJdbgrdj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 00:51:49.4537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008006bd-c31a-4f6e-f5ea-08dea264d582
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Fri, Apr 24, 2026 at 07:58:20PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 12:12:40PM -0700, Nicolin Chen wrote:
> > On Fri, Apr 24, 2026 at 10:11:48AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 23, 2026 at 08:08:59PM -0700, Nicolin Chen wrote:
> > > > On Fri, Apr 24, 2026 at 10:53:49AM +0800, Baolu Lu wrote:
> > > > > On 4/17/26 07:28, Nicolin Chen wrote:
> > > > > 	    mutex_unlock(&group->mutex);
> > > > >             /*
> > > > >              * FIXME: Mis-locked because the ops->probe_finalize() call-back
> > > > >              * of some IOMMU drivers calls arm_iommu_attach_device() which
> > > > >              * in-turn might call back into IOMMU core code, where it tries
> > > > >              * to take group->mutex, resulting in a deadlock.
> > > > >              */
> > > > >              for_each_group_device(group, gdev)
> > > > >                         iommu_group_do_probe_finalize(gdev->dev);
> > > > >         }
> > > > > 
> > > > >         return 0;
> > > > > }
> > > > > 
> > > > > Will the change above trigger a lockdep splat due to this "mis-locked"
> > > > > case?"
> > > > 
> > > > Oh, I missed this one. That's a good finding!
> > > > 
> > > > Perhaps we can just change it to list_for_each_entry_rcu holding
> > > > rcu_read_lock() and drop the FIXME.
> > > 
> > > You can't hold rcu across that function IIRC
> > 
> > Oh right. I didn't think too carefully...
> > 
> > I tend to keep it as-is. So, maybe just list_for_each_entry?
> 
> Does your series make this existing race materially worse?

I think it would be a status quo.

The only possible place is __iommu_group_remove_device() that this
series touched by changing the kfree(gdev) within the mutex to the
kfree_rcu(gdev, rcu) outside the mutex, which actually added small
delay. Though that doesn't fix a potential race, it shouldn't make
things worse.

Nicolin
