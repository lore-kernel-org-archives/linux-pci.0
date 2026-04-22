Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3492741B6;
	Wed, 22 Apr 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820804; cv=none; b=LtD6Kkmsu2K/5a4ne2h5b+WZjmtaqoza0crYtLYXrHDouNc6NMy3GbpViO/ffY2EjxXYfQ2YVNMBw6SDO7+xP9tqhd3dy5f9f6JEgpNBbTqMEE9/7mLV17l5GVyw8XxCgKJin3usliVa2aKek4BmDE1wpaMymTxLwfvqUf9fCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820804; c=relaxed/simple;
	bh=llIREafGgMxsq5xUB0lVp7qtxCatkjGeEzb+hb7zg30=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p42Suo3TqAD9Kx9KqHpiOOIsxjNJoUKaThijTUmFHqs1oCjbmFmJQCsJPgjlbL8gqResJ7WEmT6XLYHX/2CHVrtEcnoQV+18FUqcV5aQF5TTx+5g6pLE5L8F1BOZMWMmWZ1IppJd7PIjGal6KoVkbGKvOVhSmXfbPp0QVHhm050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3eTMKT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3eTMKT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0986C2BCB0;
	Wed, 22 Apr 2026 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776820803;
	bh=llIREafGgMxsq5xUB0lVp7qtxCatkjGeEzb+hb7zg30=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Z3eTMKT6R3rPbIJjfqGcNEPi+yjWC/rFKOBXFRSLPNo2i48y+pStbaTr7JRZF7hCN
	 zUJHdsMYhsAHapp7YNv9CaTzaWOuONBdVzjR7VsPvR6k6LTvGcj3eheQ3r+ySRT2Sh
	 CON9t9vsNRUNXLCI/hhKlgb6GYzyDOkkLJBNNTi7rmERH/+6dw6s8RbBHSoynS5JMw
	 pWTbf07GB2H/5v/vy/aDnBIDhwnNI+lLqb7/eM2/PjPX6qCK5/q771VqLakYU9HRtX
	 q7ltwbbebKupeNlriKgGWRw0pOy/3pFt4WlAHyWf37fXnqkUtcQk9bkQb8DWXv8tO+
	 5U9njNeqzw1ow==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 64CADF40068;
	Tue, 21 Apr 2026 21:20:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Apr 2026 21:20:01 -0400
X-ME-Sender: <xms:QSLoafWhfFf6HUGWLgZwUHBWbr4O3TtDmCBqKBYewslpIuRoAeRXhA>
    <xme:QSLoaW1LJSJh_PtTMvk1VNcG-8rUuTw7efwllH3iSzTFEvu-IBM1m4h8z-SLtO2bE
    W3eLu6ylXW9ruuuaZHTx3QdMjY3u5rY7huvYJanuyVsKYdyR2MBbNzH>
X-ME-Received: <xmr:QSLoaeP_fzTBGUJpQ3PLheJNKM10CY_Snv0jD-ZtZ96DmoS2SyjMbDHkuyL3MUKigGiHVh2uL_4lrm3aXPothoBgvnEFxke5OKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdelfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:QSLoaR29e5axqHm4xRt3AFZus6J0PaaCGVrmZfgInUChbrQTR8MOGA>
    <xmx:QSLoad3bn-78tlypo9QOOdDgcH_9FrbYFlyJYbjLnZ_08J_O3HMKgQ>
    <xmx:QSLoaf95WGtWNNIIHhk4kG8bMj-uKn7V6wn3MMdkY-KqRZwl_KhlgQ>
    <xmx:QSLoaZbybtSU1x7MtDsuSJEXB5zkICLcGvWO5iUgQAUvYJxWPyvaAQ>
    <xmx:QSLoaez36ipbZjUmoOkFSGGGzuMmxGJOi_a_f8ThNE9_muE8sQMVmsqo>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 21:20:00 -0400 (EDT)
