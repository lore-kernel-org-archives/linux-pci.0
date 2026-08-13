Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810543BFE2D;
	Thu, 13 Aug 2026 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613878; cv=fail; b=mn9dWAN7TfFo4fLVC1v+ZmSPbaA11Sut+UPGlD6z6Rbwac+SUF46JyyJxNIj2YLcDDmyyb+T5qj4jbydvVm+A9xPE8oIMLG0/3OxVN2nboE7nAnLh4COlPWf4hSmBR1W+2KxHf70NAqddFuc4Q0bwW9wdo7KlrFfPuEt+8n0Tgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613878; c=relaxed/simple;
	bh=kSAMVFlTb8usC3i/L6YdHgYNpftvMESOexe+9y0iC5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jj6+mtsNdKAxz+1uYKacNKQoscr8QaPOrG/B42bLn81V6wM8JxlgKpl3Bv2Jxi4r1ZtgVGS5U/y0Pdc1/SB5rR2yQGecm43CHuYS0M4bjz/B/oX2oQWllzpFGb8BQUekNmiyuzQvBOtPa0OL0/jVGeyEnaMrFQrstQ08pop4ZdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTDqBLxo; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTDqBLxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTCO9sy/Zz/3OKp8gsLzBVGuM7KwoW7e4bWhvHtPVj+LG0M953myfDkEfTma1iD8lotEj/X+nfmR7/hkpVMI3sUD8UwoTfXk0OlZJg1DpGzifEJ/Uq9qEa92sYa+v8jrn6p8fbtQZorQD/da51n3Plc0sUBzemXjDgvvTZGxOPAIZ3EBt8D5a1/lb1s7NtLGXSJ+47H/xH65kxhDMCq0C9gYsJ9i1vnoNZasXtl7HQHYoS32iH0tCDvBN1UCFqF5z/maRe23PhqnWiqKYb2an8D4+92LAVPw0V6GAyD/au2hZ6IjS3j7KIcC+VC/MRpWA+7q/AcG+spzMity93KGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y862TkRoEB603HJjU2lH3ERUHtcLYK0VemViDQk3dYk=;
 b=wko+ZVc6THOZHBTTVgObTiIo+XGNx5XiYJSyeTaSvd35N+I+7cXVTKHmfMWIbSu0hNERcKXCflwwZFk2ciM88nWSvJigkTzacQS/mk5s6N0IXcIcsuV1r2HW4dvW7PV6zX1mqflrx24JCsvQiaI8WAKVCY/ju8l9MHZtxKQWafEX9AflPBC8dNs8oBQP89MELlwkTiAhHuuYERC5hJ7AZO50kvjQrJzG5JcAfKWpR38Ksgqe0aCXGIHUBpaFalIrwmdev8RHdPZlzNhhgqdOfiQdAgJN9tbNIOKGqtk4Hpq6TfJBQGVhGo5KqbwQ+RvCZsptApttZwtOzns542Fj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y862TkRoEB603HJjU2lH3ERUHtcLYK0VemViDQk3dYk=;
 b=NTDqBLxoj3YpcT8FNRyW55HHCBYWmK75kW7ptrCaZ8LulZ5sYrHo8eU0OBe7kfAV1XjIVQIj61GTQEE8A6To45CdH3tupvK8rOb1dbAGCI6aBmalcJI1MZitjDXbBWfOIIi3pPL/O7DEYkzP2Jaim2CEYo1xJU6iio9OSIdf46aw1hYvs7Vu2H7JZd5D+LbD8vAFUPxTAJLqKa2jcrJR+xQFe6l3z3Gy3ykNSTsmhv2gvbjjVp/yPV4eM6lJlyWj6/6LbPnz8QhKT+c7iAoQmIKJ+xfIkqmRCcmOLfK/4Yrn+3+nlWYuAmvzEJA8hKvzpo+xKjwOYlCOgsub1N6DmA==
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 09:37:40 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::a3) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:37:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:37:21 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:11 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 01/27] cxl: Fix resource.c include path and export cxl_restore_hdm_after_pci_reset
Date: Thu, 13 Aug 2026 15:06:05 +0530
Message-ID: <20260813093631.2288172-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 5356a540-b88e-4e47-c11f-08def91e8497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|11063799006|56012099006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	KS48Ie64l4db90pL2CsysdygmOAjbgCgrkxvlfqJlI2hgCSeRClzlFjAwNy85H8MiA373LvcU2pSFTfAW/Kg6LzlbrHyh4WUc7GATdZ1WxxCFdW89RDg95ySancpb2g4n9vKeebiCdcCIQus+lYyBzLJvEi/XlGjqgVRVrlKYE9fs0WNam3XmuehXHOxeVDJhVsrt9A3cK+jlNoAJ+Rt+n7npJDZyJy7kNHrlDL2G1HsFe/3HQu6ch4bOKMzuSp218G5obIn3Q7drRfufmJuH3F4t9kwRn9BGsP0i1B2QLjpS8qqXFOmWZP52MbU+VE3v0aztnTPY+CxmJB27nxTdCB8rvgxg5XXjXitHpwHicVlRWXbm5tSXQgub4Q5zfwr8T5ZIa5F2aRX1kiCwwE4gDGtxJwdmYu7QIDRzxVaWsf5M/INjST7eSfW+ReRGtMETKA4P0um8NzNMUp0buAyQD1Kiq5zoSE9oKCDW11EW8BM1OMMrEiIhFn+kC6RsyB99oWmrWjSJQX23D9hJPIAqrbov6KjvkHhiv90nyHyk1I0uoD0BQSuozWxv6fOzF3nkz4Gcdp5hQCqO3dZSGwPvdPiOvZtTjcx9UExGDSHUTLBZqvp2tFL/F9n0mdJK/7kvhHnHTaLV7dvpLbnMX6jNFZByNJx8GvB1Ka0wq6wTKcHwjImV49wAPQMvHbC+vtOHa75P3iQAvU6Bwq74CEqaiiI1dklFjyFerZenhZ4YGBvKh6OYotVNFl/Ln6sOvKP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BklbyGrOmMYdyze2shAlSjYhXE8OB/xAzsQr5qG9c0pe+vzVmn7epOXT5SKx4aOhzckBz5OrBRIeuPv7rFDnpJFA4AfNUf8E2j1WGCnzIseK7DYLXss4dRhR2JC0DuqVlvcU8GWZYQB/nd1Q3ym6V8O1xpJxCB9hotOSjlbf3eIEQi4Z2ZfI4F7FwZUAbMVKCflq4K47hR4vcRHAh603G9EvFXxcGWeo3lKseJxM13sI0zSgPvr5MRm8VBcsd1yud3HJKtuhyt6tyzBDmHU3Rj47TBupWBAjJBgUZ6dplR+ejFPzjMdE2dOlmB18CXP4LqF/VUFE0PeBKN9zhR2Pa8Yu/BwAe21yRz9Yz7RtW3WlymxyiVgNaMVBrI/J39/eTuB1dnRk7piaA07gTUF0d0I4wZaQ2FgXpi6ZV/Xu/lVWff5+lIlPWREfvSRjQA1N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:37:40.0073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5356a540-b88e-4e47-c11f-08def91e8497
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

From: Manish Honap <mhonap@nvidia.com>

The vfio-cxl Type-2 driver restores the endpoint HDM decoder after a
D3hot->D0 soft reset by calling cxl_restore_hdm_after_pci_reset(), so
export it to the CXL namespace. While here, correct the resource.c
include of the CXL PCI definitions from <cxlpci.h> to <cxl/pci.h>.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index daa5e7fa2509..492ffe8e3576 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
-#include <cxlpci.h>
+#include <cxl/pci.h>
 
 #include "cxl.h"
 #include "core.h"
@@ -850,6 +850,7 @@ int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
 
 	return cxl_reset_save_restored_state(pdev, command);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_restore_hdm_after_pci_reset, "CXL");
 
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
-- 
2.25.1

