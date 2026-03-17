Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E73CA482;
	Tue, 17 Mar 2026 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753224; cv=none; b=Pf+xwg42fzX+jp98VSQyRoKlNhmwr+DGdy6fA+xfwPtEMuwxo/IhNa5reIW0EVckTUp9BtkjektROapu9g4+4yqjEVW5UvgWw+ZeOO+v3yo/RYYuAqw6C1c+W0TzCOQjG6a0vMApDGwRJbX2Qu7wfRnI383GZOwvIT2rRplmqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753224; c=relaxed/simple;
	bh=sEDbPh4yhAoShlDoswQYm1A+wCqhs0ydA/Ueg/hKfCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgGbo1Z+hEsDeldg+eR+cB39OLOKMrOmhufEmAbCuLnKL+OyDClVQ4NZAnNo2hvVCaYh5hwxHHZRL5o+qfp9QSa27PlGXkQGC7ukJA/rz1oN/73CEWoCJR6AZ+0iI2FMXmpbNt2jM/RlpChFrX/S0br9O6rzYRauCLLas8XTrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3C8F81058C;
	Tue, 17 Mar 2026 14:08:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 296BE6015C0D; Tue, 17 Mar 2026 14:08:11 +0100 (CET)
Date: Tue, 17 Mar 2026 14:08:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Benjamin Block <lkml@mageta.org>, Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ionut Nechita <ionut.nechita@windriver.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <ablSO1rA8D2blipG@wunner.de>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
 <20260317090149.GA3835708@chlorum.ategam.org>
 <20260317094656.GI2161595@p1gen4-pw042f0m>
 <20260317113334.GJ2161595@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317113334.GJ2161595@p1gen4-pw042f0m>

On Tue, Mar 17, 2026 at 12:33:34PM +0100, Benjamin Block wrote:
> @@ -518,8 +520,13 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
>  
> -	if (val && device_remove_file_self(dev, attr))
> +	if (val && device_remove_file_self(dev, attr)) {
> +		device_lock(dev);
> +		kill_device(dev);
> +		device_unlock(dev);
> +		device_driver_detach(dev);
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> +	}
>  	return count;
>  }
>  static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
> 
> Marking the device dead prevents re-binding after the unbind.

That can also be achieved through the PCI_DEV_ALLOW_BINDING flag,
though you'd have to add a pci_dev_disallow_binding() helper in
drivers/pci/pci.h to go alongside the existing
pci_dev_allow_binding() and pci_dev_binding_disallowed() helpers.

However pci_stop_and_remove_bus_device() implicitly unbinds the
driver before removing the device.  Remind me, what's the need
to unbind before calling that function?

Thanks,

Lukas
