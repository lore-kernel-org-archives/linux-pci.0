Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E3466B57
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054557; cv=none; b=aFlq9JTl+GazL0yOod8bxzYblQZ5w+kLOsh6J4o9AY+L6kqzowwD7fTwQz1gmgtHVYVBsLFkQdIHGCPEyiH5wiYbR46t6Vo3nX/mWj8aO47sJDP7BjV1M3lqUuBqZlDLPlEXdJuGncuBp+csUtogFQ5cbQGZckKMUPbWjwlFFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054557; c=relaxed/simple;
	bh=Xgcjqjf3P4MGGbQztdNdBHKpAHb0Y3bYS7ovsxn2/ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onPJretQhsmo7JQ3I+8EFNF1sagPZyoNXMPFlAXdH6LcesHwmWdW1+E3+Y4HqejW/CpxLRjDiJOkJ+jrsY001OlsyFQlw6SXswJmEH3RL1O3P/to92a9SDPiAEU2aaGYwuOJfsW7+2H1gm5h0VrYJtRw75VX1voEqIBXJ40z41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BghkDUfH; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BghkDUfH"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso4367430a91.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054555; x=1789659355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+MOwVd/hSplAvFbBk52yvKLS3w7cDWTRO3ieRL0csc=;
        b=BghkDUfHl35Zy5Aj9pM+NUXZSvy4UZzmsejvbWmcOeeGxldnNvhElVIQniPQpEr4Co
         JgRDcA1Gnu74gu97lzzZPSZ6V/9kxdf1zzGqXe0+5nB/L4necGvDv5W+nqyPM4Z+6YQg
         RkKLWKpatoYGrBQcIFvfE7SgpCy27kyC26F//CaMDm9CC3Tdy2gAVD3pa8AoBLwEP4ju
         ohtw5hItC160oQjP1zUv4rPmneaAQ7Dnoz/b0jMnjdAtaAJ7+zNep5IMPdj+FJQ8o3xU
         Nu9Qjx3TgpDqhR9VihGRXKB2GlVTYGcUFqribcc6QRGDn7LiP0jJdHQhgh7bEo8CuLAj
         Xm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054555; x=1789659355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+MOwVd/hSplAvFbBk52yvKLS3w7cDWTRO3ieRL0csc=;
        b=gReybM2lw7WiJPmzHzAPR2Hc/dIAmYCGzAneEjmhsaARDHnaTDr2fthZj5F1X2sTNG
         A2QfRg9KNiJ7+EK3VG8c0JQZ3TBCu5pY/oO82ZEMrZcEJnj1iF+uMgOx3Jz7K84NcHEW
         EshWBUhKzp8H8oybBfxXdBQqDK5+5DrYcCSyjLbrFMIXlTGWoxQ9661JTfpyswB6/zK4
         +C5TEO0zuPiLWL2dge0WwhSO7MitHtYHl7r8/bFwVFTlOSPpgRiYahdqHlprw2ozg9xW
         iwGRKAqMTad2PjbKSBpnJWC3LEuKJoXTqCjwGa1E0Q51NAWx7o9DoN1Owff9eN5wrQrC
         K54w==
X-Forwarded-Encrypted: i=1; AKwUvBxa2ytY4SAD+dGMHOF+wo80TZCD55PwHO8J0QO54DXpfxiPxIUwj3frjg4E5GIZ1jj3SJBvBWGYGP8=@vger.kernel.org
X-Gm-Message-State: AFuF++nNKfTWFyh7U76Dva5aDmG0hFnX/znnyaVVYybTjR57iZTGgSZm
	vmoQDZ2BjXOaG2PPWn6Iv1tooslsMA0Tg9gjW+lNxzPxDSjtjea+cm+x6e1Heh3ngVmgSqB8VNU
	wxkfotg==
