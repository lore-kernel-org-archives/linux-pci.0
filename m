Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97572FD681
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977811; cv=none; b=N+SiKwcPllKXaA4JOOwNRypvVoCrV9oE4mZYW1YCMymDZoxiY306evGx+5269RREe5sq3wSiMcP+ELCQoW4KzPvpC8w2GjqTGjvIRI46HjKWfzSfDyCmBaGP0U46BQESgionyydjwH/uZ2iG6BpcDbdf7uDzTGar3gLyasqBMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977811; c=relaxed/simple;
	bh=4p8xZgPTwl23yuO4usByrqVx7sRRkYZITrF1b6z8fNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a30NbhSKcLOzsfx4yaGwQm8rLnRlWnaiTilfJCBu6MVBltrBZ2Mqn7K2y/X0VLjQ7yuHV8/Ib8mWwiPXMz4wOj6boZrRb1nIBHcGODzvJINfcnVbABqHx1YVEhSR9tLKFi9/k3PWM3pTiAQvsG9crHNn2r3F5I4BWKwbgMwuAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSHbcEEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSHbcEEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D911C2BCF7
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977811;
	bh=4p8xZgPTwl23yuO4usByrqVx7sRRkYZITrF1b6z8fNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pSHbcEEffmwAe1AyV5gwpZOhcvKoyz5oNnw5hpUc4pL78QL6NWwQ93yOMxpJ1i1Sk
	 MGPGZVJyIqgnLxqCX+bx3hERDbXYLz/1x1I0b0KY6bjkhHxQsrTkCQwsrzs0M3umOG
	 4+89S7eH/7QVsU5IKOSP2RLRa8R+pdUZs89GlJ48cijmAuMtZbi9lJSCB9WBA6NX34
	 SMnDQ2D3SyVtz0iMvEfHNVTl8myiDfqT3y8WnMXr7efRqdKTC22USNHHZ1ZXrEn3LG
	 4GbRbN1bncCugzOAQTKfs5y/IQdQszglWZQR9wf8bqbZg1UgOIzYt2elCg0Vl+7USV
	 oi0JMLWiKAvbg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393800586aeso26683811fa.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 03:43:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9NvRSE94WnlPV1GCMeARO4RJIw+u0UuWbvtbbsShrgeQwL1c8JC91OUpdFWn4slKHYBqXfe9doqIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3+bUyI46CB5n7tNa4CeDdfozY1RBnkMoWwoZLxTtdomhEZKx
	/PO4RXXzLT9WQJnOHQx2jijK3cJU8nYhCyhTMpI7q6QzDQjykwWPS3I2oTaiyXys1kXl6poqj4m
	iSzvq8EwuijuUfOHXUBjpcaWqyWZdhtc=
X-Received: by 2002:a05:6512:3f0b:b0:5a8:7360:5c59 with SMTP id
 2adb3069b0e04-5a87e6826b7mr1133820e87.10.1777977809996; Tue, 05 May 2026
 03:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0g3f8_7v-8W0SAbn_8vmKUJgpDbgyYMSjv03QjXJ8bCHQ@mail.gmail.com>
 <20260504211741.GA659556@bhelgaas>
In-Reply-To: <20260504211741.GA659556@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 May 2026 12:43:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hngqvdi2vRB4n5T3sGSPc10eR=1X+UO2QAR=GHYmQo2w@mail.gmail.com>
X-Gm-Features: AVHnY4L9S085Yvf8QXDvLO4t6IegPYvzrYt8Z57K_31su0wbMOblGNmN7xFGjSs
Message-ID: <CAJZ5v0hngqvdi2vRB4n5T3sGSPc10eR=1X+UO2QAR=GHYmQo2w@mail.gmail.com>
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

On Mon, May 4, 2026 at 11:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, May 04, 2026 at 09:31:51PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 4, 2026 at 7:09=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Mon, May 04, 2026 at 09:49:36AM +0200, Lukas Wunner wrote:
> > > > On Sun, May 03, 2026 at 01:51:08PM +0000, sashiko-bot@kernel.org wr=
ote:
> > > > > Thank you for your contribution! Sashiko AI review found 1 potent=
ial
> > > > > issue(s) to consider:
> > > > > - [High] Removing the read-back and retry loop for BAR restoratio=
n in
> > > > > `pci_restore_state()` introduces a risk of silent regressions for
> > > > > hardware resuming from non-FLR resets (such as D3hot to D0 transi=
tions
> > > > > or custom driver resets). The commit incorrectly assumes the 60s =
delay
> > > > > from `pci_dev_wait()` covers all usages, but standard PM resume p=
aths
> > > > > only delay for 10ms (`PCI_PM_D3_WAIT`) before calling `pci_restor=
e_state()`.
> > > > > Historically, hardware that needed slightly longer to accept
> > > > > configuration writes relied on the 10x 1ms retry loop to successf=
ully
> > > > > restore BARs. By removing both the retry and the read-back verifi=
cation,
> > > > > BAR writes to slow devices will be silently dropped, leaving hard=
ware
> > > > > unconfigured and causing MMIO accesses to result in IOMMU faults =
or
> > > > > kernel crashes.
> > > >
> > > > Hallucination alert:
> > > >
> > > > PCI_PM_D3_WAIT does not exist, it was renamed to PCI_PM_D3HOT_WAIT
> > > > six years ago by commit 3789af9a13e5, which went into v5.10.
> > > >
> > > > The macro is used in:
> > > >
> > > > pci_pm_resume_noirq()
> > > >   pci_pm_default_resume_early()
> > > >     pci_pm_power_up_and_verify_state()
> > > >       pci_power_up()
> > > >         pci_dev_d3_sleep()
> > > >
> > > > However before pci_power_up() calls pci_dev_d3_sleep(), it reads
> > > > the PMCSR register and errors out if config space is inaccessible.
> > > >
> > > > Hence when pci_restore_state() is invoked a bit later, config space
> > > > can be assumed to be accessible.
> > >
> > > I don't quite follow this.  In this path, pci_power_up() changes a
> > > device from some low-power state to D0.  If the device was in D3hot o=
r
> > > D3cold, we must delay at least 10ms before any access to it (PCIe
> > > r7.0, sec 5.9).
> >
> > D3hot and D3cold are different in this respect, so using "or" here is
> > inaccurate and confusing.
> >
> > Accessing the config space of a device in D3hot is entirely correct
> > and doesn't require any delay.
> >
> > Accessing the config space of a device in D3cold is questionable
> > because the device may not be accessible, but then the host bridge
> > should just fail the access.
> >
> > The 10 ms delay is after attempting to program the device into D0 from
> > D3hot (or the other way around) and it is observed as required.
>
> Thanks for taking a look at this!

