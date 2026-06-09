Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4348A2AA
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028218; cv=none; b=p+Hqk9RXd7ASGM9Ojgj9ttMCBRh/JnJ9aIZBgvT1AJ6KZkbcGfAOf6Ucq8XFfgNaqXUsoUrHP5JL/1yqkrQ2FOnslbkxBFaF6OObS/GBbD28WW3CbVdk+3sEoe3/O7/uvPvvHak95aQvYoZt2itG0zjYfXEkVhdAacCl/XR4g+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028218; c=relaxed/simple;
	bh=SX4qlgoV3gU2rCl9ddPaVZbThQtE6NOnGGJYyrnmR60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR1G7i+i1xPMU3YLVBnUPrb9cO9o6l5J1Fn6AOBj7oThk2SOR1UMCdnWeZqrq6O0dXxiatfNKGjty99YQGEqhtCyqXGQYxPEJ4LjoniEL9BNvSELo5JzPMMEuByjc7O0mqxREUyluGtiVvfx1lM79vbQv+erR5PwvnSun2l142A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmJh3bzV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmJh3bzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781028216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnBmtUsOV6AR26m1a1E5hJ29QcWIbb9DPjXBH0i0AVU=;
	b=TmJh3bzVn1RslJPoyuby30Fit6lkEG5GfeM48DVlGP89+6VvV37QW3wOagVM77G+6oxS0C
	b1j3Itu0tZvNXpIVfdCPQhgPtUVysJDq/XBBRc8TC2Nm9wj0IhFIGb5OZRJ+bVcQNdPzT5
	AhuP6j4zVSj5RSGNaH19dL+SvQD8Pts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-eHNEtef5POS2HK6RRmRYhQ-1; Tue,
 09 Jun 2026 14:03:31 -0400
X-MC-Unique: eHNEtef5POS2HK6RRmRYhQ-1
X-Mimecast-MFC-AGG-ID: eHNEtef5POS2HK6RRmRYhQ_1781028209
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D371835E2B;
	Tue,  9 Jun 2026 18:03:29 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1785C18005B8;
	Tue,  9 Jun 2026 18:03:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/2] PCI: Call local_pci_probe() directly in pci_call_probe() if affined to the right node
Date: Tue,  9 Jun 2026 14:03:15 -0400
Message-ID: <20260609180315.850637-3-longman@redhat.com>
In-Reply-To: <20260609180315.850637-1-longman@redhat.com>
References: <20260609180315.850637-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently pci_call_probe() will unconditionally queue a work function
to perform the actual device probing whenever the device is associated
with a valid NUMA node. The use of work function originally comes from
commit 873392ca514f ("PCI: work_on_cpu: use in drivers/pci/pci-driver.c")
to execute the device probing and allocate memory on the right node
where the device bus is attached to.

This is inefficient to schedule another work function in the same or a
neigboring CPU and wait for its completion when the current task is a
work function itself queued by pci_call_probe() or async_schedule_dev()
that has been affined to the right node already. It will also reduce
the amount of parallelism as noted in [1].

Fix that by calling local_pci_probe() directly if the current task has
been affined to the right NUMA node. Now lockdep dynamic key will only
be used if the current task is a wq kworker but is not affined to the
right node.

[1] https://lore.kernel.org/linux-pci/20251227113326.964-1-guojinhui.liam@bytedance.com/

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/pci/pci-driver.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bc8c0f061072..70e7b944c097 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -375,6 +375,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 {
 	int error, node, cpu;
 	struct drv_dev_and_id ddi = { drv, dev, id };
+	bool node_invalid, affine_to_node;
+	const struct cpumask *node_cpus;
 
 	/*
 	 * Execute driver initialization on node where the device is
@@ -383,14 +385,24 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 */
 	node = dev_to_node(&dev->dev);
 	dev->is_probed = 1;
+	node_invalid = node < 0 || node >= MAX_NUMNODES || !node_online(node);
+
+	if (node_invalid) {
+		node_cpus = cpu_online_mask;
+		affine_to_node = false;
+	} else {
+		node_cpus = cpumask_of_node(node);
+		/* Check if the current task is affined to the right node */
+		affine_to_node = cpumask_subset(current->cpus_ptr, node_cpus);
+	}
 
 	cpu_hotplug_disable();
 	/*
-	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
+	 * Prevent nesting queue_work_on() for the case where a Virtual Function
+	 * device is probed from queue_work_on() of the Physical function or
+	 * when the current task is affined to the right node.
 	 */
-	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	if (node_invalid || affine_to_node || pci_physfn_is_probed(dev)) {
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
@@ -417,8 +429,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
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

