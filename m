Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AE202C48;
	Tue,  3 Feb 2026 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087243; cv=fail; b=ir852re2p2yFav8MP9qYlqncH9QZOCZOj3HuuSz264fGr6Exzw450wj/43vYkJRXeleP8S3VA5uJBlk7AtXOnc6mfWI6srXkzizwVdpk8L8+AaZrGtVKo1aIzka1GFAhzLWmRTqehDnlSC/d83chYnhTlUxPZEbS5lLi7+BjLPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087243; c=relaxed/simple;
	bh=9X2hZQjPLmHZ2t3dqZuL/k/DhkrpXqceD0baQf5O4jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgnYOhyHDPJFXHafoT8L2wqGcMmBCv6blNUYnok169QB7wukEsZBf6iGMyj6cmpZrMolNRA75DKroLfozq0ARCo5W5PSLil+S0QXsFGVZznTA6t5ANaX5Jq/yugpsMFubu7vD95QDMsTiMZEen01hJCvUyJCedGXJVM1d1ki/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ceWDy0Hz; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ceWDy0Hz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBKB8iC10Kwj0FeF194pdSklIW6DCR9CkKMWBuCeZjEWsldOAqPuQCK/xP1eVW87gNlpB+LcqDUSQ4WK5TlPu73K8JGC5HvZ/XKITv1RqQuDpRLv/KX+Im/6aUZ4dMs7kxe4r7uBShk8oBmQY8SFPWGOmloA7qs0CidkpOCmV0oaarUiNqwfIwI+Te09eVJiO1ZMA/Q/07wzyYpTrT04iho71+olfp55wJfObPhS7SkQhc21PxDCRgc9m5f3BnJwW4N3P8bs15su1HPJ/phT+FBobVYSv2xvmMzoIRlgYhW5nPXakf6vwd4EqGJvp1iJeNDB3/nns+8aRhnjhzPQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6EsXhIq9vRSXjNzjyRVV9N5xwx/hMFRISg5q4auBjQ=;
 b=vDgtERnaHhfD/J8JNE932oyGk6faq8GD5WO9xTsoqhG8NDQA95wzhbaBvhiZ+rK8n/eNRH0B0CUYYuescKU0YdKg/bZKVpTZdnkfGLIqdpHC+jONndd+1mz7Sl9Qw+eocAL3X7jn+GpMGOlugNakIBh/f/2dDDG4EmJFhUp+D7BnOqfO87I0Yu/FVl0vniogHCO8ZB/tmHTvEybqeATq9LdFnWoh7dHydrTKkh6fp1KTzREQ3FuqgHEgVm8CBj1A8P2c7GNlVVFLqr3IBA5xpFSIRWo7WZKvX6JABAvgq87d3O+dcUuPv0G0UyKwACuF6WSuJfA9bC7ttfxGm+VBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6EsXhIq9vRSXjNzjyRVV9N5xwx/hMFRISg5q4auBjQ=;
 b=ceWDy0Hz7drkAa3ZjhShIuniIh8KXGvAURlFwO3IB2ktGfP0Pa2EmCrtTq7deCjjmTQa81I3+b7j+gdFMd/nbxOs98/32ySkoXtKPl7E4EcnuT5+BpEkZ4cLjm5V/j80pBcw0Z9JDoYtsqsjIrhF5q2DCyq/XaZ0wBNWmvkmh9M=
