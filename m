Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A028488D
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776829; cv=none; b=Z+bZQw+JMW4FAe0BvXeP+dxTB5tdoT2YsuWODwFxrcTsvZSBkOuXY8U1lZHGrwETYpLm1fMWle45MbV8T2yYivuoORLu4LPsIcXpjBF83V3etQ56J0MRkajPiPo/tsX+VpljhzFZ62nuWGcaIirDw6TszJDrWzKv6AVDOk3YBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776829; c=relaxed/simple;
	bh=5maPw5rOu247J95ogkhFL1Gvw11KNpgsZRmMGtsr8es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjvIYOoJRuGuzXnynZRjI1kJa5Q9AYptRH5fXekJjyIf38Piq4vdqQVb2YSrv8DRcg8TVrBTwDCicr4IFF/LfZgCyheEq3fwW19dxTaDsenpdGvzAB3id5DZ0TiFIx2zLpPG5xXND1f4dY8lNtyeP3aiMvuQ9mFXiox+1jlx26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0Coo76Q; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0Coo76Q"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12713e56abdso1005095c88.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775776828; x=1776381628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERkzPbjiSFF8tdP7mJxWiG00pMQx/MpjuHL9NISAD1E=;
        b=Z0Coo76QnvwhZxjajBmvQC8LwWtKFkzokY4XsjvecbW7ed8k/V1e0ZUiPMoTE5lTJU
         U/Pb/QEVeGAxvdn2jlzKY3BhDlowKxfQp5y9fSZmTsHqAcopSkfMsIKmo25OYpwMaH3v
         +SnCRdMhu6P2JJma9n3eGahybQVNUMI9pmf3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775776828; x=1776381628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERkzPbjiSFF8tdP7mJxWiG00pMQx/MpjuHL9NISAD1E=;
        b=RHx70VuGsqcKTZiaow1Diys3bcCdTeLn6PbXgh4Y6ZwXG7V/5bbq7MH/nGBZO55Ujc
         Odm9/0de+ZuTHD05FXl5kluOUraACPbwJdWI8Lwky2pZtniP8JQnLl3CxFcFLZFa81i7
         POJV3hEeOihYrEjOJiDJ6knpgFu+2zC2tQd+tULXHFEoI7qEHie6lLWIMB5StFX62yTf
         xmJRPnfhiJym3UruJ2QjSdQRSUr+iTMUP5vJrhcCBt8TTnkRgLJRwB/ZQG8oxQCT4883
         GTYMFvgo5rLhL97SaW430g24JDHpboVzcMq8x54FInXH4UUUa90QpQx1uW3Do/jy3lrD
         a/vA==
X-Forwarded-Encrypted: i=1; AJvYcCVGgYtm/iUI0bj+34LNIxdyw0UoigYyMVzuyVv0PjgX0Z0iRC10Ims08RlVy29nmmvbWd1HC1ZG0RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTPhWRJTDzCsVYSDpR6vQgVWNoyVoqpFWqSbD5tfU8Rhirvb5
	5C2Ja+B4H9EnvDQrRuvb2Jw+8stt0BcbkYEij5w3MIOiXOTY0bTBnIW4BHdw2Shgj0o90VRG6j8
	QXMQ=
X-Gm-Gg: AeBDieusrvoL6ZXxr7aQzHwX4VsHSt/R+XhFfsAwYnUFjeT6Xgm1CieukWB8JzYSTY3
	jifHV+TtHEsvAQwhWUPuq4OrXUz96iYQofbGIZrREX4Q3hnc+xF0J5fVKjENVAYzezyJrfBkWLv
	r8lyhv2dBaA9lGI9iCZ9GCqkStmkiObEy6yHFsM/08Oy1+/v9cnfniUKWBkEGslOX0+h5STUkev
	SROvOe2Q1HC86RGo2VRpZkz93LjjtWtl19hRCrPfJdicc/z/fhLcNT3nD8VahkczjJ42XoVyXIc
	RTCAXeAVecCoVx96U3FdgSup8G2orAMb/f/i5ktNG+L0qjuUPJty/UXNN0Tsvj0eDBuFP6v4fSc
	+4Ar5ISpKzMHwLk+JKibu9Nni1G9kv8wwa0LF57gPxZ19e8fFb3WtSzsBwx6jN/eNWXGyG46tom
	1xIjCCQVr8Z2lUS4/4nZD+LgkcoPEeSEPKE8bnyeBRla3/rOjciZ8/DwnEU31/lA==
X-Received: by 2002:a05:7022:6709:b0:12b:fd86:b443 with SMTP id a92af1059eb24-12c28bfe72bmr2644176c88.7.1775776827535;
        Thu, 09 Apr 2026 16:20:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5d1f:ad34:cf0d:7e41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2d561cd2a4esm2175767eec.16.2026.04.09.16.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 16:20:26 -0700 (PDT)
