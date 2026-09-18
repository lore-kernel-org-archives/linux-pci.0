Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581623AFAFF;
	Fri, 18 Sep 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743424; cv=fail; b=C40ANnWDAV2M5D4YxdJL0DraSY2bM8UJt4ZscNPVmp45OHZSOlB1VjghkSMFt77nwqcU+/0PAYSkO3Gw/+YFNapZpyy30fCX1tzZWLQr58ev0R+n5x0hu3LF7W8lCDF0HKRiIZrOjMU1xnEhYogKDcyNCM/6o40nN7LuxkucMZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743424; c=relaxed/simple;
	bh=Ie3eY+42VSjH2+45Suw3HMR97jC9ceu+EhsVlTM8uWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T0fCJ70OosgqyAOcTftz5EP/w5cAaXDTEK6xGzKukt/n/F/1D1FNaprq+CemdgnFnp6AqmfZU2nqDTIsucN++jBJz5CV8MR8Jnpfwja701eeVgE1pLH1IDJCPP7XaC09uDL8Cl8kugeilMWUF4aFxx3pGkAu+XiQbKkPaacevQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3fyvENMS; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3fyvENMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZizNU1iseXxSdsHbu9M/CzHbtAVdMylwfgfKQiNCaWdMaFTtU/zpV9M6FiEB+tqsE2MXZepzOKk3Fye6ZS+3r3MWls/osSqK8J4+fz9gz++csph63FEscY/ImczyocdgEa1OiJd00Bg9NCmFH3jUQ91hQHfIqE0NHEP1PF6PQRrK/7g+m89wai8vg9F4dZPpkzdWOJQ89ZgoYq6WJG9sq4XBsmW/HVv2NUFYO8V8hFUZZtjKeVMqYvtV7OBCy3uskN0LcMn9N6yofJIIRTOxdxmecLaVpXwDqcOpB52EkoJdgQTVlAchvIg2s17ibP81R8eBQkHWlOdjziPlnuenvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkZuIixq9fW4tjsfJ8nExJMLnc9X7D8jsNk9lIHQWYw=;
 b=h56aW/WUYdgMecYYhooZVBMp7Yu1EbHziUvz5AbkXZLQzfllqhtcyIyUl7nr7eGATrkMUpm36MFwW2gt4xMp5juevEvKYajLXWYYokt0tvZxCojBR7EocIGygSIyuMucj7y+ZbIX66P+WZf/fgmbTx6WL4y3312JJWeJT6x0Y0gjXAlDpOxNPUXyuHgFgl0m1OM9za4ZNVn4yZhv+ZsBvFKgsRgepnVLi50vROho9cuJtRauPjuMyrdsHt6bQtAtanSn7t0opWD5B69UIWs+BIxMRjYlYZhxXB6DfzLn7e6DRI+5gPb1DIecSYXUR26aJmyCknEvqe1sBxosanLKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkZuIixq9fW4tjsfJ8nExJMLnc9X7D8jsNk9lIHQWYw=;
 b=3fyvENMSdHDMCxuwmJJdkBVh8w2+XTSaAIQRcGZY5tyqQoa4fkH0IDcJcVlmmMF9gS+k8axCk9lPc2VvTDkOK0L8ue/EcIQ7i4ZQLml/WDH7lShrgMnVmmfJVP9YnT5ff43vfkPaP+ZH9zAi6UKAWlpdxAUhZSlocZnl1wvl0e4=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:48 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::50) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 14:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:48 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 00/10] PCIe Flit Logging Ext Capability Support
