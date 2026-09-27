Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04130F95C
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535451; cv=none; b=TjYc4btoNg/HpPrp1FlL1hGjb1YA1lNtXFjNBTVM7H7Se7cIh3fG04QQSEFZUPAuveuQjTSrtLPglRXMnRtMwiccvsrz6Md3fo+YpPky4VzD5kkRLonIf7XPzFHXerK2BwOimki317MvSRXjCdQwIvPJzw8ElqR/rIHyOAUwJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535451; c=relaxed/simple;
	bh=QL4C3CRcKgV5kFFgyHF52h06rBPMTdE/DSaT9pV/tug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O23hW22+tLjEyG+0V8QGyJkps3G7X/CuRuu6y4ncsPF2lvBzBVUf9viBYPvI+DwNVIExjDURQthlzjcm0NXOGAQ56vXyi9nqGnwvT28EfkO6VcXbJniQj40wZx3pU4WTMwVatVluhalFMrI9SGGwn9Azi+XGXNdfjf3Z3krZgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 543321D06;
	Sun, 27 Sep 2026 20:57:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DE4B2625294D; Sun, 27 Sep 2026 20:57:27 +0200 (CEST)
Date: Sun, 27 Sep 2026 20:57:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
Message-ID: <arlnF7FsstceeiZ5@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
 <20260927183122.8B3F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927183122.8B3F91F000FF@smtp.kernel.org>

On Sun, Sep 27, 2026 at 06:31:22PM +0000, sashiko-bot@kernel.org wrote:
> > +++ b/drivers/pci/pcie/err.c
> > @@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	return status;
> >  
> >  failed:
> > +	if (host->native_aer || pcie_ports_native) {
> > +		pcie_clear_device_status(dev);
> > +		pci_aer_clear_nonfatal_status(dev);
> 
> [Severity: Medium]
> When pcie_do_recovery() is invoked for a fatal error (pci_channel_io_frozen)
> and recovery fails, will this leave the fatal error bits uncleared?

Generally not.

First of all, the error status bits in the Device Status register are
cleared because in the "pci_channel_io_frozen" case, a reset is performed
unconditionally.  (They are not sticky, i.e. they do not survive a reset.)

Second, the Uncorrectable Error Status register is cleared as well because
the first thing that a driver's ->slot_reset() callback does is generally
a call to pci_restore_state(), which calls pci_aer_clear_status().

Hence explicitly clearing error status bits in the Fatal Error case has
historically been considered unnecessary.  That said, I'm not happy with
how the bits are cleared and consider this patch an interim solution.

In the long run, I would like to clear error bits immediately when a
device is examined in is_error_source() and aer_get_device_error_info(),
and I would like to clear only those bits that have been read.

Right now we may lose error bits that occur in-between reading the register
and later-on clearing it, so this is all somewhat suboptimal.

Thanks,

Lukas
