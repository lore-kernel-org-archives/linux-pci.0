Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD33385BE;
	Wed, 18 Feb 2026 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455432; cv=fail; b=LvGvEkJazC27PS9GFFCScuCmMbGi2eVsdH41U4rW79NRiP7ZcNX1UjZ6aRj25tYZdpNcVI4xT33G23G/xi7o76J/kKg/dCLgwApn4dgYSLjXMSBCBWAGnJo0a9joh6+QIuZtnk0P1KkQ98SAEuLbWfJVHgazeNrk3AxU0gJeb5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455432; c=relaxed/simple;
	bh=55a1WIB/9Ck0xwNtS+n2GNJFET3yajqH5oOABjc7uog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvs5bImF5YQU0Pla/cNwQtrZZMbBc/vqAQWgrw5mYVqiMgKwn52/54/7Ckzuiax5sJ1cholneeXag+4lRCzN41dAYDJROqBI/6o0oaA38K+kqq7IrtJ+SpvwzYgv171cSsPQc2ynjo5C/c5TkEZKdcExwfDbFSY4MHMqdDuDpA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tt0F7Wd9; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tt0F7Wd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meCAwfdZMmncEnaAz1jFgv6z2cj3UfOYhAbc9IWlwf64gfnQXj1pWDAI/8MyZzPFrprL3iEKkpmkM6HHN+3MD9dxuDd32kyzTgaP0tWjDEq/OmUpp9KqCaUuQYZg9z4yDFXkXkFnumA3UUHZ9lbi3Ch2pt/L5WrSg6yAox0I0O+Yo8oGHFYR4BKbjNUX6VubysMbtDj8STs565bEjWcWfx+dRx19RjNuomVrH8GwuT3tzP3t3F97TQfxYB9EtSBVv1Z2jwlLfstvZurj6CIVOupIOPAhJ3zTe0GJ5A9WsoHWOl16dfaWGXofahRznorP4nMVTI3Poo4hQuqad/UMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pm+Rs7NxBOeLLWdS8J17f5KYc9O6VEue4HLylO68HQ=;
 b=TOLkuzB7JPnItOC5k3xv+D1xYENxTTZEW1n7bivot8XwlrOkXWc7R3FCSATrwf3o/Ut1MKuWBCyDHRaRhjBrcRd9cFihHf17/qTcRRvGtUBHrC0dXSyqTX8D869Juv0L00xRwAwmhjS6eRuAnBmc788Cxo4C6/KxdFtRvgBHX/xMWB70BbF2w8iw6L/zt2lWMSH3iyEovBIRV4bTzOockWJ9fF1N90BP+WcF54PN9OdA92OLuTBaYUk5Tpu73EXf38D46YbtU9Rrn5FsAWDUl2yVKWAuaoMX/la3v/By0OUASI4t7CvHdHOnZ7dZa2ufKrzB8mIbDoMytO/k8k5YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pm+Rs7NxBOeLLWdS8J17f5KYc9O6VEue4HLylO68HQ=;
 b=tt0F7Wd9FQctfMNcVl9hx2QfT4i1Tfrt0MnxWPnTzDgTc7fIPo9YTJA0i4UUSAkVDehUdetOSAirJzW7JrjnIOnaZqk6R/jOjCkBtCGPLh9zjjcU4q4mD9Pszq1u8kF5E7Wwgd4WX8yulOXcSTqzG+kkCkhewqfngWR0I4kZHcK8InBmHiLV9kPxpQUnaNqlZvH2McASy3N4lbPLS3yuMTpknEYpuDnOV2zI+AMFjkpMZepy8afbod5i+hQK74Rktf08geGyLuavMK+97lGCi0qE1JVUqB4ftxyghRZl0KQ/C7d4/nddJH2lrGLuv3vSc0RybA1fKe0caLKJERPqMw==
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 22:57:00 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::8c) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Wed,
 18 Feb 2026 22:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 22:57:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 14:56:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 14:56:36 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 14:56:35 -0800
