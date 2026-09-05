Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1A4F053A
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633566; cv=none; b=s8dgQP86wAESxVLhpLgedyZUU82iZG7ke9unvq+XNhgC4gqSkYpUpBBveA/ky0Q0pSiBVIQw8PNG19ReaGLIAhBsWHt7lFL+E6ZOattnjuayKH/fB2eliLwFUiEAGlB9q8OScSFLhcSUCvJpK3yjsioyA5rL0kPnJWm4sbD1nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633566; c=relaxed/simple;
	bh=2YluIy60Jfzmukqkh5yOQvfMAun1hVRGK+XOEjZhVsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWpAUB4rzEDB4jWUuYhnhZTwowjZgQVytco36zNfMUHrdwYfZTHdVa32ti+rnVa/hpJ3hwGXmj0ntGM0pHEtamI8kY9tMQwf+iefEvcy3X9IFGla5WD92FdlgtRyYJA3F9pI+tCHdcvNnBmmgYpX1cWoxk5rcgO0kU7mHD4waGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLz6LIxb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLz6LIxb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485888b3c3dso2218051f8f.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788633563; x=1789238363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0q/PhqzpPPYuw5I7NOI37oNV5qDMBKzDX3eeEPIj9k=;
        b=KLz6LIxbRakntqO5V2uMN+MjCp/PT0SkGjrF/WegNNP+dwIlC5SrSc7eWmgc0ZSJ+f
         UaLOSXLpT21iEwTw/HQcnXotfnTfIUmu4q3Bu4LhhfBqzSL3D5nGxceYn6Aw14nWlPab
         3YdtPPdBj0VSEv5gTLuJyB+wq+xQUGWGIQk4IoQBH6HX2Gxe67zytz5WOSRg9qlZMNAE
         q5TLzZDK9v3+XLEtfI29n/+bVHl7D+4aoOy7NYy4FrlE9y3pd+9admpi/H97DpqpyamP
         45dAtFa/Qd6IqCRcIZP7HcB38R5nt3U7tNIMO6qDpcCMtMZfvuirIDNXV6PAP7kG6Dzx
         u1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633563; x=1789238363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x0q/PhqzpPPYuw5I7NOI37oNV5qDMBKzDX3eeEPIj9k=;
        b=LHXfmp/97D6jZQuOY0YvTUi8e/GsP6SOERvBiWilR+9GKtay8NPRyC1euNWhVtMcEj
         hu+gUWFipZitx5pD+3p6mOGEYvIap1uycyER1EKsv14R5Fz/TsN2DzbM64jeR7Ck+tfF
         fNGhD0inycLuRRsj+x4iMlSCZgyHhpolpRO/upQEaz+G+rQ5tefSYtutcWgSszwoa4MR
         MRS5FVICx4SPTiBKgEf9bolfvJdazmDZnPFEkm2AuEjCYEVUJ95YjhHmp+ktpAymnMBA
         m18+fS1NRNxjl/AB83VyaZzbn7sDuwNx4ncqpRkAj0fVj4YpDyE5GtZiX04oD2wrLheZ
         YerA==
X-Gm-Message-State: AFuF++nV23Pszt0LmtgEqznQzllfdNBdb4wTXFzKoo80dEUf/2PlvuiI
	jYrBFdHwe3iKeYOJp6ib/cxpvobEtcyB/q4WalgRMmVIXyq0Ri2jfngv
X-Gm-Gg: AYBFou1nrAEpOEfYzJDK82H+CEQJgdk2sX2zP7Uxcqwn9ur8ZnOprW4LGnv7FsqNqoc
	coQ1zA5WsmDfeXSwN/TSxmzhyR7oySKXo45hd7y4/UsI14CIvHAYKsFH81ujySu2gaqfgmZnYh0
	IOqj6UWGyM5VpeJ83xQLiTq6AYcRWSM5qpspLsbxNiXjgR66oZS462olujCidAfmVGdPz8UFGZX
	baPNtiwqR08mxIGZJ0w5G0PtJUIQeZpW5r9bn02YA/mQNTDnGXTRscznhkkaEkiUWB7HfTraLGt
	uJpWgRuGFz7boSzaMboSxV7HF6FxSrJRqAHRn1F/r1+dsZiCaqxbQ21SCPc+8VXxIg6DxEpLc4N
	91RmDkRfX8UptckLAI42W30h/JjG2jLKfTs5OuDVcWjzmbJ7Pp736VJlpabEA044EZBMW5sXrK2
	FhxsXEsrnBxyFfiHtNws4Aj6Ues1jWVlCHDYlUTN94F62muBAwlK7fT8So908CGHhQwnmJo4JDC
	A==
X-Received: by 2002:adf:e19e:0:b0:485:8c16:5eef with SMTP id ffacd0b85a97d-4858c166088mr10620207f8f.41.1788633562541;
        Sat, 05 Sep 2026 11:39:22 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box ([2.210.128.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm16333603f8f.34.2026.09.05.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:39:21 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: bhelgaas@google.com,
	lukas@wunner.de,
	mst@redhat.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kees@kernel.org,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 1/3] PCI: Report surprise removal event
Date: Sat,  5 Sep 2026 18:38:58 +0000
Message-ID: <20260905183905.997833-2-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260905183905.997833-1-abhinjoses@gmail.com>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
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
[Abhin: adapted commit message subject]
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..23b1605e783a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	if (READ_ONCE(dev->disconnect_work_enable)) {
+		/* Make sure work is up to date. */
+		smp_rmb();
+		schedule_work(&dev->disconnect_work);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..06d43f57f509 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -592,6 +592,9 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 	struct gpio_desc *wake;		/* WAKE# GPIO */
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
 
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
@@ -2123,6 +2126,48 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	u8 enable = 0x1;
+	u8 disable = 0x0;
+
+	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+
+	/* check the device did not go away meanwhile. */
+	mb();
+
+	if (!pci_device_is_present(pdev))
+		schedule_work(&pdev->disconnect_work);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
+
+	/* Make sure to stop using work from now on. */
+	smp_wmb();
+
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 bool pci_suspend_retains_context(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI is not enabled */
-- 
2.51.1

