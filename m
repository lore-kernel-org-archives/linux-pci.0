Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B71DC9B3;
	Fri, 15 May 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860053; cv=none; b=V5fRQOTy+t+wIEp6HSXHkiCn5ygvdNFwmqmJKd8fSOTIhj37YistG7L24+M+AzWZjlhsMEmRzg4wPZa3gqet1aHMpbQ34MluXRNqAeNNsBbqI6fxJdUXXIzgPg57N+NUGFTIdjahB9zwy00TzFI58GU+ph5FmaT6I0Y1tt8IaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860053; c=relaxed/simple;
	bh=nAxuzXMOK+miwIa6OcLsPEoy+WyYQNEXt6Jh5/C42mM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aCjr0/UpJvWeIJOuj80/O3KNNe0lMWbj0eOzaPtFNNBYEylw+UPY5huvwmkP+zeKBCbilgdgVNDBaNmmYRlhielaNJYSfiVpV8YNw2BvLsyibmDn3UMlvU1wGBqnZUPyRIygxs+6Tdzqz2jImPRWl2J1x25d+TuwLXOS8eSipDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA+rcpwB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA+rcpwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF42C2BCC9;
	Fri, 15 May 2026 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860053;
	bh=nAxuzXMOK+miwIa6OcLsPEoy+WyYQNEXt6Jh5/C42mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FA+rcpwB7CHc3UEez0UHqJOOEIrted4CGnF6OLJdFocL2hgz2RGYxjug6GNM3wkOd
	 2q4ASG927C0C79kBdGfKeG7yEw2xNPR0lOBZROSijpGUVRzK5vyIdQlZwJIdKWF/19
	 8gYNyRqUjhT5g9w79ZFA4D42en+eibl1UfUN81gVPGpzqtd9X1D6qcwRHc8+5pWq+4
	 P21LJP9LUvFgk4swSWP6zAz0Bh7g9FLj8AoMelDiVG8fvpAcI2LFf7DIHT4CehT8es
	 ODLMcId891v44O6mTQbu/S15k0e6yJhoLLPt/Tmm5V7iQUk5HRJqMiTJ6oKc8VatMO
	 PT+WcYFn4nKYA==
Date: Fri, 15 May 2026 10:47:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <20260515154731.GA479800@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agcVvg1ntQPbivr9@wunner.de>

On Fri, May 15, 2026 at 02:46:54PM +0200, Lukas Wunner wrote:
> On Thu, May 14, 2026 at 04:38:11PM -0500, Bjorn Helgaas wrote:
> > On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > > > +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > > +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > > > +				     PCIE_RESET_READY_POLL_MS);
> > > 
> > > Is it safe to ignore the return value of pci_dev_wait() here?
> > > 
> > > If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
> > > ignoring this error, pci_power_up() continues, unconditionally sets
> > > dev->current_state = PCI_D0, and can return success (1 for need_restore).
> > > 
> > > If pci_power_up() returns success, will callers like pci_back_from_sleep()
> > > execute pci_restore_state() against an unresponsive device, which could
> > > potentially trigger PCIe Master Aborts, AER events, or system crashes?
> > > 
> > > Should pci_power_up() propagate the error from pci_dev_wait() to prevent
> > > this?
> > 
> > Good point.  I think it should look like this instead:
> > 
> >     if (state == PCI_D3hot) {
> >             pci_dev_d3_sleep(dev);
> >             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> >                     ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> >                                        PCIE_RESET_READY_POLL_MS);
> >                     if (ret) {
> >                             pci_err(dev, "Not ready after soft reset\n");
> >                             dev->current_state = PCI_D3cold;
> >                             return -EIO;
> >                     }
> 
> pci_dev_wait() already emits a warning message on timeout, so the
> additional pci_err() is probably not needed.  Otherwise the user
> would see duplicate messages, i.e.:
> 
>   pci SSSS:BB:DD.F: not ready 60000ms after power up D3hot->D0uninitialized
>   pci SSSS:BB:DD.F: Not ready after soft reset

True, it is redundant.  My thinking was that the other message from
pci_power_up() is KERN_ERR, while the one from pci_dev_wait() is only
KERN_WARNING.

But maybe that message from pci_dev_wait() should be KERN_ERR instead
of KERN_WARNING?  As far as that device is concerned, the lack of
response does seem like more than just a warning.
