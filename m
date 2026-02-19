Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A214A4F9;
	Thu, 19 Feb 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520032; cv=fail; b=kwwMynb2E6WyT/5rb+f3GaQoO52r4/R0I76iaTH9SCYP3EAYmflw+TeaOX6dlAAW7/rymC9IoXNZrtpqYZ6Dzx/y3uSPGMHo+m35uUOooOdJbhZlHtW+nPbwsEMLiBmVyxCGJ9qZ5IxxGIo4qStuhj64jkSmOOO3ava/+TZGY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520032; c=relaxed/simple;
	bh=FnOgwdgtD7jSMzuKhJnBvA6uz7SMpVsSXBLTChmpMb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=are9Z8u1iHp9Lmg//07Zwg1RH4xAytl9LO7J/02NONx/G8z/fJP+gz26TE+NHpYXteKjXOHXxgBejNYBmfYKh2+8Ucbw/010VtStQVv7g7ZR9eec/wdw/cgey5vNvbKNJtLWQA/p9SHdVn4CHpw7hjL2Rt9d7vR154+aGcPQh+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0RhDY5j; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0RhDY5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4hcm9eal8mBttY8z62SPYwcYVDT2Psb47feC1QD2pL8Bul0lD/sfeId8PE6+nP6OUGNSDsk/GQW5uKoVdHdc/tn24RHYvpCBpiZGG3MIzFOrqwrGU3M6NQC4LacMQgdrquwk2yr22/oqSnO4nJvvt9b8DGPzJVmovF/Ss7OlE1Nvvw1u71iffa2dt6gSbWLGfyRg18fRXogr6i55kx2yodvQo6MKBGH2B+DO1/D1Mz+Or8S0p+h9rQDdX51Gr7+swAuq6128jvQeWsOs+ShloQu0eKUm2kdmOa18ZqRjFCZ5xo2VAmymoC45N/5zBhXfOLunTFKv2J4L6P16MKBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sL/2bwrtqZhmTX5mVWbCuOi8d8ue4yHY1JqsKLKDpI=;
 b=kGwqSq92VwlVw4HbhcZTRaDFPhbKDZQWv4AOXJopjJc8VupuhLGOGNZPORbAATWNBDrxkCDbJKIUheIMV7ryKiMZyvGlbTMzVnDIEOdBvjbhrFrRCihhyEiG6o9S6gX7FeYXoo0x2omvYSPOULFrqZE30H3zrXFX3tyROUepjdVZZ829izyxtkj4kzJ9yxS3hdQNob/YIIzT2b/UP6LEAKVwzlM6MOgp1VWO0rzV/TGYI2AC3OThycotohgFMwIdxGXM2wIv4fDJpzejU4fnfXGIbdCs0XsqqO7ozPkPcun35UW/VBM7oj1rHqqr9uGL6gclv6FBs4sQ/BexwsuNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sL/2bwrtqZhmTX5mVWbCuOi8d8ue4yHY1JqsKLKDpI=;
 b=S0RhDY5j4FD+DZ1PnfJ2r2mVF/yx6QsNwQNHV8KO6S4b+HSEJ3vrp7M6o+TZAelqddEmnqzuRzyC/p+e/eiNsBN8KC4eUke61D9fC4TBmWCnA+fb38zQWDD3Oe2CODfqTKLtPuyyWbGsiLEINa18jdN6DjnM6h6K8dX+GNkTUsqSEmF4wkiV/c32dmeLNoCEHv8xukF1zf87w9NRDieEtcc/OQLBbVQVxYTSI6cXULMQewX2lm+Zu1Njnm6t35iSa5CVGdTTSaZnm6TxhQx1+BvUNSK4IWWdfkZzKwhgsbsvp6TVAvQ+eLg+iTbn4TNEawf1r+Su1I7GGIJ4yINyxA==
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 16:53:42 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::e) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:53:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 08:53:23 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 08:53:22 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 08:53:20 -0800
Date: Thu, 19 Feb 2026 08:53:19 -0800
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
Message-ID: <aZc//6kvH3Eqfwfe@nvidia.com>
References: <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219143737.GG723117@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: a51f4d2f-276b-4bfc-cf89-08de6fd76fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VVMPT6bxUBTviGJLZujJAiBt8eW8flFVjlPIXAyRUXIHNlUJNTUiq7ozIqC2?=
 =?us-ascii?Q?GhmZ0hE/gGuWqztnmL19xRRpcTIFyIPNctCJ9OLzmN2XKR13p8vb4qq/MeZH?=
 =?us-ascii?Q?nAI3qbd9lVfUl/aIePfVcFae9c5fSPTTic2c9BNF2DoI16KrVpoem7zeebp5?=
 =?us-ascii?Q?u3tImBUrifpLAy4bOxzlm5/kpCgoQ1HR2sa/wbz0iwSyiu45IvxgvvOzpLc6?=
 =?us-ascii?Q?EnuQv7RMs1XIXx7bx54s6F5HCyaWkPDxaJzTVDz0Ge3PX/Kqs7md6Q+EX1oV?=
 =?us-ascii?Q?GIGlVlJaQIi86mbD821JmQywCl6Xz2LvIiCXOQigCWds4PFqK2GyKKMRx2+C?=
 =?us-ascii?Q?4ZemQYPyZC6ERD5DQ68HgAk/qIeH9NxnaSGFCqcEipoP2Y3ryJ8ZWtyVhSx2?=
 =?us-ascii?Q?X4x0vZM5shpylXS2DwdyUW2Q6zl9UFaoh0nxEFWxjA8GNufY6wgpurZ3caO9?=
 =?us-ascii?Q?p/K0o1DH6Pv4O5Pny+RHz0Pv/IX6h+iTQXaT1w6IvPyhlo2rs+/YMT8V5YFk?=
 =?us-ascii?Q?EgFXgCT0LuuCrUGpEOHZe2Spvc1oEbAJZ0rhHiLcaXPxsOR9VbbqmubFvcmq?=
 =?us-ascii?Q?LTzkBJz7W4bQV/u3ZNazWev57QiuduGWb4TQ421374ZP0nSnsGugHdAKOCgZ?=
 =?us-ascii?Q?Gj1HbWpmZtcUTgsmacqr9bJUhNqwMDsH9HfLmAQVN4N+7Q6Xh/o7xW22xBJL?=
 =?us-ascii?Q?yZPzWpGBe32CPwXOri4iZGVaHCGBR77+wfaPczBGItzfQsGh27z/L42/Arwm?=
 =?us-ascii?Q?zvsckURQSAtkNEmgWC5tmTDt52AquZI1V0NX0UPlHQD+3FXjUDd7p4qr4DkV?=
 =?us-ascii?Q?80e39b6DorlrVAxQAoBlgb/ljJlFnL0JSrKPDyrQER58X177PyRTrEEOePoi?=
 =?us-ascii?Q?a+asGqZHDMNa5cLMYGF4jT2jC1sQyivasUJlVwI1fkt3v/AIwtu6+WIfvxfF?=
 =?us-ascii?Q?1YaLFlwg4ThrsPOvtXNcECr/u5sg900XGpNjiOf8d+BmyawEqi4nisXVfVxZ?=
 =?us-ascii?Q?lnsfgxo23GXFvpIXTNmZ3DbMjXUM/aAm8lBXBDwYgocQ+2Ck2z1tV/h/eTJA?=
 =?us-ascii?Q?nGQBAu96pnQNfvPEiwYrKiKLts1LgyWaif87yvGW8zCTPpXoY88KtqUNY3kh?=
 =?us-ascii?Q?BVFIYytR/7Gc/PfqNDwfnJqUC4o3TtwHB2RkALpjmjeVp15vnHV9TJPimsUb?=
 =?us-ascii?Q?mBDbaAYRTh4cLWCFNmDzMbjYaghrSeJqIbuHCQZtbEnEuXk6mnag7IDibt3Y?=
 =?us-ascii?Q?srqLLfbMtRKQKeU81en+wxW0O1On0xhNf5ELkEPEFEqvjDHDe0bPMRdd4KOa?=
 =?us-ascii?Q?waUKUYDZVkjgzz3nIjlqmwcOTojN4H1t7kdb0DMeB8tDN7cH2FzysYWcKe4X?=
 =?us-ascii?Q?aJ55CKZe00Gu+ewCakYeLSp5wFR+mAE9qzL39yBE78f3kIMia3E4efcxe93+?=
 =?us-ascii?Q?igbXMtXFtY70QyfV9N2LYAvJ1sV6mq5iVAqnMCIRTk0QJNhUGXqFR2phStRB?=
 =?us-ascii?Q?krSlVa9wxprrxub1sxSqE+jwNNYjcCb235xYmSAsxkauXz8Vb12PNB6AG4pN?=
 =?us-ascii?Q?YGX3mDngp1hf7SABNw3qkRhABi0Swvlc4sRJgNIj8jSLsNRFymYTo53NFOc1?=
 =?us-ascii?Q?M+T9LMIQYhRM8OgMalhZ5R73G+4VK2vVc4QAIST7MvMPaZjnz4fyPgSlAbZc?=
 =?us-ascii?Q?H+zKdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Y3K7sDVYneADcS+mwzWcdAWomna8O6cKrmK2PWKY4aoJzhQX7M5RXBN8mKW9gY1T8rSRbWAfxm0J8GAibVMNVHQErqE28paDTo3xctkxniNsgEZw714ITRynTcINgdWJKWHNgr4iRqnSJHqLEnvpXXZ8g9Wr5UjBECkTzqRPReyKq6XyZ54ji6C4QzHB7imtw9sqEG9RPmjPEo5QgRE/6V7C1VmxoDSQzOHtWIiJJB3YdPVhbjLUHqLirDAXIGfvHnyEv+D6eiRVaXv+DkDQfBdSRzljrbCs2pJutJAN2OPMyphuEmtUAh1DUoi2uCvt0GyPdy4W9E0Vu+Me5Ciwvwl70HhMTSvRADch9szaNxjoruW7EYcA0OJ0tmjJWXKOL/b+LBBnlJGMji7xdNKnUjGD6+o0d6Mxxo3rDoOMzD5fy7RNQMEqg+i9B5iTyRl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:53:41.6944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51f4d2f-276b-4bfc-cf89-08de6fd76fdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929

