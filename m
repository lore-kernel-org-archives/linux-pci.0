Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA73612DB;
	Tue, 29 Sep 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703253; cv=fail; b=TvDvJ+m8vLJapopbfSS/fYmKxQuTR/T11eM66WTGY24cgoyYFp+qStYG/XIkotbbFEvprd3wR1sFGMP5FEK81PAruBe191Lwgm4qz0wGOjG8TZC92LgvQO8YY6lGN2z+sPK6uKwq+ImW1udzSXd3vY84eWOtL8N/87P9nMU9WHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703253; c=relaxed/simple;
	bh=qDARIMshi45WM6zciVnwkG5aqw4fSyzraZ6K6kgSfI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXPCET6Us87tLLutoF3kJsmWw769YOV1P9CMd86DpOTfZ1V4IN98W9lDIpvNquIOPO60tKWrZH/w8LGzp39EAPFALAilvufVu2rqWwTGUTla/ASS5n6IbP3hUz90SMklw99AsfJXK4/2osfbambkfhOHKjolqB9CuoEz/goXaaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CC1Xp+2S; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CC1Xp+2S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRGm/e960faoCzsbw33lWwcn1MEhygSckJR30d6n7zG7x9n2kviBScQmBWHLwfuiVVb2/5Tx5UqxGSo62JILPohmqXxqWtOAFQupbMXHGQ5VCbN8xzjo3KzWPA5bH3pQySkRSf+Weo3gtnttbMnUc8lVUKxt4i7tzQzhpRVgt+nqn6Qr4/SurK5mQVgiJqf1fmuAyp+s+nuPpkepS+N+NCDrRHr068QsR9fq+Lj3PRldgqVk0nPHwuCiYCd43r7URz0CW1hCDYt4AZN4bIrya5gf6HyK2czuRosHQI7mdyjmlti9tM+Moq0vn8zMXLZE8kVv3q2O6sQGfppc7rcUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSKkv150WYs6cSNWoYyBruS2GWEkncBmYHDVa3AgTCA=;
 b=pQn6lOvbVk+iO9zJ075ZcwbgOXG9QhHkOZtglu9cu0tKo6UG4ygxAKgaOWVaRJdIcXfJ8UzVpfCAs1398gOqTxnlrJUJQtrHTlJaIC+4awT6cl1pavj07FuT0Jjvh1WB+rVTQibIQKbn6ZXpyiJAewKTp/vBsKF9M7EH2pzUWnob1GZ4Mxt6ouGlSZcrzYyMC99gktoKfJL+3vp/T+ORY3TSR5SXZGxNpzD+PdGkBIWrhQ0tK0GolDWrIoWMFC6Knm6BxBQhwmOvBsKAteTfADWZmOgf2d776vXA8Rls4TabKlZHPh4hF16OaxAONC7KF5EIIIWsnQ/sQyepG80YDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSKkv150WYs6cSNWoYyBruS2GWEkncBmYHDVa3AgTCA=;
 b=CC1Xp+2SExuf6gL4M7jR5YlVik2ec7rH7yTUpmOJCfHp80zAEQPoXMx4tI+xsM5ZXGuyFiXbO9GQygeXW4t9pVXdEF3QvXnWKk+D6esZD3j9VHPdjbGO3qEfoCciyGyPFg3kIsrH12ab9ru3NEDSaWniFT7+tLtufE1KccPwS4fTGKJLUZvnTes5vA6imcSjMqEH2w+b/ERyub8jZ7yonOGErC1MHdXioHMMlD9FE+BerOwm0+6rVzwjmhAXpeNYomjt8LBMXL8eitldyNEzy5JjPhkYZMR/koVVpaBqyl8qv3Zkl3qOcA9I5fTEzbXNsjvPsCdszqXskhQ946ZhfQ==
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:04 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::90) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 17:34:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:35 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 04/16] vfio/pci: Gate BAR and ROM access
Date: Tue, 29 Sep 2026 18:32:53 +0100
Message-ID: <20260929173305.204856-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3351dbf4-ea75-40ad-1c8d-08df1e4fdb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TK4pvl/jMeWErbe6riAvG+3+TXqtKpK3s96Rw5k6/e34xlA1NtLTxIKa/otMQhUQAHg6TopPfrs5tQEzX2U4BOj58o4pJEkgNZp04U7BgInIg+ZFudlNobYEGxd6n99YXDkV8a/cdRCE4F8xo25N97QJIT9E6dggO9g9tYnlb3S7QVFkQNjrCxxF1MVonDt7eKYl5RauYCflcAU+SdlS2oUn0SOZjisrEKFH+cAluVfDlH3B5XFEwVpJOQ45cMBnQ8WEpTWVFdfIKpGfTV1BEkMaPFaKtVFC9C142hFTFxOvRWr3ZxI9CQDvJpUd08Czclx5BMCeIE5brtL7T6pZ+9AcH1TeXBhbN+ud/Wij3RohRzOHcjzG6d1oWM9Q+PmHlv00ahc1DgSXo8fh9NNWNaCwSZ1hkC4QIgcSVQejihyziYVGmOkHY4e3XBEaX3trISFdyE9yXVuK323caCG7LZ4xJbs8W1reEjken0RW4Ih8WPak5ezoVpG1g+6rp48HBWQ0zU+YaOyj660ltTPinzcPf1WrJr4D5PNbaubuOczqpdCNT2jycys38PjtjKdzvPAbLo57fggC9zNZe1jaAcHcYe5r0V8OBWykHWKT7HjlkF0wXhakv5h/Ljyt0e3J2gmKoGfBkVrvpxEPEYCtv29FGf/02BLJwFp0AWUEw7IGpgrkSne6O2EEqbSltzGrBmc/g9OnOrVcB+KcrTHV2Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RPjgMN1DKqlmliryTgoFjOJabKxmiKnOl1CANVf3usWuAM+sbFkKk9+z17ZzQyXn+l85zmTlmIAb5PpdyIA2luwWuf1WwUCYRAwMD/TEzyrRwwlY3gnOUML76yX+KUQHFszKEdvX11StyuOT+u39LKvB0ztMMY8Jmc6FyCDQADSWCSmZY1fTeBB6FeCTT7l6gpx4KU1+412OV+mQHYkkPy5cTa1G76MOBesqqdvIEfcFKfmXQXe1gsg+bWxPIZcmMBcgXaICj77PrXsLanMvj7RbhMrLTVl2mSYxBJ9+0o05bgHYMvsBblcKCGX1jMQmkTuoqiyLvDIsGnddxfOw9f+0WOYllfzhRsgBnxDJhoJeoGYbaFSmYykpI0Wts6zAyTBkgeRQv2Aha8zIreEKhC531MuDKtzP4XidpleCn+M0YbAZh6pcw/hnpT6FRikT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:04.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351dbf4-ea75-40ad-1c8d-08df1e4fdb89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

