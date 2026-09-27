Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBF3BB9E1
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531534; cv=none; b=oFId+v8eJmx9nysK4QEZKHNqbSLXIjnYI5ZEpIl3FA6lF/PxulH80ZiEN2FxHHIyLKexCSG0+hqXsFKAMCgneVTPn2mQoZAY29PCaAmEKOSjqDphdb5Cuz9SKndMNaXludjwc3xhxIwHsEGHaPsTN7N3zlC6KDhgxLnmdURvDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531534; c=relaxed/simple;
	bh=mMwi/NfTduz/j9ghsttpZUHmM50236YObntODgocA60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3bywE7ObChAjlMmm842PbSk8Bu+4e0jGm5RCIWafD9inFyBe5oh10QQtLze9LMqOusoDiksifDhuZvs7y6ORQ7EHY031JhLM02lxhtJTfdGaMljpbyGQk8k7QrAtfl06RBFKt2K4FTZY9AG9K/FjiKpIrQnpxHFq35SXVNxe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+Q6R4It; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Q6R4It"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso8032025e9.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531531; x=1791136331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=E+Q6R4Itv2cU/qOBmnTH9gWPZnPzKDpuD3y7rX4jpqLS6iUkCAvz0g9y9rnQzweMpN
         id0Y7K7mhi/6ebg4RVtRyLp7oHJwECbOUmEs+FyCQg05uWzNpERZZzFS3HUdEeD0rMqb
         HK56JvO5W0yBLtJxPmBA5m6XLs/A+nrwo8ORoaDUABiqOHk1TxW+0WCDAVpGtjiep50I
         oHmuN/FB78FHFotQycoxwJu1LJZBgvdL1qtMX2qX8uIV65npeJ6LqPnGPRT7w3Er2PB5
         8mnXPa1yNdUiOn5LuKySqijVngq+sfCU+0srXeFBeRyGIYVPaV5PqApT7A+a1kqsxAHS
         U7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531531; x=1791136331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuN5+KumXzfDF7N5B1L0sRY32M0tbe03+VKPfAOnEmE=;
        b=G/P9YegBmjN8YeL6PgEMEQkc/Io4oIyDeO2+QkYgr4WO0hzRzs2vLQaKkNmQzOX0De
         wBcePiCON6DfTtlJCBcToXZXZOW5ti0PeIMwgu8w1mllc88wQAu5/yHUUxxc6CqySKuN
         OQ9gafsM2tuEi/KFtqEKMK8rU8mlLC74Ad6j1/KfE59+qa7M/qtq+50+w5xjcTsh2pfu
         njXMIVyrBXDAzKVzDOvRwPp/v6pk4EyQ7LONQucWdrLCdDwurXWLgMWyzowGKhaVCSYO
         KbXcQ+XOuoilDB5PCF7muvlbC/BdQaoRDFIiqAh1gHu8H20d6QFOPD74M0OqUxhUBtuN
         izYA==
X-Forwarded-Encrypted: i=1; AKwUvBwFeoYhGrp2eEAr/17HfLDTbSge6vPv/yzvWZkKEarmtwHEflWqBG07w+Gd7IlW/+5wSwtvMK0seD4=@vger.kernel.org
X-Gm-Message-State: AFuF++nwShr9FKvQtx3E+gIByjPcHgHZk6tEmJlewH9QsL5ed/LFMecU
	Rn5ut6YZRKqLsbQqzpMOjQS4ZGs6s4BX43MKg/ZcgMLHd7czgkv1yaYc
X-Gm-Gg: AYBFou2hQKvStaCgr6NmusRCaVlPuHHtJER743Jh2DmSuNbWBUc+eNrJmf+xWdawKTV
	MG6/rCa7mT9R7hZG8dun0t+hbAsk7K4iGTeDpIZIElcyYrl5c5xnKbJPTK53JxTv1PGrd0YK6mi
	lFR6b/lbjSQg5iqtjif4kY4exXxXNqYrBgFkdbgIwL0ZPsSH1gsSypoP6IIOZmfUhj0cwcJkIE5
	ZA8ixNrrujbEjF+BRVzt4mS99lc9XcKpxbyRwcv9qLd1ILhMbmNMHy+zKmJHRh1B5zXCMbhdxlI
	ff4VDg1f0Rb76UjzLBXbG95P308cz1bUhGdptr1J225cZCVJ3Ljc5NDky8LRly4C/ObJ4X8pU8C
	EZmCW6CJcUUhH1nAcDg3kM7FI5SPWEJrmfT5+U7ZfBAcOzd3VxDMnirTfVWoVSPNomO95ZtEKGj
	tAAYfPhdYsxn3X/K8oyJ4ESPm2yb1Koe7eb+Li1CZEi2kLpzBBBu6+1LRY7VoV7LAMqUMRDsRIc
	NfEbu5DtP7pQZKVKfQdxLyX0nOd0l+Q0mPB7C3hYdCCmyocuf9atvKeZ00bx32k9mk=
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49fe66d8135mr188402975e9.20.1790531530505;
        Sun, 27 Sep 2026 10:52:10 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:10 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v3 1/5] PCI: Report surprise removal event