Date: Tue, 21 Apr 2026 18:19:59 -0700
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
Message-ID: <69e8223f4c8e6_fe08310058@djbw-dev.notmuch>
In-Reply-To: <20260327160132.2946114-9-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
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
> TDX Module supports optional TDX features (e.g. TDX Connect & TDX Module
> Extensions) that won't be enabled by default.

So this is another place where "optional" is misleading. For simplicity
there is no mechanism to fallback from TDX Connect operation if present,
at least in the core. The only optional aspects would be the mechanism
that could be unloaded through the tdx_host driver.

.../me notices that other comments on this patch say the same, but do
read on, another important detail about ktime_get_real_seconds() below.

> It extends TDH.SYS.CONFIG for host to choose to enable them on bootup.
> 
> Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
> features to enable. The bitmap uses the same definitions as
> TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
> configuration, e.g. TDX Module Extensions is a service that supports TDX
> Connect, it is implicitly enabled when TDX Connect is enabled. Setting
> TDX_FEATURES0_EXT in the bitmap has no effect.
> 
> TDX Module advances the version of TDH.SYS.CONFIG for the change, so
> use the latest version (v1) for optional feature enabling. But
> supporting existing Modules which only support v0 is still necessary
> until they are deprecated, enumerate via TDX_FEATURES0 to decide which
> version to use.

I would say this differently, it will always be the case that new
kernels are needed to enable new features, but it is unlikely that
TDH.SYS.CONFIG ever needs to change again. The v0 -> v1 transition means
that feature bits are to be used here on out. So there is little value
in worrying about deprecating v0 to save a couple lines of code in 5-7
years when these original TDX platforms sunset.

> TDX Module updates global metadata when optional features are enabled.
> Host should update the cached tdx_sysinfo to reflect these changes.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
>  arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index e5a9331df451..870bb75da3ba 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -58,7 +58,8 @@
>  #define TDH_PHYMEM_CACHE_WB		40
>  #define TDH_PHYMEM_PAGE_WBINVD		41
>  #define TDH_VP_WR			43
> -#define TDH_SYS_CONFIG			45
> +#define TDH_SYS_CONFIG_V0		45
> +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
>  
>  /* TDX page types */
>  #define	PT_NDA		0x0
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 130214933c2f..0c5d6bdd810f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1353,6 +1353,7 @@ static int construct_tdmrs(struct list_head *tmb_list,
>  static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
>  {
>  	struct tdx_module_args args = {};
> +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
>  	u64 *tdmr_pa_array;
>  	size_t array_sz;
>  	int i, ret;
> @@ -1377,7 +1378,15 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
>  	args.rcx = __pa(tdmr_pa_array);
>  	args.rdx = tdmr_list->nr_consumed_tdmrs;
>  	args.r8 = global_keyid;
> -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
> +
> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_TDXCONNECT) {
> +		args.r9 |= TDX_FEATURES0_TDXCONNECT;
> +		args.r11 = ktime_get_real_seconds();

Mainline has reason to not entertain this module requirement. The fact
that passing zero is an error is useful to detect unsupported modules.
An updated module would accept zero as indicating "VMM requests module
disable all policy and mechanisms related to untrusted wall clock time".
Specifically, there are several problems with this:

1/ No other TSM implementation requires the VMM to pass in an untrusted time
2/ The wall time may change and may require hooks to keep the module time
   up to date, but see point 1/, this would be a TDX special flower hook.
3/ Presumably this allows the module or the guest to do certificate expiration
   checks, but that is the responsibility of the relying party. The
   relying party may have reason to accept an "expired" cert as determined
   by VMM wall clock, and the guest presumably already has mechanisms to
   determine untrusted wall clock time from the VMM if it wants. Guests
   do not need TDX ABI for that.

So I think Linux wants to pass 0 here and wait for modules that accept
that as the start of TDX Connect support. As you said, given there are
no released modules with TDX Connect there is time to make that first
release drop this requirement.
