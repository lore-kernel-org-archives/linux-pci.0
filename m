Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527A2E11C7;
	Wed, 25 Feb 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042746; cv=fail; b=M9ClyCSCodqusfS35zSgccpIWLeYqeet5WjgYhW8dERxo7uiKv0HH4p4CZsApRjmmSIZsvvgB/wTc9K+KGvFBr4SDrnwq8gpKh/mq3N6fKveKraccClLEEkEcIsC+qGfwKm5Ve69inKRi028jITPX+2L7NB+U83VRdxm6zf2j5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042746; c=relaxed/simple;
	bh=cRkx8UKVx4b5dqolCi+BVh5cFARASaOnETdPtoYf9hE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eECGAU4NWWcvcslG65D+LyswiAvHVAl+UFxFIhq17n0Jn5h5Pgt3593dQu3TReXhhEzGl47J85oFhIuI2rGNpVjXf4tqLTylvrGJA8fa/Ahj1/DLc8AJSOtMhq692HqJ57T2aU2VGNV3Xt8P2eUaiy5/CEFfzpJ7AfiZapW80Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VL5aae/r; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VL5aae/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp7uXHr32IFpFsUBiSE2yK5lCSTJAM5w5WF5UqaAlhL1CMPrKtrNyoRN2ekowxIs62VqpOX7+DJEJj4lCEeI6UHKMj4xKJf0WatAeZ7rub4tXzhqgTzK/LuBjZXPGvNRBU8Oid3fdzce2Zcw/NJUqrxJ7kDWCUNZyKX+ULu2Fop2BfuqVubI7OTsYJ1m9rEHuXyBSO0DbvWEsoQVoifWsj/ylh0TimwbGMxdZ7xXonqOONn553zuNl0H5MvnN05anEgyHYtAMQO9ISqA4RoTBIv20u0/AuLn9LZXMyUbM5p/eOTASJqv9bq/PItyr6Ip1KuLsQbR/Xz/X5pyyKdqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCtIpOxdlZQW05hnzjffy7um17Y3GJ2ud7+bIqKoMhM=;
 b=KmtV01vO0bYpD5vb3q2Q7IDBM9Rr7n56sbzC4UP3iEHjnSsvGWaShPHQVp3lOfb8whpyNovXuawxcPcybg/wDMm98Ma7az8+8WqiiDCc5Jt6btCmPuCYSuA4koma4LWorNlSJw3SwDsQmBt+O2AS82v5MvOtMRtQnTdAIdVEMxFnrqWMWbXcz4f7K/pLuNkJuMuQbaTzZ2nXJQEZAzIf8I5HHIPK665T2cGAMi4uVkhRZOJX5HpWle1q1a+6gMNopqSp7jJ7D3r/rz1fTFnEApa6GZalM6liliFFAM4kkrF0gfQvc6GU61oEe3le43NNtglp56QBbuxGkoZfOBgaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCtIpOxdlZQW05hnzjffy7um17Y3GJ2ud7+bIqKoMhM=;
 b=VL5aae/ry/jKqmJBq2M+q5ZrbhSgO1JQucF40Jz3Zz8VVnOLVy0GWbXTAP7VTWU7r863TcxR0SytrVQApCe1n0m3SitU8YUXaKmiBxyq+wWaEulJVs7/rn8n4XVL2rZ7Ngz4gO5XnsFRZy+Z6LB4xiBNxySSpjLXhvoWtXzM7w1gdHzGFEI7IlmrbIUvI+3V2mYdRv8i/9tZI0WfuxN3E30siOCM0tU0NLfqc0m0KQzT/YgINwwDxk/KvPSym0DikwFXLpAcftDMziw0FrA8Yka+Vc0+8J0sOQqZMD6DzVSOocO5AiDarhqCYXUFoNUWHeUElRYjDnOpcfMrD9sWsA==
