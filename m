Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0E3FA5F2
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802464; cv=none; b=K0425ez3ZexwCUyGnDomspyAZydE7YgrisdYK/LUuTp/lQoR/A9AjObnBsAsTQzPT87Gs43wDWYGERIJraUx5blGNXbb54UB2HlYjp2nx14hPuI5gkwrGwOmkheqxFBMNx/LKTA8UOdbpdeqo1oH9wQcNE3NwvUF/FWY5q75TuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802464; c=relaxed/simple;
	bh=1LfDPPdF9kRVOmTHDImgSfPA/ijutNtWhD5EG362RAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BP6hR8Zec+MPTGsWpSDb+tibhKtoM4qhwu/oKI2O3b1DA+mew0f4rFjMFl/JQKW+R5kWIFYRRdKrkunaV9hGsPw40QPsMdfsJqAv2CiIgsY4VYWCqPNjXiNQcK64ncugCO/U7PMnCziD9rddvwIu35seDFA7xIWFGBTHVsXPRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkrmPebR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkrmPebR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779802462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mg1+kRsSNGZTbkMwaTAPjKmNsacasOv1PicS0GJAsds=;
	b=LkrmPebR59H/oESZwCytzjxegJ7mZIwdknDckWgoOfFycPoyEfya0tjadYrWLQai6F2gxW
	yz4mDiKh5k0ioDtV0CUYt+7P1xmGKS+FpRDrkGCOD3TQLYah5gGWNALaTBHqegw2bGVETS
	Y1OqckzjmDb23ifz0tYIJqX1OWUzkI0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-UaVwC7iTOSGZqixkkIMblQ-1; Tue,
 26 May 2026 09:34:17 -0400
X-MC-Unique: UaVwC7iTOSGZqixkkIMblQ-1
X-Mimecast-MFC-AGG-ID: UaVwC7iTOSGZqixkkIMblQ_1779802456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 974E9195609F;
	Tue, 26 May 2026 13:34:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3D71180034E;
	Tue, 26 May 2026 13:34:15 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] PCI: Prevent workqueue code nesting in local_pci_probe()
Date: Tue, 26 May 2026 09:34:03 -0400
Message-ID: <20260526133403.1253961-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

local_pci_probe() and hence pci_call_probe() can be called
recursively. If the recursive calls are done indirectly via workqueue
kworker, a lockdep recursive warning can be produced.

There are older commits that tries to prevent that. One example is
commit 12c3156f10c5 ("PCI: Avoid unnecessary CPU switch when calling
driver .probe() method") which prevents work_on_cpu() recursion when
the current device is a virtual function and the physical device has
been probed. However, there are still other cases where workqueue code
nesting is possible leading to a lockdep recursive locking warning like
the following stack trace on a 4-socket x86-64 Skylake server.

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

Fix that by adding a new wq_kworker() helper to check if the current
task is a workqueue kworker. If so, call local_pci_probe() directly
instead of calling into workqueue code recursively. However, this patch
will increase the level of local_pci_probe() nesting that is possible.

For this particular system with a patched kernel built with a RHEL
based kernel config file, the local_pci_probe() nesting is only 2
levels deep. The additional stack usage from one local_pci_probe()
to the next is measured to be 792 bytes.  With a 16k kernel stack,
it can sustain up to 20 local_pci_probe() nesting loop. The mileage
may vary depending on what kernel options are enabled and future code
changes in the PCI driver code base.

It is unlikely that we will see a real system with a very deeply nested
PCIe topology requiring more levels of nesting than is supportable by
a 16k kernel stack. To be cautious, a comment is added to mention that
kernel stack exhaustion can be a possibility if a very deeply nested
PCIe topology is to be supported as further change to how PCI device
probing works may be needed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/pci/pci-driver.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

 [v2] Directly check PF_WQ_WORKER as suggested by Sashiko and document
 the kernel stack exhaustion issue with deeply nested PCIe topology.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..6d9944b42c3c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -370,6 +370,14 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
 #endif
 }
 
+/*
+ * Return true if current task is a workqueue kworker
+ */
+static bool wq_kworker(void)
+{
+	return current->flags & PF_WQ_WORKER;
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
@@ -387,10 +395,17 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
+	 * device is probed from work_on_cpu() of the Physical device or when
+	 * the current task is a workqueue kworker.
+	 *
+	 * TODO: With a deeply nested PCIe topology, pci_call_probe() can be
+	 * recursively called multiple times. If the nesting is deep enough,
+	 * it may cause exhaustion of the kernel stack. So some additional
+	 * changes will be needed if such a deeply nested topology is to be
+	 * supported.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	    pci_physfn_is_probed(dev) || wq_kworker()) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
-- 
2.54.0

