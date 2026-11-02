Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633834;
	b=DTvVvR3gyWfqGKpI4WRIuUxj6hB7mSq4LE/p4PBugrN3wqRWmfD5mSD5+2lYow71q60J
	 LtqIwzdtJR3bFZ58y47eLymDwRTqWiVgP30bP768rkKTvGTo6k7/rOMivavPkJ2rcC6kT
	 j2I8h3pNBoH6KVBU7Z8Km70EfYCAKXyAk14dJELDlju9kTaqKW+iSWp+SldZPrDeiltC6
	 3xOws7YCF+LnJLsltdXGU8sOzi1BQHDA+Wh/jhTcKNrq4rlNDdbbGHx+ml1AiCtnwrWhH
	 Y2Sj64Ezi27ly5rsQK/zGqJoi5DdLUQZeMPuDGT4IbPtsDv6fvNLJEXuaZlJUcP5Jeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
	b=TBwa1rD+Wr1vq9bOuc6Qa+zJk9209wWqrkM0hPjNia72abb4OknmBX5hIV4MLhUFHIEO
	 t9JgKxwzAIXqFS20WQ41K1NveTd64iukhpp0Duj+igI7TdKKtKcUPsHbxWUwVQ9BeDRhF
	 Al/8gza+PDmJZI6iU3OD+F7CTkpwP1xNbrF7curyDaqy+U1aFwJH6l5YFw0+nZ5LYE6CU
	 Oru2f35cbpEC2zOdpWd1U3NBBWF1BQs0a40aWX/MIl/gsTr+DaqRP8oLUI7t4QKrMcQI6
	 l7JEZEeJlH9ZcDtO8Xxg4jyBQ+XRQEE6maV64PKhunKbIhjncW1vsITLh4zPY18kRag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOoLULKt;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1760E6E4E
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD1760E6E4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOoLULKt
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so6718934a91.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633833; x=1794238633; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=OOoLULKtlquOo1hW/AmHaG5FsQeivEQrZb86orM8Uwr5rOr6omi+/3iadCq7mNqOO1
         XljI7RfadAnR5LvZE8sdlhGrGm7ovH1YZchOD+n2oEdVDwI1s4iPidqSm7AnqLNneX1J
         +19jmKdtOW/0IT9T+eUJSqR4B1jrAI1gc0IPi7/hiW+AFxh7LkF8GjPdKXH6YhhCWNtV
         Z/lr5wNh2KLIgibplLjpCnHFotSkYKRjnxsu3uTadvcsHqt+h9j1nYYXy0V8Ayodtieh
         GBaa8eAzMECdepVHl0ZN+7QCof8/aDsVoHEN/NF7jgv/oIWJ/c4wL25TQC+PNWSJZLhV
         bCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633833; x=1794238633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=137J9FpCbLfibS5irZfzNzvfTD1gGyS3Uzz8zKhppkMN9YKI0JB1nmyfvpOX+cy8K1
         5LE+AtuXcwUdf5jMg0c7CTmp51fIavMOaTmGssHJ2ykkCqMkhRD40HYLrThJ5u5jUV7Y
         TpsP1fkV7vsLQQ/tFfy/1PWHgd+3le8q6L8ia9U1sWxbPiSuRnTMxHofYfj0C6icidSH
         qwIuVHsYLfxADmJN47MeO5b2Mge/zD/JUQvtqf3k89ZDKTB+DFHrthH2YfCL6oSlzpqg
         CETBoR9xssin9ABzr0CNV96k+Pn/MIcSSI3201Jm0AmR/g/Fk9a5lifil/CtFo9eAEOH
         YbCQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/ynbZ490l3iGAHEvp9aF1fSf8sau/qHX3MrPkvk4e+LcKh5f8MeTu9YwORy4l8ovUa3QiM0BZgGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+53hnVM1myOxtjtWrWehLphXW5zGNXBVWOfCz2kXK9UHYh6nYV
	/h9rcnlqv3eI9exLolSxFZRplhBhFTarcyZawkTA1lnfZUqnW2ZQEhNMWsoI3fwOdd7BoeJyerd
	aStmnV6A24Q==
X-Received: from plhb8.prod.google.com ([2002:a17:903:2288:b0:2e9:84f0:65ba])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b47:b0:3ac:9f00:3bc7
 with SMTP id 98e67ed59e1d1-3ae8980dccamr9246672a91.33.1793633832641; Mon, 02
 Nov 2026 07:37:12 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:41 -0800
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
Message-ID: <20261102153656.1431701-13-vipinsh@google.com>
Subject: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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

From: David Matlack <dmatlack@google.com>

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c             |  8 ++++++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 38e691eceab5..f0018eae3c4d 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -58,6 +58,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
 		}
 
 		*filep = file;
+	} else if (vfio_liveupdate_incoming_is_preserved(device)) {
+		/*
+		 * Since it is live update preserved device, it must be
+		 * retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD instead of
+		 * opening /dev/vfio/devices/vfioX.
+		 */
+		ret = -EBUSY;
+		goto err_free_device_file;
 	}
 
 	file->private_data = df;
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..62b4eaabc829 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -316,6 +316,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
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
index f13c757b4567..64810010f983 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -43,6 +43,12 @@
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
index 12557d45dfee..e6ca4c3fda06 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return pci_liveupdate_is_incoming(to_pci_dev(d));
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
-- 
2.56.0.317.g454f8302e1-goog

