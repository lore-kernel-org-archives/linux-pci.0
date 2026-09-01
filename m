Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA6377553;
	Tue,  1 Sep 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255287; cv=fail; b=HZZXG/pGpoTE3MKg7nWtbI4X4Ihf0IXCKuWYKhpbJGQlAydZszyLSD/Txm3c3gy8zwXzqAvmjmuuZZT4rC+qU4TIPavRpo8rpBYqzb9j71bDPvOM47WIAsJlqd+DACpdmnlfGswoiq8O91BGXryfqzk0RxhH7B+dFpFrqNaApsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255287; c=relaxed/simple;
	bh=RT0Gc85JUb/6wT1vm+vaOpL4a8dvcUODNT6FxY2KINo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbABncGz8iOcpzsfuuZtw04Tw2JU1BRBBbNk0JCFGqLsW35kBKd7qXkrYfXYidzPNbyTb2nQ4g9z7d8BmHr0+YM+O6bpk1DIPOLPsNZKGX117rzxABDsPiBERr2Y5FwNsvctkg3+deWwyHvMjUa5VkRFRs7e6N5UXcaQwEQ4myY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+iSk81v; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+iSk81v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuO9atuDBAAu8QtixR9Z2d68p/2T07c+OQZHrjTClh9x6UE4Vvux3upiN8FO3YiLDgyAnxolSeD+MxERWKAZumixmrdUVnmFL7VECynPQksDZVECJEvTpPfF/+dItuhbyWo/vgqdz4ay3JtVPZqMfCN017yUmyper68GlKBJcHLN5ne5BxICrLsyGLmuE3f8uwUS8kG7SHZcuzHfJaYFFklCutlCQnwjN9h+PlQpQYpZmEy61LFaJ+PokrF3UL3QEGp5HHldUgfJ8gPkXXP3apGFrjTDxdAQz7x7ghfw5wuV326bvD38jYN23owenr8/Z83IhD239/r4/cRlPR70uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STyc5hfCh9lq32weljCIPCl8r2ZXaM3EAl7Wxg/bxD4=;
 b=xY8biZpMUblGhdEB36UJTrXp39TIPiBxkbPz7aNh5h2OQMRcsSr/VAxLVFxf8+zSYzvgD9IiYCRcVR+AVeOUK2X+/vfgGia2pIwbLibfB5TtCZu7GSgFK7sLbAU2sQ5zH6Qd/njs3SEbK9++3D+bhPafbJE+yCP40wtEithII6uvTHhp6A6V9fmBH5z3xb5mQZGkim4sLhwqJYacXkTuokVIFtKx0zfB1rqRq3i+bK5rcuOgGXjs/JKLca9n2q57/GLlr2+db7vM+C/HWt9rtJiHOwv5DE9iGFSuyBHX5qV7MnOm1GHa+IFEoJiTsHw/t8BITgrQ4rKeqLiU1lPvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STyc5hfCh9lq32weljCIPCl8r2ZXaM3EAl7Wxg/bxD4=;
 b=c+iSk81v3TppVxE/2WNqm0sunueE1ziSFu57PXSwPBEll/FceS+PPYXtrYF0xxiX9GJOvkRyhAO2KzSdEn0bWK5UVJqo/5tjPdOxLchEizZM+aGfnj8jC21uQtfbNNpcc+uWhQHJQWq32Q+biJ9sD1OTwbsBRHktCaDxg8DRYwckbMBmw+s2oNI6EOMcgJP8qPVd3/qftbJcRUP3Fq1o2rG+Tc7bZy85YR7j6maSwwF/l77twk2YKiWbmAplePylHUUdqgBpj4EOUQ3Ts2t9VYoJb4moZdjseqFiFtAYQy/N0fcxOLdEuuTrXnY/ESVJWPfS7jG6WxrqZ8AWxl5Zkg==
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:34:27 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::28) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:09 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:06 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 15/19] vfio/pci: Add INTx helpers for PCI recovery
Date: Tue, 1 Sep 2026 10:32:13 +0100
Message-ID: <20260901093217.8539-16-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5a9988-0ade-4e63-6974-08df080c375b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|56012099006|5023799004|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	012P70SioJlY3MRHc8725nWOBQwDOO0dlGRcUJca7TpE0j2/LdJ9eSMESSRYQu/grMqHlULDXcmevEFQpJb44inEnGv4duMCZGhmHfqJffnDYCijN5GgA01F4eRmC3GzrSD7n5jNXZhfRwkDlHk+YlwP6Xpyj/ZfgqVTPv1ryra5afEhZdhZwaqsHohZ4s7hQNrFgGjmfkV+osHGgFMOW5EhgVOd7v3SV1iFo0qNzhpUDxxRt66YLNMIbh7qxp4m/8jOtO9ozUER3/qlzeZkSf/zoARMIPzZRdbsULvNz0LvIaYHNSt7LROALEmOb2JTh5tJa5Tp/AweUjnyPtue3e3uCtDmMGG7VY4Inqz1KjfHntmLBv4adjv8qFf+L+VgVmvVIcegIoQnixHrZyQ1V86n9GfpTebOn6kOGVidx3oh7pXDs3Z12RsihHvi6YfVBIoWzTuP4h8bOJoV/HYvsJyDjIZVzd3Lz/5uK3G5CPkNw9UuhMLxf2FS5k9sTpS5Cn3odYF1UxEc25H358nNPIHGFbUwXGt9Nf1B4wFRcoqIWgtulBuOqBT3TrHQ8T61pCAzxfIpnczvIH6mzn6fhaNj6wBRjRgpTF8yCMa2KggLrS4jn/omB5+2AMRZLbmrQJjrW9cQRa368so6N6/SWG4u+QzpSuSj4yxgMEc3afNgDpqMzA01sKRw9a2CPyZSyJ3HyiakLU22gzNxks26cg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(5023799004)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YvToXHLGtDEHdzODkJtU3aiwQ7yCGyIktQwcED+xiI7VibLYZqK4GWMwpj3md0ssUGDkd0WGP855PTiiouUtZUq5Y2OxCoPQSiF0FnwMDvDnxuOBY9wzxp8yglKVXet15y3GVd3sd9U7O0QYhSgErUQ+A8PRTtVlo8JWBOYjBgJUAXTZdBXgrKgfWlZqye/ja4NigCo8pQYcqOLPA/0Uly/Bm5pw3AKOMu7yG+dR5UBXSEvBbLpDEjfH+vky6SWAF8vM0ctxrH98jRTCG20BOJ7/pJn7Q73iFyRhxsLVHsjzBHyE4rS/QvfzoJLzwNW0UIIO34wMzzOIs21OctHsJliILf92q6wINQXOECzuoOonKJhlx3IRikR8x9nhZZprOn7dTt/Y7BQBqCe/+Vb7IMpmDk7U+zzwsMQg8UFr4dzYqSAL5N8Urck1rZjIlmUj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:26.9472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5a9988-0ade-4e63-6974-08df080c375b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

