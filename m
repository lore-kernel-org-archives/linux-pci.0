Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A402F9C3D;
	Fri,  6 Feb 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369103; cv=none; b=Os/u1eiKaILRdWHsRTb6+X4v+Xq47kdTda3ZGRDcsrm1F+SAPn1UX87aI54AZlrZSlX0/RwOVI/AjYS+26nVkMsQRxe3adsssjQhVyqGCSGk0RbW44xXrGle5oSGjiOBSoH8cVTDkYdQ0Hy/qyfQkSGaRtyDDrkAC8RWiVh87ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369103; c=relaxed/simple;
	bh=tc3lg7Bqw2QuglErWCKqTgJiaeqx1w8P2QbcfUFOiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYmQQaVmswmCIuS0ASj6f7m4HK4TbJyD7ofo8lMUezIzuTU08ai5Szf+fjlWBVmgf4oTG+0sYXkj+dlaYPTtAKjDjo4NDuZI3WrSVtlmOacf4oLRS+YqBv0i8ghw6OQRd75Vlhv1xpTYTVwJIEXAAPmcpae3dc9O/QwyGm1iN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNvIj8yX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNvIj8yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C003C19422;
	Fri,  6 Feb 2026 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770369103;
	bh=tc3lg7Bqw2QuglErWCKqTgJiaeqx1w8P2QbcfUFOiwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNvIj8yXjA18Uloi4a5pXmyoeRcbpkMv8P/JamRmhW0oiiwPcrfAXXcm5Kl8H7Vdq
	 6ju1ewFwoH4mqQjQk3VdddRtVIfnyxHbPZALERTl8ZNzDQvRVhMIhJx5HqdUg2NCD1
	 fJaUjfu80MfMC11lsGCZPfZixHD6VOKuc/gMj27CYa3nz1jQtGjWQNR+EmoL3TeZDN
	 I1T8F25cGhTHZ2QUo6/OBJKW14vLmkp4E4FW21VR7OU7ltLkbMMRppXP0gx+1sH09e
	 S+C5fwacH7bugWkfh0XE9oMRuVKhvbSf9wvkG3z7MOLPxnT4JA3rfxjJfEQiojSoCK
	 Oo634rTYJ69/Q==
Date: Fri, 6 Feb 2026 14:41:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>
References: <20260102-pci_acs-v3-3-72280b94d288@oss.qualcomm.com>
 <20260205233920.GA17083@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205233920.GA17083@bhelgaas>

On Thu, Feb 05, 2026 at 05:39:20PM -0600, Bjorn Helgaas wrote:
> [+cc Alex, James (author of aa667c6408d2)]
> 
> On Fri, Jan 02, 2026 at 09:04:49PM +0530, Manivannan Sadhasivam wrote:
> > Some IDT switches behave erratically when ACS Source Validation is enabled.
> > For example, they incorrectly flag an ACS Source Validation error on
> > completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
> > says that completions are never affected by ACS Source Validation.
> > 
> > Even though IDT suggests working around this issue by issuing a config
> > write before the first config read, so that the device caches the bus and
> > device number. But it would still be fragile since the device could loose
> > the IDs after the reset and any further access may trigger ACS SV
> > violation.
> > 
> > Hence, to properly fix the issue, the respective capability needs to be
> > disabled. Since the ACS Capabilities are RO values, and are cached in the
> > 'pci_dev::acs_capabilities' field, remove the cached broken capabilities by
> > calling pci_disable_broken_acs_cap() from pci_acs_init(). This will allow
> > pci_enable_acs() helper to disable the relevant ACS ctrls.
> > 
> > With this, the previous workaround can now be safely removed.
> 
> James added the existing IDT workaround for the IDT 0x80b5 switch,
> which was merged as aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum").
> 
> I guess these last three patches:
> 
>   PCI: Cache ACS capabilities
>   PCI: Disable ACS SV capability for the broken IDT switches
>   PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch
> 
> are basically to fix the same issue on the IDT 0x8090 switch?
> 

Yes!

> The obvious approach would be to extend the test in
> pci_bus_read_dev_vendor_id() to check for 0x8090 in addition to
> 0x80b5, which might be worth doing first, before changing the whole
> approach.
> 

I've mentioned the rationale for not using this approach in the cover letter.
But I'll mention it here also. I did try extending the existing quirk in the
first version of this series [1], but Jason proposed to disable ACS completely
for these switches as doing a dummy config write before reading the vendor ID
would not help if the switch gets reset during runtime. The cached bus number in
the device would get lost, triggering ACS SV again.

