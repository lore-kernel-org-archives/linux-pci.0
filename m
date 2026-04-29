Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3873921C2;
	Wed, 29 Apr 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455200; cv=none; b=QY+LXrWZvtlQ19FKaneHn9cSx8HYq1gPc5Pe5nP9jgIGNxWzW0s/ZSm2cSEAkkt8WgaWg+smWF9idrZzhmy+6shXJUTS0NDhLQqR4YzDpqyepPWxlEmUZRj/K3YJdNEH0QqQvO2mINvpbf9glk4zL/c3Ig33IN95oYqejShA5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455200; c=relaxed/simple;
	bh=GQZhXFU7lhHkmz5VyNccAdxMxoGDGwmpXqoF9767owQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0iiQC/GHVDgiynsbwCAqhP8I+Jc+TVAl2+1Kwhwq8Psjja66fP21mU8xorEdTyRVOA6A/fPPG2Zrffo2FHPLUl3orX2DbSKBLL75RNaOGUvj57d6QMPdfhKNPU12fu3Xf/Ga5Rc0ZDDUGnCWfxhk1MTj6u1qb4E0+vV00Owuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEieC5NI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEieC5NI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D81C19425;
	Wed, 29 Apr 2026 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777455200;
	bh=GQZhXFU7lhHkmz5VyNccAdxMxoGDGwmpXqoF9767owQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEieC5NIn73hV729TgYybER1HWYgPlQ1RWVRxU0+THO8TAsgSaqxpcfCwUDNyX9W3
	 /JxbhZ3W6kxhe2i07hpaYaUZQHP82DbndzQdgZXKIysvnpL1Pwmjhd2YPqg3xdC7m5
	 H93eDzZDuppX5+pvwNEYHVBkcexAlQQjn/ud4z8vHarODrOyg3DqUx0qj5v9ACKs1K
	 1kwbDwP6Y4xlDO0v1Ig/fXM2bdwHqzrsXTd0FxvdwhdBDI5g9mo5hxRLYLjIiO1fwT
	 EMzv2hw8HfW9VvW3L3tsb3N2QGabwsDXJQ/PHSS9UfLzVVka7wXizdfCgujv28L1iu
	 PjAt6lhdQm5VQ==
Date: Wed, 29 Apr 2026 11:33:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Max Boone <contact@maxboone.com>
Cc: den@valinux.co.jp, mani@kernel.org, frank.li@nxp.com, allenbh@gmail.com,
	bhanuseshukumar@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, jdmason@kudzu.us, jingoohan1@gmail.com,
	kishon@kernel.org, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, marco.crivellari@suse.com,
	mmaddireddy@nvidia.com, ntb@lists.linux.dev, robh@kernel.org,
	shinichiro.kawasaki@wdc.com, mboone@akamai.com
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <afHQWdn2rmG4mAA4@ryzen>
References: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>

On Tue, Apr 28, 2026 at 10:36:15PM +0200, Max Boone wrote:
> 
> I’m not very fond of keeping this implementation in the pci-ep-msi file,
> as the platform MSI and this implementation are both iiuc specific to
> the designware ep driver. Even more so because the MSI implementation
> is enabled by config rather than through device tree.

Why do you think that the current code with DOMAIN_BUS_PLATFORM_MSI is
designware EPC specific?

I don't see anything that is designware EPC specific.

Sure, it relies on GIC ITS, but I don't see why non-designware EPCs can't
use GIC ITS.


> 
> Wouldn’t we want end-users to specify what kind of doorbell they want,
> as it seems to be that a more specific doorbell BAR layout can be 
> programmed with eDMA, allowing native support for nvmet’s doorbell
> BAR for example.

I also wanted to use my designware based EPC for doorbells in nvmet-pci-epf,
specifically the support that Koichiro added for inbound subrange mapping.

However, most designware EPC have a strict alignment requirement
(CX_ATU_MIN_REGION_SIZE), which is often 4k.

This alignment requirement is there both on the PCI address (address within
the BAR, and for the physical memory address (target address)).

I thought that we could use the inbound subrange mapping and put the doorbells
in a separate inbound iATU, so we could remove polling in the nvmet-pci-epf
driver, just like they have done in the vNTB driver. However, it works in vNTB
because they have a register telling exactly which BAR and offset in that BAR
where the doorbells are.
In the NVMe PCIe Transport specification, the offset for the start of the
doorbells is fixed, at offset 0x1000 (4k) and the only thing you can change is
the stride between the doorbells.

Currently, a doorbell is a single 32-bit data, sure we could call
pci_epf_alloc_doorbell() with ("number of I/O queues" + 1 (admin queue)) * 2
(submission queue and completion queue).

However, the address which we get from pci_epf_alloc_doorbell() might not be
4k aligned.

We have the function pci_epf_align_inbound_addr() which can split this
non-aligned address to a 4k aligned base + offset from that base.

However, that would also require the host side driver to write to this offset
from the start address. (See e.g. doorbell_offset in pci-epf-test.c).

So, basically, with the current limitation that the doorbells must start at
0x1000, together with the fact that the doorbells returned from
pci_epf_alloc_doorbell() might have an arbitrary alignment, I don't see how
we could add support for doorbells in nvmet-pci-epf.

If we could supply an alignment requirement to pci_epf_alloc_doorbell(),
e.g. 4k, and the API is guaranteed to return an address that satisfies this
alignment requirement, then we would be good.

However, right now, we don't have such an API. We simple get an address
somewhere within the GIC ITS MMIO region.


> 
> Originally in a patchset by Frank Li the API that was proposed was more
> generic, and the pci-epc-msi implementation was chosen because there
> was only one implementation:
> - https://lore.kernel.org/imx/20231019150441.GA7254@thinkpad/
> - https://lore.kernel.org/imx/20231019172347.GC7254@thinkpad/
> 
> I’d personally prefer to see an abstraction that is weaved into pci-epc-core
> and pci-epf-core that can be implemented by drivers as they wish. While 
> still keeping the enum for different types.
> 
> That also gives room to pull a poll-mode doorbell into the pci-epc-core,
> which deduplicates that code from the nvmet and vntb epfs, and allows
> other functions to use RC->EP doorbells without needing to bother with
> writing the polling mechanism.

Sounds like a good idea.


> 
> P.S. I’ve been working on a vfio-user based epc for development purposes
> personally, and the last hurdle before I want to send it in for comments is 
> support for doorbells, and came across this patchset checking if there’s
> any other activity in the space. Having an implementation-agnostic
> doorbell API in the EPF/EPC core would be very helpful to me.

I have looked at adding doorbell support to nvmet-pci-epf, but got stuck on
pci_epf_alloc_doorbell() returning an address that is not 4k aligned.

(Since the NVMe PCIe transport specification has the doorbells at a fixed
location, we can't change that.)

But if we could provide an "alignment" parameter to pci_epf_alloc_doorbell(),
then I think it is possible.

Sure, the GIC ITS MMIO area might be quite small, so it might not be able
satisfy such a request. E.g. on rk3588, the its1 MMIO region is 0x20000 (128k):
https://github.com/torvalds/linux/blob/v7.1-rc1/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi#L2414

However, I have not idea of how much of this region the GIC driver uses for
actual registers, and how much of that region it can actually dedicate to
doorbells.


Kind regards,
Niklas
