Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E493D566B
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046966; cv=none; b=YmtvD5ME4qOKLuzfqk4RuNTavNbjdsETxfU20xKsj7Gkbb8xCKCdfPA85BV4US9dV8UmHdUQ6JqomXRPqPflrsLtdhpJdJF4oL88SplPPF19AO2ie0h9WsebLgdwxoWmj8t9ZhUaVtHVOsTRTex+UCerGNBy7y5CMD2/tS6mNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046966; c=relaxed/simple;
	bh=GSEabozmIh6pzZge9YaGhqUE/+S63wUHZbQyGaqo3ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LBl1yE9/SZC8CwPFKLXIqTcgPncW3lCSMS69ZpOigYRecdPhrMphv/NPWA6Rqr4BC4YII6GHz/DXOnmvfymgZbKBRU1ftikaAHSW3MlIE769hRU2xg6Rf2g9ofKbsQ94ddUsL8Bg/GxHEJTLpGfO32bevf2dTP8Ev7eB+B6RWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvo6OY6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvo6OY6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C2C19425;
	Fri, 24 Apr 2026 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046966;
	bh=GSEabozmIh6pzZge9YaGhqUE/+S63wUHZbQyGaqo3ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Uvo6OY6Z2d/u2HFkTCsJ8NLMs526g8bYpDR2Hkb+9VIntrGLsPTDQRYD8FxjMSORy
	 8fPWqsZvzv6G1ekeHD64bufMKcH0Ai41kD0fTSvFViGmOXLLIBB6o6TuRdHP/xKWIR
	 G1OfE2n0CyEwEePpc8Ed8xpbrvgxW5FAS96+nPB5y+GPeeK4L8e85YAip9itt8l+Ct
	 NykYkJHrhsaLljM1Msvm4XGWDsyJmTG0r8WLZUEbPmO7gb3P7S/6x9u+1AmPBVGjjs
	 zXyxS+XOi5TuOxxOhGTVcr7ZJ9JXG4av3PWcdSh4QiW5LHVrFuv+qKpD34xefNF5Lf
	 Z4lwW8lZXSkQA==
Date: Fri, 24 Apr 2026 11:09:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Stop setting cached power state to "unknown" on
 unbind
Message-ID: <20260424160925.GA11406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7d11d3ceb231acc90829f7a5c8400c2446744f.1776415510.git.lukas@wunner.de>

On Fri, Apr 17, 2026 at 10:51:46AM +0200, Lukas Wunner wrote:
> When a PCI device is unbound from its driver, pci_device_remove() sets the
> cached power state in pci_dev->current_state to PCI_UNKNOWN.  This was
> introduced by commit 2449e06a5696 ("PCI: reset pci device state to unknown
> state for resume") to invalidate the cached power state in case the system
> is subsequently put to sleep.
> 
> For bound devices, the cached power state is set to PCI_UNKNOWN in
> pci_pm_suspend_noirq(), immediately before entering system sleep.
> 
> Extend to unbound devices for consistency.
> 
> This obviates the need to change the cached power state on unbind, so stop
> doing so.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/pm for v7.2, thanks!  Will be rebased after v7.1-rc1.

> ---
>  drivers/pci/pci-driver.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d5..774892d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -482,13 +482,6 @@ static void pci_device_remove(struct device *dev)
>  	pm_runtime_put_sync(dev);
>  
>  	/*
> -	 * If the device is still on, set the power state as "unknown",
> -	 * since it might change by the next time we load the driver.
> -	 */
> -	if (pci_dev->current_state == PCI_D0)
> -		pci_dev->current_state = PCI_UNKNOWN;
> -
> -	/*
>  	 * We would love to complain here if pci_dev->is_enabled is set, that
>  	 * the driver should have called pci_disable_device(), but the
>  	 * unfortunate fact is there are too many odd BIOS and bridge setups
> @@ -862,7 +855,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  
>  	if (!pm) {
>  		pci_save_state(pci_dev);
> -		goto Fixup;
> +		goto set_unknown;
>  	}
>  
>  	if (pm->suspend_noirq) {
> @@ -914,6 +907,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		goto Fixup;
>  	}
>  
> +set_unknown:
>  	pci_pm_set_unknown_state(pci_dev);
>  
>  	/*
> -- 
> 2.51.0
> 
