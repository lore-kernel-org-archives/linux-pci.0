Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E83DD536
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244712; cv=none; b=GHzkwAZ9ZywC4W53V9fxw08sWkl63htnP8oA0llfU+wFFk7XfacxogafJkkIquiAzdsnwqRPX0yRsAfZQRXJ91oUeEmVv4SLcMa7uH4oCgpc4eswB+eLNW8dHo7RJlO320BjYy4KwXJYNCtTvRpbrO32saDPBKv9aiT3N5OkQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244712; c=relaxed/simple;
	bh=b5hRY7E4eJ8rgy6jbk2EEW/Pk3YEWbLTn4ysMpU22L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE2I3KL0iESN4S2LLrxNELU4rtwxhghA+kSLesiAnAIOMclEzi0JI8rBhXAvMJLRPi9pU6OW2dw+w3pTwYToJIwsQAjzmOldrFmYOLo8Ifg72lZq4cb0CsxPEW7UgbJBqNs+DEUwiEHI9pYNCoJRqlKRpqETAximJnrHWyzuk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj/3/jc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj/3/jc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E0EC2BCFC
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778244712;
	bh=b5hRY7E4eJ8rgy6jbk2EEW/Pk3YEWbLTn4ysMpU22L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aj/3/jc8V9GABvkjzrdKTJ0B8rlOOiyHiNggJL80vJYjN9o8mKscCcyDktwyxE8Hl
	 rsMoKg0/OFjq+R6tER33I4PDmKUylH3/48CZpoBZuRPEfBhg6FnOq3PTOYnbm0tWIm
	 eb9mlRc1SusYPcgZDm9VBijW0L2Vbywqp7RSkZqP6kRr5/zX+e9sARc3pLiIXhN90y
	 W+wV2SblGMOYAMPtGV9qY+ge1f2Y7BduPOEtmlI2EfMfI74Pi47f9w2OJXpsb4qFUy
	 RCg1Ss3suPQIxsGakO+52cRB3pO7hlND8m8DuWYFTHFP5nMT6ogpli2BpDSNhfhz6/
	 LRnO+Jsq85XuA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so1993235e87.3
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 05:51:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+hXfUOimACVRmPPSz9DcZBLjg1fM03AgPSIFR74ye48oItDpznDwzHlfr5POOzTjM0tUkMduwq6B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vFHHX4DADLeNNmyCFWirQ6HqbcnQIKb8F/qzwURzHlNtQk+K
	B0Ua+DDt7iSoRu2aG1RNTcyEI4kCmm5i/lQx+iXtUNiCP/MEJ9SSy2vRP3Fa3PuY7pqxCy0M1SY
	APenUDPnvC8w8jPDUbrZ3tp7+P6/oTTg=
X-Received: by 2002:a05:6512:b2a:b0:5a7:4699:d851 with SMTP id
 2adb3069b0e04-5a887adce0amr4231056e87.7.1778244710812; Fri, 08 May 2026
 05:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hngqvdi2vRB4n5T3sGSPc10eR=1X+UO2QAR=GHYmQo2w@mail.gmail.com>
 <20260508001700.GA52868@bhelgaas>
In-Reply-To: <20260508001700.GA52868@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 14:51:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com>
X-Gm-Features: AVHnY4JDm0NwQbvbIF57UXrSWpYkIi9GWtdbhq4uIIdxb7B3uf32C_ZBVih_N7M
Message-ID: <CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com>
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

On Fri, May 8, 2026 at 2:17=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 4, 2026 at 11:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > ...
>
> > > If pci_power_up() is doing D3cold -> D0, main power is initially
> > > off, so platform_pci_set_power_state(PCI_D0) would turn on main
> > > power, which is a Fundamental Reset leaving the device in
> > > D0uninitialized.  In general the device needs at least 100 ms
> > > after that reset before any access, e.g., before the PMCSR read.
> >
> > Yes, it does in general, but that should be covered by
> > platform_pci_set_power_state() because on some platforms the delay
> > can be shorter.
>
> It's surprising to me that platform_pci_set_power_state() takes
> care of that delay because there's so much PCIe infrastructure
> (dependencies on link speed, RRS polling, Immediate Readiness,
> Readiness Notifications, etc), much of which sounds more like
> OS-level support than firmware support.

It is kind of a mixed bag because it involves platform-specific
operations (the PCIe spec doesn't define a standard method of
transitioning devices in D3cold into D0).

The consensus in the industry appears to be that if AML is used for
carrying out D3cold->D0 transitions, it is expected to take the
requisite delays into account.

> But if platform_pci_set_power_state() does guarantee that the device
> is Configuration-Ready, we should document that somewhere.

It is more along the lines of what I said before: After
platform_pci_set_power_state() the device is either
Configuration-Ready, or inaccessible (in which case it can be assumed
to have dropped off the bus, but this is all platform-specific, so on
some platforms there may be ways to revive such devices).

That said, I'm all for documenting it.

> > > If pci_power_up() is doing D3hot -> D0, the device already has
> > > main power, so I suppose platform_pci_set_power_state(PCI_D0)
> > > doesn't do anything.
> >
> > It may or may not.  Some platforms supply AML to run during D3hot ->
> > D0 transitions (and the ACPI spec allows that).
>
> If the device started in D3hot, it never lost main power, and I
> assumed platform_pci_set_power_state(PCI_D0) might just leave it in
> D3hot.  It sounds like it takes it all the way to D0, although the
> subsequent code that checks the PMCSR state does suggest that the
> device might *not* be in D0:

On platforms using ACPI, platform_pci_set_power_state() carries out
the AML part of the transition which may do nothing for devices in
D3hot (for instance, there may be an ACPI power resource that needs to
be turned "on" in order to restore power to the device, but if the
power resource is "on" already, say because it is shared with another
device that is in D0 ATM, its state may not change).

platform_pci_set_power_state() may also be a no-op for the given
device (for example, if this is an add-on device without any
associated AML).

The rule of thumb is that if there is a programmatic way to remove
power from a PCIe device (so it can go into D3cold), it is generally
platform-specific and there should be a complementary programmatic way
to do the reverse (also generally platform-specific).  Otherwise, the
device can go only as deep as D3hot except when the system as a whole
is powered down or it is on a Thunderbolt link that can be
disconnected at any time etc.

>     platform_pci_set_power_state(dev, PCI_D0);
>
>     pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>     state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
>     if (state =3D=3D PCI_D0)
>       goto end;
>
>     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
>     if (state =3D=3D PCI_D3hot)
>       pci_dev_d3_sleep(dev);
>     ...
>
>   end:
>
> If platform_pci_set_power_state(PCI_D0) puts the device in D0 and
> takes care of all the delays, "state" should always be PCI_D0, and we
> shouldn't need the D3hot and D2 delays here.

Well, not quite, as per the above.

I guess the name is somewhat confusing, but I'm not sure what other
name would be better.
