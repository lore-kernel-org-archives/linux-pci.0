Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF7286A7
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216967; cv=none; b=KvFXGOkFyZs6DIcIb9+0UvOS/Rf7WLkatEvG2+J0FWJ1bGu6CJ1WbXrmy/P0AED5QCNfhTpPT6eHFE2LIyHCgJ7GykpoGdbFSH+2USzBC0IgAvGqiyD9Y0F8nK7LPgQ7G+bdXBKfO3Yig4WEmVsyLJiU3uAxpWd8n089QfRIGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216967; c=relaxed/simple;
	bh=iWlRv61hmX6VI1/ndInYVh46DL6bAnQciSLGswPwxXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZinW0WbDp3H6YiYVsO26ltDit9YARjR7MjKXaH40gfzwBV+0Q60oqWYXZw+Ge57SKU0VurYRyu3h2k/EauOkuo5niKJVWeh43JEr2FTqEp7HoLCW+/L0rsL5blNMNzHw8ekH8x1GM0PNF98ox2DqJIWMhWfVzwcalZR0JV1qHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6r3LdNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6r3LdNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E2C2BCB0;
	Fri,  8 May 2026 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778216966;
	bh=iWlRv61hmX6VI1/ndInYVh46DL6bAnQciSLGswPwxXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=H6r3LdNZFZbpk5hWhrpBCbxhJ5tsIwb+mmhiF+QMaze/2o7xaJMyncdjZUid9dKmt
	 OmG6Kf4UFm8OY3HqdZlkI/Cd3K6FXYc7G4RQQrFURSkAyqYAEPyQYOT894hV940Enk
	 WqZBxZ8Ux2+BhnRYTYIq3lvD02wpmDCmLdxiIhxBPrEmx9tIK6oMSYvWnzil+bi+mj
	 iykmbLVpdRCGM6hpHrqxLwnKfFfPKvOY+1AkOJoAY2jLdBCyYr5ZEss+Y8TFEq9Z3U
	 d53tP3/bV9RPo8RCwiIYTOcme5G28dDTjGW+quywycPf8MdaRBj5vXKuxuYSwhwuGE
	 AvYtTWq82gxJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/24] PCI: Add macros for legacy I/O and memory
 address space sizes
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508043543.217179-20-kwilczynski@kernel.org>
References: <20260508043543.217179-20-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 05:09:25 +0000
Message-Id: <20260508050926.821E2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI_LEGACY_IO_SIZE macro is defined with an incorrect size of (SZ_6=
4K - 1).
--

commit d53406577948bbef31acd8d9cf7f8f8d4aed412a
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI: Add macros for legacy I/O and memory address space sizes

This commit adds defines for the standard PCI legacy address space sizes
to replace raw literals used by legacy sysfs attributes. It then updates
the sysfs code to use these newly added macros.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index a6451bbf69a8c..7ba12b2abe486 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1019,7 +1019,7 @@ void pci_create_legacy_files(struct pci_bus *b)
> =20
>  	sysfs_bin_attr_init(b->legacy_io);
>  	b->legacy_io->attr.name =3D "legacy_io";
> -	b->legacy_io->size =3D 0xffff;
> +	b->legacy_io->size =3D PCI_LEGACY_IO_SIZE;
>  	b->legacy_io->attr.mode =3D 0600;

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c56f2cf0d2ab5..e37677a8dd3ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h

[ ... ]

> @@ -1169,6 +1170,10 @@ enum {
>  /* These external functions are only available when PCI support is enabl=
ed */
>  #ifdef CONFIG_PCI
> =20
> +/* PCI legacy I/O port and memory address space sizes. */
> +#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)

Is this macro value mathematically correct for a size definition?

The legacy PCI I/O port space spans ports 0x0000 through 0xFFFF, meaning
its total size is exactly 64 KiB.

While the original sysfs code hardcoded 0xffff as the file size (which this
patch intentionally maintains), exposing this off-by-one limit globally und=
er
a SIZE naming convention seems potentially confusing.

If other subsystems start using PCI_LEGACY_IO_SIZE for memory allocations
or loop bounds, could this lead to unexpected truncations? Might it make
sense to define the true size as SZ_64K, and handle the off-by-one quirk
directly at the sysfs site instead?

> +#define PCI_LEGACY_MEM_SIZE	SZ_1M
> +
>  extern unsigned int pci_flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508043543.2171=
79-1-kwilczynski@kernel.org?part=3D19
