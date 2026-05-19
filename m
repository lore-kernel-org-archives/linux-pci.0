Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17336921E;
	Tue, 19 May 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215400; cv=fail; b=fQ7aUWnSvG7SgpQNCU6/npjccetfBIbFh2ZX2qIWKjEgy+liNNKYSySnPtk8BThCl0ZTQhAs81aaFjrbBoTesbIBdFfIUhlk5M1/Y10wPt3GMrKbJSFAa7A0mrtqyoO8EnSwZgM+b/WINZAWCRETgnnTE1lWQHRAxMAt8WCwoNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215400; c=relaxed/simple;
	bh=rsLMJq1ZRC7LtffyuZBkBdvK0QL9Va0FyyKTJaQjoYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfe0JsRm0l6BDL7PwcOV2mJhYN5xmwHQaN8yExVh15GEbudVZDXCNlQfxPP0tAC9buNTqhmRwZP/IE17aawTjJVHMejMHT+vItUYe56+64gh56nvlnttIpZKIfA+BI230vOopU5nQXeAhjgks1otDQ1nXr7re8hzvkQVvNa7MdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eggrSqWJ; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eggrSqWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTrfA9Doch+UmYLxOcZELAKlE0ciw3DyBAHUvjLy5JsNfNGEuV2x+u+O4fGCOrCYtFBQSCY8RQnPt7pLNFi4JiWV2mxHREvebPo7HrdB6iPbogbXH8qaZ2CS5jHC33HBJ+aOJKRjD07pa6EbsBMvyJbmCdyZf0bWKf5/8upVz48OV9jcaViwAkQuKHeeTIcLfaRa8wD5vTzTL+XQIPYiTD3EfppDZqfu+WCpB+02ZtMYks+rdhcLhG78258XcZiCMJ930JT+iQPiKO8aOVXe4SWM+Jw9GEYMG9MDB6ZtvqysK64xBBTrH4KuXSsGekmXYoTlkg2qrn3Roc30oS2RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q67EPzlY6/81vWsD6C2W3ik8HjFvq2cVFmvqAeUlKj0=;
 b=QgQkaMa4DvPMe1zJdj3335YbjFusxwtA5b5wM1VDX96iH26GbPu+Jgz/ldapdv3ttGRZgz7xb3cZYteSBfp9Pjy4JslM1rouLZweFRQLF1tbFv3plAnqd8uKFUlnbDVWzgORsP78HSm1ej6TEt4xThW42U4t0Y9ecxUKnCw/rKS6+iy7w2rUtLQFAJvjKGC1vn/h3Qr6B7BIBF+kq0tbsRGm3Of+ftl8R0+D3/HiJX+GIMRAUjj0nc8qMVptY4Y9KKh50O+ZNfGoCkDFE5JEVfPuqmDzhvunWyJZ168zZt9DuVzDW2vs1LbtZ5kKoPL5sFGfLtxOny4MImNuUV8k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q67EPzlY6/81vWsD6C2W3ik8HjFvq2cVFmvqAeUlKj0=;
 b=eggrSqWJVBnB/2GyGk+7nEQx5bzKtHAKeoUjgzupKs14ij8oV8ioLM3KSYBuDBMzz2163OoGJf0rDsfm3s5u6hgWLKUJToLvThwCcsesxxiC6n2c039bpKLbUgC8gucKqDOXsBsbddXDBpygoY1/DIUCnzex/yP8r1Jp2zfIDEszROEuCMOOwJ8sqTQ/aJjmp4vHt8wZPd1tioKJJxxd7W61qPhc59zDHpGqRfJEMb0TRhJd7bbRYXXa3eUcMPOMxCDag8sU4rbHqwlOD8xnByWAoeKSHCpmoMjokNkFFyL37xdTHpGjjijQxDd0JDo2lGlkfV8W07x2MULxHiAcZQ==
