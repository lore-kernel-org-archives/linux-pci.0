Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618622;
	b=Hyk0w8MWUlyyNXcwv81EKOXVUAlN62gV97P1lK0pumyTdu60LFQ9Z21CV/oNcuY/ZJsw
	 h4Zd31X0Nk8OIBN1GFLq43jzOee8iPrkuxTt0htC/ezigU+rJ8x434OMVMvnHRrlUGG3Y
	 zXs5ivnasOeicThQiy0LYPzaChH1aS9byvX5cfcYzHHPXZ4W8qRTYgAHhtzcZWgub9S/i
	 QaKFyBn662LTsPDXA6zj5O0DKDKH8OLG49QZmGogDqCjYUX7c4Gkaq7VPMu4CBQTuKOxq
	 F+D75d0PzVNWefL8o7v2rX4vW1iSceblXxArVKsethaj/vuPhnGS3YJUxQt27W347iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618622;
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
	bh=/vMTRln2w7FEAHW14RmfUtYoNsz/Mh2l2mR/iM2f1Ws=;
	b=i4Fca0ZpIBf7pUKmMSMvgEvYJMS/xAxAe5gowglzFa46dhnkEihYdgv/m/cjosNWAWJG
	 8z1BX0hrtZyvzYRyFz3KWrqsvuOZzV0z7E8YwXY/eOj3NvP9HePsmUcbIVqAawenbVxXB
	 XAzF2PsUEKOw4cAbxstdgNKcAlk6S8gxrTwWb5+OCNX9x7dyEViz1/rQpIp2X26YtbCQZ
	 VfsXytQeRdlkjy/pirODw3SoA8+6vMPde6uW/vQNuKvET7Asn6Hs3ue8xAFutHhkbCh+H
	 rWsVkhRqxOLVCXWjn8yGitZkIK4c273i6tqpXbijd4sMwquAntC/OIJNyprlN8RtIUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DNvH20y+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.10
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB160A3813;
	Mon,  2 Nov 2026 11:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48AB160A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DNvH20y+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDf5GhB1nwAYcndlp59sJGKuMe9ZiikEdoj8cnY4XZxkLbYX1FlSPq55H2EzMUaXmZ0JnI7QEARGDaQyUs6Pnc0iZ5G7hwSL1VF5k3y2/lxezgAA7Nx/MJ8+4tETSzZAe6CLZRnBCFy9hHEaauDEiEDqHckGUGPu4WHzzrF3UXeihLqfnmwU80NhgU2IT6b7ugZSI4L+vbKj2soCIlF99+F35JIgylFZJ/YIJfNLRK+uK14M65shwKUUbXVozYUvUDPuYxKzkFIaMvWyTQNZ4FDXqpSX4WTfJ08zr5c/605fBZ7tgcHqRMecyuq92CSRjufL7tfRx8D7ncFFhMfYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vMTRln2w7FEAHW14RmfUtYoNsz/Mh2l2mR/iM2f1Ws=;
 b=B4PY2BF2uwGoz/tY4hhEXRWxDutVuwFCKK5AoEUAC7xQ0VDuyKIE4cHbDrCOfJD8Syuw6a5Bo+j8mOCon1d8W5AfpEEyK9J/1nwyeaGKbmQmcdiir6na8bI91ysZ2wckYZ+agDlZQkrInuUrCUvByb1zR4zxBNeZhul5s7yXQkeP/I8c04P0rpom3DjWXG/XcV9i1/vbjuANZ0QPhIVAzARUJk5NU7+EGN9AgDj+yDzeqrlLS9oFkFrUHdNbnUtvTwAhWYIyII+pTBY0+AfVZw6gA4Q2sxlT+JIgrwjE+iywTvuLn0nxcQrH60YeksGD1IBU5rkPMmBvhG8bIGmq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vMTRln2w7FEAHW14RmfUtYoNsz/Mh2l2mR/iM2f1Ws=;
 b=DNvH20y+/GQOsU3gqZ61jGvJ/qt8xLUpvpJb+xDUJ7kozKuvChuAaGXdq87dkqls9Cs7bEhBUEz+qHXLww40Qf3Ofdvlrc8h8feWhQAFetLpyyKiLcdslZwRn0kzAym8HJ/p+7GJGihWNJDyu7qJTMjoHb9VV/i70Fld3lavKzIodbxIBAxJi66EMRHppu1Xpc/qK6y+hcG65G1MM9BQ2YBYSExB3cZR5hh2atn5mh7qGHTdmrEHOsJ8r+y8B3o4s6y+PMszwJf7f9ar0c0mCos4S+jB8vWTS+ShJwnVUU+CGJgMMc/8idt4z1wvWw+JGEt9sZj5xlxkb8A9nCFmdg==
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Mon, 2 Nov 2026
 11:23:38 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::91) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 2
 Nov 2026 11:23:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:23:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:23:22 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:23:18 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>
