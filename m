Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3EA21A92F;
	Tue, 23 Jun 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205374; cv=none; b=R8Jt8jXzZOCIByX8BvEXbM10q8I91y8mv0zTP28a8EQ+4zXb6BWJaZwT9U0uXhMX4jMmyqrsf3DzxEGcsgtaocWxRyhHLWtqij/LcLQ3IiDmIxe3v0angMWF4mN2sZ6AYOCA6iH4sg0ytN7gmYduRv8UdWjMAMfL5W6WVJgKdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205374; c=relaxed/simple;
	bh=qnFxUH56UFHNq5SH1v1UJT9JyL1GDSe4LsYnZmM20u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VmqBOMcr3rUUeNvi4Ef8NlR8aUecDEHVSredCtzGmA8nmSyr9/WzUoz6uzK3lTYyooARJ0nZlNCn5mb59aawYdGlcTrVOYmTulRfwpIkm5TIOgnx5EfdNCcrL/YC8h8gbw0ypVjPJBhgZpQ+9lvfbAH+YjMuRTwVYZAC7Ln1nDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd5SVeJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd5SVeJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0261F000E9;
	Tue, 23 Jun 2026 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205373;
	bh=ej0iTTUXN5uIDMEP0KIb8Khmjkrm8hV9TkIX0xVMI4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zd5SVeJWmajGLrpwUQMp2zmehhFpFzCDF66S+AW6LEaiQjAfqYNbrDtwdPUGAkoPT
	 2VoPNfSyGFku1QGznzzTuTq+jFizgfFGY3lqv+3ilR6KBjf6hTf168PATOuUdXFu9F
	 6kB+GeGPVc8Kj5S7sBn4JG1OPijynGovsY0MfOPvuGgOR5arZDSKyV7Um6mBKn1ByX
	 D4ZZdsG0Wej5drRP7kGedZIYhU7T4fjoyJ9woXEvXsgJHsdzxZrMLXP4nYHKxkmexD
	 JcUU+rqZZYXrqxsyhCgzEm+Ei93SW4+/O47JOrvELEndqBbSScisVl0zplWrYbR6pb
	 8j6lqi4v1InNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 08/12] PCI/TPH: Add sysfs binary file to
 export CPU to steering-tag mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-9-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:02:52 +0000
Message-Id: <20260623090253.1E0261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using `pci_read_config_dword()` to read the PCIe capability regist=
er `PCI_EXP_DEVCAP2` reads from the wrong offset in the base PCI configurat=
ion space.

Pre-existing issues:
- [High] Missing ACPI buffer length check before dereferencing u64 data in =
`tph_invoke_dsm()`, leading to a potential out-of-bounds read.
--

commit a6ad2b09ffbe79acf9a6193d9d9e38bc463af8b8
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add sysfs binary file to export CPU to steering-tag mapping

This commit adds a per-Root-Port sysfs binary attribute tph_cpu_st to expose
the ACPI DSM CPU-to-ST mapping to userspace. It supports unaligned partial
reads and implements dynamic visibility rules to ensure it is only exposed
on PCIe Root Ports that support TPH and provide a valid ACPI DSM.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index c080cf5401a31..bb6f24eccafcc 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -130,8 +131,47 @@ static acpi_status tph_invoke_dsm(acpi_handle handle=
, u32 cpu_uid,
> =20
>  	return AE_OK;
>  }
> +
> +static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
> +			       union st_info *info)
> +{
> +	acpi_handle rp_acpi_handle;
> +	struct pci_dev *rp;
> +	u32 cpu_uid;
> +	int ret;
> +
> +	ret =3D acpi_get_cpu_uid(cpu, &cpu_uid);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	rp =3D pcie_find_root_port(pdev);
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return -ENODEV;
> +
> +	rp_acpi_handle =3D ACPI_HANDLE(rp->bus->bridge);
> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, info) !=3D AE_OK)

[Severity: High]
This is a pre-existing issue, but does tph_invoke_dsm() lack an ACPI buffer
length check before dereferencing u64 data?

Looking at tph_invoke_dsm(), it appears to unconditionally cast and derefer=
ence
the returned ACPI buffer pointer:

drivers/pci/tph.c:tph_invoke_dsm() {
	...
	if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
		ACPI_FREE(out_obj);
		return AE_ERROR;
	}

	st_out->value =3D *((u64 *)(out_obj->buffer.pointer));
	...
}

If a buggy or malicious ACPI BIOS returns a buffer smaller than 8 bytes, co=
uld
this result in an out-of-bounds memory read?

Although pre-existing, exposing this via the new tph_cpu_st sysfs attribute
might allow a root user to systematically trigger this evaluation across all
possible CPUs.

> +		return -EINVAL;
> +
> +	return 0;
> +}

[ ... ]

> @@ -615,3 +661,78 @@ bool pcie_tph_supported(struct pci_dev *pdev, bool w=
ant_ext)

[ ... ]

> +static umode_t tph_cpu_st_attr_is_visible(struct kobject *kobj,
> +					  const struct bin_attribute *a, int n)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +	bool is_root_port =3D pci_is_pcie(pdev) &&
> +				pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT;
> +	u32 devcap2 =3D 0;
> +
> +	if (!is_root_port)
> +		return 0;
> +
> +	pci_read_config_dword(pdev, PCI_EXP_DEVCAP2, &devcap2);

[Severity: High]
Does this code read from the wrong offset in the base PCI configuration spa=
ce?

PCI_EXP_DEVCAP2 is an offset relative to the PCIe Capability structure, but
pci_read_config_dword() takes an absolute offset in the base PCI config spa=
ce.

Should this use pcie_capability_read_dword() instead so the attribute
visibility is determined correctly?

> +	if (!(devcap2 & PCI_EXP_DEVCAP2_TPH_COMP_MASK))
> +		return 0;
> +
> +	if (!tph_dsm_supported(pdev))
> +		return 0;
> +
> +	return a->attr.mode;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D8
