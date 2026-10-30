Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380398;
	b=qfZR3A8EgdGsNLpaMoIIhBk0h4TAab2iuNmI0Ixj7UcfTedJS0yN7kPasm3oJQopiqe2
	 4GzHDXK6+8Fbu2loff94WdsOJMmK1jFVMGHm+8djo3XeG//XJIk8S2kZIFq5B3mBazTIa
	 NxyETl0RC7PzkT8BbF8UkH1n/4ovzTPUtQRplhi/HusqfdrENLHpwgUa/eT5+QF6tBTL2
	 oDEi8EtMqy6GODwHWqHBc1BHc7i5pyoHbIa2u97RYRZ/aUhyabmQfqt1tLBf5UIIhb6oO
	 DJjQix0/ZZ9DxvxtB6tljdYqdi/Mt26N+RHrJaMcJx21iYYxPD2tAEt84iqpPqaNgsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380398;
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
	bh=Dr+ygBjvjv+PEIDltfhjxgecXHoRMwo9D0YsWA5RwvM=;
	b=ZvAaPLqkvdCjGf0MF7UaVKN5b9UqSRlLe23PECyvLQJ0vSz68+/qRaqMMaKfAy1XLgBa
	 OGVXEa3PBipV7+8POaYwKd+UC5jyEDF6JHNT7jDRaTIK+vMFb30ZUXinHKfkCCSDPquNf
	 Ur2A+ZU5awcGxu+mP1CVwmD/2LJHSRYcQaxjONzpFfLs08CC3xvQiOEMZc0RMi/RWlYvH
	 gVDd38eGYF4b/iA/wCA/1r/qt680hWv6nfJCdqTZdLa2EtxQcVzqq0PMEhEVik4MsraOt
	 1L+wjot8QJunkwJUw2nQiBv537VODIwOyTXg0jGTjQRJIezK7YFTtiVs3e4vinTkn1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rPCdDYED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.29
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66686606A323;
	Fri, 30 Oct 2026 17:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66686606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rPCdDYED
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+Y79wB1rmOspgrMoJ/R5OOZtAi4uX62wp8Mlg4W3Jdo5eaKn2NDVHoeT/0GtrRqpfd6f4PXYvGSmIuKHzuT4LtYKpLbg7Zgeg633P9uKntMCpLoVp4pgxyLHcvKfRDKZPO7/6n9yu1N2xmYFc1NtuVB1vt2ARZczUiEeQ98IGhLyMwmS3DlAGhxQqk13RCn7N03GMTupMhKGnx1hT79PS9s8bG/EGUIJ7o0zs175x9Hm3VEl0dRg++osGDaH3/NiCcYyEmDED2kBa6KOt7jt3OHRZChvSAueXajr5MJ45AtQqLVhu/GgSR4PURFxwAyhhm+Iu49VuzSXnZUjicNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr+ygBjvjv+PEIDltfhjxgecXHoRMwo9D0YsWA5RwvM=;
 b=KcIO7sLIdLMHzSLMzxN18WMoum3nu+w7BTA6+g24O9wvfTVhQy3tppiQlZEdv0A8Yd/FA5Z0z0SAHGBMAx/FA6A4CUueFTJnsjpREPEu+OiQv1K3Ojord73SD2wC5lI8OobDKyq+ZBlz7MEWdWYsstGie14oRdQ9lxzAG4gB3bFtSO/1rfp1gExc0V8TLUi3oz9VjQAX4I3MBNQt9PcB7dTJBevT/5E7212DzW2IYvyg3y4Vdc5hW/stEOxbnDMZQH8XC6B7XL68ZfrW9fMGvushUREWSYstZgq79BHdXTL5q3amoS+nfkvZFZC10MwZ3Y+RTrOLr2EsMklwCHx3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr+ygBjvjv+PEIDltfhjxgecXHoRMwo9D0YsWA5RwvM=;
 b=rPCdDYEDMrcxcuwwR04K0xWmDIxkqsAE/rSTtR8uS4GTzTxNQWRE3c7oYjsH4U/QTDX7RhXYhjcUVO1B19g5i9crWX8Cwoco0fvWFT3djcod8PreKEyNjz062cHamr8Tc9piUmp+xb6i9CN/myvg4ciqB5blxCmEedPSArpw49MiJT7Mw1eKj+hKSUrFxNfXu4ug2YPDS9t61uhGRdOMKDy+l7eiiDutwqBDdgCyRsMTVE5HTVYugRp2pbJburXjH3Ct6R3lgNTklRsvofs6lt/NyLIXGWOqmNxbV948S36oew7riGplALhdB3ZRCtBp/Hfn5EKSWuvjFbbPmLShlw==
Received: from DS1PR02CA0027.namprd02.prod.outlook.com (2603:10b6:8:44a::7) by
 BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:13:08 +0000
