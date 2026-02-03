Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255735D5E1;
	Tue,  3 Feb 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095658; cv=fail; b=OsEQdAYiP7UUdkDWdgcPZBzXny6IqPPbYPQYP+zlQBteqnrpNSOjwPderbt3pA+gOmXIGUlhuU+ipzx6btYp7SDqP7RVPzNwUKnHzyqYUwwKJ87w1jr+NmMd/gDi2FjfadVmqOgRachjoBT391AoIZpjJUe1OE5sgqnjljoJPh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095658; c=relaxed/simple;
	bh=/4VfjKG5EriOgQCcrOQHDyrGVv4RaYy5hCkumyVM7rw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL1vdVVTJ4eaxjVW3cEqJ4W8ZVE4+ed3LMltG1dYLLC96ahBS+hNQhgMDa5Ct+YMLy46YprdzUPw1vwVFEqD3CsyaLbG5tdLnyKkggXIEZ6dvKdXZcV7Qp06NGK3zeG3B3vv2yx5fbAD6TLTVL6RbOKMb5xtEalPLTX1+rmuw/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ns0uI43z; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ns0uI43z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSn0dTw3rDdm361WLMFWfOSWkkAVnmylvKGhIEK0sJr39icCDGYFwt9V7bL22897FnJ7fSNaI+5dFGPyZ8pb1QkhMptPzIfpdZhqQ83c9/z9KdihK/lVpAPpON0sDrFIOG1gfsTR7bSt4ldGU9l70HueJAbMbNH+/QYTKxI85MbosCc24eaUeUbovcyXHmPksmDq0kikvkAZ1063nHibrOEKsAsC6Vd7pC5ZgpcETiiiHLNQNUW2Ioxc9CYxlfkhiu8mGOlmrOL51kBm+wOA2SNFyRugk/KVUczTBy+TxVdRzI37w5mqIaCbBmXRPBbcIW8tGPGLddwD42NyC8QUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54tebQSuSAV5xmKJTTtq+UnKGS7GmY6XA5MnuGaJBMM=;
 b=U+eVE6fYSEfZrblhPzq+koJxekMaYjjnOhg71u7F/6idYbbQpCpoe+uANOjgkmjgatR1H0tzH3fgwS0Q9jVFOO8+6tV6YaAWyTi1lX28bfpaNXPFbyF7qI3rdZWGbjtkQGCXjC7gSK4BTr3WbOpFOMkQdGhCvFMvgXM2KpJNWPE3QNCNJo+2P82xyOHTiXvNhDTggPy0NXG0F/TVncuCddnV6tOeDNFDb2JmAtG/IBdY9+1m/H5ShzUb+tEejohuU2R+SpsvZZygwo8xZCKry5a6HscpT0swHGLurL/7lPQVJZ6takXelQnun3nilDHPFbCVTMgaAZtCVLjMNloSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54tebQSuSAV5xmKJTTtq+UnKGS7GmY6XA5MnuGaJBMM=;
 b=ns0uI43z8fD6PFn6T6DREBCdj40JDl8rb5VAK5D7aVofpdL8jskq4meeC3LObZcIiVwWzF9g26UdDb+NH8AmHZHhyUtwPL/zd8FxaZPt4JHPa7ou2ZBT1j12CEHv/rlj/ZcJpnk2i3Vk1XdVbKRLREVC7MoFosY/q8Xv12UED8Ye5qALhmdo+x9E+mG81eLnrhKNDxaR776ahX9pVNB2WYrQCCYCFQ1YFBlS961OIT8QXOgEQkIzcBQvmI+bHqZJ91LS434jMYa8H8SZE5960rDtxOlM6fPnR1ax6NeDPQm83vIfYq6wtwc0kBu8qmpZEqML+zF3sEm9yCIgNbKdjA==
