Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770064;
	b=K2rw7H1iOG+nV1e9TuFPyzygo4FcS2oBvzpD8NxBZpb9Gc4dRR8SAZzbTHJeNRotnxWl
	 4SEIGXPbzFpNdkB0bhxWRM9pmiR/O+1K4R5SVvXUTsyL6QnfFD7VMj99eYJtBrwPNgUGa
	 /y7B2cTo2tVifFwfBEN6UyAXqBo3br4WhCRnEZKlR+15FLeaInNdTu8/WuXp5tUOrT55c
	 Oms3y+T2JtODoR3LT4clWshuL8Oc3VVhYiSPVRa7bAZ2+oB8umZrOceC6TjjCOGHyUiQy
	 dme8tCRYKc5jExvpxuHFn1xUwOsI6BuImIrGY06Wynb4ECHEmxZb25ZLYTppHRVbMSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770064;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FTpMsPedD8A3Ep+V61dgAdy8F87vVfoLgCwSA4qT+WE=;
	b=q/GuMc+N56kqGkfBe/P4WBn9I83RiTIcRLsLXKXb7adC24qodUKzE6to78u6cLEgaxZi
	 HzSOR6AEuCEEW28VEyusr8qlV3J2Sr4pEGguJXc045fY9+qqDNlpuMfEUoPvPvzLCtGdK
	 mTPX6e5fGhB34AGz5rKy4l/om+O4OAlbwd9C3/vT1lzvWZ7XUeM10e7CjLXGhpG4FFYQc
	 CfHzD3jtUqMzcLs4AIivyXL/HJ+PE307WHLRushW++q0SnHst1VjDcDeq+GoPeTdtuSJ1
	 DJmAqoPsjU/Fy/rtG2ZRbMoXQJe5WXiYHx9KJ3okU+IjeR0PwYKutSeNfjD7DVZqJyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NEbJztuk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.54
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A165606A31A;
	Fri, 23 Oct 2026 15:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A165606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NEbJztuk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTaeylx0D1yaaOMBG6e6Sd/f0ZZQbk3xfuSM/7NYmudVe56iKDtoJ5CsVtWVMIxqnKD/lKfu0boT4MjwqgM6PW02pHFAY4gQc7jS817+8+7oLJWpqoZBsyObQau2ofKQPONZpmH3iG4LH8UL94nt9nWBhxYObGHid8rbfDBuKCzqwjBr1ezoLZABFqiDS45dz1T5/fTNfDvZMmR00YgJbUGlp9WOvXiMEOSmjPQXNBUrvT6QcyFK6V8IQuFUe7GLzKfQxZeZGTfOQdl25RLXncd2a/0mHcxRgXLsTE8gQG7o9VmRgzWTmxce6Lqt/+Q5PQgEPa5nZZUk2/Mw2zRr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTpMsPedD8A3Ep+V61dgAdy8F87vVfoLgCwSA4qT+WE=;
 b=gUN0J2u2ZP4SbsQRc1lczOhcniVzXvlC0lOV6P4xszKucOv6OCLNYcbJGk2yWEMmy6fhOjVRrasuuIlD+vZnggPZ33Vfj2mV54Cx3XyWSnFfNDfrL0mDS6vxzfSYADJL/CcfrvWzuvsR7agQyiaDwSNhp3DEeTy2aRCLze/yBkz+gMjQudttafZfeDW4uRqi/nHcwufj2zGfdV3mZ4wSmUtxwk4jKD2tfqEQW3Kg3PJFF6tToZe9FC2tK3SR3P0rBBmx8Dn5VFv9wuBWPnKjZRPpMTpa0E23Ou2Vr2+vlMktCE1+Q//mRiqmRX0L/C4QvwUu9sFgcS+h4MjOM83VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTpMsPedD8A3Ep+V61dgAdy8F87vVfoLgCwSA4qT+WE=;
 b=NEbJztukwGcawfGq9YmyIRgjGtoihkjTqbmnsckCmpTFHeAxxoUUOm+o4ZjNd3U426CXJ9Uk8E2qOwYo6oS3hYLta0uHE/XmXJMZbxy9FrTJUBsFNawM670GrAHZol2ZZ5QOwLimhhZCV0pcANvXjed4E0AxjPGisXweSqeXOIqDS5tYqcGJsPJ2Wvh7UdUPQHf7juR8eEyVEBO+rcFTbxHEGjjTw3M/HFoaxqOTbxAhR+ECxkrOec49jhwQNCCwWDmyRpUI28cG/WCDInOpBDyF97d3ygF+iVS4c+BRs+2Q9VLaP1eSoBKKl0Q1i/V/VW8S5NVvEipodRepFmuEZg==
