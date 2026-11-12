Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493203;
	b=R/y1cLAxllxsG173VpGOdSFj+JNeaMp6CcrigyIntiqg3Fpg5zh0U2sjUcEgl2kUiLjG
	 HVpgLbxlRC5OxQDuLFOjYqOqbicxla7dNk1kxxGLShoKISzfuB7QWBrQDDfOKF715Gigo
	 pmom6h8Ym8vTcpq08wF6Z0dGRLHyBT9jTO7ijuBbgvYSaPyaeLVX24Z5NwEgXww3gkQt1
	 PhxRTHPBQVOU0Kb9nId+QdJ8vD/t7AXTPc4k9NOUZE2AS9S8UHGcPyzGVbJ9B1sqQd3f0
	 eYjhcIUrBNkKqU7bIGuk7U2UWL9pYsaSt5mk4LNlIKbZnHQP01nfbbUegCpFQxu8DDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493203;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sjqmZlwnNDtNyA82Dkomt7yAUny6FwPAASfsL9uySzw=;
	b=mqYvkhrfQbeNzlThZGGpxEqOlwiVvg4nVVsIo3B0jdyf1f7XN3bWcwLEeW7JjmGqnp46
	 +Mm1EXyXMQxnE5x4u7Zj9mry/WuoZHZrZhWhJb2WpzTXWl2rP3HI/PJoAAJmUq1ZBEjNv
	 /Z38/w6VBEN503Cln4z581la3sVmF1AxfacSmXz3xENVvZTSwFWiyQyBma77gJI16y1zz
	 6U9kOR0eHKH5Fyz92kiXEbroIla8otGcA3g8ylrxC9NJderp5up9iz9IcXslupaz5JEoJ
	 Kpy8uJoE1nEAtzKbSMMPEPEUyZVj34mfVbulEkNcr3vrFeKDP9C4IysbGSYuXVJ+L0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MZeCulVK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.66
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EC60A381E;
	Thu, 12 Nov 2026 14:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 646EC60A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MZeCulVK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmvBcVE9FYR8OwZ01f5bHwgLGg5Ph5mLB5afrMcx1URm9d+CT/Ghv6lalij8PksRTof1WNUL0H1mIHcbuu2RkNqHatd4JpYLEBMFRPO9aR0xI7VIX7KtZd8EiatDGu9ql7llFf4Np+D2vqRYxgNvgq//UKTzW/1imycuDUvJFdY6gI6ee69JcVVWA9OTTUXJvTdc9lPtdqBlUBojhYSwYqb+hzsFzTVA+XdfC8PIJKBBJC0XMDEXYdKMUYQA2IFnCfpFuW3qhAK7d02SQ5g/nNrWKBIzHA36BUABnggvn6z7rr8F2KQjzXSAU1V0UxgVOKmwW5Txg5Ixec79BBWkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjqmZlwnNDtNyA82Dkomt7yAUny6FwPAASfsL9uySzw=;
 b=AA1yLwLtbETdOrunT0szNIURNjy9zvrH9vzD7BW3i7pKHLf+QAh9u2yW4DJ4qjVEBzh5w9VDzjJ0Iis0d5qJWFK+OGJ9+qHMjI9KC2KJ7faW9nYdIScI16OSZ1hjcL2SXcbLfZ2j+Dvnh5dAGPKFza4l9uMjEKWR74sFYgi7PGy8nV9J/9tGENQMVIsztbpQeEGD9nMKDhp/ETl5JEYdOYVZI4lNq/rD8RR581RlzZ8lWOyjGyl1SMz/lWM5MCjUn5wuSh6UIuV6UIkEkkbSagb9hd0KP/0La6uYt/tYvllfYvpFRvhRPbyZSPpZIBN7N7o/gNS75uneRF0Gke2A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjqmZlwnNDtNyA82Dkomt7yAUny6FwPAASfsL9uySzw=;
 b=MZeCulVKMLCOaQMPVqtI2Gj80izfp4jUBewWPD7IoWXunxbCWewe7OFge+FIxSQCb/aBkN7xq0wG9Dwo5aipYNUekD48CJVtPkhJt4xdbhuY27B7KKzIyQo/yPv5f7Khx8nZHdsufSH+0+IXI0rz4X1fH2EnoFpPrmqlwuBOXmsOEHOaiFdqVM5/E+nV6I1YcPNoad8IA18S69rD2CbBeVppUYXHXNs1eZY6R43456WBraH6JpWGvDBkFFRSEDrkQC00UpaQ7xMMU6YR6+REIi70Ey4goNuFz/Ms1tZ/6Ntk/ejwcnBKmJQEtSBoGeTqBP3eJSi9rSWZyYyFuZ03gg==
