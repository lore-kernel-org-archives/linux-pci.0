Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E433ADB8;
	Fri,  6 Mar 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789070; cv=fail; b=iXQ7Zrjvr8uJp4g0IjLi9ojvdelJdmIKljn1Gwzs6RriR1CxOPyQLcd8q+gswx9Nj+20ucZCkG7KFUOo9RPdQlPKOgWQbB6BIhXU57yh8SuZC3kW9MBtaazneP8LYeYepUemBkE7uDD2MYpXKujEywpi+Bwq23JybxgbjzVJrJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789070; c=relaxed/simple;
	bh=zTeGZp0zfEQUu32v4EmQqp5g3qoZRVPj1gq7AmwKn3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrcW9pXZN5b56+8vTSIVE6CwTzmwu2j/HbNoUiYhmI/FEoDe+urGXMQXujjHGTcli6kpNzL57lX2XwyFkh49C1vXLN1zzX3vqaRqg1EDeGSclpYByJoCcM5s1hypk8QuvjoE/PmFpyFIEMoBrcUINqJQ2ChSCECPSS1FuASo+ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jj3mMmXk; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jj3mMmXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfu7XVmTJwwBCHDFmBWNQRZzE/RRfNeEPj3XhN/ptyTY9dO7nxayR4QRnxzjwSXgkff6kCkCa1yqxy0XJdzP4mz5DpoRPwvSXo8H+DrUKuw7zKXw6GkzWJ6uDyn/PIUSRXPeUBwyIMl/R4tfGlXlqvM6EemtXLzwBV0DxiwwUsOmiMOVhQxSkKCt0X75z1Z8pPUbAJgIZXwLcSdljoFw/zmfbO7E/8JdRn42ONJs7bbP0n0bF2aYORfQhR4XgbfNTDkG6Y5RnpVZk/u/2GStjKLZyY4yeCkdJP5L0NQPS9TfQMiUI5sTDK+LTzXb8654Mx/s4kbJZJXAfrqCheZv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmV0pdx+57TLp0lAIs2WAuPZOLKX4reCZjTXkWetk5I=;
 b=kz6OD6MuaqAL7KqRZDbQUnUMrMarRWHfYyJH3B1EzOpcq9wwp+LidVO6tLCjx89wmS2boNy1U+wNziFlqaTa3IX3eadpmriuMvF3gVsP9fLCzAaP1Xrcy9BBt4xKUWipNJlnOdF8PykMXEl7eU0p0iGvf1w6ut3siKD6V6lZX/GDcDK9Ac+IkGNjXq4E5oy9Kdd7qLEGIHPYWpES+Ohotyc1zahUi0aLdWM6iuMwQuiVSFPE3sSJsakhrDUkKSrdtIPmLfTE6wwDR/nknnLWbp0kXE1JGI22zwo9p266owBZ6UkgTDo2e8qd7MAvrhy9wLnMsNVXBMgzfSh0oIWYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmV0pdx+57TLp0lAIs2WAuPZOLKX4reCZjTXkWetk5I=;
 b=Jj3mMmXktsw/3jC0DRguxuliR6Hu7vc/Ig+fL1FZKtBoVM1Qez2mtSjzWiWDACwYTuGRCx3BvL3TrW3zxky9o1QPiS/ZSRHhWgyjhAbbyCE5HYTU9u6Ieo24+TJ2XE3qjzf+uzAK/NqCQmEXN6qzygvcY9h8N8Aa3ToqNKemtxpEoGGU7CwEF/Dy6kAopsfsNt1eU+lzxo3ozby5GRJ00H//q1dw+8MO9Det17ye2NpKxlX8QCIwsYrtp8jkox2ie6Nn+Z43Fui2W2GnjIAeCeIm0Zlbcp3rDPmSR24Ku9h2Y5Ki9Ht49/MlcgwV8gPA3SWdokxpqFg9IqD/bYMuKg==
