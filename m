Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717394A2E3B;
	Tue,  5 May 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002299; cv=fail; b=Ts4c3MxEFNqJw2XOi+CBlUz0tMfjdCDWlth00sDAWAlpqhoj768Qj0bezIaRVpXBrNgTcveXp9YMAJ78vNRgEJyQOzJGzsvoyohC7m08eUzv/BP6hs6bXhoCwk1lg3GZrnBu7XD4zNHmEE1PGnQvhhuCzCoGwFGyhlvoU1MI970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002299; c=relaxed/simple;
	bh=1AbY7jaFryMXXSc3Zu062yut5s9oe76aqwH32xHZ8Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tudood8DiCXJBDKhpm3mc3wHLowH6rCmN36OrLnlZqbBrOJAFHLJ+/Y/YPoJK1nBJVkiUO5V+4ujvQoRy3EH8aX4UcsGnyGDeDRZcnEoMa1WS/Z9BIcyczDpcAhlgjvHIgef7aonG7+O3gLeS4rjizwN3VWz+CjF4wTpIussHhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFG4PYHi; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFG4PYHi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlQHMIdd0Sn+ChvJRHTiyMlXUO00kNr23S5rzsHKaw38mykd/YWr8v4ZOb5cMDmqA5Kep1FfD/9N2PB0iSDOrd5N8AlMe7oZbikaSjFXVck4BXFUk9XbErvEBpQ9/xA/vtI6NazCHoF213J/f3VCWCB/RwuHqqV0DJZvy/2huVXKTEOCOEAqeG5DXy0KgS+IoXv1EC0YPczQHlcVAYFKJSMDJz7EGVD4ZGLWIATs+eymmiZAN9g1+Cy5zpNmKlAcn38TKR+uD8ry15F97bAjhXO5wHwvopI3MagyVHjxXp+46Q3j1EoxABIoDc7MQ/buLIJKbtlLHAK/igMW8x6ZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BSuWG2yAN/RqK6rli0peBUpIaSvZQ2G0kYyf9mx+Hc=;
 b=hM+L27bpfLg3wGUtUh/HHZNswQC3bfiXHaK/ghYz1rID+zg3n6jRJAcB+38zcwk6XYS1ZdN/jaXGvRAMppXa+0VyIxvVuJoVGpHHfSY0AUS4xK8Xm5rD9iRP4wwroei08yTxj2xZ7nLXwmSWMygWwFRx+4/OhxnU5lO5BUP7x/KssJUPCS1hN8r2phY2LZ38fZiULmNW3CPkSL0zMSqg9Txm1fVob17ko5e64E8rWozfJjpAM+S0WrtQ1O50sZ/lVgxCbkVRCKJe6W5UYiNcSxBqYJwR74/jauV4wsQVN29lZ2mzSr6PPDcT63+rrjyp50bCr5bCGNSV8r/QnxEi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BSuWG2yAN/RqK6rli0peBUpIaSvZQ2G0kYyf9mx+Hc=;
 b=oFG4PYHixTYXOX+rs98abwJop2eAYtiJjrC0+1VG8e09gyF5M8aeucSN7sJxPTSvEa6vs0O7uJWixVcl75X2Zp36Q7wLAGij9K/8SVBDoifcLWIkNlybvT5ixpPC0xvIamGOErNieY6Vy7kqdlUMSNuMfceciMzjEoaXCXvOS4o=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:31:34 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::61) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 17:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:31:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:31:32 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 04/11] cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