On Thu, Feb 19, 2026 at 10:37:37AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 18, 2026 at 02:56:35PM -0800, Nicolin Chen wrote:
> > On Tue, Feb 03, 2026 at 01:55:40PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > > > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > > > allowed in general if require_direct=true. I assume this case can be
> > > > an exception since there's no point in allowing a device that has no
> > > > driver yet to access any reserved region?
> > > 
> > > If require_direct is set then we have to disable this mechanism..
> > 
> > I found a corner case, which might be another exception here?
> 
> I don't think this blocking security work needs to be part of this
> series. We just need to disable the mechanism for untrusted devices.

Oh, I thought it should be a prerequisite. I'll separate the patch
then.

> > Most of dma_configure callback functions don't use default domain
> > when driver_managed_dma is set. And this breaks MSI on pcieports.
> 
> The ARM MSI aperture need is some special case here. Those drivers
> don't use DMA at all so of course they don't have the DMA API setup,
> but they do use the MSI aperture on ARM.
> 
> Broadly here we were talking about blocked domains for unattached
> drivers, but an empty DMA domain is the same thing and still continues
> to allow the MSI vectors to work.

I see.

> So we can reframe this a little bit into more like
> 
> if the user requests IDENTITY then the IDENTITY domain is not
> installed until just before the driver binds. Up until then it is in
> the DMA domain. Meaning if userspace controls driver binding then
> unbound drivers have their DMA access blocked by an empty DMA domain.

The thing is that those driver_managed_dma callbacks don't call
iommu_device_use_default_domain(). So, the iommu core loses the
trigger to switch domain from BLOCKED/empty-DMA to DMA/IDENTITY.

The pcieports case via pci_dma_configure() is an example.

My previous approach using BUS_NOTIFY could likely work, but it
needed to adjust the timing between BUS_NOTIFY and dev->driver
setting.

Thanks
Nicolin
