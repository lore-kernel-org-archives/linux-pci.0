Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683754781
	for <linux-pci@vger.kernel.org>; Sat,  8 Aug 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220308; cv=none; b=udbapgRywGBPTXCO18qOnNKhJ3KnfHXR8UUjd+6QpboH0AxlrfBRVz1++QxEcMDua78m9tZwwTnuENqXE45+ZCrs/A5V3WpIfibQiUXXcmxsSWRjZDVO8Y3Dih9nsVAlubuQdB3WTLHkb4aeSSsko2zgOfUIytXGcREgnLL/5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220308; c=relaxed/simple;
	bh=gu6oJQ+L+B9xxuIVgCsdKhynM5eSghIGS/KzzsDwHlY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qEziYWV/dLkKr3OAn8MIJA/Fl0ZmRwQq7WYtVHbKmNHbPWwrcGpiKTEmJlyrHOQ0purSoaZUGJKVSWVcyH9b4sbklgI78Hd0hmB8VYT/F9EA9d/d602Ys8FJJdxQeVqRa0Uk/WB0qCEvQLkeXw4UJLZdYKe00i+geSkrJXKRYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a41f46d629so1021421b6e.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Aug 2026 13:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786220306; x=1786825106;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsO5WEB9CVKkvd59GJIFZUvlgolm7RAy7EjzjEByheg=;
        b=h4svqyIMeLjhSVwXKoFR1p9IqBvigiRRbFGgAc/k/UNO+MgnDlYeLAcvJxCwE8LsE/
         APta9fcsqoF6tN3ddj6d0QC0Q4UUk6XLmxTnar32EFZFRTzrYSfblaLh9mpbA323fder
         UvdMlZwZ7GcnxTKBrCua0qz1iM1g25/BDsgceAGVIfrFaAOcVFxNs+QglmAUDiTL3WmS
         6I8yAak5KFPoIpW+f/YDz1KzYCLR4M+HL4kkKedbiRil9BgJS73caOWksLEL0wv1zUiX
         J46/0B/CRE8hgmntktkiuMnOfZWP8x3HvvUZ3zaNIA1m09UceOT6Oqv1TxvGnlE8RiOX
         2iPg==
X-Forwarded-Encrypted: i=1; AHgh+RoITBG0W6kQNXlI9nyHTN6qqDQpsfnmI30ti79OqJGt/+7YIW29yJrOCnoV/bmKdxZjHnhIaBwe5h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypdd/7cpjwlNrJnp+ckoXIAW8+67/DppBuMr33PS+HjFNCcXRM
	2srQkCBatg4rkKOYS3Va8Zo4D6c08WaSPoxSp7Usx9gbvLOBOCi3nVpOAuNPSAPX1/BYHeRUm2Q
	Yc6OtKFaLDe9S+qvy6UMVQZDaY4i5KJRyCiPdtcCd29tz2QlFyIv7u5zuUNA=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:168a:b0:4b1:540a:df99 with SMTP id
 5614622812f47-4b1a108a299mr7185680b6e.21.1786220306120; Sat, 08 Aug 2026
 13:18:26 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778f12.b50370da.49fe0.002d.GAE@google.com>
Subject: [syzbot] [pci?] BUG: unable to handle kernel paging request in pci_resource_io
From: syzbot <syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba5cc80fd326 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6afb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f4a132580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1398efb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/959ad5f4e730/disk-ba5cc80f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0787d25f251e/vmlinux-ba5cc80f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e85c36fabac/Image-ba5cc80f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffffffffc0801001
KASAN: maybe wild-memory-access in range [0
KASAN: maybe wild-memory-access in range [0x0003fffe04008008-0x0003fffe0400800f]
Mem abort info:
  ESR = 0x0000000096000061
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000061, ISS2 = 0x00000000
  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000021b036000
[ffffffffc0801001] pgd=0000000000000000, p4d=0000000221322403, pud=0000000221323403, pmd=1000000102b2a403, pte=00f800003eff1713
Internal error: Oops: 0000000096000061 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 4917 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __raw_writew arch/arm64/include/asm/io.h:36 [inline]
pc : _outw include/asm-generic/io.h:650 [inline]
pc : logic_outw+0x58/0x124 lib/logic_pio.c:305
lr : _outw include/asm-generic/io.h:649 [inline]
lr : logic_outw+0x48/0x124 lib/logic_pio.c:305
sp : ffff800098937980
x29: ffff800098937980 x28: ffff800098937b88 x27: 1fffe0001a6e7a00
x26: dfff800000000000 x25: 0000000000000100 x24: 0000000000001002
x23: 000000000000101f x22: 0000000000001001 x21: 0000000000ffbfff
x20: 0000000000001001 x19: 0000000000000002 x18: 0000000000000000
x17: ffff800080c9e010 x16: ffff800080c9ded4 x15: 00000000200000c0
x14: ffff800080f03ea0 x13: 0000000000000001 x12: ffff0000c4881d40
x11: 00000000685d429e x10: 000000000000007f x9 : 0000000000000000
x8 : ffffffffc0801001 x7 : ffff800080f080b4 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000002 x3 : ffff800086896aa8
x2 : 0000000000001001 x1 : ffff0000c4881d40 x0 : 0000000000000000
Call trace:
 _outw include/asm-generic/io.h:650 [inline] (P)
 logic_outw+0x58/0x124 lib/logic_pio.c:305 (P)
 pci_resource_io+0x1f4/0x3dc drivers/pci/pci-sysfs.c:1187
 pci_write_resource+0x78/0x90 drivers/pci/pci-sysfs.c:1221
 sysfs_kf_bin_write+0x154/0x194 fs/sysfs/file.c:167
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_pwrite64+0x118/0x1ac fs/read_write.c:794
 __do_sys_pwrite64 fs/read_write.c:802 [inline]
 __se_sys_pwrite64 fs/read_write.c:799 [inline]
 __arm64_sys_pwrite64+0xa8/0xc0 fs/read_write.c:799
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:738
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:757
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
Code: 929fffe8 d50332bf f2b81008 8b080288 (79000113) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	929fffe8 	mov	x8, #0xffffffffffff0000    	// #-65536
   4:	d50332bf 	dmb	oshst
   8:	f2b81008 	movk	x8, #0xc080, lsl #16
   c:	8b080288 	add	x8, x20, x8
* 10:	79000113 	strh	w19, [x8] <-- trapping instruction


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
