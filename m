Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A9407571
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638127; cv=none; b=P4Ax//8dmbRrmhFepI0DM6/8U6jQGiOqsC1vORSTekc/uqmAsJ860Eha0nA1zc1pa2/FfP4Efl6KqPbEg7K7CerytruJ/L+hUyqxHbZessKqmQiM4IUNfWzuU836ooFb5b+aEDy6efuD3BNIecXCDqiuYWKzTpsLmmOwkBvBXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638127; c=relaxed/simple;
	bh=vyPxlSjO6tbgGdJvKWRY97zHRXm672uv5NrREWHPfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCa904zGmsV04/jjddvtycpqTZL/jYMzCHAKoRp3gzfvF9SxW4xkQjJgJjk/+17GPKQvcU475a+1qZicofyNv9hAAnfK5NSLE/BY2I3h3eWS+95rOyUruW9AVrUZ31l0HcXfZrb+LZ4C6p3HfTUcya5r9OVK4Hq3p3u6dkE4ByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUEoaGdE; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUEoaGdE"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137ff9a7d5eso6095c88.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780638125; x=1781242925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbv0AZ2j24l1SmU6m1H5V7hzpCBteEa/IZu6sKIRnTI=;
        b=aUEoaGdE5xeLiqjFRYh8R+9uF57aT6yN6Bzoo6hn+5Jd6ygxas+pD+2/fLa/CGCCY2
         W2BeRb7mx0nbIVcSEJVAmkmxxOy59AorDZS73yj5E/sthVK8wJgIAS1G/8Dt4X9vGK1w
         KNj1asIlSXKf4u0dSiaYC77XUxR4fDydKpt1G/XiWcSdokyxRJXd+Ev1rtRxI9mVh9LG
         tc/9FHc9+Qhj2f5r+aF9IhNY1ULFC2dRPFADPzeYvVrz3+3Hvb8D4noNwDAOOkHfnp9v
         O+0bHnFE80/zfpN2CK8Wa81Td49lA8p6jk0pk9sjEEaTOe3xMdSR9JzFeXzJUsVLdCIr
         PXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780638125; x=1781242925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbv0AZ2j24l1SmU6m1H5V7hzpCBteEa/IZu6sKIRnTI=;
        b=fvUxweZGaPFI9jROss31qtys0ckZgkbVnZvnGd3IZ0vJ6yg7nozFAUVEmUIvGof5ON
         JR2r5IMDFy9ZqfMTsLyRtQnjIRKRg+x6kVyxPDgT3abwb/h45z7gl1RMlTaYHYPJbB8p
         bC0CH5qEgBGB5vu9u/bmr0GJeweReIBBRy+Nlb8rwX2Qfhr5+EwM7niGXXT7Cqc9gjXP
         7yNE8hufxXJU9KSZqPbfe3P0XMIIotkQIKgn96naFLR4ZZtHEORKCiW1nFENIpPemIdE
         26+9bqNZADqL4y4Mhz7+wHfpS/xK/TH9DZ/vE2dxGo1jkxDxF9cqCXzeyX3aq9GoMdZu
         BGSw==
X-Forwarded-Encrypted: i=1; AFNElJ8vgMq6LDxMU44H4Znvzgd8CYodjw6713su12MvH0LvT0xlNwzVZy+H5suS40VxBinanFY4/z3tAs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXV+PfH9VTDBEDLvzE6tRaeueOsPhm/lBFbuiCLH4NYOkO2LG2
	0hFwBa+7ZWbOdyEmD9AHXacnmz4HT1gEwQbvbPWAMz08y4xypCGNJitfh9HuQLGipQ==
X-Gm-Gg: Acq92OGMprkwGzylbPtshgnzpR87u9RtwFGKz2JcSRbXodIcCqytkA0tpdnL67qBZHF
	cvi32BX5dQQhoMs0RKRzMLIFZu6IMwtXN8oY5i9TD/NB6+4HZfuCFcXoBcEwyMzDR5Zu1ZnXda6
	OX0eOW/N7OCpZ73EJBEEL443Jm7aMLPcPmq677HGwomdSlcoj4/ESf0x8yJcWuO1rCnikTo/a+T
	pvxLQv4KDVCPfqppW/n6VwzjOIYlgeSQOJ2Wqqfx/cuYT7kPwMvS4her9nSsQ91nhoXq8nmNh0W
	OftTpUDJwguzaIrWXdN5ZbNoguEwn6Lb9jBVn6c7nUhAfnU5a2CWYtgK6mxDg5lj8RfACHnwtyt
	jCGODVdoSObnm7R2itcMwJhLVy2j2WzXRGvDum1pVX61V7Haq/oTAuTOnnFtG30FdslUSXi1w/g
	ldSiAH8NZEfjHB/HsZqhSR2WePluX5kK8Um5CKXiMn3ofNZ0cOpo3YVGtI13esN+eiHKlA0qg=
X-Received: by 2002:a05:7022:107:b0:136:d02a:67ee with SMTP id a92af1059eb24-13807cf45e2mr63052c88.24.1780638123822;
        Thu, 04 Jun 2026 22:42:03 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm6539103eec.17.2026.06.04.22.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 22:42:03 -0700 (PDT)
Date: Fri, 5 Jun 2026 05:41:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
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
Message-ID: <aiJhoq_Yj6-1Hl5r@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-2-dmatlack@google.com>

On Fri, May 22, 2026 at 08:23:59PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> 
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is intended primarily to
> support preservation of PCI devices bound to VFIO drivers.
> 
> This commit enables drivers to register their liveupdate_file_handler
> with the PCI core so that the PCI core can do its own tracking and
> enforcement of which devices are preserved.
> 
>   pci_liveupdate_register_flb(driver_file_handler);
>   pci_liveupdate_unregister_flb(driver_file_handler);
> 
> When the first file (with a handler registered with the PCI core) is
> preserved, the PCI core will be notified to allocate its tracking struct
> (pci_ser). When the last file is unpreserved (i.e. preservation
> cancelled) the PCI core will be notified to free struct pci_ser.
> 
> This struct is preserved across a Live Update using KHO and can be
> fetched by the PCI core during early boot (e.g. during device
> enumeration) so that it knows which devices were preserved.
> 
> Note: This commit only allocates struct pci_ser and preserves it across
> Live Update. A subsequent commit will add an API for drivers to tell the
> PCI core exactly which devices are being preserved.
> 
> Note: There is no reason to check for kho_is_enabled() since it can be
> assumed to return true. If KHO was not enabled then Live Update would
> not be enabled and these routines would never run.
> 

[...]

> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @padding: Padding to naturally align struct pci_dev_ser.
> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 padding;
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

Minor Nit: Shall we consider using specific bitwidth types here?
I'm wondering if down the line another u32 field is added to 
struct pci_dev_ser.. in that case on a 32-bit machine 12 % 4 == 0 but on
a 64-bit machine 12 % 8 != 0..

[...]

With the nit:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
