Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CD3E51CB;
	Wed,  2 Sep 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334119; cv=fail; b=fxkgtEhxm4A/q6egFklJyMogkgJkZExF8Bo5Io6vEI/mPsz4oMqb+txI2nyORbeZS57bY5VyT+Y3Bnl0Abnjv+83HO7Ttq2HkcHH9Ri7cpEUkvulmbbLGGt8gSeooQ7HjOsAUJ1cjWRgaXxI8EwKBCcgaLqsKMLi8mmVjVGjBvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334119; c=relaxed/simple;
	bh=Pr6WwDO+8k68Fe1DYmGI/IRLu3UIPRrY0BU5dgBffqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9W+876YMWnXMU9I2C1HRAnjhnxtBMqt5FtX/WG7764fJaNcEviqs15tdoJqC/a7c4h4WWzFCsZi4HuZKpTRJmxGU+WTQesJY7pJO9ApfQs77VIqIJzGjcnxlF09P9Lrr8Ydh6LMBQOiXKMA45nrzYQZ8/611cuXdD60bimMrp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hM3hnO8F; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hM3hnO8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTOpyBcckQtPsmPbbaq5lVQSRJ+hGtWRt0TdzJPqm4o4JyHXxTChsVvEq82suVly9ovaLmKrd0o2e0UlvbN3kyTg/nV+RVt+6QB9VqOIINXPVhVT/tlys4KGpw4cB5LiSDnv6hoDn4ZzECxo8RU2nAk5BwYjBjs1CulKoTALGVYTq+EDnr/NoLHCga5jllMTNsog5Vol3a3R6NxpGWCwb7OmgLAdROtuxi+D8kB+SHjIR3oYMNqaG/ZMe8Nyf28OaunKRLPEp70wFXhIs0INZY1d3fclUJLE3Q0plrHNQeEIprOQsnE9UXYE2+/mhPCcRe/QKMTkit92/JbFs6u40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WIxwyub5mdTQupPrRIYvrQGsmkOwk7grTXMjcUfrF8=;
 b=aWRDxTO307oNhaTtcluicdi4hFklzKUGI8IXiFZ0t/bfY0HoUMSEiqGT4v0X0YEwNZcoRWkAKWFcnOyHa6OW7povyEkWgmIfMJUXBSdqZ9Srp1lrLihPNZD8depOT+1N4EtmSn+I2MR5c98UMucCB9wdfw0Eil0Q2/NDSS8Aooc1r57A8vLnk1SJN9rP7GzUAKY4UhfLLtiXCuU/iP08V0vrz/8+ZipJXx6AD42HPgXgqkxPizeu7f/c5aG+4FGe1oOYbG4l3CWUsTDm2Wwv/oVs8um4E3fWdWrnos7rs2Tr8/6rzhC1Xq1t54js1bknM6UVlt7GBlyo2IwI9C+nQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WIxwyub5mdTQupPrRIYvrQGsmkOwk7grTXMjcUfrF8=;
 b=hM3hnO8F7d5cdilIxYdYjHKJyztY3ggM/f8sJIl3/5DTQeIQ9EXoXGY4hPvIBev0hvQjvuHemEWMuWGo1X8l0QT9x8KJS1XNRwZrLBdSwl7v/0g1txqaqih+8jVg701pchhV9WMxnmMSi1S92tyTX+GA0PljaTn+EZORb6c5Sj6AEODCYD9kB3O0lFCiFaXCr0OaeSjB2/sqglaqslIxqrKwl6okYDNjd9SkUAt51XVP7pZOin32ALAHQS8uwppaeEqnBF0ndX3waStl5SluP7epBcoYsCcyqWzS6btQjx7BtCqNOaJdiu76WtwR5aRJrma+FClplE5z1OPyLczJWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 07:28:35 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:28:34 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
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
Subject: [PATCH v11 10/12] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Wed,  2 Sep 2026 07:28:02 +0000
Message-ID: <20260902072804.665639-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3883199f-5562-40da-5114-08df08c3cc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	AmY+s81ki8aPfKx03Qga+48y39G+CpLjVRz8lwwWgk5ywPb5Vo3Xgzc1pnRAv9NCdonCqW0T5Ce+77IlEUkkQafNh3fbW4cj3d8WTsQGXHpSvgCQDD1H2KRT9WZFI4mD7BZ6vqVCitBPq90cf383xGch1x+Ws0GQq++Oc6aGr+38eaqZW+CW5jLcDharZ4hxslAA0MAhWDjgZc/ycanr0Q6/0Wq7wxobnTj1l4UFcz0scI4gZ6zT/lxFe+97B/AC3DcXSA/6tHnbI2pHa3h6bmZLUYwXvVVRSq0YqdkEG7IayypGmW7Fv7WWgYRAKpMAkkDUx9UnzrejSU4JcMJarp/DHSo+cOV0utZawPjTfsAaJkHNHAcf4ald/pAY11LGXZf6ZnT12D7j8YNEb7wfKF1DRlNNb3RAGjs5wzozmjVi7xcKJ3EiSo+twArAMyr4bghsYtLPiuA157P7ctvNBg7KrB9w5X61upmznUR0BS8vUYlew6n2eh1v9YyxaUXEGwEtNUzxLdibzomMp42wSK5t46/2UPPVj1cYQaZPqAjlMvSq3ewZMVMusmtwLOrdkt93bOca3sAnYPjsGFyaTiTIYAFvih7N0Pj+ltrXRQCnY6fkFxlF8BpJyQ2XLKlr7VsU7EVnHoTR8yGokQnZWZgjTEFUZ2YME9l4dgSdz9p3Iw7xAvqbXNvow2VEmT7VpfpfQefWRZDidiP0eBTG/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+moxI/F9XpQPPcJQDf6QRi/xqsXUf1hQMpMBpAMhwyUF5rXSRG8KfQLEDXmB?=
 =?us-ascii?Q?sLxBguth5DE2kAlXRLkvSUHj4zZPkBpxNGokqQvAYyI3LZCdfEVxCl0ZmhOt?=
 =?us-ascii?Q?6Kn+4BL6cGOtAzunR1/dV4ZGwINLq0CMFSJovUqbER2rHwqGhMXrS1rIlnBw?=
 =?us-ascii?Q?V1Yk5e4sl+tpQOwi82Ttku+5e+/e10zYxFAzr7g7ONOtGB+pnT0XWIHHA4R/?=
 =?us-ascii?Q?nS+Rl0uzTAxN6VeAALsCTqbAil+XxRuZNHRbzyRhvi+K2mHMVRFC1fBwzDLa?=
 =?us-ascii?Q?+uD525JM4wQ6LkEsAqWy+LHQ5EyOP8okwfoNoqu4BnfkLQXtgL/tcjLmDObG?=
 =?us-ascii?Q?rF68xIEsOtccKMkODzCVlhzMjY47jUuCVU/d/0LT2sgVT7yV4NyXSm6uX23q?=
 =?us-ascii?Q?qpkHn5wHJ2IfjVJcpnMUZFincIJAdUbdLoYWrqDYeKwAnpZit30opLCuxsGH?=
 =?us-ascii?Q?6THoXNPqCgShL2EebfFzKQESGg97qvG51Qg+wyj+YSkQIkME37ze7nOa6Ppw?=
 =?us-ascii?Q?1lh/OyYKFp/hDLiqZdVaL2yKr0G9tQPDG2+dVF5z/jbonLI32D3kXFtY27VF?=
 =?us-ascii?Q?lIHf0wPYjRbXnlEMhAeQRqT9sjD1uWmxlkS8bd/VbOJE+1to8iAYXrT49tUH?=
 =?us-ascii?Q?eM+HED7/yadHhzR+wtAoWzx89fRtsRsNk8ol8vn7Ob0yGrwjtlCkEWiE+MKG?=
 =?us-ascii?Q?sGRxKIn/JWIlbDUnEBiQY/x4K8gbSZMqMvXzja5b+OX57QGG2WsyG+dIcE4Q?=
 =?us-ascii?Q?zhQkbHaOBOtQAh5MehUoe/0d7zpmgX5JQ3o0Ob0KGUmHKqQLubyYRrVyMGAu?=
 =?us-ascii?Q?sLdxPbhjfqbPYyKSQJajUWxx46V8xU1T9CCcLG/Kuzo44Wm7+QmAb1oGR0sU?=
 =?us-ascii?Q?KNsYswIbeowjRbO0uSwBcxdpu4FgeOENgqyx7OljYSVBtFFdE4v4H0MU2JP0?=
 =?us-ascii?Q?rsjxnPmprdgvQJz7uKoLQbU8a0qYlwHxB5WzLcdEMrTMQ9s0w2qKbN45M4nj?=
 =?us-ascii?Q?LQmLt8gCcrXOtDfnHz4gNS+sikxhH6Cu8XBKMFhu6Gb15V4LFLULYHSDFNW8?=
 =?us-ascii?Q?DxTp+LMIAheo5Jf1VxWmyobxf0765QZ1mz8MvNRr5EUeyS2tYzRrbdPYrQha?=
 =?us-ascii?Q?cquTUSdsrFZeVGfkGBU6oVMCW0i16bC0C9nr8g35l2KIx4cFwOivU2WDf6lb?=
 =?us-ascii?Q?CaZC/NSdW4GxpM75tM+OUgkMzXB8E0U+q/cVk3E5bDCdD2C0p7RBtaUlAi5n?=
 =?us-ascii?Q?IzfHHsC4vuW50qIY9k5e64aoye4dJUeL1TXA1e7tAMp7ibxVPxNy8wvWLgnM?=
 =?us-ascii?Q?NR7l0BX8EmaHO+qsapFDxX707PaOMg574tyTq3HbJtYskwoB/OjtazjrfCiS?=
 =?us-ascii?Q?AVKCIT07U0ZOUb+rzIWv8MBYpML16ElAmT86q1cn6d1+t5R09a02TqS90MGO?=
 =?us-ascii?Q?4Ikr7FD3log3I7AA+xMWtkLxiDFl+IBWY4B7CzICdgEGxX0myxs5gUmt/ns2?=
 =?us-ascii?Q?esIvWDbulF/0eRAXyPQLl1PRNkzm/o2THNbLtQYThXwtUsC91FP+RMAZO6MB?=
 =?us-ascii?Q?Z8zCnCUVMlRTANwXrsRGzaEQep2l0qum31QXy46ZBhq/75NkMzprwp9DhjsK?=
 =?us-ascii?Q?hJL2gV13t4vBkOrWbSlPZnmym73ImeLILB7a4HQ6bkTx3yK1lbN+/KetzjQ/?=
 =?us-ascii?Q?8w/BLGA0sEBrGAhSuXU+idHcmk74Q7U20vPv3Ts6GNUIk0TuY/Akoh9W3Bmp?=
 =?us-ascii?Q?uyAGw7yoxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3883199f-5562-40da-5114-08df08c3cc18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:28:34.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXZE8M7n7QQkvLFRxIgfUPZwUe6OQzqv3/hHVpxyYMgpNfJuAt5PuOemKesuLmI+kqobai97SULD8kjImfiR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

Add the CXL Reset helper to the PCI reset-method table so userspace can
select it through the existing reset_method ABI.

Advertise the method for Type 2 CXL devices that report CXL Reset
support in the CXL Device DVSEC and pass the function-scope check. Reset
execution requires cached HDM decoder state for the target so affected
ranges can be validated and HDM programming can be restored. If that
state is unavailable at reset time, return -ENOTTY so PCI can try the
next reset method.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 2 ++
 include/linux/pci.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..157f06c576e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,7 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5145,6 +5146,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 84d058b1b492..074767c7afc4 100644
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

