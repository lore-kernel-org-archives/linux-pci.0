Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633833;
	b=xLkHPMSmHntowSoWaCzPL0zunOsaCZos9OEXXtox0aUhqFr74k8LJBhscwyBRxvwsDTS
	 3qTG+2IwwfyxqGux49FcmmPf7SstFsdMmsAmwiDZNIvfcd41XFiwwwzXa7Di+aNfs50xB
	 +uR69Efdd5veON83Xcp2k8H6m3AvX93LEOJNKLz6fpmkmqMu345HKQzYPnTfAxufyeP/K
	 0zl7OZ6qDciNAVKLuT6rf/nLHN+TwbcDxH1Q65iROB7N2YQRa/CItZLvT+skWQNd6i+tD
	 Tzw6ZNIlkyUI8whN6o6JTzTiGAI1FLlTtmPSoxK0YHRf03XnRHnEbgGESKxEi2JHMwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d9AP9+h3Vm5Lv0UYDFXf9dAmgO6It2Nsi1syTC+DAOg=;
	b=As0jkniMuuj6xHQIUXwHRwfRBWst0bFvrCzMsKRGhjLnKLPcRfGrZpmYAoQFrw1CNq8m
	 HeDsLhV6prCcbEiCgBSrqwvWyxpPuSFp+DRSBVypLBL6NtQhEtv5tJzCsltPsuGXtRri4
	 UlnbIzt5vsqHTihdfyIwnCZuMK9qFS2qvp49oyl5BaiamgFD6//OGHbOlwIM7vnniInmY
	 h9kh0UydlBDEQmFo/Qn55EB+hsSdbi4AsnDpbpl4nynkjOhpSH4T66TaWeTOL1RHyu959
	 /nBBsC/x3Z6bQQWLcvh4aS+Fs6aBfkKRrwtG9/4Q4mWJXrlBsyzmIzA6jfVrUyKm2eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GuCPj5OJ;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DF60A6C29
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675DF60A6C29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GuCPj5OJ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea63087d79so29717365ad.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633832; x=1794238632; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9AP9+h3Vm5Lv0UYDFXf9dAmgO6It2Nsi1syTC+DAOg=;
        b=GuCPj5OJUxVOiE1DtsurEjod5NmLPg7Y0+VlPIwDOzpjMwR2mbU1FpLumcEI/ahlg4
         ttkpDhgONHo7j+p1bTcrQSL2wlD7S0ei+9axNyJPi831Zjhjv1sW8bf653LOa6MfvlkD
         kXvh7OwdW7iIApFcrpiqCRobz1Rd/sGExPiGxK6zuutRPs7R+GK9AhKiJPtwYY042PNl
         aRxqaNXwayxnNZpo77WrzTQRCqSu/Gidy+nTKrJ043S4DApmVWetsavRddOneXau8rl2
         tO2trXwSaqlGH/CGi8jtRdJGg2fzL7U2ObvA0xCjbktiZJjkcp/T1SUkL2vcNAygO3wh
         rpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633832; x=1794238632;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9AP9+h3Vm5Lv0UYDFXf9dAmgO6It2Nsi1syTC+DAOg=;
        b=RhH5UIw3dbSvcmFUKyYXkMajOFEBGk/phfCgN8bFj13jwZszMJ1RIUx15wps3PEYg6
         1IHgOSP3ifGf8NB1p3DN+bXxc3Vu4p3MirMrKvF4Fg3ns/HCjXD5fBnLcbqyFGL7LYQ8
         ijdvDAgEoFaqZOnSoxbzkzMw0rSiIMvhw7sC/UNE+M+Rc3ZEiFfFNO/UyVQCSxK+iK0R
         kDgphX8JZmLiCU/wusqLG6ulcY/ztnrli8fzjMf4ad9z7ZTJum4pV2vqZ5mxILcekh1o
         PrvRc810/mw6aEbMCgGWjdf9U1QoCcxCtc6ke5SFXdv45PEAp2+5RpMwhynPzL2jA4H8
         DSAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQy6qKOa0ilU84ZvuBv4IzkJf8YNGx7EfChwjeCq2MLrD7NA+7z3l2NDeif0tNJ/7woKHdeUPIHiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dtMjDXBGSkm8+aftqjU9bwPtpm6E1RoZeXuDJM+oMXbDJcq7W
	6j6u8mXPvT+q81BCnlSty8QZDha91+OmwuXLBYWr7UnIuM2ktQxq7k3ZA9jM82N2egdGyrGrdO/
	05g/FOWIp+Q==
