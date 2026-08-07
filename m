Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F334CDD
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115578; cv=none; b=NyF8TFsgab1JjXUiMNy7n97BycFCstBf0LvLry7k8lcnOGYweDaJb3NV9GCzbQWYoyYCB+OWzZ9Upz/hHD0bybvIu9NUDb3mWM6zZOlUsHUOEWWbcOtbpGeIegfbPrM3Z3OaomVs67TsQZr9Bl3OiSN2VlPKFurLPoaxheZIgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115578; c=relaxed/simple;
	bh=zDXKTEWX1pI7NBm5GyjF1XbjQMTKWjE+TVm+1eLxBSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/0UEgNBlTUwldSPrirgzVASXeSg6VKuUSb6l8w1YFVM9WdjNb6h2XtHer0dPfSJxMiq7xH7BjnQLOfgPDI2CY1ABQUXZGBP03B+hi47JxP0hlmImpwQ3nFW7InTyK/t1q1qcrcLxrD1ujfoZvztavHavbDDgklXC+q1PYntM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZsugA/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZsugA/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FA1F00ACA
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115576;
	bh=w3idmkLYxvaX5dQDFxcBPWDJ2RpS4frlnOp764QzOiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QZsugA/TsQnVghgjFe1tpWFS8y8US3uVF010Z4zEEHOALY1f2dy5mGc9mhrrEIuqW
	 HKDV2qCKUUh0y2gTyoS0mzm3yfgh3EemVbFLML2HSlmWsOHo92/QqNfCGKq3Io0KZv
	 0G9vegoRgeYrXHh++c1OuDLXh3bpcVH9DsB3/5y+KH/1bqdJ6JxeRCG+C+M/mOj8rk
	 jiGjDajq9Hit5WX8nViY+d3LItJZyHl9rI4OXFTmSbxzDSw2CEMEvyHgQgirHEz6md
	 n45JqhSGQMrAs6QYwanaEA1IFs9T+NH4jy1DjsJ1BeFlsHfs1xNrihplTtF/dP5iTf
	 xkXLpl5TFCxRA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b015532f7bso3271288e87.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 08:12:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoP7gqh9BtW7wx5qX7dA7RK2ensE0WzR8zfPnSSbAnSFUMHVbfjMA3OnMcTcLWgTNM89wjpBAh+dXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnnLHRBxXky6mcWEWnxgZDTtoUwx8cAHY3k7EQiVHAsXo5oTd
	KWIVDdxLTddF4+qVLlYFRPgOV/X1rMro+MO8UyMwK6FxiINFgBxQLhdWDsRooY/N7qTfAg5Z0HJ
	tI7fTJ5+bg8w4OIC4qapjhfg2VbHS9QY=
X-Received: by 2002:ac2:4e10:0:b0:5b0:1669:1a00 with SMTP id
 2adb3069b0e04-5b2f4ccb516mr3477925e87.32.1786115575169; Fri, 07 Aug 2026
 08:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112052.857684-1-kazuma-kondo@nec.com>
In-Reply-To: <20260806112052.857684-1-kazuma-kondo@nec.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 17:12:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0MeLGgzHGihBXH3YBnDt4KGdq2uR8-F3H9b4Fszpx2Q@mail.gmail.com>
X-Gm-Features: AUfX_mxnYNK1cnghTgS2c7HVx38GGer4JLILGBUkje9kVgOVewCfNNqyBpHZqsc
Message-ID: <CAJZ5v0g0MeLGgzHGihBXH3YBnDt4KGdq2uR8-F3H9b4Fszpx2Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
To: =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:21=E2=80=AFPM KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=
=80=80=E5=92=8C=E7=9C=9F) <kazuma-kondo@nec.com> wrote:
>
> After commit 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of
> acpi_run_osc()"), the _OSC evaluation path now returns AE_ERROR to
> negotiate_os_control() instead of propagating AE_NOT_FOUND from
> acpi_evaluate_object().
>
> This has not caused any functional issues so far, but it produces
> additional misleading messages for non-PCIe host bridges without _OSC on
> some Intel servers:
>
>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Clock=
PM Segments MSI EDR HPX-Type3]
>   + kernel: acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug SHPCHotplug =
PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform willing to grant [PCIeHotplug=
 SHPCHotplug PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform retains control of PCIe featu=
res (AE_ERROR)
>     kernel: PCI host bridge to bus 0000:fe
>
> Previously, negotiate_os_control() silently ignored AE_NOT_FOUND for
> non-PCIe host bridges without _OSC, but after the above change, it no
> longer does so.
>
> As a result, negotiate_os_control() logs messages as if the OS had
> negotiated with the platform via _OSC, even though the non-PCIe host
> bridge has no _OSC method and no such negotiation actually occurs.
>
> Skip _OSC negotiation for non-PCIe host bridges that do not define an
> _OSC method before attempting to evaluate it.
>
> Fixes: 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of acpi_run_os=
c()")
> Link: https://lore.kernel.org/linux-acpi/d0be949d-0e21-472e-a44b-cedb1dd8=
695d@nec.com/
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
> ---
> Changes in v2:
> - Set *no_aspm to 1 when skipping _OSC negotiation.
> - Updated the debug message and the comment.
> - Link to v1: https://lore.kernel.org/linux-acpi/20260731090820.493064-1-=
kazuma-kondo@nec.com/
>
>  drivers/acpi/pci_root.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4c06c3ffd0cb..cab29a75a276 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -574,6 +574,17 @@ static void negotiate_os_control(struct acpi_pci_roo=
t *root, int *no_aspm)
>                 return;
>         }
>
> +       if (!is_pcie(root) && !is_cxl(root) &&
> +           !acpi_has_method(handle, "_OSC")) {
> +               dev_dbg(&device->dev, "_OSC: Skipping a non-PCIe host bri=
dge without _OSC\n");
> +
> +               /*
> +                * No ASPM for non-PCIe host bridges
> +                */
> +               *no_aspm =3D 1;
> +               return;
> +       }
> +
>         support =3D calculate_support();
>
>         decode_osc_support(root, "OS supports", support);
> @@ -615,10 +626,6 @@ static void negotiate_os_control(struct acpi_pci_roo=
t *root, int *no_aspm)
>                  */
>                 *no_aspm =3D 1;
>
> -               /* _OSC is optional for PCI host bridges */
> -               if (status =3D=3D AE_NOT_FOUND && !is_pcie(root))
> -                       return;
> -
>                 if (control) {
>                         decode_osc_control(root, "OS requested", requeste=
d);
>                         decode_osc_control(root, "platform willing to gra=
nt", control);
> --

Applied as 7.3 material with some minor modifications, thanks!
