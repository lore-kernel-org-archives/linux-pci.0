Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5E20C029;
	Thu, 24 Sep 2026 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210853; cv=none; b=jGx+hcicGLU7Og2ROfXGGBZhHPI7l35IgWwX1WnQyHBJ0Nzui3BXtmRxsoYfPLl4UJke442wK2Trc6ZtMHZN++3/4J63k5+skxwzS6iEm9LF2+d6hdgFLjG787mbTVpsFRLHJ5q0cbcmEOmPcjUFlh14+o36pVnATsYjCt3nc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210853; c=relaxed/simple;
	bh=MRHflf9pQlKfYm/MU7RO6JHQQwTgMq9RRkPqv7LT2cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPrix/P991S8QqqZmDnS89bOBCcCUMIGSABQ5ziK6k6QonmkHWpippD4OEQAzFL1hTmJ1C/2t/PfTyZ9c1/erScyg8Pn9Uf7kgBFkZU2rtWviObAkuYKeH6X1zWAy8CasSMyknahzKWu7NqFTOL/iI3ZdsPa9e4PTscCXVwH4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV4beVCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV4beVCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153771F000FF;
	Thu, 24 Sep 2026 00:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210851;
	bh=awHK9SiCfzSBDYiPOU71GG6u6kKKpzEZuYf14gWMxa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gV4beVChD2YFU+25DzK5A4e7H6OhBn+7xBLutWlvIwVKLj/wDn5FZpxLX9ohoCH9h
	 AFfq8wLhcsDWaDoMKplqDFEF8LOQqHJ39a1MJVJAC4gGlvXryfdJvyUUrtSFcKnAkm
	 6GDXIHMai1lrkebpR+4V7fzXGTi3Qn1kx0rUjDkbXKkBOpB+YMcivPhQC+fjV3vhBb
	 cRRft6cuTdDFiZjy0iIJC81FCMf0fMlQSpr7HspBS7ypC4I6DzZY1/un/872rcaXht
	 Tmql0Z9Wr8pePQuRPwNX07hJWoxalAH3xLGoLy9AM76Uz3b57x0ApYysTQe1yjNL+E
	 38IQjY5c48UWA==
