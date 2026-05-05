Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2D33987E
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024628; cv=none; b=Nuf5xEOV3NQ1wOJZUUkMYzBMemwxg2oBoMJbZSXG4ITmKTC/wFr8SlOedAC6j4wokbJ2LEpybThPbg3rC3w/MdtybiYZEzLlFM5AFK8u9gQ/mf57KUTVmZTbFk/8k6yZxDKhZ3B5haopSs/mffhatfAX0KGiRDQgh5CfH94kf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024628; c=relaxed/simple;
	bh=5NTiSaDfrs9AGN5yp3XlSx0CLvr1x9GJvDeuDPc3dtc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WY8j4f1+IEJpqD2r85W4tPCHOhgPVWwpuFACgHh5+eOSORxeAxWwttNp2aRm63vdnuKfaDXNj0gzrJtM/ZInzn0OCcIb/mMNhup/FhWzDUllsJoBiX5dnNf81r6tA8A3Vea3+EtYs/IGch0DWPcABD3qehETU1AUD636E4hSvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWP/Xk8J; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWP/Xk8J"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8354503d9acso3494424b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778024626; x=1778629426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLifBCcvpeoNaalw5dhl6uu6/26Oav0q3n95ZKVqY6I=;
        b=lWP/Xk8J3xYzzYLbJgnmyFrwa1XJwMFx5NGEbEOW85CKOlMvtvwTU6rCwiW+Z9Zvpy
         THnk0lERD34cSSMzcEUlpT8n8LNpnl3tlPElgjgy6U1pYU/DnWlcI/nKMpaSIQXNmxeW
         ITo4+PP3R6JNkhBoTmJAFiW2kRgyHDyq1OAdIuJihEEWdNaR+kLaewzkN9Ui0xcZDZ31
         fg36Ip5nJE9KtBle8ZSfkW+x1SKQ8zImmbsPjLICYc/hyfm0Vhg6w8vNhjChR6VL3AQb
         x988dl7Ee8b0Oyncnp9WfpqAwPwC2DNwBCbRarFCkwAlcqBHPzJcZwu3WKPs8BXtamuo
         K3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778024626; x=1778629426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLifBCcvpeoNaalw5dhl6uu6/26Oav0q3n95ZKVqY6I=;
        b=DxlxcqmypDGc1wUs+QSVkJ3iEKhfmOcjsCvnId52wXGzf2qJgJ42aLVQPEITqZ4yMz
         uAWNc8ZYndZ7ppugj2ZEGYplLmHS6iYIulJrHTGTCnn/D6VYF7tHa9NP6F1fdqyzmecn
         jhU/7O5SCo5RoAf3qx6K1WRvPDS/gjNUNnnXsWrw4aM2r5h6Kb1Lb8TOhKipdMBv+8h4
         Bwdxu5pUheSqvIiw+Raz+lxHKLudPRZtON+6VJmBhgJmrzwKpkls2ct69PBz21hzHwv7
         rKOFYy8NhQRYAGeTP6HWXw53fw1VQDgnztq4DGZqFWD8ccGUJ3ssPXo5I5i+YrgBmUtp
         OMUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tT/WYV+4uGmyF/HK7qT2RlrtCU9yU2W/hShrc0VUo1AeUNwYHZPob2nbTisl8KBgqF5a84yThiw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYLAMrgV/O/WdR9JOnYGB5zbO7OEACBvqEUaFvcAiXWbRpcFP
	7RX+Z5OeY5Sds3KyaWECto8zPLyWCc0NlP886BKG4Bud94JuYgnhNjxW8FWepGGEKvQtvZcpEy0
	Y9DqN2IQ+R/dXhg==
X-Received: from pfbcr15.prod.google.com ([2002:a05:6a00:f0f:b0:82f:5b50:db30])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4514:b0:82f:355a:857e with SMTP id d2e1a72fcca58-83a5ea421f2mr766773b3a.47.1778024626170;
 Tue, 05 May 2026 16:43:46 -0700 (PDT)
