Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252C3AFCEB
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484893; cv=none; b=t/G5SRyEX9fkGBMPLLU7pyyddBPKd4jk9wfJgbQ3QIVcCKgGeeNaS00FokbA1OQ9MPZRhjU2xuadmZM02eHp2tf0+5Lzz/00F19fa9UaTgzgGUU6P0cVCC/8/4/1ejbGoIhlNmaE2qjoC+vMbXmlVz8V+HUy9q8mfw5ftSE2dVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484893; c=relaxed/simple;
	bh=u93wNS3AwLSER9gM0mSpUq3f6JnDlgVkvigftychwm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6dsKLdKWlOqfkT3Lb2KFhlMW6D/AKyVs+fxSeRdb7S+hUpezO3nBh5uzhSyM8Ii3HJzsrVrf9yrJS/nvxKVEqgRlurODrNOXTlXL2ow5V2ngTY+p+6YF5URqmy0UTA2pkH+3c7tLgtan0DQiAZJAZQb/V8/3GMgD+G24y1Af5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlfAel2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlfAel2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A5D1F000E9;
	Sun, 19 Jul 2026 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784484888;
	bh=rT+xWX8HebXhr2XQK4Pkq5JxWq+B5pbzGgPjKWTOsV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlfAel2pWbBvZDl/Aar2ufHEMv0UKpieGL57VUlpM7NckFS1Do5LU4jib6SDCZlkv
	 imlcMXT1LK3PfaDATd+BAayXrP4mCyfPsDTAb5wOD/m6NyJXBvjfuoS7qRBnHCy9qc
	 msYZez6jD7Hsv4nPNs6vTNgeSj4GohfaAGs6KwoRP6SwAv487CDEC1tQ4Mqxmzxc5v
	 loh4GxiGCQZ/zxlKk/EHVIDz6NwhKcBdZSy3ow9JiPJFuCbwexhuYCZ8dYolJSHD/z
	 QR4ParEMq27q1AfdQV2HnCufzGmsh2ljWZGHG1u2BI+KJzIm37Dk3VQfeTFqu7ltG2
	 qIJPU/wkYiVpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] treewide: Add a flag to detect the Apple T2 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260719180308.1398-2-atharvatiwarilinuxdev@gmail.com>
References: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
 <20260719180308.1398-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 18:14:47 +0000
Message-Id: <20260719181448.55A5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Spoofable PCI device check allows local attackers to bypass UEFI S=
ecure Boot revocations.
- [Medium] T2 Macs will suffer an EFI firmware crash if PCI enumeration is =
bypassed or disabled.
- [Low] Linking fails with an undefined reference to `has_t2_chip` on x86 a=
rchitectures when `CONFIG_PCI` is disabled.
- [Low] The globally exported variable `has_t2_chip` uses a dangerously gen=
eric name.
--

--- Patch [1]: [PATCH 1/2] treewide: Add a flag to detect the Apple T2 chip=
 ---
commit 371f6a2037c381d85697cd4a6b5cede313505414
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

treewide: Add a flag to detect the Apple T2 chip

This patch adds a flag to detect Apple T2 chips using a PCI early fixup.
It caches the result and replaces the existing DMI-based quirk in the EFI
certificate loading code to avoid repeated checks.

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c

[ ... ]

> @@ -995,6 +996,15 @@ static void asus_disable_nvme_d3cold(struct pci_dev =
*pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d=
3cold);
> =20
> +bool has_t2_chip;
> +EXPORT_SYMBOL(has_t2_chip);

[Severity: Low]
Since arch/x86/pci/fixup.c is only compiled when CONFIG_PCI is enabled, will
this cause a link-time build failure on x86 if a kernel is configured with
CONFIG_PCI=3Dn and CONFIG_LOAD_UEFI_KEYS=3Dy?

The declaration in include/linux/platform_data/x86/apple.h is active for all
x86 builds, so the missing definition would only be caught at link time.

[Severity: Low]
Is has_t2_chip too generic of a name for a globally exported symbol?

Exporting such a generic name to the global namespace might increase the ri=
sk
of symbol collisions with other components or out-of-tree modules.

> +
> +static void apple_has_t2_chip(struct pci_dev *pdev)
> +{
> +	has_t2_chip =3D true;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, 0x1801, apple_has_t2_chip);

[Severity: High]
Can this unconditional PCI fixup be spoofed by an external hotplug device?

If an attacker connects a malicious PCIe device (such as via Thunderbolt)
that spoofs this Vendor and Device ID before boot, has_t2_chip will be set
globally.

This would cause load_uefi_certs() to skip loading the dbx revocation list,
potentially allowing revoked, malicious kexec payloads or modules to bypass
Secure Boot.

[Severity: Medium]
What happens to actual T2 Macs if the kernel is booted with pci=3Doff or if
PCI enumeration fails?

If the PCI subsystem does not initialize, this fixup will never run and
has_t2_chip will remain false.

This would cause load_uefi_certs() to attempt reading the db and dbx UEFI
variables, triggering a page fault in Apple's firmware and crashing EFI
runtime services on these machines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719180308.1398=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
