Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993182;
	b=HEwireLfKOdYcWTq+tI6IlL5u/iMfIYHXcpg36P1EA4uTdFeUU1Em4NSig5aI9B4hYNx
	 IX/a29ZQZTi2lFD/SS3X0vzKRNKk9ihD+ea9f9Ka6vCri5S9v//oRACRVXZQNnLKDL/TF
	 c7PdAue0zlln58UPCCtqVR6nupYW0ZJDqal/3fcMEnQIekAl+z+sSrlIjbeCpxdaCQPmB
	 g5aE2K4FVN/Sdz3i3G5U8zZw2YQkzSIHlkiVMp22sTsB/diNFDfKwFwdlcdnfzgPuhkGL
	 jDvud/PQsnC35ZqOB0XB8rlQeMw9mYrqYvMKHt74SA/j2fdwOtSpr0EnP/TImmHQFjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993182;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=Y/ezhjl74RxeLp5x9iAUkWi9XBPoG3p2eS21xOUcGrw=;
	b=kHsInV1Wjs8cbBN22mWibjspK8CyvluEcvQevpqSFQKdLqIEjdYhuOLw9xvcINEzqIMK
	 Snm45osW/Ho3pqO3vD1K0g0AWx21qSmmMLKLCsVL8CUq/lrqYzIC9SzqxOItPTNhm92pL
	 2KMZFmS8zuwsJJlGE6DsbM83vEIm5cx9fnhPYuzVhCOvbpRo1ZsGf7EEXWFmPb9H1cNNu
	 XPZ+iVNcdquGtShwK067+mhDA2FdcAOFJLod/vup9VNWgE5YbYEw8RrrVE9Q2NUj1b9rE
	 X3bXodOejFOajbFtlj8tBE6fJQhP23WxoFeD5s9dgRrAr58P7jS5ArwJLOA4+B238ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vRN4JU4y;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3311606A891;
	Wed, 18 Nov 2026 09:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3311606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vRN4JU4y
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y/ezhjl74RxeLp5x9iAUkWi9XBPoG3p2eS21xOUcGrw=;
	b=vRN4JU4yOoasf9DRo7SigLOeHnL+mWgZma2eVxUsquiCvIXSC1qFEkzyxDqWGf4SX3VGJuDjy
	3IlNJjN/Ar4w+iQJ4ffApqX5KRWlOCWhlDhFNaGijtgfEgyLvxMafrvvLCho6FxJFNY2IZQlSi/
	Lhc/1RpxsmbCbrUhZt6sbUY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jTwqC3bDFzmVc2;
	Wed, 18 Nov 2026 17:12:39 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E7EB940586;
	Wed, 18 Nov 2026 17:12:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:58 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 10/13] vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming support
Date: Wed, 18 Nov 2026 17:12:35 +0800
Message-ID: <20261118091238.45992-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Extend the NO-ST baseline with an IV-ST policy and introduce
VFIO_DEVICE_FEATURE_TPH_PROGRAM for batch programming of architected ST
entries.

- Add VFIO_PCI_TPH_POLICY_IV_ST and extend the tph_policy module
  parameter:
  * IV-ST: expose IV mode and architected ST table access, hide DS
- Restrict TPH control register writes to NO-ST and IV-ST only;
  block device-specific TPH mode
- VFIO TPH GET reports PROG_ST_NONE and PROG_ST_CPU capabilities after
  opt-in
- Add VFIO_DEVICE_FEATURE_TPH_PROGRAM (SET-only) to batch program
  architected ST entries for NONE and CPU (volatile/persistent) sources
- All ST programming is gated behind tph_opt_in and policy checks
- Register a per-device cpuhp offline callback: automatically clear ST
  entries bound to an offlined CPU and set those ST values to zero

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci.c        |   5 +-
 drivers/vfio/pci/vfio_pci_config.c |  10 +-
 drivers/vfio/pci/vfio_pci_core.c   | 287 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |   1 +
 include/linux/vfio_pci_core.h      |   3 +
 include/uapi/linux/vfio.h          |  74 +++++++-
 6 files changed, 371 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 77764eabb71a..664775bb3526 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -64,7 +64,7 @@ static unsigned int tph_policy;
 static int tph_policy_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