X-Received: from pltm3.prod.google.com ([2002:a17:902:6bc3:b0:2e5:ffbf:77d8])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c4e:b0:2e9:9c65:1af9
 with SMTP id d9443c01a7336-2eb364e8187mr97004705ad.53.1793633831668; Mon, 02
 Nov 2026 07:37:11 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:40 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-12-vipinsh@google.com>
Subject: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files after Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Enable userspace to retrieve preserved VFIO device files after a Live
Update by implementing the retrieve() and finish() file handler
callbacks.

During retrieve():
 * Validate the handed-over struct vfio_pci_core_device_ser header,
   sizes, and flags.
 * Locate the registered vfio-pci device matching the serialized domain
   and BDF (requiring device->ops == &vfio_pci_ops) under the device
   lock. vfio-pci registers the vfio device before its probe completes,
   and the probe holds that lock, so a device that is still being probed
   is not returned.
 * Require the device to be in noiommu mode in the new kernel (returning
   -EOPNOTSUPP otherwise), still marked incoming by the PCI Live Update
   core, and matching the serialized PCI config space size.
 * Deserialize the inherited struct pci_saved_state and copy the
   handed-over vconfig and pci_config_map into a kernel-owned struct
   vfio_pci_liveupdate_incoming attached to vdev under dev_set->lock via
   vfio_pci_liveupdate_attach_incoming(), leaving the KHO serialized
   buffer read-only.
 * Open and return an anonymous VFIO cdev file via
   vfio_device_liveupdate_cdev_open().

Do not implement can_finish(): closing a retrieved LUO session invokes
finish, and refusing can_finish() would leak the session and leave
unclaimed devices running. Instead, finish() always completes:
 * If the retrieved device was claimed by opening it via
   VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
   subsequent patches replace the open-time reset with non-reset
   take-over, reject opening incoming devices other than via retrieve(),
   and protect incoming kept-running devices across runtime PM, dev_set
   resets, and non-noiommu boots), finish() simply completes its PCI
   Live Update participation.
 * If the device was not claimed (never retrieved, retrieve() failed, or
   retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
   vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
   device, clears PCI_COMMAND_MASTER, resets the function, and restores
   the inherited pci_saved_state just as closing the device would. If
   the device has a function reset but is not reset, e.g. because
   pci_dev_trylock() contends with a concurrent driver unbind, latch
   vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
   completes the function reset and state restoration via
   vfio_pci_core_liveupdate_reset_locked() under the device lock held by
   device_release_driver(). Opening the device after finish() resets it
   like any open, so it drops the latch.
 * If the device was not retrieved, look it up under pci_dev_lock(),
   which waits for a vfio-pci probe in progress. If it is bound to
   vfio-pci, finish it as above. If it has no driver, clear bus
   mastering and reset it. Otherwise leave it to the bound driver.
 * Call pci_liveupdate_finish() and kho_restore_free() on every path.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  65 +++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 342 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |  75 ++++++
 include/linux/vfio_pci_core.h          |   6 +
 4 files changed, 484 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 5f8c882d5778..60ada3bbb6ff 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -671,6 +671,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_core_map_bars(vdev);
 
+	vfio_pci_liveupdate_claim_incoming(vdev);
+
 	return 0;
 
 out_free_zdev:
@@ -739,6 +741,63 @@ static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 	pci_restore_state(pdev);
 }
 
