Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BB5304A7;
	Tue, 22 Sep 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066408; cv=fail; b=d4N1PfZM5iU4nUNZAK+NxdRNPCQj3jgp1/NSKOaXGmnhtVTHYhA7KzfvETLf2+FpslyjkFZpXlAgrrQyr1N4LpEslVf5jW+b7+iLVIrfx2wCf2lNs3YsgeQ4lk64r2/nL0EzwJBMTIWX9GMl7nNM7ZBg6ylf4p6SHbRJ0rJ5B+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066408; c=relaxed/simple;
	bh=S6Mqivfold/80O01p/1TXZauWZvxp5eRsu+xSwNOy8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Td0nRe6aUHvb0qRBomXhtEoUx3XJcY+JjoXL+BegwboX2ejBul0Eh8khJ58OrFP/2Zmwc0tCA/2Y2PC41X9BV9MZHBO6I4DelXOhFMHSppqJd4ou4UpFLm43RPXvOo5K351boat0S+8790tnBCSF4KO/bus+jAC7YvF2I3H6HQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ou1GbRWY; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ou1GbRWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9FJpaFF/tS7CVGwr7/dojcAU+LZNUs0oCQhsA6ZrLoF9Vt4LAsO3FraSrb8X0HIrikGYbnc3j5TK1aJ8+0fxN/9013qrNxt5tq8ENqkDQRoIVQgXKU0YUn95ZkYIwaXUlT8uMjFmQxJZSMbauOCI12w6cqQubddXVKdhAhbVspQN8qfUrwfMsxroAlbVeQoscHiUZOp5R0pWBZ2z9MiaUDS5MQwU/ozf2EWAPD1Xn2Tl3vDV2h7GpVNdGK+auZiHnpniP8sU92x9iKzGBPiaD061Vh0XGTHToMtsgnfFitFoeDxjKDi1yYgpEgY1B46fGa3iH4KGKHHFL5sK37kFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FxJ3/blPZUX/sT8a/EwBPSPvuALCcoUoMXEctVEyxo=;
 b=jqPZMtlXklOFUmQPy+8+ptDj+avwbgPe+M6pJE05CAzVq1e3U/UXlFSLVgUdqB3b5O82x7WsWYq/FgiHKgDTiieqyhU3dqlNb7WA7uyhyA2EMIihDN6lmg46QGkKqzL91fkkeIwfhYvAWgXQ8Q8IyM2HMdZVkIXHPpHGJkuxVAU53BtheBIn9gm9LauuYCdG7t8OSP2lz0aQ+CyZmEQHwYFTC278WgZTCGmDjPCMv/T8KgRXEhtM5qOQJ78v/IGfo0O2lvq58+mT1P3YZ2YbqbIgzK6qrqg0XThnIpQEnstJIQw+jYa8Z5U/oKDyfuWT8/pc0rQHlkRG6dIOnyCOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FxJ3/blPZUX/sT8a/EwBPSPvuALCcoUoMXEctVEyxo=;
 b=Ou1GbRWYrmMsjmPRWEUuaTTaHZqWCJ4LiK+tBDxx0wwGfjjK/1pywv/kspbGncZmz5OmaHyi1Eyutj7+EEi48rm3tybLtF/jou5ai6hgu5fAP7ElywqTI5i5iZ5NL6Ui7aGOuV6xlb76lX7wxPlxty+3+4daBxSMH/QDrE8Py/tohN1hf85p6h8Rfq5YHwVk9eYxesLVldLUiYrjyEZ12xSw7mZm9aGTP4YFdOZPkdrcGtKPB0glu/9BGvo2F2VApSLXitY+P1ZsC0vjXVj/oWoWEoQaC2C1eJTtS0eMfCKOvcbtggWloElaJNSbKGDnaY6wDyyGt0lOjArMy3uCGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:40:01 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:40:01 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v13 14/15] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Tue, 22 Sep 2026 08:39:23 +0000
