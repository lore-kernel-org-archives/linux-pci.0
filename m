Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA383C09EE
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160525; cv=none; b=HAdBu43fX58cAU9itlAHM/tmO9cBo1/J4xHE+JastTQCBuIoN592BMOvI0FxX830XKITce3oSz9E3BQoyG744rldFi4pzLsVG0IzUjs2sB5YvCWht9jHq3ArbIXCCAgKeHQO0eipH22X9HnV1yCgz52jK7uFYpjBC5/5qvTIdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160525; c=relaxed/simple;
	bh=uXD1hdfvLSYCqX/GKP2JXWRJNXOdFYAmXwPM53Vwd2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJLxchrmuYq2JP5nWWS1zuTULgjlCvmn6ZGVGDhZgGx0+DjxlR3GBnXzfvk9bK3GJ0nDSxPwImzgSBPPSWZ+Prnu6/n2JzKdquWxEtNyRpfuDG7rxb4ViiG7OjQZxiSPfZ1f7ZZAgSguM3zQNjiUBBjwmkHnz6KcnTHFg312wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3639EC18;
	Mon, 27 Jul 2026 15:55:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 042EB60CDD18; Mon, 27 Jul 2026 15:55:20 +0200 (CEST)
Date: Mon, 27 Jul 2026 15:55:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Matthew W Carlis <mattc@purestorage.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 6/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <amdjR8LqIY0YmiG4@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <1b62915ffe06ee5b08e846531c42392e5f244337.1784905909.git.lukas@wunner.de>
 <20260724162755.DDA801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724162755.DDA801F000E9@smtp.kernel.org>

On Fri, Jul 24, 2026 at 04:27:55PM +0000, sashiko-bot@kernel.org wrote:
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -410,6 +424,15 @@ void pci_aer_init(struct pci_dev *dev)
> >  	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
> >  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
> >  
> > +	/*
> > +	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
> > +	 * 7.8.4.6).
> > +	 */
> > +	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
> > +		pci_clear_and_set_config_dword(dev,
> > +					       dev->aer_cap + PCI_ERR_COR_MASK,
> > +					       PCI_ERR_COR_ADV_NFAT, 0);
> 
> [Severity: High]
> Does this code modify the AER Correctable Error Mask register unconditionally
> without checking pcie_aer_is_native(dev)?

Yes, that's a valid point.

> > @@ -916,8 +997,20 @@ void aer_print_error(struct aer_err_info *info, int i)
> >  
> >  	__aer_print_error(dev, info);
> >  
> > -	if (info->tlp_header_valid)
> > +	if (info->tlp_header_valid && info->severity != AER_CORRECTABLE)
> >  		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
> > +
> > +anfe:
> > +	/* Recursive invocation for Advisory Non-Fatal Errors */
> > +	if (info->anfe_status && info->severity == AER_CORRECTABLE) {
> > +		info->severity = AER_NONFATAL;
> > +		info->status = info->anfe_status;
> > +		info->mask = 0;
> > +
> > +		aer_print_error(info, i);
> 
> [Severity: Medium]
> Will this recursive call operate with the stale info->level and
> info->ratelimit_print[i] state?

That's intentional.  I want the (Advisory) Uncorrectable Errors to be
reported with the same loglevel and ratelimiting as the accompanying
Correctable Error.

However while native AER handling does this the way I want it to,
I missed that Firmware First does not.  It uses the loglevel and
ratelimiting of (non-Advisory) Uncorrectable Errors.  So that's
something I'll have to fix.

> [Severity: High]
> This is a pre-existing issue, but can this cause a PCI device reference leak
> if the hardware error status changes between loops?
[...]
> If the hardware or firmware clears the error status after the first loop but
> before the second loop reads it, aer_get_device_error_info() returns 0. The
> second loop will skip the handler, and the pci_dev reference is permanently
> leaked.

Hallucination.  If hardware or firmware clears error bits behind our back,
it would be broken.  

> [Severity: High]
> This is a pre-existing issue, but does this create a TOCTOU race window for
> newly arriving hardware errors?
> 
> drivers/pci/pcie/aer.c:aer_process_err_devices() {
>     ...
> 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> 		if (aer_get_device_error_info(e_info, i))
> 			aer_print_error(e_info, i);
> 	}
> 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> 		if (aer_get_device_error_info(e_info, i))
> 			handle_error_source(e_info->dev[i], e_info);
> 	}
>     ...
> }

It's a valid point and already on my todo list, but not something
I want to fix as part of this series.  The duplicate invocation of
aer_get_device_error_info() is not only susceptible to a TOCTOU race,
but also very inefficient.

> [Severity: Medium]
> This is a pre-existing issue, but does this code cause a memory leak of the
> dynamically allocated aer_capability_regs when the recovery queue overflows?
> 
> drivers/pci/pcie/aer.c:aer_recover_queue() {
>     ...
> 	else
> 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
> 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>     ...
> }
> 
> In the GHES subsystem, memory for struct aer_capability_regs is allocated from
> ghes_estatus_pool and passed as a pointer to aer_recover_queue(). If the
> bounded aer_recover_ring kfifo is full, it prints an overflow error and returns
> without freeing the memory.
> 
> The aer_regs pointer is abandoned and the memory is permanently leaked, as it
> is only freed on the success path inside aer_recover_work_func().

It's a valid point, I've added that to my todo list.

> [Severity: High]
> This is a pre-existing issue, but can this lead to data corruption when
> decoding concurrent Machine Check Exceptions due to an unprotected global
> buffer?
> 
> drivers/acpi/acpi_extlog.c:extlog_print() {
>     ...
> 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
> 	/* clear record status to enable BIOS to update it again */
> 	estatus->block_status = 0;
> 
> 	tmp = (struct acpi_hest_generic_status *)elog_buf;
>     ...
> }
> 
> The ACPI extended log driver allocates a single global buffer elog_buf. The MCE
> decoder callback unconditionally copies the new MCE event payload into this
> global buffer without any locks. 
> 
> Since Machine Check Exceptions can trigger concurrently across different CPUs,
> concurrent executions of the MCE handlers will simultaneously overwrite
> elog_buf, corrupting the data structures being parsed.

I'm not familiar with MCE handling, I'll have to ask internally whether
that's a valid finding.

Thanks,

Lukas
