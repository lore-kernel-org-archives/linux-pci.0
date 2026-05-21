Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AA363097;
	Thu, 21 May 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385532; cv=fail; b=CF70CBi9xOyqGID0k/TbpcBcIqLG6dKiSUTSoO3nyXjIgbHkLMKknPgHsPcF64Ylegiuwa2LsZc4qrPLCeTu2uBrjW2GRW7pcN5+xTFwNjEKSsLqPsgy43jPrWdz3YdkCkgp1/mDjmEEh9iZ7J9ssXnRc+I2DcYw5cAa/IXSUKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385532; c=relaxed/simple;
	bh=FhVb14gDBFzkywu6gU/TUykG3/P6SOj1uHzMvcuEw8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAl70p6JnxhWTTg8a/rn6Ajqv+H1l2adVK+IPo0m9cZCv2kh8pnfUrQy05xibU336c+DR3PpOSqLB1/PZ/OdxmILXDVHOWxXzrPkl4F9Isnza+WAqtZVGWLRkT5f9r6CRDGC94IMjEe1HB2pqSfzjwXOAg7hZWi14WPxJcJ/P24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOYB4XGu; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOYB4XGu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LETUtezBm0wzqMjV+xVvh1zSYr4fT/TXQxJ9aIJrJy5XNh0+AUqR03WEHZNU0xRnlDv1h7BH539XKMvK1WNcEgSlU1Xtn+OkZ3viYOH/JGx5bLwsASfT/fo8Ed/S2f8d6Quep5wxEKn+dxXEDcWFa7iWfW+LmZHqAjPrxI4mmrf5sf2w/dEiSTUfJH2PlZ2Ctf1sGOK5Yv0TcQoizVq7n1qwYW0erYldlUK5vrLTgwxUccv6vPIcLzaUGsKtcaeoMWth7Vlhy70bP5Fbz1auHDWl9puptPSVgZbLw6CP35VPbU3SUYjLqVfpZgryk2Rm/K7dmXWmRS/xonn4H+OccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS6fnA3lU2D/+Z8LnfqqCPtAqVL4T2HGREkrLBAbKIc=;
 b=fgWOFM1MIvU77GWlf3o80++W7r4uE6rBFPsX6Qf+Woir3I4lPKjxilXDXJ7ENVBbAx9mE1hd5d1uPVWZZIHRGol501P+9NtS6bDvOuT3qdqluF/R7c5x7tCR2caxgEXmDH8vC/txbbJkkbyqRTWLdalX/yV081+BAcPChwhwMF5RNpZuV8nS3VfLq/uBtwtXa49yMJCSFWCZKx+qRMvjKAiZWLPQlVKuruc+x1owRA8VVdJLHyXTjpZJX5DHQEk28TYFI8Q5L5MVYbKHBjJqG0yawvArCeu78DJp5mkQq49jLD6lR4LGHV2OcQ67bvPZxBX+0Zl17UwArswOE1CmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS6fnA3lU2D/+Z8LnfqqCPtAqVL4T2HGREkrLBAbKIc=;
 b=FOYB4XGuGq/41vvh3eL+vEJp2viDczaQYvtVC09HvFUTQ5qcdEpfG+gB5KhmIqO59O40Mo+LhaV3+4IIRfGScL5g+F8GpXGUiOtV+YvG5FiDYXy9sPYbbiI00pJ8bUvOKpocFaBNqFe5bik6xmoTM+Us+P1FUkT5a5oZbKlSQx0uzJJRJwldl/f56+ML508/E2ipka9cfwStgduXdlz9XhanwsMsCH1KYzuGkshVXhqMKIyRZoa4Ub394b1vTQRnBGli5uzdVxrvq+RF8vUbBFJo4ytYW1f/ZLqLsEGoseCoONh0fhxL2J1C6rwS21zyBC9/wyHxZhtJQC+GiVuYQw==
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 17:45:23 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::37) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 17:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 17:45:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 10:45:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 10:45:02 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 10:45:01 -0700
Date: Thu, 21 May 2026 10:44:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<robin.murphy@arm.com>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ag9El9N4CiBu4gPx@Asurada-Nvidia>
References: <cover.1779304390.git.nicolinc@nvidia.com>
 <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
 <ag43NP4UiS7Z9T6q@Asurada-Nvidia>
 <20260521134409.GG3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521134409.GG3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc38333-d4de-4a95-6d4d-08deb760bb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|11063799006|56012099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	jVaCFrMgb8PVU44UR+FzIujRbMc/DWQ3InH8UF8wRt8lAwT5yfpjJ6Pa20LTBwivthoNvQe+gXy82ck6MTF10oc6V+fmuToD0HoM+ZkJ+ooDUbQ5oDwosaoW9VflDdS+VLOdt7DLpu0n1Z2ikz7LFUJxIY4hJpREeGRmlCC9XXeL9TpJiRG/xZXd+8LNZsfg/wlZSbNuL9lGFzuNZE/tL8zctgVRiV1+aR0JZQbu1g2vq2rnezjFf9zcRgfgEZYflZJp5pB8qUg2D3CWC9fv11GzLlJS8rpErQEUlgZoEzvRFs2WKdKerZQ6QyfoQ/31AkTcv8wrLk2vQva0EbufFyNDrXFC+cHC5xWjs5n/TLnIhFofWEje24poCKv/xLjlZRpTjO2630Klj5hR97s2XRcopzC46JLxRrTqawVfEFb0lZ3jLigmQKyY2OQgch3OZyw7myu42lIbYzXZ3FV6bYhcl8+oig5k3IPW/MrOWvmaVcrw9eD6R1SQdC2DAmhgEkO6FM+qitUtGW+ZctYKKNTPPdcPSvfVZ93v941VjWavgzl7gN3d1sPKc76rHfPpnuljxGhNxd4vw4PZBpkVpGT+51O22Z4+J3Wae7s9WOFIVC7rss7yurfISode8fHajMlgzXgCbw3diBcws/85c0tsDXwa3ec404862zeWxi1h8ZdwvdXJUdQYwKdms2a/CUUt1gIaItOrif6SPTqqcZNFKQzb0/Q6NC/AQaoP97Y=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(11063799006)(56012099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5LSmE+lN7OMQsDlTrdNnXK3aw178rYJ/P4fIxzhQVNc5Sl/W2pG8YLbAfBejUgQleYtq7pyUzw3/64Hsts2KuS2pxDbLxDfq2qvKhkB8r6HH0t/h/hFRc3jHGO9sLvNeV6hRi+sa78gxrd0aBXv+Hdab7cij8JFl9a5qu3MuuSRSja/MmQi/rBBcRxaNaq+Awrc0PX+HlcMOST0QspixrlutykMROYEZViA6E5iCCCaGeNtYWb36cLk59l4GiUUcX1xsWA8sZBMGFQKqFYwwg/RG1qimeereUX9WwOfg+IGXh9ZUvRkvzA9EXiBX4hXZq5YoBrvmZZ5Z7uLlSiUI6YDXkaFHZYy23HIY33DXcOtMkvzUfHo/Y3U3PiLOsLQpBQ4ya8UfOaRkT4ynp9W0Gs3R30XWjFp+JZYtLxx4qqWYGleGYVeMFDAjm5nl5Rf5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:45:22.0719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc38333-d4de-4a95-6d4d-08deb760bb71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

On Thu, May 21, 2026 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 03:35:32PM -0700, Nicolin Chen wrote:
> > @ -3870,13 +3870,15 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
> >          * When the last user of the CD table goes away downgrade the STE back
> >          * to a non-cd_table one, by re-attaching its sid_domain.
> >          */
> > -       if (!master->ats_always_on &&
> > -           !arm_smmu_ssids_in_use(&master->cd_table)) {
> > +       if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> >                 struct iommu_domain *sid_domain =
> >                         iommu_driver_get_domain_for_dev(master->dev);
> > +               bool ats_always_on = master->ats_always_on &&
> > +                                    sid_domain->type != IOMMU_DOMAIN_BLOCKED;
> > +               bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> > +                                sid_domain->type == IOMMU_DOMAIN_BLOCKED;
> > 
> > -               if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> > -                   sid_domain->type == IOMMU_DOMAIN_BLOCKED)
> > +               if (!ats_always_on && downgrade)
> >                         sid_domain->ops->attach_dev(sid_domain, dev,
> >                                                     sid_domain);
> 
> Only identity should remain with the CD S1DSS STE, BLOCKED should
> attach the normal blocking domain still

Yea. I have !ats_always_on guarding here.

Thanks
Nicolin
