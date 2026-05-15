Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C396B73;
	Fri, 15 May 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845301; cv=none; b=mE21BKvTf6n5zEcAfmsRgi8X5zZ0RwHjIo6O+UYnnBp6Eng0XqYl2sWJS4/LqIOQzB9iuxZ1hj9uhvOibQXjc0DJdNDli5HzxXsVYj2VuKMCfevspUfjVCSIibiMmQVN23cBB5ufeTx2THUUMJrvII50FfWGx6c0IgBj6tYMcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845301; c=relaxed/simple;
	bh=wUa2cQFiiNE9K0wnB4Us1zFnnA1SPJ7Yg+YBxo9BoZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWYWTXutIl6zDii6LNPeZVt9K4OFv+o+WHS1m/pwDWCIfKICw551mSRV5k3d9ew2xzpgUDMySlXIV5BMKG0i0w7anrFiDTIbpzy597ovV6JeeXZnWI7qfCVSEr8Fy8weatmzSQnxpIQohfOO1LJ+lfg6zXDby6sXq3U8f/Ywq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTUmHoB7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTUmHoB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778845299; x=1810381299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wUa2cQFiiNE9K0wnB4Us1zFnnA1SPJ7Yg+YBxo9BoZo=;
  b=MTUmHoB7KRp2Z7mAS1RsW5vc/J4QZxUPNw5xJ0d9YyWDLFU6gYmEJ7l8
   cBBhZP2oG+S5P0Bv4NejtIHVyaGF+pim8CbflgxTa6hyuKem3Tju+vZa8
   NMSFOFT8OensU2d0YuQCK3jv1QlN5Akd+mhYD2/h8IJexGUGHZkfwmqmH
   7Qcjup698J2CS+JGYz+1DIaIh5Tsh5brI5lUzMvQ7PIvGZngq3lq0Dro1
   xjLiq1+qd4io+dX/GGVWv5FMAgsf7hEDJY1/SF5giEttrwzXo2D4n/FKW
   pNJW+yuLrH5A+zeK5AEVDUePQGiG8Q9FV1FfK+L0uGsWQUH9zpi1FSs/s
   Q==;
X-CSE-ConnectionGUID: uO+/dU8mT7+aF1CbMaoOUQ==
X-CSE-MsgGUID: 996EtDr0QPq98jO9Hlz5Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83670283"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83670283"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:41:39 -0700
X-CSE-ConnectionGUID: e3XfgxO0QoOJOTmogPJkDg==
X-CSE-MsgGUID: MO0qV4rYTP6S0O1qER28tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243644025"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 15 May 2026 04:41:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2747F95; Fri, 15 May 2026 13:41:34 +0200 (CEST)
Date: Fri, 15 May 2026 13:41:34 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <20260515114134.GJ84797@black.igk.intel.com>
References: <20260514200625.C6877C2BCB3@smtp.kernel.org>
 <20260514213811.GA434353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514213811.GA434353@bhelgaas>

On Thu, May 14, 2026 at 04:38:11PM -0500, Bjorn Helgaas wrote:
> On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Ignored return value of `pci_dev_wait()` masks hardware readiness timeouts
> > --
> > 
> > commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
> > Author: Bjorn Helgaas <helgaas@kernel.org>
> > 
> > PCI: Wait for device readiness after D3hot -> D0uninitialized transition
> > 
> > This commit adds a call to pci_dev_wait() after transitioning a device from
> > D3hot to D0uninitialized. This ensures the device is ready to accept config
> > accesses, especially for devices with No_Soft_Reset == 0.
> > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8f7cfcc000901..9d0fc9fbb76a0 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > [ ... ]
> > > @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
> > >  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > >  
> > >  	/* Mandatory transition delays; see PCI PM 1.2. */
> > > -	if (state == PCI_D3hot)
> > > +	if (state == PCI_D3hot) {
> > >  		pci_dev_d3_sleep(dev);
> > > -	else if (state == PCI_D2)
> > > +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > > +				     PCIE_RESET_READY_POLL_MS);
> > 
> > Is it safe to ignore the return value of pci_dev_wait() here?
> > 
> > If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
> > ignoring this error, pci_power_up() continues, unconditionally sets
> > dev->current_state = PCI_D0, and can return success (1 for need_restore).
> > 
> > If pci_power_up() returns success, will callers like pci_back_from_sleep()
> > execute pci_restore_state() against an unresponsive device, which could
> > potentially trigger PCIe Master Aborts, AER events, or system crashes?
> > 
> > Should pci_power_up() propagate the error from pci_dev_wait() to prevent
> > this?
> 
> Good point.  I think it should look like this instead:
> 
>     if (state == PCI_D3hot) {
>             pci_dev_d3_sleep(dev);
>             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>                     ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
>                                        PCIE_RESET_READY_POLL_MS);
>                     if (ret) {
>                             pci_err(dev, "Not ready after soft reset\n");
>                             dev->current_state = PCI_D3cold;

I wonder if PCI_POWER_ERROR makes sense here?

>                             return -EIO;
>                     }
>             }
>     } else if (state == PCI_D2) {
>             udelay(PCI_PM_D2_DELAY);
>     }
> 
> > > +	} else if (state == PCI_D2) {
> > >  		udelay(PCI_PM_D2_DELAY);
> > > +	}
> > >  
> > >  end:
> > >  	dev->current_state = PCI_D0;
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260514153124.404060-1-bhelgaas@google.com?part=1