+/*
+ * Reset a device that was kept running across a Live Update but not taken over,
+ * from the Live Update finish() of the device. Return true if the device was
+ * reset, false if it could not be reset, e.g. because its device lock could
+ * not be taken.
+ */
+bool vfio_pci_core_liveupdate_reset(struct vfio_pci_core_device *vdev,
+				    struct pci_saved_state *saved_state,
+				    bool reset_works, const char *reason)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	lockdep_assert_held(&vdev->vdev.dev_set->lock);
+
+	if (reason)
+		pci_warn(pdev,
+			 "Resetting device not taken over after Live Update (%s)\n",
+			 reason);
+
+	pci_clear_master(pdev);
+	if (!saved_state)
+		pci_save_state(pdev);
+	kfree(vdev->pci_saved_state);
+	vdev->pci_saved_state = saved_state;
+	vdev->reset_works = reset_works;
+	vfio_pci_core_try_reset(vdev);
+
+	return !vdev->needs_reset;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_liveupdate_reset);
+
+/*
+ * Reset a device preserved across a Live Update from its remove() path, where
+ * the driver core holds the device lock. Save and restore the config space
+ * around the reset like vfio_pci_core_try_reset(), and block user config
+ * access while doing so. Like pci_reset_function_locked(), do not take the
+ * upstream bridge lock: remove() cannot wait for it without inverting the
+ * bridge -> device lock order, and the Live Update finish() of an unbound
+ * device holds it while it waits for the device lock held here.
+ */
+void vfio_pci_core_liveupdate_reset_locked(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	device_lock_assert(&pdev->dev);
+	lockdep_assert_held(&vdev->vdev.dev_set->lock);
+
+	pci_clear_master(pdev);
+	pci_cfg_access_lock(pdev);
+	pci_save_state(pdev);
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+	if (!__pci_reset_function_locked(pdev))
+		vdev->needs_reset = false;
+	pci_restore_state(pdev);
+	pci_cfg_access_unlock(pdev);
+}
+
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -2362,6 +2421,12 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 
 	vfio_unregister_group_dev(&vdev->vdev);
 
+	/*
+	 * Must follow vfio_unregister_group_dev(), which waits for the
+	 * references a Live Update finish() of the device may hold.
+	 */
+	vfio_pci_liveupdate_unregister_dev(vdev);
+
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index ac77241ffb1e..f13c757b4567 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -35,7 +35,13 @@
  *    preserved, so there is no way for the file to be destroyed or the device
  *    to be unbound from the vfio-pci driver while it is preserved.
  *
- * Retrieving the file after kexec is not yet supported.
+ * After kexec, the preserved VFIO device file can be retrieved from the session
+ * just like any other preserved file::
+ *
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+ *   device_fd = arg.fd;
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
  * Restrictions
  * ============
@@ -97,6 +103,36 @@
  * the ``unfreeze()`` callback restores the physical INTx mask and clears the
  * frozen state, leaving the existing file descriptor immediately usable again.
  *
+ * Retrieval and Finish Behavior After Kexec
+ * =========================================
+ *
+ * After kexec, userspace must ensure the preserved PCI device is bound to
+ * ``vfio-pci`` in noiommu mode before invoking
+ * ``LIVEUPDATE_SESSION_RETRIEVE_FD`` (for example, via ``vfio-pci.ids=...`` on
+ * the kernel command line). A failed ``LIVEUPDATE_SESSION_RETRIEVE_FD`` call is
+ * cached permanently by LUO for that file.
+ *
+ * ``LIVEUPDATE_SESSION_RETRIEVE_FD`` validates the handed-over serialized state
+ * and returns a new unbound VFIO cdev file descriptor. The device is claimed on
+ * the first ``VFIO_DEVICE_BIND_IOMMUFD`` on that file descriptor.
+ *
+ * ``LIVEUPDATE_SESSION_FINISH`` (or closing a retrieved session file
+ * descriptor) always completes:
+ *
+ *  * If the device was retrieved and claimed via ``VFIO_DEVICE_BIND_IOMMUFD``,
+ *    ``finish()`` simply completes its Live Update participation.
+ *  * If the device was not claimed (never retrieved, ``retrieve()`` failed, or
+ *    retrieved but never bound via ``VFIO_DEVICE_BIND_IOMMUFD``), ``finish()``
+ *    logs one ``pci_warn()`` naming the device, clears ``PCI_COMMAND_MASTER``,
+ *    resets the function and restores the initial PCI saved state just as
+ *    closing the device would, and finishes its Live Update participation so
+ *    the device can be opened normally afterwards. If ``finish()`` cannot
+ *    reset a device that has a function reset, for example because it cannot
+ *    take the device lock while the device is being unbound from
+ *    ``vfio-pci``, it still clears ``PCI_COMMAND_MASTER``, and the function
+ *    reset is retried when the device is unbound, unless the device is opened
+ *    (which resets it) before that.
+ *
  * DMA Memory Ordering Contract
  * ============================
  *
@@ -110,8 +146,9 @@
  *    preserving the VFIO device. LUO finishes files within a session in reverse
  *    preservation order (LIFO), guaranteeing that if the device is not taken
  *    over in the new kernel, VFIO's ``finish()`` callback stops bus mastering
