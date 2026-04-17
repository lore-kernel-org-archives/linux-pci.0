Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191B327BFA
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469014; cv=none; b=IAgLgbumacGe79q9UsGZEeICrdRyhu/2kKvnD6VbKGQlMXN0KuFAmB0hd5GTHFl+8lMJto0C+k4EIY1V7qALvR4WUPMmDhgkydSb4H0QWJNJO3CqYviLjU2LdUXpWdgwp1oMEcb3qUUhJl+vnmgRSRNJTQPApzbpjeEFI4XNy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469014; c=relaxed/simple;
	bh=bR+JfLgOReiZQpPuPbj2jQ8xLtLBFTAd/AMflQ9NMAA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B9/C/wn/yQEiIEYJhY9Fl4IAxwlVLo/aFrlmdnsJ+su5/EgUpYMoxwGwzae4TOV5+BofLMLHubjO4ILscORLqa2CZ2BRZfnjWn7BICb1bQZY4SeMktg3pkKwFCPBYUNGBosQa5IWTBVTSX+TEiZsKuctdw4feSEgyV67+JQHYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it8Rvy5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it8Rvy5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D2EC19425;
	Fri, 17 Apr 2026 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469014;
	bh=bR+JfLgOReiZQpPuPbj2jQ8xLtLBFTAd/AMflQ9NMAA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=it8Rvy5LOWSAwCxfh/L9FATVWm7HqKML3/IJlZBZU6X+gimBODPjLkGK40Z/lNQIE
	 HFYaLKUjT0VDLmsdXp4PWARmyhWRt7F+NEkUXc25x34hNc+9499zA4ubr2Hx2+GL7s
	 nhuxEiWr6fzsOFvFI4CeGtK1L4nVTUTr+exgnIjEBKlen/uQC9X3e8I67i+1a6kVcW
	 CbHccJ94jS6PLLaYLwEb6BH635PDLZ++BKravkq6lqV7z9te+2NonE0N6e4gVlirFl
	 O/LYY9L2nQH1DAFJab8Ybtg+CjqZJLd50HlJHcBo5KgrtvX4EI8RXVJt0fbIgO5qBA
	 axMYiv4RXNgjw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE903F40078;
	Fri, 17 Apr 2026 19:36:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 19:36:52 -0400
X-ME-Sender: <xms:FMTiaau7pCV2wgJ-RMJpY12MddUIoRnE74EY89xVksjW8ZhJlP9lgg>
    <xme:FMTiaevBGXgOXjEkoA8Aa3PcBKJfAKOhOWrvZHbkYSKE1c58D3YWNYF6iwLh5Tj8I
    b92FiIj_UR3_BTRnCMNwWFsvcaldmo5qAeguCWcCu4MajWj1TyPSGk>
X-ME-Received: <xmr:FMTiaYmnM_AgrUA2PrQcE9UMGwoxrDzFrrH7_1MxxZK_cl-D1Ac2yYMaLrf2JyUhY6U8qUkyg09fpP_hKNh7EdZm0RFtUDxbSAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehuddvvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:FMTiactCoWthaudJ_FKux-4nERbEFkionn0XhDuK0tvA9jSrtoxWjQ>
    <xmx:FMTiafMaHIbPpSZKw-GTQdUv293XnDfDdvR7O4tdkbqS68Q_V45RPg>
    <xmx:FMTiaV0aNci_pxg0eTQo9dEKFvzeWlYDBiLfFsfYiQdS904XJBCqxQ>
    <xmx:FMTiaZyuG_EcyQndvZCGty_O8vXYZ-XcQTTx4yCAmAZzoOqcR1Jjlw>
    <xmx:FMTiaXpq7BrpaPdwuCirfwU3aE7oOV1RpJeNeDj7jb4poUAuXNTC-07->
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 19:36:52 -0400 (EDT)
Date: Fri, 17 Apr 2026 16:36:51 -0700
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
Message-ID: <69e2c4134f1ef_147c801001a@djbw-dev.notmuch>
In-Reply-To: <20260327160132.2946114-4-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for new
 TDX Module objects
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
> The usage of tdx_page_array will be in following patches.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[..]
> +static struct tdx_page_array *
> +tdx_page_array_alloc(unsigned int nr_pages)
> +{
> +	struct tdx_page_array *array = NULL;
> +	struct page **pages = NULL;
> +	u64 *root = NULL;
> +	int ret;
> +
> +	if (!nr_pages)
> +		return NULL;
> +
> +	array = kzalloc_obj(*array);
> +	if (!array)
> +		goto out_free;
> +
> +	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!root)
> +		goto out_free;
> +
> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);

This should now be:

    kzalloc_objs(struct page *, nr_pages);

...oh nevermind you caught that in your incremental fixup. ...but a
couple more comments below:

[..]
> +
> +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> +
> +static u64 __maybe_unused hpa_list_info_assign_raw(struct tdx_page_array *array)

2 quick comments:

* I do not understand shipping a __maybe_unused helper in patch 3 that
  does not get used until patch10.

* The "assign_raw" verb feels strange. I think this probably just want
  to be called: to_hpa_list_info(struct tdx_page_array *)

> +{
> +	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> +	       FIELD_PREP(HPA_LIST_INFO_PFN,
> +			  PFN_DOWN(virt_to_phys(array->root))) |
> +	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, array->nents - 1);
> +}
> +
> +#define HPA_ARRAY_T_PFN		GENMASK_U64(51, 12)
> +#define HPA_ARRAY_T_SIZE	GENMASK_U64(63, 55)
> +
> +static u64 __maybe_unused hpa_array_t_assign_raw(struct tdx_page_array *array)

to_hpa_array_t()

> +{
> +	unsigned long pfn;
> +
> +	if (array->nents == 1)
> +		pfn = page_to_pfn(array->pages[array->offset]);
> +	else
> +		pfn = PFN_DOWN(virt_to_phys(array->root));
> +
> +	return FIELD_PREP(HPA_ARRAY_T_PFN, pfn) |
> +	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nents - 1);
> +}
> +
> +static u64 __maybe_unused hpa_array_t_release_raw(struct tdx_page_array *array)

It seems too subtle that this function sometimes returns zero and
sometimes returns a page that the TDX module will clobber with data that
we do not care about.

It is also not clear that "0" is what the module considers a valid value
that meets "checks its validity for forward compatibility". I guess we
get lucky because all of the calls that need this presently are
multi-page cases?

I would feel better if this always returned the root HPA and was called
something like:

    to_output_clobber(), or to_aux_clobber()

...to make it clear that whatever was there before gets destroyed.
