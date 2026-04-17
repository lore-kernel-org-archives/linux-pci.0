Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A622B8C5
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470326; cv=none; b=C6KieR2jGPjzWlIjIPcOBFb75Ti/wmtkX+mBtvwyAILIKjEzRMV6W/m29vNSRkbFSCje0UEblCgpSJYgksVeKOW95f+TKP1p9On/3wk3+Scxs/MgJQYORwgzJOWro9CJDtl+5e7QF5yDs+Gp14BVDvs1Opms1xPFi9/E6dBQd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470326; c=relaxed/simple;
	bh=GEwx8TwcWm6NsxrCs3bU71hRFfX/t2FIn5eAGTM1Thw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PlawwHvYKHI0cofqWGTr67Ix+CosV/lNbnlSjcX7vp1UujLmYDjezDzRYHnE7wBbdPdRxoZ2hEafujRWpcTyxgMkKD4QzVB+trdcUtan31YylR404FqcE0Yhv7CYQJQW4La5pa4/GgZ9fYKZO8c7GgWBc7yynOl3xlAyMw2IQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBUYjArY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBUYjArY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AAAC19425;
	Fri, 17 Apr 2026 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776470326;
	bh=GEwx8TwcWm6NsxrCs3bU71hRFfX/t2FIn5eAGTM1Thw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OBUYjArYot5sJ05JnSFDX8XXET0ccRSaZhN+18pvrc1jzefYjjJy/t2D4KGGiV6u+
	 +E6tDWXmbu1V/qpcHkuiHi7ZIX/j0EUAn3014aSX3dnXGaDNKKnmKdtn4x7pHQ68NW
	 orH7cTMo6Lqpf/3SVFtM7yEHH3BWgz1Jqvv9d8bubyYx3p5YJXEIjRageqlrlUQMsZ
	 2Re5PxIndr39C7KifBvVIKbLiaejtn/xisVZ+Gv9ZYFX4UfKd1HvYDjI+g0Z4eVnHR
	 NXWGFlPbWR6urGzfLpPDDCnKKJG+e3CPQOfedU3x0kSy6hkrwF1zqs8RjYyoLEB2fJ
	 Dkqk8sHuO+PEA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D36AAF40079;
	Fri, 17 Apr 2026 19:58:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 19:58:44 -0400
X-ME-Sender: <xms:NMniaecjxAaZbeOh2n8_8bx07bEhgbF0x4Y43jekRbKCTtaB8v17PQ>
    <xme:NMniaQ9v4SHaM1QOnXSB0iUMBa3jfr8wIt6jFRb_Im9xS-dhgXSWvHfQS8ny4Eb4T
    c74WY04vzkGylaimYR5eV3lWDfZyg8aToQV-dTx-aVQ0vynpWT6V8k>
X-ME-Received: <xmr:NMniaePiNqVMRFKAFLTzBH0pJskcCHifzmPA0J3vmZARQGRAHJEVJzQMRsfLP5Fne0pS4if--vE4XJwS-rpqmB8BzDGSkNDAm1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehuddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihi
    lhhunhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghkrd
    hprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtoheptghhrghordhg
    rghosehinhhtvghlrdgtohhmpdhrtghpthhtohephihilhhunhdrgihusehinhhtvghlrd
    gtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhigrd
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopeigihgrohihrghordhlihesihhnthgvlhdrtg
    homh
X-ME-Proxy: <xmx:NMniaeUjlQ24i5SQ1tfmld_kkpCpHXLnvcMPaIhmtTz4O4VwofVtrg>
    <xmx:NMniaejFkg_O1pfaZ2FmQHqYN_7UwBZYK31H-jdKU64PqVVul8eHMA>
    <xmx:NMniaW9qIyVUq4p7DKmkEb0wK-vaC_JkWMw7XbkKgzzEctx6bK3ZRQ>
    <xmx:NMniadQUrhfvkJFjZyFrHyxHidy0kjDzHclnXf6IlpyQA5gwNcQh1g>
    <xmx:NMniaduzKJxusRAHabJrVcbMyndRhafTeXPeMVigWpQvP2qL-WOtUNxE>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 19:58:44 -0400 (EDT)
Date: Fri, 17 Apr 2026 16:58:43 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, 
 "Xu, Yilun" <yilun.xu@intel.com>, 
 "x86@kernel.org" <x86@kernel.org>, 
 "kas@kernel.org" <kas@kernel.org>, 
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
 "Williams, Dan J" <dan.j.williams@intel.com>, 
 "Jiang, Dave" <dave.jiang@intel.com>, 
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 "Verma, Vishal L" <vishal.l.verma@intel.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Message-ID: <69e2c9334cbf7_147c8010040@djbw-dev.notmuch>
In-Reply-To: <aeBufjwO3t7XzVle@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
 <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
 <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>
 <aeBufjwO3t7XzVle@yilunxu-OptiPlex-7050>
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
[..]
> > 
> > I'm drafting some changes and make the tdx_page_array look like:
> > 
> >   struct tdx_page_array {
> > 	/* public: */
> > 	unsigned int nr_pages;
> > 	struct page **pages;
> > 
> > 	/* private: */
> > 	u64 *root;
> > 	bool flush_on_free;

How about "need_phymem_page_wbinvd"?

That makes it a bit more greppable and not to be confused with other
flushing.

[..]
> Hi, I end up made the following changes on top of this series:
> 
> -------8<--------
> 
>  arch/x86/include/asm/tdx.h            |  32 +-
>  arch/x86/virt/vmx/tdx/tdx.c           | 561 ++++++++------------------
>  drivers/virt/coco/tdx-host/tdx-host.c | 179 ++++++--
>  3 files changed, 316 insertions(+), 456 deletions(-)
> 
> +		ret = tdx_ext_mem_setup(nr_pages, &ext_mem);
>  		if (ret)
> +			return ret;
>  	}
>  
> +	ret = tdx_ext_init();
> +	if (ret)
> +		goto out_remove_ext_mem;
> +
>  	/*
> +	 * Extensions memory is never reclaimed once assigned, stop tracking it
> +	 * and free the tracking structures.
>  	 */
> +	tdx_page_array_free(ext_mem.chunk);

Wait, these pages belong to the module now, they can't be freed, or I am
missing something?

> +	kfree(ext_mem.pages);

Releasing this makes sense.

>  
>  	pr_info("%lu KB allocated for TDX Module Extensions\n",
>  		nr_pages * PAGE_SIZE / 1024);
>  
>  	return 0;
>  
> -out_flush:
> -	if (ext_mem)
> +out_remove_ext_mem:
> +	if (nr_pages) {
> +		/*
> +		 * TDH.EXT.MEM.ADD only collects required memory. TDX.EXT.INIT
> +		 * does the actual initialization so if it fails some pages may
> +		 * have been touched by the TDX module, flush cache before
> +		 * returning these pages to kernel.
> +		 */
>  		wbinvd_on_all_cpus();
> +		tdx_ext_mem_remove(&ext_mem);

This only releases the last populated chunk, not all previous chunks,
right?
