Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE033A6E2
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514069; cv=none; b=SygKCnGheFYZ/qtn/KwvZ1OZLe66H8B01WaevdOpro03/LnP9TWHzT1WZd+JdAs5U46lMNY6LsdXn1AKZYEnDyzBvpnidqGfvtNhu2OGfT3IvK9yxzelM6Zf076k7ko3kQ0YmIooL9qv6INlBRC7+7tZbYl7hOLqPU0PWZ5KOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514069; c=relaxed/simple;
	bh=BiRIk36aRlgFDld8cOjUwMutvWofMNuCgJoHAAmiKOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjMltYkFHCuqTBokErR4qTTFVStIONg1Gi1THghkI0f+XBmzBo3iLkcV63Y0CnFrOZjl7vBqVr2H05XiKGzIMaDc4WMlm0mUzHQwiVn6Pfgq4JRtMqbitlrJHpuW47lqMrU0Da+m+oBBVZ48b3WCVcX4nNQSxZMDcRqVXKt+Gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PuA2Efmq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PuA2Efmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781514052; bh=bAQXwn+qC2akO+xZ226TuyCtpNl+On4M2U4hUu2Wv5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PuA2Efmq6JCJfc9v5O4uRAQXigWfr83lvZk+axCjdHGn9QdyekaTmYeOdWdI9wcmJ
	 AFot0R7oeqCF4HHHl6WKabbikVnxJFxAdptZb+K612hfxOJDv4eH1xqKVog5aunIiX
	 p340C8UE4xS2uwq5maJn9cTGS5xXpNxAw+Wd4ukE=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3200ED8; Mon, 15 Jun 2026 17:00:50 +0800
X-QQ-mid: xmsmtpt1781514050t7m0f2qpe
Message-ID: <tencent_F4321A5EB5642AE407C42238ACC61714BB07@qq.com>
X-QQ-XMAILINFO: NEGqkzgyFYqOy21RODdbG9rlTKPhvd5gsUs6LBSSBCrK5iSQB9W0YUtLtY942o
	 Xx2+g7fM3JeSPbuezl4+RgOxTXMr4oLZAJbW/S8OU8v6z/uCG5jYtt9x00vqf6YDGCsSe8uCXxkY
	 AOJ+oDOcBeeLE4aK7OfNQn7VGlLStG1yJ8mJZvk0BEUV8+Q6rGThJBuHflbso4jOehsKcnqWMpCh
	 FA2LifYm0UZ/h+NpTIFRSqrCGoEImfwwk3ItFqulb9bi7VpqHP3OrtRrUFyvuOjJD4upB3BhyByF
	 sjIALlw/zeUWprU9ErHshGnM2paleEWNxqa8KZWmkZzloUBsLSb8OVJ9e51ckgAx+zpb6r5mG2WE
	 25+Y+XUIl/p+mz2azsulUUFjNS/YKudEg+i+MlMxEZkriyyMJ6RCAckaBgxBb7nXevctQ6WOaKAC
	 Ro4iZI6h+nAy0Ha7yJFyd9AfFlPd2gRIPwvOpQ6127SwNcqawXBMNGMPRLzckmVAZHFMuUVDlYKS
	 p37EA8Bxx6f/8dYos6/TKZzuFr1CKy9z/bs+ZoD28zSn+8yT1u91pzD6RY7rtOYDL2Rm4qX5SsIU
	 ZENFA2N8dCGai4bIPaWm8+fcVgwHOKRWRuYX3kJdiy4mTGD1MbA/4XErUdKrze7oNfZygCBgtRZo
	 d2F+eYHbnUbY0m4Zr2iAVrPgZFRNPRv1Mj7UWoOyk9wiVgjXEqyx+5jfYGBFP964XQfpZ0tBoQ2Y
	 ajZsROIfpvggGeBP2onGgxo1erdy2317r14OrlLGNQLpMGhTQEqyASuQh958B9X8snRi1/FGh10h
	 tdZbV9Gh4a4xad5u68Vt8pReKhvCDC9LzjRi9IfFsE/JO7vMUPYjH2/xSLXnloyCt8slIXE/jEMN
	 4rO8W2hYfkenYXOPRTPBZcESl7VxDGYuY4caSISkf2neAA5fwZBzcXD7DBQj3BtA9Qoi8G0LAAAm
	 IHJQ0xTynwV2QP/CALzqFiHBm9b1Zjdixgbez9sTLCDZoYim0HttqzwFmljP2JUnN6tFvL5X+Lcv
	 lTvuuRcFO5c9FtwvLoem53Q4Z0kvaB5PNhUSRI6g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <74d2da68-a1f1-484d-8ba4-95d2d224e81c@qq.com>