Received: from CYXP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::15)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 18:29:45 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:930:ee:cafe::ca) by CYXP220CA0008.outlook.office365.com
 (2603:10b6:930:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:29:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 11:29:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 11:29:25 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 11:29:24 -0700
Date: Tue, 19 May 2026 11:29:23 -0700
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
Subject: Re: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <agysAyreCY4huf0I@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519120737.GQ787748@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a59d12-edc3-4e21-d6ba-08deb5d49a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|11063799006|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	LQIBxNZLAC6j5mCxOxturxhkTlKynN/9mk6+I/Xmw2FAgFHWF6b8IBt/PaoY7Mo3wgiyqbmFdNAyJjDyaJi0jgc/2PTo1pu71yecM2Y+XYaJGnqXfzrj+Qb4WjOM7AWoyIPQl4jBZB4UUCr0MUX1CZMMxTfnia+ZcKoVs6quZKE4SvP4ARE815cG0V2npvAgkIqIuo0eyD7UO0TrUCv2Z5564TklgsZXF0Oa6NSOAH7EH11+qFkJTxBxMZ754sMYOQDzWy+ZSHvPpLpRDTor1i0PnGZ4bkU8n8rfqj+moAI4KCQ4W2+ljOrvAz1nYoKlD19bUftusK9SRBCT+VYLyPFtd+IoS/xfOIAX74ar6n75Z15rv+i+uBDOFUuX1ZgqAa0lx0VcL498y4hv/ThE4G/mLK0kbYB4jmkYbRNHJ4mRRthrBSvw3UOT29BdNFSTUIrCGkYuHg/8d4mLdoOlWQFHiMzZ06d0Rz8Oi45YD9tH9DiYhPuQpZEJ98W3aIcc2Dww1sAnuRWbu2V9cMWgtdxBS4HW6nrJK7Gsp/56kzprUiGZlZy0vuvltZx/Vv9ESXv6gg8ERxgP0mRGDcmj88MnutYGCFPBfDXUYQC+Ojg81Ps+awd5v9C7Crprbufe/F22Br659yzyJo203EMNvDGrekxGjY/kG6I7BxaHWnsccOVqYXHTQhQhtGJ1wXspeGhGsvlYIp4S4CUQuI1vEY+zUEJQ7PvDOSCN5VARGM4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2vXT7NFimP7X9ZyeSTDyKCiFplNOFiCmGOUnmkDHHL+X25aG2ijC0J6VpM8dB2Vu8X3uLSU2LAhRzvni4BxNmsqi/ubBmgtCG5P+xJlNozKK1TdaTmOK/WJwbHTzqyuY1yq9QTbLA+iTfPJZVaj91TiUssGaCfMNlmjeI3DX3TYA85R1+EuiKYdkXIn9F7bcMijeVtynfK3aZEz9JGVr6X5SsaXMS/Oge2dLip6Vg5Un98pd2qWcJjuYZJIZaauhiJnZMAjrBODsVbakWmzWkeKqoMGkr2TN1v4OPEPxSacpGuMMxsGQmb/NDxZVA5F9hZdn3MkuyT3IUOQNDr57p/zq2oJuwaFkLalUlFp5NgM8rETuoMsivqvRI9dUHeGV6wCyONTNhph+37jg9dut245bzZV/jOtY+sqnLnNvGn1+UO1AQ416UFm3P2mqVxrY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:29:45.5406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a59d12-edc3-4e21-d6ba-08deb5d49a20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

On Tue, May 19, 2026 at 09:07:37AM -0300, Jason Gunthorpe wrote:
> On Mon, May 18, 2026 at 08:38:54PM -0700, Nicolin Chen wrote:
> > +void iommu_report_device_broken(struct device *dev)
> > +{
> > +	struct group_device *gdev;
> > +
> > +	/*
> > +	 * We cannot hold group->mutex here. Rely on iommu_group_broken_worker()
> > +	 * to validate dev_has_iommu(). The iommu_group memory is RCU-protected
> > +	 * via kfree_rcu() in iommu_group_release(), and group->devices is an
> > +	 * RCU-protected list, so the lookup runs entirely under rcu_read_lock.
> > +	 *
> > +	 * Note the device might have been concurrently removed from the group
> > +	 * (list_del_rcu) before iommu_deinit_device() cleared the dev->iommu.
> > +	 */
> > +	rcu_read_lock();
> > +	gdev = __dev_to_gdev_rcu(dev);
> > +	if (gdev) {
> 
> If this is why the RCU is being added it seems like overkill.
> 
> Just add the worker to struct dev_iommu and push it there so it can
> use a mutex but I'm confused why are we even adding this function?
> 
> The entire design of this series was supposed to have the IOMMU driver
> itself adjust it's "STE" to inhibit translated TLPs synchronosly
> within its fully locked invalidation loop.

Yes. Surgical STE is done in the driver. But, core-level attaching
state doesn't reflect correctly. So the driver calls this function
to notify the core (this is in an invalidation context -- not able
to use mutex).

> Whats the async worker for?

Then, the core needs to block the device using the similar routine
to the reset prepare(). And that needs to hold group->mutex, so it
needs an async worker.

Do you see a much simpler way?

Thanks
Nicolin
