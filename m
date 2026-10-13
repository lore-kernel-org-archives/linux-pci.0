Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235A5452A0;
	Tue, 13 Oct 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925253; cv=none; b=Wa0z4FB5Mml5uDe+xYZEZcokoONUCcRzzPvwSyt1geiFPCk1RD/Go27X7IGhDXjqlXdnDmqXQhWT5HiAdyQGW2JCqzBler5Cx3o4AyTvy75hAQTORb8tDUs8CYzT2joIYySXvGgHPaesyqU/K1oQ8UU5H5HrCqQuS8Ykz2A9JZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925253; c=relaxed/simple;
	bh=d1n5rtMRFSkov/Jat5z6yxh7sPCeCASqFmvPurp7Ob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY15uat0DfFk5Qq02z+bCOdOjg7IJRKqV5vX0Z9HyOwe/K+v22SKZhyYAXbBrnRMCq1YKW3gYEvWTu6lePjtt2iDdBk3DLjYoXq3GGKbWln6dJ2eiBfpdEBRkTAx6E+HRWSDQb8g0sweafJpi7fLMlxIPU++uFcgCPc/b7/RjqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfSoUrws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfSoUrws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847491F000FF;
	Tue, 13 Oct 2026 21:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925252;
	bh=Zr0j98oZUTk+CQ5hg8gqJ3FDcthzN01fo7cNQzUKDa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfSoUrwsDZYSrs9df+DhHndiC85y5+LLGO0Np/JxxVxEQGorOI8AiTl4/6jIdABLy
	 htWCWBt/2TLE+3JB43hVuTAb7Gf866iDXyL+01ct6ECQyIFzGUswx7sDFfWuDCCTLU
	 SHd1+aIJujIdUq5SXUAcNwuyoZls9xzofVXK1waM7UtdjlvTzEm1ncNh5O+t4GXTub
	 ErqDbVD/IksmHOeOxyRwzHuw0TFC8MLgMxryUuQE+xQJCOfRZYvklAr9CcMhRKjber
	 ggx3VjSTYP00LH6zAMmsrAuW4bW12ZL+jGmYFQ43ArOxrgL/RqAvmZDf78+cPDhRnw
	 73A6SCtqkdwhw==
Date: Tue, 13 Oct 2026 23:00:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Update saved Max Read Request Size in
 pcie_set_readrq()
Message-ID: <as6b-w_aqSC8pqkK@ryzen>
References: <20261013195307.181647-2-cassel@kernel.org>
 <sashiko-outbox-170438@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170438@kernel.org>

On Tue, Oct 13, 2026 at 08:05:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pci: Data race in pcie_set_readrq() corrupts hardware and saved state
> --
> 
> commit 5cff2e9dcd50378ba11b9189a892c4623d8503cd
> Author: Niklas Cassel <cassel@kernel.org>
> 
> PCI: Update saved Max Read Request Size in pcie_set_readrq()
> 
> This commit updates pcie_set_readrq() to also modify the kernel's saved copy
> of the Device Control register when changing the Max Read Request Size. This
> ensures that pci_restore_state() restores the intended MRRS value after a
> device reset or error recovery.
> 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5944,8 +5944,12 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >  
> >  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >  						  PCI_EXP_DEVCTL_READRQ, v);
> > +	if (ret)
> > +		return pcibios_err_to_errno(ret);
> >  
> > -	return pcibios_err_to_errno(ret);
> > +	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_READRQ, v);
> 
> [Severity: Medium]
> Can this introduce a data race when called concurrently?
> 
> Looking at the newly added pcie_update_saved_devctl(), it performs an
> unlocked read-modify-write on the saved state memory:
> 
> drivers/pci/pci.c:pcie_update_saved_devctl() {
>         ...
>         devctl = (u16 *)&save_state->cap.data[0];
>         *devctl = (*devctl & ~clear) | set;
> }
> 
> Both the hardware register write via pcie_capability_clear_and_set_word()
> (which drops to the unlocked variant for PCI_EXP_DEVCTL) and this new state
> update appear to happen without synchronization.
> 
> Concurrent access seems possible via VFIO, which allows parallel lockless
> pwrite() calls to the PCI Express capability region. This routes through:
> 
> vfio_device_fops_write()
>   vfio_pci_core_write()
>     vfio_exp_config_write()
>       pcie_set_readrq()
> 
> Could concurrent user-space writes corrupt both the hardware register and the
> cached state memory, causing pci_restore_state() to mistakenly restore
> invalid state later?

No.  As far as I can tell, concurrent pcie_set_readrq() calls on the
same device are only possible via VFIO, when user space races config
writes to Device Control of its own device.  That path already does
unlocked read-modify-writes of the same register in
vfio_default_config_write(), and pcie_cap_lock does not cover Device
Control, so that race is not new.

pcie_update_saved_devctl() only modifies the MRRS field of the saved
copy, with an aligned 16-bit store, so the worst case is that the saved
MRRS is the value of the other racing write, which also passed the
checks in pcie_set_readrq().  The saved state cannot become invalid.
Also, vfio-pci never restores the live saved state without first saving
it or loading its own stored copy.

The already queued patch "PCI: Update saved Max Payload Size in
pcie_set_mps()" is not affected: VFIO virtualizes MPS and never calls
pcie_set_mps(), and all other callers run during enumeration or from a
driver's probe().

So I don't think either patch needs additional locking.


Kind regards,
Niklas
