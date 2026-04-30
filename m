Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E015B0EC
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574908; cv=none; b=fbIqVcG6f1ODQYRvsIupy9O6rlGM6vbOD4GIGqNjBDdPihn+BOYb1T9mESx7ikYR+9CEyjopcaSOh9ajMFAv8/LEz2xGDrOV0+CG9aEc8hhG7w2wnZsVvS3MtDBSH9IKrId7b2fzzAPgGKvxmn583r26ofbNE9vYv5jylyJ51qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574908; c=relaxed/simple;
	bh=oOCA6r5C2BmuUW8Nh03N3Y23igUJA/x154m57C9Gmrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6Fel2WKIDCPOTRRj8ZwF+p/eJhcM3f4Pabi3TbeCYA/qepzDs3xW/GGQq/HJN9v+6ep610Sh6Gmh7trm4Qs5lKESCctrYm9miy4PXzyFMIadOC9FDDBeB4rrDXT6INGm9fIUfTtfqU2ZEuiAjddASUqpvKeGq00bmU18zItjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXG6muwT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXG6muwT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b243198058so24585ad.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574907; x=1778179707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=FXG6muwT8CW2xQ5uyU6zFGmU3s4eGPuMZADtION1e+h++0ks6a0kAFdLE7skILJ2Bq
         eGo+4lSboHx64gSLBk+xIz5eVkBteWoz993tpGo/ZunCoiLZpFELkl/9z58tkXVGyOPL
         Bg8V5EOS8+CIrCQ0POr7jp4GBPzceF5KrBypalvCMyglGgS3IxQRC9DwO09J2hMy+uqO
         nsk6dAXnmrNF53axhVXgz1G05FkHcMJ6lh8mAus/k4UBqoVb1hwnnjC9QAcC8o0v6giT
         Kwq8bcBuJxdVT8vXcqp203o7DP6FC7YMVSaJX5hWAYiyHwM3tObDn+QH6G/VdkWpSMLL
         AogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574907; x=1778179707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=Ck6btg0XsW4seixDXR+bMfGYabBrnUualdwoxpXVrkJrZNkumIFVG0V/7/l02fcR8s
         5e9GBbtCtn18JgETJseP2nsLxcDzr3LoJ/O5n4nsNdSB7qGkgfrM80fZhpxlxZNjHxP5
         aIak2VffeXIwgLHdo7v8s/pyTKqTyNyX1YPTOggKH8ZJiBq/tiGTGehQDuw/J4VHvqMy
         +ZWtFIlK53tF5VoO1JSVEqm9kOsA5uyY4Ab7C5iN5i1JVIlC1qZCFJI2dqpBX6bkDGm1
         HR7lprIqkiIMmcR1ALb/yRxBJeMe5VsDWpi7FdCMwGhbnT1M4Yddl3/8K+0Fb/JkBKtG
         xJkg==
X-Forwarded-Encrypted: i=1; AFNElJ8ixUkQN7gprJBf9Br+hC094vFG9VSYojI4gz7vYLFccjkKeeDdZBjWNfEe9+9FzJ1NgbYndu+qmlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3pw46chdIGVJrid16JjPdjiFno8/0jlN0qJplk3TlbjNbPxX
	t5ljl5CDhAI/fcRAZja4DtnOEGVphb/CDPHuCG0MRfVUTTJswxKxm7n1lSthdoAPYg==
