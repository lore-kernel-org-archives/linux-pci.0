Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF43515F9;
	Fri, 21 Aug 2026 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277429; cv=none; b=exvHUKTcwOxv7ojW02cOp/kRJwUiBrXyf8HgST0XAoaPnfrqoPLrwwcvHO4HxQNw/vFSUw9tMmdsm/h4WiK7dnihNeh64Zk2o0i10C6YquAXVuk/VwFvQWwpfoADcxoyO5OjA0Q54GKqlHUas6aWgAl7P7B1XBU+OVP3sg8YJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277429; c=relaxed/simple;
	bh=vaa+eL8epVpGAe23TT9gsuLQJ4AOHGlwMdIZdNZwx4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvB4QJbxmf4bLPkaS7J7PsUkq/vHpuHychEQ37atGo3OTBTLlN08JMlechrysMqBCysth/o6FzQq/aMLMyaXBLcp5didQLJ6vRh06XSB/ghXv8SwAED0YDsyjunntFtjDzNgVnGQzLiN4rBExPTxvCyOjIs0NCqJ/J4DGCfYV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XGVzuIzY; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XGVzuIzY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=25au69T4jnDTn0u7B83R03fZNdgn3q5Gh9iYvp2As/M=;
	b=XGVzuIzYWW155aVdun57hZwiZEsLOGb6SL0ZDIa5YHWkIXHxvSkXQS0n0yY0NKJ9IEYPOFMo1
	iJvBzsDnpC2eEgj8tWC7FIlcREslKi+ph2oHJ3cM1ppS3+XvUdKSmcoAb+teUsu5rUv0zMwgUuy
	v0jNA6PRnUY5/DR0GZnFfsM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hR37J726czRhWV;
	Fri, 21 Aug 2026 09:46:20 +0800 (CST)
