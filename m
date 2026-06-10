Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA3416D1D
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104742; cv=none; b=N/f8plB7GP+7epSswxiy8+gn3UftBPVOw03z7IeqtmPUMtLaQHvYSoDY86KDPKLbqhWH9uOZuaK9XHDFfbTDbu5s5HiKRGWmO3UNwsqCyQvSlwCwN9fGfN8GisS+OY6V9w25czkJ6g6mTLE6YCFnoMFc6y/dqPgWH6Mb7Th7pXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104742; c=relaxed/simple;
	bh=UkLj+tZqpkffpEV5QRjxZQz63KWtzsiYYBPOPyc3h+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/p6+LhkNX20XUP4DgA1tlw4B1wWOdtOoTf8Jyh9LhLNawie7KLzLFAFwZy04M9mEKDl3H+vfse3DvEvEEO4zX0UFs+FsPEu2ile1dysmKsrW6eQdm2VovZpRX8Ao8hAHr7ZtbXPQ6dt0VP6SdCJH+a+GylF4kE3EXTWb7jlGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd0OG8Em; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hd0OG8Em"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso4430086b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104741; x=1781709541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0es0rdpo5zHpTGer7c4Y4kWiVEeVry4q+hd8CbVLqA=;
        b=Hd0OG8Em7EHMQiF/hkAaxiBue+lvyOgIEeCTVLQWT6e6wqCV8V7rldu2w3qNEFjeyJ
         0ufcs3T+Oa/dYCASFh94bXV7Bmn8F1lJb1YNEFi08/uwSQfWT2QavgPaTFS4yhXPLo54
         +I6JeSsaXZmGmFbnyMpzFtXBHOxfDKr9t1ufXerpyOx9P0jfekWAlUvrqKJpV18J9M45
         l4yaRIoc/wx3t7fVmEvaFqLNsmb9d0KS//HXNPiBKkedq4hUcNfENAB/8lUQvcpyGSAb
         Nozk9Px94eou78R/AavXSLzoigRtxSLsoPO8XBnGxdAISdL5Se9v85O18dhzKQEhnjSa
         Azqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104741; x=1781709541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0es0rdpo5zHpTGer7c4Y4kWiVEeVry4q+hd8CbVLqA=;
        b=C+Coenw7L1YOMGRApHcla4N4PbrPENh78rTQuYYKE1CQxCO+KoJXfVya/3nFyzFomz
         zTf5aC8OycgMmTXtpUEb6ufebM9X5aI39c1KLfSdzdJwZU0yQQsB8cCJKRCF39S1eVCy
         5MBWghV4XZH9J+Bj0ktj6fXObUXJWQ9hf73jhLbYcSn97y9H1vY/bgf0MvYUNfHc0UyI
         MaU3KPELRq7hbk6FSQXnRDL/IfBalkLsIvUJKHmS5QtPsZ0Boe2nwqUm4BJEjo0bROjh
         ztJPqlxN2LHRYc3pM6jd8/JC9MkjFvOWoFlaXkMubjhZ3WwFuyClmvD59fS63JyolVAh
         eF8w==
X-Gm-Message-State: AOJu0Yyepq7Ob0u147zybgj0F2jWbTxBzbEAam26oeaq8FMHfWhgFE2r
	dybCrIXEEGPfeOSqWZk+MOYfDPrVoebToomBOJf1XmQAFnp4EAQyQsUiAhYLDynRE3b2OEL5cK6
	k/Wf2BO8seIbJQz98Tn2U2WKPUAfyGVf9es5xPaP6TkX3TGT+bDBuxIw0MCs6J70toxKsIu+m8K
	l9m5op+r2GC/SZCZxgE6+Zd6Fx6wfCsqxrehE=
X-Received: from pfne8.prod.google.com ([2002:aa7:8248:0:b0:842:4f22:f388])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440a:b0:842:614e:cc9d
 with SMTP id d2e1a72fcca58-8430a70be01mr8519996b3a.27.1781104740313; Wed, 10
 Jun 2026 08:19:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:50 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-3-praan@google.com>
Subject: [RFC PATCH 2/5] vfio/pci: Implement ZONE_DEVICE-backed P2P registration
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement the VFIO_DEVICE_FEATURE_P2P_REGISTER. A bitmask is added to
track the registered regions.

Post-registration, the BAR is added to the device's P2P pool and is
available to be used with standard page-based APIs.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 39 ++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..1e922e3aaeb3 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1554,6 +1554,43 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
 	return 0;
 }
 
+static int vfio_pci_core_feature_p2p_register(struct vfio_pci_core_device *vdev,
+					      u32 flags, u32 __user *arg,
+					      size_t argsz)
+{
+	u32 bar_index;
+	int ret;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(bar_index));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&bar_index, arg, sizeof(bar_index)))
+		return -EFAULT;
+
+	if (bar_index >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (!(pci_resource_flags(vdev->pdev, bar_index) & IORESOURCE_MEM))
+		return -EINVAL;
+
+	/* Already registered */
+	if (vdev->p2p_registered_bars & (1 << bar_index))
+		return 0;
+
+	ret = pci_p2pdma_add_resource(vdev->pdev, bar_index, 0, 0);
+	if (ret && ret != -EEXIST)
+		return ret;
+
+	vdev->p2p_registered_bars |= (1 << bar_index);
+
+	pci_info(vdev->pdev, "BAR %d registered for ZONE_DEVICE P2P\n",
+		 bar_index);
+
+	return 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1572,6 +1609,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_P2P_REGISTER:
+		return vfio_pci_core_feature_p2p_register(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 5fc6ce4dd786..cae7f069e5b6 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -112,6 +112,7 @@ struct vfio_pci_core_device {
 	struct vfio_pci_region	*region;
 	u8			msi_qmax;
 	u8			msix_bar;
+	u8			p2p_registered_bars;
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
-- 
2.54.0.1099.g489fc7bff1-goog