Add the helpers the recovery callbacks need to keep INTx in step with an
error event, and the two per-context flags they record it in. Nothing
calls them yet.

vfio_pci_intx_recovery_start() masks the line when an event begins.
Nothing has fired at that point, and pci_check_and_mask_intx() only writes
DisINTx when the status register says an interrupt is pending, so it would
find nothing to do and leave the line enabled. Use pci_intx() instead,
which masks whatever the device is doing. __vfio_pci_intx_mask() already
does this for the same reason.

vfio_pci_intx_recovery_finish() replays what the event masked, and any
unmask which arrived while it ran, once the event ends. An interrupt which
was masked and delivered while access was blocked is not replayed. The
user was told about it, and unmasks it as it would outside recovery.

vfio_pci_intx_recovery_command() reconciles INTX_DISABLE with the command
word error_detected() saves. error_detected() sets that bit when it writes
the quiesced command word, without recording it as a mask, so the saved
word and ctx->masked can disagree about it. The helper keeps the bit as
the INTx state has it, for resume() to use when it restores the word.
Restoring the saved bit instead would unmask a line the handler still
believes is masked, and a shared pci_2_3 line would storm until
note_interrupt() disabled it for every device on it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h  |   4 ++
 drivers/vfio/pci/vfio_pci_intrs.c | 116 ++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 8a7f9fe22386..5598e472da4b 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -25,6 +25,10 @@ struct vfio_pci_ioeventfd {
 
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev);
+u16 vfio_pci_intx_recovery_command(struct vfio_pci_core_device *vdev,
+				   u16 command);
 
 int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
 				    struct vfio_pci_eventfd __rcu **peventfd,
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 64f80f64ff57..c4a075b5bb2e 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -29,6 +29,8 @@ struct vfio_pci_irq_ctx {
 	struct virqfd			*mask;
 	char				*name;
 	bool				masked;
+	bool				recovery_masked;
+	bool				unmask_pending;
 	struct irq_bypass_producer	producer;
 };
 
