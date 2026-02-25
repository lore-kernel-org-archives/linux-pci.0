Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64083A1D04
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022542; cv=none; b=OgfRRMef5quoyfHBgV61NjXg4R92yoaQcrbsweC+1lv8LYhHKQXQ9Ts025cFGcGWHzYTC+EedPBP9pDhUf6GekI7wsOQynNDPjZcqGeWe6t6HPk7R2U7QWyvrTui7XKNg7XEvP39pMMRzrvzXKJKZzJIkHusUfhx9pYD0ByhSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022542; c=relaxed/simple;
	bh=7g+d2bSnzpz2QCpHfxO/sRHUP6mOIul7BC/cDoNCzrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEYFSCo0HDireuf6QuEy6Bssirr5Jzh0NNqLTrammNzLdwhBEwzPuBwP+3PWMRkZr/o28cjIYG8/+XT4W7v+9fKKUjzDDtvCueDHat7ivs66Wk2A0sMX2b3FnUl909yXS6cggMmigYvdber6PXmvrlOQqTnpVWYsoYxoNGty7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZXFjEoP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZXFjEoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772022541; x=1803558541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7g+d2bSnzpz2QCpHfxO/sRHUP6mOIul7BC/cDoNCzrY=;
  b=lZXFjEoPK96dDscrqOFSgvv3XGcCtXIwBiX62Plx3wc3I7o6XKR/D1x2
   72E79JIufkQKte7wmRWPa/D5vLXgqeypLlXPN0BquD+79MWJEokUvsrWr
   Y9nXv9R6fTML1xyRF+jD+OIWjbw5UStpdF62+0aPSR/m04LuZrRxDHd0b
   88x0O+7WkpY07Iq8sq4sGUIp5tMMr0V0Cvb5y95rumyBOIjxcfi1vH6kF
   /ZyO5Y2vAfw4hjSrr20zRHMrqkHHG22+FcFxvdpHh/qAAQ6Jo+Bd3wxFd
   tyP+ruoZp0ldDGKe5bGYD3PXOTPJ8YcHTBUSaAH7zY5inK23vSejQJY6E
   g==;
X-CSE-ConnectionGUID: fYAyCyMIQV+LTJ7NjIh/yA==
X-CSE-MsgGUID: cXK2sqXZTKiIBajFk4hkfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72960807"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72960807"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:29:00 -0800
X-CSE-ConnectionGUID: I3xwHY4JTKidB9QAeTmyOA==
X-CSE-MsgGUID: z3uDptVlQUyHrQZjyUOZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215323366"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Feb 2026 04:28:56 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 238D198; Wed, 25 Feb 2026 13:28:55 +0100 (CET)
Date: Wed, 25 Feb 2026 13:28:55 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
Message-ID: <20260225122855.GC2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
 <20260225122619.GA2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225122619.GA2275908@black.igk.intel.com>

On Wed, Feb 25, 2026 at 01:26:19PM +0100, Mika Westerberg wrote:
> On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
> > > Currently igc driver calls pci_set_power_state() and pci_restore_state()
> > > and the like to bring the device back from low power states. However,
> > > PCI core handles all this on behalf of the driver. Furthermore with PTM
> > > enabled the PCI core re-enables it on resume but the driver calls
> > > pci_restore_state() which ends up disabling it again.
> > > 
> > > For this reason let the PCI core handle the common PM resume flow.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > I love it, thanks a lot for doing this!
> > 
> > Do we still need the pci_enable_device_mem() and pci_set_master()
> > in __igc_resume()?
> >
> > I suppose some of that is related to the pci_disable_device() in the
> > suspend path (__igc_shutdown()), but there are only a few dozen
> > drivers that do this, so I'm not sure it's essential.
> 
> I think they are just as you describe due the fact there are explicit
> pci_disable_device() calls. Probably we can get rid of them as well but
> that requires careful testing that nothing accidentally breaks.
> 
> @Vitaly, what do you think? I can take a look.

Sorry @Vitaly and @Vinicius I meant :)
