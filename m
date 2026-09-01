Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1F459AD5;
	Tue,  1 Sep 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247378; cv=none; b=AheEta5f6gLIw9YyaUQSg+sOs2Ea+H6NnNajfBYLMx9e8if5PFlTa2e0r0fx6xhG9bL2amjUcUBeUtvAU3kD/Z3XByw6X/AA3+xB8PFsBR3tZttxIbFAEvq9gh6dWriKLUOM8Jd5e+e6Nbp+zbV8njgIjrFu1FOAdz3/3iAIC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247378; c=relaxed/simple;
	bh=Rt6CARWCsUJX+Jom/I6/vw1DI1CRzJ9Coan0W1eu8DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC0ADTw1bVHXRcTdowXxVR5SgPaBsOxvV+xaMPvD4839eBuB8Kv/+PkSEuY7Mh14YsznFuwsIMRS+bIJQ65c0/0WdMjs+zQv/xLUeZfxkTo37Cxv6eVw6lgKi2gx+ZmzlE1IdcE1cL9gerB4hcMtFhzLSLGqBVmGdlLEJ90ff0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437249|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00632327-0.00115466-0.992522;FP=14413116455023103195|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j2BhS6r_1788247049;
Received: from localhost.localdomain(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j2BhS6r_1788247049 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:17:29 +0800
From: Lin Wang <wanglin@open-hieco.net>
To: Borislav Petkov <bp@alien8.de>,
	yazen.ghannam@amd.com,
	mario.limonciello@amd.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	bhelgaas@google.com,
	x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] x86/hygon: Map CPU NodeIds to DF nodes
Date: Tue,  1 Sep 2026 15:16:58 +0800
Message-ID: <20260901071700.3255382-4-wanglin@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901071700.3255382-1-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On bare-metal Hygon systems, CPUID 0x8000001E ECX[7:0] encodes a
CPU's socket and local CDD ordinal. The value is sparse across sockets
and cannot be used as an index into the dense DF node cache.

Translate the CPUID value through the CDDs sorted by socket and DFID.
The NodeId reported by CPUID in a guest may not describe the physical
DF topology. Return -ENODEV in guests or when the NodeId does not
identify an enumerated CDD.

Signed-off-by: Lin Wang <wanglin@open-hieco.net>
---
 arch/x86/include/asm/hygon/node.h | 21 ++++++++++++
 arch/x86/kernel/hygon_node.c      | 53 +++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/x86/include/asm/hygon/node.h b/arch/x86/include/asm/hygon/node.h
index 6e15c133b774..bc4e588ab405 100644
--- a/arch/x86/include/asm/hygon/node.h
+++ b/arch/x86/include/asm/hygon/node.h
@@ -82,6 +82,22 @@ u16 hygon_cdd_num(void);
  */
 int hygon_node_get_info(u16 node, struct hygon_node_info *info);
 
+/**
+ * hygon_cpu_to_df_node() - map CPU to dense DF CDD index
+ * @cpu: CPU index
+ *
+ * Hygon Fam18h exposes sparse physical node IDs via CPUID 8000001E[7:0].
+ * This function translates the per-CPU physical node ID into a dense
+ * DF CDD index in [0, hygon_cdd_num()). The NodeId reported by CPUID in
+ * a guest may not describe the physical DF topology, so the translation
+ * is unavailable in guests.
+ *
+ * Return: DF CDD index on success, -EINVAL if @cpu is out of range,
+ * -ENODEV if CPU-to-DF mapping is unavailable or the physical node ID
+ * does not map to a known DF node.
+ */
+int hygon_cpu_to_df_node(unsigned int cpu);
+
 /**
  * hygon_node_get_func() - get DF function PCI device for a node
  * @node: DF node index in [0, hygon_node_num())
@@ -126,6 +142,11 @@ static inline int hygon_node_get_info(u16 node, struct hygon_node_info *info)
 	return -ENODEV;
 }
 
+static inline int hygon_cpu_to_df_node(unsigned int cpu)
+{
+	return -ENODEV;
+}
+
 static inline struct pci_dev *hygon_node_get_func(u16 node, u8 func)
 {
 	return NULL;
diff --git a/arch/x86/kernel/hygon_node.c b/arch/x86/kernel/hygon_node.c
index 85835938315b..e2aa7de180e9 100644
--- a/arch/x86/kernel/hygon_node.c
+++ b/arch/x86/kernel/hygon_node.c
@@ -16,6 +16,8 @@
 #define pr_fmt(fmt) "hygon_node: " fmt
 
 #include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -23,6 +25,7 @@
 #include <linux/processor.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/topology.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/hygon/node.h>
@@ -554,6 +557,40 @@ static int __init hygon_sort_and_classify(struct hygon_node_cache *cache)
 	return 0;
 }
 
+/*
+ * Translate a Hygon Fam18h phys_node_id (CPUID 8000001E ECX[7:0]) to a
+ * dense DF CDD index.  On supported models, the node layer uses
+ * this encoding:
+ *
+ *   phys_node_id = (socket_id << 4) | local_cdd_index_in_dfid_order
+ *
+ * The cache->nodes[] CDD region is sorted by (socket_id ASC, dfid ASC),
+ * so walk it and return the actual cache index of the CDD whose
+ * socket_id matches and whose socket-local ordinal is @local.
+ *
+ * Return -ENODEV if the cache is unavailable or no CDD matches.
+ */
+static int hygon_phys_nid_to_df_node(unsigned int phys_nid)
+{
+	unsigned int socket = phys_nid >> 4;
+	unsigned int local = phys_nid & 0xf;
+	unsigned int ordinal = 0;
+	u16 i;
+
+	if (!hygon_cache.ready)
+		return -ENODEV;
+
+	for (i = 0; i < hygon_cache.num_cdd; i++) {
+		if (hygon_cache.nodes[i].socket_id != socket)
+			continue;
+
+		if (ordinal++ == local)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
 /*
  * Build the global DF node cache.
  *
@@ -618,6 +655,22 @@ int hygon_node_get_info(u16 node, struct hygon_node_info *info)
 }
 EXPORT_SYMBOL_GPL(hygon_node_get_info);
 
+int hygon_cpu_to_df_node(unsigned int cpu)
+{
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	/*
+	 * The NodeId reported by CPUID in a guest may not describe the
+	 * physical DF topology.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
+	return hygon_phys_nid_to_df_node(topology_amd_node_id(cpu));
+}
+EXPORT_SYMBOL_GPL(hygon_cpu_to_df_node);
+
 struct pci_dev *hygon_node_get_func(u16 node, u8 func)
 {
 	if (!hygon_cache.ready)
-- 
2.43.0

