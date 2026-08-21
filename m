Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1E374735
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336422; cv=none; b=U176CYZbNetJUPyrVR2xvXdtjk+LXQMrChAbAmyRpVaA8VOhdZO0Gr4mEuT+IpX8gPGnjlAF7uVwztSDbVVMmrKFASPMSZPqxJdgNEvkE2FbOqvbKTz1K07iH7dJeP6rgyf5HtP0OwnhBZKxUVOsbKLSzychezpR9eSzWUgmzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336422; c=relaxed/simple;
	bh=Hbn0PQOoTktUTftiLrEuevg3vqVU7O3+nFMdnQxawOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FU6wnJZN1Y87mkG0U0glKyNKqN8w1XKkb6tsqK2MSgSmCtWrlzR3C2/lzUs6lwDHF70fqNsMFecRG990eBMWUSj/e9h8tkSxsCgSNirpscFqjofRPEzvTp5bnspxTVvvC1QW44TVWjH1QDEXIqvEeDDZSdue2deXILjFzEoUjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpzVcT0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpzVcT0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245721F000E9;
	Fri, 21 Aug 2026 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787336419;
	bh=XhglmsicncowxpGyf4AJUOasDLP/gJFPVMneATqNVJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpzVcT0FiUjGLBRmi6DnxioILgD6bpZfAjk/tJRiJuZAOJpLFgqkk2Qmlry757IkL
	 ngNiuXrSlpK03B9dyVzUUkm/lFAQzN3wYWVxhkj2OvS7VLhrweub4a7zzBmuEa8pvW
	 LdB2qiEMERYoqe9OeEILznAFkZzgQwDAldg3qG4el12/PwIL3WwotX3iZQi66ev1Jf
	 LVMLOeTszuBvDE+NrKFyP5NlSc5YD8u1NKlzoy+E8HwLXCd/bmQoe029HW+2+uEWc4
	 FU0fDBiwFrBQhhYA/eOlg2db+Sykcu0qP8wsO3smomPSuuVJGB2Z8ND2SMnu0nRyL2
	 YxYRsCv5SiUsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260821181203.82722-1-lyude@redhat.com>
References: <20260821181203.82722-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 18:20:18 +0000
Message-Id: <20260821182019.245721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing NULL validation for the ACPI companion of the parent devic=
e leads to a potential NULL pointer dereference in `acpi_remove_pm_notifier=
()`.
--

--- Patch [1]: [PATCH] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 a=
nd 16AHP9 Nvidia GPUs ---
commit c5f31e20fc4140461290146739333c87be79e5ce
Author: Lyude Paul <lyude@redhat.com>

pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and 16AHP9 Nvidia GPUs

This commit adds a PCI quirk for specific Lenovo Legion laptops. It disables
spurious GPE wakeup events on the parent PCIe port of the Nvidia GPU after
it enters D3Cold.

Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..4d1f1565b61d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -6165,6 +6165,82 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA=
, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> =20
> +#ifdef CONFIG_ACPI
> +#ifdef CONFIG_DMI
[ ... ]
> +static void quirk_nvidia_dgpu_broken_gpe(struct pci_dev *pdev)
> +{
> +	struct acpi_device *parent_adev;
> +	struct device *parent_dev;
> +	int ret;
[ ... ]
> +	parent_dev =3D pci_physfn(pdev)->dev.parent;
> +	if (!parent_dev) {
> +		pci_err(pdev,
> +			"Can't find PCIe parent? Your Nvidia GPU will have broken runtime PM\=
n");
> +		return;
> +	}
> +	parent_adev =3D ACPI_COMPANION(parent_dev);
> +
> +	/* The spurious GPEs will be sent from the ACPI device for the PCIe por=
t this GPU is
> +	 * connected to, so remove our PM notifier to turn them into a no-op.
> +	 */
> +	ret =3D acpi_remove_pm_notifier(ACPI_COMPANION(parent_dev));

[Severity: High]
Can this cause a NULL pointer dereference if the parent PCIe bridge lacks an
ACPI companion?

ACPI_COMPANION() can return NULL if the system is booted with acpi=3Doff or=
 if
the node simply lacks an ACPI companion.

If that happens, this passes NULL to acpi_remove_pm_notifier(), which
dereferences its argument directly:

drivers/acpi/device_pm.c:acpi_remove_pm_notifier() {
    ...
    if (!adev->wakeup.flags.notifier_present)
    ...
}

Should parent_adev be checked for NULL before calling
acpi_remove_pm_notifier()?=20

Also, it looks like parent_adev is assigned but then
ACPI_COMPANION(parent_dev) is called again instead of using the local
variable.

> +	if (ACPI_FAILURE(ret))
> +		pci_err(pdev, "Removing PM notifier failed: %d\n", ret);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821181203.8272=
2-1-lyude@redhat.com?part=3D1
