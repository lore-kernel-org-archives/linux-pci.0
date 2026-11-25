Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567633;
	b=EFiddY8lckg8mV11XoAc0BxVfTQPGeNLfBn01DqfeUEO+1XN2ttYWwk1r3OxuO8h7ng5
	 GXQUlMFaWbKEAvjs8xNtZy5zyGCqEcMzhzAdAknj/HkcBYXnMIW3OSz5UCDDZRl7fLXm3
	 6KKyUcq7px9GR2dNQIR3rk7LnUhABiwJyKCTp8mn/eyngb55+d2Y/+uyjxoDlyPgb2oHa
	 MVOKhtwdZFzaBJg1L+gVNHdmyGbyYEnUOk4RxDGmHNVMPHaJkhmNTxYoHZl9wivcGS9YE
	 wTt4us1MccaeCkYMlOPDEG+0oOEok5P1cFK5B3HPoe75pIZ0m+fvRVKoP9FokgK3Ixg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567633;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x3Tb5wGvPFsOLbf9O2zMutrp6rf2pvaXOEHNMdWmm6U=;
	b=sURQaF91S0J69csNkTC9LhDdZn/0PkilKj6Zy/HHigedNpC9A1yEQZih9DLJKA+AVHft
	 6AObBUuGSKDJK8jAMo7q49mSMNOjSL4aZ4AkQ5de0haPSX9FdBV9F61duKRIjNjfPBVn/
	 MG76WXWM6Qj2V2+CvG5R6Av86uwVfo2b5WkZHG5qhQISZQaiobGh1b4pFRSTxRkNYgmxU
	 fGxyxw1Fb1hVAz+AjTh81rAdHrZCQOH/LACSQsm1yl5XQsTRiAyb2XJGk0xnk1baCEuTY
	 YLo33G4JMI+MT0kAEvll8dYCjb66ymK2BYSffXQkcXKWIO6pvIW9oHv40gEsLXqVgvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WF2i9eGW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D111606A31E;
	Wed, 25 Nov 2026 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WF2i9eGW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD31F000CA;
	Wed, 25 Nov 2026 00:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795567632;
	bh=x3Tb5wGvPFsOLbf9O2zMutrp6rf2pvaXOEHNMdWmm6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WF2i9eGWMpChy12GvKFv2XzhlDqcX1nk78LLUoOzK9Fa5sZ7QogneatQj727yuaA1
	 mrAyJGMiJrUqDePX1pGiisLxoKmwYrGSqREFf4cn86lSJAUt+WCORCmsv2tf/pI7YA
	 WWdKRnw94alFPTukBeJ8f1i037hbCzTjx8ILmuZxqRya1cD9kZV5/jvkBy1f/MEyJ3
	 jqj6jfmgwXaq7xaHh9i3wkCIkh1YWmyDKFJjH7E3HpsQ+RS2XeT+j2waY0x/Rl+yKX
	 Z5sYQCd4OWlc41nW2NUUv+CSDB8SZKejjJCal4hCOaEgtwRVAKTfqXcTdzwai99pWl
	 wKNBMDhox5NOA==
Date: Tue, 24 Nov 2026 18:47:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	helgaas@google.com, iweiny@kernel.org, ming.li@zohomail.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, tglx@kernel.org, wangruikang@iscas.ac.cn,
	alifm@linux.ibm.com, shawn.lin@rock-chips.com,
	lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com,
	xiangzao@linux.alibaba.com, vidyas@nvidia.com, kaihengf@nvidia.com,
	kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Message-ID: <20261125004709.GA1202732@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awQJGfWYyqYCmL09@MWDK4CY14F>

