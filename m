Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7119D093;
	Fri, 20 Feb 2026 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563222; cv=fail; b=bBMYX1FUA/L20dlL3UNGs4z59ZFNjfg1be/tnOPfH41TVuc6ff8U8FEIAtSZgXHVd2xccVMBsxPPHEc1YL2k98RDdkffCcaIr508AG3dMJ7XAV9Gz/w33YxczeRFMjwv1CT5wZnzOjeg6MUl8JjbUDSRlFU4y5HW2+H73VfGJLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563222; c=relaxed/simple;
	bh=rRsCaUV2mOo8mkQGNzIU1CebaTc4+/HzvhQm7sXNvl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8FD5RT97kPhsl6p6bCRHvTMnv8oJbkjXp+dAxhJ5DiSbveP4b51jSvyQfWZCh0zy6CC8CcN6zNlCaqhsCkSg2YuQmHaoCFJP5iTUhViVi5kQSOD9HKV+ej/TX0H2e4rFgHWRCh7XK8tRNZvmP/oUpQluLm8HgOPA07qMV9a78w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMJP1ueB; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMJP1ueB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AowztNri8akhOg6usRdavJHr1SRDrZFWqITl0D6WitshQnsMfdSoO/BN6OWi8Z/7VtDLl34kZ/ZmydlWZsAZHgY19ny2A8c4H9yhB1fV79LhJ5wawOlf7w0gaXTgHSd/WjYjjtox8CIKzdNNKd3Y6D+rKsSpaOpXCr2y7H5gTlbk5ZzORNas4/jbR7fcHXJBZwr6ZB6ljrtX2etKipxhtUJ5OdD54iuTiXF9OHTfKcN7TAqEWDtK8F3tKjtpwLKD7PPi8+hZ9123x6Dg9l2rp1XfWTC92bFILgKDMoVOD2pWHxuh2uBoQVPbhGDUHqfVVpCUxqCcIQ6jQFf25qBPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzNBo9SM6318MnP/dCl+Fz8uowc/qEfvDJ/FuwnajMk=;
 b=M5IlCC7pVjjP9z8l2tFEpJHttwyLEY6Hqa7nVkVcaDoiW5M3Pch9EvKfY1uEljXIsfeBprAFUvfBXAqaB568gfKiwzl1iGGgufF3u9mjnmnCogCfFq6jOrQJJMhajkDeTdlhONqEvAfK6IqzBoL53vfn7QHzksJdqi8P3MTJnfEZGzQioz5raH0jLrkl75yNSJZWBQNRTpCaEyLsdrq2SeSB9fPjCTDljMhWDCVz31s7DjDX7DwSSlnq3/C6tQr3laedwlQIQBS1v+CQDU9FDVtzu1SN+fxJPi6ZNcp6Ghe26g3e41h2X9t1fIPbnGtDUVpvTeEiXWOHC5qS0FERmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzNBo9SM6318MnP/dCl+Fz8uowc/qEfvDJ/FuwnajMk=;
 b=OMJP1ueBZE1AreN+6osdtkMwcw1pWq6pkAICeUnE2RliOnqdUrRnvfXk99l6eupuaDQAryrrL+U7oh56Cbkmfe0tewaJXAuqZMePAXUkk9VImqfU768rDO27MQ6pCkDe4RjzvXF409d6roHyqOJfDME3fJbAlWmuQ9UWPV//R/n8njuqe8MeZFc+eGvPVooeq9qUguXACrJXxj92jy4GtAWQxpFbqyM5i1WySA1XZtD9uuAWKumzOAnhpqHaDRm+3WBaNm0qq9I+cFFezOIE6u/4zsIQ9rQGFTrxInlgVJTfpR2n5vB9eaWy0QOlpCPouE/EBkfI8pcYeHKAm3it8Q==
