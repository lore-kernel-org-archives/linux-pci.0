Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C7477E20;
	Tue,  1 Sep 2026 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255255; cv=fail; b=UPebMVDWMwII6eykMzwm+m5TKESjXX5SpL9Wf8SaT7XPyy9WQU1y2MX6Q3IMiXe59OmVUWpyZkrOuJvmkjU6GuLjXdrUH6JeEbK6iKWsVsDI5NE/w2vRz6ifGynYy19henKzySRFJTfrKUqEmzwf9PL9m96MfzGiJtdRDConXN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255255; c=relaxed/simple;
	bh=By0QsfUtpSurdQxUMLis1iXJ5ebYafw/x0bA+xUAPMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5Z0UqHcquqkU9Is+a9mLXV/V2F3lNF6BjU24zDeKUDLmezfIHohpDjw94atB9VHVCXeIlPntJWe6JHAGp7c9NanO7ysySNkbiuRupjugMi3vHpHJf66a2t09MZuBLGenxzyVVG0Hla7KAm9/idHpaxcWEfewRzKCLbupM6ZDQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KXr0CnPK; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXr0CnPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avRQZkNL65Zgjvkot+P4uvZuEW+scC/TPEszu+OVQeWVeCqrodRgi5u1f6tsVYg1660iCzDle62US5fU7c/DBA5d5Ih2BpkQIJ4mAIa9Hpen4aa50VgRe/GJlx/xZnWsmOSOg6p+DFqqBWwsgOiHNoF58BoRKQuEcz4ivpMKkhoHwk+W2BxLLcY5a7u5DYsz/IJQm0baeClhFwq9xEphzhzdJksfxo4Ob6z3sqD7m+6tYEHa+R+4IXKfsgVr5qxH6laQuHkRfmtr/Psk1tRGavqx7dEd9zYmAyLwpq7O+ewbWciHfmjqFpqLLb97LTxe/AUGxhYfUdA1uo1VoLRqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSZ7bqoz9YWBc1j0WC3EsEqKtG1xlz7Hj91FGbI4dzU=;
 b=duFcsR+FLqg/F3H40V8n08Nd7Ed8izHT1ODQtJT5Wfua+/cP18MvuBuYnKJNqpPGCFDfL6DtXOjGPai44C4nuMwq542O97jKdcI/jK+hDGRH06IAWtLWxooqrF4ZFRqzKGdJXZfgl8r9bUlQ73Paemy1U4iZrED+hLBtco3S/wA1mrYKyVsTK463D2z9xn0Ph68yA1V3NvN5JsZh73jGoYTKaFoZaaP0XZ/YMLkDu4mEH6z+V8WVVRK+jRqdD3qZBKCmHW9p3KSyEjrPRNNyKXmED+H5Z8a5fR49Sf2QGFdLrX2M7ng6iZrDKtCp0ZUl3zC9ZZbm144SpsDG7UG5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSZ7bqoz9YWBc1j0WC3EsEqKtG1xlz7Hj91FGbI4dzU=;
 b=KXr0CnPKPFm9KP1wLlTfhK9CQBpm7d5z6EuFdgc3lG+tQju5ft7zflOKWCNFWpili7G1zoujlDboRBeTW4urPK9KSn6f+XcK05KmMLqqdk/pEVw7K98I5xzU++70fNQdUxAiyja9VPS2Vz6sIAwcXuai2DumybIUd0zeLP2CsquZQvQAv6juvZZh5koT8QNxzvKMvlghiieRwmw7kgtTj2Av9x3kfI/fRyCX+82FvSlt0lB49Bzkk+kCoI8vS7w1AJx7i2UO9kBsfpMl6GSfHDf4SDQW5W+i7t6O7rOB0PrHd4n61j2r1lQUqM0MwWMMWP7eafmfwo/x0mr50aaefQ==
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:55 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::11) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:39 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:36 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 07/19] vfio/pci: Retry BAR faults after temporary recovery
Date: Tue, 1 Sep 2026 10:32:05 +0100
Message-ID: <20260901093217.8539-8-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2b1b02-bd07-4780-e18f-08df080c2424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AMyUaDAtrz1ftMPXMZqyt3IQ6YX/KrN3rrthjaxofLuYO1zFRPT7rBWoEa8rD5g1tOTEdUjwSYapFJxXlPJ1QLNaobdOmZE0/jn6sBovehvbdTe8BVKh11Et7724N4CJFOpwibORRC7cH/5cBcV2um32zrlhAwK1xNioeXfVhT5Lkyf7yD8HLYKCwsMCwa+/6DGXOCKQhoIVFbPzECbkgVdYYkBiTV0Txs3CuckH4vW8HPOAiR0XqmUF7kbXcM64Q/cxqaXgUGGAIy4UotNRkxEKm68vSPVeBAjR69CvCUKXg4tay0l8y2FVkNWk+pgVmJT133cjU7rRLv9g4kzSoogdAHfIuqS3garl6tF7VuZ5a5KEy4ldI/RMVYxvS9xhNltgCmk2pf5ncKOpEsh9RgQUEyJZiLaUeluYrupwf8DfUixBYV6EtBXHQs/nz8ngmu6eKU+a17GIISecFmUzMDgFjksqhdOvzI29fLAzJ14F1yeNUoJDEH7dwqTvGcvZs7eYgTkRY22SU4aGarP/LhuibNQ+BSl/r42U5D5vJ4o7tkKZq1V2SjXLTRuxEosT5nicFUq6km5tUKIxdnXFhFG+RMMZlUmcctM32sNnQRS4anokdF5f1bWPyiS1dt+qexhdv3ZhlaocJf+IqkTxb/qYICsK5b0xsrjqErciBgdE8fS6D0UjPuLHHVCuF8BfUZDapqpr0f2E3+xHf8G6oA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hMSSfGpDqmYWdOPoiga7qZYY48yeglhjFtHmSHXQ9uR2uYIapeEoZLZdogZ993w3QaqUKerZ+LjVLfPyIieabV+d2KC+EnBckUWh33DNCataPC6NKTl9S3q5rD85l03wlDquonktSLdC2bBHuRxKArIE5uoGrAuP6jcpLNCvfMGhALmo8WUFshQHNegSD3xDw1js//H6N6QvOH15iadmsADatxHHKrrp6uwtRKmg4PwBBCJGNcTu64efREJbOumWVOW+dtH4PbrGs+5kUNNRDfd0Q2NZTkbynLQFRUmEWkiCYuGyVglNF3++R/nTyMAzBI0lkOOwpBwKuPbKeIAQnlXTW+vriJCviysSSgtK8tab47US+iKNfL6wCFiZwvwPPUFyKND5sLuhRFw24wGQY935CcGqBfkScfNoa428VkawqPlQJFO918K5GfEAMNuJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:54.7344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2b1b02-bd07-4780-e18f-08df080c2424
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721