Received: from BN9PR03CA0555.namprd03.prod.outlook.com (2603:10b6:408:138::20)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 09:24:23 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::d1) by BN9PR03CA0555.outlook.office365.com
 (2603:10b6:408:138::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Fri,
 6 Mar 2026 09:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:24:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:24:00 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:59 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 6/7] cxl: Add cxl_reset sysfs interface for PCI devices
Date: Fri, 6 Mar 2026 09:23:21 +0000
Message-ID: <20260306092322.148765-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e2ef45-229e-4bd9-dfbb-08de7b6227c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	d98rDfMJaq2bFOom0U3YQctKxjzuIYNTJfh73KdOizIsJbR4q4/cvTCv9Kg23NOto8O7oT04Sf6gq9KY+veSaEzk8BPRvhjIV+4NqQQ0QL05KRq/W3O/nTJAJ0Cd+wD3pA7aDyZkIGxDjbcfiEI8AbEgFlrO8P2mB9UBuwJUUfL6AwhFopIUo2FwlPiswMN+ROjbgKfeqKo7xwtxIbT1ns2IJBb4rI1A4TP1a7gYT5/VPN4xyZMoroMBjsZC7gZL7ZNP0XIU65ftigguHHvWO0xAFbWmrlGh/ZY8Q5Rv+EUNjl3W3AH1I/h7+UOWIwiknWjbSGbX3IrvrdAS1yXu3izSBZXnarADq7aP4SumUVVYGHgN+vGmtzQWMgEW2C3bSky7qmNGNou4ylW4G9+zFL+6SzSXh/lTVnpSm6wtuJM6PhI4N/czrZTYH7BCTAMq4OoNz5YSPkkgqa37FYbE0hONHQ6VUdDrba+5IQMkLo2ouSAo+V7E/eIqgXfR9IeHol2GMr4zT00ne0q9JdJpeqqrZv61CZl+BMuJsJEIeZKEMxeq/0m8FcyUMleygGMQhSYLKC4thEUxBpsptBZo2DOXcVTLF37PmIQzCXuC8v2xcngc3h+TLz9w51cPFFFXHoq+W/qubdPlqGnENrkP/8zP8TlPbjwaMBBad35/MillxDLIm2XDyjC6IxPYszs67EfH5d+njkjM2YciyskmriWxnMeuvUpqNRDiG9y9pCUsz0+Urdn0O/33bKkxH2yeDC38Kcp1H2pNl9zzbnDT/w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DmkHznH7hxwLybqb9k5MeDCAJ8ZQPjN0vAV6uhOHBLdUK6ROtS28K4jClXWg6QcQtFMBzJ2WSGzwaswJXgZ3Nxk1GlhCHGi6O9S4ZApHtGSyDtYHgRYjHV3rPJ1WNb3XHR7W5byj6ZkWp515b+IMgCXB5bAtT8QcTkuS2NAOW5cGmpJ06Gnx5f0zZwqUgajF25Yhz6GjVlBhM2gTapp2jNWSCZCRI3uRgALM8lgFX0uuCs7/sJhmmK8kF4xVjW2iCph1g+f8Qelsr7rgtcPJkHyf6pdWOqygzWgIkzV6WyXOyVuXW+dYzpoxs09YVkGVICJ3QJPPws2vUbpX6p+lJO70wEITmEMzE//sGrVajyeFKat7el2B9hr0+K/6R8UAfSw3qCtFIUkCU2uftv0oV9xszMALthsIGu9xjDbOr9tUxcT0vk/YixWd7604hYaq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:23.4965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e2ef45-229e-4bd9-dfbb-08de7b6227c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add a "cxl_reset" sysfs attribute to PCI devices that support CXL
Reset (CXL r3.2 section 8.1.3.1). The attribute is visible only on
devices with both CXL.cache and CXL.mem capabilities and the CXL
Reset Capable bit set in the DVSEC.

Writing "1" to the attribute triggers the full CXL reset flow via
cxl_do_reset(). The interface is decoupled from memdev creation:
when a CXL memdev exists, memory offlining and cache flush are
performed; otherwise reset proceeds without the memory management.