Received: from CY5PEPF00000E79.namprd02.prod.outlook.com
 (2603:10b6:8:44a:cafe::5d) by DS1PR02CA0027.outlook.office365.com
 (2603:10b6:8:44a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 30 Oct 2026 17:13:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY5PEPF00000E79.mail.protection.outlook.com (10.167.247.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:13:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:12:45 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:42 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v5 0/9] Add Rust PCI SR-IOV support
Date: Fri, 30 Oct 2026 10:12:18 -0700
Message-ID: <20261030171230.196717-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E79:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b4d9c2-a7b6-4cac-f37a-08df36a911c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|18002099003|13003099007|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261021130227099003|261022113327099003|261022115727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	s+FGdQ8bdO/WLzGicRYq7ZRdUe99lc7qz7ylCCICnFN1dzRoXQm0GAon/tM6MwDWKo6e66rxRrrmXOten9F/r0pqt/b9BTpDA/QnPQQynuDSjJxPOdg0VylKtKKkxjUzwMzIbyZtXy+mZ+40V4ohz2OU6OnGhyrNVYlsYga4KCo/PR1HlP0BItaD8PV5SJf7epKPGg4k4AdVCfwCBI8ibW2Kx/wjy+xACNzUig75vSbgPijpa1BgiX6FXDqa1jwgIpiLZoiDzt/QPTJxht/HQClZekHNyDVBpQ77t5W8Mt9V9gYQFTaESZOIUvT3xjmj0bjRTtJ7loXmp1/pscVjLBBbYeLyI2Lvnb0VgHLVISPOo4/iD9u8kgM68qL1twqj1tOqKz+wtunBp4Rc09QpErJq9es/OW9mKnIFPTQJpdI7hNKc+zG0Ebepp42kZGus3CWqJIpe+saqApNd40DdItm/cMliwlLWTOeibYE7L5Gk0felXSAAZROIYcZyg3WQ1Cck8ViBWTG1wonDdnqvUWNEIYCRXuQabCmtUBg4Tw0Xd4oBQtlL2sjft3lNPvYkL1cc73JE9Q3oIOk2I2CIRoSJrZjpYvYPqwtK9BK2f99tl/A8JDyyGE68bHeWKRovrI1zhzMPZW1tMTy22LhxKPMpxtcVPPN4gq42kowL+MDUSPtCUqbTSwhmoVEcjB2dMRuuU/PW5e7tpK3YhWHL6g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(18002099003)(13003099007)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021130227099003)(261022113327099003)(261022115727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8eyOYZO2yUwMyMWwz/visSpaGr3bGFGifS4QRNC5M1+qGjMLirvg3jZsNR5LBN/R4fS3p6mydw8wtIHJk0X3gPNkBuHtUHCUeqnx3D8A5uMf7XqvEeH9dInaT2EgEKLFecQOrr+62asx7X+U7msoR4orNd49QgC2yg8tnrLgU/VFUTDYrkqxFfqOJNaDMfGDMw3+P4u+saM5iQN8XdXkO9U28bGpf4Krs84HqpXoNDPw23BK8cPQjH8BFMsoMZ9o7S4+lSPaTjnNwYrceWQbJlxx9oGFE1tF/QhOIL045egH/lNcuEFwNpa/mRaraXWt4aIrcD4AncK6oo+AxYxqF1MLVJUc+ubpV9y/M/hWKWkQTGgoImc2Q88j3eJ5PXxbqYKCXPgu1Cl7mYZktxUanTRJ0Hsp5Zar4pLyhC/a0LIOsKRPrNm6zjOE4aLQzEE9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:13:08.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b4d9c2-a7b6-4cac-f37a-08df36a911c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E79.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

Rust PCI drivers need to configure SR-IOV and let VF drivers borrow
selected PF-owned data. This series provides those operations and a
registration that keeps the shared data available until VF removal
completes.

This builds on Peter Colberg's Rust PCI SR-IOV series [1] and Danilo
Krummrich's typed PF registration design [2]. The PF/VF samples demonstrate
the interface using QEMU's 82576 emulation.

Drivers implement separate sriov_enable() and sriov_disable() callbacks,
each receiving pinned driver data and a token for the requested operation.
Enabling VFs returns a guard that disables them if later setup fails.
Returning the guard successfully leaves the VFs enabled, with
VfRegistration owning their final teardown. Drivers that do not share
data with VFs can register ().

Changes since v4 [3]:
- Add #[inline] to the small SR-IOV helpers and accessors identified in
  Sashiko's review.
- Move Device::is_virtfn() to pci.rs so it is available when CONFIG_PCI_IOV
  is disabled, following Sashiko's review.
- Remove VfRegistration::data(), following Danilo's suggestion. Remove the
  PF sample's dependent helper and request-count log, and update the
  documentation and commit messages.

[1]
https://lore.kernel.org/rust-for-linux/20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com/
[2]
https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3]
https://lore.kernel.org/all/20261004120732.1045629-1-zhiw@nvidia.com/T/

John Hubbard (1):
  rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (5):
  rust: pci: add internal SR-IOV enable and disable helpers
  rust: pci: add vtable attribute to pci::Driver trait
  rust: pci: add num_vf(), to return number of VFs
  rust: pci: add SR-IOV enable and disable callbacks
  samples: rust: add Rust SR-IOV PF and VF driver samples

Zhi Wang (3):
  rust: pci: drop driver data before remove returns
  rust: pci: add typed SR-IOV PF registration data
  rust: pci: add SR-IOV enable and disable tokens

 MAINTAINERS                                 |   1 +
 drivers/gpu/nova-core/driver.rs             |   1 +
 include/linux/pci.h                         |   7 +
 rust/kernel/device.rs                       |   4 +-
 rust/kernel/pci.rs                          | 115 ++++++
 rust/kernel/pci/iov.rs                      | 387 ++++++++++++++++++++
 samples/rust/Kconfig                        |  12 +
 samples/rust/Makefile                       |  50 +++
 samples/rust/rust_dma.rs                    |   1 +
 samples/rust/rust_driver_auxiliary.rs       |   1 +
 samples/rust/rust_driver_pci.rs             |   1 +
 samples/rust/rust_driver_sriov_pf_exports.c |   9 +
 samples/rust/rust_driver_sriov_pf_main.rs   | 164 +++++++++
 samples/rust/rust_driver_sriov_vf.rs        |  70 ++++
 14 files changed, 821 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/pci/iov.rs
 create mode 100644 samples/rust/rust_driver_sriov_pf_exports.c
 create mode 100644 samples/rust/rust_driver_sriov_pf_main.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs


base-commit: 414628df5e4629a39ff683924d192145a4307872
-- 
2.43.7

