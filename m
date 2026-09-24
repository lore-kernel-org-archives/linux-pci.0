Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720B2AD2E;
	Thu, 24 Sep 2026 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211261; cv=none; b=ceRUJjPv0U43Hf5aau8irck37dX2VLz55UjrsmQi7ab6ODKQF9aYr1cOdYkLdJ07mp1eHKyOCnckHLHyKm8HHbmi+6/DdMflZGmHpB/g0KvEKsu1fL1yag3a3m8qumrONJ1qBDG5bwuGXXExCKDfOJ2pl5gIeRK+2HI5J4vylik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211261; c=relaxed/simple;
	bh=hj1afspDTZChgEQ+55mfMNH6cKzUiikF8sTCti2+qOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzTdtBAJCkkfiJG4HtdQe95DM3et2Rt6MRtugP+ESiq/6eZOGoL2hQTaKYiv6R3tYBTSTJqOcUYOJA6VImvBwE0z2XIXMPKiSkmH8CCDv+I6FbRy4EsgyGUqdn+LsRpHphYKmyV+JcnpybO/I6CTULjCEcDL46lk69oLAU+YB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKu5ipBn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKu5ipBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4142D1F000FF;
	Thu, 24 Sep 2026 00:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211258;
	bh=5ny6G4QGhCW6cY8aBkrWvz1OpCgET+94cns7jDOrINU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fKu5ipBn9sKvTREnbqLVb64OCOEHtjiKVFC0DuhKHMUaUGnzJeXcfgDZKgcWvBTUk
	 w5vKtgg0Ei1axBJwBTf51BT+v3eINiby41XKT8gH6SDsMaBqNzEzOflfhCySKZlNHn
	 hAv6NV9VkWL1n/Vnlu41mu788iN+r+UBtlP4lKqP6IEbTPtbN/YC014ftwqpmJSAI0
	 H6qcjiovG2Rvu7jCLCxbOAVfqFySB8Eig/kHB0I16uyIVbfaRPTujyM/Sr8c567sbU
	 DCyLfhpGdbXyJnHHLt7dITdirUvKOGSLxhrBkwG2FAueHl4VBWwhQyNWYdUtqgG6GO
	 4EPgkdP3B/vFg==
Date: Thu, 24 Sep 2026 01:54:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manish Honap <mhonap@nvidia.com>
Cc: Gregory Price <gourry@gourry.net>, "alex@shazbot.org"
 <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal
 <ankita@nvidia.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
 "kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
 <gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
 <zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-2
 device passthrough
Message-ID: <20260924015409.3681ad6d@jic23-hlaptop>
In-Reply-To: <IA1PR12MB9030771093FA13DCB01C481EBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-27-mhonap@nvidia.com>
	<aqrl_FyWEBOZundU@gourry-fedora-PF4VCD3F>
	<IA1PR12MB9030771093FA13DCB01C481EBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 09:43:34 +0000
Manish Honap <mhonap@nvidia.com> wrote:

> Hello Gregory,
> 
> Thank you for the careful read of the documentation. I will rework the
> sections you flagged as below:
> 

Hi Manish,

It is much more helpful to reply inline with the relevant sections so we can
see the context wrt to what Gregory was asking.  That saves others
reading the discussion from having to carefully build up a global model
of what was said to understand what the replies are about.  Also I'll hazzard
a guess that Gregory may have read enough code since he sent the review
that he has already forgotten some of his own comments! (maybe that's just
me!)  I appreciate that doesn't always work if you are going to address
the comment via more radical restructuring.  Or in short, please don't
top post!

Thanks,

Jonathan


