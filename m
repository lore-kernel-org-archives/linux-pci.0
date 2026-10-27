Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130547;
	b=fBfEEdjssNT8Na240TzztacuKLTzfGPUy9MKjeD3MvH0PErfITjTWwBmgtcXVtRxOiXt
	 8Op/eUJB6hvQAS+4kvcR3Fv/+QfBmZ7yPsgDV+ENUseSor2DME9Jc4FXCeSOwbqvumn/w
	 FRn21QqaTtW49bUatylBr8dKiTDFgle8fiSSACm4P1bbzFQvtYjRgDHyDtTdZQ5cWFoLN
	 Jis+3rQkguGUlPlx+ZbIAUf08ERx4sWuF0sbDTqG/BXyEkfQmloKVYHSSd9WSYQn/HulK
	 qDxK5gCYrnxl+KTwAiO9lNYquW4Hc2oA3wiCkk+Xmd2NGgv2iL354DvJTv8pYsdfISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130547;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZOtopiA38vMwgfZNnGhgjD3iF19cUKWfBEMIJinm/TE=;
	b=4+UcHpzcwJtoOk9OGeII1vxk0ybJTb7r6DFT+/UIpeqO1MzjfFtNyTpDq4KavzEwno5N
	 GdwKNf47lCM0ZlTDCFTyJ4/FheuwzXEsCbS4gnqQuyC+0r0ZfZeqYEP0fQdOT8DWqj9OO
	 sK/EBjLIG0ZcSloyyEGI67zNa4HV+h5vlvyGb4/ZP/9i0vJmJC1oy9hkFyDYujkD3sYHq
	 k9fHSHNioF0IbJHMgmFkNpSiWmxDIplN9KZnCa2Ehnk3RiIGFjsWtLKLHdd205nI9lECZ
	 P3nA9G7RDFGZnD42LZPW35EvoUQjv+OzdALU5zuEa5L23MyM41KjqPLQeBC1XgGQ7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoLrRFj3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EB606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoLrRFj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D22E1F01825;
	Tue, 27 Oct 2026 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130547;
	bh=ZOtopiA38vMwgfZNnGhgjD3iF19cUKWfBEMIJinm/TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YoLrRFj3IxdzqvgpXVWgT68VZx++vHYXu/Ol2e3rM/8AR+qwgLAAEathxnpiz/UPY
	 apZ/5xtkYklX0UBbQebyecCdDC7Xy9d/QfChZKhlkTMhVjtJr7NAX9r0BVPOXOkxlq
	 kK4Pxwue5eXWeKbAJOtGbqE3opN/7Di/WTxw5qpVjEkn7SrHEbMPi1E6ZTERStTrLk
	 krF1AJ1cHOTwuG8cQ6R5TKR0hidSwyjQXhTkDwiCTEMjlQe0itcTBrdn5nCG1tFAyL
	 ljkiuq0mjKDLNMtLTy7VvfGB2YZzpdKnHSikU6o5hj3Xea43Tr1F9XTzic3t439DpN
	 7b2JG8JtBMLJQ==
Date: Tue, 27 Oct 2026 14:49:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukasz Laguna <lukasz.laguna@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	michal.winiarski@intel.com, djbw@kernel.org, brett.creeley@amd.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vipin Sharma <vipinsh@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 00/13] PCI/IOV: Improve reset handling with VFs enabled
Message-ID: <20261027194905.GA462134@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027160446.858300-1-lukasz.laguna@intel.com>

[+cc others interested in VF reset]

On Tue, Oct 27, 2026 at 05:04:33PM +0100, Lukasz Laguna wrote:
> This series improves reset handling for SR-IOV devices. Today there
> are a few gaps when resets happen with VFs enabled:
> 
>  1. VF state is lost across PF reset. The PCI core saves and restores
>     the PF's config state, including its SR-IOV capability, and the
>     kernel representation of each VF (struct pci_dev / struct device)
>     survives the reset, but the VFs' hardware state does not. From the
>     PCI point of view, the VFs do not exist between the PF reset and
>     the restore of the PF IOV state. Their config space is lost, and
>     their drivers are never notified about the reset.
> 
>  2. VFs are prepared in the wrong order during bus and slot reset. VFs
>     are handled like any other device on the bus, and because the walk
>     is top-down, the PF's .reset_prepare() runs before its VFs'
>     callbacks.
> 
>  3. VFs on an SR-IOV virtual bus are not handled during bus and slot
>     reset. The walk recurses only through dev->subordinate, so it never
>     reaches them, as such a bus has no bridge. Those VFs are reset
>     without being locked, without driver notification and without
>     config space save/restore.
> 
>  4. The "bus" reset method is unavailable for a PF with VFs enabled.
>     pci_parent_bus_reset() accepts a device only if no other devices
>     are on its bus. A PF's VFs typically sit on the same bus as the PF,
>     so enabling VFs makes the PF fail this check. The VFs are in the
>     PF's reset domain, so they should not block a bus reset of the PF.