Received: from CH0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:33::15)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 04:53:36 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::45) by CH0PR08CA0010.outlook.office365.com
 (2603:10b6:610:33::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 04:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 04:53:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 20:53:15 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 20:53:15 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 20:53:02 -0800
Date: Thu, 19 Feb 2026 20:52:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <dan.j.williams@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aZfoqETxb31jp/Pk@nvidia.com>
References: <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
 <20260219174139.GI723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219174139.GI723117@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff509c2-1b48-4421-028f-08de703c01a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3R7jp2CWKRH08YJuwNHz9clVCse5TkTF5FIFzH/LWsxNg7ONW2z8NRyLJ4E?=
 =?us-ascii?Q?TvHSs+9RbB7muJqX3map18HZLEjRcAB7q5YXQPGTDz+dn4KyyIUCqCwpC1A0?=
 =?us-ascii?Q?PxQdaJF+AM85tshtJhA6TLhZ+iru83aG50d34jIt0Gc6/j4Y0w+t7L2LAObi?=
 =?us-ascii?Q?DqujGzs5odBDiLlHfZ2U0UsPufeNplbSglxbIFRYNuNm35owEYIzyXNPnwIj?=
 =?us-ascii?Q?fsxs4/+b7P43h6r4lUi+ZJfICctWYYEnfgHHzVK6vpZ+RgrDHXe8StDnrnOu?=
 =?us-ascii?Q?LxQjMRtcuuOP+RvmwuY8KwXOI5LiugwrBVR7w1kukXrA5PX/sak0y6FxVM12?=
 =?us-ascii?Q?9sGxeIe2Ilneix7GGtLADcjI0jQ2cc23uSz+hgaaJioisRADKKPo77+r7Jdn?=
 =?us-ascii?Q?Hr+CGYhZO565dY7Kyo3CHZ4SFcS7eJH9/k0QUeQPkJuMtA/X1WGFlVO46LV4?=
 =?us-ascii?Q?OOMm7klaN0XBY0VKMzaTUT+Wfba7Q1KA5KXwl5P7rLDFmhkbAjI3sgSFC7pE?=
 =?us-ascii?Q?sQ9AttfyEP9IPxH60JYOjIorldZLDco+u5UIT6HJFyq111gw3vCnv2XTO0zK?=
 =?us-ascii?Q?R8RH38+zBoohwNY1nYYLWO34oi6BF9DGaMmSYZPXQAtGOhRgVevpbZUY1+VU?=
 =?us-ascii?Q?9GzHTB0LVUJ3MOmjk13JBKqtWS4iOq8C6rHmc2mVA+whohEe2fs3YkSxpj7H?=
 =?us-ascii?Q?tNm9d4tB5cYZ9JI+GKwPloS0gm2bXBBn4P/uA7igx1r5nOhde+TcG52A4Nze?=
 =?us-ascii?Q?nt6Lf3V7T5RS1HZMIV/tiTwIlW4OOFXFAQQA+olPq0zpobl+pb0+8iXBUo/W?=
 =?us-ascii?Q?E5I6Rtu8AdPIMWcbEag3qcP+Gms+pcfB12zvPo4kIA7ZjdJ4x7YfOKHzMud2?=
 =?us-ascii?Q?/BqpT+ONGg4j0D8RW9UpI3VfN+g5ELdweN4eyO4z/+J98ckU8RigWEw1TXvZ?=
 =?us-ascii?Q?9lwz/kjn1uokKV4+Nqaoe8dD0ZrgvpsDfpG0w/W59rBpYZbBEGxuicVy5L5o?=
 =?us-ascii?Q?L6Kt99dIFEpGVzXaVXe/xOQXSAnKlUzaJIR002qHPmVg4zRmicBBk1kOiPvB?=
 =?us-ascii?Q?FoHbLWYWY5X+gvJfhogy7ePMk7aMtH1HLR+SFAFdSio+kFoHFSoBTX47IHR4?=
 =?us-ascii?Q?mihaorjsMOVS/nkfw21AcwAGhNpyvmx0Bh25GsC1W/a/2bbuIhMIbjtL3uqf?=
 =?us-ascii?Q?EhTp8vGnFkkGTo3Z2bcyZYzw+oODQjPAILYnvplDPztO/5Cie59LTseOJFFO?=
 =?us-ascii?Q?Xj1OGDrHwGUHegHNJHtBr32ipD5cIc/JaWcS/2419p2FSd4Zu7INXUugs4fB?=
 =?us-ascii?Q?C53jOiGwMI15wxl8I6ppdHCJE47TfGXq+x6DmxUZqYWfv7DRnVRgpKnFEBlZ?=
 =?us-ascii?Q?PlQ02y6o14YbDC2Tptuvm0QdBpozt57DQSIFrWJFYdcEx/1zr7k54+DLbaIn?=
 =?us-ascii?Q?wWpY5r84E/vxwXY8crcemmX7rR1ZdF3mkxpLSkhiXbblLXsxm+QGr5sJu8gN?=
 =?us-ascii?Q?O9azpBVCcuH8rhzXtd1KVw/dfbBZFmJKcvBtMJXQm5tHDtpkKaA9seoGVLdI?=
 =?us-ascii?Q?GUwgEeo0NVfFqIolo9Q8Fcfo0aKd84h35L4WqimDKtv0fbHuo4dz895J37Av?=
 =?us-ascii?Q?NPvIVA7wVAeK1b6EjCsNmAGWcbTZk7D7pzk94kH8rJt8LZBTV02Y/0oL5Wre?=
 =?us-ascii?Q?OU0qLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1fpOQJ8RkhFqgnVtyA+baFawd2DGw4TWGytTxhhchhvz/MCndZzD+UhnEJ3oMaDl84oYlZoZtUQFJv8rlk/sSsvMfCDD5of+PI5uK0ZxiKlT0tGr+bxEqsy13+YT43PSzJ1t13KjvYI9nGHd1YcPLtIdYVcxq/Z3D9pY8JEWy03sqwOb2bBX3ki2M+aJubFAmQlfiFIDcbaas8Oi8R7gpvVOh0qMb3S/AXSSjBUQ7i/9iMzR3aLugPH/zk56Y1FJ0VspaymQ7w8ppDWcl0H9z6N5KIX4c46oX+GPdtCal7m9m6bOXPvKi0YBaE5UfqvRdGPYTet1c0oqVG32/yMw8j+J8XFIKiC1Bkyr5FC2tsaIfjwZy9k1zViqjQ169DKy+Y3CWACUN7waoBZrk+B7Y0pbYWLW8l50F4iRkV8yO9gHWY8ZOrWKUyns0Cyt6dQL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 04:53:35.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff509c2-1b48-4421-028f-08de703c01a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119

On Thu, Feb 19, 2026 at 01:41:39PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 19, 2026 at 08:53:19AM -0800, Nicolin Chen wrote:
> > The thing is that those driver_managed_dma callbacks don't call
> > iommu_device_use_default_domain(). So, the iommu core loses the
> > trigger to switch domain from BLOCKED/empty-DMA to DMA/IDENTITY.
> 
> But they don't use DMA API at all so it doesn't matter to them.
> 
> Your issue is that BLOCKED breaks MSI on ARM.

Thanks for the hint!

It actually failed in iommu_dma_prepare_msi() due to having an
IOMMU_COOKIE_NONE in the blocking_domain.

My implementation sets group->domain to group->blocking_domain,
and keeps group->default_domain=NULL to retain the EPROBE_DEFER
validation in iommu_device_use_default_domain().

Then in iommu_dma_prepare_msi(), the group->domain now becomes
valid so it failed due to its unsupported iommu cookie, which
I entirely missed.

I could simply fix this by adding:

@@ -3892,7 +3892,8 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)

        mutex_lock(&group->mutex);
        /* An IDENTITY domain must pass through */
-       if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {
+       if (group->default_domain && group->domain &&
+           group->domain->type != IOMMU_DOMAIN_IDENTITY) {
                switch (group->domain->cookie_type) {
                case IOMMU_COOKIE_DMA_MSI:
                case IOMMU_COOKIE_DMA_IOVA:

> That is fixed by using
> an empty-DMA API domain as default.

Hmm, even if we set arm_smmu_blocked_domain.type to an empty DMA
(IOMMU_DOMAIN_UNMANAGED?), it still doesn't allocate a cookie?

> What is missing is to bring back the IDENTITY performance optimization
> in a secure way.

I might have got it wrong (from the last part below).
https://lore.kernel.org/linux-iommu/20260127150440.GF1134360@nvidia.com/.

You mean to disable ATS on IDENTITY domains? 

Thanks
Nicolin
