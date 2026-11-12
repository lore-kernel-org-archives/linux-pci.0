Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493184;
	b=LxblkKW284UV5EjNMALwRWGNmC+dgqGWFi4SqNMX1tW97jEX713O2AWuA1YY60o52OuI
	 QT/aQ/AimTPTEWA41hwA1z0nqlnhC2lvXNQR6MnNlMl0wzJXnz4ZnfRYmu33mg1vFY7Vs
	 QzySVlH9hlu7hIxtCWCtM159RvF7MXrQyWfiI0OS/fKU567YSC4suzn6gIyCIfIe03juK
	 1stNujNgQeURCKiOahZAbKnVKNStxIBqGz9+WVCGN8JQq42GQNcioiKEPuGU3+9c8GoL2
	 kI6aJgWAnJcUq8/qovzMq/zm0Q7TQahyr0dvxQxmHUdEXCADoTPZU2eBy3IC6K84UjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493184;
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
	bh=eNNuXoo94hbyMafHqZo1xjkofQQ1v3WXlyC2/uARunI=;
	b=QyY1hueiYK44Rg0UC6L7OQAm1v1kHCbjKzor3cTp7dJ7xnXdgnHzk3OcG5eKskY9hgrw
	 P4T7+DF+XvsSybGJmrlubPdLsf2G/xNNosp5SpDobYqVRL+sJjzWHIlIlvwlfkOEZPenq
	 1MYBTzYZyifc/TpJuc562t4sywHE3HdYA+whHNFvz6VA0frg5ZNL4wiqMlbl02nLjEYzB
	 HNC1IS6aQoSZI4Hgs7cvHqYsWgVxHn9x5BSW9fTFCA1u2RUaKj7k5z7WZtMQsXVX8CPwZ
	 W5Krza0mdeQnN2palEZ/eoyu+NREXWGVhz8UTxnXUDVndSyShlWyzNwV0voUQ5ZYKhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="kUuwF+D/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552F60A380B;
	Thu, 12 Nov 2026 14:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8552F60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kUuwF+D/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj5C2gLF1Xd/df5AakQIFJtEnwTyImYSK6QLJLeKyrYmRdMI+UnKMv8zjB1Tc0DV2RDu8Ad7UR+qWqm0NkEwOY7WA3NQq1o89r/pbqjVyb9ndPQ9FX9yCSfzmmwK9X/7TZQG+qtQvaQ6q+q/Ibxri3QrqiepXSywelpdJq9cZzSl60a5gf6x8rKoY1GCoy0YpTUSjk8Pscgd0OyQGdoCyHx6/Y1hOOVkLCDSJWdv6yj2HTs4DNUaV45SpduEUeYyK9nceFD/pTq4LPjG09V5ClKUyXcUS3FREy6Fd19V+fW+R2u+CHWXnhXixQVQ5tc5A2RykPEkEMcbgLS7y5CkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNNuXoo94hbyMafHqZo1xjkofQQ1v3WXlyC2/uARunI=;
 b=zIc57ySut+ktF7a87MFJp3R7fQ5ST3XlPurImuxm0Vs42r8Eyo3U4I/SAftHuiWFU4JOk6VZFaF3c8NqF4Zo0UMlkrGUmBOjeTymxwlED35bO1vFUPsJJ7wqqHkk5APHLRi+Ou+4g7b/rhzDJkT5hWH5dteCZzO8VpmSiZbSuWqV75oHq6Knn0S1PvNfpIndM1wjMvff0scoxJ0VOwLhg9oTTwwVZO17DCE3KDzH5ybAzwAa18kQ9TKndB4g+MWmP3roysKwW5eY8i/gB7e778pJlqP9l/A3ttu//UET+uu9O7BjhJngV/6yIPavK7GLEKuQVchT4kMWkFfPpdA4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNNuXoo94hbyMafHqZo1xjkofQQ1v3WXlyC2/uARunI=;
 b=kUuwF+D/V3ECmLQRnPywhIRhoIDcp6RxKS7MNesutFIZTzavqyjS/qLduCtX/TynOL/YZicjtq01m8vpddRvX5Af2Hvjd5hxjw21PK/8GDGcTNJqHOh49nbYn8XbDWkaQBHvzjJdyCxLriL5RjCg5HvVM4NaMp/MyXcAWkfpU/YcPmrFBGB3Ovxqe3FkDo8sUM0SWdM4KrB6PtXzjqE5I3wR8QOvZyE3K0HTzlwqi9f6ma7v8Wu3GdM7z52TI9SRrknH1NFQoYxcBZo2mLlWYvJjuoPHOz3hAC4ix6IgjRzJUEeZXxbFpfvEnIF6CcAICZDsE2TnBJFZuQmZbJDi6Q==
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:19:01 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:303:85:cafe::8a) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:19:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:28 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 13/20] vfio/pci: Track PCI recovery state
Date: Thu, 12 Nov 2026 14:16:25 +0000
Message-ID: <20261112141632.918954-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c498da-1531-4423-883b-08df40c7e5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|261028144727099003|261102123227099003|10067099003|261009223027099003|261026121527099003|261026140227099003|11063799006|261021121427099003|261022105027099003|261021123027099003|261022075727099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dcegiqKUsF2KqCQP18R5vmiwln68bhZnZ92ZDM7Fq0EXdZJxlTNxPF+w2hIQAwouvjXg8fAnLnW9AiAwhsJWJWbH8WEKWyhp6//0rl4suoI/U4Mgk7j717Sn650nX+AZhPsHHBRTwoxtndCavC6+4+DrmDMBe2ZnceVv0BrdnzIn2KBPRzuP6r4gg8ClExDZigjQX+JiLV2qLOuUKr8YAQeowxEXxbrJsp707PXBpi/m8EaU7HHGhd8tUw+vAwr890xJe26ByHY93E1RqzYWV9Ec2l4mZ4/h6whvokEnPtQGQn7rgRomYinvXGYw9AJoMpUB3FvMPdjdVDewkuyh+fsAT23qP+ac0l1f4FC2wT+5q6zt+B9ZMhYwcWfrswTQTNliZQJxVE8u4Yzhce+7/JeUzhVOt1HUOC4F7m2Fx4cQXqBerpk5IPmWesg3JfaUnm3ze2b1TjzDaZpYgMRwnmxMCBCEr6+Mpgt9J2OFLeh+k49RjRBKBjoJ7hAlKCHm+jMLpQLMIgpLy4J0DSDRNHyMS7edMZSn/TMswCK0ox0oyvnn8Sd6xsHjKjApXHaXsB6OWJygu8Q76i3n/D452ypPoUckDvVNaiCdYuOU+UeIQkNY1vkePOINLmPchFtOp5VM+jEVK8YMEMT3lKS54nXhfFRtcKkFynXCi+ELuxJDUHHpthq6pQBIKVw2HTldaBrXhEt+LovmF4K5ytua2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(261028144727099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dywuB+BiN2YmXJr1fnjQswCzPSKbyMfPaP4KGmdxT+exwXyhU0GKYIytyRpqplYyQdcbYuzfOseJ92LKdZ10ZvzfZ4hsWu1342lGBIbmvn1k/VHSpFuuBjUAEBQiLECHeO+vJRJiGX4cn4fIe7o96jX4cnXs8kgVqMTet3u+d1e/q5Peu82tlMDFkQLjEykdJuSRQmCIX9B0FSxPqGo8VimpFnJpYkoj64RasDydrx2VAEpNigdDZt1uOfPaKkV5XHudqpaY8vgoffi7kyOcsxS5FyxXeJlHRQbo5TuieBxRffdLAyPAcEwRCKVHyVAvaugGpoLehEX8TthSfBd4Q2dCf1Y6vApwbXAw02ybACqLkAGWm1/tTBOfBpl4CmpO4e9SkY5Z/rEySkSN323Aa5l3CMUgFaWBr3OPYjZzvdz9Dm90uEJAZxZEQad2cTRj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:00.6534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c498da-1531-4423-883b-08df40c7e5c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899