- *    and resets the device before the ``memfd``'s ``finish()`` callback releases
- *    its folios. Cross-session ordering is the responsibility of userspace.
+ *    before the ``memfd``'s ``finish()`` callback releases its folios. It
+ *    normally resets the device at that point too (see above for when it
+ *    cannot). Cross-session ordering is the responsibility of userspace.
  *
  *  * After retrieving a preserved ``memfd`` in the new kernel, its folios are
  *    ordinary unpinned shmem page cache until pinned again; userspace must keep
@@ -124,6 +161,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -131,6 +169,7 @@
 #include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci_liveupdate.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/vfio.h>
 
@@ -327,13 +366,308 @@ static void vfio_pci_liveupdate_unfreeze(struct liveupdate_file_op_args *args)
 	smp_store_release(&vdev->liveupdate_frozen, false);
 }
 
+static int vfio_pci_liveupdate_validate_ser(const struct vfio_pci_core_device_ser *ser)
+{
+	size_t expected;
+
+	if (ser->reserved)
+		return -EINVAL;
+
+	if (ser->flags & ~VFIO_PCI_SER_KNOWN_FLAGS)
+		return -EOPNOTSUPP;
+
+	if (ser->cfg_size != PCI_CFG_SPACE_SIZE &&
+	    ser->cfg_size != PCI_CFG_SPACE_EXP_SIZE)
+		return -EINVAL;
+
+	expected = size_add(sizeof(*ser),
+			    size_add(size_mul(2, ser->cfg_size),
+				     ser->saved_state_size));
+	if (expected != ser->size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct pci_saved_state *
+vfio_pci_liveupdate_parse_saved_state(struct pci_dev *pdev,
+				      const struct vfio_pci_core_device_ser *ser)
+{
+	const void *blob;
+
+	if (!ser->saved_state_size)
+		return NULL;
+
+	blob = ser->data + 2 * (size_t)ser->cfg_size;
+	return pci_liveupdate_deserialize_saved_state(pdev, blob,
+						      ser->saved_state_size);
+}
+
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct pci_dev *pdev;
+
+	if (device->ops != &vfio_pci_ops)
+		return false;
+
+	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
+	if (!pdev)
+		return false;
+
+	return ser->bdf == pci_dev_id(pdev) &&
+	       ser->domain == pci_domain_nr(pdev->bus);
+}
+
+/*
+ * vfio-pci makes the vfio device visible before its probe completes, and the
+ * probe runs under the device lock. Look the device up with that lock held, so
+ * that a device found here has completed its probe, and the reset done by
+ * finish() does not contend with the probe for that lock. Return the device
+ * with a registration reference held.
+ */
+static struct vfio_device *
+vfio_pci_liveupdate_find_probed(const struct vfio_pci_core_device_ser *ser)
+{
+	struct vfio_device *device;
+	struct pci_dev *pdev;
+
+	pdev = pci_get_domain_bus_and_slot(ser->domain, PCI_BUS_NUM(ser->bdf),
+					   ser->bdf & 0xff);
+	if (!pdev)
+		return NULL;
+
+	device_lock(&pdev->dev);
+	device = vfio_find_device(ser, match_device);
+	device_unlock(&pdev->dev);
+	pci_dev_put(pdev);
+	return device;
+}
+
+static int
+vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_liveupdate_incoming *in)
+{
+	guard(mutex)(&vdev->vdev.dev_set->lock);
+
+	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
+	    !pci_liveupdate_is_incoming(vdev->pdev))
+		return -EBUSY;
+
+	vdev->liveupdate_incoming = in;
+	return 0;
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct pci_saved_state *saved_state = NULL;
+	const struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_liveupdate_incoming *in;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+	struct pci_dev *pdev;
+	struct file *file;
+	size_t in_size;
+	int ret;
+
+	if (!args->serialized_data)
+		return -EINVAL;
+
+	ser = phys_to_virt(args->serialized_data);
+	ret = vfio_pci_liveupdate_validate_ser(ser);
+	if (ret)
+		return ret;
+
+	device = vfio_pci_liveupdate_find_probed(ser);
+	if (!device)
+		return -ENODEV;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	if (!vfio_device_is_noiommu(device)) {
+		ret = -EOPNOTSUPP;
+		goto out_put_dev;
+	}
+
+	if (!pci_liveupdate_is_incoming(pdev) ||
+	    ser->cfg_size != pdev->cfg_size) {
+		ret = -EINVAL;
+		goto out_put_dev;
+	}
+
+	if (ser->saved_state_size) {
+		saved_state = vfio_pci_liveupdate_parse_saved_state(pdev, ser);
+		if (IS_ERR(saved_state)) {
+			ret = PTR_ERR(saved_state);
+			goto out_put_dev;
+		}
+	}
+
+	in_size = struct_size(in, data, size_mul(2, ser->cfg_size));
+	in = kzalloc(in_size, GFP_KERNEL);
+	if (!in) {
+		ret = -ENOMEM;
+		goto out_free_saved;
+	}
+
+	in->saved_state = saved_state;
+	in->reset_works = !!(ser->flags & VFIO_PCI_SER_RESET_WORKS);
+	in->cfg_size = ser->cfg_size;
+	memcpy(in->data, ser->data, 2 * (size_t)ser->cfg_size);
+
+	file = vfio_device_liveupdate_cdev_open(device);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out_free_in;
+	}
+
+	ret = vfio_pci_liveupdate_attach_incoming(vdev, in);
+	if (ret)
+		goto out_fput;
+
+	args->file = file;
+	vfio_device_put_registration(device);
+	return 0;
+
+out_fput:
+	fput(file);
+out_free_in:
+	kfree(in);
+out_free_saved:
+	kfree(saved_state);
+out_put_dev:
+	vfio_device_put_registration(device);
+	return ret;
+}
+
+static void vfio_pci_liveupdate_finish_vdev(struct vfio_pci_core_device *vdev,
+					    const struct vfio_pci_core_device_ser *ser,
+					    const char *reason)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct pci_saved_state *saved_state = NULL;
+	bool reset_works = true;
+	bool was_reset;
+
+	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
+		if (!vdev->liveupdate_claimed &&
+		    pci_liveupdate_is_incoming(pdev)) {
+			if (vdev->liveupdate_incoming) {
+				saved_state = vdev->liveupdate_incoming->saved_state;
+				vdev->liveupdate_incoming->saved_state = NULL;
+				reset_works = vdev->liveupdate_incoming->reset_works;
+			} else if (!vfio_pci_liveupdate_validate_ser(ser) &&
+				   ser->cfg_size == pdev->cfg_size) {
+				reset_works = !!(ser->flags & VFIO_PCI_SER_RESET_WORKS);
+				saved_state = vfio_pci_liveupdate_parse_saved_state(pdev, ser);
+				if (IS_ERR(saved_state))
+					saved_state = NULL;
+			}
+
+			/*
+			 * An unbind of the device waits for the reference held
+			 * by finish() with the device lock held, so the reset
+			 * only tries to take that lock. If the device has a
+			 * function reset but was not reset, e.g. because that
+			 * lock was taken, bus mastering is still cleared, and
+			 * the function reset is retried when the device is
+			 * unbound, unless the device is opened before that. See
+			 * vfio_pci_liveupdate_unregister_dev() and
+			 * vfio_pci_liveupdate_claim_incoming().
+			 */
+			was_reset = vfio_pci_core_liveupdate_reset(vdev,
+								   saved_state,
+								   reset_works,
+								   reason);
+			vdev->liveupdate_reset_pending = reset_works &&
+							 !was_reset;
+		}
+		vfio_pci_liveupdate_free_incoming(vdev);
+	}
+
+	if (pci_liveupdate_is_incoming(pdev))
+		pci_liveupdate_finish(pdev);
+}
+
+/*
+ * Look up the vfio-pci device of a preserved device that was not retrieved,
+ * with the device lock held, like vfio_pci_liveupdate_find_probed(). If it is
+ * bound to vfio-pci, return the vfio-pci device with a registration reference
+ * held, so that the caller finishes it. Otherwise, finish the device here.
+ */
+static struct vfio_device *
+vfio_pci_liveupdate_finish_lookup(const struct vfio_pci_core_device_ser *ser)
+{
+	struct vfio_device *device = NULL;
+	struct pci_dev *pdev, *bridge;
+
+	pdev = pci_get_domain_bus_and_slot(ser->domain, PCI_BUS_NUM(ser->bdf),
+					   ser->bdf & 0xff);
+	if (!pdev)
+		return NULL;
+
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge)
+		pci_dev_lock(bridge);
+	pci_dev_lock(pdev);
+
+	if (pci_liveupdate_is_incoming(pdev)) {
+		if (!pdev->dev.driver) {
+			pci_warn(pdev,
+				 "Resetting device not taken over after Live Update (not bound to vfio-pci)\n");
+			pci_clear_master(pdev);
+			pci_reset_function_locked(pdev);
+			pci_liveupdate_finish(pdev);
+		} else {
+			/*
+			 * A driver is bound and its probe has completed, as it
+			 * runs under the device lock. Holding the lock also
+			 * prevents an unbind until the registration reference
+			 * below is taken.
+			 */
+			device = vfio_find_device(ser, match_device);
+			if (!device) {
+				pci_warn(pdev,
+					 "Device not taken over after Live Update is bound to %s, not resetting it\n",
+					 dev_driver_string(&pdev->dev));
+				pci_liveupdate_finish(pdev);
+			}
+		}
+	}
+
+	pci_dev_unlock(pdev);
+	if (bridge)
+		pci_dev_unlock(bridge);
+	pci_dev_put(pdev);
+	return device;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_pci_core_device_ser *ser = phys_to_virt(args->serialized_data);
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+	const char *reason;
+
+	if (args->retrieve_status > 0) {
+		device = vfio_device_from_file(args->file);
+		vdev = container_of(device, struct vfio_pci_core_device, vdev);
+		vfio_pci_liveupdate_finish_vdev(vdev, ser,
+						"retrieved but not opened");
+	} else {
+		reason = args->retrieve_status ? "retrieve failed" : "not retrieved";
+		device = vfio_pci_liveupdate_finish_lookup(ser);
+		if (device) {
+			vdev = container_of(device, struct vfio_pci_core_device,
+					    vdev);
+			vfio_pci_liveupdate_finish_vdev(vdev, ser, reason);
+			vfio_device_put_registration(device);
+		}
+	}
+
+	kho_restore_free(ser);
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 2c732cb1c189..d8670dc51bb4 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -150,6 +150,15 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 }
 #endif
 
