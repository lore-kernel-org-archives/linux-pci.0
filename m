Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312566;
	b=tj2qtW7Mz/IreS/JI2gRUMrik5yHgM0l+EyRygwBrXlfwcquA42d3Dg+b8jjvvmbAcx1
	 oF5XCbAUhGPxyBnxeXT/inDTvJEPLk5/jl2bcbkvVOztFWMH4mhwto+ioCA/JqS2LSs2W
	 YzMW1kONiMmBseXyVtk0wgRDNvHNROweMeGikXiVpWkSMJXO2SnOWpvz+5x6OxsbiMJU0
	 2Qr29klNw54PHg8VbuiZ3iBinZ0b4B+uFPe4CA6UwH6wXbFXd25WGzXQxHOGC7Jjo8RSA
	 BZKCzb3JdOs5ewxDcwX7DS/+KfvQITPLq/ksZD8oLTSqW+hooA9OGAwzk/qhTk41t8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312566;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PH02iIJ+INghaEueE0jl0/j0pLvZeA1CRO4AfSVm6as=;
	b=3So+FE/nP7ouEPcG8RQNkyRm1hyyaSr5lwOPfcTFx8pyI66m2rkMOmUC3f2uHnOOvl4x
	 GhsY/Ih5U69L4e+/3mYCqUH06wSXR7rniyMkIvlofB9vmAQqte6aNeIohPZw+dQZ7lRUo
	 /BgJ0HThubII6/qW83bYFR785A5A04CiNiV4o1bOK8omxeip70Rzc47UPxDfUQ9VnNEbx
	 eTqOVU365RUt7kmCUmszO7pz16VjzdQDWYB5RRnXq6i6Yb6vRvgUl9OTU43lwRnCR1J+z
	 vmIbgDCVTAbWYrzK2asYzB4gJZ9YZgCNaFdNdW1nQgWka7g+PMSJNT8LJHGGiNBGB9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4mdXan3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF04606A32A;
	Sun, 22 Nov 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4mdXan3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C481F000C6;
	Sun, 22 Nov 2026 01:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795312566;
	bh=PH02iIJ+INghaEueE0jl0/j0pLvZeA1CRO4AfSVm6as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k4mdXan3eS5eT1tUZcDbLYgaXw1NMlFAF9pJwB8kuqzbPuzrzQ2fJKlHMKe0OUWMn
	 ecvOP2vD376UOzi91lxHw2NwpvIs53lFGKBAv2F1D6/NfzZz8qVWAfxA8r8j8Tvo0S
	 O8LEh8kFUkvy6ahb/QiS+DFXQTbFx+LMiSqskdnso8h8tSpY2MWnb5s2W5vQI+CHCn
	 BTCea3SPQzrUdJDXQLN3XbvzGF9Uagq6Gw21RIAemVqGopJ3kRmerXrQMyRXAFaIvs
	 YpqJNCSgXMLuFYQNmlXBQBkm3mLbZVMiSL8WJW6Z4qYQNZSAXE5/ryadz6wRrsNMWX
	 hWNLnNZcLHhWw==
Date: Sun, 22 Nov 2026 02:56:00 +0100
From: Thorsten Blum <blum@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <awJLsDWI0OgdWhph@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>

On Wed, Nov 18, 2026 at 02:21:41PM -0800, Borislav Petkov wrote:
> On Wed, Nov 18, 2026 at 10:40:27PM +0100, Thorsten Blum wrote:
> > The patch has been reviewed and acked for quite some time. Bjorn offered
> > to take it via the PCI tree at the end of October, pending an ack from
> > one of the x86 maintainers, but there hasn't been any further feedback.
> 
> Why, because after sifting through all that gibberish in the commit message,
> it is basically telling me that some mac laptops have trouble with Linux?

v1 (submitted on August 7) didn't mention the iMacs as examples because
this bug may also affect other early quirks.

Lukas then asked for an example, which is why I added both iMacs to the
commit message in v2 (submitted on August 16, with no code changes).

> And because of this we need to stop the presses and take your patch
> immediately?

I never suggested the patch had to be taken immediately. And 3+ months
doesn't seem particularly immediate to me for a bug either.

I resent the patch twice (September 16 and November 6) and pinged once 
(October 3), which should be well within the community guidelines:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
