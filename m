Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618127;
	b=Abf0uEfnlYbQJcokklE38VFGtX+I7jXQOsHxGA28DCq88tsK7l3BKFQHFHZQZF3aA1za
	 szVVpg4j1KLNQeH5yQjTA7oNEvnEwJOWoU8XxAqgx9j/6pxGKCzLkx81IcoDCXfRUhC1o
	 di+V+VIivtZzOcYR96kDp9h5kHBFl1BCGm0JovV0KV/lmZ332ORV17vsoFvefLMszU1Jz
	 L5FyjSa11b/Pro38QGplkfV1Lefcaotb0v50M5twp6yEyKZT3qGdsVtlAMKkoNtdt7q3x
	 51hyAavlLVydTaz2mywUMg/W4caxbE93ZpNagBMPnnFwgc8oYLKHgZn4nnI2Wl+49fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618127;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F7wKO/ra6CpzvAoT3lnf4hCZp0TV5QbDp/7Gz7nVQeM=;
	b=GUfdunVYyaL+vsYLX/gn9nhnbymkc1ToMFtzYUckiUrLW9cGq+kRobqMCLRPxwkdQFlo
	 H7rDqTVpeX7F6HZsH+MhEB+/nz+OjfgHhkbf5uvmSfmWJGUZdmxf4fcyH1YYW3LVA6EyW
	 3MGikbjFKngroo1XC2aJBu9Dd3Mqqux5R0GHMNEeLh5B5bunj5VijxmVw5uSS7HSkpUbu
	 PaPqpf6LE/9650isaScUD31rDjDQCMDh8DHs4tvSs8ow9AGt2T59pvrVEZbREQG5NI/Bh
	 nJgR9JXGYw6D0LWs2Hhfl6rO7tmjpSo3RF2iboLqQFtfC2azFVnQlCnOK5k5ToE/9cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ndkItt5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.45
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27D606A329;
	Mon,  2 Nov 2026 11:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F27D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ndkItt5y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6XjQT9StpKVFjpN5oqrMWuUbRYgi2DTGWQO7pHn0h0747GeQGVg+xmaII043wfg6GEYL/5gzdDQlv/QHzWmGMvweyO+8QIoxyWEyfTiwCjkdViuQCsLTybAZBGP6zu7lW3kvQ00FByF4coBmTEHawTOnA+4M+S29sdE0if7qHrbFEeP5x1vZhys0ruPl/Qx9HJ2fzXDYviKYokItBuzXAAZLCoMB8RtUaYxY6yVAACTSY936M6ja+YwFftIlns2RgrNMGk93CMK+yJsnfveUrZBce6/P7+TPRTdpr6YpG6khRpvzZSEzRV9jygiYNPsBZ+UU/PMV1rkLH4MkOsh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7wKO/ra6CpzvAoT3lnf4hCZp0TV5QbDp/7Gz7nVQeM=;
 b=P+VKf8H3y395AcKtvNm2rWjUuhSpeb4EiKurxoJ8orFv50O7rZJbjZb8+Ep4c95HfrbAe7LF3Nn32fDWayIjCxaecSLXiEQNa7QZu+nE4Govyk7WibGWSN4BfpL3fOFYWMokND9wPEsPjJpCFKL5k2DKOdoyIKE8yCCRARkzL6IQpQXOuctI3j62MVNbW59Z+ZOKpumAd4kkun/E6kbuNuvPy8zDKzMYBblfCuXEhUwvqGASpbbD8B9AFY5JbF0VdDqMrQsAKg2CH8DcDeaJFR4s1pcDU11ZPGUcvkkKr7D9AF+wEl1HmJ+5DPYT2NaOx5mP6GxPNglD2zDPdQtPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7wKO/ra6CpzvAoT3lnf4hCZp0TV5QbDp/7Gz7nVQeM=;
 b=ndkItt5yMf0oGBck7b/6PIZnJch2QNMKouABHmp42ryb2MLkqEhKJku1yaC2nzYM5SFpjt8zPGUcaEV+ugEHbhvXCUISeH248jdZHFNfIL8kGVdHaf/Hd9B/lEiI3CFnf6b6Z74NJXPhTuL1vEA+ZSD61lX1ZMZuvELlorr6U0tRZHQatFkWZ63ml+raWWyY4pIcCILTQE6h5Zxhy1QR/TpHXygB56sh9N3y2EPxA8rmtQTGTIvC8snbM5hMEcm5RQnfxPzWXnBdqyuASC2kbupWLfJajpl9VOE2AwQ1QrfFF+SDtctpDfCa6qizAq22VGI1y4fGEp4zXQLo+0sHWg==
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:15:22 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::9) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 2
 Nov 2026 11:15:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:15:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:15:07 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:15:03 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 0/4] PCI: dwc: Avoid full EP cleanup on PERST#
