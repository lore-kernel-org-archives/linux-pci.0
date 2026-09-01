Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346E476066;
	Tue,  1 Sep 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255237; cv=fail; b=CtvQDGLDzWLP359YyoIGMkxCFv58XWsePKHAkwGfR4qTS/72kGFMb2vV10N6TXg6QYwy6NZ+NJFYjj7OsQQJkwbLF7tKeKQPB3baYExqLKCwHhogVSMb5DfKpJfs1yZ84s3exKDnpMCV4djAzumUVh6miqez4oGBmKRHwv7jWoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255237; c=relaxed/simple;
	bh=kaZXVrrCP2U9Ug8O9yMNnVLRKWzQf/F6fTgHO2aMYes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW37JxrRa1I1HUQb9r9/yx/Um4Q1kaFJR+BWuAilh9Yj/gNWKb88o+92SbhK9p7PxhKF4BZopwBMWlRvtI312L9fmfN/AvinN3qrkUCFHvbgJruSrNe0op7pnwhU4eQWpVdvSB1H7hiBFyuLV/GQJ6uZu0KaHhrnqm5/cfwW5co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1kokl6R; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1kokl6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwyEQ0Aw3mXW7qllkd7a2WLnk/SRgDoVrByspaXEXoDlhn8FkVti0L0zj1yNpD9EYdpfFvV2ruDion8bavr7iCA6JB9gaMvbtav0ay/C0LgpCij7sFDECDAYwYPgYcDzacqOyUf6/eoTGzxZ3ZLKy2cgXCeX5BQB3Ji6ES6SRDwAv6NIxkNxLb2I6hCLEQwfdkfnKJSafCCciUEHkRO5CCPPkA7dmTqn8bQ0JbjONFgK/xFs7t6lETj+3uxE+WMcfdsCi31r3qG1vv5kb/OZkDlXI2bp3upo6+7bSHrWZgKKSj5VtMqTvi/ExZ9j+j8oraOWZ+SbqARl0UZWAMZbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTcGDI1SipXcb5nQctScIiUvyi7LV3lMLuxyR56YF0w=;
 b=TpunAM4Uq5qZ2E6OpgDtGQX5we5Hvi+fHNwlrSGOVmoex7/WZm0P3WFFauZT3ZfKeSBakMKIGkQEW0AGHRlLTHPdmZe8Ge26m6akm4ME9lgjDaTzXO2BP/ps6aps/Fp2OUZHKJJJwquHv7NVDCsDmvhYLttljNCe/3kKwWleq1Man1b7azLfeQw6YvaXDXxGlsXf5i1dvV2g/hLApjgFvKus7RGflErYdabrG00nZuK14aezdJ8ZjA5PwI+meoxdhwqK9ySLyA6zwsLMHSVNf6Sxy9ZHCeTR9sm1x5DKtVd5CPJOC25YKBVuMTYAxUsS+aWnYB0G544SvvQ5HDeKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTcGDI1SipXcb5nQctScIiUvyi7LV3lMLuxyR56YF0w=;
 b=t1kokl6R0cXTiw9FAb4jkRdXPmjHdrr4L+txwHDj/4yp/csAcTF23VIGVodSFexcBhWpA872zB3cDQkCqGprTiYEgkUQEfTK+IaakiulPq+8ahydsM7znUYeuwr19CIKdh9FQCjcXC0OLNpU3QkbXEHQKLZqgSWWLZGHDqKgx4rCYs+PQaaA2j4/XHZfupn2OmVaCUrHiVV6NQfWHN33kPPAcVeWLi7nRtRB1nS4JR5HoNErcPhhIBalydjqraqffr1KoZAD7YZNupDFspMRe46Btwpt6lPtKRUoBMG91LMz5/Ob4gYAwY7Eu5Zjt/twBK18OZ8xE5cqldhi7eAWbA==
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 1 Sep
 2026 09:33:39 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::58) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:21 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:18 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 02/19] vfio/pci: Serialize generic device lifetime with recovery
Date: Tue, 1 Sep 2026 10:32:00 +0100
Message-ID: <20260901093217.8539-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f964b94-df0d-44e0-20b7-08df080c1b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WOc7WAzZNIGEeXvHUBXocUmqvXdDZKYiiOLaPMeI0qWy/ZaQ3mbImHLJDiQ8yyr+a8t8jQupo6WB/gMGVrXGE5ODgwLQ5baydvlyA407rz31X6hi2yhm2tCVekXeV0UBKqBYL5LqvkhUcBqLNnosHC78vNuVCDluz6Sut+JOaZYO6bczvNRzIlP5QfJLWc4v2s4BHIYnlKeW2JcGsG2k7wYS1TtnPKObjwl+vq37LR0ubL59Xnik5r4LGUSieintzuTf5eV8J6ZMHs92DBR53ws9Ubs3gTzdBK16H1OcCmA43DyPNR6vQByJjPfFvUAK7mVPdsTAuCZz3h+PJ5E3ulafjmF5GbzxQ47LILObFvlbUCV2uw1Hdpw9E8/xuvsj86alskI5UTNQsxcmyvRFjRqNx5axUXPO1SaV4cRaSaTPVOA2Kc19AbIo2oQ5qb37O9FpOTfwZgxahMQ+IKN8DuPCguNkwqKrendUozWQvXcNuPy3dXoOkie7XCy2uNNThAXuyzVuuFMp/VMDem8aB+Z6OIiT4pGYaWjLUWFILXuJkJ6E+1s2w+D+o6K5rBEZWMTrpZLhcEwSGJpb01j2wB6eVSyagcl5Wmt4AJkZWCAxmTnVkBlBZTH4rwGWqgI/eDq9niRJ+HcYJ/5dP9Q/J7647Kcxp0LbItmy0xum6VDxN17XFi3PP29wC4ceQQTbcnkWF6YsWFcekMBu6jyhpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8v/Gi/DFb/+7mNVYOiwIxEQXttehG0BOq6ADh6jbBuFuao9WEe2Ai+raAJa0A0eZQQyH8ed99S/k6NKJaxUk/0KSWdFiSdesUFkICT3PJZIwxu7KjUstBhr66Ccg9LTIAilpgdSE5Xh2d6mRrn33QV7fqiswYEdy/84H+UwAXOaPsdDGkI3fco/FZFtvVJyil3p/rDsTFd9lchYeyoUaOV11KahtjzHc9JsBMSodw1IC7mAwn1kLZ6jKeitZrZg4NZI6xrfzpppDTjvpp+itq4Gtm69p6B+AJEQf3YvmQSZaQLFbeFjKfqPgmvRqIH6yNs0g1TqX1mYJcI9kVjmfhtOeAdZPiycp5eKLBaz8nZEZDn1R8P+RuwvPX+2aS2p0aYjwfowO/tFtIejVfeVau3rXJYmTWuO0L3zxOv/+o1aG3ScpMLV/TVcf9m6UdKuP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:39.3665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f964b94-df0d-44e0-20b7-08df080c1b09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983

