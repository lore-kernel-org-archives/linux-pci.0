Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731177;
	b=suOYhpVwds4d9fJxsydnflkdx0A2NtRUMG1TonN8/aBDQblV9YQQSDk2/TCvoNEhyG8r
	 OOBMLrFLsC9ty5Psj5r9XBqARCgcOMEbERNkjYb/YZjF/J8dHr+gQKg3IVkYjz53cPIbV
	 z8Fg9OVziYFE3G1DuqbSRPVcJ0+8DkuPZ8PjR3b+omo1cbY+/N7Ej7E3USqkPw0Stu1zd
	 RsbLoc2O/wD3dm84vXMfkpJJy+F7vLibEQOOoqeXWod2AI6DoegKpUER1+C1TtF5hY47A
	 2UQtOqt87WquH/qydnp55U2DtgeoLgf6rtvTrp1z4DcQ2+gwMNrfYoIQ683uPx8QLhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731177;
	h=Received:DKIM-Signature:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:Mime-Version:Content-Transfer-Encoding:References:In-Reply-To;
	bh=o2bsm3sM5qM7pFg6qTM+Ueo75HRL9OdoPZG7+in0now=;
	b=2/vfEqnMKMrucvmz6sS9jSqMay2vIviW6Mi9PfTgHlJ+rb8yU9mdJv5MEpN0OfFrua9j
	 BdeydOCcvWRZwB69tKrXC16B7QegdkEZ2ko4nSwn6Vm8bwOM6i+1V7O5z8jOVB7VeZYps
	 EZU1c9Lpx5b+vXEmZUCABoBGoufYje4tdFlcn6uk6bjFoKewAGTPKu1Z+Iie3edNUUcBK
	 5AJs641rQf2WxKDNvQRAqqrEcQkebUT76BO2oF0DJrETvY6cPCquyNZoQrw/URWjZByVa
	 Gb9REdSpdBP1ePLgtOSm3ldFmfYzTNAGlPj2ScI0okyLIJiSAD9VJcWmRz01R6wGO1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng+2Fqre;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65180606A31C;
	Thu, 26 Nov 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ng+2Fqre
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8001F000C1;
	Thu, 26 Nov 2026 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731177;
	bh=o2bsm3sM5qM7pFg6qTM+Ueo75HRL9OdoPZG7+in0now=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Ng+2FqrejxNEJfG8T0unRvcStAuJRuDRN5Vtt4t3P+PcZ93TfRUfJp+UqRhY82NTf
	 gvvhoYeGobrtNYAPclvZzMWMHRiQi23Kbp2tBV4zH82rp4nATvEgToDWVVWaryR+kL
	 UeWJES8M6dOXJB8Ch7oT4DhzPo3RbKJrT8xIQSDNy7jk0n2TA7mvkaNINMllMf7DZt
	 YZsydudUrV1a7KPDzQs3bBuD++RXCZNQZvlaoxE4JAhRQR6w+OEwA4O7CgHBRwvibR
	 NJz4ShlfPMYFgCxw2zcvqOYE1FWWM90XYDCLuZjOx451USETxqc3uqSoy/TYrDbbfG
	 n7oSR9LbtCiHA==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 23:12:47 +0100
Message-Id: <DN5HKLQK65L0.1L9NVW750P85W@kernel.org>
Subject: Re: [PATCH v5 12/35] gpu: nova-core: mm: add VramBlock
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
To: "Alok Kumar" <alkumar@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20261124135937.18583-1-alkumar@nvidia.com>
 <20261124135937.18583-13-alkumar@nvidia.com>
In-Reply-To: <20261124135937.18583-13-alkumar@nvidia.com>

On Tue Nov 24, 2026 at 2:59 PM CET, Alok Kumar wrote:
> +/// A physically contiguous VRAM allocation.
> +///
> +/// # Invariants
> +///
> +/// `range.start <=3D range.end`.
> +pub(crate) struct VramBlock {
> +    _blocks: Pin<KBox<AllocatedBlocks>>,
> +    range: Range<u64>,
> +}

This allocation seems unnecessary, VramBlock can itself be constructed as p=
in
initializer...

