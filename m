Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FB3009F6
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513107; cv=none; b=QwEYvUeHNc4kJZgtgPlVaY3yoAlkbOXsJFhiHlyKM2nShwPudct+xkdQjENXkjsi0HrvmvepnZ45ChXDgA2Ul0T82LUe+7KhVD5ee+0ZoGjDlsP1+pS61Fxyr4Ijh0JKcDbG6r7WUCX+bzgtOOZ6MoCJhejd4PAPkTKJFMh6paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513107; c=relaxed/simple;
	bh=+pg/9kMhQf48rIITwfb6CvpKHuU0Ao+CjZHjak26bbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbGZoNrQnyY+uSafX/Y45MZdi88XASqI839Ae+XULvOdooWEYajKRmXsEV2UuKSr9HBrPbbFik0glisT8YZC+rBAJNoQfwmGSd/Wg48DZVWxtaOjLwCNWJhhLYr7pGR3tOboazGh+7m/UU84exwocS0p/KS84eK2aSKXT325muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZfRYLeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZfRYLeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C21DC2BCFF
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778513107;
	bh=+pg/9kMhQf48rIITwfb6CvpKHuU0Ao+CjZHjak26bbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZfRYLeGzYp7zsdwSzvdi8lHvx13Mp2xirE7+3rZXZ4rmiASQhgwdACIF+G2ZqpiR
	 DX4FxIWM0kcZuO42aqbwNLFpvcG2nrMhNInwM4pZK2KLGZEayE2+nrf+6IjqpnqJvx
	 lI4udyrFoQtfiFh9Zo/+sOaikNcAMDdfXwXa515yDJxSIBgA1k2dp+S2dYJMiMaqgb
	 lGGVNAiAjxSPIo5VM/g1CDZJVB63S/BicYrEQYw9iNWyQHXqSqkTiloM68xBjyFI4v
	 Rh2m+1SSfy5NTui2u027AgPZkHkdRI21Iqssfgj6gXIQycTSE1ZxJww/6yBEKaxZ7J
	 IUVbAP/I67yhg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso4902193e87.2
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 08:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VZ9YUTAYebh5OfB8QKQK7qfcZEMLETl6q2jgNtdcJe0D2eC6rpBeqT0CBY2JPW4S5blucdnWL4jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtx9kQF+2NxLReoy0SQyOF1pR3EMlpqXku6KCZ0Th8BBPUfkgs
	LHyO+v/sqfz6LynCvtxhfXVX7addrt5mOF5rSjK/sVnD5Fj0WRMwuka/XGMfmYF7gMzPfExRWXA
	T10SHIGolOMi/g1PUolgBDzfvi+ttPko=
X-Received: by 2002:a05:6512:3d9e:b0:5a2:bedb:2119 with SMTP id
 2adb3069b0e04-5a8a94bc40fmr5211116e87.26.1778513105192; Mon, 11 May 2026
 08:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com>
 <20260508214309.GA14699@bhelgaas>
In-Reply-To: <20260508214309.GA14699@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 17:24:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gU3fjh0czpp+7gC9EfRSwT2dUZQj0hSJR8VNwBLXM4PQ@mail.gmail.com>
X-Gm-Features: AVHnY4L8vh7NmiWbS-Fdt7taHcBrWbfKKfUkJQ5hkWdcSdN32I8gQ39BGDBAm8A
Message-ID: <CAJZ5v0gU3fjh0czpp+7gC9EfRSwT2dUZQj0hSJR8VNwBLXM4PQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org, 
	linux-pci@vger.kernel.org, sashiko@lists.linux.dev, 
	Marco Nenciarini <mnencia@kcore.it>, Michal Winiarski <michal.winiarski@intel.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Eric Chanudet <echanude@redhat.com>, 
	Jean Guyader <jean.guyader@gmail.com>, Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 11:43=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, May 08, 2026 at 02:51:37PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 8, 2026 at 2:17=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, May 4, 2026 at 11:17=E2=80=AFPM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > ...
> > >
> > > > > If pci_power_up() is doing D3cold -> D0, main power is initially
> > > > > off, so platform_pci_set_power_state(PCI_D0) would turn on main
> > > > > power, which is a Fundamental Reset leaving the device in
> > > > > D0uninitialized.  In general the device needs at least 100 ms
> > > > > after that reset before any access, e.g., before the PMCSR read.
> > > >
> > > > Yes, it does in general, but that should be covered by
> > > > platform_pci_set_power_state() because on some platforms the delay
> > > > can be shorter.
> > >
> > > It's surprising to me that platform_pci_set_power_state() takes
> > > care of that delay because there's so much PCIe infrastructure
> > > (dependencies on link speed, RRS polling, Immediate Readiness,
> > > Readiness Notifications, etc), much of which sounds more like
> > > OS-level support than firmware support.
> >
> > It is kind of a mixed bag because it involves platform-specific
> > operations (the PCIe spec doesn't define a standard method of
> > transitioning devices in D3cold into D0).
> >
> > The consensus in the industry appears to be that if AML is used for
> > carrying out D3cold->D0 transitions, it is expected to take the
> > requisite delays into account.
> >
> > > But if platform_pci_set_power_state() does guarantee that the device
> > > is Configuration-Ready, we should document that somewhere.
> >
> > It is more along the lines of what I said before: After
> > platform_pci_set_power_state() the device is either
> > Configuration-Ready, or inaccessible (in which case it can be assumed
> > to have dropped off the bus, but this is all platform-specific, so on
> > some platforms there may be ways to revive such devices).
>
> If the device is Configuration-Ready or inaccessible after
> platform_pci_set_power_state(PCI_D0), then I agree we shouldn't add
> that delay in pci_power_up().
>
> > That said, I'm all for documenting it.
>
> Strawman below.  "Inaccessible upon return" is bound to lead to
> questions, but if the PCI core can't do anything I don't know what
> else to say.
>
>   diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>   index ed1b1d7a7b46..2b0513c35387 100644
>   --- a/drivers/pci/pci.c
>   +++ b/drivers/pci/pci.c
>   @@ -1068,6 +1068,12 @@ static inline bool platform_pci_power_manageable=
(struct pci_dev *dev)
>           return acpi_pci_power_manageable(dev);
>    }
>
>   +/*
>   + * When setting power state to D0, platform_pci_set_power_state() ensu=
res
>   + * main power is on and that any required delays after a transition to=
 D0
>   + * have been completed.  The device is either Configuration-Ready or
>   + * inaccessible upon return.
>   + */

