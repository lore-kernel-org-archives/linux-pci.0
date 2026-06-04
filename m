Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215793939D2;
	Thu,  4 Jun 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559112; cv=none; b=VWAIBke4xrwsqUdOsSGC4PKjaYYQWJfk2K40c0SR4qv2Uzuuzne6eG+Or/rSGS7SLhEk+wro/iex49+3iUKE6am5fbeyMWur6Vu8CPE6GMtqVaVx5DQ3qktZJoTRo0DpmdL8pubmgYnWHV+mHGLXWmqfmw0J2btGUaqkeFyfI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559112; c=relaxed/simple;
	bh=TiFjIvkVhpduKyeYWOCDKy+kt/HeDIoBED1SRL3S/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnasGx0rsHbcXiNf99oiLLdNbmWW7QG0wxdubXHFE7dQRTgpiRclH8Gf99Bv+3BOYbWmBt/t/2txcCsVeDxAfYyDyWIQpw5pkO8wZaJWp117tpi3fAdrqSIlrqm/qxcHWnuGO2fKbRv8OOmEubCKqDc+EtjPP9m0NR5UbC+77GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu7v34YV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu7v34YV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1121F00893;
	Thu,  4 Jun 2026 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559110;
	bh=kXQkI9+DXRjaIp9RfDhWbe5qlEIe11pWQMnoO4ZK15U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eu7v34YV/mZZt+xwg4PmmyxKqBfrH/TwVYWl85R2EQqQYp+Kj0SU4tvJpky6NAox5
	 qTR6SGxDT2o9XrpZPgrlL1VoIhbtneXcuTGcYqQ+jSoQFEXCN8OFvfp/UtBWjRCBOH
	 T6dyuCSyZAgM807ZOI+S4a7GR6Nq1YlEN7J0zm4tG1E3g2DCHOrgFFyC86+XHLrT+v
	 xIf2WrlpwJHrYxSoTwXtNGRMEkgMJVkAxFzylLcXTcBQETHAvMswN384oTSYrO3qpF
	 6lL+aXuxO2j/xntpXFbjCTDpwjE4OfGdpF+oD7k6yoL7eSGB5yPpbHyi0jWM8DmBgf
	 nMixGMWJlRXxw==
Date: Thu, 4 Jun 2026 09:45:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yadu M G <yadu.mg@oss.qualcomm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Initialize pp->lock before MSI domain
 registration
Message-ID: <rn3iccwguseu3dvygwauog62jgcg4azrxvusotolpfr6tlga7y@odknnlfue3ym>
References: <20260514181901.315647-1-yadu.mg@oss.qualcomm.com>
 <20260514212621.55873C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514212621.55873C2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 09:26:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional double initialization of `pp->lock` in `dw_pcie_allocate_domains()` destroys lock state and corrupts lockdep tracking for standard platforms.
> --
> 
> commit 34c5622cf23f408a8b7191136ff7caf71c5a0456
> Author: Yadu M G <yadu.mg@oss.qualcomm.com>
> 
> PCI: dwc: Initialize pp->lock before MSI domain registration
> 
> This commit adds an initialization of pp->lock in dw_pcie_allocate_domains()
> to fix a lockdep warning on Qcom platforms. These platforms allocate the MSI
> domain from a custom .msi_init callback, bypassing the standard
> dw_pcie_host_init() flow.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index c9517a3488368..de316f103c73b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -215,6 +215,13 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> >  		.host_data	= pp,
> >  	};
> >  
> > +	/*
> > +	 * Initialize pp->lock here to cover direct callers from custom
> > +	 * .msi_init() paths (e.g. firmware-managed platforms) that
> > +	 * bypass dw_pcie_host_init().
> > +	 */
> > +	raw_spin_lock_init(&pp->lock);
> > +
> 
> Does this unconditionally re-initialize the lock for standard platforms?
> 
> In the standard DesignWare host initialization flow, dw_pcie_host_init()
> initializes pp->lock at the beginning of the function. It then calls the
> platform-specific pp->ops->init() callback, which on some platforms like
> Uniphier configures and enables INTx interrupts.
> 
> If an INTx interrupt fires asynchronously and its handler legitimately
> acquires pp->lock, would this second raw_spin_lock_init() call in
> dw_pcie_allocate_domains() destroy the lock state while it is in use?
> 
> Re-initializing the spinlock forcibly resets its internal state to
> unlocked and assigns a new lockdep key, which could introduce a data
> race or corrupt lock dependency tracking for platforms using the
> standard initialization flow.
> 

This is getting messier. Why don't you just initialize the lock in the ECAM path
of pcie-qcom driver to contain the fix in one place?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
