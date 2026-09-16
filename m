Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79174E50AE
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587224; cv=none; b=W1hi84oXZgFU5g56gA8oGg1nn+p7A0vgynGrB8G1w7mIRRxtq29TK3DUrODeRZakRvEO7a5S1T4vHdFN7WD3YJ++g1mRWXbywZTa9lno7NvLOx+Md1otJ2y0buoVwczfIdyyhJ9bK4FhSQBdVIn3KKAuTnMcJuDjU1fVb1W8qXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587224; c=relaxed/simple;
	bh=Kpo0OyWi0CO746t44DDgn1hn3lqL6Qj9kQMB/VsQdtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXkVAmr6GEyjoAopWaR2twvzolI3r9uru7gXT6fvd36cqJnUfvUz7B6DA8Y3WBkiCzySlIMS0ksZVyAha0VQk9gW6X9Q9ITcz29BeZa52JfbKF1cc5KKLxjzNxjbhXNh2YkKB8mxxXWbBDvUt3P1K/6KEdorvLH+j6fnS6wbGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RSzzeEYp; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RSzzeEYp"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910531ea7feso213066d6.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789587211; x=1790192011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJtIecQvwkVEDPm/6dNtwM/FqSFHvdTn3Czip8ta20A=;
        b=RSzzeEYp51xyMflEt24hgwFSPgHtW1nrLj3gzOsux+BYrVHqPq+MBJDHkgcBE0IrmV
         qZGteJmf5nvplXr5hPFVIldhBVKQVujfnj1U+9iQEXbzQvvKfa4YBK6oEUEWTiH2t+W6
         c0spJB+mCL0Giv46yabqNPKEWMxFk5LvvEq44AGVjebZ4mTj7r36ODIyJXG3EMKmT4aK
         YYCCH8K4Vsj/dUt0IRddDyX02VS6nqKoGr/BxN2yWilB+Qpc408H15zR3BkT/QREp6lV
         bqYdUZLDY16rbNFi1KO33uo7l4wDajjwgmsZo1cjyrrMI2hzEUy7UIx5CVAeFz3zIxY3
         qE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587211; x=1790192011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJtIecQvwkVEDPm/6dNtwM/FqSFHvdTn3Czip8ta20A=;
        b=Hx2nn7N5P6+vkFiW8znMVcUq2h78mxkAJHvaFCpGAMdGSYn166sCjBVTwztGU17sMY
         hERdws7pzFbfEX45ZD2YLFJNujf6jgdm9+EO3F/i/wzFMddYh1zyPfybV11WwNLcIdcQ
         KDR9PNcNnow1h04B9ZJenq73wlRu23hUxdGgVIu6GM84bO3ap/or+3JE9pLMZzghEFZB
         +SftSECbr0mzwAiH+0kmZ8q/IObA5qVDUp+sjsAXLtYzRufUHOrkUEjMU6ZzLznVpRTa
         XBmgwfUtDRPKRNcu8YmOGwcKmQiAZ6SSP6y54f/6QHm1EFb4WsHP8DD+gX+tnSWFIQ8b
         EwHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0agmc9wA/ZVO/VkUF0Ti5v6fKb9TWEX929tc4MhzVM7NKS33cZj+MK7z2xhJZYVFsmNwwbgA0q9I=@vger.kernel.org
X-Gm-Message-State: AFuF++kCIsqoRX6+wggc1KXRwWGDpdXIeMEavtUTLVG31utV6cEz3cwb
	e0kShKNrnPrK/u2HTS7WWq4Twca+bl582eLgXKipw01Ku93H/vu9VjOaeJIBdNX5yyg=
X-Gm-Gg: AYBFou0kUi92f8z25KUeC+MBXk3SsrS2atCmgDMHedwJvTOPkG34nUCFrA8jf0M0xoa
	xqrm7EgYsctK4DTxBAvV3P6D+E+TjqMAJZUijeqGb8o8d/KNrDuw4VxaWt7vtXAY2a2TMIHfiUx
	GkYL3Iv1TEzTMB0HrdK5Qik36bkJwq94TBlJR/g1m62d2ZYkpeFEpdGTNJXxKlOAauE+nTna6sq
	TMfRLHzbkWZK8xX2ET9PV6d9LOiXicjxyo0DGipG0eVQKlrAXm3p87IVrZDz3qhx7i+MZOFmm7I
	Tc+W/DRIR250KDRV0p88/aJ1OSjlvaZUIlqtwiSL2GbxhKZioOIpnLuJm3FwrbrMG/AU7Voyq6L
	fCqr6UQEsPw0XmXPPb659Natcf03l8+CCdOefTb3QnN/CuaTt8ezAn8WZV4Hok0Ern/fTzUz8gF
	eJYNUIPQeEhxZZ726RQtlmfa8o+iXIUQh3/mklekYCdDzlp9fby9SlqCRO5ZeXx63kANKsBK3vI
	y2dEQNAsoDUxEhyMZUadJVrNk/s56l9ykx8s0YW9HCEaQzs4a0YfkA=
