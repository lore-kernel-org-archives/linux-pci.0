Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9236A36E
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543314; cv=none; b=q4h/uwLUp4FBCcuB0Rvbf97amcgTR4HjwOgikG4HlCNju6sAtcKm9HEJoObeelowQMjCy2nYvjlZ/ALjyPeQGkAtwf7ivfLpbj0X4lflzq/PcgrWtP1tcrKQNS0bb2tX2UuXipj022x7j19fbqnaAHKAyVZlkmjxa03EshSQeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543314; c=relaxed/simple;
	bh=JQdvnfwZ1UiMBoJV/M1aimVlkpa2tFk4EK0bnL+eufI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RwFo9AY3wf9RmjmdGZnqc7R8pr33XafA1IIDGmRRRX7Gpz8qX6/j5JWaJZnkXGDwgnjTNoXtx1MuiBCz13421bCZ4SBUYfBj+Tict+fZvkuohJxQUefesU1PBXykO4bNDwIE5a0fKKFWZT96mf76xgPP/K4ArGDGmM8FJgluz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ppf55UKC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ppf55UKC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda3052so2670889a12.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543311; x=1779148111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFPnttZDgBRngzGtSguPdn1kleodxJkte/D1pn+GAEc=;
        b=Ppf55UKCqbj46/rnC9bvtQF5avovdtOg7P6XkMXQNuQtVQ1iLbp2tMOxXZDLH2GbL5
         01xhazhjms71eNEjZQsNEwnRfSkrfE5kZTaFKkF/7+lc/WyN9J+w8EzuwVQTGcbD0XJF
         yipTRKa3j28kcZbUrfYkRdNIU7mHA42kKwDhJeyOR8PJ9xSjayHZc97qBV2ZgwhNLCb5
         oc5vgGzluIg2PXz7vOHcr6aLq+dNUJDiNex4z8kMAqr9spuRdoCxm8iwrK09Y0mTkVC8
         WuHCOqD5C6lllPTQrxuS+MHOlILzggUuorScq5lfuT/SOfbpLuSRJqp+mzfXM3JhT7mE
         JtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543311; x=1779148111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFPnttZDgBRngzGtSguPdn1kleodxJkte/D1pn+GAEc=;
        b=pyJtOn3LvK9x0IdURgwY66+NcfywcGp1uC/VqLmdaUIuAdV0sJxFqw0OKru1hhwFEf
         G2qovfxsYjANYUme5F1sq42YkSBiGW14Bh41usAuJu0KisSpR5zMOoJXBlR0WRr2uW6F
         iOXgEYm2frgwBpeTy+ird9lBB4NvzVscy6LdxzLOzrsUMt6igUYuQbeipMQFwH2ld4Bi
         Es7PKKLFQRr4HGKzqoS9leEBE/mI8tJT5SM1MyMgyEZaQ4hHWzsAlvS+260Nhth2lTjS
         qCh3zLj9vveFpZm3FjzxRDkFK1z27u6pusuT3BubjjmAGW6AxsUFHVCAN90BI2iRD4W2
         gKbg==
X-Forwarded-Encrypted: i=1; AFNElJ/stIatOzhydcNuKVxkYcHpET4FnXUJtn0/QFkQC3C9PuivF1OWY3Pe9NNRt4uKkwiTO7hL4D3o5f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCKRQBELJhOR+95IKrIRgdg/iD08dIwIUIA5cFZPRKjKTOb9V
	E/iXzi7h5WDcwdNRhqVKVrjlh21+9grvG/MDOniNFYOSMIlNIc+XbRxaGsDW9o+MC5Yf+86Rl3e
	1hgJTKI/s/w==
X-Received: from pghz21.prod.google.com ([2002:a63:e115:0:b0:c7f:c4f1:ae17])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca2:b0:398:bbd6:80b9
 with SMTP id adf61e73a8af0-3ad966596abmr704170637.23.1778543311124; Mon, 11
 May 2026 16:48:31 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:48 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-3-vipinsh@google.com>
Subject: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Implement the live update file handler callbacks to preserve a vfio-pci
device across a Live Update. Subsequent commits will enable userspace to
then retrieve this file after the Live Update.

Live Update support is scoped only to cdev files (i.e. not
VFIO_GROUP_GET_DEVICE_FD files).

State about each device is serialized into a new ABI struct
vfio_pci_core_device_ser. The contents of this struct are preserved
across the Live Update to the next kernel using a combination of
Kexec-Handover (KHO) to preserve the page(s) holding the struct and the
Live Update Orchestrator (LUO) to preserve the physical address of the
struct.

For now the only contents of struct vfio_pci_core_device_ser the
device's PCI segment number and BDF, so that the device can be uniquely
identified after the Live Update.

Require that userspace disables interrupts on the device prior to
freeze() so that the device does not send any interrupts until new
interrupt handlers have been set up by the next kernel.