Received: from dggpemr500010.china.huawei.com (unknown [7.185.36.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 79E4E40561;
	Fri, 21 Aug 2026 09:57:01 +0800 (CST)
Received: from huawei.com (10.50.85.180) by dggpemr500010.china.huawei.com
 (7.185.36.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:57:00 +0800
From: Zhang Hongtao <zhanghongtao35@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Alex Williamson <alex.williamson@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Dan
 Williams <djbw@kernel.org>, Keith Busch <kbusch@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	<zhangqiuhao@huawei.com>
Subject: PCI: Prevent device lock leak during bus reset
Date: Fri, 21 Aug 2026 10:16:26 +0800
Message-ID: <20260821021626.1874602-1-zhanghongtao35@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr500010.china.huawei.com (7.185.36.210)

pci_bus_lock() and pci_bus_unlock() independently walk the devices below
a bus.  The topology may change between the walks because pci_bus_sem is
not held across the reset.

This causes a device lock leak when AER recovery, device removal, and
driver bind and unbind operations run concurrently.  The relevant order
is:

  bind/unbind                 remove                 AER recovery
  --------------------------------------------------------------------
  bus_find_device_by_name()
                              device_del()
                                                     pci_bus_lock()
                              list_del(&dev->bus_list)
                                                     bus reset
                                                     pci_bus_unlock()
  device_lock()

pci_bus_lock() locks the device before the Secondary Bus Reset.  After
pci_destroy_dev() removes the device from bus->devices, pci_bus_unlock()
no longer finds the device and therefore does not unlock it.  The bind
and unbind paths retain references obtained by bus_find_device_by_name(),
so they can subsequently reach device_lock() and wait indefinitely for
the leaked lock.

The race was reproduced consistently on QEMU Q35 with an e1000e endpoint
and a mainline-based kernel:

  7.2.0-rc4-00366-gf9cf390f34eb

Artificial delays after bus_find_device_by_name(), pci_bus_lock(), and
device_del() widened the race windows.  Concurrent bind, unbind, and
remove operations were started, followed by an injected Data Link
Protocol AER error using CONFIG_PCIEAER_INJECT.  The hung task detector
reported both device_driver_attach() and device_release_driver_internal()
waiting on the device mutex, likely owned by irq/24-aerdrv.

Take a topology snapshot under pci_bus_sem and hold a reference to every
device in it.  Drop pci_bus_sem before acquiring device locks, then use
the snapshot for both locking and unlocking.  This guarantees that every
device lock acquired by pci_bus_reset() is released even if a device is
removed from bus->devices during the reset.

The fix was tested on commit d326f83e819c ("Merge tag 'net-7.2-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") with the same
forced ordering.  The device was removed from bus->devices between the
reset lock and unlock markers, after which device_driver_attach()
completed and no hung task occurred.

This is intentionally a limited fix.  It makes lock and unlock symmetric,
but does not protect the topology for the entire reset.  In particular, a
device added after the snapshot may be reset without its device lock held.
Similar independent walks also exist in the slot and try-reset paths.  This
RFC seeks feedback on whether the snapshot should be extended to those
paths or reset should use a stronger topology exclusion mechanism.

Fixes: 090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
Signed-off-by: Zhang Hongtao <zhanghongtao35@huawei.com>
---
 drivers/pci/pci.c | 102 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..25a1e44263c3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5409,6 +5409,88 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	return __pci_bus_trylock(bus, NULL);
 }
 
+struct pci_bus_lock_context {
+	struct pci_dev **devs;
+	size_t nr_devs;
+};
+
+static size_t pci_bus_lock_count(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	size_t count = 1;
+
+	lockdep_assert_held(&pci_bus_sem);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			count += pci_bus_lock_count(dev->subordinate);
+		else
+			count++;
+	}
+
+	return count;
+}
+
+static void pci_bus_lock_fill(struct pci_bus *bus,
+			      struct pci_bus_lock_context *context,
+			      size_t *index)
+{
+	struct pci_dev *dev;
+
+	lockdep_assert_held(&pci_bus_sem);
+
+	context->devs[(*index)++] = pci_dev_get(bus->self);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pci_bus_lock_fill(dev->subordinate, context, index);
+		else
+			context->devs[(*index)++] = pci_dev_get(dev);
+	}
+}
+
+static int pci_bus_lock_snapshot_init(struct pci_bus *bus,
+				      struct pci_bus_lock_context *context)
+{
+	size_t index = 0;
+
+	lockdep_assert_held(&pci_bus_sem);
+
+	context->nr_devs = pci_bus_lock_count(bus);
+	context->devs = kvmalloc_array(context->nr_devs,
+				       sizeof(*context->devs), GFP_KERNEL);
+	if (!context->devs)
+		return -ENOMEM;
+
+	pci_bus_lock_fill(bus, context, &index);
+
+	return 0;
+}
+
+static void pci_bus_lock_snapshot(struct pci_bus_lock_context *context)
+{
+	size_t i;
+
+	for (i = 0; i < context->nr_devs; i++)
+		pci_dev_lock(context->devs[i]);
+}
+
+static void pci_bus_unlock_snapshot(struct pci_bus_lock_context *context)
+{
+	size_t i;
+
+	for (i = context->nr_devs; i > 0; i--)
+		pci_dev_unlock(context->devs[i - 1]);
+}
+
+static void pci_bus_lock_snapshot_release(struct pci_bus_lock_context *context)
+{
+	size_t i;
+
+	for (i = 0; i < context->nr_devs; i++)
+		pci_dev_put(context->devs[i]);
+	kvfree(context->devs);
+}
+
 /* Do any devices on or below this slot prevent a bus reset? */
 static bool pci_slot_resettable(struct pci_slot *slot)
 {
@@ -5585,21 +5667,31 @@ static int pci_try_reset_slot(struct pci_slot *slot)
 
 static int pci_bus_reset(struct pci_bus *bus, bool probe)
 {
+	struct pci_bus_lock_context context;
 	int ret;
 
+	down_read(&pci_bus_sem);
+
 	if (!bus->self || !pci_bus_resettable(bus))
-		return -ENOTTY;
+		ret = -ENOTTY;
+	else if (probe)
+		ret = 0;
+	else
+		ret = pci_bus_lock_snapshot_init(bus, &context);
 
-	if (probe)
-		return 0;
+	up_read(&pci_bus_sem);
+
+	if (ret || probe)
+		return ret;
 
-	pci_bus_lock(bus);
+	pci_bus_lock_snapshot(&context);
 
 	might_sleep();
 
 	ret = pci_bridge_secondary_bus_reset(bus->self);
 
-	pci_bus_unlock(bus);
+	pci_bus_unlock_snapshot(&context);
+	pci_bus_lock_snapshot_release(&context);
 
 	return ret;
 }

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.34.1