I want to hear opinions on this part.  I guess it's obvious that VFs
are in the PF reset domain, since resetting the PF destroys any VFs.

But I don't know what coordination people expect between users of the
VFs and the PF.

I think people expect to be able to reset VFs independently so they
can be assigned to different VMs and be reset without bothering peer
VMs.

But whoever owns the PF can reset it and all the VFs, potentially
destroying any VMs using the VFs?

> This series addresses these gaps as follows:
> 
>  - Patches 1-3 add the PCI core helpers used by the rest of the series.
> 
>  - Patch 4 fixes (1), (2) and (3). It locks all VFs together with the PF
>    around a function reset, saves and restores the VFs' config state,
>    and calls the VF drivers' .reset_prepare() / .reset_done()
>    callbacks, so both architected and device-specific state can be
>    preserved. During bus and slot resets, VFs are skipped in the device
>    walk and handled through their PF, so VFs on an SR-IOV virtual bus
>    are covered as well. VFs are prepared before the PF and restored
>    after it. As a result, pci_reset_function_locked() now requires PF
>    callers to hold the device locks of all enabled VFs as well.
> 
>  - Patches 5-7 adapt PF drivers to the new core behavior. ionic and
>    pds_core call pci_reset_function_locked() from their error resume
>    handlers, so they now need to lock the VFs around it. i40e no longer
>    needs to restore the VFs' MSI state in its .reset_done(), since the
>    PCI core now restores the VFs' config state.
> 
>  - Patch 8 fixes (4). pci_parent_bus_reset() now ignores the PF's own
>    VFs when it checks for other devices on the bus.
> 
>  - Patches 9-13 replace open-coded VF lookups with the new helpers.
>    PCI/TSM and ixgbe use the VF iterators, and ice, liquidio and xe
>    use pci_iov_get_virtfn(). These patches depend on patches 1-2 and
>    are independent of the reset changes.
> 
> Link: https://lore.kernel.org/linux-pci/20261019083514.838640-1-lukasz.laguna@intel.com/ [v1]
> 
> Lukasz Laguna (12):
>   PCI/IOV: Introduce pci_iov_get_virtfn()
>   PCI/IOV: Introduce VF iterators
>   PCI/IOV: Introduce VF locking helpers
>   ionic: Lock VFs around pci_reset_function_locked()
>   pds_core: Lock VFs around pci_reset_function_locked()
>   i40e: Drop VF MSI state restore from PF reset_done
>   PCI/IOV: Allow bus reset_method for PF with VFs enabled
>   PCI/TSM: Use generic VF iterators
>   ixgbe: Use generic VF iterator
>   ice: Use pci_iov_get_virtfn()
>   liquidio: Use pci_iov_get_virtfn()
>   drm/xe/pf: Use pci_iov_get_virtfn()
> 
> Michał Winiarski (1):
>   PCI/IOV: Allow VF drivers to handle resets
> 
>  drivers/gpu/drm/xe/xe_pci_sriov.c             |   4 +-
>  drivers/net/ethernet/amd/pds_core/main.c      |   5 +-
>  .../ethernet/cavium/liquidio/octeon_mailbox.c |  10 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 -
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  26 ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 -
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  25 +-
>  .../ethernet/pensando/ionic/ionic_bus_pci.c   |   5 +-
>  drivers/pci/iov.c                             |  88 ++++++-
>  drivers/pci/pci.c                             | 217 +++++++++++++++---
>  drivers/pci/tsm.c                             |  25 +-
>  include/linux/pci.h                           |  63 +++++
>  13 files changed, 357 insertions(+), 137 deletions(-)
> 
> -- 
> 2.43.0
> 
