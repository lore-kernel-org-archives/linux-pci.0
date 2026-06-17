Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0330D40A;
	Wed, 17 Jun 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667303; cv=none; b=BbBxvBpwyBICZJ56tmCWPhoeCjJ1HtTjeBXFooUoK0GQZS12+9ymb4bQm31P5apAvPSqnJ6BcmHlG2pvny4noKLhdHf+g0ZWiV6uTGQjZJZQYHmXOlZzQKDhy7BHdlf+KCLAjSP1TFemxRHTBKIPiWw0F7/MJlWYlCPPoqS1Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667303; c=relaxed/simple;
	bh=tedbuzG845kYaIBdGycgN/T2GgXZ0xgUwhs0a50ZYQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlJ5lCiGh9/oJf6vxy80K0S/L1hR6ozN2MCwHFGEUEhGz9f6RA3TPzSlE0YNIZWPvY+1BakrTzDjB9ZSPBCvKdRQa4PbCHa5xL7rtoglrzJg+6T+01oiuo8FLz4THAcQz+gfbaUxqNg58NavHMNkaM5st7/GGRrGEnDsUdZGGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABR7Honk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABR7Honk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8F1F000E9;
	Wed, 17 Jun 2026 03:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781667302;
	bh=fZnYoWahI23oaIajfnJX969BZamd3bNID6nxhmEeG6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABR7Honkx/vmuC+QQHbuEsQyIlzzsIuKJZxlSX9n2cmm+I7eFwRwwZj7NZuUycI80
	 p425qtFBa8eOftZDL9qm3LmgeyGxF6hjJoEPgikCc4MTbKjII//G3x8tn89wVYg3RM
	 3PhZPJqX4slAM5CexUJunZx/iBLy5f1aGZYIdWQFMl/z2ZI+FB9NKBjse4SkGG0R0D
	 K1uXOTO9rMq54CjP/iOclhOYSCeQb2zJAmBG3q/zt3LfepFqKjWRsy8kBDfcHCYrk+
	 fX66MK8ZPb/CltCL8njW4+MAC/0I1w9M8lIbick3nHOFs6Hdmk1/EaC1zdpzwq70yD
	 6FuMI9JWtJB9Q==
Date: Wed, 17 Jun 2026 12:35:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: XIAO WU <xiaowu.417@qq.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
Message-ID: <20260617032302.GB977693@rocinante>
References: <20260612232400.585195-1-kwilczynski@kernel.org>
 <20260612233426.B7EFD1F000E9@smtp.kernel.org>
 <20260613151251.GB3086320@rocinante>
 <tencent_F4321A5EB5642AE407C42238ACC61714BB07@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_F4321A5EB5642AE407C42238ACC61714BB07@qq.com>

Hello,

> Following up on the Sashiko review that pointed out the `*(u32 *)buf`
> issue in pci_write_legacy_io() — I wrote a small PoC to confirm it on
> x86 with HAVE_PCI_LEGACY enabled for testing.

Thank you for the proof-of-concept and the analysis.

> As expected, writing 1 byte to `/sys/devices/pci*/legacy_io` reliably
> triggers a KASAN slab-out-of-bounds read in pci_write_legacy_io():
> 
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in pci_write_legacy_io+0xb5/0xc0
>   Read of size 4 at addr ffff888107c8ed88 by task bash/9528
> 
>   Call Trace:
>    pci_write_legacy_io+0xb5/0xc0          <-- *(u32 *)buf
>    sysfs_kf_bin_write+0x17c/0x1f0
>    kernfs_fop_write_iter+0x3a4/0x580
>    vfs_write+0x7e1/0x11b0
>    ksys_write+0x12f/0x250
>    ...
> 
>   Allocated by task 9528:
>    kernfs_fop_write_iter+0x22c/0x580       <-- kmalloc(2) for 1-byte write
>    ...
> 
>   The buggy address is located 0 bytes inside of
>    allocated 2-byte region [ffff888107c8ed88, ffff888107c8ed8a)
> 
> The kernel at line 921 in drivers/pci/pci-sysfs.c:
> 
> >    return pci_legacy_write(bus, off, *(u32 *)buf, count);
> 
> unconditionally reads 4 bytes, but kernfs only allocated count+1 bytes
> (2 bytes for a 1-byte write).  The upper bytes of val get populated
> with uninitialized heap data, as the Sashiko review noted.
> 
> On x86 this is "just" a KASAN splat since outb() truncates to the
> lowest byte, but on PowerPC where pci_legacy_write() does
> `out_8(addr, val >> 24)`, the garbage bytes would actually hit the I/O
> port.

