Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC08420479;
	Sun,  4 Oct 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115689; cv=fail; b=XrMW2lVTnIAD0AytzBODQnhQWu3PYFOwYZlik28VsGjN1+uxNElYOCxsDwkgBrUdD7Q2AusAgqqPQj2HYMECXl0+iiD13A0PZXMaZn2RIvuVb8/XIK7hEHlv6bAy8Cm0yY5+COvDXa4A2HFrIVHIts3gdnqCug+r6g53esdzuZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115689; c=relaxed/simple;
	bh=Pp7OQEyt5TcE4s6Ws2kO4kaei91U/WWPpM4IyOq+kDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=daGBAKlI2I6ptEcKXB4p3UFSnnYO5NKZa0EL7+fMJlxaXJlBtEYPWVauikRuyKaNEtTgIVXM27ZVrwTyGRGg6tksGvEIP3e5NEtkPOZTi0fhi3wRjxv3sbeX9W1v2TWvw7G23gKo9EvsSTA1IdlWdAAAsjRii9lp6keiHUeFpWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdMiuMfi; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdMiuMfi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL+Z2iLNQLWMQc8HYwykoMCL1O/70t5J7pyufwhzvsoGhoiIaYr2MDZ8pvfPDa4VzEnibrbBLNZrMIJPy/Y3ClN6fn+f51aQYKgMOVcCXhQltwamFyi8NpmOAFPXEeUk5BuzO2DnEETuAO750iuc1Nl6wPsQlmJchUEqGWMHSdkrMzgdD/nnMpm1XStgOomcmhHRneIhkK2VfRrjQ5AcvS2IglBtR/QYdvjRzxbO7FLIys/9p6thFCNmfnjNn1yi/WtDoWOi9MEMmOkFHnXcBPFWd66hGyKM8vGFj5FiWIFviP5XNQYLLsbPNpN7D3uzw//36L3PMVEZWqLYeWwhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8saoni21JoQKE2xXIXPAjqEZzsm33F+a2r9VXgazVak=;
 b=gQA4SjE2hZbSNN8RxA1iBmLiA8jGDyiJYX1P4voJXHRagru9NykyG5bLLBBXjrZEOnh+Ze4PomV+/xz+HW6wbCNSQttsWWQtYx/oKjGeyPZEZGh6beYx2vT8JBu1NrrvQSWULcJJbz9iGQBvqTf0kAnrjHoF5Pw2UDvHRBPplTm6d8/Gi4LS3vbOn/UMCUyZwsTIOPR6A53w3dwT/NP2iCvfnA6+zF9zmwwAqJa4PlcbOR9H6I03W7TJVMMQYXzf8vXGPQcIaGwsfW9KvOnkxPBtcSoRU1aZGt+o1+HpunvsiWQ8YoLculL+FuTFJTv/lJOouBua+CNOTlmfJgQeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8saoni21JoQKE2xXIXPAjqEZzsm33F+a2r9VXgazVak=;
 b=cdMiuMfia4gFIUpaXIIlT6N40IuNZmIo0rU0h5fW2oO/wPLztFVzybLkJnh/4rQe89Q2GI2B4Dp5X5wDxJgK4Vfym9GCm17Dilpdp7XIsJCyvz/Q/4DY3IhZ1ov9QMh2ldFn2oyuHtcFdUKUozz4HjrdctJ1sn4cx6fdUbvgcWencBfvq5yaL6+z6RLSnwMwA3J0ZdNhApsX+y6dS+4ADtaf6nNLuIEqOoBSu1HFIEv8qz6l4GugYUAUoCsnXeDYlIJrqm3jbSz6QiiilNRePl43XBexQBgoIEGl7bXeltZ2rxRU40qAqNgpuefef0dJ8ANIv7rtqHCcXYzP5Zy4qg==
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sun, 4 Oct
 2026 12:08:01 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::61) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:07:40 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:07:34 -0700
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
Subject: [PATCH v4 0/9] Add Rust PCI SR-IOV support
Date: Sun, 4 Oct 2026 15:07:21 +0300
Message-ID: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 62155875-dddd-40a9-d277-08df22102306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|1800799024|376014|82310400026|56012099006|10067099003|260925022911599003|260925021311599003|6133799003|3023799007|11063799006|260925021911599003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	6yEdcNFycUj6cFaiMiKez9g5N3G9PgSsCN+DRsM/bir49bBBsJFGmvg52Wi24iR6fDnp17rJH3zEHYdQumnpLGyjcfnqTejKUQEXJY6Z6o6WO8Zwxjgri+pBjejjQjuViQDJd0QCnJ2/DggtWkyT5+w8ENO20MNIlGI2gd+cJ6siwkT8TVyP9mQgRMxLR8BnE6Znoll8TSHhiaEmeUvtFU6H5MtzTbOmRBo+l2uBRBxDRmF+hCziNX1XWM4VHlCx9PhNICy43OcKKutEejxqn0tCy3iViw3h6Ne9qtX7IFyHrurj3c2c34Lxl9Hp+wswZAKlYIRgSezcQyQJL6g14GfmwSyr4MgMjY5kPISLEq8Ea4ytzlDoJs6X41wcucWHFxcbsE3JBH/JH55PovgeG3ArNIUdJL26agT/+Gf0xU8ZGYw0sT7Ly43AcSRSz+TOb/m13OSgAGx7bkpM0rJnRceek/EicGcsHBQHj98FY9o9BeN6sI3rX2vwjneYkIZ25n1b4tPKL7gjcONYrW1NKoUjP0aNgPT6thvBGIsr72/4Q3i4M6lTFcE7PBoN9kKLZyv6LSRrwyOIOxkZA7h7eiJXYi2zUrsRikj1msxqt5ivfsiey/DvGgNt8LnmylHi7u7HJopqyGl+ooSVerYfUMpYV1bfffFvA1fZcKABCCGC+VKf++s0p5/Fs2LluoeObrWM8RP32e9yHwCxiQrSsw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(1800799024)(376014)(82310400026)(56012099006)(10067099003)(260925022911599003)(260925021311599003)(6133799003)(3023799007)(11063799006)(260925021911599003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UBz9BLQXdO+IpZ2jfNYrzmyDeBaGBZLbSeFt5tyQL8VrM+NgmGIyaOwZmDppxuJ9vTs/nyWNfc2OMc3JwrZU8HHwDylePLx0bviMAhCbo9LuNdhf7K+Wvcn9DOGTCJFdedX9whrOmjfm/h34fRiLeWk4AGoN0XBZjuaTS8BcV0rL08XMrT2artmwVeH9O2WDsOsMpdknibB2ZYKddZq6sdOPmedo+4rGncFLmzRElTbuYUVDPfsbnzWOh1yg/L3HPCyuj+Gl1SaGwR7wn0v/srVEsBRhsPR7o387/fAQpz20w8/A+58h0Wsf0z9T73kMwzqm8/CE5k5p6uT72+DN5CXxLkTWPdJJpsdJvVmJ565eXBS5t9Tlwwp3liZG5kyjP+c1hGui2Q4IkB0/zymK3Y1qK2UcbA8OehdnEGHcqZ4kYZ1+X1PeyCrdt/zsl5PD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:01.0537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62155875-dddd-40a9-d277-08df22102306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

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

Changes since v3 [3], following Danilo's review:
- Use u16 for VF counts throughout the Rust API, with conversions at the
  C boundary. Restructure the internal helpers' SAFETY comments.
- Generalize the internal registration-data initializer's error type.
- Capture the Core context until registration initialization completes,
  and use the safe num_vf() helper.
- Add VfRegistration::data() so the PF can borrow its own pinned data.
  Return ENODEV when no registration is installed for a VF.
- Use a single 'a lifetime in the new callbacks and tokens, rename the
  driver-data parameters to data, and use ManuallyDrop to disarm the enabled
  guard.
- Remove the redundant PF check from the configure adapter.
- Store Bound device borrows in both sample drivers.
- Split the PF and VF into separate source files and modules, with the VF
  depending on the PF.

[1] https://lore.kernel.org/rust-for-linux/20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com/
[2] https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3] https://lore.kernel.org/rust-for-linux/cover.1790705494.git.zhiw@nvidia.com/

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
 rust/kernel/pci.rs                          | 108 ++++++
 rust/kernel/pci/iov.rs                      | 401 ++++++++++++++++++++
 samples/rust/Kconfig                        |  12 +
 samples/rust/Makefile                       |  50 +++
 samples/rust/rust_dma.rs                    |   1 +
 samples/rust/rust_driver_auxiliary.rs       |   1 +
 samples/rust/rust_driver_pci.rs             |   1 +
 samples/rust/rust_driver_sriov_pf_exports.c |   9 +
 samples/rust/rust_driver_sriov_pf_main.rs   | 173 +++++++++
 samples/rust/rust_driver_sriov_vf.rs        |  70 ++++
 14 files changed, 837 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/pci/iov.rs
 create mode 100644 samples/rust/rust_driver_sriov_pf_exports.c
 create mode 100644 samples/rust/rust_driver_sriov_pf_main.rs
 create mode 100644 samples/rust/rust_driver_sriov_vf.rs


base-commit: 7db73c69c8311bfe72b3acbd6807d57cd755bdc7
-- 
2.53.0
