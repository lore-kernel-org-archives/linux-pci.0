Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066C347BB5;
	Sat, 23 May 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535029; cv=none; b=ooHML9di0Gzo/nRaAhhk5ffBonmSqxfj2lS0t+JtCoRP4gVsUpVG93ZUDba5f6C6PQUf0GIrl3gOSGAAsaS1xFD1IvIcsh2/SjHcVsjeXh64Q15hkdSMDZRFwqj9KxHKam+eVqC4XzXFyRp3bvbhhCYtrLZ13qHJVjRmwRR4GWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535029; c=relaxed/simple;
	bh=UsIZ3ROz4HgoqG/iZzrlr7mk4tV62y/kaUXEsQJPf2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kErukX4NPQzbkg5g3wgRbZ+kJUDgJmKk2KDNQ7erVeq6fC1IrUrKu3ctybvdoEITtwi1ZRHogvohDwORJjzoMm6RV35iEpZnKrGSUZQ3cTLt6kNSt+QYmoiAuUqsY116nNgmkB9UF+LSKo7EGjWWI7dX33DuDsq2nSObE6MZsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgCyvFMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgCyvFMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7E1F000E9;
	Sat, 23 May 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779535028;
	bh=DFFkEUaecq9jgVgrZXM+gBJFGsiiQrkz7PbftdHt+vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mgCyvFMQp4XOX/er5dLrmU9iZHrpVItvF2dDlyj0qu/KFPprv4F/rA8efyAiiRabU
	 5ggR6w+MEhG2118BZhRgZV5kIIuBiNsWNtlhVOLVuUlCa8o1BYXOPyG4lt8nuHiB7j
	 Eth9WPoSHKbKVs3ZQHMBziJR90bl1q9pTJXUXBpII0gb6a/YFOUmqpm/OCzhbsk6/H
	 qauqxt4As07+qfNZGvi5jo1/7Va2hnXxpGCXQpsT1Kl/iXoqKSNHAq9Gjg/8TJysMC
	 aPd33dUWR4ebeaX4lYNC9q6qGO50YWZbKAGJjq+d7soSM14j5D+HOcozvXHDOFHFEt
	 cpEOKQ3aWnfyA==
Date: Sat, 23 May 2026 14:17:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	Pasha Tatashin <tatashin@google.com>,
	Pratyush Yadav <prty@google.com>, Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ahGMrrU0wCUdWgsN@kernel.org>
References: <20260522202410.3104264-2-dmatlack@google.com>
 <20260522204400.4C7E51F000E9@smtp.kernel.org>
 <CALzav=cZsFx5dpbELx1cMHUa1+4+uv7cYEWAWAtZkXeB2d9mMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cZsFx5dpbELx1cMHUa1+4+uv7cYEWAWAtZkXeB2d9mMw@mail.gmail.com>

On Fri, May 22, 2026 at 02:37:28PM -0700, David Matlack wrote:
> On Fri, May 22, 2026 at 1:44 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Missing `kho_is_enabled()` check before calling KHO preservation APIs in PCI Live Update FLB operations.
> > --
> >
> > commit b0cb2fb154fba1aa85d63570fe0186e243353fb7
> > Author: David Matlack <dmatlack@google.com>
> >
> > PCI: liveupdate: Set up FLB handler for the PCI core
> >
> > This commit sets up a File-Lifecycle-Bound (FLB) handler for the PCI core
> > to participate in the preservation of PCI devices across Live Update. It
> > allocates and preserves a pci_ser structure using KHO when the first PCI
> > device file is preserved.
> >
> > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > new file mode 100644
> > > --- /dev/null
> > > +++ b/drivers/pci/liveupdate.c
> >
> > [ ... ]
> >
> > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > > +{
> > > +     struct pci_dev *dev = NULL;
> > > +     u32 max_nr_devices = 0;
> > > +     struct pci_ser *ser;
> > > +     unsigned long size;
> > > +
> > > +     /*
> > > +      * Allocate enough space to preserve all devices that are currently
> > > +      * present on the system. Extra padding can be added to this in the
> > > +      * future to increase the chances that there is enough room to preserve
> > > +      * devices that are not yet present on the system (e.g. VFs, hot-plugged
> > > +      * devices).
> > > +      */
> > > +     for_each_pci_dev(dev)
> > > +             max_nr_devices++;
> > > +
> > > +     size = struct_size_t(struct pci_ser, devices, max_nr_devices);
> > > +
> > > +     ser = kho_alloc_preserve(size);
> >
> > [Severity: Medium]
> > Should this code verify kho_is_enabled() before calling kho_alloc_preserve()?
> >
> > The commit message states:
> > "Note: There is no reason to check for kho_is_enabled() since it can be
> > assumed to return true. If KHO was not enabled then Live Update would
> > not be enabled and these routines would never run."
> >
> > Does this assumption conflict with the Kexec Handover subsystem guidelines?
> >
> > The guidelines mandate that all callers of serialization APIs must explicitly
> > gate their usage with kho_is_enabled().
> >
> > Calling preservation APIs like kho_alloc_preserve() without the check can
> > silently add tracking state that will never be used if the subsystem is
> > unexpectedly inactive.
> 
> Sashiko keeps leaving this comment. It seems like a false positive to
> me. KHO maintainers, perhaps the KHO documentation needs adjustment?

TBH, I don't remember such guidelines, but patches are welcome ;-)

-- 
Sincerely yours,
Mike.