Date: Mon, 15 Jun 2026 17:00:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260612232400.585195-1-kwilczynski@kernel.org>
 <20260612233426.B7EFD1F000E9@smtp.kernel.org>
 <20260613151251.GB3086320@rocinante>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260613151251.GB3086320@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Following up on the Sashiko review that pointed out the `*(u32 *)buf`
issue in pci_write_legacy_io() — I wrote a small PoC to confirm it on
x86 with HAVE_PCI_LEGACY enabled for testing.

As expected, writing 1 byte to `/sys/devices/pci*/legacy_io` reliably
triggers a KASAN slab-out-of-bounds read in pci_write_legacy_io():

   ==================================================================
   BUG: KASAN: slab-out-of-bounds in pci_write_legacy_io+0xb5/0xc0
   Read of size 4 at addr ffff888107c8ed88 by task bash/9528

   Call Trace:
    pci_write_legacy_io+0xb5/0xc0          <-- *(u32 *)buf
    sysfs_kf_bin_write+0x17c/0x1f0
    kernfs_fop_write_iter+0x3a4/0x580
    vfs_write+0x7e1/0x11b0
    ksys_write+0x12f/0x250
    ...

   Allocated by task 9528:
    kernfs_fop_write_iter+0x22c/0x580       <-- kmalloc(2) for 1-byte write
    ...

   The buggy address is located 0 bytes inside of
    allocated 2-byte region [ffff888107c8ed88, ffff888107c8ed8a)

The kernel at line 921 in drivers/pci/pci-sysfs.c:

 >    return pci_legacy_write(bus, off, *(u32 *)buf, count);

unconditionally reads 4 bytes, but kernfs only allocated count+1 bytes
(2 bytes for a 1-byte write).  The upper bytes of val get populated
with uninitialized heap data, as the Sashiko review noted.

On x86 this is "just" a KASAN splat since outb() truncates to the
lowest byte, but on PowerPC where pci_legacy_write() does
`out_8(addr, val >> 24)`, the garbage bytes would actually hit the I/O
port.

Hope the PoC helps.  Patch for pci_write_legacy_io() would be:

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -918,7 +918,19 @@ static ssize_t pci_write_legacy_io(struct file 
*filp, struct kobject *kobj,
      if (count != 1 && count != 2 && count != 4)
          return -EINVAL;

-    return pci_legacy_write(bus, off, *(u32 *)buf, count);
+    u32 val = 0;
+    memcpy(&val, buf, count);
+    return pci_legacy_write(bus, off, val, count);
  }

Thanks,
Xiao

---8<--- poc.c ---
/*
  * PoC: KASAN slab-out-of-bounds in pci_write_legacy_io()
  *
  * drivers/pci/pci-sysfs.c unconditionally dereferences *(u32 *)buf
  * regardless of count (1, 2, or 4).  Write 1 byte to legacy_io to
  * trigger a 4-byte read from a 2-byte kmalloc buffer.
  *
  * Build:  gcc -Wall -O2 -o poc poc.c
  * Run:    ./poc   (KASAN-enabled kernel with HAVE_PCI_LEGACY)
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <linux/limits.h>

static int try_write(const char *dirname, const char *buf, size_t count)
{
     char path[PATH_MAX];
     struct stat st;
     int fd;

     snprintf(path, sizeof(path), "/sys/devices/%s/legacy_io", dirname);
     if (stat(path, &st) < 0) return -1;
     fd = open(path, O_WRONLY);
     if (fd < 0) return -1;

     ssize_t ret = write(fd, buf, count);
     printf("  %s (%zu bytes): %s\n", path, count,
            ret < 0 ? strerror(errno) : "ok");
     close(fd);
     return ret >= 0 ? 0 : -1;
}

int main(void)
{
     DIR *dir = opendir("/sys/devices/");
     struct dirent *entry;
     int found = 0;

     if (!dir) { perror("opendir"); return 1; }

     printf("PoC: pci_write_legacy_io() slab-out-of-bounds\n\n");
     while ((entry = readdir(dir))) {
         if (strncmp(entry->d_name, "pci", 3)) continue;
         printf("Found: %s\n", entry->d_name);

         /* 1-byte write: kmalloc(2) → *(u32 *) reads 4 bytes */
         if (try_write(entry->d_name, "\x01", 1) == 0) found++;
         /* 2-byte write: kmalloc(3) → *(u32 *) reads 4 bytes */
         if (try_write(entry->d_name, "\x01\x02", 2) == 0) found++;
     }
     closedir(dir);

     if (!found) {
         printf("\nNo legacy_io files.  Kernel likely lacks 
HAVE_PCI_LEGACY.\n");
         return 1;
     }
     printf("\nDone.  Check dmesg for KASAN report.\n");
     return 0;
}