Reset the device and restore its state in the freeze() callback. This
ensures the device can be received by the next kernel in a consistent
state. Eventually this will be dropped and the device can be preserved
across in a running state, but that requires further work in VFIO and
the core PCI layer.

Note that LUO holds a reference to this file when it is preserved. So
VFIO is guaranteed that vfio_df_device_last_close() will not be called
on this device until userspace has unpreserved the file using LUO.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/Kconfig               |   6 +-
 drivers/vfio/pci/vfio_pci.c            |   2 +-
 drivers/vfio/pci/vfio_pci_core.c       |  60 +++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c | 178 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |   5 +
 drivers/vfio/vfio_main.c               |   3 +-
 include/linux/kho/abi/vfio_pci.h       |  15 +++
 include/linux/vfio.h                   |   2 +
 8 files changed, 242 insertions(+), 29 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index c12d614fc6c4..019de053f116 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -45,13 +45,15 @@ config VFIO_PCI_IGD
 
 config VFIO_PCI_LIVEUPDATE
 	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
-	depends on PCI_LIVEUPDATE
+	depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
 	help
 	  Support for preserving devices bound to vfio-pci across a Live
 	  Update. This option should only be enabled by developers working on
 	  implementing this support. Once enough support has landed in the
 	  kernel, this option will no longer be marked EXPERIMENTAL.
 
+	  Enabling this will disable support for VFIO PCI DMA buffer.
+
 	  If you don't know what to do here, say N.
 
 endif
@@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
 	  To enable s390x KVM vfio-pci extensions, say Y.
 
 config VFIO_PCI_DMABUF
-	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
+	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER && !VFIO_PCI_LIVEUPDATE
 
 source "drivers/vfio/pci/mlx5/Kconfig"
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 5038265f3af5..439d14d79d8f 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ad52abc46c04..1726d4d41b57 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -585,9 +585,42 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+
+	lockdep_assert_held(&vdev->vdev.dev_set->lock);
+
+	if (!vdev->reset_works)
+		return;
+
+	/*
+	 * Try to get the locks ourselves to prevent a deadlock. The
+	 * success of this is dependent on being able to lock the device,
+	 * which is not always possible.
+	 *
+	 * We cannot use the "try" reset interface here, since that will
+	 * overwrite the previously restored configuration information.
+	 */
+	if (bridge && !pci_dev_trylock(bridge))
+		return;
+
+	if (!pci_dev_trylock(pdev))
+		goto out;
+
+	if (!__pci_reset_function_locked(pdev))
+		vdev->needs_reset = false;
+
+	pci_dev_unlock(pdev);
+out:
+	if (bridge)
+		pci_dev_unlock(bridge);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_try_reset);
+
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 {
-	struct pci_dev *bridge;
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
@@ -687,27 +720,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 */
 	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 
-	/*
-	 * Try to get the locks ourselves to prevent a deadlock. The
-	 * success of this is dependent on being able to lock the device,
-	 * which is not always possible.
-	 * We can not use the "try" reset interface here, which will
-	 * overwrite the previously restored configuration information.
-	 */
-	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
-		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			pci_dev_unlock(pdev);
-		}
-		if (bridge)
-			pci_dev_unlock(bridge);
-	}
-
-out_restore_state:
+	vfio_pci_core_try_reset(vdev);
 	pci_restore_state(pdev);
 out:
 	pci_disable_device(pdev);
@@ -1613,7 +1626,7 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_device *core_vdev = &vdev->vdev;
 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
@@ -1622,6 +1635,7 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_zap_bars);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 1c74854600ea..5cc57bf39dbe 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -6,28 +6,201 @@
  * David Matlack <dmatlack@google.com>
  */
 
