Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84484F053A
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633570; cv=none; b=C09PdVjEmovZ6CvenSjK7i1ELsn2nwpTWFhAGlaVVeYZn05iGGR6AL6FK37qAOZRY0xCtb6CludOjocm3aOmQFBRj9Nfr0Ba2LL2HmYzf17q2hFThZB1oTZLdNY0s+JmzxNV8e/tItAZCs6Qryv9eYVPvOJjFXdWRON4AaTbjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633570; c=relaxed/simple;
	bh=zqM1Egd1H5DgF8rBBGGCJB+/hNj9dNxjE7s90jsaat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h60J3VQTDs74kAt/S/VlZEbE4+/sBftTesAM8crk1iOXk5soOy/6mrVUDr8s5It23VPfNFA8mIpHBogWhQmqHbbJ1wnkjpRrAyF7a7buDHS/3O61y+ukerl9irEOxMH+U6Qw9oPlj/HkBNA8PfD/L1WCtHwsQWmJdy9jZxMSnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/ZZps0P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/ZZps0P"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48436251906so2390377f8f.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788633567; x=1789238367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTWignQfEmN2SpuJ74uFQJg2JrONtVT7vSQ7KAxjdQM=;
        b=V/ZZps0Pldu+bLFyEb8oKRl2mt/+9o9n3n8oqTUR1rJPSwodQmyg9/s1Zfb4xtjMoW
         dyW+FaMx5IZhqw00gwgNQhGo8rpM3LlCg2yB0YWxMm/XOteq2csIuNn+WHH8QQy+1adG
         uD0O6reEPQOdCsnPZclnEiXRlvbWmgLUCWtbN29KlAqCazDBjoUWC1A4wjyXN54c+jJd
         osF+1uQXv7plGnrUwA6dDpkud4tBU4xit7o6UPd08D/WwKdM80BNiiNWb6V3JEGVeQwP
         q4ZkzCdLSDo3hgTq3Ktc8cR+ShBT2Y+eCf+2hj4N/rE2QhE+8dbkI6t8i+gWxsXpxT4R
         fHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633567; x=1789238367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JTWignQfEmN2SpuJ74uFQJg2JrONtVT7vSQ7KAxjdQM=;
        b=iGpNh6nwgo3r9K2qTU/AtaJKl7nAb8XtIBo2LzNvQ8sKEoRZgz/5AU0gzwBQ4pxqi/
         1ivoRJYteXy+qMYRJfZM/qxloiz72dIDQXEVUXTCkh6aho2ckAOx5RoUY9cYWGpWNddg
         UDHmTtIdzpNQfMcXs7A8E9Px+zh/IUtyYdYTkz4ZoRbMfr2OcZz4qykkG7qMIQdKTrKI
         EjPfm6xlor0UhzNgzXjPVcTySAsk0/LvHIYK5/cHEwNgx+ol8Q1y8O7eJ0mm2AKT9G9b
         QIlaxmjbaK35nBVG0sItIIuyfni4/zMc0wF5HOKIOEI4ChL2OyxggRWoXE8+oZ7XCWWB
         pzOA==
X-Gm-Message-State: AFuF++lw8QAQL8NDhCuYc9oMdH1jtFuq2WIAVS/FtC0MkrviOBo3ClMO
	YE/FBh983IkBiVWjMz/llOArq9IFIEKIYOW60vWCCQW2qfyOIwSwJyEG
X-Gm-Gg: AYBFou17q2m3Gtq/XMN5uKSvTc0LHeGTldy0t7C+JEMGbktowN8tB0fGdbC87CYDVhE
	+qJBV9X6Zuuadu66vtHPR1XcPZwKdppzkEx9u/5Jsc6aamChp8B/0WbF5ep1uYw3FBgkulUpVxi
	sNB0Tt0fEUmo6od5xf8MfA/tVnHC6wO4FgS35HUHUmu9w5VKzF2nBxobjQ9O35SywoONgHrjsfK
	/4H6n3ogU4Ao862HG7u2s6kahBSsGfxedk5RGH3eiBo1Inf9nBIndGu2vMqqGjsWJynHuaaVHhn
	dgm91dpawWjtjB0TuYIiJm/UPaPXuUeMxks+FVK0VeCPhQoJhLhDZuQtB7Y+vvHp2UGGcrKAlsi
	dCNCgCf02O8dyZzxDBElhgtvTQpQKIAFGbF5tsZKqKWWnw6VaM/bBXrj5GQ5AneVHrLgav2JGvU
	dVS8W30T/JB5ooZgb2DOj1M00Ee9u4ZlUQLJ/zEHOyyCNAiGgf2HVGjepmt7d/pxZGysAlASt7W
	A==
