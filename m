Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5122FFFBE
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190115; cv=none; b=PPulHI1NCFSjpSKv7btgHj+o8UakjPQMt3oKJIdJDHnxcvFLag9BDkrg+CGZgArjt5cPg77NIimist7cGM5puKNSWd9TDiHbLFSSqPRVtfRk8M/RKIsW5ZXnvx9khBG3BprinTmnIkEryVwCxXJQNbjM3Ax2tH+ZbNIfEGp936k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190115; c=relaxed/simple;
	bh=epcpKe8yj0NKaYFPsPLmdQdot8jDpvl6IXf1cHdd0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr61i4yCgBMLGs76LM4EwfU6hm+g4LaaF97FCKYOUJLoIO056vSD4SLM4m27HddDzKTqmrUFYrlDFTQoZcVT9Y3eSlqYdTXLhwj5xFY508VJayVmkeR3V2Nl2zMYuzdjj0XGl/QkKPKnUl0/QSEl69EC2nsX4rGhYRxeM4MoY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnjg25tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnjg25tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64581F00893;
	Thu, 11 Jun 2026 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190114;
	bh=xchjfE3gMrrgjbrsrdL4aHW1st8qPcu/3Q9VKKaRxBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gnjg25tr/3OoWhyGRa8SxE9jL+d0HPeAzsSGQraCnTzab7C8SQrNrxylEeYWP+g91
	 NXO3PVSkVU3caqNCyiIgRIwTfVQ3BsdVVgawWp61lm4C6ULHqzEXDYzxhGpEUOr+r3
	 bJ4w86tGsR1RO41lM6eoW2ghaidmj8e1Hwy/4ka5Gcs1N7b7Ns35gZB0SxWQ9Z0gvW
	 Jat66CjqVbt3ZTcQpeEHzvdHQdSguv1RLhW5t7rbyju/dm080fCoqYdgB0DfCI83M7
	 NIcMDEKJ6IHrKZC06tFJg3itaulI8BOn9W29+3ZZ7duY3KodIXDaUFnGxy+S0xH5G8
	 jsSWu0fbxtk5g==
Date: Fri, 12 Jun 2026 00:01:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260611143710.GA375273@rocinante>
References: <20260606203022.743558-1-kwilczynski@kernel.org>
 <20260606212045.GA2380983@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606212045.GA2380983@rocinante>

Hello,

[...]
> > Thus, extract the bus procfs directory creation from
> > pci_proc_attach_device() into a new pci_proc_attach_bus() function,
> > and call it from the two bus creation paths: pci_register_host_bridge()
> > for root buses and pci_alloc_child_bus() for child buses.  These are
> > the only two callers of pci_alloc_bus(), so for buses created after
> > proc_initialized is set, bus->procdir is in place before any device
> > can be added to the bus.
> > 
> > Therefore, by the time pci_proc_attach_device() runs on these buses,
> > bus->procdir is already set and the racy proc_mkdir() call is never
> > reached.
> > 
> > For buses created before pci_proc_init() sets proc_initialized (the
> > common x86 ACPI case), the bus creation hooks return early.  As such,
> > add a fallback call to pci_proc_attach_bus() from pci_proc_attach_device()
> > to handle these pre-init buses.
> > 
> > Additionally, wrap the for_each_pci_dev() loop in pci_proc_init() with
> > pci_lock_rescan_remove() to serialise against concurrent PCI bus
> > operations, add an early return in pci_proc_attach_device() when
> > dev->procent is already set to make the function idempotent, and clear
> > bus->procdir in pci_proc_detach_bus() to prevent use of a dangling
> > pointer after proc_remove().
> > 
> > Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/
> 
> Applied to procfs, as I want this to have some soak time via linux-next,
> plus 0-day bot will test it for me, too.

I will be sending a v4 shortly, which aims to solve this problem with
a different approach as moving procfs directories to the bus creation time
has an unwelcome side effect of leaving empty directories for post-init
creation time, such as remove/rescan or when devices are added via
a hotplug, etc.

Thank you!

	Krzysztof
