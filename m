Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5D44CAEC
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844432; cv=none; b=ZbQPvCfKyA5uOLk0830wNR9dI9bICsxxrGYExgjd0wETgo4g+f7SHmP4VjiNZOmIic1wzgT33bPe3pA/7wvJSd/uMSFZMqNR7lH8SZy1/AEZ7oYpaY6YEc1EWsUetP6UI1g+YmdvRR0Yn3WjJTGbPG9JczXb7R8rHG0fb29mxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844432; c=relaxed/simple;
	bh=VUAa7gAOkrHqkwkX1y25qWYx5B6UnZSl4Lcary+wJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgfeKt97IbIKgUmcKJb0gOwfwO7BAvfgDwzTdHVShsAv99y9ss+jKiCHFQuQaFctIbANOt/TVwi8pGLi9WQFTI4EvDexCYn91GXsMFWd184tKxTxvG7j7dbnjHYKZa3kvhJEO0I1lfTemI8En6TQi2NxNztHsRBBUNdgB9p5xQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA67cxw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA67cxw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6EDC2BCB7
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844432;
	bh=VUAa7gAOkrHqkwkX1y25qWYx5B6UnZSl4Lcary+wJAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DA67cxw2kAosCVWAp89NnBkb39CO6DHrhEbGuaHtrikB9sIxz+nQpoLmRS+uTiPU9
	 a/MfpEjZKqLVwwEkK+ZuQvCPIOjIz3p1pk8Eppuh7rzuo1RGiwQ2p8Kn9luB997W1I
	 QLEnF2lix/FgqxNVG2RocK7Y6k/Y+kGEsEEOFdGX4cjWH8TQmF+2epnKnq0QeRLgrj
	 7P850SACWTqz4zHZoBK8yJOK/51/RHyO+xgQ7GiTegUDjOR4KadYBzuXGGi9v/ppVz
	 55YBM7m1We0V9+rywECGd+3S9cS3NAJ6tY8P8mCc185uRJoIzv5u0yc/MF7ZF/CsW9
	 GCkdz+OBZgoyQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a884ebba7dso9096060e87.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 04:27:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8SEm7YYH1hd46+hoKQIHzR6b3XNzR9209Tp0XP+NVHtGljdSrRnUNvyJWH44iOnp+hWdZHq8uqUmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7/ra94XjoE6Q+4hsYNgVeDdT1mAithDNzwmgu9GMohpJfmfk
	tn4Ez3wuZTaAte4ujLXfYIiv2J5J/FVTJoWdpgTOwFi4kWJS0th63jjruWmtx/9GHu7cYeg/bx7
	fITvZnoZbd1kptZGZgNBrXeL7wS6l88A=
X-Received: by 2002:a05:6512:3b9b:b0:5a8:950f:e92e with SMTP id
 2adb3069b0e04-5aa0e73059dmr1499119e87.23.1778844431034; Fri, 15 May 2026
 04:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200625.C6877C2BCB3@smtp.kernel.org> <20260514213811.GA434353@bhelgaas>
In-Reply-To: <20260514213811.GA434353@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 May 2026 13:26:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gj4yG+ZEKHGhd0mjG+YA=2HuKnTvDrF7x1TQoC21JeHw@mail.gmail.com>
X-Gm-Features: AVHnY4IMK-lo04qeLNn_cLj1AYSD7pFmiz_bW8apUAX8-T2mqZoZtt49ULy-QL8
Message-ID: <CAJZ5v0gj4yG+ZEKHGhd0mjG+YA=2HuKnTvDrF7x1TQoC21JeHw@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>, 
	Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>, 
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:38=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Ignored return value of `pci_dev_wait()` masks hardware readin=
ess timeouts
> > --
> >
> > commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
> > Author: Bjorn Helgaas <helgaas@kernel.org>
> >
> > PCI: Wait for device readiness after D3hot -> D0uninitialized transitio=
n
> >
> > This commit adds a call to pci_dev_wait() after transitioning a device =
from
> > D3hot to D0uninitialized. This ensures the device is ready to accept co=
nfig
> > accesses, especially for devices with No_Soft_Reset =3D=3D 0.
> >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8f7cfcc000901..9d0fc9fbb76a0 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > [ ... ]
> > > @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
> > >     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > >
> > >     /* Mandatory transition delays; see PCI PM 1.2. */
> > > -   if (state =3D=3D PCI_D3hot)
> > > +   if (state =3D=3D PCI_D3hot) {
> > >             pci_dev_d3_sleep(dev);
> > > -   else if (state =3D=3D PCI_D2)
> > > +           if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > +                   pci_dev_wait(dev, "power up D3hot->D0uninitialize=
d",
> > > +                                PCIE_RESET_READY_POLL_MS);
> >
> > Is it safe to ignore the return value of pci_dev_wait() here?
> >
> > If the device times out or disconnects, pci_dev_wait() returns -ENOTTY.=
 By
> > ignoring this error, pci_power_up() continues, unconditionally sets
> > dev->current_state =3D PCI_D0, and can return success (1 for need_resto=
re).
> >
> > If pci_power_up() returns success, will callers like pci_back_from_slee=
p()
> > execute pci_restore_state() against an unresponsive device, which could
> > potentially trigger PCIe Master Aborts, AER events, or system crashes?
> >
> > Should pci_power_up() propagate the error from pci_dev_wait() to preven=
t
> > this?
>
> Good point.  I think it should look like this instead:
>
>     if (state =3D=3D PCI_D3hot) {
>             pci_dev_d3_sleep(dev);
>             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>                     ret =3D pci_dev_wait(dev, "power up D3hot->D0uninitia=
lized",
>                                        PCIE_RESET_READY_POLL_MS);
>                     if (ret) {
>                             pci_err(dev, "Not ready after soft reset\n");
>                             dev->current_state =3D PCI_D3cold;
>                             return -EIO;
>                     }
>             }
>     } else if (state =3D=3D PCI_D2) {
>             udelay(PCI_PM_D2_DELAY);
>     }

This looks reasonable to me, thanks!

> > > +   } else if (state =3D=3D PCI_D2) {
> > >             udelay(PCI_PM_D2_DELAY);
> > > +   }
> > >
> > >  end:
> > >     dev->current_state =3D PCI_D0;
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514153124.=
404060-1-bhelgaas@google.com?part=3D1
