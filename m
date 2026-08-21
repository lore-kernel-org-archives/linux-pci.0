Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FF3BFE40;
	Fri, 21 Aug 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330442; cv=none; b=haK98SvY8ZDAIUZOvkRrpfzt2F8mGwnJ5KB163gzjHznHJDOxYRtv735NLK5rMkDnbgc3v4j1lv2waMDMwMT76qYPMGoExRM+Z8sdxpylDP7BO3cxqcMI16Se0dQ/Y13RttCXBGSUIjAAdY5+A6s+jZsiw7EA6tm2L3d0eAe/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330442; c=relaxed/simple;
	bh=LjY9K5ove29/BH+rESB2pQyikZT4aQPayjl8uzpozrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FSVmxQ6VmYAjOTcygtbeG5gbS1k65mR8DOOqMf6JjtT493O0Fv4aXELTTjxxdDS0pJjWzGv/udQ/zhHbR+DkHdJ64EnVp34med5BOAQc2LEyy7jZVFQAueLpKNO0LIxfwxc+2VE+vw0YLrjPs+XVDFcng+gz+pgoIn0E4QB05vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ETuFHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ETuFHj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A2E6C19425;
	Fri, 21 Aug 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787330441;
	bh=LjY9K5ove29/BH+rESB2pQyikZT4aQPayjl8uzpozrI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=O2ETuFHjRleckP/KS19rF4SuugcLb1zYsw+unphUzEl4GbAsG0g+ySEf1j6xX539K
	 Fmztgbj1+LpeIjYj/BmebgW2iG4K53V3/XTbgyKnetMl+HRjvBT2xa2ihpmpSk30Ty
	 28tOB9wdSBwhTlCmGg/8XBuJJZXI6vnVON9Asb0bKrqXowpZTxxq2kvUKBkRd3oPg4
	 ycplllXk6TIRl4vJry9bpDFmf4dnVyaTWEG9TxZ8FF2L5lWndCJCajBBM3oUKJ796m
	 XeKNSYBls99Ll/V4OTEWXAayPUR9gazhfs7zHNb4tOgyPUfk05ETPhbHQ821wPLRqV
	 2FioBmvqXL53A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F7C5DF94;
	Fri, 21 Aug 2026 16:40:41 +0000 (UTC)
From: FAN YE via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Date: Fri, 21 Aug 2026 16:40:41 +0000
Subject: [PATCH] PCI/VGA: Fix lost wakeup when waiting for a VGA resource
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-pci-vga-lost-wakeup-v1-1-39dc6a2333c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIh/iGoC/yXMSQ6DMAxA0asgr7GUhFG9CmIRUhcMFUQxQyXE3
 Rva5Vv8f4JQYBJ4JCcE2ll4mSN0moAb7NwT8jMajDKlqo1G7xj33uJ7kRUPO9HmMesqVRZ1bnL
 SEEsf6MWf37Vp/5atG8mt9wqu6wuBcIaPdwAAAA==
X-Change-ID: 20260821-pci-vga-lost-wakeup-3b70658424e1
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787330440; l=3519;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=Rrv8GAN0TkTavxf0KIGyHuf9553vMGCJ0Prul4fquuY=;
 b=1v3iU7KRL+w1UPjVQY3sriskWxxUrivf66xlFxS/4VJKeVonSAOMEM6cfTk1prWoeU90MW/qg
 8DXrI67x7cCALTVOmYRZpLfStHf90Vi8Ql6yt+yPQnzRj5EgeN26XS5
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: FAN YE <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

From: FAN YE <fy15309206903@gmail.com>

A task waiting in vga_get() can sleep forever even though the conflicting
device has already released the resource.  Once __vga_tryget() reports a
conflict, vga_get() drops vga_lock and only then puts itself on
vga_wait_queue, while __vga_put() wakes that queue while holding vga_lock.
A wakeup landing in between finds the queue empty and is discarded, and as
the conflict is already gone no further wakeup is coming.  Callers passing
interruptible=0, such as the "lock" command of /dev/vga_arbiter, are then
unkillable and keep their lock counts forever.

Queue up before dropping vga_lock, the way prepare_to_wait() publishes a
waiter before the condition is re-tested.  The releasing side needs
vga_lock to reach the wakeup, so it can no longer pass an unqueued waiter.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: FAN YE <fy15309206903@gmail.com>
---
Reproduced under QEMU on 818bebeb63dd with two VGA devices, the second one
behind a bridge that does not forward VGA so that it owns no legacy resources.
Two /dev/vga_arbiter clients each locking one device wedged the second client
in vga_get(), D state and unkillable, after 8538 rounds, while the conflicting
device already read back locks=none(0:0).  40000 rounds with this patch, none.
---
 drivers/pci/vgaarb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3de05aee78599..51c7d171c9558 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -459,6 +459,23 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
 			break;
 		}
 		conflict = __vga_tryget(vgadev, rsrc);
+		/*
+		 * We have a conflict; we wait until somebody kicks the
+		 * work queue. Currently we have one work queue that we
+		 * kick each time some resources are released, but it would
+		 * be fairly easy to have a per-device one so that we only
+		 * need to attach to the conflicting device.
+		 *
+		 * Queue up before dropping vga_lock: __vga_put() wakes the
+		 * queue while holding it, so a wakeup cannot slip past.
+		 */
+		if (!IS_ERR_OR_NULL(conflict)) {
+			init_waitqueue_entry(&wait, current);
+			add_wait_queue(&vga_wait_queue, &wait);
+			set_current_state(interruptible ?
+					  TASK_INTERRUPTIBLE :
+					  TASK_UNINTERRUPTIBLE);
+		}
 		spin_unlock_irqrestore(&vga_lock, flags);
 		if (IS_ERR(conflict)) {
 			rc = PTR_ERR(conflict);
@@ -467,18 +484,6 @@ int vga_get(struct pci_dev *pdev, unsigned int rsrc, int interruptible)
 		if (conflict == NULL)
 			break;
 
-		/*
-		 * We have a conflict; we wait until somebody kicks the
-		 * work queue. Currently we have one work queue that we
-		 * kick each time some resources are released, but it would
-		 * be fairly easy to have a per-device one so that we only
-		 * need to attach to the conflicting device.
-		 */
-		init_waitqueue_entry(&wait, current);
-		add_wait_queue(&vga_wait_queue, &wait);
-		set_current_state(interruptible ?
-				  TASK_INTERRUPTIBLE :
-				  TASK_UNINTERRUPTIBLE);
 		if (interruptible && signal_pending(current)) {
 			__set_current_state(TASK_RUNNING);
 			remove_wait_queue(&vga_wait_queue, &wait);

---
base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
change-id: 20260821-pci-vga-lost-wakeup-3b70658424e1

Best regards,
--  
FAN YE <fy15309206903@gmail.com>