Date: Fri, 18 Sep 2026 09:56:08 -0500
Message-ID: <20260918145619.3016889-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6932ad-e798-49f2-c4ab-08df159510f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	jfNDbjNVYiv8U3xvFe9C4M6MqoYYL4MbJMJ1ANQtmzaxu9XKnwRI/srx1zLeA+7MsTm8LFW47JhCp0jVAMoemtbVuds3cA+do0cStceeALkdZjL4P2yuQLKljBOLOnTSZM0+oY21TLv8WAhiq1goo1rmzpDl1W03oiSievlSByJs77UpQ52Hv/TVdg/nTQ4QDKl6iguXeCkj1CB+07p2onExrgAn2Vwn87qVI3ILYql+tMWQosxjDyA84Ljj5ALVBnELIqvl+k9M8xn2YzYrCp+o8xTDzb6cdmv0D8xEbetc94QXSeyi4tCOUytEXQcLIhINaww2sccgUZ+r45h2vxIcIYtwmZocQJF+R5hjY+9mfmay1lFo62U2a05MR6pDObZZR82/COE6U7MEOpPdDDgkuSRjD8yYLp2c8f2Aajgl/Ufcncygl7ap+LtcBEFTOA54kYrVZuFtQ+dkEeLXEYr5XR266sJFqdBSCPpxr64DwsjOLTprdTm779ftvFsaVJtlBRJaqbYjIhUxdsET20vzqJdvtgnm+VGxj+4aoc/waIrVeer4S5OCb/i9NQJyJ14d0QqOoMgdJFEkSvP4ORDn6Cujvh5yDEHYIojRz96P93tJ2dKS5vp0pyoqXPnCWbYwUFN1WN9x5y+kelQ6JoWh7c5npRnApvjVbO1L5HELngNZNWToFRz+JKJUaz/zr3AnOrQATng5j7qL14XAuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v6lFLYy9zWElarPDM1UFO1nQ4d5Cv7eAnAeksE3LhhBO2hYK9/N4wnrXWNbzwE9tl5cPcK0YSRHy/5kEIhiQte0NRaDrJXtr4eH0vado5ngEfg6gEN140wFSdPl9jvBfYHxtNS8rqPxz1SeMamn6VPWFYHEmavjCkPXFLSrB/u0M6jDXFnnPP3sa1zGDznieibwiJ5UxXw85Ba5pzRrZLzVlmaao/5qhZJpEMdsGmJn9yFmFMO5RNJA0CWWYmz5+VGQklic/6kb2HQ0tbbL/1jA/WAmD2SFYxEsw8mGVnIMFJNAwrNqXHgfHu5hlYMNTqap4ftIAQM4cQTdQfmHKlUDoPwZ3MURvlR8QLLrpNRQc2N3m8jSt7JbfsK6dbKMOuqdH/P/hMlR7Y/hw7QiYAnYU3oWoMFXgzeWmsTgHdsxFly4Lv+xq4JrPja82si2v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:48.8609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6932ad-e798-49f2-c4ab-08df159510f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

Hi all,

This set adds basic support for using the Flit Logging capability
introduced in PCIe v6.0.

Patches 1-4 are fixes for AER sysfs issues.

Patches 5-6 are refactor prep.

Patches 7-10 are the Flit Logging support.

I tried to reduce the verbosity in code comments and commit messages.
But I found that review bots would either get confused or pose redundant
questions if comments, etc. were too terse. In any case, please let me
know if more can be trimmed.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20260714183950.1620016-1-yazen.ghannam@amd.com

v1->v2:
* Address Sashiko bot feedback.
* Fix sysfs issues found during development.
* Add sysfs controls for Flit logging parameters.

Yazen Ghannam (10):
  MAINTAINERS: Add the AER sysfs ABI file to PCI SUBSYSTEM
  PCI/AER: Clamp negative ratelimit burst to zero
  PCI/AER: Report the ratelimit interval in milliseconds
  PCI/AER: Hide the "aer" sysfs directory when AER is unavailable
  PCI: Share the AER ratelimit sysfs accessors
  PCI/portdrv: Group PCI Exp Cap services into a single mask
  PCI/FLIT: Add support for Flit Logging Extended Capability
  PCI/FLIT: Add trace event for flit errors
  PCI/FLIT: Ratelimit flit error logging
  PCI/FLIT: Expose the error counter controls through sysfs

 .../ABI/testing/sysfs-bus-pci-devices-aer     |  27 +-
 .../ABI/testing/sysfs-bus-pci-devices-flit    |  70 +++
 MAINTAINERS                                   |   2 +
 drivers/acpi/pci_root.c                       |  11 +
 drivers/pci/pci-sysfs.c                       |  71 +++
 drivers/pci/pci.c                             |   2 +
 drivers/pci/pci.h                             |  62 +++
 drivers/pci/pcie/Kconfig                      |   9 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/aer.c                        | 105 +---
 drivers/pci/pcie/flit.c                       | 511 ++++++++++++++++++
 drivers/pci/pcie/portdrv.c                    |  23 +-
 drivers/pci/pcie/portdrv.h                    |  16 +-
 drivers/pci/probe.c                           |   3 +
 include/linux/acpi.h                          |   1 +
 include/linux/pci.h                           |   6 +
 include/ras/ras_event.h                       |  38 ++
 include/uapi/linux/pci_regs.h                 |  20 +-
 18 files changed, 876 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-flit
 create mode 100644 drivers/pci/pcie/flit.c


base-commit: c6d17c3a542095046bd3ae187e82fc5aeaa6e0fc
-- 
2.43.0

