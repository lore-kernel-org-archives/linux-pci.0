Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9003B1EFC
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528131; cv=none; b=SRcpaS5UOS3e6LmxdwRlu1X+q9CP5g9Tv3U7u1IyaSJXhjw+6cGaQ9TvPNmm1kvRBPtNHxk3kqi1TDiyrGuqJ3IO3/yD0ZPgMcnpVVIxgfqpcW+Z4z+LLC0ueQzd/g8vE/EI0JeOVZsbk802BffmWGpkMwDAcKqLGVf0Z8zkgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528131; c=relaxed/simple;
	bh=/lIKUXJLz2UQHUvF+Hmo7XzpSNQsesH7USAI7l2sM+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlN5viurdnnBgDGe7VJS/oYnF6qYZ7bnnXfTAXa0yD/LA4XsoCWsYu0mJYpy9sYf5oKQvYiTkD3jjmgYxUN0FLPZ7btmwtIfZAuhjZYDLUiP/xyiCt/XNHEmBqpA9Y98w2lLUMoDIV7kjHHxF73B06oUrR8oQ3/O9GlgXN6iqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArXt0ZFf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArXt0ZFf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffe817151so4639725e9.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528128; x=1791132928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=ArXt0ZFfndHw5l6w43PdZolyc3ctkZna2wcdEjysFNa4jIqcDpWvNyF43lUNgim7xF
         6eEIl8xHm0/ayAYbX3uJyhtThuDYIoCamJ63Sh4u89Ie92nKRbZ6RiJo+ucet5793cCD
         n7T3TYRdoTr+JPLY13NDTalZjYakwK3YNOGJUOojhxI0n+h3vOx1fhPRcHfCKO5Opi/f
         LK+xZsM0GqfULegWnAJrhWaWddQE1ximQSzcdSnG7eid/6nS7MQ/x4yW8gKLXDQ4pSkH
         sXRfsRNr8/uc2Qi19WdXBqB+NeFsAJmOrt4r8XMp75F8UW1R7CX3xGy/03I0Y98ptNkP
         AWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528128; x=1791132928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ym1diEOibk5xps77zZysxQ1bh4AhoR+8AInugu/q9zA=;
        b=M0Inf/LWEANof0Z1gJZHWrR+aTUA+p0OO8ZtX4wqI+bWbfhKOXPEJsoO5FOihcxP99
         1aPdrrYkLC4fXF1MoYR7+xyEpXzzpaChhUOuNl32GJ7OzuwDLxQ/Q2YE9ddXCLx1g9cC
         6lXau9uZzRqGJOX+4z/BMC5cMVG5dd4NyEohCBvxdKqMQj7/8RIx0a4aob7BSXWxDv1T
         TB4fxHMZw3I8fTsv7p1X+blkrk3i0zS0ivpVpIJpe/W20QgcO+bZ7ObVJwFuMSB2oZVh
         pulP2hTLzC5ksMSR+rne6DNedirbxDIu+2ZF1OCPI763ak8xIaKS7WeubYV/YyMmauVh
         PkFw==
X-Forwarded-Encrypted: i=1; AKwUvBy3+nVq3TejAeH40hDvq+v0KC822jWRmTJ4FmO3SrslFiPKpmSvvrKJz+6e/c9Nq+z5E1+8hwcPU5w=@vger.kernel.org
X-Gm-Message-State: AFuF++kBKqaiWpaCIMNJDr9UH8iYXhAhWmcSTmB97/uMhYJE+3s40h8A
	W1k7sClNu3x3EBDY9LZ3iiIh0iYlSiYsveJzTTl1XPYV/p3MU8OSzsRS
X-Gm-Gg: AYBFou3pz3xWnOGBwW6goCPsOxMG1Fi3El5F0hhXBEVQK68dAZ+041LnfOkm+UN/O0/
	K/UbHp46uXb1UjFM0XK572dEH+CPh9UgFzuLAcQdNTXW0Ctf8DTLfk25TkQTH0X0TBlZXl4HE0b
	qOJupU8cjTh/Af3ehzWPHUkWucLZH8HwKnAEe+8geI8jCDJA7BKlwIxp5Q5dB4c7WBorCgpIXL8
	mZYlwUURiI+NDk9EsjHb0ZtJOhYZcDFhjJdKrKlj0tH55GJoCWptBjTejzzda2hBKoLt598k42D
	K/29lIAm2dWDIiOgvOnqhANrsBtKmmMsT/Vaz2SIrO2OXqSQgypQD3H4CZruy4rrtyCsXQuR+O2
	W5poMNvvNCUPVzAMSKkVQPyTlsM7kg9odf51vIbVm7m2GxKcQ9+hbB9w3Y2LJy5yXpFzrDNuEN4
	dCd2PQsKv4VbcUyelLUYTu5u1q3U2F7bvmbM1l3HK74pRIvX0++EKtiy5aY6fKGJO418W45PtIG
	yUfbh9L8REPYcGPEj1MUlNERo8PtD8zTZNk+va7mYi+jPuuoGmdUNBgMHRmRRA/w99M65RtugIN
	Cw==
