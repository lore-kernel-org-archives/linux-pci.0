Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F9376465;
	Tue, 24 Mar 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315841; cv=fail; b=dWghltaX4DXLBjIiALZrRkpZQDV6b2ThHgT+e5Gw+6UD/qmnoDb9W2Nh+LfzysQEaQQ4OGPgdsnWAoFc1ajvUZK6DHta5yFwAbY8q4i9awcC8l8270Uqy951WQq0eIlwqCpTkPER6oplo5vkPz8Yd9rpaRB4MNRRNWEQoIsEnhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315841; c=relaxed/simple;
	bh=p8wg8+aDEwTUPuia4htwnUVxE8GYBXeQ02CLMeq2fSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riU0J6VkOuSLp+FPh9vWXBJmUdHw9sCzSbmLXgPIN7n6SJFo5VGBquxqvPZ9Q7jz1WyGFGBKtDioDXgr/rCjwLwoe2O94GHDyEnK4YuAThk0L4wNmUD2GCjrCfDSHDzjunb6Mp3O6elHICWnSfc45lk91iAyhPrj0XSwdx/yG6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EeMXWEJz; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EeMXWEJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dasLjEGm6Qm7eqhwc9jRbb6DeLxMLDprp8hYLn86GON70RlQhAv9bhvLEb27JyWL4bTjjckrQm5ewYkQQOB/PkZOYkgarGgZpxM7e53hmF3ITUIA/dFs17apoGd5U7JxQNpo5w2rukDoUEXELZVY6ZR21vb2ymd3b4S+Pj6LSESD9vDN3WeKisliI5AKTRvP0AEYps4TYy+W5SHtyocIq7fa8QAu21/td3Bo+OmXTpDNSD7Ibu7EezRgCsMVGwQeYv5tv19kLpr9BffIOwmwk7r6DNAdAESdZ2BOLrzEhnIFtcTCWBFyanTzS8uVrX3Hp53iWgwFKRrsywiOtuXCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2XY9ToOTJj5LX1UxUtEFcXJ54zADajt4NNMRmgp058=;
 b=QE1hHK1ZS5PiNTLZefXreMIAl56kVQhDkSpXgcsV0KT2WtCHIpYNPzouiCGaNxehZ5Qva8+Dez3AljGOCWjznJ0mjrvKx2zIE1KbyDpBpJXZEgrAfmVsYnhtSr0mpJblap/EbgnUkeffg9kz11HY+OEuY+pG08SgtVoI0BHinthJPjT3I8rGzQXLTgoIcsO+x3Z0mS5r22AWDuMNZtUAgGIoIlFvH0iK2BGmM4pbZeXaVGyQNn7+IATSKGRVy0GRKSEadsPKALLHBhyGt2wON8dI9nRnzWqCn0aABPU4U5HVt+e9VQa2YtEnQ9emxPP+ZD+q3lC3mXGZlFHlfxJ3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2XY9ToOTJj5LX1UxUtEFcXJ54zADajt4NNMRmgp058=;
 b=EeMXWEJzQ0pGj0O1MfoPJq+xeyIdGtufMYySKpc608vLbypUirqz7VkDI7qroatiKd/w3R2+B3fhdWd7rvhV8dr7RN8BCPWi9qnQcCnZtdGjhz6ZC4ViU4gyvyDTWoA3PigjxuhfHpk5OXfofybT3KMNzQgR2yMn18K7m4sqyl1pmIApa2lFbHVFRnw1Rw2HXyR0IZlKI/FnKAEF78jCxmMDXt0VughptQ+/PN3Z+XpY++dgfyTICepngKiD0nKIBTX0Ot4jizDw3MvwcQLmkhdUnIJ7EQFeMq3Jfjb3/VrMcDmSxRwgJHjejWb4ru+Drt08RTcafYAhfCi/niN1WQ==
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:34 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::8a) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:13 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:13 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <will@kernel.org>, <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
	<ilkka@os.amperecomputing.com>, <jonathan.cameron@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<sdonthineni@nvidia.com>, <skelley@nvidia.com>, <mochs@nvidia.com>,
	<nirmoyd@nvidia.com>, <bhelgaas@google.com>, <wangyushan12@huawei.com>,
	<shiju.jose@huawei.com>, <linux-pci@vger.kernel.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 3/8] perf/arm_cspmu: Add arm_cspmu_acpi_dev_get
