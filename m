Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F762517AF;
	Sun, 12 Apr 2026 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962394; cv=none; b=edPlFmbiTUkl13k4K4ntO8RZ0+WdOJWAFvIf9l/eRvkmOv2nYdcntBe7BxEoUMYnLbsY6l5lEi5yu97QKSTFGNWQGFKHylYW3RbGdZkPKfbNQAxAj4QukQKhbcBTZVCAffIEPJ63LYqSfiABHspV3zJ+WKf1oZaUj7hgUspuIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962394; c=relaxed/simple;
	bh=WfZlJUGaAmXReI7P2TaFOL144/OK4O4FjezT9pjQ/fE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rwLq+athefOq/pZmTCMI9RhSdZTKFos0+TQcVx5ZHaHFXo0Dl77t4U/iuzvQydOx7eXqqmRsfVvGxv/pDqSJJw2SYGMep/V2Zx81u5i6mhdt7TUOiZ361bKC4SIsKhrPTyuN+xM2jSWWe7edMHyyIvS7iFxZRCYAgxEzLTIj2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCmNLXvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCmNLXvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2C0C2BCB0;
	Sun, 12 Apr 2026 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775962393;
	bh=WfZlJUGaAmXReI7P2TaFOL144/OK4O4FjezT9pjQ/fE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZCmNLXvw8jjWnFWj9GDf2KibUHEfaj+BLtPqiXhi4oQ8PSu1R1wn+xCS0813rj6Za
	 lYEKtL64s2IxL84+NHiDpPBi7ZqDJqX5rzCY/28zNRiu3UpzmBTV0GtQeR05A3g7k0
	 IpjXQBVO8ABmLwC1HR4dSSxvmGeYhtUMSSzEnFz63nhMu9NfzWv0vLteU/St52Jutb
	 MEzgRGHis7WOInEptYwilWuGaaPNrkqNAB2Vj2hAtSuiN0TfqTV/8HJvK4icIdsFVN
	 Snqb+5ZY8Ot2ocV/5oWzfzHRSzxSFmPyfXE2XHi1uTGyxAVOFALa9n1iBkkJzIVyNI
	 /Cub8gMU6L0sA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C0B6F40096;
	Sat, 11 Apr 2026 22:53:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sat, 11 Apr 2026 22:53:12 -0400
X-ME-Sender: <xms:GAnbabI-Ww3PpebiWP9h2kOehq9ljFScZLmHrfsEjjBtPhY-oJY5IA>
    <xme:GAnbaTFd_G3AL80r7opbq7Vi3wyGAsmGvNdgq0rP4QauNJyACl-vh4qDK_5eqmlAe
    l9xNLfEl2bPKN7f6yfTzijTnYz3KGLCs8of-42Ufs_FdkZqtQuY1CU>
X-ME-Received: <xmr:GAnbaYRqUPvT_lHF9i3DhZ839LBkEmLAn7koqWMWsO-Fuu15EVD7wUg-TRRfewatfUFp6mPdgdG4hUzZNKg35N5pfxSp5eY09HM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefgedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihi
    lhhunhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    phgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgt
    phhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegsrg
    holhhurdhluheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeihihhluhhn
    rdiguhesihhnthgvlhdrtghomhdprhgtphhtthhopeiihhgvnhiihhhonhhgrdguuhgrnh
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:GAnbacX7RQDdxNNKddD7SUgiN8Xved0R4Nnf0T9lZZWTpc6m_8akuw>
    <xmx:GAnbaXiOfgIXeHr7uRWfTo7yZN8BZWpII60lPRAbeSoEHus9zcA6lw>
    <xmx:GAnbaVfLcdxdg1UptpyYd52vhxJGcxL8Rzy6C1jYaCYAye_Fx7y1hg>
    <xmx:GAnbaSf2DSQ9PlrbhIBgw78ykzVvsFD164drIjpdFPIZZMnu_5K5hw>
    <xmx:GAnbaRXNa73aNWIMQcN4qv3wB3qi_otlzPywXq6xBPQ2mbVwmm1aC8y0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 22:53:11 -0400 (EDT)
Date: Sat, 11 Apr 2026 19:53:10 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
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
Message-ID: <69db0916ba63c_fe08310034@djbw-dev.notmuch>
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
> Add struct tdx_page_array definition for new TDX Module object
> types - HPA_ARRAY_T and HPA_LIST_INFO. They are used as input/output
> parameters in newly defined SEAMCALLs. Also define some helpers to
> allocate, setup and free tdx_page_array.
> 
> HPA_ARRAY_T and HPA_LIST_INFO are similar in most aspects. They both
> represent a list of pages for TDX Module accessing. There are several
> use cases for these 2 structures:
> 
>  - As SEAMCALL inputs. They are claimed by TDX Module as control pages.
>    Control pages are private pages for TDX Module to hold its internal
>    control structures or private data. TDR, TDCS, TDVPR... are existing
>    control pages, just not added via tdx_page_array.
>  - As SEAMCALL outputs. They were TDX Module control pages and now are
>    released.
>  - As SEAMCALL inputs. They are just temporary buffers for exchanging
>    data blobs in one SEAMCALL. TDX Module will not hold them for long
>    time.
> 
> The 2 structures both need a 'root page' which contains a list of HPAs.
> They collapse the HPA of the root page and the number of valid HPAs
> into a 64 bit raw value for SEAMCALL parameters. The root page is
> always a medium for passing data pages, TDX Module never keeps the
> root page.
> 
> A main difference is HPA_ARRAY_T requires singleton mode when
> containing just 1 functional page (page0). In this mode the root page is
> not needed and the HPA field of the raw value directly points to the
> page0. But in this patch, root page is always allocated for user
> friendly kAPIs.

I think this undersells the fact that "singleton mode" is a premature
optimization that requires complication to take advantage of the benefit
(sometimes save a single page allocation). The Linux implementation
forfeits that small benefit for the larger gain of cleaner kAPIs.

> Another small difference is HPA_LIST_INFO contains a 'first entry' field
> which could be filled by TDX Module. This simplifies host by providing
> the same structure when re-invoke the interrupted SEAMCALL. No need for
> host to touch this field.
> 
> Typical usages of the tdx_page_array:
> 
> 1. Add control pages:
>  - struct tdx_page_array *array = tdx_page_array_create(nr_pages);
>  - seamcall(TDH_XXX_CREATE, array, ...);
> 
> 2. Release control pages:
>  - seamcall(TDX_XXX_DELETE, array, &nr_released, &released_hpa);

It is simply a bug if TDH_XXX_DELETE does not return every resource
passed to TDH_XXX_CREATE. The only "leak" case to worry about is that
TDH_XXX_DELETE fails. In that case it should be "fatal" (TDX_BUG_ON,
system can keep hobbling along, but panic_on_warn() would not be
unreasonable). If TDH_XXX_DELETE fails it indicates some catastrophic
misunderstanding between Linux and the TDX Module.

So the seamcall in this case has no need for @nr_released or
@released_hpa, those should already be known to the kernel.

What is missing is an architectural guarantee that TDH_XXX_DELETE
success == "all resources you arranged at TDH_XXX_CREATE time are free".
I would hope that is already the case and AUX_PAGE_PA is only an
unfortunate distraction. If it can ever be the case that CREATE and
DELETE are asymmetric on success then that needs to be corrected and
Linux will wait for a future module that can make that guarantee.

I think that cleans up a bulk of the logic here to abandon caring that
the module tries to remind us what we are releasing.