It looks as good as it gets to me, but I'd put it into pci_power_up()
which is where it really matters.

>    static inline int platform_pci_set_power_state(struct pci_dev *dev,
>                                                  pci_power_t t)
>    {
>
> > > > > If pci_power_up() is doing D3hot -> D0, the device already has
> > > > > main power, so I suppose platform_pci_set_power_state(PCI_D0)
> > > > > doesn't do anything.
> > > >
> > > > It may or may not.  Some platforms supply AML to run during D3hot -=
>
> > > > D0 transitions (and the ACPI spec allows that).
> > >
> > > If the device started in D3hot, it never lost main power, and I
> > > assumed platform_pci_set_power_state(PCI_D0) might just leave it in
> > > D3hot.  It sounds like it takes it all the way to D0, although the
> > > subsequent code that checks the PMCSR state does suggest that the
> > > device might *not* be in D0:
> >
> > On platforms using ACPI, platform_pci_set_power_state() carries out
> > the AML part of the transition which may do nothing for devices in
> > D3hot (for instance, there may be an ACPI power resource that needs to
> > be turned "on" in order to restore power to the device, but if the
> > power resource is "on" already, say because it is shared with another
> > device that is in D0 ATM, its state may not change).
> >
> > platform_pci_set_power_state() may also be a no-op for the given
> > device (for example, if this is an add-on device without any
> > associated AML).
> >
> > The rule of thumb is that if there is a programmatic way to remove
> > power from a PCIe device (so it can go into D3cold), it is generally
> > platform-specific and there should be a complementary programmatic way
> > to do the reverse (also generally platform-specific).  Otherwise, the
> > device can go only as deep as D3hot except when the system as a whole
> > is powered down or it is on a Thunderbolt link that can be
> > disconnected at any time etc.
> >
> > >     platform_pci_set_power_state(dev, PCI_D0);
> > >
> > >     pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > >     state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> > >     if (state =3D=3D PCI_D0)
> > >       goto end;
> > >
> > >     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > >     if (state =3D=3D PCI_D3hot)
> > >       pci_dev_d3_sleep(dev);
> > >     ...
> > >
> > >   end:
> > >
> > > If platform_pci_set_power_state(PCI_D0) puts the device in D0 and
> > > takes care of all the delays, "state" should always be PCI_D0, and we
> > > shouldn't need the D3hot and D2 delays here.
> >
> > Well, not quite, as per the above.
>
> OK, so after platform_pci_set_power_state(PCI_D0), the device may be
> in D3hot in some cases.  Then there's a D3hot -> D0 transition, and we
> do pci_dev_d3_sleep(), but not pci_dev_wait().  Sec 2.3.1 says RRS is
> permitted after a D3hot to D0uninitialized, and pci_dev_wait() is what
> waits and retries for the RRS case.
>
> It looks to me like we need pci_dev_wait() after that transition when
> No_Soft_Reset =3D=3D 0, i.e., something like the below.  Do you think thi=
s
> is unnecessary?

Well, let me turn this around: Is there any evidence that it is necessary?

I guess if it is not necessary, there will be no harm, but this is a
performance-sensitive code path.

>   diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>   index 8f7cfcc00090..ed1b1d7a7b46 100644
>   --- a/drivers/pci/pci.c
>   +++ b/drivers/pci/pci.c
>   @@ -1341,10 +1341,14 @@ int pci_power_up(struct pci_dev *dev)
>           pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
>
>           /* Mandatory transition delays; see PCI PM 1.2. */
>   -     if (state =3D=3D PCI_D3hot)
>   +     if (state =3D=3D PCI_D3hot) {
>                   pci_dev_d3_sleep(dev);
>   -     else if (state =3D=3D PCI_D2)
>   +             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
>   +                     pci_dev_wait(dev, "power up D3hot->D0",
>   +                                  PCIE_RESET_READY_POLL_MS);
>   +     } else if (state =3D=3D PCI_D2) {
>                   udelay(PCI_PM_D2_DELAY);
>   +     }
>
>    end:
>           dev->current_state =3D PCI_D0;
