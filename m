Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30147A885;
	Tue,  1 Sep 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255284; cv=fail; b=DRkgCaDRGsiYYv9aowutHP/GmR0QcoOh47fxVl2XdNcQzoybnm6LqpR6G9A7sMCYs4fX3OXYG2H+qLG+C9hthzAMKKJwEMi58T3mcdw6XVx2ojnC0pDKv0Za/SGsvlylvj8ybXUZ/T/bLHUWP2R+R0eL9YY+khKuqohfWcl7OMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255284; c=relaxed/simple;
	bh=GbsXmPd0px9Y8I9MQRSlikrFCnbR0XaEzx5UEj7RNo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8HQlD3tX/fO8duLANy8wuMkPC36RGyuT8D1fYb+fWanDnIZ6XJEnXZtlnwIDeOTSAgWMLg3kqut8KnzH9MMNEdJZf5rjkhEbUKDRvB8hFKEmclU4BKmqs83/3852X3dc8m8UwN5PzEyg3zfAzxzY/xjDNjcAcNAxSP9RhJFm7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENr3CK+r; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENr3CK+r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwkse8kVBMHK0jTVcF7PFb+pIxo5qmLOmgZwuU1w5dJUw8nxagGQVhEwf2enW7xEOx24HAFYErX2IYxuwMUsDwjK3I9AGLfJQx8FCyqV/kTiNC8d0TeTZaPJtauSFe7ezzXxk4SbeWIlXYKscnyi0NV3bqBZ7HQt3eHta2TwIOR+ETp+P4Xbd+M5iWhBznz/RJiu9kH+3nvj5irrqyB3Lagi5ebO0JffRS6xT+5Vi8w9rpJhzlLbCU3w7ra5OkHn9gvIhP4tvSS/AQy7KBFFADO0Zre5X64VukQeF0nO+dKS9oz6IO4IZOHT+aHduOH7nUlLB92AC5apzueMpyd9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQYvJq7MalZjQc+3FUaQ6CA7OyX2KvLfbvStvaMWosE=;
 b=kyQ4QcgOXnC/+wojk6cv8jrAA2Ht5oKTM6e32Afqm9vJKwJDlsyagJRjIW8vJ0BFTpKp6DbY1q7j4WgoGtNCiFl8UjbCDomRkDa5xOLNLb8WSpuOT+e9jXCq2vxkRbMELBgpqI9FMwKIMa0l2WoQcV1TZcWWS7HOPZzSMNGcy0Z9FSs4HAW29phgwibRX5MvdXx4gJNHOFAMLJ/YcjQeUfzs14UEf5k9DSHx8D4paYmn23p7e8li7nkgUXKNEn3ZI2o6aNMWXQwGgFeaMCoQilbLZQYWmbU7sGlFAf/2zsJobbAymI+uN5nSQUd5jNARhwRm8A9OuunMh09lSCeNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQYvJq7MalZjQc+3FUaQ6CA7OyX2KvLfbvStvaMWosE=;
 b=ENr3CK+rFoyAXNUdAdqtCCL6RjMjIz3N44GcYGzlN0Rhc5Xh/A6DYL7ubCgUeXUYgQW+FJbuQoJ+y9k/1HwiqM6NpjoF7cq9vvFY+C9W/uzSIk2fEWCFR262Z2bmJbcP28tYae5ygE8qm/usrisHw78DWL1xp5JdPS84e4jo2UZTIbwbWeqa33ibkM/CDVAbvHAiWW4hVmOU3+dbFMoW1infZMoVEMTjATeSXibbs6DgdX0acuRzFHAu+nylUG3Rs2uzVAZencJfISVUar0AuR8PqgF+HftzZ4j99FXd4D4GpjlMV6WU6jSnWkdGiv6SwAmlAJI3Un6Rvp7lvTncmw==
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:34:20 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::19) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:05 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:02 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 14/19] vfio/pci: Add generic PCI error slot reset handling
Date: Tue, 1 Sep 2026 10:32:12 +0100
Message-ID: <20260901093217.8539-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7784cd-a6ce-4af9-bc4a-08df080c3376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zmKHKeEkSojKzPSUZcv9IxIbLMD2pH58S76+s4xxdGwadzCDXGk/OZaznc+l9AUdcbRiFXOmi0KobajfroRr8vZhpSlV4OqbNU4C0tq9OQIoYApA9Dfi4LF+/sPET+ZrSkjdjXw3hOhphoON48L13/NgL6TXl40U8K3O0Qw9s9FQUiDEgmFtPCCaagkSplBVJPeWLvESCzVYjIZyUr1NAaF6TCPLOyv81dLYi7XV/QVHfZJKoZoJb/RGW+dEIfd72XL6AMJUwhkM63UZ1/niaGvtb8MOReF2ju14YNB1KUVTXbJWnCN5x12PE9v/TagMpjavEcKxIz7fKW7YpqVSkW/Z6DOht5OnDGUCDK6ovnTgpzg7UFXeGDbWavpD1pTb50vhBzHUJ9NDSSK41BRJAGWIcKRcPF8HsLKLYUIdm6KVq2xQlg61wsbMSmnpVvtkNocf0J1baxvFtWemWjAoh/X4riuyGhM5YuHB89MIl74ywA2dIWvKOb/oH92QqO34wwwzMO5EyX7LMs0NU/hYC36VFfnqRMqhEceSO2PswfjMPacCu7UQldfC517thFjSUbJ5T8NQcsiJUMj3Og3Lh251jkD7F5r3EIjBZuAic24BlQn0c2IY4XRPLtXyqwrQuSwHzfTE+AzKPnKON5aBKb1K7UhB93V2maN9EqicGWpx3nIOeD4hKhxghxNDvvxNWZvZsasSaTevNtbx1GxaQg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LRZDzdmWDjTTGDZKz7i2yDvFFDqiPwXZ+v2KLuBZToOw29oMa2rb0gH2SUzWZaV4koWbqCve93FqXUbp7ypM/CFUIPfSblCTj0zzS40b3hbFQyoVs2HaLFz/yaMKASiHP66mGnX4zRWSWno2rNmdqi1yoENgmHBOMKCuJESjlJ0SIUZqWS+2ziNKhDCb36gHs7BE8kIBIMG3noWqA/4TJYMzBvwDBlpnzT9U54DtUd1yMI+SIHHr1WWHxCOMtLgHvIXhe6xw70bq2Jh/VO/9gyJWZj3NIr40BSlKXKR33aWS4wzapNcIrMwjuh0Xcj472Y3bpBY04DAu+SCpqQ0TaL0k/2ShFPrEUGvAwcFX4XdBc97fLPpFeZarMK2AercxbOq3/y5z8komaiTBxHg/tjCmx2sCzEihcLmY6YsGndzOfQMs0mI5LekF7Eyhok4G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:20.4078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7784cd-a6ce-4af9-bc4a-08df080c3376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Add a slot_reset() handler for vfio-pci-core.

