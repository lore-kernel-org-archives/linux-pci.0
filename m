Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F91AA7A6
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079657; cv=none; b=d2r3MAJTeYpSSmYQQy6ft6cdPqZBDX7I70GMRgorKG8j1rIb9J2m6Wz30iHaEyG6uOwunA++tuzMUzdti7YTHjI+qVx4y6RUtVLF4G37MilKp+8NS4loZnOa9FKvsf3q4eeugnVaad5UihpMTwewDUKtUctqhDpYTkE4Y5+zg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079657; c=relaxed/simple;
	bh=xmR4ROolpQ29fAzsqbQHWkq6/+/BOUM2aex2Z1yVbSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJ1s7a1BWvP1xCSomo4FW00Q1VIQ6KnoxZzaioDPF3jaVW9NGZ/vHELtq+EQxGX8Bd/n4tU9HocG4iK0XBimzZYV7qj5o102uZC/PByplFjwzANDPAj1rzqpjFFJwzPlENZ5GAckjvG/e6ROFhavyMkAO87drrfJHEEQdkP8hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLh1Mw4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLh1Mw4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00AC1F0089A
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781079656;
	bh=2s+zfdXPY3rZg82ouUE8Qe1zy1F+JhQQiel36/N3QL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NLh1Mw4szQVIRvhps+ZUwNwPaIN2tOT6/leq6GR7p0XNACzjWTBKi6YVFNAEzA8GW
	 kDYBDkkre1fixlgD5e0U+05pGAgToMDqc1tquLJayEH9qcVDozSmUJb4NFJMXfNpHM
	 /cz+5p2bxX67arMbfrlriTXUHPFn0R/lapXtxV/U/qQ/8hPAkkk+UV5hqGxJVCXAf4
	 cxNwYBmeh2g4ui2fIdW7Pn3VRp2VKjQFBF/vaB05sU5Md5mkn4dz3Lu91id0pTjO1Q
	 yNJXLVczqKn4NG/waXZ9nXDfI2YQjJS1PijAhKJ9CR0AnVqAlbO/x2/Kn2epryXsZW
	 mwWR+H6o1RRBw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so9346991a12.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 01:20:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8/bfkzqWM1mzJJ2aWLIz0aHHTwoumtMNoW5CZdTidLQkJyId8CBXy2ezzftDJyvCJY4rb0KrXTQE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsXXxEPmqEQsF1/SFexdcqWt00bNa42p6rDFYJpxETjBFcley
	JVCSbEYAfEetRfcwwLpr4kC8QC5+slu3DRsB2pW+TvTmUXwtMCpDCiPwAYNGyTBi9JfLLJ2ukbO
	UXC0e/3WDdtEQmoD2taWNfdYWUpodf9w=
X-Received: by 2002:a05:6402:3809:b0:68d:abcf:9593 with SMTP id
 4fb4d7f45d1cf-68fa5149f11mr9990720a12.17.1781079655263; Wed, 10 Jun 2026
 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609152511.753760-1-xry111@xry111.site>
In-Reply-To: <20260609152511.753760-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 16:21:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
X-Gm-Features: AVVi8CfHp-4U09EL6DLYVVbOkH7bXHdKskTsjFQhNXaFgzzoUDZhsqUBsJSwU8I
Message-ID: <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
Subject: Re: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29]
 Root Ports rev2
To: Xi Ruoyao <xry111@xry111.site>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, Han Gao <gaohan@iscas.ac.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Tue, Jun 9, 2026 at 11:26=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> board using the same 7A1000 bridge chip exhibiting the same issue with
> pcie_aspm=3Dforce and pcie_aspm.policy=3Dpowersave (ASPM is not enabled b=
y
> default on the 3A5000 board because it's based on ACPI and the _OSC
> method has not been implemented in its DSDT/SSDT yet).
>
> This seems only affecting the 7A1000 chips shipping the revision 2 of
> the PCIe x8 Root Port: on other two boards with a (persumably older)
> LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> issue does not reproduce.
Is that confirmed by chip designers?

>
> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Henry Chen <chenx97@aosc.io>
> Cc: Han Gao <gaohan@iscas.ac.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for de=
vicetree platforms")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index a4250d7af1bf..dc7cee10643e 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(struct p=
ci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_br=
idge_speed_quirk);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_br=
idge_speed_quirk);
>
> +/*
> + * Some devices, for example Intel 750 Series SSD, experiences data loss
> + * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is enabled=
.
> + * This seems only affecting the revision 2.
> + */
> +static void ls7a_pcie_port2_aspm_quirk(struct pci_dev *pdev)
It is better to follow the namings in this file, i.e.
loongson_pcie_port2_aspm_quirk, or loongson_pcie_aspm_quirk for short.

Huacai

> +{
> +       if (pdev->revision =3D=3D 2)
> +               pcie_aspm_remove_cap(pdev, PCI_EXP_LNKCAP_ASPM_L0S);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT2,
> +                        ls7a_pcie_port2_aspm_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>         struct pci_config_window *cfg;
> --
> 2.54.0
>
