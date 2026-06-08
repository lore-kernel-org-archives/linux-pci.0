Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69195399CED
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951868; cv=none; b=ocpdf7QeqCthtiCEXvXGQttjY3cd+4c6QS6LbTyPcWGN0mUbum2im+6qXVI1o7o5gJXHA2YPzp9uk/s7Df10pUmqOgtBM8L/jlPDIS6gy49LVuvDpo9B+/BwImCflxUeaxCxqIxi6/roqv5UiJ7JW+y+Mp0tTupYjaUyu8Qg3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951868; c=relaxed/simple;
	bh=RgrBSzRAxPq1hTiEITmRzTE416WdMM+7VkSjXwkwPk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0zdweDpPosGcBLU9CRkVh8y//KJELZcN+sQPSUFlhPMXMLq8AvRCPkF23cYVsiKsmO6DmGcwqoC62ut+xALvZVpsj0jW862Ff4DVVd2w4wqer4X8nmmRVvK8/MIQ4XkaUsgiIMOml2OGzX0SEV3S3n+a2gvcg0H2djcICqkmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZe/h+O/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZe/h+O/"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85b2139015so1578397a12.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780951867; x=1781556667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqANBGSP00mnERvECbdyBZ/QnoUicIMj2Z9x9A+M1D8=;
        b=eZe/h+O/8Oa/XTt7FeXjKP9js+XVO8RqJQUg68yRxQTmgI50v+Q+NGutCCzPtthJL8
         RqKn3xUkoNpsQtW8Tb1nqfEOWLd4dFgts1suLFyvf+baW7TKAlV3kiZBrj1OjcMe8TVm
         jqe2KHIm0dA60iVTjn10RS439nJYTL0Cf91F4+1QJUilaaxZQSf7RxDHySgniJI7aHAz
         s/xZV5L2ItrQyLc3RHU5+HL2RwdfzkscC2cP4HTC77zdEFMA+V/9OjsitA8OZtIesjo6
         3o6MeQ9iNETHAHIYxu0qMgShoZGKtyQ+11xUo9fGe/nyA2ZMKqBzMMX3KL4oasN9H5GW
         RMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951867; x=1781556667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqANBGSP00mnERvECbdyBZ/QnoUicIMj2Z9x9A+M1D8=;
        b=jMkcn1yT4BpsIo0l56J8Zmb+oDjYDN8d/QLnyKNYrMPrOUeWNE3rxjG1o21Twd3xS5
         yNXIJjz2C8gnNXfuptqE8RpptbYlewWYGLNpk6EM9A9HNxERGZrdrOZeDrHXKbHxpAe+
         gfJ/M+9weeJUwGxsW/mJi6n0Ceoxpk3WL06uH1h7Igz71ryarxsMQnx5ay4g1n1KSUKW
         ZtVTnXk7Zw/pYLOsDDypmjraeWEUrmQBM5k4V3rLpIQ8yj00+zE+K4LY1/KSf3+gfkA0
         4NT8gIylImUXi6vBrNmW2S7b9gFpZnHB8Egrz1g7+3AzpTIua9aff8HXq/jWvyGZmoA+
         lqCw==
X-Forwarded-Encrypted: i=1; AFNElJ+SNJ+vAqWdMP0kLN2D1PS0O0Yq0py6R/G8+LZQmjxZHKOUNY+reHcDP/xNFLLTK8azeVSKFdtKgXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2e+bxGUhSTZc52eRJq58sSabfRJskYgphQsmvOFB67c61OLR
	hQjOcVttPrBvta45QT/mkmI+dc0f39wLfRrOZTTNGCuQuJs7D4ZCu58RIhSxjuU4lw==
