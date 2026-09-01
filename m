Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CB444713;
	Tue,  1 Sep 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247063; cv=none; b=JTW/kxk+m8y40RBKtiH0uVPaNz32Q5ZIJcBHd56BNpjswfsdSg13tOEvfQr9YisPhplUaNJDuBf+w7XnZb911dCu9h2HzLGoEDC9Ue0mWwD0hRFaEEurmx6ZEvzlWTQl7LpDtMmu4j+3tFKFPZxY/w/JjhdhSFqhSN2oT8vilV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247063; c=relaxed/simple;
	bh=oM7jTywyNKXV8MRK/mEIG+T9Y7F/Zg9SscLfN4EgX/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vqoy/UHj63WvfLDKj3IJayw7NoWKAHnOAB2ANkeX/DYPBwljNdbjUgKm+jrLiBHTPtyEYeh3T2jP0f5UCMDdWRrMPRmyxUSAdQDll/idGFk5Lr9akyMb/nOPKGSdepaz9v8gTemOWO5nAtjRri+K+CM3mFaDzc+z8qaFTHxhAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00801614-5.535e-05-0.991929;FP=18014790336117556458|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j2BhS9h_1788247050;
Received: from localhost.localdomain(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j2BhS9h_1788247050 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:17:31 +0800
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
Subject: [PATCH v4 5/5] x86/hygon: Add Family 0x18 SMN access
Date: Tue,  1 Sep 2026 15:17:00 +0800
Message-ID: <20260901071700.3255382-6-wanglin@open-hieco.net>
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

Hygon Family 0x18 DF nodes in a socket share an SMN ingress. The root
groups therefore need to be associated with sockets before they can be
expanded to the dense DF node indices.

Build the node-to-root map after DF enumeration and expose Hygon SMN
read and write helpers. Hold a reference and reserve PCI config space
for every root used by the built-in node layer. SMN remains unavailable
if root discovery or mapping fails.

Signed-off-by: Lin Wang <wanglin@open-hieco.net>
---
 arch/x86/include/asm/hygon/node.h |  38 ++++-
 arch/x86/kernel/hygon_node.c      | 275 +++++++++++++++++++++++++++++-
 2 files changed, 310 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hygon/node.h b/arch/x86/include/asm/hygon/node.h
index bc4e588ab405..b8a11d85eaee 100644
--- a/arch/x86/include/asm/hygon/node.h
+++ b/arch/x86/include/asm/hygon/node.h
@@ -2,8 +2,8 @@
 /*
  * Hygon Family 0x18 Data Fabric node enumeration API
  *
- * This header declares Hygon Fam18h DF node enumeration and function
- * access interfaces.
+ * DF node identity, CPU-to-DF-node translation, DF function lookup and
+ * SMN access for Hygon Family 0x18.
  */
 #ifndef _ASM_X86_HYGON_NODE_H
 #define _ASM_X86_HYGON_NODE_H
@@ -125,6 +125,30 @@ struct pci_dev *hygon_node_get_func(u16 node, u8 func);
  */
 int hygon_pci_dev_to_df_node(struct pci_dev *pdev);
 
+/**
+ * hygon_smn_read() - read a 32-bit value from a Hygon SMN address
+ * @node: DF node index in [0, hygon_node_num())
+ * @address: SMN address
+ * @value: output value
+ *
+ * Return: 0 on success, -EINVAL if @value is NULL, -ENODEV if Hygon
+ * SMN is not initialised or @node is out of range, or a negative
+ * errno from the underlying PCI config access.
+ */
+int __must_check hygon_smn_read(u16 node, u32 address, u32 *value);
+
+/**
+ * hygon_smn_write() - write a 32-bit value to a Hygon SMN address
+ * @node: DF node index in [0, hygon_node_num())
+ * @address: SMN address
+ * @value: value to write
+ *
+ * Return: 0 on success, -ENODEV if Hygon SMN is not initialised or
+ * @node is out of range, or a negative errno from the underlying
+ * PCI config access.
+ */
+int __must_check hygon_smn_write(u16 node, u32 address, u32 value);
+
 #else /* !CONFIG_HYGON_NODE */
 
 static inline u16 hygon_node_num(void)
@@ -157,6 +181,16 @@ static inline int hygon_pci_dev_to_df_node(struct pci_dev *pdev)
 	return -ENODEV;
 }
 
+static inline int hygon_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+static inline int hygon_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_HYGON_NODE */
 
 /* Inline helpers, available regardless of CONFIG_HYGON_NODE. */
