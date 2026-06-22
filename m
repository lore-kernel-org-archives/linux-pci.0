Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13135203A
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100912; cv=none; b=bE+qeiSykqoXUvVE4rQovOpb0A/4O0wt7g2WwauUtYvXHaQk61dOnT0s5lTAI5jS9wWivUxlUpCpYGjWYCloVg1fICRUAQGzsqKRnhX7ypAqVdRIsSjsT9yQDvb/KFMssx8Rx2vqrInv/P0mhYJIknPaojhiiKBXJ62KAtEXQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100912; c=relaxed/simple;
	bh=19sCJyPWCM00fWxbvSdBYcy4yH3JWfYtpDfFnrFmaTo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=TgFTaVAzSk+WVZ8ie8ovBE6mntsIkKWCo7pNlch1wXZYJ/a5kDLEQ6DWN6vZfASVFwNxF9Ye03oUL1gHkMfrEwetvMlkm+cP0kPjBiSKMYDsQyTHhMgSK1Af9jpSd+Ljgt958rsAarElxdLAjm6QI1hnAwjp/neX0aasCnXOCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZrhTIoz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZrhTIoz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8dd586317ccso36944856d6.2
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782100910; x=1782705710; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCKCvEKcIAbbLzhVk7tgcr56H+29gkKFj7JV8ys4ro=;
        b=UZrhTIozo8EDkYeldd0eEDegHBihbDXr+8PDKepplDdFbXqVn8rWNu/wIAWCDIG5Ze
         PRwAEHvC41ldtdI8kThzt0p9x0IhUua/EsNsT7Xy1tSwfD6SVAX2bwXqq6FeYXBjCe89
         XHmpP+74tAJLL71pZVNcgi85rkARY8EDtUo68he41H8Tnyuj5VUdoxAZrpuo2Q48VxFj
         Vx/3JU2ZE46lrq8ukRSi0+aA1pvXwEQAsuniOSGlI5VOyD3yJ0b7KrpN3/QqAN2RxpYK
         5LAaGAFyHGx1oSc/6UpiTdtNXiBmqxsvOqnu4lh47Ltpj/MzQzXH/pFV5aiLzEVvXfIG
         XIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782100910; x=1782705710;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzCKCvEKcIAbbLzhVk7tgcr56H+29gkKFj7JV8ys4ro=;
        b=aJbdBbmoFLpvheMKvv39gFfc21i9VtSM9naW3Yvzbi8Wd5b7BKXWbseot5EoV99g8h
         VtvzQvBI1stGOpkyLw7IlhrV0Av6yxZ7LBUtRqmLHVOXkQEJ0ygzE/zAWYuwMuTGzokz
         kkrPkzqFti/K8Oh2mq1pHDpmkFEryvY4fGqe7HpnreZdJf6FjhbyuTJ/Taof18Jm7AG8
         YDsWUQo1ucgmyUctf1rEk4xKJWVu3sGYX0NoUu3ggUrxQUdCO9SeI60sKe12zts6/yDQ
         fUS8InoAY3e6OL58Q85g/2786RUqw9Cht1EvzUDNwH+iYP+1kX+D2byOQwOjrSQJedba
         mYdw==
X-Gm-Message-State: AOJu0Yw3JhqAlli5LpsUJ3tCK4m+Z+rdh+kZTyOvzcLAhkVMOQwSiGkm
	5eTqUTiIvGVRt5ZceoJMxKPgcAORXIzMppE0hItje3Kv+/J8ZEI3ROkJnl3OZI+Y+l4yIw==
X-Gm-Gg: AfdE7cnBr7KJo4v7Nv68yd7CKujxkqfKCvsE16g32v3uQ1hKe2iiBts7PlRR1xX4ugh
	EuxekmoPyQLjrXzRQLD+NB5Lm61U+UF7WkvjkooTnIiK/vjV5egU9/KFCUpzGSXO3nh/AvVW1o6
	Z6ZGOhTT5HiW8r9PBGUT2BDxR6+K6fCYfetjlzEoRmsb6dRfj4omlQwwh0TJYVTsT8pRu6b3ywh
	VFc5FrKbDZMeqOOc+aMxzKiW127GkHSSPKv44JCLHNPVK7viAFiXTWVMk8WIZSwYHJ9/H1etgJw
	3ZlmcnBJAYSN3sELZtazudwPo6H6+hmEMocxvQN43uRl82IZi1Q04HESRohWEJejRBLkzsadEEk
	wsWQ76SjoL8QJwg9tYtS94M5sGdhV+jI6EDXrAUNsdDUEHjB5LfDh9+jdE2lVD7hygI3oWJtXAX
	rIAIb+iG43j+UaExhAgFnhv1E52rI5GH/2WL0J6ld5fICJ3ihIyii0HEqw4sRqmLo=
