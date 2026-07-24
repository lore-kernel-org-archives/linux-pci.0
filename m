Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A431D366;
	Fri, 24 Jul 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904879; cv=none; b=nt1rUEWdYy2CPnJszr9D+M8Ufa3+TQcSj8iM5KtuVptIYIPfFh98z/HqNwmMbqfmSz3sNUbXzu8+yd22Rcm5y6CJr1BiAgu+x3R86ui9AyZ/NSKap9NcdFnzo5YN+Pug6YIJB5AffXSxX/Vi6HtUbUOMdvBagBAND68nTt6P0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904879; c=relaxed/simple;
	bh=bvs374BYOrufsAD11iatUF1u/fIIPW4gb3wkuLye2m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJVswjEUjo6gbV5KZaE4xUcNRh8/qOltwcOQGoheK/VaHfgjgr8n6mzi2E4caTDTUxfnnOAj+KCx10rsgZsrgqwOBsEjvNmulIAMp4j5k4F+qlp8afyXALag5wOm9f3U2l95A+0mE/FvOZxyQ7F7uuIOyPMWuCCFePJQ9DNaQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX4YalWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX4YalWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DCE1F000E9;
	Fri, 24 Jul 2026 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904874;
	bh=ULGXxvxs9ke/7Gl1iHnpY/tnoLFCsWGp38S1Uw+duI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OX4YalWpMmRQZu6EoBqPgBn2fGjJF9Qr3hfG7J4fIWIvBQPEyE76+AIP8UDjgfaJL
	 sil5vKwr0tU1y9H6iTggOh0nHxlj4Y8U/LC9X8l5bpl7bJMFDWSDd579cWgtMRhpcS
	 S2A0Us/XStxIB+rCnzVzqoqz6NdC7XVaVjzHm5JkcrsgVkE/OK2Pm4JjdKgZJ5PnC6
	 frHNtSbklBabYhCKBQIHTwxJcjkoeQ1eGoHsqD7d2JLOeMaJSYzMTPlWb6r3OiTtWY
	 IbN5/KOklqaIcL5iMnnh32Q5qFK1uG3gLQtabPoQIsD3QE9j4SExeWADW0MNgXse+2
	 Z42cWL/abMOPg==
Date: Fri, 24 Jul 2026 16:54:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI/ERR: Add support for resetting the Root Ports
 in a platform specific way
Message-ID: <4xejyx6zttyq55xz7xgvehh37wgnv7pajsc666a5ysoprwkanj@yu5wkwlqiisu>
References: <20260518-pci-port-reset-v8-2-eb5a7d331dfc@oss.qualcomm.com>
 <20260518162739.D246EC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518162739.D246EC2BCC6@smtp.kernel.org>

On Mon, May 18, 2026 at 04:27:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing pci_save_state() before the Root Port reset, leading to restoration of stale or uninitialized configuration space.
> - [Medium] Silent failure and bypassed fallback when the platform-specific reset_root_port() fails.
> --
> 
> commit b100b0c0e31e848c799fc6d648ef37421c08fb9f
> Author: Manivannan Sadhasivam <mani@kernel.org>
> 
> PCI/ERR: Add support for resetting the Root Ports in a platform specific way
> 
> This commit adds a reset_root_port callback to pci_host_bridge to allow
> platform-specific root port resets during error recovery. It calls this
> from pcibios_reset_secondary_bus() if available, attempting to save and
> restore the configuration space across the reset.
> 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8f7cfcc000901..651505b3bd60e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4809,6 +4809,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> >  
> >  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> >  {
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +	int ret;
> > +
> > +	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
> 
> The commit message says "save the Root Port config space before reset and
> restore it afterwards". Should there be a call to pci_save_state() here
> before initiating the reset?
> 
> If the state is never saved immediately prior to the reset, won't
> pci_restore_state() restore whatever state was last saved in
> dev->saved_config_space (e.g. from probe or suspend)?
> 

False positive. PCI core now calls pci_save_state() for all devices.

> > +		ret = host->reset_root_port(host, dev);
> > +		if (ret)
> > +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> > +		else
> > +			pci_restore_state(dev);
> > +
> > +		return;
> 
> If host->reset_root_port() returns an error, the function returns early
> without doing the standard reset or propagating the error (since the
> function returns void).
> 
> Will this cause callers to falsely assume the reset was successful?
> 
> Should this fall through to the standard pci_reset_secondary_bus() if the
> platform-specific reset fails?
> 

False positive. If the reset_root_port() callback fails, then there is no use of
trying pci_reset_secondary_bus(). Also, the caller will catch the recovery issue
in pci_bridge_wait_for_secondary_bus().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
