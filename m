Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5381FA272
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954111; cv=none; b=kvTRk1tx+wmosty/09mxQv9YFGMyTRQRckC4CqXjmw2U9S8vS3vq114wAFesTz0dc0F/ruGcpjEeNmueH5BQGX2f3fBaixe8lDBOs/GlY2OuiPYTNBM2IzwE9aKqD4Z44wajBTS3vt52krhPocefXQYijlTNfjaX4/8H9b/Uh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954111; c=relaxed/simple;
	bh=poZ3u02bBJHnXU0CjUEuHdqJ5cCpVdT2DgPI86zHjus=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=syRH2PjB9ejzEK+XBwFjQ/vbeVHPQLwQfr4eYODUdEqVsDU+mYfXbZqD2ZEBXBqAo1KTU5Qpxbrebw+yFbUS9W38QW/iia08Ua1wcMuD0cuTO0xfpLmbJixG+BbYlAHA2z6nBItuTHYB4m8YYNEmjL+BDTiWrMGR1w20LFt3SWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-4040e71a7f6so7893197fac.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 16:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768954108; x=1769558908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tWU80pBORoXjwhazKdstV6RnNsxWYh93JI9DEe5lmU=;
        b=NLnw4BNC3tJvHKb9yt8mtT01EAxPQVDDOPNqF5W7JmhfMUEvWleUIcLxPeF5HKSV2T
         ALB/PJMSKiDDvGdMr/rvyFjy17QnCEzUZpqPABYass+HRpimrwRED69+VfBr4QfjFihQ
         2DN3SPsv6U2mAOb5GRtsKmtiDb+HLpqZhFZbb2S5jt8PiYH8MChSmf2vrEGhEZsK8b/X
         7pJGeJeNv5x9pq2TPtebMdOg1KNYNtDytWVJRP1/gAuoapHYBOUwbxsPupMajf8eWT8f
         3GhR651NmrJm+fGawOgrxpX9VIHcAdS87W8QCQk6GBcaFgYz2RhAB29ex2UO1xLNbI1W
         +Egg==
X-Forwarded-Encrypted: i=1; AJvYcCWQQDCtyVARym5ctqEc4jzXuSTreIksEIfqQTPB8ur2Sl/C7JcUKcvjD5kzOlDuOZdg4ExlulUC1bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaP8rfLndDIZ8X72D8HmNGcI772y3jJ43Ge2vRpmtF5rOZKz+4
	8Oue2+KNs/x8SrNwNyt5fw11Smo6wTprTJCyZfGIZyj26faqLnzm9rroK6qTQYY7+hHoyvfjTMZ
	W4TC/PPtOwGQcY46VkPO3YZ+soGiFjbWBg2jbqUrICgLbzSARTvaAjRu5d88=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c98:b0:65f:6994:314c with SMTP id
 006d021491bc7-661189244e3mr6784690eaf.53.1768954108579; Tue, 20 Jan 2026
 16:08:28 -0800 (PST)
Date: Tue, 20 Jan 2026 16:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697018fc.050a0220.706b.0003.GAE@google.com>
Subject: [syzbot] [pci?] WARNING in pci_scan_single_device (2)
From: syzbot <syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    983d014aafb1 kernel: modules: Add SPDX license identifier ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10658852580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be
dashboard link: https://syzkaller.appspot.com/bug?extid=87bb32e345aa80c0554b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a294469166c/disk-983d014a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9504a6df5a7/vmlinux-983d014a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88a1d939d6af/bzImage-983d014a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87bb32e345aa80c0554b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: drivers/pci/probe.c:2800 at pci_device_add+0x105e/0x1490 drivers/pci/probe.c:2800, CPU#0: syz.5.1730/14510
Modules linked in:
CPU: 0 UID: 0 PID: 14510 Comm: syz.5.1730 Tainted: G     U       L      syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pci_device_add+0x105e/0x1490 drivers/pci/probe.c:2800
Code: e5 04 83 e0 8f 09 e8 88 83 c0 00 00 00 e9 ef f2 ff ff e8 85 7a d6 fc 90 0f 0b 90 90 0f 0b 90 e9 ee f4 ff ff e8 73 7a d6 fc 90 <0f> 0b 90 e9 c1 f7 ff ff e8 65 7a d6 fc 90 0f 0b 90 e9 54 f7 ff ff
RSP: 0018:ffffc9000bb5f938 EFLAGS: 00010283
RAX: 000000000003659d RBX: 00000000fffffff4 RCX: ffffc90015bd3000
RDX: 0000000000080000 RSI: ffffffff84e7e38d RDI: 0000000000000005
RBP: ffff88801bae0400 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: ffffffff81000130 R12: ffff888142e87028
R13: ffff888142e87000 R14: 0000000000000001 R15: ffff888142ea2000
FS:  00007fa6b528e6c0(0000) GS:ffff8881248f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000058e000 CR3: 000000007e2d4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 pci_scan_single_device drivers/pci/probe.c:2824 [inline]
 pci_scan_single_device+0x252/0x310 drivers/pci/probe.c:2810
 pci_scan_slot+0x1c0/0x760 drivers/pci/probe.c:2907
 pci_scan_child_bus_extend+0x6b/0x7d0 drivers/pci/probe.c:3126
 pci_scan_child_bus drivers/pci/probe.c:3239 [inline]
 pci_rescan_bus+0x18/0x40 drivers/pci/probe.c:3530
 rescan_store+0xfb/0x130 drivers/pci/pci-sysfs.c:472
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa6b438f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa6b528e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa6b45e5fa0 RCX: 00007fa6b438f7c9
RDX: 0000000000000001 RSI: 0000200000000200 RDI: 0000000000000003
RBP: 00007fa6b4413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa6b45e6038 R14: 00007fa6b45e5fa0 R15: 00007ffd9a287b48
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