Received: from BL1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:256::14)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 05:14:11 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::6e) by BL1PR13CA0009.outlook.office365.com
 (2603:10b6:208:256::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 05:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 05:14:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 21:13:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 21:13:53 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 21:13:51 -0800
Date: Mon, 2 Feb 2026 21:13:50 -0800
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
Message-ID: <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
References: <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260128130520.GV1134360@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cfb1b7-2c57-43c3-2959-08de62e31120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qa/FIu2EwzPmyEpYAwr4rSVQsuQ33c++F7///2HRwEyg48CTXmHbsGZQBOhZ?=
 =?us-ascii?Q?0rb/FMF48ioZfxzKi6VNAk5G3W+qCJNxxwgXsFvWFUJrt6j3djz/MBFcrTkE?=
 =?us-ascii?Q?9raaJG1mxR1Rlkaku1AGG+70wbPDP6dfLQM7gZPmscjC1/e9vEDLVNOWn38d?=
 =?us-ascii?Q?7ugWgfxJ1D+Zr3zMaNnS6Qrc4b6puQ2SRjDSKAD8ByGXYpjNZ/3/rQEt5zk3?=
 =?us-ascii?Q?E5pvyZ7NIFOgry5cHXn2QUcY7qBZ5wBOaq6t1jWaWb6XKgIg8Llhirw3DcDb?=
 =?us-ascii?Q?2dACewruXEhmh9l0OTieZyHKPJv8ySSkrLkXhdhfoUpbravvB/dClVZmelZ7?=
 =?us-ascii?Q?7lNe+8jGbnIzqLndM/oPfFGWZD+4SjGlJ2pKybWbHUhsUy8BRUmrGpPuKYyH?=
 =?us-ascii?Q?5stpmMBFCaOLplnpS579O8XGol6tPq80dEYCLs3Evz38yJwor/6IAoABOP28?=
 =?us-ascii?Q?dh/RbfKTiBwWuYWMJuoPGljpM6+UjHmmV1MM1YbvLkXanEMxlFwyyYMwamMU?=
 =?us-ascii?Q?ma+IoB6L9x/au1F7BHQtBRGxcKTkfwuVW+qgRIBmEfdM0hn7L9ZwUg5i97IU?=
 =?us-ascii?Q?9JCTyoW5BpWDEXGUUujer+dVd+PY2UwG2AwDrHUmAJmneSJ8gMi8BuSY1VGd?=
 =?us-ascii?Q?EBRFkBXYQtKyJpsiKxqNqwpv8UwG0I0tkuQFOzeIJDhmntIxSUKHwbXfXTPF?=
 =?us-ascii?Q?Ah/x4GENqbUjkYNaqZkIz2S555ZBXAKRMLqfI7ic6Mh0uqXBPO37SVU2BQB4?=
 =?us-ascii?Q?6aYg+0bsGsyGGegBgh1ehtXV2cURO3Ndsd5xcD2aV9TJUVeksKhm32AjKZrT?=
 =?us-ascii?Q?3axjR/eD9W2zMrYrhndXwBUgeWd277a9KkDDHAIduFuEa+F/EVHmudQwbIoZ?=
 =?us-ascii?Q?GATOEPClR8H2a1F13g+1EogIp128KlKcy/6ygJ0hV8mpHBGHVmW4gBcoIMgg?=
 =?us-ascii?Q?dFtB/eGz08UvZE/OP4jobcFfBIuvXIFIRXCxG1FwBmwR8VdhpTADXSQVe0ab?=
 =?us-ascii?Q?kYQ6RLlipLtgxZhIvX3jbFzmn6N1ElJiP2Bz/Xh0kHpFyzsQYBMFcA3QDvx+?=
 =?us-ascii?Q?EttzOt6O18KPE7Pzr5K7mcToyH/fqrKtr/B6RSvdiFabGwbPUjp3zCgI2gPN?=
 =?us-ascii?Q?95XNposZr3obQav1o0NhEwqARETo1drrkmpgUu9ssUN3utGRctpR1iMS9PL5?=
 =?us-ascii?Q?yTEr8K1HSajIjynTVrzkjBCzIcBZXwEFnKjtZUcZYITplIVeH8dP0czup9AF?=
 =?us-ascii?Q?wAEGav5ZROgWTOGE5Zr+Q8i2/xokoKE3mUHyYEANPBNEGKsD1arzJJ8kCS+5?=
 =?us-ascii?Q?gL5QkcVVtIdp4voX7VHhqOxb2HzQ/dcwx1Q6kUbdlFYmYmqKqHE/oWyonArp?=
 =?us-ascii?Q?2gTlQDz1wd7dDw5hJaDHbYUQpBVSvrxmbWxUoZ2TFy6ldeEUvn1UVPWDzkLo?=
 =?us-ascii?Q?aR+zKmDRTlIyMvZqQxf58NyYPa6ePqOT/MIQjHBtONfLT03qydAm3azIMjhn?=
 =?us-ascii?Q?otKp/1uD7mtmxN2nq/DxWZG3Sn/rFho8Bfb3Oo2/9kfXqIV3yS5dK8zOxEtA?=
 =?us-ascii?Q?q9gCe2SkXZIx/diCk1NGaiS2Sr/MVfALYxv3oImu4HA8jzj0YH9QhipMIG65?=
 =?us-ascii?Q?qwIeWxI7OFTf0KteXuZNX0qlcCajKEDKg5W8tBMTh9C4dvfZyOvXSfYRYF5J?=
 =?us-ascii?Q?W3YfHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OFOIVskXnTIOm4/fdPXaUTuM8/doQBg/91gfDE+24scNMvoSfuIzhBKoGt4gDa/5RV/G91QbftEKFcQQJdavpKeyiTb3sWwwHASk8U5+puQwCVkzrKlgkxi67eeukZmaMmUGNoJsJIdTwcq59CiUYASliLEnWhXOkhP15JoR01YlE7+blvJUDZ++qQJTL2TiD6wu8iNubcvQYbOnBenzWsPlyPLIpiPhMGxPpRJ4v2HjlwOatPsNkRxmQeaTtlzxlaoRMUFfrNdJhxUh/0Qxh2haBNl6RDTq7OFcfDPVIFMU0souCAQthAMNbrOz2qPBzOOTA4aIwPlmW778ejIxZatpWaigBbvLvR8iltLpNrBt0XnP9bE4IqTigcUr5BsMjZeve4Q22094Vxz928oFeu2nWyBD/Hq0VPlrsBTJxRffT+GXB7vXTey7n68Ip+3d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:14:11.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cfb1b7-2c57-43c3-2959-08de62e31120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

On Wed, Jan 28, 2026 at 09:05:20AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 27, 2026 at 04:49:07PM -0800, dan.j.williams@intel.com wrote:
> > > Yes, ARM took the position that ATS should be left disabled for
> > > IDENTITY both because of SMMU constraints and also because it made
> > > some sense that you wouldn't want ATS overhead just to get a 1:1
> > > translation.
> > 
> > Does this mean that ARM already today does not enable ATS until driver
> > attach, or is incremental work needed for that capability?
> 
> All of the iommu drivers setup an iommu translation and enable ATS
> before any driver is bound.
> 
> We would need to do more work in the core to leave the translation
> blocked when there is no driver. I don't think it is that difficult

Hmm, not sure if we could use group->domain=NULL as "blocked..

Otherwise, I made a draft:
-----------------------------------------------------------------
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 349f31bedfa17..8ed15d5ea1f51 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -437,8 +437,6 @@ static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
 
-	bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
-
 	ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
 				kobject_name(&dev->kobj));
 	if (ret)
