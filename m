Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45C48F852;
	Fri, 18 Sep 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743415; cv=fail; b=oWE08DzQJHCQBptRAHVnvOnxl1VCFj5SToMxGr1kuaUtVO25Wd49/NNbDX72/hYG0dyfLAQAVueAsm/CgtYBIF8VOhXa8jEDtlHtHOJJqh95nCXhiJfJXQ7mavOhZx9rSePHVxh7Ba0TRdUt56EP3fnygKyFXSSpooWQz26b7ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743415; c=relaxed/simple;
	bh=PKeM09skoyhUtMoUjeV7TXkPfHeVFynUS+exNEx9l68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/2Xxq5E74uBfNEMVo+Y+9F4DY8OXYD5QsPbTcS++HPSo7gS6G56RTrPXnFdqiGOE8JWDHgUvbRK0eZfxZVZjaN6K7sE9gLhWpfNAqm6qVchPg35t9bmMB5IyV8C7SHae9/PgQqleb/KjgX7YKzIcJkwAnzwX/muMhH0Eu7/3Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NosAzs8M; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NosAzs8M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1p6JY2lQJrLoCv7Ze8RvsjUDaTi8NWr4Da3yS66HkxvnGnyUfBmBMvVeHcSwSAIkKLBZQ1puEX36yf/WkCEFClx5Wdrb2xqrfZcE8s3EAtG4AuPXnc/Jkau+cp3lc1EJWctlE4eaT5EqEEWQ7pRwWWhO88shjV9Ssy2ACfIvSniI54sf/7CF0x+mPDLtOaawhs9fwRR5d1B/B/L+K1/fXQ6TWvGWeR0aQ4ZSXvlA0hobHnC/bgVEnpwIKGyIwmQacGC4P2mh546EFSk17FeDbU83CdlnwckP/uT6M/CdR8VsIv9eBmbEgkTdJ9Ma0ZkGjNrTH2QsY5VoOJDDoCimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWZ0IvplSI3DCJEHDNVxG3+R9GdTYNvZV4xwQd0xeUM=;
 b=I5kMHg4eFeeu85jFxR7yx7bkbQPse+rsKlQzh8ezI/HuwffzklR4w8BT9fwtFw3lhlfaNpgHMvFhGZw3xvGTg7A6VyKo0A38btTFKjrkU4j2xfO9C8LubQ4R4eQJeXVMDj68PXhtmckfdkIAJUMLsZKgY0ZT9M2HWkqYY8otXcl0QPQwndre0ravQW9zEm+mH0llv3ZQ83Uj6X802AoX9SQyDhDuCKLY8WmsTVqh3LqtSCZK7t87N9b7UFgZUTCO+pB6lbrACHD9WthvC1mcD0FF8A1SWtJRK9OS29gbGBVROW95PyrX0z8gyH6eHHi9gXr3W7PnTCh4KnJey8dMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZ0IvplSI3DCJEHDNVxG3+R9GdTYNvZV4xwQd0xeUM=;
 b=NosAzs8MpNWJveFzQEEoVwf5Ha9Glf9wg3jp/3H1FdTrEXWi4BTtnSGgc1uhrmU7nZtdS+vXEM4c/ZLlMpRnXIg6vnJGQ8vp1pHayBzFHCUgMycKCYi2QwOZCfFEyU89ds58PS7ESjy7FIIbMUupQk1UqwyXl47I51KEm6nsD4c=
Received: from CH2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:610:51::40)
 by PH9PR12MB011960.namprd12.prod.outlook.com (2603:10b6:510:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:50 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::38) by CH2PR15CA0030.outlook.office365.com
 (2603:10b6:610:51::40) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 09:56:49 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 02/10] PCI/AER: Clamp negative ratelimit burst to zero