> I guess your point here is that the existing workaround isn't enough
> even for 0x80b5 because it doesn't handle the reset case?  The patch
> changelogs after v9 of the original patch (see below) do mention that
> FLR and hot reset were tested and didn't seem to require the
> workaround.  But you've probably seen problems after reset?
> 

I haven't seen the problem myself, but Jason's point was that there is no
spec mandate for the switch to retain its bus number after FLR/hot reset [2]

> I think it's worth a note about why the reset case can't be fixed
> similarly to the enumeration case.  
> 

If the device looses its cached bus number, then further config reads from the
host would trigger ACS SV. And we do not want to do a dummy write from all
possible locations in PCI core.

> This patch gives up on ACS SV completely for this switch instead of
> the current approach of:
> 
>   - disabling ACS SV
>   - doing a config write
>   - reading dev/vendor ID
>   - re-enabling ACS SV
> 
> It'd be worth expanding on this and what the effect of avoiding ACS SV
> is.  Does this change which devices can be safely passed through to
> virtual guests?  Does it give up isolation that users expect?
> 

IMO, ACS SV is somewhat broken on this switch. But we can still passthrough the
downstream devices to the guests. There won't be ACS SV apparently, but that's
what users will get with broken hw.

> I also couldn't remember why we can't just do a config write before
> reading the vendor/dev ID of a device below the switch, which is
> addressed in the discussion of v3 (below).  Basically if the device
> isn't yet ready to accept config accesses, it may not latch the bus
> number, and we can't really tell when it *is* ready.
> 

I think that is a separate discussion (detecting device readiness). But doing a
dummy config write to woraround the hardware bug looks fragile to me too.

- Mani

[1] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20250924125555.GJ2547959@ziepe.ca/