@@ -638,10 +636,12 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
+	bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
+
 	if (dev->bus->dma_configure) {
 		ret = dev->bus->dma_configure(dev);
 		if (ret)
-			goto pinctrl_bind_failed;
+			goto bus_notify_bind_failed;
 	}
 
 	ret = driver_sysfs_add(dev);
@@ -717,9 +717,10 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 probe_failed:
 	driver_sysfs_remove(dev);
 sysfs_failed:
-	bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
 	if (dev->bus && dev->bus->dma_cleanup)
 		dev->bus->dma_cleanup(dev);
+bus_notify_bind_failed:
+	bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	device_unbind_cleanup(dev);
@@ -1275,8 +1276,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		driver_sysfs_remove(dev);
 
-		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
-
 		pm_runtime_put_sync(dev);
 
 		device_remove(dev);
@@ -1284,6 +1283,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
 
+		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
+
 		device_unbind_cleanup(dev);
 		device_links_driver_cleanup(dev);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb884..af53dce00e29b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -106,6 +106,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
 						       unsigned int type,
 						       unsigned int flags);
+static int __iommu_group_alloc_blocking_domain(struct iommu_group *group);
 
 enum {
 	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
@@ -618,12 +619,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	ret = iommu_init_device(dev);
 	if (ret)
 		return ret;
-	/*
-	 * And if we do now see any replay calls, they would indicate someone
-	 * misusing the dma_configure path outside bus code.
-	 */
-	if (dev->driver)
-		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
@@ -641,6 +636,15 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	WARN_ON(group->default_domain && !group->domain);
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
+
+	/* Block translation requests from a device without driver */
+	if (!dev->driver) {
+		ret = __iommu_group_alloc_blocking_domain(group);
+		if (ret)
+			goto err_remove_gdev;
+		group->domain = group->blocking_domain;
+	}
+
 	if (group->domain) {
 		ret = __iommu_device_set_domain(group, dev, group->domain, NULL,
 						0);
@@ -1781,19 +1785,70 @@ static int probe_iommu_group(struct device *dev, void *data)
 	return ret;
 }
 
+static int iommu_attach_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	int ret = 0;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+
+	if (group->blocking_domain) {
+		if (!group->default_domain) {
+			ret = iommu_setup_default_domain(group, 0);
+			if (!ret)
+				iommu_setup_dma_ops(dev);
+		} else if (group->domain == group->blocking_domain) {
+			ret = __iommu_group_set_domain(
+				group, group->default_domain);
+		}
+	}
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+	return ret;
+}
+
+static void iommu_detach_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+
+	if (group->blocking_domain && group->domain != group->blocking_domain) {
+		__iommu_attach_device(group->blocking_domain, dev,
+				      group->domain);
+		group->domain = group->blocking_domain;
+	}
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
 	struct device *dev = data;
+	int ret;
 
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
-		int ret;
-
 		ret = iommu_probe_device(dev);
 		return (ret) ? NOTIFY_DONE : NOTIFY_OK;
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
 		iommu_release_device(dev);
 		return NOTIFY_OK;
+	} else if (action == BUS_NOTIFY_BIND_DRIVER) {
+		ret = iommu_attach_default_domain(dev);
+		return ret ? NOTIFY_DONE : NOTIFY_OK;
+	} else if (action == BUS_NOTIFY_UNBOUND_DRIVER ||
+		   action == BUS_NOTIFY_DRIVER_NOT_BOUND) {
+		iommu_detach_default_domain(dev);
+		return NOTIFY_OK;
 	}
 
 	return 0;
-----------------------------------------------------------------

Thanks
Nicolin