-				     VFIO_PCI_TPH_POLICY_NO_ST);
+				     VFIO_PCI_TPH_POLICY_IV_ST);
 }
 static const struct kernel_param_ops tph_param_ops = {
 	.set = tph_policy_set,
@@ -73,7 +73,8 @@ static const struct kernel_param_ops tph_param_ops = {
 module_param_cb(tph_policy, &tph_param_ops, &tph_policy, 0644);
 MODULE_PARM_DESC(tph_policy,
 	"Global TPH policy level (0=default No-ST):\n"
-	"0 = No-ST mode: ST programming unavailable\n");
+	"0 = No-ST mode: ST programming unavailable\n"
+	"1 = Add IV-ST mode: ST programming supports NONE/CPU sources\n");
 
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 3946ed2ec0cf..398f8db8b8ff 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1142,6 +1142,14 @@ static void vfio_tph_vcap_rewrite(struct vfio_pci_core_device *vdev, int pos)
 		 */
 		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
 			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
+	} else if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_IV_ST) {
+		/*
+		 * Add IV policy: mask DS mode, drop ST location and size
+		 * if device does not support IV mode.
+		 */
+		val &= ~PCI_TPH_CAP_ST_DS;
+		if (!(val & PCI_TPH_CAP_ST_IV))
+			val &= ~(PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
 	}
 
 	*vptr = cpu_to_le32(val);
@@ -1210,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
 	cap = vdev->tph_vcap;
 	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
 	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
-	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
+	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
 		req == 0x2 /* reserved */ ||
 		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
 		goto out; /* Drop invalid or unsupported write value. */
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 05a03aa2bceb..23ed8ea39657 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/aperture.h>
+#include <linux/cpuhotplug.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
@@ -576,6 +577,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
 	}
 }
 
+static int vfio_pci_tph_dev_init(struct vfio_pci_core_device *vdev);
+static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev);
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -630,7 +634,10 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_free_zdev;
 
-	vdev->tph_opt_in = 0;
+	/* After identifying the capability, initialize TPH. */
+	ret = vfio_pci_tph_dev_init(vdev);
+	if (ret != 0)
+		goto out_free_config;
 
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
@@ -656,6 +663,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -729,6 +738,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	kfree(vdev->region);
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
+	vfio_pci_tph_dev_deinit(vdev);
+
 	vfio_config_free(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
@@ -1597,12 +1608,116 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
-static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
+static enum cpuhp_state vfio_tph_cpuhp_state;
+static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *vdev);
+
+static int vfio_pci_tph_cpuhp_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct vfio_pci_core_device *vdev =
+		hlist_entry(node, struct vfio_pci_core_device, tph_cpuhp_node);
+	u32 st_size = vfio_pci_tph_get_st_table_size(vdev);
+	int i;
+
+	if (vdev->tph_st_cpu == NULL)
+		return 0;
+
+	mutex_lock(&vdev->tph_lock);
+	for (i = 0; i < st_size; i++) {
+		if (vdev->tph_st_cpu[i] != (s64)cpu)
+			continue;
+		pcie_tph_set_st_entry(vdev->pdev, i, 0);
+		vdev->tph_st_cpu[i] = -1;
+	}
+	mutex_unlock(&vdev->tph_lock);
+
+	return 0;
+}
+
+static int vfio_pci_tph_cpuhp_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "vfio/pci/tph:online",
+				      NULL,
+				      vfio_pci_tph_cpuhp_offline);
+	if (ret < 0)
+		return ret;
+
+	vfio_tph_cpuhp_state = ret;
+	return 0;
+}
+
+static void vfio_pci_tph_cpuhp_deinit(void)
+{
+	cpuhp_remove_multi_state(vfio_tph_cpuhp_state);
+}
+
+static bool vfio_pci_tph_has_architected_st(struct vfio_pci_core_device *vdev)
+{
+	u32 loc = vdev->tph_vcap & PCI_TPH_CAP_LOC_MASK;
+
+	return (loc == PCI_TPH_LOC_CAP || loc == PCI_TPH_LOC_MSIX) &&
+		(vfio_pci_tph_get_st_table_size(vdev) > 0);
+}
+
+static int vfio_pci_tph_dev_init(struct vfio_pci_core_device *vdev)
 {
-	/* NO-ST only, no capability bits exposed now */
+	bool has_arch_st;
+	u32 st_size;
+	int i, ret;
+
+	vdev->tph_opt_in = 0;
+	vdev->tph_st_cpu = NULL;
+
+	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
+	if (!has_arch_st)
+		return 0;
+
+	ret = cpuhp_state_add_instance_nocalls(vfio_tph_cpuhp_state,
+					       &vdev->tph_cpuhp_node);
+	if (ret != 0)
+		return ret;
+
+	st_size = vfio_pci_tph_get_st_table_size(vdev);
+	vdev->tph_st_cpu = kcalloc(st_size, sizeof(*vdev->tph_st_cpu),
+				   GFP_KERNEL);
+	if (vdev->tph_st_cpu == NULL) {
+		cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
+						    &vdev->tph_cpuhp_node);
+		return -ENOMEM;
+	}
+	for (i = 0; i < st_size; i++)
+		vdev->tph_st_cpu[i] = -1;
+
 	return 0;
 }
 
