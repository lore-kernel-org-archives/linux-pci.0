Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60337EFF8
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763713; cv=none; b=Cv6/4cKaKODUk8//x3kCpHRcsoe6c8upuIuhlX7toB+umddGMiZchsnKUB+4RhilqOiyjXSp0us3Aa1OkcwxoNHYeC28/i1fm/IoHqX16GR9Vo+a5fbHNh3ZV4xNTbSkgAn6j9OjVGzF4SUY8Mqa0WuKlMg+VK/RMlIH6HGz8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763713; c=relaxed/simple;
	bh=w15suKsWFvnl/SbNHI/YWs/B61oJZUiIks8mIiL/ciw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YUqqpF9JcqZD8Frt4W5TDArk0U64ybni8XNo88LXpf7ae50q7nDmomkw46jOIhugNQ/pqxh95pvVOMfQ3kDNoKa8Njy8Jg3c/RaXpGT5rDVRuH9+Q32lJw2j91xMGGMXXU1mpDFJYF/uPh9Ejj86fsFuNV6lBRaq1NPc0LRDYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.224.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66cc65a15dfso1795921d50.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 10:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763702; x=1788368502;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zpkb59MZ3xKKGRCh9R6EynX+Nh2apKlX3tYGFftwGAo=;
        b=VwLkehjkzjmHPuqQtBtfRTI6LFg6rTDTH5/hJjAj3xjZA2F0snz75I9+zXwR7y5A5d
         ygHXno72RbhkLYRI6pUDhcNB8JRjfxVHEMlQTzPPf+Z2MpIc+nrywaccNStTEd0EVxL0
         Bwd84XUt+c86MSDonBCyOPXiXu0jBSQteK8Iht8Fy72RCs7XXcU5AKf+b/P+yOcPIB5D
         hC2BQypCikuF0IJB9SIo2X1uotqYx+FKiI/vLuYrLOTibsrw0Q54QCQFmzwuYgpnDwQd
         FPJnqr7VZxElykuD2GHdPtdOo9LFPxTtS0kGTrb3fbcdtnV9KEBt0ID4gG3Qchfwgp1k
         G1Uw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/EDFCyNzxP+gFfs/RHagp6POxueQts73u9G8jY96elH51bZ9yAvcvgnV2p5fzO3AU9rK9IhvZTK8=@vger.kernel.org
X-Gm-Message-State: AFuF++mumLG0bqRjzJipVgDHKUc+EOU886Wqr7+6/olZP7EL1F1UBJHm
	zrj26rF63wbEcFArY5Q6YMrM7+DgHLC+DQVJ9Yhf8xEGWkFkox1ph1U3iRCkumhTcgJJb2b/O2+
	nTAkhwMwj+x6rEiDLUi+SCnfA/DcMjGIk3La9lwYh3Yb0p86QxN48cAHDzDc=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a53:e849:0:b0:66d:112b:769 with SMTP id
 956f58d0204a3-66d25663260mr2084976d50.1.1787763702629; Wed, 26 Aug 2026
 10:01:42 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:01:42 -0700
In-Reply-To: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8f1bf6.50659fcc.60cd.0004.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING: proc registration bug in
 unregister_irq_proc (2)
From: syzbot <syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, bhelgaas@google.com, dakr@kernel.org, 
	driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17569625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=690d666eb12fca6e1e61
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ce979580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com

------------[ cut here ]------------
remove_proc_entry: removing non-empty directory 'irq/17', leaking at least 'comedi_parport'
WARNING: fs/proc/generic.c:747 at remove_proc_entry+0x4e7/0x610 fs/proc/generic.c:747, CPU#0: syz-executor143/6008
Modules linked in:
CPU: 0 UID: 0 PID: 6008 Comm: syz-executor143 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:remove_proc_entry+0x4f5/0x610 fs/proc/generic.c:747
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c7 00 00 00 48 8d 3d 39 b7 88 0e 49 8b 95 d0 00 00 00 48 c7 c6 80 39 0b 8c <67> 48 0f b9 3a e9 2a fe ff ff e8 4c 2b 4a ff 48 8d 7d 18 48 b8 00
RSP: 0018:ffffc900032af7b8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: ffff88803dac74dc
RDX: ffff88801cb025dc RSI: ffffffff8c0b3980 RDI: ffffffff91498da0
RBP: ffff88803dac74b8 R08: ffff88802b20f75c R09: ffffed1007b58e83
R10: ffff88803dac741b R11: 0000000000000000 R12: ffff88803dac7400
R13: ffff88801cb02500 R14: ffff88802b20f738 R15: dffffc0000000000
FS:  000055558ac37400(0000) GS:ffff8880d5ba2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efe6b5a6130 CR3: 000000002bb43000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 unregister_irq_proc+0x206/0x2a0 kernel/irq/proc.c:406
 free_desc+0x89/0x330 kernel/irq/irqdesc.c:482
 irq_free_descs kernel/irq/irqdesc.c:874 [inline]
 irq_free_descs+0x84/0xc0 kernel/irq/irqdesc.c:865
 irq_domain_free_irqs+0x46a/0x5c0 kernel/irq/irqdomain.c:1919
 mp_unmap_irq+0xf8/0x130 arch/x86/kernel/apic/io_apic.c:1061
 acpi_unregister_gsi_ioapic+0x40/0x60 arch/x86/kernel/acpi/boot.c:722
 acpi_unregister_gsi+0x25/0x40 arch/x86/kernel/acpi/boot.c:751
 acpi_pci_irq_disable+0x275/0x360 drivers/acpi/pci_irq.c:517
 pcibios_disable_device arch/x86/pci/common.c:706 [inline]
 pcibios_disable_device+0x89/0xb0 arch/x86/pci/common.c:703
 do_pci_disable_device+0x9f/0x100 drivers/pci/pci.c:2192
 pci_disable_device+0x130/0x270 drivers/pci/pci.c:2228
 enable_store+0x219/0x260 drivers/pci/pci-sysfs.c:342
 dev_attr_store+0x58/0x80 drivers/base/core.c:2509
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d19fda9f7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffff688d7b0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055558ac37400 RCX: 00007f8d19fda9f7
RDX: 0000000000000002 RSI: 00007f8d1a0120f4 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f8d1a012129
R13: 00007f8d1a014458 R14: 00007f8d1a0120f4 R15: 0000000000000015
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 fc                	add    %bh,%ah
   2:	ff                   	lcall  (bad)
   3:	df 48 89             	fisttps -0x77(%rax)
   6:	fa                   	cli
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 c7 00 00 00    	jne    0xdc
  15:	48 8d 3d 39 b7 88 0e 	lea    0xe88b739(%rip),%rdi        # 0xe88b755
  1c:	49 8b 95 d0 00 00 00 	mov    0xd0(%r13),%rdx
  23:	48 c7 c6 80 39 0b 8c 	mov    $0xffffffff8c0b3980,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 2a fe ff ff       	jmp    0xfffffe5e
  34:	e8 4c 2b 4a ff       	call   0xff4a2b85
  39:	48 8d 7d 18          	lea    0x18(%rbp),%rdi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