> +
> +impl VramBlock {
> +    /// Returns the range covered by this VRAM block.
> +    pub(crate) const fn range(&self) -> &Range<u64> {
> +        &self.range
> +    }
> +}
> +
> +impl GpuMm<'_> {
> +    /// Allocates an exact byte range relative to the buddy allocator's =
base.
> +    pub(crate) fn alloc_vram_range(
> +        &self,
> +        range: Range<u64>,
> +        align: Alignment,
> +    ) -> Result<Arc<VramBlock>> {
> +        const PAGE_SIZE_ALIGN: Alignment =3D Alignment::new::<PAGE_SIZE>=
();
> +
> +        let align =3D if align > PAGE_SIZE_ALIGN {
> +            align
> +        } else {
> +            PAGE_SIZE_ALIGN
> +        };
> +        let size =3D range.end.checked_sub(range.start).ok_or(EINVAL)?;
> +        let buddy =3D self.buddy();
> +        let base =3D buddy.base_offset();
> +        let start =3D base.checked_add(range.start).ok_or(EOVERFLOW)?;
> +        let end =3D base.checked_add(range.end).ok_or(EOVERFLOW)?;
> +        if !start.is_multiple_of(u64::from_safe_cast(align.as_usize())) =
{
> +            return Err(EINVAL);
> +        }
> +
> +        let blocks =3D KBox::pin_init(
> +            buddy.alloc_blocks(
> +                GpuBuddyAllocMode::Range(range),
> +                size,
> +                align,
> +                GpuBuddyAllocFlags::default(),
> +            ),
> +            GFP_KERNEL,
> +        )?;

...so we avoid this allocation.

> +        Ok(Arc::new(
> +            VramBlock {
> +                _blocks: blocks,
> +                // INVARIANT: `range.start <=3D range.end` was checked a=
bove, hence
> +                // `address <=3D end`.
> +                range: start..end,
> +            },
> +            GFP_KERNEL,
> +        )?)

To me it seems that reference counting is not needed here.

AFAICS, a VramBlock does not actually have shared ownership, it is owned by=
 the
VgpuVramSlotPool of the VgpuInstances.

A VgpuInstance owns a VgpuVramSlot, and a VgpuVramSlot owns a VramRegion. T=
he
VramRegion borrows (a range) from the VgpuVramSlotPool's VramBlock.

Finally, a BarMapping (also owned by a VgpuInstance) also borrows from the
VgpuVramSlotPool's VramBlock.

Do I miss anything? I tried to double check and asked my clanker to inline =
all
the relevant structures, and it came up with this:

	struct VgpuInstances {
	    vram_slots: Option<VgpuVramSlotPool {
	        backing: VramBlock {
	            _blocks: Pin<KBox<AllocatedBlocks {
	                buddy: &'mm GpuBuddy,
	                // Allocated buddy blocks.
	            }>>,
	            range: Range<u64>,
	        },
	        layout: VgpuVramLayout,
	        fb_region_size: u64,
	    }>,
=09
	    instances: KVec<VgpuInstance {
	        vram_slot: VgpuVramSlot {
	            index: u32,
	            fbmem: VramRegion {
	                backing: &'pool VramBlock,
	                range: Range<u64>,
	            },
	            mgmt_heap: VramRegion {
	                backing: &'pool VramBlock,
	                range: Range<u64>,
	            },
	        },
=09
	        plugin_rpc: PluginRpc {
	            comm: CommBufferRegion {
	                map: BarMapping {
	                    region: VramRegion {
	                        backing: &'pool VramBlock,
	                        range: Range<u64>,
	                    },
	                    access: BarUserAccess {
	                        bar_user: &BarUser,
	                        mapped: Option<MappedRange>,
	                    },
	                    mm: &SharedGpuMm,
	                    unmap_error: Option<Error>,
	                },
	            },
	            // Other RPC state omitted.
	        },
	    }>,
	}

(In case you wonder why it says &'a GpuBuddy for AllocatedBlocks, I have [1=
]
applied locally.)

[1] https://lore.kernel.org/nova-gpu/20261126221108.3768637-1-dakr@kernel.o=
rg/
