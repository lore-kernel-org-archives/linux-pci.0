Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B83CC9E6;
	Tue, 24 Mar 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339796; cv=fail; b=CRigsh5ZY2cBmawIaLVpqmD0AlrKB8w0rJHaKngpzV/7EqLDotxLl0o3lq6dppqDi0j3D4teaj/REFnQlb8plRmuKNnlFQK2wSx+WfJKw3UcD2+mN7C9zYIz/9vlyLo5Co81buWU8TvLyJBkLWQ45zQYv/UVxf7eN5caCT2Y14g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339796; c=relaxed/simple;
	bh=JJrNLxcUAJIDgLb+ZJWe4BZ8zLy1wbMjsNy6g3WAt6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3x4uOYddq2xIpTcmGpQTWtSEXUq+cxKwTcuilCRTXJ8KhP/H5CYteiHmhFxUnvfZjCLUxElX1mu2lC6YEKwAatSy+l0BMuuOcRqxUSsmMEqrE6CBRKJH+rkm3vMhQ9PAasBlKEwjuUqpbAgE0r5aTWP1hHEap+QFPKTPr6av90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W561UuiU; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W561UuiU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRWkD53NF8gaB9Ewp410BFBQ3bkPJmOdceUBpKy/UTNiqSN0PieM2N9GR8P2OjYYyjMHt1eV3bqnLhCe8a6kX7X7+o0Yrv6yaKV0m7CKmv456ww+5UM48npRubud3KLF2KPdaHPzwZEdck/ekCbkSgD9LwDYub+PyyAJgXRxk8nuHpiw3Wb7yk++E5FJs5ZbZKGnGhktSW04Pj5h6YQfXs6azy3HV/gMgLUzXW1ABE2r4+AfB/OuXEVyL/vlKULScUROZAWYu4aBED4z64Mhvnso2NHOJbdpreDL5R9N216N4dHdVSXR0tzJRiO3bAPvKtq5zi6NHKmWWl2BUonVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpx+V4CW/biikRSL+cxFiwvZEDfQbjPQN3IQRfRH4L0=;
 b=g1quZ7i6SRp5HYKzLy2fy8zvRWM2ZiKTnduB9Nk5g3fht347wRDdNB3g79FkhG5OTLsJh0eEHVOnEsdFP2Hjc6xnv+Jv6ZqFCdtXqP44V65KalIICdbz5HnUhPW7oBocNF/p/3bFizaJDsWdPiD8oUTTqdfnqS3PsUIamFjvinAHV8WxKC6df1+EmGCNiSMTJvnvpvmolp1BWzDpebaRR3mX5mLKGHyzuiR9HuMll8v9Jjq3z4+rGzPEh1m2t09UOjZoH6c4ljPuktaeQfrL5uOwQCMeJ7U+JUlpPD7AOLFIJJsVTNkLQVINPhdqEv0+7dQsVRrSbouh9DhfQb/WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpx+V4CW/biikRSL+cxFiwvZEDfQbjPQN3IQRfRH4L0=;
 b=W561UuiUxwlvCOxpImEMEe6lG/oz10fsMQ66gCqB5PUd5IrsrXGmueyz+qMVdgyy3IouCPLKhKNWWlcn5u+6WgcUfmqN+ZuBX2JEd15wtds9muYt3prjMd8gGvcrRuAIpdkwHyJVvkk+xXQf2E9vOhve26wLXzL+8/P/H4++JCcnpsvV++4+0lC9bPrgdzy8BEr5BY5RkqcaBEoQYVALTUFJRTmvcIgs1u7LhdM7WYK2CKvPF8bvk3keYIMk2xgoswlumB8/dUJBjAUFq6Mxr/twrWDD7CCxBGMG9E7R3xIveaC4dWG6eKfGjT5x1T77oXV0YCBGNpptju7cNVl5zg==
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:09:44 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::9a) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:09:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:09:26 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:09:19 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v3 1/4] PCI: endpoint: Add reserved region type for MSI-X Table and PBA
Date: Tue, 24 Mar 2026 13:38:54 +0530
Message-ID: <20260324080857.916263-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324080857.916263-1-mmaddireddy@nvidia.com>
References: <20260324080857.916263-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad2fae0-b13c-42da-2194-08de897cb420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IvfI+P4tkGkHfjw2Sa7ANrTdOPpXFPWCqssWiwcnAiUhueLIX8xcvIfLLhPztdvJyuK6Yt5Z66hE7iUpWGvA7x3zCurYGaBi6hdjil3pDSi63xXYDiZi561e8VaZ/0IEplPFBYjmepevAwnqEzxLolPM+ab/10ztojVUO/uYTxWiUS9rBex+p6MxpjTS27EfluafaM9UNBk8oYCJx3lqZTs/G9HLf8VIL+IWl8gSNO7Td/j2bp54Ig6opnN2KrD/ZUZVFvKtz6kB+2LmabLcLub3sBcF2JEc+FaoJ9y2xvb9qsVp38CwbaJBP3+C8yyLStIx/4nEeJJxVNwmlHPb9/sq2sHSseliu8ZrYqpBlBNg8Hz40RXbDYcjPbReOXirlz0zaQT9az4HNJi90T0tcPdZqhxsGCW7NIRSIG+/qaBr2JB8Vhpxa+TPBhgOmurfFfV3lAlXLIutTYzdyl+gxqT2wTALT3iSOp75RqLLrBjfTB0gB7wayKoWZk1GGNfpz/vG+Lq6R+DH/TysoHWrFGqdI7NY6yVSWHPdVMRjBlZj1D0H0t0ZUdLe5DYNyoQMS4RAzRx9AlgxtaLwyBt4zSHB7FNtDIkJH1/BiSiZaH7Btegf6TmajOkINffixzaJFILCrsimNT5P6aTw6TjfBdgoP9TaLB43SjdpF/BxTo/jpDpkuwG3oVuwjtPED8oRMtGkpfdTDXYY6ENnJZbS5YblcmjN6ffWqcwq3Zh39RNLse8VDrniTy/a1iXxOgDUUaXJKoMmB01mpDo1jLG5rAb9sJ3a9ZrtgAiAQwC4q+esdVRhTvkIxVfuvEx7BXVf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CCt2j2PeXqS6ICknpYxxD0sKxelhvqvSofFXxJyDf9fUVmgFJyAuelgsYc7oHv7U9Gh1IZQHYBI6jVWQA2Nz+WM/plvAWxUCmxMQRhLnZs9TNuaPfPePWWdE5Ll4Y3WthO7qW0LAJRDdhcFhbUJ5N6o82jYsMrjebSSbyV6DUEMrlycUXMcs8LLUXM6/eTHkQRD6jlZvZ46qC+GyUdmx3+9djQ9p1tQYGJOUX86KMaMgf6zNdN5yFX9Sqsk2ZxQSQ7Y67Fzk52yUaNPDzcKWWAH8iyESCgzVNbzz5x4qhfqNR+eLzdPeqM8Whxp30+V9S0IF3kcuMGwd4MK7eW9NWPXeuL5OlIq+oQrDH7KS7O25gX7B/VUk/6yvzVvkK+7OsqauX7OGjfr76fYyEEwxO/MswxQNUfxbDEgARLqqzL4Pui2uWzmjulqCgbUhRnmt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:09:42.3106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad2fae0-b13c-42da-2194-08de897cb420
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713

