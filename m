Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567940F750;
	Sat,  5 Sep 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602812; cv=none; b=Vh1EV8yQmyzn9lsjh/BcZzkJyY21VHAqbHqC6d++sAQfcLHoDEHcwiUK4nK+ROIZ+ykdpP81c8UPhE6SGRq4qwmZVh+Ws0QksiEfhixhkk8LtAk9TTKAgK9z9r5aEj6tBK5Sx80XhwXJ5LM0mUJlZ6n4wRX86tEo8DEAbOIwiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602812; c=relaxed/simple;
	bh=syCs84ku1/vM8Nv/L6FB+9YKfVBV2XiaEElhQtJGHxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzv53bo0CzI/Dqg6998/XPyfu3h10LbKHi9rtsNduJwnK9Bmz/+Ebo9BQElUCMruQcMd5EhS97QJ1PrAs+K8O+aw7wsspiC3vYY0Y5RbQpZw7SGy30Q93XQirM8tbqGBhmJSCbN/T2lqb5W9u0aYk8DKfyfTC8Y9TsnO5VtMFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id CE09872AB;
	Sat, 05 Sep 2026 12:06:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A2318600D14A; Sat,  5 Sep 2026 12:06:39 +0200 (CEST)
Date: Sat, 5 Sep 2026 12:06:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yury M." <yurypm@arista.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
Message-ID: <apvpr5Q6gu_3MODj@wunner.de>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <apq3kd9_qsURNpKu@wunner.de>
 <6f916404-63b5-40a3-a429-befe42a08629@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f916404-63b5-40a3-a429-befe42a08629@arista.com>

On Fri, Sep 04, 2026 at 04:36:12PM +0100, Yury M. wrote:
> On 9/4/26 13:20, Lukas Wunner wrote:
> > On Fri, Sep 04, 2026 at 11:13:18AM +0000, Yury Murashka wrote:
> > > With a nested PCIe topology with multiple layers of hotplug, a link
> > > can go down near the bottom of the topology shortly before a link
> > > above it goes down. In that case, pcie_wait_for_link_status() can
> > > wait for the full timeout while every read of the link status register
> > > fails because the device has disappeared.
> > > 
> > > Return immediately when reading the link status fails so event processing
> > > can continue.
> > [...]
> > > +++ b/drivers/pci/pci.c
> > > @@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
> > >   	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
> > >   	do {
> > > -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> > > +		if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
> > > +			return -ENODEV;
> > >   		if ((lnksta & lnksta_mask) == lnksta_match)
> > >   			return 0;
> > >   		msleep(1);
> > 
> > It might be clearer if you check for pci_dev_is_disconnected() directly
> > instead of relying on a PCIBIOS_DEVICE_NOT_FOUND return value which is
> > generated as a side effect of the device being gone.
> 
> what to you think about this check:
> 
> if ((pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta) ||
>     PCI_POSSIBLE_ERROR(lnksta)) && pci_dev_is_disconnected(pdev))
> 	return -ENODEV;

It's repetitive because pcie_capability_read_word() already checks
internally for pci_dev_is_disconnected():

  pcie_capability_read_word()
    pci_read_config_word()
      pci_dev_is_disconnected()

I just thought that since you specifically want to bail out in the
hot-removal case, it might be clearer to check pci_dev_is_disconnected()
in pcie_wait_for_link_status() before performing the config space read.

But I don't feel strongly either way and checking the return value of
pcie_capability_read_word() is a viable approach as well.

Thanks,

Lukas
