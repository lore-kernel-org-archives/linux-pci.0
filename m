Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284037E317
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510114; cv=none; b=fEMIZm7+j2DR7mZWk6e0ZGyevttWj0ir6XRhFHOd3nIPSiug4z/oqTAzTOoMTJgeFHOZ8Tt1ZwbL8GMLgeYICdhk+z4BZ5CXOZOxiAeJCKrT3wlPdhoR35heY4Vn/OR69cpRNwgqJBYYWYrwmlL7n3UnOvTr/YN+FW0BxOvhyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510114; c=relaxed/simple;
	bh=NvYRVXgFjcjQEUe8XA3TmxPUCrloiIqrGqm28dvgLK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXt2FowtUJIh4mY/FfaSIxK/Uok+EtZt1YPNOVliqyWUvg8lLnQWxnEOwAPD5HmzMg+ljfUPgh9mjbz9rNckKfDHop+A4LcOzC3/UC59TlpEVJjp2MygMDhF4zBzNQmuI4ibAP7PdU7vsLucm6an5vrE/xAMjFWby66PMDkxCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pULfaYNI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pULfaYNI"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20e70a0962so407711066b.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510111; x=1788114911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIXCeWqSrCQg2g+vGMEBn3omtTu0U5s8PS5zUr5JWZM=;
        b=pULfaYNIW7PkBRfGya1Yx/xnnS+/gibW2vA9J12DdvOLZoMjZlrXpKSMReqRNEEBfh
         nKTrAAEe1Stda4W/Q9IlBtS85RWKU/rjOs0a6kcT1LGHwwLsZ/yrpP1qWdBdsj3ohxZF
         qfPUZlw2u+E6cKWkcAam813Z26aEXQ6QcjSE7sK6XX81SRIESZCcgFjx/WIa7quk5XTN
         yy3k3/CEtNilmDzz23/qiYoA/WpMkHqGVe7HIRi/ZqB4vNnz2Qw7o7uSDYzC+dH4M4P5
         Gg0UN4PfB7GiSGnDV4Y+nHxbaI5u/v05RjkgYs69lcb2+yxU/FqVqkvbLcPlx3UiQTz/
         FLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510111; x=1788114911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIXCeWqSrCQg2g+vGMEBn3omtTu0U5s8PS5zUr5JWZM=;
        b=OCdkKNY46s5STH55mTLgHLfWIAHKmUmCLaWD0ZS+iAS9urIMU3bk92s1fm26X5dCSD
         SbtdInDB8wxQLQWtOcFXh2xjyjsEr2H2jO+Qgl773ByGOwNMMdzONm5/3wzhPKBY/OmA
         7zAo2X8++Cfoiwcd1IyJzR7fTGgvTVCYFi1d9kGUNAKYPaSKOytXVrk4NuTeL4D9aoJT
         0Cbd4N9ekTk0d/+LRLEt0ZRL1+KvZt9USo/ylZOow0QYyds26bNK6EvTJ8WY3gkPPI2/
         NszBBBqndhNmO1IBWEkCOg1WXZ5NJpSM8vttYFg8L4z1ioaPGAgaeJwPYOW10xXMNki0
         HgvA==
X-Forwarded-Encrypted: i=1; AHgh+RpOwmofcGduwGizaCudeMXU4+x4C9anddpXzHyvMIWQD4XD8RB/EkbhG3wmiy2+wJ2Z4HQsEhAOvwQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lEwzpaYiWQh9iEA80eI/QjmKB8AfQzS/kMcuAbi0ci9iu4ok/z
	YeHW5MVVTofq5OG/HHg6WiZlKqUErg4zShocVqyqOh2b8FZBLqGG4iVA