CC: <kishon@kernel.org>, <Frank.Li@kernel.org>, <bhelgaas@google.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <thierry.reding@kernel.org>,
	<jonathanh@nvidia.com>, <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 0/2] PCI: endpoint: Skip upper halves of 64-bit BARs during search
Date: Mon, 2 Nov 2026 16:53:04 +0530
Message-ID: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fce38e3-9c6a-4fa8-c817-08df38d3bda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|261028144727099003|261022105027099003|261009223027099003|56012099006|11063799006|261026140227099003|261022075727099003|261021123027099003|10067099003|261021121427099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	CRdBsHT/vLjKXiQKLPFGiiVGcDq8cn6jPG9wBnZDw/8DtU8R+M/7gZOxXwcxS/OJiNWJpwCigaWTX4KhGven6zCqJov/B8aJF3ucVFqQoewYZg5LWFM45GoVALdsMDUfNnT9ulRiQ6E7ujROHJkkzatOobDsysc1byvRqSHokIr5UViHcpeT6Y2WxqRPnGWqDzGhdG5kbS0uOhMFzlaoWd959qoq5P61dsW6lKpq+9RaDXvAxxWkWuXdKleVJFetLZmeCE3IwcUZdGGro4yYhcmtl1YvVjWM03+kKPoqvZdRdSHDBpX06im5scGXAODdUm5jk+jnmfQBBpjLzoxYh6HevCiNXyWI+zIpoXKKdWg8PTciFKWeZ2mmdtDUcXCBqKg+0WSJRrOLa0fH37GPwmPBa4l0p1Q0SA/ejSuBoJ3nnBrWxOyn/8soqHTgEdOsij7Hd2gOYAA/jbmRXx5bNOLQUEi4CSjL4rJU5BNHlhaGJpLZbYxmP0BZqDc+VKqIOlvzKm9nuwuks+CLg2DUvnUUG+/pbIkXYx5HFe5Lje6BluiUbckn3xQtKUrtcKVmYwaKWeVyMojrfZ64JuKXpvC/pH1//bwRQ1ghcHC1PiVLvUED8hcJmuTAT4yUbANd/yvHhccFMY7M3U2TYhEFtDONafiLYDA3ru8R6c4nMJJPcmHqSQAciOSaVDOc/P/sTWWH2W+qbB5IauAKGmO5MQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(261028144727099003)(261022105027099003)(261009223027099003)(56012099006)(11063799006)(261026140227099003)(261022075727099003)(261021123027099003)(10067099003)(261021121427099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7N6EiwYvTEj2zSdqFFrFMYpUHdEINbHD4C418o4nJRl/xW3WWPOSOeTDEgj4FX7A7oc+PRP5V5jKKIrXZpFV2WwMZvMWiI/CceFIhniACD9HICCt4VkbVL29CiLqwIyL+8INUQ8mdDiIt8S20LbP3z4vC1MnadEDtBpnwVpMIH7tI3XbG/o2aDbRUIwE10SGCPxlrD40X3wwLIdOEovM1uXuCEXqh5ifCo5k9cAglLFvP9C2g9MTfAD9TdZYlz8arfwchNdGTOTwqcJ1Y78cUEOzSlaSU5eDxoUcQHmaDJVjiQDQt7GLq4I2Eh24+eq5RVIu6GCC/cJxYpgOJ5jxh4g11G5I8Yy8rhLnWw7KbkPGolqezhcNAPiCKdYjuAIXLp2LLibr3WkeBjzI64eHsuMlA2fkei1o5DMf3JbMStV8U6gETmE7I1z3nTgZLdnZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:23:37.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce38e3-9c6a-4fa8-c817-08df38d3bda0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929

pci_epc_get_next_free_bar() can return the upper half of a reserved or
disabled 64-bit BAR when the search passes that BAR. On Tegra, this can
cause the EPF test driver to attempt to program BAR3 and BAR5 even though
they are the upper halves of reserved BAR2 and BAR4.

Patch 1 checks the preceding descriptor for every candidate so that upper
halves are skipped throughout the search. Patch 2 clarifies that only_64bit
also describes the hardware width of a BAR_RESERVED and that the following
BAR register cannot be used independently. The existing wording for BAR
configuration by EPF drivers is retained.

Changes in v2:
- Rebase onto the current PCI main-based patch stack.
- Add a Fixes tag referencing 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit
  on BAR_RESERVED") to patch 1. The code change is unchanged from v1.
- Add patch 2 to clarify only_64bit for BAR_RESERVED, following Niklas
  Cassel's review.
- Add a cover letter now that the series contains two patches.

v1: https://lore.kernel.org/linux-pci/20261021080644.1346549-1-mmaddireddy@nvidia.com/

Manikanta Maddireddy (2):
  PCI: endpoint: Skip upper halves of 64-bit BARs during search
  PCI: endpoint: Clarify only_64bit for reserved BARs

 drivers/pci/endpoint/pci-epc-core.c | 8 ++++----
 include/linux/pci-epc.h             | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)


base-commit: e04b12478ada488e59c54bf17dee4e0f5843e131
-- 
2.34.1

