Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5663C5DBF
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538255; cv=none; b=KnS0aeR4xjuiJU8dJx/PuqRrjrsTvYzaks2YgTOunusE9Gzh2O00bYs7tFXk9Fzc1Gtqh8u7qBBGFRxyNNUDggp8UyPlVzhEXnCyzoKiPWg7kkUK6c8XjzwMWBwIlns2HAm9LWTJ041+9u2a1OwApfXZBKScJw5rpWsJm2BNnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538255; c=relaxed/simple;
	bh=Dwxhv7sf09IRSFSSoN2QRxvu5M8MbqOUFr8Ti4Q5s9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfRy26xVrli0NYkG8kMo8TIIi/XAcYGBlSzbRNJJSwWdlfIIXiGPsBQKe4cZW6vS5W+En0bXEKW/f0TW1tM/Bu61YceBERgQW2u9/dNqlklD9RIg45XqaJvybbMD9+50gb6v2z/f0MLPVFFA7XynQsMR7JqDCbevyUulbjA8Z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 636473A6;
	Mon, 15 Jun 2026 17:37:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 49A146019068; Mon, 15 Jun 2026 17:37:52 +0200 (CEST)
Date: Mon, 15 Jun 2026 17:37:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Dan Williams <djbw@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
Message-ID: <ajAcUOumwyK_RYs0@wunner.de>
References: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
 <20260615134252.B34A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615134252.B34A21F000E9@smtp.kernel.org>

On Mon, Jun 15, 2026 at 01:42:52PM +0000, sashiko-bot@kernel.org wrote:
> > +++ b/drivers/crypto/ccp/sev-dev-tsm.c
> > @@ -38,6 +40,10 @@ static int sev_tio_spdm_cmd(struct tio_dsm *dsm, int ret)
> >  	if (ret <= 0)
> >  		return ret;
> >  
> > +	PM_RUNTIME_ACQUIRE(&dsm->tsm.base_tsm.pdev->dev, pm);
> > +	if ((pm_ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
> > +		return pm_ret;
> > +
> 
> [Severity: Medium]
> The commit message mentions that "resuming to D0 needs to (only) be done in
> code paths which use DOE specifically for CMA-SPDM", but does this code
> unconditionally resume the device to D0 regardless of the operation?
> 
> Looking at sev_tio_spdm_cmd(), the resume happens before the loop checks if
> the operation is actually PCI_DOE_FEATURE_CMA or PCI_DOE_FEATURE_SSESSION.
> Could this cause unnecessary power transitions for generic operations where
> accessing the config space in D3hot would be sufficient?

Moving PM_RUNTIME_ACQUIRE() inside the while loop may lead to repeated
D0 -> D3hot -> D0 -> D3hot ... transitions (depending on autosuspend
settings of the device, which are user-configurable through sysfs).
It would also lead to overhead induced by runtime PM code (repeated
spinlock acquisition etc).

So I believe keeping PM_RUNTIME_ACQUIRE() outside the while loop is
the right thing to do, but I'll leave this to AMD engineers to decide.

> [Severity: High]
> Does using PM_RUNTIME_ACQUIRE() here risk leaving the hardware permanently
> stuck in D0 during the device removal path?
> 
> The PM_RUNTIME_ACQUIRE() macro queues an asynchronous pm_runtime_put() when
> dropping the reference. If sev_tio_spdm_cmd() is called during teardown
> sequences, the pending asynchronous suspend can be cancelled by a subsequent
> device_del() call, which disables runtime PM. 
> 
> Should a synchronous runtime put be used here to ensure the device actually
> suspends before the removal completes?

If the device is deleted anyway, we don't care about leaked references.
And we absolutely do not want to synchronously runtime suspend here.

> > +++ b/drivers/pci/tsm.c
> > @@ -894,6 +896,10 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> >  	if (!tsm->doe_mb)
> >  		return -ENXIO;
> >  
> > +	PM_RUNTIME_ACQUIRE(&pdev->dev, pm);
> > +	if ((rc = PM_RUNTIME_ACQUIRE_ERR(&pm)))
> > +		return rc;
> > +
> 
> [Severity: Medium]
> Similarly to sev_tio_spdm_cmd(), does this code unconditionally resume the
> device to D0, ignoring the type parameter?
> 
> If a generic DOE transfer is requested that does not strictly require D0, it
> appears this will still force a transition to D0, contradicting the commit
> message's stated power management requirements.

Hallucination, this code does not perform "generic DOE" exchanges, only
CMA-SPDM ones.

> [Severity: High]
> Is this exported API also susceptible to the same asynchronous put regression
> mentioned above?
> 
> If pci_tsm_doe_transfer() is invoked during a teardown sequence, the async
> idle and suspend queued by the macro might get canceled by device_del(),
> leaving the device in D0.

We have to leave de-enumerated devices in D0 to ensure that a subsequent
rescan successfully re-enumerates them.  E.g. leaving a Downstream Port
in D3hot upon de-enumeration would leave any children inaccessible.

We also leave unbound devices in D0 for similar reasons.

Thanks,

Lukas
