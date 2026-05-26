Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2821638D
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809297; cv=none; b=AuIjygVbF2D5bmEo07R9+GyJpXChDQVLUXINgvWhNm9IfxLrfn1npio9+XKq4q+4j/pxSQwhTPsMD5FRFVPDkbHD4mWBH4aHAbe7mYmtu7Dy2IkuljW1LNV67QaI4BcpciToO8spE35x7WVKcYrZooFWnNR+OfO5yG5fSsJIv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809297; c=relaxed/simple;
	bh=ReZ2/rS5lGpCs0To1uHpeMLAQwIIl2Bh5k431VBs0pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivihmnkKOMtYXTqlwuaEfobgz4kZd6GN1Qs8FBilbySyJ63DhDw/Tke29bBDh4wZINjB1lNyd6pzdfAD5GdpXPhhsJ7tgQxLp/0JGcHRdywxDqg+B8xdS4krhCboINz4FiBcO/5wgwIGx9NFEbsgHx7prV9sj0OYXMTwCJPl6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxb/eZy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxb/eZy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E61F000E9
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809296;
	bh=e4B2+g2DnrxVkeX9BainRIBrXTQVp2da9LdiS2rk6yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vxb/eZy33k2tnsAD2XwMtnCTnaKNQHgS0fpGpteiR/wZrUqCDMcImc7Mx5aO/I86L
	 drvRxtjeWASlt5k2OBrvXglPuSJrNIc8+1UCkZWyjPMtHufs+IW23lccm+7YQDRKdr
	 vvmyeMtAVKNqBWs0LhOmpHn90kfjXwj/pc/SkAlr/DViYkBerDhJMYsYmgxkaKLyPX
	 V5IFq1OPHWGcCDtKLif7bPhRlhzA7ycObKdUTsfFQHhwhoJOR3fQZfOGVQTG1GYpGU
	 snJ5zBWYkJQ+IfckQgSeg5jFdV2BMNiTGAFrCqdpSgxR3//9W6oSwj6UyXzR/fo7eO
	 OoE1abWxaS61g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8f9841616so8746815e87.0
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 08:28:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9vXfPDYkKy0SQ0FQfE92Xpv2x5UyEpOEuzFhw9vGfwTxcjOt6HlGTSP/BN/zQG4RPYUYlDfapt1+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+NWIEnylA6H4Plfs4r6E2cu2X4hsTA0QrCOiZg5IGmrT7Eza
	tcj8CiBwlyjkGsMDbBWUBlTEx8UmEP7o/4hYWxtPZfAK+L9+5kXPYp6WNOE4creF1lzUQ7duhex
	0M5OK3KwgLImOyzBLx4IgT8GK4XjAKDA=
X-Received: by 2002:a05:6512:3ba9:b0:5aa:fd2:ae35 with SMTP id
 2adb3069b0e04-5aa323c48e5mr5701744e87.44.1779809294609; Tue, 26 May 2026
 08:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-7-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-7-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 17:28:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyTirqGGVY_U4LEvbnerSLRHewCDW+h-RoziFqw7udBA@mail.gmail.com>
X-Gm-Features: AVHnY4JFZICYGX9mZUqfUI50PyndxzlyIy3tWn98m0B0BtVipDp1vah42rXZIPU
Message-ID: <CAJZ5v0hyTirqGGVY_U4LEvbnerSLRHewCDW+h-RoziFqw7udBA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] PCI: Put PCIe bridges with downstream devices into
 D3 at hibernate
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> During suspend, PCIe bridges with downstream devices are transitioned int=
o
> a low power state (D3hot or D3cold) depending on platform capabilities.
> However, during hibernate, these bridges remain in D0, which can lead to
> unnecessary power consumption.

The platform firmware is supposed to power them down though when the
platform is going into S4 unless wakeup devices (that can wake up from
S4) are configured below them.

> Align the hibernate flow with suspend by updating pci_pm_poweroff_noirq()
> to use pci_pm_suspend_noirq_common(). This ensures that PCIe bridges with
> active downstream devices are properly transitioned to a low power state
> during hibernate.
>
> This change introduces a functional update: the hibernate path will now
> invoke pci_save_state(), and =E2=80=94 unless bus-level power management =
is
> skipped =E2=80=94 will transition the bridge into D3hot or D3cold as appr=
opriate.

This is somewhat risky because it wasn't done previously and, again,
it would be good to have some explanation of why it is needed now.

> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3c82d818ee15b..50eca518493b8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -788,7 +788,7 @@ static void pci_pm_complete(struct device *dev)
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> -#if defined(CONFIG_SUSPEND)
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
>  /**
>   * pci_pm_suspend_noirq_common
>   * @pci_dev: pci device
> @@ -834,7 +834,7 @@ static void pci_pm_suspend_noirq_common(struct pci_de=
v *pci_dev, bool *skip_bus_
>
>         pci_pm_set_unknown_state(pci_dev);
>  }
> -#endif /* CONFIG_SUSPEND */
> +#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
>
>  #ifdef CONFIG_SUSPEND
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
> @@ -1191,6 +1191,8 @@ static int pci_pm_poweroff(struct device *dev)
>         if (device_may_wakeup(dev) && system_state =3D=3D SYSTEM_POWER_OF=
F)
>                 device_set_wakeup_enable(dev, false);
>
> +       pci_dev->skip_bus_pm =3D false;
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>
> @@ -1233,6 +1235,7 @@ static int pci_pm_poweroff_noirq(struct device *dev=
)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       bool skip_bus_pm =3D false;
>
>         if (dev_pm_skip_suspend(dev))
>                 return 0;
> @@ -1254,8 +1257,9 @@ static int pci_pm_poweroff_noirq(struct device *dev=
)
>                         return error;
>         }
>
> -       if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
> -               pci_prepare_to_sleep(pci_dev);
> +       pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
> +       if (skip_bus_pm)
> +               goto Fixup;
>
>         /*
>          * The reason for doing this here is the same as for the analogou=
s code
> @@ -1264,6 +1268,7 @@ static int pci_pm_poweroff_noirq(struct device *dev=
)
>         if (pci_dev->class =3D=3D PCI_CLASS_SERIAL_USB_EHCI)
>                 pci_write_config_word(pci_dev, PCI_COMMAND, 0);
>
> +Fixup:
>         pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>
>         return 0;
> --
> 2.53.0
>
