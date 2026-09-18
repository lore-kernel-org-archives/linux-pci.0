Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2F4FD278;
	Fri, 18 Sep 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743428; cv=fail; b=pZpp11J259k55DfntpKZx+4ObuLJ074F1bQVRPYoibIR0R582kPXPU0rAvLeQL4GoK/iQL1r6zyiJ7miINsKUD4QzFokcFy5wGjePAR4fDm+va4lcUMDaYcefsB2UgdoSOo0BVPy3GEi3UPFZag+77y9I9kkPkjhc1jtyXeImyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743428; c=relaxed/simple;
	bh=xEoRLEwWV2hzEwhjM9Kad4z4Sx+x/yGJO2HXug8gyVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C25GEEaiRc51j+ksjdaPVUlzEs0vooCjj2ROnUydwq3I0v6G0w1+HBsmgeaUKn4YPxx174abU2F9c7klB3Y8orTSilgFrEOJ7tZnchaE6tmVNBYxQZRF3cDifkOmNEMGGy4BYs9TPAAyI9SwxocvpZiBqmfCJiMf/nFaZxZJlMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zFKuN1yL; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFKuN1yL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnnVJZE1NGr5SZxV9NqwUqid5n/qGXaspLyB0MnMTFcxU1R6emc6YU7WJNfS8814bpQgGenWuJ1gO0Q1gD1xe1rkclwloqKIHRwYUoOkwtUrRI/ShDNBkf1oYp0r0XeUXeC57lZ+/CBD/03Tn2i8ZC9fnsXWnx34XNS7myv8q0ZVZ3qsgsRGxlqznGTG8/vE3ODGL9Hdd1v7uIPFGvvETnOsNPCXP1lklhSdmmFuUhiau4YywoNJP8wn5hjknjgwvAySUagcErfJuam7JVQj/aCJ+tKgve8jT55X5W0Pw5LiF+MLSSaNgPkPBGoFM4gVorevv78oftb+5ME03LSn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udl2dOM+1zcBA9cWNYdd1I0SskvjKCezZUHeSg6/Jsg=;
 b=Bs3B59qa+eaf045nb7pMWoB6Lc4ThreKt0WlD3XH8BCoFxsL4OteRjgCPiTfbCbcnwZ8Bo6UXfqs9B4KHsfnEVrY8Ax1ZcWsGY+p0pzijPJzZVSQFc77mUXaPdkRQ462gvu5AvQTzHtSNNETqnXc8anuaTfxleqj9/4odlFF5Ipwvt6pL+z6qs8dbs8h0h8AfSvQruaiSjbRvXSxGeDtQ33gLSxT6NS47GYE8PpDLbpOhoI2B6HtOGhm3znGpJtUYEc4xUrX7ErbCR/aNDSRvRAHpYzYo9QRw4SeAz+X1hLMkaLLGmgeuUczubUhcWdz37vEpIZXlanpxY8/KAorMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udl2dOM+1zcBA9cWNYdd1I0SskvjKCezZUHeSg6/Jsg=;
 b=zFKuN1yLMZEh8yIPbmjRAzFBxOBbd3ERciyDYkcJOVmo7rXN5A1zz7gG/GYJWHM/Eg2treG1hwsSkYUB9a5yfF+qARHUKqVHAGkoBAc1AnE1nBmWMQ6VlvMDrH4QiJGHEQwnB+NWeZWzVclA+c7cPuB2IUtCX78O95vRwmGfhmU=
Received: from CH2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:610:51::12)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:54 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::8d) by CH2PR15CA0002.outlook.office365.com
 (2603:10b6:610:51::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 14:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:53 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:52 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 08/10] PCI/FLIT: Add trace event for flit errors