Restore the saved PCI state first. The host resets the link without
restoring config space, so on entry the BARs read as zero, and tearing
down MSI-X before the restore would write through a stale table address
the device no longer decodes.

Then tear down the stale interrupt configuration, holding recovery_lock
across it. vfio_pci_core_disable() runs the same interrupt teardown when
the device is closed and takes no igate, relying on there being no other
user by then. vfio_msi_set_vector_signal() frees the per-vector context
with no atomicity between the lookup and the erase, so two callers which
both find it free the irq, the name and the eventfd context twice.
vfio_pci_core_prepare_close() takes recovery_lock for writing before it,
so holding it here keeps close out.

The interrupt teardown ends in a flush of the virqfd cleanup workqueue,
which is shared by every vfio device in the system. So this holds
recovery_lock while waiting for other devices' work to finish.

That cannot deadlock, because none of that work ever asks for
recovery_lock. It can be slow. The flush waits for an ioeventfd write to
complete, and that write waits for its own device's memory_lock, which a
reset on that device holds. So the wait here can last as long as a reset
somewhere else, and anything waiting on this device's recovery_lock waits
with it.

If the teardown fails, record it as FAILED and return
PCI_ERS_RESULT_NONE. Returning DISCONNECT would fail every device under
the bridge for a problem which is local to this one.

The handler does nothing until a later patch starts a recovery
transaction.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4447967413e7..b3ad7ed261e1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2756,6 +2756,77 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+	int ret = 0;
+
+	down_write(&vdev->recovery_lock);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS) ||
+	    !vdev->pci_recovery_device_open) {
+		up_write(&vdev->recovery_lock);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/*
+	 * Restore first. aer_root_reset() resets the link with
+	 * PCI_RESET_NO_RESTORE, so on entry the BARs read as zero. Tearing
+	 * down MSI-X before this would have pci_msix_shutdown() write through
+	 * the stale table mapping to an address the device no longer decodes.
+	 */
+	pci_restore_state(pdev);
+
+	/*
+	 * Hold recovery_lock across the interrupt teardown.
+	 * vfio_pci_core_disable() runs the same teardown on close without
+	 * taking igate, and running the per-vector teardown twice frees the
+	 * irq, the name and the eventfd context twice.
+	 * vfio_pci_core_prepare_close() takes recovery_lock for writing
+	 * before it, so holding it here keeps the two apart.
+	 */
+	mutex_lock(&vdev->igate);
+	if (vdev->irq_type < VFIO_PCI_NUM_IRQS)
+		ret = vfio_pci_set_irqs_ioctl(vdev,
+					      VFIO_IRQ_SET_DATA_NONE |
+					      VFIO_IRQ_SET_ACTION_TRIGGER,
+					      vdev->irq_type, 0, 0, NULL);
+	mutex_unlock(&vdev->igate);
+
+	if (ret) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   (vdev->pci_recovery_flags |
+			    VFIO_PCI_RECOVERY_FAILED) &
+			   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+		vdev->pci_recovery_command_valid = false;
+		/*
+		 * Vote NONE, not DISCONNECT. A DISCONNECT anywhere in the
+		 * domain makes the core skip resume() for every device under
+		 * the bridge and report permanent failure for all of them.
+		 * Our interrupt teardown failing says nothing about the
+		 * others, so record it locally and leave the domain verdict
+		 * alone.
+		 */
+		result = PCI_ERS_RESULT_NONE;
+	} else {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   vdev->pci_recovery_flags |
+			   VFIO_PCI_RECOVERY_RESET);
+	}
+
+	up_write(&vdev->recovery_lock);
+	/*
+	 * Whoever clears IN_PROGRESS owes the wake. resume() will not do it,
+	 * since it bails once IN_PROGRESS is clear, and the core skips it
+	 * altogether if the domain verdict is not RECOVERED. On success the
+	 * transaction carries on and resume() wakes.
+	 */
+	if (ret)
+		wake_up_all(&vdev->pci_recovery_wait);
+
+	return result;
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2828,6 +2899,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_core_aer_slot_reset,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

