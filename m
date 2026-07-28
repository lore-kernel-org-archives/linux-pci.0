Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D59233947;
	Tue, 28 Jul 2026 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230279; cv=fail; b=dYhB1Cl47Vt3GXoW+xVVYVgUAnqazjDo4QewUgp2vmNaDsZ3xbsbhZhoaNGA2p35hJ2I3MrzgTT5v+aNSshDoSbPzjKv67kW+PXvNL4UDZsAbuAYmxZ8BLNJHsn/OM/mzO11UKlbBwskkByF72OMo/cCiy1cEQrI2/YU+XpsJ1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230279; c=relaxed/simple;
	bh=WXYwx7TAW0D9KcAyqdwFlfteuAJ0Ezcqf1CpPY0Y+tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jyYbH83OyEjmzeRjnuvrlLDMITC1uF1fo5uOuHrqc4uv7l9hRaBY3wt/QSUrGZwhE4AdXaWRIi8j73oUPjlAphuaN7PQfRTkU/aNrD2yOTZaXNecG5NBImquBTDklRzM6md8krc2en4lGc0sKdI7mnwZw2ydDp6zCjiR9Rckxvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YG5+0Mqv; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YG5+0Mqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfpA7I2FANNiJdyq1YchV+1jlxKQpO5YPDKW413XyiQjajm4cjt+LEiOONSdiuqb09bNhTwy58eGCk+M5LiWzBsjI3lPk5nYeGreyqTGlj5+4MxBShn7eFeD/Cy4O/QDMWjNZfS9ccxUlKImkSzLI11IaaKydlNh8lh/zjDV9oV3Y7J4CeO0Zt3giPPPlswGv713U8r2WwN6CoS+wcRsqaHTRypl0tQ611Ep672XjmqGP5S0u7+O7S7YNcjU6mZ5kS+cqBNzplycU6rzKQ7tJoyvdzGGeTSLSVsv+e6f1L6UIzQQOuKpN4oX1pyFnrOnYo4dHfezOsdAg6UGrxHv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH4rJepcp3qMXhqdxfpkIJfKdz3cNLfkzg4EbWHdZA8=;
 b=rKPGVyrKo2WTt3jEe+gL2fKi3T2Sz0oNj/zppNxS8zWEG7sBWAd2aNcEr0xDeiFLyknySoOathPEUVDnGwyxmu8gDIUVZJkqcEBXQVGiD96UlUK+1ZnTtUy0jITthIBPzhopxcb85wnhSRsiNvF9a88H49RdmG/I2g/NoSlSM1/2KRypurPdlHo8oTLck4Ob68mMbJApVILEFvtSQGovqMmj1EUWgqy4XTUeeKHrJTxcR3jv51K38SUbuDpTpONloFwUsrqCdDR0maZURh1ZPLPSNazVD92YAvD3XvIkIPfW/2+rtalaQeAnRsMazyMouQ/C0Fpsda2Xb0rzdXcE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH4rJepcp3qMXhqdxfpkIJfKdz3cNLfkzg4EbWHdZA8=;
 b=YG5+0Mqv596vYaOpDgfKyPR1boC/nWnp+vx4CyjtNToxcXeRTG2gQj2mhU6oPNcz4j49wNrAbIJBT1zCpEcyVEigG7Ad23nMjqyS9A6upnHl72DD5lXViaqOVC0Xj3pgKjOGVfMrq3b1B+htp5obIAMFe2mEKEJOr8OJnYoBBns=
Received: from PH8P220CA0053.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::26)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 09:17:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::79) by PH8P220CA0053.outlook.office365.com
 (2603:10b6:510:2d9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 09:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 09:17:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:17:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:17:52 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 28 Jul 2026 04:17:50 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <den@valinux.co.jp>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 0/3] CPM6 Channel Separation Support
Date: Tue, 28 Jul 2026 14:47:41 +0530
Message-ID: <20260728091744.1086942-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 663bd452-b46a-4386-35cc-08deec891a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	OawYWdVlNy4ymzZRo/lCxo0pwV+Kaz8erHxECgH3qqmKvR6N004p7oXJwjIaW2Z2o8M/dcaRL1aolUHuMhR21jwJj6dv0XPCvegI8Ol0ba5Fbw3s4fSw3neE86VvUL9e+shG6A3BSosn+yOh967oYDvZ/tGmpRWZbmHI+d+TpkcS6vjw0VIbldKZ4XezlDOqkqZz0FYZmikeOyt7u8XKUsbaBFb+B41wpBZA6YtgMGYg8CcRmNp6hF53A7cR7F2L7yUSKW5d0JiLdJfQgXZMwmuyLn3fD2RqSL3ELobTGQUK2jVFAd4h/FrQmwCKG1QVlvX17FYPO1uonIps+5wk4mRDrdyQl4ygYC+L4l+NB/kdVeMYQcCi6K/ZiCVDYP09gFkWIGiHHQN3iZNYGc1BhFqp6Zrjg8N3ukLzU2Q9KB/+i1jJw1Iy8v9aQarIcD3bJ9ar7OXACA+YBHHcMtA9O/oVvZH0FX4aDw3K/0r20G+YRIDqajB4qEt+dhVLQGi96Sqq5hZfjgQx1LGwZIw5WvO0RMa5RFCYE2wM+DRiwt/a9s5ZB+t0AzwJcthSE+TNOzzwbm3wQUzYja94TtwZyXRRl7UvXBsmFsZuxdCxerg7L9ZWM05U7sBOQ0KTeHScY7rZ23Anl5FPs0Vt0Ln3vGzS5cE1JiaFXvzsk1q626WDMArC3QoawQ1ogf2BcqG0AhcBz+1rfKQzTGRvyghfXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZLJrfsE0vekdONGKe0vxiGmv+rLOw+8HQuq7/Nods5Y1zLuig4ZFENjSIoRDPNb21PSb2fEdUZNejefb2oFtnVCjZG2jW2ZqR2B3AF61CHfMpN9+WdE31jJkd15Sjj8Ve2psmpyOkEzvc6biZNAmiR/Rd6PmGT4N11sSzIqSaJNHAXRczyWmymfNoJF4A1aoEN81QaQSIPcUIYlgqyr5h4eKnym080O5KjKW2Ebj2JasBh+nET1tq8vB5df0GnJ7sZ1ncJxymtDjvxsTPg/5/NQYt2vxkQ66QmO0tEJlw2pLV+YLI0VSJKKNsLS9gDVS96zscuC+5fc8dC8W7YDYmiTCInRQJcdsvHcGkuGPOi5XrbElQWAIbkdtpOatO5AEE/j6FSMlr+GzwRulfwMOwdscX30JH+HKfqKuDwrti0BCMsXbjJly3RVlxFBxOk/P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:17:53.2775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663bd452-b46a-4386-35cc-08deec891a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.
In order to use the VSEC functionality following changes have
been made:

o For Xilinx IP alone, the macros declared are made device
  name agnostic to expand the usage of macros for similar
  functionality.
o Utilize the existing VSEC implementation to retrieve
  the channel separation and translate it to correct size.
o Modify the structs and functions to calculate correct
  DMA channel register base using the channel, direction
  and channel separation selected.

Devendra K Verma (3):
  dmaengine: dw-edma: Make Xilinx Macros Dev Name Agnostic
  dmaengine: dw-edma: Enable Chan Separation via VSEC
  dmaengine: dw-edma: Add changes to support Channel Separation

 drivers/dma/dw-edma/dw-edma-pcie.c           | 81 ++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 +++---
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 ++--
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 72 insertions(+), 61 deletions(-)

-- 
2.43.0

