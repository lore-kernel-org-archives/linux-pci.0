Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F130171A;
	Fri,  8 May 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276591; cv=none; b=IrZUuMNk/5CMVlbmGovuB8B2iwDlckJE5TgjFnOKvthir2BQ9HmjVFgwxbGY/JVeODIX7HJNqjZI+eqokdQVNsPqcPgV/58CryZp9Y5dbomj0+AHd3BwE3K0ciKQT7sbsW9zPcqyZTD8+drV2FwkJ3IRktuMRiQaEZEFDtACbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276591; c=relaxed/simple;
	bh=3FlxDe9og/Uf8FICT2+xgDoU1qSHSCjeRNrP9tt0wcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aw1CI5e5xAWaVQIO0vAsiQ3hAYVckb8sTQsMv4Mt0ypN4mHlGTyX5IQEvjROCz9aPOpgNEVVf1hihjyqq4C/FdNZp8pO4wkEiBKhf0OZPy3DQe3OrlJFaSdrfQ2A6NdHB9A5J6SQIssajZ3anO9GJzx661smF80CiMe/xLTl5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YojPhLFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YojPhLFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F74C2BCB0;
	Fri,  8 May 2026 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276591;
	bh=3FlxDe9og/Uf8FICT2+xgDoU1qSHSCjeRNrP9tt0wcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YojPhLFw6N9f/40AV81KdVEduyCu58hd3NrYX5sUi1lkHOFlhCiAaPuCVyab41Pdr
	 HdIphTKEzyUhPMwXUaMPfW9iQQWcPM0xeOYoLqUWN90Y9vVmr9jeyI/2veNlnpSEsh
	 9Z1X8a5AK8S4kWoTAwab+3yluEt3doi0EDeztwIeE5wzHaecL6wdhtY+afxEAs9RLn
	 liAdHd0lAc9Z2O1/RK2lGihzfR10ntPIezxUro5iOjrn84pJIRhA3LVQ/zNPuvBm9X
	 ZtH3yilS7+VdqLCWKrUhHTeloq43wTVwbwUtAyxX/CmvSuP9He37U7CaLRyRLxcFRF
	 bnG6nKooVgKBQ==
Date: Fri, 8 May 2026 16:43:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org,
	linux-pci@vger.kernel.org, sashiko@lists.linux.dev,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <20260508214309.GA14699@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com>

On Fri, May 08, 2026 at 02:51:37PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, May 4, 2026 at 11:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > ...
> >
> > > > If pci_power_up() is doing D3cold -> D0, main power is initially
> > > > off, so platform_pci_set_power_state(PCI_D0) would turn on main
> > > > power, which is a Fundamental Reset leaving the device in
> > > > D0uninitialized.  In general the device needs at least 100 ms
> > > > after that reset before any access, e.g., before the PMCSR read.
> > >
> > > Yes, it does in general, but that should be covered by
> > > platform_pci_set_power_state() because on some platforms the delay
> > > can be shorter.
> >
> > It's surprising to me that platform_pci_set_power_state() takes
> > care of that delay because there's so much PCIe infrastructure
> > (dependencies on link speed, RRS polling, Immediate Readiness,
> > Readiness Notifications, etc), much of which sounds more like
> > OS-level support than firmware support.
> 
> It is kind of a mixed bag because it involves platform-specific
> operations (the PCIe spec doesn't define a standard method of
> transitioning devices in D3cold into D0).
> 
> The consensus in the industry appears to be that if AML is used for
> carrying out D3cold->D0 transitions, it is expected to take the
> requisite delays into account.
> 
> > But if platform_pci_set_power_state() does guarantee that the device
> > is Configuration-Ready, we should document that somewhere.
> 
> It is more along the lines of what I said before: After
> platform_pci_set_power_state() the device is either
> Configuration-Ready, or inaccessible (in which case it can be assumed
> to have dropped off the bus, but this is all platform-specific, so on
> some platforms there may be ways to revive such devices).

If the device is Configuration-Ready or inaccessible after
platform_pci_set_power_state(PCI_D0), then I agree we shouldn't add
that delay in pci_power_up().

> That said, I'm all for documenting it.

