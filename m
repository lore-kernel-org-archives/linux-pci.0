Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125096;
	b=hQiEHMQv4hpK2BG3/E0U0oUL3HaqJQ+nZEg0wQAlTivmME1LySwHvga1JQnXUD0Ly2ry
	 fY6Q01SiRM5SFRAsuvUka8pOR3Bdlth8Rij0hBov8PhFyR8HMaOeIhwwkzSCw1IaZMmQr
	 le7sdkVVAPZHrEAFlaaL5nvuyy8I1srQXn8W0m+T0P2WqxMz+MHHGKZVxf7HmnaduqEyj
	 ZzS7FewAAc+/xyueeA+Tv8MXvyKJ8F5i5aLgQ52UgVUobJfh0nnIBS+yrtiZ4N3mNjnr7
	 Ub35O+B8McTC5JIunhMHl3j4e98IcS3lYrbni57VZ4gftg9HcMmc0K7lnF2Sal4rSFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125096;
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
	bh=U6xwhT3xxcSRvWrFMi+zO+YW2Ej4dmHa1PR6NcuEX6w=;
	b=C3yNdxL3UgZycDSwKm7lyEd7MvA3Uj6qZbcimbsCLTnClci9WyKf26+fGL6FzH24roXK
	 drgTzLqyv1UU2knOLENHyAAZAZFCcHVutl8YMtyEVptHzI3NJfBYxMNTTDwVtja+NM0bo
	 p9MfswoVazr0F/UexaohWBnLJQMIIB7vMVtLZf4aCZ+Fb039Dcq3qP24iZpGzqbiuAB0+
	 FQwksvqMXbXK17ZKFZxbCefhttHgPDR8zx/M3PfJ6xahuMcEybMSQ6ueTm+hiFKVVB8ZB
	 x1BxAbLa2H3rGQguGVqpFrOKl6ts3KjiLcpygk8PeX+nLCusudf+5YewnG0BGCijBIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jPdfQgsx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77261606A332;
	Thu, 19 Nov 2026 21:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77261606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jPdfQgsx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZiCve0vEZqLUqn2oNhN3+5CaT/BkKoB0U8U8YuFokPOPC1SI1rE0PfiXtp8Chvut7YzII32DC71UB9lqHhRZvIGR+qS/lJth+p1XdD3LyP+G2fn0wqE8fVCLESqHdH1TsCVHSxogaFiklGFHosPzGkUoz/RGiQ7RgTr+DhD3a8rHfTSFbaUD3wDHNhT/lW/v1pisZ7CBHMFlFkda87UIPGzeVNDH2WUTgEQW45rgOGMRPYmCKOjEFIbHZ4svDlOrF2bRrQnxV9wlBP55+li9PbJP6NxjJ3SBkVCVR9uc4Smt9E7Me5GFPeVaWV4rI3oKFRodne8BoCEdKCFekn2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6xwhT3xxcSRvWrFMi+zO+YW2Ej4dmHa1PR6NcuEX6w=;
 b=DwHRXCnGs3xw9mktYX+2pMD1p2TgiOndgEpWn2TFVqGEsnWIXbeaqQ+YOxw96kRhNBxOV5Tr+N/mGMUbtrQR8tROiGORQd05o/m0JOH8dgHyDVkPwHRAVZmLCYA4pNyhIXXQ5JtXc78k6frDEWwozJtTPk+5RwFnjD+sGhml20y1+jh8Y5gBjxhTizgdJUfIr36fFcZJ7joV09qq8FeGqfChVZti+c37hox7cMiJhowxC4gVpS7L6EUe2vJFgvApClbH0E0XYLT4JhFAwpgxzDTKlZ14hcSGMnGV9Ki4oHA+nGkac7eZ3G2pvOVdem1Vh+WexFJ+83doUJlUUE6qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6xwhT3xxcSRvWrFMi+zO+YW2Ej4dmHa1PR6NcuEX6w=;
 b=jPdfQgsxW35ZWMUhGxkDhQVABkOVonEiXOouEzqPhSdye5TSRHmLNVpyxUwRQcE2YFhv36HD2QgAqPirpo2dPPy+t7vsBYqa+R2UZie/9RApSEyUUGT+yEfYw//Ul7yyEo83kxWIEv9Gg+Jsq4bmDJ/eX7uWPawJ6eMm3rprS/5tdFRFA6y7peNbQbv1oUHDNf3jvdL223/j2rBHJpeQcnjgXaXp8okAhUj+L3t0/FeQuoo9q3poIxu5waCsDKd83mbYWC9Otvf/84Ae8p0RWJxmHfDyW71M8QhOdpIj+85Vu+vjhlFkOObhKtJPrNLTrxXPY0qGhWl6AcZ/StJHXA==
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by IA0PPFDDA81179A.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 19 Nov
 2026 21:51:29 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::30) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 21:51:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:05 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:03 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: Simon Song <xinmengs@nvidia.com>, <alex@shazbot.org>, <jgg@nvidia.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>
