Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624579;
	b=jUFrjeoGMOqe50CBN86k7yIiD9QscAdccegdF4IflSFDX/1bISzA6iiUmCNPNFquoaEZ
	 0g+YeGFN+RnER3mTKEtp40Z/GOKBnEmivKkNLIsgShgUy9OVPBKLorX2d1t8e2Ch+Wf0m
	 T15eE44ft56GVg85mbVvH7v1+1f19lltQv6jKWKDT7Yonok23XUII8SAnqHF62a/XBaqa
	 9+fZT8eC0n9Lrd/QgOFtQC+33HJd5P585hgrHaaW8cJtdoBkIbkAc+x2ew4dZXkY1tGDD
	 u0H2ydWaEIR5whikm+gMxMYmLzXeGLk1hcEJ1x7+lr+lVNx9h/x/ukfRMuTvP3Hzz0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UXFz+LVPA4StkvelJonUtuNdbofnh/Ow/uAkSdC83dA=;
	b=GMF1xwkHs2F51gRxcwW3GV5dRsjrGoAx3KOuZ6fPC3ctlxvIhwy1zVvzaXDI7bJ5HGrs
	 BzBdOYZ0dQcmmSArTCteFaXa+jKxrT3F1ywsaJOcvFznH8XJM2ehhBsvXEZI65eaMsdts
	 xUWEKU938aPhC8zBZAXeysxZhR52FUFNazZedy5dp59hcpvDEFKOpqIE/ASu+ukTaPvcA
	 615NG1b1C/Co5c2owE7rJZyWKEA8EHFRSw1X3fdWPWN1sox6OGABS9PJ8TEbFqz2Ly0Go
	 Nb9zih8ZCNux5GzgzLuWckE4crTVcppixaB5gUxQUHho309DM5c2chytH/gMzFFhRMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=me4nK145;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94C606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E94C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=me4nK145
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso374436966b.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:49:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794624576; cv=none;
        d=google.com; s=arc-20260327;
        b=lLOLXJSStQYHGbh9ehdzxEu2JKvm6I7QtRkfTHa+CL/wutx4PSV8CSUiQKfzLRrTKh
         efPEO6ECqm4xrLAzbQNaC5Qd3Y0jnrpvVXouNx9bSApdOEUdi3rBndiDnNfl+JiHHX11
         Q4Th11o5T8RW22b1DUFKxWdn9zAt8qGhPeJZ7EMTWEKOWHVOE/FeTBgEnDxA415mj3CY
         mut5yI+DWGP2UbE214h/sd0e0HAck9Xi+yUA43VozFAnnwOU33yTiBbwhrF/ORLNnQ5r
         tO1+4OGkrVahfJV/ViAAcPbh75iPRI7mdRJvaRMBUdeYeQ3A0Vl9r8Wp87rrJmVrEeyj
         WMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=UXFz+LVPA4StkvelJonUtuNdbofnh/Ow/uAkSdC83dA=;
        fh=2i72fZbxvfcmWe3u6utYYUcRClyxhzgmyKwFtDXzC+s=;
        b=RLXQ0fWW+7R/F17TK0E4yzR5iuptLDhsYqQfme3z0C43+U3qa1SFgNDeMz5cTU7oCb
         lV4NKksiFoNiZc5/599B+4emSzxmZ6K/keo1/Lw643CnukkGiM0V8cEcRt/QXDPS0Z/k
         nkonVftuejgHCrDSlQ+FDZ7jKsDQKk0xdSZr4rWhEuI5vbDb8mo+cqs/8PzJMu9VElUb
         ErOvdeuv6/rmmsCgVTGGj2at5BpjwuAtf7elGiQZ2u3WCAFJsTSp1u1ig8mf4xfo1z06
         JxpIYgedWZcdOQje534evoYKkZ79Jw+0HvkV2NJCDO93ycxZhgCl0BDpe/6p0TQRc/Xa
         FAhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624576; x=1795229376; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXFz+LVPA4StkvelJonUtuNdbofnh/Ow/uAkSdC83dA=;
        b=me4nK145BvUwSydS35zt/+x/rtNM0IxHIveqPqHbNokQ+yVzcLXL9dt7WYXaSThfxZ
         fhW8en5hSbfanGV2k+EHaYnKcqh5SRrSpPehaGjV5kO0FAWBbMyUaKU0U4zqzDvmcYXx
         xKB14I16eTsnnwFRFvhgFavVhviWyNL872pKK3aA4VkBgkj9WQNs906hLTWD+r60pWVs
         PUfLi/MQzs+TBnTW4uyB+B9iTUuau/s9YOGBKpY3C1H0JBv3z1+mbAv2Cq8WCyHJLFbw
         RNVEmyfDq/Y+GjFAT7AL22x/9OIxEBQl2qqEr80zcAVAdOTScPUBPvxmsrHO3c8JTQbj
         04FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624576; x=1795229376;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXFz+LVPA4StkvelJonUtuNdbofnh/Ow/uAkSdC83dA=;
        b=oC4JM19vGyr03zahfYDInJojfZ9sViUTtnDC///fsnCLrteb2KVJJYlxX7fk1sPg9m
         Y3QrCxyQ70c39eSy+El11Ko3Ame1T20teNXiXK4EGsiAdgV4ysVFVriI+VU20hGkE1Xo
         nulxWo80vSPOkh+uFtc1Vx1Ecl/VAhNT3g7SK5wfFWhtxntPCc4d7vxqqn0Z/cJFFDFU
         bEzAFPsXx2h7FNw/du1o/mSBKbcvtgV0HzrlWVeOSH6wP0VFn7dnj6wXnFDkEB3PyI9h
         eT27bf3zXf0mClXCSNclIrkdYDbHNhlTjsF5wed5pKBSojU0hz9UWfH2xSEKmJ5dvlVh
         TIuQ==
