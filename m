Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C537F319;
	Sat, 10 Oct 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621828; cv=none; b=Iet6/PQiImA0NUlGphp7ZtEtrrAxrnlWVOwZEDTTvRmkOWZ8FZzcY+3qtipMgs+s2+u0jyqoSQnKV8ucWcuEAJMHeL524QT28W5WnY/kxT7gz9ZiJK0neP7Nzvu6mFjFYamcJGtBfHg7xFBAGvSGZM7zzCeGAVz7EtBSg8CXmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621828; c=relaxed/simple;
	bh=htob2w2OihWwsimbkfqGmyw+ABRCSI6vnSUhFAcytos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRqjrwtUGARsTjw/hzkM4Ea+jYLnk6+N4VuAiRNpmXiKor4nrU6RxizPvjN6rUyqSBY8vtqfEqgn/PryUE1t7iVnA+9hT4uVil5Eqo7JuXZbXS+H69pTn6b+3tG5LTBqNFtA/Tn3muOIPsD3/lsYI8JU45mo3joCdD5CKzRu8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjJGCDC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjJGCDC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5161F000FF;
	Sat, 10 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791621824;
	bh=EMhRMdEboRulS299sQmhaXW+YI7ZYoe1z6XHEW4vJjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gjJGCDC+KFlQQ26bxZqDLXuKbl4aNueNBLvuMQMHUN4tKQ0Ex3Ln42ZwAoFIzAPhW
	 4n4luK6SIuM55oNlIsJpZApLqeE2TcNDmj4froU2AjsK2W0MfdHtxRKsZbuLyGEhnX
	 czgWTxN73f/MgPDW8s24C0QrAl37lsiYNUj/m8LXdd5+OhLL8P7eUCdXlTir4zjR/4
	 3G8vXsxdlEo9OJKIS0nL8mr+1S4xUHANWrW4NdhdvZo3BcyyovSeBrZAkVJx0QEFNe
	 Q2xtPUfHiVmAES+sUYYsLsnH/jsVgcxjYijX4aOkIZNR+jDTVqPHrlfovDe3tAClzu
	 2CHSoRoF4KnIw==
Date: Sat, 10 Oct 2026 10:43:32 +0200
From: Mike Rapoport <rppt@kernel.org>
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
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 01/13] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <asn6tKL72RXItqMD@kernel.org>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-2-dmatlack@google.com>

Hi David,

On Fri, Sep 18, 2026 at 08:06:27PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
> preserve its own state across a Live Update kexec.
> 
> Preserving a PCI device across kexec requires preserving two independent
> sets of state:
> 
>  - Driver state, e.g. everything vfio-pci needs so that userspace can
>    keep using the device in the new kernel. The driver preserves this
>    itself and the PCI core is not involved.
> 
>  - PCI core state, e.g. which devices are preserved, so that the new
>    kernel knows not to disturb them while they are still running and
>    doing DMA. That is what this commit adds, serialized into struct
>    pci_ser.
 
...

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..66dbee0bd3cf
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +/**
> + * DOC: PCI Live Update
> + *
> + * The PCI subsystem participates in the Live Update process to enable drivers
> + * to preserve their PCI devices across kexec.
> + *
> + * Preserving a device requires preserving two independent sets of state: the
> + * driver's own state, which the driver preserves with no involvement from the
> + * PCI core, and the PCI core's state about the device, which the next kernel
> + * needs so that enumeration does not disturb a device that is still running.
> + * This file implements the latter.

This does not look good in html docs :(

> + *
> + * :ref:`FLB <flb>` Data
> + * =====================
> + *
> + * Userspace decides which devices are preserved, using :ref:`LUO <luo>` file
> + * preservation: a driver exposes a file that represents a single PCI device,
> + * and userspace preserves the device with
> + * ``ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)`` on that file. Binding preservation
> + * to a file gives it proper lifecycle management, e.g. the preservation is
> + * undone if userspace cancels it or goes away. How a driver exposes that file
> + * is up to the driver and invisible to the PCI core (vfio-pci variant drivers,
> + * the first intended use-case, use their per-device cdev).
> + *
> + * LUO only knows that a file was preserved; it does not know that the file
> + * represents a PCI device. Drivers therefore register their
> + * struct liveupdate_file_handler with the PCI core:
> + *
> + *  * ``pci_liveupdate_register_flb(driver_file_handler)``
> + *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + *
> + * LUO then refcounts the PCI core's FLB against the files preserved by that

Please spell out reference count

> + * handler, and that refcount drives the lifetime of struct pci_ser:

           and here too  ^

> + * pci_flb_preserve() allocates and preserves it when the first file is
> + * preserved, and pci_flb_unpreserve() frees it when the last file is
> + * unpreserved. In the next kernel, pci_flb_retrieve() hands the PCI core the
> + * struct pci_ser built by the previous kernel, whenever the PCI core asks for
> + * it (e.g. during enumeration), and pci_flb_finish() frees it once the PCI
> + * core is done with it.

...

> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> new file mode 100644
> index 000000000000..4096e3cd3324
> --- /dev/null
> +++ b/include/linux/kho/abi/pci.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +#ifndef _LINUX_KHO_ABI_PCI_H
> +#define _LINUX_KHO_ABI_PCI_H
> +
> +#include <linux/bug.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
> + *
> + * This header defines the ABI for preserving core PCI state across kexec using

This does not look nice in html docs either :(

> + * Live Update File-Lifecycle Bound (FLB) data.
> + *
> + * This interface is a contract. Any modification to any of the serialization
> + * structs defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the PCI_LUO_FLB_VERSION number.
> + */

-- 
Sincerely yours,
Mike.