> I collected up all the history I could find about the original change:
> 
> v3  2017-06-09 https://lore.kernel.org/all/20170609231617.20243-1-yinghai@kernel.org/
>     doing config write is hard because we don't know when the device
>     is Configuration-Ready and can capture the bus number:
>     https://lore.kernel.org/all/20170613221451.GC7012@bhelgaas-glaptop.roam.corp.google.com/
> v4  2017-06-27 https://lore.kernel.org/all/5952D144.8060609@oracle.com/
>     only do workaround for IDT switches
> v5  2017-07-06 https://lore.kernel.org/all/595E610A.5000900@oracle.com/
>     skip devices that don't advertise ACS SV support
> v7  2017-09-18 https://lore.kernel.org/all/59C02719.5050103@oracle.com/
>     add https://bugzilla.kernel.org/show_bug.cgi?id=196979 with
>     details about how Windows deals with this
> v8  2018-03-06 https://lore.kernel.org/all/ce8e9a3e-474d-961c-eb0a-c021077f2dca@oracle.com/
> v9  ? (couldn't find this)
>     tested FLR and hot reset scenarios; didn't see issues where
>     workaround was required
> v11 2018-04-11 https://lore.kernel.org/all/e6a55432-8c56-9c99-ce99-4ae80a0ed3ba@oracle.com/ (no version label)
>     2018-04-19 https://lore.kernel.org/all/b6439e86-2284-5b3c-3656-a0c3c2568317@oracle.com/ (no version label)
> v12 2018-04-24 https://lore.kernel.org/all/7e9f5905-34c5-f24c-8b13-df36b8bf3621@oracle.com/
> v13 2018-04-30 https://lore.kernel.org/all/4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com/ (labeled v2)
> v14 2018-07-09 https://lore.kernel.org/all/4117c119-c754-bf4e-544c-19cb6e239f38@oracle.com/
> 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pci.c    |  1 +
> >  drivers/pci/pci.h    |  3 ++-
> >  drivers/pci/probe.c  | 12 -----------
> >  drivers/pci/quirks.c | 61 ++++++++++++----------------------------------------
> >  4 files changed, 17 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d89b04451aea..e16229e7ff6f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3652,6 +3652,7 @@ void pci_acs_init(struct pci_dev *dev)
> >  		return;
> >  
> >  	pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabilities);
> > +	pci_disable_broken_acs_cap(dev);
> >  }
> >  
> >  /**
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 4592ede0ebcc..5fe5d6e84c95 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -432,7 +432,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
> >  				int rrs_timeout);
> >  bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
> >  					int rrs_timeout);
> > -int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
> >  
> >  int pci_setup_device(struct pci_dev *dev);
> >  void __pci_size_stdbars(struct pci_dev *dev, int count,
> > @@ -944,6 +943,7 @@ void pci_enable_acs(struct pci_dev *dev);
> >  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> >  int pci_dev_specific_enable_acs(struct pci_dev *dev);
> >  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
> > +void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> >  int pcie_failed_link_retrain(struct pci_dev *dev);
> >  #else
> >  static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
> > @@ -959,6 +959,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
> >  {
> >  	return -ENOTTY;
> >  }
> > +static inline void pci_disable_broken_acs_cap(struct pci_dev *dev) { }
> >  static inline int pcie_failed_link_retrain(struct pci_dev *dev)
> >  {
> >  	return -ENOTTY;
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 41183aed8f5d..c7304ac5afc2 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2547,18 +2547,6 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  				int timeout)
> >  {
> > -#ifdef CONFIG_PCI_QUIRKS
> > -	struct pci_dev *bridge = bus->self;
> > -
> > -	/*
> > -	 * Certain IDT switches have an issue where they improperly trigger
> > -	 * ACS Source Validation errors on completions for config reads.
> > -	 */
> > -	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
> > -	    bridge->device == 0x80b5)
> > -		return pci_idt_bus_quirk(bus, devfn, l, timeout);
> > -#endif
> > -
> >  	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b9c252aa6fe0..1571a2ef331e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5778,58 +5778,25 @@ DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> >  			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
> >  
> >  /*
> > - * Some IDT switches incorrectly flag an ACS Source Validation error on
> > - * completions for config read requests even though PCIe r4.0, sec
> > - * 6.12.1.1, says that completions are never affected by ACS Source
> > - * Validation.  Here's the text of IDT 89H32H8G3-YC, erratum #36:
> > + * Some IDT switches behave erratically when ACS Source Validation is enabled.
> > + * For example, they incorrectly flag an ACS Source Validation error on
> > + * completions for config read requests even though PCIe r4.0, sec 6.12.1.1,
> > + * says that completions are never affected by ACS Source Validation.
> >   *
> > - *   Item #36 - Downstream port applies ACS Source Validation to Completions
> > - *   Section 6.12.1.1 of the PCI Express Base Specification 3.1 states that
> > - *   completions are never affected by ACS Source Validation.  However,
> > - *   completions received by a downstream port of the PCIe switch from a
> > - *   device that has not yet captured a PCIe bus number are incorrectly
> > - *   dropped by ACS Source Validation by the switch downstream port.
> > + * Even though IDT suggests working around this issue by issuing a config write
> > + * before the first config read, so that the switch caches the bus and device
> > + * number, it would still be fragile since the device could loose the IDs after
> > + * the reset.
> >   *
> > - * The workaround suggested by IDT is to issue a config write to the
> > - * downstream device before issuing the first config read.  This allows the
> > - * downstream device to capture its bus and device numbers (see PCIe r4.0,
> > - * sec 2.2.9), thus avoiding the ACS error on the completion.
> > - *
> > - * However, we don't know when the device is ready to accept the config
> > - * write, so we do config reads until we receive a non-Config Request Retry
> > - * Status, then do the config write.
> > - *
> > - * To avoid hitting the erratum when doing the config reads, we disable ACS
> > - * SV around this process.
> > + * Hence, a reliable fix would be to assume that these switches don't support
> > + * ACS SV.
> >   */
> > -int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
> > +void pci_disable_broken_acs_cap(struct pci_dev *pdev)
> >  {
> > -	int pos;
> > -	u16 ctrl = 0;
> > -	bool found;
> > -	struct pci_dev *bridge = bus->self;
> > -
> > -	pos = bridge->acs_cap;
> > -
> > -	/* Disable ACS SV before initial config reads */
> > -	if (pos) {
> > -		pci_read_config_word(bridge, pos + PCI_ACS_CTRL, &ctrl);
> > -		if (ctrl & PCI_ACS_SV)
> > -			pci_write_config_word(bridge, pos + PCI_ACS_CTRL,
> > -					      ctrl & ~PCI_ACS_SV);
> > +	if (pdev->vendor == PCI_VENDOR_ID_IDT && pdev->device == 0x80b5) {
> > +		pci_info(pdev, "Disabling broken ACS SV\n");
> > +		pdev->acs_capabilities &= ~PCI_ACS_SV;
> >  	}
> > -
> > -	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> > -
> > -	/* Write Vendor ID (read-only) so the endpoint latches its bus/dev */
> > -	if (found)
> > -		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
> > -
> > -	/* Re-enable ACS_SV if it was previously enabled */
> > -	if (ctrl & PCI_ACS_SV)
> > -		pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl);
> > -
> > -	return found;
> >  }
> >  
> >  /*
> > 
> > -- 
> > 2.48.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