Received: from BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 25 Feb
 2026 18:05:29 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::3) by BYAPR06CA0072.outlook.office365.com
 (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 18:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 18:05:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 10:05:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 10:05:03 -0800
Received: from inno-dell.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 10:04:53 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <kjaju@nvidia.com>,
	<zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC v2 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Wed, 25 Feb 2026 20:04:47 +0200
Message-ID: <20260225180449.1813833-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca7d15b-ecb7-40c5-b4df-08de74987589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	8sgx++NzxfoWNtuVypQu+zMUpQY/X6ZOaWkoKyiNrUHUmgY2dn/Riov8N3WOGCfdjxCw725KjCaGo7yv4EuS/ZmwNVTLQz+cyHZkzsl0dXxlM1jAiKeEIvHpKDBi4Evrj2SHbW3S0OLIrbnoKEZ3zhvjicNdewdzizMFRadulPaY62JJN+ugRrzFao3f9wFPQAAu7KbXGRtsSMDxV9cYQevHuNnjDjG7pMBaJFAPqcCmOua6npZUr0XwSU4UGcSW51/yjp36C+ctdnZy9jeY3h8rphO5qAppQgFaFfu2RNGHvCa7sWXw6wzxYsEqS/LvAfLrhBpMsaVKDxsWJPAkBWNyeLzovUNG8G6BFL+/F1B3UQOzNo4MeV6VIcFRwey/CfIiA8ZC80DPdfaP3K2dJZ03jOyUicuzeNczdtOf9n9yeyOUOJehB3EFg7V+mH32x2BXw/ITpWc6kpE6dSNMumsM7XuKyOR5oGwFK8icpTq041iJtqcfl360MjWibhlI/xMTj2XrrgdK6rdCtTwgiVcp/BfkRRMpa0v0Yq5gS9zfcmMihKecqur1oJSj+j329lh3IS9s6F3ki1EY3dlf40MFEkKH1+2pLWrLeQRnT4rwcT2D3PCvq7RMfvwzVYOtXYRVPNFYH80crpE4R2ZnlbPYjXpfpXWFxua4cGjo90zn5zTdWtgPk4gYjV+/VqbTfqmerFG1xojHcmZeV+vOdk4ce3N+yGmvMRjUET3AhwkpI71FUvbO1hXHzE+lo2DY5/M/qd9DSfeLvrd1QccZOzxqaCp7C+7mJLcmt127SVREdJs43PpzdbBDYjHjL6kJqMH+8NrqP/+0b4nSHXO5sg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BGjtwa691NWTzJdMZacSJMSCfwkH/o+DLeFR3u2ZFfUHAnzVdbkAkOlDRk/hODNJKqbWbgU4b4k88Yt5dbmiy29Qozt/wPwHoA9SbDXRihqQrjvZS+ooXwRhm8O5qPbUALbSa+7hUfKqt+2QGotafo5hM7iqovBP6L03fiKg2jgXvIPOtZ/aQLK338/Zvatlw1/gTmI+Kg2fb+K+7Lj+yYY4WB8a3COJtYFlgr/7lwsC3XaytjCg4kINoBqivl8e/aavEvQNG4X6kNvwG3vM2uPBOq6KAbMrRi9AncFJaLMCufl8DMld/yWRVCgx9eguetU118ykz8avwzHCV1mnGQYNh5Ot5VKj0s7enpaJC5HFPZhyJ4U0I9tw2mAP3LMJI+a3Y+91znqdw6CXJjPDHdX++gvBpOSyDJfMxx38D7rnlw6eP7r0E+HCcze1Sd7C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:05:28.7587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca7d15b-ecb7-40c5-b4df-08de74987589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF

This is a follow-up to the RFC series [1], reworked on top of Gary's
io_projection branch [2] to use the Io/IoCapable/View infrastructure.

Patch 1 from the RFC (fallible config space I/O) is no longer needed,
as it is already covered by Alex's "IoCapable to functional trait" change.

This patch introduces ExtCapability<T>, which implements the Io trait
for PCI extended capability regions. It delegates IoCapable to the
underlying ConfigSpace, so io_project!/io_read!/io_write! work directly
on capability register structs. ExtSriovRegs provides the #[repr(C)]
SR-IOV register layout, and ExtSriovCapability is a convenience alias.

Changes since RFC:
- Rebased on io_projection branch, using Gary's Io/IoCapable traits
- ExtCapability implements Io and delegates IoCapable to ConfigSpace
  instead of duplicating config read/write logic
- Dropped the fallible I/O patch (now upstream in this tree)
- Added rust helper for PCI_EXT_CAP_NEXT() macro
- Replaced raw `as` casts with From conversions where possible
- Renamed SriovRegs/SriovCapability to ExtSriovRegs/ExtSriovCapability

[1] https://lore.kernel.org/rust-for-linux/20260126215957.541180-1-zhiw@nvidia.com/
[2] https://github.com/nbdd0121/linux/tree/io_projection

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   7 ++
 rust/kernel/pci/cap.rs | 244 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: d6d357817b3fea5798607d04ee5668894705a0e1
-- 
2.51.0

