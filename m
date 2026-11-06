Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945409;
	b=AsPFlr1EytwrR7OH6BcN8cI+4/HpOda6EWKqYr/TLmr/+VcJV4bshYIQNKNotzZx1wdU
	 4fQG0xI0nYcAYcStDeMZaCJTAqNOm/Oa7rjH9sjxAxS1sCXdC0AUR1Ds8h2kcWjV/IrA2
	 Ww0s5BDVpV2Rr4yFgHinOp2crhum6VdfJcWb0T20SFsyfzPUWN0Gh6vraB9x4jYdWhiQp
	 a/gokfqOK/89Loq+xyXt8B2lsK2hcyRbG/TrqEVYGHHyoRuHz28UlTbZ6j6bf/CvHqTvY
	 Fcd6SsJrqdaB9xrLSiTbeOAqBkcLW/hyBfhpI1T+oX+2XL3Tpu+X4zfta/kVA1V2w7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945409;
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
	bh=Sli+4FN+dbSB++d2zRyNmpBgBRMcLdVfKz+h6Da2QVU=;
	b=Mv/3facTmot0TIb5kOigzUkEfLzQVKU2apyWay5hdJ0feZotlsS4rF8r0v/XmlER9wMI
	 szUXSbIpTog4WQDkHGwmp7IuDcA36uEdASmFTYrnhWPbN/ooJn4x7ajQyVWWfqnV+E4wR
	 sLXqBprUic6rucQ/NdedMJK395jfd4j0lS7pCha0UyOXqU6/8RQFzYs+wKbMPVtUBC2hk
	 W7RzpsM9Zs460h1A+kbO3J8TE0cjzDZkVmTr4Ffc0T3h5sPa7hi2sM5iiPP1mlJi3fcH4
	 B/JDh7yI8rglZ4VS5siKwjehCxndDRphx9gUqjqm1Xjg4A+0U7uzCQtnRQYdtjviibg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fEoAcrh0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.30
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D743606A32C;
	Fri,  6 Nov 2026 06:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D743606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fEoAcrh0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDLdnipThvM7v51XM0nC+XR0ET+wfC9+obGRJkHnaPpKFWvobkXTopY/D1wugAhJ73B2DOtddoOnRNw7eKO4f/419/h/pepBhc81BxEdQYWOr9Ld6f0eqIip7A3wkSv/SX4gAvkpeY7nNMGgrXlVaj4gPH85nLt8wc72NNmlH+SFfsixJ4wZla+L388L7zOlWe96q1JS8IWhaT5AtqLGo23e0iWcs+3jlLEkmcA5+dM5BSe2OY0kuj1nNEgwXDBmee2sFArqaMxeFJQ/R2wSxVv1VAHShXRnv7Oahvgq+QAEwMYbUOuiJMvMCA5oHzz8gGGURqWpAWQ2aUQIJEN/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sli+4FN+dbSB++d2zRyNmpBgBRMcLdVfKz+h6Da2QVU=;
 b=n23/rwqk5tcSYvSwpnEx75mUm+OQUodCzDY+lOy4tlP6yO1b5FlL6LCMs+H71yl5hngIXX+4KNsGKtxfpPHfqicBpHyr0OkmU0RWffQTUPSE4FDZmk2st4hs1+ehtJjkPW3l4X1VxAkVkVUWxEMBR/V0252RzUf2CahoKb8Xlykvnq55vfeARrd8wrZCyxh4fVmEihc3t3N+0dQyDnfqPc4E/Al9JrST7vPjYC7ppHAbv1kk34s/Jwau23PBZ9zdkGjXfvtA/1Ciu5f0jaCTc/radwhvCAuzZ7CNAhPlTsIA3csFywIiB2c1/Xku08KawtWe8CPV+RBQISV8oZp2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sli+4FN+dbSB++d2zRyNmpBgBRMcLdVfKz+h6Da2QVU=;
 b=fEoAcrh0iHTd2txsVxWU0dziCJ2oH5JK7J2bReB2KuZFFICbYt8mP2pCLrbA+9ivWdgW6F/FgSEGA8V5zHjKpjYEa9znk271Rvru3SyVMhb0P90w1my+3tcbWUvCXJGqQnHVzPJUpzm1OvCAcXIuG0zVE4mFIl5U4L9OizYQvO2Gen0uQ/niR0tpw9P8LuKys+BTfc36xH6j/8mIXB9jG+eSHkQptDp3Tr314YxWXeNDUIuL4ud+T1+cMiMW6t2bdLSC9cx4n1e/9mWZpuKU5mEd4/wmuWLdUle0pG6QWZsVTMMcr1wAU8rjGduJEl5lgqFpy2YcQqSDqyIgJ1YTpg==
