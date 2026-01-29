Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041572F745D
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721954; cv=none; b=uXiaPLv0POvVsgEmO/dd1p3hov0hm12uCErmE93FeZjeAa/KLd78xp070ZU9jkfsILZYFjL924UUi9tw84R9xPTLYVj/oOc6b1qZv7+u1qfIWMso1GOnPA2g4HQX8RLrx/yBTa75rQjRfVHocWPqHXGuHmtQNfD+tUwzjnAKd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721954; c=relaxed/simple;
	bh=6IdtaI14wSLFnlm3AePOxVdQnZ5Ce/BaKfnD8oLedO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgdpJScsfvWRdVyYpHBbhHwIv5NUDacg+GlLiCbn+ScxdPk/4IHMsVs3Use+hm5U0SgR9RNkXbBBpPVzF6GwKICl7PZfQJRea24Ux3pRXJduSidQO0yMxQI/otLeG7jRKReP1BsznWaKB6IGDPKqJs2SsMGBFdDmDhRKLWz5zT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2b2iQaws; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2b2iQaws"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-353a5c295e4so1775772a91.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721952; x=1770326752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEITHmxK+p0fg2PKlGTWLUl48Yr7XTXbjGIRUwhwM+A=;
        b=2b2iQawsuPGFdxNaG5DH0hw0rX+Sqvp6lcSMbvGtXOPbhnGelfqgN3xGH8EIEeaqLM
         MWu+vEK8CeOtWWmjKilHqHyrBwyaXmEe46T9N+cw5YAXzBwF9T8blgw1yE+JxCy/Jxco
         Pxo2hJ+Jxf/qwb9gO6AoYjGm1Z+iX+in76+iq2cuwkei8ZGaV3jevtB9ODT4pQuJ7re/
         6TFO29PI7rslUwKTqHnG1A524axdk9oAhdD5huZ2N8TOU+8yayQPfX/9fezyK9B5AkGU
         t3EE3LQcNqDBMJ5LYwz8P5dllqo0HzvspUHB/e/CXHBRon9adexg1bP5Oi1YIHovGq3u
         CbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721952; x=1770326752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEITHmxK+p0fg2PKlGTWLUl48Yr7XTXbjGIRUwhwM+A=;
        b=Uhgqn+lwq2EntpeQQMyR7QZSeeTkSJ7fdY9pOrXYUJQfJ1sxei+lLiA3b/GE/NcaIn
         q2sPm9O3xuHEkMntWM5mL5wPRq4D0iVSL66dSuSbYvU/1LSE+PwvUrExBDywWdkpiYvA
         JhsUXCH/cG57g3FBZON4Mf0l6R5He6T9FVYdBXMYuCFTd3VEZDbCpkpjA4WIQ/HjFzkb
         Kid5SqioPyHz5Uvki4O/CJDnXjVtPkp7I7FwThh1GVccLg2cUkAey60lxCoEAwEKnwEd
         jz3kIMKe+e3EKESivgbJmcig+ZT8vSXRf0ikSIKeoLdVX9ROaoTCTQ9gsSXdpFhZfFmG
         Iw2A==
X-Forwarded-Encrypted: i=1; AJvYcCVboGf5IGzda/dqe3ySuyXLxrEbV0J5Qnnvs2EbIAOn3OIp7ZtIbrDWoZG+awtTQEy4Xis5VxTB2J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmAxvDFRUS4IsFtszgUP5U3Lya6dBvCck5PdVQWp+BMjGApGY
	mthgRl50OkVuy4n3vsSzubPvg4Cy897uqitiB4eGTFMfVln3JbrtFsCbe4qufEXSi8oqHeVnsHr
	1A/pY4Q80QfiHhw==
X-Received: from pjk11.prod.google.com ([2002:a17:90b:558b:b0:34c:489a:f4c9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c10:b0:353:2972:74a4 with SMTP id 98e67ed59e1d1-35429af8f7amr3444629a91.13.1769721952367;
 Thu, 29 Jan 2026 13:25:52 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:56 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-10-dmatlack@google.com>
Subject: [PATCH v2 09/22] vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device
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

Stash a pointer to a device's incoming Live Updated state in struct
vfio_pci_core_device. This will enable subsequent commits to use the
preserved state when initializing the device.

To enable VFIO to safely access this pointer during device enablement,
require that the device is fully enabled before returning true from
can_finish(). This is synchronized by vfio_pci_core.c setting
vdev->liveupdate_incoming_state to NULL under dev_set lock once it's
done using it.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 17 ++++++++++++++++-
 include/linux/vfio_pci_core.h          |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3a11e6f450f7..b01b94d81e28 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -569,7 +569,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
-
+	vdev->liveupdate_incoming_state = NULL;
 	return 0;
 
 out_free_zdev:
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index ad915352303f..1ad7379c70c4 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -131,6 +131,7 @@ static int match_device(struct device *dev, const void *arg)
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 	struct file *file;
 	int ret;
@@ -160,6 +161,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 		goto out;
 	}
 
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->liveupdate_incoming_state = ser;
+
 	args->file = file;
 
 out:
@@ -171,7 +175,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return args->retrieved;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+
+	if (!args->retrieved)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+
+	/* Check that vdev->liveupdate_incoming_state is no longer in use. */
+	guard(mutex)(&device->dev_set->lock);
+	return !vdev->liveupdate_incoming_state;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1ac86896875c..350c30f84a13 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -143,6 +143,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct vfio_pci_core_device_ser *liveupdate_incoming_state;
 };
 
 enum vfio_pci_io_width {
-- 
2.53.0.rc1.225.gd81095ad13-goog

