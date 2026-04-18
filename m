Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6F40DFAB;
	Sat, 18 Apr 2026 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470761; cv=none; b=iRU61HGC9WLwYCLpZv8igDaG+aiu82YzP1g6IR3SQQcTC9FfbiLgoum0ZTY0FRnd9m/LywsHlp+hTeFzgxk12ayv7z2Fr6tvssG3SKci9NoX28QfcT3eAg8sj8IZxD+dI/6GR58t9ZObJgSHDvrPs+HG+vXsuZQbOosrdziXU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470761; c=relaxed/simple;
	bh=QGdfCQ84T4CRb1lUGI9SJPtbILd4AIxNSPRzeNf7H3M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uBvysUf70U/x57A7Hha7USuxlf8GkhCYseFaLlQxmfP9v1UDIdGFFQVa6hIXEW7lndvzU36E9uCa8IOF42CErA1V9sk+zogQEgegFP5998+ShrSaOcmbMJlSZHNiX8MKCVHWEhn7cgx25nYFOBUNK1Jcfg2j2vdbc/fQxtob7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khG0J03U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khG0J03U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82360C2BCB3;
	Sat, 18 Apr 2026 00:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776470761;
	bh=QGdfCQ84T4CRb1lUGI9SJPtbILd4AIxNSPRzeNf7H3M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=khG0J03Uh9+m0+o/DvP8/tF4SLcHidUOl4W72LdxmHu69qkmCenLmTdI8r0jibCq2
	 tR8mTf0qdLrLOQuMbkl+uOJH6cpMhVTmi4OxxyrS0NM+wfGHBW65A3DYxDT4M9Iwp/
	 9TALxtL/Wbz/Yo1Bn3aMrZYhie5EHoA9Tbt+FkZn+OwdutYAHNwqX5FQAndnUgknz0
	 HpUGF7Zwl9Qv3Qx64UckBcHD/dSLrQZz9IkIddMczwjNFZ/qRaarygCKVW9OciUM7m
	 +5XGC7cx71Li/7QHny30OclsB4fc23T0HULOjKbHJE60yLvxDWeHJJoWm64YmB4hs4
	 /5iXkb2EhCK7A==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4CD34F40069;
	Fri, 17 Apr 2026 20:05:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 20:05:59 -0400
X-ME-Sender: <xms:58riaT96P48jQQL2LiyZiDHijo1h99w_G2O8RnastQ_zzE4fvTnJgg>
    <xme:58riae_epX6EiclWmE0fOY5ejO665fCp_mu8bG7GFSqcY007EI4kp9laxX6EBYx6X
    jL5-5PhJsGN-cFXwgMgfaedmF8BM1WE3YeIxAdNivPmlOohBGeIuKA>
X-ME-Received: <xmr:58riaT2andN52XhF-85gcw_TOPQnVNvSwLGzSfScgAALTkfiv0dqHnpjSMIVw7YM4Un4q4A0iNqVSRqoqQujkVTE4eDMPmq2J70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihi
    lhhunhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    phgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnrdhjrdifih
    hllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegsrgholhhu
    rdhluheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihihhluhhnrdiguh
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:58riaW9Ru0Vcsn6vN93WDslULGPFHk_Bko8btQSstOAzhaQ1FCNmAg>
    <xmx:58riaceui4Mm0Y9H-4Qe-r_xZKfqPb0B8ScRI498znSAgK9vR3Akyg>
    <xmx:58riaaGD9w7LbZQ1OynWIiHToINuK6hD8xmJ18ZfX9EtnO_tta4xOw>
    <xmx:58riaZCYJb8103e-nh0dqt4mZzERqxORbmUMfe6cFfMMPU6n7OZRCg>
    <xmx:58riaV4_RgIQ7mK3v7Qi14LMbf7ragtY-OxmL-bcOiwOQdn4ObkU-hB7>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 20:05:58 -0400 (EDT)
Date: Fri, 17 Apr 2026 17:05:57 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
 dan.j.williams@intel.com, 
 x86@kernel.org
Cc: chao.gao@intel.com, 
 dave.jiang@intel.com, 
 baolu.lu@linux.intel.com, 
 yilun.xu@linux.intel.com, 
 yilun.xu@intel.com, 
 zhenzhong.duan@intel.com, 
 kvm@vger.kernel.org, 
 rick.p.edgecombe@intel.com, 
 dave.hansen@linux.intel.com, 
 kas@kernel.org, 
 xiaoyao.li@intel.com, 
 vishal.l.verma@intel.com, 
 linux-kernel@vger.kernel.org
Message-ID: <69e2cae5aeb69_fe08310079@djbw-dev.notmuch>
In-Reply-To: <20260327160132.2946114-5-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-5-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 04/31] x86/virt/tdx: Support allocating contiguous
 pages for tdx_page_array
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
> The current tdx_page_array implementation allocates scattered order-0
> pages. However, some TDX Module operations benefit from contiguous
> physical memory. E.g. Enabling TDX Module Extensions (an optional TDX
> feature) requires ~50MB memory and never returns. Such allocation
> would at worst cause ~25GB permanently fragmented memory if each
> allocated page is from a different 2M region.
> 
> Support allocating contiguous pages for tdx_page_array by making the
> allocation method configurable. Change the tdx_page_array_alloc() to
> accept a custom allocation function pointer and a context parameter.
> Wrap the specific allocation into a tdx_page_array_alloc_contig()
> helper.
> 
> The foreseeable caller will allocate ~50MB memory with this helper,
> exceeding the maximum HPAs (512) a root page can hold, the typical usage
> will be:
> 
>  - struct tdx_page_array *array = tdx_page_array_alloc_contig(nr_pages);
>  - for each 512-page bulk
>    - tdx_page_array_populate(array, offset);
>    - seamcall(TDH_XXX_ADD, array, ...);
> 
> The configurable allocation method would also benefit more
> tdx_page_array usages. TDX Module may require more specific memory
> layouts encoded in the root page. Will introduce them in following
> patches.

Will skip this one as I see it gets massively reworked in your
incremental update. The change to make the caller responsible for
creating the page array is great.