Date: Wed, 18 Feb 2026 14:56:35 -0800
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
Message-ID: <aZZDo3BeuBKh9q24@nvidia.com>
References: <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203175540.GC3931454@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 657f6947-4aed-4abd-3c08-08de6f410694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bd+s8jxwXCSrh/coZw4CV0h6gKT8s1xBIIYikQhhRIbLRtY30vgOtTpXePq1?=
 =?us-ascii?Q?m/HwwVF/YlsN1aZwKtWqq+qPBG4KjlVN0oRSmXzbnV0qbPPeSX/708CjuO+r?=
 =?us-ascii?Q?kNGiJntLmyaGljXxKjdZAnQUiwwqw1iD0Psy+U55E5b8n36cGIVhopRXlWKp?=
 =?us-ascii?Q?jQIX6hAyLAkjJquMIjY6tdHi3f1U1RA62i7X+4kkQl4yWbsD54KYqcC5pEVB?=
 =?us-ascii?Q?Dyl93WCNyw2K3wj8GiSHCbNy3m89XHiXzZK0JCgohlBoxR/MDylaAtFUy57E?=
 =?us-ascii?Q?J64ggtkvkeHEcUaTyViRu/n3OlQHI9+f75X6ztE/t9yHclKTvHiX9YZj8PPK?=
 =?us-ascii?Q?iwvle5HEuAhnC4rHZj5Y4yW+sc/YJhAIoWZ+tNkgry777ntdUkDDJxa0+7PC?=
 =?us-ascii?Q?IrM2sWCUCTM0PuxBB8gRLPKjRTou4Ti3VsBqkG+ODhLMPUJ69F18697fL/vO?=
 =?us-ascii?Q?fNYFWL51hhDbppfyjuhk5kxR+RP3ZSInNW4Csf+4hLjs0+eVgdkOEkzRJiyn?=
 =?us-ascii?Q?ayFBqR6s2A/z4gWQHIU2q3dr0j0cNzrDNKwy0NwqZL6QrQNuneqP16PMzg4S?=
 =?us-ascii?Q?ELooZNIaGLW5GMGT8lwQCH8DTVZD9JADQNPJcFg8FjdtVk3c4hdeZNf2qYOD?=
 =?us-ascii?Q?N5X6G3d/P+44GVuiir7E6//vdk9dpGkHofXui/xMw6WrA6ehF+F/e0scSvAs?=
 =?us-ascii?Q?cCaScfagRceZGdFSek8yK7Jtey8EvbJZ3froKTbyBRwO8PjlKbb3YoBih3qY?=
 =?us-ascii?Q?6/9uTV9q5n4sb2qbNvwFTEXDZX+CugGzxtHOOVe7XXG0/jxmV/4cggA0qg28?=
 =?us-ascii?Q?RKx6axgKbnGa2H0Qb/0jM6yhvAPkdBlUrZ4vJYwIMfOtF7bKX/r2xoB/ZbP6?=
 =?us-ascii?Q?ybldMiZwomTQKYXKRU+2o2wVqkJvfsJL2lKP8VR+NEJeYb2cxJz3hO+4lgWk?=
 =?us-ascii?Q?9KDkjG3/NiynAuu9wcJjNlRgbgV0RAfO0DJNd6+1Z6TAD8CgYZ87lWJE7zX7?=
 =?us-ascii?Q?8Rd1bII6bPFzId/5Xa+1vfQ56alwcXcW8xLLITlKvCRIQXMfGmqI/yjdbyBZ?=
 =?us-ascii?Q?Gv5bj0z6b4Pt7t9pMJMSz+4SRWO9vpvOt+8KYn4LTI22J4cNqL6VQcj71KaW?=
 =?us-ascii?Q?QDLrZ73DjtkT1KJlfRfbggDWMEV7xBlYqcdtnIliyP3jQ+LP7Nz3JYZBex1p?=
 =?us-ascii?Q?JsdVIssWEcQNZVtLUdNXyrCGpxisUe1q+P6EOEHOaGD4LLExcM3i5ommIiFX?=
 =?us-ascii?Q?BXOoIWYnp7rvjcUbV7WdSbN0sIgdWKtKjlpmLoimo76QShcFEZRC9w5K5hch?=
 =?us-ascii?Q?ED47emDw/ljnn5i2Q4ChG34Bv3sGhi0e6N8StJjp5N7hQ04aD119hg3IHp/P?=
 =?us-ascii?Q?+pkwGhoVetNRcKTLJhVOe46GaUQacIm2N2ljJdY8Y0V0l7AfhH0G30bA8OA9?=
 =?us-ascii?Q?gCAaFm91exqegTN/K36ITqDuLK6R6oR3zurGf4tDWwdP1+wcqgIUe+7tSZ0L?=
 =?us-ascii?Q?fwd3okbsxysb1DPcHazSPXUgQPnNG6XZ1jfjjn9bwh9PMFmtyHsHjaTw8Ce8?=
 =?us-ascii?Q?SZel1STA6A/Y1+UtrvmdrLrUcmEHZzWAFtgD2fJFRWakqoEPI3BMumfCVRae?=
 =?us-ascii?Q?7QPg4A6QGkkxMgh9iEZx5BMQToAp/9uk+O7AZ6s2Izm2+mV67Ya2Z97ip4UB?=
 =?us-ascii?Q?nsqZNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WYq4796FsPFo6dT+iZtbI85y/K+vJaWnpOSA5qyqnxsnardD0iqtR7OaQpaIRucayEhOTclltjXTq2qwhgXeOgPC56/qoBeggBM4lDyOi9dZC6OXfrTWR/vhUKgF0pvsNT7+WVv/pXtUVIatm+RoUFZwKgFJqFhVyUK36opuHoy8RyIjXHiMrSMEdBgxd4+/a74iShN+NmT/nLs8h1PQL8tq35W6PlyNMD+oAgbnuA5erYM/mpXRZo15Ds9rxUFe9ZHyjXthpScqKg7hVZUjAeG++sYPnrkI7V/qR5FH2JLuMpKOP3AYMXKl/EuX5/Gf/I6DiJuQ+NKnRSlKVWLhX5oxctS2bq0s3o7/12VyzGsowivcwei2N9P3ZVxK/awYBVShLe9b2YqFoZs/TDKLdb/X0GMyT3YOXrJCCMokPZbYcJi7iqJgr+TRw/nMQG/3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 22:57:00.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657f6947-4aed-4abd-3c08-08de6f410694
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