> - Address model
> 
>   I will update the wording to mention that VMM does know the GPA: it builds
>   the guest's CFMWS window and so chooses the guest-physical range the device
>   can inhabit. What the host owns is the HPA and the placement within it, not
>   knowledge of the GPA.
>   I will add the two models you described, fixed placement for an accelerator
>   that needs exact physical placement versus no fixed placement for pooled or
>   compressed memory, with a small HPA/GPA example, and note that the current
>   series under discussion implements the fixed-offset case.
> 
> - Virtual decoders
> 
>   I will rename the The "Guest decoder and commit" section to "Virtual
>   decoders" and add a short flow showing a guest vdecoder write being absorbed
>   and a live read returning COMMITTED from the host-locked physical decoder.
> 
> - "The kernel virtualizes ..."
> 
>   I will update it to say vfio-pci-core (its config-space permission hooks).
> 
> - guest IOAS, stage-2 mapping, and struct-page-less coherent memory
> 
>   I will define these terms where first used and include that the range is
>   handed to the device whole and never onlined as system RAM. I will also add
>   details why a stale stage-2 mapping must not outlive the HDM window, and how
>   the VMM rebuilds it.
> 
> - Reset
> 
>   I will reword this section. FLRs are virtualized so a guest reset can't
>   inflict physical CXL.mem/decoder effects on the host rather than loose
>   wording "must not take an FLR"
> 
> I can share the revised text ahead of the v6 posting if that is easier to
> review.
> 
> Thanks,
> Manish
> 
> > -----Original Message-----
> > From: Gregory Price <gourry@gourry.net>
> > Sent: Thursday, September 17, 2026 1:03 AM
> > To: Manish Honap <mhonap@nvidia.com>
> > Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> > jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> > Srirangan Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> > skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> > vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> > Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> > <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> > dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> > <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> > <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> > Subject: Re: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-
> > 2 device passthrough
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Sep 17, 2026 at 12:05:39AM +0530, mhonap@nvidia.com wrote:  
> > > From: Manish Honap <mhonap@nvidia.com>
> > >  
> > 
> > 1) Thank you so much for writing documentation, i truly appreciate this.
> > 
> > 2) I apologize in advance for my terseness, I know writing is hard,
> >    please do not interpret this as disliking your writing or series.
> >   
> > > +Address model
> > > +=============
> > > +
> > > +The HDM memory is a coherent host physical range (HPA). The host
> > > +kernel resolves that range before the guest sees the device, and owns
> > > +it for the bind lifetime. The guest only chooses where the memory
> > > +appears in its own physical address space (GPA), by programming a
> > > +virtual endpoint HDM decoder. The guest never reprograms the physical  
> > decoder.  
> > > +
> > > +The kernel holds the HPA and does not see the GPA. The guest programs
> > > +a GPA and does not see the HPA. The VMM holds the device fd, reads
> > > +the committed base from the decoder-register region described below,
> > > +and maps the HPA-backed HDM region at the GPA the guest committed.
> > > +The base the guest reads back is the GPA, not the HPA.
> > > +  
> > 
> > I think this must be slightly inaccurate / imprecise wording.
> > 
> > The host *must* provide some form of physical memory window to the guest
> > at initialization time, otherwise the guest has no way to know - at boot time -
> > that there's even a window of memory it can use.
> > 
> > That's what the CFMWS is.  This is initialized by the hypervisor - which is
> > controlled by the host.
> > 
> > So the host (at least the VMM) must know, for the region the entire device
> > *could* inhabit, what that GPA is - because it's the one that makes the CFMWS
> > for the guest.
> > 
> > If this is not the case, then something is missing from this documentation to
> > explain why.
> > 
> > 
> > If you're actually trying to say is that the GPA's programmed into the virtual
> > decoders are largely symbolic - this at best feels a bit inaccurate and simply an
> > implementation detail.
> > 
> > The host's virtio device could enforce ....:
> > 
> > Host Range:
> >    CFMWS HPA - [0x10000, 0x20000]
> >                    |         |
> > Guest Range:       |         |
> >    CFMWS GPA - [0x50000, 0x60000]
> > 
> > In that case, you'd get the following translation...
> >    vdecoder0.0 - [0x58000, 0x60000]
> >    CFMWS GPA   - [0x58000, 0x60000]
> >    CFMWS HPA   - [0x18000, 0x20000]
> > 
> > Or the virtio device could not enforce that and let the host page-fault just hand
> > it a random page from the actual CXL device.
> > 
> >    vdecoder0.0 - [0x58000, 0x60000]
> >    CFMWS GPA   - [0x58000, 0x60000]
> >                          |
> >               No discrete host mapping
> > 
> > 
> > The former makes sense if the device (accelerator) requires exact physical
> > placement to do its accelerator nonsense.
> > 
> > The latter makes sense if the device (accelerator) doesn't care about placement
> > (compressed memory).
> > 
> > This is not saying we need support both out of the box, but we shouldn't lock
> > ourselves into the former unless there's some reason why the latter is not
> > reasonable.
> > 
> > Can you please help document what the actual expected behavior is with
> > examples in the Address model section so it's easier to understand the intent?
> > That will help quite a bit.
> >   
> > > +Guest decoder and commit
> > > +========================
> > > +
> > > +The guest programs its virtual endpoint decoder through the trapped
> > > +region: it writes a base (a GPA), a size, and then the COMMIT bit.
> > > +The host already resolved and committed the physical placement before
> > > +the guest ran,  
> > 
> > So the host does know GPA, just not exact placement.
> >   
> > > so a live read of the decoder always shows COMMITTED and the
> > > +guest's commit poll completes. The physical decoder is never
> > > +rewritten; the guest's writes are absorbed.
> > > +  
> > 
> > Rather clunky, round-about way to say "The guest decoders are
> > virtualized".   If possible, it would be nice to formalize this concept
> > into "Virtual Decoders" - since that's what this is.
> > 
> > With that concept i think you can probably generate some nice diagrams that
> > show how the guest vdecoder's interact with the host drivers.
> >   
> > > +The VMM observes the commit, reads the committed base, and maps the
> > > +HDM region at that GPA.
> > > +  
> > 
> > So the host does know the GPA.
> >   
> > > +CXL Device DVSEC
> > > +================
> > > +
> > > +The kernel virtualizes the CXL Device DVSEC body through the
> > > +config-space permission hooks. Reads and writes inside the DVSEC body
> > > +use a per-open shadow; a guest write stays in the shadow and does not  
> > reach hardware.  
> > > +Accesses outside the DVSEC body go to the device as usual.
> > > +  
> > 
> > "The kernel" - what part? vfio-pci ? the vmm ?
> > 
> >   
> > > +DMA and iommufd
> > > +===============
> > > +
> > > +A Type-2 accelerator issues ATS-translated DMA to addresses inside
> > > +its own HDM window, so that range must be present in the guest IOAS
> > > +that backs the nested stage-2 translation.  
> > 
> > Type-2, ATS, DMA, HDM window, guest IOAS, stage-2 translation
> > 
> > I think the only thing i don't know in this sentence is "guest IOAS" and it's still
> > hurting my brain to read.
> > 
> > Are all accelerators expect to have this particular interaction, or just yours?
> >   
> > > The HDM range is struct-page-less coherent
> > > +memory, which a userspace-VA ``IOMMU_IOAS_MAP`` cannot pin.
> > > +  
> > 
> > The hardest part about writing about virtualization is keeping a consistent
> > mental model from section to section.
> > 
> > which userspace? guest? host?  (i presume guest here)
> > 
> > `struct-page-less coherent memory`
> >    e.g. the host never hotplugs this, it hands the entire region
> >    directly to the VFIO device, right?
> > 
> >    I think this would be nice to spell out somewhere.
> >   
> > > +The HDM memory region is therefore exportable as a dma-buf:
> > > +``VFIO_DEVICE_FEATURE_DMA_BUF`` on that region returns an fd that
> > > +iommufd maps with ``IOMMU_IOAS_MAP_FILE``, mapping the physical  
> > range  
> > > +without a VA or a page pin. The dma-buf is revoked whenever the
> > > +mapping is torn down (reset, power transition, teardown), so a stale
> > > +stage-2 mapping cannot outlive the HDM window.
> > > +  
> > 
> > For the sake of readers, I think either a little bit more information on this
> > "stage-2 mapping" concept is needed to make sense of what's going on here
> > and why it mustn't outlive the HDM window.
> >   
> > > +Reset
> > > +=====
> > > +
> > > +A CXL Type-2 function must not take a Function Level Reset: an FLR
> > > +resets the coherent CXL.mem state and the HDM decoder. The PCI core
> > > +reflects this by preferring the CXL reset over FLR, so a function
> > > +reset of a CXL device runs the CXL DVSEC reset sequence, which resets
> > > +the function and then restores the HDM decoder and the PCI config state.
> > > +  
> > 
> > I think what you're trying to say is that FLRs are never passed to the device
> > because it can cause physical device effects that defeat the purpose of the
> > virtualization, yes?
> > 
> > So we virtualize FLRs...
> >   
> > > +A guest requests a reset by writing Initiate CXL Reset in the DVSEC.
> > > +That write only stamps completion in the shadow. The real reset runs
> > > +at the vfio reset points (the reset ioctl and a virtualized FLR through config  
> > space):
> > 
> > As you describe here.
> > 
> > So it's not that an accelerator "must not take an FLR" - it's that FLRs are
> > virtualized to prevent deleterious effects on the host / hardware.
> > 
> > Am I misunderstanding this?
> >   
> > > +the kernel zaps the HDM mapping and revokes the dma-buf, then runs
> > > +the CXL reset, which always clears the device memory, and restores
> > > +and re-samples the decoder afterwards. A CXL port masks Secondary Bus
> > > +Reset by default, so a ``VFIO_DEVICE_PCI_HOT_RESET`` does not reach
> > > +the endpoint and the HDM state is untouched. If the port has SBR
> > > +unmasked the reset can decommit the decoder without restoring it, so
> > > +the reset_done handler gates HDM access; a ``VFIO_DEVICE_RESET`` then
> > > +runs the CXL reset sequence and restores it.
> > > +
> > > +The decoder register region is served by live reads of the hardware
> > > +decoder with guest writes absorbed: the decoder is committed and
> > > +locked by the host, so a guest can neither decommit nor reprogram it,
> > > +and the kernel keeps no shadow of the decoder state.  
> > 
> > This is basically what I said at the beginning - it must either be that the host
> > provides locked auto-decoders at boot, or it must provide proper virtualization
> > so that the decoders settings are fully virtualized.
> > 
> > Seems it's the former, and that makes sense.  Please correct me if i'm
> > misunderstanding.
> >   
> > > After a reset the kernel restores and
> > > +re-samples the firmware-committed decoder, so the geometry the guest
> > > +reads back is unchanged. A VMM that dropped its HDM mapping, for
> > > +example across a reset or a D3hot->D0 transition, must rescan the
> > > +decoder and rebuild its
> > > +stage-2 mapping before it resumes HDM access.
> > > +  
> > 
> > Yeah i think we need a bit more information about this stage-2 mapping
> > rebuild to make sense of this.  Maybe I'm just not read-up enough on this
> > particular setup - is there another part of the docs you can link to that talk
> > about this, or are you able to share some details as to what this rebuild
> > process looks like?
> > 
> > ~Gregory  