Message-ID: <20260922083924.2451158-15-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 213e4fc8-5d8b-4154-aa24-08df18851797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BheiSgzhZJf8K6004bpv2gAUsHMdM9Od67RMRZjsz2tnJdjPmixX3AHBslbHwk5YSoRWMHpcOLeGGQdXuCWT9zf+UPtjKI6IBdVteVDq+LueYCN9dmAYIX+fJ426XUl4wlvohTgGI+HCf4mNcXt5fqTBmvecpcZj40HAu9AWA60v0Out7ToqAv4Q1mUK0Jdb2LnNaXQKuiZpGtXAuoOxs38GouZ1LSluRK0X/ccyc9yUhLDz4BwF1FRAsiY9kkiCkNzM/JgiT7sl+uo816VtZJXRERHzhnzwn1AJ/51i9zegTTjjoMQ2nc1t80VBO8WEDTMHKzcuB6k446pO15wdYFIUhTOiyCmZi033wgZJ+W+hB+1HGHfdpxM7iESOPmedN37Qz/e1gapabgqw0dVTd+Yfl8rnwEad9g0pe+Em0mOt4MujCeVMVJtPGr62SDYLA8r5EnxJs4WHvBb1IbxzcQ7c4JIQmay8hWo8gqdXi6QZE44QH4dJxg/RfPoskYSkvgxwmx0zBnuwATL870SuoH2G6tqzAWNjJtiwRGkgmsUzQa5vqVloFQC/zBj6GEFRjzq26Rw8C4Q9sbN1BRgn/iBjLhLAkrZ3nMj7rrr0JZIfFfF+alR+Arp89GvaQSmwX2BL0vH4FoEtqj3H525migzr4oPMg8BY9KMT2Me+6lgWQB4Tn0O/DEhKi2ekIC6Tkkb5f2AxtTZVYgU5TKQF6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LWR9tXpbT/o4zj3QfWdiGK0GRisZyhqYncjX2CdGC2zOp9xP3uFRz0AoSQId?=
 =?us-ascii?Q?rN0BUjKv6NWaUPe8aILXS8E9ce5Dne5xYyYFR/Lci3cbk7G3rCZD2n3625b6?=
 =?us-ascii?Q?YgYhJetUlf6PV6LE+iKA3XnA4ZKTGd97RiN6fuvk+b8zEipN2zW8EXUz8THo?=
 =?us-ascii?Q?go46jvztzR5QhbH7iP9Xcy0y6VmZJ/1afQuhM4H4JTMOTVFaXbUsO2imzmwB?=
 =?us-ascii?Q?ZNFzaUdopYra4pMcs8uv0y0vHJk93MGuqoIGQIoA3CFXJycJvU17Mx/ZiJrM?=
 =?us-ascii?Q?LDM0LcrD6JlnCSapQPYRcL6kBNfG6f0ZTNxNMtMHOm+1IBKKxd5FaFQxInUO?=
 =?us-ascii?Q?BhoBFNCooDtmCPAQbH1vq4Q0SnEbRwKKOFJ9u7j2DF/YyNh39qf8nipXBfRB?=
 =?us-ascii?Q?G57y/9gZ8I4YS5bGrNxRmimu3hDt8XKmhWAq/QHVxb0UjPZsqe0FuvxkPEaM?=
 =?us-ascii?Q?wOXOFiboetAXS5I/haVD/pcPGaEj70w16a7z/KrO/XHMRTjQRzx1/JHhgYyu?=
 =?us-ascii?Q?L1bHD7hOxcpw7lHn4h3rBDzjm+zg5PtFUh8lH4VeR+A2H8pxAKLBlHE6Yq6Y?=
 =?us-ascii?Q?yIL0LWuMcC4PzfiUWWvBTOcVPxkkhYzHrL6SS5WFQwJewnSrm3POWpBNhlVT?=
 =?us-ascii?Q?bKNmF/FuVvik7Q6uHJJlAY6qHfW4pGjCxT121f2KelUznJyrzc9PHE5zJM61?=
 =?us-ascii?Q?WawW+AQy+BB2Dn+rC838QFbcATEU+IFTLjW4npMFKTVWdm2VthGuPOn0HsXq?=
 =?us-ascii?Q?W4d5UpPKqnarKkpLR6T07ijJwrZ152lwVgjG1hlu/hf+8WIgDNgmMJeqb49K?=
 =?us-ascii?Q?4xfJUgqq8GF2br1eibYIRVPBGHSbgPvcYpsAPODg1lRJgnIF37d30mkwOMC2?=
 =?us-ascii?Q?yn3tTMAkcml2paxUidzNGTjtxbAvSNbxAxyVylXsbFfH9TItJRMJWqHvpMw3?=
 =?us-ascii?Q?HBCu3MMV8Aiiolg4+aNyluvb6hCoSbfAjd7gZPKvRAc7zZXpg3PtsdWyQXZM?=
 =?us-ascii?Q?icF4tJYptqlMALHWrGYMDe55Y8MsAE6uXNn8gNV7GEi/P7cLeh8p7pLHbwR3?=
 =?us-ascii?Q?fktWKFMkiyj4Tq0oHXWocRWPR9age6ChuyhjNoNhdRNLPb/ou0556d94rQIv?=
 =?us-ascii?Q?KG7wgIwns2f/ZknmFTr/Ts18WHEW40wXiQnYguhLg4lxyQ/zkgQY19uVjmXs?=
 =?us-ascii?Q?B5eU1Pt8dvmDOwFb+vCFmhZxX2K8Qz06MH9p3OISqToxFDO/ATSykF4qjJjg?=
 =?us-ascii?Q?hiJmYbak9TFV7iZKc4HM+rmpmHKRobbsFlgioWD4c9yLWfUjIZrI3d+5Exiv?=
 =?us-ascii?Q?n1q5hdWggddozmPjAQ/Vnw+KFgjLqBcbDouGUphmw3psQyQEuVrpHcltWltp?=
 =?us-ascii?Q?w0JQIIimNmUSOwMkDsi/3R/A799ZOL8McBUTvogd52wXS7QT7Vo1RN6Ma22b?=
 =?us-ascii?Q?ubA3V2um+BcBz7q81dN351Znq8NKftOnwCvakxVKcX149fmC1Npkr4rS5uBC?=
 =?us-ascii?Q?UeML0cLsnan10D6ahlAPYfy/AAo9BL6FLAUM82W7/66PAgpUqX43uxVYULpz?=
 =?us-ascii?Q?RvTDlm4dJ4Z74wS5XZJdsIu+B9j+Mo5TAM7c85mhdq7DQTZkAg6VJj91JnCy?=
 =?us-ascii?Q?TAzLLOQaS/Iqg/k3ei4zgjLJxyyFL30kkkVqOIm0ki6O/L1o+PU2qGXtqJdO?=
 =?us-ascii?Q?qjuPJ+mijvHdHz2RRBbFJFFHTvoB514oFJaGgIWVxPr4IwAByEKc4kgV7w0G?=
 =?us-ascii?Q?Siy8Yex4Hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213e4fc8-5d8b-4154-aa24-08df18851797
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:40:01.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7zTaDngb3R3OUn3OXX9jhyLCIpHpeXsJSGbE9Y2B2s8fyogv3/5IGasV1PP9TkVRi7nni5SdwXErfqziydpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 8 ++++----
 drivers/pci/pci.c           | 2 ++
 include/linux/pci.h         | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 79ed12ecea81..6bf503e498e1 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -1225,9 +1225,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(cap))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
@@ -1236,9 +1236,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(ctrl))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fe611340f5ab..dc57a202c91f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,7 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5148,6 +5149,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7bb37fcb556d..743b57ff885a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

