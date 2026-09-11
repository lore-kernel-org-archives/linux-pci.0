Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9F496D38
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145056; cv=none; b=MGcYF5457rfx1ia8EbX513k+ZZqq8eVrQw3pfACOH/L2vjJePcej6NaPzDCKrvTE2mWqPiObuPtrx1gtxSUj+soZiqqQgigU1D6gu78tPNtNPjktoNF2Uv1mm+zNafjaAo5JTUNEGQrAXnXRSqK76/dAs1KhWBfwcXYp1WhhTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145056; c=relaxed/simple;
	bh=hd5NL3Gh1DmDr5bvMSZgx1o+RubAP4rmHWQw/+dH+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFmSnJ1Q1kio89Dfy9VZfGXAbjp/6RMBn3yQ9xWUBmj1+STyNS87F/Nu3vXwf2tWTpxI0jGsfCO5iHJiqOAmd57gdpbxPuPr3fwwaM+Zp+WNMItj9J3hoeIZrUhGpBgtK5WojQvOO88N8Yfn0YRdn7ZTdV3oVQ0Aru9k6qHhCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anElV8w6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anElV8w6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d9520b9155so11560075ad.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789145054; x=1789749854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sNNu1TO589CWD7onDuXMEv1eJ3q2rtxkDJ3Q314d4zo=;
        b=anElV8w6OEfxZI0Pr7TpU9UjsIivDTVEo8HuBq6wOvaJaFCVqtq0q88Q475G741GVZ
         OUWUa3SvE8vzUbqsugjc5gCmX5eX9ZYNIw9lK6dtyuaJIugbk4blBfuG2SUDP7w0fGY3
         Ey6N4YTjQWdQlGqXKNuoLSko+uZVOD4QFW907KzQRLaX7GVp3tY4nqxsgtmBIFKpdo2D
         QNE32cdMFaEmVMGT+E5mg3GHyZYMZGWyO2gcIPisfNeVl0bn3FVdOup7je9BaRR5ftxN
         l3JiVdN4PBCtPhGnEfFYx9j/Pt5r4QW814nRy7QDRy3QWbeqewP05YMDvm8K+M6zmxk5
         PtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145054; x=1789749854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNNu1TO589CWD7onDuXMEv1eJ3q2rtxkDJ3Q314d4zo=;
        b=aTCUXFHBU8zcoJWgqkuw+Pqax5URVT2pFCZjPIGvzFUMhx5S9VG0U+PMhPvKS/URt5
         3fbmb7W8pTX2lsQoYsarP8rl36jz/Td6CJbJBpfhXbgRPseF6mQ5xxDg9DejXD2Aoijw
         +bn1itkCYz6+G7x1eQgQSqVEnGAhQffsk7V1GmZkniU6q/kjlssYYsQqhoj7rSjBE0KR
         c2JWiwa8VUoQnQuaiP3rUQ2beCNbpMkbarGw6BIra745qHRFJs4wmlHvKlI40Nkcw2cm
         FWqiUOPibx2qcrkMvC9ssoWYSFPcRjvcIGcX2ndHXBApcHTKZyzOO1xfwdgRC/VJYjmC
         x2tQ==
X-Forwarded-Encrypted: i=1; AKwUvByYdSCzObEM3l+1iL3t/2fHDcgqKqzfqORGRlbDzjBad6MTzhvH3k25Gk15NPvLVHK01b/VKMzjKIg=@vger.kernel.org
X-Gm-Message-State: AFuF++k+S3W3HJq+3fzYtuE/U5Nh/DYkwf/E6FWLMYM8gTHuOuMvsGA0
	FlkQNk/L21YlyAdjqO7tXm3wFJqLROlfDxeQPycO0oKxODgZW8xgFW+aGhFmdQFHbw==
X-Gm-Gg: AYBFou3pnJvz52B24j4PsKPH9T7WyfNlZIJ3bVOO5wZ12yLor/pJh9FBQXvr2/Crik+
	gQdZ13kYiReYpJ7H4uIKhJSyeQ0MOcPpWL2NumpLCgON0mOCBS9bd3DwDRwinF2ynJdxc1M+wTd
	XR4ZbjnTPY/A8JX84KFTJpcZmVe2bZMp/wVvTLRzBpuY7XOcH7R1NNxIGtTtensoBbNrHag/4Yl
	YM6P9lVGem59LJPUvltLYLKoc+xbBfFCuKT0VKEMMN+WXUUfYV1xt1m0hda3pjPnooSjNRHGfsQ
	ndXj4l3ASViAOqCoUMUHwL3Clvy6A2/PmLzEZ0+zK+JPmgDyFo7vSBeIqCId6Y5eVZ5izAdDB5d
	oQThqEng8tgL6q2eBjmbEyx6su5X9/uwcucfj7LJyb14i1SSC3H05V/wUTo3rPxbnNJq7LyHVIy
	ibgmTc4UDvPIxSHrJuVBXeVGT+LFyNvGaZREz8OrMEHnrWy8ahOKnDaKBIHxwZNxcy8P2Url1I8
	HdwaWe9AWRuIsVgTUnsqqQLfdbe9+aGsT8re+sQ
X-Received: by 2002:a17:902:f546:b0:2dd:40cb:a04c with SMTP id d9443c01a7336-2dd40cba291mr28022885ad.19.1789145053219;
        Fri, 11 Sep 2026 09:44:13 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca263fsm14640505ad.6.2026.09.11.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:44:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:44:02 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aqQv0jJdT4xq6VWu@google.com>
References: <20260728221007.2098560-2-dmatlack@google.com>
 <20260910234824.GA366888@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234824.GA366888@bhelgaas>

