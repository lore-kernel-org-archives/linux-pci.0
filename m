Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2F347500;
	Tue,  4 Aug 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871850; cv=fail; b=tsBMtczGBmyy7BudwhrnZDLKK3wzK/fKrCnbLwwVxQGLySLkuhDeoFfVxYKJ+5rKfKQHHsVa9qZS/qh8EftSlAPKKETOZ6c9sjYZtGo8xgWZAl/mTok630+H0SJ2ToZ3qk4RhY9ucKYeSEhtUxHexqTmMUfBeqmeLvRRKyXLhT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871850; c=relaxed/simple;
	bh=jM0uvRSnbe/QknVa0fddO2WjSXocVdu5TmOIrQbAQj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6Se1fR1j5gLAKewput675T9v8k1WmLHtkoRl9NN7ThV1XDtYhfuODA/9nS3Vm95+C8STpHQvCBucs3rJI08bX/0s9N+P6R6VbnVYwLJuY8SJFBS+613kIwnr3IxBKGEWHX6ES17HdHwnzrTsVZeh5RSKciFcAvu2Nxk5IqGIjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWwo+vzy; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWwo+vzy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo8nUixim4wzwXt7L+2cei2pTFPFg+VTfLB9dJyDu0HnFQUSflzKI56qyi7z7NhJnbDBMWj4YNEuRXWqfwOufnOZ/0ljpNfAqURacYLTY80yc8kPDjdyvGlsViAY7sWXERcSLwr9To5c1GpmsNj1CJk03DtwKO8Gnq4/rW8+VxA1iiF+gFCq1JluZCvZvv8lE2jqKA0igHEzpJ2kxNa3qwM0yqVLdqmBg6tTEz5weMLV3xptzdEqwAgndOAtvw9T1i627Jn2wkokVlsZCIaVaNFSF8VKTVmoiYu23Kg7I0xVDiJen670u4ZOCxjUkf+tDBNDCdMpNHUeLs9eGXOV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0s37buFbOhhkBOv8zHnwJTb0nyX/mU37b9/y2uC/MM=;
 b=otAkcPX6DgMaWHPQuV6siHQIwzaoyFSvn2i8ruYBnqTnZSUH1bkGZOTToMZbr/wQU2a18Jgd7fabTbo4SEVgOKApD1cmSW5Sh//WiVvskpnjTIxHZZLJlxCeGphqyny/MtoTKTUm21pCNlJGh+VmW8mPZfW9/wcNwvAb+t/s9D/eVXLduB71XbnSNtpdd4BZw+5pyy/jn7Bw2VTzV82k8wgsfW5KDzDjcDjmQwNiZ3PjlCasVpFVw2zF8HH1M/H4O82VG2Bsab6f46Q1KfGfsLC1P5USZp0wBZ8u2IyvxU1vIhFwWsR11dcDFVUd+FNqnn6GSy+DcWjjuzNAZfrU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0s37buFbOhhkBOv8zHnwJTb0nyX/mU37b9/y2uC/MM=;
 b=kWwo+vzy6rJ0FXoGgsLUiF4Ydb2pzQBDyX9sT+Sod4oAj2Jm7zcEMreoQN+KBjdabRxJ5WpUX0LEKlirOjg/eopcKkMt8y+4UOL/S2LP2Nvc3xtrRM6zRgSERnUZgRhraq9R46C1iXfmVI7CPO9zyi6MRgaUhZBrQOmuP9zzsLurhXt2xLSc8qTlWppIV06pdwIwUnRvT0MSCyYtBG3nkz19l88uRj6TNvtcAbl+rWWE5PApjmRPMcVJr6jEY8I07yGTgeoIhO60KboS1nzGjhxmw2d4b195jOIXDLzEs84zVG+gOMdB2Va4Ut2jX0MmMWajaPMOUpc5ZOvG6ts7dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 19:30:43 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:43 +0000
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
Subject: [PATCH v10 10/12] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Tue,  4 Aug 2026 19:29:56 +0000
Message-ID: <20260804192958.1823952-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ed9725-a2ba-4a8b-d7e2-08def25edf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|921020|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+xO+hUTr74tRHFgpBgcnopS2Ikeo6Nuu+1knGCJu/tOZB8rvw6JRI9SfKxgmOmrv3QqFJT8BjQr579UpWvFZeKPkKlEUUxSv555jCh8YYIxVMG2fPyO2WyuZHjO9m5dr9qMMNtYyFrkgBKz/1Q9BpxGX/ycQtkrjjKfNKZTvEPTJeh7UGNWQbH+pVnRI4iBzV4DeAFMtATeUwthv6NclCDoseizsuoV5gdUcjGVlm/G2GJ7JUKzJSAHjYmOaQp3cFbHbQghLLNiNnLX3Q1QmOp6sbCc/3Tqh7vjL4tqf9CLAfe0Rapk8Yd36mV49RYa+03h11mtQNPghurRh9nm4MTe00GjWojx8DG5DjN/MQVuSJw9pBsjLjDyqj5u0ZDTkYyAzwewSh+AJPkUr4sxso+BJT0vOnOOfFnpBCY+2u2SsPegfPm4YwUc2eeLnQWgPSVEQXNF8LPKUEAmRXaF3kq2xDhLF26UVEPBKMFYPwX73+hNLqe5UoOgiRQebJ8d5q13Ha6LId81+DCNtXuH+KUfblyEC60spJSHFpzfa1otZXjr08ip41o4T64T84t3JJZ6plFeYNx/zdfTJg7oH5vC1jDuHt4Y9kI2AljRfMlmrWniz6w6KiIeLnrfYmDSaqF5J5JmHvaCDDxBufWZGiaW6kSgs9/4VTbU2Op+M5YYn9/fuJyzHskif3n89HTGfXeLQr0D5AptlAyWXivss2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8iSxOcBgxaiXzr5S0iLEnhKmqPX5SVfKEX76UwEplfRG2qzfMXKxAM4F6la?=
 =?us-ascii?Q?OFITHssGZb845rWveIyRnimuDOo0oUW0I94GinKqApHAtY61xp6+u17KH9ZI?=
 =?us-ascii?Q?V7Om74PxKRDqN3y5WBNlEUkoNBJBgg65uwMWsQIAg8Aegzxz6QP8btDgtGBh?=
 =?us-ascii?Q?J/E7Zl0D99NhFxMXkPBRNu2cUViagobXRBaDJiA+Ao2R13o9dPlDX7DwIEVx?=
 =?us-ascii?Q?wQwLKojbECUJRguigwUtFBvYsoG3RZHx0AedHGQBOriwfU3Q3Emw1m9k4NRh?=
 =?us-ascii?Q?w6p+oN1dLdJ6RQcZc2H+xGJLkplwS2DLdIMYkjQmxkNlwpgO8bKeZ5uWZ/yY?=
 =?us-ascii?Q?RMKSF6d48oks1aFmq5SJWvLP/y9xwOoG1VNtqAh5VMGfnp5990/kTwq5gV8z?=
 =?us-ascii?Q?1KlH2Ma0tzZibB6tm2NzZZlCcGCzQbw4DE2r8S45yuVEVD/SRVjEMK4IOtKH?=
 =?us-ascii?Q?GP/6GGtpyTPhY7DbXX31/mWK3gpC+l0ujktxsKcenO5yx5HrHWwpJNp+4K5q?=
 =?us-ascii?Q?T6HFrMyRX1Utu/pM2BFXSSI9MKVE0eQxLd9ZSrno2XuaZkb+7vaTzXkMyrfM?=
 =?us-ascii?Q?TFKFxPC+lIOew+Dn5NHRLVuXGC3YUSNOCOfl/yHh2P/SpF4ekt5VG39UDO+G?=
 =?us-ascii?Q?T73snRrGsOO1FWfaDulZGSNf04JcfV5CcCRT43kQ/294BSKDFY7G8sjA8HPU?=
 =?us-ascii?Q?rAvN3ERaCZBCwsMDVs2e0n7ib1+mhXyHvKMWUwo7oiZy4+NDTQmYrBbjv2H7?=
 =?us-ascii?Q?HR4X3MLLoggy+YNilmki4iSW6IvPHPBecQkFb/YXBpk6RV5EROneIogT81KL?=
 =?us-ascii?Q?ZN18DCIkbT1ksdx/5+RLe623kXjbW6Ir4x3ZLEhXieWY9W2ne1IKoJ+kwQnT?=
 =?us-ascii?Q?/OIcEWwwZdDMyi39ryREUmgfw9QoaSeZK5tOat7JXBYus7w9/PIOI4xll0+8?=
 =?us-ascii?Q?53mTc2GHEVF5gj8RRBLXGRkyG/jXlhFhg5WEyROPO2AocCOt2BQQEsWGFs+g?=
 =?us-ascii?Q?hw4VdTXGPEPHCiJAyl0DGL6UGt8SE/4ecmqPF0MjpKOORAPKZqwvkOGId9ZK?=
 =?us-ascii?Q?haoXhCgk+apKWQUOUBzfBc6PIdIR/T15cZTPCW7yOCETBBA6oUJ9WzuV/P6d?=
 =?us-ascii?Q?EGLjkjhGDZVOP29biNtpCxoP+YZM8XeWIqbaOmXz8usJgxdhh0OHUMwY6z/Q?=
 =?us-ascii?Q?pzzoQdk7SheCqyFSa0N/qfgtOR5UmGePE1S0Qc4Z8y/rYXIKmEons/IeCX9T?=
 =?us-ascii?Q?Hd/p0drcxxpkMnDFd+shZuu+4eFnSQiAoV5k3DGP6qLv0cu/fo51TioBQK67?=
 =?us-ascii?Q?afYrEtFZ5sgF2RBsmsxCcxq38JubhsvxCwtMAkH+piU/RxGOcu4jZNsB106L?=
 =?us-ascii?Q?z1vAsBJMF5MDkvaYwMGOKsG7JUVGJVOPt3u7ePw0zP5YIx44ra7ZJ2a9XFOq?=
 =?us-ascii?Q?lv/AbRwzjARf/AEhlmY9pTKNJtGi1Bx4XPH0IvmNlRHAYwfpNgtPbqlkZHqn?=
 =?us-ascii?Q?08MAhEwvRPeN/iIXuZL9ZsmqNC4Ow9eCl5TTN+V3rnYMi3MQJEksIH6pwJ8a?=
 =?us-ascii?Q?JhCppr8P8i5/qSEDTL7XktvtevOfHFSIsBsPtR/G+yLhhjoUqu+4QG8CXPa1?=
 =?us-ascii?Q?KeUxTUJY7BpE9FbdySIFP2LnXlBAUuY5FAKv3/mHZfOCiG/efg6Xy1hQ/qv5?=
 =?us-ascii?Q?5J99EV37ScZEUH4QsrA+In91gsySI+jrottgWMwywIHQ0UDLTcmIP7+X+d0/?=
 =?us-ascii?Q?ND5NYh2b0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ed9725-a2ba-4a8b-d7e2-08def25edf6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:42.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FFzs4uTxZceaIv9Efo2BOsed0NwAlWEa2SFWMVCH8O4mr5IwVJqAzB0ZijvjoQadNvwAfLJJl71G8YVqWdgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

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
index 77b17b13ee61..ef25ba5f7fe9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -34,6 +34,7 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5092,6 +5093,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a8e5cec96bae..9319182b5692 100644
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