Date: Tue, 5 May 2026 12:30:22 -0500
Message-ID: <20260505173029.2718246-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d28631-c17b-4070-3444-08deaacc26f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ycFTYlj/Ao4/W1XB1JNvCCwSDY72vQ5SgjxJX/+xQaGxC/J/IEn0FSrHAhtoybIL8mtjGojRzcdjIDzlUsvhHraw9SpL2PPYTQXqUMqSVzjqatC83ojpNXX/wajyOQIV3a2O3vsNLR4+YdgwBw8bvZxYWv6FUOxf7mMy9hTSgkt+hHtilv6BoWU1IElKqRIqSE4DxSHyx/yNDyCHAQvYhpTIM5U79GT+7o4ClrUwvVtkIJZ2OzgRXYBOIv4ZF4jQTqdYn0HyvlW2FXMtfn+Q2usWX580YrrEg2gw34Pd1VIbNPiJkpFoixxbS8hbF6i9iTlFf60Nf8g+VMV1y88teZhQFFDe40riopRR0YddIAcTciUmOXsp9WH921Q3N57h6S3RdcDILsL7Vxs3SCx0PN9+Dvtdc3vKFxmUqmVqEFFGnvomk67EAEqtL9wmaRPbuiImk8WZNflyhKJELITQhgwCypS1CpzqrbCnx6HBMWnGi/sA41XGbCPcmRJsyJDucOjW4LsUME0ODxPlY2iOiyigdXWC3/f2+5UdSsGSXC/SO2kYUuLi/ARx3F6BeSzJfnP0/RX1FzcLvRvHq22ei5ozxZtmV+zL0aBcNg0e7xQh0Ki/fH1d0zhoshI7LexSc0HxF0uc+Mr4Rikyg5W30CfQVg6rEZq1F+4W5V/eYVkC85irr6PFy1p7PIw9E7Rz49WhStANRbObhFE1wy9CqniaYBwxXr2/myB9vuHBNDwjV9mG0rW/A6JjCEdZkNdZ65RuQlRpKjTuW6GgvSAjrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RiwIoR/k/gY67yovhlWfx9qb49oNCgNwrqbbitpNh9drqHQKHr1jg3y9/1Aw79hufr7XwMEgMgzuG8oRmU7AWHXdbyS1e7YAjsy80kbAdo9b6bzWu3Y6dDHVmnsWZC4kD+NzJ540BdCzBzpXVAu5cNvmKPDzzZMhbLhkjQw5IRSocntF2Xv0bhDKkNlPA9MCu0aigz9Z5BZl2typFVkklduJjT0UyONf54TKBhPipaKAlWf2M7NgXfryG+wMeUJWFbx0BYfsEgInEYheQWeIuRrpsJf/yfLCUywG972TIqKM1Hf8wHgQE/v20UpLLrBTLZZ37sepIPS2LVrOV7bpbWbl4LdifNl0wkJJrYoIAXQ2yQzA3U7m3m02moyqZDSEPMbmZh8cLWcb8KHZC2taG9eMs95o0j80AONBTr7YgqfzWR3ar/Y972tR0O2IKGbN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:31:33.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d28631-c17b-4070-3444-08deaacc26f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

From: Dan Williams <djbw@kernel.org>

find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
functions that search the CXL bus by dport and uport respectively, but
their names do not make the lookup method clear.

Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
method explicit and consistent with find_cxl_port_by_uport(). Both
functions remain static to port.c; the upcoming patch that adds the
first cross-file caller will widen their scope.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v16->v17:
- New commit
---
 drivers/cxl/core/port.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..b35a9016fc81 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1377,7 +1377,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 	return dport != NULL;
 }
 
-static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
+static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
 {
 	struct device *dev;
 
@@ -1390,8 +1390,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+/**
+ * find_cxl_port_by_dport - find a cxl_port by one of its targets
+ * @dport_dev: device representing the dport target
+ * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
+ *
+ * Return a 'struct cxl_port' with an elevated reference if found. Use
+ * __free(put_cxl_port) to release.
+ */
+static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
+					       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1399,7 +1407,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
 	};
 	struct cxl_port *port;
 
-	port = __find_cxl_port(&ctx);
+	port = __find_cxl_port_by_dport(&ctx);
 	return port;
 }
 
@@ -1893,14 +1901,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(pdev->dev.parent, dport);
+	return find_cxl_port_by_dport(pdev->dev.parent, dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
 
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), dport);
+	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
 
-- 
2.34.1