X-Received: by 2002:a05:6214:448b:b0:910:31f7:3bd7 with SMTP id 6a1803df08f44-9123d7d57f2mr72582036d6.29.1789587210868;
        Wed, 16 Sep 2026 12:33:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91246979f17sm6900666d6.34.2026.09.16.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:33:30 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:33:28 -0400
From: Gregory Price <gourry@gourry.net>
To: mhonap@nvidia.com
Cc: alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com, jic23@kernel.org, 
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com, kees@kernel.org, 
	gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-2
 device passthrough
Message-ID: <aqrl_FyWEBOZundU@gourry-fedora-PF4VCD3F>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-27-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916183540.3813685-27-mhonap@nvidia.com>

On Thu, Sep 17, 2026 at 12:05:39AM +0530, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 

1) Thank you so much for writing documentation, i truly appreciate this.

2) I apologize in advance for my terseness, I know writing is hard,
   please do not interpret this as disliking your writing or series.

> +Address model
> +=============
> +
> +The HDM memory is a coherent host physical range (HPA). The host kernel
> +resolves that range before the guest sees the device, and owns it for the
> +bind lifetime. The guest only chooses where the memory appears in its own
> +physical address space (GPA), by programming a virtual endpoint HDM
> +decoder. The guest never reprograms the physical decoder.
> +
> +The kernel holds the HPA and does not see the GPA. The guest programs a
> +GPA and does not see the HPA. The VMM holds the device fd, reads the
> +committed base from the decoder-register region described below, and maps
> +the HPA-backed HDM region at the GPA the guest committed. The base the
> +guest reads back is the GPA, not the HPA.
> +

I think this must be slightly inaccurate / imprecise wording.

The host *must* provide some form of physical memory window to the guest
at initialization time, otherwise the guest has no way to know - at boot
time - that there's even a window of memory it can use.

That's what the CFMWS is.  This is initialized by the hypervisor - which
is controlled by the host.

So the host (at least the VMM) must know, for the region the entire
device *could* inhabit, what that GPA is - because it's the one that makes
the CFMWS for the guest.

If this is not the case, then something is missing from this
documentation to explain why.


If you're actually trying to say is that the GPA's programmed into the
virtual decoders are largely symbolic - this at best feels a bit
inaccurate and simply an implementation detail.

The host's virtio device could enforce ....:

Host Range:
   CFMWS HPA - [0x10000, 0x20000]
                   |         |
Guest Range:       |         |
   CFMWS GPA - [0x50000, 0x60000]

In that case, you'd get the following translation...
   vdecoder0.0 - [0x58000, 0x60000]
   CFMWS GPA   - [0x58000, 0x60000]
   CFMWS HPA   - [0x18000, 0x20000]

Or the virtio device could not enforce that and let the host page-fault
just hand it a random page from the actual CXL device.

   vdecoder0.0 - [0x58000, 0x60000]
   CFMWS GPA   - [0x58000, 0x60000]
                         |
              No discrete host mapping


The former makes sense if the device (accelerator) requires exact
physical placement to do its accelerator nonsense.

The latter makes sense if the device (accelerator) doesn't care
about placement (compressed memory).

This is not saying we need support both out of the box, but we shouldn't
lock ourselves into the former unless there's some reason why the latter
is not reasonable.

Can you please help document what the actual expected behavior is with
examples in the Address model section so it's easier to understand the
intent?  That will help quite a bit.

> +Guest decoder and commit
> +========================
> +
> +The guest programs its virtual endpoint decoder through the trapped
> +region: it writes a base (a GPA), a size, and then the COMMIT bit. The
> +host already resolved and committed the physical placement before the
> +guest ran,

So the host does know GPA, just not exact placement.

> so a live read of the decoder always shows COMMITTED and the
> +guest's commit poll completes. The physical decoder is never rewritten;
> +the guest's writes are absorbed.
> +

Rather clunky, round-about way to say "The guest decoders are
virtualized".   If possible, it would be nice to formalize this concept
into "Virtual Decoders" - since that's what this is.

With that concept i think you can probably generate some nice diagrams
that show how the guest vdecoder's interact with the host drivers.

> +The VMM observes the commit, reads the committed base, and maps the HDM
> +region at that GPA.
> +

