Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857B3AB2E4;
	Mon,  2 Mar 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483887; cv=fail; b=Mtg/Ct/tt0qTt0ipiV3RE6ZsDeGHRwviNdyK67UXe3w4wOI/MteGpzTTU6I0wfj7GzFT6n6FdS70Diw0a+tpvzktmbWNMzFsbUqTRkNJJn6eFXizpdCmEAWSg5wASbvZ0u3ojQZiJmPJ++ELgEzdRxe3oXyXhdtP4dnla+5pA/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483887; c=relaxed/simple;
	bh=tvO0vUjW+1GxygElvXT2Y2l70n4r0zA2RS+C1rX6l9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNWIzSURUeCkwzgVReXko/DmRujB5tueh+K5jFGA5Z0Qae3+bt8g0I4ZShug0rYO/P306L2oCP83Yhf/mt0n3ZIq5g7jSeMIr7w/0fQ7wEYvNMGmKDKbZ1UeMKfQFzRZu/VbtPoQdsqqC3jxnQKSffsUY69ipFMfmOf49IOrmbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yD/7FouY; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yD/7FouY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDTRAgToGYjpQ45CGG8bbg8iv1rvQLQAjFXgbJFzyg5z4Rc/4XN3vdmrIrLjAO1XxqSGpYOg9q84HPe4KtiEZIy9aslHyUTGLssGKYBMy7hqqSuDvrDAK1ttp2NK/zYz9V14+XLldwm1OelTguJfRYYPaCPzECUurab8ViUSwQdDgYHYuCSYgdotJErpJuPU0wWXnunTJXe958maF+Rwvqv/z60pVfoeqj8cxVcjZITs8ZJ4N+lsxPMSa8ItkEQWJA1lpXKevEq74DhnJ2f1u3peA1WMlmN0PGtobHet4DmUAKXcyrVFcqFyKQvic54Bip2hUaH/fQEp8RrszjZSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93/Dba+8kZj92lhDF3jY/tGf6w7BnPQbQa7SkvE5UC0=;
 b=FOWxgFnYbhVVZHXAci+6nhO6NGiRpLCx70vGvY0xYKFqYjC9ziwyBg4zMLkVwwVaK0IsQIeA+QWE64jtutOb7yTja2/APtp/aAE02xbhim9vcPgBW68TPXtxh0tlB2yEnshuRhBZCm7QYNCdT0JVMRy/E+gOeNaRU1goosUGfMZNC80rrVHN/rP2fJqQQYfpSmgEhEFHDsFtUvdVLlKdMRy9pTQylEdLpXjg/NWuU4fOoQCu0NCBKxAFI2I9inmE0ICd+pTbPwBD1UYsrJCggxS4vI+zCD3dE8RLoxS76ZZPovkfPeVIfHalm8U9XQATNjYR5bP7dT9geepk+tSIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93/Dba+8kZj92lhDF3jY/tGf6w7BnPQbQa7SkvE5UC0=;
 b=yD/7FouYhm6DREwhzjLNyB/+Dde4Q0JluEV0AJ8Ca+o6Y+qJv2RWB5xSYvVQeXhe+lCxQeUfbeoFYvLn7AJCR+71oaakPWE14UAYXhCOit4j3TUpFnpgaZ5IUGXNv/Mw5/EqU0F2mZWw0v2Hymw7GjxOw5yxEtYKEUaITAJ27dc=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:38:01 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::12) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:38:00 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:59 -0600
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
Subject: [PATCH v16 06/10] PCI/CXL: Add RCH support to CXL handlers
Date: Mon, 2 Mar 2026 14:36:44 -0600
Message-ID: <20260302203648.2886956-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2c65dd-d12d-48e9-b92e-08de789b98a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	Da97WJ5t7Tkh+qDQsfOTtMKKW96fR/0elJj3hUs0oUN500lQCGqXjp+yhpkMbayOgvHunBR3kcwucCkB8i1FpB/+sOf1UlDOvc65oplQYz7Bq8bud02AuE6b0S/Mg2dv2hDzlDZZ/odJTngL3vvjm05s9WyA+9cTHXbK3761Q6ZIOVZvXvRM7jXauAvH+4wImQUTEmPk1O46tozNR71CPptRRAekIXXfe3JoYFrJv5Nc5nZhJXeTzcH34ne9GUn1bSniFn9qH/EryCnR2FJNr2t3K0Ftdn9aIhctdanm5OVYIdbRE8FAZevjmUT+2l+cjY+QWv+k7DbKZ1FUrm4HGHcC0i3XUC1oRIAo7oFFwJihrTCcFpH2s6ubCGp5H2qOI8ObHO0ZlP/vJ+iVqiTMdiPL7JVFyFqYyZ8j9AFSAiVSqogGOXdD/eaZ3wLCWvNXjuFblDYjn+zgeQsCq71GChERRfTXdCfBjxmegZRwppeXz+OFJM4xPcsfFSGojVdxBNjMw3CkJXrj389rkxSqxhHTHf+ZOxkRsSXnJ+EegPYVuH/PsRaI8DCqX+z56m+vwiyKoXF7v6N8ak7K/BLNxno/4vnLIWbOmVUKXfw8tHbfhtMWU8RrppH3XLagxjzEyF1k+NJ7TjFCCkGL6d0c715ymbTTyCHZcxUi9gh/qfgPCYwn59reCEUWSzrELtfBZeyRdEfM6HV6FTkBKYYFp+CF7NrrCs7vEsOdTBKyC5gdAVqNFwcBIBEnhxW918At2b6y9UgNhXfRJXXI6uNOAzDKEeBI0VsNfOBD0xGdQlDAj2KtoaCAiBkglpFgTBvt0N+T59LvUxFqkeK3KcxhnD/8dabwAIhRScvQ6nto03w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xmuiJUL1pjT5Zx0YH49Kml+9TRwRas5F6VP1AOVsJUPgAGqpqNWmUMri/ZEYBYdAwSAw9WD+sI82dQwdMC0XBuADePJLqJgSmgY4TQZW8JYoGa7Kq4d36qZg+ymgTv+3JrzXuPFYv6ypwAWe2EmyGJV8k/LwKdEYQNgywBjfIv+pcF/1zaT00r7rqmAvRRsbgI8uN7QZxIaB/h4gQBt7nvlBCz0szxpuL2aa4PcWor32EPD7Ha6UUAT7vcc1TcgQ2cZGV627b3/8WbPRZ5dq5scrY0f4g1x86/iZTfjuYxqoGzCOcDz0sZ8ZBwMC8qt7k1DwS3ULNNTKGtwNRFWAHXAeCAPUJGxxh3CThC3nu/R5WNpOHQtBh3worl6sfutANwnFIcNmX/skranJ2kPCt57MlSok9tBU5ykLqpnAKVcR6XJSv0PCqmnMAPYXnj7T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:38:00.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2c65dd-d12d-48e9-b92e-08de789b98a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Restricted CXL Host (RCH) error handling is not currently supported by the
CXL Port error handling flow. Integrate the existing RCH error handling
into the new Port error handling.