Subject: [PATCH v3 0/9] Rust VFIO PCI support and NVIDIA vGPU driver
Date: Thu, 19 Nov 2026 13:50:35 -0800
Message-ID: <20261119215046.2892839-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|IA0PPFDDA81179A:EE_
X-MS-Office365-Filtering-Correlation-Id: e701ce83-5600-4bb6-9599-08df46874436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|23010399003|82310400026|376014|260925021311599003|260925022911599003|260925021911599003|56012099006|5023799004|11063799006|18002099003|6133799003|10067099003|261022113327099003|261009223027099003|261026130827099003|261022115727099003|3023799007|261021123027099003|261026140227099003|261022105027099003|261102123227099003|261022075727099003|261021130227099003|261021135927099003|261021121427099003|261028144727099003|261026121527099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hy0SyMUYLA1SPBKehUDeSyFxvaGWApqInuUNsknQ43m9rKHXsgINQi6gNDCw/fbaWVLfczbKAzExxPqJCauI2lj2AgnbDyMsooP+AP1G3BB+5hu2HHAsY2D3QrFv0gl70qpfjxVQ4RvB3smdDsRv1d6+qELwG+3mqoI7VlfgmDkHRuwbLPyftygLdMDv5eMwestwivNUip8DhfUF8tIeTLhPdGJopgV5Bqa3wxH3deVqfe/HvFXWZ7I/xQx6cvw6mDizQHenlPWS2Zxv/x1o/BV6d26DiqKAq3LcEklZWU2intrZch2TGP995dK2cJmmQMkmic6jhU9NMkMW//QH/rt/vv+ZooMJBW7VDXB9gn7SrqHlOJ1T7100e1WM4fNZOIij/AFABq0PqqrnAyYOMc9g9fEaPWkPWc58LtUsNflBA3k/0qvR9OFuLc5uRf/mnOY03LGIoRHKW79Ut4wQyhsYub/Eu2ZQsCYOj6bNdUwq06ReAhDWleB/cGsYIGi9p8JOCzV/uxgJTBae/N4ytpqYuXxAktLmYdtAJvVNCDHBhrebKAnq7DYTSPtcs8tEvuK2A2escEzzpYPWp0SfQySQU/cMFez0e4Ei6ogjYNKTiWgoG1IXeMz8ok0XzOGtQpvd0FUA7ad/pLz1LvKL1oDoKzV1BMsjICX+J9eNSShjfShXN7BzxwxPDz3LuB54oL7s2eGyB7ibIkyqgDU4Qw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(23010399003)(82310400026)(376014)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(5023799004)(11063799006)(18002099003)(6133799003)(10067099003)(261022113327099003)(261009223027099003)(261026130827099003)(261022115727099003)(3023799007)(261021123027099003)(261026140227099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021130227099003)(261021135927099003)(261021121427099003)(261028144727099003)(261026121527099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YdEf130F0d2fKwfLzv48L+IF/UdGd8T+AO5lxgHaAJF2vfOVG1sjHwWRPyizARKK/41RmrTJvwQdsvGI8srjegjsFwTraHEtrNYDaqMCDj7BEPlV8Mvg44fGg3UzJUFKqhXr+XO6WoFpl+3N5RAx9kWHKlN0BOtN0/RJoGNlr/lKk/gT72h15/WESOPuou6WGkwoDqOuSedUkPIfOL5/OCqAfS/Xz9NYv9iEvAcT9U75I0xzyUdO3UMXY8MfSc9MhaMYrq+lk0i/EgJ0KdhkPEvQxflwUHhGFigrgxR2nbIpWFkXItM9a922aM74J7QvMTrHy6Gcmpfww/auGp6KOXHx1xo8VSQWLRW8OrIeWSOwjxqIsY31w0ij7No9xqhZ5HD3MTrrHOd9sL4+6V8PYmktG9cCauGU+mb9x0zOlJIFs9SYUj9C5drYWvSA5kF3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:28.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e701ce83-5600-4bb6-9599-08df46874436
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDDA81179A

This is v3 of the Rust VFIO PCI abstractions and the NVIDIA VFIO variant
driver [1]. The driver uses nova-core's typed SR-IOV PF interface to
create, reset and release vGPU instances while VFIO provides userspace
access to the PCI device.

