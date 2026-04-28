Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E693A1699
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405556; cv=none; b=e06P9KxvoSrmupI9iD+W/QkHpnOIErZs6IL2NY+iCSxG7QaDcPIerBpPJt9HdUO/xoqkF6s6sumiXPGmPRfwB7IufXYx0JpV621HAg6TNnbAxQzM9C7DcIs6atiUFl2CFmIayzBmXVD/xFMLwNgjp8WtMgdKVGF40X+I7AcxCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405556; c=relaxed/simple;
	bh=t8AW6SfVnUEhN9bd4oWyayBPAuaNupHqxJT75tRMt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORv5Z1inHScOyQrGLpEeMGCRu+Sll7KXmdGRwbixz97swNRKqTAr5AjnZHKWm57SHaPvmFqcWt8fLCaGlG3KEE/YWZB/FdP+yTuWxfY4q7rsA+FVR29cky+8cJut4Xz1cqz9hfnbptoc9mq5xNQFXpMRmmp/t96MP3rxWjscebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7rXAzuI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7rXAzuI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b243198058so9895ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405555; x=1778010355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=j7rXAzuIopXfICtqgp/ZJan0JfnEJ7zEkstANUxVM21Uuga5qCAV6MwQVkCgyLxuor
         Dpa/clbfZjvgEnd1zQfYb0w/xh/lYhPZST6e6tyFi8bert31JEkJpZG1/Ph3zFjsLre5
         LtAHX0LRfMpLxRoDbI1aoJwvJwbSFheuA41HXeSLwwiGh9nPlMsrj1E10ag+UTeznf5w
         T1UO1i9kHRwuSJqN6uCjfEUO4JOIMw12cNFZpncjabEG4OusApRlwtqLsXC6FPoLOSnM
         XgOhQP68WfRSBvK6kwu4RmdF3gEb+6spSDanTt4AFoa2ZZaqWqDA16QeGKPlwd7XkdY3
         lmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405555; x=1778010355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=Qsp5D2zlJ3RecKIu6k8+3tZXDYRtimHcDbqQUikcmuqPE+xd9uqNTQDZ1hMGP63nho
         PCqPT9LsIxC0VkWPCRR/oc9uq+djfNGEfNSfLxcksG4V8WfVuyYoEEYcWEL/oBPyua12
         /wtPtMgUEzXB0vyk7vldFQZWVs1PhDLl/qTeayJjANIZRgi830d0nl22cT3qFD92fjhe
         or/SqAX3u+8Dn17lREjkqCt0uP2nS0Ybbl/5JM1MrKnDdlRwYM9suqPNTH4Rzn6S1MvA
         HV1rNLOYbMHVdXyq6xBcfr3otKdtmHk333J0T7wN5oTy6pIi4GkaoRXzCYP4ZaqxVm+T
         S+/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/P9GVdDPkWnWLk1DmXAzXoWey/UAjvRTKJgkrwXdaYJqljEhBxWkByXiGKNiqv0K74JDX8ENVG1/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUwcQ2cAPy1vUS/a9VNSjOEix723b2sghCE35XPBFfwQkb0m9
	VnDm8+ksZglGZFCF4qvtZKbxRQQHuisAgQw7z16Dob+GXuzMn8RurwrPZfk5wscVfw==
X-Gm-Gg: AeBDieuW4DCxHPw/RNSXB1x3IHV7WXRPQ1SRiuSL8gDagy+hpDtYCdDZrM+ajq30Z9t
	MF/vlj/Cq2ZsYPMZgV+/e0Jo7MmRL8hB+kvFJEfbqpLwhqfvkloutMSKq73yvB52utLFJp6Lscg
	EObUTKJfXJFxfYTJqHOcqGET993hi30r35crL3PsSHGwCJDFJVoAsM9FOyPosZO+69wPav2EBHB
	LktEfpglyY0MQCNsIQPXJwbZwcs8e3C9bYH+QP97ozuNbjBBtqXbjovTb9kGQ0vj7ZNXlHSXRaU
	ERKFojtlcvFEK+FbPUY+/JfvGAt8kCjmmo7+Z2pnxONPaAXkarjwq6pWTn3fb7zGUnKkx8qgORp
	VxIuKfsCJhybLmbGVHrZrFhDgUrRgnyLHRne+R3YywooLJ88UVlFT+TIflcWh/GVAuOFWsOnAMd
	squ12ZWFzxZskj74WCS3r6JxZIRibhFN55xnjr0TWHio9BsRMfj7W0KT72kjF5MAKnnzfbFU9hq
	/NVsb2d44nhiJIJwA==
X-Received: by 2002:a17:902:d58a:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2b987eb5398mr770645ad.16.1777405553961;
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2732502sm41657a91.3.2026.04.28.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:45:48 -0700
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
Message-ID: <20260428185242.GB3825533.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> +		 max_nr_devices);
> +
> +	ser = kho_alloc_preserve(size);
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);

Should there be a similar pr_debug() in case of failure to denote that above
"Preserving ..." message didn't finish, or, maybe just print one
pr_debug() after the error check above?

> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 reserved;

Should this be renamed to 'u8 __padding[2];' instead? This will allow to
just change the array length based on the need (0, 1, 2, 3).

> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @max_nr_devices: The length of the devices[] flexible array.
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Flexible array of pci_dev_ser structs for each device.
> + */
> +struct pci_ser {
> +	u32 max_nr_devices;
> +	u32 nr_devices;
> +	struct pci_dev_ser devices[];
> +} __packed;
> +
> +/* Ensure all elements of devices[] are naturally aligned. */
> +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);

Nit: Maybe move this assert to be near to the definition of this struct,
easier to find it when editing the struct vs finding it later during
build.

