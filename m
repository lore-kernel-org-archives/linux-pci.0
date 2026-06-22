Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B941F09A8;
	Mon, 22 Jun 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157520; cv=fail; b=BuB4Qhky1IsupjW7LRP1AaKGLZ+1DU8x9se9a1D2VH7JXmrWpbZIlwksE8hENjyM7l4PIlzcgSHC42fw9/PtZn50txsWv6wJ6H/NXwXQKoPyt0G7j8jUH7yf+2xW90jYhKHVUIkeLPBhhw4SbH8GXCgHAo/ncTGZqPmZDNJX7jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157520; c=relaxed/simple;
	bh=vpRITdSoklbiSi0w6lkTQWoWKTuaBuV8u3q4/cfvqYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crxylOTYeUb5K2H/oWBYe3acd2X5D8qi8zoOBmMUPOOWEWLfn5HzZK7gE80ZREIXtsdtFkmJIJP+X+7rJqqfXoy43kv0B1Vp+jkuGmMbvhA/ro4GPgh0AA6VtPi/HiAet0CWEt///l+1nGgvfIQm4xdM3lbDFQHtWt+Eyfx2D1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdJVTJcn; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdJVTJcn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUtAydg3+cfdIQ0dvtvE66unYrA5qQOiPNn6ruPpb6w5wn/++a6Q/LQGs0USVOXLwt/T4w+73l7Byzaz0oNMIoHnGh0znVaAcEXqGYUdPL038GKnOYc+HxIW+NBEGnyiyu4ScKj8zrfePq1GUjjNxX7GzmHBzTWI2ZQnwfbMVAHEBu/gw1ftNl7dZspZdgZxkgtEoXcyYfX84Txm1Jp/9RQKO+C1KUmqCOtFLUQR3HUJdl+UVvw2clY0MsVnwoDNWi37R8h6ek+dp2tLYqvOdb6vD9173TmrD0VhSfdd4TDqSrA0JPXjQVRKHJzPDeLl7V2HfIoe3CQQeVskiFk8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YbcvYEhMf86M11vE2pQBCzqVwZsLBshsoi8e/9FKMY=;
 b=okbQEGJbZ6dYOyVbqJkCpBNKi9E5V5ww7Pjr3Cvstsl91BNEDT4n2iQC7rB9Wu2YWRMVLwUPjOlZSfk7Evsdyv1zsLiruM97Maaq10VOq5jLBWNMewg6RL2q+DIC3KeLZ+HqjZkbInBLgXFvq01O++NIl4lvfksl53i8+buZF0F0NThHFhO/B2LUjIvZnhk/Al+P17xZ3fGw+TlgikSK1BLseR9e9oa5+QOHcoTN0rvoPtRL2/m6l/im1ng2hp8Uc2ONEsEdCGiLWJ6iUAn5AHcaA40Ip+2cPu7DcGuJAWTMCSp9LEZygIRPA64t7452Gy8nMI2g3J1jRWJO9pREYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YbcvYEhMf86M11vE2pQBCzqVwZsLBshsoi8e/9FKMY=;
 b=ZdJVTJcnwcxBs3gACCqRtIFUJGRskjAc/jz0CpkWegYRJPMTDzl1jxjuBkQROAMVOU6jr/mRH+Dd/OkvESTPdulGbn9xcIwof+CNdaHiiigakJZQ1iJCxwUp8qWoitEyYNg4YxpTXrwmHrqS3eQZS4Wp8085uu2KQecJk84KjJGBOVdF75ggP4YbLN+jVuCCbY9a9fhpHZPF7UI1EpG+lWbbBgZ02GN0h8SE1iWHcrVaio8y0O1xjs0tlZPoGDmAJuIdIcrfNnwEpnNUR3JoFVXHsb6Cezu1XSWvpFWtgMv+c+6s7e6VVLYX6mh/8khjtBPhOpFLXiHDMyCm8Gfh8Q==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 22 Jun
 2026 19:45:06 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::44) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 19:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:45:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 12:44:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 12:44:42 -0700