Update cxl_rch_handle_error_iter() to forward the RCH protocol error using
the AER-CXL kfifo.

Update cxl_handle_proto_error() to begin the RCH error handling with a call
to cxl_handle_rdport_errors(). This function handles both correctable and
uncorrectable RCH protocol errors.

Change the cxl_handle_rdport_errors() function parameter from a CXL device
state to a PCI device.

Report the serial number of the RCD Endpoint in the RCH logging. This
is used to associate the RCH with the RCD in the logs.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16:
- New commit
---
 drivers/cxl/core/core.h        |  6 ++++--
 drivers/cxl/core/ras.c         | 15 ++++++++++++---
 drivers/cxl/core/ras_rch.c     | 13 +++++++------
 drivers/pci/pcie/aer_cxl_rch.c | 17 +----------------
 4 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 0eb2e28bb2c2..76d2593e68c6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -186,8 +186,9 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial,
 			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+void cxl_handle_rdport_errors(struct pci_dev *pdev);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
+u64 cxl_serial_number(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -203,8 +204,9 @@ static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
 				      void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
-static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
+static inline u64 cxl_serial_number(struct device *dev) { return 0; }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 1d4be2d78469..48d3ef7cbb92 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -218,7 +218,7 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
 	return NULL;
 }
 
-static u64 cxl_serial_number(struct device *dev)
+u64 cxl_serial_number(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
@@ -371,7 +371,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		}
 
 		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
+			cxl_handle_rdport_errors(pdev);
 
 		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
 				   cxlmd->endpoint->regs.ras);
@@ -396,7 +396,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		}
 
 		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
+			cxl_handle_rdport_errors(pdev);
 		/*
 		 * A frozen channel indicates an impending reset which is fatal to
 		 * CXL.mem operation, and will likely crash the system. On the off
@@ -431,6 +431,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
 {
+	/*
+	 * CXL RCD's AER error interrupt is used for reporting RCD and RCH
+	 * Downstream Port protocol errors. RCH protocol errors are handled
+	 * using a unique procedure separate from from CXL Port devices.
+	 * See CXL spec r4.0, 12.2 CXL Error Handling
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
+		cxl_handle_rdport_errors(pdev);
+
 	if (severity == AER_CORRECTABLE) {
 		struct device *dev = &pdev->dev;
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 5771abfc16de..184b7877f700 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -95,17 +95,20 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
+	struct device *dev = &pdev->dev;
+	u64 serial = cxl_serial_number(dev);
 	struct cxl_dport *dport;
+	void __iomem *ras_base;
 	int severity;
 
 	struct cxl_port *port __free(put_cxl_port) =
 		cxl_pci_find_port(pdev, &dport);
 	if (!port)
 		return;
+	ras_base = dport->regs.ras;
 
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
@@ -115,9 +118,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				   dport->regs.ras);
+		cxl_handle_cor_ras(dev, serial, ras_base);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
-			       dport->regs.ras);
+		cxl_handle_ras(dev, serial, ras_base);
 }
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c4..83142eac0cab 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
 
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	guard(device)(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		return 0;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
+	cxl_forward_error(dev, info);
 	return 0;
 }
 
-- 
2.34.1

