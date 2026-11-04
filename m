Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815226;
	b=jyI16UzOeVhTIsUm7LeqDFfeRNP/T07YjeT93dCbgqAaI1XVrf5MhHGTFf0MU3DveDks
	 V6SLrT+gtsRc1TuKcezMs0Ar8iKJ4UKgq3Ax+ZSkJ13W3csm11haIfxyLXPNuePcQqJZ5
	 bYzQoXXwgxDVvrloHyxK9GwzykVhs+WG9Rp8fqTfV/coP5PEYrYucS738yn59jWDGCKkZ
	 snLPN1bJrWpkLs4Xrtxo4Xb+F/gevXc3/jz8JVYghc/6XErDVBnOBHirzaWIgXmAKe7W+
	 oG2ppHLomXiyaO++b2EYLgVtsbAC5X3ruquFfjVKAwUHwCEo39h8tPOcZVpJKPWZ4pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=;
	b=Xwy7QA3LiucifwCdqUXHfWOKiMyxHL8pwOpMI4Pdy6rwlUgRkAm2SCmSdaQBxfQhryv2
	 lUFlRgQBrR7t4DaHhpSHmWmUtMGF2SGZy0Hn5UCyuetpvWI0xO5QE746QdqBkkGfK23qZ
	 RMXIiLEE3HOXxeBoS32ZCz3m5L3fsw7rAZVitkC3CVvPYbQhvUihcHsZgecb9rY7517Rf
	 zL5zAeWMCHVar87UV9cvY5dARlrEalTbiOc44g4NejSo5o96GurG1pJMNV3RwLczepjCu
	 mExYDsa4seCyfHSjNPpKGHT4FnYdTo7IOt+JLCKM2EcTlN5w9dWZQjsY/aqId0+JtPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=g5iMOwTh;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417B6074A4A
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9417B6074A4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=g5iMOwTh
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso617202137.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793815224; x=1794420024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=;
        b=g5iMOwThX+uE+7xsUaGHYp7csSg/cw1QC0Zn78GJVNHcZU7wyhpKG7ije+QTRwPjdC
         zecPx0d+8hWLwKjLelfE4KxCT63+V2598YFacCCjm1WZI7lh1Dkl4ywNr552sqNsZfN0
         1D2oFE502NTv+ISi+I51HLtxJyZ+7UTOzL+27rjsur7LECqPVVL3e5hJ9+rcWX3BGctn
         hTVH/2y2Fy6ziFzdTOkp/akeK2x3V/pd1J1poAtcCCWbctt8AwcLGbTs3sIRXhWhbJFo
         S/CFPMAQnuLl3iONSFxM9KIU04d3YWS5O8kA3yxJkA5qXnphvXd2ZgSnUwc9FSBBfTa8
         ejxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815224; x=1794420024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAX2rOFX3ps0z7E54cgly2XJNYqW8YfGnVzidzlyKN4=;
        b=yVGqZ+YYE8ZQPCQVOuvO1ief7091+OnVuRN5ZZ3rHR6YCNg2ClMzzAW5A/ZJYyGKo9
         JlUlmW8cuRpz1VFY4tP5P3hpnlHCbl8ojZU1iXlxLrDaS91aaxaYR+yfCMCH8gAke2av
         zx0HB301mwx4+nH6QnO7O/iYbHvQagIybvclBo89DXDyiODgjSobOPpLtZewagp+GQ/R
         O327WhuGM1NZFywbeJVvQkbQrkftpWkuo2nc0OYouLOaXdv3QxbES2/8F4tnGfQv0/48
         MSX+WqXVHwKTL8wNxS2qBKaw1VOc1r5e8qHpDFgrEKZ9F7cG/IbHRZngrGdHuZWvy5GP
         4sgQ==
X-Forwarded-Encrypted: i=1; AKwUvBybvKB2oaWMvsTENGWTE0WiCl+v3T+6CfU0CR2BudFQLi7dEKaePSEkckdkwm9F8MuJQpBGeiENto8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k4vYY04+p0I+749YBSFNgP0Wx/VqyDWOSWh+RM9A2/E7LdOIe
	wmofUgPUm1XQ7tEhLaIr5Va0LmIrisk+orYe1nlH+WuL/yi5kKa9mbDELgi5HdOXEUo=
X-Gm-Gg: AYBFou1kQfB+ofd8vwBdh0uyaaC/bg5LaI2d3I1+a7GafHbrpBaWaS7qgwtN7KWICfd
	hlkgAu1GxSCOuzcAMtG853De6YFhMibcWNqba2a1amAJkSIeFuOF/wNT+1gwO/I20Ahmf/GrmDg
	U4ndg9AKENwRQ6T8t9ydtGutuo3orpDYuVTpVBuC/NY3wp4sMuKVDAIAM4TIY4aDdQNEp3AHKB8
	RK5r9A76ss4nJuASx34q1iufQgDC3nlWn8vDuxevd9t0W13acgjbnWvyrRGTfYk9yBdIfmQsDUv
	iwtiEuHbl1pe+9fyxwEGztId02OUaQKof4uUNwJhBhQZjbtpRxXzrsRsZ7ApjZaAEKNVz8X1r4F
	roq+21gJ/H8wwzCtJq9B6CThwEt2GFvJ+t4qIJGI4Esiye16PXXSRnsuF89eoZIv0MNPpyRoWCU
	xLzG+EjBysQ2hx7Ed/HbBJeq3aHuZtf0LACLNKXBZ4vYQCkzrZ6XiyFLnSLdS2aA+9ng3cepmsY
	Tiy3JIIe17Nhah6W4wTZMSoj3KeApOzm1NxT7MfRRP/iBKBmGgMsw2lG04p/MarvCgB9ytrVVnJ
	NK1G3bFqbbi82zfC4QJilwQsEr3n/Q79TOuYp2qozCr5T4Nzkr72TEf1sGvh2WCD6cJP/90KGSj
	/kuP1nvajFJ8ZkIijqgUAxqBQQJVQ
