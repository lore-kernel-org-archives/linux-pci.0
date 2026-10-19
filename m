Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F67401A0B;
	Mon, 19 Oct 2026 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411937; cv=none; b=ezk1rT+/fhdQ+KZEpBsy8z66jpY8bgqPScuH1BFM1Z+fNnhaU0qJv9V8oiCADIl9BSU+T2yQVSoJftOPolPj59qpLAHpiniOvPyJPcqrULV5Z1FxlTdTxVYKli+P6SkGyMAuMAmtqgT6Prf4llxN/JAqV+yHXJDCmEh9CHChkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411937; c=relaxed/simple;
	bh=jgI896axhpooxM8KiGv1kvdjyX5E6i3MkRUDxPN5WcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCXHkZvaD6+bDJCyIVN8CDmomgdJ0enGCIVW6KFTTtVr1lclyqWzWrTaEsRa42gk/NH4ls700Z5BEioKF7swPlRcxI6c2Dn0QqATJnU7A5D7qJStkaxvVRAMyK/GyswM4FFdcdvK6f4MzEmYhiVBX5f7wxEXGQgc4BnENp/lDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFuHoPjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFuHoPjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A889E1F000C4;
	Mon, 19 Oct 2026 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411936;
	bh=7oZHEsAwZVGbdUxLD/4XpLXUnxKJqxZtQipZAz0tqyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFuHoPjJkDobW1AjD136+GxCbqzyJDJh+QQF+0oceAlpVu3sl/kItSKp2/Y/avUZm
	 UTxgAuvenFDu0GrrZ3mSyIeVAkbWV/lYZ1zjPZUdJYVM3YY80QycRv4O+ftN/jIWCm
	 tri/5rX4kny1afm65RAsmVTb2aXvXeLZCfLf25wPefOu7oDNKSgwAYeTOqJClv4wWp
	 HLvxkLy6kXPcflIOqfUykQT0WU07cJkYxhrMEpOGoQEeqsMXrhdM0d/OdKJcP9SQ/1
	 9DFuQr7t7AlxjwUy4k2VFQ9CHe0K3KBLZFF4SPvSoo9143/ujGiFr6tAwcC1jcjLGd
	 NpYqONsYjSbmA==
Date: Mon, 19 Oct 2026 14:12:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Ji <jixincheng@ultrarisc.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: ultrarisc: Remove bypass_ob_mem_iatu variable
 on DP1000
Message-ID: <atYJHP_d2BWYtnXI@ryzen>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
 <20261019-dw-pci-fix-v1-2-9b7860f919b9@ultrarisc.com>
 <sashiko-outbox-176707@kernel.org>
 <179239875333.3277712.11479056245012803076.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179239875333.3277712.11479056245012803076.b4-reply@b4>

On Mon, Oct 19, 2026 at 04:32:33PM +0800, Xincheng Ji wrote:
> Hi,
> 
> On 2026-10-19 06:53 +0000, sashiko-bot@kernel.org wrote:
> > > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > index 523f454c6c524..a0d328c0c09b7 100644
> > > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > @@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > >  
> > >  	pp = &pci->pp;
> > >  
> > > -	/*
> > > -	 * DP1000 routes MEM transactions without outbound iATU windows, which
> > > -	 * avoids the 16-window/4GB-per-window aperture limit.
> > > -	 */
> > > -	pp->bypass_ob_mem_iatu = true;
> > > -
> > 
> > [Severity: Low]
> > Does splitting this removal from the preceding commit ("PCI: dwc: Skip MEM
> > outbound iATU setup for identity mappings") break bisectability when
> > CONFIG_PCIE_ULTRARISC is enabled?
> > 
> > The preceding commit already removed the bypass_ob_mem_iatu field from
> > struct dw_pcie_rp in drivers/pci/controller/dwc/pcie-designware.h:
> > 
> > struct dw_pcie_rp {
> > 	...
> > 	bool			ecam_enabled;
> > 	bool			native_ecam;
> > -	bool			bypass_ob_mem_iatu;
> > 	bool                    skip_l23_ready;
> > 
> > while ultrarisc_pcie_probe() in drivers/pci/controller/dwc/pcie-ultrarisc.c
> > still sets pp->bypass_ob_mem_iatu = true until this patch, causing a build
> > failure at the intermediate commit.
> > 
> > Should this change be squashed into the preceding commit (whose commit
> > message already states "Remove bypass_ob_mem_iatu and the UltraRISC-specific
> > setting"), or ordered before the struct member is removed from
> > struct dw_pcie_rp?
> > 
> > >  	platform_set_drvdata(pdev, ultra);
> > >  
> > >  	ret = ultrarisc_pcie_init_clks(ultra);
> > 
> Thanks for pointing this out.
> 
> Am I correct in understanding that the issue is with the dependency 
> between the patches,as the intermediate commit would fail to build 
> when `CONFIG_PCIE_ULTRARISC` is enabled?
> 
> Would you prefer that I reorder the patches so that the UltraRISC-specific 
> assignment is removed first, or squash the change into the preceding commit
> that removes `bypass_ob_mem_iatu`?
> 
> I'm happy to revise the series accordingly to ensure that each commit 
> builds independently.

I think squashing the two patches would be okay.


Kind regards,
Niklas