X-Received: from pjbdt17.prod.google.com ([2002:a17:90a:fa51:b0:39d:8f18:feb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:6081:b0:39b:51cc:4586
 with SMTP id 98e67ed59e1d1-39b51cc65admr27199424a91.19.1789054554982; Thu, 10
 Sep 2026 08:35:54 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:35:54 -0700
In-Reply-To: <20260910143448.GD3968357@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com> <aqIAtOoew-_6jw29@google.com> <20260910143448.GD3968357@nvidia.com>
Message-ID: <aqLOWkuVKccR-I7W@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2026 at 05:58:28PM -0700, Sean Christopherson wrote:
> > On Fri, Sep 04, 2026, Jason Gunthorpe wrote:
> > > On Fri, Sep 04, 2026 at 10:24:21PM +0000, David Matlack wrote:
> > > 
> > > > The proposal here (which is inspired by the KVM UAPI) is to ensure every
> > > > LUO ABI struct has 2 properties:
> > > > 
> > > >  1. A field to encode options/features (e.g. u64 flags).
> > > >  2. A way way to grow without breaking backward compatibility (e.g. so
> > > >     we can add new fields).
> > > > 
> > > > Each flag can mean whatever it needs to. e.g. It can indicate the
> > > > precence of one or more fields (i.e. new fields in the struct), or it
> > > > can mean a field now has a different meaning (i.e. union in the struct).
> > > > 
> > > > This would enable adding support for new features without breaking
> > > > backward compatibility. Downstream users would have to ensure their
> > > > kernel does not start using a new feature while it can still rollback to
> > > > a version that does not support the new feature.
> > > 
> > > This was never the biggest problem. The main issue was the functional
> > > behaviors of the kernel that cannot be represented simply as data in a
> > > struct with some flag bits.
> > > 
> > > Like for instance kernel A supports memfd folio sizes far larger than
> > > kernel B because we fixed MAX_ORDER. You can't fix that just with
> > > simplistic flags.
> > 
> > Can you elaborate on why the folio sizes matter?  Honest question, because I don't
> > understand why the serialization format wouldn't express things as "N contiguous
> > pages starting at PFN X".  Then the implementation would rebuild its folios as
> > appropriate.
> 
> That's an idyllic view, yes, but my point is (IIRC) we didn't do
> exactly that for memfd.

Well, y'all screwed up then.  I don't see why past mistakes should force other
subsystems to support a flawed implementation.  Learn from the mistakes, add v2
of serialization for memfd, and move on.

> Sometimes you can do more and more work to try and be more and more
> general but this is *alot* of work and even then eventually hits
> problematic limits. Like what do you do with the sealing flags? That's
> ABI breaking if the successor does not support them, and downgrades
> make exactly that possible.
>
> A CSPish user can do things like patch the new sealing flag into their
> current kernel (while preventing userspace from using it), ensure
> everything is updated to that, then jump ahead to a newer kernel and
> enjoy the new flag with full downgrade support. There is so much more
> control on their part that makes the problem far more managably simple
> that upstream does not get to have.

I guess maybe we have a different definition of ABI? 

I'm not saying that upstream has to be 100% forwards and backwards compatible.
I'm saying the serialization payload itself should communicate what features are
effectively required.  I.e. *if* there are incompatibilities, they should be
naturally expressed in the serialization format, not communicated out-of-band
through magic numbers.

The scenario you describe fits exactly with what I am proposing.  Until something
actually starts using the new sealing flag, the CSP can downgrade to older kernels
at will.  And if the user cares about downgrading, then they need to prevent the
flag from being used until the new kernel is rollback-safe and deployed to enough
hosts to prevent stockout.

> This is why I think the very idea we can support any version pair is
> too much to ask for. We should focus on supporting a small set of
> version pairs and not making it too invasive or hard in the kernel or
> on the maintainers.
>
> Thus live update within a stable branch only is my proposal for
> upstream support.
> 
> If it really succeeds at that and it becomes very popular, then let's
> discuss upstreaming doing additional version combinations.

Why on earth would we have version numbers in the first place?  IMO, monotically
increasing version numbers are flat out the worst way to communicate features.

I am completely against supporting any scheme that relies on magic version numbers.
It creates problems where none need exist, and checking for compatibility can't be
sanely done in a programmatic way, because by definition it relies on magic numbers.

E.g. if the ABI for a given component hasn't changed, why should anyone care if
the overall "version" of the kernel is ahead or behind by N kernels?

> > I could see things like HugeTLB not working if someone booted the kernel with
> > support for only 1GiB pages and then tried to feed it payload with sub-1GiB ranges.
> > But to me, those sorts of things fall into the "well yeah, don't do that" category.
> 
> Okay, how about worse, todays kernel has hugetlbfs and there are
> patches around to luo serialize that. Lots and lots of talks about a
> post-hugetlbfs world out there.

And?  Adding a compatibility layer to a future kernel so that it understands an
incoming HugeTLBFS payload should be trivial.  I can totally see not wanting to
support serializing a post-HugeTBLFS kernel's memory representation into the "old"
format, though even that probably wouldn't be all that difficult.

> Do we want to constrain what is possible to ensure we accomodate this
> hugetlbfs serialization? I vote no.

In what way is providing strong ABI guarantees for individual components
constraining HugeTBLFS serialization?

> Do we want to reject the hugetlbfs serialization until we have a year
> of debate outlining every possible ABI scenario? I also vote no.

That's a bit of a strawman argument.  Is designing a forward-looking ABI easy?
No, but IMO "a year" is a massive exaggeration of the effort required to come up
with a scheme that can survive a variety of plausible upgrade/downgrade scenarios.

And again, I'm not saying we have to support infinite compatibility.  If some
future kernel drops HugeTLBFS, and we decide not to provide a shim to support
downgrading (which IMO is totally reasonable), then it's on the user to understand
that moving to that new kernel is a one-way street.  Given that dropping something
like HugeTLBFS would require significant changes in the software stack, I think
it's perfectly fine to put the burden of understanding the implications on the end
user (though realistically, there would be a copious amount of documentation and
deprecation warnings).

> Should we make a downgrade round trip a downstream problem? I think
> so!

Hard NAK.  There will inevitably be boundaries that cannot be crossed, but I am
not at all ok punting on downgrades.  To me, that's basically saying "we want to
add just enough support upstream so that it's not too painful to carry full support
out-of-tree".  That completely goes against the spirit of open source and upstream
Linux, and I want no part of it.
