Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C635674D;
	Fri,  3 Jul 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116330; cv=fail; b=JReBXGdqg3Sv4cXMToTbY0BB2+XBrcH6nzcAVnGRL6nrZ16o5UCodSI7tQ9zgULhobkd/XJB2PxxlMKeT3JFh3v/nGZV2y3jv6Yh5hccggR+X9NiWuT3CoxXqIQrEGryCaPSypYuhFUcJWHpvaNW3Sc22yfvYgTX/pp/yeY/Wdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116330; c=relaxed/simple;
	bh=gXa2mvMazSS84s9F148ZnJrHuZjy75pTgCYsF2f8nQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HE7gSXP/iwjNRAvW2ok0+UVRd0xWboqK+fmuraYD36bZALyPY32QtE1tc0Bev4YiiAe/o9c2QLMwIVAj5NCwQeduMCrLkIOwnx+0/zMy4BMWpyZAF6Fw8bsw9/PptJ6yzWoJDKwmIpzhT19W9W1mOpK10wvP4Jamm6hWY6hpKaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvNUnCLk; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvNUnCLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbbzqn1S5UzOIl199z5l3MclbZT2fobaB2IoUE5/u7vCktCrqsu8erwXwwIWNKrNjJBmEc867noKBuQfobLzuvGHhJdzCiTUiTg8UWVSAHCe4GkknbVxvH3pM+vGLKK0gVbal+I4x6j6f3tbYF2agbyS3lGENjDC8fcKjEvZdRiulZ5KN+83toPJ3J/2/JCmvyA9gs+RFweiU1nBEz2UGqlGVlIXSthfFdmfr059sWnv6xhibGKyv91xyYHxUHHsRFi/x4HUkGDesYrJQHvdYK5iR7hP6zAYDJII3p0tlpzVU4errATsdkbloJQYwXlWj9WdMNwU3+QCtfjT/CMpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A03W+Gcp7H6GpHsu/GGMLYLzAgnTeFh0XDnLjYOMP44=;
 b=IcrV/au/X+/LWKSPpXechsyAEeXJo05fC8QOGAgJl7z/JUxRI/PA6igU4JPLdUCxGrptkJ5zExv75lhV8mCbitZlXNOj5r/YWWbkHnNewuRxiKwBGJgP4C1Pur2gH55gRJukJUT5fPEQPwKBJqMTN1j7CqNKUOtX+92pJiYPUyA7JcZAzT/gTuALs8n9dNKVTZ4lvJS7iaKrCYS9/ylGPfTyWlbys8o8kPggzolZNkQOqU/LasjoIUCwprFJHakzLZxdmHvqH38EW6uuyoXLzUvZmtDWchKzQKbMCvsbAczyJgqEHA/nuoxPxYu0JBgbJ9KbLBmHyRaPI4rcFVAxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A03W+Gcp7H6GpHsu/GGMLYLzAgnTeFh0XDnLjYOMP44=;
 b=YvNUnCLkW1t4ChK3uolampvcH/0ToGk4jooSPNzstZvy8aSc+W61C/duSBmHsQDs9b/G3ZvLAyPmpQqmqTmTwzMXkN3QII2A3imz3tKTD2cCKVM+UnaiquMSqMbiWaUAvZwzlxRkoxvWbFf9kjgYsIyZGqzCYYxZjHW0yC+zYrSzBi1553cv+BP7r3JQTlEb+QEZHPZ25/Zrne1CH1qWFoOa68/sMaGa60TZP22JeGZsb8I9Tah2IpkV8No5h4QbkhywzhMt7RZAplfoyMSEnM7yBrw9M+zQESQLiQnjs8TTlv8nOplyk96Wi0lmD9XNoEHG1pxbdVGkw91Ks78WtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:24 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:24 +0000
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
Subject: [PATCH v8 05/10] cxl: Add CXL Device Reset helper
Date: Fri,  3 Jul 2026 22:05:03 +0000
Message-ID: <20260703220508.546528-6-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::10) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ffb4bc-7b23-4110-4443-08ded94f2e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	zPMSXS+SMe1shwWxK4oPgWqVdqMJjIHrpaFC6cbu205deVAtsBDGp4NdNaTF3+DXtcjG1zGF+T/GEUAq0uRm2tsIhHLT83DECdrohBrnnWxqJn09TCHzGWV5And5DBiWiqGpUeCY3L3n/IzJEzDcGbgE9SQ9/ja3l1YE0Tl29Cli38BKLMeVUwtjyZ8G6QxispMFkqg9sFLIZZX7NpwYD3OlOfOoo691m6G56fahtE9UNT3QJAcBlt4ccQXjhkr1z3pEXKmiTMktlC1AzNVSPcur0gYoLnRIimmFMIC6j6ZgzloHaKEh/AJqLvr0SOCpzikJqEX8LMOe3WIzZDyxM2fkogZ44hlUyt22lawScESgHcf2ggIaA6d6DIArvikKjw6VfMnG6y8Dq8ylf/n2cVEMf5mHm7k04YS0dIe9rYcTdREU2pMb5RvGIQT5F1HvX12NU2n8+ietQpiwBrWBR/lKBx9rlQCz3I+VpwBDOLn7viX4Ej+AoObgxl+bJm0T6GExRgHKu3r3fU9DuGYUWumc9k00ISvkVErcBYXnmQwsVtCJci0xYbMu+KDGQfDWUpJeHSGK2Be2621f6f6RkhYgFVO4KhMtq0+bevdPiXPefeXviEc+/iyRaUkiQWi2b5TEK+Im/8UBhP5OecTjsDMeAnYmcsNRQyWl0KIcco6n8AhE0HNnhg9edGVSzGNDtHRzTRhL+jHn6uSa+qHFmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qa7AwybtBzd/ySw0/lAqKF8Hrx5prQvddMjjmSzC9fCn5n3Vwi0g9gNcQhs5?=
 =?us-ascii?Q?A5QQgsfD9MoMAWrPLpdV4zbMkJSbbMz6WwyBFafFneANFeeYgFK4enMCfJow?=
 =?us-ascii?Q?bsodqY4RyqhU00aAGZOyQEwftSxe4uJ9CKShqGdCWUdJk6s+KPQXQIFyyTr1?=
 =?us-ascii?Q?6LRd00JyjEPf2hXPhmHeZOZlCcJKxUzpeYKWslLFw3FQ9VC4wzr9dM+huO+e?=
 =?us-ascii?Q?0fQoL6Y3HNvJFFJau6LSBBXXCHoxA8tK49gFYS1S0yeUBk3DqEzgllkrf08Z?=
 =?us-ascii?Q?618cxERKT8gXdJiN/eO9GmGSR/2L3+suak8onm1JsCukA3IDJomcB2LEjc4v?=
 =?us-ascii?Q?YRIlGrbw8qBct3UjYTDBWoZwjxju5mF4uipVnZVc52Q195pj2ZDpjGpdPGi+?=
 =?us-ascii?Q?I3zrcjYLCWioXG/45R3E2Yx4v6rJe4Z22GgfF7VTgPp6ZZdbaHQobUPh2g49?=
 =?us-ascii?Q?f1c2Xuckp38spLLw/M6+/IyRznB9iz/ozfeNWzxX8aCvVT+SFb1EbaKVxDYR?=
 =?us-ascii?Q?7wOPMFaBliGqdCR9PIA+4Vs+LMPABSRmsjo/sPk8P4nVXhRehD4ZeRkzZSiQ?=
 =?us-ascii?Q?jCLbIXi/SGhX/1jP2IvNK7e5TXuof7Hu8m9bs6NQfgQAeM/S2/ia82HOnEaK?=
 =?us-ascii?Q?siJ8DvRrmHRp1FcbslRw4R0ys7IIuAkD3mHr6XkfCZz8UT6EtakthEepvJLj?=
 =?us-ascii?Q?tRkW3QSW1uoQFU+Uu3CbN0fNXmfzlAzSeWPAlemGiQ+/GdW29FIy/7VbnVT2?=
 =?us-ascii?Q?S5ya79LUuqNaECOrkMKuMWrFjvrV7e8H8F4lBEGQsD6wb2feaCTz+oZNTe0E?=
 =?us-ascii?Q?lezKGTZzHJdsgZ9zZw7y99HtXmCRKoBvXgRdJeEAy4bmLjj6Ji/U/hjkaCWL?=
 =?us-ascii?Q?ymsUZ6idesBzIZhLJET+cYJRK6Pm51MQBYSTn7dAVaGg2ozzMQ5K8peoHCBz?=
 =?us-ascii?Q?uyj+rC2OpaZTJcmezA5WLe8LhnACnPr5cmFUGV68RSO/BK2sfENDeYJqxL/H?=
 =?us-ascii?Q?1En9CI0i9v4LiohYIzkj3PmBi3fsa6evQBopcU5DHOExbQI1r/ENxOl/hi0w?=
 =?us-ascii?Q?Nxhi9wxMwlnb/OLGnjRMwvh4vjTY53F+mk6VHiTLRzr8h38MvNkeQvNTSvzZ?=
 =?us-ascii?Q?6JD6GBsuevN+mDyecAZOboFHBAwiLnVme4gW3aH49EIKSEFOI40b+UsCFR9l?=
 =?us-ascii?Q?qT5vhncHq6ahgx5Bdpk7sO/+srUcJNIBdSaTVk2EkeHydmX3IGgpaAoi0voS?=
 =?us-ascii?Q?hjnHqqEUPudPzJtvq+5I2K2cqUnqZXxzP4Tss/MzcdcorAjc/kcsR193XUIs?=
 =?us-ascii?Q?q0SUL4L4kZQKHXpNowej+0lzkpsKzJbzaVrBC1C9OOIACC+IC5p9lcmpCUfW?=
 =?us-ascii?Q?ZeceNDOLCpgj+h+XBksycRfdu+LRUcpLKGtmClv0zVGMVjQLLv7gr36njIIr?=
 =?us-ascii?Q?Jehn/T0+mDrpMlwRC2xl47O5Yb3VDgkHzQkxktlUIZbgZd8PwdfsUvGgnU5d?=
 =?us-ascii?Q?mtrwkaJZ2gL4R6X72FyjBvP6yiJ49B5kuJfKobzBNHdeJkipZeI13ZUJNhb+?=
 =?us-ascii?Q?5lJczYaWiL4xRhwvtnashytLWeCISjo3mS9oXzOa+/d2Ejm1QC9thNrQnR/M?=
 =?us-ascii?Q?F/Lcn/6yc6MOew2Aexm/6YNcZkKm+030mWTtz/D/rzeuQPSqIF0oFy4+w1eu?=
 =?us-ascii?Q?3oTCvFzs78PErJSMzY9Kd611fp/ZG7jmmiqkJCz8tdwBJ1WzjwoZTcQIk297?=
 =?us-ascii?Q?ukaoPxIfbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ffb4bc-7b23-4110-4443-08ded94f2e7c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:23.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkRh2/IOO4VLVe5+YAg9ffTA/KAlzglvKbLJud0L/0L/XcNRrJMF/lcNF4MRLngVZZDIOSHTBa/vjEInL6aylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback when supported, initiates reset with Memory Clear disabled,