@@ -220,6 +222,40 @@ void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 	mutex_unlock(&vdev->igate);
 }
 
+/*
+ * Mask INTx because recovery has blocked device access. Returns true if this
+ * call did the masking, which means recovery is the one which must unmask.
+ *
+ * Nothing is normally asserted when a recovery starts, and
+ * pci_check_and_mask_intx() only writes DisINTx when the status register says
+ * an interrupt is pending, so it would leave the line alone. pci_intx() masks
+ * whatever the device is doing, as __vfio_pci_intx_mask() already does for the
+ * same reason.
+ *
+ * Masking a pci_2_3 device goes through config space. If the error left
+ * config space unreadable the write has no effect and the line stays
+ * asserted, which is no worse than not trying. For a non-fatal error config
+ * space still works, and this is what keeps a shared line from storming while
+ * access is blocked.
+ */
+static bool vfio_pci_intx_mask_for_recovery(struct vfio_pci_core_device *vdev,
+					    struct vfio_pci_irq_ctx *ctx)
+{
+	lockdep_assert_held(&vdev->irqlock);
+
+	if (ctx->masked)
+		return false;
+
+	if (!vdev->pci_2_3)
+		disable_irq_nosync(vdev->pdev->irq);
+	else
+		pci_intx(vdev->pdev, 0);
+
+	ctx->masked = true;
+	ctx->recovery_masked = true;
+	return true;
+}
+
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_irq_ctx *ctx = dev_id;
@@ -247,6 +283,86 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
+void vfio_pci_intx_recovery_start(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_irq_ctx *ctx;
+	unsigned long flags;
+
+	lockdep_assert_held_write(&vdev->recovery_lock);
+
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (!is_intx(vdev))
+		goto out_unlock;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (WARN_ON_ONCE(!ctx))
+		goto out_unlock;
+
+	vfio_pci_intx_mask_for_recovery(vdev, ctx);
+
+out_unlock:
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+}
+
+/*
+ * Replay the masking recovery did, and any unmask which arrived while it was
+ * blocked. Call this only after access_blocked has been cleared, or the
+ * replayed unmask is swallowed and recorded as pending again with nothing
+ * left to replay it.
+ */
+/*
+ * The command word saved before the quiesce can have INTX_DISABLE clear, but
+ * the INTx handler may have masked the line since. Keep the bit as the INTx
+ * state has it, so hardware and ctx->masked agree until
+ * vfio_pci_intx_recovery_finish() replays. Restoring the saved bit instead
+ * would unmask a line the handler still believes is masked, and a shared
+ * pci_2_3 line would then storm until note_interrupt() disables it.
+ */
+u16 vfio_pci_intx_recovery_command(struct vfio_pci_core_device *vdev,
+				   u16 command)
+{
+	struct vfio_pci_irq_ctx *ctx;
+
+	lockdep_assert_held(&vdev->irqlock);
+
+	if (!is_intx(vdev))
+		return command;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (ctx && ctx->masked)
+		command |= PCI_COMMAND_INTX_DISABLE;
+
+	return command;
+}
+
+void vfio_pci_intx_recovery_finish(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_irq_ctx *ctx;
+	unsigned long flags;
+	bool replay = false;
+
+	lockdep_assert_held_write(&vdev->recovery_lock);
+
+	mutex_lock(&vdev->igate);
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	if (!is_intx(vdev))
+		goto out_unlock;
+
+	ctx = vfio_irq_ctx_get(vdev, 0);
+	if (WARN_ON_ONCE(!ctx))
+		goto out_unlock;
+
+	replay = ctx->recovery_masked || ctx->unmask_pending;
+	ctx->recovery_masked = false;
+	ctx->unmask_pending = false;
+
+out_unlock:
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+	if (replay)
+		__vfio_pci_intx_unmask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 			    struct eventfd_ctx *trigger)
 {
-- 
2.43.0

