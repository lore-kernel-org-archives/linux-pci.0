Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2144607E
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515543; cv=none; b=I+e+GhhqFJJFyMgDqVrSOYyrrZzsjeYJlENaox/mpmQ4tCL5lCI46gTAhr6h1+hI3oZK10lYv4PrcIK4fOjBe03jQHSrwEgmsVNlE9YwMBMIeoi+qeWwjaGGVp7vVXdON8yRU2QixLzSl0CDLsGbQzdQKW1QMwdA9Tacp4DZ9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515543; c=relaxed/simple;
	bh=FV9meUjcd+Nqh9yYKyKTeLGtwlXv49QbwrjqM4mX/Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijH6/oB7URv2xxu9H4YtdqsocfCLHk5yvc4GQVP6XBtwVzNE/VMlhNy7u72l1JnW2m2vClV232TC5WReAmEORBgHY2ig6THMxzPedfRPyIzMkTUCWclxzIwU9DSePJInmktfycd7jZ8m/5e0r/9pTd4fnZXOLVGnICEpcs4+g8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=BIsRA2pX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="BIsRA2pX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a65e66555cso845156a12.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1788515537; x=1789120337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3TRln1//k3zoErYU+/B3z5hgnprP+i8NqFQiEQFbYg4=;
        b=BIsRA2pXJW13hKs+IDd7g3K5TsXkLOpRPgzV+tmZ3hkjzM6gvGowNUIRIJORRCqWxa
         V/fDmXAVp96humzvwSkgBa2TJJulV0TT3EbWzwfHSKzeETA8XgLA2MXcTSKTnSSlYnA1
         kZsZE8sbVaWjovQR+RvKZ5HwZz3Yeot/c0LodGiCkb3Qk3HWK8fS2+1qeBo8h9XYZtwH
         daPqNKsUitYcquf1R5Gp/zUOXikOIrfT2wd2I2NlEOX/FRWdW0LeJwTHIN2Ny/v1uoRv
         E+crt201HJ2er+oTWRN1d9vnh/+0hevMmnnxLmAOQbnbyq624A311oktgxbK6EmdqQJU
         wL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515537; x=1789120337;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TRln1//k3zoErYU+/B3z5hgnprP+i8NqFQiEQFbYg4=;
        b=J52//E8NtMLwBJIUD5q9OxbH4JG3Z8VF2txj0NFR3wHkB7t3x7fJ04JYCBowJQti/D
         vijkG3rJVpO25oryc7aYk0rgjmDW2EkULF5GIMR43pThKJb9LbHTZARS/8NJl6sGnecJ
         +8Mf5h3Zli9ASYaiachfUxGYP6y0XDp9N+/i37JyNmWhs4YTc9PGHgV18gzVXZr2bKIK
         GCXx47/oiTAqqoIGERw6WDF0JEo08nvhXuZbr7xS00wHYd3I4aRUxJY+JlpXrEvqvnRc
         AM1dbvb20R3JzDrhMwScYOmvD4HRw892cKGYb8UyI6ppJPc3i0dsTMSk9pDa9eE4iYiD
         nPlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwurNXXP4JbVe9zLArWXd1xS/jVKs4rbCP5NjdAY9H3Fg84fuLYarwBXOtNk28PJgvItVNSN1WGtcs=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ2M/s7q7N0nhbeTrncHtWzRvA531AfhVQhrsMwC1UgRT64jpO
	ZfNAudiW66XWzUCF82j301JivVCTn2YP2N7Puh+t5pg8Yh+9wO+52Un/bLuP8rBLzNw=
X-Gm-Gg: AYBFou16skpYt22bm4DwrSXY1tvL32ASjnGPhjStzRKtopask6uUJB0uKlAR4dFRbEI
	rqPfbgesfi1gaOs+JSB03tvCR53Uc0Y69gYfLv9yQdGrDVYd+kqC1Te6rMUgbLS5CincsLtHiNl
	Kw6zxn3wmE71ry4oTBoYov3V5mOzRyC/2rRK0JILuilcRQH9VvDpZ1ybmo058kMlUjm4spNZOqx
	n5AQv3KSwoSp1dHLSHG+2Qy3NPvswt+2OUNKiVO0VIRvc5/Yr5dWAp4NiwbguOIBc06cYI8sVn+
	2VzD/oLYSVs+d3jHE3UkwLD46Bwa0tdQmB+7DEpEA4q40H3mZmSx3Ny5Ju59fjRO1hklAS+YIjF
	dnBEl74gO/WnEadNEG8tvotBBGPeWStpljkfpCqur9LvzCcttX6Htimlicg4XuNigs7CI4cFY/I
	+VmSOsGkyU0wgauSRB3WHrFitKbZ8dGQpFw+klkdFcBqXZKWEyDDFSCp/9tbIIIlxMgt3SC4c+A
	1wqXN/KMaf2jyncpMw=
X-Received: by 2002:a05:6402:51d0:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a7e8d8ded1mr1586216a12.10.1788515536608;
        Fri, 04 Sep 2026 02:52:16 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bee8e8sm1003148a12.23.2026.09.04.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:52:16 -0700 (PDT)
