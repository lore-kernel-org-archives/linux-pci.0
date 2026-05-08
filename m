Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051470809
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217793; cv=none; b=Ac+YPkl2lzcObIb+l6padTNKFD5atS0VqKe1VEUPljWi+KjA0NlxVDeVXXtMrf+Sez/GQEqIiA62UvNXr9VTmJN5gpLf9a6j+Q4oaQDDjLrcgTjjkygVVzoL+22dAXD6HyyWZ6VEfWRyqiMteIOZT+wkewk5loWG4sEnRErFLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217793; c=relaxed/simple;
	bh=azlnMnzy8lNPSFJ8Qfc6i1xtogdTTZRo8Lln1Dvg4T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJ5MfkvYWUkrv458nmTcbcbXbTVoSj1TbXC3cxhLJcCS3dy+AYUgNKXFW8Z2MuDWnbCX/f8nt3x2qaYAxJv7Is+jXXyUZ63j0EjpBQ1soxwYjNDEw6su6l01P1TXvmgD6sLkaOu19RKmWqkaCx8x7pfj7CYsPrRI4uU3uWN/rOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3j20pBc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3j20pBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8516C2BCB0;
	Fri,  8 May 2026 05:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778217793;
	bh=azlnMnzy8lNPSFJ8Qfc6i1xtogdTTZRo8Lln1Dvg4T8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N3j20pBc02pewEi1UZXiNcyYwGFZt2I006UwIn3ijkcFjjLRDS0pjqWRUZ6KThaAW
	 Ju+y9JULoNgzzEzNhAt+/JoGcOzGon+VyEg45nHcKMN9RgqnOaibQENw3LT7iastH+
	 wGCydmNvRF0IWwWt+VLRV15js/2nxiYhlJhGttJYj8pUrC33QyRC6QEppVqTh6ImRr
	 GGM6vWFXxvWgEK6CsTz+6HnTeVKl/QbajFlCEAbvD6AyWpF9w/qkewPMBYGq4a3hz3
	 r8xxPVzvBBSSaqWLuy5JxGWuxcZPKcidlVL5MMdx6bj4Qa24hYhdXX+9eEGG8TIgNj
	 JmHUsbsLXHZMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/24] PCI/sysfs: Add static PCI resource attribute
 macros
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508043543.217179-7-kwilczynski@kernel.org>
References: <20260508043543.217179-7-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 05:23:12 +0000
Message-Id: <20260508052312.E8516C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `pci_dev_resource_io_attr` macro leaves the `.size` field =
of the binary attribute uninitialized (0), disabling VFS bounds checking. T=
his allows arbitrary offsets that truncate on 32-bit architectures, enablin=
g read/write access to arbitrary I/O ports.
- [High] The `pci_dev_resource_io_attr` macro conditionally omits the `.lls=
eek` callback on architectures without I/O mmap support (like x86 and arm64=
), causing `lseek(SEEK_END)` to incorrectly return 0 for I/O BAR sysfs file=
s.
--

commit 2bb0cfc5ea48584962711dffb2f762f594fd8374
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Add static PCI resource attribute macros

This patch adds macros for declaring static binary attributes for PCI
resource files, setting specific callbacks based on the resource type.
It conditionally includes mmap support for I/O BAR resources based on
arch_can_pci_mmap_io().

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
[ ... ]
> @@ -1197,6 +1197,47 @@ static ssize_t pci_write_resource_io(struct file *=
filp, struct kobject *kobj,
>  	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
>  }
> =20
> +/*
> + * generic_file_llseek() consults f_mapping->host to determine
> + * the file size. As iomem_inode knows nothing about the
> + * attribute, it's not going to work, so override it as well.
> + */
> +#if arch_can_pci_mmap_io()
> +# define __PCI_RESOURCE_IO_MMAP_ATTRS		\
> +	.f_mapping =3D iomem_get_mapping,		\
> +	.llseek =3D pci_llseek_resource,		\
> +	.mmap =3D pci_mmap_resource_uc,
> +#else
> +# define __PCI_RESOURCE_IO_MMAP_ATTRS
> +#endif

On architectures where arch_can_pci_mmap_io() is false (such as x86 and arm=
64),
__PCI_RESOURCE_IO_MMAP_ATTRS evaluates to empty, meaning .llseek is left as
NULL.

Since these are static attributes, their .size field defaults to 0. When
.llseek is NULL, sysfs_kf_bin_llseek() falls back to generic_file_llseek().

Because the inode size is 0, will lseek(fd, 0, SEEK_END) incorrectly return
0 instead of the actual resource length, potentially breaking userspace too=
ls
like pciutils?

Should .llseek =3D pci_llseek_resource be defined unconditionally to ensure
the correct dynamic resource length is computed?

> +
> +#define pci_dev_resource_io_attr(_bar)					\
> +static const struct bin_attribute dev_resource##_bar##_io_attr =3D {	\
> +	.attr =3D { .name =3D "resource" __stringify(_bar), .mode =3D 0600 },	\
> +	.private =3D (void *)(unsigned long)(_bar),			\
> +	.read =3D pci_read_resource_io,					\
> +	.write =3D pci_write_resource_io,					\
> +	__PCI_RESOURCE_IO_MMAP_ATTRS					\
> +}

Because the .size field of this static bin_attribute is uninitialized (0),
VFS bounds checks in sysfs_kf_bin_read() and sysfs_kf_bin_write() are
disabled.

If an arbitrarily large 64-bit positive file offset is passed via pread(),
does this offset truncate on 32-bit architectures?

Looking at pci_resource_io():

static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
			       const struct bin_attribute *attr, char *buf,
			       loff_t off, size_t count, bool write)
{
#ifdef CONFIG_HAS_IOPORT
	...
	unsigned long port =3D off;
	...
	port +=3D pci_resource_start(pdev, bar);

	if (port > pci_resource_end(pdev, bar))
		return 0;
	...
}

Could a 64-bit offset be crafted such that when truncated to 32 bits, it
becomes a negative value that exactly offsets pci_resource_start(pdev, bar)?

This would cause port to wrap around to a targeted port value.

Since the upper-bound check against pci_resource_end() would then pass,
and there is no lower-bound check, does this allow reading or writing any
physical I/O port between 0 and pci_resource_end?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508043543.2171=
79-1-kwilczynski@kernel.org?part=3D6
