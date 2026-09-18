Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650349B47C;
	Fri, 18 Sep 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743414; cv=fail; b=OfYS3W0oYssaEe5YLQbScaQb4klL2JbY8xnRp/QKHOrRePObvpDuSz0g8th9VRXdGy+lswMzXPuXac0pBqvLM+nNrNvo600jHW1qM55KBR2j4en9iWlJsQlnwNOxIJqzmEw7Z7Ix3DzpqzmvOmd+wYEgwO1ZJuRIUsIhWK4tzKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743414; c=relaxed/simple;
	bh=9pCY9ZeQpyAdKg3fK4XR6tx7kOr5RHo/X1snONwEXYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvxEVmGCE9hAbCx/6NSImZGo1M2cgTgP9AXH6QtWXX0xfFqAmY38zZFOJaTBkVQIg5Z+63MGNPhVGu/W7s7++kIOqY45C0OkRuA0g3V+lD1WxTFlmAEcqOLW0TFAJYhDIWZ9oWmNqY200BOUDe6/+zswX+Zs/HYk/z3Abar8NLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAuT3nDo; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAuT3nDo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akhh6Z3WtPUB8BY7MrvafmAV3QnbKXzGoU8oujOPVGmAvleJ/euFcwOW/Nq4dcSZkDaNQHQlXCVwZgpG00gz9+Zd65vU3LDY7pL5Fz4tleJMjRwUPJ90m9gKmo8JXVwy/Yzs+MBeHBvcevLvLexzkq1D5FAZwHGWcUk9I9A+8HFs5bu8ezrfofjtZSmvUk1vsqqu6ZcVAU20cmOt80tpDLOlEf/tw8MlF732Aj8pDfUHfK3JQAFBNN7QTaTrUWWdzejvNQxU3vPtICkNu+GK4Sfww0vzWrV6Rfww4/h8LUa0QrOyRlu22vOZ2BLXls1Qm0B6u56GLutg8fJvDp0z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJQuHvx45oPtGxUW49G6fmCNHQ8AJPOM7ZoAycURC+8=;
 b=jR4Py/3Bwm4deFUbrbVnQoYd0qAftwSqAY0HPpKBJzty7x+iuaddRXssdi7YqAIMZ3kal6xXyi7LUdGjmRL9MmrjEixOOW9/5cKi8JUZBMAhR80RPA/oNcNDtSxWZfGp8Fih4gZXyiznArMDZNBgV5xAENBUbsPstarb1iNV7yCVMfZd2LRLgJH+YSvQpSv9OtQ0jpn/YAXg+ozUg9RRDyyLNLRa0wWL40j32R71+tZetE7B7h86Zs6ndW4tdvB1HMhJhPXa33iWZbesvzNcEMTqyI3PRegIMlxeX+SwhI9iAkK4S01t3uTpip3ETBy5kp71lMrMtVW7LDWL5DQ6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJQuHvx45oPtGxUW49G6fmCNHQ8AJPOM7ZoAycURC+8=;
 b=MAuT3nDocPyHfYu7ZI/8GN124VAcAyisu/WMBja8nzcIxfRQLC5+GGKAr9XisIx/H9KOW1U4AURWqq+Z+Qda93v4jXAs9kfyOsxsCVruNWev4VJVwlydu7SxLbTt7dZ1hCst4qGSBQ7n+Op6JEFKs9wWxNajOrSqaex0aN/K9bY=
Received: from CH2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:610:51::39)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:49 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4e) by CH2PR15CA0029.outlook.office365.com
 (2603:10b6:610:51::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 14:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:49 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:48 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 01/10] MAINTAINERS: Add the AER sysfs ABI file to PCI SUBSYSTEM
Date: Fri, 18 Sep 2026 09:56:09 -0500
Message-ID: <20260918145619.3016889-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: b1416ca9-4f06-4059-3516-08df15951138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|13003099007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	k0e/RMktfW2YPffZoNvGp33+KiW8qEF1O8QkLXshXMSmNjWzUYN7dPAMo7p2INTJgcsvmkRPFuFE9eqxSrX2SgqeSNvTLHtHwDDSmYiqCKyWbnxymgEF52kwXtXjIbhvgaKFfNkHssXhzYBY1Vme/9VOSi8yGxFSJOVzQ38e/3vF2wL0qRNMw8T1Wy5FvtI+KoMVyIYKsFHYIug1n0sD5uCMQH8XvrFclXkOUNI36TsSMqSnbdv0zl8XDTYExVww2hydPmMNeqctzea7in0L29DxGm2/c30J7jTZVwg/KE/zqmo+RM31zVz+YIT1b0zBfH6i5ZWaWF5pAa86p93tukmz2/wgXFJbsmYjs9tEVQBJdvjCRRX+3h/XezvFErBC8Ua7ymS4+taVUPnsGJ2w0vJOFRpcspOAJQqy+EshnytdTK2YCD35isa1daRyhxfdHnJBmqB0yw/Gq178ZYKRPru+0a3G3zGaD9mQG70X2686GPZsNuVF2t7qrGBdRCi+3mGkiKnNpIQMVXS5lX/Tp2DPZfgiDVp5pQgJ7UVwPGWZ/QG+9o7X6OqvNLF+m3Rsknm99DQbWnh80arqX/OMPk4WwWm39ybzLVm+xwhSw/tmSsHdyPYj0eoqKsAGtCMBmggiQ+S/mCuku32o0M/jzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vS/H/nzTtZtBOaW6cfGrN2omsLuJAVhU/ooXvwfKcQwVmUGy8a9ohYNQrlGiAaibyXyPPqnFeAhETafVq661Gf7TAU8h7UACNc371Bd14Go0e6Zeva7qM3R2OMRiL87CbNbKGeRuR/yUG88OtFijPmfowgWKmsiOrz9HcwsLtviapnT6GPdkNn7cJwqEW+Ml+nbDZhiU3Q0SKLEGjP3EVXKcEXYTzkU85cMImFZ+B3kJN7duqgvmc2isfrx2mt0TlDP4RmKKurBeyDvl7Vqvt98836EL+2BEviSXbrHZNQZ8beayf6o2/DuydM+pUWzaxa5w76tOfR5tdZDBNcAFvm5I3XcKpB4ZKZLMIUmyNKOO/wWeZ52DaMbr8DQXhhTc27m/79meZ1m7D3QJEjy2iSUtJK75U5zEpK9JO5Q+hd6DqqRB7QHKQ6OxJHBbQcuU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:49.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1416ca9-4f06-4059-3516-08df15951138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604

get_maintainer.pl returns only the LKML catch-all for
Documentation/ABI/testing/sysfs-bus-pci-devices-aer, so changes to the
documented AER sysfs interface do not reach linux-pci.

Add the file to the PCI SUBSYSTEM entry.

The generic Documentation/ABI/testing/sysfs-bus-pci is left out on
purpose. file_match_pattern() matches on a prefix, so that path would
also claim eight sibling files describing individual drivers. Covering
it needs matching X: lines, which is left for a separate change.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..3df47851869e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21110,6 +21110,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-bus-pci-devices-aer
 F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
-- 
2.43.0