Received: from inno-dell.home (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 12:44:34 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/7] PCI/IOV: Return u16 from pci_sriov_get_totalvfs()
Date: Mon, 22 Jun 2026 22:43:47 +0300
Message-ID: <20260622194353.1308872-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622194353.1308872-1-zhiw@nvidia.com>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 1550b537-d4be-47fe-81cc-08ded096c2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XKbeaKo8OV7FkyBDKAGTSJ0p1RSXQobVAEIeIeIMU9ajx9vAf9HextYoJjFAlJpHRFB4SuCRaaeI1R+PhY0MihZU+sBE+k4/eodoolS4+yZ/rHl4CBs/MYGywLYFB+C7GO/TZDEkZIWxEd1UayY7lkxqIdyJ8RqIyPn7Xq2ntLEcdsYq9Ihkzlod3p/aZQchv1xwwLX6dPyXbYPrdergnN2exdyAa3FfcFz8K/2Ss/24wOEcg1AlYwy60bTH44VZ+Mko94CbQcePBpxj69QhtgNQbCWkrCVRlMchS2uJ7XSnfRFVdBxawO49jbnuZmFZ5IOlRLBVzK7adimQS0SEPzXp96T+as+1DWbJUy0DG9txc0M9cbUuohnNwDj9FVfBtrQVs16d4SoI9yZ5kUMHXJr2l6piBf6/EGrZIUZ2v/I++6R+jvCpmttUJ+mNRBIZFfpDZvDrMrXEnhuLpFbwPROeGfyLvJLZHD60Uw4x68qGEYZGdINt2nK+UZMfSytdRaU4oRJ2jYyI1vMd3XQDpp67LhosZxiOMcFFputSM1mjAN6gjNGwAxEt2t0EWjCIpU6kpNomXHBLcR7xMr+jfKmVNY2/ohGoHJgFgMH8SerqSFCBrj0LqqUm8DCE/GFU/k4lsMYmp6YC5tD5atb3eVOZ7ivp/gPXe/TaS0dHUJahYj+OdvpDFonJMTsVbINvHVqD9jyjC7J5m0+ao5qLHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	du8EOaGhHPrCObt5I1HKrCbYrQsl+3k6G/Qt0DsjOjZvlag1TjVnnl0rp+MetWGET6fVBDWbXWT8SLqHIczZFDYkRaKuyTn6hqRSdCh5aVNNLdTc3dsyX5ExXNOjyikyTeDGVs2z61FyaDarGtgzl3NZiWC32qTGnNhHLfPN094gl6TdPS09ZuVMZ3DrQB0RhvRkJbJqckmFwnVYpobuFzW11g7Vsx3kEr7CN0VCEesQfA7TR9Bc5Jb0b/rNxTYlcRI+pdyRt42UujE4K7dST7Pu0z2v/Tl7HuJOximIou/jEMfINvZ8xW/kZKutPcThSsQJnZsstY2aUR8uxljYo36YMdhuKq4u+KgO7e5y8oL3rXGRLOUVEcAwY5GHbHqTz7Fp+QVNKXaO4SZpA0hijSrklKvn0Vt0im6PsyhK39r+OD+uG8F8rYKILcm/gLnO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:45:06.4186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1550b537-d4be-47fe-81cc-08ded096c2dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

pci_sriov_get_totalvfs() reports a VF count, not an errno-style
status. It returns 0 when SR-IOV is unavailable or the device is not a
PF, and otherwise returns the PF's driver_max_VFs value.

driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
from the SR-IOV TotalVFs field or from a driver-provided limit, so the
implementation cannot return a negative value.

