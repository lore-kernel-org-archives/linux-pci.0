Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EDD45FFBE;
	Wed, 23 Sep 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148259; cv=fail; b=dprnfVsGVytuYB0pwJGnV7b2kD6H2YwdAXGY35+YkLWb960zioB+tABm5KVELV+FVnWdJvtndMaIYB6Xv96c/NwURZ72d4yzXoLnWhCBKvWiTqe97ahyppbmGfAvMKxfGHQcMgkwahvpO0pOP3VWCZa/Pm6lDLuglkH2ylIbcXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148259; c=relaxed/simple;
	bh=RdYbeivPHMC7ww8GSQh7MCdSTQjCUd+VJuxTQb5uvkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKgPfHciL5nP7NAE1Gm75/mycKT0umMv6TrLTPz7F9YOfGBsvUrGZf39C9jWJUT3y1LyK9pZvoLm/+goiviLFM9Zjy2IAoX7zs5XS455U+jb+YBBmqMX2IMSBQYKHTUfdrVkWiIekVrxud+72oVHFqrnX6D1D11PZdofgcr0Prk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RSxVQvTN; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSxVQvTN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZoKJX/UWrlfmikpsuqd0j68zw8hw3aOuLRjnZSEq/gS78qLRr+RxF7KMHAfxReZFL2d+un19CwrkhG8PZCh6U47THSbAN6ez4G6+EaSCIDjKjSl/ZuVt5AN8Mx8FtnTZvZ7j5rS1FMaw+HByr4O3ncee3r3fks3HD6a5j/BtuaW2NPIspY7XF2YcKE6Ed0dVEZDWI5aaiL/aCuu2hDW8CQOas6ota+VqvQFTRiBfEYD4XsEYnlph/r4mo74BYGkB1Q4/zExCwVvAIT1+Rxxkm6O9j+mAAUlUgcVsxIKrJTHAarTtZoWBYckeRtdwLW0YjBIMZEXqACqv0cWGnGPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATWRAP8y90NapAhdAJPN7zzO2pmrDrRZmXkepWRpb3M=;
 b=j6sloavM5tLkiokyzSNOKAv7iiODWnBl04m29hHwhFFQus91uXOhLng4teGJWQ0rPXSVA9j6RljA2ZLQ/QHOcczb8mCFwtty+wZSWaAX1jf85wRIPBUrCxUps65E3bZFuEsp7Ie8qPtW7kDuxUtEpDgR50JSoU0CbHXVnZu23On9NmDWtFe1xQpz8Kqp9Qn2GvPs6nAp381V1INUe0HURKTMD6F16MYDVwSkqAqxLZ165smRyBf1NZTX1ILpbmtW3G7GQas7O1pOwMvPxysAolr3U5RWblDAo+9OdxwQYdjP7mb0JfkQedC+pcjfBMzD9E9T4pt9SRFya5NsFWQl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATWRAP8y90NapAhdAJPN7zzO2pmrDrRZmXkepWRpb3M=;
 b=RSxVQvTNrjaCfULRbAMYVac02zEpkHR5qsZPojD209fkI9mGWUr9Gc+e9BiaKF/p73Vo7M29CMb5oL6s7K6h25JOm41nB7/4PbAGXW6DQ76Q8cyqtB18Btl1mRB+DFP1Df/c+/y6zFnDJSAI5v0zbmJ3xEL53LYlUEEzy2ySVMFS1zqW26mmm4IfE2GR9VpeUTTkG/pifQK8sUffMyTglaFiP50Meq51b4bBUS98ttbNPoRdtSBROoaiLD+i28EaqnugZIfnUMMwy2QSKtdg3la7VYd3LEwgtZpjJV1yKVxCslvOoD4QFsXJjJ8ikSWxeqptULI7AwL4T6nBAOxEbQ==
Received: from BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36)
 by DS2PR12MB101350.namprd12.prod.outlook.com (2603:10b6:8:70c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:24:10 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3) by BY5PR04CA0026.outlook.office365.com
 (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:24:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:57 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:52 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>, Marco Crivellari <marco.crivellari@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 11/11] PCI: endpoint: test: Do not relocate fixed MSI-X tables
