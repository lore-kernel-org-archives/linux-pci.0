Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18B38911A
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310334; cv=none; b=L8LUq86SVRiUstA+j907/amMnvcJh+UzM5FNdgx+eWgouRBWUYKK9/h7oJMeUtYCw1Wvn3Do75rLQjUx09vpXVDYpqBNfGmyEyEQzeF2Khzv1E0UmhCqAoazwdT7oFBxcxbs9Nhq9f43Hkg1NC9PJ8y80ZJZrE2b5Iykax1Ql9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310334; c=relaxed/simple;
	bh=hpHWwpCyWNYJavxcdBciCVs72hFwampWkekPO66znUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2v3o+VtUktAUSOEvo+uLZ35OW4Vsy/YK9fWQg8xLxvEo/Rb3j1dmJKwRWZgzj0eNwp/Xm4TIp5PyQvc6ykAIuuPCHPKPqbIEQsYIqC5N54w8CA1UQRO/J3162hat7674APjDhIqbSP1ZrzkgkxicTLP+U26zukLSxJr9IkNOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aqd6XXCz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aqd6XXCz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so703173a91.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310331; x=1774915131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmzYNzW0+Ct+eXaBxLnJaomUJdCksoGs2CQSxI1y3bk=;
        b=Aqd6XXCzQEqQ+JMYsEMeKF8bxKs7kJa+7EfSfX6pMR6ef3N1JzIbSLGACB9zgw42vu
         9Rw4mPWDe4Sd8iNutrPnb1etpj+vhMBuxtI5u+gokIIDaiVJqk1sq6rbMaZumvDxoyyy
         MxRfXEQK1HHinl+z0vI8Or2n4NX1Bowkjm3pTNO0uWtTMzrabD4wQreGP0QvhL1r8zFn
         WVAVF6bSgDs9HjFnYyJxTnsyKx0hA68CMCiEFaxD7G3qrsxtw/WQGpmIfwCcHSkGjXpt
         hEvon4owwTAI+TztBdDpBsco+D6PMUQoFxaJ5t+5pR9KGaoy8afelk0xYDOsBxMWw2Ic
         m5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310331; x=1774915131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmzYNzW0+Ct+eXaBxLnJaomUJdCksoGs2CQSxI1y3bk=;
        b=Og+o/YzrJOyVWROxob41wStgNhIZ8viggusmQT+wBkBj6ojTYhw62irW+AxVllda/J
         nyTehXirTPDEwJd90a3a5pr4zJO4ttmoUdJAu0iUSPeLppNfyQOMHGlYVfKeUK4Iig5E
         1uE3UWICi7Gc16wK214tVyYGvVISe3mUFfF7wUJmWlzCXR5uWa2FhDCiBrR3hTTlVDUJ
         +c5PIcUsJa5wyH0CS+F23LlqlYveLTEpYqYEdhtgEspK2RZucVlSRWozapY/zv3GXLR8
         D3yW1y2jDbCDkoB7HhfaCx1qScNQSlyEbF5mGV0ST4+7B4cJbEg7IYAG8e3soDxKxi1e
         E72Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSbFzYamv1A3PcpeR3HUQGJBUqxwhKty0vFqoJQcLSGcCOXmYWNP7y6OkP4pwVkgagOuoHUTw1D4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wy+GRdmBDxhP+wUea9HVgKMC8MSLFISZMs1xneC2NTyStJuz
	qT0ZEXpkWVZMwAy/4InuWAdxYqts0e4wmDAvJatX5fOhP6xjxs+O+ghJA3VXjdKJx7OnGoqOQAF
	BNHU+c2vZeXDQzw==
X-Received: from pjbfv10.prod.google.com ([2002:a17:90b:e8a:b0:35b:939b:1e33])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:a82:b0:35b:e4d6:73cd with SMTP id 98e67ed59e1d1-35be4d6748bmr4279808a91.31.1774310331243;
 Mon, 23 Mar 2026 16:58:51 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:00 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-9-dmatlack@google.com>
Subject: [PATCH v3 08/24] vfio/pci: Retrieve preserved device files after Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve() and finish() file handler
callbacks.

Use an anonymous inode when creating the file, since the retrieved
device file is not opened through any particular cdev inode, and the
cdev inode does not matter in practice.

For now the retrieved file is functionally equivalent a opening the
corresponding VFIO cdev file. Subsequent commits will leverage the
preserved state associated with the retrieved file to preserve bits of
the device across Live Update.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c             | 59 ++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c | 52 ++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 13 ++++++
 include/linux/vfio.h                   | 11 +++++
 4 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..edf322315a41 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -16,15 +17,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -37,22 +33,67 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	/*
+	 * Simulate opening the character device using an anonymous inode. The
+	 * returned file has the same properties as a cdev file (e.g. operations
+	 * are blocked until BIND_IOMMUFD is called).
+	 */
+	if (!file) {
+		file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+						&vfio_device_fops, NULL,
+						O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto err_free_device_file;
+		}
+
+		*filep = file;
+	}
+
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
+err_free_device_file:
+	kvfree(df);
 err_put_registration:
 	vfio_device_put_registration(device);
 	return ret;
 }
 
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	struct file *file = NULL;
+	int ret;
+
+	ret = vfio_device_cdev_open(device, &file);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(vfio_device_liveupdate_cdev_open);
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, &file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index c4ebc7c486e5..4b83a02401aa 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -39,7 +39,13 @@
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
@@ -85,6 +91,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -180,13 +187,53 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return 0;
 }
 
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct pci_dev *pdev;
+
+	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
+	if (!pdev)
+		return false;
+
+	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device *device;
+	struct file *file;
+	int ret = 0;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	file = vfio_device_liveupdate_cdev_open(device);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	args->file = file;
+out:
+	/* Drop the reference from vfio_find_device() */
+	put_device(&device->device);
+	return ret;
+}
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return args->retrieve_status > 0;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -195,6 +242,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8b222f71bbab..e5886235cad4 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -1766,6 +1767,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct device *device;
+
+	device = class_find_device(vfio.device_class, NULL, data, match);
+	if (!device)
+		return NULL;
+
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e9d3ddb715c5..7384965d15d7 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -393,4 +393,15 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device);
+#else
+static inline struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.53.0.983.g0bb29b3bc5-goog