Date: Fri, 4 Sep 2026 11:52:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>, 
	Alistair Francis <alistair.francis@wdc.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, 
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	Leon Romanovsky <leon@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <apqSAQykEK3MF9AO@FV6GYCPJ69>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
 <apl39vOiMPP7VloW@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl39vOiMPP7VloW@wunner.de>

Thu, Sep 03, 2026 at 03:36:54PM +0200, lukas@wunner.de wrote:
>[+cc Jonathan, start of thread is here:
>https://lore.kernel.org/all/20260902150125.GD2890729@ziepe.ca/
>]
>
>On Wed, Sep 02, 2026 at 12:01:25PM -0300, Jason Gunthorpe wrote:


[..]


>
>> I've asked Jiri Pirko to work on
>> the PCI evidence uAPI based on his deep netlink experience
>
>netlink isn't well suited to transport large blobs because the nlattr
>len is u16.  (The len of the enclosing nlmsg is u32, which is sufficient.)
>
>Previous approaches, including the one proposed by Dan in this series,
>work around the problem by splitting the blob into a sequence of nlattrs.
>I think we should instead extend the netlink protocol with 32-bit "jumbo"
>attributes.
>
>I suggest we reserve bit 13 of nla_type as NLA_F_JUMBO and use the
>the first 4 bytes after the struct nlattr header as length (if the
>jumbo flag is set).
>
>
>A second problem is that the size of a socket buffer's linear data
>is limited.  Also, copying the blob into the nlmsg is a bit wasteful
>and we'd want zero copy instead.  The solution I've come up with is
>to attach the pages backing the blob as fragments to the skb.
>It's very simple, overcomes the skb size limitation and allows for
>zero-copy:
>
>https://github.com/l1k/linux/commit/6e73bb999128
>
>That commit is from January and the time I've been able to devote
>to this has since been limited as my employer prioritized various
>AER feature gaps and fixes.
>
>I worked on this for native PCI device authentication, which faces
>the same netlink blob issue as TSM-mediated authentication.
>Both should use the same uABI for evidence exposure.  Additionally,
>native device authentication may be used by non-PCI buses such as
>ATA or SCSI.  The uABI should work for those use cases as well.

Not sure if netlink as actually the best fit for this purpose,
for large blob transfers ioctl-based iface is probably much more
convenient. I'm working on a uapi framework that make the best of
netlink and takes it over to a fd-based ioctl. I call it CTLV, here's
a link to an early pre-RFC draft:

https://github.com/jpirko/linux_mlxsw/commits/wip_ctlv_pre_rfc_draft1/

What are the benefits over generic netlink:

- No networking in the dependency chain. No netlink sockets,
  no CAP_NET_ADMIN, and no network namespace semantics to reason about
  for a device that has none.

- One character device per registered instance, not one global family.
  Access control is the file: udev rules, ACLs, an fd passed into
  a container.

- Events per open file description, not a multicast group.
  Each descriptor has its own subscriptions and queue, and an overflow
  is reported in-band: the next read returns an event-overflow record
  naming the first and last sequence lost and how many.

- Large payloads are referenced, not copied. A blob attribute carries
  a user VA, a memfd and offset, or a dma-buf fd. Nothing big travels
  through the message.

- One YAML specification, everything generated from it: kernel metadata,
  UAPI headers, userspace bindings and the reference documentation.
  Introspection is answered out of the same metadata the validator
  enforces, so a device cannot advertise an operation it will refuse.
  A checked-in ABI snapshot makes any wire change a reviewable diff.

- Family inheritance. A family inherits another's operations and fills
  declared extension points. The effective schema is resolved per
  device and the chain is exposed to user. A shared core with
  per-driver extensions is declared once, and both attributes and
  operations can be extended.

- Introspection is per-device and live. The framework answers three
  queries on every device: the family chain, one entry per published
  operation, and any operation's full attribute tree with its bounds
  and limits.

  The answer is what this device accepts right now, including what
  a vendor extension added to an inherited operation and whether an op
  is currently disabled, and op-changed events carry the generation
  ops-dump reports, so a dump can be ordered against a change.
  GETFAMILY and GETPOLICY describe a family statically - there is
  no device in that model to ask.

- Fragmented queries are built in, with a consistency check.
  A continuation carries the generation it started from, and if
  the answer changed underneath it is refused with ESTALE,
  reporting the expected and the current generation instead of
  reassembling a torn reply.

- Attributes are 8-byte aligned. CTLV_ALIGNTO is 8, so
  a 64-bit payload is naturally aligned and there is no per-family
  padding to remember - netlink's 4-byte alignment is why
  nla_put_64bit() needs an explicit NOP pad attribute.

- Cheaper round trip. A one-attribute query measured 2.6x cheaper
  than a genetlink one in the same guest - a debug kernel.

- Async operations using io_uring are planned as a follow-up extension.

The framework owns validation, schema resolution, blob acquisition,
reply serialization and the event queues. All getters and putters
are generated helpers. A family implements semantics only, and
the aim is to make that hard to get wrong.

[..]
