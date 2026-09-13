Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FD285CAA;
	Sun, 13 Sep 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303890; cv=none; b=fj0LAJUX1xCnb3XA2NBC4anfZ4xTBGL17XqcEw/WRbuI9+Def2gfDN5P+o4ueSM+1dopPUgdwW29AvdujcpkmR68XZVT3NMGjYR1zieD4Qxv/wlbXx4URUOLYXSBzgIeKp+UyWj5x8nFaPI2ZTfElBqXqw8WDwJlG+rI6lkuAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303890; c=relaxed/simple;
	bh=QoeSvN471UQuqwSz41GXF8Jl6uqntZOC8xyYuURbM5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAnwtK8qg7x8NvXXa1Q74miy05X1gqsqWQb8lZCm+7stiqR6se9oJRlBli76mmNmBAeraomzrpRmzPJOEPdGDEomcJQJKyPnIbpXCPeZ7nxXuzkNbxrJJ//SUStaPr1IOHgMEwc55VPIoOi3a+zu8udrXdm7ymqjTBG/+c4zw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=luRA9Qp5; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="luRA9Qp5"
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3cc;
	Sun, 13 Sep 2026 20:51:21 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: bhelgaas@google.com
Cc: sthotton@marvell.com,
	vattunuru@marvell.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] PCI: octep: handle an unsuccessful hotplug scan
Date: Sun, 13 Sep 2026 20:51:18 +0800
Message-Id: <20260913125118.109777-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad27a1503a1kunmadf12168251132
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxhDVhkYGEIYQklDQ0wZSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=luRA9Qp5l+uwuLJ6ymUQDFprGT01CNnzKe2pHUPBzph5j9B08jnAr5FgNQ8RSVl4sLQHi3cfwpR1PD6WGfLrm+kEYOSzCHN1Z2zhrycAS6VPFnnwUK3NTgQxQ4GD+yhdFQHeh3r6XvjXoDUeMdux/4hy/0L+AQ8RzSkjjTAkPck=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=yhhdRDxPvVEh20H2ygRtbzTLlKXYk2l8ayO9t4VIsRo=;
	h=date:mime-version:subject:message-id:from;

pci_scan_single_device() can return NULL if no device is found or
allocation fails. octep_hp_enable_pdev() passes that pointer to
pci_bus_add_device() and then dereferences it for a debug message.

Return -ENODEV when the scan fails and propagate it through the hotplug
enable_slot callback. This leaves the slot disabled and allows a later
retry without reporting a successful enable to userspace. Log the
failure for callers that cannot return an error to userspace. The
scoped mutex guard releases the slot lock on each return path.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: e434e54d3ffc ("PCI: hotplug: Add OCTEON PCI hotplug controller driver")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/pci/hotplug/octep_hp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
index a0a7f9ccb8fa..a57969185022 100644
--- a/drivers/pci/hotplug/octep_hp.c
+++ b/drivers/pci/hotplug/octep_hp.c
@@ -66,24 +66,31 @@ struct octep_hp_controller {
 	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
 };
 
-static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
-				 struct octep_hp_slot *hp_slot)
+static int octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
+				struct octep_hp_slot *hp_slot)
 {
 	guard(mutex)(&hp_ctrl->slot_lock);
 	if (hp_slot->hp_pdev) {
 		pci_dbg(hp_slot->hp_pdev, "Slot %s is already enabled\n",
 			hotplug_slot_name(&hp_slot->slot));
-		return;
+		return 0;
 	}
 
 	/* Scan the device and add it to the bus */
 	hp_slot->hp_pdev = pci_scan_single_device(hp_ctrl->pdev->bus,
 						  hp_slot->hp_devfn);
+	if (!hp_slot->hp_pdev) {
+		pci_err(hp_ctrl->pdev, "Failed to scan slot %s\n",
+			hotplug_slot_name(&hp_slot->slot));
+		return -ENODEV;
+	}
 	pci_bus_assign_resources(hp_ctrl->pdev->bus);
 	pci_bus_add_device(hp_slot->hp_pdev);
 
 	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %s\n",
 		hotplug_slot_name(&hp_slot->slot));
+
+	return 0;
 }
 
 static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
@@ -109,8 +116,7 @@ static int octep_hp_enable_slot(struct hotplug_slot *slot)
 	struct octep_hp_slot *hp_slot =
 		container_of(slot, struct octep_hp_slot, slot);
 
-	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
-	return 0;
+	return octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
 }
 
 static int octep_hp_disable_slot(struct hotplug_slot *slot)
