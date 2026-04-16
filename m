Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F9D3939CC
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337695; cv=none; b=H9KPajyuESJl2vOn0BuQJZrfzrixb3Ke0nBVWCJPKPSTZwWIIKhazpOPN0G5o+U4/qLuwgruTvGVRTjPEVu2LAhJPJ/czXFoxr0bakH4ZTZNnbPWMvvqI3vS6+wOHRKLFAVJh6mVz71tILajHX6ln/A9rLhFqcpUATE3UlSdeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337695; c=relaxed/simple;
	bh=DQwkVMKOwzWi4l0FJfWXhOkm0YP9JxkkBkUKeGamdWw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EnpsvGuU/l2rTCXR9q/LtKwSHTl1Ls+aXqvrFk3ol7XJIHkI4kEaE2JFdrSauA2rFEfgci8br9T/mR1BMb6nXqmziujWrD6KmiOj3LkU6pWh0HnSCdDhnuCrULCHgofjB29lPZyGmLlf2wlDDNhGGMQtHXLwNZkwwh+LEcYCpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXURT7Y1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXURT7Y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776337693; x=1807873693;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DQwkVMKOwzWi4l0FJfWXhOkm0YP9JxkkBkUKeGamdWw=;
  b=PXURT7Y19qrDCl7G5popjXRKBS0D9TY3UjIhhBrfX3uSfex3QFFpdXdv
   32ayHdL3R58ErmACau11VQPX0CATRcoyR2Rzh9eeY2ZCyN9gE2Rd8/3Tz
   F/8MZ6PvX3qiibIVrp4W9iJpIBtyRORGm9LW7Ks4Kv0t006d0C37/Pm/c
   CCrP9vlxObXSPOEM/jU3fVptRA00RBJlCmpXJwIKYygX586csd4Tl4uya
   PNNeE8J/LjdLqWTbaRbzhKohkSyGmYNaemwejRwfbAQtTL8icalM8L2Ka
   DHMLNlvXXFWAwkV/HriU5dxui4BwaJHhnfpd+jADMFqK749iEDY/1Hha6
   Q==;
X-CSE-ConnectionGUID: hijzm2N3RXCdD2d8A+Bytw==
X-CSE-MsgGUID: GL130ZBRRlmcqPb5zsLZ7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77240876"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77240876"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 04:08:13 -0700
X-CSE-ConnectionGUID: VMPYZ+UnSoyK4m7o5IYZeQ==
X-CSE-MsgGUID: +Ihv2uYNTfWXaqpvKGyipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="254158489"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 04:08:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Apr 2026 14:08:03 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bernd Schumacher <bernd@bschu.de>, 
    "Alexandre N." <an.tech@mailo.com>, 
    Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org, 
    Uwe Kleine-Koenig <ukleinek@debian.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Alex Williamson <alex@shazbot.org>, regressions@lists.linux.dev, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource
 assignment
In-Reply-To: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
Message-ID: <fa331b71-133c-3773-3ec9-1aecc807fd9b@linux.intel.com>
References: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Apr 2026, Lukas Wunner wrote:

> Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
> adapter plugged into an ASRock X570S PG Riptide board with BIOS version
> P5.41 (09/07/2023):
> 
>   ddbridge 0000:05:00.0: detected Digital Devices Cine S2 V6 DVB adapter
>   ddbridge 0000:05:00.0: cannot read registers
>   ddbridge 0000:05:00.0: fail
> 
> BIOS assigns an incorrect BAR to the DVB adapter which doesn't fit into
> the upstream bridge window.  The kernel corrects the BAR assignment:
> 
>   pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window
>   pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned
> 
> Correction of the BAR assignment happens in an x86-specific fs_initcall,
> pcibios_assign_resources(), after device enumeration in a subsys_initcall.
> This order was introduced at the behest of Linus in 2004:
> 
>     https://git.kernel.org/tglx/history/c/a06a30144bbc
> 
> No other architecture performs such a late BAR correction.
> 
> Bernd bisected the issue to commit a2f1e22390ac ("PCI/ERR: Ensure error
> recoverability at all times"), but it only occurs in the absence of commit
> 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing").
> This combination exists in stable kernel v6.12.70, but not in mainline,
> hence Bernd cannot reproduce the issue with mainline.
> 
> Since a2f1e22390ac, config space is saved on enumeration, prior to BAR
> correction.  Upon passthrough, the corrected BAR is overwritten with the
> incorrect saved value by:
> 
>   vfio_pci_core_register_device()
>     vfio_pci_set_power_state()
>       pci_restore_state()
> 
> But only if the device's current_state is PCI_UNKNOWN, as it was prior to
> commit 4d4c10f763d7.  Since the commit, it is PCI_D0, which changes the
> behavior of vfio_pci_set_power_state() to no longer restore the state
> without saving it first.
> 
> Alexandre is reporting the same issue as Bernd, but in his case, mainline
> is affected as well.  The difference is that on Alexandre's system, the
> host kernel binds a driver to the device which is unbound prior to
> passthrough, whereas on Bernd's system no driver gets bound by the host
> kernel.
> 
> Unbinding sets current_state to PCI_UNKNOWN in pci_device_remove(), so
> when vfio-pci is subsequently bound to the device, pci_restore_state() is
> once again called without invoking pci_save_state() first.
> 
> To robustly fix the issue, always update saved_config_space upon resource
> assignment.
> 
> Reported-by: Bernd Schumacher <bernd@bschu.de>
> Tested-by: Bernd Schumacher <bernd@bschu.de>
> Closes: https://lore.kernel.org/r/acfZrlP0Ua_5D3U4@eldamar.lan/
> Reported-by: Alexandre N. <an.tech@mailo.com>
> Tested-by: Alexandre N. <an.tech@mailo.com>
> Closes: https://lore.kernel.org/r/dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com/
> Fixes: a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.12+
> ---
>  drivers/pci/setup-res.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e5fcadf..1769ba9 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -102,6 +102,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  	}
>  
>  	pci_write_config_dword(dev, reg, new);
> +	dev->saved_config_space[reg / 4] = new;
>  	pci_read_config_dword(dev, reg, &check);
>  
>  	if ((new ^ check) & mask) {
> @@ -112,6 +113,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
>  	if (res->flags & IORESOURCE_MEM_64) {
>  		new = region.start >> 16 >> 16;
>  		pci_write_config_dword(dev, reg + 4, new);
> +		dev->saved_config_space[(reg + 4) / 4] = new;
>  		pci_read_config_dword(dev, reg + 4, &check);
>  		if (check != new) {
>  			pci_err(dev, "%s: error updating (high %#010x != %#010x)\n",

Hi Lukas,

I'm wondering if there's something that makes this problem specific to 
only standard BARs?

Can other resources, namely IOV resources or bridge windows, similarly be 
updated "too late" and not get correctly updated into the saved config 
space?

-- 
 i.

