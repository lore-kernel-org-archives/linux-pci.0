Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591260;
	b=CWeQFyFKDpU89B5XouXeciHhuVNyjdAxh2X1kHLCkciUZ23D4QjqkzDo6GLY8R6BnzSY
	 kGaad1xrnSwL9OAuD2P84MCsLqbbWYH8lEobevLF+ki7DvWt5ug462+RKc3i+qJCxlU3V
	 5wN7+blWn8wpsraPAa0i7wUktbYbMvEu0BioxpkPdVAQbsJawS/kcpj4DqIjzWrF+gFH7
	 D98LBR6Bmk4d1eVsVtotfRAT4G4klexVGwEKSzB6+OhA8TFWsceBCaG3UWinHK4Mqa6tq
	 9A5zjBBcxz/LEViK8CZvUHXH6dpjdxleosO1fZKa1TaRX8dijNR9KJVBvogLcB2K0sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591260;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=vNXXOctCbKVjtXQCaCxPHHgqQCrdz1BMmTa7T1T11Tc=;
	b=2tzQgvjTMmGSIO6agYLXuWWv6A/iqJY7bRe/Nlj64YEVfailzzRqC8Jx5gmIsNGgcVeU
	 iBbp9CJfWj9jRd3QZNPnktU1OMakARTNvOK7TzRR4pOMRaHvBPcpx2FZnpXYdnZDGCvXE
	 39rtwwg/GxvPMKq2tVX3k0UBSpmBT2YAcQ9jKnF3B1FUhT6qV7pPdWfITAXoMMyp0/ofQ
	 c6bM0GupJAW0WsOwJhsPrsUgh7Lb8y1ia7xgWBMbXW0vs+yksf43mLpuotVdfRDUQoPlv
	 hTYauvkTq7UGDox+45I4R0VPw7MXoxZipWxWzIReOydcu/lsRSBxHIBIRzo7ZBi2XUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAF606A32E
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 03:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06CAF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4a2db303521so2720904fac.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Nov 2026 19:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591259; x=1794196059;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNXXOctCbKVjtXQCaCxPHHgqQCrdz1BMmTa7T1T11Tc=;
        b=zc7BorwKelz7RRUtUEclxBJC4ssWYAOjJbgdaz9qwwGUThSPlPUJ3HGCtBabaod0o/
         +TSKc3OgqU0Sdv0IBwfNLR0qCj6Zu1dW2fGvb8n2LomWnHWbt/DXraAvg/ieX0SPY52j
         JgWedFQjT6B5Y3v1U89mYFSbMqd74ADg0KHJnkKIeamFTtAd4mD30QHfIWUJKjkkYxy6
         rk14sSnnOr3ySkPAxqb3zCi9WCD+kewD/VMeHsoG9tYO7Gq+UY6qz0MubIE0m/VmIXka
         SIIVS6mI8W3tFOTqYZ+k7C9+FIxeowebksWRKUL/vgxnKeWiTq61h2yjX/N2zLNZgI1b
         75sw==
X-Forwarded-Encrypted: i=1; AKwUvBxCnl+ZcE1y2blAeiLPSb5Lx7no0smtK4wzv8OOcclW+iXucbpG6JnAgMH+mqA11oCU4dOsfYh6vFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL0gTGsf1+HiNcwf/HerMuxIZgxeXkl+AAAIrBqapHmqynMa+q
	uPmOHGjbQcUsJJ2/DLt7ag5v9kQP8SGUN0iUdvHS9HTBLKbTyhbZ05DjOuXGaFKxMhTLBU3uYU0
	iG2R2ibKkfOSC1dzzZbjzkSU0vrKwvVIATDAwqSQR3Wzznmlgm0IL6YDzKaY=
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:120b:b0:4e6:6079:c33d with SMTP id
 5614622812f47-5640dcf25f8mr5584715b6e.10.1793591259061; Sun, 01 Nov 2026
 19:47:39 -0800 (PST)
Date: Sun, 01 Nov 2026 19:47:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae807db.c8ffc79a.e3697.002d.GAE@google.com>
Subject: [syzbot] [pci?] WARNING in pci_add_new_bus
From: syzbot <syzbot+ea7278bdcb20a491495b@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36aad21d50d1 Merge tag 'ksmbd-for-7.4-rc1-part2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1501662d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37ec6334ca3b8e94
dashboard link: https://syzkaller.appspot.com/bug?extid=ea7278bdcb20a491495b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127a2cb1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-36aad21d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d729f75149c3/vmlinux-36aad21d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2cbf16f3d26/bzImage-36aad21d.xz

AI-generated root cause summary:
In drivers/pci/probe.c:pci_alloc_child_bus(), device_register(&child->dev)
failure is checked using WARN_ON(ret < 0). When device_register() fails due to
normal runtime resource exhaustion (such as -ENOMEM, triggered in syzkaller by
fault injection via /proc/thread-self/fail-nth), this check emits a spurious
kernel WARNING. Furthermore, pci_alloc_child_bus() assigns bridge->subordinate =
child and updates bridge->resource[...].name before calling device_register();
when device_register() fails, put_device(&child->dev) frees the child bus via
release_pcibus_dev(), but bridge->subordinate and bridge->resource names are not
reset to NULL, leaving dangling pointers to freed memory.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=ea7278bdcb20a491495b

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea7278bdcb20a491495b@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc139c26038 R14: 00007fc139c25fa0 R15: 00007ffe91ac8be8
 </TASK>
------------[ cut here ]------------
ret < 0
WARNING: drivers/pci/probe.c:1272 at pci_alloc_child_bus drivers/pci/probe.c:1272 [inline], CPU#2: syz.3.21/6134
WARNING: drivers/pci/probe.c:1272 at pci_add_new_bus+0xda4/0x12e0 drivers/pci/probe.c:1293, CPU#2: syz.3.21/6134
Modules linked in:
CPU: 2 UID: 0 PID: 6134 Comm: syz.3.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pci_alloc_child_bus drivers/pci/probe.c:1272 [inline]
RIP: 0010:pci_add_new_bus+0xda4/0x12e0 drivers/pci/probe.c:1293
Code: fd ff ff e8 1e 5e 95 fc 44 8b 74 24 18 31 ff 44 89 f6 e8 7f 58 95 fc 45 85 f6 74 dc 45 31 f6 e9 71 fd ff ff e8 fd 5d 95 fc 90 <0f> 0b 90 48 8b 3c 24 e8 c0 c6 03 01 31 db e9 92 fb ff ff e8 e4 5d
RSP: 0018:ffffc90003e3f988 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888050413000 RCX: 0000000000000000
RDX: ffff88802e362580 RSI: ffffffff8578e803 RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000000 R09: 00000000fffffff4
R10: ffff888050413153 R11: 0000000000000001 R12: ffff888024497000
R13: 1ffff920007c7f36 R14: ffff8880504130dc R15: ffff8880565849a0
FS:  00007fc13a9046c0(0000) GS:ffff8880d467f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1399ecc40 CR3: 0000000035790000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 pci_scan_bridge_extend+0x9e3/0xb70 drivers/pci/probe.c:1473
 pci_scan_child_bus_extend+0x449/0x7b0 drivers/pci/probe.c:3138
 pci_scan_child_bus drivers/pci/probe.c:3216 [inline]
 pci_rescan_bus+0x18/0x40 drivers/pci/probe.c:3507
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:474
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc13999f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc13a904028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc139c25fa0 RCX: 00007fc13999f559
RDX: 000000000000001e RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007fc139a36b50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc139c26038 R14: 00007fc139c25fa0 R15: 00007ffe91ac8be8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