X-Received: by 2002:a05:6102:fa0:b0:7c3:9982:67d7 with SMTP id ada2fe7eead31-7d072670942mr7469213137.16.1793815224323;
        Wed, 04 Nov 2026 10:00:24 -0800 (PST)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm2383636241.8.2026.11.04.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:00:23 -0800 (PST)
Date: Wed, 4 Nov 2026 13:00:22 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <autxCZPJ9yiE2ucq@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013162529.1928093-1-dmatlack@google.com>

On 10-13 16:25, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This functionality is critical for
> minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> Specifically, this series allows preserved PCI devices to perform
> uninterrupted memory transactions (DMA) targeting system memory
> (specifically, preserved memfds) across a Live Update. These devices can
> be behind a bridge but must not be VFs. Support for P2P and VF
> preservation will be addressed in future series.
> 
> Series Overview
> ---------------
> 
> This series implements the following to support PCI device preservation
> across Live Update:
> 
>   1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
>      PCI-specific state (struct pci_ser) across Live Update using Kexec
>      Handover (KHO).
> 
>   2. Add APIs for drivers to register devices for preservation
>      (outgoing) and for the PCI core to identify preserved devices
>      during enumeration (incoming)
> 
>   3. Automatically preserve all upstream bridges for any preserved
>      endpoint. Use reference counting to ensure bridges remain preserved
>      as long as any downstream device is preserved.
> 
>   4. Guarantee that preserved devices retain the same RequesterID (bus,
>      device, function) for the duration of their preservation by
>      inheriting secondary bus numbers, subordinate bus numbers, and ARI
>      Forwarding Enable on preserved bridges.
> 
>   5. Guarantee that memory transactions to/from preserved devices are
>      routed consistently by inheriting Access Control Services (ACS)
>      flags across a Live Update, from the endpoint up to the root port.
> 
>   6. Modify the PCI shutdown path to avoid disabling bus mastering on
>      preserved devices, thereby allowing preserved devices to perform
>      uninterrupted during kexec for Live Update.
> 
>   7. Provide comprehensive documentation for the FLB API, device
>      tracking mechanisms, and the division of responsibilities between
>      the PCI core, drivers, and userspace.
> 
> Merge Plan
> ----------
> 
> This series will be merged through liveupdate.git, matching the
> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
> 
> Testing
> -------
> 
> This series was tested in conjunction with v5 of the VFIO PCI driver
> series:
> 
>   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
> 
> The full set of patches used for testing can be found on GitHub.
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10-with-vfio
> 
> Testing was performed using the new VFIO selftests:
> 
>   - vfio_pci_liveupdate_uapi_test
>   - vfio_pci_liveupdate_kexec_test
> 
> Both tests were run in a QEMU-based VM environment (using a single
> virtio-net PCIe device connected to a root port to exercise bridge
> support) and on bare metal using an Intel EMR server with 8x Intel DSA
> PCIe devices and 1x NVMe device.
> 
> Future Work
> -----------
> 
> Please see the PCI core Live Update Roadmap:
> 
>   https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/
> 
> Changelog
> ---------
> 
> v10:
>  - Save and restore the ACS Egress Control Vector along with the ACS
>    Control register, sizing the save buffer from the HwInit Egress
>    Control Vector Size field (Alex) and drop Bjorn's R-b tag
>  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
>    rather than adding the dependency later in the series (Pratyush,
>    Mike)
>  - Reword kernel-doc comments to read better in the HTML docs and
>    spell out "reference count" (Mike)
>  - Replace the version number at the start of struct pci_ser with
>    required_flags and optional_flags, and record the size of struct
>    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)

Hi Bjorn,

I am planning to target this series for the 7.5 merge window through the 
liveupdate tree, as we previously agreed. However, there are still 6 
patches that lack an Acked-by from you. I believe you might have 
reviewed some of them before, but the tags were lost during subsequent 
refactoring. Could you please take another look at the following to make 
sure everything is in order for us to merge the series:

PCI: liveupdate: Set up FLB handler for the PCI core
PCI: liveupdate: Track incoming preserved PCI devices
PCI: liveupdate: Document driver binding responsibilities
PCI: liveupdate: Auto-preserve upstream bridges across Live Update
PCI: Save and restore the ACS Control register and Egress Control Vector
PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Thanks!

-- 
Pasha