X-Forwarded-Encrypted: i=1; AL+hErEwOsqX61vCOGEt35da6nKdKGjsbgAG+XZZsUSgYEV4sJYE2PeeSBOR1Bbee7NQbA57ZrkwEXF4Ang=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MX/np1DhoIAUEwR9Wd5TaSEEzECVYuQwGe99YCliS1VXqYSjf
	5zcxNDmQX4t1VqHKucRIBI5i1nrjKyobcoPaiMVb8wlo+CKUhGcg68X+SWukoec6V6k0I/874Dx
	DKRVrxYkFru+xQvIro4+3ev3zGuWbMT4=
X-Gm-Gg: AYBFou0sY4N4acxZQkgWva5/Vt8fKIlCwWCaczzQATHyHhrR4CkA3tHk4UeP0ldz5tt
	qLxs+c8pByBcehfTbxXoeBJKDJgkICG7MKu0S0PskYSykYu+V0hJ9yatwP8LU5aaFjWChY9Y3YE
	B7WTLjYR0+a/QqeK+mNNrpSpeva+l7vNK6/d7fp7CDSWAJzEBoOYhyXReF/GjkgAQcMRZyuT2fw
	Z1ZRV9CYt4pnGwCeyvEEMD8FcegGnyTl/fhKISAknntiq8uzDEy3vpDLRCF4bE3Gt2vXs77hrPC
	talJ97T0URgqDFTFOoriUehhi5qL7yGl2Pb58GUxKWMqIDWMfiEzWDofEON/9zMBKWeaT9y0URa
	P8Kkx9VmPVLQPyugxEbYcWQ81p77CXdcdU7sc7bA4QltHTzSOPCnMHl/s+KL8G4n0jNxt
X-Received: by 2002:a17:907:1b06:b0:c48:1977:e1c3 with SMTP id
 a640c23a62f3a-c509633f436mr370744566b.21.1794624576345; Fri, 13 Nov 2026
 18:49:36 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 14 Nov 2026 02:49:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Gustavo A." <gustavogyn@gmail.com>
