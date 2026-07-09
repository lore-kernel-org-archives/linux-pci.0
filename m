Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD839937B;
	Thu,  9 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559045; cv=fail; b=arELz36+2YaEqy7dcmsguscMOvYHXymWqGJNqLcYf22QBLhM3wpcP4KDUAZ1EC9PbaVlpKZ3xlbrVeg4zVLPQw+k5jeG9st7N0y1/Lzx2IybcrZciBdbAdPCW/i0HqEVUMFe0q8iZidyXOZhi5fnMzhcKrkAgN1F8mazc+7YEbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559045; c=relaxed/simple;
	bh=jM0uvRSnbe/QknVa0fddO2WjSXocVdu5TmOIrQbAQj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ln/ijWeby+KIq9xB9KXPo6utG68tGxpUxzhsePOFa+IPTX2RDQ8/JB+YsQCTT6OMYRMTIFDQ5vgyq6vUIsjKCyknktMaFp4TY9jL0WmZMTSBresqztUNnroKzwU1rMDpe6KQa5c5VysbFhCULCzWbwM+Z8hzrPTdi8eSPrgwV+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omlqRk1I; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omlqRk1I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIDDcsw7o+MOt1zAfWNJJDZHcVnKgrwsGlXpM7jE4NBzb85PILlAB790ywvIaVplazcy/r5i/ubUxI0/95w95vMz7wgZ1Mb3K/A8xD/vKrS+bDNhe8RYPYq+g8Oms/IumfjO+AdLFEStzJIu5Y1SOPc2irPmo2ET7x6FzS301Stx/ATG/2HeRssD41Ji7L153wLtw3U5sPwGseVESXJQLVXADuwuhIaLdob5yeUiuj9MTGEaLrQ5P5mYU92WqhrzAlgZGB9Ugz5XpJeIov1L6iaOiEUu62DzwWxttu1cH+Wz870ydf4FhgeRiyaw02j8DaI7Izgef8ZZ5Xq906ccXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0s37buFbOhhkBOv8zHnwJTb0nyX/mU37b9/y2uC/MM=;
 b=O/wiVRSzh07ESuBAqinFotc3TAjmFqXN7xp9d5kXUzF6Byrtqtn3xVEluobaHv4mSwC8D1sR2JlbD+I4Frt+gvRLXuAkWBnwNK6jZCKxQmEdQIw/bN1j4YJWLsxg5Qoh1aDyw/LE3qrE9aG5Gqudm1hwLHdqDd7JcN73U2oTZx+hrvO/2gMhl+k3kuvZ6vN0FzoFVeysjG1MJqdpDaQushEZ4MLIcAqwJfv4VWUEvdABiQclh7wIczPacxAybIHXxfVDDD15mD704nIfns8bh5E8ZZRS+61MhQN7Eyz1UxpRQuyAaHFespLG2NarEiu6YBl+0DDVDQW7KMYKyIljiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0s37buFbOhhkBOv8zHnwJTb0nyX/mU37b9/y2uC/MM=;
 b=omlqRk1IsLU2CzcyoHBtumx0Rka8TNUc3TodtCw1omgtyXeUEoc3wmx319hW5xBIzpSonWyVSs8Dd6XIAyHXHcQfMttMPrlzXXhAzij515RQVoA+K8ndMzy3gaTKcAnQNUkGqRNEYFY0VRUE6rgMoEHtC4xGksL+D1JRD3HNbOrT2FOL7VzCkwEvLzus3V1PM7qZLa/4c6+XYfSlT/n/GnKXgUvAFBUBv1OxjVF8kOLh3yuISLRg/5Hk+OaOKK7nXgV90Oqj4QHRAhfH4hh4eq574zXm/10TZYY0h2JJ3s7PD8EGwOY+UaW/gXGgHeq579Uk41TmSL6K0AJWo/vTIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:04:00 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:59 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
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
Subject: [PATCH v9 09/11] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Thu,  9 Jul 2026 01:03:02 +0000
Message-ID: <20260709010304.680422-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 72339833-8c9e-4374-6a50-08dedd55f5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	l6l6IhW3FtnmiadkmjTlehkrLSJ6tFsb/VFklhw/43e5hN2x0gFunloqk9uSdBFyTTN38ZQ5ZFpxT9WV842NmCaf9NnQUQU6piO6wNpv2uQF0WiTa+MhCGLskMDB6Wo2ZS7WK3yCXoNUJ4XdRXlJ2C3E642g6yfu7F/6aRyl/15uzTOzNdAMShrUVTnsfJLXQj80h9mFA45rTWmz/oZHCBd1EP6T3wsurAuJlkODnyx5vZABskLVRlpk25h/6j2Cl0sBdcZLTlYB8Oqm7e8aCe21/WGc7F+pU+aZV1p5UJjvkqR0Xn49hxTnlLXctGUXNPnlMxlcpb42iLZvq3Czjk+1a/FnQR9eUwuUO3RwxRCt0laRpKbjSrgbvkK06crBUEs/5UbXTauAD8Jm/gUjhQLLL1Ix/KCq5fBveWDFOFtlo5oYLuOES3P7Vb1XtTy6a7ewp4wofF8C53bfbs9PLJeNti9ULOOSSd2vLgh3EpeLxOJGXZUjrKOI+qWi8XgNkG5c3uJ6PPqqtXo9I9qnfEU5ztZYcw+FzQrJvbypZ7O8qLANnI2AgOHegd4VsDvwhVMBDdRG33k+Ng2DVK/ep4ftaREswVmT1opJ7KtVdYMiAOufQao7RRJn6Ur19UC50dF9Mtw+4l1oVY/+GE9+qDZ92SuTcoOz7fXt/cOdv6VAmLALUasE1rTeW9D7DRPiWC9bODEGGnANyFsgTJ/jBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uYfQY2ZukQoFDNyMOZjoQIv9xUNiq9EsC5nwIm0qqG8mmKK3qGiiPWIFkjDE?=
 =?us-ascii?Q?heWQqUTb17HQVlLD/dIOIXDsdGOZNr+XYlIbkvPnr/cz0bhpO1Jo1NBTerqe?=
 =?us-ascii?Q?8HdM19fCuhHLBz1MEKs8I53qOfHiEdQCxhrnQZGlIWnqaBBeDuavT/1yd97l?=
 =?us-ascii?Q?8lQmRQFYdG6pO+k3couC8ZQg5SIPDhtCnwq2uSFScANnUKh5R7OUIZ39wYb2?=
 =?us-ascii?Q?hHTk0az4W31dNSKkFR7zPlsoU8S66M7LbD/gRAWOXiOUZBF4+K9l/BSDfcQt?=
 =?us-ascii?Q?faxFJoXzUu6DczSeBkNtgfk8liuQE7fkw7mymndKd132gSahcUvMlLDurIFU?=
 =?us-ascii?Q?Vhtmf6HDRLj+Tmd2YrmZjfkkGmcK5UDqOd1pbukeDuFEG8ORFbrLr6P8erRp?=
 =?us-ascii?Q?tsiEKGRGgiaTbvPOKUcesFB7VtzX5BM4VtYSoa0GsO6RBlRgibyyptZTsGDZ?=
 =?us-ascii?Q?ZHUXtQ/08mkrTIJ+Ys4KlRAmblQG4KfWdX+nJvBUgNKUpIGPfNtearvZyug1?=
 =?us-ascii?Q?jZ2kxjQsLyTSmTVy3x3P5rb5Uv9AuQMCYpsUoqfjDO3VeU1VVirr9ROZH2NZ?=
 =?us-ascii?Q?zvFgAz15xwUpnFtuJJCpSzUfHIuqOPEz7G9LEuaTyW4STJ5LCZhSvvjmATSw?=
 =?us-ascii?Q?LmhVLBWcyUwLCoLn9kLhPwEoNCRRN7TlgzQZEjJTEs9z/ACqd7GQLFiZrlP+?=
 =?us-ascii?Q?VoXXu421sbXqI0oPHq2QGnDIy442v9PIQwKojoCIv6KquMj/FRL+djCs0tQK?=
 =?us-ascii?Q?YRMVhXqqSceRAo6s0EI2b5V18JATs6f5lAI0lwUAmtHSwYVkO6zJrLJFuyTY?=
 =?us-ascii?Q?CEzBXDMwWKH/yjvWfMakd/3nG8u1tY8QvRxONalFS7V+kGaDwPOSjkYfHv64?=
 =?us-ascii?Q?/rmIsN9sdgzWCqqnYDxjT3imqFgbtvFsbw6MU/g4khjin6szO3JFs1Z9Hp7e?=
 =?us-ascii?Q?PGeA7qnQzwGKy9ys0L26U66yp4MXrljU97B+tNDz7AmRy3QrZMhJlw/G2HB1?=
 =?us-ascii?Q?BPuOOMarb+560PVFB4DjZapcbmlI9PFXN4r4pDQF3a2gc5IxydP9m6Kh80Wg?=
 =?us-ascii?Q?HFLb9O3dumv5UkHQj1d5YBzt6o2B+aHDTXC08Zudf/slD5nnPxSNMUW3aIOW?=
 =?us-ascii?Q?JTEiLUYw+OHEsNnG3+zM6/0xMCqkyvxbbK2VzRX60VGBb964ybnJBzHF8LBA?=
 =?us-ascii?Q?lIBQOAcPpak4Ks08h52TM6HHSCsKwyTF2fLvpWjzxzblZtGIwrRZs/anQEmp?=
 =?us-ascii?Q?VK3nzoN161tPBe5p2WSWYNWBD/dBASVjv4zn6l7B6aD6JHOHLi+5XuPyk46t?=
 =?us-ascii?Q?Es3e1TjCXYMftIzgoiPEA4g9imvjOVlRSsbw8F/xKrHz5mMoC4qLm+yqX/pD?=
 =?us-ascii?Q?d0QiOwL2EIzY37leOF4Jq1xpEdmvtGNg4qbEmz3YKsUctydqo2P16xq/glyD?=
 =?us-ascii?Q?Yln6vZD0Eq4XdZ3Dfld+Qnu7J+6iNquMrzUFn5SsdoIodGRRPU8oWb2tM8xi?=
 =?us-ascii?Q?ZI/Xo+3hY6HjeX4jYCFXMbvbvOfvUs2EHxjvCMkuzP/FQQk8GCajPD9EKL7E?=
 =?us-ascii?Q?NVNDvQnhzvIVf7EH/L+C7Ulbhajus705F5cCFkZqyfpflI50x5wsPfkHojRB?=
 =?us-ascii?Q?NGZhgCwJuhMNVZHZkO4lKHwCxEtKck1fxDSkF7MRf1f178mGtQzj7C18r8NS?=
 =?us-ascii?Q?4ZwW0lZgVfzFOJStlDkLj4lTDaS+4rdpcfts0q/uIz8olFSB7+5iMdicHG3o?=
 =?us-ascii?Q?60NtmKYE9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72339833-8c9e-4374-6a50-08dedd55f5b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:59.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q+VqpnrByfLeCIrzwNbeHHiR/p+twN4eGthCUF9qXXFJWazW4TkTKUfnt0YcUCqPTm/1letQFX4yTmog4RXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

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

