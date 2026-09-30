Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1263F54AE
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752447; cv=none; b=RdMKJzjoIOUZNUwIdP78k2erHbIIuCfMd6JilvMeVfPRrwV2Z5j06uwaqcnf3ii+OXZB/pnnw8j+lc1LodiGv290/DGSQOXSF3v6yzomE+cvjZpVVf5YAC0P8OgD3EkcPoqzHknCx9WIp4qaf1dhh7B5QFcpoJytnx6xJFQtuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752447; c=relaxed/simple;
	bh=4JjmJ1Qokt0KlgHTt1SwfYQH6CE93oU5RTSOisQ+hXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbOyTktwyE5a272GS+MhU3x5i6LFPHIhsWmCQ2ZNXEx9xcw3WVlaVLwZbVUnJ98YC5clVzO5MbrX57qrSNZohKDDEXTnwnIL4X5e+JQkci1xJ6a9PyR+uMJcUmcPn4XVKlWRkNcMmMqctjUoxFo2yF7iXdDSVW9WYTGmQrGHPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 8560C63B;
	Wed, 30 Sep 2026 09:08:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7385C60C8EF0; Wed, 30 Sep 2026 09:08:24 +0200 (CEST)
Date: Wed, 30 Sep 2026 09:08:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 7/7] PCI/AER: Enable baseline capability error reporting
Message-ID: <ary1aMGD-hqf78L9@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
 <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>

On Tue, Sep 29, 2026 at 02:01:42PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > @@ -431,6 +432,9 @@ void pci_aer_init(struct pci_dev *dev)
> >  					       PCI_ERR_COR_ADV_NFAT, 0);
> >  
> >  	pci_aer_clear_status(dev);
> > +enable:
> > +	if (pcie_aer_is_native(dev))
> > +		pcie_clear_device_status(dev);
> >  
> >  	if (pci_aer_available())
> >  		pci_enable_pcie_error_reporting(dev);
> 
> This also enables error reporting below AER-incapable Root Ports, where
> no AER service handles the ERR_* Messages.  The Root Control System
> Error enable bits are only cleared by aer_enable_rootport(), which
> doesn't run on such ports.  If firmware left them set, the newly
> enabled Messages could result in System Errors.
> 
> Should reporting be enabled only if an AER service (or DPC) is above
> the device?

Excellent observation.  This is a pre-existing issue but I think you're
right.  However it's non-trivial to fix because just checking for DPC
capability in the ancestry or AER capability at the Root Port isn't
sufficient:

For RCiEPs, we'd need to check whether an RCEC exists which has
AER capability.  There's an "rcec" pointer in struct pci_dev which
allows discovering the RCEC responsible for an RCiEP.  But the pointer
is only set when portdrv binds to the RCEC (pcie_link_rcec()).
That's much later than when the RCiEP and its capabilities are enumerated.

When enumerating an RCiEP, we'd need to walk the entire set of PCI devices,
check if it's an RCEC, check if it's responsible for this RCiEP and assign
the rcec pointer.  We could try to avoid that by running pcie_link_rcec()
already on enumeration of the RCEC (and not on probing of portdrv),
but the RCEC may be enumerated after the RCiEP.  User space could also
force an unset rcec pointer by issuing remove/rescan of the RCiEP.

Also, right now when firmware does keep System Error Enable bits in the
Root Control register set, there's a window between endpoints being
enumerated (which enables sending of ERR_* messages) and Root Ports
being bound to portdrv (which clears System Error Enable bits).

Any errors that occur during that window will cause a System Error
right now.

> Or alternatively, clear the Root Control System Error
> enable bits on AER-incapable Root Ports?

I'm worried that users may deliberately enable System Error bits in
BIOS on such systems precisely because there's no other way to catch
them.

Thanks for the thoughtful review, much appreciated!

Lukas