Date: Thu, 9 Apr 2026 16:20:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <adg0OFkVnT3OiSJd@google.com>
References: <aZfIfn9viQRj4uy4@google.com>
 <20260220164046.GA3528004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220164046.GA3528004@bhelgaas>

Hi Bjorn,

Sorry, I've gotten pretty busy, so this didn't top my list of things to
try to reply to for a while. But thanks for your review! See below.

On Fri, Feb 20, 2026 at 10:40:46AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 19, 2026 at 06:35:42PM -0800, Brian Norris wrote:
> > On Thu, Feb 19, 2026 at 04:25:14PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > > +out:
> > > > +	/* With no child services, we shouldn't need bus mastering. */
> > > > +	if (!capabilities)
> > > > +		pci_clear_master(dev);
> > > 
> > > I'm curious about this part because we pci_set_master()
> > > unconditionally just above:
> > > 
> > >   pci_set_master(dev);
> > >   pcie_init_service_irqs(dev, irqs, capabilities);
> > >   for (i = 0; ...; i++)
> > >     pcie_device_init(dev, service, irqs[i]);
> > >   if (!capabilities)
> > >     pci_clear_master(dev);
> > > 
> > > Bus mastering on a bridge must be enabled for DMA from downstream
> > > devices to work, but I think that's done by pci_enable_bridge() when a
> > > driver calls pci_enable_device() for an endpoint.
> > > 
> > > I assume the reason we call pci_set_master() here is so MSI/MSI-X from
> > > the bridge will work, even if there is no downstream device.
> > > 
> > > I don't think either pcie_init_service_irqs() or pcie_device_init()
> > > requires bus mastering, so I don't know why we enable it here.  It
> > > seems like we should do it when we set up MSI/MSI-X interrupts.
> > 
> > I'm no expert here, but by code inspection, pcie_init_service_irqs() may
> > call pci_msi_set_enable() which sets PCI_MSI_FLAGS_ENABLE. Could that
> > confuse a device to see MSI enabled but bus mastering disabled?
> 
> You're right that this path may set the MSI Enable bit:
> 
>   pcie_init_service_irqs
>     pcie_port_enable_irq_vec
>       pci_alloc_irq_vectors
>         pci_alloc_irq_vectors_affinity
>           __pci_enable_msi_range
>             msi_capability_init
>               __msi_capability_init
>                 pci_msi_set_enable(1)
>                   # set PCI_MSI_FLAGS_ENABLE
> 
> Setting MSI Enable allows the device to use MSI when it asserts an
> interrupt, but my understanding is that it doesn't enable the
> interrupt source itself.  The MSI Capability is an interrupt
> mechanism, not itself a source -- there's no interrupt handler at this
> point.
> 
> The sources have their own interrupt enable bits, e.g, Root Control
> PME Interrupt Enable, Link Control Link Bandwidth Management Interrupt
> Enable, Slot Control Hot-Plug Interrupt Enable, DPC Interrupt Enable,
> AER Root Error Command Error Reporting Enable bits, 
> 
> The drivers using these interrupts should be setting up their
> interrupt handlers before setting their interrupt enable bit.

Ack, makes sense.

> Bus master is a global thing that affects all kinds of transactions
> coming from the device.  There's no problem setting in from various
> places, but clearing it in a single place affects all of them, so we
> basically need global knowledge to know that it's safe.  That's why I
> suggested doing a conditional bus master enable instead of the
> unconditional enable followed by a conditional disable.
> 
> But I still do think this is not quite the right place even to enable
> it.  I think it would make more sense to enable bus mastering in the
> drivers that need the MSI/MSI-X, e.g., PME, pciehp, bwctrl, aer, etc.
> At this point in pcie_port_device_register(), I don't think we can be
> certain that any of those services will actually enable the interrupt.

I'm not quite sure what to say. I agree that in some sense, we (portdrv)
are not the ones to know who's going to use bus mastering; and so moving
that decision into child services makes a little sense. But then, we
punt the problem of what to do on failure or unwind -- if any child
enables bus mastering, it won't know whether it's ever safe to disable
it on (a) subsequent error/unwind (say, in probe()); or (b) remove().

So is pci_set_master() a one-way operation done in child services (never
call pci_clear_master()), and the only clear is via
pcie_portdrv_remove() -> pci_disable_device()?

Brian

> > > If we want to do it in pcie_port_device_register() (instead of in
> > > service driver when they set up an interrupt), maybe we should drop
> > > the initial pci_set_master() and do it conditionally, e.g.,
> > > 
> > >   if (capabilities)
> > >     pci_set_master(dev);
