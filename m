Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55A42B302
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762168; cv=none; b=jy01jNaknG397Fes69BvUG7Rd1hKAXssw+fNsdMDKQQhJnTXM2LvXG5y3vYTjgInfmR/7QsnIMaM3zxUaVlIEPlTVZeSf1uHC0fnCtg2IC2DpNQhP4nzQSPW3CUceno+gMGwtJWh3O8Bt8C5c3GKFCpOC4nqeqnSzbOOefMwPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762168; c=relaxed/simple;
	bh=WBNkpjYp7Rou85GCTMeWgm+HUcD0wtM7gf3sX1bxa0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJbvDacsMORx55V9y6p/PnRvwRlucPpbbcoOKtVaR60qSxYZ2HbworHf9fNBTVwtkd+pGYtb1DRMorAMvkiOGLWhpk5Oq229Pa/kvt5mc0gyi73NYgwg6TSfHDgisWNFPfEh+QJ8TVK3ejb+iA/L0m+yoPA97NAwNWdN9ZN4K2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KY3ns+0o; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KY3ns+0o"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so10653a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784762165; x=1785366965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lInBjANtH4BjEEGmffn+p/zkomTeab76R8MrFSqGh90=;
        b=KY3ns+0o8CqCxqFRpDt/n4wgZKWJ403uGyx2hQKOWgwgRbmzx1IXaLDyWOZFkvfnLw
         +OqArm95zuhAGk23xJWlXy60PthOGZzYTDvFZU3nW+YfqSEWZhElzvcB2gvozkzci/kZ
         ZOWEaWMUHJnwdJFjO0s806wycIh2smBBqoVCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762165; x=1785366965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lInBjANtH4BjEEGmffn+p/zkomTeab76R8MrFSqGh90=;
        b=MwWIiRPL2mKZdPuVgEl0zKkMo9ZKwEU1YAJpCFz2qRS4VaudW3RCWXC03CnyoZmwJd
         firpL1H8BksKerOc0MRWTTJ2Eb9EHMC5Ss/JQYOm5Ep2XDZni5c1qIDrXg6YBZkq5CmJ
         4q3rIDCrdXV1RM+OaHFivRpIxAIa+BHVEiCluhBVKZH9a3tXJAqH5zkhrLOGgnnvoCEH
         FuQum86tFUY2BZZdj5TspIpDVwtzPQtYTj72jyncpgQNZurDAaDzaJzBFUuoksT1T4sX
         WcHkrljOK1kachS9N100k6bjLUH0AxpM56tviXQfpIrXp0uFv403QnXG74eAYroe3nIg
         0YyA==
X-Forwarded-Encrypted: i=1; AHgh+RrLhACu3P4P+lOBMArSpcLvFK01iYZNc6qi+aRDbeKHtduCQXaKBRQ65Ux3Pip4K0zOmINKoI6EtQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycb5nejyw1j4ToUow7g9n4SGjJagH7Tk904woJQHPpSeF5LXEM
	p3lBBIGL0uQEqvWe2lHvMDeWwovlWJBdONtcalKdS9hLuZhvOGGY+4jZaCLkY3H359axiiUS00/
	GACt0kA==
X-Gm-Gg: AR+sD108GXrPLHsujlaX31/Z2mkl5199Okf1WfeKly447FlY1SIHeqchpsdlaPvzGX2
	xTRUouTxKHcgA2OeUEphrUHVKdTpryw7fe2gkPYTxL2oSuHLX6Rz9IdrMmLCS/6vRe0qbZnArbm
	LNJ/o5bJr1QUykRYMlB1a6Oxh//GJMZ3j3le4tUz2AKCU+arH/A9p2LtwFC2H6vqMApwMUAK9B7
	aVHUTDJUesQkNjSPUQHknFtFmLGK/5zHKofdfpzCjuqLfelfz7txUyDGCiSkhrlgVWwKPKAxp5k
	k8oWGze+Lr45Ch0C5lGfuYeAAKFLByEeDLkUpat4dtWGkHbVfiHmPKsO1M1aR9O8kVkGMz1yh5P
	X4lXbsypkJud3gXMw2KHxewtr/Q7KEYJpw/vDwBUsstlq7xDYZfi5tWcE5HrosYmAOMNnUwjQ2o
	KmXh26P/ukBdOCfSfX1VpHOVJZTC4Xm6QOWAeejYaF