Strawman below.  "Inaccessible upon return" is bound to lead to
questions, but if the PCI core can't do anything I don't know what
else to say.

  diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
  index ed1b1d7a7b46..2b0513c35387 100644
  --- a/drivers/pci/pci.c
  +++ b/drivers/pci/pci.c
  @@ -1068,6 +1068,12 @@ static inline bool platform_pci_power_manageable(struct pci_dev *dev)
	  return acpi_pci_power_manageable(dev);
   }
   
  +/*
  + * When setting power state to D0, platform_pci_set_power_state() ensures
  + * main power is on and that any required delays after a transition to D0
  + * have been completed.  The device is either Configuration-Ready or
  + * inaccessible upon return.
  + */
   static inline int platform_pci_set_power_state(struct pci_dev *dev,
						 pci_power_t t)
   {

> > > > If pci_power_up() is doing D3hot -> D0, the device already has
> > > > main power, so I suppose platform_pci_set_power_state(PCI_D0)
> > > > doesn't do anything.
> > >
> > > It may or may not.  Some platforms supply AML to run during D3hot ->
> > > D0 transitions (and the ACPI spec allows that).
> >
> > If the device started in D3hot, it never lost main power, and I
> > assumed platform_pci_set_power_state(PCI_D0) might just leave it in
> > D3hot.  It sounds like it takes it all the way to D0, although the
> > subsequent code that checks the PMCSR state does suggest that the
> > device might *not* be in D0:
> 
> On platforms using ACPI, platform_pci_set_power_state() carries out
> the AML part of the transition which may do nothing for devices in
> D3hot (for instance, there may be an ACPI power resource that needs to
> be turned "on" in order to restore power to the device, but if the
> power resource is "on" already, say because it is shared with another
> device that is in D0 ATM, its state may not change).
> 
> platform_pci_set_power_state() may also be a no-op for the given
> device (for example, if this is an add-on device without any
> associated AML).
> 
> The rule of thumb is that if there is a programmatic way to remove
> power from a PCIe device (so it can go into D3cold), it is generally
> platform-specific and there should be a complementary programmatic way
> to do the reverse (also generally platform-specific).  Otherwise, the
> device can go only as deep as D3hot except when the system as a whole
> is powered down or it is on a Thunderbolt link that can be
> disconnected at any time etc.
> 
> >     platform_pci_set_power_state(dev, PCI_D0);
> >
> >     pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >     state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> >     if (state == PCI_D0)
> >       goto end;
> >
> >     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> >     if (state == PCI_D3hot)
> >       pci_dev_d3_sleep(dev);
> >     ...
> >
> >   end:
> >
> > If platform_pci_set_power_state(PCI_D0) puts the device in D0 and
> > takes care of all the delays, "state" should always be PCI_D0, and we
> > shouldn't need the D3hot and D2 delays here.
> 
> Well, not quite, as per the above.

OK, so after platform_pci_set_power_state(PCI_D0), the device may be
in D3hot in some cases.  Then there's a D3hot -> D0 transition, and we
do pci_dev_d3_sleep(), but not pci_dev_wait().  Sec 2.3.1 says RRS is
permitted after a D3hot to D0uninitialized, and pci_dev_wait() is what
waits and retries for the RRS case.

It looks to me like we need pci_dev_wait() after that transition when
No_Soft_Reset == 0, i.e., something like the below.  Do you think this
is unnecessary?

  diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
  index 8f7cfcc00090..ed1b1d7a7b46 100644
  --- a/drivers/pci/pci.c
  +++ b/drivers/pci/pci.c
  @@ -1341,10 +1341,14 @@ int pci_power_up(struct pci_dev *dev)
	  pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
   
	  /* Mandatory transition delays; see PCI PM 1.2. */
  -	if (state == PCI_D3hot)
  +	if (state == PCI_D3hot) {
		  pci_dev_d3_sleep(dev);
  -	else if (state == PCI_D2)
  +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
  +			pci_dev_wait(dev, "power up D3hot->D0",
  +				     PCIE_RESET_READY_POLL_MS);
  +	} else if (state == PCI_D2) {
		  udelay(PCI_PM_D2_DELAY);
  +	}
   
   end:
	  dev->current_state = PCI_D0;
