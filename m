Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3033939C9;
	Mon, 31 Aug 2026 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209761; cv=fail; b=UKbJzFCbLohY6SH6cqtNDSagzBHQ4CsbJHGt6Zt77A7t22nsK7FBw/w+G8WZOw9pxDBRT3dCysdJ/YTJH+FoCiY2/dsanroo8+bhlm7IzdGMVCSvRi9U0NriLRUBvClzLCl24VQDxt0oVK/GozQGXx7kC2fP5HEoRABYv/ker84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209761; c=relaxed/simple;
	bh=+xjK/ej+4A1IB8TcNp5fUG+XCWJMQVY0l5Yod4QKryE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuNLzW9MmumirCdKFFpd1AmhjFtTfgwiSnzkKuiiKV/GV6Nztq6fYJlxh2wzewFgPMr7sy9EUcbB36sy7RLoDBLgt4/5uB/Dw9sOeoEtUSeD++gPK6lkr0A9HY5LHlLJshHWbTNtsuUSP1lhz/76h1iJlB47jzQUSYaYqT7F2WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RKd/Sk+a; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RKd/Sk+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJaZxY9uPRb5acOZQcMBflkIJj37xpjGAdQhwedReVDI5moQVh6bqQOp5SxLzgMnhr3kzJFO8OhwXz4k2rpV5KWhDzsKjHviBIeUiD2fyQDNHsAIC5N6CqnQEpyaC8+yqRlj+Zbh/vxKpMzqJlMibPkmv/OA/m/4d/nARMCSrQRRzoX71rneLYrvhUvCFNlulJVNHMScpZLUuOejGjDRiHTQC27CA1Ofa2vaMTsL/wKeCCIlgG/8QuLfBcLV45hVx/exgxy459t+zqtKFtBzEKn+217q9gVUef86dZOSl8wUZU2F7J20Fmqf4iT+kxu/WxQ8S4K/lQeBOoNQMgSctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg7LVVFXV0HJrwP07G1iDbRYc8Py2uP0c1OqhhnjhH0=;
 b=kk+Jryt+9N20uogLhBi0qLVvyOVWZHBT/xJqM8xgJYhFRysp0hNPfqgwBhpkRbBiV9IqpqkXUoU67Zv5bdLntt1cFoDPQ/vIWhQo7Ng2gBc/O6yFF7bme4uDYDFBDaCaMykjkPVmk4ndy1sa9vvTafM79AF0N67X1qV1OtkUIGGWGWcDO5mvxRT+NlveLk7FF6aYft2sE5iO9bdT/IwwFXq58/4N14uzggmpyuUGitdLzo+tKpVDxM8lz12NF23afDh7bO3p7bsm5+rhpTuzLXLVPtGhFV7ZaJroKAU3fJYN8muV1PP/0KGuec7S3yS/93VsPsMcdYZxIm3O/YPWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg7LVVFXV0HJrwP07G1iDbRYc8Py2uP0c1OqhhnjhH0=;
 b=RKd/Sk+aeuOOqJS2PJli7fb+po0xy5z3dr5dFBnVxFiSrvDBDJcvTwT/uX7GIAXEzZbw07+AQoXyTJToyTr//2xkLQ5yFbMFlcZTqdVdsClgfFWCiM6VBA+2c8Bqo7TqpGb7HK1g/Et3ZgNmHEtrG6HZToBJPcRuH1bUQnCHx2M=
