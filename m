Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD11A681F;
	Mon,  2 Mar 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483935; cv=fail; b=AB41K/vew03/jogS6BazuSjMgDxCjoMi+1z3jZ3mJNf85awiO+8ucpNmaBqIl2sVyUz9F+FHpG2s0KL7IKZokS8Vl+yI8LbRyQbnWNPFtVt/AFZyXT/Xmqa1v3TUZXgvUqxex2Mjp3FWh4wWF2O/sAQinjXW0aNz2afrhCAfsxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483935; c=relaxed/simple;
	bh=lxNs8YlCP+ZCcpBDon+HAIt4BBh2mlEeELWbdJFqeY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll73bhqRwfwdkSBrQg4fOjLoTEce/C8m2PTHRgR1QqnpheZndHNQU8kzL4ZPy1Xq4EH4bttMko5ZCX9mpfBk7yqI1FWE/3C/++2bTV1rk9+CFx9PPYtckhzriIhNpiysM/GUAnYtN7lrQTT81RLVA+S0YlpzLDvc3pFIR3f+4aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SnUZTbIn; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SnUZTbIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSN+CJ+qReB98dFkKqwAcZ5IYDJ+7aYXgF8FJJY17jmNc6CqiCRdwg7WWnJvekaYdXg+Yx6n8QaNYj7qT/QdXr9MsGtmAzOnwK7Ug+XMYrEVhenSk6894/raoHiqMMamaJvsIDFj74zdFvd4RM4pqlWtqH6mULl0imPIuXVQFGN5Yek1+5kYcAqnL7an/ysnzog+8fbGt+OLUz49zFv9/KXG5KWnD1hjNCPR9GQgndbF0+JQ7rFCJXpbc+7Uq6cH6M3DsMU6M2LgJgR/fgugKfNGmeLBPQMoolJ+dwOhCrvVJgyBBby9P+0OyuaL/ooxrpo6LXYdfARxuQnPJWSxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C8MxuOoPLIrAuz5w9497cUSjt/ogyfQpM6OM8azx9Y=;
 b=ApCzXENLdCUvVHWhHki6pt7/Z7FnppOHrOrQzxygqz6dLMwQG7hixDBeB5hRrX3tWViqXnfwaN274+0QH4A6M1c2OFEfw6TT1NUF2pi72abaaX6z6dWfOipzt8WzWzcGIA5fSODYWpidnA1bPoSXnTsL44GKfOGZ7FyYWLqlW6+uJ7Giyact6hL6NqOPkSpHnXeA4gyF32FSemp0lXI24M9jL0xMAOS65AFsmJ7bO830sD3779NQGr06R8GwY5wdQoyopYDaMhTPV3sJZCx8g7zVCkAIU31MSymPCTnhYg5gSEhAL/GXV09mtag2MFgJRop5tCbufuVz4aM9gON30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C8MxuOoPLIrAuz5w9497cUSjt/ogyfQpM6OM8azx9Y=;
 b=SnUZTbIny1FHHPo2TPGhR3UgTNdCJTUU3AglBA73JRsR2dwnsxJUAk/6F5LKBeEeXwlH5xkFmBWOe4iprnbTKVLUpqaPJ3/222ekSD+vVhnZ1+mcmshu/ZaUKR8DRnzMEiztmqLP5WBnKZDR+GPdJik/zFBK2TupapLGsMQ1Pbw=
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:38:47 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::b8) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 20:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:38:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:38:44 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 10/10] cxl: Enable CXL protocol error reporting
Date: Mon, 2 Mar 2026 14:36:48 -0600
Message-ID: <20260302203648.2886956-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adfaaa8-5a2e-413c-38b5-08de789bb42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	mZtRphh0WHH9/qWWyPRhEzzHZHvXmDq5P/2s+lntMpBRvNb/kVBn1dbYp82O2WSSdGRhQL5sh8hdhFh3dO2iU58VocmkJMMorERz46qR+LWiJtqbF084Juksi7HkFD6kF1JbT7wYM3TyzBDg7m8rFO2QIlkLIhWNPqecBx7AzdViVQmzWODPRCTgy5+Wmgrt2DWuFSvf1ysuwbWHr3Sn3lcLzZ0SKsPJRg1FE0xwlFjUfGwdhZgCSFNz94L30BIpML+1Hf4XOmbIVPALvR5jbqQvQ7zxx57DaLIxD7xW0JLNe1ctcW6/wmGKnK/wmyW0in8LtI6rF2UYPMSZzxBATFsxD8hDFWNec/Lv44he43kt0qy4TrYXHA4cCKwp9XKJhWScboPD/suBa4q7HjQFD7pzVhc0lNC4WCDvrG52HHOSFwV2uTC1zTC1Avw3myi9NOx8vS8mYGE8LW+Cph2gcZvqPwobYpRqp/kP7hpYSUXekYEfY845VSB5Q/6U2howoFYVZvQoQhLS8c6ahRuXip6DQltN+7qLi7L/cxpHpRWSuGbCfdfN66LcwQUzPNY7tQvnPDWKxHLKbfoHFeG/qNFW+b3HI8qN9USU/5G9mcES9QkeXMEriztFapHKYoVt43Orc+BF/FLhdJ6YETJIhl9b/NFBiWdrnUn2sb5AW+E4B+uqTZG5lRMQwXWcPdmWAFpAihUOFinJEi4d4IQjJ9tRlbFMCAXymgEF3IKsT/Z5xVx2b9ad3Llts2+F0JO7CLJTilACCbqtvq+YuY+wM/KWw1TSHvYko/78Db4NfLHvMSijoDdVQqDqDBsTGrrsTOZ8to0FMNxDm8L/9DfIaQFOmrifRyUST6jJ4EYz2ns=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kYMbio7pJ8Uwzfze9x5vXzYWi7zwFhBjHQtCpO7+Rwe0IEPiydRQzJnHjKdyRqz46JDPG2YdIo6LHzlj/j50Of68xxWryUgSE1kRU2XHTHm/99C9jcYYgbNNq5dYxCviU8/jXYEyZYVjzAQRzxe+2BW+JwHeE2GZ8bGfYgqUKPPiw6xHfylpnW+XCL0bnV4tzHyhlU3ULno02xvq1QEgAo8MQ9GFZSv1Vlvjpd4fDEzhgSYajOQ5se7OJoseeTn7rDbIIORqVUanVTqMFUHJPPbtdF2UlfLnxKMgs0AvKRTWkYeLsZpHAK5bV+UXlIvVs2yaePcdT061il7mZbXPX2rrNjLJ09mWSR8XzVWIbOdBIHLRpGPC0XoCLqaZoed23jbVu5lVMc8m39t6NYw+WbZJDFaXg3mvs3fs+Os1oLzLNPPbJoMX3Y1k2WMleb7g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:38:47.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adfaaa8-5a2e-413c-38b5-08de789bb42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Change in v15 -> v16:
- None

Change in v14 -> v15:
- None

Changes in v13->v14:
- Update commit title's prefix (Bjorn)

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None
---
 drivers/cxl/core/port.c |  2 ++
 drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
 drivers/cxl/cxlpci.h    |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 27271402915f..c33d58fb7264 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1852,6 +1852,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
+			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
+
 			/*
 			 * If the endpoint already exists in the port's list,
 			 * that's ok, it was added on a previous pass.
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d6112b812c82..bfe6cb35154e 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -119,6 +119,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -129,6 +147,8 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 	else if (cxl_map_component_regs(map, &dport->regs.component,
 					BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	cxl_unmask_proto_interrupts(dev);
 }
 
 /**
@@ -172,6 +192,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 	if (cxl_map_component_regs(map, &port->regs,
 				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 184a95e96ea9..b7cf9d6137b3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,6 +82,7 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
+void cxl_unmask_proto_interrupts(struct device *dev);
 #else
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
@@ -96,6 +97,9 @@ static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 }
+static inline void cxl_unmask_proto_interrupts(struct device *dev)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
-- 
2.34.1

