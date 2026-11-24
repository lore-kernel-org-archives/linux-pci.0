Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795531409;
	b=buNDhjmQ9JdTCKt5fPT6GeTE/L8gA6T1kygFYWhLh5jvc6G9JrGn+E7mdpJ8ULdeoSeX
	 BWffi32G7Mhifoz10z9UAq5ZM4zBgIJrkjDEjQ2obkBKnRFHXHzdbS4Y5zbkQ015rW4XU
	 rekjugSbeDun4SjLAZd2LD7J0gDQ2xIuFk3ZYoBGtESXqwTOvXcfSd8ab/aNRNQy/S2rt
	 P4horP8nH9AqfsRaGpQI8VFT+C+bz9/rF7S5smR/lGhnOhs3nPBT9wZx4PMLrqHNOU3co
	 fzfLTrrkIpxcPzY0bHUu9EJHaMakBq3NagZpx6Pfy9r0yqESCC0QuC40tYrY7mHRyQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531409;
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
	bh=37iWtkEYVxT5Rj/Agt+5ARtq0Av7RcT23h7tCkGqGa0=;
	b=LyhDY1F4sbIy5cKPkc/RZ5RoCMeMwx21iUQsfbesa15OXX0CSXisXHCf5makEsVY8FKE
	 Gtw5PTaDIpX/14/tCjg9PJssP7L4D84g+bAbMdzpKHDgDdZKvWMxy+bg9RGcVFeeR69/c
	 reEaL6KEg/+cNgNHXoh3IZU/dXEWVEJHCsiOs2J+l/8pB3zs+CCkX+SO8qyyCeAB22sQL
	 NOSCsIQ4G9hJQC1O7YPbCw14c9o+8+SdPK5hsokcciEb4uwqukoGA1ItPDNlcWQZ45r2S
	 1L5Eb/f20KFrL4xCFD8OAPOd9CXn+ALDmWdeTq4Hp4OLqcceuTcH5euxroMIw/r7OOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pRbwv126;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.44
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF5606A330;
	Tue, 24 Nov 2026 14:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EEF5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pRbwv126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf8G/kdg5/pvzDAXSW79j4cufKaFlaybRkai+BqWjDHvGQ3vFw0YyasNhUbVr16sn2PKyoSlEgJJVGycYeuh5yjfFq8Tv08XdHAL545naSORhbLWChhAWfXcH1Ku439PoElK2FHFIMPqoTyJ5JJXQ664QKuXg7Nl39ahp7j2j3OEpMWzsV+8Jopc31UjdkueSI6nadTRZ3pBRTqNe00CCZMr5mtLfc3QibH4KkqYmSln3Cf0HV5DhMSCQsL2IsOt0RPCesbmKQCneeI3mZbhQaVJAOa5azfpZ4CgmEfAJtZbqH1YQOUlJVff59+U5YgFaYbyLXXVVZ1Q0yyVNJ+gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37iWtkEYVxT5Rj/Agt+5ARtq0Av7RcT23h7tCkGqGa0=;
 b=lxJ/qwtnuHCEtXfza2zLdMfgbl3cFQyUWE8A0wNQCiX+IvJA3uRPys0KuYEjEQ97hc9WBUqYUkz82dnR37xomGFod5AP96cnp27R1tBboTtJVmT7eDhQ3bG3SvWDjQVqa7uynUt1qZZV4p3XuylsO2mfzIVah9YdBb8GXveCPQX6PiA3s1L+NL/dJIneyxc/+tLOpfMBpqiDmZl6YdGM1z1Bcryy2Nn4973zoQtoOno4bnG03at5P2e5dRLWIVVcKemON8YNNdujzT4ZbsJnEq0h34jcl9USLYPcIC2iQvM91yfKHhO3EPV2PfhPXEMGWD5DuLz4HXzhtVlo70uf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37iWtkEYVxT5Rj/Agt+5ARtq0Av7RcT23h7tCkGqGa0=;
 b=pRbwv126wsxNdEM5TgoptweMdLHb+7oxiQWuuM8xSyylQXQt6eM7umuxoIGeXC87eycv7YOYe7NYCP2kVgnUnnxx7oJA4Q/BUghAv2axiVbZyWLKrq5WDcpS94SIMOMSAHOlBEnKD3qBJtF9p9xlYZ/5HUvrLeCJw+nA1HEySrPLVNmA8qjNUrlcICoAR1Jl3snEFXOBr+Rso7QIgTBqxb11VaLNjT6/oUQJbKtWmOU4pjMxq0CaclVcsdOAMOPO/5qiYxw36sphfNEctTvuM8gXF3xyaqK/v8f31fqQt8eru4pA2MdCPS8Xxtmqvav9wWgr5icnBJMj1SeHvzZlew==
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:43:14 +0000
Received: from CH1PEPF0005BD62.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::2e) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:43:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0005BD62.mail.protection.outlook.com (10.167.244.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:43:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:42:53 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:42:40 -0800
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
Subject: [PATCH v3 0/1] gpu: nova-core: add fwctl driver for firmware control interface
Date: Tue, 24 Nov 2026 20:12:03 +0530
Message-ID: <20261124144204.19072-1-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD62:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: e95cba3c-2b14-4ce0-9f96-08df4a3944cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|10067099003|260925021911599003|11063799006|5023799004|56012099006|260925021311599003|260925022911599003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003|261022075727099003|261102130727099003|261102123227099003|261026140227099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lR09xPnGJNwdiimhVW7gu46I+rLiXSXY3JerkKDvaCmQInXJWJPg6OLOMjAfiaCTnXLDHWWMUAqQOJ7w5yw4s+01H1fHF+9kjYYDqxuSTM2d8Ekzw/A7hgn1CdyGrl7no21saT8nK+j+g0N19GnNy+CMge6UZHoVxXeQo4hZTLrerSiVr6+kNvaFkA2/V8BGqCPr4RcH4cp81QstjSKpn1ZnKktUneNn4E6Fyipz+/PCe3LIUSrFY9bbpTEGNdTFALqYRcwzaB70BGfnkeO6t1KF7dWyfdnapvl19XOr9WDiHQ4HKYDEPtIChdapxqV9tkI/zBP1/kwxvis4kYduKl3yE41s94WcW2eBjmtTlZDTYKzgQzyVaPL81V5k88YWEZIH7KKVanM/IWe4sX1h66cX/UBxnzaw45S1/cZx/wBerGlrQcuHyCQHs1vX5gnuWl6HNjRCrowrh7LCYD/fiY2PfZQ+4Lg3R2ivszQMvtgod30ogHazBit7l9ufiw4fSKg5tfv3fnN9RXnJPkE8gxIolZa1658kCA2QAzQXnIjTnQMyabilR5yjKxSd9dihKRE9WyEecrAH74p6MHUsH+TyLY9gTe+FREA+CLGhLKretlqJskxuvhm74n1ZrQtfofx4hAa3AEHnfRZc1WJCyC8cu/p9zv6hSCIlrKCRdYs6xz99o6vs1UUyWtp9Ley+6TmapBOkXt18kIoT32nRMA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(10067099003)(260925021911599003)(11063799006)(5023799004)(56012099006)(260925021311599003)(260925022911599003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003)(261022075727099003)(261102130727099003)(261102123227099003)(261026140227099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EF+MffGJWnt0zX1FBAC7dzu/akKDBD3TPKja105Qk/H4HY6rPcdhrB0am7kaM1kTgweu747MT+GzXOooB7Ns2piyA1NTGP0QtdbsfoqUmDulPpCXlPxS3WKoFo3CHOTu8/TVt/LTMlE4VTXR2PNOjVRdA8pAcXhvs/oACJtQwc8M6tyC8JCVrHwHq6fSE+bLxBGL0XIhPjtYMg+744vC0jkwEDOhPmc13zCv4iIqmQ49uy0H0o/w7QpnS6oOWbcOomUKNjvJ8OVZewjbiTQKZlOxs4yI4u34LzApkfz/QDapxLqJrX8NBDfQiy3Gu0PgMFgW3MvAK1Ixsp2B3sBmLyhxEn0XzcrrIN5/bne+15XtrWiWSgdrIFyMN7t1ql+mEeOpCX6YRGEBehkbxN7IdBiY0A8Q3lnkCMIflnBXbLs4GvDBoKQ0UQWCDtwMT1sY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:43:13.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95cba3c-2b14-4ce0-9f96-08df4a3944cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD62.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Add a fwctl endpoint to nova-core for the GSP GMC API commands used to
manage vGPU types on a physical GPU.

The request path is:

  userspace
      |
      | FWCTL_RPC (FWCTL_RPC_CONFIGURATION)
      v
  nova-core command allowlist
      |
      | typed GMC request
      v
  GSP command queue -> GSP-RM

Userspace supplies the native GMC command ID and command-specific
payload. nova-core constructs the transport headers and permits only the
seven vGPU management commands for adding, querying, assigning and
deassigning vGPU types. Other commands and scopes are rejected.

The request starts with an eight-byte header containing command_id and
a zero reserved field, followed by the command-specific payload. The
response echoes this header and appends the firmware response payload.

This series is based on:

  [PATCH v5 00/35] Introduce NVIDIA vGPU manager [1]

Userspace tools:

https://github.com/alokk-nvidia/vgpu-tools/tree/m1-nvkv/fwctl

Changes since v2 [2]:

    - Define CommandToGsp request types for the seven permitted commands
      and submit them through send_gmc_command().
    - Add the missing management command variants to GmcCommandId instead
      of exporting numeric constants through the vGPU firmware module.
    - Read successful response payloads through MessageFromGsp into an
      owned buffer before the receive-queue slot is consumed.
    - Preserve firmware-error handling: return EIO when GSP rejects a
      command, while propagating transport errors.
    - Use pin-init self-reference support to borrow the GPU-owned command
      queue. Unregister fwctl and drain callbacks before dropping GPU
      resources.
    - Add the new userspace header to Nova's MAINTAINERS entry.

The userspace request/response format, seven-command allowlist,
configuration scope restriction and response-capacity limit are
unchanged. GMC, MCTP and NVDM transport headers remain inside nova-core.

The complete integration tree, including the prerequisites and the
companion VFIO series, is available at:

https://github.com/alokk-nvidia/nova-core/tree/nova-vgpu-wip-20261124

Previous postings:

v2 posting: [2]
v1 posting: [3]

[1]
https://lore.kernel.org/nova-gpu/20261124135937.18583-1-alkumar@nvidia.com/
[2]
https://lore.kernel.org/nova-gpu/cover.1793906674.git.alkumar@nvidia.com/
[3]
https://lore.kernel.org/rust-for-linux/20260305190936.398590-1-zhiw@nvidia.com/


Zhi Wang (1):
  gpu: nova-core: add fwctl driver for firmware control interface

 MAINTAINERS                        |   1 +
 drivers/gpu/nova-core/Kconfig      |   2 +
 drivers/gpu/nova-core/driver.rs    |  23 +++++
 drivers/gpu/nova-core/fwctl.rs     | 160 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs    |   5 +
 drivers/gpu/nova-core/nova_core.rs |   2 +
 include/uapi/fwctl/fwctl.h         |   1 +
 include/uapi/fwctl/nova-core.h     |  34 ++++++
 rust/kernel/fwctl.rs               |   2 +
 rust/uapi/uapi_helper.h            |   2 +
 10 files changed, 232 insertions(+)
 create mode 100644 drivers/gpu/nova-core/fwctl.rs
 create mode 100644 include/uapi/fwctl/nova-core.h


base-commit: 7c4cb57138562f96b53683e29c8fddef73d57294
-- 
2.53.0

