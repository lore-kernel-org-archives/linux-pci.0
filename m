Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B743CED8
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028216; cv=none; b=le2TAaEHs4vzjiTqYc+5hLfER+CSQ+ntljy9sNqrWvkuZm8nn5sSNhKYGfoKbAg7JEwxAPOODMipH4hU+t5Ck2keacsTcjYIEZqxmxNvLuPXEIEaKxIerzbYGA307+kOJv62s8Y/KpUtvVlJzAFW04SE/i2JN7MqJ7/fXhWlH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028216; c=relaxed/simple;
	bh=Q65ug760ZPb/OlYGqOGNlVJO+R74CPaBf2rOMM9K0rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej00rPUXOeGm7V5U75tVW6R1MYluhYE1BI/ffHIPsNcynsVYmkDVUFXdf7zOSFobkZF4G+vG34OTVGg78K4I0Z+5b+2lohOrAvrDqcZR9xXe3B6euBWNXkjr/J1BPlDX+mihYPE3X7Kn7K84s3n3D325nsaB+FCl0mnsVuBoCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4+cC09Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4+cC09Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781028214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bba3ShkPXLnJs6fxJeKo/039rEsBR36+Fx7OF6O65d4=;
	b=L4+cC09Q6KJMG+GjmyDLC6XxfuyfaC1XxcACgpiBUPmQtlYulGVBfoLkwObdya/Y2MbiMa
	8YpD54BmOFBw9XPWM3md7rTowCMYUB0OHzTmEvocGYcayX9zkXlNEB3a5E+43T130lpUIx
	Cs2zMGyxjv5Z4zcnuFVsYIptMV8tKmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-uwoDDCC3PHSB1WBo60-8WQ-1; Tue,
 09 Jun 2026 14:03:29 -0400
X-MC-Unique: uwoDDCC3PHSB1WBo60-8WQ-1
X-Mimecast-MFC-AGG-ID: uwoDDCC3PHSB1WBo60-8WQ_1781028208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2F7C180131A;
	Tue,  9 Jun 2026 18:03:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6345A18005B8;
	Tue,  9 Jun 2026 18:03:26 +0000 (UTC)
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
Subject: [PATCH v4 1/2] PCI: Suppress false positive lockdep warning in pci_call_probe()
Date: Tue,  9 Jun 2026 14:03:14 -0400
Message-ID: <20260609180315.850637-2-longman@redhat.com>
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

local_pci_probe() and hence pci_call_probe() can be called recursively,
e.g. when vmd_probe() calls .probe() for devices in the new hierarchy
below VMD or a PF .probe() enables VFs and calls .probe() for them. If
the recursive calls are done indirectly via workqueue kworker, a lockdep
recursive warning like the following can be produced.

  ============================================
  WARNING: possible recursive locking detected
  7.1.0-rc6-test+ #1 Not tainted
  --------------------------------------------
  kworker/52:1/1593 is trying to acquire lock:
  ffffc9001498f708 ((work_completion)(&arg.work)){+.+.}-{0:0}, at: start_flush_work+0x3e9/0x9a0

  but task is already holding lock:
  ffffc9001498fd10 ((work_completion)(&arg.work)){+.+.}-{0:0}, at: process_one_work+0xd4c/0x1390

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock((work_completion)(&arg.work));
    lock((work_completion)(&arg.work));

   *** DEADLOCK ***

This is a false positive warning due to the limitation on the number
of distinct lockdep keys allowed. The same lockdep key is used when the
INIT_WORK_ONSTACK() macro is called in pci_call_probe(). So when a work
function queued by pci_call_probe() calls into pci_call_probe() again
and another work function is queued and flushed, the lockdep warning
will be displayed. This can be suppressed by registering a dynamic key
and used it whenever the current task is a wq kworker.

Dynamic lockdep keys are limited finite resources and they should be
used only when really necessary.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3f59001785a..bc8c0f061072 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -394,8 +394,21 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		error = local_pci_probe(&ddi);
 	} else {
 		struct pci_probe_arg arg = { .ddi = &ddi };
+		struct lock_class_key key;
+
+		/*
+		 * A nested pci_call_probe() via a work func will produce a
+		 * false positive lockdep recursive locking warning. Use
+		 * lockdep_register_key() to provision a dynamic key to
+		 * suppress this warning when the current task is a wq kworker.
+		 */
+		if (current->flags & PF_WQ_WORKER) {
+			lockdep_register_key(&key);
+			INIT_WORK_ONSTACK_KEY(&arg.work, local_pci_probe_callback, &key);
+		} else {
+			INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
+		}
 
-		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
 		/*
 		 * The target election and the enqueue of the work must be within
 		 * the same RCU read side section so that when the workqueue pool
@@ -422,6 +435,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 		}
 
 		destroy_work_on_stack(&arg.work);
+		if (current->flags & PF_WQ_WORKER)
+			lockdep_unregister_key(&key);
 	}
 
 	dev->is_probed = 0;
-- 
2.54.0

