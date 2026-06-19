Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E1364927
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860335; cv=none; b=Wvd2WJl+gx5MJZ4m8KGhjZTNqO+5TcaYWTH4Chtp4QCrNhzMP9E7nGhO1s5F1+FTAxcQZDP40ZkDIYFmsnOMcMGJgnf3AHspzx9ju0LQAQzt1I9IzDH6itGJs4EACI6P3NEgePQGUAfM7Q+6ZiVpqbc+a4V37nZAwwteV/vfpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860335; c=relaxed/simple;
	bh=JaWSHGj3NTKY1XdZeM55CeDCx21Cmwsg7FbCTJO6p6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QPZuw/ZkSqCLN+eGMXwZknMEYA1c7pEIlsT3N5K4GQxs3dquPHYz3SQXgl1A7+Dx33LLbhkPb93zxNpokTfb8hCdIR+kAfKM8dWd7mtlMHWO8O0NuXWsxuAoFUN/sD5w9akHQ4ndHau0YTyeOmHvAnn3vcsUEt3XbR1tH6CrwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGK6wSrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGK6wSrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0081F000E9;
	Fri, 19 Jun 2026 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860329;
	bh=MqmZTshXbNQYIMCLBv9Y1Qhy1Dhy+/EDq3wCb+/E2G4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGK6wSrD+uFgA6LsfAXPNaN6K2XbtzSTb1YuBw4b/c+n7J6y+l+I3KH14s/7nidG3
	 wFWOgxcmpPiSLYXF8GVr+ryA34ZwrVBJiRu/NuoIfsW8XU4DCChgyr3fdd/F6tKw5e
	 4d08lqRYkJjKxKUwDT70t7iqMs5Zsk5It0OtnMuTCIxoPH4s9BViT9K4Vkr6w5qH93
	 qZHPaXlddPpRA/bpHSe19C+BZPp/VqNnjAkTsMo8NfZQn+FQ3IyFb9/dbOycF7YJdc
	 osWCNte1b/8XQDZYavQue5SPbxsgQDT2Tp4XaAUfGIQzPHz/+7wYj03DQKb7MFQuY/
	 HDlbVhJnMRG1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/25] alpha/PCI: Compute legacy size in
 pci_mmap_legacy_page_range()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-21-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-21-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:12:08 +0000
Message-Id: <20260619091208.CC0081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Legacy PCI sysfs interfaces (legacy_mem and legacy_io) bypass the =
`security_locked_down(LOCKDOWN_PCI_ACCESS)` check.
--

commit db07f943a60b56a40842995e84a339a8791f8af6
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()

This commit updates pci_mmap_legacy_page_range() to compute the legacy
resource size directly using PCI_LEGACY_MEM_SIZE and PCI_LEGACY_IO_SIZE
macros. This decouples the bounds check from struct pci_bus fields that
are planned for removal.

> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index ae448a2e40c54..74c9145e02536 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -173,8 +173,11 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, =
struct vm_area_struct *vma,
>  	int sparse =3D has_sparse(hose, mmap_type);
>  	unsigned long res_size;
> =20
> -	res_size =3D (mmap_type =3D=3D pci_mmap_mem) ? bus->legacy_mem->size :
> -						 bus->legacy_io->size;
> +	res_size =3D (mmap_type =3D=3D pci_mmap_mem) ? PCI_LEGACY_MEM_SIZE :
> +						 PCI_LEGACY_IO_SIZE;
> +	if (sparse)
> +		res_size <<=3D 5;
> +

[Severity: High]
This is a pre-existing issue, but since we are updating the legacy PCI
mmap paths here, I noticed that the generic legacy sysfs interfaces
appear to bypass kernel lockdown restrictions.

Looking at drivers/pci/pci-sysfs.c, functions like pci_mmap_legacy_mem()
and pci_read_legacy_io() do not seem to verify the lockdown status before
granting userspace access to raw PCI memory and I/O ports.

Standard PCI resources correctly check
security_locked_down(LOCKDOWN_PCI_ACCESS) in pci_mmap_resource(), but
the legacy handlers seem to omit this verification.

Could this allow a privileged user to bypass Secure Boot kernel lockdown
by mapping and accessing raw hardware resources directly through these
legacy interfaces?

>  	if (!__legacy_mmap_fits(vma, res_size))
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D20
