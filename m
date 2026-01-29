Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368F361DDC
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721953; cv=none; b=B2Z6Ji5Z6sf2eAljwo5SO8HQFF8xgbv5XkfcjJGcRPtDqahu6XOYO7F8tqikassGyRNEY0uuon/YjtiFJkJtdjkp+HB5sMpbsIL0kx06cU7G6Co6JQs9rwdNQ9uqguIQyPR39hnTkf1lsTxDke4Z1B05S/FZj4qEklQfyFRSD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721953; c=relaxed/simple;
	bh=PH5iGzvJjXTHpagZy3PRNHKNaI45nyOejtuOEQ4Vpv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWgs9Zjbd8Us/WXLmMYNvBMUgZJog4hALyhMXBiCIhTXfqEwUlySclrdpFnmrRGP9Ufz3qcvy1AzVVQGxv3VjNV/qa6G4r5H1Q49aHyO8Rf1Apj0CfGFx+kaJc4aq6khAI2cv8aPxtmc++pEI+/1U+aTeeYPnUYPa6Sv0mwxn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8e2Ortj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8e2Ortj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a78c094ad6so15278545ad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721951; x=1770326751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3umikqL/So8idv3VwvFYaIe6+4TeFw4VgnmENinGbaA=;
        b=C8e2OrtjW0pK6NU4+4pA7apan1abQ64W9AU73v+5MLSgoxU3PFLcQ35UnxyjSkvxW/
         jHGFZ0Sly19gY9qnHYAz8wYk5VaqCdHZM2Cics4NzJGADMN6HvBtPJacvT1eGdo2suwt
         ZRhpTHioWcJ/pWkH0ykH2wBZy2qfsg2XW+OMkV0yYJMVLWQKMlkq16WIsS6txca3VotJ
         /nsOLnywSf0t5LPsRcB/2fTdZdo82Z7dYxby8mo6zDWAS6vlF4PYmOhwl6or4V/1gc9D
         hPaf+DOmaNpeQvVe1RnN7NwGGMG7zJ7jnVbWavgGDvg2WFb4KxJJzZQJx5nEe3d+Yclm
         xQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721951; x=1770326751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3umikqL/So8idv3VwvFYaIe6+4TeFw4VgnmENinGbaA=;
        b=REl3LuWyLeqfjrXvU4QL8v4EXtUGXosYzNKTI/y78vON3CH9QhphTBG8+wQGkfK5rX
         IFeL8QZmLpME1hGojxB3+JeK51xnxtx/H87aYd3lF7BpKdeud7Jpyj48UHL3U5Z5zcgR
         /YaEctuDvY0bBr0NHavT9W4Sh9xjWFS54rQ9udYiRCknMh4iXKKzgooTfj98fEGw2PJL
         b3wxU3V/TeDHUSqr/tVnOlogmlZmJl2rfHe7AbUbgb24y1Ub7KvJIjIwbzkGIdrlUHHL
         3HsQH6or3oOOqpMc2FK4F7oXXkemjEamcGcmQP4fIfYFC+WzCr0dpT0lx1Ba+x6oZMdy
         OGTg==
X-Forwarded-Encrypted: i=1; AJvYcCVZXXN7iwJLcyK1EFmDde2C4zuG9WMDjfjVBD9f3U2yJvND4utzaYgcKUd3Mli9MZxOCgj2rvRko84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYyRbGfIDJZyWJrE2yztJ6Dus44AU+RU+Fj36FMm1eHN++WRc
	57buOFYmEiEgw74LiEs+ECWKF7l+ZACSSZ8kXTU36fc3yrX6dS0qVRY+Xg1FAFyYum1gZGHsmHk
	0auAnfTPXShu4DQ==
X-Received: from plrf5.prod.google.com ([2002:a17:902:ab85:b0:2a7:6c0c:5916])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c952:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a8d8176d76mr6976645ad.41.1769721950767;
 Thu, 29 Jan 2026 13:25:50 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:55 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-9-dmatlack@google.com>
Subject: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/device_cdev.c |  4 ++++
 drivers/vfio/group.c       |  9 +++++++++
 include/linux/vfio.h       | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 935f84a35875..355447e2add3 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -57,6 +57,10 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	struct vfio_device *device = container_of(inode->i_cdev,
 						  struct vfio_device, cdev);
 
+	/* Device file must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD */
+	if (vfio_liveupdate_incoming_is_preserved(device))
+		return -EBUSY;
+
 	return __vfio_device_fops_cdev_open(device, filep);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index d47ffada6912..63fc4d656215 100644
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
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index dc592dc00f89..0921847b18b5 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
+#include <linux/pci.h>
 
 struct kvm;
 struct iommufd_ctx;
@@ -431,4 +432,21 @@ static inline int __vfio_device_fops_cdev_open(struct vfio_device *device,
 
 struct vfio_device *vfio_find_device(const void *data, device_match_t match);
 
+#ifdef CONFIG_LIVEUPDATE
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
+#endif
+
 #endif /* VFIO_H */
-- 
2.53.0.rc1.225.gd81095ad13-goog