Received: from CH5P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::12)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 23 Oct
 2026 15:40:55 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::4) by CH5P221CA0016.outlook.office365.com
 (2603:10b6:610:1f2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:40:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:40:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:26 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:25 -0700
From: Simon Song <xinmengs@nvidia.com>
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
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 00/12] Rust VFIO PCI support and NVIDIA vGPU driver
Date: Fri, 23 Oct 2026 08:39:55 -0700
Message-ID: <20261023154009.2246627-1-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 13eb2116-6351-4673-54cb-08df311c06da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|261022115727099003|260925021911599003|260925021311599003|261022113327099003|260925022911599003|11063799006|261021135927099003|56012099006|261021123027099003|261009223027099003|261021130227099003|261021121427099003|10067099003|18002099003|6133799003|261022105027099003|261022075727099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1y94mE36t39juB5rcbTFPQb6rVy5OnF8hTavP7nNkR4jrjluLKCVWmvGcJGUBCixzdpug5efw9voaOS0koce8FuxPPkGwlwDSvvPuApOxdb0y0xL3hYG2NW8QV2wlboHRLDsSUdUsE+1KeeYNGZasl44m8gfNqqvfwkX+oF3OEOumDJXmz82F32QIq4pjfnvv0xM/AzFhx9Kx4o6o5arBrIVVWqCi+sSczGtK2C2WEzSWMgVDdifb/eH1p3CYpxvS66iEgCXBO5oZuA1CGby9O6v7A+7KPQbWLO3WhhMqr3uqA5j5QCObgzSZlnRRd8BBNt/sxI61WeMX7s10g5/cV82Hhy4Cix+6T4y9XBcawHW5I+HdnP+sx5TE3l8mJPHeJZk7Nn6aDNRya692Mj1pzGiGtk9YA7szS9gxFZ83EqOv/o3DPuLMTImEoqMM6A5tGB/EjQ5bZ5kTrgNsmYQUF4nDxbTkOO/H/iJ10kIurKFSuUKN4Jl7uQvwlNZUAYE0x0boG1LFuhAilymZ1InkD3Zpa4oxhVKBHD0GZkQ8ABnOx/BGSEDiGVCICAUz5ZcDJoWrbpaIb1pN9UEKocji3UswQwFIAC8ACo40aO+5EjhZgVAdA7+IwjqEgtIyNNZC7edvMKFKZnHxkqiU/20g0+ovOob+ixOFa4Du7hE5R/6mPENubn7nofYwl3Cn+FyNl8QMJOqMJbnDgPx2jpAGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(261022115727099003)(260925021911599003)(260925021311599003)(261022113327099003)(260925022911599003)(11063799006)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(261021130227099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(261022105027099003)(261022075727099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DUvhxrto5e0v4fSQ8b4W4rGRHvipT0HgdZdX5aYjVoqWzmprSuSJZZKKV0Qts7zDx7PQpL2sUyzrTKu4icHTHORliLjXqCUsESkLPPbtlYMAvr9Cz8IsYQry0mfe9edS8sxzVXVEqSR84FKesn9eqoGif5Af94S1FEKkThGsDrn1nmAZFphANMPb0o1Vuofwkax+M2JL9FGlnETirFd1Rz3oxdq4UpK5mc1PZzqz3KaMWy3v0rJS5b6IOpSSsdSRHyD+/opRRg14d+sDp/f4ha/CJGE4kJwSxlnuJYevHmSCmZtIjZZHnQVl5oZop2BfC9JL7IfMO11IBoqYuXJHyabS3K5FTHbQ1tBikMWV5cONEtRhHhryRdjlcstj811m2s8VdSi+CxTjNWf1JeZ5V9VlkuzOO1Wto6v9p1r2RCDJQy010JJsylsjLOv+rTMo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:40:55.2071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eb2116-6351-4673-54cb-08df311c06da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

This updates Zhi Wang's Rust VFIO PCI series [1]. The NVIDIA variant
uses nova-core's typed SR-IOV PF interface to create, reset and release
vGPU instances while VFIO provides userspace access to the PCI device.

The base includes Zhi's BAR1 self-test fix:

- commit 317e76cc60b7 ("gpu: nova-core: mm: keep BAR1 self-test page
  tables alive") [2]

It also includes both prerequisites cherry-picked from Alex Williamson's
VFIO tree:

- commit f1b563d3e3cb ("Merge tag 'topic/pci-vgaarb-rework-2026-10-01'
  of https://gitlab.freedesktop.org/drm/kernel into v7.4/vfio/next") [3]
- commit 6a5f427bee12 ("vfio/pci: Remove the core dependency on driver
  data") [4]

These allow Rust VFIO PCI drivers to use their own typed PCI driver data.

Patches 1-4 provide the PCI helpers and VFIO PCI abstractions. Patches
5-8 add reset, bind, AER and runtime-PM support to the shared PCI adapter.
Patch 9 migrates VFIO to that adapter. Patch 10 separates common VFIO
handling from PCI, patch 11 publishes the typed Nova PF interface, and
patch 12 adds the NVIDIA VFIO variant driver.

Changes since v1:
- Patch 2: restrict vf_id() to Device<device::Bound>, following Danilo's
  review, so VF index lookup requires a bound PCI device.
- Patch 4: adapt to the updated VFIO core driver-data APIs. Pass only the
  core device to vfio_pci_core_register_device() and
  vfio_pci_core_aer_err_detected(), use VFIO core's VGA callback, and
  guard runtime-PM helpers with CONFIG_PM.
- New patches 5-8: add bind, reset, AER and runtime-PM callbacks to
  pci::Driver so VFIO variants can reuse the PCI adapter. Run bind()
  after driver data is installed, and require Sync only for runtime-PM
  driver data.
- New patch 9: remove vfio::pci::Adapter and expose VFIO registration
  through the shared PCI adapter, with a build-time check that VFIO
  drivers install PM callbacks when CONFIG_PM is enabled.
- Patch 12 (v1 patch 7): register the NVIDIA driver through pci::Adapter
  and delegate bind, unbind, reset, AER and runtime PM to its VFIO
  registration.

Integration branch:
https://github.com/xinmengsong/nova-core/tree/nova-vgpu-wip-oct-18

[1]
https://lore.kernel.org/nova-gpu/cover.1790764573.git.zhiw@nvidia.com/
[2]
https://github.com/zhiwang-nvidia/nova-core/commit/317e76cc60b763a03664cbf8244f4de076e58aa7
[3]
https://github.com/awilliam/linux-vfio/commit/f1b563d3e3cb0f9a97ef77f538ffc0e75e79a628
[4]
https://github.com/awilliam/linux-vfio/commit/6a5f427bee12c82beaf13efbd133416da1541c39

Danilo Krummrich (5):
  rust: pci: add VFIO override device IDs
  rust: pci: expose the VF index within its PF
  rust: pci: allow drivers to manage DMA ownership
  rust: vfio: add PCI variant driver abstractions
  vfio/nvidia-vgpu: add the Rust VFIO variant driver

Simon Song (5):
  rust: pci: add reset callbacks
  rust: pci: add a bind callback after installing driver data
  rust: pci: add an error_detected callback
  rust: pci: add runtime PM callbacks
  rust: vfio: use the PCI adapter for variant drivers

Zhi Wang (2):
  rust: vfio: separate common device handling from PCI
  gpu: nova-core: publish typed SR-IOV PF APIs

 drivers/gpu/Makefile                        |  15 +-
 drivers/gpu/nova-core/driver.rs             |  47 ++
 drivers/gpu/nova-core/nova_core.rs          |   2 +
 drivers/gpu/nova-core/vgpu/vgpu_api.rs      |  82 +-
 drivers/vfio/pci/Kconfig                    |   2 +
 drivers/vfio/pci/Makefile                   |   2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig        |  20 +
 drivers/vfio/pci/nvidia-vgpu/Makefile       |   3 +
 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs | 402 +++++++++
 rust/bindings/bindings_helper.h             |   4 +
 rust/kernel/lib.rs                          |   2 +
 rust/kernel/pci.rs                          | 229 ++++++
 rust/kernel/pci/iov.rs                      |   8 +
 rust/kernel/vfio.rs                         | 290 +++++++
 rust/kernel/vfio/pci.rs                     | 849 ++++++++++++++++++++
 15 files changed, 1953 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
 create mode 100644 rust/kernel/vfio.rs
 create mode 100644 rust/kernel/vfio/pci.rs

base-commit: 07484ea6c8335226301113bc86e7c11b52312f51
-- 
2.43.7

