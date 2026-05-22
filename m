Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AD30EF90
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480859; cv=none; b=Hn7Y9onCL1ut9wC1J0Viw+HV55P17/61wwackeZBLHfogLfAt52wqHIt7RvofwIcU+maBHMCbEAD04sShyQrf7J681Q9Tc4s866qpWz+kSMA9l4ZZRCQP35WyI/t3nEY4XHnlkKkmqGeYAlPS0/lrXjeGGhrt00slUI8kQ/MsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480859; c=relaxed/simple;
	bh=qWyagzwj81sZHYqCHTv2e1MRLXoqEQYkL4V3VuRWcCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJnuAnXnEpYnGKCTbWp6u1N16+RzBmxdn8q2GhIA67IqlE9WgPXUBW85vDzFQPrWEUAxI5oRvadLElqWIOsY2HACbY+AgSOmbvAcBgz+bhmnFhgIxkoX3uXe3HqUC8w2vUOthcYIbxVXJEMrmQPto5rIWH/BJ3Jc1caIEXMdTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iONR5Cdx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iONR5Cdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779480856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i1r7c0ZX/Rk9Rie3kebVNlDwho4qFK7/jhLohvZtobo=;
	b=iONR5CdxVZOcUh0B/HHNgSISb53xNH+h000OT6l71enUt9mzCcxWhSM1vn2qL6yiqBasim
	wGam+6kVBGXjYdwZEAXORpm4juhS1EZGqARJKGJSuOJUXlLe5XAEf+CD2HoDA2H47zTIfV
	bBIqUpAt6RUuyi4jFA6i71HbFMaDJ/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-haRVGjbxPByLdHWE1paWuA-1; Fri,
 22 May 2026 16:14:14 -0400
X-MC-Unique: haRVGjbxPByLdHWE1paWuA-1
X-Mimecast-MFC-AGG-ID: haRVGjbxPByLdHWE1paWuA_1779480853
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A666F195608E;
	Fri, 22 May 2026 20:14:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B304B300019F;
	Fri, 22 May 2026 20:14:12 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] PCI: Prevent workqueue code nesting in pci_call_probe()
Date: Fri, 22 May 2026 16:14:06 -0400
Message-ID: <20260522201406.1057431-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

pci_call_probe() can be called recursively. If the recursive calls are
done indirectly via workqueue kworker, a lockdep recursive warning can
be produced.

There are older commits that tries to prevent that. One example is
commit 12c3156f10c5 ("PCI: Avoid unnecessary CPU switch when calling
driver .probe() method") which prevents work_on_cpu() recursion when
the current device is a virtual function and the physical device has
been probed. However, there are still other cases where workqueue code
nesting is possible leading to a lockdep recursive locking warning like
the following stack trace on a 4-socket Skylake server.

  <TASK>
    :
  work_on_cpu_key()
  pci_call_probe()
  pci_device_probe()
  really_probe()
  __driver_probe_device()
  driver_probe_device()
  __device_attach_driver()
  bus_for_each_drv()
  __device_attach()
  pci_bus_add_device()
  pci_bus_add_devices()
  vmd_enable_domain()
  vmd_probe()
  local_pci_probe()
  work_for_cpu_fn()
  process_one_work()
  worker_thread()
    :
  </TASK>

Fix that by adding a new wq_kworker() helper to check if the current
task is likely a workqueue kworker. If so, call local_pci_probe()
directly instead of calling into workqueue code recursively.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/pci/pci-driver.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..3c63098f6fde 100644
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
+	return (current->flags & PF_KTHREAD) && strstr(current->comm, "kworker");
+}
+
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
@@ -387,10 +395,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	cpu_hotplug_disable();
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
+	 * device is probed from work_on_cpu() of the Physical device or when
+	 * the current task is a workqueue kworker.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	    pci_physfn_is_probed(dev) || wq_kworker()) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
-- 
2.54.0

