Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502923822AB
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310325; cv=none; b=N71E1tTPgzlLf/Ym4DyDziZCVOmeMHxOGDZnlSUoR8c/FlzI+7fGKoPaZzl4kdJRKZ0b+xp8xbXzzW+SvnAbh6eltGjqZymr+i+G2+TahbV5MpRy99WxSNlwqLgPLxm141a4GYAZ11CttiPGAf9e/6HQIAnwCsa5ZVF/JWnqGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310325; c=relaxed/simple;
	bh=vLDgiBBZd58h0T0ReKqdykl5DlgchHSnpVYqQ6ykqu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihzvpoow4fIXQPGWSBxFcTjy1LhnizQgG3ITht5gYlD6t0XkGXKhF2P4l4rxIOgmmS2+IzLAzVTScJRpDgP3qvsRWSZKffVwClugJyVB9wVs6KI25D5IAp8tcZ9HZ9EhJRQ+s/gYCuXvTWk+fFuzSmF3UphKkdnuj1mBsPTmPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1gkYkqP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1gkYkqP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b0601ff3d9so12983725ad.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310323; x=1774915123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw5NKF4E66vyohb8n/pa3diZrC0/+CJM8Skon/TvWYk=;
        b=F1gkYkqPc+XdbjhbEZ9eztV6hD5/Rd6mu4MK2/mGOdF+e97YHQIKpaKbenq82XSibi
         RxDRMPgvRENeXLq8GmvoRQPUY73un6Q/Fcb/sJsjhgH/imGRygfZsL60y0maJPtIeF9u
         iS1QzMZ7xzBL/tHsROAf+j7U9GqftIp/slvyx/m+U1Y1cfIg+CDuK+N5P4oseShqs65J
         uvSFfTzxUi0u8H3qaymMi6nT8dOdWM43zYNyCHhlKvPimNxhJ85Vbg97BjS8V/7BHz0s
         U49yfXPQO4CN5glC9UZFv+4lb3mMMX3RdXiFliIpkWXKJ4aU5ejVeZlOyQdobWqwEM4F
         wwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310323; x=1774915123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw5NKF4E66vyohb8n/pa3diZrC0/+CJM8Skon/TvWYk=;
        b=aSpNwUM/jIG4IUG9oN/2vBkaDI7kggpuRYd3cO1KT6Ja0CVMjBRQEwtc/U7sw7MPXN
         unC5uzyO395XQntXjUe8DcTNZro+IqG3dP7dnESAV5qv5ZKq3gSo6eZhZVfZZCjJkHNd
         7ggvIbuOqJ9PDZkLoD0W0CcedGQpv0njxj7ibX2F/IQaElOcwwmlIzQDuEayN4xunH16
         Y37wQLbuiy5KOXjADEJybJBZuJtP+XF0/TqpYjqiRDdUST2LGnXDGkaGZboB8uPfRR7f
         4xsJoXNo1rh1hVW4j29OtfsO6dBmIfuZEROCQCAYG79I3aZMTiIGW/eYrZHpbKrr2M4u
         K4pg==
X-Forwarded-Encrypted: i=1; AJvYcCU8mizKoB1CT01lrG/ujDXipA5MzNLxmpKjU7w+bkrfM3CJX9fMDBHaXrtFH0l/OCl1J0BB8RK5gP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3oaihnL8C6OZ0L1D6dIk52K8yUBp3k8h4mJiJAn0YOn+BBga
	BHojISHlZGjWlgnSL7nKbRIGfZLW9exbkCaZ2ydfMobShAfYonWyhTCj5+eJ8XDcG1lEnzvZYoT
	qsv2LzOuhAIPaQw==
X-Received: from plar5.prod.google.com ([2002:a17:902:c7c5:b0:2b0:5a1f:4fdf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d507:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2b0825e35e3mr130027435ad.0.1774310322445;
 Mon, 23 Mar 2026 16:58:42 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:55 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-4-dmatlack@google.com>
Subject: [PATCH v3 03/24] PCI: Require Live Update preserved devices are in
 singleton iommu_groups
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

Require that Live Update preserved devices are in singleton iommu_groups
during preservation (outgoing kernel) and retrieval (incoming kernel).

PCI devices preserved across Live Update will be allowed to perform
memory transactions throughout the Live Update. Thus IOMMU groups for
preserved devices must remain fixed. Since all current use cases for
Live Update are for PCI devices in singleton iommu_groups, require that
as a starting point. This avoids the complexity of needing to enforce
arbitrary iommu_group topologies while still allowing all current use
cases.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index bec7b3500057..a3dbe06650ff 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -75,6 +75,8 @@
  *
  *  * The device must not be a Physical Function (PF).
  *
+ *  * The device must be the only device in its IOMMU group.
+ *
  * Preservation Behavior
  * =====================
  *
@@ -105,6 +107,7 @@
 
 #include <linux/bsearch.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
@@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
 	ser->nr_devices--;
 }
 
+static int count_devices(struct device *dev, void *__nr_devices)
+{
+	(*(int *)__nr_devices)++;
+	return 0;
+}
+
+static int pci_liveupdate_validate_iommu_group(struct pci_dev *dev)
+{
+	struct iommu_group *group;
+	int nr_devices = 0;
+
+	group = iommu_group_get(&dev->dev);
+	if (group) {
+		iommu_group_for_each_dev(group, &nr_devices, count_devices);
+		iommu_group_put(group);
+	}
+
+	if (nr_devices != 1) {
+		pci_warn(dev, "Live Update preserved devices must be in singleton iommu groups!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
@@ -232,6 +260,10 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (dev->is_virtfn || dev->is_physfn)
 		return -EINVAL;
 
+	ret = pci_liveupdate_validate_iommu_group(dev);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&pci_flb_outgoing_lock);
 
 	if (dev->liveupdate_outgoing)
@@ -357,7 +389,7 @@ int pci_liveupdate_retrieve(struct pci_dev *dev)
 	if (!dev->liveupdate_incoming)
 		return -EINVAL;
 
-	return 0;
+	return pci_liveupdate_validate_iommu_group(dev);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_retrieve);
 
-- 
2.53.0.983.g0bb29b3bc5-goog

