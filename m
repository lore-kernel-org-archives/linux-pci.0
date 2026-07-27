Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E223CCFB8;
	Mon, 27 Jul 2026 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180424; cv=none; b=srokJKD2ooOSsq+4j5aLeJRzYikUgqwI3UgWDgX9khHANU2p0t6dpxcySwTlD0+D0gDpSJLicgXWiWx9ukBgtOhynSHA8u/3XiLaOdnXH43M4STWqZ26qYI55LUIu16DjDZl12qE8tWmXummd2AqIuBgVG7lKWMSL+qyD8eIQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180424; c=relaxed/simple;
	bh=4RoRD99AfLP5NZOE3pDGSZ3RQEMc09eY+WJD8jtqH5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Es8aq90ZVvayrF5tu8rmfyI0/nESGtOQs31d0sMsIRMBizgAyxCFznNbrgIEZQtmYgR6zcyQF7djgWEymwf2SPOXrqIQ7absbUPWxGXTzy+5s42f4fA8mHQs7RvWUwtuUu18O8X9R6KM1FX33yz8nN28NHoE8K1ex3qKpwuUdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzYilg/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzYilg/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36551F000E9;
	Mon, 27 Jul 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180423;
	bh=sKZJ5OViBbK3ZJT1F6pApbVMnloDUEEXkiEo8E43BZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IzYilg/M8OJawVypIyI6yqeauwbZiYHFTE/2k3KHuRHUxMx0FStRiRDIYwLSXuz+j
	 05E1VSdnB8lEC6Dizt4VUGoyC5z/mveyiibWsgRdAlvKKIkj48/ah7F6UT2aCwtI+P
	 M7K/wl4ZU3s2ty47OdvEC9FdpqZZooqnD/YPe5dYLEcIqXgPRe9z+IRv0OGOjxpiCI
	 Jkkv2KqNrNrHHFyKWrUSu4jKNcR9MN7OKjAKqyH6336kbZXEsU0FdJisLbzQ98yFFp
	 BOxeFggnvJIK1ABfQTx2tpoMDd3ziP5gU/FGGW5Hjp9V/egQQBr6nc61xzYH0DhpGX
	 yRf6bic++oydw==
Date: Mon, 27 Jul 2026 14:27:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
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
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260727192701.GA1250952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>

On Mon, Jul 27, 2026 at 10:40:52AM -0700, David Matlack wrote:
> On Thu, Jul 23, 2026 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > it to participate in the preservation of PCI devices across Live Update.
> > > Essentially, this commit enables the PCI core to allocate a struct
> > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > one device is preserved.
> > > ...
> >
> > > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> >
> > Is KBUILD_BASENAME buying us something important here?  Just from
> > code-reading perspective, it's more work because without some digging
> > I don't know what it will end up looking like in a dmesg log.
> >
> > > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > > +{
> > > +     struct pci_flb_outgoing *outgoing = args->obj;
> > > +
> > > +     WARN_ON(outgoing->ser->nr_devices);
> > > +     kho_block_set_destroy(&outgoing->block_set);
> > > +     kho_unpreserve_free(outgoing->ser);
> > > +     kfree(outgoing);
> > > +     pr_debug("Unpreserved struct pci_ser\n");
> >
> > If this pr_debug() is useful, maybe it should include an address and
> > there should be a corresponding pr_debug() on the preserve side so we
> > could find things in a crashdump?
> >
> > > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> > > +{
> > > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible);
> >
> > Is fh->compatible enough to identify a driver?
> 
> Not necessarily. VFIO could theoretically have one file handler that
> handles all the vfio-pci variant drivers. But I suspect we'll end up
> with 1 fh per driver in practice.
> 
> Are you thinking about how we can ensure devices are bound to
> compatible drivers after Live Update?

No, I don't understand enough to worry about things like that.  I'm
just wondering if there's enough info in the message to be useful,
since fh->compatible is the only text that's variable.  Same reason I
asked about the "Unpreserved struct pci_ser" message above.  E.g., if
a user reports these messages, will we need more information to debug
it, or is the message itself enough?
