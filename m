Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA83FBB4D;
	Thu, 17 Sep 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678127; cv=none; b=uZrcuQ0VecR7uF/eJP6JrzaK5JThvL9iBPpmWxMPuNNMR0B3qXF21Yo0efu2fC/39EGLNwq1TI86a5bNTLlxI/vvyM6NfS+Ln/jBmdazjfCYWY+E55i64WSCEW1buybB/oex0ERMO/4JXJg4uZhL1OTSEDdygDdmlSKQGOnVdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678127; c=relaxed/simple;
	bh=j92afSGgbOckodNiEOu7f8ALpu4hQ1eL612RHdF55Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQPgMuuRNHnymegGZwXej7Y/UG29h1oUnWEYAUYUh2ZQwmUIRDiw5gjw2DBxsaaKh8X6ET6O2BcxSnV3LEKyR1wO8pFRzY2f8vmQFB7mcH67+mjlEratO39fIIlHFUDiRMQ2DAMC/+Um2zvX6qFaMBayHg+KrOlOAZQXtbbsD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ1tetIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ1tetIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96251F00893;
	Thu, 17 Sep 2026 20:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678125;
	bh=j0AQ+9htqhtcT6dEBdky8OefeVWQ2THGkLTpHxFQPV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oJ1tetIULg2XpLBOnZUPvhTxlKaak8pEtjAVpvlijuEahJjxVOcIYt8X/YhwBegFJ
	 EXwkdVPTIm+OCh4taS6k/wYEhhNcKzEskzxuV/dgQkfgfdPnO8Sp3mYvb/YaS8LI+3
	 YMkXNT/iN90KrNlL97E/HwpQ9wYTv4S9SIkeTSrtzMBn9TfPvsmVbiCvLj4mXDtTI5
	 lt22TV0VSpgIGvp51Y56zgE9cy0SWhc9dVwzL8LPXBfrGkdW/gelqakSoAS7PllrLf
	 TZV2EG0sanfDfAg1SX8iPKZuJlgOJ1TY9Z+Uti4+Lz4E0uu5Inyrukh8z9y0v4XRq/
	 lNj3kN7s3wnvw==
Date: Thu, 17 Sep 2026 21:48:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com,
 kees@kernel.org, gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com,
 vsethi@nvidia.com, zhiw@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl
 on demand
Message-ID: <20260917214837.46f8237d@jic23-hlaptop>
In-Reply-To: <aqrg9AJBh0GUsP0l@gourry-fedora-PF4VCD3F>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-8-mhonap@nvidia.com>
	<20260916191659.1d3cb36b@jic23-hlaptop>
	<aqrg9AJBh0GUsP0l@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 14:49:36 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Sep 16, 2026 at 07:16:59PM +0100, Jonathan Cameron wrote:
> > > +/*
> > > + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
> > > + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
> > > + * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
> > > + * identity before engaging it.  
> > 
> > We don't expect to handle type 3 class code compliant devices, but what about
> > the things referred to sometimes as CXL Type 3+?  
> 
> Dan has previously (and I think would continue) to just call that
> an accelerator - because it is.
> 
> I think the Type 1/2/3 nomenclature is stale and needs to go away,
> it's outlived its usefulness.
> 
> To your point below, a compressed ram device is really an accelerator
> with CXL.io and CXL.mem.  All the spec says (used to say?) about
> "Type 2" is that it *may* support CXL.cache - it doesn't require it.
> 
> > It is also plausible we'd pass a full compressed RAM device through to the
> > guest without paravirtualizing like we currently plan to do for class
> > code Type 3 devices (for DCD, sharing etc). +CC Gregory to point out where
> > I am wrong on this ;)
> >   
> 
> Plausible, possible, feasible - yes.
> 
> Sane?  More sane than using it as a normal memory device on the host
> assuming RAS signals from the device can't overwhelm the host (unknown).
> 
> > More generally, why are we controlling usecases?  A class code compliant type 3
> > device 'could' be passed through I think if someone wanted to do that.
> > I'd not encourage it but why is it a linux policy to not support it?
> >   
> 
> The only scenario I can think of that you'd want to pass a simple
> expander all the way through to the guest would be RAS signals - which
> I think still require host plumbing anyway to avoid passing said signals
> to the wrong guest depending on how you've chopped up the region.
> 
Taking just the compressed case...
If there are capacity signals etc I'm not sure I'd want to have to paravirtualize
those. Plus I really don't fancy making a single compressed device provide memory
into multiple hosts. That's a whole new level of paravirtualization of noisy
neighbours.  Ma! Someone else wrote really uncompressible memory and now there
is none left for me.

> Basically if you need DPA/HPA data from the device to be interpreted by
> the kernel, the guest needs a translation mechanism.

Hmm. That is potentially ugly. But I guess a problem for any accelerator.
If they are firmware first not too bad as it's just normal memory error
reporting so we create a cper in the host with the GPA and send it on
it's merry way.  

> 
> In practice I can see passing a virtualized, locked auto-decoder through
> to the guest with the same HPA/DPA values as the real device so the
> signals can be delivered quickly with limited host interposition.

We'd lie (trap / emulate) the device decoder and probably the topology so that
what you see matches up and device provided DPAs will translate to GPAs.
I forget if that bit is in this patch set or not.

> 
> You would probably need on-device vitualization support to do "proper"
> passthrough so the device can route signals to the guest directly.

Hmm. We may get a way to do that at somepoint but so far it's pretty
simple so I'd argue only a few things need to look different in the
guest to what they do in the host.

> 
> Anyway, you could pass it through, sure, why not.
> 
> We shouldn't limit it, if only because we're not clairvoyant about
> what will be useful tomorrow.

Agreed.

J
> 
> ~Gregory