+static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev)
+{
+	bool has_arch_st;
+
+	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
+	if (!has_arch_st)
+		return;
+
+	kfree(vdev->tph_st_cpu);
+	vdev->tph_st_cpu = NULL;
+	cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
+					    &vdev->tph_cpuhp_node);
+}
+
+static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
+{
+	bool has_arch_st;
+
+	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
+	if (!has_arch_st)
+		return 0;
+
+	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
+}
+
 static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
 				     u32 flags,
 				     struct vfio_device_feature_tph __user *arg,
@@ -1638,6 +1753,154 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
 }
 
+static u32 vfio_pci_tph_get_src_mask(struct vfio_pci_core_device *vdev)
+{
+	u32 flags = vfio_pci_tph_get_capability(vdev);
+	u32 src_mask = 0;
+
+	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_NONE)
+		src_mask |= VFIO_DEVICE_TPH_SRC_NONE;
+	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_CPU)
+		src_mask |= VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
+			    VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
+
+	return src_mask;
+}
+
+static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 loc = pcie_tph_get_st_table_loc(pdev);
+	int ret;
+
+	if (loc == PCI_TPH_LOC_CAP) {
+		return pcie_tph_get_st_table_size(pdev);
+	} else if (loc == PCI_TPH_LOC_MSIX) {
+		ret = pci_msix_vec_count(pdev);
+		if (ret < 0)
+			return 0;
+		return ret;
+	} else {
+		return 0;
+	}
+}
+
+static int vfio_pci_tph_resolve_st_tag(struct pci_dev *pdev, u32 src_bits,
+				       u32 src_handle, bool extended, u16 *st)
+{
+	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
+	int ret = 0;
+
+	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
+		*st = 0;
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
+		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_VM,
+					      req_type, src_handle, st);
+	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
+		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_PM,
+					      req_type, src_handle, st);
+	else
+		ret = -EINVAL;
+
+	if (ret != 0)
+		*st = 0;
+
+	return ret;
+}
+
+static int vfio_pci_core_feature_tph_program(struct vfio_pci_core_device *vdev,
+			u32 flags,
+			struct vfio_device_feature_tph_program __user *arg,
+			size_t argsz)
+{
+	struct vfio_device_feature_tph_program program;
+	u32 user_flags, src_mask, st_size;
+	struct pci_dev *pdev = vdev->pdev;
+	bool extended, stop_on_zero;
+	u32 *src_handle = NULL;
+	int ret, i, k, written;
+	u16 *tags = NULL;
+	u16 cmd;
+
+	if (!vdev->tph_opt_in ||
+		!vfio_pci_tph_has_architected_st(vdev))
+		return -EOPNOTSUPP;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(program));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&program, arg, sizeof(program)))
+		return -EFAULT;
+
+	user_flags = program.flags;
+	extended = !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
+	if (extended && !pcie_ext_tph_supported(vdev->pdev))
+		return -EOPNOTSUPP;
+	user_flags &= ~VFIO_DEVICE_TPH_EXTENDED;
+
+	stop_on_zero = !!(user_flags & VFIO_DEVICE_TPH_REQUIRE_ST);
+	if (stop_on_zero && (user_flags & VFIO_DEVICE_TPH_SRC_NONE))
+		return -EINVAL;
+	user_flags &= ~VFIO_DEVICE_TPH_REQUIRE_ST;
+
+	src_mask = vfio_pci_tph_get_src_mask(vdev);
+	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
+		return -EINVAL;
+
+	st_size = vfio_pci_tph_get_st_table_size(vdev);
+	if (program.start >= st_size || program.count == 0 ||
+		program.count > st_size - program.start)
+		return -EINVAL;
+
+	if (!(user_flags & VFIO_DEVICE_TPH_SRC_NONE)) {
+		src_handle = memdup_array_user(u64_to_user_ptr(program.srcs),
+					       program.count, sizeof(u32));
+		if (IS_ERR(src_handle))
+			return PTR_ERR(src_handle);
+	}
+	tags = kcalloc(program.count, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	if (!tags) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cpus_read_lock();
+
+	for (i = 0; i < program.count; i++) {
+		ret = vfio_pci_tph_resolve_st_tag(pdev, user_flags,
+						src_handle ? src_handle[i] : 0,
+						extended, &tags[i]);
+		if (ret || (stop_on_zero && tags[i] == 0))
+			break;
+	}
+
+	if (i > 0) {
+		mutex_lock(&vdev->tph_lock);
+
+		cmd = vfio_pci_memory_lock_and_enable(vdev);
+		ret = written = pcie_tph_set_st_entries(pdev, program.start, i,
+							tags);
+		vfio_pci_memory_unlock_and_restore(vdev, cmd);
+
+		if (written > 0) {
+			for (k = 0; k < written; k++)
+				vdev->tph_st_cpu[program.start + k] =
+					(tags[k] == 0) ? -1 : src_handle[k];
+		}
+
+		mutex_unlock(&vdev->tph_lock);
+	}
+
+	cpus_read_unlock();
+
+out:
+	kfree(tags);
+	kfree(src_handle);
+	return ret;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1660,6 +1923,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_TPH:
 		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_TPH_PROGRAM:
+		return vfio_pci_core_feature_tph_program(vdev, flags,
+							 arg, argsz);
 	default:
 		return -ENOTTY;
 	}