Date: Tue, 24 Mar 2026 01:29:47 +0000
Message-ID: <20260324012952.1923296-4-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324012952.1923296-1-bwicaksono@nvidia.com>
References: <20260324012952.1923296-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 0534c25f-8970-490b-c34f-08de8944f1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rx61I6tcGhAknLbLOs5AvikZZb9dEzca6wdEnp55whl3ZfkQu9EZPo9aUNmy0FG4KzJ1Ljmc+6B+mh3FwVb7V1nqG7XW62MxWyiL+jABhW+K34Ode3I8cfF/HJzTMYUrDMPxTRMJCqR5Tp6in8ODXDaC8pw1y1BYU3ZaYBmeylIRpxsiT1z1hdV7VtFoDCmO23arj7cjXn3FMQSJoj//rDz/lZhm1tsf3sCMdBGVbD+3xX0db+PF3SAC14hx6+IBwNW/fLZFttzRfEG4SQeM0LJ56tl3jYa8qLXJUQMqbbHc5B0RSBzUgrU7Ht4/o+wO1qZFSbCP++CXXZiMU2hjXG1ogk2P2NgyACA7JnkcXejwKaEm/wc2CZAaHB7rMM6TLKGygAUQWsqJjM9OXgKFbESDj2EY8HrBmJfs1DpiipddEmlEoxBnROqmU6oLeRrNwrWhKYGeakvOF2aMXiZ+F6hs9GjCNwp3r4ZZpYOiKsu2V9jWhbkLS8LQYuLiyHMpppyfNyA3R5x3nmU1xF1EOpjdIBpIDiC9phSCCYmPkfYJgILhsh0/4lZkQN1Q9BNduUQhnINaAbzJgHJ5haJutDuNqlQCSYfH9rsCD89pT72/u6IbvtpsD6L33XGugxHdVbC+W5rvObs5qlPN3uYg2Q6lCdcieHSQggAt1XUVr9kbTxqkFvjB4CgzlrRIs0pTs5qd0a6pfDfZHJBo6aPofNJ7WRrizx4nQkOYSWznVyoiXe/pO68O1liXpvo38tvZEp2mtt/Ew2XklGOlpsDMfg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+1nsKLobXbu3i2gIic5Olo75J0/UIgG48f26FdRI1JfwwBwaQXFJ1I3d/G2W4yz/g3PY6gak4CT6jAlOTQAXK5tS6NPK26fkmgiEJjiRnfzUGYUsYK8a4dx48WcJmkvtmIVcLx/WVSJIb7rCei3Bx4HKYw3dQyUPOkav/7A3jbEbceAMWZ8hwwXxRJigbq44qyhSMYeMYovKWNgwzZHMb9cOhN2mjzCYRXhCAM/Uc+iZDqynxXv6PTAXp6HsY6Lf9n+l9WO8FryvYAFL1c1qyiaidy0ynFG7FWcAKJMKd8p6h0NtY+gwOCWYKXZt6Hwibktzof8vW8WHrlNENF+VwfuVVq2zPUAIVzxMG5HePrg7j7uLdHAD6hNmzov6kaEyhvZrnBZAvK35WdmkuWaBIqxz6Q3cGvFxoZHrvqfXjmSz3t3iiDRHFfgWpLDX1tUg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:34.1984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0534c25f-8970-490b-c34f-08de8944f1fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Add interface to get ACPI device associated with the
PMU. This ACPI device may contain additional properties
not covered by the standard properties.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 19 ++++++++++++++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h | 17 ++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 34430b68f602..49e8a1f38131 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -16,7 +16,7 @@
  * The user should refer to the vendor technical documentation to get details
  * about the supported events.
  *
- * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -1132,6 +1132,23 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 
 	return 0;
 }
+
+struct acpi_device *arm_cspmu_acpi_dev_get(const struct arm_cspmu *cspmu)
+{
+	char hid[16] = {};
+	char uid[16] = {};
+	const struct acpi_apmt_node *apmt_node;
+
+	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
+	if (!apmt_node || apmt_node->type != ACPI_APMT_NODE_TYPE_ACPI)
+		return NULL;
+
+	memcpy(hid, &apmt_node->inst_primary, sizeof(apmt_node->inst_primary));
+	snprintf(uid, sizeof(uid), "%u", apmt_node->inst_secondary);
+
+	return acpi_dev_get_first_match_dev(hid, uid, -1);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_acpi_dev_get);
 #else
 static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 {
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index cd65a58dbd88..3fc5c8d77266 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -1,13 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * ARM CoreSight Architecture PMU driver.
- * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
 #ifndef __ARM_CSPMU_H__
 #define __ARM_CSPMU_H__
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
 #include <linux/device.h>
@@ -255,4 +256,18 @@ int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
 /* Unregister vendor backend. */
 void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match);
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
+/**
+ * Get ACPI device associated with the PMU.
+ * The caller is responsible for calling acpi_dev_put() on the returned device.
+ */
+struct acpi_device *arm_cspmu_acpi_dev_get(const struct arm_cspmu *cspmu);
+#else
+static inline struct acpi_device *
+arm_cspmu_acpi_dev_get(const struct arm_cspmu *cspmu)
+{
+	return NULL;
+}
+#endif
+
 #endif /* __ARM_CSPMU_H__ */
-- 
2.43.0