No prob.

> If pci_power_up() is doing D3cold -> D0, main power is initially off,
> so platform_pci_set_power_state(PCI_D0) would turn on main power,
> which is a Fundamental Reset leaving the device in D0uninitialized.
> In general the device needs at least 100 ms after that reset before
> any access, e.g., before the PMCSR read.

Yes, it does in general, but that should be covered by
platform_pci_set_power_state() because on some platforms the delay can
be shorter.

> If pci_power_up() is doing D3hot -> D0, the device already has main
> power, so I suppose platform_pci_set_power_state(PCI_D0) doesn't do
> anything.

It may or may not.  Some platforms supply AML to run during D3hot ->
D0 transitions (and the ACPI spec allows that).

> The device remains in D3hot, the PMCSR read should be fine,
> and the PMCSR write to transition to D0 is immediately followed by the
> 10 ms delay.  When No_Soft_Reset =3D=3D 1, this should be enough.
>
> But when No_Soft_Reset =3D=3D 0, the transition is to D0uninitialized,
> which sec 2.3.1 includes as a reset condition after which the device
> is permitted to return RRS.
>
> So to me it looks like we need these delays:
>
>   - For D3cold -> D0, msleep(100) and pci_dev_wait() between
>     platform_pci_set_power_state(PCI_D0) and the PMCSR read, similar
>     to what pcie_flr() does.

Adding those delays directly to the PCI PM code would ruin the timing
of system resume on many systems where devices go into D3cold during
suspend, or are powered off by the platform firmware later in the case
of S3 transitions.  For instance, during resume from S3, everything is
typically powered up by the platform firmware which also takes care of
the delays and the kernel effectively gets all devices in D0uninit.

Also, as stated above, IMO it is better if
platform_pci_set_power_state() takes care of the delay.

>     Maybe platform_pci_set_power_state() takes care of some or all of
>     this internally?

At least on some platforms, yes it does.

Moreover, the power-on may not actually happen during
platform_pci_set_power_state() for the device in question, but for its
parent.  It is quite common to provide an ACPI power resource for a
PCIe root port for bringing up the downstream link, which doesn't
really change the power state of the root port itself, but it affects
the subordinate device (and possibly everything below it).

Of course, a good question is what Alternative OSes do when
transitioning PCIe devices from D3cold to D0, but I think I can find
that out.

>   - For D3hot -> D0 with No_Soft_Reset =3D=3D 0, pci_dev_wait() after the
>     PMCSR write to transition to D0.
>
>     abbcf0e2a99d ("PCI: Wait for device to become ready after a power
>     management reset") added the similar wait in pci_pm_reset().
>
> > > pci_power_up() doesn't do any delay before the PMCSR read.
> >
> > It assumes that platform_pci_set_power_state() has run and either it
> > has succeeded or the config space is not accessible which is when
> > PCI_POSSIBLE_ERROR() will trigger.  Unfortunately, there is no
> > canonical way to verify that power has been restored to the device
> > other than attempting to access it.
> >
> > > That part seems like a pre-existing issue even before this patch.
> >
> > I beg to differ.
> >
> > > If the PMCSR read returns PCI_POSSIBLE_ERROR(), pci_power_up() does
> > > complain "Unable to change power state ... to D0" and return -EIO, bu=
t
> > > pci_pm_power_up_and_verify_state() doesn't look at it,
> >
> > In fact, pci_update_current_state() changes the power state to D3cold
> > if the config space is not accessible.
> >
> > > and pci_pm_default_resume_early() continues on to pci_restore_state()=
, so
> > > it looks to me like we could try to restore state to an inaccessible
> > > device.
> >
> > So the pci_restore_state() call could be avoided if the power state of
> > the device was D3cold, but then the question is how much of a problem
> > that is in practice.
> >
> > > We do call pci_dev_wait() in pci_pm_reset(), which does a D3hot -> D0
> > > transition; shouldn't we do the same in pci_power_up()?
> >
> > It would be good to make them consistent, but maybe the other way aroun=
d?