Received: from DM6PR02CA0158.namprd02.prod.outlook.com (2603:10b6:5:332::25)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 06:10:02 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::76) by DM6PR02CA0158.outlook.office365.com
 (2603:10b6:5:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 06:10:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 06:10:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 22:09:45 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 22:09:32 -0800
From: Alok Kumar <alkumar@nvidia.com>
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
Subject: [PATCH v2 0/1] gpu: nova-core: add fwctl driver for firmware control interface
Date: Fri, 6 Nov 2026 11:39:13 +0530
Message-ID: <cover.1793906674.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: a58c7e5a-d5fe-43ae-79c5-08df3bcc9817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|261021123027099003|261022105027099003|261022075727099003|260925021311599003|260925022911599003|260925021911599003|11063799006|261021121427099003|5023799004|261028144727099003|56012099006|261009223027099003|261026140227099003|261102123227099003|18002099003|6133799003|10067099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	5gyWxv9vGr/18+shmQWMBv76ZE2zknzJhvVRqHS2DlQkQgduQRuQm82GVet/x211JizN2khpsZYxa/u+DMIy+hFqSLgNMjd5zXbv9n/5ntFiLnIlugYoq9PYXjmnD4u5qKHcy/qEGMaRmoCvYakbXsrL1MMh65XkqPoh9sswZ9IGpyx81AuIG/1zNRNMNapFYUuj1UM9xZG+6FkigVJidiJhW//mF7hviAbhOo8ABA/ndUXrqspYGzKAKdThb3utIQIcGM4/BI8QOi9/A2glLz/BKPsnpwJeicwRkWrpve33GjyXbBLbEsiCNzygcMRbQ0EQl9tBgcK8VuFYhzaOz7BcA8KI6urf2ia8zQjWL0Hwca/47UsuyNBL7ba73+Zbo69tSdz4JGei1OGoLYSQ/BTi02MFLXcMe60oaiYrgk/4Sk3cV2HDSrmx2lymWQApuoxxGDRFB78tciqd1g/v7xXtEvmbI3pTGL8a0pfURQjgD6dJqDj7ItAZp1H8pvjfd+oeNAL33rUvwpsEj1vJxR4Y9aFsRhnF1fYNglAWt132059xFfHvZet2aTUolkmRJLk6K9Yh+7n7wY0NjN/GZGQMVlHQ4CPyJPY4dq+gtUZrxzjbnl4UcAXnakKDzsMqomK4v3EgFKUXUAXq+/hbQ0YzqPsLZ3NtaAMJpN5sP/+ui8201rsemDJq8CrL44smnxnCrLWNHyL3uDr4omObmg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(261021123027099003)(261022105027099003)(261022075727099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(261021121427099003)(5023799004)(261028144727099003)(56012099006)(261009223027099003)(261026140227099003)(261102123227099003)(18002099003)(6133799003)(10067099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e0dvPvnEjUH96g9V27beWFmy0cm1Ob5+dNWiJWYm37Hi7IBpDHYIEwks69kkYqvntV2IN3oqz2OdLTYEcSyxuff3dvChwpYWI80c4WXUq1l64mwIsO5Gqozq86+9o24yRL9TT1Qtcmy53+gC/z9buGuOBHCtzenu/GJxFBI2Nih4t6XISYia7GgQ+UByHE2o9OLk1UJyniCCr01njxN+4p435RhhkBWvR5x5E51fHz4Vh9iJA7ERJgIYMGUVkTGKHKOM/Gqk22u4jn7COzKmEz0nI9sgMMFewJWFfj2KZ5NdtbCMdaNa6gwpy2MoFEzW1NAZH1opji1nI/1ozbJtH/LtnnrhFxGmgZpvjxBzIiJfBxaxvI/vFxQkeERzzlSXIyRqGbX5q1rVj9iPDtVhSmZdIaWWSeUSJaWZTbju/jlmygoXJncf0sHgwCM9z2ln
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:10:02.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58c7e5a-d5fe-43ae-79c5-08df3bcc9817
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

Add a fwctl endpoint to nova-core for the GSP GMC API commands used to
manage vGPU types on a physical GPU.

The request path is:

  userspace
      |
      | FWCTL_RPC (FWCTL_RPC_CONFIGURATION)
      v
  nova-core command allowlist
      |
      | GMC command ID and payload
      v
  GSP command queue -> GSP-RM

Userspace supplies the native GMC command ID and command-specific
payload. nova-core constructs the transport headers and permits only the
seven vGPU management commands for adding, querying, assigning, and
deassigning vGPU types. All other commands and scopes are rejected.

The request starts with an eight-byte header containing command_id and
a zero reserved field, followed by the command-specific payload. The
response echoes this header and appends the firmware response payload.

This series is based on:

    [PATCH v4 00/32] Introduce NVIDIA vGPU manager [1]

A userspace implementation is available at:

  https://github.com/alokk-nvidia/vgpu-tools/tree/m1-nvkv/fwctl

Changes since the previous posting [2]:

  - Pass native GMC command IDs and payloads instead of translating a
    driver-specific command.
  - Keep the MCTP/NVDM transport framing inside nova-core.
  - Allowlist the seven vGPU management commands in configuration scope.
  - Borrow the GPU-owned command queue through lifetime-bound fwctl
    registration data instead of looking up PCI driver data in callbacks.
    No separate BAR0 reference is stored in the registration data.
  - Register fwctl after GPU and auxiliary-device initialization, and
    unregister it and drain callbacks before dropping GPU resources.

The complete integration tree, including the prerequisites and the
companion VFIO driver, is available at:

    https://github.com/alokk-nvidia/nova-core/tree/nova-vgpu-wip-20261105

[1] https://lore.kernel.org/nova-gpu/cover.1793906667.git.alkumar@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/20260305190936.398590-1-zhiw@nvidia.com/

Zhi Wang (1):
  gpu: nova-core: add fwctl driver for firmware control interface

 drivers/gpu/nova-core/Kconfig      |   2 +
 drivers/gpu/nova-core/driver.rs    |  27 +++++++
 drivers/gpu/nova-core/fwctl.rs     | 119 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |   2 +
 drivers/gpu/nova-core/vgpu.rs      |  10 +++
 drivers/gpu/nova-core/vgpu/fw.rs   |  18 ++++-
 include/uapi/fwctl/fwctl.h         |   1 +
 include/uapi/fwctl/nova-core.h     |  34 +++++++++
 rust/kernel/fwctl.rs               |   2 +
 rust/uapi/uapi_helper.h            |   2 +
 10 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/nova-core/fwctl.rs
 create mode 100644 include/uapi/fwctl/nova-core.h


base-commit: 132a3ca37584de0473193e8186c61e46ff8042d3
-- 
2.53.0

