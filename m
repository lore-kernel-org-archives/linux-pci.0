Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EC4BA1D0;
	Thu, 24 Sep 2026 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276808; cv=fail; b=DhpseyzCw/xkwy/Aovog9UIAsWq1HAUDSpEDCIzFXskWioAhDKQhYAdypSizAc047cT05JUggbCTq7pP+Vl3J1bdX0juF5Iz6y1jI216iY9R6AscPd3DzkwrGCxllL7IrLeJ42Ng6iLI15unr3b1xbsPs9ZjiaiiBB0+BngkFng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276808; c=relaxed/simple;
	bh=OGfVGZTuXtEDasQeQatQHqN7ZW+JG/UMCVKXQiIWWoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1lhh5Y+CiPXDef0w7HZcU9VbF0gl+9gZW3lpC/gN0ioxiHlNE9Tn7H9pxAX9qcrf7o59fTZ305E2MHLRoUK6nfu4z7t0qX337RxCVonXy2OeUSwS7xE0fY//s+++SVPmh+LxQ1UvF0NrJ6U/hH42sZMipS5weqiDKBUR4oQR7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WHVvWkza; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHVvWkza"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGeWuNW0IQoBDsirtXtO75yREgnsmClpkalANtF5wDrzwLtqfl6e2BGyBmof8KK9einHuez+Ed5XNxgt51EgRUyebkYEA6Lbg/TqzKkYYFpHcKGwAwRUB9poHQp211hn681K6Wz4VGW9ihMnrVGE62ZsbPN/98v+CV9iRzbgrfqJbkIoQZdZVvVhx0rOdHG6l/1iZeY9vOnOy75HXQ6kV/3xRXylE12sE4K9zNnlUMV9uLxZHLzqJfLMf7j4NaKyje9K/4ep9Js5KHLnyFKw4nXA/LGik2mcN9MKCJ8cX6M/TWJJ4L7NaoBWHHUfsLiX/u2KqzF+L69ZiRc67PNwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UOQopu6/9A4bBM9V3ciF5SdnqBoCfQqD7XuNK/MTdY=;
 b=bCQBg7gQE6rtC7hHqpiLRCsVvZNW0FK2FgFadMPIBPBRztPvQJb9fX0DTg6Tbt3E1XvsUfWlWFgkWrdTW1uMLpsWzVHvfwxxeH05HvXrqRskDk64Nv3YaOTTO5CZJxZyocUc4zx0IcwVBhZO8EZX7tmNvuBza+ZEGrpWJWqgvUlv73a6rJQ4xZucb39IuGmpMrtWuehwor3da1t7kdLmTt+2qt379s70SunbfVTvz2GzX6nA/kZQGXMWtTGkbm6x/pQGr3+rroPT1MfaDjHiqqw93UbdoLyMqkjxaodixHK6r24fajvbL3NjWFAA3+smOraB9W/0n4ivNYeI5b6kJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UOQopu6/9A4bBM9V3ciF5SdnqBoCfQqD7XuNK/MTdY=;
 b=WHVvWkzakIEchmdtsWsWo1okeCauWjF0KYkIG/hID4s7nvJnIG2L4sqhmpjNzhjLZyajHVt71mPsirejl40CPi1Zos4uyGvQcqUW67YWpRjyC7emhbkGQAvTu47zmamfBDbSuuv/2w8iUf/ASx/ymhj4200BGvwhwti3vJF67x0XdIwNEE3pSWMPGnhgQM3egsan0iaxihj++VXYFh8TBbMJ0edVsPjkj0pVzlGp6tySgaDltbs7QZEVGTh7DGcUOf4jIXJ9+kJq0PbHwNNhceG0dAUXHCFZR8fK/snfC+CzXWEhXYug65CSmxpl8E/SBX/ht1c/B1z+VIyQ85rzKQ==
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 19:06:32 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::8d) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:06:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:06:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:09 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:00 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v2 0/8] Add Rust PCI SR-IOV support
Date: Thu, 24 Sep 2026 22:05:47 +0300
Message-ID: <20260924190556.1620886-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c35bb0-773a-4fb5-90da-08df1a6ef288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|11063799006|10067099003|56012099006|6133799003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	B3yBucfI9Y7+Ddyyb7L3jcD0mBOOEyS30szuySr/1WCR4kfN7DTyPcl9c3mpwaF7gGSikeKVfmpLlQR75aREWWhUlnQF7AaYRMNjvBb0TpxKy2z/Vd6jO3QyuoHItZD+Rc6YOE2eZxDJZDenWJ7bdxggJLYX0qfB3oZ6Kvr70VzWD4tqRh4a214EekY6uqstc4Dh5w1TYOkkCEfd+f2pT9GYMdWZcmmUtE65yIqFEk+lUy/dJQ54NZpXUSV0HjmiXi3Qhc2AvLp4J7KDKn+euxBqrhMFd1oQNbRXVAmJrFpJGtwbZkBYTJOHskS85OjjJBwak3HSQX9mHXiWMZCiYcQnj/+s57zxOaHzzP48CIomBnTpa2CZ41fYLmB3rR9nW+PVtC0Jx0FWLz0DLE5HCe8Dq2Fe95NSHtovdwezacblptAqhcrRhhVjDZxPi3dF1gTyzfcrUgft8sjIAsMclcgw/ltrEuSFX/JjlYBRGkt5usQu4LhUXWUGcEihoIaV3zZ+U2YLcfGoAPOOVjFNbZg0OpZkS63pPEeL4ETviLKq9BScmfb18s4mW5QvpQaWyUuOYCxtgOCcFQ65D1pn97HzERCJJlPDq878zXywtZXGDk60rsRY10kG8tadOeATtdt75b5+V0lSZ1jVgRjNchCWasOu5wfaLsvvO6BgKRm8lvHtAcHpOKrFad5GL7IIEBOSZCGlqw8tfgG15G4khA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bee92Uj1OcISlDLLxdMTstPIlrB6MsfrDmBbnUnbh0ZlbtR2Pd6OdPVBMCABKyb1xvBL/O+Cfeil2p0zgQSYRlUwwg3SAP2SeI38w76RXAbBGyz4bAjfRg9oP607d0zctK+UVV2Z//5Jf37oQ+s0RsxscuGsDRHklqVGHrIrdI8UThkuKlVHiH9UxbMBRrlmW5dgigFZp4SPVc4ggHhIQp1zdgEmOPZhoZA+3LbuSKshTtkHm0z7FxD+PdUJFAkB2foPNn22hzgCXY33a4iubSR9euNaO6/PTifgi9ZfA6xuH1Ea9arOqavG4Ps/ujFr2QGAl3hZSaZNvzP0JDDffDOj52eTtGpvyQlRP7zv6XAgbn60DMrucELSDIn6fZj8ePf9CVkK74/fPHaDwCl1Zxq3djegDj9f5RvUJY8sIF8WNAhxbwrDlX4EJoNb5kGN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:06:32.6385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c35bb0-773a-4fb5-90da-08df1a6ef288
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