X-Gm-Gg: Acq92OFuWboA9iICA3a+K1CASf+1ldCIaZMlreVdd3/7W9GUPUVYCcwnIX5SPQeQ64r
	yeDmLErvtaTUjf2oIa144yyZlTUCkI8QWRuIB8JJdJ/pgXCQaDnpBzbwLF4LHghWGXluT/EfB5K
	aWgNGr0Md5+4haU9vktei+X36ZjabIjcDQkRbKFLsSIh70HsHeVNoau9C1i9vGkl9Je3PRvB74S
	Vy1p+a2iUIPK2UsUwcIE0mqzdmdPtz1ndVR76HExr8s6dauIQQrGdIu22x0KiuGl+mtBj4F6Jnw
	UbzRAxtbR4eyS+5Yx6JRlY4AQKibzCZlszPuDvGw3SLX0Y/+sb+GNNnp3kxEWcs4urNr/ojvXE6
	HeXjB3hHmAccyMEV7OSeZVyzGEHpj2nU5H3rEMk7VudPLXng5hC5osIdWuKYo9nxANPR/b5dSJw
	GouNxtml+0Bjs2w4FcgvDC5eM6MqLmCdeiUtYLcMfdqqyS92aNUg6j5TLrd/o1yGrCLE9ZhV8j
X-Received: by 2002:a05:6a21:a38b:b0:3b4:904f:c9cd with SMTP id adf61e73a8af0-3b4cccffc4fmr20088541637.6.1780951866181;
        Mon, 08 Jun 2026 13:51:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b315esm15840734a12.26.2026.06.08.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:51:04 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:51:00 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aicrNNVrMBtJD2iZ@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <aiJhoq_Yj6-1Hl5r@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJhoq_Yj6-1Hl5r@google.com>

On 2026-06-05 05:41 AM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:23:59PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> > 
> > Preserving PCI devices across Live Update is built on top of the Live
> > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > expected to expose a file to userspace to represent a single PCI device
> > and support preservation of that file. This is intended primarily to
> > support preservation of PCI devices bound to VFIO drivers.
> > 
> > This commit enables drivers to register their liveupdate_file_handler
> > with the PCI core so that the PCI core can do its own tracking and
> > enforcement of which devices are preserved.
> > 
> >   pci_liveupdate_register_flb(driver_file_handler);
> >   pci_liveupdate_unregister_flb(driver_file_handler);
> > 
> > When the first file (with a handler registered with the PCI core) is
> > preserved, the PCI core will be notified to allocate its tracking struct
> > (pci_ser). When the last file is unpreserved (i.e. preservation
> > cancelled) the PCI core will be notified to free struct pci_ser.
> > 
> > This struct is preserved across a Live Update using KHO and can be
> > fetched by the PCI core during early boot (e.g. during device
> > enumeration) so that it knows which devices were preserved.
> > 
> > Note: This commit only allocates struct pci_ser and preserves it across
> > Live Update. A subsequent commit will add an API for drivers to tell the
> > PCI core exactly which devices are being preserved.
> > 
> > Note: There is no reason to check for kho_is_enabled() since it can be
> > assumed to return true. If KHO was not enabled then Live Update would
> > not be enabled and these routines would never run.
> > 
> 
> [...]
> 
> > +/**
> > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @padding: Padding to naturally align struct pci_dev_ser.
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 padding;
> > +} __packed;
> > +
> > +/**
> > + * struct pci_ser - PCI Subsystem Live Update State
> > + *
> > + * This struct tracks state about all devices that are being preserved across
> > + * a Live Update for the next kernel.
> > + *
> > + * @max_nr_devices: The length of the devices[] flexible array.
> > + * @nr_devices: The number of devices that were preserved.
> > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > + */
> > +struct pci_ser {
> > +	u32 max_nr_devices;
> > +	u32 nr_devices;
> > +	struct pci_dev_ser devices[];
> > +} __packed;
> > +
> > +/* Ensure all elements of devices[] are naturally aligned. */
> > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> 
> Minor Nit: Shall we consider using specific bitwidth types here?
> I'm wondering if down the line another u32 field is added to 
> struct pci_dev_ser.. in that case on a 32-bit machine 12 % 4 == 0 but on
> a 64-bit machine 12 % 8 != 0..

I think natural alignment is what matters for efficient access of the
array elements. So failing the assert only on 64-bit architectures seems
like the correct behavior.

> 
> [...]
> 
> With the nit:
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan
