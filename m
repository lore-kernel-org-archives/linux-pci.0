Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEE496D2E;
	Wed, 30 Sep 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765964; cv=fail; b=geWXK8VX5YPE1vT1r/OFCtcLlQvWOg1oHVUgM6LLr6af+OboOLCAfbK0Og2B/u7xEkSDRLRtRASfj4PF8a+BBY0zpse5nOzIJORaRhUqu2sW7g0AGtkJ4mC0ITV4zJjl0VXkQiN4nDsN2z2jz1f8CJFc9CPM1txtzFnPoheQ4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765964; c=relaxed/simple;
	bh=JvzLYjSZg5OcgPRRXHNEDU5P1XK7WvM52aSaeOi+RUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2LV8XyeAGVKfIOnwnl1cG1Y7wcuKoUoyFGU8hjLhbcdCcgP1/W7r5MXa5oyWMNg+X7ek9IvMGFObCpzjoxmpwS3Tab3Bn02jAwJpHMNVWX/eUiSyj/I5JhwB0BmH09mKNtxML5Yrzh3cq8D12LLQS8XH2JmbcIJuJ7WW8fiz9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSQFNcoR; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSQFNcoR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0+y/JyN+0ITj7O7C6bZDX1NEz5wPtvniCoVRHTf+7TVIZjbhssBCnVouBRiyCbUKXVJjPEIinHee8BX+mCYh105eKIyKEpeR5+1+Alpkthp1R1UIJhu2jeQmKYFrJaujDH5njxgypGEpcQNdL+984IYdaKoE5pyk8PEGtgpbqq4la4/Wr+4/JOOhye92/RissM4k7sYC61oWxgPVeg6QSoCAfNGFkics0SakoIW2LB6clUN6aONQcn17LeQsGURt5ZceUm8BCS2YfxPH/7PyRm6y2XUfdofUsHRZEHaWlYmKYaB5oLL+Hvk6meywuyOnX9Ax77Ui0v36fn/yM/NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF2oZSdlSu2P3aOiNXSGn80Z/eAWKGs7Bs/gcKgAfFA=;
 b=cau0Kip42FRSmo1tArp1LSuRz31ScjkMqEHlFike4CgJdwDPMVSonmQxcB6Fkoj8Wo5NxBIkMWtammZ7St4mzO3SbPM1HzLM8JFw9RzBbalerLnmyTCAau5DMmmzL6xQ+R7X5h6I9vvfI97mms5v7QTb1i+fjqjGV3gwlKPnBG7otLwEm9PusuZ2fuIxAFtbB/1wFLZ8br1ZPbSSEUl2m4YsYjsTsu/HhNm07lOdALjWLjUMuIcMSuVEME/qvwckZIOGP9opJThW2O6z7h9XmMGIBkC+DCo9YwcIajOVmFgtSJTjOIIkjArKVeL/aKVkzZbyKIZdLbrV1aYydiwioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF2oZSdlSu2P3aOiNXSGn80Z/eAWKGs7Bs/gcKgAfFA=;
 b=PSQFNcoRqL5Qg79eN068IxezkbfGhKdbvTZMevhWkhGhVFPdkp4XuiPZuJKkGg2QZeXCONbSwjMz2hWIKvMhU5Rh1AvttEsSY+E4mYRxDQU+ywewktdtPPpc+F4210XhAKkRLXEkyUL3iRX/JKxTnw60EHywpB2UYxVjd0UbEG5AmQKD5DCT6VX/w2AioIWWib7xnKMN75XINO9zFaiDHW8GDmi3hwYU3FyS9ENtSSFZNyH7khRi8bdxcDaa5HTItNN89gGQ274E+MDzBILGCxiMvZogn3AjPx8Z7r8FKGumeyY4PEtdK3YHygJiYtDZNtvWNFuxMAaZvMz0ZSfvhw==
