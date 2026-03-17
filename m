Received: from mout38.gn-server.de (mout38.gn-server.de [87.238.197.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18F2BCF68;
	Tue, 17 Mar 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.238.197.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739729; cv=none; b=stlt7LFThBiEMhZ4W/t5jnSPbpPilwLQ2yvgfiBwcmI6MB6kL3oEo+UJbM4B9kkfMUXrPNCcCXWVkXplCJ+OIEKLmEjHwr4I+nfNQUgtMXNH7zI0eBAjhEF7G7tW4petFSn7yCA1dv2E6Xf6NZ63vXJiA0vIUbo4BNcUvjKqwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739729; c=relaxed/simple;
	bh=KWJsFa8ByIVm7t4l5tm/eQC/OLnn+mjzZCLjUVrunLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWDvfhkdOynsf+FUY33Cenr8b6uAdzP4GF4bezrUUvlaWEIR+RE+YPTBosL1caoBeZeI2pZMl0vSSkDVpFseDMNJOnCw/uC5pV+Jxckkfu7pP5sU5e2B1wAL1znQoFF7xPm8PIll4UjE13X/NZBEqPggRnRXfry8DF4TDFrmNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org; spf=pass smtp.mailfrom=mageta.org; dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b=E2EPffEB; arc=none smtp.client-ip=87.238.197.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mageta.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b="E2EPffEB"
Received: from mout17.gn-server.de ([87.238.194.244])
	by mout38.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1w2QJO-0003OR-2c;
	Tue, 17 Mar 2026 09:02:02 +0000
Received: from lc0.greatnet-hosting.de ([178.254.50.20])
	by mout17.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1w2QJM-0005lw-2M;
	Tue, 17 Mar 2026 09:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=lc0.greatnet-hosting.de; s=rsa1; t=1773738120;
	bh=KWJsFa8ByIVm7t4l5tm/eQC/OLnn+mjzZCLjUVrunLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2EPffEBSHSHR4HmdFQr+yIlWyWmQPV6dDbA79pkDBlekiL4/geU+Gq/Iy+BWX8Ar
	 M/eaRX81yTbuH2h9xZYTHtjVjqwZKNHK50Fgi6AC4h20KTJpQnlE+HFq33ocsnTJZb
	 qmk5VcwEGyR0e7NsLcAgMK2yAgor0ckeJ8O+mcJ83IujOiyk8bUuLRpfYX5CZSZoJh
	 KwLXRCr2DCj0aco+hoWFGzr+dPCqW3A3yFAVU7fFUL/K7zu66QvgW9XtscxT4Du17z
	 YRJd2cMRBGLiGqt54ECZCqdyo5ONFqps4SemWvbXB7CsYbvUzZTN1b4/2jADwovhPy
	 1Tu7dN8nKgZ3g==
Received: from chlorum.ategam.org (ategam.org [88.99.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: work@mageta.org)
	by lc0.greatnet-hosting.de (Postfix) with ESMTPSA id CF81AE58AFD;
	Tue, 17 Mar 2026 10:01:59 +0100 (CET)
Date: Tue, 17 Mar 2026 10:01:49 +0100
From: Benjamin Block <lkml@mageta.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ionut Nechita <ionut.nechita@windriver.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <20260317090149.GA3835708@chlorum.ategam.org>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
User-Agent: Mutt/2.3 (50e3b1f3) (2026-01-25)
X-GN-Spam: 
X-GN-Spam-Score-INT: 40
X-GN-Spam-Report: Action: soft reject
 Symbol: ARC_NA(0.00)
 Symbol: R_SPF_ALLOW(0.00)
 Symbol: RCVD_NO_TLS_LAST(0.00)
 Symbol: IP_SCORE(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: GREYLIST(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: R_DKIM_ALLOW(0.00)
 Symbol: RCPT_COUNT_TWELVE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: ASN(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: RBL_SPAMHAUS_XBL_ANY(4.00)
 Symbol: DMARC_NA(0.00)
 Message: (SPF): spf allow
 Message: Try again later
 Message-ID: 20260317090149.GA3835708@chlorum.ategam.org
X-GN-Spam-Score: 4.0 (++++)

On Mon, Mar 16, 2026 at 06:57:53PM -0700, Guenter Roeck wrote:
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 7de5b18647beb69127ba11234fb9f1dec9b50540..4a659c34935e116dd6d0b4ce42ed12a1ba9418d1 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> >  
> >  	if (num_vfs == 0) {
> >  		/* disable VFs */
> > +		pci_lock_rescan_remove();
> >  		ret = pdev->driver->sriov_configure(pdev, 0);
> > +		pci_unlock_rescan_remove();
> >  		goto exit;
> >  	}
> >  
> > @@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
> >  		goto exit;
> >  	}
> >  
> > +	pci_lock_rescan_remove();
> >  	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> > +	pci_unlock_rescan_remove();
> >  	if (ret < 0)
> >  		goto exit;
> >  
>
> Google's experimental AI review agent provided the following feedback
> on this patch.
> 
>   Could this introduce an AB-BA deadlock between the device lock and the
>   rescan/remove lock?
> 
>   Earlier in sriov_numvfs_store(), device_lock(&pdev->dev) is acquired. The
>   patch then attempts to acquire pci_lock_rescan_remove() while holding the
>   device lock.
> 
>   However, during a hotplug removal of the PF (for example, via sysfs),
>   remove_store() first acquires pci_lock_rescan_remove() and subsequently
>   calls pci_stop_and_remove_bus_device_locked(). That path eventually calls
>   device_release_driver(), which attempts to acquire device_lock(&pdev->dev).
> 
>   If sriov_numvfs_store() and a concurrent removal of the PF race, it appears
>   they could deadlock waiting on each other's locks.
> 
> The actual call sequence (at least in v6.12.y, where this patch was
> backported to) is as follows.
>   remove_store()
>   -> pci_stop_and_remove_bus_device_locked()
>      -> pci_lock_rescan_remove()
>         -> pci_stop_and_remove_bus_device()
> 	   -> pci_stop_bus_device()
> 	   -> pci_remove_bus_device()
> 	      -> pci_remove_bus()
> 	         -> device_unregister()
> 		    -> device_del()
> 		       -> device_lock()
> 
> I don't claim to fully understand the code, but the AI does seem to have a
> point. Please let me know if the AI analysis is correct or if it misses
> something.

Ugh. Well. That sucks. This lock is a sheer endless well of joy.
No, well, I think the AI is correct.

We've since discussed to move away from that patch again, or rather,
improve it further by applying this in top:
    https://lore.kernel.org/linux-pci/20260310074303.17480-2-ionut.nechita@windriver.com/

Because it improves some scenarios, such as driver core unbinds.
But looking at it from this angle, it suffers from the same AB-BA cyclic
deadlock.

  remove_store()
    |
    +- pci_stop_and_remove_bus_device_locked()
        |
        +- takes: pci_rescan_remove_lock                    # XXX
        |
        +- pci_stop_and_remove_bus_device()
            |
            +- pci_stop_bus_device()
                |
                +- pci_stop_dev()
                    |
                    +- device_release_driver()
                        |
                        +- device_release_driver_internal()
                            |
                            +- __device_driver_lock()
                                |
                                +- __device_driver_lock() - takes: pdev->dev

  unbind_store()
    |
    +- device_driver_detach()
        |
        +- device_release_driver_internal()
            |
            +- __device_driver_lock() - takes: pdev->dev    # XXX
            |
            +- __device_release_driver()
                |
                +- device_remove()
                    |
                    +- pci_device_remove()
                        |
                        +- vfio_pci_remove()
                            |
                            +- vfio_pci_core_sriov_configure()
                                |
                                +- pci_disable_sriov()
                                    |
                                    +- sriov_disable()
                                        |
                                        +- sriov_del_vfs()
                                            |
                                            +- takes: pci_rescan_remove_lock

And there is no way I can see how we can reverse the lock order in the
unbind_store() case, since everything above pci_device_remove() is owned
by the driver core itself. I don't see a way for us to put a hook in
there to take `pci_rescan_remove_lock`.

It's similar to what I'm trying to fix in:
    https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/
Taking `pci_rescan_remove_lock` inside the release functions is fraught
with traps, especially with SR-IOV in the mix.

One quick idea: can we somehow unbind the device from any device driver
in remove_store() before calling
pci_stop_and_remove_bus_device_locked()?  That way we would not have any
SR-IOV functions attached anymore at the point where we remove the PF,
since the DD are expected to clean them up.

-- 
Best Regards und Beste Grüße, Benjamin Block
               PGP KeyID: 9610 2BB8 2E17 6F65 2362  6DF2 46E0 4E05 67A3 2E9E