On 2026-09-10 06:48 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> 
> I assume pci_ser is the state the PCI core needs to preserve across
> kexec so the new kernel's enumeration doesn't interrupt the device
> operation.  And that whatever state the endpoint drivers need to
> adopt/inherit the device in the new kernel is managed without any help
> from the PCI core?

Yes.

> > Preserving PCI devices across Live Update is built on top of the Live
> > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > expected to expose a file to userspace to represent a single PCI device
> > and support preservation of that file. This is intended primarily to
> > support preservation of PCI devices bound to VFIO drivers.
> 
> Where do drivers expose this file?  sysfs?  I guess it's a file per
> preserved device?  Thinking like a driver writer, I'm expecting a hint
> about how to expose this file (should also be in the file doc somehere
> if it's not already).

There is no requirement about how drivers do this from the PCI core
perspective. For all intents and purposes, the VFIO PCI variant drivers
are the only drivers that are going to be supported in the next 1-2
years. They expose a misc character device for each file.

> 
> > This commit enables drivers to register their liveupdate_file_handler
> > with the PCI core so that the PCI core can do its own tracking and
> > enforcement of which devices are preserved.
> > 
> >   pci_liveupdate_register_flb(driver_file_handler);
> >   pci_liveupdate_unregister_flb(driver_file_handler);
> 
> So a driver calls pci_liveupdate_register_flb() once, then
> pci_liveupdate_preserve() once for each device it wants preserved?

Yes

> > When the first file (with a handler registered with the PCI core) is
> > preserved, the PCI core will be notified to allocate its tracking struct
> > (pci_ser).
> 
> The passive voice here makes the actors a bit obscure.  I guess a
> LIVEUPDATE_SESSION_PRESERVE_FD ioctl on some per-device file kicks
> this off?

Yes. (And I will reduce the passive voice in the next version.)

> I guess the pci_ser allocation is in
> pci_liveupdate_flb_ops.preserve(), i.e., pci_flb_preserve()?

Yes.

> So the PCI core tracker (pci_ser) isn't actually allocated at the time
> of pci_liveupdate_register_flb(); it's allocated on the first
> LIVEUPDATE_SESSION_PRESERVE_FD ioctl for a driver that has called
> pci_liveupdate_register_flb()?

Yes. The first device that gets preserved triggers the allocation of
struct pci_ser. And the last device that gets unpreserved (preservation
cancelled) triggers the freeing of struct pci_ser.

> IIUC the call tree for that ioctl looks something like this:
> 
>   <driver>
>     pci_liveupdate_register_flb
>       liveupdate_register_flb(fh, &pci_liveupdate_flb)
> 
>   luo_session_ioctl
>     op = &luo_session_ioctl_ops[...]
>     op->execute                               # eg luo_session_preserve_fd()
>       luo_session_preserve_fd
>         luo_preserve_file
>           luo_flb_file_preserve
>             luo_flb_file_preserve_one
>               if (outgoing_count == 0)        # only for first FLB device
>                 flb->ops->preserve            # eg pci_flb_preserve()
>                   pci_flb_preserve
>                     ser = kho_alloc_preserve  <-- alloc pci_ser
>                 outgoing.count = 1
>           fh->ops->preserve                   # something not included here
> 
>   pci_liveupdate_preserve
>     pci_liveupdate_preserve_device
>       dev_ser = pci_flb_alloc_dev_ser  <-- alloc per-dev PCI core serialized state
>       dev_ser->bdf = pci_dev_id(dev)
> 
> Seems like kind of an awkward way to allocate pci_ser.  Couldn't it be
> allocated on the first call to pci_liveupdate_register_flb()?  That
> would be a lot easier for driver writers to trace through.

I agree the LUO FLB API is a bit awkward, but this is how it works.

If we allocated it during pci_liveupdate_register_flb() we would then
need to stash it in a global variable to hand-off the LUO later. Despite
the awkwardness of FLBs, it is useful to avoid globals and have LUO
management the lifetime.

> > When the last file is unpreserved (i.e. preservation
> > cancelled) the PCI core will be notified to free struct pci_ser.
> 
> There's a lot going on behind "PCI core will be notified".  I assume
> these refer to the first-time behavior of luo_flb_file_preserve_one()
> and last-time behavior of liveupdate_flb_put_outgoing(), which is
> honestly kind of hard to suss out.
> 
> This series doesn't include a caller of pci_liveupdate_preserve() (or
> pci_liveupdate_register_flb()), so I can't figure out the ordering.
> Obviously pci_liveupdate_register_flb() must be first.

In every version of this patch series I have sent I included a link to
the vfio-pci driver changes that build on top of this, rebased that
series on top of this one, uploaded it to my GitHub, and included a link
in the cover letter. Here is the relevant section from the v8 cover
letter:

. This series was tested in conjunction with v5 of the VFIO PCI driver
. series:
.
.   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
.
. The full set of patches used for testing can be found on GitHub.
.
.   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio


> I first thought pci_liveupdate_preserve() would be called via the
> fh->ops->preserve() in the luo_session_preserve_fd() ioctl path, but
> it's not.  pci_liveupdate_preserve() is intended for the driver to
> call it directly.  But it looks like it has to be called *after* the
> ioctl?  Obviously I'm confused :)

It is called by the driver during it's fh->ops->preserve() callback. In
other words, it is called during the ioctl by the driver.

LUO just knows that a file has been preserved and what preserve()
callback it needs to run to preserve that file. It is has no idea which
files correspond to devices or which devices. The file could be a memfd
for all LUO knows. That's why the driver has to call into the PCI core
via pci_liveupdate_preserve() to let it know that a device is being
preserved, and which.