X-Received: by 2002:a0c:cd87:0:b0:8dc:30ac:e011 with SMTP id 6a1803df08f44-8de42744f62mr169552606d6.42.1782100909696;
        Sun, 21 Jun 2026 21:01:49 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:c86d:bd73:bd2:2455])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdeebbsm86787196d6.29.2026.06.21.21.01.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 21:01:49 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] PCI/VGA: KASAN slab-use-after-free in dev_driver_string from
 vga_arb_release
Message-Id: <330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmail.com>
Date: Mon, 22 Jun 2026 00:01:18 -0400
Cc: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: bhelgaas@google.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in dev_driver_string from vga_arb_release

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/47ec0715a0120beaacf5009460b90687

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  250.268327][ T8342] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  250.271034][ T8342] BUG: KASAN: slab-use-after-free in =
dev_driver_string (drivers/base/core.c:2406)
[  250.273371][ T8342] Read of size 8 at addr ffff88810aebc138 by task =
bash/8342
[  250.274604][ T8342]
[  250.275019][ T8342] CPU: 0 UID: 0 PID: 8342 Comm: bash Not tainted =
7.1.0-rc5+ #106 PREEMPT(full)
[  250.275027][ T8342] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  250.275031][ T8342] Call Trace:
[  250.275044][ T8342]  <TASK>
[  250.275049][ T8342]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  250.275108][ T8342]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[  250.275177][ T8342]  kasan_report (mm/kasan/report.c:595)
[  250.275190][ T8342]  dev_driver_string (drivers/base/core.c:2406)
[  250.275196][ T8342]  __dynamic_dev_dbg (lib/dynamic_debug.c:906)
[  250.275228][ T8342]  vga_arb_release (drivers/pci/vgaarb.c:1436)
[  250.275245][ T8342]  __fput (fs/file_table.c:510)
[  250.275260][ T8342]  fput_close_sync (fs/file_table.c:615)
[  250.275265][ T8342]  __x64_sys_close (fs/open.c:1507 fs/open.c:1492 =
fs/open.c:1492)
[  250.275271][ T8342]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
[  250.275327][ T8342]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
[  250.275333][ T8342] RIP: 0033:0x7f65140dbc03
[  250.275341][ T8342] Code: e9 37 ff ff ff e8 2d f9 01 00 66 2e 0f 1f =
84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 =
00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c =
24 0c e8
[  250.275346][ T8342] RSP: 002b:00007ffce08e3808 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000003
[  250.275363][ T8342] RAX: ffffffffffffffda RBX: 0000564bd1808ba0 RCX: =
00007f65140dbc03
[  250.275367][ T8342] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: =
000000000000000a
[  250.275371][ T8342] RBP: 00007ffce08e3890 R08: 0000000000000000 R09: =
0000000000000000
[  250.275374][ T8342] R10: 00007f651417efc0 R11: 0000000000000246 R12: =
0000000000000009
[  250.275377][ T8342] R13: 0000000000000009 R14: 000000000000000a R15: =
0000000000000000
[  250.275393][ T8342]  </TASK>
[  250.275395][ T8342]
[  250.295059][ T8342] Freed by task 8342 on cpu 1 at 249.233016s:
[  250.295689][ T8342]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[  250.296168][ T8342]  kasan_save_free_info (mm/kasan/generic.c:584)
[  250.296682][ T8342]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[  250.297176][ T8342]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 =
mm/slub.c:6251 mm/slub.c:6566)
[  250.297593][ T8342]  device_release (drivers/base/core.c:2570)
[  250.298062][ T8342]  kobject_put (lib/kobject.c:689 lib/kobject.c:720 =
include/linux/kref.h:65 lib/kobject.c:737)
[  250.298528][ T8342]  pci_stop_and_remove_bus_device_locked =
(drivers/pci/remove.c:132 drivers/pci/remove.c:139)
[  250.299187][ T8342]  remove_store (drivers/pci/pci-sysfs.c:525)
[  250.299631][ T8342]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[  250.300179][ T8342]  vfs_write (fs/read_write.c:595 =
fs/read_write.c:688)
[  250.300622][ T8342]  ksys_write (fs/read_write.c:740)
[  250.301054][ T8342]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
[  250.301525][ T8342]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
[  250.302121][ T8342]
[  250.302372][ T8342] The buggy address belongs to the object at =
ffff88810aebc000
[  250.302372][ T8342]  which belongs to the cache kmalloc-4k of size =
4096
[  250.303772][ T8342] The buggy address is located 312 bytes inside of
[  250.303772][ T8342]  freed 4096-byte region [ffff88810aebc000, =
ffff88810aebd000)
[  250.305161][ T8342]

Best,
Shuangpeng