The sysfs attribute is managed entirely by the CXL module using
sysfs_create_group() / sysfs_remove_group() rather than the PCI
core's static attribute groups. This avoids cross-module symbol
dependencies between the PCI core (always built-in) and CXL_BUS
(potentially modular).

At module init, existing PCI devices are scanned and a PCI bus
notifier handles hot-plug/unplug. kernfs_drain() makes sure that
any in-flight store() completes before sysfs_remove_group() returns,
preventing use-after-free during module unload.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h |   2 +
 drivers/cxl/core/pci.c  | 113 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |   3 ++
 3 files changed, 118 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 007b8aff0238..edd0389eac52 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -136,6 +136,8 @@ extern struct cxl_rwsem cxl_rwsem;
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
+void cxl_reset_sysfs_init(void);
+void cxl_reset_sysfs_exit(void);

 enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_LIST,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c758b3f1b3f9..3a53d4314f24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1293,3 +1293,116 @@ static int cxl_do_reset(struct pci_dev *pdev)

 	return rc;
 }
+
+/*
+ * CXL reset sysfs attribute management.
+ *
+ * The cxl_reset attribute is added to PCI devices that advertise CXL Reset
+ * capability. Managed entirely by the CXL module via subsys_interface on
+ * pci_bus_type, avoiding cross-module symbol dependencies between the PCI
+ * core (built-in) and CXL (potentially modular).
+ *
+ * subsys_interface handles existing devices at register time and hot-plug
+ * add/remove automatically. On unregister, remove_dev runs for all tracked
+ * devices under bus core serialization.
+ */
+
+static bool pci_cxl_reset_capable(struct pci_dev *pdev)
+{
+	int dvsec;
+	u16 cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+		return false;
+
+	return !!(cap & PCI_DVSEC_CXL_RST_CAPABLE);
+}
+
+static ssize_t cxl_reset_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
+
+	if (!sysfs_streq(buf, "1"))
+		return -EINVAL;
+
+	rc = cxl_do_reset(pdev);
+	return rc ? rc : count;
+}
+static DEVICE_ATTR_WO(cxl_reset);
+
+static umode_t cxl_reset_attr_is_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pci_cxl_reset_capable(pdev))
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute *cxl_reset_attrs[] = {
+	&dev_attr_cxl_reset.attr,
+	NULL,
+};
+
+static const struct attribute_group cxl_reset_attr_group = {
+	.attrs = cxl_reset_attrs,
+	.is_visible = cxl_reset_attr_is_visible,
+};
+
+static int cxl_reset_add_dev(struct device *dev,
+			     struct subsys_interface *sif)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pci_cxl_reset_capable(pdev))
+		return 0;
+
+	return sysfs_create_group(&dev->kobj, &cxl_reset_attr_group);
+}
+
+static void cxl_reset_remove_dev(struct device *dev,
+				 struct subsys_interface *sif)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pci_cxl_reset_capable(pdev))
+		return;
+
+	sysfs_remove_group(&dev->kobj, &cxl_reset_attr_group);
+}
+
+static struct subsys_interface cxl_reset_interface = {
+	.name		= "cxl_reset",
+	.subsys		= &pci_bus_type,
+	.add_dev	= cxl_reset_add_dev,
+	.remove_dev	= cxl_reset_remove_dev,
+};
+
+void cxl_reset_sysfs_init(void)
+{
+	int rc;
+
+	rc = subsys_interface_register(&cxl_reset_interface);
+	if (rc)
+		pr_warn("CXL: failed to register cxl_reset interface (%d)\n",
+			rc);
+}
+
+void cxl_reset_sysfs_exit(void)
+{
+	subsys_interface_unregister(&cxl_reset_interface);
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b69c2529744c..050dbe63b7fb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2542,6 +2542,8 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_ras;

+	cxl_reset_sysfs_init();
+
 	return 0;

 err_ras:
@@ -2557,6 +2559,7 @@ static __init int cxl_core_init(void)

 static void cxl_core_exit(void)
 {
+	cxl_reset_sysfs_exit();
 	cxl_ras_exit();
 	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
--
2.43.0