Add PCI_EPC_BAR_RSVD_MSIX_TBL_RAM and PCI_EPC_BAR_RSVD_MSIX_PBA_RAM to
enum pci_epc_bar_rsvd_region_type so that Endpoint controllers can
describe hardware-owned MSI-X Table and PBA (Pending Bit Array) regions
behind a BAR_RESERVED BAR.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
v3: Change 'PBA structures' to 'PBA structure'
v2: Split MSI-X pci_epc_bar_rsvd_region_type for both MSI-X table and PBA

 include/linux/pci-epc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 334c2b7578d0..1eca1264815b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -211,6 +211,8 @@ enum pci_epc_bar_type {
 /**
  * enum pci_epc_bar_rsvd_region_type - type of a fixed subregion behind a BAR
  * @PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO: Integrated DMA controller MMIO window
+ * @PCI_EPC_BAR_RSVD_MSIX_TBL_RAM: MSI-X table structure
+ * @PCI_EPC_BAR_RSVD_MSIX_PBA_RAM: MSI-X PBA structure
  *
  * BARs marked BAR_RESERVED are owned by the SoC/EPC hardware and must not be
  * reprogrammed by EPF drivers. Some of them still expose fixed subregions that
@@ -218,6 +220,8 @@ enum pci_epc_bar_type {
  */
 enum pci_epc_bar_rsvd_region_type {
 	PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO = 0,
+	PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+	PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
 };
 
 /**
-- 
2.34.1