Date: Tue,  5 May 2026 23:43:27 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505234327.716630-1-skhawaja@google.com>
Subject: [PATCH v2] PCI: Init temporary pci device in new_id_store()
From: Samiullah Khawaja <skhawaja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: skhawaja@google.com, Danilo Krummrich <dakr@kernel.org>, Bandan Das <bsd@redhat.com>, 
	Gui-Dong Han <hanguidong02@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When setting new_id of a PCI device driver using sysfs a lockdep splat
occurs. This is because the new_id function new_id_store() checks for
driver_override by creating temporary pci_dev structs.

Since the newly added driver_override spinlock is not init for temporary
pci_dev structs, the lockdep splat complains about it.

Initialize the temporary pci device to fix this.

[    4.464296] INFO: trying to register non-static key.
[    4.466207] The code is fine but needs lockdep annotation, or maybe
[    4.468487] you didn't initialize this object before use?
[    4.470486] turning off the locking correctness validator.
[    4.472494] CPU: 2 UID: 0 PID: 177 Comm: liveupdate-iomm Not tainted 7.0.0+ #9 PREEMPT(full)
[    4.472497] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    4.472498] Call Trace:
[    4.472501]  <TASK>
[    4.472503]  dump_stack_lvl+0x5d/0x80
[    4.472508]  register_lock_class+0x77e/0x790
[    4.472512]  ? check_prev_add+0xf4/0xd30
[    4.472513]  ? check_prev_add+0xf4/0xd30
[    4.472515]  __lock_acquire+0x3b4/0x1b80
[    4.472518]  ? raw_irqentry_exit_cond_resched+0x20/0x50
[    4.472556]  lock_acquire+0xbf/0x2e0
[    4.472558]  ? pci_match_device+0x24/0x180
[    4.472563]  _raw_spin_lock+0x30/0x40
[    4.472567]  ? pci_match_device+0x24/0x180
[    4.472569]  pci_match_device+0x24/0x180
[    4.472571]  new_id_store+0x189/0x1d0
[    4.472574]  kernfs_fop_write_iter+0x14f/0x210
[    4.472578]  vfs_write+0x263/0x5e0
[    4.472583]  ksys_write+0x79/0xf0
[    4.472585]  do_syscall_64+0x117/0xf80
[    4.472587]  ? clear_bhb_loop+0x40/0x90
[    4.472590]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.472592] RIP: 0033:0x7fe7bc0beeb2
[    4.472595] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
[    4.472596] RSP: 002b:00007ffcdbb1ed80 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[    4.472598] RAX: ffffffffffffffda RBX: 00007fe7bc2415c0 RCX: 00007fe7bc0beeb2
[    4.472599] RDX: 000000000000000a RSI: 00005580955433c0 RDI: 0000000000000001
[    4.472600] RBP: 000000000000000a R08: 0000000000000000 R09: 0000000000000000
[    4.472601] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
[    4.472602] R13: 00005580955433c0 R14: 000055805932493e R15: 0000558095545490
[    4.472605]  </TASK>

Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
Fixes: 8895d3bcb8ba ("PCI: Fail new_id for vendor/device values already built into driver")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

---

v2:
 - Use device_initialize instead of spinlock init
 - Set release cb and call put_device to release
 - Add Fixes tag for the commit that added temporary pci device without
   initialize.
---
 drivers/pci/pci-driver.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..e3f59001785a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -179,6 +179,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	return NULL;
 }
 
+static void _pci_free_device(struct device *dev)
+{
+	kfree(to_pci_dev(dev));
+}
+
 /**
  * new_id_store - sysfs frontend to pci_add_dynid()
  * @driver: target device driver
@@ -214,11 +219,13 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_vendor = subvendor;
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
+		pdev->dev.release = _pci_free_device;
 
+		device_initialize(&pdev->dev);
 		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 
-		kfree(pdev);
+		put_device(&pdev->dev);
 
 		if (retval)
 			return retval;

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.545.g6539524ca2-goog

