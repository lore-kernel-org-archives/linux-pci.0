Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882203451C1;
	Tue, 21 Apr 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808297; cv=none; b=H9NclRiJIDazbGOGzqjz6zVak+PtRVIy+h9E1veCU101kTA8IOq8OffRYDb8gjND5a6WvhdEbbtzeW9hJbvzsLxNGVg3aoBBxCKqebv/WvH5nFcYPMr8ehYnflV9a/vlAPkeYzW6CMPkANNTOpYaYZhX1jIlYOOOXmgYpnklqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808297; c=relaxed/simple;
	bh=8URItRpFauZLE8W6/S36pVEcJMigUBLUMd5drwiTN8w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TyXNYkwkGXr6oOkGxOahCXjjlXZQgJI5yhNFn0Ot1292+Mo8gXAEcoJz35UhiDa+hbhS0XsDJMPUorsS/vac1ppvi7swqnzJDYurKMBc32SfxZa8tG8aepu+ZOtpFsngUE1dCfGQv51zPu8EHuxZ3Des/21sJRl4n6rQ+o2971A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMh/2iZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMh/2iZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EA9C2BCB0;
	Tue, 21 Apr 2026 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776808297;
	bh=8URItRpFauZLE8W6/S36pVEcJMigUBLUMd5drwiTN8w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FMh/2iZpTdOwN9+ZNS7GINGbW8l6d8QxN+Zv+OBkgqBc+vl94dwS450PSJMTFcQuO
	 kHDT5clmWICrDv9rZ8WfxRook5OQpN81z2nslfhqFfI9Er2U/DvgdNT9txWPqi42Ew
	 Dv1cNyQfvaMSPORoSL2CXXbzlPOAVIVVpmfawUwqfV9sBM0+9bMXgL598NAwbRKuyU
	 PvKLGvLC/7K50N+rePwTaKsc2ie0RAWfzbMI5j8WXHdYCiaE55W68ICGH6IOEHtNHC
	 t/NWgKZM7JQf7T+fA8+9faxa3/KBu8qki3Ft4Ytp4UUkRjVbu8aKPgxeSIi449kYON
	 vLtyHd6ehGyug==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC110F4006B;
	Tue, 21 Apr 2026 17:51:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 17:51:35 -0400
X-ME-Sender: <xms:Z_Hnae-xWJ1rXjQDEZzqdN5QUhPRYTKWuRX5BecdGHxJEX6zhiwSPQ>
    <xme:Z_HnaXcYHZZCVZymAl0mGOW6lFPrtEOJKLvDL-OIymQ6Kkeywyew1C80KuRlp5oHt
    r40Gd3D7ISqykcR3GZp2WE19FhDwXRTT-Jx9wluYsSa00Swv8_hDZc>
X-ME-Received: <xmr:Z_HnaSt0sRg-eeRPTr6KERkX5n9p5wyypVSHzQ3OAJlRvQ_lQjtrSqOwnH6LISysAbA5QoVs_LtUFjo92XKo5_b25In2mGAdssM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihi
    lhhunhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughjsgifse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgsvges
    ihhnthgvlhdrtghomhdprhgtphhtthhopegthhgrohdrghgrohesihhnthgvlhdrtghomh
    dprhgtphhtthhopeihihhluhhnrdiguhesihhnthgvlhdrtghomhdprhgtphhtthhopeig
    keeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsrgholhhurdhluheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Z_HnaY2vq7VuP4xiDPz63HQJm1Tz0aQLSwdBhMu8XziXYaySEvXZUg>
    <xmx:Z_HnaXAshVHwzHM7MGqkrx-4W5Y6gBeN7PmvzAXJH2aDhK8zQvaoSQ>
    <xmx:Z_HnaVdC13YUfhgt-qea0b_V1UZoTEEvP4UeegTjq6g8npyJIyik0Q>
    <xmx:Z_HnaZxyG68ufTgmuya-rfsk6MSPr47cesAFsXMciDi4gv7hhdXrvw>
    <xmx:Z_HnaQNSWzzcD8S2vXyM9JYPYFdHxwICKxQWUZX9QO4MX3cILs0hjzKr>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 17:51:35 -0400 (EDT)