Date: Wed, 23 Sep 2026 12:52:37 +0530
Message-ID: <20260923072237.1139013-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS2PR12MB101350:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce0e19c-c19a-4b0d-dd2d-08df1943a946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|23010399003|56012099006|6133799003|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DYFe/jyBVw6psfhqq4Il2XDWbptaY6bv9iRPGhGkdZW/sYMU3SVhqftMrm1+uo9HI1IXUh007aFjKTYW0Elvxy59W6BByFsXkzfqkL3ZuxlHz2QIZTutNOzwHrvl67TYsP7WGhlI3drGmiuBbK7Z2rMF14MgzwcbEESRYr7JkoKhMd1hKj06tsep+GC0GB2NYwk91mNYJX7VBVwtuV11lCkfZNEvRpbdpwsZc6bcmY88qQ/5K1A6L39WohKVY3vqbe5R/pMEd/dd3stH39F1/NusAv25JXRzzZ96ZhDzh1iykd7TgzwFducqNCITD+3OEqD6SleSNmE93BobXiqhzVtjg2KY8Nc98UIWHQhfd41i5rX6aRioK9juurF89WGcsUy+lz/pu0Gmz0fkIdTcg1oTM7OpsDlDoUva+x4GA53ee4ykx7IJMdg9rkd/ukBtc2imb1SFmSKvud5OwbccMMdadrgaFWzY4tlCvHSuATSpqCVAAkxUqSaXkj7ZI2Lc3rI77/qRNQHXawWDnL/aRntk3yFIeRzl95Ms20Lls4T0ORrXZGU1tFIpf0v/50xZIIeqi+G+xtVkPBrzmdyVM5xT7bS98gJXdS3KG5fj+pj8JCWrhTkCUgi5+k0/zr0MNN+2G6iTvowVoJI8wQ2yljIQ7K2Gv03EMrNAtY7riZSeCOJhCBf1nj4oSehbDsRLctZWSZ2k/lvaHV21b1DjAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(6133799003)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ae73epnmYCKLjdrp3LKPwA/ULnnS/FK0XOTRWbJbP6fKJd2mRpj3F7brrePSzcDSf4rqHlPRwcDaAIv8PPi62+PKo8kHq1he8CE+XGhGw7bFALIQ03fCioHbDP33lu1D5xHD0lne3bLtVpoEylZM3rRTp+I5WWiXsJH/o6UIdXCVOl2SjAMibkrH9G1l7iNEw0h8wsnBXEd/p2YD7fK2Sw8RjGTYEoYdFZx26VjvZdfJKwlcKmzpD821WUxSSDrbssfc7AutMKKgCRywbJHbjIiLhOBNKasgLssD3IjR6Gb7R0rvL146naOgHfCuWmaL2/SFyCJ2H2AbygmLIhzoRrdHLp698BCLkbtkBEa6bLBa12aJWIdTZ3Aea0U2Ndh5tzJ4Sp5CcHKzxOOFj3scUraH4sqsTjaI6oX/FhoYcLd/YW5Kop+3DwenFGheuVSR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:24:10.3134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce0e19c-c19a-4b0d-dd2d-08df1943a946
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB101350

Some endpoint controllers expose MSI-X table/PBA storage at fixed,
hardware-owned BARs. Such BARs are described to endpoint functions as
BAR_RESERVED with PCI_EPC_BAR_RSVD_MSIX_TBL_RAM, so the function driver
must not reprogram the MSI-X Table/PBA capability to point into ordinary
function BAR memory.

pci_epf_test always allocates MSI-X storage after its test registers and
calls pci_epc_set_msix(). On controllers with fixed MSI-X storage, this
overwrites the controller-defined MSI-X layout. For example, the generic
DesignWare path derives the PBA offset from the number of vectors, which
can make the host program the wrong MSI-X storage and prevent MSI-X
delivery.

Detect fixed MSI-X table BARs and leave the controller-owned MSI-X
capability layout unchanged. Keep allocating and programming MSI-X
storage in the test BAR only for controllers that do not advertise fixed
MSI-X table storage.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c0..82d4714e998c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -83,6 +83,7 @@ struct pci_epf_test {
 	struct config_group	group;
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
+	bool			msix_table_fixed;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
@@ -98,6 +99,26 @@ struct pci_epf_test {
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
+static bool pci_epf_test_msix_table_fixed(const struct pci_epc_features *features)
+{
+	enum pci_barno bar;
+	int i;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		const struct pci_epc_bar_desc *desc = &features->bar[bar];
+
+		if (desc->type != BAR_RESERVED)
+			continue;
+
+		for (i = 0; i < desc->nr_rsvd_regions; i++) {
+			if (desc->rsvd_regions[i].type == PCI_EPC_BAR_RSVD_MSIX_TBL_RAM)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 struct pci_epf_test_reg {
 	__le32 magic;
 	__le32 command;
@@ -1214,7 +1235,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 		}
 	}
 
-	if (epc_features->msix_capable) {
+	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
 				       epf->msix_interrupts,
 				       epf_test->test_reg_bar,
@@ -1282,7 +1303,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
-	if (epc_features->msix_capable) {
+	epf_test->msix_table_fixed = pci_epf_test_msix_table_fixed(epc_features);
+
+	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
 		epf_test->msix_table_offset = test_reg_bar_size;
 		/* Align to QWORD or 8 Bytes */
-- 
2.34.1

