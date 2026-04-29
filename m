Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6331ED80;
	Wed, 29 Apr 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474340; cv=none; b=rs5nYbkWHFJKqmtvqzYcjk6SzgPv+NlnIz07acm7MlLxgI9VelrzTlpv2JiktFuxRU7caaCYpxs43PQ8NqYctVPbfS2OVjxi0bfHLozDWW+Pv/cEjBvK2hIMiWEIv8xenbvxXBh/zYdBfp1SVEU6ORJUHpba37DJVY3HOGvxfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474340; c=relaxed/simple;
	bh=MiLNYFll0yXV48Kf/vGtWWdNwTpZem5lgvnwm4KtA8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4zS4x1O1JuJ7IMSpbJf1oSj+hyj5Cp2MqNLRrTw0+sO7SI67jTpY1aN5hMpN3mYeX+uznYek0j5gaKULU5uIHZU/7gfz3HzopjaMaRqhSPFk2pcmZeRWkLr7kAQJ/zlvXqKv931uq3h8QTSKx0UZmGPeS7CGnZUyGWucQf6pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdjujMNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdjujMNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E70C19425;
	Wed, 29 Apr 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474340;
	bh=MiLNYFll0yXV48Kf/vGtWWdNwTpZem5lgvnwm4KtA8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdjujMNsJSx2hS01hYoiUrxqIc1DE3BF0VPTTF0pUMOEvCi0rFX04I8HhzVNck7dn
	 qD3zffkfOjQemQT07gj7xb20JN0+I6/11IC9WsCMmSgV+UIgAHeu91LGK0RTtWkeps
	 rbBYw/S3EcKS8FnDdPxmpDLMAr/5DgShFk4YkXq9QeiUHIYJt7jhKpx9vY1dd5bdBY
	 4NlBs44mBjPBwIFBObLer+6UtC436IMU5AmKBOCcFD4XAEGQ9rc+yB3TYcW0vH7660
	 QvSP7OVyOtIQFxN3TjZ7wKR/MmgoF276I7txKMZ7dcS3nOcoltbuLT7PD8t3HdvQhR
	 XHdXMa2Ov7Vvg==
Date: Wed, 29 Apr 2026 16:52:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Max Boone <contact@maxboone.com>
Cc: den@valinux.co.jp, mani@kernel.org, frank.li@nxp.com, allenbh@gmail.com,
	bhanuseshukumar@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, jdmason@kudzu.us, jingoohan1@gmail.com,
	kishon@kernel.org, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, marco.crivellari@suse.com,
	mmaddireddy@nvidia.com, ntb@lists.linux.dev, robh@kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <afIbHeXFomp4a8QU@ryzen>
References: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>
 <afHQWdn2rmG4mAA4@ryzen>
 <BEB40AEB-7A22-4BED-AC00-E3C0CDE72510@maxboone.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BEB40AEB-7A22-4BED-AC00-E3C0CDE72510@maxboone.com>

On Wed, Apr 29, 2026 at 01:11:12PM +0200, Max Boone wrote:
> Good point - looking through the device trees I only saw the msi-map / platform
> msi set for the imx95 and assumed designware was the only EPC supporting
> this (also because the code uses that of-node specifically), but I indeed don’t see 
> a reason that other chips can’t use this.
> 
> I’m a bit confused on the configuration, fwiw it’s probably me being unfamiliar
> with PCIe, but it doesn’t seem right to configure the MSI and eDMA DBs through
> a kconfig option rather than inferring it from the device tree and/or having the EP
> driver enable the capability and expose an operation to realize it.

I don't see anything that is configured using Kconfig options.

But in order to enable PCIe EP doorbell support in the vmlinux binary
you need to build with CONFIG_PCI_ENDPOINT_MSI_DOORBELL=y.



To make use of the GIC-ITS MSI support, you need to define msi-map defined in
device tree. I did send such a patch for rk3588:
https://lore.kernel.org/linux-rockchip/20250908162400.535441-2-cassel@kernel.org/

But, AFAICT, considering that the rk3588 does not have any way to map RID to
a predictable SID (which is possible on e.g. imx95), I don't think it is wise
to add msi-map to rk3588.

It is similar to the problem why we can't run with the IOMMU enabled when
running the PCIe controller in endpoint mode.

For more info see:
https://lore.kernel.org/all/20250207143900.2047949-2-cassel@kernel.org/

Basically, the problem is that the host assigns a BDF to each Root Complex
on the host side, and then assigns a BDF to each Endpoint it finds connected
to that Root Complex.

Thus the PCI Endpoint controller will have no idea which BDF the Root Complex
will have.

The Requester ID will be that matching the BDF of the Root Complex.

But the problem is that the Endpoint side cannot insert a mapping for this
Requester ID, because it does not know which Requester ID the RC will have.

I guess it could theoretically insert all possible Requester IDs in the IOMMU,
but that is not going to fly according to Robin (ARM SMMU maintainer):

"Yeah, that one pretty much settles it - we can certainly expect host
root ports with nonzero device numbers, so that's at least 13 bits of
the StreamID space to cover, which isn't going to fly."


Note that there are some PCI endpoint controllers that can run with the IOMMU
enabled, by using a look up table and sideband signals, see e.g. imx6:

commit ce4c4301728541db7e5f571a5688a3a236d9e488
Author: Frank Li <Frank.Li@nxp.com>
Date:   Tue Jan 14 15:37:09 2025 -0500

    PCI: imx6: Add IOMMU and ITS MSI support for i.MX95



I'm not sure if it is possible to configure a LUT on the RK3588 as well,
in order to keep the IOMMU enabled also in Endpoint mode. If it is, then
it wasn't clear from the RK3588 TRM.