In-Reply-To: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
Date: Sat, 14 Nov 2026 02:49:35 +0000
X-Gm-Features: AclHuK_8EXPqWfBcaJzUj-vJun5PFqofwNouDnURDw6kMQ9Hpoyy-kyr9dieQcc
Message-ID: <CAPZV9qVJ9BcwFgT7-3j6vxCmyCQmMan7WHsmRYgx1AT3aJcVBw@mail.gmail.com>
Subject: [RFC PATCH] vfio/pci: Wait for GB202 firmware initialization after reset
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, gustavogyn@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: "Gustavo A." <gustavogyn@gmail.com>

On the affected system, GPU passthrough worked with the CachyOS 7.2.10
host kernel. After upgrading the host to 7.3, the guest still booted but
its physical display stayed grey. The exact triggering change is unknown.

GB202 GPUs can complete a PCI reset before their Firmware Security
Processor (FSP) finishes initialization. Wait for the BAR firewall to open,
then poll FSP's boot-complete status before reporting reset success. This
restores normal display output with huge BAR1 mappings.

Use a shared five-second timeout. Reject unassigned BAR0 resources,
temporarily enable memory decoding to read FSP status, and restore the
original decoding state while preserving concurrent command-register
updates.

Apply the check to physical GB202 GPU functions, covering both GeForce
and RTX PRO variants.

Link: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/fsp/arch/blackwell/kern_fsp_gb202.c
Link: https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e6a2e01579fbbd1ca2ed43fef2ee2589e9bd8bd9/src/nvidia/src/kernel/gpu/bif/arch/blackwell/kernel_bif_gb202.c
Signed-off-by: Gustavo A. <gustavogyn@gmail.com>
---
 drivers/vfio/pci/vfio_pci_config.c |  16 +++-
 drivers/vfio/pci/vfio_pci_core.c   | 141 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |   2 +
 3 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c
b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac6..94d49f2e2 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -908,12 +908,18 @@ static int vfio_exp_config_write(struct
vfio_pci_core_device *vdev, int pos,
 						 &cap);

 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
+			int ready_ret = 0;
+
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
+			ret = pci_try_reset_function(vdev->pdev);
+			if (!ret)
+				ready_ret = vfio_pci_gb202_wait_ready(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
+			if (ready_ret)
+				return ready_ret;
 		}
 	}

@@ -993,12 +999,18 @@ static int vfio_af_config_write(struct
vfio_pci_core_device *vdev, int pos,
 						&cap);

 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
+			int ready_ret = 0;
+
 			vfio_pci_zap_and_down_write_memory_lock(vdev);
 			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
+			ret = pci_try_reset_function(vdev->pdev);
+			if (!ret)
+				ready_ret = vfio_pci_gb202_wait_ready(vdev);
 			if (__vfio_pci_memory_enabled(vdev))
 				vfio_pci_dma_buf_move(vdev, false);
 			up_write(&vdev->memory_lock);
+			if (ready_ret)
+				return ready_ret;
 		}
 	}

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da86..c77de8868 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -17,6 +17,8 @@
 #include <linux/file.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
@@ -24,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/vgaarb.h>
@@ -575,6 +578,129 @@ static void vfio_pci_core_map_bars(struct
vfio_pci_core_device *vdev)
 	}
 }