So the host does know the GPA.

> +CXL Device DVSEC
> +================
> +
> +The kernel virtualizes the CXL Device DVSEC body through the config-space
> +permission hooks. Reads and writes inside the DVSEC body use a per-open
> +shadow; a guest write stays in the shadow and does not reach hardware.
> +Accesses outside the DVSEC body go to the device as usual.
> +

"The kernel" - what part? vfio-pci ? the vmm ?


> +DMA and iommufd
> +===============
> +
> +A Type-2 accelerator issues ATS-translated DMA to addresses inside its own
> +HDM window, so that range must be present in the guest IOAS that backs the
> +nested stage-2 translation.

Type-2, ATS, DMA, HDM window, guest IOAS, stage-2 translation

I think the only thing i don't know in this sentence is "guest IOAS" and
it's still hurting my brain to read.

Are all accelerators expect to have this particular interaction, or just
yours?

> The HDM range is struct-page-less coherent
> +memory, which a userspace-VA ``IOMMU_IOAS_MAP`` cannot pin.
> +

The hardest part about writing about virtualization is keeping a
consistent mental model from section to section.

which userspace? guest? host?  (i presume guest here)

`struct-page-less coherent memory`
   e.g. the host never hotplugs this, it hands the entire region
   directly to the VFIO device, right?

   I think this would be nice to spell out somewhere.

> +The HDM memory region is therefore exportable as a dma-buf:
> +``VFIO_DEVICE_FEATURE_DMA_BUF`` on that region returns an fd that iommufd
> +maps with ``IOMMU_IOAS_MAP_FILE``, mapping the physical range without a VA
> +or a page pin. The dma-buf is revoked whenever the mapping is torn down
> +(reset, power transition, teardown), so a stale stage-2 mapping cannot
> +outlive the HDM window.
> +

For the sake of readers, I think either a little bit more information
on this "stage-2 mapping" concept is needed to make sense of what's
going on here and why it mustn't outlive the HDM window.

> +Reset
> +=====
> +
> +A CXL Type-2 function must not take a Function Level Reset: an FLR resets
> +the coherent CXL.mem state and the HDM decoder. The PCI core reflects this
> +by preferring the CXL reset over FLR, so a function reset of a CXL device
> +runs the CXL DVSEC reset sequence, which resets the function and then
> +restores the HDM decoder and the PCI config state.
> +

I think what you're trying to say is that FLRs are never passed to the
device because it can cause physical device effects that defeat the
purpose of the virtualization, yes?

So we virtualize FLRs...

> +A guest requests a reset by writing Initiate CXL Reset in the DVSEC. That
> +write only stamps completion in the shadow. The real reset runs at the vfio
> +reset points (the reset ioctl and a virtualized FLR through config space):

As you describe here.

So it's not that an accelerator "must not take an FLR" - it's that FLRs
are virtualized to prevent deleterious effects on the host / hardware.

Am I misunderstanding this?

> +the kernel zaps the HDM mapping and revokes the dma-buf, then runs the CXL
> +reset, which always clears the device memory, and restores and re-samples
> +the decoder afterwards. A CXL port masks Secondary Bus Reset by default, so a
> +``VFIO_DEVICE_PCI_HOT_RESET`` does not reach the endpoint and the HDM
> +state is untouched. If the port has SBR unmasked the reset can decommit
> +the decoder without restoring it, so the reset_done handler gates HDM
> +access; a ``VFIO_DEVICE_RESET`` then runs the CXL reset sequence and
> +restores it.
> +
> +The decoder register region is served by live reads of the hardware
> +decoder with guest writes absorbed: the decoder is committed and locked by
> +the host, so a guest can neither decommit nor reprogram it, and the kernel
> +keeps no shadow of the decoder state.

This is basically what I said at the beginning - it must either be that
the host provides locked auto-decoders at boot, or it must provide
proper virtualization so that the decoders settings are fully
virtualized.

Seems it's the former, and that makes sense.  Please correct me if i'm
misunderstanding.

> After a reset the kernel restores and
> +re-samples the firmware-committed decoder, so the geometry the guest reads
> +back is unchanged. A VMM that dropped its HDM mapping, for example across a
> +reset or a D3hot->D0 transition, must rescan the decoder and rebuild its
> +stage-2 mapping before it resumes HDM access.
> +

Yeah i think we need a bit more information about this stage-2 mapping
rebuild to make sense of this.  Maybe I'm just not read-up enough on
this particular setup - is there another part of the docs you can link
to that talk about this, or are you able to share some details as to
what this rebuild process looks like?

~Gregory