X-Received: by 2002:a05:6000:18a8:b0:482:ea08:8c8a with SMTP id ffacd0b85a97d-48587090294mr25391012f8f.20.1788633566813;
        Sat, 05 Sep 2026 11:39:26 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box ([2.210.128.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm16333603f8f.34.2026.09.05.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:39:25 -0700 (PDT)
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
Subject: [PATCH RFC 2/3] PCI: pciehp: Report surprise removal from pciehp_isr()
Date: Sat,  5 Sep 2026 18:38:59 +0000
Message-ID: <20260905183905.997833-3-abhinjoses@gmail.com>
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

A surprise removal during a safe removal cannot be reported: the
removal blocks waiting on a device interrupt or status read, and the
single-threaded IRQ thread is itself executing that removal, so it
cannot report that the device is gone. The removal hangs.

The hardirq handler pciehp_isr() still runs while the IRQ thread is
blocked, so it can report the disconnect. However, pciehp_ist()
deliberately ignores link and presence changes caused by a Secondary
Bus Reset or Downstream Port Containment, where the device is only
temporarily inaccessible. Distinguishing those normally requires
waiting for the SBR or DPC to conclude, which takes seconds and is not
possible in hardirq context.

Schedule a work item from pciehp_isr() when a PDC or DLLSC event
arrives and PDS indicates if the device is connected/disconnected.
This provides us a pathway to wait/block/sleep as we will not be
in pciehp_isr().

Move the scheduling of the driver's disconnect notification out of
pci_dev_set_disconnected() into schedule_notification_work() so it can
be invoked from the new work item. Factor the spurious link change
test out of pciehp_ist() into pciehp_is_spurious_link_change() so both
pciehp_ist() and pciehp_disconnect_work() can use it.

Link: https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 56 +++++++++++++++++++++++++++-----
 drivers/pci/pci.h                |  6 ++++
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..c8ceb9320e2e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -116,6 +116,7 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+	struct work_struct disconnect_work;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..235ca8a176f1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,6 +620,45 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	up_read(&ctrl->reset_lock);
 }
 
+/*
+ * Link Down/Up events caused by Downstream Port Containment if recovery
+ * succeeded, or caused by Secondary Bus Reset, suspend to D3cold, firmware
+ * update, FPGA reconfiguration, etc. are spurious and should be ignored.
+ */
+static bool pciehp_is_spurious_link_change(struct controller *ctrl,
+						  struct pci_dev *pdev,
+						  u32 events)
+{
+	return (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+		(pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
+		ctrl->state == ON_STATE;
+}
+
+/*
+ * Workaround to not wait in the isr.
+ */
+static void pciehp_disconnect_work(struct work_struct *work)
+{
+	struct pci_bus *bus;
+	struct controller *ctrl = container_of(work, struct controller,
+					       disconnect_work);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u32 events;
+
+	events = atomic_read(&ctrl->pending_events);
+
+	if (pciehp_is_spurious_link_change(ctrl, pdev, events))
+		return;
+
+	bus = ctrl->pcie->port->subordinate;
+
+	/* The card may have returned */
+	if (!bus || pciehp_card_present(ctrl) != 0)
+		return;
+
+	pci_walk_bus(bus, schedule_notification_work, NULL);
+}
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
@@ -722,6 +761,12 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	/* presence change events */
+	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+	    !pciehp_card_present(ctrl))
+		schedule_work(&ctrl->disconnect_work);
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -761,14 +806,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 				      PCI_EXP_SLTCTL_ATTN_IND_ON);
 	}
 
-	/*
-	 * Ignore Link Down/Up events caused by Downstream Port Containment
-	 * if recovery succeeded, or caused by Secondary Bus Reset,
-	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
-	 */
-	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
-	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
-	    ctrl->state == ON_STATE) {
+	if (pciehp_is_spurious_link_change(ctrl, pdev, events)) {
 		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
 
 		if (!ctrl->inband_presence_disabled)
@@ -1036,6 +1074,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	INIT_WORK(&ctrl->disconnect_work, pciehp_disconnect_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -1096,6 +1135,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	cancel_work_sync(&ctrl->disconnect_work);
 	kfree(ctrl);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 23b1605e783a..4e17878edeab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	return 0;
+}
+
+static inline int schedule_notification_work(struct pci_dev *dev, void *unused)
+{
+	pci_dev_set_disconnected(dev, NULL);
 	if (READ_ONCE(dev->disconnect_work_enable)) {
 		/* Make sure work is up to date. */
 		smp_rmb();
-- 
2.51.1