vfio_pci_core_disable() frees vconfig while holding only the vfio
device_set mutex. The PCI error callbacks never take that one. They run
under the PCI device_lock instead, and vfio's close path does not hold
that. So a callback still running when close starts can walk into state
which is being freed.

Publish a device_open flag under recovery_lock. enable() clears it before
it touches the device, finish_enable() sets it once vfio_config_init()
has allocated vconfig, and prepare_close() clears it again before the
teardown frees vconfig. All three take recovery_lock for writing, so a
callback either gets there first and close waits for it, or it finds the
flag clear and does nothing. The access guards added later test the same
flag.

recovery_lock is not held across vfio_pci_core_disable(). A later patch
has error_detected() take it from under pci_bus_sem, and disable() gets
to pci_reset_bus(), which takes pci_bus_sem the other way round.

access_blocked is only ever set while device_open is set. Nothing sets it
without testing device_open first, and close clears access_blocked before
it clears device_open. If close left it set, nothing could clear it
afterwards.
The transaction which set it cannot clear it once device_open is gone,
and every path which refuses work on a blocked device would go on
refusing. Clear it before device_open so a lock-free reader never sees
it set on a device which is closed.

open() now refuses a disconnected device with -ENODEV. That is new.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e0be5ddf7039..8de586e4bb73 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -591,10 +591,23 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
+	bool supported = vdev->pci_recovery_supported;
 	int ret;
 	u16 cmd;
 	u8 msix_pos;
 
+	if (supported) {
+		down_write(&vdev->recovery_lock);
+		if (pci_dev_is_disconnected(pdev)) {
+			up_write(&vdev->recovery_lock);
+			return -ENODEV;
+		}
+
+		vdev->pci_recovery_command_valid = false;
+		WRITE_ONCE(vdev->pci_recovery_device_open, false);
+		up_write(&vdev->recovery_lock);
+	}
+
 	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
@@ -815,7 +828,40 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
 
-void vfio_pci_core_close_device(struct vfio_device *core_vdev)
+static void vfio_pci_core_prepare_close(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->pci_recovery_supported)
+		return;
+
+	down_write(&vdev->recovery_lock);
+	WRITE_ONCE(vdev->pci_recovery_enabled, false);
+	vdev->pci_recovery_command_valid = false;
+	/*
+	 * Clear access_blocked before device_open, so a lock-free reader
+	 * never sees it set on a device which is no longer open. A
+	 * transaction which is still running cannot clear it once
+	 * device_open is gone, and paths which refuse work on a blocked
+	 * device would then refuse it for good.
+	 */
+	WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+	WRITE_ONCE(vdev->pci_recovery_device_open, false);
+	WRITE_ONCE(vdev->pci_recovery_flags, 0);
+
+	/*
+	 * Publish the closing state and drop recovery_lock before any
+	 * teardown. Recovery is disabled and its state cleared, so
+	 * slot_reset() and resume() become no-ops and a later
+	 * error_detected() only follows the legacy notification path.
+	 * Holding the lock across vfio_pci_core_disable() protects nothing
+	 * and inverts the lock order. disable() reaches pci_reset_bus(),
+	 * which takes pci_bus_sem, while error_detected() takes
+	 * recovery_lock from under pci_bus_sem.
+	 */
+	up_write(&vdev->recovery_lock);
+	wake_up_all(&vdev->pci_recovery_wait);
+}
+
+static void vfio_pci_core_finish_close(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
@@ -838,6 +884,15 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
 	mutex_unlock(&vdev->igate);
 }
+
+void vfio_pci_core_close_device(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	vfio_pci_core_prepare_close(vdev);
+	vfio_pci_core_finish_close(core_vdev);
+}
 EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
 
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
@@ -852,6 +907,18 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 		vdev->sriov_pf_core_dev->vf_token->users++;
 		mutex_unlock(&vdev->sriov_pf_core_dev->vf_token->lock);
 	}
+
+	if (vdev->pci_recovery_supported) {
+		down_write(&vdev->recovery_lock);
+		WRITE_ONCE(vdev->pci_recovery_flags, 0);
+		vdev->pci_recovery_sequence = 0;
+		WRITE_ONCE(vdev->pci_recovery_enabled, false);
+		/* Close clears this too. Start unblocked either way. */
+		WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+		WRITE_ONCE(vdev->pci_recovery_device_open, true);
+		WRITE_ONCE(vdev->pci_recovery_rom_disable, false);
+		up_write(&vdev->recovery_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
 
-- 
2.43.0