@@ -2222,6 +2488,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
 	mutex_init(&vdev->ioeventfds_lock);
+	mutex_init(&vdev->tph_lock);
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
@@ -2242,6 +2509,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
 	mutex_destroy(&vdev->igate);
+	mutex_destroy(&vdev->tph_lock);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
@@ -2697,12 +2965,23 @@ static void vfio_pci_core_cleanup(void)
 {
 	vfio_pci_uninit_perm_bits();
 	rcu_barrier();
+	vfio_pci_tph_cpuhp_deinit();
 }
 
 static int __init vfio_pci_core_init(void)
 {
+	int ret;
+
+	ret = vfio_pci_tph_cpuhp_init();
+	if (ret != 0)
+		return ret;
+
 	/* Allocate shared config space permission data used by all devices */
-	return vfio_pci_init_perm_bits();
+	ret = vfio_pci_init_perm_bits();
+	if (ret != 0)
+		vfio_pci_tph_cpuhp_deinit();
+
+	return ret;
 }
 
 module_init(vfio_pci_core_init);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index f3d53af93dfd..e8c66f3d1743 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -13,6 +13,7 @@
 
 enum vfio_pci_tph_policy {
 	VFIO_PCI_TPH_POLICY_NO_ST = 0,
+	VFIO_PCI_TPH_POLICY_IV_ST,
 };
 
 struct vfio_pci_ioeventfd {
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 17c4ad490dc2..217f95aaa9db 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -154,6 +154,9 @@ struct vfio_pci_core_device {
 	u8			tph_policy;
 	u8			tph_opt_in;
 	u32			tph_vcap;
+	s64			*tph_st_cpu;
+	struct hlist_node	tph_cpuhp_node;
+	struct mutex		tph_lock;
 };
 
 enum vfio_pci_io_width {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 00e23c0b21e6..237af73909bf 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1560,8 +1560,9 @@ struct vfio_device_feature_zpci_err {
  *
  * SET: Opt-in to enable the VFIO TPH feature for the device; flags must be
  *      zero.
- * GET: Return VFIO-usable TPH capability bits in flags (currently zero).
- *      Returns an error if SET opt-in has not been performed.
+ * GET: Return VFIO-usable TPH capability bits in flags (see
+ *      VFIO_DEVICE_TPH_CAP_*). Returns an error if SET opt-in has not been
+ *      performed.
  *
  * Typical userspace sequence:
  * 1. Read virtualized PCI TPH capability via VFIO config space access to
@@ -1570,6 +1571,8 @@ struct vfio_device_feature_zpci_err {
  * 3. Invoke GET to retrieve the set of TPH capabilities accessible via VFIO.
  * 4. Write the TPH control register through VFIO config space to activate
  *    device TPH hardware.
+ * 5. Program steering tag (ST) table entries by VFIO_DEVICE_FEATURE_TPH_PROGRAM
+ *    if the device has an architected ST table.
  */
 #define VFIO_DEVICE_FEATURE_TPH			14
 
@@ -1577,6 +1580,73 @@ struct vfio_device_feature_tph {
 	__u32 flags;
 };
 
+/*
+ * Capability bits returned by VFIO_DEVICE_FEATURE_TPH GET
+ */
+
+/*
+ * Supports programming steering tag (ST) entries using the NONE source.
+ * This source resolves to a zero ST value.
+ */
+#define VFIO_DEVICE_TPH_CAP_PROG_ST_NONE	(1u << 0)
+/*
+ * Supports programming steering tag (ST) entries using a CPU source handle,
+ * for either volatile or persistent memory type.
+ */
+#define VFIO_DEVICE_TPH_CAP_PROG_ST_CPU		(1u << 1)
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH_PROGRAM - Batch program architected steering tag
+ * (ST) table entries. This interface only operates on the architected ST
+ * table described by the PCIe TPH ST Table Location field; it does not
+ * manage device-specific (DS) ST storage or any vendor-private ST array.
+ *
+ * SET only
+ *
+ * Prerequisites before invoking this feature:
+ * 1. Call VFIO_DEVICE_FEATURE_TPH with SET to enable vfio TPH permission;
+ * 2. Write the TPH control register to activate device hardware TPH logic.
+ *
+ * @flags: IN - source type selector (see VFIO_DEVICE_TPH_SRC_*) and
+ *         steering tag namespace selector (see VFIO_DEVICE_TPH_EXTENDED) and
+ *         failure policy (see VFIO_DEVICE_TPH_REQUIRE_ST)
+ *         Note: only one source type is permitted; combining source type bits
+ *               is rejected.
+ * @start: IN - first architected ST table index
+ * @count: IN - number of contiguous entries to program
+ * @srcs:  IN - user pointer to array of source u32 handles (CPU ID for CPU
+ *         sources, ignored for SRC_NONE)
+ *
+ * Return value: >=0 = number of entries successfully programmed;
+ *               <0  = negative errno
+ *
+ * CPU offline note: When a CPU goes offline, the kernel automatically clears
+ * all ST table entries mapped to that CPU, setting those ST values to zero.
+ */
+#define VFIO_DEVICE_FEATURE_TPH_PROGRAM		15
+
+struct vfio_device_feature_tph_program {
+	__u32 flags;
+	__u16 start;
+	__u16 count;
+	__aligned_u64 srcs;
+};
+
+/* Use extended 16-bit steering tag namespace */
+#define VFIO_DEVICE_TPH_EXTENDED		(1u << 0)
+/*
+ * Stop the batch when an entry resolves to a zero steering tag.
+ * Programming halts at that entry; the returned count
+ * is the number of entries successfully programmed before the stop.
+ */
+#define VFIO_DEVICE_TPH_REQUIRE_ST		(1u << 1)
+/* Source resolves to a zero steering tag (ST) */
+#define VFIO_DEVICE_TPH_SRC_NONE		(1u << 2)
+/* Source holds a volatile memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE	(1u << 3)
+/* Source holds a persistent memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT	(1u << 4)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

