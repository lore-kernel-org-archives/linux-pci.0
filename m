Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419437A494
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543317; cv=none; b=ZTHPO09c6XJMUvjXoqTrwEk/dSLJ9E+o3vKhSXfBqLZZakCepXGb4nFmEKU8btNjGvfs6f+0lW/iUTWayrpHhH2hzIBPf+bGNDKFYW0bEHd6xKY5bWFizmboy+m3/RUf08DO4WttGwKp7DRmQJXExrujbast2icTNMWRX5Ibu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543317; c=relaxed/simple;
	bh=jYAESqc70AKAPm2uQN0+BGW14vc4dGTA7ACtaEyAaQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCeMscAFqCevAd3fa5qgJF6JAWGVlYKwJqP9/UF2e5MBeuEKtkOVxEZ4GeIw720vyy1ys8otff9CNiavO2CbB7hls9JVz8NkOFysI8WjxVveJQxRtWMrv/lOAQsOqDjzj2xXXPj1DoqMUeaXCYK21MPf2kNVN8cqKbEzxfuANsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFUjGoak; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFUjGoak"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba224c3ffdso64097455ad.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543313; x=1779148113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3NVtd4OK2CvqntR6Z53hO/1J0Yder27WCm5j/oDPnQ=;
        b=PFUjGoakT9zJjtd/apU/V8phW/8AuEDg6bJ7t+CL0TXOi80ozxaiRICrr53BMsFs+V
         A0+iRwvKydGd7SysfEV9hNZmrtxfs1+m0vsXyfK0JvDkjohMFjsGZXVtid29OniBGlQx
         vCJPMme+keCjR03ubtOOV3qp45ZeBEYr6XP6kfGVHLiYes0cHtf0qDjshDopNaUNijrR
         p+vwsddhbxN33e2iwjF/N0guuMQW4ngRtVUsnzPSw85iIQjl9oVQK7AnmzV039OqWDua
         0r1pW1MEXV6LcavxYYXlsCfjJ8CiLsagiKGxQ6hdLpZTm3T0dvF2Kz+R1YQytHgFwvB+
         EU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543313; x=1779148113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3NVtd4OK2CvqntR6Z53hO/1J0Yder27WCm5j/oDPnQ=;
        b=KtVP0aPC2C6TroP1VMVLt+NnUsohdiajAvlEnpZlFAZtQyYQEORqObYz6admkRn1ji
         Wb/R/XHLYxqpFflpztwcB38/rF1WilO8c92iCzUf9+jPCczat3HOrIkLI4K3PzGU4Fe3
         6ssFt0X1isszCsP3okR1IqPLD9IRj/rwDSBalnnS++hk7EMgVUJaXmd93kthfwJV2FGS
         84DdBAHk9JLT5Se8bRK2fpf+OBxQo+hBsbn95QWKAVxmFRifOMt7xRtWy4+4I1onfEp8
         V+XZtuF/j/ToCH2/2TIBvqXBjRT+SAK7FQ7WqZweWBkwfAxzd4yzQj3iVMmHS6z+6qO7
         WpAA==
X-Forwarded-Encrypted: i=1; AFNElJ9dV0M7qWw+J+iqAiju0ATedUq/z3sFsLv2rWlXLSZQ1Gbh7oJARz8Aq9DXhMf1q1Tr6/RVjIv8nO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3GZ0Dvymf5PWCcgw6XZHICwhO6Tcsr2hlSm5+VXT5lAL97ce
	65vSJSSRPwKDSm4Uv0EEiPgePgwg7vhGVVMdykYAEr11Bc3tIugut2w3fEW75mayAiRWnsN15WS
	CE+24zxO+5Q==
X-Received: from plud14.prod.google.com ([2002:a17:903:f6e:b0:2ae:3bca:37a5])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebd1:b0:2bc:db02:d1ed
 with SMTP id d9443c01a7336-2bd0134098dmr6418155ad.38.1778543313150; Mon, 11
 May 2026 16:48:33 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:50 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-5-vipinsh@google.com>
Subject: [PATCH v4 04/16] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
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

From: David Matlack <dmatlack@google.com>

Notify the PCI subsystem about devices vfio-pci is preserving across
Live Update by registering the vfio-pci liveupdate file handler with the
PCI subsystem's FLB handler.

Notably this will ensure that devices preserved through vfio-pci will
have their PCI bus numbers preserved across Live Update, allowing VFIO
to use BDF as a key to identify the device across the Live Update and
(in the future) allow the device to continue DMA operations across
the Live Update.

This also enables VFIO to detect that a device was preserved before
userspace first retrieves the file from it, which will be used in
subsequent commits.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 44 +++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 9142aaea94f2..11c3bc8a8dcd 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -71,6 +71,9 @@
  *    interrupts on the device will cause the ``reboot(LINUX_REBOOT_CMD_KEXEC)``
  *    syscall (to initiate the kexec) to fail.
  *
+ * In addition, the device must meet all of the restrictions imposed by the
+ * core PCI layer documented at :doc:`/PCI/liveupdate`.
+ *
  * Preservation Behavior
  * =====================
  *
@@ -141,23 +144,37 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
+	int ret;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		return ret;
+
 	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	if (IS_ERR(ser)) {
+		ret = PTR_ERR(ser);
+		goto err_unpreserve;
+	}
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
+
+err_unpreserve:
+	pci_liveupdate_unpreserve(pdev);
+	return ret;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
 
@@ -256,6 +273,15 @@ static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device;
+
+	if (!args->file) {
+		pr_err("Finish called on an unretrieved file.\n");
+		return;
+	}
+
+	device = vfio_device_from_file(args->file);
+	pci_liveupdate_finish(to_pci_dev(device->dev));
 	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
@@ -280,13 +306,23 @@ int __init vfio_pci_liveupdate_init(void)
 	int ret;
 
 	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
-	if (ret && ret != -EOPNOTSUPP)
-		return ret;
+	if (ret)
+		goto err_return;
+
+	ret = pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);
+	if (ret)
+		goto err_unregister;
 
 	return 0;
+
+err_unregister:
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+err_return:
+	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 
 void vfio_pci_liveupdate_cleanup(void)
 {
+	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
 	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
 }
-- 
2.54.0.563.g4f69b47b94-goog