Received: from SN7PR04CA0054.namprd04.prod.outlook.com (2603:10b6:806:120::29)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 10:58:59 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::1f) by SN7PR04CA0054.outlook.office365.com
 (2603:10b6:806:120::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:58:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:58:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:35 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:58:24 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, Peter Colberg <peter@colberg.org>, "Simon
 Song" <xinmengs@nvidia.com>
Subject: [PATCH 3/7] rust: pci: allow drivers to manage DMA ownership
Date: Wed, 30 Sep 2026 13:57:45 +0300
Message-ID: <b9427cf896bbe9fea77c781501ebdecd5064a978.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790764573.git.zhiw@nvidia.com>
References: <cover.1790764573.git.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: dae68c07-8b7b-42da-486e-08df1ee1d456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JNFkmV866fU5aXi1WB9kr3QfAGTr42EtJWB1O3Cpxs0YZHqiz5jjGqBSpufJk6ZhuPBJSFPrlCZPJR+M1kFOHGHGoycyQi10VooO03BFjlsByRRFtMjxr95IyG8gHT25ZXxu0Dc4jqGAjHfPiBC62/Gw4Z5oAuKXRRPAUgPPsNOOCg5vY7jSl2igsfgEIudMADK2rRIqKUhP3j5jE+tv4De9y0dxQZ0x4Ki5LNbvU++x8ualkbXcFkgOqRd+o87UV3YXTtUTGMrmvdCAiZuJ4oPYk8096+vIUjFI2137FbI4DrT68z2T8LQ2nfB55tEMiQf0lZ2Ucm0FnLP72H13uOwfaN9dbPzWsmTvfljHAZpPBKqGyzKLJMiqGiGCHCEroX5uIB5RhBtqPO4HLDvi+BBKyQzb1McRJH7ilDMANZFYWcrAemVlV3y+HC1GH9+tYWLKzsgsDbfGylD7QmW1oPppX2PMOizktTbdRhVJQgvwec4iWRsCDlY2cRoe7G34K+nZ4au6jnKKzwAaQ5R038uSIVWQrF267ApGl+imwF0b9U0NhurhgG1L/gyaq00tc+qOthV+C3Oqobrf18aLWnD2sX2mmrAs4oO3ChQi6Ko9I3PH4U392w4YkHQIQprl6SsJ13lqUuuP17MkGgtJdi4mxB/z0R9T0QialvJ03c87RenYaiN2PSqX/8+2EFWwzV0PtjuUqVxXrJePgRezYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wk6qvOtlUVGo/CY0IhaBSxeqTSY+c24Ug2wNdRBtqqcwfYvcVYdvrRbLTPin0PpejFPKSSArwW2b3JqL3Kr3Cu/MM3eJ7Lr2nMge+98PgIXwzL5NnGr7but0zrC9LKzmZQKy73tN0m869sycQsVjCOoN7QuwYhjva5e5F5lprIoYxwwz/oyF+H5Wdo5xHXrcwNFa7k7vuJ+vpv7qk2sNDtH9hQ/u43yTEaa7wCuSf6qDOHmF/EPEGXnvZi2AoBo5zud7hhaDdD/3LOWeDQxgaBxFlq50BiY67eJlvEjUPERpEIVAVqRSofwha/Vr3vOnsS7o4Q4OHBFE+76Q6X77TPVwx5dFdo5d8LtsXGNb+udyPp/YDX+ZMCQbYu9Fdh6OU7eBL4qxUBZ2IuHeMWs2IauLPyGwnXRvXFuegbXh4esLYqTn7/bmsvGiEazeh1iT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:58:58.7709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae68c07-8b7b-42da-486e-08df1ee1d456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

From: Danilo Krummrich <dakr@kernel.org>

VFIO manages DMA ownership through the userspace IOMMU interface. Its
PCI variant drivers must opt out of the driver's default DMA domain.

Add Driver::DRIVER_MANAGED_DMA and pass it to the PCI core. Existing
Rust PCI drivers keep the default setting.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 10864ffda4ea..a156927e23d5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -108,6 +108,7 @@ unsafe fn register(
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).driver_managed_dma = T::DRIVER_MANAGED_DMA;
             #[cfg(CONFIG_PCI_IOV)]
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
@@ -345,6 +346,9 @@ pub trait Driver {
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
+    /// Whether the driver manages DMA ownership instead of using the default DMA domain.
+    const DRIVER_MANAGED_DMA: bool = false;
+
     /// PCI driver probe.
     ///
     /// Called when a new pci device is added or discovered. Implementers should
-- 
2.53.0

