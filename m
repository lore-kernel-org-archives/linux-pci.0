Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1B3F0752;
	Thu, 28 May 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972424; cv=none; b=lUKHorE4vrtKxMJVBLOOI7aBcgYs7a5HMh9raSlxzoHGref1ZO8shnrXygD4JCpHL3ZMg0QHzDakdrmXRuoGdovQ8m75dhUpOOIX6ZHiSOEfetdayY4de7cd74ByGDsE7EChS0MiVT3bg3woUsFEAAIdZH7XmkMbwbdTakWwI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972424; c=relaxed/simple;
	bh=KeijSz0MPdR2YV//9PD0XFJstgbPzFHp2lEnv4itE9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2SbTyIrCugukUxEUwy+JNB9kTkl9/6eXJt8eIPma0JuhqrhiCjLvqguZjAVT3HBLMI3xTKN8Dz0Rhs55sD2C/hPmwKxfx7093omake7Aop4yc5yMff+whi6O6IEk7rVv0v06sNYW8zueWVFWGsJ56zYClVpGyiHIYDm+tZ/yC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HUQp7hhw; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HUQp7hhw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=thVZQk17TmA7yi1q/CiSLw3NNkQPaWVlBVIUh8Np8Is=;
	b=HUQp7hhw/WMN0tD9XzBE1Bibl1Rtx35FvlRNMoZhyOxSfnJirVCS74HQTQQvrFZpRF3fMsh9a
	w5M8xtCbR7a5X4j7pXWcRAPk/VZK0mPT0djWoxAbJxel//d55KTWknLeKInCltH67oNMH3wkOPT
	jObOppRNdgVhWZ2+Z4r5VQ0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gR5dm28NpzKmXn;
	Thu, 28 May 2026 20:39:08 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 20B5D4055B;
	Thu, 28 May 2026 20:46:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 4/8] PCI/TPH: Add requester policy to pcie_tph_get_cpu_st()
Date: Thu, 28 May 2026 20:46:45 +0800
Message-ID: <20260528124649.14732-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Extend pcie_tph_get_cpu_st() to accept enum tph_req_policy, so callers
can retrieve Steering Tag for standard or extended TPH explicitly.

Add input validation and extended TPH capability check. Update function
prototype, inline stub, kernel-doc and Documentation/PCI/tph.rst.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 Documentation/PCI/tph.rst                     | 10 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 ++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  3 ++-
 drivers/pci/tph.c                             | 26 ++++++++++++++++---
 include/linux/pci-tph.h                       |  9 +++++--
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index a5f14d17977c..17a369e72af1 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -87,11 +87,13 @@ To retrieve a Steering Tag for a target memory associated with a specific
 CPU, use the following function::
 
   int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
+                          enum tph_req_policy req_policy,
                           unsigned int cpu, u16 *tag);
 
 The `type` argument is used to specify the memory type, either volatile
-or persistent, of the target memory. The `cpu` argument specifies the
-CPU where the memory is associated to.
+or persistent, of the target memory. The `req_policy` used to select
+standard/extended ST. The `cpu` argument specifies the CPU where the memory
+is associated to.
 
 After the ST value is retrieved, the device driver can use the following
 function to write the ST into the device::
@@ -125,8 +127,8 @@ been changed. Here is a sample code for IRQ affinity notifier:
          /* Pick a right CPU as the target - here is just an example */
          cpu_id = cpumask_first(irq->cpu_mask);
 
-         if (pcie_tph_get_cpu_st(irq->pdev, TPH_MEM_TYPE_VM, cpu_id,
-                                 &tag))
+         if (pcie_tph_get_cpu_st(irq->pdev, TPH_MEM_TYPE_VM, TPH_REQ_AUTO,
+                                 cpu_id, &tag))
              return;
 
          if (pcie_tph_set_st_entry(irq->pdev, irq->msix_nr, tag))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1f8d3e728a9f..c3cb7cd7b74a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11734,6 +11734,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 		return;
 
 	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+				TPH_REQ_AUTO,
 				cpumask_first(irq->cpu_mask), &tag))
 		return;
 
@@ -11892,6 +11893,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 
 			/* Init ST table entry */
 			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+						TPH_REQ_AUTO,
 						cpumask_first(irq->cpu_mask),
 						&tag))
 				continue;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
index 26ce59d16785..043e13c95028 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -105,7 +105,8 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
 	if (!st)
 		return -EOPNOTSUPP;
 
-	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, TPH_REQ_AUTO,
+				  cpu_uid, &tag);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index f7758445988e..4a2c3575a883 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -236,24 +236,44 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
  * with a specific CPU
  * @pdev: PCI device
  * @mem_type: target memory type (volatile or persistent RAM)
+ * @req_policy: TPH requester selection policy
+ *
+ *   - TPH_REQ_AUTO:     Use currently active requester type
+ *   - TPH_REQ_STANDARD: Retrieve tag for standard TPH (8-bit ST)
+ *   - TPH_REQ_EXTENDED: Retrieve tag for extended TPH (16-bit ST)
+ *
  * @cpu: associated CPU id
  * @tag: Steering Tag to be returned
  *
- * Return the Steering Tag for a target memory that is associated with a
- * specific CPU as indicated by cpu.
+ * Return the Steering Tag for a target memory and requester policy that is
+ * associated with a specific CPU as indicated by cpu.
  *
  * Return: 0 if success, otherwise negative value (-errno)
  */
 int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
+			enum tph_req_policy req_policy,
 			unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
 	struct pci_dev *rp;
 	acpi_handle rp_acpi_handle;
 	union st_info info;
+	u8 tph_req_type;
 	u32 cpu_uid;
 	int ret;
 
+	if (req_policy == TPH_REQ_AUTO) {
+		tph_req_type = pdev->tph_req_type;
+	} else if (req_policy == TPH_REQ_STANDARD) {
+		tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+	} else if (req_policy == TPH_REQ_EXTENDED) {
+		if (!pdev->tph_ext_requester)
+			return -EINVAL;
+		tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	} else {
+		return -EINVAL;
+	}
+
 	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
 	if (ret != 0)
 		return ret;
@@ -269,7 +289,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 		return -EINVAL;
 	}
 
-	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
+	*tag = tph_extract_tag(mem_type, tph_req_type, &info);
 
 	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
 		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index eb7f165b2570..7f78a40173c9 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -23,10 +23,13 @@ enum tph_mem_type {
 
 /*
  * TPH requester selection policy
- * Used to choose standard/extended TPH when enabling TPH
+ * Used to choose standard/extended TPH when enabling TPH,
+ * and select requester type for Steering Tag retrieval.
  */
 enum tph_req_policy {
-	TPH_REQ_AUTO,		/* Auto select by capability */
+	TPH_REQ_AUTO,		/* Auto select by capability or
+				 * use active requester type
+				 */
 	TPH_REQ_STANDARD,	/* Force standard TPH (8-bit ST) */
 	TPH_REQ_EXTENDED	/* Force extended TPH (16-bit ST) */
 };
@@ -36,6 +39,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
 int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
+			enum tph_req_policy req_policy,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode,
@@ -48,6 +52,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 { return -EINVAL; }
 static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      enum tph_mem_type mem_type,
+				      enum tph_req_policy req_policy,
 				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
-- 
2.17.1

