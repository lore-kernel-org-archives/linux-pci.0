Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436547;
	b=aLduzeJ20v2TrO0u6+0m6KFUO1IS/Lx8YPuOpH11rI0jf8zcLqCdHn+fuKf/xjDmgUHH
	 Uu1Z7GncYt5FpvwQtruwOXMR8Ddi7tFCDutKn5yx/kXo1Q/upUJUnKw92FcnjcfrrmTdZ
	 BKEK8doDweWPcrGNamurJahNb/vXhrxc6LbRBPbK0IbtXRTfxC7yB2OWjWjDcMEE5P/NV
	 SUtwyz3ERtrkpsthgGTRR6O5xo1BUk7gyTHxXQgHgkCWRiDdQsR4RusbKVCVvxPgSIXPc
	 26W2/rxVF+Op6F23ShEPitKYKoNtTmVUOchonrZ/LD6ptisLnwhuIuW+Zp3UBxaooZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436547;
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
	bh=2IJ2j4eViVeckLOZNJLGcdOc97spLCWTuCNroI0kBaU=;
	b=ie4phEYlUELrAvzvYL0tJmMPd50FmrSfiMVqJ3wAhXgYdUdv1sCp60XwM90gI1ztuPPJ
	 NlAztNjTK/eMDkatMxong2ncUgfmBFTg4rEWWqioleaAdvFG62U0rouQxqL3xDhtMgJS5
	 B/iuYR72iVWwyPJzQ1tIwzoqEWTKkplru5z9MMVgRz4ovN5ltdn/EbyS4aOPgvgSG32mD
	 dMUAsDDlKKKIcnGKDbK7oYKdQgk8zS8kjgyZ2NyNhql2rVmeb8o9lp0Lr1XwgO+Zl9e31
	 TeTXxBBueNarG/2Z+5HCIeGC8buBUrj0knFBip6RWbdncnC2WumWw/aEe4mNqsSI/tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IRcEL1oZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.7
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1E606A321;
	Wed, 11 Nov 2026 22:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IRcEL1oZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri3FTDfycB0t2SPftPz7ODBeG7iSCvtw1g0bJM+qEc8ZGpaPRCabOg/wzLaCJ8Z6Uqkp5+xtZeLpVkwXJrR3vME8lDkAI4G/9KqNtG1SZyvrrDxsWPyO31AyvQM76lnmdvnUs5nILoLiIXcz/4lDyH3bXh7t3SyKrTThE0im8wl0mNoGKQ8sErCRJhXcHfoY7DGvFVFIukPHHlfbwlRxG9zov1FSBDmMjNXLjT9lBSWQ2LCL3WUH4t8offATlkwGgp/4bs3BlGDyFF5swkDLifJqGM9bHMweXkz+0Nav/mTdhHvkcFHDS8ANViXQWjW1uG6tqU/+rtrNP9F30bKXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IJ2j4eViVeckLOZNJLGcdOc97spLCWTuCNroI0kBaU=;
 b=sBFcPoXCQlDO+6yXbqoE1zJBNRmiaN8HrpBI4QbCNODnI1p1TqArs2+qee/wbWIfhdAcir10dBGJpKk31B+U/dgfmINjX34ccNFtMWv7Zr6LtYly9YMlyiU90RSMsLcpn+Vr76DZfzwdOXq8xW7dcw6+EAYGpzF5oKSqA7N6c8Yz0H+WA6jDMeK9+AZt/Xx4sDY5LlYAiFuLcqmaXqRHN5ZUk4e9kR4+JWpns4/zSoKnyU9jk8RMGJ7YLj1Bl1cuEc2wFjM92wDmzlrPkFXkPq2xvbzTnw6qUGHv/MJEzfZraBAX1ijcCHfNskhUkThUhdoezmVfgbgGp05XYenO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IJ2j4eViVeckLOZNJLGcdOc97spLCWTuCNroI0kBaU=;
 b=IRcEL1oZogiKZtzT3IBwUdldiQC1Cl4SmofnPqd0Zznp0oryhXDBZLd7E2Q16Lj4I/vHw4dYq23qYQ2DFqE7lyos2N4EGOwk1FDZ/WQQ6AO0ZXwWMlLpb9dYDJ38vIYE1ti0LTKVLVmaMuTkayjEb60es0+o5epQNn2ryVonlQdrr01zuweVIxyZnNDRLKj4HyiEFI2+1SV7de6XSU+hYOAbDc4itN3jGv1JT6ViGw5pobJjVeI02eBUdGnPEe47Puj/cT7k1xM60c6Hw/XCCgp2LA15HowAfMUexE8UtACTvel8zGnkJNBVtqpIcLS2Va9s2bV/fcuksEM87zXYFw==
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:18 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::29) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 22:34:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:33:55 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:33:52 -0800
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
Subject: [PATCH v6 00/11] Add Rust PCI SR-IOV support
Date: Wed, 11 Nov 2026 14:33:25 -0800
Message-ID: <20261111223337.508989-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: b0911004-3b84-4249-f413-08df4043ec57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|261022115727099003|10067099003|11063799006|261021123027099003|56012099006|261021121427099003|261021130227099003|261102123227099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261022113327099003|261028144727099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	U3/O4C2Wta1FIuO2vAp9ngTJY1gecBDb40S4tUyJEMx5UV2QiV4mp/najCbJhN858Q/+nxfWDalxMlzu9xg5ihJAFZAfJo6XV6JZg9IX98oom6Gne1QQzwiotsKjqJLlMG9hCkTvMQ5wZUnscuBR/mHy/4p+DAdddNWaH3zLAMn/I1OCJa2zS590g9EEH/ryF80SmiwiZvHVpSTs6MSkZrFSsJV3Xfsc8T4iiELPF0m/kguo2dpQeUHJVu3kX1JSzNwAr6peLpjvbiFZ6EeOYKweShDRmi36qENjmre+d/hZpKmR1o2nJAAJ2q5dT6l15ER7+3g0pE2exnK3Tm20mIb8+zTy2BAKWzefuZwhE7Vrsg8aBqBEg3qYa8Na7l07XCsY8OlL8CBALlt2V++ZPWfjX0zz+YBTsD2++3OU3L2NydbWNHkWehXfM1gPZtxIrVEUJ6JdPg692ipLk8B/jOC25y5QG8yF1C1a3M7hyQdD/AyekbRuMOXXWmXbXK1Z53qKRD9xTTZiIlWZiy8i6naEcQ7aq3LlHdpLDvdlcb/sKEu78+fJIZJdGQwdWtzjGOXO8ac4PEYHjBji8FPE591LEG9yj3kvm4zstAS7p327hfw/xVvVPgWjaqViJtq8lZeid25Vk6nY7el8MAGwbKWg+K7HqTWCUUQEpckq8XmQNJbCxJLCKbGLGtJy28pgZnWdT6ZO4+Uv2u3FE3TJpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(261022115727099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(261021130227099003)(261102123227099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022113327099003)(261028144727099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R10V1iiAUPPhF9p7iW2EtDJ1hpQoZ+7BA2IWxQJa+rBSnLRIi4ESmCdCD51I2e6vDIG/0Vx9n1/lvgnJeRF84FTGBAKWQSk5m4RdgPf7K+t95vdDK+50bP/zF6VIbM03tx04AiOERWBavJroGpx8PsAJMHHFeuulvjQ6/+8UaD4BA4e2Zfn8kuIWVbGJn0d3O8NgjMy6KhOooTDTvEZVMWeLSaZV2XP7JWvTzQgZkHY119gsG8VQgOAfSzpnVP1woaVVy6hum0/53ODdWHQRarHBwM+bdgjoeh6U1UmkEm5EfGUtT2AcG5etqn/pKe1tIPYHabr2EoshXHfSa/2y6zEvFjB1xqEX4AVdg39h1bpmZxyq65Mxx2KWn7gttHpdEvUspfQKlNJevJx3L/Q+DN02G9ISOIFG/TDwLjCSOCqepOcWvN+7pgojyxylGls/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:18.0661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0911004-3b84-4249-f413-08df4043ec57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

Rust PCI drivers need to configure SR-IOV and let VF drivers borrow
selected PF-owned data. This series provides those operations and a
registration that keeps the shared data available until VF removal
completes.

This builds on Peter Colberg's Rust PCI SR-IOV series [1] and Danilo
Krummrich's typed PF registration design [2]. The PF/VF sample demonstrates
the interface using QEMU's 82576 emulation.

Drivers implement separate sriov_enable() and sriov_disable() callbacks,
each receiving pinned driver data and a token for the requested operation.
Enabling VFs returns a guard that disables them if later setup fails.
Returning the guard successfully leaves the VFs enabled, with
VfRegistration owning their final teardown. Drivers that do not share
data with VFs can register ().

Changes since v5 [3]:
- Stub the SR-IOV API when CONFIG_PCI_IOV is disabled instead of
  cfg-gating it, so drivers need no configuration guards, following
  Danilo's suggested diff [4].
- Add SriovEnable::enable_all() (patch 9), following Danilo's
  suggestion [4].
- Split the drvdata_borrow() safety documentation fix into its own
  patch (patch 5), and explain why driver data is dropped before
  remove() returns, following Danilo's and Alexandre's review.
- Use NonZero<u16> for the requested VF count, const_assert!() and
  #[optional] for the paired SR-IOV callbacks, and document the errors
  returned by SriovEnable::enable(), following Alexandre's review.
- Build the sample as a single module with the PF and VF drivers in
  separate files, and simplify it, following Danilo's and Alexandre's
  review.
- Collect Alexandre's Reviewed-by (patches 1-4, 8 and 10) and Bjorn's
  Acked-by for include/linux/pci.h (patch 7).
- Dropped Alexandre's Reviewed-by from patch 7 after adding
  CONFIG_PCI_IOV=n support; the revised patch needs renewed review.

[1]
https://lore.kernel.org/rust-for-linux/20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com/
[2]
https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3]
https://lore.kernel.org/all/20261030171230.196717-1-xinmengs@nvidia.com/T/
[4]
https://lore.kernel.org/nova-gpu/DMRNF7IZQ1YI.1MRPH47QJC9XC@kernel.org/

John Hubbard (1):
  rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (5):
  rust: pci: add internal SR-IOV enable and disable helpers
  rust: pci: add vtable attribute to pci::Driver trait
  rust: pci: add num_vf(), to return number of VFs
  rust: pci: add SR-IOV enable and disable callbacks
  samples: rust: add a Rust SR-IOV PF and VF driver sample

Simon Song (1):
  rust: pci: add SriovEnable::enable_all(), to enable all requested VFs

Zhi Wang (4):
  rust: device: clarify the drvdata_borrow() safety requirement
  rust: pci: drop driver data before remove returns
  rust: pci: add typed SR-IOV PF registration data
  rust: pci: add SR-IOV enable and disable tokens

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |   1 +
 include/linux/pci.h                   |   7 +
 rust/helpers/pci.c                    |  16 +
 rust/kernel/device.rs                 |   4 +-
 rust/kernel/pci.rs                    | 116 +++++++
 rust/kernel/pci/iov.rs                | 468 ++++++++++++++++++++++++++
 samples/rust/Kconfig                  |  11 +
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   1 +
 samples/rust/rust_driver_pci.rs       |   1 +
 samples/rust/rust_driver_sriov.rs     | 178 ++++++++++
 samples/rust/rust_driver_sriov_vf.rs  |  49 +++
 14 files changed, 853 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/pci/iov.rs
 create mode 100644 samples/rust/rust_driver_sriov.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs


base-commit: 6e557330b874b0e1fdd03e8fe4c438f36c93eefa
-- 
2.43.7