Change the declaration, CONFIG_PCI_IOV stub, and implementation to
return u16. Update callers to store the result in u16 variables, remove
obsolete negative-value checks, and use unsigned format specifiers where
needed.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/crypto/hisilicon/qm.c                   | 8 +++++---
 drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
 drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
 drivers/misc/genwqe/card_base.c                 | 6 ++----
 drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
 drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
 drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-
 drivers/pci/iov.c                               | 2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c        | 4 ++--
 include/linux/pci.h                             | 4 ++--
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 3ca47e2a9719..13b45fcb582b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3878,7 +3878,8 @@ static int qm_func_shaper_enable(struct hisi_qm *qm, u32 fun_index, u32 qos)
 	struct device *dev = &qm->pdev->dev;
 	struct qm_shaper_factor t_factor;
 	u32 ir = qos * QM_QOS_RATE;
-	int ret, total_vfs, i;
+	u16 total_vfs;
+	int ret, i;
 
 	total_vfs = pci_sriov_get_totalvfs(qm->pdev);
 	if (fun_index > total_vfs)
@@ -4188,7 +4189,8 @@ static void hisi_qm_init_vf_qos(struct hisi_qm *qm, int total_func)
 int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs)
 {
 	struct hisi_qm *qm = pci_get_drvdata(pdev);
-	int pre_existing_vfs, num_vfs, total_vfs, ret;
+	int pre_existing_vfs, num_vfs, ret;
+	u16 total_vfs;
 
 	ret = qm_pm_get_sync(qm);
 	if (ret)
@@ -4203,7 +4205,7 @@ int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs)
 	}
 
 	if (max_vfs > total_vfs) {
-		pci_err(pdev, "%d VFs is more than total VFs %d!\n", max_vfs, total_vfs);
+		pci_err(pdev, "%d VFs is more than total VFs %u!\n", max_vfs, total_vfs);
 		ret = -ERANGE;
 		goto err_put_sync;
 	}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
index 8bf0fe1fcb4d..317b80c1772f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
@@ -52,7 +52,7 @@ void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
 static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
-	int totalvfs = pci_sriov_get_totalvfs(pdev);
+	u16 totalvfs = pci_sriov_get_totalvfs(pdev);
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	struct adf_accel_vf_info *vf_info;
 	int i;
@@ -148,7 +148,7 @@ static int adf_do_disable_sriov(struct adf_accel_dev *accel_dev)
 static int adf_do_enable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
-	int totalvfs = pci_sriov_get_totalvfs(pdev);
+	u16 totalvfs = pci_sriov_get_totalvfs(pdev);
 	unsigned long val;
 	int ret;
 
@@ -237,7 +237,7 @@ void adf_reenable_sriov(struct adf_accel_dev *accel_dev)
 void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	int totalvfs = pci_sriov_get_totalvfs(accel_to_pci_dev(accel_dev));
+	u16 totalvfs = pci_sriov_get_totalvfs(accel_to_pci_dev(accel_dev));
 	struct adf_accel_vf_info *vf;
 	int i;
 
diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c b/drivers/gpu/drm/xe/xe_sriov_pf.c
index 33bd754d138f..1a1c4978e5f3 100644
--- a/drivers/gpu/drm/xe/xe_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
@@ -58,10 +58,8 @@ bool xe_sriov_pf_readiness(struct xe_device *xe)
 {
 	struct device *dev = xe->drm.dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int totalvfs = pci_sriov_get_totalvfs(pdev);
-	int newlimit = min_t(u16, wanted_max_vfs(xe), totalvfs);
-
-	xe_assert(xe, totalvfs <= U16_MAX);
+	u16 totalvfs = pci_sriov_get_totalvfs(pdev);
+	u16 newlimit = min_t(u16, wanted_max_vfs(xe), totalvfs);
 
 	if (!dev_is_pf(dev))
 		return false;
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 86bfa82723ff..259d2f9c9416 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -360,10 +360,10 @@ static bool genwqe_setup_vf_jtimer(struct genwqe_dev *cd)
 	unsigned int vf;
 	u32 T = genwqe_T_psec(cd);
 	u64 x;
-	int totalvfs;
+	u16 totalvfs;
 
 	totalvfs = pci_sriov_get_totalvfs(pci_dev);
-	if (totalvfs <= 0)
+	if (!totalvfs)
 		return false;
 
 	for (vf = 0; vf < totalvfs; vf++) {
@@ -1132,8 +1132,6 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 	}
 
 	cd->num_vfs = pci_sriov_get_totalvfs(pci_dev);
-	if (cd->num_vfs < 0)
-		cd->num_vfs = 0;
 
 	err = genwqe_read_ids(cd);
 	if (err)
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 0ec65ec634df..33faa40381d3 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -98,7 +98,7 @@ static u64 nic_reg_read(struct nicpf *nic, u64 offset)
 /* PF -> VF mailbox communication APIs */
 static void nic_enable_mbx_intr(struct nicpf *nic)
 {
-	int vf_cnt = pci_sriov_get_totalvfs(nic->pdev);
+	u16 vf_cnt = pci_sriov_get_totalvfs(nic->pdev);
 
 #define INTR_MASK(vfs) ((vfs < 64) ? (BIT_ULL(vfs) - 1) : (~0ull))
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index ed302f5ec476..21cc5113ab92 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4441,7 +4441,8 @@ static void be_calculate_pf_pool_rss_tables(struct be_adapter *adapter)
 static int be_get_sriov_config(struct be_adapter *adapter)
 {
 	struct be_resources res = {0};
-	int max_vfs, old_vfs;
+	u16 max_vfs;
+	int old_vfs;
 
 	be_cmd_get_profile_config(adapter, &res, NULL, ACTIVE_PROFILE_TYPE,
 				  RESOURCE_LIMITS, 0);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index bf6f631cf2ce..7087f1a4d364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -298,7 +298,8 @@ int mlx5_sriov_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_sriov *sriov = &dev->priv.sriov;
 	struct pci_dev *pdev = dev->pdev;
-	int total_vfs, i;
+	u16 total_vfs;
+	int i;
 
 	if (!mlx5_core_is_pf(dev))
 		return 0;
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index f98f1707d1a9..5b339b055761 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -263,7 +263,7 @@ int efx_ef10_vswitching_probe_pf(struct efx_nic *efx)
 	struct net_device *net_dev = efx->net_dev;
 	int rc;
 
-	if (pci_sriov_get_totalvfs(efx->pci_dev) <= 0) {
+	if (!pci_sriov_get_totalvfs(efx->pci_dev)) {
 		/* vswitch not needed as we have no VFs */
 		efx_ef10_vadaptor_alloc_set_features(efx);
 		return 0;
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..db9828bfff52 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1277,7 +1277,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
  * SRIOV capability value of TotalVFs or the value of driver_max_VFs
  * if the driver reduced it.  Otherwise 0.
  */
-int pci_sriov_get_totalvfs(struct pci_dev *dev)
+u16 pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
 	if (!dev->is_physfn)
 		return 0;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 31a02e7fd7f2..4b032b757ee9 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -796,13 +796,13 @@ static int octep_vdpa_pf_setup(struct octep_pf *octpf)
 {
 	u8 __iomem *addr = octpf->base[OCTEP_HW_MBOX_BAR];
 	struct pci_dev *pdev = octpf->pdev;
-	int totalvfs;
+	u16 totalvfs;
 	size_t len;
 	u64 val;
 
 	totalvfs = pci_sriov_get_totalvfs(pdev);
 	if (unlikely(!totalvfs)) {
-		dev_info(&pdev->dev, "Total VFs are %d in PF sriov configuration\n", totalvfs);
+		dev_info(&pdev->dev, "Total VFs are %u in PF sriov configuration\n", totalvfs);
 		return 0;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1994a88afbc2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2538,7 +2538,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-int pci_sriov_get_totalvfs(struct pci_dev *dev);
+u16 pci_sriov_get_totalvfs(struct pci_dev *dev);
 int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size);
@@ -2590,7 +2590,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
 static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
-static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
+static inline u16 pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 #define pci_sriov_configure_simple	NULL
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
-- 
2.51.0

