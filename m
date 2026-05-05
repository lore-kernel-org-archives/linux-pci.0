Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FD3E5572
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004576; cv=none; b=OUeCc6RgGwHZe/bN8/yBC9tORfgZrNRw+3fTfm+OfSXsd1Op8QZnfQO3YLgEHs8svbq0w8xAXPI4t85T0Xh0XTznupkLVX64ISxL8H1CCM1moxHuM7Nlyhxj1a+nqi1p6p3/JGZgmbd3tgK/ivk25ByLR2vgkhoTWl3s2lT9Vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004576; c=relaxed/simple;
	bh=MLgyzFRgufGYkU5ISwC+ZrbjcgCWw3g6pOSfMpAdo5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk7Boo+FmSYqcYasFngnRF1qcPSRQVwZpVOyj2c/B9MCWc9UNAvmtAUH0Kon2yZ52hWxxP17uRUjctCUm3mvUMpsKRLo6y4fq7QQ5tvE21EEtRLLlXK4aDn1ah5eJpKYwJ7AbeoWzZgnOiyF7BfyHPiVCCg2P+iUK1k1ul7XPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7L1h97H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7L1h97H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524E5C2BCF6
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778004576;
	bh=MLgyzFRgufGYkU5ISwC+ZrbjcgCWw3g6pOSfMpAdo5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B7L1h97H7NMDS+9N6vFZdMlITAUWcIBKUJoDlwkXDtH/wLWDYQJnsFe3UL4woiT+M
	 peXWjB19lv2sBNJIoxmH/jX7/wlnAItwxJAUCGNyNOP82EPVwPB0wDFebKBEfNdR+J
	 UeFo7EJGtnGfsDXjQghTAiwe9Lg0l+PfMMtDTLKM5edZeCUoVebq1iTVoELqZlbn4h
	 u+q0MRf4XdhnHI/+QIgDFwRzdXyTFbEY8oWiYOomx60ZOdh5qpYuUhFfvqUBM8VXwR
	 P1vV4gyLmkKeVQFZPo6fyoh23rpEMC1NwceZaKQcVkkXFFzQZ1uESpQfbP0xNQx0VG
	 J/GN/c214uyKw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39378db197aso37904441fa.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 11:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9XAnj+oSZzeaQ0AUJ/cMrymXXtJZzstBSMhSuFXGMs5FFPD0WGy18MgzZCUABBgVGnpLkhv/XLBzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzopKCt7WMjrWILlvI+g3gaRu36KUIfDnrVD7OTGtxEyz9avmuC
	n3cBvOhoxLbzHI/3hyhv+E/akosyow7JZHH2xoVlhjTmE8q+BUjLVvsKnwCnOPzk7vQZN+edIig
	NrJcHA1JYbKny323969EWrLRd3CcnlCc=
X-Received: by 2002:a05:6512:39d2:b0:5a8:6e69:de98 with SMTP id
 2adb3069b0e04-5a86e69df06mr5145712e87.32.1778004574650; Tue, 05 May 2026
 11:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504225246.480921-1-mario.limonciello@amd.com>
In-Reply-To: <20260504225246.480921-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 May 2026 20:09:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2NKNU2NTkXbH0FrBsYQJXVbNVxKCMtUUkNcSkFuMQLg@mail.gmail.com>
X-Gm-Features: AVHnY4Jnzbaa3zK5Y3utMPenN_GfnIUBus9Mv-ao9roezATLuZlg2Eb4ZaMPaeI
Message-ID: <CAJZ5v0h2NKNU2NTkXbH0FrBsYQJXVbNVxKCMtUUkNcSkFuMQLg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Mika Westerberg

On Tue, May 5, 2026 at 12:53=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When comparing lspci output between Windows and Linux for hotplugged
> Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
>
>   Windows: LnkCtl: ASPM L1 Enabled
>   Linux:   LnkCtl: ASPM Disabled
>
> This difference in ASPM configuration can cause behavioral differences
> between the two operating systems for the same hardware.
>
> The root cause is that Linux's default ASPM policy (POLICY_DEFAULT) relie=
s
> on firmware/BIOS configuration. For hotplugged devices like Thunderbolt/U=
SB4
> eGPUs, the BIOS may not have configured ASPM since the device wasn't pres=
ent
> at boot time. As a result, link->aspm_enabled is 0, link->aspm_default is
> set to 0, and Linux never enables ASPM for these devices.
>
> Devicetree platforms already have special handling to enable L0s/L1 by
> default regardless of firmware configuration. Extend this same logic to
> removable devices when firmware hasn't configured any ASPM states.
>
> This makes Linux behavior more consistent with Windows for hotplugged
> Thunderbolt/USB4 devices.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221319
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pcie/aspm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff0..77497d90be0b7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -804,8 +804,15 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
>         struct pci_dev *pdev =3D link->downstream;
>         u32 override;
>
> -       /* For devicetree platforms, enable L0s and L1 by default */
> -       if (of_have_populated_dt()) {
> +       /*
> +        * For devicetree platforms, enable L0s and L1 by default.
> +        *
> +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and=
 L1
> +        * by default if BIOS didn't configure any ASPM states. This hand=
les
> +        * hotplugged devices where firmware may not have configured ASPM=
.
> +        */
> +       if (of_have_populated_dt() ||
> +           (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {
>                 if (link->aspm_support & PCIE_LINK_STATE_L0S)
>                         link->aspm_default |=3D PCIE_LINK_STATE_L0S;
>                 if (link->aspm_support & PCIE_LINK_STATE_L1)
> --
> 2.43.0
>
