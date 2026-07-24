Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2043B4AA;
	Fri, 24 Jul 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905330; cv=none; b=BrtA4jGdA7MOlGSnjIny1kHpJTpKzHGpv2rzWq196ZcTLPQPrEboxdj1HyN88e0mDQExd10cx7sMvvCv6D/GqpCXGTNwOqPfI3oMpTT9XQmDmenh8uChfpqL/hqUdWs+FCipG6uRlYgljdzu2RApyH0oU/hN9DhNr4qJSzMaInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905330; c=relaxed/simple;
	bh=o66we11P5gChNne594fX9fgEFp6Z5SXk1WPkO+PAMic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7VGrw6xPy827NexV2zkZ7q2d8LKV2CH2tkxTskfkaB/EuFh8WIXAxwpPg5oEKiYXUrPtjKrrKqE6IyjYlRAkTBL/6Y2Y+B+U8TNFz/Tw04OI9+wwS3Z51cORO4xPUmrocgv6pidphnm/Xtnoi0GQ+xWhL+6tTMol/dEG7Rdtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZvSvSxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZvSvSxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D661F000E9;
	Fri, 24 Jul 2026 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784905329;
	bh=z/mggxsbNrpvroZn7mZ9QBDirWOmig2wFSQsn9S6HIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AZvSvSxeAOjerPg1OxVPnSyJcngvZYxKDPdUu43XJNruR1KSzsMktbCuod3qcq0F0
	 wBo2FAaG03IdWPBXC1TMKb5EpE/AH3XBdUTiscgs01HdlV0W7R72JtDjo43AOkRnNS
	 RBKCdkHcW1a8jzjKtFajPCM2Vh+bVKhR+yiMJt/O8jh8fR16DQegRIowO28mu5ulug
	 81jLCwg7Z4lSAs97LnV+ExZtBH4p4s48kF5e3JXyXLifKkJ0rwhBCkpGp4Nr1Mb4f0
	 dVJzlLOOc0nzirAQNkoJ+ckg1lcbdld2yHeXRv3enK8ZddeGQ9BbMJ9ftp9y86Ujhh
	 E20zLs2LD2l+w==
Date: Fri, 24 Jul 2026 17:02:03 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 3/5] PCI: host-common: Add link down handling for Root
 Ports
Message-ID: <mcdce4u2alwsobdsapnnwjwxofhwrd6gypdu45m3i5wzswhp65@lhrv5tvsvjs7>
References: <20260518-pci-port-reset-v8-3-eb5a7d331dfc@oss.qualcomm.com>
 <20260518170537.357DDC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518170537.357DDC2BCB7@smtp.kernel.org>

On Mon, May 18, 2026 at 05:05:30PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Hardware state desynchronization when CONFIG_PCIEAER is disabled.
> - [Medium] Commit message claims error_detected() callback is triggered for the bridge, but the implementation skips it.
> --
> 
> commit f07cf37e729701c6c67b90c92f65dd76b53b9fec
> Author: Manivannan Sadhasivam <mani@kernel.org>
> 
> PCI: host-common: Add link down handling for Root Ports
> 
> This commit introduces a new API, pci_host_handle_link_down(), for host
> bridge drivers to recover a specific Root Port when a link down event is
> observed. It utilizes pcie_do_recovery() with AER handling if enabled, or
> falls back to pci_bus_error_reset() otherwise.
> 
> > First, the AER error_detected() callback will be triggered for the bridge and then for the downstream devices.
> 
> Is this description accurate regarding the bridge receiving the callback?
> 
> Looking at pcie_do_recovery(), it uses pci_walk_bridge() to trigger the
> recovery callbacks. However, pci_walk_bridge() handles bridges with
> subordinate buses by iterating over devices on the subordinate bus.
> 
> Consequently, the Root Port (the bridge itself) appears to be excluded from
> the callback walk and might not receive the error_detected() callback.
> 

This seems to be a valid concern. portdrv registers the pci_error_handlers() as
well. So we should be calling them.

> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> 
> [ ... ]
> 
> > @@ -106,5 +108,38 @@ void pci_host_common_remove(struct platform_device *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_host_common_remove);
> >  
> > +static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +
> > +	pci_lock_rescan_remove();
> > +	ret = pci_bus_error_reset(dev);
> > +	pci_unlock_rescan_remove();
> > +	if (ret) {
> > +		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> > +
> > +	pci_info(dev, "Root Port has been reset\n");
> > +
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> > +static void pci_host_recover_root_port(struct pci_dev *port)
> > +{
> > +#if IS_ENABLED(CONFIG_PCIEAER)
> > +	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
> > +#else
> > +	pci_host_reset_root_port(port);
> 
> If CONFIG_PCIEAER is disabled, this directly calls pci_host_reset_root_port()
> which performs a bus reset using PCI_RESET_NO_RESTORE via
> pci_bus_error_reset().
> 
> Since pcie_do_recovery() is skipped, downstream device drivers are never
> notified via their error_detected(), slot_reset(), or resume() callbacks.
> 
> Does this leave the hardware configuration space of these devices wiped while
> the bound drivers remain active and unaware?
> 
> If subsequent MMIO accesses by these drivers hit unmapped space and DMA
> fails, could this lead to device lockups or data corruption? Would it be
> safer to hot-remove and rescan the devices instead of blindly resetting the
> bus when AER is unavailable?
> 

That's a design limitation. If CONFIG_PCIEAER is not selected, then
pcie_do_recovery() do not exist. We can call the individual err_handlers()
though, but that will end up somewhat mimicking AER driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
