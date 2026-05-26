Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98453FD143
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804307; cv=none; b=C5LRMs2xDxUQYBAHIJId5557c58UAqD73NsRDB6scQEMCHL9liS0435fuxewEHXgnxW/tt+baspavVZqjofm16co1GXoSGUUTcCKpDUMdaS+4j/YfhzHhKvCcb4+ONYW7X1jWFlbfE6LlZz7ju743U2InAJkXTU/o5nV75jlWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804307; c=relaxed/simple;
	bh=fz7/noeRsn30M2L5Ln+yArPHuWk10SA9fs1hNj5CF2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCLDshAWKzJA+biY3dNEf1zU3zNuZNZJQZVoFJv2gAyPQ5VswiIyGJxzPbhTO0ZdxJakLx0/vP52DYvDJDEjH49IFTv6YkNK9+o4Pv1CiWlkrEV29sHvhP3ltdfgADtOqRGV4JcWlPWDHzTruojXIkPWJd8wsm/SL8LI/+mLDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy8VeWrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy8VeWrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D81F00A3D
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804305;
	bh=bxww9adqV3Fdz7YwXrlp/uC6uT3vINKYt+j2jL4elT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qy8VeWrmOrJv3ZDpGOKpU0Ie2TRZnso5tu9Kkms8EKyTcy05uxpEda9woHApHKrwm
	 N5gFdxMa1J16Ydfa1ktcCtyenTWzs9r0r0W/AGBhzyZS9xm7mzENvNTduuiHvEmfFx
	 Lo8qu8bWCY64oE82mYdAjo/B55sWnAOWU2dsFUHgb5vEV7P5fRXZmEDIgb+IQnGVFp
	 WW2N1gxo8B6E9Ec1cgR3clIJSLOo0awCLNQNIR+m3/T4XWImjaSwuyqafT8XjyeGTa
	 hmQGCYIVWoVnIGQQ410D80NdnMRJ3RvdjZ5VdCm1iZRv1xnbVCPH6wEJ8Mmno+JJFQ
	 Yq8u3PcpybGdA==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-57513a91514so3522046e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 07:05:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zlSP7YZD7aeJvOlVw368nA1oPxZhkgA/k+uDIeiK1uB1f3sFKVM9G+fc/w2iGMgCCxVG54Xwvf/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKADO9z+thh7rEfCdMcW4QrOHLgP4yBUeJ8p0NWBC7wAGxpq8s
	miXprhfxNpl7cP4t+GH5kxs1dL3XIQA4d71CB1ARDQOY/yftgovOpwyasGQDEV6Nphx2POBdkPe
	Lk6+xFUZxafLfkUo3jhi08ITzIggyMTk=
X-Received: by 2002:a05:6122:a0b:b0:56f:2aaa:450c with SMTP id
 71dfb90a1353d-5865e4a60f4mr8992869e0c.1.1779804304682; Tue, 26 May 2026
 07:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-4-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-4-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 16:04:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaR0_3msYSqJT0-XpOFq6n0EtBr=OT5ypbdk+B-KMdrQ@mail.gmail.com>
X-Gm-Features: AVHnY4Idpb315D3BnDhp0jKgdfi1-PoxGWvAbCd1zVAxPIjNnT7rVCVeap7vZB4
Message-ID: <CAJZ5v0iaR0_3msYSqJT0-XpOFq6n0EtBr=OT5ypbdk+B-KMdrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PCI/PM: Split out code from pci_pm_suspend_noirq()
 into helper
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> In order to unify suspend and hibernate codepaths without code duplicatio=
n
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 86 +++++++++++++++++++++++++---------------
>  1 file changed, 54 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a43ee7bbfb3f5..bfb521eb0eed7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -788,6 +788,54 @@ static void pci_pm_complete(struct device *dev)
>
>  #endif /* !CONFIG_PM_SLEEP */
>
> +#if defined(CONFIG_SUSPEND)
> +/**
> + * pci_pm_suspend_noirq_common
> + * @pci_dev: pci device
> + * @skip_bus_pm: pointer to a boolean indicating whether to skip bus PM
> + *
> + * Prepare the device to go into a low power state by saving state and
> + * deciding whether to skip bus PM.
> + *
> + */
> +static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *s=
kip_bus_pm)
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
> +               return;
> +       }
> +
> +       pci_pm_set_unknown_state(pci_dev);

Can this go back to pci_pm_suspend_noirq()?  It wouldn't be necessary
to change labels then.

> +}
> +#endif /* CONFIG_SUSPEND */
> +
>  #ifdef CONFIG_SUSPEND
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>  {
> @@ -877,6 +925,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       bool skip_bus_pm =3D false;
>
>         if (dev_pm_skip_suspend(dev))
>                 return 0;
> @@ -886,7 +935,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
>
>         if (!pm) {
>                 pci_save_state(pci_dev);
> -               goto set_unknown;
> +               pci_pm_set_unknown_state(pci_dev);
> +               goto Ehci_workaround;
>         }
>
>         if (pm->suspend_noirq) {
> @@ -907,40 +957,12 @@ static int pci_pm_suspend_noirq(struct device *dev)
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
> -
> -set_unknown:
> -       pci_pm_set_unknown_state(pci_dev);
>
> +Ehci_workaround:
>         /*
>          * Some BIOSes from ASUS have a bug: If a USB EHCI host controlle=
r's
>          * PCI COMMAND register isn't 0, the BIOS assumes that the contro=
ller
> --
> 2.53.0
>