A guest can fault on a mapped BAR while host recovery is running. Do not
insert the PFN in that case. The device is not usable until recovery is
finished.

Wait whenever access is blocked, not only while a recovery transaction is
in progress. A function reset blocks access without starting one, and
error_detected() blocks it before it publishes the flags, so a fault in
either window would otherwise fail for good. Only a closed device, or one
which has failed for good, ends the fault, which is what
VFIO_PCI_RECOVERY_FAILED records.

On the first attempt the fault lock can be dropped, so drop it, wait for
recovery, and return VM_FAULT_RETRY to bring the fault back later. The
wait is killable. Take a reference on the device registration before
dropping the lock, because the wait outlives the lock and the device
could go away. This is the FAULT_FLAG_ALLOW_RETRY set and
FAULT_FLAG_TRIED clear case.

Once the lock is dropped the VMA may be gone, so return without touching
it. The caller returns early too and skips its debug print, which reads
both the VMA and the device.

When the fault lock cannot be dropped, because the caller did not allow a
retry or this fault has already used one, wait with it held.

Look at the state once more after that wait and return SIGBUS if recovery
is still not done, rather than wait again with the lock held. That fails
a fault which might still have recovered, but the window is narrow.

The wait condition is read without recovery_lock, so it only says when to
look again. Every path which unblocks access wakes the queue, and the
decision itself is taken under the lock on the next look.

It is not a deadlock. Recovery revokes mappings with
unmap_mapping_range(), which does not take mmap_lock. The wait is
killable. SIGBUS is also what a closed device, or one which has failed
for good, returns.

The order matters. The fault takes memory_lock before it releases
recovery_lock, so from the check until the PFN is in it always holds at
least one of the two. Recovery needs both, so it cannot finish revoking
while a fault is part way through. If the fault let go of recovery_lock
before taking memory_lock, recovery could slip into that window and
revoke everything, and the fault would then map a PFN for a device which
was already revoked.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 128 ++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3645daa8891f..d46448662e84 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1937,6 +1937,127 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
 
