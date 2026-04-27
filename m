Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA241B362
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318321; cv=none; b=BgYMCq3EOYDJvGufTKcwuoAdsYuycVVcoYOzdlsVQz1+azQNq2rhQ/a9Gg6JWG3RVElD5fJfzEVLu6LRuPATjK+hODxyFiIQXplWwV8UvIxs2ZXRNR2P39gmduMdZPVAX1QcDzjBGVWNDo7lFr14FqlELqHIKF0aZQKeFQCPUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318321; c=relaxed/simple;
	bh=LVmCeMbPONRbWHAmNFPGHdz4QzY8fHP3vOP6GzcGnRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VgyN8zzNM5NWBGBzuNRrJXZxawnu5dI7XVmZOZVzUXUEuOg/KNRRk7jb7oEu2JosMeX0PAthYWNfU2nl2mQ1EGlcysJk4fFa2ZUTMxGOpddUMUNPZnxAQ6QUGKVgW1JCa21ndIViQ/HfeHDUdWQyRGcjm6jkc/QMnPRHH20oJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYeTMuAe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYeTMuAe"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e6ee9444so114248335ad.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777318318; x=1777923118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snPdlzVdOYUMpgWp4O8YWqXKWZOQ7VLQKeDCjnOdDtE=;
        b=DYeTMuAeP/GoKy2Dhhs3rvzRf2vHU2G61rL1gUIeND9t3PYoAQNblwMmxwoYXeT68g
         H4UIdyp6ZuM1usHZpAFe5hZT4WxcFIsSaQi3c2Xcdz5BSzDe7jLBsklpFb+RRk9MCXtl
         G260v/VF5VQXMFwnbpf2igjRMfjK9OHBchx99mQE7LY93GtAg/LKIzQtZU9kdkQdvhYF
         K9nKBKQXoUNgGUK9xIWYNHr0Y4wHToTNQ0oXMDZUvcXXsnM31GYpAT4shxwMvgZgdLcH
         nfIfEgnMc78HZjnUgH69zYEl6GGV+CaaegoQmYHOZm76rx1H9i70QJSmYMZZCPH4Ob80
         PtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318318; x=1777923118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snPdlzVdOYUMpgWp4O8YWqXKWZOQ7VLQKeDCjnOdDtE=;
        b=U5FJuMJPukrCi0HyWwbTh8GjzTnP1JZVh9zqMgHNtIBxazcypL8WyJKWeG8PaqWIJW
         S38SIxnwadY+7cXhoZL990g6JWVVGkWja2bOqM4r5ulR/u4Zh7GLBEPQBIw6l552HjVY
         ifAyIP9Q718da8t0Cto3Hv7g6QBNJYkLXgAWlzdMi6wmrMGWKfbDklF+o/WIdLnFIh47
         QE9XctYWlZtP2srDFCDhW4e9GgyDRgLBGb4niwz06oscz/hrBPFBjHSWbweZ2iAhToXS
         ahyr0voVoL39woTH5Guqd+jbpdfLuZTCr7ADPoeHpeyYkkDeMFovwPReiZaG8gnk35Gi
         9xbw==
X-Forwarded-Encrypted: i=1; AFNElJ/E8BBZH1PJS7vPpRhzYAT1TecNUgUkOIRpEJRPM1HsAtU9p++eC8cWoc8goL/CP/v06cHMJfUX8H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ysyKnTet7mAZC3Z+1823b8+OgyHRDB7TJ6k/9f42KJSO05ZR
	Hy+DzF7vj+986OqWVsdn9xJApYZK++12uhQj+BpfXJHUnlJBp1mnVlDLgjG37PdyrBzFERVpuA9
	4NCBvS6L4b8IjSw==
X-Received: from plda4.prod.google.com ([2002:a17:902:ee84:b0:2b0:af2d:2502])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1107:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2b97bfd91e7mr146815ad.6.1777318318229;
 Mon, 27 Apr 2026 12:31:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427193139.2109938-1-skhawaja@google.com>
Subject: [PATCH] PCI: Init driver override spinlock in new_id_store()
From: Samiullah Khawaja <skhawaja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Gui-Dong Han <hanguidong02@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alex Williamson <alex@shazbot.org>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: dmatlack@google.com, Samiullah Khawaja <skhawaja@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

When setting new_id of a PCI device driver using sysfs a lockdep splat
occurs. This is because the new_id function new_id_store() checks for
driver_override by creating temporary pci_dev structs.

Since the newly added driver_override spinlock is not init for temporary
pci_dev structs, the lockdep splat complains about it.

Init the driver_override spinlock to fix this.

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

Fixes: cb3d1049f4ea ("driver core: generalize driver_override in struct device")
Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..5f453213b8c5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -215,6 +215,11 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
+		/*
+		 * Initialize the embedded struct device driver_override lock to
+		 * avoid the lockdep errors.
+		 */
+		spin_lock_init(&pdev->dev.driver_override.lock);
 		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.545.g6539524ca2-goog

