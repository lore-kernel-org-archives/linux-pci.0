Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92E340416;
	Wed, 12 Aug 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571157; cv=none; b=W/ShZFlbAyWIUSL2VeyoY5V2TP5O4q0Mnuy/eIfMx3lhxWymPKhjtfluNVGq8rthFZlZsp4TV0hxo3CnYxsf9mwjp7GswTW0yX4/tvIdTSnZ3C7Em5UF+Gm4CKFR8wbCVtrVQZnMPFXBGq+WAl7ExVZkQF8byxGJHXYRkEoLLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571157; c=relaxed/simple;
	bh=OcVOeV4upUSCDuMo+6r3YF9hexEpQEDgRc2xxKTAK6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OGY3MtacvF4E9zch4mrJOuc7bjLm0JeJ/XuCtPJLgtv8vzcxR0C8jmvp6qTE+S+rqvGdUPDItF5NrPm1Fk2wxMcbYXhCg3YmtJZajIZXnRdHC0SAike5e1RNyvqAz21tNfWEVQSBoC9gcE1DnpgTMfGIhw4erZO+yZkSw/kLuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajGQ2BUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajGQ2BUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D512E1F000E9;
	Wed, 12 Aug 2026 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571156;
	bh=RcVzn1g6Qh/ei/KZFaNk2QQnIh9Fbz3gVQVVwhoamp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ajGQ2BUITVbRWNNzJxnl6sLsDqf3191d6Tr0c39fHp8EKKBtUrWXIwbHXwoiNRcEo
	 LplgsVv8EVZvC49Bg4iKhO4C9GZFHGVdji02NMO3sxA4qeBLsiFkfi2OSjULfWRk68
	 NKLTz5qfZyhI/EGOOJcRW/7kSU5l8S1YwWniS5FEjMfI1wcT3Pg7tLjbt+txXzF5Mo
	 ULRKb3eQaxeAK99BkpNYlGmLzUBzx/oce/AZi/6qZGPGySawlhjaywhUiUQZ9DwusZ
	 RWqEcptoJlkSmRu5QSweVgV5nkVlU1ELZHtOh/9bAK2Su+lGmklq+TIy+p/X0/hdk0
	 u+XGMC5EfSo5A==
Date: Wed, 12 Aug 2026 16:45:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
	skhawaja@google.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Andrii Staikov <andrii.staikov@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Nick Nunley <nicholas.d.nunley@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <20260812214554.GA1067593@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812045325.2733631-1-alex.williamson@nvidia.com>

[+cc Andrii, Mitch, Nick, Tony, Przemek]

On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
> while SR-IOV is enabled.  This can not only result in an uncoordinated
> disruption of the use of the associated VFs, but the ongoing use of and
> access to the VF has the potential to result in machine checks.

I suspect this might also be related to the somewhat weird usage of
pci_restore_msi_state() to restore VF MSI state in several network
drivers:

  https://git.kernel.org/linus/371e576ff3e8 ("i40e: Restore VF MSI-X state during PCI reset")
  https://git.kernel.org/linus/7e4dcc13965c ("iavf: restore MSI state on reset")
  https://git.kernel.org/linus/a54a0b24f4f5 ("ice: restore VF MSI-X state during PCI reset")

I think these are a little weird because they only run on a PF but
call pci_restore_msi_state() on all the VFs.

I guess these paths are recovery after FLR of the PF destroys the VFs,
and after the FLR, pci_restore_state() on the PF re-enables the VFs
but leaves them uninitialized.  It seems kind of ad hoc to restore VF
MSI state but not the rest of VF config space.  This all seems kind of
messy and makes me dubious about exporting pci_restore_msi_state()
directly to drivers.

> This series proposes that this gap is largely an oversight of
> pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
> violates the scope boundary of the pci_reset_function() API.
> 
> Patch 1 introduces guards in the common wrappers where we can hold
> device_lock to prevent .sriov_configure races.  This covers locking
> conformant use cases.  __pci_reset_function_locked() can't be gated in
> PCI-core; it runs after the potentially destructive .reset_prepare.
> Therefore its callers must provide the gating, along with the locking
> and state manipulation the interface already demands.  The vfio-pci
> change is included as an example and known use case here.
> 
> Patch 2 introduces a callback to pci_reset_bus() which allows a lock
> dependent callback to be evaluated after locking the physical hierarchy
> and before initiating the actual reset.  This allows use cases such as
> in the following patch to evaluate the SR-IOV PF configuration without
> racing.
> 
> Patch 3 implements exactly that test in vfio-pci-core, such that the
> hot-reset ioctl can be blocked when SR-IOV VFs are present on a bus/slot
> affected PF.  This completes the lockdown of resets induced on behalf of
> the vfio-pci in-kernel or userspace drivers.
> 
> Patch 4 exports pci_reset_supported, which allows patch 5 to remove the
> latched reset_works flag, which already had the potential to become
> stale due to reset_method manipulation through sysfs, but now may also
> become stale due to the SR-IOV state of the PF.
> 
> This is RFC to capture the discussion of [1] while it's active but
> requires testing before formal proposal.  This effectively side-steps
> the feasibility and security question of the operating model in use by
> the referenced thread by generically gating resets affecting PFs with
> active SR-IOV.  Please review and comment.  Thanks,
> 
> Alex
> 
> 
> [1]https://lore.kernel.org/all/20260805003355.728299-1-skhawaja@google.com/
> 
> Alex Williamson (5):
>   PCI: Refuse function reset of an SR-IOV PF with enabled VFs
>   PCI: Add pci_reset_bus_cond() for a caller-gated slot or bus reset
>   vfio/pci: Refuse to reset an SR-IOV PF with enabled VFs
>   PCI: Export pci_reset_supported()
>   vfio/pci: Use pci_reset_supported() in place of reset_works
> 
>  drivers/pci/pci.c                | 117 +++++++++++++++++++++++++++----
>  drivers/pci/pci.h                |   1 -
>  drivers/vfio/pci/vfio_pci_core.c |  28 +++++---
>  include/linux/pci.h              |   4 ++
>  include/linux/vfio_pci_core.h    |   1 -
>  include/uapi/linux/vfio.h        |   3 +
>  6 files changed, 129 insertions(+), 25 deletions(-)
> 
> -- 
> 2.53.0
> 
