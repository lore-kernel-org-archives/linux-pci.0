Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3D3659EB
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381457; cv=none; b=gqmjAikJ/CLIVceH/e6tS52f2bEJtPg5BIl17OdBIw+cd6XVVUIlRAHLzN5sEILDeXTRNjh5KJAL9nxypoXzS6kBmHUqA5800RKktxp2oxOIbmdV6CssWy0hQzhKa81jQopREINoj+GW572Tx7xWeQhlK+o7pwbtbvksRi6gGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381457; c=relaxed/simple;
	bh=hJrVWSmFhYdhl1SJGt/utoD7boW3QvSWpfAgeVAFpj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFb/Cy7XjMmUKccEWCgfl9iDOLgIOgWFWbw4hmITtf57HLu/98bBDxachS9R29BKqRKwfrskpczvWVy5/MKrRJtOvsRzKOWHD2ueCDgaiWm5V3653F5Db6QQ6wR4OtfUIQdV1GAf8Uk/c4JBonuNcl5yquhlUX94qnOsUOs9QUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owdk5qLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owdk5qLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D41F000E9;
	Thu, 30 Jul 2026 03:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381454;
	bh=EDcT/sdB0MaIzpzwYggUTqhzurPMfsO3fthQ3eIL5Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owdk5qLvjoD61iBR/5kRjG3sn00qFT+k7GCzhCuNwoBxkijKfoK1XlgtOgBu8/hNf
	 1H41A80IXFYCRY61e/YRQsIXStCYkyavA0VnYZCwM7zOd3fiZxMNL/tG+5C4yqM5/V
	 ZFCgz7sc57Vz5/DAGYwEFeKkaxEKHVTYbIRLQHQAmA+sg1XHlREhq7k8FgNFLqf1+c
	 shrsNg5r8uNYXLOdS0olNP6ojUvugZUeQhg8TkB3zfTWClTtvt4Z06NMxxneq1Ktyb
	 g/nG1KsxkbztDHlA3vwkkJpCJq7ZYp6/gMVeBkA9gAuUyDX9o0nL4yw53sljGAXDW2
	 GGwSSsH7O0iyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] PCI/proc: Warn on writes to driver-exclusive
 config regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-4-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-4-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:17:34 +0000
Message-Id: <20260730031734.A89D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The format string in pci_warn_once lacks a terminating newline char=
acter.

Pre-existing issues:
- [High] The return values of __get_user() are ignored in proc_bus_pci_writ=
e(), leading to silent hardware writes of zero or uninitialized data on fau=
lt.
- [High] proc_bus_pci_write() performs unaligned user memory accesses via _=
_get_user(), violating API constraints and potentially triggering alignment=
 faults.
--

--- Patch [3]: [PATCH v2 3/6] PCI/proc: Warn on writes to driver-exclusive =
config regions ---
commit 7011bc96a28549a7bd6d8b00360cce10cb406486
Author: Ziming Du <duziming2@huawei.com>

PCI/proc: Warn on writes to driver-exclusive config regions

The sysfs configuration-space write path warns and taints the kernel
when userspace writes a region claimed exclusively by a driver. The
procfs path can access the same configuration space but does not perform
this check.

Add the same resource_is_exclusive() warning and taint to
proc_bus_pci_write() so the two userspace interfaces treat driver-owned
ranges consistently.

Fixes: 278294798ac9 ("PCI: Allow drivers to request exclusive config region=
s")

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index ec2338c1e667e..3f041765da978 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -122,6 +122,13 @@ static ssize_t proc_bus_pci_write(struct file *file,=
 const char __user *buf,
>  	if (ret)
>  		return ret;
> =20
> +	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos,
> +				  nbytes)) {
> +		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config of=
fset %llx",
> +			      current->comm, pos);

[Severity: Low]
Is a trailing \n character needed for this format string?

Without it, subsequent kernel log messages from any subsystem might be
appended to the same line, resulting in garbled dmesg output.

> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +	}
> +
>  	if (pos >=3D size)
>  		return 0;


drivers/pci/proc.c:proc_bus_pci_write() {
...
	if ((pos & 1) && cnt) {
		unsigned char val;
		__get_user(val, buf);
		pci_user_write_config_byte(dev, pos, val);
...
}

[Severity: High]
This is a pre-existing issue, but is the return value of __get_user() being
safely ignored here?

If __get_user() fails (e.g., due to an unmapped buffer or an unhandled page
fault), it returns -EFAULT.

By ignoring this return value, the kernel silently proceeds to write zero
(or potentially uninitialized stack data on older architectures) to the PCI
hardware configuration space instead of aborting.


drivers/pci/proc.c:proc_bus_pci_write() {
...
	if ((pos & 1) && cnt) {
		unsigned char val;
		__get_user(val, buf);
		pci_user_write_config_byte(dev, pos, val);
		buf++;
		pos++;
		cnt--;
	}

	if ((pos & 3) && cnt > 2) {
		__le16 val;
		__get_user(val, (__le16 __user *) buf);
...
}

[Severity: High]
This is also a pre-existing issue, but could this sequence lead to unaligned
user memory accesses?

If a privileged user issues a write with an odd offset (pos & 1) and
length > 2, the code reads the first byte and increments buf by 1.

This makes the pointer unaligned before casting it to (__le16 __user *) for
the next __get_user() call.

Passing an unaligned pointer can trigger a kernel oops on strict-alignment
architectures that lack unaligned kernel access fixups, or it may return a
silent -EFAULT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D3
