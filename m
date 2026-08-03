Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCBEEA8;
	Mon,  3 Aug 2026 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795558; cv=fail; b=Fh3QluyUavrfR3kEJg7I/uwPYmMaS1yTRIlObm+LMr8ZXl1Uu6+rBvTTFwkbjRMXjubFVB3nXmAUKpNCJlkrCUz4A0CLv339PzRbgknl/hxytETpqG02IYiWsslIjQuyIeODLt6ptOZaVcyVPDGtlLnosv4Aa1Ybmf2n6uSGzOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795558; c=relaxed/simple;
	bh=xktIN0U1Q6bT6u59qfzfNhEnBM8AjUtKHxhvPsLspAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYWs2ilRiGtBq0PPMeznnHcCbs/IIrn0s5LPAn7+UrEpbePRqVZr24EvTY62l4kvcQPIOe29QJpyNOxoRyZAY0Djbl+kTqR8Rn8jOA5g967S/0ovhn0sJs+hafhj3pXV+RJHttdLJzU1A8WuYFvjv//EdKT89NzU1wZMTarCzII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jM4zKQUW; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jM4zKQUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa71Exowr2FqWXohwpMaHDo5/PU3TFK7cLulMVGghox6EZXVNFEoESejiapf3UvhK0RLkHi8mO/IrhqYqve0rBI9zsRxvMCr1b10euCKfye+hTT9GRZ8bsevKeVe6BaVjQvEE+E3074NauzwXnte1/krhPEjjk3GaIPtQ3HqQNHfhZzVn+HMfQxi4PH7Zg8SO3NuegKLRnUFlYdoHnZ7vM1ZUjYkdtyq5WvMZyYqWyya+sJequ1S2HODHt5qF+lmAFYxDXTgdlXEJ7vUGFP75UcrVJY5m1YmtzCybPiR09TIIWMlelFGhYyzTzzh/Z7wjTr+4zCN7+AXB2jt8Io/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7o9heFYTKcDzcBSlYKX7FFpEKvwhaG6AHxuY9ALEB4=;
 b=SfWzOnYm/JeVHJrArv33xrwJE0QlQO3lPgH0I6bWkuz7JP/Qrd67COoGCGxpEy4hXiQvoHF3+S4QSV7Hawv8GyqWQeAuQQFYHVxruEHf+Wl8Whrewsgc4lZbI1gK0ehEUan5Liy7Npl4FWbqq2r0z+24Xcx81ysRLO5iTYAm0Sbd2E8/uHP+9neh22NwQMA0cXB6EGfFbYVpQ85jKaHO2MboXuX3+Sou/x3dP429AjJ0tc/0p5Yxliut/jqVkH/XR2sipi4UHViBbApO6NaeExFWHkTo4hX5G7lzMDNXQPn76HKxDl6r6X2mOo+ezgH0uR1P0WItX3F6ABStDKEfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7o9heFYTKcDzcBSlYKX7FFpEKvwhaG6AHxuY9ALEB4=;
 b=jM4zKQUWW2r4releRjAYqekzBmE+fh+3NhOx1FTNB+xBEM57unMuK2vmzSYlZobCA7sD1xzmM/cybgd87rjAhXcqF3/tH+x9Rf0Hi9mrPamJME9XXb/AkC3JdTHJdNocF/6911vodnbnWqWexX/mv7ni5K5EviPDKmT1mAmsNw8=
Received: from BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:12 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::80) by BL0PR05CA0006.outlook.office365.com
 (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 22:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:11 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 05/14] cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
Date: Mon, 3 Aug 2026 17:18:01 -0500
Message-ID: <20260803221810.3685703-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 725cbd8a-44e8-4d71-6055-08def1ad3f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xM5mpCzT/wytz83wOKeUuer32P4dFtKj65wNHkg1m48OYu6bzQTuK4vXh0w391lkfOfCrTgtBRvyqbutTi2wLJaU1BBSJG5rtwdiUJvqpyP9k7EwBOWAAW4INGR/9inkuJnFfG6fdyAANpdPXhOjNX9c6knGiycg+Jk9mavKon1QKVF1ZoN38cL55Iq+NCQQDRs8I2xTH13O62aDQ9c/ulFazEGVFTdOjADFCDdheUlMMq5YavIu7YRoH3nSQP7lEIFafQ6BHYIjEg/DFfHIgCZ8qj43lsbgodpQJ0/CCKpe3U0Giv9WpZmaDxT2Neim4W+Qz8CVWX0Fm9gnxb9C83J+Pj9eZZysQK2A/hUc5AlRqEC/Kz7DF7HQU2M8EySjypUz3ZLCLskBvFSfe1NNl0iayx+EjbD2fsbCgaQYec7Sh13GVEOAR7u2f4Jn34EHJE1D19GKe2eqbTLHspEQRMT7e/9EWJXqnuXYtxkvRbQ18c7r8msBP+2lKenL6IvCTWFEjMx+ujtJhA2Q5pzKL3nl8P2rjN54TptYnfDTyfdV0C2osmYqM21h1jdb6rjDuEsw4nyflfTUULUZHFF6H9fonVbNXznqf4iEjRW6TCjduQDV4YxILPDaD2+dvOvxgX3hP4E1+OwhHxn0aR30RGTl2az7XE5lDE576MNyYg2VAicmb5hUx726DQFwk3j/KHY0KYfNM3UM0SEgPmH0wg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dk/+xrpZGq59SuH1GDnaxKdGLYq2DlqGEqIesBtgHSG4LM4CsR6/NoXAzyJ1ldtJdfkNegJXqo6EJ5fdQrgLke0SA9iej6djV6TT4k3CV9gm4Hx2KdJRDj8x7WmXIo0bNmzPIU08zros5FObEFM89dzrkyXbxxhyMI90yTyiJS4LffO5Hx+uS9BUhKXoVbXMvg9pBDV0d+gw9QnMWMFlPj9GgnfzLuNSSROpk1sjooq1C6WmwWPvEqil1ujCBgDtnJw7z03J7ZXjtNHtQWsyuz/gfuHfX/NwIb0UmgOEwX5PlQZf6ujJAA6sSNs4xMRHd1Ch6HNyAG0yfe693Jj3qvBpfU1hGd8yFCK8OEnwrKKCW5ktDnBXefET1HsaXqMJyOUaLDc8Z7K+xBHIY3ttBPoA2npf3El1zwAW09De+JJY0s9XUSPSfDG9XxKQ2w3o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:12.8386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725cbd8a-44e8-4d71-6055-08def1ad3f6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205

From: Dan Williams <djbw@kernel.org>

find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
functions that search the CXL bus by dport and uport respectively, but
their names do not make the lookup method clear.

Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
method explicit and consistent with find_cxl_port_by_uport(). Both
functions remain static to port.c; the upcoming patch that adds the
first cross-file caller will widen their scope.

Make the same naming change to static helper __find_cxl_port_by_dport().

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18 -> v19:
- Update commit message imperative to include __find_cxl_port_by_dport()
rename.

Changes in v17 -> v18:
- New commit
---
 drivers/cxl/core/port.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f90f899c31d07..cadb51f70f854 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1379,7 +1379,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 	return dport != NULL;
 }
 
-static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
+static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
 {
 	struct device *dev;
 
@@ -1392,8 +1392,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
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
@@ -1401,7 +1409,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
 	};
 	struct cxl_port *port;
 
-	port = __find_cxl_port(&ctx);
+	port = __find_cxl_port_by_dport(&ctx);
 	return port;
 }
 
@@ -1895,14 +1903,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
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

