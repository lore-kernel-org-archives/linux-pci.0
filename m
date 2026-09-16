Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505E4FC8FA;
	Wed, 16 Sep 2026 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602646; cv=none; b=kAvflkKMgxx+1PL9sPlF2NqPbbChA/H3gYWt3BYggQIn+2LCTnFSV5DcSFV9KkWwe7R5kg96pfQ5PkPkT2pcjOWzcGz1PbArQC4AWe34wtnRftjdjMZL9Hg6yOESioIJ8FNiGiER5SLZ46RvEn8gF4U7P38twIbAft8H/0LlG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602646; c=relaxed/simple;
	bh=u+p8FYdERtHvWVdvcSRK+cc0hWiqKjs0X/9In5eYdvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z+YItmOaAwMtOuPIPIww1TiuGZG5YZZ/3yidvoxHdesGu6xUrEoxIRBJ2zjNFkD5b54QyaOfA1j9jdhZ4E3XefYm1E5TXzXyvPZEY1VFiSbfrhOT5poY0oAZjdZVGkfZyklWgVklfWy0TpNxPpNXZv3a3PRLxK4x/Ug9P0RzKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNDtz1Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNDtz1Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F771F000FF;
	Wed, 16 Sep 2026 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602643;
	bh=qPjQBnx2tCtJDcZHN3jf4v80iQiouYB15DSXdllYse8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=KNDtz1Rd8L8ybHdH2AUatFHyZFrKaabo/nWl7GwdrwsktV+0VCNdmH5sdmnQDqlCy
	 PQk1Bo4tRWYYCVppruPNGHV8yXBfgLO/uU1AnCYBiHF+Nr9MMLQOPdzJwJO0pwosn1
	 NfXI2B9gvaRRbQPiwJNLqS4uq/WlMStkiHT1Gz/IO7kl4jcmHQjWtuJy8SL5/Ud/hf
	 xgduxSbvCIOZ+sOEpsevR2csnaXeu37YVe5e8IXBQMcaPd1d5QGpgQ4qW/vRVW5Vmh
	 CyOFdO2lt4JxqcIikCTiKhi3yX9y0DMcdpVBcLb1M7okbv3H/hyr2yJJLovPWXg0Fo
	 5WEtIl1deHiDA==
Date: Wed, 16 Sep 2026 18:50:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260916235041.GA989143@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQv0jJdT4xq6VWu@google.com>

