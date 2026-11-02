Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633830;
	b=DXienL+DEOqx2ldTbOBY4n+q/a9/tuVZMhdlaLsAfHP6BGJGEcNkueBauF0GOamG8Uqs
	 z19scKgRS89Fgc8qlZb3x6/Id4rKjZVw28JtxS6OfImvF71a40SMkJAsmM/tUznPbBWJl
	 f7KEr7B6OdppSED71JtyGaNggsl/ebsjs8wHLHIClmMhpGKDF1wPZla1wK8m+JSTEJKSH
	 m3wzGO+pVSIjSTfaIJey83KcvhcuhP3Lt40vl/5oyy/sH8z/S1wuY/MxfiM63vyDfbKBo
	 usMuQSsQ9t584UDoWfNKpppBaf08iACV+MdHm1t3ZsJNFXhYL1OlfiiIbKxw0f7aZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=;
	b=Tzgm/x4PedVPhZiB01rwgGiB+xJ+meN6aYFFybaIPcPDJ3nrRAkdXlIYRkahxJLG9zIo
	 qKn2uga4xeZzeM28+Jp1ygzbiQyCqfUoyjnpDyZPahqjmBLQW1sedDuwCXzCaLNkfdxZS
	 Vbn7b6uWdELrhdBDrT/w/Fqg1/j/plgTivMwO7xaygMHoCAtC+2jCDaaEA2oPSw+Fig+X
	 NtHN1OU4OxTNoAyV1riatwU337p4BgM82FUSvybMq0TetKKbjfg57wTtmrlWUosi6Uzbe
	 tCwbdkX3kYF59LKXmOr41uTGBRUJXxeklVodUyzt7vlvsw1rrfkSI9uRHJFoVC9LY1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RHPknbIb;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54360E5031
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C54360E5031
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RHPknbIb
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9821ca96fso51011155ad.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633830; x=1794238630; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=;
        b=RHPknbIbBuIHlHHpM+0mhs9tS8/MLTkheddYOkdNGOyFLmEGT944Vj4CKBLdx0YaJu
         Dev5zbaIf51qW40wRu0B7H4K9XVtl+vkwOM/eW9w+GCgSmMhvQrhhHamlfL9Ao/lFjW6
         Z/8apUu85BYGwHJLBcr8YTGnEGeW6gU4s/np3+7VkJ2p0adAqkIqX6r1EThLrmWkG5oG
         wwLsnsjXxqYlhBUPiQCDNldLCi3yeQ+TWM87/k82MUS3u+/Je5RNYTYMPpJF/+dhXuXk
         SSjvXJFiPF/DZO2+R9mQQ1Rjxvgx6qJKTi7fqJhV2SN5+GEUOyN1lJuBkcUJnGU7ehAo
         r9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633830; x=1794238630;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+ppaxYmKgFAGGAkOJ55j6j/Hm1uYafLIHrUuvA3BIk=;
        b=sHXdH1cszvsru4DDhfauvTMIP5xuI0rR4xjwegY/is6BifdHRUd66HM/tET/zn/0ws
         cRBp+ykUzydnOm5Fn3hLC80T8kxMOf1bLEZxArnkd0rD020yfMPlObTgms9HniUnbW9k
         dTAqBxQV+uoGPneHfepwEh2kJEoSlcYBkkX1dnGFWz+4DLpgu5UPrqBTNWj/Y1k3o9EJ
         P7Bfk5wpFha2N2r7099AQfPe+cZnXXnDrFC24oeB0PphyN3PapiBa9HzVd5pZeH85QY3
         TqI2vyudiCWCr1cLK6XESKXk5/pDnFMh+UQJUxpKKJb53F5msb7RGWk89KBbdXjTmor6
         G17w==
X-Forwarded-Encrypted: i=1; AKwUvBzX79DJsSTDsD3782+f/hjyJTZxQ4h11J8WQhXKlBWqlx8jjhQjCQ8yA8q7ApLYe3zWzUf2fUWByDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PaicaKwp5KLOHsOG7c2oV26Ecq5oa12RymjwZJh8w0wVS4vKw
	I9AWGj8h0BuBWQOZTzfNDzrL4aZm/hX1Qbk1yvQKLQcAz+yvZC4e6hn0jBf5eLJQ2TWaXfHwMen
	fPcB6WZp9bA==
X-Received: from pgca18-n1.prod.google.com ([2002:a05:6a02:6392:10b0:cd8:b247:58f0])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134c:b0:3ab:9c73:12f
 with SMTP id 98e67ed59e1d1-3ae897ee533mr8958349a91.24.1793633829608; Mon, 02
 Nov 2026 07:37:09 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:38 -0800
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
Message-ID: <20261102153656.1431701-10-vipinsh@google.com>
Subject: [PATCH v6 09/27] vfio: Refactor vfio_device_fops_cdev_open()
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

Refactor vfio_device_fops_cdev_open() to use a static helper
vfio_device_cdev_open(). This helper will be used in subsequent
patches to support opening the device file during Live Update restore.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 23b229468151..d83e99137e1a 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -20,14 +20,8 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file *file)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
 	int ret;
 
@@ -46,14 +40,14 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
@@ -62,6 +56,18 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	return ret;
 }
 
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-- 
2.56.0.317.g454f8302e1-goog