Date: Mon, 2 Nov 2026 16:44:46 +0530
Message-ID: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2029dfe8-2ef3-4c14-d99c-08df38d2965f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|5023799004|11063799006|10067099003|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	DyXt7qgH+fEXsnfE0lysCZIdOxsCldjj7dnAMMfEREMbqdNYkh3N5sxFbg6rVRB0PBkhp7gNAMsigFwnNt/GbtW+5pW1sdSdCvUuxSzHhpF0KtEL2jK7jGvifEQ+JcVdBsA2lpndp3kUCAVWqfu/z+f7RQ+4N2PVB07whSNvAHxSyDTmfC9G54zIIQeERrkJ103aABOCdc2rV16LDlgLoX8irU/i0sICnGJxaQJgpt/kMQmOi5315kXzg/wkPmaFO7GxaxK3AQHZ2+54Sh5YMAP/bJUxpEUDVKqiZ2pOgztfbQAgTLeZZj8sMGAkV7bZBr21xnk6WUsB0ncimwdJg0Lqip4UsFSnE/mVGGYc9Yom4csS5mJzaS8nuEIDgzT5SgK1u8e7zbmHhEr8PNN+eNUpwy03EXTVcBrP+ppivpdhWTAaRgYCUxcr18zjnO/T0GHo4VhrJZpD/0lQ9Nf2nJLFovwcIWNqHzN1TL0MQxfNhPPM5loiAuTeveAZt87d1ixPABCiV3V2YgcZw2kvZQomZrl+uFQ0RXQRgZCwH+JsnSj5J04/6nKboSQIp0WlEuY4HgFDCLIT5cWGHH2/x1lVsEKGMeA2bqkXsC/rBmCP6meJcmNCsK7F5hn0uAdn408jPi3GwdumQ72HhWpg4/IYG7LSv9hbYPouM2N2naShWXUDN9JZGrvjXhIWRdqYqPjp7qarsLHyeMc0h8zzYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(11063799006)(10067099003)(56012099006)(6133799003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	13KQNs9zqhQMre9sG6Ij8o3AsjbFtc2v0bF+4qCxbQMHNYDEk6KPaJbIKFp/2Oclv2ciCEKkUvCrNUg5ekWDJQb7+lq6qqTxIYzF/gN7mDPitdkx0PFET50C+w76q7KoCu/DCDpeoPI5b4kex1oUc1eYdTUMT3rfZVPOOcJ0tZOEZWZY8NT7BHamxW+3AuJ8tz5oMBqOB8VCS3sU4hgI1jGSZEbbVVqEJmbYlyApvIvpf6Pt8miJshkYMjlMDVM0LdL8GUGU8k56AogTmAQ2zfyr3qkf38yO86XFh0EqoEtddemqzC+ilrTSQleS7mpuUCpCkWkgf10JFJ/qsPGHvaghUwY5utoQtWgxeOCpJd08voXUKvdfVYUvZx0LE5IUZ2WLChJKVJsGix1WundYuzPA+GaoRXyuEGQNaUMDsLumlA6hS/cWqjEFSdki7UA0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:15:22.5394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2029dfe8-2ef3-4c14-d99c-08df38d2965f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

This series avoids repeating full DWC Endpoint software resource cleanup
and initialization on every PERST# cycle while still restoring reset-lost
hardware state on the following PERST# deassertion.

The current Tegra194/234 Endpoint flow runs the full DWC EP cleanup/init
sequence for each PERST# cycle. The allocation bitmaps, outbound-address
array and per-function descriptors already have allocation guards and can
be reused. Repeated full cleanup/init also removes and recreates debugfs
entries and unregisters and reprobes eDMA where present; eDMA detection
allocates managed linked-list memory retained until device detach.

Patch 1 folds initial setup and reset recovery into the existing
dw_pcie_ep_init_registers() API. It tracks successful resource setup and
uses a private helper to restore reset-lost registers on subsequent calls.
After hardware resets the iATU, cached outbound mapping state is reset so
stale bookkeeping does not hide available windows. This does not disable
or unmap live hardware windows.

Patch 2 removes the full DWC EP cleanup from Tegra PERST# deassertion,
allowing the existing initialization API to retain software resources and
restore registers. Patch 3 notifies EPFs of link down before powering off
the controller on PERST# assertion, allowing their callbacks to quiesce
work. It calls pci_epc_linkdown() directly to avoid the DWC linkdown
helper's DBI register reinitialization after REFCLK may have disappeared.
EPF callbacks can still access MMIO; the notification is not a guarantee
of register-free execution.

Patch 4 requires PCI_ENDPOINT for the Tegra194 PCIe driver because the
PERST# assertion handler now directly calls pci_epc_linkdown(), which has
no stub when endpoint support is disabled. This fixes the build failure
reported by the kernel test robot.

Hardware-dependent EPF deinitialization remains in the PERST# deassert
path where REFCLK is available and core reset has been deasserted.

This series is rebased onto the current PCI main-based patch stack,
after the DWC register-field cleanup and Tegra Endpoint/Root Port
corner-case fixes. The base commit is recorded below.

Changes in v3:
- Rebase onto the current PCI main-based patch stack.
- No code changes to patches 1-3 compared with v2.
- Add patch 4 to require PCI_ENDPOINT for the pci_epc_linkdown() call and
  fix the CONFIG_PCI_ENDPOINT=n build failure reported by the kernel test
  robot.

Changes in v2:
- Rename the outbound helper to dw_pcie_ep_reset_outbound_state() and
  clarify that it invalidates software state after hardware reset rather
  than disabling live iATU mappings.
- Fold init/reinit selection into dw_pcie_ep_init_registers(). Remove the
  separate init-or-reinit API and keep register restoration private.
- Document the reset and quiescence prerequisites and retain full
  initialization after dw_pcie_ep_cleanup() clears the resource-state flag.
- Clarify which resources are retained and avoid implying that the
  existing guarded allocations were repeated on every reset.
- Keep Tegra's existing initialization call; only remove per-reset cleanup.
- Narrow the linkdown notification's safety claim and remove unrelated
  pointer cleanup and teardown discussion from patch 3.
- Reword the resource-lifetime explanations in patches 1 and 2.

Validation reported with v2 (patches 1-3 are unchanged):
- ARM64 compilation of the DWC EP, host, core and Tegra objects passed.
- Per-patch checkpatch and whitespace checks passed.
- Verified Endpoint reset sequence multiple times.
- Verified ./pci_endpoint_test tests after Endpoint reset sequence.

v2: https://lore.kernel.org/linux-pci/20261021061903.1269605-1-mmaddireddy@nvidia.com/

v1: https://lore.kernel.org/linux-pci/20260923072554.1141864-1-mmaddireddy@nvidia.com/

Manikanta Maddireddy (4):
  PCI: dwc: Reuse Endpoint resources after fundamental reset
  PCI: tegra194: Avoid full Endpoint reinit on PERST#
  PCI: tegra194: Notify Endpoint functions on PERST# assert
  PCI: tegra194: Add PCI_ENDPOINT dependency

 drivers/pci/controller/dwc/Kconfig            |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   | 149 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
 4 files changed, 112 insertions(+), 43 deletions(-)


base-commit: 0012b353452613344db3292f17c69ea512344949
-- 
2.34.1