Rust PCI drivers need to enable and disable SR-IOV and share selected
PF-owned functionality with their VF drivers. The shared data must remain
valid while a VF driver is bound.

This series builds on Peter Colberg's Rust PCI SR-IOV v3 series [1],
extending it with typed PF registration data. The registration design
follows Danilo Krummrich's Rust vGPU/VFIO PoC [2].

Add the PCI SR-IOV operations and callback, VF removal before PF unbind,
and typed PF registration data. A pinned VfRegistration publishes the PF
data before VFs are enabled. Rust VF drivers borrow that data after a
type check. Include a Rust PF/VF sample that demonstrates a VF calling
an operation provided by its PF, using QEMU's 82576 emulation.

Changes since v1 [3]:
- Rebase the generic PCI support and Rust sample onto driver-core-testing.
- Drop the generic C FFI descriptors, C PF-data accessor and C VF sample.
- Remove the managed_sriov driver flag and PF/VF device links. With VFs
  enabled, the Rust PCI remove callback invokes sriov_configure(0), when
  implemented, and disables any remaining VFs before calling the PF
  driver's unbind.
- Use pci::Device directly for SR-IOV operations and callbacks, removing
  the separate pci::sriov::Device wrapper. Update the sample accordingly.

[1] https://lore.kernel.org/rust-for-linux/20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com/
[2] https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3] https://lore.kernel.org/all/20260915205659.76841-1-zhiw@nvidia.com/

John Hubbard (1):
  rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (6):
  rust: pci: add {enable,disable}_sriov(), to control SR-IOV capability
  rust: pci: add vtable attribute to pci::Driver trait
  rust: pci: add is_physfn(), to check for PFs
  rust: pci: add num_vf(), to return number of VFs
  rust: pci: add bus callback sriov_configure(), to control SR-IOV from
    sysfs
  samples: rust: add Rust SR-IOV VF driver sample

Zhi Wang (1):
  rust: pci: add typed SR-IOV PF registration data

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |   1 +
 include/linux/pci.h                   |   7 +
 rust/kernel/pci.rs                    | 145 +++++++++++++++
 rust/kernel/pci/sriov.rs              | 253 ++++++++++++++++++++++++++
 samples/rust/Kconfig                  |  11 ++
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   1 +
 samples/rust/rust_driver_pci.rs       |   1 +
 samples/rust/rust_driver_sriov.rs     | 241 ++++++++++++++++++++++++
 11 files changed, 663 insertions(+)
 create mode 100644 rust/kernel/pci/sriov.rs
 create mode 100644 samples/rust/rust_driver_sriov.rs


base-commit: c15c5befd6d6150e92ab7c6c7fde1088e0f543e6
-- 
2.53.0

