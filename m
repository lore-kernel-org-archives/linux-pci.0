Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CB503BCA
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566674; cv=none; b=UCg1o20zSFYmnPPCCA54/yNjnRagSKBTe+DvuHLhpovgB7GkXtt5rqEFvZ138rhh7cdgwqfe5yJ5MwblpHGfudhAQ0l9XHbEq+U+nce8CTSnEK46NPCehn25+LeAMDIlN3ZAXfTE4ClZI7lI5iqawpxyIvCSaodq2tp+PziiFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566674; c=relaxed/simple;
	bh=d0fNw7I7yFDopuJWtzYWjixrWoj6HGW9S6RdWVGAagM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOe2U71kG1xaNQcjOjYR4b7T4VnMQmlBBW5pAG0h0usc+1YgPI1A8CGbH//uXORUMqmH3SdCrgO3BOToXqSyM/yXoqQwoGYHSGeYybvKuNmLIPtOXthwXZSMA2rcOYDQ5vEZu7Xaph7aeAS31uuP2Bss/APZI7UIaeYgegSUj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGrFBkee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGrFBkee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7897E1F0089D
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566669;
	bh=EcwfPW4QP5Xml74DanZs2iwT1Yn8MF2fALNKcDOscV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iGrFBkeeNA4UPiv5QNna8P4/oEhNLw43BKpT+7hH+Nz3uL0K/tJ2kElyiz/dYRfte
	 qaSHOLD2cSUQoh7SOxOlUMjQ8xhoSaqR0SqzPTwiW2T4FqrMXd1Rg47BQEMwGgepC+
	 Po4cJ5lzyV/Y0JtUmYh/runOnv9koMKz7KqOVFJDQ/wofHZ+ows9O6u5Gw9uRzOJpv
	 jo0bg3v73nwlk0t0l5P6fipJu/kaAVDd0eorUm8drgiCO6BGEW4PomXd37WUCHuaPy
	 kIrBQlzZCdI5wmunsG8dApzXwgpRZqza2RLlQprL6yhVp8ONtN/55wlVX832ZYFHmc
	 8xDpi5Im3A/5Q==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso395024e87.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwAVeT6xmiQS5X+AMT3r+T0GOa+Nt/I9LVKt2T2+g9mCvKt1a83Haypz5wPnMjmeHvQBPsbmh4jfI0=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ677LuQWB7ZnRo8C9F7nOLkO7Q6iqWNsDj49DeScXa9q0cEzI
	+37SZQnpNndFPHfrmIiTSxxAHdAwgMsLZef7uMbtUA/j/csWuK9OkB9xh7kHVbGou8a05jQZuIi
	2LgXLraR0kB0rhsrkX7mbJR9U31fUMOA=
X-Received: by 2002:a05:6512:3da1:b0:5b4:ab3a:8305 with SMTP id
 2adb3069b0e04-5b8b63de08cmr671011e87.11.1789566667769; Wed, 16 Sep 2026
 06:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916051034.180226-1-mario.limonciello@amd.com> <20260916051034.180226-2-mario.limonciello@amd.com>
In-Reply-To: <20260916051034.180226-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 16 Sep 2026 15:49:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4sBVBOnJJV3tnq_z8P8QEzwTCL+3gmws2uoRhy_gFVg@mail.gmail.com>
X-Gm-Features: AcwNN1UfjPKEn2vX1e_V6wm29RAqdEFLzqinUNOeIY2SM4G4LjkXRrSYKHB4KQI
Message-ID: <CAJZ5v0g4sBVBOnJJV3tnq_z8P8QEzwTCL+3gmws2uoRhy_gFVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI/PM: Split out code from pci_pm_suspend_noirq()
 into helper
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:10=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>
> In order to unify suspend and hibernate codepaths without code duplicatio=
n
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> v4:
>  * Make pci_pm_suspend_noirq_common() bool instead (Rafael)
> ---
>  drivers/pci/pci-driver.c | 77 +++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e16aa59dd7ac8..8334214f8c1ed 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -818,6 +818,52 @@ static void pci_pm_complete(struct device *dev)
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> +#if defined(CONFIG_SUSPEND)
> +/**
> + * pci_pm_suspend_noirq_common - prepare a device to enter a low-power s=
tate
> + * @pci_dev: pci device
> + *
> + * Save the device state and decide whether bus-level power management s=
hould
> + * skipped. Returns true if bus-level power management should be skipped=
,
> + * false otherwise.
> + */
> +static bool pci_pm_suspend_noirq_common(struct pci_dev *pci_dev)
> +{
> +       if (!pci_dev->state_saved) {
> +               pci_save_state(pci_dev);
> +
> +               /*
> +                * If the device is a bridge with a child in D0 below it,
> +                * it needs to stay in D0, so check skip_bus_pm to avoid
> +                * putting it into a low-power state in that case.
> +                */
> +               if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev=
))
> +                       pci_prepare_to_sleep(pci_dev);
> +       }
> +
> +       pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
> +               pci_power_name(pci_dev->current_state));
> +
> +       if (pci_dev->current_state =3D=3D PCI_D0) {
> +               pci_dev->skip_bus_pm =3D true;
> +               /*
> +                * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if =
any
> +                * downstream device is in D0, so avoid changing the powe=
r state
> +                * of the parent bridge by setting the skip_bus_pm flag f=
or it.
> +                */
> +               if (pci_dev->bus->self)
> +                       pci_dev->bus->self->skip_bus_pm =3D true;
> +       }
> +
> +       if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
> +               pci_dbg(pci_dev, "PCI PM: Skipped\n");
> +               return true;
> +       }
> +
> +       return false;
> +}
> +#endif /* CONFIG_SUSPEND */
> +
>  #ifdef CONFIG_SUSPEND
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>  {
> @@ -907,6 +953,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       bool skip_bus_pm;
>
>         if (dev_pm_skip_suspend(dev))
>                 return 0;
> @@ -937,36 +984,10 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 }
>         }
>
> -       if (!pci_dev->state_saved) {
> -               pci_save_state(pci_dev);
> -
> -               /*
> -                * If the device is a bridge with a child in D0 below it,
> -                * it needs to stay in D0, so check skip_bus_pm to avoid
> -                * putting it into a low-power state in that case.
> -                */
> -               if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev=
))
> -                       pci_prepare_to_sleep(pci_dev);
> -       }
> +       skip_bus_pm =3D pci_pm_suspend_noirq_common(pci_dev);
>
> -       pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
> -               pci_power_name(pci_dev->current_state));
> -
> -       if (pci_dev->current_state =3D=3D PCI_D0) {
> -               pci_dev->skip_bus_pm =3D true;
> -               /*
> -                * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if =
any
> -                * downstream device is in D0, so avoid changing the powe=
r state
> -                * of the parent bridge by setting the skip_bus_pm flag f=
or it.
> -                */
> -               if (pci_dev->bus->self)
> -                       pci_dev->bus->self->skip_bus_pm =3D true;
> -       }
> -
> -       if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
> -               pci_dbg(pci_dev, "PCI PM: Skipped\n");
> +       if (skip_bus_pm)
>                 goto Fixup;
> -       }
>
>  set_unknown:
>         pci_pm_set_unknown_state(pci_dev);
> --
> 2.43.0
>