+struct vfio_pci_liveupdate_incoming {
+	struct pci_saved_state *saved_state;
+	bool reset_works;
+	u16 cfg_size;
+	u8 data[];
+};
+
+void vfio_pci_core_liveupdate_reset_locked(struct vfio_pci_core_device *vdev);
+
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 int __init vfio_pci_liveupdate_init(void);
 void vfio_pci_liveupdate_cleanup(void);
@@ -159,6 +168,57 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 	/* Written in VFIO PCI Liveupdate during freeze()/unfreeze() */
 	return smp_load_acquire(&vdev->liveupdate_frozen);
 }
+
+static inline void
+vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_liveupdate_incoming *in = vdev->liveupdate_incoming;
+
+	if (!in)
+		return;
+
+	kfree(in->saved_state);
+	kfree(in);
+	vdev->liveupdate_incoming = NULL;
+}
+
+static inline void
+vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
+{
+	/*
+	 * A reset that finish() left for unbind is not needed once the device
+	 * is opened after finish(): the open resets the device if it can, and
+	 * so does the close.
+	 */
+	vdev->liveupdate_reset_pending = false;
+
+	if (!vdev->liveupdate_incoming)
+		return;
+
+	vfio_pci_liveupdate_free_incoming(vdev);
+	vdev->liveupdate_claimed = true;
+}
+
+static inline void
+vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
+		/*
+		 * Complete a reset that finish() could not do, see
+		 * vfio_pci_liveupdate_finish_vdev().
+		 */
+		if (vdev->liveupdate_reset_pending) {
+			vfio_pci_core_liveupdate_reset_locked(vdev);
+			vdev->liveupdate_reset_pending = false;
+		}
+		vfio_pci_liveupdate_free_incoming(vdev);
+	}
+
+	if (pci_liveupdate_is_incoming(pdev))
+		pci_liveupdate_finish(pdev);
+}
 #else
 static inline int vfio_pci_liveupdate_init(void)
 {
@@ -173,6 +233,21 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 {
 	return false;
 }
+
+static inline void
+vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
+{
+}
+
+static inline void
+vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
+{
+}
+
+static inline void
+vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
+{
+}
 #endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
 
 #endif
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 6bae7581f4f4..f5c279d0df1e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -152,6 +152,9 @@ struct vfio_pci_core_device {
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 	bool			liveupdate_frozen;
 	bool			liveupdate_intx_disabled;
+	bool			liveupdate_claimed;
+	bool			liveupdate_reset_pending;
+	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
 #endif
 };
 
@@ -197,6 +200,9 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
+bool vfio_pci_core_liveupdate_reset(struct vfio_pci_core_device *vdev,
+				    struct pci_saved_state *saved_state,
+				    bool reset_works, const char *reason);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
-- 
2.56.0.317.g454f8302e1-goog