Received: from PH8P220CA0056.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::35)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Thu, 12 Nov 2026 14:19:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:2d9:cafe::42) by PH8P220CA0056.outlook.office365.com
 (2603:10b6:510:2d9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:19:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:55 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:52 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 19/20] vfio/pci: Add VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
Date: Thu, 12 Nov 2026 14:16:31 +0000
Message-ID: <20261112141632.918954-20-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfaf6e4-e479-4081-4bc3-08df40c7f150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|261026121527099003|261022075727099003|261028144727099003|261102130727099003|56012099006|261022105027099003|11063799006|261102123227099003|261022113327099003|261009223027099003|261026140227099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	D61N7gDpvGUFQGg3pvJcfo83/LtFbNP4uV51LTvaYn4Gf9EbPArXPuIx20/gbCbpI7CinCaRbXtHKBHPM0XIPSfuXFs29ggVg1S7M+15gTGdEk/u4U+m8FHjk8iqXTay0CCj+qx1xUiIjYMxrEnA5MVqZ7YBurBmQvgr1ygluCWe1+oJ9UI4cohfYZK/jyHHzFbJNs8cjO9DnF5M294qM8r7Xv1ouygtDlfVK7aIelKBVuVrrzRHwWfcjLZ3EMNdctF5tGULDW0uUtI3gQ85IA381Sd1DgNbH0Ld++MPYJzRHprGFtJmMFofYw8PCv7MeSYW6ZnuZ04fuYfGnRc2aAKR+WXnX9/3TVZTkmn145fl0Ly0xrwIsJgdbBr9dDI8jVmxb1W3VsPf1C+Mt0KKjIcir6MLPTPH1JhJgSoqVnNCm3ARFWGglxSE8qY4L3fWzc3atY8W388tUCoqfoP8wblM885bNsFO0JCMNCWGVszc0RUIhQvej/cmG5SxyJ2tXjA0Vbw50s1oEErVifYRopozDOBIH6oZdVOCKulvhv0tEHlkuCe4mR9GzWhfhPaT7sjgCxf7YXc+qmy166qtLihhrGVNdiyx68BNcB3IXcl8a/tG93qc48n+ottFcsjzSFpQKruQZUDmiUefgfF/QLlzmWdCHbiIK/RtilObknWh5qZL3i6roWV0eFpd/hqgjLwMLCe99VUnpq0AeRVDjg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102130727099003)(56012099006)(261022105027099003)(11063799006)(261102123227099003)(261022113327099003)(261009223027099003)(261026140227099003)(261021121427099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bE8qLcdT1PGT2vZ+Ns1NciZt8g/ZrvUThItVpQTcv8PNl5SJ0PqPko/Q+Tl+AS3v8rB42zYh1kVagZhUrAFGwLd2G9N3lTe6zQPoiy9CMwjlDUpIAXyqbbwYMyaS9oerNmypGX2OYuHtOtUYfVXu7OXVVeZsjtmZkt1wltcn+s79FSev884vMOqvt6JiKRUsWEfsaw2lMs9tHbzk6WVkixYUWfWtTxC7QPqJ7YBpgqkf/YqZnFQ1QQ3bvCuENlmCbRjwSBL8Xp4z7XKV0AUdEmQ/Yag3TwnZzGOKbyMzhKsrgGUTTE8NAI5yQNNENc3IAsJmmFEMTZo+wjt9XymZo9rWKr6+mR+ifToLL3kJC7agNYgqfqfs7/TzR3PayQcujj0FjpaDOiVDlJi05sZtFk9zKP5d78lB04EGysWdkD122jmFSOgE81+jbFN57RKm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:20.0092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfaf6e4-e479-4081-4bc3-08df40c7f150
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892

Userspace needs a way to enable host recovery and find out whether it is
still running, succeeded, reset the device or failed.

Add a device feature that registers a recovery eventfd and reports
status flags and a sequence number. SET with eventfd -1 disables
recovery. GET is available while hardware access is blocked. The
sequence number lets userspace detect recovery that finished before it
read the notification.

Reject SET if access is blocked, recovery has failed or a recorded host
recovery is still running. This also applies if userspace had not
enabled recovery when the event started, so a late subscription cannot
report part of an older event as a new one. Updating the eventfd resets
status for the current open. The existing error eventfd is unchanged.

Add the recovery eventfd and signal it when recovery starts, completes
or fails. Release it during close. Signal under access_lock so SET cannot
replace the eventfd and reset status before notification.

Userspace must probe each device and restore guest state after a reset.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    |   1 +
 include/uapi/linux/vfio.h        |  51 ++++++++++++
 drivers/vfio/pci/vfio_pci_core.c | 139 +++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index cd7d87788de0..896c176c28a0 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -152,6 +152,7 @@ struct vfio_pci_core_device {
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
 	struct vfio_pci_eventfd __rcu *req_trigger;
+	struct vfio_pci_eventfd __rcu *pci_recovery_trigger;
 	struct eventfd_ctx	*pm_wake_eventfd_ctx;
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..86a3952ee302 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1555,6 +1555,57 @@ struct vfio_device_feature_zpci_err {
 
 #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
 
+/*
+ * Report host PCI error recovery state for this device.
+ *
+ * Userspace must probe the feature on each device before enabling it.
+ *
+ * VFIO_DEVICE_FEATURE_SET with a valid eventfd enables recovery for this
+ * open and requests notifications when each event starts and ends. SET
+ * with eventfd -1 disables recovery. flags and sequence must be zero. SET
+ * returns -EBUSY during recovery, after recovery failure, or while device
+ * access is blocked, and -ENODEV after close has started.
+ * VFIO_PCI_ERR_IRQ_INDEX notifications are unchanged.
+ *
+ * VFIO_DEVICE_FEATURE_GET returns the current state and eventfd = -1. GET
+ * is allowed during recovery, but may wait for a running callback.
+ *
+ * The sequence number increments for each event and resets to zero after
+ * a successful SET. It lets userspace detect multiple events from a single
+ * notification. Recovery may complete before userspace reads the
+ * notification, so userspace must check the sequence and status rather
+ * than wait to observe IN_PROGRESS.
+ *
+ * Ordinary hardware accesses are blocked during recovery. Read and write
+ * requests fail with -EIO, and faults on BAR mappings result in SIGBUS.
+ *
+ * CHANNEL_FROZEN records a frozen channel. DEVICE_RESET records a host
+ * reset, after which userspace must reconfigure interrupts with
+ * VFIO_DEVICE_SET_IRQS.
+ * FAILED indicates that recovery failed and access remains blocked until
+ * close and reopen. Status bits remain set until the next event or SET.
+ * ENABLED indicates that recovery is enabled.
+ *
+ * SET returns -EBUSY while a host recovery event recorded by the driver is
+ * still running, even if recovery was disabled when it was reported.
+ * Enabling recovery does not report events that have already completed.
+ *
+ * Open returns -EBUSY while a recorded host recovery is still running,
+ * including events reported while recovery was disabled.
+ */
+struct vfio_device_pci_error_recovery {
+	__u32 flags;
+#define VFIO_PCI_ERROR_RECOVERY_IN_PROGRESS	(1U << 0)
+#define VFIO_PCI_ERROR_RECOVERY_CHANNEL_FROZEN	(1U << 1)
+#define VFIO_PCI_ERROR_RECOVERY_DEVICE_RESET	(1U << 2)
+#define VFIO_PCI_ERROR_RECOVERY_FAILED		(1U << 3)
+#define VFIO_PCI_ERROR_RECOVERY_ENABLED		(1U << 4)
+	__s32 eventfd;
+	__aligned_u64 sequence;
+};
+
+#define VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY 14
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 5e9451e08263..0897d1f0e082 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1043,6 +1043,10 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 	mutex_lock(&vdev->igate);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
+	if (vdev->pci_recovery_supported)
+		vfio_pci_eventfd_replace_locked(vdev,
+						&vdev->pci_recovery_trigger,
+						NULL);
 	mutex_unlock(&vdev->igate);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
@@ -1939,6 +1943,114 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+/* Consumes the eventfd reference on both success and failure. */
+static int vfio_pci_recovery_set(struct vfio_pci_core_device *vdev,
+				 struct eventfd_ctx *ctx, bool enable)
+{
+	int ret;
+
+	mutex_lock(&vdev->access_lock);
+	if (!vdev->device_open) {
+		ret = -ENODEV;
+		goto out_put;
+	}
+	if (rcu_access_pointer(vdev->access_ops) != &vfio_pci_live_ops ||
+	    vdev->pci_recovery_host_active) {
+		ret = -EBUSY;
+		goto out_put;
+	}
+	if (!enable &&
+	    (vdev->pci_recovery_flags &
+	     (VFIO_PCI_RECOVERY_IN_PROGRESS | VFIO_PCI_RECOVERY_FAILED))) {
+		ret = -EBUSY;
+		goto out_put;
+	}
+
+	mutex_lock(&vdev->igate);
+	ret = vfio_pci_eventfd_replace_locked(vdev, &vdev->pci_recovery_trigger,
+					      ctx);
+	mutex_unlock(&vdev->igate);
+	if (ret)
+		goto out_put;
+
+	WRITE_ONCE(vdev->pci_recovery_enabled, enable);
+	/*
+	 * Updating the recovery eventfd resets status for the current open.
+	 * It does not change the access ops or whether host recovery is running.
+	 */
+	WRITE_ONCE(vdev->pci_recovery_flags, 0);
+	vdev->pci_recovery_sequence = 0;
+	vdev->pci_recovery_command_valid = false;
+
+	goto out_unlock;
+
+out_put:
+	if (ctx)
+		eventfd_ctx_put(ctx);
+out_unlock:
+	mutex_unlock(&vdev->access_lock);
+	return ret;
+}
+
+static int
+vfio_pci_core_feature_error_recovery(struct vfio_pci_core_device *vdev, u32 flags,
+				     struct vfio_device_pci_error_recovery __user *arg,
+				     size_t argsz)
+{
+	struct vfio_device_pci_error_recovery state = { .eventfd = -1 };
+	struct eventfd_ctx *ctx = NULL;
+	bool enable;
+	int ret;
+
+	if (!vdev->pci_recovery_supported)
+		return -ENOTTY;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_GET |
+				 VFIO_DEVICE_FEATURE_SET, sizeof(state));
+	if (ret != 1)
+		return ret;
+
+	if (flags & VFIO_DEVICE_FEATURE_GET) {
+		scoped_guard(mutex, &vdev->access_lock) {
+			u32 rflags = vdev->pci_recovery_flags;
+
+			if (vdev->pci_recovery_enabled)
+				state.flags |= VFIO_PCI_ERROR_RECOVERY_ENABLED;
+			if (rflags & VFIO_PCI_RECOVERY_IN_PROGRESS)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_IN_PROGRESS;
+			if (rflags & VFIO_PCI_RECOVERY_FROZEN)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_CHANNEL_FROZEN;
+			if (rflags & VFIO_PCI_RECOVERY_RESET)
+				state.flags |=
+					VFIO_PCI_ERROR_RECOVERY_DEVICE_RESET;
+			if (rflags & VFIO_PCI_RECOVERY_FAILED)
+				state.flags |= VFIO_PCI_ERROR_RECOVERY_FAILED;
+			state.sequence = vdev->pci_recovery_sequence;
+		}
+
+		if (copy_to_user(arg, &state, sizeof(state)))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (copy_from_user(&state, arg, sizeof(state)))
+		return -EFAULT;
+	if (state.flags || state.sequence || state.eventfd < -1)
+		return -EINVAL;
+
+	enable = state.eventfd >= 0;
+	if (enable) {
+		ctx = eventfd_ctx_fdget(state.eventfd);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+	}
+
+	return vfio_pci_recovery_set(vdev, ctx, enable);
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1959,6 +2071,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
 		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
+
+	case VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY:
+		return vfio_pci_core_feature_error_recovery(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2685,6 +2800,20 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
+static void
+vfio_pci_signal_recovery_event(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_eventfd *eventfd;
+
+	lockdep_assert_held(&vdev->access_lock);
+
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->pci_recovery_trigger);
+	if (eventfd)
+		eventfd_signal(eventfd->ctx);
+	rcu_read_unlock();
+}
+
 /*
  * Save PCI_COMMAND, clear bus mastering and set the requested bits.
  * Reject an all-ones read from an inaccessible device.
@@ -2717,6 +2846,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vde
 	struct vfio_pci_eventfd *eventfd;
 	pci_ers_result_t result = PCI_ERS_RESULT_CAN_RECOVER;
 	unsigned long irq_flags;
+	bool notify_recovery = false;
 	bool nested;
 	u32 flags;
 	int ret = 0;
@@ -2745,6 +2875,7 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vde
 		goto out_unlock;
 	}
 
+	notify_recovery = true;
 	vfio_pci_core_block_access(vdev);
 	/*
 	 * Keep the original command register for nested events. Recovery may
@@ -2811,6 +2942,8 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vde
 out_memory:
 	up_write(&vdev->memory_lock);
 out_unlock:
+	if (notify_recovery)
+		vfio_pci_signal_recovery_event(vdev);
 	mutex_unlock(&vdev->access_lock);
 
 out:
@@ -2900,6 +3033,8 @@ pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev)
 		   (vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_FAILED) &
 		   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
 	vdev->pci_recovery_command_valid = false;
+	/* Report failure now. resume() skips recovery that has already finished. */
+	vfio_pci_signal_recovery_event(vdev);
 	mutex_unlock(&vdev->access_lock);
 
 	/* Allow recovery of other devices under the bridge to continue. */
@@ -2911,6 +3046,7 @@ void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned long irq_flags;
+	bool notify_recovery = false;
 	bool notify_intx = false;
 	bool power_up;
 	u32 flags;
@@ -2921,6 +3057,7 @@ void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev)
 	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS))
 		goto out_unlock;
 
+	notify_recovery = true;
 	/*
 	 * Match IRQ configuration's lock order and keep D0 requests out until
 	 * live ops are installed, so no deferred request can be left behind.
@@ -2983,6 +3120,8 @@ void vfio_pci_core_aer_resume(struct vfio_pci_core_device *vdev)
 	mutex_unlock(&vdev->igate);
 
 out_unlock:
+	if (notify_recovery)
+		vfio_pci_signal_recovery_event(vdev);
 	mutex_unlock(&vdev->access_lock);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_resume);
-- 
2.43.0