X-Received: by 2002:a17:90b:52d0:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38ec667a731mr659784a91.43.1784762165505;
        Wed, 22 Jul 2026 16:16:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f3fd:a899:78ad:64d4])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-13d130158c0sm9903256c88.6.2026.07.22.16.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:16:04 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:16:03 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <amFPMxGyU7EJDZ1m@google.com>
References: <alnnTRldy-deNIFM@wunner.de>
 <20260720204419.GA426578@bhelgaas>
 <al68lFtbq_Q4RCL2@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al68lFtbq_Q4RCL2@google.com>

Hi Lukas, Bjorn,

On Mon, Jul 20, 2026 at 05:25:56PM -0700, Brian Norris wrote:
> On Mon, Jul 20, 2026 at 03:44:19PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 17, 2026 at 10:26:53AM +0200, Lukas Wunner wrote:
> > > On Thu, Jul 16, 2026 at 12:26:41PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > > > The PCIe port driver fails to probe if it finds no child services,
> > > > > presumably under the assumption that the driver is not useful in that
> > > > > case. However, the driver *can* still be useful for power management
> > > > > support -- namely, it still configures the port for runtime PM / D3,
> > > > > which may be important for allowing a bridge to enter low power modes.
> > > > > 
> > > > > Thus, allow probe to succeed even if no IRQs and no child services are
> > > > > available. This also mirrors existing behavior for ports that have no
> > > > > PCIe capabilities, where we'd also probe successfully.
> > > > > 
> > > > > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > > > > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > > > > controller"), because it's common for some DWC-based systems to:
> > > > > 
> > > > > 1. have only have the "aer" and "pcie_pme" port services available and
> > > > > 2. not define legacy INTx interrupts properly in their device tree.
> > > > > 
> > > > > After commit f5cd8a929c82, such systems may fail
> > > > > pcie_init_service_irqs() and so exit with -ENODEV.
> > > > > 
> > > > > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > 
> > > > Applied to pci/portdrv for v7.3, thank you!
> > > 
> > > Some thoughts on the version now applied to pci/portdrv:
> > > 
> > > * After this patch, the return value of pcie_device_init() is no longer
> > >   evaluated, so that function should be changed to return void as part
> > >   of this patch.
> 
> Yes, seems reasonable.
> 
> But then, possibly negated below.

Not done in v4, since we now use the return code differently.

> > > * If no port services are initalized, e.g. because pcie_device_init()
> > >   failed for all of them, the allocated IRQ vectors are not freed.
> > >   They're hogged, which may be a problem on systems which only support
> > >   very few IRQ vectors such as Sophgo SG2042:
> > > 
> > >   https://lore.kernel.org/r/0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn
> > 
> > Seems like a good idea to free IRQ vectors we don't use.  It *looks*
> > like it should be safe to call pci_free_irq_vectors() here and then
> > again in pcie_port_device_remove() if a port is removed, but Brian
> > wasn't sure, and I didn't look any deeper than pci_disable_msix() and
> > pci_disable_msi().
> 
> I think everything in pci_free_irq_vectors() is written such that it can
> safely be called twice. I'll see if I can verify that better and submit
> an update. I was just unsure at the moment of review, especially
> considering you had other real double-cleanup bugs in your proposal.
> 
> > I guess if we did this we'd need to retain the pcie_device_init().
> 
> Ack.

Done in v4.

> > > * It might be clearer to call pci_clear_master() directly in the
> > >   if-block which is amended to "goto out".  Then the "goto out"
> > >   can be changed to a "return 0".  It seems "if (!capabilities)"
> > >   cannot happen through any other code path, so it's unclear why
> > >   the "out" label is necessary.
> > 
> > It does look nicer that way.
> 
> Hmm, yes. I may have rewritten it enough times that it was never clear
> how many error paths we were going to have. As soon as you get more than
> 1 error path, it gets tricky to do this.
> 
> I'll revisit this one along with the previous suggestions.

The additional "free IRQs" suggestion means we again have 2 paths that
need the same cleanup, so I chose to keep the 'goto'. There are other
creative ways to avoid the 'goto', but I felt like "creative" often
doesn't help readability and maintainability.

> > > * There's a duplicate "have" in the commit message ("have only have").
> > 
> > I fixed this on pci/portdrv.
> 
> Commit message looks good, thanks.
> 
> > What do you think, Brian?
> 
> I'll give the above a shot. I suppose that would work best as a v4
> (pretending your pci/portdrv is only a reference, and not a patch-basis
> target).

Submitted v4:

https://lore.kernel.org/all/20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid/

Brian
