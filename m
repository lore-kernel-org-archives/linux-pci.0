Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F51470446
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932298; cv=none; b=e7g2heuDMwEn8jIIggcEXJ/qQenEToxOKeuHls5Rt9yR5T00KZjT3LgpOCOwisTQzF5xUHrnhM5+nZ4tPeg3roCtOvZNDKa0oogKyAQQtGFY+tvaVhcnCrWARCxpWRj6No6hgRjWyI6gLmWHteVcmQLW4LKBPdHc5XvxfkyXx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932298; c=relaxed/simple;
	bh=ZYq9dRUXPU97OYV9bQZfV/ys9GqUxznB9+mTBZ4KNZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UHLJTD/Fx48PWeVwHTljpBcxjltDZRMFONOl8fZSOF37Ntn0jYlPoqnwV5LVdeMTisL9sgh7yuGI2ac/WG/qWlWDEW6h2doRojsrA9OBWwbcGL3PvMSnr1/bc61bqlsOlvp0Drbz/niQKqqFQ/gjfz/QljV1xuQcFxLCo+Pn28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9fdc2870fso433955a34.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932296; x=1785537096;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xOe/WW6uluWiRSXni0Zhqb6IuP/aDWEl8FcTelSXhf0=;
        b=PjNHdxOTTqKNOcj07tfrdhSlzpNG7rEIHuc7eA4F0Qc9XRYSmMqQCdv9m4l8TkFteu
         Fk3AoFK8RSeEi1c3lJ7/mpBYa59PC8dRbKsAkyxPDeuWo8hwbQWtK6AsXRpdG0CgMlfP
         gxEDCLyPtD9iIg7QdDc8aoqD9GtOzqRpt7EoeTMc4DwBnC1DBUj4df7xUii4/3WwDhGm
         ll22rWWU3v1HP8Qo43R8MqodcMQwaUzFm0O0SQ1NsEJSUjF+BAX18a/nbLQWZpOUaJXe
         ONI7LkmXafJjjndIP/ZURas0z4n9f0T5B/k6J05YV0v4eJ/B74hzdB+EKr+LkrNzsJ7f
         zmnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrg6GRrs2mCFHA6YCshr1y5kRc4gMusdqEJMD2+cMuBrwqb1vdU8JGHqW6lwk207aRXvio0PkEN1aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrmC64f5n68mbJth63S/aAB/eVXCqQ10UiT3cNMPcwipe0Efc
	vkU+b/azkUCo//NiNYO71tbwT4Zm/x2GoM45hbBbN49sD/yhXrX0csi2rbYQCGN/aIz88R3RSPe
	88ddmq/nBvythr6xK+2I0Vnlr0nsX/Nl2CubO9pf3o8kNkO1njjuBRTj/2Kc=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0c:b0:49a:8f0d:cdbb with SMTP id
 5614622812f47-4ab6a223eebmr377982b6e.31.1784932295736; Fri, 24 Jul 2026
 15:31:35 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:31:35 -0700
In-Reply-To: <697018fc.050a0220.706b.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a63e7c7.70955b6c.323240.000b.GAE@google.com>
Subject: Re: [syzbot] [pci?] WARNING in pci_scan_single_device (2)
From: syzbot <syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com>
To: bhelgaas@google.com, kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    48a5a7ab8d6a Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c02499580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=87bb32e345aa80c0554b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1677d746580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158932ea580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-48a5a7ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ed725bee82f/vmlinux-48a5a7ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/110c09c210d5/bzImage-48a5a7ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com

 </TASK>
pci (null): [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
pci (null): BAR 4 [io  0xc0e0-0xc0ff]
------------[ cut here ]------------
ret < 0
WARNING: drivers/pci/probe.c:2768 at pci_device_add+0x133b/0x1810 drivers/pci/probe.c:2768, CPU#1: syz.0.17/5936
Modules linked in:
CPU: 1 UID: 0 PID: 5936 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pci_device_add+0x133b/0x1810 drivers/pci/probe.c:2768
Code: e5 04 83 e0 8f 09 e8 88 83 c8 00 00 00 e9 28 f4 ff ff e8 18 a3 ae fc 90 0f 0b 90 90 0f 0b 90 e9 0e f7 ff ff e8 06 a3 ae fc 90 <0f> 0b 90 e9 7e fa ff ff e8 f8 a2 ae fc 90 0f 0b 90 e9 11 fa ff ff
RSP: 0018:ffffc900037a7928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffea RCX: ffffffff855bb419
RDX: ffff888025a72540 RSI: ffffffff855bb99a RDI: ffff888025a72540
RBP: ffff88801c2e9000 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffea R11: 0000000000000000 R12: ffff888022e6f028
R13: ffff888022e6f000 R14: 0000000000000001 R15: ffff888022e92000
FS:  0000555591741500(0000) GS:ffff8880d5ede000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055af1cf515a8 CR3: 000000003dca4000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 pci_scan_single_device drivers/pci/probe.c:2792 [inline]
 pci_scan_single_device+0x1d0/0x240 drivers/pci/probe.c:2778
 pci_scan_slot+0x1c9/0x7c0 drivers/pci/probe.c:2875
 pci_scan_child_bus_extend+0x6b/0x7b0 drivers/pci/probe.c:3094
 pci_scan_child_bus drivers/pci/probe.c:3207 [inline]
 pci_rescan_bus+0x18/0x40 drivers/pci/probe.c:3498
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:473
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe44799de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce5639058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe447c25fa0 RCX: 00007fe44799de99
RDX: 0000000000000001 RSI: 0000200000000800 RDI: 0000000000000004
RBP: 00007ffce56390c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fe447c25fac R14: 00007fe447c25fa0 R15: 00007fe447c25fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
