Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D1365A0B;
	Tue, 19 May 2026 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229890; cv=fail; b=mJPl/Dt51lCi+Rg3G7TnMILGcEKELBwiTyZWdM0w+5lix5qDKDd6Ydl5NnamEZtEVL3k0GyL2gGexRIhICXBFfOEVeHwYGOMb/ctmAijq1pmtFIbMY8P5pmsryLld0tRPzaVVXGBlPNDbHby52ALYPFld7LQ9PRKaJ4uJZtoPU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229890; c=relaxed/simple;
	bh=BZHt7c8ughzvqrYh55LuOw68i1/qqQenwFerjLTFB+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQv1/HVeuMBkUK17yiJVB532qHFOBa8lnRHvkKoSkQlZJQC4RTnWnn/KXc487XvbytGokkX9ojud2Debt5A4eXWrmqKYnScwt9LQu+1TN4MNK9KTHge+HxhdeoF08GBNYa0WlfykiF7kZFbFFdtJyI2KRSc+Q4T4RpbHsDPbiSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kllsOHq2; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kllsOHq2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St/bLQWxmlK0bJ1swtUS+O97+qBnMQUSLxGIzwXuoGkgqrn8fJgbv/T6EqzpQsVXpaHV7j1YZUIc91xLESxS+D70zFnr2MdjuBgxBQrTew5eNO+FY4kQPz7oscNNFFMr/zu/fSbdtuD5AEykLcZ0dkLbI3aOKtmZSut0JvaecPxFQrP+kVyI7NGhKEaYlIZmNbEBmeF6V05/HafXff7JcA8KdI77WPdTkHyamO3Z/XP+RN524XntOEUe9MLkeSW72FSOPyLv2d6kvpe9renPmyJIZo7f/Uo3u9CBuYo6st6XHgquSSMRyVnew7skSaeq/sq/aFJeGan9WEDOANHyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW4Szj4mnbVsl2PmOZmFHj1we67HfxwbNdZ3ENqEt1s=;
 b=afDRyUMSQ992FmfwQ4du/c4b34PgJvzOB9g+gEKmSi2sxkVqt+4sXJGmFduVAFAbv+/Wx6I6xMdHaQAVrnwFgqMfgq37xNPJkaDLwLB5grhPsC8xRccIeJelFpPghx/c2jzc8iwOKWjf5JKzavsb8vUo91LX2I3mXmLNwRl8sREDezZz1NvevYsql89Ij1IOvbPwBV7EHkV1NjkYRMNBqAr6XFfhi7S8M//CjuFwiGGkKEq/8dVzool9xyZWijFDJ+7CwVs0sXdMdu6J7XSsmmRJz7mxqBReFL+SW7lZwyZU7+C8BbkfL5Y8qesuN36/Adlse1lfevE5IeUpx9eZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW4Szj4mnbVsl2PmOZmFHj1we67HfxwbNdZ3ENqEt1s=;
 b=kllsOHq2N/1S7lLAH4Lx0f9y6CknnG6FRBPAlsiwzy8AgXtvJXpxFyiVhZMPcVIwnuOQngha6gsG0KKDeRcIgABbVQG7cNrjQTu4xYrYGI0KG3EbewK1eGIqqw2MuQhb6b/kkGJgQOzS6DPxRVNc360//bVtDAkZDGzEw4FAspUT54ZhTHO+EA/x5gp9+IAHhhSSuRKjc8uZm4tkHYLKhqysnb9Ugj9OA9P+4xytqeKnVdkbNG6+M0wyIvaE3ljTmfQOn+a4Bs1TK0yRzwGZL50yzFMQIjAl9bot5Royv4L5964tNenUhJFW62Vt/RzVHlYXZ4dCV/6yQOLR/Lsa+Q==