X-Gm-Gg: AeBDieu6JaNz8VffisAOoBm8VEwgM9QyY8Q0nUbCFj3Tvmk2qgK2isQZSQaacsy6q29
	A4zDTUPhpySNKXXextXFd0Tqv0Rf1afR/YoGHObIP50NRL7XmEDVXyRMA2WkxAUpeZ+6OGzybqG
	KHhNx/jlrZQaQzy0uRkkXxE5RAL9KtMtsKIZiCL2Hsnw7blt2L50B1rgHixy8vFCNOhfCBxu0PR
	EMG6iNYCmIBghoAmp99UrYPiVWG1KejHE9+qRE9FFEXsxNWkpEEV8sH/MOoUdjOjlZAgB+b7lSb
	MYuGrfX8xYt5Qd1NHT4apbTVDwMcVTLA9eMiBXTHmCKzltJ8BOSeStwmqvyXMF0QO3qN/39NS7J
	hPQ25ibNZ6ma68EpkZ+ivGGEcNXI+zALqesXNpfzjplnxKXP9iu8i4dknNUnxdOyiSX/tHpLk6C
	1zPfpAG/+k6m+JLGp7Vh3bngxHNTp1pS0s38CMXGDY1T246P8FSq5+BJCOcb32wzrBCcVh0rdgW
	xTvLVgP1w==
X-Received: by 2002:a17:903:4b4f:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2b9cd98bb43mr418175ad.14.1777574906266;
        Thu, 30 Apr 2026 11:48:26 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e47asm3289405ad.15.2026.04.30.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:48:25 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:48:21 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260430182532.GB13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
 <afFICT9mSL1XG0v_@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afFICT9mSL1XG0v_@google.com>

On Tue, Apr 28, 2026 at 11:51:37PM +0000, David Matlack wrote:
> On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> > On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > > +		 max_nr_devices);
> > > +
> > > +	ser = kho_alloc_preserve(size);
> > > +	if (IS_ERR(ser))
> > > +		return PTR_ERR(ser);
> > 
> > Should there be a similar pr_debug() in case of failure to denote that above
> > "Preserving ..." message didn't finish, or, maybe just print one
> > pr_debug() after the error check above?
> 
> Hm... I guess there could always be more pr_debug()s but I don't want to
> instrument every error path. I could move it to the success path but I
> don't see how that makes it any better.
> 

In current way, it is printing that it is preserving pci_ser, but there
is no indication did it succeed or not in logs. If we are printing the
logs then may be complete picture will be to know what is the action and its
result.

I think moving to success path or printing again based on the failure
provides assurance of what happened. If this gets printed in happy
path, then we will know it succeeded in preserving that struct on
kho.  Absence means it didn't. 

We can also remove pr_debug(), if this is of no value.

> > 
> > > +/**
> > > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > > + *
> > > + * @domain: The device's PCI domain number (segment).
> > > + * @bdf: The device's PCI bus, device, and function number.
> > > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + */
> > > +struct pci_dev_ser {
> > > +	u32 domain;
> > > +	u16 bdf;
> > > +	u16 reserved;
> > 
> > Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> > just change the array length based on the need (0, 1, 2, 3).
> 
> Sorry I'm not following what you mean here. What is the reason to rename
> this field and change it to an array?
> 

Having a padding explicitly tells there is a requirement of being
aligned. Reserved sounds more like don't use this u16.

If someone add more field down the line say u8, then to make struct size
aligned they will need to add another u8, u16, u32, and name those
fields padding or reserved. IMO, having a u8 array named padding makes
it easier to just change array length as per the need.

> > > +} __packed;
> > > +
> > > +/**
> > > + * struct pci_ser - PCI Subsystem Live Update State
> > > + *
> > > + * This struct tracks state about all devices that are being preserved across
> > > + * a Live Update for the next kernel.
> > > + *
> > > + * @max_nr_devices: The length of the devices[] flexible array.
> > > + * @nr_devices: The number of devices that were preserved.
> > > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > > + */
> > > +struct pci_ser {
> > > +	u32 max_nr_devices;
> > > +	u32 nr_devices;
> > > +	struct pci_dev_ser devices[];
> > > +} __packed;
> > > +
> > > +/* Ensure all elements of devices[] are naturally aligned. */
> > > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> > 
> > Nit: Maybe move this assert to be near to the definition of this struct,
> > easier to find it when editing the struct vs finding it later during
> > build.
> 
> The combination of these 2 asserts is what guarantees that every element
> of the devices[] array are naturally aligned, that's why I put them
> together here.
> 
> I can move it up though if you think it's better.

Okay, SGTM.
