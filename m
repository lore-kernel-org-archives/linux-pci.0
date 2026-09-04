Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3912E7162
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527068; cv=none; b=MtFCtQfNIZx+gM/arLFXU4+xvy55OSRRuUY5eX5WlQL1oRoUuTqhQdOjzDtaCGZ7ru0hbntZ+y9BV3Ktcp1Bg59dtsF+RMQOFI3XgiLpR4nJVtQnZtMELbZsMY9uTD0ECgp0aS3veQVIMKEF86ujXNthDuW0Xr+e1gwHKWIZUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527068; c=relaxed/simple;
	bh=pz4znyfHAVxRoNFZ5O9A/Am6C73BJY3MN0MVVjlXt1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juBTGyEzuiS5M0EiEqQ8AYEpwLP+rGiQ5lVe/+cOI5f0/PjpZ4lZR+8Arh+3tHaxvqLXGt0NwBz2qygHwwrFgfDwk9i1UGjqLo+jj7/0jah4NsJVEaxwBMUttIgpDgWWxizVf9avFOSmf2kmnfOCw0MZSw2ybCaw5rLMcNg3+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCdjBjX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCdjBjX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68ED1F00AC4
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527065;
	bh=dPfyTpAM0H5vMW96Ce0wYMVnlBHfCGUWFqIOSULrGrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YCdjBjX5yF/GfYzA3rofivLaOx1pZG0ZCJJgPiSMLtTrDqmjNHjpkH/xGORMgaBPw
	 0xoa52wj+ivcAHekBOqLFa0712y3jk0y84ydwSvoaDZeJbEBrd7ODPqUF05lkuZxCZ
	 Jx+B3H1PgFncPihA0CCzuaXefRyMPjTJxr+2irMtV48wEiT1Bjg17Lc5p0fWA3iMoY
	 GeBT3OYsOYik7dlXH22K2bGDoqGHO4LX7a4m+gS2mk3IzYbyyLebRqNwx17zdJK+Nk
	 XIeLMEjy06PYVIg4YTif02cnKgWzXsm0n4G7OCea6cR5rAngTr1aLlcG0SX3GqtT++
	 mx6SBKYiXcN/A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so1292898e87.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 06:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzNLMPa4D3qnDelPkbqyQrxSJx9UyW/hPsAI73QdrEnyavbNmKAJfN8WhRiktO6AbqiYySb0sGC+8E=@vger.kernel.org
X-Gm-Message-State: AFuF++mQA0EAEd8g98FHBem3KwPlXZp8UnQnh9A8kS+x+0S6Wk9Zo2v6
	Uu/LNj+6MNBiqNpLklAPscr+/stlZFsf+Fhwx/c6k440SLZIBeusQUFv1HmpLD6KtiPhctTQmCU
	FRUISS8w9di72Q72KECA6Pbrc045xit8=
X-Received: by 2002:a05:6512:6d5:b0:5b6:10bc:dc4b with SMTP id
 2adb3069b0e04-5b610bcddbbmr1548313e87.34.1788527064240; Fri, 04 Sep 2026
 06:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831205533.2325747-1-mario.limonciello@amd.com> <20260831205533.2325747-2-mario.limonciello@amd.com>
In-Reply-To: <20260831205533.2325747-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:03:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4Fov-0JXZLqhXNuTag3k6-hAEhUCSsn8Zqmt1p463pA@mail.gmail.com>
X-Gm-Features: AcwNN1Wqn5_Mdkim-iKY41zDJ6PyS7KQTuJo-skl-NrBxfl4k-r2YAmLfrn5pus
Message-ID: <CAJZ5v0i4Fov-0JXZLqhXNuTag3k6-hAEhUCSsn8Zqmt1p463pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI/PM: Split out code from pci_pm_suspend_noirq()
 into helper
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:56=E2=80=AFPM Mario Limonciello
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
> ---
>  drivers/pci/pci-driver.c | 75 +++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e16aa59dd7ac8..e3d352c7b31d4 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -818,6 +818,50 @@ static void pci_pm_complete(struct device *dev)
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> +#if defined(CONFIG_SUSPEND)
> +/**
> + * pci_pm_suspend_noirq_common - prepare a device to enter a low-power s=
tate
> + * @pci_dev: pci device
> + * @skip_bus_pm: pointer to a boolean indicating whether to skip bus PM
> + *
> + * Save the device state and decide whether bus-level power management s=
hould
> + * be skipped, reporting the decision back to the caller via @skip_bus_p=
m.
> + */
> +static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *s=
kip_bus_pm)

Change it to bool.

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
> +               *skip_bus_pm =3D true;

And return true here.

> +       }

And false here.

Then you won't need the second argument.

> +}
> +#endif /* CONFIG_SUSPEND */
> +
>  #ifdef CONFIG_SUSPEND
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>  {
> @@ -907,6 +951,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       bool skip_bus_pm =3D false;
>
>         if (dev_pm_skip_suspend(dev))
>                 return 0;
> @@ -937,36 +982,10 @@ static int pci_pm_suspend_noirq(struct device *dev)
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
> -
> -       pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
> -               pci_power_name(pci_dev->current_state));
> +       pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
>
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