diff --git a/arch/x86/kernel/hygon_node.c b/arch/x86/kernel/hygon_node.c
index e2aa7de180e9..2fcd75ee71e9 100644
--- a/arch/x86/kernel/hygon_node.c
+++ b/arch/x86/kernel/hygon_node.c
@@ -16,10 +16,12 @@
 #define pr_fmt(fmt) "hygon_node: " fmt
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/processor.h>
@@ -714,8 +716,275 @@ int hygon_pci_dev_to_df_node(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(hygon_pci_dev_to_df_node);
 
 /*
- * Build the Hygon DF node cache at fs_initcall.
+ * SMN index/data register pair offsets in the host-bridge PCI config
+ * space.  Reads and writes to a (node, address) pair are issued as a
+ * two-step transaction: write the SMN address to the index register,
+ * then read or write the value at the data register.
  */
+#define HYGON_SMN_INDEX_OFFSET	0x60
+#define HYGON_SMN_DATA_OFFSET	0x64
+
+/*
+ * Runtime SMN state. hygon_smn_exclusive remains false until setup
+ * succeeds. hygon_smn_reserved_roots owns the independent PCI references
+ * and config-space reservations for the lifetime of the built-in node
+ * layer; hygon_smn_roots contains per-node aliases.
+ */
+static struct pci_dev	**hygon_smn_roots;
+static struct pci_dev	**hygon_smn_reserved_roots;
+static u16		hygon_smn_num_nodes;
+static bool		hygon_smn_exclusive;
+static DEFINE_MUTEX(hygon_smn_mutex);
+
+/* Internal cache accessors used by SMN setup. */
+static u8 __init hygon_node_socket(u16 node)
+{
+	if (!hygon_cache.ready || node >= hygon_cache.num_nodes)
+		return U8_MAX;
+	return hygon_cache.nodes[node].socket_id;
+}
+
+static u16 __init hygon_socket_num(void)
+{
+	return hygon_cache.ready ? hygon_cache.num_sockets : 0;
+}
+
+/*
+ * Walk PCI host-bridge devices matching the Hygon vendor. The SMN
+ * index/data registers live in function 0 of each root complex. This
+ * follows pci_get_class() iterator semantics: @root is consumed and the
+ * returned device has an iterator reference. A retained device needs an
+ * independent reference before the iterator advances.
+ */
+static struct pci_dev * __init hygon_get_next_root(struct pci_dev *root)
+{
+	while ((root = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, root))) {
+		if (root->devfn)
+			continue;
+		if (root->vendor != PCI_VENDOR_ID_HYGON)
+			continue;
+		break;
+	}
+	return root;
+}
+
+/* Release each config region before dropping its owning device reference. */
+static void __init hygon_release_reserved_roots(struct pci_dev **roots,
+						u16 count)
+{
+	u16 i;
+
+	for (i = 0; i < count; i++) {
+		pci_release_config_region(roots[i], 0, PCI_CFG_SPACE_SIZE);
+		pci_dev_put(roots[i]);
+	}
+}
+
+/*
+ * Select one root from each contiguous per-socket enumeration group,
+ * then map every DF node to the root for its socket. The root socket ID
+ * cannot be read back, so the grouping follows PCI enumeration order.
+ *
+ * hygon_smn_reserved_roots owns the PCI references and config regions;
+ * hygon_smn_roots contains per-node aliases. Enable SMN access only after
+ * both arrays are complete.
+ */
+static int __init hygon_smn_setup(void)
+{
+	struct pci_dev *socket_roots[HYGON_MAX_SOCKETS] = { };
+	struct pci_dev **reserved_roots, **roots, *owned_root, *root;
+	u16 count, num_roots, roots_per_socket, node, num_nodes;
+	u16 num_sockets, reserved, socket;
+	u8 socket_id;
+	int ret;
+
+	num_roots = 0;
+	root = NULL;
+	while ((root = hygon_get_next_root(root)))
+		num_roots++;
+
+	pr_debug("Found %u Hygon SMN root devices\n", num_roots);
+
+	if (!num_roots)
+		return -ENODEV;
+
+	num_nodes = hygon_node_num();
+	if (!num_nodes)
+		return -ENODEV;
+
+	num_sockets = hygon_socket_num();
+	if (!num_sockets)
+		return -ENODEV;
+
+	if (num_sockets > ARRAY_SIZE(socket_roots)) {
+		pr_err("Socket count %u exceeds maximum %zu\n",
+		       num_sockets, ARRAY_SIZE(socket_roots));
+		return -EINVAL;
+	}
+
+	if (num_roots % num_sockets) {
+		pr_err("Root count %u not divisible by socket count %u\n",
+		       num_roots, num_sockets);
+		return -ENODEV;
+	}
+
+	roots = kcalloc(num_nodes, sizeof(*roots), GFP_KERNEL);
+	if (!roots)
+		return -ENOMEM;
+
+	reserved_roots = kcalloc(num_roots, sizeof(*reserved_roots),
+				 GFP_KERNEL);
+	if (!reserved_roots) {
+		kfree(roots);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Keep the first of every roots_per_socket consecutive roots and
+	 * skip the rest.  This groups roots by enumeration order, relying on
+	 * the platform enumerating each socket's roots contiguously.  Roots
+	 * within the same socket are redundant SMN ingress points.
+	 */
+	roots_per_socket = num_roots / num_sockets;
+	socket = 0;
+	reserved = 0;
+	count = 0;
+	root = NULL;
+	while ((root = hygon_get_next_root(root))) {
+		if (reserved >= num_roots) {
+			ret = -ENODEV;
+			pci_dev_put(root);
+			goto err_release;
+		}
+
+		pci_dbg(root, "Reserving PCI config space\n");
+
+		/*
+		 * Mark the entire PCI config space kernel-exclusive because it
+		 * contains the SMN index/data registers.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0,
+							 PCI_CFG_SPACE_SIZE,
+							 NULL)) {
+			pci_err(root, "Failed to reserve config space\n");
+			ret = -EEXIST;
+			/* This exit does not advance the iterator. */
+			pci_dev_put(root);
+			goto err_release;
+		}
+
+		owned_root = pci_dev_get(root);
+		reserved_roots[reserved++] = owned_root;
+
+		if (count++ % roots_per_socket)
+			continue;
+
+		if (socket >= num_sockets) {
+			ret = -ENODEV;
+			pci_dev_put(root);
+			goto err_release;
+		}
+
+		pci_dbg(root, "is root for Hygon socket %u\n", socket);
+		socket_roots[socket++] = owned_root;
+	}
+
+	if (reserved != num_roots || socket != num_sockets) {
+		pr_err("Root enumeration changed: expected %u roots/%u sockets, got %u/%u\n",
+		       num_roots, num_sockets, reserved, socket);
+		ret = -ENODEV;
+		goto err_release;
+	}
+
+	for (node = 0; node < num_nodes; node++) {
+		socket_id = hygon_node_socket(node);
+
+		if (socket_id >= num_sockets) {
+			ret = -ENODEV;
+			goto err_release;
+		}
+
+		pci_dbg(socket_roots[socket_id],
+			"is root for Hygon node %u (socket %u)\n",
+			node, socket_id);
+		roots[node] = socket_roots[socket_id];
+	}
+
+	hygon_smn_reserved_roots = reserved_roots;
+	hygon_smn_roots = roots;
+	hygon_smn_num_nodes = num_nodes;
+	hygon_smn_exclusive = true;
+	return 0;
+
+err_release:
+	hygon_release_reserved_roots(reserved_roots, reserved);
+	kfree(reserved_roots);
+	kfree(roots);
+	return ret;
+}
+
+/*
+ * Serialize the PCI index/data pair between in-kernel SMN users.
+ * The transaction follows amd_smn_read/write();
+ * hygon_smn_setup() provides the Hygon node-to-root mapping.
+ */
+static int __hygon_smn_rw(u16 node, u32 address, u32 *value, bool write)
+{
+	struct pci_dev *root;
+	int err;
+
+	if (!hygon_smn_exclusive || node >= hygon_smn_num_nodes)
+		return -ENODEV;
+
+	root = hygon_smn_roots[node];
+	if (!root)
+		return -ENODEV;
+
+	guard(mutex)(&hygon_smn_mutex);
+
+	err = pci_write_config_dword(root, HYGON_SMN_INDEX_OFFSET, address);
+	if (err) {
+		pr_warn("SMN index write failed (addr 0x%x)\n", address);
+		return pcibios_err_to_errno(err);
+	}
+
+	err = write ? pci_write_config_dword(root, HYGON_SMN_DATA_OFFSET, *value)
+		    : pci_read_config_dword(root, HYGON_SMN_DATA_OFFSET, value);
+
+	return pcibios_err_to_errno(err);
+}
+
+int hygon_smn_read(u16 node, u32 address, u32 *value)
+{
+	int err;
+
+	if (!value)
+		return -EINVAL;
+
+	err = __hygon_smn_rw(node, address, value, false);
+
+	/* Clear the output so callers do not consume a stale value. */
+	if (err) {
+		*value = 0;
+		return err;
+	}
+
+	/* Treat the PCI all-ones value as a missing device. */
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		*value = 0;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hygon_smn_read);
+
+int hygon_smn_write(u16 node, u32 address, u32 value)
+{
+	return __hygon_smn_rw(node, address, &value, true);
+}
+EXPORT_SYMBOL_GPL(hygon_smn_write);
+
 static int __init hygon_node_init(void)
 {
 	int ret;
@@ -733,6 +1002,10 @@ static int __init hygon_node_init(void)
 		return ret;
 	}
 
+	ret = hygon_smn_setup();
+	if (ret)
+		pr_warn("SMN setup failed: %d\n", ret);
+
 	return 0;
 }
 fs_initcall(hygon_node_init);
-- 
2.43.0