Patches 1-5 add the PCI helpers and callbacks the VFIO abstractions
need. Patch 6 adds the VFIO device handling common to all buses, and
patch 7 the VFIO PCI abstractions on top of it. Patch 8 publishes the
typed Nova PF interface, and patch 9 adds the NVIDIA VFIO variant
driver.

This series is based on drm-rust-next with the Rust PCI SR-IOV series
[2] applied. Patches 1-7 need nothing else. Patches 8 and 9 also depend
on Alok's vGPU manager series [3] and can follow once it has landed.

Runtime PM is not part of this series anymore. As Danilo suggested, it
will follow as a separate series based on Beata's generic Rust runtime
PM work [4], so that the rest can land independently. Until then,
vfio::pci::Registration keeps the device runtime active while it is
registered, so a VF bound to the driver is not runtime suspended.

Changes since v2:
- Drop runtime PM from this series (v2 patch 08 and the runtime PM
  parts of v2 patches 04, 09 and 12), see above.
- Put the common VFIO device handling first (v2 patch 10, now patch 6)
  and squash v2 patches 04 and 09 into one patch (patch 7) (Danilo).
- Drop the bind callback (v2 patch 06). A driver registers its VFIO
  device with vfio::pci::Registration::new(), for example from probe,
  and unregisters it by dropping the Registration (Danilo).
- Patch 1: say first what the function does in its documentation
  (Gary).
- Patch 2: return Result<u16> from vf_id(), and add a C helper so that
  it builds without CONFIG_PCI_IOV (Danilo).
- Patch 3: make DRIVER_MANAGED_DMA an unsafe marker, until the DMA
  setup tokens exist (Danilo).
- Patches 4 and 5: use Device::drvdata_borrow() and #[optional]; add
  the pci::ChannelState and pci::ErsResult types (Danilo).
- Patch 6: add vfio::DeviceBase and RawDevice; use GATs instead of
  ForLt/CovariantForLt and drop the covariance requirement on the
  registration data (Danilo).
- Patch 8: drop the CONFIG_PCI_IOV guards, use a pin-init
  self-reference for the GPU, simplify the SAFETY comment and use
  enable_all() (Danilo).
- Patch 9: rename the driver to nova-vgpu (Danilo), and adapt it to the
  changes above.

v2 patches 01, 02, 03, 05, 07, 10, 04+09, 11 and 12 are now patches
1 to 9.

[1] https://lore.kernel.org/nova-gpu/20261023154009.2246627-1-xinmengs@nvidia.com/
[2] https://lore.kernel.org/all/20261111223337.508989-1-xinmengs@nvidia.com/
[3] https://lore.kernel.org/all/cover.1793906667.git.alkumar@nvidia.com/
[4] https://lore.kernel.org/all/20261026120523.526942-2-beata.michalska@arm.com/

Danilo Krummrich (5):
  rust: pci: add VFIO override device IDs
  rust: pci: expose the VF index within its PF
  rust: pci: allow drivers to manage DMA ownership
  rust: vfio: add PCI variant driver abstractions
  vfio/nova-vgpu: add the Rust VFIO variant driver

Simon Song (2):
  rust: pci: add reset callbacks
  rust: pci: add an error_detected callback

Zhi Wang (2):
  rust: vfio: add common VFIO device handling
  gpu: nova-core: publish typed SR-IOV PF APIs

 drivers/gpu/Makefile                    |  15 +-
 drivers/gpu/nova-core/driver.rs         |  34 +-
 drivers/gpu/nova-core/nova_core.rs      |   3 +-
 drivers/gpu/nova-core/vgpu.rs           |   1 -
 drivers/gpu/nova-core/vgpu/vgpu_api.rs  | 178 ++++--
 drivers/vfio/pci/Kconfig                |   2 +
 drivers/vfio/pci/Makefile               |   2 +
 drivers/vfio/pci/nova-vgpu/Kconfig      |  20 +
 drivers/vfio/pci/nova-vgpu/Makefile     |   3 +
 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs | 375 ++++++++++++
 rust/bindings/bindings_helper.h         |   4 +
 rust/helpers/pci.c                      |   5 +
 rust/kernel/lib.rs                      |   2 +
 rust/kernel/pci.rs                      | 194 ++++++
 rust/kernel/pci/iov.rs                  |  11 +
 rust/kernel/vfio.rs                     | 433 +++++++++++++
 rust/kernel/vfio/pci.rs                 | 777 ++++++++++++++++++++++++
 17 files changed, 2011 insertions(+), 48 deletions(-)
 create mode 100644 drivers/vfio/pci/nova-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nova-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
 create mode 100644 rust/kernel/vfio.rs
 create mode 100644 rust/kernel/vfio/pci.rs

-- 
2.43.7

