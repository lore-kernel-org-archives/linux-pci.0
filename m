Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DE33AD82
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780870281; cv=none; b=tuL9ExwsgcpN2oiUobFjMENXuJvm4TRWw43rw5t2LeLjQUWwhczTgjtXvGvIHZq1KrNhij7mAPB9iRwtUz+Y8yQqHPPkCxFSRKi05QNfSVUkGGONBw4/6BFRXV2voIe7STzUGhPWIuUZxuweWb6VAZP441Kzkgrl/E88aWjeYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780870281; c=relaxed/simple;
	bh=4JBI04u+kID23zdCcaQzHiI4W8ColUHsmkfUmiVwZLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHgqX8QzHz849fu89aE+PKISTGmNxdBojwYktec0lQt2dfKgITl0xGbYTOGb8BHAqeHwyjlju13psXElIWGY4m3a3fy3XExEAsSSYGVtkMMOAEW/FuUPBLKRDwAvpjy+C7WtsQnG3fQhIJlNQn2hYCRktsxuBDBijjky2npxgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JV2Kz41J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV2Kz41J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780870278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ut9OwPb+kpC9bGm19kb1PPldeyaiiw/iLCahvOVlUSg=;
	b=JV2Kz41Jxh8GsPsGdHsM8TUSVk5x0n5xoLhq9D06Y422oDdE/SobQcsthWZ8U/6w0McYvJ
	9f1HE38j6BlmdUNhXmO52j3+YnVzN7T1NpdzBPmsm4GJZwxE4fOncArXNB/b4KYEz15RTc
	QjBp1Ul3AzDi+sFExLQZuO/0BW/QMs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-takGgpcHPm6kBQMVa2xydw-1; Sun,
 07 Jun 2026 18:11:17 -0400
X-MC-Unique: takGgpcHPm6kBQMVa2xydw-1
X-Mimecast-MFC-AGG-ID: takGgpcHPm6kBQMVa2xydw_1780870276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5EE1800473;
	Sun,  7 Jun 2026 22:11:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01BE91800480;
	Sun,  7 Jun 2026 22:11:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] PCI: Call local_pci_probe() directly if current CPU is in the right node
Date: Sun,  7 Jun 2026 18:11:03 -0400
Message-ID: <20260607221103.703133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

local_pci_probe() and hence pci_call_probe() can be called
recursively. If the recursive calls are done indirectly via workqueue
kworker, a lockdep recursive warning can be produced. Below is the
stack trace of the lockdep warning on a 4-socket x86-64 Skylake server.

  <TASK>
    :
  start_flush_work+0x40b/0x9b0
  __flush_work+0xbd/0x1a0
  pci_call_probe+0x510/0x700
  pci_device_probe+0x17c/0x270
  call_driver_probe+0x68/0x1f0
  really_probe+0x197/0x7b0
  __driver_probe_device+0x32d/0x460
  driver_probe_device+0x49/0x120
  __device_attach_driver+0x162/0x290
  bus_for_each_drv+0x109/0x190
  __device_attach+0x1a2/0x3f0
  device_initial_probe+0x7d/0xa0
  pci_bus_add_device+0x93/0xe0
  pci_bus_add_devices+0x83/0x190
  vmd_enable_domain+0x11fb/0x1b80
  vmd_probe+0x34c/0x4b0
  local_pci_probe+0xdf/0x190
  local_pci_probe_callback+0x35/0x80
  process_one_work+0x919/0x1af0
  worker_thread+0x5a6/0xd10
    :
  </TASK>

The use of work function originally comes from commit 873392ca514f
("PCI: work_on_cpu: use in drivers/pci/pci-driver.c") to execute the
device probing and allocate memory on the right node where the device
bus is attached to.

In the case of nested device probing within a work function, the current
CPU is likely to be in the right node already. So there is no point in
scheduling another work function in the same or a neigboring CPU and wait
for its completion. It will be more efficient to call local_pci_probe()
directly when the current CPU is indeed in the right node. That will
also avoid the lockdep warning due to nested calls to schedule and
flush a work function.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/pci/pci-driver.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..542b22537852 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -375,6 +375,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 {
 	int error, node, cpu;
 	struct drv_dev_and_id ddi = { drv, dev, id };
+	bool node_invalid, cpu_in_node = false;
+	const struct cpumask *node_cpus;
 
 	/*
 	 * Execute driver initialization on node where the device is
@@ -383,14 +385,27 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 */
 	node = dev_to_node(&dev->dev);
 	dev->is_probed = 1;
+	node_invalid = node < 0 || node >= MAX_NUMNODES || !node_online(node);
+	node_cpus = node_invalid ? cpu_online_mask : cpumask_of_node(node);
+
+	/*
+	 * If the current task is a wq kworker activated by queue_work_on()
+	 * below, the kworker is affined to a designated CPU and won't be
+	 * switched to another one. So the current CPU can be checked to see
+	 * if it is in the right node.
+	 */
+	if (current->flags & PF_WQ_WORKER) {
+		cpu_in_node = cpumask_test_cpu(get_cpu(), node_cpus);
+		put_cpu();
+	}
 
 	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
+	 * device is probed from work_on_cpu() of the Physical device or when
+	 * the current CPU is in the desired node.
 	 */
-	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	if (node_invalid || cpu_in_node || pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
@@ -404,8 +419,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		 * targets.
 		 */
 		rcu_read_lock();
-		cpu = cpumask_any_and(cpumask_of_node(node),
-				      housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpu = cpumask_any_and(node_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 		if (cpu < nr_cpu_ids) {
 			struct workqueue_struct *wq = pci_probe_wq;
-- 
2.54.0