Received: from MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::24)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:55:53 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::70) by MN0P221CA0024.outlook.office365.com
 (2603:10b6:208:52a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 20:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 20:55:53 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 15:55:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Unfiy PCI suspend and hibernate paths
Date: Mon, 31 Aug 2026 15:55:30 -0500
Message-ID: <20260831205533.2325747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c444abc-94e9-4ec0-460e-08df07a23f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	hajdxzSBEvse/lzt8quG+PxOlkgueEeoz0EkoKDnWFa0gTX5vURgfnMlJsZhgG7idouaCS/dcUesC3lWV0BILID/FCa6DEMjLh4LA2IOk1tTRkPb0/0sda2jlHMkCbFkNDChxEaKk+lvDE3Nx7FY4Yq79FhTHDqLE2D5Lx7NbkwVVigdgfzCOO07AnWEVyokYO73aY7S92KX3hsY3o6v9Cd3J36VV/AtiDUc2iE5pzoY4Q1smb2hTg30g/kXlbi/jxbpdD/bZRXrOA6EaTVNv6Z+t0XM4BF5YzZ9Nx6otoUwqYIHByAl9VMENgvih0LAOQIVrLN15B+SwUtNfPAzGy8r1Z2CYMaOVPd73ZURV6GMzqlXa0X1yFhaQqfsE9rjcqzQwVNewJBvXRYl4HIRq8tKLEjd3N3Vv8tP/TPuNe1XYV99G7tFj5lU4UBXb3O6lp/htWFhMSu1dvNCvYDOnQASDut31EWuPdyZm8NxbGHZ0Q/Te0DkS3rttpwjWnV4YgZrOrqloINB4vqRfGPtk8EK8oTHRqBN+h7NJOaMF61l8Si2qm93mAQo7j34dLj+/g06rHD3csIfOqvivDRJ9iSq7saXlNsfwGOibex8Ax92ax3aw7pY4eAq1M/6Uv8MorU9pfRjPim51JAn1W8XI9OapKu6OR8Au4AxQ4vvxG+1CuB4lxCPwbZeEQ77yXlsAvH5d5T99dwwnSkf8ecX0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ass3YEDsAEitr0rRzIlU4m9g7LIfAV1n0LhAs88AatxI//Ch6vYxHhBgVgO1eosFS3hkvvq1Cv6zAriDPbbqu6ZKqOh6h5FiCZEtUqyqZx7opEtDahrwIa+kMDdUcec2X+i8xeR/qiJ+LNodAtIniDG/T9+IU3H0dsAsTw+grpkZ5+xtqnE89pL+21BacjDhq4pvKYO/gMq6t7M4wuYKknNzd66bDeVGIbEcS1M+i1W/BfUOIq1kSJPg7O7p1WvvafaNTZzW16hqwvgt0echcYno0/4mJHdTDftDxy9WrejbN74GEcSaOEdrCm7uIFoSPuAaACA57C5i4HUcLgK9q/c028McUmpKTE0qWxQgk2iTZJtKYQstTuc/MoRU6kkmlllPSA7+P3LCufFMYOAhge/jEzhHbdU8CfUlumGxKU4te4B5cWsxA5HlFXa52d2f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:55:53.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c444abc-94e9-4ec0-460e-08df07a23f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

Many cycles ago I sent out a kernel series for using the S4 paths when
the system goes to S5.  Some parts of it got merged, and Rafael suggested
to split the other parts into smaller pieces across multiple kernel cycles
to make bisecting easier.

This series attempts to unify the PCI suspend and hibernate paths so that
PCIe bridges with downstream devices are put into D3 at hibernate the same
way they already are at S3 suspend.  I have been carrying it, rebasing it
and personally using it for a while now.

Since v2, the two changes that had major push back on have been dropped
(see the changelog below), and the remaining patches have been reworked to
minimize churn and to explain the concrete motivation behind them.

v3:
 - Drop "PCI/PM: Disable device wakeups when halting or powering off
   system" (was 2/6).  It would break Wake-on-LAN / Remote Start from S5,
   has a user-visible sysfs side effect if the poweroff transition is
   rolled back, and runs counter to ACPI r6.5 sec 16.1.5 ("OSPM does not
   disable wake events before setting the SLP_EN bit when entering the S5
   system state"). (Rafael, Bjorn) 

 - Drop "PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()" 
   (was 5/6).  It only touched the line that the final patch replaces, and 
   the shared helper already selects bridges via pci_power_manageable(), so
   it was superseded churn. (Rafael) 

 - Drop "PCI: Stop setting cached power state to unknown on unbind"
   (was 1/6) from the series; it has been merged.
   (Reviewed-by: Rafael J. Wysocki) 

 - Split-out-helper patch: keep pci_pm_set_unknown_state() in the callers
   so pci_pm_suspend_noirq()'s set_unknown: label is preserved and no label
   churn is needed; fix the kernel-doc comment for the new helper. (Rafael,
   Sashiko) 

 - Rewrite the changelog of "Run bridge power up actions as part of restore
   phase" to explain why it is needed: it is the restore-side counterpart
   to putting bridges into D3cold at hibernate, mirroring
   pci_pm_resume_noirq(). (Rafael) 

 - Rewrite the changelog of "Put PCIe bridges with downstream devices into
   D3 at hibernate" to describe the concrete problem (firmware not powering
   the bridges down at S4 on affected platforms, and the resulting power
   draw) and to argue safety (it mirrors the shipping S3 suspend_noirq path
   and is guarded identically). (Rafael) 

Mario Limonciello (AMD) (3):
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI/PM: Run bridge power up actions as part of restore phase
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate

 drivers/pci/pci-driver.c | 89 ++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 30 deletions(-)

-- 
2.43.0

