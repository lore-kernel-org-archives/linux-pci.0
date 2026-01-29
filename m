Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272436403F
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721957; cv=none; b=QIdA37a8o3NLbUUUNsc+je0S475Zl0fKQNAT66gL4EEq99EFx/mMfeLFXIthvbunUw1R3OC2YRkh50bEScplWkaW1H0gNu9xWlYDJcEib86Jdp2VN8N9MIzzMzxZyCqHXJTf4Xp09S2NMiZwts0DkB3SLugvTyE9DI1bM4LkoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721957; c=relaxed/simple;
	bh=a+0/tE04p22lp6sOOwH4YlMRI/tEgdEnUCc2v9hrZNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fA7sezA92QGcqDIohrA7BfGWilwvddF3xwjKDLPM5XBK7DN7MjTKIjf0Ad1FqD47BI9SiZPjM2OwhfBWxy752SfjPyXhb48Jj88EgkwrQ309GqZo2nN32hZkldAj7bw6qiuMEiBs+VUaVduGz7zha6P1QuPGXJxF63aoxsQbzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+wI6RtB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+wI6RtB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a13be531b2so13517565ad.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721954; x=1770326754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha2krivTi79qOGY9TNrpoF2Kn7NOugjkcaAbsESD6eI=;
        b=V+wI6RtBEKGX/Fwog7ZpkPux3Grm+DRByFarIYW9X9UZUWZw08uoezcY3k3//4eVLK
         Ii0d4yLzLzwB1oR/oTfl+qsqVyBgtpR+9jYzC7XAAxZendDZJdtq/Z5CwAhzCg8TkpBr
         7oQLtRpXEM1CiXVXJxM6IvwOuX/DXkKmhyC71s/JLwRVdFFIOVk+bFTW14kDQyQhZenT
         +js8UIHWg8KBT9LbpO1KtROQF2CI6T47CC2G85sUIye9WsmbF7FiFfSrj9DEAKbbceR7
         J6T2AH3sczRVsTrjPNYx/l5ECouQE1pHCyimQ49l4hsuIxhoTyBcwWmpSF8WthM2Y/YH
         Q+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721954; x=1770326754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha2krivTi79qOGY9TNrpoF2Kn7NOugjkcaAbsESD6eI=;
        b=V6/rCvrd8EjTHVKQcjfkTP8pS5//7bPdv3+K4RK4y9OvBmBQ5woQcNg2p558MLSpa1
         IPiEdbIR1pQA3syW82Ua6IkAhMgWLr4zIQZZncXiyUzxl0fOSIvN1kKC4mGaCrI37RED
         JFxhlpPbA3B+OU+rMO6hSBrpFxdNAeLmPiPRRvBzVpaj0YFaBkcOQoD3ptPiWurxLS4i
         YNqr3vV371OHiiWekkSurcWmhh7GhsQflUNmHbox1M8AbnTeTNE8peJNAxUIZJijOLdv
         SKLmd/i/yqKBnDKRWec9UMVplQ+8qnj/nD06lDllAk3+mqBCXQOzRVVJkaWEdRnY6tDN
         bWvA==
X-Forwarded-Encrypted: i=1; AJvYcCWe3dFusmRhZFLjqnbq9lHbROuUytGM8v4ww84sUpTvS+KHIUEwdBThTl74VC/D2miBJjiVLcqpSns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFgJxBar9LTy//eNIvX2Ae3XzX6I1sJd3R3aQGgoaqQHfocHV
	/qHgS2F5YVI3akYNR9bzh3JOHpMer5+QOnwD6THWl5WUELb8Oklyz7sWHquj7H3KV8Ms0+QZ3Yr
	c/O9pL8LGxN99Cg==
X-Received: from plba14.prod.google.com ([2002:a17:903:100e:b0:29f:1fb1:be7e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c9:b0:2a7:99c9:1086 with SMTP id d9443c01a7336-2a8d9a56c95mr4558805ad.47.1769721953965;
 Thu, 29 Jan 2026 13:25:53 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:57 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-11-dmatlack@google.com>
Subject: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after Live Update
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

From: Vipin Sharma <vipinsh@google.com>

Do not reset the device when a Live Update preserved vfio-pci device is
retrieved and first enabled. vfio_pci_liveupdate_freeze() guarantees the
device is reset prior to Live Update, so there's no reason to reset it
again after Live Update.

Since VFIO normally uses the initial reset to detect if the device
supports function resets, pass that from the previous kernel via
struct vfio_pci_core_dev_ser.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 22 +++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  1 +
 include/linux/kho/abi/vfio_pci.h       |  2 ++
 include/linux/vfio_pci_core.h          |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b01b94d81e28..c9f73f597797 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -515,12 +515,24 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (vdev->liveupdate_incoming_state) {
+		/*
+		 * This device was preserved by the previous kernel across a
+		 * Live Update, so it does not need to be reset.
+		 */
+		vdev->reset_works = vdev->liveupdate_incoming_state->reset_works;
+	} else {
+		/*
+		 * If reset fails because of the device lock, fail this path
+		 * entirely.
+		 */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
+
+		vdev->reset_works = !ret;
+	}
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 1ad7379c70c4..c52d6bdb455f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -57,6 +57,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
+	ser->reset_works = vdev->reset_works;
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 9bf58a2f3820..6c3d3c6dfc09 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -34,10 +34,12 @@
  *
  * @bdf: The device's PCI bus, device, and function number.
  * @domain: The device's PCI domain number (segment).
+ * @reset_works: Non-zero if the device supports function resets.
  */
 struct vfio_pci_core_device_ser {
 	u16 bdf;
 	u16 domain;
+	u8 reset_works;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 350c30f84a13..95835298e29e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/kho/abi/vfio_pci.h>
 
 #ifndef VFIO_PCI_CORE_H
 #define VFIO_PCI_CORE_H
-- 
2.53.0.rc1.225.gd81095ad13-goog

