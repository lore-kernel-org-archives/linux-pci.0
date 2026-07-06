Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0927A107
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361158; cv=none; b=WUIv0KGsGugNjGrTceeJrK2kyVjga76iEHmLybbRK5tRZzJHBU0Z+gKwxh2pOnWT1oiV64WS0QzBY7ZfDjcTER6YV3CjnXZcAZpK+R0F1ie+uCCPQnX2C1acNX/SKeKEymw1/TUZAB5JyLEXASPrz9LgixkI0GiNMyYhklKKGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361158; c=relaxed/simple;
	bh=6XwRp+HxaWgqwPH2sVjYfM6zgkmHeoAOvVSDFddJglw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4aHgQHR6q7BKrvK5HfjQl28ofM4TKGcmDJbqAIxkn0tU8Xi8XZP8NmgjGX62qa2AZl1BCpmo5Gp/kQINGoxyM1pPZjDHMmlBEAhwZvfGy/RzotipCNhV4HWh+9w20R5+Nhow/g2wGjj919xMWpCRyy/ozaMbQGhEH/oDJAfu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfwDqUe6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfwDqUe6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC71F000E9;
	Mon,  6 Jul 2026 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361156;
	bh=KMVNOVQRyu20srq1QFkH/jp4ZK49sepsueY/OoqIkO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfwDqUe6xhbC46/GqJT8YiblM30uhTsHW+z7DYng2pQQchFOaAZeu5CuqmLhbcKh+
	 f0OsGUPo6XrsSqwWwIrP90FHg34sAkKr8iwLtajLH3hR7U+XJZLvwtLUP1uJuNcKjm
	 N/JOrZ4zfHvXVoUR8qMGI1MIa8Po18jAWHXBuFR41day4mnUt9nA3Gqh8Mfoyckxxu
	 af+1IDp+ArYjj39Lq7Vs7XcmZq5srTNE4zUQCnvbrLoFoKxZCJYw30LR5kGh61+2uf
	 yVAzg42c4wO6ngSX7nNYB/KC3EyZ9miPGCun0a2RSAcoIKtEwOj7PlbUaGGahTimHP
	 hLCBCTh/jaD+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260706175423.98305-1-kwilczynski@kernel.org>
References: <20260706175423.98305-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:05:56 +0000
Message-Id: <20260706180556.BBDC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KASAN Slab-Out-of-Bounds Read due to blind 32-bit cast on dynamica=
lly allocated buffer.
- [High] Missing kernel lockdown checks in legacy PCI sysfs interfaces allo=
ws Secure Boot bypass.
--

commit be452ca0a927e25b05ef8e9af9aca2fcb7ecfaa3
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()

This patch corrects the argument order for outb(), outw(), and outl()
in the Alpha architecture's pci_legacy_write() function. The previous
implementation wrote the port number as data to the address derived from
the user-supplied value. By swapping the arguments to match the expected
value and port order, the intended I/O port writes are now performed
correctly.

> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 94dbc470cd6c0..7050f0f7fe3d7 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -224,17 +224,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t po=
rt, u32 val, size_t size)

[Severity: High]
This is a pre-existing issue, but could the caller of this function trigger=
 a
KASAN slab-out-of-bounds read when passing the val argument?

Looking at drivers/pci/pci-sysfs.c:pci_write_legacy_io(), the buffer is cast
directly to a 32-bit integer before calling pci_legacy_write():

    return pci_legacy_write(bus, off, *(u32 *)buf, count);

If a user performs a 1-byte or 2-byte write to the legacy_io sysfs file,
fs/kernfs/file.c:kernfs_fop_write_iter() dynamically allocates buf to the
exact write length plus a null terminator:

    buf =3D kmalloc(len + 1, GFP_KERNEL);

Unconditionally casting this smaller buffer to u32 * and dereferencing it
reads past the allocation boundary. Should the buffer cast be bounded by the
count parameter?

[Severity: High]
This is also a pre-existing issue, but does this legacy write path allow a
Kernel Lockdown and Secure Boot bypass?

Unlike standard resource handlers like pci_write_resource(), the generic
handlers in drivers/pci/pci-sysfs.c for legacy endpoints completely omit
the security_locked_down() checks.

For example, drivers/pci/pci-sysfs.c:pci_write_legacy_io() allows writes:

    static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *k=
obj,
                                       const struct bin_attribute *bin_attr,
                                       char *buf, loff_t off, size_t count)

And drivers/pci/pci-sysfs.c:pci_mmap_legacy_mem() allows raw memory access:

    static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
                                   const struct bin_attribute *attr,
                                   struct vm_area_struct *vma)

Neither function checks security_locked_down(LOCKDOWN_PCI_ACCESS). Can a
privileged user exploit this to write directly to hardware I/O ports or mmap
legacy memory?

> =20
>  	switch(size) {
>  	case 1:
> -		outb(port, val);
> +		outb(val, port);
>  		return 1;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175423.9830=
5-1-kwilczynski@kernel.org?part=3D1
