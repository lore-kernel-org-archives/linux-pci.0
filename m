Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C038C427
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310339; cv=none; b=H9Wp8KtNl+WJA2d6VdVOoZNGZ9RidpHQPjklDLCtpuPZrtnWcjIO70+4i5IW/dTCGX85w95z/Bg2T1FMfpYFetk8j/rw++f9d4FRCqCcu39Knx4aAiuL8dw70eM83BHHCcYtTjw42278tPUT/Vjg9CXVqMxTFo8CckoE1JCuqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310339; c=relaxed/simple;
	bh=+0b5yfHhqKc5WRkrCQm2Jd3F6UU1rPdRTjAvF2KhK0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwMWqPl70lGvqKlGO0BO9JsLNDECEXEVtdNZLYONaONcvC5o2rvQyxEXZk3+A4OTBV9qY8RNMx0puu7iAS0rKdBXPp57pSe/OJKyN371JT+Zf+qpRD1Na1bXBGI5Xl6Q7fmZ6Vr8RV5knrlD5L3Zu2b+c9T2mpm29JzSywITNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2ibxz68; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2ibxz68"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b061868724so3415155ad.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310337; x=1774915137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6NpvLJAkS4c52+WboP6wAkf2PbPQKSMM3U4nd1tgoo=;
        b=o2ibxz68IXVTcIRdHzzqBa25/gq1A2igO71wTFgztZP/Ct2yhr0W7TM4nPTlvb6uXT
         a675CAbJ7xrdXRDTnpLslUarYiYWAPoniZYniKrCjcb5eDKN+6Oz33cjQnjtw9dWRwPm
         eta35Qgbx0E9/UkKofRss8tJe+TDO7xWZwyP71mNKZ4r+TLqWDvyLOxv51W438S9q/Hn
         oHd36fHDLbH3zIDV4WEob31theMxppbT69D90N+TEe6+R0dalhZQqrpZ8m/HcFq5shpK
         CytSn3es3Nw274l75XtO66yDCC7EaIJXZg5627sC6FArk8CIEPQDdskqL2aJYvoZcVGu
         0unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310337; x=1774915137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6NpvLJAkS4c52+WboP6wAkf2PbPQKSMM3U4nd1tgoo=;
        b=L0VJwrZKoteaCISO5k274E9YxN6L4hqgKls7xL9SFk2KPL+fiz1FcACiRhqkPr6Q3y
         C2ZWSMhlet/aP37FlWMWysGaL0eZ41/kfcKxWQOcPaeHusmS9k4YLjNE5V0H9QUY5ym9
         uSkj0CgAW6oWYqK/eFlJvJcSvJE/0l/XsqdBZ29Hx9TXnprruuKLJLhA8AORTiqw/Pgf
         r6kaUyN1AVFDsyc+4JlRE3/aPKAh9lZ+U9tN3q6AjRKarvXyKnAvZL42x35SE3kiTq1a
         KfssEwjDCGESr10NKQajy4gcgoe8jD/2YucCBjvdeslVpU0Gx8hyUdsTj56yeNUF1Orz
         fCLw==
X-Forwarded-Encrypted: i=1; AJvYcCWyM9OnBRjaEK0gS12n2wykzMP+bnPui5eZzng1Qoke+NF+18REH+XAjLlLhCryOcCdnUQ/AbgIxnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzx68JZjZizjEMe/wxkmBPLQ2i7BI8LjQ05YLQHzxEn69FYdg
	ozPPQ99tnaqydK7igCcul7FT0wU5REy0uo+yMj7wl2UXWCcxE6KeLbI0mNCWPwZN4Fr58FlmFYG
	aWKHeoYN9UeAeCg==
X-Received: from plgd12.prod.google.com ([2002:a17:902:cecc:b0:2a8:71ec:6799])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f984:b0:2ae:c795:6b4a with SMTP id d9443c01a7336-2b0826d73f3mr94191885ad.11.1774310336851;
 Mon, 23 Mar 2026 16:58:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:03 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-12-dmatlack@google.com>
Subject: [PATCH v3 11/24] vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device
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
 include/linux/vfio_pci_core.h          |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 81f941323641..d7c472cf4729 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -568,7 +568,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
-
+	vdev->liveupdate_incoming_state = NULL;
 	return 0;
 
 out_free_zdev:
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 6f760ace7065..8d6681e1d328 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -226,6 +226,7 @@ static int match_device(struct device *dev, const void *arg)
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 	struct file *file;
 	int ret = 0;
@@ -246,6 +247,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 		goto out;
 	}
 
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->liveupdate_incoming_state = ser;
+
 	args->file = file;
 out:
 	/* Drop the reference from vfio_find_device() */
@@ -255,7 +259,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return args->retrieve_status > 0;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+
+	if (args->retrieve_status <= 0)
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
index 2ebba746c18f..0c508dd8d1ac 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -26,6 +26,7 @@
 #define VFIO_PCI_OFFSET_MASK	(((u64)(1) << VFIO_PCI_OFFSET_SHIFT) - 1)
 
 struct vfio_pci_core_device;
+struct vfio_pci_core_device_ser;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_attachment;
@@ -142,6 +143,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct vfio_pci_core_device_ser *liveupdate_incoming_state;
 };
 
 enum vfio_pci_io_width {
-- 
2.53.0.983.g0bb29b3bc5-goog

