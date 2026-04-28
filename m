Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B038838C
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420305; cv=none; b=l9LBiRVXev1AUF07xkp5IG6QMIwNUrGjZQQogaiC3Xi608GRu/DzJ8AE964SzT5IfD2vA6o1vKyXg4B+fvRTItEHEoRnMZF5AVsT1P6On33GPz8xGvcRycY+q7YyzfnYqy6m5cDwvh6KU+3pa4yIaVdEFK7pT78RqcboLSHCotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420305; c=relaxed/simple;
	bh=PzrGjnYnqw4935qMxbE++jGJcpzbiv9Qu385mNo68Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPrFQAisyB/QqJVt89o+6bhspZb/nLGV9WB5vj2/guM9TeZn+JUWAihL/t7N4GrKw9eoNiX1WA+1L6nF7FjqiWKBfsht2z7xxOaDEJ4TDq5ITcR0OwjN49MTUEL6tNOYb/8lEsQS8RKQgMPkYc8i10Cla085a2Zs4qykOcX3AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veJ52o7X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veJ52o7X"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b45cb89f7eso74796455ad.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420303; x=1778025103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=veJ52o7XgBTZD/d4gsn74d/L9Fe/9u1lhdwWWDUdMNRjuwTZ47RO8vJYkF6NaMe6hC
         1wp84OTcSepUS5CpdqRar9FfLrAwyyKwJ5CPifdUNZMVjV9yUfgiczorXrhs/DzK9mMS
         3DcXfbfDbKp8cnNCJE1tEbMzE1NqlqcNyfPb5puyT9N3d3r4STq1pgPVZxof7wOWgELM
         hs6ymFWVJJknOKNQ1XD+miCCzH7iozy3IzAeCI/h+89qcgqNmOElz+jdg8+1HNIuOeqz
         93cYPHfeQBPhR2P/9gkmu/B63A+ugtPTYnKvAtYJXGEpGqs0U3AZ1ecgRx1j57VdEgBG
         T13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420303; x=1778025103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=gTgDu3iTpg5cevfO65IQsI5DVSPR4gEm+qxPk5O9RtWNl01iDJpZ97P00SXGvSjtPg
         sdG6yjORjEDErW5o6+ulLMf8UXjPjJUuzr8o3Hhd+zG7fRbFBBdPFesqXeS0OWCkorhw
         BzS8uwI6nBLgDDCVUrOWmyiYRVBu3CFY3fL2bUoxSHbjGYsOAq/F8DoHGuqpR8+hIaks
         Wb59IKoaq3HY2GijnBEEt8JsWYO9VRIqQNYD4MUntwJE2Dllf7qs1TuvBdajOJBeSiqe
         vRbKD+N3mTGoWWWpfAUSh+7mDM4eiQctFBrMvjBloHnKyFnWNvOlHNl9gu+RwslzDAZz
         wRkA==
X-Forwarded-Encrypted: i=1; AFNElJ+jkysEOkIof8LNCj30a2iQ7uP2nd3yJV/7zVIpKxascw4cu1KHmoDWvwvtuGfNiVT3KyOkJF91Qa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaD/hY8z1A4G/5ghjTbiwcxrw2wEtshxskIHbFiixFLr7U3k5s
	llWfZRA8AddD9FrEQlhFQ7ekzykwf/sCujWA3RdhZWHZb+UoVriHK8CZkHcHo7HKUA==
X-Gm-Gg: AeBDievFQB1FYLtQtZfx4DTuyOQE4eVdAr759YPPlUgYPbVyNe3QIMGru7WsEdW/5Py
	zzkhSotBEQwcm4bhwGOkFk86/4hsrBkK5+EOb/kcUOZvGLZiZ8BflFh+jJtHOpH/l76nA1mq3AR
	0eHBxh9M2qexEpR6Fs8L2yqVTMo0PxCwvjMTfDx3mybd3E8upa/oTOSX/NzJ9/OYydazcZAdOJg
	2KxaSjAU0463ZwEVmqRZziCHNRRyxqFz5iDIvi83uufoqG2Kqu8cL9ILQO2AWCahsjSRNpztCtu
	TnFi9D7mfztZrYvSLdl98/vwKEuY/Lig63jnxLvnY4Fcjb4hAfjDP4qzJJ3Bo0yq0SG3YyACxkv
	0oEFxzm7V5N4VyqW7bu3LXTi7L+8M8GBGE0NcW6V6DXKdq99qx7KQ21fyRxx3Y0pU/THBrsbyBT
	mvTlsBWhYerFXRmmQrbAz7iszzjnkDwR0Om74/DaotcRqlMwQlOwwsOf8Pt9IBk97/CSfeYoIgs
	ZsG5A==
X-Received: by 2002:a17:903:a90:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b97c4c8995mr46570035ad.27.1777420302688;
        Tue, 28 Apr 2026 16:51:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98859f629sm3480345ad.0.2026.04.28.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:51:41 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:51:37 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afFICT9mSL1XG0v_@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428185242.GB3825533.vipinsh@google.com>

On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > +		 max_nr_devices);
> > +
> > +	ser = kho_alloc_preserve(size);
> > +	if (IS_ERR(ser))
> > +		return PTR_ERR(ser);
> 
> Should there be a similar pr_debug() in case of failure to denote that above
> "Preserving ..." message didn't finish, or, maybe just print one
> pr_debug() after the error check above?

Hm... I guess there could always be more pr_debug()s but I don't want to
instrument every error path. I could move it to the success path but I
don't see how that makes it any better.

> 
> > +/**
> > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 reserved;
> 
> Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> just change the array length based on the need (0, 1, 2, 3).

Sorry I'm not following what you mean here. What is the reason to rename
this field and change it to an array?

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
> Nit: Maybe move this assert to be near to the definition of this struct,
> easier to find it when editing the struct vs finding it later during
> build.

The combination of these 2 asserts is what guarantees that every element
of the devices[] array are naturally aligned, that's why I put them
together here.

I can move it up though if you think it's better.