Date: Sun, 27 Sep 2026 17:51:58 +0000
Message-ID: <20260927175203.928270-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927175203.928270-1-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Michael S. Tsirkin" <mst@redhat.com>

At the moment, in case of a surprise removal, the regular remove
callback is invoked, exclusively.  This works well, because mostly,
the cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup
and is now waiting for an interrupt from the device. If the device is
now surprise-removed, that never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

	1. the graceful removal is ongoing in the remove() callback,
	    where disk deletion del_gendisk() is ongoing, which waits
	    for the requests to complete,

	2. Now few requests are yet to complete, and surprise removal
	    started.

	    At this point, virtio block driver will not get notified by
	   the driver core layer, because it is likely serializing
	   remove() happening by +user/driver unload and PCI hotplug
	   driver-initiated device removal.  So vblk driver doesn't
	   know that device is removed, block layer is waiting for
	   requests completions to arrive which it never gets.
	   So del_gendisk() gets stuck.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that
the device is inactive.

Since cleanups can take a long time, this takes an approach of a work
struct that the driver initiates and enables on probe, and tears down on
remove.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/all/fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com/
[Abhin: adapted subject, serialize with a per-device spinlock]
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

---
Changes since RFC v2:
- Protect disconnect_work_enable with a per-device spinlock, held while
  testing it and scheduling the work, instead of lockless accesses and
  barriers.  pci_dev_set_disconnected() could otherwise test the flag,
  get preempted, and queue the work while a newly bound driver
  re-initializes it.  With the lock, cancel_work_sync() is sufficient
  again, so go back to it from disable_work_sync(). (Sashiko)

Changes since RFC v1:
- Use disable_work_sync() instead of cancel_work_sync() in
  pci_clear_disconnect_work() as schedule_work() on a
  disabled work item is a no-op. (Sashiko)

RFC v2: https://lore.kernel.org/all/20260927165459.829900-2-abhinjoses@gmail.com/
Sashiko review of v2: https://lore.kernel.org/all/20260927170707.6F9241F000FF@smtp.kernel.org/
RFC v1: https://lore.kernel.org/all/20260905183905.997833-2-abhinjoses@gmail.com/
Sashiko review of v1: https://lore.kernel.org/all/20260905184649.E8F621F00A3A@smtp.kernel.org/
---
 drivers/pci/pci.h   |  7 ++++++
 drivers/pci/probe.c |  1 +
 include/linux/pci.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc23..175273756c183 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -802,9 +802,16 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
+	unsigned long flags;
+
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	spin_lock_irqsave(&dev->disconnect_lock, flags);
+	if (dev->disconnect_work_enable)
+		schedule_work(&dev->disconnect_work);
+	spin_unlock_irqrestore(&dev->disconnect_lock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..3a05ad32bfd54 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2515,6 +2515,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	};
 
 	spin_lock_init(&dev->pcie_cap_lock);
+	spin_lock_init(&dev->disconnect_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1ef..aed62ae709f59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,6 +592,10 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 	struct gpio_desc *wake;		/* WAKE# GPIO */
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	spinlock_t disconnect_lock;	/* Protects disconnect_work_enable */
+	struct work_struct disconnect_work;
 
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
@@ -2123,6 +2127,59 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	unsigned long flags;
+	bool enabled;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	enabled = pdev->disconnect_work_enable;
+	pdev->disconnect_work_enable = 0x0;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	return enabled;
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	pdev->disconnect_work_enable = 0x1;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	/* check the device did not go away meanwhile. */
+	if (pci_device_is_present(pdev))
+		return;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	if (pdev->disconnect_work_enable)
+		schedule_work(&pdev->disconnect_work);
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->disconnect_lock, flags);
+	pdev->disconnect_work_enable = 0x0;
+	spin_unlock_irqrestore(&pdev->disconnect_lock, flags);
+
+	/* No one can queue the work any more; wait for a queued or running one */
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 bool pci_suspend_retains_context(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI is not enabled */
-- 
2.51.1