(Having the IOMMU enabled when running in Root Complex mode is no problem,
as the Linux driver core automatically will add/insert a (single) Stream ID
matching the BDF it assigns to each Endpoint.)


> Check, thanks for the write-up, this is also what I’m looking to get working,
> coindicentally on the RK3588. I had imagined that it would be possible to build
> a sufficient API by passing in a base offset and stride for the doorbell allocation, 
> but an alignment param sounds better. Can we program the resulting doorbells
> at an arbitrary offset in a BAR, or would we waste the first allocated
> doorbell that’s going to be located at 0x0000 - 0x1000?

I'm not sure if I follow.

If you use subrange inbound mapping, you split the BAR (BAR0) into two.

The first range, 0x0-0xfff would use one inbound iATU and would have inbound
address translation that points to allocated memory by nvmet-pci-epf.
This is the regular nvme registers in range 0x0-0xfff.

The second range 0x1000-XXXX (depends on how many I/O queues the nvmet-pci-epf
allocates) would point to a physical address that is used for doorbells
(the address returned by pci_epf_alloc_doorbell()). This would use another
inbound iATU.

Since there are no NVMe registers after the doorbells, we don't need a third
inbound iATU.


I think we can use stride == 0.

Another possible way would be to use stride == CX_ATU_MIN_REGION_SIZE, and then
use one iATU per doorbell, but considering that most DWC EPCs have a very
limited amount of inbound iATUs (rk3588 has 16 inbound iATUs, but some SoCs have
much fewer), I'm not sure if this approach is the best idea. One iATU per I/O
submission queue, and one iATU per I/O completion queue, then one iATU for Admin
submission queue, and one iATU for admin completion queue... I'm not sure if
this is a good approach. Stride == 0 and one iATU seems better.

(I don't really see any advantage of using one iATU per doorbell. We will still
have the problem that each address returned by pci_epf_alloc_doorbell() needs to
be aligned to CX_ATU_MIN_REGION_SIZE anyway.)


> In any case, I think it would be preferable for users of the alloc_doorbell function
> to pass in what kind of doorbell they want instead of using a fallback mechanism.
> It seems to me that the alignment and possibly a larger amount of doorbells are
> possible with the eDMA doorbell mechanism. Or am I misunderstanding eDMA
> here and is that bounded by mapping / size / alignment of the GIC ITS?

The GIC-ITS MSI way will return a physical address by pci_epf_alloc_doorbell().
(This option does not really seem feasible on rk3588.)

The alternative is to use the DWC eDMA hardware itself to emulate doorbells.

For the DWC eDMA option, there are two ways:
a) The PCIe EPC controller was synthesized to expose the eDMA registers in a
   BAR at a fixed offset.
b) The PCIe EPC controller was not synthesized to expose the eDMA registers in
   a BAR at a fixed offset.

For case a), we will get a physical address that is within the DWC eDMA MMIO
space. Here we will need to call pci_epf_alloc_doorbell() can set up an iATU
for inbound translation to the DWC eDMA MMIO address.

For case b), at least when I was testing, setting up an inbound iATU that
translates a region in e.g. BAR0 to the DWC eDMA MMIO addresses did NOT work.
Feel free to try this yourself. I don't fully understand why this does not work.

My theory is that when the DWC EPC was configured with the eDMA registers
exposed in a fixed location, e.g. in BAR4 on rk3588, the hardware has some
internal fixed translation for BAR4 to the eDMA MMIO addresses, and because of
that, setting up an inbound iATU which also translates inbound PCI TLPs, from
another BAR, e.g. BAR0 to the same DWC eDMA MMIO addresses, does not work.
Again, please feel free to try yourself, perhaps I missed something.

Thus, for pci-epf-test, we simply fill in DB_BAR and DB_OFFSET with the
BAR + offset in that BAR where the eDMA regs are exposed, rather than using
an inbound iATU to translate the inbound PCI TLPs to the DWC eDMA MMIO
addresses.


Regardless, for the DWC eDMA case, I'm not sure if it is possible to support an
"align" parameter to pci_epf_alloc_doorbell(), because I think it will always
return a single address (a specific address inside the DWC eDMA that can be used
to emulate doorbells). For GIC-ITS, I think pci_epf_alloc_doorbell() might
return different addresses, for each time it is called.
Koichiro, please correct me if I am wrong.

So, my suggestion to add an "align" parameter to pci_epf_alloc_doorbell() will
probably only work for the GIC-ITS case, unfortunately.


> Hrm, I think I’m misunderstanding the eDMA mechanism that is proposed in this
> patch. Is the fixed eDMA register block (e.g. BAR4 for the RK3588) translated to
> a space in the GIC ITS MMIO area - or is restriction specifically on adding alignment
> to the platform MSI doorbell implementation?

The iATU alignment requirement, that the base and target address must be aligned
to CX_ATU_MIN_REGION_SIZE is always there when using an iATU.

So for "GIC-ITS + iATU" or "DWC eDMA + iATU".

The difference is with e.g. rk3588, pci-epf-test does not use an inbound iATU
mapping to read/access the DWC eDMA regs (using the DWC eDMA MMIO address).
We simply fill in the DB_BAR and DB_OFFSET to point the BAR which has the eDMA
registers exposed by default. So we read the eDMA regs from the "fixed resource
BAR" (BAR4), rather than setting up an iATU mapping in e.g. BAR0, which translates
to the eDMA MMIO address.

(And because NVMe has the doorbells in a fixed location, as long as we can't set
up an inbound iATU that points to the eDMA MMIO regs, I don't see how we will
get nvmet-pci-epf to work with doorbells on rk3588).


Kind regards,
Niklas
