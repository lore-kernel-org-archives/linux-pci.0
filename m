Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5447F2CC
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846247; cv=none; b=rV2LqXYMDsHpFgR37ilxHaJ5q1LoyOwfFStRBJTF+iWgZ0iruQrOSpGPvdVGPVDXhl3XsOOKKTLRVU1Upjy+AK48912gKachJzeXepj+M8IQUzxXUBjmKbDHK1NF+2X+8Dkt246LJoNNMXLuEWToDF4/R6a8gu7Bj18WM8sIsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846247; c=relaxed/simple;
	bh=c/iad1vdohB0Y+N0QotiOZ3xpOlKAMSdxMwCwMqxEsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2zL8vFuTa+c3serl7tQu+XwxwoK0TKnV9lTaBj2yhvpKBEy97dYNnIWmcXwuD5qLSm123Abfv8KRaR9jJ+G1JK+WzX7eko4MjMAdaAHgO2zmg0xZ5ivqkI+VS5kC6beHTXjhf0rX4NSc9pj5Ft3jwMbWwoleP3qHQbjoB1hyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMCxMKWb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMCxMKWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C85C2BD04
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778846247;
	bh=c/iad1vdohB0Y+N0QotiOZ3xpOlKAMSdxMwCwMqxEsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jMCxMKWbBMBjtfCXaYeQrq5/GrYrRbk14B/EPiXJwLAhpdz9lNiqqB2/Z+B302yWe
	 s9EfYxinqmO9UAF9Nww/eGWkZU3cs/lUfJb6O9K5etqlNT0SsxZb94MEC1Pf7g+IzS
	 wIaXn3HkSy8gb3x/kBQ+pNwL0c1RsrEtc+O77/vwR1zZdCy9FFKmSK75t8BAVDrqKf
	 k3wthbJtp5CSXxuoXwdAZveZsKZGyocAFBDhbfoNJm/AHrK3KpELpAGLIq+GTP1Nue
	 O5+YCG2qxIyvdHNVhU8GtrNtqGnx2YBzldFcIV2nWX4C35xZGrC9OyhzbgpSXWMoIM
	 yqucouIv47dFw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a746f9c092so1627414e87.1
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 04:57:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9xIf0CVwlYdqHOViqtRpT4zpBsnXZqHsVxI/r6SSSU0qLLyEXXJDsD0xPVEtTnZAuKD6cFOZBY5Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXqziiMTO590vqN/uzSGoJAGmyu9PwNxLZZEOZXzYE2yUAuIJ
	MIQUCdgvE32mS95g+wxG5YrkcCzc/lpAqcBct5Fb5xSif4DzQeqlA5ZZE+jr3yVM5tW01dvVPwY
	0D6Fnh+IZWW+cdget+9Mqh9ks43PLwq0=
X-Received: by 2002:a05:6512:3c95:b0:5aa:b6a:602b with SMTP id
 2adb3069b0e04-5aa0e0a0b45mr1181977e87.21.1778846245328; Fri, 15 May 2026
 04:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200625.C6877C2BCB3@smtp.kernel.org> <20260514213811.GA434353@bhelgaas>
 <20260515114134.GJ84797@black.igk.intel.com>
In-Reply-To: <20260515114134.GJ84797@black.igk.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 May 2026 13:57:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0igy2g0zCJrY8wsFiDzVvQUkQH=y6EM1M50rPB-04G3MQ@mail.gmail.com>
X-Gm-Features: AVHnY4IP0bC1i5x7fxIbvcLC-G3Duq3Vtlw22KOQaerlM1dl8BHJkrZzQBHZrzg
Message-ID: <CAJZ5v0igy2g0zCJrY8wsFiDzVvQUkQH=y6EM1M50rPB-04G3MQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sashiko-reviews@lists.linux.dev, 
	linux-pci@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>, 
	Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Eric Chanudet <echanude@redhat.com>, Jean Guyader <jean.guyader@gmail.com>, 
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 1:41=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, May 14, 2026 at 04:38:11PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [High] Ignored return value of `pci_dev_wait()` masks hardware read=
iness timeouts
> > > --
> > >
> > > commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
> > > Author: Bjorn Helgaas <helgaas@kernel.org>
> > >
> > > PCI: Wait for device readiness after D3hot -> D0uninitialized transit=
ion
> > >
> > > This commit adds a call to pci_dev_wait() after transitioning a devic=
e from
> > > D3hot to D0uninitialized. This ensures the device is ready to accept =
config
> > > accesses, especially for devices with No_Soft_Reset =3D=3D 0.
> > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 8f7cfcc000901..9d0fc9fbb76a0 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > [ ... ]
> > > > @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
> > > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > >
> > > >   /* Mandatory transition delays; see PCI PM 1.2. */
> > > > - if (state =3D=3D PCI_D3hot)
> > > > + if (state =3D=3D PCI_D3hot) {
> > > >           pci_dev_d3_sleep(dev);
> > > > - else if (state =3D=3D PCI_D2)
> > > > +         if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > > +                 pci_dev_wait(dev, "power up D3hot->D0uninitialize=
d",
> > > > +                              PCIE_RESET_READY_POLL_MS);
> > >
> > > Is it safe to ignore the return value of pci_dev_wait() here?
> > >
> > > If the device times out or disconnects, pci_dev_wait() returns -ENOTT=
Y. By
> > > ignoring this error, pci_power_up() continues, unconditionally sets
> > > dev->current_state =3D PCI_D0, and can return success (1 for need_res=
tore).
> > >
> > > If pci_power_up() returns success, will callers like pci_back_from_sl=
eep()
> > > execute pci_restore_state() against an unresponsive device, which cou=
ld
> > > potentially trigger PCIe Master Aborts, AER events, or system crashes=
?
> > >
> > > Should pci_power_up() propagate the error from pci_dev_wait() to prev=
ent
> > > this?
> >
> > Good point.  I think it should look like this instead:
> >
> >     if (state =3D=3D PCI_D3hot) {
> >             pci_dev_d3_sleep(dev);
> >             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> >                     ret =3D pci_dev_wait(dev, "power up D3hot->D0uninit=
ialized",
> >                                        PCIE_RESET_READY_POLL_MS);
> >                     if (ret) {
> >                             pci_err(dev, "Not ready after soft reset\n"=
);
> >                             dev->current_state =3D PCI_D3cold;
>
> I wonder if PCI_POWER_ERROR makes sense here?

Not really, PCI_POWER_ERROR is mostly used by things like
"target_state" to indicate that nothing has been selected.

> >                             return -EIO;
> >                     }
> >             }
> >     } else if (state =3D=3D PCI_D2) {
> >             udelay(PCI_PM_D2_DELAY);
> >     }
> >
> > > > + } else if (state =3D=3D PCI_D2) {
> > > >           udelay(PCI_PM_D2_DELAY);
> > > > + }
> > > >
> > > >  end:
> > > >   dev->current_state =3D PCI_D0;
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051415312=
4.404060-1-bhelgaas@google.com?part=3D1
