Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F230149F;
	Mon,  4 May 2026 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929463; cv=none; b=KXb+PWi6jgOAZ/i0DuMGmmaTniTwDVWfiL/B7seC6dJ+57nEv8fzkzr4AvViI+ymwMjzFYej6I3pXEsj0PbzEfBcA9/PXZDO8eXQuXXbfh5KU0bIek81nA6YDYB4pLps/jTwdqM+W00QNjkYsoWYqfBUl05kQYr77P5uewp2cxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929463; c=relaxed/simple;
	bh=VJCFodeb1415gnZmpEDRAfNlGtQgS+k98vXZga2ZtNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kttnzyxQAx053UAwm+TA/EdEKvldZuWKDvHUvT3Q5gs/gzyj8aVx1mEtBvtEkkV8evtzBoYC5bPrTSLcaCrIWLGbUJyT4KOvglT4idFF6Q5RR5BQlTVodiwSbDSkT1I6Ea8A6ynBXpTL8YEVXtGVzYp5pbQc7O2spAOlfLS3qdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paXdTHtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paXdTHtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158E9C2BCC9;
	Mon,  4 May 2026 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777929463;
	bh=VJCFodeb1415gnZmpEDRAfNlGtQgS+k98vXZga2ZtNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=paXdTHtX1528jv1Ts0LYLYABVvKzXxcpMTDJcupE/VIWyZtYBAPSw/nC4NDa4bMLN
	 jj8fswigvElJhXiPWatxoLcSR6L2sqCzinx0pfu4e9m9TZjfgmHCd7F9Gj4CJ+H7Po
	 JCIk37TFRyvnoMFjh7zTibvLkRog31pG+OGCbVlkbj0vkN1U3PLTXLBMqD/Og7LEv0
	 Cqgf83wqKF4Tyq9Hld3Sr91y8erG2q16Vzm/StHG6GTnQJs1G3UhMlohxabLxbxHGI
	 05nBZ6T4MOPMnY9NneR9MfmWuMnTStU4vo7FIW/3k408uU1UP/UB3IVIGMf7k/Fr2y
	 h3I0PFDtpA6CA==
Date: Mon, 4 May 2026 16:17:41 -0500
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
Message-ID: <20260504211741.GA659556@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g3f8_7v-8W0SAbn_8vmKUJgpDbgyYMSjv03QjXJ8bCHQ@mail.gmail.com>

On Mon, May 04, 2026 at 09:31:51PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 4, 2026 at 7:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, May 04, 2026 at 09:49:36AM +0200, Lukas Wunner wrote:
> > > On Sun, May 03, 2026 at 01:51:08PM +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > > issue(s) to consider:
> > > > - [High] Removing the read-back and retry loop for BAR restoration in
> > > > `pci_restore_state()` introduces a risk of silent regressions for
> > > > hardware resuming from non-FLR resets (such as D3hot to D0 transitions
> > > > or custom driver resets). The commit incorrectly assumes the 60s delay
> > > > from `pci_dev_wait()` covers all usages, but standard PM resume paths
> > > > only delay for 10ms (`PCI_PM_D3_WAIT`) before calling `pci_restore_state()`.
> > > > Historically, hardware that needed slightly longer to accept
> > > > configuration writes relied on the 10x 1ms retry loop to successfully
> > > > restore BARs. By removing both the retry and the read-back verification,
> > > > BAR writes to slow devices will be silently dropped, leaving hardware
> > > > unconfigured and causing MMIO accesses to result in IOMMU faults or
> > > > kernel crashes.
> > >
> > > Hallucination alert:
> > >
> > > PCI_PM_D3_WAIT does not exist, it was renamed to PCI_PM_D3HOT_WAIT
> > > six years ago by commit 3789af9a13e5, which went into v5.10.
> > >
> > > The macro is used in:
> > >
> > > pci_pm_resume_noirq()
> > >   pci_pm_default_resume_early()
> > >     pci_pm_power_up_and_verify_state()
> > >       pci_power_up()
> > >         pci_dev_d3_sleep()
> > >
> > > However before pci_power_up() calls pci_dev_d3_sleep(), it reads
> > > the PMCSR register and errors out if config space is inaccessible.
> > >
> > > Hence when pci_restore_state() is invoked a bit later, config space
> > > can be assumed to be accessible.
> >
> > I don't quite follow this.  In this path, pci_power_up() changes a
> > device from some low-power state to D0.  If the device was in D3hot or
> > D3cold, we must delay at least 10ms before any access to it (PCIe
> > r7.0, sec 5.9).
> 
> D3hot and D3cold are different in this respect, so using "or" here is
> inaccurate and confusing.
> 
> Accessing the config space of a device in D3hot is entirely correct
> and doesn't require any delay.
> 
> Accessing the config space of a device in D3cold is questionable
> because the device may not be accessible, but then the host bridge
> should just fail the access.
> 
> The 10 ms delay is after attempting to program the device into D0 from
> D3hot (or the other way around) and it is observed as required.

Thanks for taking a look at this!

If pci_power_up() is doing D3cold -> D0, main power is initially off,
so platform_pci_set_power_state(PCI_D0) would turn on main power,
which is a Fundamental Reset leaving the device in D0uninitialized.
In general the device needs at least 100 ms after that reset before
any access, e.g., before the PMCSR read.

If pci_power_up() is doing D3hot -> D0, the device already has main
power, so I suppose platform_pci_set_power_state(PCI_D0) doesn't do
anything.  The device remains in D3hot, the PMCSR read should be fine,
and the PMCSR write to transition to D0 is immediately followed by the
10 ms delay.  When No_Soft_Reset == 1, this should be enough.

But when No_Soft_Reset == 0, the transition is to D0uninitialized,
which sec 2.3.1 includes as a reset condition after which the device
is permitted to return RRS.

So to me it looks like we need these delays:

  - For D3cold -> D0, msleep(100) and pci_dev_wait() between
    platform_pci_set_power_state(PCI_D0) and the PMCSR read, similar
    to what pcie_flr() does.

    Maybe platform_pci_set_power_state() takes care of some or all of
    this internally?

  - For D3hot -> D0 with No_Soft_Reset == 0, pci_dev_wait() after the
    PMCSR write to transition to D0.

    abbcf0e2a99d ("PCI: Wait for device to become ready after a power
    management reset") added the similar wait in pci_pm_reset().

> > pci_power_up() doesn't do any delay before the PMCSR read.
> 
> It assumes that platform_pci_set_power_state() has run and either it
> has succeeded or the config space is not accessible which is when
> PCI_POSSIBLE_ERROR() will trigger.  Unfortunately, there is no
> canonical way to verify that power has been restored to the device
> other than attempting to access it.
> 
> > That part seems like a pre-existing issue even before this patch.
> 
> I beg to differ.
> 
> > If the PMCSR read returns PCI_POSSIBLE_ERROR(), pci_power_up() does
> > complain "Unable to change power state ... to D0" and return -EIO, but
> > pci_pm_power_up_and_verify_state() doesn't look at it,
> 
> In fact, pci_update_current_state() changes the power state to D3cold
> if the config space is not accessible.
> 
> > and pci_pm_default_resume_early() continues on to pci_restore_state(), so
> > it looks to me like we could try to restore state to an inaccessible
> > device.
> 
> So the pci_restore_state() call could be avoided if the power state of
> the device was D3cold, but then the question is how much of a problem
> that is in practice.
> 
> > We do call pci_dev_wait() in pci_pm_reset(), which does a D3hot -> D0
> > transition; shouldn't we do the same in pci_power_up()?
> 
> It would be good to make them consistent, but maybe the other way around?