Date: Thu, 24 Sep 2026 01:47:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 09/12] cxl: Restore CXL state after PCI reset
Message-ID: <20260924014724.6ca3e59e@jic23-hlaptop>
In-Reply-To: <b7c0facf-f1ec-4108-9a7a-fe5fe8fa594f@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-10-smadhavan@nvidia.com>
	<20260912024332.17a19b2f@jic23-hlaptop>
	<b7c0facf-f1ec-4108-9a7a-fe5fe8fa594f@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:10:07 -0700
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> On 9/11/26 6:43 PM, Jonathan Cameron wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, 10 Sep 2026 07:08:05 +0000
> > Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> >   
> >> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> >> restore cached global and per-decoder HDM state, restore the cached
> >> CXL.cache and CXL.mem enable bits, and then run the normal PCI restore
> >> callbacks.
> >>
> >> If reset clears a previously locked decoder, restore and commit its
> >> programming before reapplying the cached lock. Leave a locked committed
> >> decoder unchanged when that state survives reset.
> >>
> >> Keep the target IOMMU reset block active until CXL state restore completes
> >> so Bus Master Enable cannot reopen DMA before decoder state is valid.
> >>
> >> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>  
> > I'm nearly out of time for today and have given quite a bit of
> > feedback on earlier patches. So this is going to be a scan read
> > at most. Make sure to take another look at this and incorporate
> > the sort of changes I've asked for elsewhere for v13.
> > 
> > This seems to carry on papering over the cracks after errors that
> > to me indicate a broken device.  I don't see any reason to do that.
> > If a device needs quirks to say don't run a particular restore do that
> > but if they are real errors, just give up - your device is not going
> > to be useable with only some stuff restored and you may be making
> > an obvious bug a much more subtle one.
> > 
> > Jonathan
> > 
> >   
> >> ---
> >>   drivers/cxl/core/resource.c | 411 ++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 396 insertions(+), 15 deletions(-)
> >>  
> >   
> >> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
> >> +                                struct cxl_hdm_decoder_state *state,
> >> +                                struct cxl_decoder_settings *settings,
> >> +                                void __iomem *hdm)
> >> +{
> >> +     u32 ctrl;
> >> +     int rc;
> >> +
> >> +     rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id);
> >> +     if (rc == -EBUSY)
> >> +             return 0;
> >> +     if (rc)
> >> +             return rc;
> >> +
> >> +     cxl_restore_hdm_decoder_state(state, hdm, settings->id);
> >> +
> >> +     if (!(settings->flags & CXL_DECODER_F_ENABLE))
> >> +             return 0;
> >> +
> >> +     scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> >> +             rc = cxl_commit_start(hdm, settings);
> >> +     if (!rc)  
> > 
> > Use a helper function for the stuff in here so you can return directly.
> >   
> >> +             rc = cxl_commit_wait(hdm, settings);
> >> +     if (rc)
> >> +             pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> >> +                     settings->id, rc);
> >> +     else if (settings->flags & CXL_DECODER_F_LOCK) {
> >> +             ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
> >> +             ctrl |= CXL_HDM_DECODER0_CTRL_LOCK;
> >> +             writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
> >> +
> >> +             ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(settings->id));
> >> +             if (PCI_POSSIBLE_ERROR(ctrl) ||
> >> +                 !(ctrl & CXL_HDM_DECODER0_CTRL_LOCK)) {
> >> +                     pci_err(pdev,
> >> +                             "CXL HDM decoder %d failed to restore lock\n",
> >> +                             settings->id);
> >> +                     return -EIO;
> >> +             }
> >> +     }
> >> +
> >> +     return rc;
> >> +}  
> >   
> >> +
> >> +static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
> >> +                                               u16 *command)
> >> +{
> >> +     u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
> >> +
> >> +     pdev->saved_config_space[PCI_COMMAND / 4] &= ~PCI_COMMAND_MASTER;
> >> +     pdev->saved_config_space[PCI_COMMAND / 4] |= PCI_COMMAND_INTX_DISABLE;
> >> +     pci_restore_state(pdev);
> >> +     pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
> >> +     *command = saved_config & 0xffff;
> >> +}
> >> +
> >> +static int cxl_restore_state(struct pci_dev *pdev)
> >> +{
> >> +     struct cxl_hdm_info *snap = cxl_snapshot_hdm(pdev);  
> > __free(kfree); looks like it will make life simpler in here.
> > 
> >   
> >> +     bool restore_command = false;
> >> +     void __iomem *hdm;
> >> +     int first_rc = 0;
> >> +     u16 command;
> >> +     int rc;
> >> +
> >> +     if (!snap)
> >> +             return 0;
> >> +     if (IS_ERR(snap))
> >> +             return PTR_ERR(snap);
> >> +
> >> +     rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
> >> +     if (rc) {
> >> +             kfree(snap);
> >> +             return rc;
> >> +     }
> >> +
> >> +     hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar,
> >> +                                       snap->hdm_offset, snap->hdm_size);
> >> +     if (IS_ERR(hdm)) {
> >> +             first_rc = PTR_ERR(hdm);  
> > 
> > I'm not really understanding the keep trying and paper over the cracks
> > going on here.  If almost any of these fail it looks to me like
> > we are in a bad place and it would be cleaner to report and give up.
> > 
> > I restored 'some state' isn't likely to be very useful to anyone
> > beyond maybe making the breakage subtle rather than major and easy
> > to find.
> > 
> >   
> >> +     } else {
> >> +             /*
> >> +              * Restore global HDM control before per-decoder commit. PCI
> >> +              * config memory decoding is enabled for MMIO access, but bus
> >> +              * mastering remains disabled until HDM restore completes.
> >> +              */
> >> +             writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> >> +
> >> +             for (int i = 0; i < snap->decoder_count; i++) {
> >> +                     rc = cxl_restore_hdm_decoder(pdev,
> >> +                                                  &snap->decoder_state[i],
> >> +                                                  &snap->settings[i], hdm);
> >> +                     if (rc && !first_rc)
> >> +                             first_rc = rc;
> >> +             }
> >> +
> >> +             /* Flush posted HDM writes before PCI_COMMAND can restore BME. */
> >> +             readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> >> +             iounmap(hdm);
> >> +     }
> >> +
> >> +     if (!first_rc && snap->dvsec_ctrl_valid) {
> >> +             rc = cxl_restore_dvsec_ctrl(pdev, snap->dvsec_ctrl);
> >> +             if (rc)
> >> +                     first_rc = rc;
> >> +     }
> >> +
> >> +     if (restore_command) {
> >> +             rc = cxl_hdm_restore_command(pdev, command);
> >> +             if (rc && !first_rc)
> >> +                     first_rc = rc;
> >> +     }
> >> +
> >> +     kfree(snap);
> >> +     return first_rc;
> >> +}  
> >   
> 
> Hi Jonathan, this patch is now v13's patch 13:
> 
>    - moved the commit-under-DPA-lock operation into a helper that returns
>      the result directly;
>    - stop restoration at the first error instead of continuing with
>      partially restored state
>    - leave the PCI command state disabled when restoration fails, 
> preventing the outer PCI path from re-enabling an incompletely restored 
> device.
> 
> The snapshot is now taken by the reset caller before reset rather than 
> allocated inside cxl_restore_state(). I kept its cleanup explicit 
> because the caller has staged goto-based cleanup for the snapshot, range 
>   reservations, IOMMU state, and cache policy.
> 
> https://lore.kernel.org/linux-cxl/20260922083924.2451158-14-smadhavan@nvidia.com/
Hi. For future replies, put the specific items inline with the feedback they
are resolving and aggressively crop out anything that doesn't need to be in the
reply. In particular any feedback that you've accepted and will role into
next version. 

That keeps the focus on the stuff you want to discuss and not on the stuff
everyone is agreed on.

I'm not sure if I missed any discussion points in here :(

Jonathan

> 

