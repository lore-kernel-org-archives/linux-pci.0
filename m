Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58148395AD1
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808119; cv=none; b=HTvq4+g6EOvghnjUmfwY0S+4BUtmCOLnahBbwzpWtSTWKFQdBDGIa9I8j4o6h6YYwR6Ry357R7C1comjM14WLRpktpt3mL8ybi1GYjsx/mTWfRwfCOxb7FvdZ4qelRrJtG473lgp7tDCs1Vg3rgdfObULTiR9IO9OLQXnO5fwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808119; c=relaxed/simple;
	bh=uzaIOC6zZELkU5sbR/ClnsjAfCVYnJB05KTHk4UHAVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ0TrGS38TcBkv3pqSsae4dIn/jPdXcbGp12sJ0OpUjHDjD9gd05vN2wFO9ID2IJnh+HlbSbQvQnW1hzfXCyyE7Qiy7NBNnMmtdb569lx/1gecW++0c+LLGbhkfiVAAFRHXrvba1ESn/K6SlDwHKBlkp74/XmadXD7+UmzEPLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAU1LesI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAU1LesI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785808117; x=1817344117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzaIOC6zZELkU5sbR/ClnsjAfCVYnJB05KTHk4UHAVA=;
  b=NAU1LesI+oZeAwWb5vkDkQZb9PQieyISHu0IwcUNDnych9+rxq02PbF2
   MPFu1mryPNNOcsqH5bzuIj6TmWvXuUIUz7nV1Nko1RefCiiAXKDAv7cpt
   UAf5kGaOC/GlXsCdOfB7X7SXJcAymLQOfruyy6RcvAfJ/DW+m5Z2pnIXC
   yVIBuXdfyGX2jAC1wFEvoLa2V8aNB9Ywa9p/ofH/rOLo4g6k4EdC5zlvu
   ntXpy692x019FRfodxx1CF6kJB6DKM9fNSG03IRau7pWIC5fPXsZerBrI
   3BLSEKzQD8E1DcSArW0n84unwOnfEDh4uw1cjs97uk2+qLGOHjr3KarLR
   w==;
X-CSE-ConnectionGUID: tuQH0vbsTIGx880+erjeLQ==
X-CSE-MsgGUID: jg1xU9CkTUO+w9vmzwSGIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86119957"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86119957"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 18:48:36 -0700
X-CSE-ConnectionGUID: HuofELu+RXaWlmkgQV+dyQ==
X-CSE-MsgGUID: QNt7WxEbQLm7JX6mlNDKXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260121398"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 03 Aug 2026 18:48:31 -0700
Date: Tue, 4 Aug 2026 09:48:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	ankita@nvidia.com, Aaron Tomlin <atomlin@atomlin.com>,
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
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amk7Xzm5jmz+6SPJ@ziepe.ca>

On Tue, Jul 28, 2026 at 08:29:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2026 at 06:20:10PM +1000, Alexey Kardashevskiy wrote:
> > On 6/7/26 08:08, Dan Williams wrote:
> > > Major changes since: "[PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure" [1]
> > 
> > soo with the recent sudden sad news about Dan, I do not know where to start really so I just start...
> > 
> > Here is his unfinished work which I'd really like to see finished to
> > progress with the phase2 of the plan. How do we proceed from now on?
> 
> Yes, we do, but at least I need some more time before considering what
> to do, sorry.
> 
> > The direction appears to be set, imho the immediate TODO list is:
> > - address "not-netlink-y enough" concerns
> > - teach pci_iomap() to map mixed private+shared BARs (ones which contain MSIX for the starter)
> > - always call pci_tsm_ops::enable_dma/disable_dma
> > - ditch the module trust parameter?
> > - add a knob to enable/disable DMA and keep TDI in RUN
> 
> I somehow suspect we should probably reduce the scope somewhat into
> smaller chunks at a time and try to follow this as a skeleton, but I
> haven't studied it carefully.

Hi Jason & Ankit:

Glad to see you all here to make progress! Intel can also help on this.
Can we have a meeting to discuss on these topics? As Alexey mentioned,
previously we had a bi-weekly call, perhaps use that for our first
meeting? Or what time works best for everyone?

https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be
