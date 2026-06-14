Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4B30E828
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475404; cv=none; b=PJWLoTVgYyTrm7YFXWAw2pmSzVI+BAeOO3AZKUIdR8am/Nfv2+d/DdeYUgn9Xvu3HxSc/5xJlBEYeQ2UJB3F61pXG6qvCyMNTmMuBIEF8YdzSLI3/d/wweynN0qW3I2Ors9xShI0OtqVInUo6u+OpWBRbRj4BUifJ4AoSVutV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475404; c=relaxed/simple;
	bh=iUnBLVR4167TjxIQ50Hi3WNlAor24JpXMNRmLIMRdDQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLrc6PsLnXIdPDkQ6YDRSDuD1LWf2NqFMQIE8hQPkyZHfe8VHUu9iQl4Ye5YUKk4+S4MLO6bPt6bWrIQ7OfGaEpwwz6gPtrqhH9zACwS9k/h9rVCkB+ELTIUIQoxOqaSjxOFwG6c6lNGo+qeMlhq9Fd8d+U+okG51qitF8a3caQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkjRDCDG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkjRDCDG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5174a3d9598so24212691cf.3
        for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781475401; x=1782080201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/USMUW5QmQOQ0Gq++9KFLj8ScG1j+mHDHbhv/uvoF4=;
        b=kkjRDCDGYhRN90Zj+iTZPt/7d0CujmWAo7I1zVedEf1Js7mxK5cvInstQRaVBbZgrf
         0OkIGFU1TYznntJhOstxdoYp4sNFvDTPUGAJGr0O2D18nJaiw28lVa9YnYXTI+U47oPB
         xzlBxEzsMpEl6XHOX/j5w90oBj74NEtnbqBLMxPnPs5rrvm/lHr9wSjOOo7jJk3jLinH
         HzZR4xkfiqHUiombTd0VPto52IX2Kyf2tWxApcMB4ze3aYbx2r2CblVhdzOr47qqDxSG
         qlXuAB/tjTysN0sZm9CPQ06NDpesSC8WFPUr09tlh5dR8HA5sbF4DaBgtzzqm1FokkB0
         0MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781475401; x=1782080201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/USMUW5QmQOQ0Gq++9KFLj8ScG1j+mHDHbhv/uvoF4=;
        b=XXTCRZ3GR+lbN5TVU/Gh0eB6tJpPOxeuvBNoYCiVaJP4glWGhQIZRxwn5UL8GeZN4f
         8JC8oo/vh1OPaNwijAOcFSwSViOu1bYho8o8CCE9JbFLBOj7okrA6Gb0qNEl4ux7LwKm
         DTQbDKHA9XKTTTqw3rCvkysLZURoAAjamXzXX49ElVg15OgYgnfnBaukkDiIaFWgl/2R
         cBoPp6qDlG4qu0YHJ3PaozJHiQQpMaY6vF9nc4ga2VC4md3Pv+t7N6PQZZMMVwQEZqRX
         S1sE7n6eqZYIRGVBP3MkjOEymsPaYxfTiOuX5LfbULnyeLmzLnIlOqKs9DTsK4WvKYkp
         0LRg==
X-Forwarded-Encrypted: i=1; AFNElJ9pBcOFZlk05IehMIpKsT0gtw25RuckSWCQnBP2vHkUTizIyUbYqdy/hY1xnTlRyWDrivTCb+yLvCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0eA/RJyH6/cNyUxVhtHADUHcpiEiGz4vyN9/Z4GAZzFggl3M
	7KIxe6T81C0VV4lJ/BxwxjP4WgDgu9B8XhH2fMgDrg/RhnYC46+aB3fb
