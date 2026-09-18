Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF4F68D4;
	Fri, 18 Sep 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743418; cv=fail; b=lUNm/z3jFAK6bIgwhiGHyvTkMki9JJNZp3PM4c++5V5SYHyAbITatPvuMMV4u8R5gut+mQvV9pCPA5dx1j2Y1eeJxJbPU7HZ2hKiKb2ACAXCsQWogz981UBfOQZTAktcatrMbhx4vVuvL2QvGc7/KiKI41WxTa/tvfiugpK1pN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743418; c=relaxed/simple;
	bh=h6ep5LuMhrJpaOwnEE1SqWGoB6qo3IVnm4JmU6/w6r8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWh9dq21R2X0xtleXhQd49sgsQBynTsjVHEzlGT0sydKGPPzXbtNdiMk+eV1qrkTMLmw7EUB0iLgjOpex3NJMZgG79v1q0UY8N56dsBDVQjmAjtsZFjr+nlsC2A9iumTMrpV+/2jmEE2u42DmeBgj4EoTUnTYzOpnZiYox5K4TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MCmaDTg4; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MCmaDTg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWX2DopFaDFvNaEpWczBurWpplwDjyS9rbh1ij4vfhjpCrOxMkM0SQmi+j0sw7k5329DrLZ+nM+eyPUOObWTOKNtn9/qKAaDPkOq+GL4kBpjC5hLvqkq/EgaQ6MnmGjL4pfWh+JFJOSRqR5BFd4Ui5mrVyTe8ZFKpp0Sou2pqJJWoHAlHAtxSU9FoR4gxi3OYXnCqxPfq6/wySIJwQNaWe/tzma6ARMTfFUJx+1D7RQzozp8NnsCYymqUAtTCMvjz4UBOxBNGOWoxIBsseZWDxdugNjICO7kycJnLSceg69hpLBC2KCuiaqlOd9XbWRkRIynibMznNErU91XQZJC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KfX8o6ry8QSrHj60hG6Mu6+Z5OfIPYZm57Rd7/gAJk=;
 b=pE3u75NKpE9WytxLG36kXerG/0ImO2hengp58fvjwPS9x5ULIyIHu8A7dtIJLA1nlw8eyh2cpjIBVwKDLY3yzD4oIO/ULIQ0Kzo0+7j90xXUQ0VmxdI7JVuYxZzSBH14pMsZlZ0vR6lz9ch1VfF7bFM/CcFw7uasDpelEmeI34L79vYGdmSAaFWXfxi8l0iurvm0aaDQqDQXzDl4vjnagbByiSuVBFIt2Sax/0FXdY3/7JN6XiZZRNt6310IBccMQHDwVw9u2071WXSlFOB1pvf9erafNrPkZ3gglvOMT5MVZ7uk3V01mx8X/B2UMME6QyWjSnHUHGvIDvMWs60YpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KfX8o6ry8QSrHj60hG6Mu6+Z5OfIPYZm57Rd7/gAJk=;
 b=MCmaDTg4uA8lAiV+rhoINkJFtZCLBzM1tNldCuioKW9wXm+gOMuXum0My17+GrFXBWnzMuMitpDH9CtkZBgWGYWODjLr/ee1ZYP2nW1mQxH2HEqnFos29xGItp8YqCNvuv28ZBTiKS0wpFVDeWaZmbPuGW4mNDZN/d3TGcrhqvw=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:53 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::6a) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
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
 2026 09:56:51 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 06/10] PCI/portdrv: Group PCI Exp Cap services into a single mask
