Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07C38BF61
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310338; cv=none; b=L78XBhQBlLcAnd/DpfSMo9C/2Gj+UPchw/zFyXG8/kvbpCP3JCvNoSzCQMETa7b3lQqyokFkeNUVNQWaaJ09hIrC/h6IfnrBZROdM/ELQvFQRKwpgVRbAqYcXxsD48HeTePmq4BYU27r3/A7giqsWDdXJhP3jFIYJIw/5QqIT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310338; c=relaxed/simple;
	bh=JIeulFoC8MyqRgbySpHafWJZwGtuNWg8OY+XTEFKwh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yk6s8mQ+SSsjLV56PfK2laJGKgW/luloSb2fHweSxfYQoxglcl62qbJDwMudds9KO4BKOZ5Pw9YYKukgjGiCs07y34yAoA4WOhsR4jormyrCeY+Y8PAdixr9eH7uyRrYeFogO8EplfvT8AUBcf4IbMLb0Yz6d/YOhTspudJxVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSpmzAY4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSpmzAY4"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358f058973fso1103440a91.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310335; x=1774915135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UG6U+6kAmFzvMZjga5OgV1LR5RVhGZN2WyiuuoZC9eg=;
        b=GSpmzAY4CKU4FJrD5pZnlzEgXy51vaw4RRfSxB09bx/fi18h5PgKCqINx/aFl25civ
         uu5siRoewCHYyqM+XWVkgAm7w/8TwFBmnQ2jSVJ3Sn4V2vVV0TbTx6dbSRgJvshQhcoF
         f4RhTY/l4ewQtMYJdRWETnju2Gquj4CdPSV1UyIaXY8Z+TRLG2DsWrOMylaRzPtN/Onf
         twmGORsCtKS4mZMMj8QMgHjxV/E26F9dJdwL97crYwjhl6SSPEFx6gOvp8lnhUJ8ZJns
         k9B10wEggsJLLH8grZc7OnYFVvis/BT/g17qyNZGD5gfvV27HjxCL3MPSW3aY+p2xL84
         HRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310335; x=1774915135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG6U+6kAmFzvMZjga5OgV1LR5RVhGZN2WyiuuoZC9eg=;
        b=p9QWSPcXjCFtS9kOy1CTbN0hekDoMv3/EUVKEGqtqGhvHNE+7602JBXnZWgMTJp1RI
         aalEQEhsyjLzinQzDuYIRk6FQferQrTAxBsNb22JH2JYMlkrox8pZcFjCshf9V/VPGXX
         nYPtsEP+H500L55FLeGeSY0V+dXdgsG6lPuRj7VNTwSxr8SQOxCzvOgEWDS2bMNkJCKR
         veDWYzRjgiaW5iNrbQzaStt74WHf7fqyEWuRyVbeTZeiWaMDZt+0qT3Z5b9A6UPolSQc
         tNJerYU9bZQHWj+f4IPGPXQ1nV/aFfgDSSCZQq6emCy+QkZN9zf8JBaKBYQpSbbY7Q2p
         kF5g==
X-Forwarded-Encrypted: i=1; AJvYcCWxsxPNZA+c9/6pAi7VlaPOj4LvRzYpG50K4tN1mB9vaJCMfDDKJKBkxq0VvCsU3+Xcngm0LjK5tzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziAid/gYGIAPeExnWAAmqPzy6QIa5clp9mWtQEztXunhV2qKpi
	btDjmX8OPuiuCgqE4qEFyiULTIvifVoz9tcGT6+N4flAdXD8XOIigbUvnW0erun9tqm7fZ/gNQz
	KVWdffqMff15Ebg==
X-Received: from pgcp23.prod.google.com ([2002:a63:7417:0:b0:c74:1130:c2ea])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5493:b0:39b:f026:6f7c with SMTP id adf61e73a8af0-39bf0267ba0mr8201078637.49.1774310334903;
 Mon, 23 Mar 2026 16:58:54 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:02 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-11-dmatlack@google.com>
Subject: [PATCH v3 10/24] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c             |  4 ++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index edf322315a41..6844684a3d8e 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -91,6 +91,10 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
+	/* Device file must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD */
+	if (vfio_liveupdate_incoming_is_preserved(device))
+		return -EBUSY;
+
 	return vfio_device_cdev_open(device, &file);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..0fa9761b13d3 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -311,6 +311,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	/*
+	 * This device was preserved across a Live Update. Accessing it via
+	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
+	 */
+	if (vfio_liveupdate_incoming_is_preserved(device)) {
+		vfio_device_put_registration(device);
+		return -EBUSY;
+	}
+
 	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
 	if (fd < 0)
 		vfio_device_put_registration(device);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index b960ec3ffbf2..6f760ace7065 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -47,6 +47,12 @@
  *   ...
  *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
+ * .. note::
+ *    After kexec, if a device was preserved by the previous kernel, attempting
+ *    to open a new file for the device via its character device
+ *    (``/dev/vfio/devices/X``) or via ``VFIO_GROUP_GET_DEVICE_FD`` will fail
+ *    with ``-EBUSY``.
+ *
  * Restrictions
  * ============
  *
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..8fcc98cf9577 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -462,4 +463,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return to_pci_dev(d)->liveupdate_incoming;
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_PCI_LIVEUPDATE */
+
 #endif
-- 
2.53.0.983.g0bb29b3bc5-goog