Date: Fri, 18 Sep 2026 09:56:10 -0500
Message-ID: <20260918145619.3016889-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH9PR12MB011960:EE_
X-MS-Office365-Filtering-Correlation-Id: c08fae9f-ab3b-4cc8-a5bb-08df15951190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zdiX1Sd7ShoACOmYlYe84DMda9vyEAEehh1usKJXdZrRz4mXvAY+3CPHk6kYAzr+RLiLy9MbwANWnB3+qFgsBrkJhW3nmOIawEBqkX/ZkOQIl91RSACdZheBeZGNo6Fa4Bh+QKDrmd36LTFrOqe/5tiDSBGY7W/KtN5ypzruP3Blxog9Ql344rdqX5jGU+bgXCjTMSjMJpOeUop/JM+XPeQ42UB3V2RyUm1wBiDLkSmK85wk+vzo3yeDpuR+8nRJDwYDmsQ9zqFqIw+KQtDCshxRnks0hg0VRcKV+EKxDKoqVgMwj0V16i2h7ZmRGoAg1prrL6EpPkUglk0tkxpI07c1qBZrLCs1z5eEr7cZdIJNLdEQTXGCp/H9lAEzMgWI9GJsbVSNReYAcjvTAdJDW/kRlWXq3qnOZJL8W0EDT8YYk1ZS+MSXgIJq69c9GaYWdU6fPKWpnK+7rHnw1ZZvGY/1Su4OI/jSuENm9uNSDX4rVcynGjP+iCggcERDBpzDlVnIzy7jicMP5Z12UBUg2QDjfzk/O/vtDQpEti11UqOwk8c+hFze2+SPmMSrTOlP/ZfNzCIoSBpuSganXxQAmJRaHkmMibveFDPTnbj7ZeR+AA5ZkgT9ayLVKnxYvHC52qiFj5yotLX4bPlBuyHjIUIYlJ1ICweC0AybMK+XlxAjczvhUYLpgZDk7DOlrm4mFAi+VIWcsC5Lz7CyYhmJuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	46JLxdqYXbMkGJxXmf+y5b9BIuIA0JuIYIIzi9elE/BctaezuoVU9jbUhl0/AnPPvmHQBoi8p/Vj9kvRpL7luBx08Ot8iIT5D/AAYK/V+FdWsRFdF1jsLXDGEXlC5m+tCIwibzyU/xKdiO9B2puJyU4ik64ykVKESWBUUDWP01GbNkO+lVNHJg7uHaKGuSrrRUs61HHazhVdZsXhQwltX5xC6i2JmNCvm2jndmVXSXD0k/k7DzITflbdjhq0/imzLiSsM67SS2JHig/vjDsA98Cf+L09BnMRZjtWPFby7rw+iZsbE7VlTmXRjUpFpUR6RKhH4LQ6bGgmT2Nr7WLLSy1rK7OHzjHn9xWYXg7DA9khVY7MOQo2qWxKm8cnt8RP3p6HVY/chNUh7+k6hBchrY8IEoD7/7TSDhow8ODrossfbyrB0jOz438DNlZJfWa7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:49.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08fae9f-ab3b-4cc8-a5bb-08df15951190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB011960

The correctable and nonfatal "_ratelimit_burst" attributes store
whatever kstrtoint() parses, so a negative value lands directly in
ratelimit_state.burst.

___ratelimit() reads a negative burst as an uninitialized
ratelimit_state and splats a WARN_ONCE. A CAP_SYS_ADMIN write of "-1"
then warns on the next AER error and suppresses every later message,
with nothing in the attribute to show that logging is off.

Clamp negative values to zero, as the companion interval attribute
already does. Zero still suppresses everything, so a negative value
keeps its old meaning without the warning.

Document that in the ABI description of both burst attributes. Document
it for the interval attributes too, where clamping negatives is existing
behaviour that was never written down.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
 drivers/pci/pcie/aer.c                        |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 5ed284523956..215cf8bd4c30 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER correctable error log ratelimiting.
-		Writing a positive value sets the ratelimit interval in ms.
-		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
+Description:	Writing 0, or any negative value, disables AER correctable
+		error log ratelimiting. Writing a positive value sets the
+		ratelimit interval in ms. Default is
+		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
 Date:		May 2025
@@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
 		before ratelimiting. Reading gets the current ratelimit
 		burst. Default is DEFAULT_RATELIMIT_BURST (10).
 
+		Writing 0, or any negative value, suppresses all logs
+		unless the interval attribute is also 0.
+
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER non-fatal uncorrectable error log
-		ratelimiting. Writing a positive value sets the ratelimit
-		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
-		(5000 ms).
+Description:	Writing 0, or any negative value, disables AER non-fatal
+		uncorrectable error log ratelimiting. Writing a positive
+		value sets the ratelimit interval in ms. Default is
+		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
 Date:		May 2025
@@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
 		allowed per interval before ratelimiting. Reading gets the
 		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
 		(10).
+
+		Writing 0, or any negative value, suppresses all logs
+		unless the interval attribute is also 0.
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..350b57e5ccb1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -751,6 +751,9 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &burst) < 0)			\
 			return -EINVAL;					\
 									\
+		if (burst < 0)						\
+			burst = 0;					\
+									\
 		pdev->aer_info->ratelimit.burst = burst;		\
 									\
 		return count;						\
-- 
2.43.0

