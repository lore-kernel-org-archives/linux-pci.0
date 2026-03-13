Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02B6F2F2;
	Fri, 13 Mar 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404333; cv=none; b=kPn4+70A9qYhCti1DsCWkMMN8HJms0+xUIP7NRCm6zXIhcXqS/5KNjJ9WWwO7FMvBO3QdEvVXqjAHv3vX9wvV5GQ9+uJB/QM90eoeTFHHJ5Rmu447oYX1/fNCZMq/BM2AT0e1VAomhDG9nLpQ2FRb2cLlaadzKE5ByvpwJeXV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404333; c=relaxed/simple;
	bh=KplXI1hSoaDtjXx21qtsOvOuFE87DyPd/0h+Lt9JRFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0/P41vYgXPKieHuYc8HPXdTXOVV1jAn/CqhB2vbgm5eAwN9BRbk4BUWZaskTyugXKjYT5kUqWbBahhVkHQvDQMl3zW7+zIouANTLZMXbc2CPcGGG86qFyT0vNKf8rDhghqBjjjPEeSSk0nbPa25i2XYRMtQqaYjreOrOly/wWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jdrIiGAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jdrIiGAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBC1C19421;
	Fri, 13 Mar 2026 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773404333;
	bh=KplXI1hSoaDtjXx21qtsOvOuFE87DyPd/0h+Lt9JRFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdrIiGAXsQUNaGNXjYf3vrhtVRJ8aujFGBa6TLTM8SzrxH+3WO5BfGyc4IE8jxTfB
	 HkfrG3yZAOqPXbWKzSfozruroFCyyrHI9uv6Kn20OIJwu2zBNiMf/PqOvCEuAP/fk6
	 ytyP1X19VEjsJ/seAYtRbnO6QhncQ1pvspGWNjXw=
Date: Fri, 13 Mar 2026 13:18:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, aik@amd.com,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <2026031319-payee-photo-bdd9@gregkh>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>

On Thu, Mar 12, 2026 at 09:11:32PM -0700, Dan Williams wrote:
> Greg KH wrote:
> > On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> > > An "accepted" device is one that is allowed to access private memory within
> > > a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> > > from other device properties like usb_device::authorized, or
> > > tb_switch::authorized. The entry to the accepted state is a violent
> > > operation in which the device will reject MMIO requests that are not
> > > encrypted, and the device enters a new IOMMU protection domain to allow it
> > > to access addresses that were previously off-limits.
> > 
> > Trying to mix/match "acceptance" with "authorized" is going to be a
> > nightmare, what's the combination that can happen here over time?
> 
> I do think Linux needs to mix/match these concepts. "Authorization" is a
> kernel policy to operate a device at all. "Acceptance" is a mechanism
> to operate a device within a hardware TCB boundary.
> 
> So, the truth table of combinations would be:
> 
> accepted	authorized	result
> 0		0		logically and physically disconnected device
> 
> 0		1		connected device, DMA is bounce buffered
> 				and loses confidentiality, integrity,
> 				and performance
> 
> 1		0		logically disconnected device, but a
> 				relying party trusts that the device is
> 				not spoofing authorization.
> 
> 1		1		connected device, DMA is direct and gains
> 				confidentiality, integrity and performance
> 
> To say it another way, when the above distinguishes "logically" vs
> "physically" disconnected it is whether the device interface can be
> verified to not be under adversarial control. An unaccepted device can
> do limited damage, but still can bounce buffer secrets out of the TCB if
> so directed.

I really don't agree with this, but I can't think of why at the moment.
I feel like you are looking at this purely in the TCB point of view,
while I don't feel that is something that should be considered "special"
at all here.  Linux has, for the most part, always trusted the hardware,
and now you are wanting to not trust the hardware for some things and
parts of the kernel.  Which is great, it's something that I have wanted
to change for a very long time now, but let's do it right if at all
possible.

Give me a few days to come up with a better reply, let me think about
this some more...

> > We need to either "trust" or "not trust" the device, and the bus can
> > decide what to do with that value (if anything).  The DMA layer can then
> > use that value to do:
> 
> Trust is separate. For example, there are deployed use cases today where
> the device is trusted, but unaccepted. Acceptance support for those
> cases is mostly a performance optimization to be able to stop performing
> software encryption on top of DMA bounce buffering.

If "acceptance" is just a performance issue, I think you all need to go
back to the marketing people as that's probably not what they intended
to have happen here.  For some reason I thought they were selling this
as "security", not "speed" :)

> > > Subsystems like the DMA mapping layer, that need to modify their behavior
> > > based on the accept state, may only have access to the base 'struct
> > > device'.
> > 
> > ^this.
> 
> The DMA layer is not operating on a trust concept it is effectively
> being told to select an IOMMU.

Ok, then that's independent of "acceptance", that is "use this IOMMU vs.
that one" type of thing which is just a "basic configuration for speed"
type of thing as you mention above :)

Let's not confuse that with anything else like "acceptance" please.

> > > It is also likely that the concept of TCB acceptance grows beyond
> > > PCI devices over time. For these reasons, introduce the concept of
> > > acceptance in 'struct device_private' which is device common, but only
> > > suitable for buses and built-in infrastructure to consume.
> > 
> > Busses are what can control this, but please, let's not make this a
> > cc-only type thing.  We have the idea of trust starting to propagate
> > through a number of different busses, let's get it right here, so we
> > don't have to have all of these different bus-specific hacks like we do
> > today.
> 
> The conflation of "trust" and "acceptance" has been the main stumbling
> block of past proposals. As you have said before "kernel drivers trust
> their devices". That precedent is not being touched in this proposal.

Ah, but I WANT to touch that.  Let's FINALLY solve that!  Or at the very
least, provide the infrastructure in the driver core to allow busses
that want to do that, to be able to do so.

> Instead, give userspace all the tools it needs to deploy policy about
> when to operate a device. When it does decide to operate the device give
> it the mechanism to add confidentiality, integrity and performance to
> that operation.

Yes, this is a policy decision, and if you are only saying this is about
"which IOMMU should we select", then that's a dma layer configuration
option.  Let's not call that "acceptance" please.

> This is a "CC-only type thing" because only CC partitions the system
> into two device domains. One where "trusted unaccepted" devices can
> operate without CC protections and "trusted accepted" devices can
> operate with CC protections and direct DMA.

In other words, it's an IOMMU switch, so why not use the switch
infrastructure?  </me runs away...>

anyway, let me think about this some more...

thanks,

greg k-h