Date: Fri, 18 Sep 2026 09:56:14 -0500
Message-ID: <20260918145619.3016889-7-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0d1c9a-6ad5-4f67-0238-08df15951389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6W6QX0WY0dfbQv3WY8N0h0LLbAOsCb/2d2MpNvlPn8D5VOzRQacoOjeRVXZzjhMGSF9RrRBYZOX9hMUakADK1fMXz+0Cpu7bTu4JqWMa5lDdSRhCrOXvt+aHvIOUsXJ/oUxbzypKom+d6JcI2iONWslrzWqeCzxHEPyVGur5J6hkbE9WskmStl5jX2G++9i5YCJf6EBN1zEbGZA9QBniJAascgIiUMrZnfq8yaUCk1VjI8b9vVr2k24BhZrPO29hAGKJ8N5EUiOD+sq6X8oEwr67hdwXrLDQpxmtEuVbZ0hx90gpEZwaaBJx8DYxA8iKmS742HsvOcyjdeK4ndrRIc5sxniIlRoWKCw7XRHCktARoShkhZpVxXb2Hdz8Nqism0qpQFKyL/pp/cvu0LqOA7SDTfRMT9QkWnyM3jVBiyCX9G1F0Qp6zXNq+mZPmSEbaKQQbp4+CQF/HAUMKSqX3g3KFQG9BJVKhq6XSWU2wicXSW/xVF5F904RKJiwb1zmORmK7IT/Q5/OdNB131xM4qSC9LewEz4O2IK4DUoro92ruSRRMelqwN0FQasuw67WAvoFUiD1pjCniq1+bOEq8PnLVSNB7u2QU5iBO+jz8bFSkAf5+/bM1pwzMYukt/lZcakBz/ZSqqKjYgT8QNR9sSaZrf2HQNOuWrEQnTAFyQV4RjMq6Bp+8RiwuZ1gHlHdu1PZLrBynWYV1+K/Qd6E8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OMDxV4g9SDntZx/oOgNoBTNFQI6PzNYx6W6fsc/Z/aORyYaLuCv9NvKkfjhSWMZbk4EtX5bQkzQgBCaA+hhdVk+JzK4YUH8I9SJFOj50MElcR1Wc149oI9Yq26stHCnRRAuB//OBzFp0w5pJ8YrQ7yN6gE4OeO+XXN4EU2vDcU2U3TNz3YGT6GxgzlSEJuJqNMuUSeKanro2iGIspHEW9/BgjXEHv+z4H65LeBu6ynSJ9DwS39ixvZMZDKTDfLZi7k1YZgT6+OC+K+5Cu8H0FDc61eaNzYzuLiaeeB7vXiE94ylCdL3CZD/o0k5USPsiUTSR5u/FpNOKnYSY5azbrwTRjzDjJH/icDBKs/vQNmgV76cBcqAtwMk+KmWNfpj/qNdDcMNE35xgSyAiTvpmFgfHbZU1+oq6DU94HBqlXOXJfs+eYMYuGdHYfD8CTY3v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:53.1401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d1c9a-6ad5-4f67-0238-08df15951389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

PME, hotplug, and bandwidth notification are all services of the PCI
Express Capability and share a single MSI/MSI-X interrupt vector. The
set of these services is open-coded as a bitmask in more than one place.
That is repetitive and easy to get out of sync as services are added.

Define a single PCIE_PORT_SERVICES_EXPCAP mask beside the service bits
it groups, and use it in place of the open-coded expressions. Assign the
shared vector by iterating the mask rather than naming each service
again, so adding one is a single edit.

Iterating narrows which irqs[] entries get written. The open-coded
version filled the slot of every service in the group as soon as one of
them was in the mask. Those extra entries were never read, since
pcie_init_service_irqs() presets the array to -1 and
pcie_port_device_register() only reads the slot of a service it found.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/pci/pcie/portdrv.c | 16 ++++++++--------
 drivers/pci/pcie/portdrv.h |  5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a9cbfc1d2bc7..ca1b9dbb8b08 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -67,8 +67,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 	 * 7.8.2, 7.10.10, 7.31.2.
 	 */
 
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWCTRL)) {
+	if (mask & PCIE_PORT_SERVICES_EXPCAP) {
 		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
 		nvec = *pme + 1;
@@ -114,6 +113,8 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, nvec, pcie_irq;
 	u32 pme = 0, aer = 0, dpc = 0;
+	unsigned long expcap;
+	unsigned int i;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
@@ -148,13 +149,12 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
-	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
-		    PCIE_PORT_SERVICE_BWCTRL)) {
+	/* These services share the PCIe Capability Interrupt Message Number */
+	expcap = mask & PCIE_PORT_SERVICES_EXPCAP;
+	if (expcap) {
 		pcie_irq = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
-		irqs[PCIE_PORT_SERVICE_BWCTRL_SHIFT] = pcie_irq;
+		for_each_set_bit(i, &expcap, PCIE_PORT_DEVICE_MAXSERVICES)
+			irqs[i] = pcie_irq;
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c84..bf18ca415990 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -23,6 +23,11 @@
 #define PCIE_PORT_SERVICE_BWCTRL_SHIFT	4	/* Bandwidth Controller (notifications) */
 #define PCIE_PORT_SERVICE_BWCTRL	(1 << PCIE_PORT_SERVICE_BWCTRL_SHIFT)
 
+/* Services sharing the PCI Express Capability Interrupt Message Number */
+#define PCIE_PORT_SERVICES_EXPCAP	(PCIE_PORT_SERVICE_PME | \
+					 PCIE_PORT_SERVICE_HP | \
+					 PCIE_PORT_SERVICE_BWCTRL)
+
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
 extern bool pcie_ports_dpc_native;
-- 
2.43.0

