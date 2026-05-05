Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58733495530;
	Tue,  5 May 2026 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002296; cv=fail; b=DMT/QhHE38R8A3ep34qcBEDYiwh3OYLdCFUGsq0vH30gz4Z+ft1hHnjbSkFPl0r5dHVlPjlV/BDa0YYqFcjR5zodZjv7oVqOZGkHY6jhXbdYVKl5EvopnHmHLN7m/FnzAxXiDtxrv0l4jY7K6ldmv3YkSStt2psE6tAYm8FYIt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002296; c=relaxed/simple;
	bh=gd/oi60dKTv24/GYHeVkSJm7coPLWVgJOSQJdIjGz9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=la5IFOg1LQr28wJynM/VypEokVH1Gy8aIV9cG8g7SRPlSLDUm+p5GtC3xeeAT49zPmL6nomk3fDWJItrovv5mfdQ668jyGTODa6GEXvbmlttKqbRLmDvl5Lk74ddubTj3C7ANuyDQg5IEOMUwly4FN0x+s5ATTU/Z5DY3/4UPSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMAJxOXG; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMAJxOXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb5vJW5neESNB80hoAC0zYTXgmZhlDZqH9ZmJtm58/H+HZsRokZljksIcMNeycKS+QvaI7JC1ckYehQqbFGiNgYy3yJ/iq78XC68qJ9w0O7vqcW3WXEk0gZSE7/nNgzpMFfiwg5MPnH1wOrPaQNvsAa6Az4wXbXACH12sXODoU7NoYPLqL33OOhFrIXxGMSq8V7teZ71dp0ewdcoaIU3RJ9ato4DGfyC8UISMZd5/lVTHKTn7EB8TBICtwDeTQrc76DJ1uFXXyoitzm4Vt/8L1Hr3T8BMQIJpqEaT5PVNaVrgRUuHCsRp5wgXqQcR+vAKwO2hosmwd9Zx2tkoGpb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj4YpW0OS8s1EpgjJNtZ07ZA3uKUFW2IhFQCpWYJjrk=;
 b=iKrJcgNCRHDMhQ9iiAbJJ5nNbW5g6fpbXcQb0wcnx6MPTWOBgZE2olvMwXfrGlFs+InKbzxi25vmY8i0mzy4SCKoHvW7V4Qbh2SgYal6e48JRX0ALSaQk2wNLs354/jZdL5RWWsHulrwOacKF51LVKZwmHumwltwXQYLJrXHnZqt+53m4Dzazh+Mfnvevr8vWNtEH8cSVoy1ZQsF/LC6oQANL6Aktdlctzh5xInvG45JipF0smG5IcmBJQMpt/PcG3RKUXra2e1l3rzFL94ZNt5yFuuCVPJtxJ9JBqjIylxvv+cTONUCsQoF60tIkBOoyX9K6BtMr1ZRmpQFY/JM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj4YpW0OS8s1EpgjJNtZ07ZA3uKUFW2IhFQCpWYJjrk=;
 b=SMAJxOXG2yQk6y55bB9iN0f7NoE75Akgo4XnUrrXTECRT81HNLnEjcGpthbnVVZ/6MnU/0TuYv3ZjLaBCnJKsFQ2iD04KWsweTEXPfnN0A43ykJkY7RdRbkRB0Zk+02RHfjd37Wn9AV63DEVi8j4PYJGzVUWhWKy3gVqjJMH1oM=
