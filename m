Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC873AE6FC
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022387; cv=none; b=l4/R3/svh32+CP/fJjyNak94tKvaDCfoFIbWK1Rkxw8QDlpZsDDMoyiM4ITgWDNME1bjThdSGpoGVX4fZskCkQHgcTvfWrF8fYS4VURVXQrCF/UBONP3Xw5D4WQOyKk/TnfcqwcNmcubM4g2fry4sL5K76yRCZUfuxbo2oQi+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022387; c=relaxed/simple;
	bh=tw+WAcM1/3PbQ8VvUf+VpkKBf4FUQLx9zMT8Bchf+AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaoxgtYmG4NkmMH4viVg9tCWTxL6id58NCl0izVgbLZxM5fdUPwbp9FahrTKo4OSMqoL0kqqLBEa1hgpbtW3m5uf2eMKPOEixsH+lIOhTUyu+SSE85c7he8c54hAfkIvb+D2dqaPyxAyT8TsXYvSQJaGzHlcEKr42vqxnqJZ9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll4Np5dq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll4Np5dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772022385; x=1803558385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tw+WAcM1/3PbQ8VvUf+VpkKBf4FUQLx9zMT8Bchf+AU=;
  b=Ll4Np5dqXN23arBFbgOQ56C+J5elj7ojUVZ4lkJdsH5VfYkicXdUETNa
   ETLxd79sQ8kv0q8wPODB5jXv7eW/ux7qgR3QuDD7SFekJ0HyMQtpdtQrq
   c/T+ecszWV+VyVD8sGsinplyuFDD9eZ4ZdwzhZV0EY1BJdQxF7XLFoUVL
   Pne62iINz5SgcMp5LIWBmraBZ/7rOO5Gf8+sInZsFI8Zp0eHnNFDqKOwi
   y0OF7wRjIRfLalMIOUlfaYVN6yvb2XGSsYogmXr8t+9lnQpo/10SzJhRq
   vddXBPaDibTnoBZBXfDkye6xigFBuuYeHiLHWQQJBLCP/hvSpGXswH5vX
   A==;
X-CSE-ConnectionGUID: Ii81wpZHQu+tQmrC8jJ8Tw==
X-CSE-MsgGUID: kIhYyOT+T5S7jZlqplOSCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72960269"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72960269"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:26:25 -0800
X-CSE-ConnectionGUID: 4JnDYL7fSCuRBpUEBA/K1A==
X-CSE-MsgGUID: j1D/6tAuQf6vtC8ZewI+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215322332"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Feb 2026 04:26:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4722798; Wed, 25 Feb 2026 13:26:19 +0100 (CET)
Date: Wed, 25 Feb 2026 13:26:19 +0100
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
Message-ID: <20260225122619.GA2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224165837.GA3736201@bhelgaas>

On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
> > Currently igc driver calls pci_set_power_state() and pci_restore_state()
> > and the like to bring the device back from low power states. However,
> > PCI core handles all this on behalf of the driver. Furthermore with PTM
> > enabled the PCI core re-enables it on resume but the driver calls
> > pci_restore_state() which ends up disabling it again.
> > 
> > For this reason let the PCI core handle the common PM resume flow.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> I love it, thanks a lot for doing this!
> 
> Do we still need the pci_enable_device_mem() and pci_set_master()
> in __igc_resume()?
>
> I suppose some of that is related to the pci_disable_device() in the
> suspend path (__igc_shutdown()), but there are only a few dozen
> drivers that do this, so I'm not sure it's essential.

I think they are just as you describe due the fact there are explicit
pci_disable_device() calls. Probably we can get rid of them as well but
that requires careful testing that nothing accidentally breaks.

@Vitaly, what do you think? I can take a look.