X-Gm-Gg: Acq92OFr9fdQ3/YJqu8WVduC0HD4CAN2nMABMsoLsYbPqowvb9QhZrVIyM2Vo3A4qfw
	Uap/Drnnn+rBlC++k+Vxc7mG37snQenkTt6cUeyEM+pJaiARIMB5zqCbrqR4dAGlkKNu604hPov
	pKECTPqRyXGJvmRZDhdPP3ElUikYgA9sB4CZlZ6SD587fUaTTgn6MPSm+Ffi7TBwiNBub+oB7CB
	otMt45ceiuAOWvXjPQP7EiASRRny/VHA5T3qUxV0v54IjRN9RcUc9zwQWPbHFel/H4+W2UCDQP3
	+wUDYPj5CRuLfHI9eCSv3VI8HSKhJWot8ZFXB2oA6tpZxKT9oFHlDnFFc3ncZttNHtPfQHErcqi
	zs2uvu0//HF3D+Tjt6BcnDD8TXj7VX9Cky2Jf9WXXwILRTGJ3WA47eMe9Ip5QvgCkTt50KaNmyb
	C7qeZ85v7uCZup/q+xUOpxwsp+/f4pUMFCjz3jrA76XpcWHJ0KRVfG80sK9tqpEqdeWyhbdJCo9
	w==
X-Received: by 2002:ac8:598e:0:b0:50e:a1ab:114c with SMTP id d75a77b69052e-517fe4bc66amr171437631cf.32.1781475401111;
        Sun, 14 Jun 2026 15:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb91:14e1:4204:4d87:aacf:f5f1:c2dd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61fb15sm86583921cf.5.2026.06.14.15.16.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 15:16:40 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in pci_endpoint_test_ioctl
Date: Sun, 14 Jun 2026 18:16:39 -0400
Message-ID: <178144969601.60470.7358419009914000395@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in pci_endpoint_test_ioctl

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/1e03464adfefbb75fb5d8112691e38b3

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  222.367023][ T8376] BUG: KASAN: slab-use-after-free in pci_endpoint_test_ioctl (drivers/misc/pci_endpoint_test.c:1145)
[  222.369439][ T8376] Read of size 8 at addr ffff88811be68438 by task pci_endpoint_te/8376
[  222.371748][ T8376]
[  222.372441][ T8376] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  222.372449][ T8376] Call Trace:
[  222.372455][ T8376]  <TASK>
[  222.372460][ T8376]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  222.372476][ T8376]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  222.372531][ T8376]  kasan_report (mm/kasan/report.c:595)
[  222.372558][ T8376]  pci_endpoint_test_ioctl (drivers/misc/pci_endpoint_test.c:1145)
[  222.372604][ T8376]  __se_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583)
[  222.372615][ T8376]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  222.372647][ T8376]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  222.372658][ T8376] RIP: 0033:0x7fd68c893237
[  222.372668][ T8376] Code: 00 00 00 48 8b 05 59 cc 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 cc 0d 00 f7 d8 64 89 01 48
[  222.372678][ T8376] RSP: 002b:00007ffc1aa73f18 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  222.372693][ T8376] RAX: ffffffffffffffda RBX: 00007fd68c9774c0 RCX: 00007fd68c893237
[  222.372701][ T8376] RDX: 0000000000000000 RSI: 0000000000005009 RDI: 0000000000000003
[  222.372707][ T8376] RBP: 0000560e1af360c3 R08: 0000000000000000 R09: 00007ffc1aa73e27
[  222.372714][ T8376] R10: fffffffffffff64d R11: 0000000000000206 R12: 0000000000000003
[  222.372719][ T8376] R13: 0000000000005009 R14: 0000000000000000 R15: 00007ffc1aa73f80
[  222.372731][ T8376]  </TASK>
[  222.372735][ T8376]
[  222.392098][ T8376] Freed by task 8376 on cpu 0 at 222.263660s:
[  222.392729][ T8376]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  222.393215][ T8376]  kasan_save_free_info (mm/kasan/generic.c:584)
[  222.393743][ T8376]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  222.394242][ T8376]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  222.394657][ T8376]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[  222.395176][ T8376]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[  222.395807][ T8376]  unbind_store (drivers/base/bus.c:244)
[  222.396280][ T8376]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[  222.396832][ T8376]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[  222.397273][ T8376]  ksys_write (fs/read_write.c:740)
[  222.397725][ T8376]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  222.398207][ T8376]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  222.398823][ T8376]
[  222.399073][ T8376] The buggy address belongs to the object at ffff88811be68400
[  222.399073][ T8376]  which belongs to the cache kmalloc-512 of size 512
[  222.400509][ T8376] The buggy address is located 56 bytes inside of
[  222.400509][ T8376]  freed 512-byte region [ffff88811be68400, ffff88811be68600)
[  222.401905][ T8376]


Best,
Shuangpeng
