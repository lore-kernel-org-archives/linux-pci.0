Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7736A375
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543322; cv=none; b=WrZmOhYQcxNq6EEj3PeW92C23M9oMLB+Wp/8jPeXA3OUgrLNXxu0bLA9iVh5Suh3zJOgRNEbq6oG1uZo6JVtuuQMokiCRGpyrXfX5Lc8TCSmZCO/Njwpl+0YHJCVV1gh75Yqhk4OgV+dKtJhAnWhtyVTmNgO/2Gna8HiRelaFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543322; c=relaxed/simple;
	bh=SpIYSVSldCEwiprj2FMflWFJ+YUNjxruLjwCB5+5c+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2pL15/7TYtEp51vFld1a8aL8y9dxanFkFBy0QirS8jVgYuWxwLZ93uLjv4xJNfeF3n6DCBAET7nJEfoxzdnR9oeXWOfhblUEiVfz5eOZmaqtsTECnpmP5ZvIyir0kkH+owfVs5RtO0p7fQ2OQlOoUw5IfQDfF1Y9Kb1O3H7hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIdQdAll; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIdQdAll"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso7035636a91.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543319; x=1779148119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrg49k9+y9J8ukhGOYyOcoRGRzDx8kw+P2iL1XvrVyA=;
        b=iIdQdAllJGT5uRTSnlNfjA0jyVxxEaxv1PVl1YEqetXp9I428MPP1Y+4l//NcU3ptc
         MgTFqo9N59JxHD0WJFGV7Ro7TWjjE8jpDu2sI6XsT+PSZCTVZIbjfPhzN1zVJU4TWL8k
         x6miZHXAiDs9lz/ZGAlGe15fzmSxEqMXk1UD4ZJrKkfufilgIJuMSHPw92W4Y8ATLsku
         5ZcAi35anfpFcKInOeoCYybxG6b10Kd4M6EyMMFLdk0dWOhXbqDRn452QnYOEb906sYH
         Stba+i56J7zM/PwHIKttxiPnkyMbdcDcryAe50LlroUanKComuRWamGG+vuuGm1hy6Aw
         j77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543319; x=1779148119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrg49k9+y9J8ukhGOYyOcoRGRzDx8kw+P2iL1XvrVyA=;
        b=tCzqOAeY5frXdXnZKr1xRfZKxbE178LvOrpWfyQxrXy8Us06JBYM2kv8+sS0rx2VUX
         LjRAaz52fzZAYBPoxAkZoTKRLJWu1pIUFV+YEYI6/Z3WkFtQQdVGEOslHEdSdfT00t1y
         LkDZ3t51+XU7exVhfz+vGXcrTXyc9mRxDi/7jDDGVnqiyFRQg5VZmLuDQibQAgineZeN
         d8SEmrYP2Uh8x1G4FVprHnfXIuwHoTwj/DuJgJrDYINGxLaAqsHCCGiIdnSwS20flv1C
         d2AVO3dJK71pcNouH1DZ97mHN0J0cSo70k/RcCnTNPAw2rJ+HZ2qcjagjz+Dvzr5/erK
         gaSw==
X-Forwarded-Encrypted: i=1; AFNElJ+e2Wtw+1FUh+421adIbo8HoV0//w8Jnu7nIPbQ0u60bkEx+5CDXdyy+7jppxTzlDhla8XgXKG8EN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5Gv+F7NSCe4l59pcwRvr81hX/JaTh1PsyAkAabqxnzGeLHZI
	HxDkNjWUFkTkiQOu2m1oFmBE5/ASSb7cRnUC/yKaBGehoc1xUOtQQnwQ2iAYBRYpBYeBrOEpR4B
	1mPr6tGCtDw==
X-Received: from pjbil14.prod.google.com ([2002:a17:90b:164e:b0:368:bb57:bcb7])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e87:b0:35e:30bc:96e2
 with SMTP id 98e67ed59e1d1-368b24e55acmr760190a91.10.1778543319028; Mon, 11
 May 2026 16:48:39 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:56 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-11-vipinsh@google.com>
Subject: [PATCH v4 10/16] vfio: selftests: Initialize vfio_pci_device using a
 VFIO cdev FD
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

Use the given VFIO cdev FD to initialize vfio_pci_device in VFIO
selftests. Add the assertion to make sure that passed cdev FD is not
used with legacy VFIO APIs. If VFIO cdev FD is provided then do not open
the device instead use the FD for any interaction with the device.

This API will allow to write selftests where VFIO device FD is preserved
using liveupdate and retrieved later using liveupdate ioctl after kexec.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  3 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 ++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..896dfde88118 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -38,6 +38,9 @@ struct vfio_pci_device {
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd);
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010..7a81edb3245e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -342,19 +342,27 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, int device_fd)
 {
-	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
+	const char *cdev_path;
 
-	device->fd = open(cdev_path, O_RDWR);
-	VFIO_ASSERT_GE(device->fd, 0);
-	free((void *)cdev_path);
+	if (device_fd >= 0) {
+		device->fd = device_fd;
+	} else {
+		cdev_path = vfio_pci_get_cdev_path(bdf);
+		device->fd = open(cdev_path, O_RDWR);
+		VFIO_ASSERT_GE(device->fd, 0);
+		free((void *)cdev_path);
+	}
 
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
 {
 	struct vfio_pci_device *device;
 
@@ -365,10 +373,12 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	device->iommu = iommu;
 	device->bdf = bdf;
 
-	if (iommu->mode->container_path)
+	if (iommu->mode->container_path) {
+		VFIO_ASSERT_EQ(device_fd, -1);
 		vfio_pci_container_setup(device, bdf);
-	else
-		vfio_pci_iommufd_setup(device, bdf);
+	} else {
+		vfio_pci_iommufd_setup(device, bdf, device_fd);
+	}
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
@@ -376,6 +386,11 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	return device;
 }
 
+struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
+{
+	return __vfio_pci_device_init(bdf, iommu, /*device_fd=*/-1);
+}
+
 void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 {
 	int i;
-- 
2.54.0.563.g4f69b47b94-goog

