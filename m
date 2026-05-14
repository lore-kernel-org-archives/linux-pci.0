Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D79314D13
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786479; cv=none; b=osEgt1y5rqiPEQ5459/oubzmMoJL4gc+8YQxvhMEXLSjm2/WZj+PvaXkBKoAtub50L1jK1fLil+XCGkDRQo88/ieSxHFt5MvPdwoLmcJhBzIxHFiLyjL3+FbVhbrLynK2WA2lidiwgFfraxrqmzajYFa4hvIygUfsf0lC1ytkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786479; c=relaxed/simple;
	bh=Va3cRIqxQSKxvQEeE0XaT93j2ztCyW0k4rs+TRIemlA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=texD/auo/KjiQ06qMBIeKghWoGWIG6A/SmZiOlPFF2Bv3U9iG6imIT6oWChXOy+cLO30ML8zKWFVB8g2ByTjKgLJeiZfaG+D+q740THujtLyab7Y9UVn2Jqufvc7ZNhadZje+IY7e+BBd09o70JVJE5Pim5bBpJ7ag30uzrVtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPctDH2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPctDH2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301DC2BCB7;
	Thu, 14 May 2026 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786479;
	bh=Va3cRIqxQSKxvQEeE0XaT93j2ztCyW0k4rs+TRIemlA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UPctDH2LLktEjVOHkpBwuqq+vl9+qp5h/puKqvVeAyUwzQ0lC6qwzsLlp2KwcgEDc
	 nI9NH9xVcCj7RDpksNXuFA0cT/bMuVj2sxR1MyW8DUWRErgoS23zWz7X75/eimHRlA
	 z2M3meRsSlRstxVRA6YPfAKrwcyiaKdBH5ZpP39okYfuRE2VrYe0snrk/ySOJMxZ2G
	 OUQb9GXSiiAm+kg/iiYUUYrqs0+fmeCPvnBkWy6ALnGwmk3iAanrkc+LIjxgF089KZ
	 cUMkBtUHn7lmNInUrkn7Gaf/R/n/hlN5nlKJxLG15Y6jOqsHFPCNab3l/ty7uyCVBH
	 8TunbgcL1xUzw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 88BBAF40068;
	Thu, 14 May 2026 15:21:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 14 May 2026 15:21:18 -0400
X-ME-Sender: <xms:riAGajo3-E9hdGJbMrID3pdaKRtzBztE-TOFA30znf7o4UKxR20R_w>
    <xme:riAGapGxDkO-Q-O3lM6CaFRVRkKdIS-AeBORdCeA3xTMQCh0Y1GPPcBCUbDGFGpyr
    xrfCPJdwKNIfW2FhwjP0Xniadr6KEQzmq_c4zMdXFAAjg_-tahZ9Jca>
X-ME-Received: <xmr:riAGau4GZ4AtAiTsVDvrAiLAG6A9he7V690Sj8RS45lF1K6NFxbmQz0Bwyf4HySsOAROWEG1sem7UardWEW0h5mz7pzIswY4o08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedvgeehieekteelueffueehfeejjedvjedvveetfefgffev
    hedvuedvffevffdvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudej
    jedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsmh
    grughhrghvrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinh
    htvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhm
    pdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomh
    dprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    vhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghlih
    hsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:riAGakD2IVwUrWiEv2Z2xc-ghHZmjlFsqnyVQQz3YaCbe3zRRVNcig>
    <xmx:riAGapSl_WhSkm5SfsifJWqjJAKzVsLpW10WPjCoGxWYVgrC32l18g>
    <xmx:riAGakcTjyaIhPmXn5zjD0EiggKaXwkuYSkHx1LFvFRKM7sW23f2rg>
    <xmx:riAGaiSwr0royp6pOWwXmUPeGLTf-_ptWsVgnY5Hkpd3BdAKc6o58Q>
    <xmx:riAGag1NrZeBx2ykgJi0si4YvCqhuqYgSweTfdLQOhCSM46WhvQOfkp7>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:21:17 -0400 (EDT)
Date: Thu, 14 May 2026 12:21:16 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>, 
 smadhavan@nvidia.com, 
 bhelgaas@google.com, 
 dan.j.williams@intel.com, 
 dave.jiang@intel.com, 
 jonathan.cameron@huawei.com, 
 ira.weiny@intel.com, 
 vishal.l.verma@intel.com, 
 alison.schofield@intel.com, 
 dave@stgolabs.net
Cc: alwilliamson@nvidia.com, 
 jeshuas@nvidia.com, 
 vsethi@nvidia.com, 
 skancherla@nvidia.com, 
 vaslot@nvidia.com, 
 sdonthineni@nvidia.com, 
 mhonap@nvidia.com, 
 vidyas@nvidia.com, 
 jan@nvidia.com, 
 mochs@nvidia.com, 
 dschumacher@nvidia.com, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a0620acec806_57ad71008c@djbw-dev.notmuch>
In-Reply-To: <6a03e5c099d98_123a100e3@djbw-dev.notmuch>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-6-smadhavan@nvidia.com>
 <6a03e5c099d98_123a100e3@djbw-dev.notmuch>
Subject: Re: [PATCH v5 5/7] cxl: Add CXL DVSEC reset sequence and flow
 orchestration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dan Williams (nvidia) wrote:
> smadhavan@ wrote:
[..]

A follow-up///

> In the short term the fastest answers to those questions is just walk
> the memdev and cxl root, in the longer term I would be open to building
> more CXL awareness into the core so that CXL reset does not need a
> driver loaded.

While I do think cxl_memdev attach is required for now, I do not think
the UABI should suffer a move if the plan is to ever support more CXL
awareness in the PCI core.

It is also the case that PCI in general wants all PCI device relative
attributes to be statically defined in pci_dev_attr_groups.

What I think this wants then is something like a "cxl" attribute group
whose visibility for now depends on the CXL core to invoke
sysfs_update_group(s) when a cxl_memdev is registered.

Then we can start to build the built-in CXL infrastructure that a
driver-less "CXL reset" capability would need. I think this looks like
HDM address space discovery is separated from 'struct cxl_decoder'
object creation and the CXL core learns to reference the common /
built-in HDM address space discovery.

The main semantic we need is that anything that tries to map CXL memory
needs to wait for a pending reset, and that reset needs to be blocked if
CXL memory is mapped.