Received: from BL1PR13CA0250.namprd13.prod.outlook.com (2603:10b6:208:2ba::15)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:53:56 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2f) by BL1PR13CA0250.outlook.office365.com
 (2603:10b6:208:2ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:53:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:53:55 -0600
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
Subject: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error flow
Date: Mon, 2 Feb 2026 20:52:40 -0600
Message-ID: <20260203025244.3093805-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7f3d2d-749b-4502-c6ed-08de62cf7916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Htx95DFKxMWly0TjOZzHtYiMA6r1xSalOUZjin+h7Z8qx3JmOFA6E+noEKhl?=
 =?us-ascii?Q?ADeaQENsHE5zcyBG6kqQbxV7M7Y49EnOz4GIvnLMzi7trk6CJj0FtQlPi9+H?=
 =?us-ascii?Q?tlk/7PBhIvQ5thxZaBpq8pld2DIXzIRPGhRXCd+GkDS5CnnIkyAMD7yMSQUa?=
 =?us-ascii?Q?2AcwuuzeT7ih5hhlUTAJDyPDq0EpSygaTBW4JZwYZd2EfdP82napgh3bQh7i?=
 =?us-ascii?Q?0UvO/HflH8q8x/sahZeQ7St+mHOiHoYffNhD8FXqjzDkBAo7IoCXq8aAmP2F?=
 =?us-ascii?Q?x0MUvvt8Nnzddk8Gid75NhO6yybXcnzEzAA2+Gwa8NH8oNOw1fWHy6QOCB7x?=
 =?us-ascii?Q?3r/l6GLbA7Snyigje42B5A0Kbg4cXWVggc+VxfBfuZNrvmVVK2Br/NkBWo6K?=
 =?us-ascii?Q?Ye1fNZERqB3hzdLelDT/f5gp7WBclaHSKG7cSo4Mmd3o+lVobbTr0WlW+G0Z?=
 =?us-ascii?Q?m1X/5NmwHup4hjG3OF+VN+RmZROkid+TsxP6CIB3YPuDEvztMD2A22uJsrR7?=
 =?us-ascii?Q?+lDqkRBgolZ2SndYWDxwOF//EeG0w1b7dnSKmK4/fL6LWr2TSZ+IdELga4RQ?=
 =?us-ascii?Q?vUfDXhsVSGV37effMW7kRVTUAznQPjOzBYoU+XDpPMmYDNeh/l48ZvZn/OrT?=
 =?us-ascii?Q?ObrIIb/ZvdZadptTWEkX8UQDbiK/avNKKNkZuqrLsKpxVWYavXbP/WyZ2/m2?=
 =?us-ascii?Q?tHrIVsDpHSY8t3VeyIFf1SQh0vnsiyQD/FqISAHwkiTrvnm/OYJ5Np5lLCTP?=
 =?us-ascii?Q?p8uWOLeIJY8ms5932325oN+MDBoxnPkLjsOj7vEKPYjvXNgS2yz3Tz13O6Y8?=
 =?us-ascii?Q?+gTXnsVyERn//1Dd8nC3LfNIk3ePJ+Z3iA4sQywipicXymUUNPmhFjv5z2Gz?=
 =?us-ascii?Q?AK8AoB/JIyonHlbi7dla6UKw4PoQuJE64or8yry6w0hBSdV5UgFlVNnDpk+3?=
 =?us-ascii?Q?vCseHr6VUi3t/zXXUtBwz+gYT5Dosfd9+o/pwg3E2L3sKsqikkZhoNwD49q+?=
 =?us-ascii?Q?aqRMAco+MiiGy6rv3g7JbZ64LNX02vsrX3ojomr8INLrKnt6HVv+yv+fCOc5?=
 =?us-ascii?Q?mXfFii4beuXgafoOCN3g5SSvDmKguZVe32vZ4lq/MaIVwLyr7ctAQ1CjzeCb?=
 =?us-ascii?Q?lpkj/Ox+23YKkKkKwTrs1LQaG11sJFQmIE9Vmz2QQYRNQltrt8qLWCAEGddQ?=
 =?us-ascii?Q?X7uExCAda0oospjHVH33/uyh+7r8J6nR+VTZptiuZfZ/X8GNGONsQkJbUfMP?=
 =?us-ascii?Q?bFyKWXZLSTd2g3k/uta00kOhLkrN1wQx/vthmyl0IuXOiWAY1+UwIVVm4TMZ?=
 =?us-ascii?Q?+4oVcqaWP+0Cm+JdpL7PNnPdhfdSXWLAG74853TY3/4etESCl8ZRjjQnz53X?=
 =?us-ascii?Q?tjg3vjjxkZE9ju+LstCq4BAvxZVXa6sxIUST2Ec3AFZgjdr9Q/oXXaN6XACX?=
 =?us-ascii?Q?g8m2GOSm2H2ki60hxWGQH44+ZXSW2TmP6xvngIWLtGaJtsUX0Ba0VTg/ZQJD?=
 =?us-ascii?Q?WnyQNWjgIiiRfNJxPhJQy1/r+jKKYLVp5lLOnZRECqeVgTdmVzUV1e03QP57?=
 =?us-ascii?Q?PHH0Cwklp1PA95+k9pamDQn0AVs8EylPDdl9Z1x5M5xmM5yjIZP3/KAWGVmL?=
 =?us-ascii?Q?fpS+TxNWPoY2KVUYBkEmENgNPNLkNyryjaHuI+uQeoE6Ca4kQsENQNPxjTHg?=
 =?us-ascii?Q?8hRwu15aAGpnt+TNDSBtAGtauvo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XmuCgk/DymNmtWw5t8l/kgi1yw9TVtfzQhy8R4d7/eUYjsYFN3K2/b+ot4wBf/veSvjcqAnN5+RDB5dT5mKqCd/PUDfSJzjKvAA8tKfQwjcRC4itL/EYBrhZe0pzawNqMtDVnhsD9Xn88DGVCmRdR4pg0h7t4VcdQ0wkFqcUsipHxmp0Ey3HSM9+Jgpf4HnU2dod2hu+2s2eLh44VcyNDG29aoBm+JrfY91ku5Foiv0w+TiK0pCsUDaowb1wgrcbCfQ+Va0hyM01HVEQ0HvQukaShcp3aThbxnzwuMaLt/ktbbRbbxj8vD6746/hYhH3ot87qLdMkryrCcA1C6GJwXkBMIEvvFNYUYQNg57jOoGAvfJulLQiaMYuoAIhJ97NW9TVNgMu48XBtc26HxuRu+vGYworXcbmXImyL/DPtBT6wpuxHLOv8DrhLxrpWeUl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:53:56.2125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7f3d2d-749b-4502-c6ed-08de62cf7916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

Introduce CXL Port protocol error handling callbacks to unify detection,
logging, and recovery across CXL Ports and Endpoints, including RCH
downstream ports. Establish a consistent flow for correctable and
uncorrectable CXL protocol errors.

Provide the solution by adding cxl_port_cor_error_detected() and
cxl_port_error_detected() to handle correctable and uncorrectable handling
through CXL RAS helpers, coordinating uncorrectable recovery in
cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
to preserve fatal cachemem behavior. Gate endpoint handling on the endpoint
driver being bound to avoid processing errors on disabled devices.

Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
for Upstream Ports/Endpoints.

Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
cxl_core to clear PCIe/AER state in these flows.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang dave.jiang@intel.com

---

Changes in v14->v15:
- Update commit message and title. Added Bjorn's ack.
- Move CE and UCE handling logic here

Changes in v13->v14:
- Add Dave Jiang's review-by
- Update commit message & headline (Bjorn)
- Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
  one line (Jonathan)
- Remove cxl_walk_port() (Dan)
- Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
  sufficient (Dan)
- Remove device_lock_if()
- Combined CE and UCE here (Terry)

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/ras.c | 134 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c      |   1 +
 drivers/pci/pci.h      |   2 -
 drivers/pci/pcie/aer.c |   1 +
 include/linux/aer.h    |   2 +
 include/linux/pci.h    |   2 +
 6 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index a6c0bc6d7203..0216dafa6118 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -218,6 +218,68 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
 	return NULL;
 }
 
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+	{
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	{
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port->regs.ras;
+	}
+	}
+	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+static pci_ers_result_t cxl_port_error_detected(struct device *dev);
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	pci_ers_result_t status;
+
+	if (!port) {
+		pci_err(pdev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	status = cxl_port_error_detected(&pdev->dev);
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	/*
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
+	 */
+	if (pcie_aer_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -288,6 +350,60 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	return true;
 }
 
+static void cxl_port_cor_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		guard(device)(&cxlmd->dev);
+
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		cxl_handle_cor_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
+	} else {
+		cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
+	}
+}
+
+static pci_ers_result_t cxl_port_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		guard(device)(&cxlmd->dev);
+
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return PCI_ERS_RESULT_NONE;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		return cxl_handle_ras(dev, cxlds->serial, cxl_get_ras_base(dev));
+	} else {
+		return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
+	}
+}
+
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
@@ -363,6 +479,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 {
+	struct pci_dev *pdev = err_info->pdev;
+
+	if (err_info->severity == AER_CORRECTABLE) {
+
+		if (!pcie_aer_is_native(pdev))
+			return;
+
+		if (pdev->aer_cap)
+			pci_clear_and_set_config_dword(pdev,
+						       pdev->aer_cap + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_port_cor_error_detected(&pdev->dev);
+
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
 }
 
 static void cxl_proto_err_work_fn(struct work_struct *work)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..b7bfefdaf990 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_GPL(pcie_clear_device_status);
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8ccb3ba61e11..d81c4170f595 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -229,7 +229,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
-void pcie_clear_device_status(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
@@ -1198,7 +1197,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7af10a74da34..4fc9de4c78f8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f351e41dd979..c1aef7859d0a 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -65,6 +65,7 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -72,6 +73,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee05d5925b13..1ef4743bf151 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1921,8 +1921,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
+void pcie_clear_device_status(struct pci_dev *dev);
 #else
 static inline bool pci_aer_available(void) { return false; }
+static inline void pcie_clear_device_status(struct pci_dev *dev) { }
 #endif
 
 bool pci_ats_disabled(void);
-- 
2.34.1