+/*
+ * Whether a fault which found access blocked is worth retrying. Read
+ * without recovery_lock, so it is only a hint about when to look again.
+ * vfio_pci_fault_trylock_once() takes the lock and decides. Read the flags
+ * once so the two tests below see the same value. Every writer which can
+ * make this true wakes pci_recovery_wait.
+ */
+static bool vfio_pci_recovery_done(struct vfio_pci_core_device *vdev)
+{
+	u32 flags = READ_ONCE(vdev->pci_recovery_flags);
+
+	if (!READ_ONCE(vdev->pci_recovery_device_open))
+		return true;
+	if (flags & VFIO_PCI_RECOVERY_IN_PROGRESS)
+		return false;
+	if (flags & VFIO_PCI_RECOVERY_FAILED)
+		return true;
+	return !READ_ONCE(vdev->pci_recovery_access_blocked);
+}
+
+static int vfio_pci_wait_for_recovery(struct vfio_pci_core_device *vdev)
+{
+	return wait_event_killable(vdev->pci_recovery_wait,
+				   vfio_pci_recovery_done(vdev));
+}
+
+/* What one look at the recovery state says the fault should do. */
+enum vfio_pci_fault_action {
+	VFIO_PCI_FAULT_PROCEED,	/* returns with memory_lock held */
+	VFIO_PCI_FAULT_WAIT,	/* recovery is running, may still recover */
+	VFIO_PCI_FAULT_FAIL,	/* closed, or failed for good */
+};
+
+static enum vfio_pci_fault_action
+vfio_pci_fault_trylock_once(struct vfio_pci_core_device *vdev)
+{
+	enum vfio_pci_fault_action action;
+
+	down_read(&vdev->recovery_lock);
+	if (!vdev->pci_recovery_device_open ||
+	    (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED)) {
+		action = VFIO_PCI_FAULT_FAIL;
+	} else if (vdev->pci_recovery_access_blocked) {
+		/*
+		 * Blocked for a reason which still ends: a recovery which has
+		 * not failed, or a function reset. Test FAILED above rather
+		 * than IN_PROGRESS here, so a fault does not fail for good
+		 * while a reset is running, or in the window where
+		 * error_detected() has blocked access but not yet published
+		 * the flags.
+		 */
+		action = VFIO_PCI_FAULT_WAIT;
+	} else {
+		down_read(&vdev->memory_lock);
+		action = VFIO_PCI_FAULT_PROCEED;
+	}
+	up_read(&vdev->recovery_lock);
+
+	return action;
+}
+
+/*
+ * Return true with memory_lock held for a fault that may proceed. Otherwise
+ * return false with @ret set to the result the fault handler should return.
+ */
+static bool vfio_pci_core_fault_trylock(struct vfio_pci_core_device *vdev,
+					struct vm_fault *vmf,
+					vm_fault_t *ret)
+{
+	if (!vdev->pci_recovery_supported) {
+		down_read(&vdev->memory_lock);
+		return true;
+	}
+
+	switch (vfio_pci_fault_trylock_once(vdev)) {
+	case VFIO_PCI_FAULT_PROCEED:
+		return true;
+	case VFIO_PCI_FAULT_FAIL:
+		*ret = VM_FAULT_SIGBUS;
+		return false;
+	case VFIO_PCI_FAULT_WAIT:
+		break;
+	}
+
+	if (fault_flag_allow_retry_first(vmf->flags)) {
+		if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
+			*ret = VM_FAULT_RETRY;
+			return false;
+		}
+
+		if (!vfio_device_try_get_registration(&vdev->vdev)) {
+			*ret = VM_FAULT_SIGBUS;
+			return false;
+		}
+
+		release_fault_lock(vmf);
+		vfio_pci_wait_for_recovery(vdev);
+		vfio_device_put_registration(&vdev->vdev);
+		*ret = VM_FAULT_RETRY;
+		return false;
+	}
+
+	/*
+	 * The fault lock cannot be dropped here: either the caller did not
+	 * allow a retry, or this fault has already used one. So wait with
+	 * it held. It is not a deadlock. Recovery revokes mappings through
+	 * unmap_mapping_range(), which never takes mmap_lock. The wait is
+	 * killable.
+	 */
+	if (vfio_pci_wait_for_recovery(vdev)) {
+		*ret = VM_FAULT_NOPAGE;
+		return false;
+	}
+
+	if (vfio_pci_fault_trylock_once(vdev) == VFIO_PCI_FAULT_PROCEED)
+		return true;
+
+	*ret = VM_FAULT_SIGBUS;
+	return false;
+}
+
 static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
@@ -1948,8 +2069,11 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		if (!vfio_pci_core_fault_trylock(vdev, vmf, &ret))
+			return ret;
+
+		ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		up_read(&vdev->memory_lock);
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
-- 
2.43.0

