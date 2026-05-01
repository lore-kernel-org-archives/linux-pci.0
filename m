Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE553CFF56;
	Fri,  1 May 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665080; cv=none; b=RriGK0GPxEm0O5YX8RoPvFbepLJUttQTIEbGiQD/hreb7V+5THBQFJ4pO8TLszB97TR0EyFkK68oi+Ft1GXlBZegspvAPW6zFqpkBwaEDDgy76+d3brHXfvOmdFeQ14oGn+vsgAfpLB1kZl/Q2ADGe+U3okV8e5V7kSpQUqzwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665080; c=relaxed/simple;
	bh=2lwK0DRmBaAJw8gyAufqK7jzcxgKzRLJfNjgaScql5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FxEHmZwszKnULk0rdV+gHUto61rJgp2S9/LoCk2CqNIrpJ2u8RFkp6QXZqWGs63+/eMrQhP0oMlTA+9hp/edblDMdNVpqLSlnDH2rq0Mc8SEXtFWZPX7ucuN8uPwVeflUM3ZNIycyw+vJILxZsnlEd2qiU3D4LXe36jxOQMaOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srPRTdlj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srPRTdlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE5C2BCB4;
	Fri,  1 May 2026 19:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777665080;
	bh=2lwK0DRmBaAJw8gyAufqK7jzcxgKzRLJfNjgaScql5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=srPRTdljPgAgcQl0cQ2FP8JuQz/ZBexicobfWo69YwU+2UWBwJMaKBJ4KUkKv4hfB
	 Ggbk8HPpnvZOsVBaVEiWVbxIhmXt1JLyT93k4gNmVYoo1eBEQi3yeV0gS7GcqmU7Vm
	 l4rVDMXhBsHJtaJZP+sUSPv2N/ExfiAXZBUgh+PlzPK75cgSk1Ncb+gYZ1LeClu3cN
	 nWCkrtANJoUVQUZuYpbi5U6IwrUqH+P+Ie6N17lbtb58tbKFVUtb+/8E53qJ6IXnew
	 W+/S35PeavybIrWSDXd2qpFnpldRFg2y9VlHnsii0z7hD/8tQXRUTi7TqQYqYXTGOm
	 Ie9n7fy5r058A==
Date: Fri, 1 May 2026 14:51:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bernd Schumacher <bernd@bschu.de>, "Alexandre N." <an.tech@mailo.com>,
	Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org,
	Uwe Kleine-Koenig <ukleinek@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	regressions@lists.linux.dev, linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource assignment
Message-ID: <20260501195118.GA516950@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>

[+cc Thorsten, thanks for the reminder!]

On Wed, Apr 15, 2026 at 05:56:06PM +0200, Lukas Wunner wrote:
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

a2f1e22390ac appeared in v6.19.  Applied this fix to pci/for-linus for
v7.1, thanks!

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
> -- 
> 2.51.0
> 
