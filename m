Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27781429CD6;
	Thu, 16 Jul 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222502; cv=none; b=svIwo8nu4K2G34omKiaPoGu56Ie/SirY8NPQ9tzy9NA0tZQscH772Fz4RasKBZnVKh1YhaTyRXouReQ8aEyZXDU6TWgpS2xQhlJcoqD2J9zDRLYC8M8uSokdhufM0DQzQNpak5/s7lzioXIrhrgKMyeW/8oAR75lNq36jZO3aXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222502; c=relaxed/simple;
	bh=01sVp5IUVr7pUmvWtce6PWfsAWLSr598L8ik7UTzJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q2Q3xc32EOtTSsBw879MQtzE8/HwI+JsWTDORhgneJZy3gFSzDszMU+tC56h9v4FAkQcvI8W5Jge6XG+ah0dkRSDIXhif/qRY8MaGe0oLDGMbJcw6xCTfn4DEmL7EWPzJsNqpwgz4p9C65aZgI4y4psxS8h+8tAwz83ZJvg1t1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6lsOAAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6lsOAAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293BD1F000E9;
	Thu, 16 Jul 2026 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222500;
	bh=T3IWZ2sZ5tYUWDZfmAyqDQEWXvE9y9I+CaJs7hkxESg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R6lsOAANHyjefCpBD1K5mHVDZBPn0FVVgPz1L39h0ymKlfyIB/s2VFT5OcJ33hwL7
	 R4kcm7amYXmZX8Jkcras0MTjnsJ3jSNCLsXIm2oSkI4GsEka6NSLAM9YjJo9OZ1RxX
	 dcb5RhI8UlnVLx6c/KraaHJzwaeqnSTUmAzeTv70uEkcOkIIfTtdU/u+oxwdX7JZkG
	 hDTSMw9tnM0zYwBdKmK205xaO5U9YgtAwpuj1gEramt+MxYOqrmDqN22VcRaMbEX7F
	 up5siqEogZVD/Kg+IhY6JG6cSVFXYmQ37YlGqUhyYV0DsvcPxfW6tIwvovnUK8yOvp
	 iKKYu7LNJQ42Q==
Date: Thu, 16 Jul 2026 12:21:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	David Matlack <dmatlack@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child services
Message-ID: <20260716172139.GA11585@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <algg4sOk0YM1TpXa@google.com>

On Wed, Jul 15, 2026 at 05:08:02PM -0700, Brian Norris wrote:
> On Wed, Jul 15, 2026 at 05:15:26PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 08, 2026 at 05:12:19PM -0700, Brian Norris wrote:
> ...

> Thanks for looking! Can you describe what your goals are here vs my v2?
> I'm curious what you're aiming for.

I was concerned about pci_clear_master() potentially breaking a driver
for a downstream driver, but I don't think that should happen because
portdrv cannot be a module and should always probe before any
downstream device.

> ...
> > -static int pcie_port_device_register(struct pci_dev *dev)
> > +static void pcie_port_device_register(struct pci_dev *dev)
> >  {
> >  	int status, capabilities, i, nr_service;
> >  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> > @@ -336,12 +336,12 @@ static int pcie_port_device_register(struct pci_dev *dev)
> >  	/* Enable PCI Express port device */
> >  	status = pci_enable_device(dev);
> >  	if (status)
> > -		return status;
> > +		return;
> 
> Are you purposely ignoring pci_enable_state() failures now too? That
> wasn't part of my original proposal. This also means you have a
> potential underflow in remove(), because now a port might get through
> probe() with an enable_cnt of 0 -- then we still call
> pci_disable_device() in remove().

Good point.  pci_enable_device() enables BARs, which we only need for
MSI-X tables.  I was thinking portdrv may still be useful for power
management even if pci_enable_device() fails because we couldn't
assign space for BARs.  But that failure is pretty unlikely.