+/**
+ * DOC: VFIO PCI Preservation via LUO
+ *
+ * VFIO PCI devices can be preserved over a kexec using the Live Update
+ * Orchestrator (LUO) file preservation. This allows userspace (such as a VMM)
+ * to transfer an in-use device to the next kernel.
+ *
+ * .. note::
+ *    The support for preserving VFIO PCI devices is currently *partial* and
+ *    should be considered *experimental*. It should only be used by developers
+ *    working on expanding the support for the time being.
+ *
+ *    To avoid accidental usage while the support is still experimental, this
+ *    support is hidden behind a default-disable config option
+ *    ``CONFIG_VFIO_PCI_LIVEUPDATE``. Once the kernel support has stabilized and
+ *    become complete, this option will be enabled by default when
+ *    ``CONFIG_VFIO_PCI`` and ``CONFIG_LIVEUPDATE`` are enabled.
+ *
+ * Usage Example
+ * =============
+ *
+ * VFIO PCI devices can be preserved across a kexec by preserving the file
+ * associated with the device in a LUO session::
+ *
+ *   device_fd = open("/dev/vfio/devices/vfioX");
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, { ..., device_fd, ...});
+ *
+ * .. note::
+ *    LUO will hold an extra reference to the device file for as long as it is
+ *    preserved, so there is no way for the file to be destroyed or the device
+ *    to be unbound from the vfio-pci driver while it is preserved.
+ *
+ * Retrieving the file after kexec is not yet supported.
+ *
+ * Restrictions
+ * ============
+ *
+ * The kernel imposes the following restrictions when preserving VFIO devices:
+ *
+ *  * The device must be bound to the ``vfio-pci`` driver.
+ *
+ *  * ``CONFIG_VFIO_PCI_ZDEV_KVM`` must not be enabled. This may be relaxed in
+ *    the future.
+ *
+ *  * The device must not be an Intel display device. This may be relaxed in
+ *    the future.
+ *
+ *  * No support for VFIO PCI DMA buffer. This is to keep code simpler, it will
+ *    be removed in future.
+ *
+ *  * The device file descriptor must be obtained by opening the VFIO character
+ *    device (``/dev/vfio/devices/vfioX``) and not via
+ *    ``VFIO_GROUP_GET_DEVICE_FD``.
+ *
+ *  * The device must have interrupt disable prior to kexec. Failure to disable
+ *    interrupts on the device will cause the ``reboot(LINUX_REBOOT_CMD_KEXEC)``
+ *    syscall (to initiate the kexec) to fail.
+ *
+ * Preservation Behavior
+ * =====================
+ *
+ * The eventual goal of this support is to avoid disrupting the workload, state,
+ * or configuration of each preserved device during a Live Update. This would
+ * include allowing the device to perform DMA to preserved memory buffers and
+ * perform P2P DMA to other preserved devices. However, there are many pieces
+ * that still need to land in the kernel.
+ *
+ * For now, VFIO only preserves the following state for for devices:
+ *
+ *  * The PCI Segment, Bus, Device, and Function numbers of the device. The
+ *    kernel guarantees the these will not change across a kexec when a device
+ *    is preserved.
+ *
+ * Since the kernel is not yet prepared to preserve all parts of the device and
+ * its dependencies (such as DMA mappings), VFIO currently resets and restores
+ * preserved devices back into an idle state during kexec, before handing off
+ * control to the next kernel. This will be relaxed in future versions of the
+ * kernel once it is safe to allow the device to keep running across kexec.
+ */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/module.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
-	return false;
+	struct vfio_device *device = vfio_device_from_file(file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	if (!device)
+		return false;
+
+	/* Live Update support is limited to cdev files. */
+	if (!vfio_device_cdev_opened(device))
+		return false;
+
+	if (device->ops != &vfio_pci_ops)
+		return false;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	/*
+	 * Don't support specialized vfio-pci devices for now since they haven't
+	 * been tested.
+	 */
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) || vfio_pci_is_intel_display(pdev))
+		return false;
+
+	return true;
 }
 
 static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->bdf = pci_dev_id(pdev);
+	ser->domain = pci_domain_nr(pdev->bus);
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+}
+
+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	int ret;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	guard(mutex)(&device->dev_set->lock);
+
+	/*
+	 * Userspace must disable interrupts on the device prior to freeze so
+	 * that the device does not send any interrupts until new interrupt
+	 * handlers have been established by the next kernel.
+	 */
+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
+		return -EINVAL;
+	}
+
+	guard(rwsem_write)(&vdev->memory_lock);
+
+	/*
+	 * Userspace must make sure device is not in the lower power state for
+	 * live update. We may relax this in future.
+	 */
+	if (pdev->current_state != PCI_D0) {
+		pci_err(pdev, "Freeze failed! Device not in D0 state.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Reset is a temporary measure to provide kernel after kexec a clean
+	 * device while VFIO live update work is under development and not
+	 * fully supported.  It will go away once continuous DMA support is
+	 * added to device preservation.
+	 */
+	vfio_pci_zap_bars(vdev);
+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
+	if (ret)
+		return ret;
+	pci_clear_master(pdev);
+	vfio_pci_core_try_reset(vdev);
+	pci_restore_state(pdev);
+	return 0;
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
@@ -43,6 +216,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.preserve = vfio_pci_liveupdate_preserve,
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index c130ac53c4f9..20d942a7d9b7 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,10 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev);
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
@@ -72,6 +76,7 @@ void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev);
 
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8666f35fb3f0..2148b00491e4 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1457,7 +1457,7 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
+struct vfio_device *vfio_device_from_file(struct file *file)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1465,6 +1465,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
 		return NULL;
 	return df->device;
 }
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 67e8199eec59..229a13ac1e52 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -9,6 +9,9 @@
 #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 /**
  * DOC: VFIO PCI Live Update ABI
  *
@@ -25,4 +28,16 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
+ * device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ */
+struct vfio_pci_core_device_ser {
+	u32 domain;
+	u16 bdf;
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..f5f7ece51f8f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -81,6 +81,8 @@ struct vfio_device {
 	struct dentry *debug_root;
 };
 
+struct vfio_device *vfio_device_from_file(struct file *file);
+
 /**
  * struct vfio_device_ops - VFIO bus driver device callbacks
  *
-- 
2.54.0.563.g4f69b47b94-goog