Date: Fri, 18 Sep 2026 09:56:16 -0500
Message-ID: <20260918145619.3016889-9-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 334aece7-e183-4a59-06bf-08df159513fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KA8htCMjJWYdv9ih/TnWdtpcV1KIrlAExcBE0YACZil6kFsjrej9L0Pg1QKOi2Qp9afCOyd1yHJC33x8uHT/6thB4utsJdr8l0TIVjOvGWo4BeZbKDQI/R4nd5/0Ff+zdkyC/ek/fcarnf478EXkSXrvftPepB7m9ZUCQrNN7As9T2jyAf6E+6TTVVrmb6VkBP2+oSvTPAVWqqFT/TfFvjuNOXiOKZ4ul8VajzcpK/71c21G0rY8TRs+RX06klf8hjETQxIVFFOtH87NoVuAMStEefWmxp5XzbzjK/KAASSE3RJ8NwCfNSH8OUVlVyh48TrWcOSryLd/X5MSH/b/rv6oAPAo4eu4za7nvHf4V0UMs6pLWdZ20SI/s1oeGlYjOrnCO+RLNyPhIfQ3kf97WDmmy6aIN7oulxcAtzUzFcwaGnxR7KLs144Zk7Ey4g+NdYSP/Qo84xIySrn1t34M/Ag76kI/TBmIXS4Q96jdyBzjEnXIBeJ7/oPguZ4p/F57ldPfihKLhoMYObKuv6NtwjcnityLhYfRizm3BObyhsgQz+fxSSypR8zlJAlsRV9b8HwfTiQ+7usAuaR2GyYnUIAwWaB2Vlu8bzxIyWxH2fgYjo1fdnY4qUw29GlrU3XsA6OIzLw3eZlD5m3/KiAxsX4XXsVPlwZKmcCd2ZetylSsdhzc4QqtPyCond5w61QY6Pw8rEB4IV5+0nZh+WLtlA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bvB0/SF5TvwWdcnYEi4CNnvlD4x7QEE1MtexRxkbVW16ajdG0QcBLxoQISDqeGU/7M6kTfp6FTVbDVK9KS1QyGCn6SrGBIXr9C++kAWDgXLF9zV0NgAQv05KlojZ6BVc0B2/ahZzQ5S1Z/jTwtvikD5V65gGOQWD0a2gp6XnflwQi+SMQsJzwHNWlowI5mLPc/0ZPRBRZn1N7NlGbisFfVB6vP9IyoFXIXvdmF/nLNXTllEWnpH6ecXnz+JFhOpbo6ihAulVbTcAa4IgFTG/+pT3XxOSkaS4FSpKCoebsDerSP6J3Mgl2tnuXPjR8I0L52O8elTWxfun9nxTzOvtcK5SF/9aQf5kv+pNs3ZlHPcFHxMuipuT6cNMFgHijg4fbElSwnsedHrfmEFpdW+3KFnL8HCWqdmzvC4GV6Asag+ZYDP8cR2WN0XCcg+hL+W6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:53.8996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334aece7-e183-4a59-06bf-08df159513fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

Emit a trace event for each flit error logged from the Flit Error Log.
The event carries both Error Log registers.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pcie/flit.c |  3 +++
 include/ras/ras_event.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
index 7c0b9c8dd481..9eb804035997 100644
--- a/drivers/pci/pcie/flit.c
+++ b/drivers/pci/pcie/flit.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <ras/ras_event.h>
 #include "portdrv.h"
 #include "../pci.h"
 
@@ -205,6 +206,8 @@ static void flit_report(struct pci_dev *pdev, u32 err_log1, u32 err_log2)
 		return;
 
 	pci_warn(pdev, "ErrLog1: 0x%08x ErrLog2: 0x%08x\n", err_log1, err_log2);
+
+	trace_flit_event(pci_name(pdev), err_log1, err_log2);
 }
 
 static irqreturn_t flit_ist(int irq, void *context)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index fdb785fa4613..427585505dd6 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -381,6 +381,44 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 #endif /* CONFIG_PCIEAER */
+
+/*
+ * PCIe Flit Logging trace event
+ *
+ * One event is generated for each flit error the driver logs from the Flit
+ * Error Log of a PCIe Flit Mode port.
+ *
+ * char * dev_name -	The name of the slot where the device resides
+ *			([domain:]bus:device.function).
+ * u32 err_log1 -	Flit Error Log 1 register value.
+ * u32 err_log2 -	Flit Error Log 2 register value.
+ */
+#ifdef CONFIG_PCIE_FLIT
+TRACE_EVENT(flit_event,
+	TP_PROTO(const char *dev_name,
+		 const u32 err_log1,
+		 const u32 err_log2),
+
+	TP_ARGS(dev_name, err_log1, err_log2),
+
+	TP_STRUCT__entry(
+		__string(	dev_name,	dev_name	)
+		__field(	u32,		err_log1	)
+		__field(	u32,		err_log2	)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__entry->err_log1	= err_log1;
+		__entry->err_log2	= err_log2;
+	),
+
+	TP_printk("%s err_log1:0x%08x err_log2:0x%08x",
+		__get_str(dev_name),
+		__entry->err_log1,
+		__entry->err_log2)
+);
+#endif /* CONFIG_PCIE_FLIT */
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
-- 
2.43.0