waits for completion, and re-enables CXL.cache on exit.

Leave the helper unregistered until range validation and reset-scope
validation are in place.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c      | 224 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 ++
 include/uapi/linux/pci_regs.h |  14 +++
 3 files changed, 245 insertions(+)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 97b72cc67b6b..7a9b1ecfadcf 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -7,6 +7,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -449,3 +451,225 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 	if (rc && rc != -ENOTTY && rc != -ENODEV)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+static int cxl_reset_dvsec(struct pci_dev *pdev)
+{
+	int dvsec, rc;
+	u16 cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if ((cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
+		    PCI_DVSEC_CXL_MEM_CAPABLE)) !=
+	    (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE))
+		return -ENOTTY;
+
+	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
+		return -ENOTTY;
+
+	return dvsec;
+}
+
+static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
+				  u16 clear)
+{
+	u16 cmd = PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST;
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	ctrl2 &= ~cmd;
+	ctrl2 |= set;
+	ctrl2 &= ~clear;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
+{
+	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_DISABLE_CACHING);
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int remaining_us = CXL_CACHE_WBI_TIMEOUT_US;
+	u16 status2;
+	int rc, rc2;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return 0;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		goto err_enable_cache;
+
+	do {
+		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
+		remaining_us -= CXL_CACHE_WBI_POLL_US;
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc) {
+			rc = pcibios_err_to_errno(rc);
+			goto err_enable_cache;
+		}
+	} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);
+
+	if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
+		rc = -ETIMEDOUT;
+		goto err_enable_cache;
+	}
+
+	return 0;
+
+err_enable_cache:
+	/*
+	 * DISABLE_CACHING can be rolled back here. INIT_CACHE_WBI is
+	 * self-clearing on completion, so leave any in-flight writeback alone.
+	 */
+	rc2 = cxl_reset_enable_cache(pdev, dvsec);
+	if (rc2)
+		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, cxl_reset_timeout_ms[last]);
+		idx = last;
+	}
+
+	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
+			   CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc || status2 == U16_MAX)
+			goto not_ready;
+
+		if (status2 & PCI_DVSEC_CXL_RST_ERR)
+			return -EIO;
+
+		if (status2 & PCI_DVSEC_CXL_RST_DONE)
+			return 0;
+
+not_ready:
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	} while (true);
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
+{
+	bool cache_disabled = false;
+	u16 cap;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (rc)
+		goto out;
+	cache_disabled = true;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
+				    PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+	if (rc)
+		goto out;
+
+	rc = cxl_reset_wait_done(pdev, dvsec, cap);
+	if (rc)
+		goto out;
+
+out:
+	if (cache_disabled) {
+		int rc2;
+
+		rc2 = cxl_reset_enable_cache(pdev, dvsec);
+		if (rc2 && rc)
+			pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
+				 rc2);
+		else if (rc2)
+			rc = rc2;
+	}
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec;
+
+	dvsec = cxl_reset_dvsec(pdev);
+	if (dvsec < 0)
+		return dvsec;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2215fe1c3f78..de58f484b7d9 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
+#include <linux/errno.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -153,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 #ifdef CONFIG_CXL_HDM
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 {
@@ -161,6 +163,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
 static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 struct cxl_reg_map {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..194ae56b4404 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1349,10 +1349,24 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