On Fri, Sep 11, 2026 at 04:44:02PM +0000, David Matlack wrote:
> On 2026-09-10 06:48 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
> > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > it to participate in the preservation of PCI devices across Live Update.
> > > Essentially, this commit enables the PCI core to allocate a struct
> > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > one device is preserved.
> > 
> > I assume pci_ser is the state the PCI core needs to preserve across
> > kexec so the new kernel's enumeration doesn't interrupt the device
> > operation.  And that whatever state the endpoint drivers need to
> > adopt/inherit the device in the new kernel is managed without any help
> > from the PCI core?
> 
> Yes.
> 
> > > Preserving PCI devices across Live Update is built on top of the Live
> > > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > > expected to expose a file to userspace to represent a single PCI device
> > > and support preservation of that file. This is intended primarily to
> > > support preservation of PCI devices bound to VFIO drivers.
> > 
> > Where do drivers expose this file?  sysfs?  I guess it's a file per
> > preserved device?  Thinking like a driver writer, I'm expecting a hint
> > about how to expose this file (should also be in the file doc somehere
> > if it's not already).
> 
> There is no requirement about how drivers do this from the PCI core
> perspective. For all intents and purposes, the VFIO PCI variant drivers
> are the only drivers that are going to be supported in the next 1-2
> years. They expose a misc character device for each file.

If this file isn't relevant to the PCI core, maybe we don't need to
mention it here.  It doesn't seem like it motivates this patch.

> > > This commit enables drivers to register their liveupdate_file_handler
> > > with the PCI core so that the PCI core can do its own tracking and
> > > enforcement of which devices are preserved.
> > > 
> > >   pci_liveupdate_register_flb(driver_file_handler);
> > >   pci_liveupdate_unregister_flb(driver_file_handler);
> > 
> > So a driver calls pci_liveupdate_register_flb() once, then
> > pci_liveupdate_preserve() once for each device it wants preserved?
> 
> Yes
> 
> > > When the first file (with a handler registered with the PCI core) is
> > > preserved, the PCI core will be notified to allocate its tracking struct
> > > (pci_ser).
> > 
> > The passive voice here makes the actors a bit obscure.  I guess a
> > LIVEUPDATE_SESSION_PRESERVE_FD ioctl on some per-device file kicks
> > this off?
> 
> Yes. (And I will reduce the passive voice in the next version.)
> 
> > I guess the pci_ser allocation is in
> > pci_liveupdate_flb_ops.preserve(), i.e., pci_flb_preserve()?
> 
> Yes.
> 
> > So the PCI core tracker (pci_ser) isn't actually allocated at the time
> > of pci_liveupdate_register_flb(); it's allocated on the first
> > LIVEUPDATE_SESSION_PRESERVE_FD ioctl for a driver that has called
> > pci_liveupdate_register_flb()?
> 
> Yes. The first device that gets preserved triggers the allocation of
> struct pci_ser. And the last device that gets unpreserved (preservation
> cancelled) triggers the freeing of struct pci_ser.
> 
> > IIUC the call tree for that ioctl looks something like this:
> > 
> >   <driver>
> >     pci_liveupdate_register_flb
> >       liveupdate_register_flb(fh, &pci_liveupdate_flb)
> > 
> >   luo_session_ioctl
> >     op = &luo_session_ioctl_ops[...]
> >     op->execute                               # eg luo_session_preserve_fd()
> >       luo_session_preserve_fd
> >         luo_preserve_file
> >           luo_flb_file_preserve
> >             luo_flb_file_preserve_one
> >               if (outgoing_count == 0)        # only for first FLB device
> >                 flb->ops->preserve            # eg pci_flb_preserve()
> >                   pci_flb_preserve
> >                     ser = kho_alloc_preserve  <-- alloc pci_ser
> >                 outgoing.count = 1
> >           fh->ops->preserve                   # something not included here

So IIUC this part of the path looks like this, which answers my
question below about ordering of pci_ser and
pci_liveupdate_preserve():

              fh->ops->preserve                   # eg vfio_pci_liveupdate_preserve()
                vfio_pci_liveupdate_preserve
                  pci_liveupdate_preserve
                    pci_liveupdate_preserve_device
                      dev_ser = pci_flb_alloc_dev_ser  <-- alloc per-dev PCI core serialized state
                      dev_ser->bdf = pci_dev_id(dev)

> > Seems like kind of an awkward way to allocate pci_ser.  Couldn't it be
> > allocated on the first call to pci_liveupdate_register_flb()?  That
> > would be a lot easier for driver writers to trace through.
> 
> I agree the LUO FLB API is a bit awkward, but this is how it works.
> 
> If we allocated it during pci_liveupdate_register_flb() we would then
> need to stash it in a global variable to hand-off the LUO later. Despite
> the awkwardness of FLBs, it is useful to avoid globals and have LUO
> management the lifetime.

It seems like pci_ser is a singleton by design, so a global variable
doesn't sound like it would be terrible to me.

> > > When the last file is unpreserved (i.e. preservation
> > > cancelled) the PCI core will be notified to free struct pci_ser.
> > 
> > There's a lot going on behind "PCI core will be notified".  I assume
> > these refer to the first-time behavior of luo_flb_file_preserve_one()
> > and last-time behavior of liveupdate_flb_put_outgoing(), which is
> > honestly kind of hard to suss out.

Could we say something specific and PCI-related here, to help connect
the dots?  Most of these paths are outside the PCI core.

IIUC luo_session essentially has a refcount (outgoing.count)
incremented by each LIVEUPDATE_SESSION_PRESERVE_FD ioctl, and the 0->1
transition in luo_flb_file_preserve_one() ends up calling
pci_flb_preserve(), where pci_ser is allocated.

And the refcount is decremented by luo_flb_file_unpreserve() (in a
luo_session .release() function), where the 1->0 transition in
liveupdate_flb_put_outgoing() calls pci_flb_unpreserve() where pci_ser
is deallocated.

That gets into a lot of detail, probably too much for a commit log.
Maybe mentioning the function names by which the PCI core is notified
to alloc/free pci_ser would be enough of a bread crumb.

> > This series doesn't include a caller of pci_liveupdate_preserve() (or
> > pci_liveupdate_register_flb()), so I can't figure out the ordering.
> > Obviously pci_liveupdate_register_flb() must be first.
> 
> In every version of this patch series I have sent I included a link to
> the vfio-pci driver changes that build on top of this, rebased that
> series on top of this one, uploaded it to my GitHub, and included a link
> in the cover letter. Here is the relevant section from the v8 cover
> letter:
> 
> . This series was tested in conjunction with v5 of the VFIO PCI driver
> . series:
> .
> .   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
> .
> . The full set of patches used for testing can be found on GitHub.
> .
> .   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio
> 
> 
> > I first thought pci_liveupdate_preserve() would be called via the
> > fh->ops->preserve() in the luo_session_preserve_fd() ioctl path, but
> > it's not.  pci_liveupdate_preserve() is intended for the driver to
> > call it directly.  But it looks like it has to be called *after* the
> > ioctl?  Obviously I'm confused :)
> 
> It is called by the driver during it's fh->ops->preserve() callback. In
> other words, it is called during the ioctl by the driver.

I think the updated call tree above shows the connection?

> LUO just knows that a file has been preserved and what preserve()
> callback it needs to run to preserve that file. It is has no idea which
> files correspond to devices or which devices. The file could be a memfd
> for all LUO knows. That's why the driver has to call into the PCI core
> via pci_liveupdate_preserve() to let it know that a device is being
> preserved, and which.