Received: from CH0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:610:b1::9)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:31:23 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::8c) by CH0PR13CA0004.outlook.office365.com
 (2603:10b6:610:b1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 17:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:31:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:31:15 -0500
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
Subject: [PATCH v17 03/11] cxl: Use common CPER handling for all CXL devices
Date: Tue, 5 May 2026 12:30:21 -0500
Message-ID: <20260505173029.2718246-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f974037-25d9-43dd-27d3-08deaacc206f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r9qTtFtYu9tbJbcxUSlpHdSU8OyjDcDv0T661U7yH/t352qA0zaZdPweMeunOLIPpznDFXouI9RaoontexS/cu5UkvdbFnhVNQpLK9RTxvflxQmaGQqltEY7C6mYh/zkBchOZvNP6W+X1gs/r2OegVcLE2eAya4J1vmCVjP46ejf2eXswL90uLIN6ik69T1mKG2hjrb3XJLitQXqDF2GWO9VPjqAHl7lW9U2xNyKI32ohtztvdk2CpCCq+yNN7p6j8kKTDTZGtHmEhxtcDVugRUfoBE2FyyWxog4YoSHlcpgvkPXBnln8/6rjHnwY6Wyf4Dr+kfyW4eROPi/O18PO0pYl90r5ynSza2k+BSz+Hu6Dwc+Hi+KNTb35GXa6qqG5GHcVbuv/N3ULoTVkCNs2UZXVxw7GJ54wEJW6+GkDqfhAcJgU+fMKyF8uVDgt6gwPQCGfJaeB164iLNKxD6WLcS4bLVvZtD7m22iRT39dYw1gEqVXgZU+XvlUKeXBChDaNu/MLRZvWQaz8c2WdN0vzGpZvr2j2ThHUxlAEm7E3Su1p/NI/1/8qHEDHSMbV3KUQiPyhFRu5KYf9aCZygmYOj/Lqpf4YQgECQnO+tSf672Rj0nZkKQeFqSBJ1+ULF85/xz1RqzfYVraB+Ha2vMt0azG+1aLJnQZFVzcDNu48WGC2Pctxz3+ReHSEqDw0S8Nf4v1QJpNrJQlLo3YxrhFByktAN85CD6cbTV3qBDtS3eJTLVnk78uiEXEa7xx5cIieo411qwaZnXAx2pA64yAw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2p7X9UHExeYcToeKRtcou3hQFxEHUURcmgF8+NfzAvsAwXItBQ5NU3F4WvuSqXlcr5Tq0BZRFDFVkm5XAWETgdJdY1LjG58tIPjN7rqk9ak/nD+s2SABV78psCuVsB590DOMX8Jib4un4CdSPeVFLWPouVegRQprrx7yzO7L31HsKI/x8lVU3JEHj5zWmFTdcfyVgswbkKt9533AvJZ3RpSER7eWcRMi08y7yg2+C/zwJS5V2eTnI4wpnmdG2CaDI9vRafl6ARmRhKzAKYrmsxfv1i7zTDtJ4nmh8R5Que72d/cD+SdwzL1wXQnyjB5TI/L8lLKK5NU2AqPF+4vcfMtYr7KrbZZrgoQ51G2vHGc2pnA2HyvCnLfOnYaU8jxG5aya0hozUe/gi6A9ZBpNCxxBTnKCkukmfNIWPLDSmY868cYUgGSmYYluS2u2Iyet
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:31:22.6951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f974037-25d9-43dd-27d3-08deaacc206f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

Fold the Port and Endpoint specific paths in cxl_cper_handle_prot_err()
into a single code path. Drop the PCI type dispatch block as both Port
and Endpoint devices now go through the same code path.

Extend the pdev->dev.driver != NULL gate to Port devices, which previously
bypassed it. This check and the existing device lock will ensure the CXL
device remains accessible while in scope.

Recent trace event changes generalize the interface to take a
struct device * for all CXL devices. Update the Endpoint CPER path
to pass &pdev->dev (the PCI device) instead of &cxlmd->dev (the
memdev). This makes the trace event's "device=" field show the PCI
BDF for all CPER callers, replacing the prior "device=memN" output
for Endpoints. Userspace consumers correlating CPER trace events to
memdev names must map the PCI BDF back via /sys/bus/cxl/devices/.

Remove the bus_find_device(&cxl_bus_type, ..., match_memdev_by_parent)
lookup along with the match_memdev_by_parent() helper.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- New commit
---
 drivers/cxl/core/ras.c | 81 +++++++-----------------------------------
 1 file changed, 13 insertions(+), 68 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d7081caaf5d3..56611da8357a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -8,65 +8,28 @@
 #include <cxlpci.h>
 #include "trace.h"
 
-static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
-					      struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, u64 serial,
+					 struct cxl_ras_capability_regs *ras_cap)
 {
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
+	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
 
-	trace_cxl_aer_correctable_error(&pdev->dev, status, pci_get_dsn(pdev));
+	trace_cxl_aer_correctable_error(&pdev->dev, status, serial);
 }
 
-static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
-						struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
+					   struct cxl_ras_capability_regs *ras_cap)
 {
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
 	u32 fe;
 
 	if (hweight32(status) > 1)
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
+				   ras_cap->cap_control));
 	else
 		fe = status;
 
 	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
-					  ras_cap.header_log,
-					  pci_get_dsn(pdev));
-}
-
-static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
-					 struct cxl_memdev *cxlmd,
-					 struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-
-	trace_cxl_aer_correctable_error(&cxlmd->dev, status,
-					pci_get_dsn(pdev));
-}
-
-static void
-cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
-			       struct cxl_memdev *cxlmd,
-			       struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	u32 fe;
-
-	if (hweight32(status) > 1)
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
-	else
-		fe = status;
-
-	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
-					  ras_cap.header_log,
-					  pci_get_dsn(pdev));
-}
-
-static int match_memdev_by_parent(struct device *dev, const void *uport)
-{
-	if (is_cxl_memdev(dev) && dev->parent == uport)
-		return 1;
-	return 0;
+					  ras_cap->header_log, serial);
 }
 
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
@@ -77,38 +40,20 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
-	struct cxl_memdev *cxlmd;
-	int port_type;
 
 	if (!pdev)
 		return;
 
-	port_type = pci_pcie_type(pdev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
-	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    port_type == PCI_EXP_TYPE_UPSTREAM) {
-		if (data->severity == AER_CORRECTABLE)
-			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
-		else
-			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
-
-		return;
-	}
-
 	guard(device)(&pdev->dev);
 	if (!pdev->dev.driver)
 		return;
 
-	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
-	if (!mem_dev)
-		return;
-
-	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(pdev, pci_get_dsn(pdev),
+					     &data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(pdev, pci_get_dsn(pdev),
+					       &data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
-- 
2.34.1