Date: Tue, 21 Apr 2026 14:51:34 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
 "Gao, Chao" <chao.gao@intel.com>, 
 "Xu, Yilun" <yilun.xu@intel.com>, 
 "x86@kernel.org" <x86@kernel.org>, 
 "kas@kernel.org" <kas@kernel.org>, 
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
 "Jiang, Dave" <dave.jiang@intel.com>, 
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 "Verma, Vishal L" <vishal.l.verma@intel.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Message-ID: <69e7f166319a5_fe083100f7@djbw-dev.notmuch>
In-Reply-To: <aeSTPuR9cuga+I69@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
 <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
 <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>
 <aeBufjwO3t7XzVle@yilunxu-OptiPlex-7050>
 <69e2c9334cbf7_147c8010040@djbw-dev.notmuch>
 <aeSTPuR9cuga+I69@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> On Fri, Apr 17, 2026 at 04:58:43PM -0700, Dan Williams wrote:
> > Xu Yilun wrote:
> > [..]
> > > > 
> > > > I'm drafting some changes and make the tdx_page_array look like:
> > > > 
> > > >   struct tdx_page_array {
> > > > 	/* public: */
> > > > 	unsigned int nr_pages;
> > > > 	struct page **pages;
> > > > 
> > > > 	/* private: */
> > > > 	u64 *root;
> > > > 	bool flush_on_free;
> > 
> > How about "need_phymem_page_wbinvd"?
> 
> Yes.
> 
> > 
> > That makes it a bit more greppable and not to be confused with other
> > flushing.
> > 
> > [..]
> > > Hi, I end up made the following changes on top of this series:
> > > 
> > > -------8<--------
> > > 
> > >  arch/x86/include/asm/tdx.h            |  32 +-
> > >  arch/x86/virt/vmx/tdx/tdx.c           | 561 ++++++++------------------
> > >  drivers/virt/coco/tdx-host/tdx-host.c | 179 ++++++--
> > >  3 files changed, 316 insertions(+), 456 deletions(-)
> > > 
> > > +		ret = tdx_ext_mem_setup(nr_pages, &ext_mem);
> > >  		if (ret)
> > > +			return ret;
> > >  	}
> > >  
> > > +	ret = tdx_ext_init();
> > > +	if (ret)
> > > +		goto out_remove_ext_mem;
> > > +
> > >  	/*
> > > +	 * Extensions memory is never reclaimed once assigned, stop tracking it
> > > +	 * and free the tracking structures.
> > >  	 */
> > > +	tdx_page_array_free(ext_mem.chunk);
> > 
> > Wait, these pages belong to the module now, they can't be freed, or I am
> > missing something?
> 
> With this new solution, tdx_page_array is downgraded to a descriptor,
> doesn't manage the actual data pages/memory any more. So
> tdx_page_array_free() will not free data pages, only frees the
> tdx_page_array descriptor.

Oh, I was confused by the fact that tdx_page_array_free() still loops
through array->pages in the need_wbinvd case. In the case of "never
reclaim" it will also "never wbinvd". ...and this why populate has that
"WARN_ON_ONCE(array->pages && array->flush_on_free);".

A couple recommendations come to mind:

* s/tdx_page_array_free/tdx_page_array_destroy/

  ...since "destroy" mirrors create and matches other cases where only
  metadata is managed.

* Create a new tdx_page_array_repopulate() helper to make it clear which
  paths depend on being able to repopulate and move the WARN_ON_ONCE() out of
  the common path that does not repopulate. "repopulate" can have
  "realloc" semantics where it allocates on first use, but otherwise
  "populate" gets to not care about the corner cases. Make the WARN case
  fail repopulate.

> > >  	pr_info("%lu KB allocated for TDX Module Extensions\n",
> > >  		nr_pages * PAGE_SIZE / 1024);
> > >  
> > >  	return 0;
> > >  
> > > -out_flush:
> > > -	if (ext_mem)
> > > +out_remove_ext_mem:
> > > +	if (nr_pages) {
> > > +		/*
> > > +		 * TDH.EXT.MEM.ADD only collects required memory. TDX.EXT.INIT
> > > +		 * does the actual initialization so if it fails some pages may
> > > +		 * have been touched by the TDX module, flush cache before
> > > +		 * returning these pages to kernel.
> > > +		 */
> > >  		wbinvd_on_all_cpus();
> > > +		tdx_ext_mem_remove(&ext_mem);
> > 
> > This only releases the last populated chunk, not all previous chunks,
> > right?
> 
> Not true. ext_mem stores all the data pages and the reusable descriptor
> 'chunk' for SEAMCALL. tdx_ext_mem_remove() removes all the data pages
> and the 'chunk'.

Yes, see that now.