PCI error recovery spans several callbacks. Add state to track its
progress so later patches can keep access blocked until recovery
succeeds and leave it blocked if recovery fails.

Add recovery flags, a sequence counter and saved PCI_COMMAND state.
Initialize per-open state during open and clear it on close. Keep host
recovery state separate so close does not lose an ongoing recovery that
must prevent reopening.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/vfio_pci_core.h    | 18 +++++++++++++++++-
 drivers/vfio/pci/vfio_pci_core.c |  7 +++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 88aa7b752231..f2b64420cb07 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -98,6 +98,11 @@ static inline int vfio_pci_core_get_dmabuf_phys(
 }
 #endif
 
+#define VFIO_PCI_RECOVERY_IN_PROGRESS	BIT(0)
+#define VFIO_PCI_RECOVERY_FROZEN	BIT(1)
+#define VFIO_PCI_RECOVERY_RESET		BIT(2)
+#define VFIO_PCI_RECOVERY_FAILED	BIT(3)
+
 struct vfio_pci_access_ops;
 
 struct vfio_pci_core_device {
@@ -159,7 +164,18 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_access_ops __rcu *access_ops;
 	/* Set after open completes, cleared before close tears down state. */
 	bool			device_open;
-	struct mutex		access_lock;	/* protects changes to access ops and flags */
+	struct mutex		access_lock;	/* protects access and recovery state */
+	u32			pci_recovery_flags;
+	u64			pci_recovery_sequence;
+	/* Saved PCI_COMMAND, valid when pci_recovery_command_valid is set. */
+	u16			pci_recovery_command;
+	bool			pci_recovery_enabled;
+	bool			pci_recovery_command_valid;
+	/*
+	 * Host recovery is still running. Protected by access_lock and kept across
+	 * close, unlike recovery status for the current open.
+	 */
+	bool			pci_recovery_host_active;
 	struct list_head	dmabufs;
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0299f5afca91..cdc6bafe9861 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -923,8 +923,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 
 	if (vdev->pci_recovery_supported) {
 		scoped_guard(mutex, &vdev->access_lock) {
+			WRITE_ONCE(vdev->pci_recovery_enabled, false);
+			vdev->pci_recovery_command_valid = false;
 			WRITE_ONCE(vdev->device_open, false);
 			vfio_pci_core_block_access(vdev);
+			WRITE_ONCE(vdev->pci_recovery_flags, 0);
 		}
 	}
 
@@ -963,6 +966,10 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
 
 	if (vdev->pci_recovery_supported) {
 		guard(mutex)(&vdev->access_lock);
+		WRITE_ONCE(vdev->pci_recovery_flags, 0);
+		vdev->pci_recovery_sequence = 0;
+		vdev->pci_recovery_command_valid = false;
+		WRITE_ONCE(vdev->pci_recovery_enabled, false);
 		WRITE_ONCE(vdev->device_open, true);
 		rcu_assign_pointer(vdev->access_ops, &vfio_pci_live_ops);
 	}
-- 
2.43.0