On Mon, Nov 23, 2026 at 05:52:25PM +0800, Richard Cheng wrote:
> On Fri, Nov 20, 2026 at 10:39:09AM +0800, Bjorn Helgaas wrote:
> > [+cc Ben, Alex]
> > 
> > On Fri, Nov 20, 2026 at 04:09:13PM +0800, Richard Cheng wrote:
> > > On Mon, Nov 16, 2026 at 01:09:39PM +0800, Bjorn Helgaas wrote:
> > > > On Mon, Nov 16, 2026 at 02:52:28PM +0800, Richard Cheng wrote:
> > > > > PCI state restoration runs even when a reset fails. If the device's
> > > > > config space remains inaccessible, MSI-X restoration still writes the
> > > > > MSI-X table. The table lives in device memory space, and these MMIO
> > > > > accesses can trigger additional errors, including DPC.
> > > > > 
> > > > > MSI is programmed entirely through config space, so it doesn't issue
> > > > > such MMIO accesses. Restoring it is still pointless when config space is
> > > > > inaccessible: reads return all ones and the restore path writes back
> > > > > values derived from them.
> > > > > 
> > > > > Check whether config space of pci device is accessible or not at the
> > > > > start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> > > > > and before any config access, and skip the restoration if the device is
> > > > > inaccessible.
> > > > > Make the helper non-static and declare it in pci.h so the MSI code can
> > > > > use it, too.
> > > > > 
> > > > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > > > ---
> > > > > Changelog:
> > > > > 
> > > > > v2 -> v3:
> > > > > - Cover MSI restoration path as well (Farhan)
> > > > > - Use pci_dev_config_accessible() instead of open-coding the check, and
> > > > >   make it non-static (Farhan)
> > > > > - Move the check before any config space access in the restore
> > > > >   functions (Farhan)
> > > > > - The return value of the PCI Command read is no longer checked, since
> > > > >   the helper only tests for an all-ones value.
> > > > > - Update the subject and commit message accordingly
> > > > > ---
> > > > >  drivers/pci/msi/msi.c | 6 ++++++
> > > > >  drivers/pci/pci.c     | 2 +-
> > > > >  drivers/pci/pci.h     | 1 +
> > > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > > index 8a0133a6a286..2865f73f5ead 100644
> > > > > --- a/drivers/pci/msi/msi.c
> > > > > +++ b/drivers/pci/msi/msi.c
> > > > > @@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
> > > > >  	if (!dev->msi_enabled)
> > > > >  		return;
> > > > >  
> > > > > +	if (!pci_dev_config_accessible(dev, "restore MSI state"))
> > > > > +		return;
> > > > 
> > > > Sigh.  I hate the fact that pci_dev_config_accessible() is
> > > > proliferating even though it's obviously racy.  Maybe it's the best we
> > > > can do, but I just feel like we're digging this hole deeper.
> > > >
> > > Hmm I agree this is racy even though we're holding the device lock
> > > throughout the reset/restore process.
> > > 
> > > I assume you mean something like a separate sources DPC happened and
> > > make the device inaccessible , some scenario like that ?
> > 
> > Yes.  A PCI device can stop responding at any time, e.g., it got
> > physically removed from a slot, a cable was removed, its internal
> > firmware crashed, power failed, etc.
> > 
> > > > Also, this is called in the pci_restore_state() path, which is full of
> > > > other things that also write to config space and will also fail in
> > > > this situation.
> > > 
> > > Actually I was trying to cover the whole pci_restore_state() in v1 [1],
> > > and Benjamin raise the concern about the drivers may depen on PCI state
> > > having been restored by the time reset_done() runs.
> > 
> > I think you're referring specifically to Ben's comment [2] that driver
> > .reset_done() handlers expect that pci_restore_state() has already
> > been completed, and your "[PATCH 3/4] PCI: Skip state restoration when
> > configuration is inaccessible" patch calls .reset_done() without any
> > restoration if the device was inaccessible:
> > 
> >   static void pci_dev_restore(struct pci_dev *dev)
> >   {
> >         const struct pci_error_handlers *err_handler =
> >                         dev->driver ? dev->driver->err_handler : NULL;
> > 
> >  -      pci_restore_state(dev);
> >  +      /* MSI-X restoration may access device MMIO. */
> >  +      if (pci_dev_config_accessible(dev, "restore state"))
> >  +              pci_restore_state(dev);
> > 
> >         /*
> >          * dev->driver->err_handler->reset_done() is protected against
> >          * races with ->remove() by the device lock, which must be held by
> >          * the caller.
> >          */
> >         if (err_handler && err_handler->reset_done)
> >                 err_handler->reset_done(dev);
> > 
> > I think Ben is absolutely right that .reset_done() handlers expect the
> > device to be accessible and config state to have been restored, and I
> > don't think it's reasonable to expect every driver's .reset_done() to
> > handle that generic problem.
> > 
> > I think pci_restore_state() needs to return failure and callers need
> > to figure out how to deal with that.  There are a lot of callers, so
> > it's messy, but we should recognize that it can fail.
> 
> Hi Bjorn,
> 
> Thanks for the suggestion, that makes sense.
> I'm thinking the following for v4 since I got a clearer picture now.
> 
> - Drop MSI/MSI-X specific check and make pci_restore_state() return errno,
>   check whether the device is accessible at the top so we can cover all
>   capabilities

Well, pci_dev_config_accessible() is *always* racy no matter where you
call it, because the device may stop responding at the next
instruction after pci_dev_config_accessible() returns "true".

Checking at the beginning and the end of pci_restore_state() would
cover most cases.

> - Keep calling .reset_done(), and return the restore failure from
>   pci_reset_function(), etc. Driver that touch the device in .reset_done()
>   need their own check

If pci_restore_state() fails, I'm not sure we should call
.reset_done().  What would that mean?  If the device isn't accessible
after a reset, I don't know what else we can do.  Maybe we just unbind
the driver and software-remove the device?

> I am thinking about for .reset_done(), since the core can't just skip it,
> like you said the drivers part can be messy, maybe changing signature to
> 
> void (*reset_done)(struct pci_dev *dev, int status);
> 
> Passing the status from driver side to PCI core and let the core handle it
> generically will be more elegant ?
> 
> Once we decide the approach I can send v4.
> 
> Best regards,
> Richard Cheng.
> 
>  
> > > What my bug actually hit was MSI-X table write triggered DPC, I can't
> > > justify for all kinds of driver, so I limited the scope.
> > > 
> > > If you think a broader check in pci_dev_restore() is a better place to
> > > handle this, I'm happy to give a deeper research and revisit it.
> > > 
> > > Best regards,
> > > Richard Cheng.
> > > 
> > > [1]: https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/
> > 
> > [2] https://lore.kernel.org/all/8a19d63c-db9a-40ab-a811-5d761252638f@amd.com/
> > 
> > > > >  	entry = irq_get_msi_desc(dev->irq);
> > > > >  
> > > > >  	pci_intx_for_msi(dev, 0);
> > > > > @@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> > > > >  	if (!dev->msix_enabled)
> > > > >  		return;
> > > > >  
> > > > > +	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
> > > > > +		return;
> > > > > +
> > > > >  	/* route the table */
> > > > >  	pci_intx_for_msi(dev, 0);
> > > > >  	pci_msix_clear_and_set_ctrl(dev, 0,
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 7c6f2aba8144..671ffe4da1c8 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> > > > >  
> > > > > -static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > > >  {
> > > > >  	u32 val;
> > > > >  
> > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > index 77efa4c5c960..98dd3dbd5edb 100644
> > > > > --- a/drivers/pci/pci.h
> > > > > +++ b/drivers/pci/pci.h
> > > > > @@ -240,6 +240,7 @@ enum pci_mmap_api {
> > > > >  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
> > > > >  		  enum pci_mmap_api mmap_api);
> > > > >  
> > > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
> > > > >  bool pci_reset_supported(struct pci_dev *dev);
> > > > >  void pci_init_reset_methods(struct pci_dev *dev);
> > > > >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > 
