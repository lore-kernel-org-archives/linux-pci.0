Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A87318BA8;
	Thu, 23 Jul 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843796; cv=none; b=c3UIkY19ExdukFMKAUfNG6tjwTzdLsV70wjs6SfWn/X9r7q69H1VfFGDhx1kMO11ryWJZqdtVEK/4MTR3W9ayviCyeeCmldV0Nqkaz5BFwaeJOO39ixzj+8EFD2pfvqrTlrVtqv1KXfasmXSSkYFR6nnqa1ENI2ZAg6fYTMslM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843796; c=relaxed/simple;
	bh=CQP5d1ako5uXL0GjcT1BYt76tu5Y/xB5dt9pRb609W0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B9icC86l1x8XA7cF9qgkZLK4IzhXKxphWfmg2r4n5swr6mV34+KG4VKUk4hz6stknLTMXcyDY+2zxQFURpzt2JuvtFsjWc34W8pLeAU4dY1UeEEihVt5pI0cKv65bR7fwNDbIvfJ/3SBxb7McabVvodQ4HqnYjEhJl9Omxqb4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcUfY9Oy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcUfY9Oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BBF1F000E9;
	Thu, 23 Jul 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843795;
	bh=3QJrG1F4VwouXVhH+XAc7LBouqKtfdmJsZAfmGzChoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=KcUfY9Oy4kUwtw2Ry8LCof4ywzkYM1XRKYjQ+rjkdDrj3l2pbXKNcZYmTEBNlIey1
	 rNSc5RhkhDIqQI+yzta914zyTLD7aJTrQSJZvS/6XeCPohe/+Bg1LyLcIM2c+xmpLN
	 teNtekohVzjkC60G4jDJMB47w9c4PpWVtZKPxLUzPQlhLWqTQlNVCq6OHxuqOhPWpm
	 S5T7UVPWdbPu9A6rp1tB3zROxhqEyRrAfQbDuZXEJ2P2ub8Q4fHN4w6magoRmqN2kg
	 KBnCLVTJvPDlUs8HJXDAZh/4o5q9XVGkbx0t3SeYTgDAGw42aOdLRn2/pQiffe/Gxx
	 uTJqcSiPXOuTg==
Date: Thu, 23 Jul 2026 16:56:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Allow probing even without child services
Message-ID: <20260723215633.GA864671@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amG0XebAYI-4eDIN@wunner.de>

On Thu, Jul 23, 2026 at 08:27:41AM +0200, Lukas Wunner wrote:
> On Wed, Jul 22, 2026 at 04:09:42PM -0700, Brian Norris wrote:
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> >   */
> >  static int pcie_port_device_register(struct pci_dev *dev)
> >  {
> > -	int status, capabilities, i, nr_service;
> > +	int status, capabilities, i;
> >  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> 
> Nit:  Move the amended line below the irqs[] declaration to sustain
> inverse Christmas tree ordering.

I moved this locally.

> Otherwise this is
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> One caveat, I note there is a pre-existing issue on Loongson LS7A,
> which (according to 62b6dee1b44a) suffers from a defect wherein
> disabling bus mastering prevents forwarding of MMIO requests downstream.
> This happens right now (and continues to happen after the present patch)
> if the error path in pcie_port_device_register() is taken.
> 
> I also note that pci_enable_device() is only called because per
> 1ce5e83063bf, it was necessary in 2009 for legacy interrupt initialization
> "on some architectures", which sounds fairly vague to me.  In any case,
> it seems to suggest that pci_disable_device() should be called if
> pcie_init_service_irqs() fails.  Right now that is done, after the patch
> it isn't.  I guess portdrv would have to remember on probe whether
> pci_enable_device() was called and only then call pci_disable_device()
> on remove.  I guess it would be possible to abuse dev_set_drvdata()
> to store this status bit (as a fake pointer).  Then again, I'm not
> sure pci_enable_device() is still necessary for legacy interrupt
> initalization today.  I guess "legacy interrupt" refers to INTx.
> A lot has changed in generic and PCI irq code since 2009.
> I assume we otherwise don't have a need to access BARs on PCIe ports
> currently, but perhaps new port services may come along which do?

I think we also need pci_enable_device() so MSI-X configuration can
access the BAR.
