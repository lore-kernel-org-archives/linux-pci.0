Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA03624DB
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860718; cv=none; b=L2Zn0gV8OK7xaXEUNghT8u+wvLCysvzcO3UpMwT7suCDcyxRJBNWsnntXg/RtEMLa8hI2qMW65Oq/P0jzX6nBZZ9hnPGUnGuPFi8I++qG3bf55oruG0L7AjiPsq1I4gsab5Wps0aPUKtxq6wp3CnKVSXiGeblqmzqzpJZKXGcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860718; c=relaxed/simple;
	bh=tMElZ2dt1+TTglOTkr6C0udnEjsMZ6kq4Wz2H81JXXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bIpODtxKw1adnfpPBvltiBZo2EjB1uVk1T/8fH0+AbNsLN/kkPLc2YG8S2QuNfCpBWafJpX70MlCw2VBO+ksx7M4XjfZTpg7T5N6WJukaNo4zM5PWdv+sP4nylkRPEXVruz5qWNRzme5CFF4dQCD4PuQQmc0gNrTCNIV45cxssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3APtAFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3APtAFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0883F1F000E9;
	Fri, 19 Jun 2026 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860716;
	bh=qjCsadnBKC3vougQFeIHFLavNiveC8D5Jzg47aFZ2CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3APtAFOTvwVydzwwbFfFSBoOjZTrG9NrO0+LqaaKkSoMkCYHZkp3YpNwEIF2kLEm
	 hj9L0AmSc4IFixB9BxY5SALNKSEK0OuN4gwqq1z6j1z7KEbMfrqMHF38jgfIdlVi+0
	 Riftmxk1QVKivPOyfCUD8ec3MUhB7F0U8p7wk5Uv1mbSZhUGgKD0M9+CoCTN106TfB
	 VS4jTIFNd+7crHipSIzKWYfntSdl98lWG+y4X2Ai1yv9AQjxa+oE1an14TGdx+TlTE
	 v4EBCIlN2qKK3VHQA9LQgJkZ/BlzHjgz188Awpbzf+9MYfz/63kqTHMmXNmC7OOeC+
	 qgy9SrkvL8tyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 22/25] PCI/sysfs: Add legacy I/O and memory attribute
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-23-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-23-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:18:35 +0000
Message-Id: <20260619091836.0883F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An out-of-bounds heap read occurs in `pci_write_legacy_io` when a =
user writes 1 or 2 bytes to the `legacy_io` sysfs file.
--

commit 9cf38c5cdfc69788fc6aaf6dcdc29d5b5da5960b
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Add legacy I/O and memory attribute macros

Add two macros for declaring static binary attributes for PCI legacy
I/O port and ISA memory space files.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index a861484ac0c08..7f1d8e07924f5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -893,6 +893,27 @@ pci_llseek_resource_legacy(struct file *filep,
>  }
> =20
>  #ifdef HAVE_PCI_LEGACY
> +
> +#define pci_legacy_resource_io_attr(_suffix, _size)				\
> +static const struct bin_attribute pci_legacy_io##_suffix##_attr =3D {		\
> +	.attr =3D { .name =3D "legacy_io" __stringify(_suffix), .mode =3D 0600 =
},	\
> +	.size =3D (_size),							\
> +	.read =3D pci_read_legacy_io,						\
> +	.write =3D pci_write_legacy_io,						\

[Severity: High]
This isn't a bug introduced by this patch, but can the use of
pci_write_legacy_io() here trigger an out-of-bounds heap read?

When a user writes 1 or 2 bytes to a legacy_io sysfs file,
kernfs_fop_write_iter() allocates a buffer of count + 1 bytes.

In pci_write_legacy_io(), after validating count is 1, 2, or 4, the buffer =
is
cast and unconditionally dereferenced as a u32:

drivers/pci/pci-sysfs.c:pci_write_legacy_io() {
        /* Only support 1, 2 or 4 byte accesses */
        if (count !=3D 1 && count !=3D 2 && count !=3D 4)
                return -EINVAL;

        return pci_legacy_write(bus, off, *(u32 *)buf, count);
}

Does the *(u32 *)buf dereference cause a 4-byte read from the smaller 2-byte
or 3-byte buffer, potentially triggering a KASAN slab-out-of-bounds read?

> +	.f_mapping =3D iomem_get_mapping,						\
> +	.llseek =3D pci_llseek_resource_legacy,					\
> +	.mmap =3D pci_mmap_legacy_io,						\
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D22