Received: from CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::9)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 22:31:21 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::39) by CH5P221CA0015.outlook.office365.com
 (2603:10b6:610:1f2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 22:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 22:31:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 15:30:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 15:30:47 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 15:30:46 -0700
Date: Tue, 19 May 2026 15:30:45 -0700
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
Message-ID: <agzkldmlG1cuDkj4@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519191626.GJ3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 94734e0e-7581-442b-1c16-08deb5f659bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|4143699003|22082099003|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	/AJe6KzXprmcQyA6o9GtbCeayRznLaKrkzioenGpbfLFpyOn2ezjXONK9mdVVB4rZr1W055Ki23z3XMJqLAZUfljS6b6cLGq4A3ESzuGOPFvjLUhgKDshyXp0rxVQEQsgZ+HOY+JEMnaEuM+HHlC8pwKhKsppfphqzNjAde1P0hNPVJZnBNen5bCf2Nk1J4+721a5/4H/n2Bl8tllOO9HDEQZGh7W3Mrki0AENrJ7lBo8KzZFq54txOmBX6dt07y29SW9JLOHqiwtwulFWO09AQ920xfUygwf/6nJUKbITZ2KFjUY9z8u0DDaMHe0k9GRx72JYhpBxOn+CxL9UudgI55+hAhGhenKRIieISHMrF9/TgVpv9eaSlT3MGBdJO60shvz83V+au36knGQANNDSkSXXI1F1EFbTy+587BSf33Q1A/vxyw++o7h9rn2Mu/fxHZEZtTIUJeEx2ODA6LLA+soonzr8ngH+y7ec+jFM/nodQkqswjd4cIqq7aAb3LR2AgLd/mk1LmpSwlcsGasp7r1Q7C2xonuZ8yJ+hb6jr4r45VkbLyv9K3axGmi+yx7XW1nZKFdn5lbPgcMNjaJ2o3V8eCCxgqcNLNwsCleb8AHr3Ps1DSUxpuUBw7sujO+4s6pwwdUv3KAJgENq2YIo5wOga4hzcFE+Hnf4mhUtDiKxr4YbzRNq6QhtUwuAzNBVb743kjhb/KP/zLgkEPRn/4JW3LQFi+yI5XI3litH0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(4143699003)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4VTI7+PZWP56DCQqDlppE+K8r1oJHib2bZt54GHJ+xX5TfkJcWnMrIBMq1+x5KDJWQBx6lv22cny7JDxw/1TLoh9vyCmpBvhOkPHcd3Ljf5Eee3E1e5ijs21Xv0NH1bGq4em9SujwKWrBnN7iAVeR/GHwA7LK1fSxM5oZcs/dgYF2EQD+pvdLYd4DygocH8dYLA83bi/aFwifzeA12jraW3w9JLvLFeGl9+7GGaX/Qnh/aVR9Nvwzjz9EqXXgmoJcaPg8qKH2jhRunWo7YyAPGYowGezsUkSmK8oRYa8IVO2tgmbvJ/IMb8nGEzaQR69L5o+KTkQhFAnJc2i3+7o+dIlz5sdage1g2Vp5bX4OXFcBfUuSV075sZrCjAKbQDXiw/BqGiClA5iUMmyuF9d0QbvfjS+dty4EdLGTpgEvx7ul+12qG6cQllhzp6CB+aO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:31:20.3634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94734e0e-7581-442b-1c16-08deb5f659bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772

On Tue, May 19, 2026 at 04:16:26PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 11:29:23AM -0700, Nicolin Chen wrote:
> > On Tue, May 19, 2026 at 09:07:37AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 18, 2026 at 08:38:54PM -0700, Nicolin Chen wrote:
> > Then, the core needs to block the device using the similar routine
> > to the reset prepare(). And that needs to hold group->mutex, so it
> > needs an async worker.
> > 
> > Do you see a much simpler way?
> 
> Put the work on the dev_iommu and forget about rcu.
> 
> But this is all probably better as some later series if at all. The
> driver can block the ATS and the expectation is something will FLR the
> device. The FLR will set the blocking and then restore the
> domain. None of this async work seems functionally necessary, though
> it would be a nice to have. Lets focus on the bare minimum here it, it
> is already a difficult enough problem without tacking on these
> extras..

OK. So you are suggesting a quarantine at the driver-level only:

1. Driver detects ATC_INV timeout during an invalidation.
2. Driver retries the commands to identify the master.
3. Driver calls pci_disable_ats() and clears STE.EATS.
4. Driver marks domain->invs ATS entries as BROKEN.
   (optional since pci_disable_ats() is done?)
5. Driver sets master->ats_broken to fence concurrent attach:
   arm_smmu_write_ste() and arm_smmu_ats_supported().
6. Something external triggers an FLR (sysfs or AER).
7. FLR goes through pci_dev_reset_iommu_prepare()/done(). done()
   reverts 3+4 and calls the reset_device_done callback clearing
   master->ats_broken (5).

Right?

Then, we'll have very limited work in the core for this series.

Nicolin