This is a known issue:

  https://lore.kernel.org/linux-pci/20260421200609.GE1684602@rocinante/

The fix has been sent recently, too.

> Hope the PoC helps.  Patch for pci_write_legacy_io() would be:
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -918,7 +918,19 @@ static ssize_t pci_write_legacy_io(struct file *filp,
> struct kobject *kobj,
>      if (count != 1 && count != 2 && count != 4)
>          return -EINVAL;
> 
> -    return pci_legacy_write(bus, off, *(u32 *)buf, count);
> +    u32 val = 0;
> +    memcpy(&val, buf, count);
> +    return pci_legacy_write(bus, off, val, count);
>  }

This would unfortunately not be the correct way to fix this.  You need to
take into the account different platforms on which this code runs.

[...]
> static int try_write(const char *dirname, const char *buf, size_t count)
> {
>     char path[PATH_MAX];
>     struct stat st;
>     int fd;
> 
>     snprintf(path, sizeof(path), "/sys/devices/%s/legacy_io", dirname);
>     if (stat(path, &st) < 0) return -1;
>     fd = open(path, O_WRONLY);
>     if (fd < 0) return -1;
> 
>     ssize_t ret = write(fd, buf, count);
>     printf("  %s (%zu bytes): %s\n", path, count,
>            ret < 0 ? strerror(errno) : "ok");
>     close(fd);
>     return ret >= 0 ? 0 : -1;
> }
> 
> int main(void)
> {
>     DIR *dir = opendir("/sys/devices/");
>     struct dirent *entry;
>     int found = 0;
> 
>     if (!dir) { perror("opendir"); return 1; }
> 
>     printf("PoC: pci_write_legacy_io() slab-out-of-bounds\n\n");
>     while ((entry = readdir(dir))) {
>         if (strncmp(entry->d_name, "pci", 3)) continue;
>         printf("Found: %s\n", entry->d_name);
> 
>         /* 1-byte write: kmalloc(2) → *(u32 *) reads 4 bytes */
>         if (try_write(entry->d_name, "\x01", 1) == 0) found++;
>         /* 2-byte write: kmalloc(3) → *(u32 *) reads 4 bytes */
>         if (try_write(entry->d_name, "\x01\x02", 2) == 0) found++;
>     }
>     closedir(dir);
> 
>     if (!found) {
>         printf("\nNo legacy_io files.  Kernel likely lacks HAVE_PCI_LEGACY.\n");
>         return 1;
>     }
>     printf("\nDone.  Check dmesg for KASAN report.\n");
>     return 0;
> }

The above code might need a small update:

--- a/poc.c (original)
+++ b/poc.c (current)
@@ -32,7 +32,7 @@
-     snprintf(path, sizeof(path), "/sys/devices/%s/legacy_io", dirname);
+     snprintf(path, sizeof(path), "/sys/class/pci_bus/%s/legacy_io", dirname);
@@ -48,7 +48,7 @@
-     DIR *dir = opendir("/sys/devices/");
+     DIR *dir = opendir("/sys/class/pci_bus/");
@@ -59,7 +59,7 @@
-             if (strncmp(entry->d_name, "pci", 3))
+             if (entry->d_name[0] == '.')

As the legacy PCI sysfs attributes path is different.

Thank you!

	Krzysztof