Protect the common I/O accessors used for BAR, VGA, port I/O and ioeventfd
accesses with access_srcu. Recovery can then block new accesses and wait
for admitted accesses to finish. Keep user copies outside SRCU so a
userspace fault cannot stall recovery.

Return -EIO before runtime resume if region access is already blocked.
This check avoids waking the device unnecessarily; it does not serialize
runtime resume against recovery. The I/O accessors check the gate again
under SRCU before touching hardware.

Hold one SRCU section across ROM mapping, the buffered hardware read and
unmapping. Copy the snapshot to userspace afterward, so recovery cannot
disable ROM decoding between read chunks or wait for a userspace fault.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c |  4 ++++
 drivers/vfio/pci/vfio_pci_rdwr.c | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 88a78766c178..323038cd0ca5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1666,6 +1666,10 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
+	/* Avoid runtime resume when blocked; region handlers check access again. */
+	if (vdev->pci_recovery_supported && READ_ONCE(vdev->access_blocked))
+		return -EIO;
+
 	ret = pm_runtime_resume_and_get(&vdev->pdev->dev);
 	if (ret) {
 		pci_info_ratelimited(vdev->pdev, "runtime resume failed %d\n",
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index b4f2c9d967dd..40c9dd02c3df 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -44,10 +44,17 @@
 int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size val, void __iomem *io)	\
 {									\
+	int idx;							\
+									\
+	idx = vfio_pci_core_access_begin(vdev);				\
+	if (idx < 0)							\
+		return idx;						\
+									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
+			vfio_pci_core_access_end(vdev, idx);		\
 			return -EIO;					\
 		}							\
 	}								\
@@ -56,6 +63,7 @@ int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 									\
 	if (test_mem)							\
 		up_read(&vdev->memory_lock);				\
+	vfio_pci_core_access_end(vdev, idx);				\
 									\
 	return 0;							\
 }									\
@@ -70,10 +78,17 @@ VFIO_IOWRITE(64)
 int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size *val, void __iomem *io)	\
 {									\
+	int idx;							\
+									\
+	idx = vfio_pci_core_access_begin(vdev);				\
+	if (idx < 0)							\
+		return idx;						\
+									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
+			vfio_pci_core_access_end(vdev, idx);		\
 			return -EIO;					\
 		}							\
 	}								\
@@ -82,6 +97,7 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 									\
 	if (test_mem)							\
 		up_read(&vdev->memory_lock);				\
+	vfio_pci_core_access_end(vdev, idx);				\
 									\
 	return 0;							\
 }									\
@@ -209,6 +225,11 @@ static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
 	void *data = NULL;
 	void __iomem *io;
 	ssize_t ret;
+	int idx;
+
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0)
+		return idx;
 
 	/* Serialize ROM decoding with power-state and other ROM accesses. */
 	down_write(&vdev->memory_lock);
@@ -272,6 +293,7 @@ static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
 		iounmap(io);
 out_unlock:
 	up_write(&vdev->memory_lock);
+	vfio_pci_core_access_end(vdev, idx);
 	if (ret < 0)
 		goto out_free;
 
-- 
2.43.0

