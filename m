Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A94AF9E2
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442640; cv=none; b=BxSOwv3PTjGpD+j1IbHNl3Iq+cROom1pxbphSsMIHYEbvbNH3Tc59BjgMfgoEPWigNUoyyV9NLCJEqwIyy86BhIAs6IHLOxd+BNgzQFCSc2RkWxbAqttb8m4c7aHNsRTS0rBtrNOFJLIcqWoE+axJgZdf0ZN540TqYRQb0PVin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442640; c=relaxed/simple;
	bh=/ApVbgGpPkQ7jmrXNkec4xKjkgmOYiJG2kztu+4FFkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUOaA7fyJJuCYOm24XaRvhPCTfH/8wv3/eWIrAVLzh+JSe6ETIWurkgTZ360KI/NV38FqnG3aJ9li7r9Pexdn1WGQ0YMqC0ikXoszsl7f0HZiih/mLhahceUVQZf8ht5OZIJOabk/L+7Ql+NOrh3s10LcfvckXf6rp2SO/brdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 20CCC1062A;
	Thu, 03 Sep 2026 15:36:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 054806004A96; Thu,  3 Sep 2026 15:36:54 +0200 (CEST)
Date: Thu, 3 Sep 2026 15:36:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	ankita@nvidia.com, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <apl39vOiMPP7VloW@wunner.de>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902150125.GD2890729@ziepe.ca>

[+cc Jonathan, start of thread is here:
https://lore.kernel.org/all/20260902150125.GD2890729@ziepe.ca/
]

On Wed, Sep 02, 2026 at 12:01:25PM -0300, Jason Gunthorpe wrote:
> In the short term I
> will volunteer to send patches (ie bug fixes!) to Linus in the CC area
> Dan was responsible for. Please email me if something needs some
> attention and we can figure it out.
> 
> To fully move forward we need to establish a new TSM maintainer
> team.

I created the "devsec" group on git.kernel.org a few years back
to host trees related to device security.  The first repository
of that group was spdm.git for the in-kernel SPDM implementation
and native PCI device authentication, with Jonathan and I as
co-maintainers:

https://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git/

Dan was added as third devsec maintainer to host tsm.git:

https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/

Jonathan and I retain access to both repositories.  I cannot speak
for Jonathan but I would be available to apply patches to tsm.git
and forward them to Linus.  It would also be possible of course to
add additional maintainers to the group.

> I've asked Jiri Pirko to work on
> the PCI evidence uAPI based on his deep netlink experience

netlink isn't well suited to transport large blobs because the nlattr
len is u16.  (The len of the enclosing nlmsg is u32, which is sufficient.)

Previous approaches, including the one proposed by Dan in this series,
work around the problem by splitting the blob into a sequence of nlattrs.
I think we should instead extend the netlink protocol with 32-bit "jumbo"
attributes.

I suggest we reserve bit 13 of nla_type as NLA_F_JUMBO and use the
the first 4 bytes after the struct nlattr header as length (if the
jumbo flag is set).


A second problem is that the size of a socket buffer's linear data
is limited.  Also, copying the blob into the nlmsg is a bit wasteful
and we'd want zero copy instead.  The solution I've come up with is
to attach the pages backing the blob as fragments to the skb.
It's very simple, overcomes the skb size limitation and allows for
zero-copy:

https://github.com/l1k/linux/commit/6e73bb999128

That commit is from January and the time I've been able to devote
to this has since been limited as my employer prioritized various
AER feature gaps and fixes.

I worked on this for native PCI device authentication, which faces
the same netlink blob issue as TSM-mediated authentication.
Both should use the same uABI for evidence exposure.  Additionally,
native device authentication may be used by non-PCI buses such as
ATA or SCSI.  The uABI should work for those use cases as well.

> This is the only time Europe could reasonably participate in,
> obviously it is not OK for China and Aus.

FWIW, I'm likewise based in Europe, as is Jonathan.

> > I find these calls pretty productive syncups. So
> > far we were not having Europe in these calls.

There is a CCC call at a US/Europe friendly time but the meeting
is usually canceled.  There was a single occasion in June when it
wasn't canceled but very few people showed up and in particular no
moderator showed up.  Dan said that someone at Google is responsible
for the meeting, I don't know who that is:

https://youtu.be/_cNgyfYlDGo?t=501


Obviously, one cannot separate discussing Dan's work from Dan.
It is still difficult to talk about either for people who were
close to him, and he was close to many.  Anyone who has lost
somebody dear to them knows that grieving and eventually
accepting loss is a process that can take years.
We're only at the beginning.

I've suggested a celebration of life for Dan at LPC, to complement
the service organized by his family last Sunday.  I am happy that
the organizers reacted positively:

https://lwn.net/Articles/1084564/

See you there!

Lukas