+#define GB202_BAR_FIREWALL	0x2b8
+#define GB202_BAR_BLOCKED		BIT(24)
+#define GB202_FSP_STATUS		0xad00bc
+#define GB202_FSP_READY		0xff
+#define GB202_TIMEOUT_US		(5 * USEC_PER_SEC)
+
+/* Serialize with INTx; byte writes preserve concurrent COMMAND+1 updates. */
+static int vfio_pci_set_memory_decode(struct vfio_pci_core_device *vdev,
+				      bool enable, bool *was_enabled)
+{
+	unsigned long flags;
+	u16 command, readback;
+	u8 value;
+	int ret;
+
+	spin_lock_irqsave(&vdev->irqlock, flags);
+	ret = pci_read_config_word(vdev->pdev, PCI_COMMAND, &command);
+	if (ret)
+		goto out_unlock;
+	if (PCI_POSSIBLE_ERROR(command)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
+	if (was_enabled)
+		*was_enabled = command & PCI_COMMAND_MEMORY;
+	value = enable ? command | PCI_COMMAND_MEMORY :
+			 command & ~PCI_COMMAND_MEMORY;
+	if (value == (u8)command)
+		goto out_unlock;
+
+	ret = pci_write_config_byte(vdev->pdev, PCI_COMMAND, value);
+	if (ret)
+		goto out_unlock;
+	ret = pci_read_config_word(vdev->pdev, PCI_COMMAND, &readback);
+	if (!ret && (PCI_POSSIBLE_ERROR(readback) || (u8)readback != value))
+		ret = -EIO;
+
+out_unlock:
+	spin_unlock_irqrestore(&vdev->irqlock, flags);
+	return pcibios_err_to_errno(ret);
+}
+
+/**
+ * vfio_pci_gb202_wait_ready - wait for GB202 firmware after reset
+ * @vdev: VFIO PCI device
+ *
+ * GB202 releases PCI reset before FSP initialization completes. Wait for BAR
+ * access first, then firmware readiness.
+ *
+ * Context: Sleepable. Called during initial device enable or with
+ * memory_lock held for write.
+ * Return: 0 for unaffected or ready devices, negative errno on failure.
+ */
+int vfio_pci_gb202_wait_ready(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 firewall = ~0U, fsp_status = ~0U;
+	bool memory_was_enabled = true;
+	void __iomem *fsp_status_reg;
+	ktime_t deadline;
+	s64 timeout_us;
+	int ret, config_ret, restore_ret;
+
+	/* GB202 GeForce and RTX PRO GPUs use device IDs 0x2b80-0x2bbf. */
+	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA || pdev->is_virtfn ||
+	    (pdev->class >> 16) != PCI_BASE_CLASS_DISPLAY ||
+	    (pdev->device & 0xffc0) != 0x2b80)
+		return 0;
+	if (pdev->current_state != PCI_D0 ||
+	    !(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
+	    (pci_resource_flags(pdev, 0) & IORESOURCE_UNSET) ||
+	    pci_resource_len(pdev, 0) < GB202_FSP_STATUS + sizeof(u32))
+		return -ENODEV;
+
+	deadline = ktime_add_us(ktime_get(), GB202_TIMEOUT_US);
+	ret = read_poll_timeout(pci_read_config_dword, config_ret,
+				config_ret || PCI_POSSIBLE_ERROR(firewall) ||
+				!(firewall & GB202_BAR_BLOCKED), USEC_PER_MSEC,
+				GB202_TIMEOUT_US, false, pdev,
+				GB202_BAR_FIREWALL, &firewall);
+	if (!ret && config_ret)
+		ret = pcibios_err_to_errno(config_ret);
+	if (!ret && PCI_POSSIBLE_ERROR(firewall))
+		ret = -EIO;
+	if (ret) {
+		pci_err(pdev, "BAR firewall not ready: %#x (%d)\n", firewall, ret);
+		return ret;
+	}
+
+	fsp_status_reg = pci_iomap_range(pdev, 0, GB202_FSP_STATUS, sizeof(u32));
+	if (!fsp_status_reg)
+		return -ENOMEM;
+
+	ret = vfio_pci_set_memory_decode(vdev, true, &memory_was_enabled);
+	if (ret) {
+		pci_err(pdev, "Cannot enable BAR0 access (%d)\n", ret);
+		goto out_restore;
+	}
+
+	/* A zero timeout would disable the polling deadline. */
+	timeout_us = max_t(s64, 1, ktime_us_delta(deadline, ktime_get()));
+	ret = readl_poll_timeout(fsp_status_reg, fsp_status,
+				 fsp_status == GB202_FSP_READY ||
+				 PCI_POSSIBLE_ERROR(fsp_status),
+				 USEC_PER_MSEC, timeout_us);
+	if (!ret && PCI_POSSIBLE_ERROR(fsp_status))
+		ret = -EIO;
+	if (ret)
+		pci_err(pdev, "FSP not ready: %#x (%d)\n", fsp_status, ret);
+
+out_restore:
+	if (!memory_was_enabled) {
+		restore_ret = vfio_pci_set_memory_decode(vdev, false, NULL);
+		if (restore_ret) {
+			pci_err(pdev, "Cannot restore memory decoding (%d)\n", restore_ret);
+			ret = restore_ret;
+		}
+	}
+	pci_iounmap(pdev, fsp_status_reg);
+	return ret;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -601,6 +727,12 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		goto out_disable_device;

 	vdev->reset_works = !ret;
+	if (!ret) {
+		ret = vfio_pci_gb202_wait_ready(vdev);
+		if (ret)
+			goto out_disable_device;
+	}
+
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -1322,6 +1454,8 @@ static int vfio_pci_ioctl_reset(struct
vfio_pci_core_device *vdev,

 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
+	if (!ret)
+		ret = vfio_pci_gb202_wait_ready(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
@@ -2574,6 +2708,13 @@ static int vfio_pci_dev_set_hot_reset(struct
vfio_device_set *dev_set,
 		vfio_pci_set_power_state(vdev, PCI_D0);

 	ret = pci_reset_bus(pdev);
+	if (!ret) {
+		list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
+			ret = vfio_pci_gb202_wait_ready(vdev);
+			if (ret)
+				break;
+		}
+	}

 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234..fcc7d1b53 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -68,6 +68,8 @@ void vfio_config_free(struct vfio_pci_core_device *vdev);
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);

+int vfio_pci_gb202_wait_ready(struct vfio_pci_core_device *vdev);
+
 void vfio_pci_zap_and_down_write_memory_lock(struct
vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.56.1



On Sat, 14 Nov 2026 02:48:53 +0000, "Gustavo A." <gustavogyn@gmail.com> wrote:
> On the affected system, GPU passthrough worked with the CachyOS 7.2.10
> host kernel. After upgrading the host to 7.3, the guest still booted but
> its physical display stayed grey. The exact triggering change is unknown,
> so this patch has no Fixes tag.
>
> PCI reset returns successfully while the Firmware Security Processor (FSP)
> is still initializing. Restricting BAR1 to 4 KiB mappings masks the problem.
> Waiting for FSP completion after reset restores normal output with stock
> KVM and verified 1 GiB BAR1 mappings.
>
> The RFC question is where this wait belongs. It currently follows
> successful resets in the VFIO enable, reset ioctl, PCIe/AF FLR and hot-reset
> paths. Would a PCI-core readiness check after state restoration be more
> appropriate? A device-specific reset method runs before BAR and state
> restoration and does not cover all bus resets. The existing reset_done
> callback cannot propagate errors.
>
> Validation:
> - Local host and Linux guest: 7.3.4-1-cachyos, QEMU 11.1.3, GPU 10de:2b85.
>   The physical display works with startup tracing disabled. The submitted
>   readiness code adds only an IORESOURCE_UNSET guard to this tested code.
>   A focused check fails without the guard and passes with it.
> - Rebased onto mainline 97d73c825122 (7.4-rc2). Full W=1 builds pass with
>   GCC 16.2.1 (VFIO modules, PM enabled) and Clang 23.1.5 (VFIO built in,
>   PM disabled). No VFIO compiler warnings. Unrelated warnings remain.
> - 79 helper checks and 51 reset-path checks pass using extracted source
>   with modeled PCI, time and locking. The unpatched reset-path baseline
>   fails 22 checks. The hot-reset model covers completion and unwind for
>   three devices, excluding ownership validation and initial locking.
> - Strict checkpatch and kernel-doc pass. Sparse 0.6.4 reports the same 17
>   diagnostics on patched and unpatched code, with no added findings.
>
> The rebased mainline kernel has not been booted. Runtime lockdep, D3/resume
> and repeated hardware reset cycles remain untested. Hardware testing covers
> only the device listed above.
>
> Related FSP-ordering work:
> https://lists.openwall.net/linux-kernel/2026/06/15/1402
>
> Gustavo A. (1):
>   vfio/pci: Wait for GB202 firmware initialization after reset