X-Gm-Gg: AR+sD10TI5y1xbxHkRtk7gwl9ax00PCEXYjfYrFPyfaS7ia9poil4Ootrx8375SwyJx
	nkRGGQ19QhnWJxXpO2fqvtwTSXwB6MQ/1nhBy325rCNc/z43JCSnBmPCLRiA6Dfg71zOfol3Qxc
	ym6ec7eB8pvky67/ACxCzD1izkEKH0zQPvJBGU5ZBPfft5L6rRDp7Tn9xCaV1EAL9fbDsRIjiQ/
	5TY/pG5U2qHgdP/L9tbIjMxE2Dk7EEFlt3gky3X+yaCqZAWNF1Zz6ZnVSJWWm3Qfc29g9H55Prz
	YC1AP41MIv9NPAndsJPBTV6QuvXfrw+7dtECQx1FNjbve+dj6OWH5yRlIrqvwLXOvX9lLSZKN5V
	EDSzpEr/VOHCnzeGnChAXOBZdBGvISOap5XY/7wSZzHIh2sR75DQwAAfqNPAk/d83OcjIQCzdHd
	4AFjxOHoJXKnCmZyDcsJAro7A2sThcnjcW63FIW3NvbAJNqGg72MYdCVzu2q0HBPlL93Bm1Nsbs
	DRSLAZ5mwAIXJJHUEq7iZKYwqSsfp+UHfgRaPnNUKBdZMc5OmVmP9o=
X-Received: by 2002:a17:906:5183:10b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c246a704562mr1871998066b.19.1787510110478;
        Sun, 23 Aug 2026 11:35:10 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:10 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 3/3] pciehp_hpc: workaround to not wait in pciehp_isr on surprise removal
Date: Sun, 23 Aug 2026 18:34:55 +0000
Message-ID: <20260823183458.982699-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260823183458.982699-1-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add pciehp_disconnect_work() , this function is used using schedule_work from pciehp_isr allowing us to not wait in pciehp_isr()
- pciehp_disconnect_work() is scheduled only if the card is not detected (PDS bit = 0).
       The PDS bit can be used to differentiate between a safe and surprise removal.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb4..69ed6b060e9d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,6 +620,40 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	up_read(&ctrl->reset_lock);
 }
 
+/*
+ * Workaround to not wait in the isr.
+ */
+static void pciehp_disconnect_work(struct work_struct *work)
+{
+	struct controller *ctrl = container_of(work, struct controller,
+					       disconnect_work);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	int events;
+
+	events = atomic_read(&ctrl->pending_events);
+
+	/*
+	 * Ignore Link Down/Up events caused by Downstream Port Containment
+	 * if recovery succeeded, or caused by Secondary Bus Reset,
+	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
+	 */
+	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
+	    ctrl->state == ON_STATE) {
+		// Ignore the link change events and return to normal operation.
+		// Could also wait here if needed.
+		return;
+	}
+
+	struct pci_bus *bus = ctrl->pcie->port->subordinate;
+
+	/* the card may have returned. */
+	if (!bus || pciehp_card_present(ctrl) != 0)
+		return;
+
+	pci_walk_bus(bus, pci_dev_set_disconnected, NULL);
+}
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
@@ -722,6 +756,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
+
+	// presence change events
+	if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
+		// Get PDS bit to determine if card is present or not
+		int present = pciehp_card_present(ctrl);
+		if (!present) { // for sure the card is not present
+			schedule_work(&ctrl->disconnect_work);
+			// After this we are no longer in isr and can wait.
+		}
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -1036,6 +1081,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	init_waitqueue_head(&ctrl->requester);
 	init_waitqueue_head(&ctrl->queue);
 	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	INIT_WORK(&ctrl->disconnect_work, pciehp_disconnect_work);
 	dbg_ctrl(ctrl);
 
 	down_read(&pci_bus_sem);
@@ -1096,6 +1142,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 void pciehp_release_ctrl(struct controller *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->button_work);
+	cancel_work_sync(&ctrl->disconnect_work);
 	kfree(ctrl);
 }
 
-- 
2.51.1