On Tue, Feb 03, 2026 at 01:55:40PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > allowed in general if require_direct=true. I assume this case can be
> > an exception since there's no point in allowing a device that has no
> > driver yet to access any reserved region?
> 
> If require_direct is set then we have to disable this mechanism..

I found a corner case, which might be another exception here?

Most of dma_configure callback functions don't use default domain
when driver_managed_dma is set. And this breaks MSI on pcieports.

So, I am thinking of doing this:
	bool is_pci_bridge = dev_is_pci(dev) && pci_is_bridge(to_pci_dev(dev));
	[...]
	/*
	 * Block translation requests from a device not bound to a driver yet,
	 * with two exceptions:
	 *  1. IOMMU_RESV_DIRECT (require_direct) must guarantee that the
	 *     device always has access to reserved region(s)
	 *  2. PCI bridges (pcieport, CXL) skip default domain setup in its
	 *     dma_configure callback function due to !driver_managed_dma.
	 *     On the other hand, they require the default domain for MSIs.
	 */
	if (!dev->driver && !group->domain && !dev->iommu->require_direct &&
	    !is_pci_bridge) {
		ret = __iommu_group_alloc_blocking_domain(group);
		if (ret)
			goto err_remove_gdev;
		group->domain = group->blocking_domain;
	}

But I am very unsure about the other cases because it could lead
to some "regression" due to this new restriction.

That being said, setting driver_managed_dma while relying on the
default domain somewhat seems like a bug to me. So it feels that
we should fix those drivers instead of making an exception here?

Thanks
Nicolin
