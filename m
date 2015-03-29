Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:59118 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbbC2JBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Mar 2015 05:01:30 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 4317925A2135
	for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2015 11:01:28 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lF9rl6jk4z5vMr
	for <linux-pci@vger.kernel.org>; Sun, 29 Mar 2015 11:01:27 +0200 (CEST)
Date: Sun, 29 Mar 2015 09:59:32 +0100
From: Felix Janda <felix.janda@posteo.de>
To: linux-pci@vger.kernel.org
Subject: [PATCH pciutils] pread.h: Remove support for libc5
Message-ID: <20150329085931.GA8259@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The support code for libc5 breaks building on linux i386 with
other libcs that don't define __GLIBC__.
---
 lib/pread.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/pread.h b/lib/pread.h
index 0e64326..3db90e3 100644
--- a/lib/pread.h
+++ b/lib/pread.h
@@ -30,15 +30,6 @@ static int pread(unsigned int fd, void *buf, size_t size, loff_t where)
 static int pwrite(unsigned int fd, void *buf, size_t size, loff_t where)
 { return syscall(SYS_pwrite, fd, buf, size, where); }
 
-#elif defined(i386)
-/* old libc on i386 -> call syscalls directly the old way */
-#include <asm/unistd.h>
-static _syscall5(int, pread, unsigned int, fd, void *, buf, size_t, size, u32, where_lo, u32, where_hi);
-static _syscall5(int, pwrite, unsigned int, fd, void *, buf, size_t, size, u32, where_lo, u32, where_hi);
-static int do_read(struct pci_dev *d UNUSED, int fd, void *buf, size_t size, int where) { return pread(fd, buf, size, where, 0); }
-static int do_write(struct pci_dev *d UNUSED, int fd, void *buf, size_t size, int where) { return pwrite(fd, buf, size, where, 0); }
-#define PCI_HAVE_DO_READ
-
 #else
 /* In all other cases we use lseek/read/write instead to be safe */
 #define make_rw_glue(op) \
-- 
2.0.5