X-Received: by 2002:a05:600c:1c21:b0:4a0:2dd:7573 with SMTP id 5b1f17b1804b1-4a002dd77demr29968615e9.33.1790528127654;
        Sun, 27 Sep 2026 09:55:27 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:27 -0700 (PDT)
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
Subject: [PATCH RFC v2 4/5] PCI: pciehp: Report surprise removal from pciehp_isr()
Date: Sun, 27 Sep 2026 16:54:57 +0000
Message-ID: <20260927165459.829900-5-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
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
arrives and neither Presence Detect State nor Data Link Layer Link
Active indicates that a card is present.
This provides us a pathway to wait/block/sleep as we will not be
in pciehp_isr().

In pciehp_disconnect_work(), wait for the DPC recovery or SBR to complete
before checking presence and not consume the link change flags, so that
pciehp_ist() can still see them and ignore the link change if it was
caused by a DPC or SBR. Even after the DPC or SBR has completed, if the
device is really gone then pciehp_disconnect_work() will see that and
report the surprise removal. Like pciehp_ist(), it holds a runtime PM
reference on the port and checks presence under reset_lock, since a
slot reset may make Presence Detect State and Link Active flap.

Link: https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM

---
Changes since RFC v1:
- Drop schedule_notification_work(). pci_dev_set_disconnected() schedules
  the driver's disconnect_work again, as in patch 1, for all callers, and
  pciehp_disconnect_work() calls it through pci_walk_bus(). (Michael)
- Return early from pciehp_disconnect_work() if pending_events is zero.
  pciehp_ist() has then already taken the events and handles them itself.
  (Sashiko)
- Treat a read error of the presence check as "not present", both when
  scheduling the work in pciehp_isr() and when checking presence in
  pciehp_disconnect_work(). (Sashiko)
- Check presence with pciehp_card_present_or_link_active(), as
  pciehp_ist() does, so that a port with Presence Detect State hardwired
  to zero is not mistaken for an empty slot.
- In pciehp_isr(), check presence before dropping the runtime PM
  reference on the port's parent.  In pciehp_disconnect_work(), take a
  runtime PM reference and check presence under reset_lock.
- Don't call the spurious link change test from pciehp_disconnect_work().
  It consumes the one-shot flags PCI_DPC_RECOVERED and PCI_LINK_CHANGED,
  so pciehp_ist() could miss them and tear down a device that was only
  reset. Await DPC recovery and Secondary Bus Reset with the new
  pci_dpc_wait_recovery() and pci_hp_wait_link_change() (patches 2 and 3)
  instead, without consuming the flags. pciehp_is_spurious_link_change()
  is dropped and pciehp_ist() is unchanged. (Sashiko)

RFC v1: https://lore.kernel.org/all/20260905183905.997833-3-abhinjoses@gmail.com/
Michael's review: https://lore.kernel.org/all/20260912115420-mutt-send-email-mst@kernel.org/
Sashiko review: https://lore.kernel.org/all/20260905185217.E9BC21F00A3A@smtp.kernel.org/
---
 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..c8ceb9320e2e9 100644
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
index 4c62140a3cb44..470cc16d4a828 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,12 +620,64 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	up_read(&ctrl->reset_lock);
 }
 
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
+	int present;
+
+	events = atomic_read(&ctrl->pending_events);
+
+	/*
+	 * Zero means pciehp_ist() has already consumed the events with
+	 * atomic_xchg() and is handling them itself, with the full event
+	 * mask available for the spurious link change test.  Leave it to
+	 * the IRQ thread: acting here would override its decision, and a
+	 * zero carries no information about the device.
+	 *
+	 * The events only stay pending for us when the IRQ thread is
+	 * blocked and cannot drain them, e.g. in pciehp_unconfigure_device()
+	 * during a safe removal.  That is the case this work item exists
+	 * for.
+	 */
+	if (!events)
+		return;
+
+	pci_config_pm_runtime_get(pdev);
+
+	/* Wait for DPC recovery or a SBR to complete */
+	pci_dpc_wait_recovery(pdev);
+	pci_hp_wait_link_change(pdev);
+
+	/* Presence Detect State and Link Active may flap during a slot reset */
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	present = pciehp_card_present_or_link_active(ctrl);
+	up_read(&ctrl->reset_lock);
+
+	pci_config_pm_runtime_put(pdev);
+
+	bus = ctrl->pcie->port->subordinate;
+
+	/* The card may have returned */
+	if (!bus || present > 0)
+		return;
+
+	pci_walk_bus(bus, pci_dev_set_disconnected, NULL);
+}
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct device *parent = pdev->dev.parent;
 	u16 status, events = 0;
+	int present = 1;
 
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -697,6 +749,14 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
+
+	/*
+	 * Check presence while the port is kept accessible.  This may race
+	 * with a slot reset, so pciehp_disconnect_work() checks again.
+	 */
+	if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+		present = pciehp_card_present_or_link_active(ctrl);
+
 	if (parent)
 		pm_runtime_put(parent);
 
@@ -722,6 +782,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	/* The card may be gone, let process context decide */
+	if (present <= 0)
+		schedule_work(&ctrl->disconnect_work);
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -1036,6 +1101,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	INIT_WORK(&ctrl->disconnect_work, pciehp_disconnect_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -1096,6 +1162,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	cancel_work_sync(&ctrl->disconnect_work);
 	kfree(ctrl);
 }
 
-- 
2.51.1

