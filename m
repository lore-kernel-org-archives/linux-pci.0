Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64843546CB;
	Fri,  3 Jul 2026 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116348; cv=fail; b=N21LmZQPcdBUHDmYnY9kcXt2xYhQNk3zR3BPdKPg/83JhPG/+2bTRYoGDqd9LUHNMrq8fcQgqD2vxGIQjD0IoOcfgLMmpEJl+MI/PZJKT3XuifFpCFAVb87Wxz+UrhMiELdWRBJrnvfstSAzOgq9AsjK40QiMeZOGeFOmAV4e3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116348; c=relaxed/simple;
	bh=CvyReYPqckV6V03vEydUWinFm22Nv8ywReLGp5nakhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EATzOr4R3roYvCv5OOj94Qzoudgn0Jq88QqSMpaIRSU/uXw66eouuR3WI7wHqXA8SdeZGTzrlaaCr4OQ1yq/lWGFRknforinMk/qlNeDl32koFqe/4Gd/iHBMqw++XUttv7b52D8MIQGz9uaf+jgqpgABqk9j+E/qv56OVwPN5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FEnwXzlH; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FEnwXzlH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ0By69qRk59mMeRQUL8dbj/Q/vvu3tQZ5+osCuuOoFEoBDXV5+9AOKnykXo7tXIlC27L2BUjly/y8jWUNNjpPl33IBOaz77wSflCnKuHES4hD1/PopOxqmNVforb8odbU9HMP8enY8l5wG3Z+jnLTvI2GngFk5+x0a5ga2ikCFqC8qSUwlgybGn/qTtL21eJ/5PJjJGjNn2BevIAWwFSu3w4AVllcZGq1jH3Yk/fO4NsuzNgVqISmRv1LrZJ26Ej5FlLQ4dbvCZtBDUOAweeQcZtVgaNFE/DAT7xQJHjZkeZPkfe0a3zfBKoXKcFGv1aCEg+LI/CYgnt0ME7YVtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoXCv8PGxTxvTQ2bNd1YlbsqmWwh9NzarQY+yO+3gkg=;
 b=ZzntwUpbrpUm9R9agYtUQmpmaS1cKIu6d/mYrg8G80WTHDNauxVn4/kI/qPW+AnLe3TwsW1ugJTvQQ3ilOaVYbLj7Adz8hhRqb6LpHs/GvjhKwl+vWGQDIB48OqpD6PDC0uVPDK+FUbNKwjuBPy7Z0BOmBtS3vYepc4su8IxPQmiPP3ZK/rIuNz9c1PmZ6nttCsMN2MIqJwdVQgKi5guYD816WK3kRdliyXCRilCVAhtyAP3tFFSgsrQxcfLDNBzeXic2ZJbxcLlezNCkI5DmBUiyzDKvmn7NTnuJvHRBoKMnV5HHHX3UF5lLT8wATv5B6TaGymbNUqobD0ymEM62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoXCv8PGxTxvTQ2bNd1YlbsqmWwh9NzarQY+yO+3gkg=;
 b=FEnwXzlHGhnVKiDRbkEtH2DoYhxu4rt+wBj7f14tg8NWvDxrTpy2eBbWLxSHMdRm2E2V3QV811nQtB/2NlEe/LCOIZca+eLO7i+q6S9HXDrWKYRMY1m4fD0A8XNxUbRER9LA55e48lIVf+ILW1LZB4pwTgnc/b422shKE74JUMWuqYhJmhZq9eGNz7mnelk64oXYj2/cZJQWvtlkkgo2QW22yQmHx8MPiubhaAa/cdBeIVSErjx4RZZGzC7KzyTnmvN9OBoNV8AVIYU18/YOczFSwm9p9JWDC7a4/JoZ3kZTsB22gbfsgeImkbqgR6O+A8cNq37GDz3rqUY+NxZ7CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:34 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:34 +0000
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
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 09/10] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Fri,  3 Jul 2026 22:05:07 +0000
Message-ID: <20260703220508.546528-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: b7392225-bd70-4fc0-79ac-08ded94f347f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	N3F7ApPconUFS0s3Bgb2urJz2GryEk08gfEG+C+jl5bpUhOiygWli6hVg7ly3Wf2tA6PJcDDrBImKGh5rzcqQI6yq7sjxi7KjpQtJcjZyZKvMt5XlHzLEZfZ+ZKMealZlISocv3WHpqTfwnzTnGD5qbgOC4RdevFO5K/4CatKaXwkFnFro/RAGYcolZajpXNv+IxHpycsO09upb5iXh1n8WhGVRI4rkXjDXzdvEx1HWoI1U+W7AyfLUeg6KHJMqwixHL+pgMVo2PHsse2SGRwouLI6rFTZEAfp4zkmdpKakyEHDbf6W1dwJsd3YaR2KO3JHXaRNaxuplPtA3FT6J3XjGU2ndta14oWHYQAd0dynMDT+Nf//U81ec735wLlSOpsLlJ5weIxkL/nw4ml2jmSbwX1Gm4xW1JjSu5SgZGDb9gSioRkkqlfRtt6VBIqXcCFLyj5CBD51T4smoiv/mtVgB3aWFdvBNmIKhG0zCougyPIM0RIx1E3qK0jxiePBarfzM5uBTdTmNjdmkNsqMeSjuyokGfu2Jde8LjoWluSk3XBzX9kNYYAVvc9cJAEaKEW9acFrXhtIX8e3w+vz5IxLuvUahzWXPgf4XujF+PWJivin9rr59+5hstu8joxLC9CwzHQIT/eRIFN+/A40zw9MwLUplw9G7BqSEOFziG1kCZ0ndTBI6CJrK9WgPDuH1/T4ebnS+s49mf2t7O/AZ+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NyO+oFP0+VBVIh2kEM3eiISZvElJFP1VUfOe7yB31R6YDAs8oJ6LlbQlD5o?=
 =?us-ascii?Q?fa5znG8Os2Gyq+a+O4N9RcnRRz5rO2teGe2P0DvhSO0FgpyARXwmnfUPS6Ac?=
 =?us-ascii?Q?+zitZiyLUkxWXtg7aNewqd+4ONS1rCHVFHFszksNSXuQSTR8yI/NMfsu5ERB?=
 =?us-ascii?Q?tOJfybv08ugDDKLZpOJXWOa0kTRdzkv7grRxIVHHsB9mxmZ/oa1INW+U05yP?=
 =?us-ascii?Q?bANy2c6eMa8YP+IGMrEXVMo+OSfKauaRc9pFP7Dknz/ej4+6gkSnSeMZrkqL?=
 =?us-ascii?Q?SiJMSGvq/Dv4lPd9RwNXwJPeHqW5pyuUpWRElH+PvlLa4lXuutiBET6UXrp5?=
 =?us-ascii?Q?66W7HKBpeIaa4Huj1R7OZmvb9EW2UMIKkgrpsCW5jeiblwPmucpcAw7F3h/i?=
 =?us-ascii?Q?VcE6kLsmk9jxzdNsJ54qpMVe0AgensgVl95rFodqSmSfWHvq42Z67NCxn/Y5?=
 =?us-ascii?Q?Pyb22nZF9jLOiObloh/thvkHJiFZcrMbJsqihtccyyb1ll8atwMvzoIa/W0/?=
 =?us-ascii?Q?hIT8SNfWYeHKHiaZdEiO8m1wLTg7iSeb/vo3H9eUEJrnsBbRb8D7mZ5O0jOy?=
 =?us-ascii?Q?ohwfWBWKWgsI/fq9r4X/CIBe+GO2XL6iYFQCxXbmHdx0P1JoMJiE9cgvW9+C?=
 =?us-ascii?Q?6ed68lughPD8niPOALgrIRM42zsbrnZFAAROXVqPskg0N+KRqlkUQJHBEguy?=
 =?us-ascii?Q?vts01OkemBy4YeA7/lGkqjudh4V06uI34A6JMSEUJevrNgg33Ky46+ANppZu?=
 =?us-ascii?Q?MJH+L8n6Q8Zi7zGXETMB/ijrA36SanXLPW8ny+iKuU6LZM6jlnRjGwDyAcyn?=
 =?us-ascii?Q?hntP/TT7ry9O1IAEINpnV29Gb5I2WDb4GFNsLJOoEMwOy6llfWPPiU1Jrkfd?=
 =?us-ascii?Q?T81YwFLwHAWQ+iBJL3G4ToP4ED3vmBYLvlUlOomSODdnpS6bZKAKdZH6cIgu?=
 =?us-ascii?Q?Nys9QsaReML1h9ZD06YbbsKLLPPWkqPLab2ophAuH/PaxyQM0CX3ZbH1T1Er?=
 =?us-ascii?Q?jP1t1qSRvcHwoY+jrn4x2XCVaBa3LVf4EY+BM7jqJgc7WQYAiXFpU5RllPt8?=
 =?us-ascii?Q?Aqwrdfj9n+5KWbxycOYHemctVtE2H+/CvyJZoX/gT+0knPfpwvHluOkweIZZ?=
 =?us-ascii?Q?5KP3heHkFnKEDH/k8eoC7TyXe0bBaNQLAzDnle/X69t2uIk4EtMqYHbncktq?=
 =?us-ascii?Q?JuyAFdpoecqZC2vd86C/Tuz9mCR6SJy6fYZnXIruVyGxPaCoiU29FWFOTulp?=
 =?us-ascii?Q?QIc5ZOVf93HvmcILAX1T8e+KcTobgM8zWDz+GAyQo9DT7qOf+pQW1CVeBnou?=
 =?us-ascii?Q?WgbYkNSRvTmcmQYVm72lOj0MsK3itG02jBMvjJc2rTNnMb64bNoz6HunzJFE?=
 =?us-ascii?Q?MqqOJWCapoeImZC/+13GuBn1cAis1jgumX1EIStqwBl492255QkRtWv8tM4Q?=
 =?us-ascii?Q?7ChLxdKLvTPhaDtJPqh0XN+ZdnHKLWtvap+St7G1gYGx8OvRbtwDLQ+tnj52?=
 =?us-ascii?Q?20GVThtofq7I/Fx1ryS0lr2rJ5LBY0uF8aWIIMT/3nEK6uGgsJt3dDS+Z0Y1?=
 =?us-ascii?Q?LHL4wZLF9/2azNdpLL0D4wFoVbMAAWCaFbRLiIDUqlOS3kA1mZPI7DMwEEaX?=
 =?us-ascii?Q?fg7TfGhkE8mLjJItGUlh/ClmnJNENNbU6UPMZvEqDg+9s9sVUP1vPy+5yWpO?=
 =?us-ascii?Q?yDXLq18eK4mOB86sdyenoTG+GzIOT7Le9a+A6YG8d0HqVV0ijMUFwX1RdtMN?=
 =?us-ascii?Q?yCsYuQkqmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7392225-bd70-4fc0-79ac-08ded94f347f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:34.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GYefEAWSyDUGy0lsO+qzJbO7STcnwCAEaYJnUvwI0b/36/RNBETr6PVcu0VvkTKaAtkzAX47hs+DB95bp0b4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

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
index d34266651ad0..7521e705f718 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -33,6 +33,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5060,6 +5061,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7db2daf8597c..7d6f1adab27c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

