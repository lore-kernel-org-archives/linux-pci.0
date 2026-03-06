Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139237F006;
	Fri,  6 Mar 2026 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840094; cv=none; b=fCAFekKqMahFvRdsFm0GbwVyssxsAcD38pA8GmCUbaCLetA/zbjd3WESvZBjfwvZqom25GZOW31A0gbm/lC+px+B6DRUsN7jWlFP80nbvN5e9XJgGPyoDXAC7RS8au5Z+LPH9dmq/PjrQUmqeOUBvhIWmo36Aosw1tEQBn5wAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840094; c=relaxed/simple;
	bh=+pAVQxBx2voBVwpxwfnCj2nDT2URUt1ipnptJT61aOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3v2Ljfw12e9bUataVvkIZWmqn4LMSVGaOylslQ/eZPtCt+oCeaZnJwAdWJYo+3SiV+mjwXDmUuo8yJfNfvfAwsdqfKotyK0w7XNWuSsEy2twLXNoGU+Ds7RBpqEhmEAvEYeaAjVC8uG6PjlKbxGs8FMnY8qLF/FqcL7cwi8FuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=I59VUr+u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fk2l4y7D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="I59VUr+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fk2l4y7D"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 831331D001A6;
	Fri,  6 Mar 2026 18:34:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Mar 2026 18:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772840090;
	 x=1772926490; bh=LobVbqY+bF/VEgdCckULqivL+jsh+rdJItYRrQJzgt8=; b=
	I59VUr+ut/IaShkFBCTFKtDNG+kL+Cq3kphg3xTFxhKoezCe4KXOtfU8Tc62Dw3v
	eBt8pxunNgjWPWusXf/+1iQGSozGCAiwNSF9LTJXQTxkmavAVWyBXjxyMu9hyevE
	ghXoRNtYxHD/8xk9JCn0m4jvNakXhCUVINLn3MLP3+IqOEmKPj9Vdu9U5E/oN3Y3
	jzeamPNUpzNEB1HiWkLFGu5cc9b10N4MoHWYBKuy3qAkv/TROYM1lslLFoqUVIIy
	IWOfHN4ccn0WS1jq4sHud1oFbhACP10THDyAPKqZMFaSl9ElwuZqYiShuug1gMvs
	qD2W8Je2fNqfwMr6kjJXeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772840090; x=
	1772926490; bh=LobVbqY+bF/VEgdCckULqivL+jsh+rdJItYRrQJzgt8=; b=f
	k2l4y7DpCzvRiuSljvbiMChwAKDRtSxgSOU6T+NGu/j3lPNs1HmLyM0SCjx6La6R
	p0kYgoLc2ABukPO4YXr51lo4W6InlIYjdtrr5Dd4gAzdAHutHhwKFAZ6Qz4o8/Z8
	eF3deYU+BCJ+DD7oD8H418rJgAPWNJhvqfag9OELf9hPxLUTpopJmU/CvzilCeXX
	SCR/Jrz8UhAH8V8/QzafSuyS7AjLCWPYmFadXMA9uXFcg8MvMUKy1GB4R+qRthdK
	zbU+Pyet0zMcpS1suc8KxYrg6dQDXJFhe+t5tWr2y7LmIpcNp1iilsXwqtEaCol6
	Ky1MRZYPdWu77JMahjeJg==
X-ME-Sender: <xms:mWSradLIso_ixAjoovFz2QYQQ7Rq4-KYGZJ0waYUY6sdvyszWvvLkQ>
    <xme:mWSraaw07SKb1Rxh5z4il_qLsJ1eBo3RsVpIdetOY9lpC5fid8b6eIBsHu9YTNCsA
    E-zoOb6FIGaO-F1o0CZ8J6LDxCJINRdQW4UFCjXWNM0MmfQXaOZVA>
X-ME-Received: <xmr:mWSraZzaoxlAB35DTilj9fHZccLVmhNncMl9A3WOmXVfjKxKOk6tkPnfChg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhmrggu
    hhgrvhgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqtgiglhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdr
    ohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrg
    hnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehirhgrrdifvghi
    nhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrse
    hinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:mWSraU3jDbdt3spMSmjMnmfEo4jUuHeHhah3O5BuOwg4ruAo8r--nw>
    <xmx:mWSraTWSF4rw-Sl0yxx-c4EFWAfnhA0cIk0D49Dlau-ASgc6VlLinw>
    <xmx:mWSraQfSkbqpnK7yy66BHrXg0u-kQLUjI2uiYeHywUEwqj4Ai7_Yeg>
    <xmx:mWSrac_HaHt_C7u_sd_9xFGpmxTq0usMlp1TGQjQYTotvld6CEL-5A>
    <xmx:mmSraaApKBuUu4rLOfD_zi5qsZWzuKh6DO4KI3PRL0yCYKJHvPXY2IrY>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:34:47 -0500 (EST)
Date: Fri, 6 Mar 2026 16:34:32 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>
Cc: alex@shazbot.org, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] cxl: Add multi-function sibling coordination for
 CXL reset
Message-ID: <20260306163432.782063d4@shazbot.org>
In-Reply-To: <20260306092322.148765-5-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:23:19 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add sibling PCI function save/disable/restore coordination for CXL
> reset. Before reset, all CXL.cachemem sibling functions are locked,
> saved, and disabled; after reset they are restored. The Non-CXL Function
> Map DVSEC and per-function DVSEC capability register are consulted to
> skip non-CXL and CXL.io-only functions. A global mutex serializes
> concurrent resets to prevent deadlocks between sibling functions.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 137 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9e6f0c4b3cb6..b6f10a2cb404 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -15,6 +15,9 @@
>  #include "core.h"
>  #include "trace.h"
> 
> +/* Initial sibling array capacity: covers max non-ARI functions per slot */
> +#define CXL_RESET_SIBLINGS_INIT	8
> +
>  /**
>   * DOC: cxl core pci
>   *
> @@ -979,3 +982,137 @@ static int __maybe_unused cxl_reset_flush_cpu_caches(struct cxl_memdev *cxlmd)
>  	device_for_each_child(&endpoint->dev, NULL, cxl_decoder_flush_cache);
>  	return 0;
>  }
> +
> +/*
> + * Serialize all CXL reset operations globally.
> + */
> +static DEFINE_MUTEX(cxl_reset_mutex);
> +
> +struct cxl_reset_context {
> +	struct pci_dev *target;
> +	struct pci_dev **pci_functions;
> +	int pci_func_count;
> +	int pci_func_cap;
> +};
> +
> +/*
> + * Check if a sibling function is non-CXL using the Non-CXL Function Map
> + * DVSEC. Returns true if fn is listed as non-CXL, false otherwise (including
> + * on any read failure).
> + */
> +static bool cxl_is_non_cxl_function(struct pci_dev *pdev,
> +				     u16 func_map_dvsec, int fn)

I think we can do better, how about:

static bool is_cxl_sibling(struct pci_dev *pdev,
				struct pci_dev *sibling,
				unsigned long *non_cxl_func_map)
{
	if (pci_ari_enabled(pdev->bus))
		return !test_bit(sibling->devfn, non_cxl_func_map);
	

	return PCI_SLOT(pdev->devfn) == PCI_SLOT(sibling->devfn) ?
		!test_bit(PCI_FUNC(sibling->devfn) * 32 +
			PCI_SLOT(sibling->devfn), non_cxl_func_map) :
		false;
}

To get this we'd eliminate ari and func_map_dvsec from the walk data
and replace with with a bitmap of all 8 non-cxl functions pre-filled
before the walk.

> +{
> +	int reg, bit;
> +	u32 map;
> +
> +	if (pci_ari_enabled(pdev->bus)) {
> +		reg = fn / 32;
> +		bit = fn % 32;
> +	} else {
> +		reg = fn;
> +		bit = PCI_SLOT(pdev->devfn);
> +	}
> +
> +	if (pci_read_config_dword(pdev,
> +				   func_map_dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG + (reg * 4),
> +				   &map))
> +		return false;
> +
> +	return map & BIT(bit);
> +}
> +
> +struct cxl_reset_walk_ctx {
> +	struct cxl_reset_context *ctx;
> +	u16 func_map_dvsec;
> +	bool ari;
> +};
> +
> +static int cxl_reset_collect_sibling(struct pci_dev *func, void *data)
> +{
> +	struct cxl_reset_walk_ctx *wctx = data;
> +	struct cxl_reset_context *ctx = wctx->ctx;
> +	struct pci_dev *pdev = ctx->target;
> +	u16 dvsec, cap;
> +	int fn;
> +
> +	if (func == pdev)
> +		return 0;
> +
> +	if (!wctx->ari &&
> +	    PCI_SLOT(func->devfn) != PCI_SLOT(pdev->devfn))
> +		return 0;
> +
> +	fn = wctx->ari ? func->devfn : PCI_FUNC(func->devfn);
> +	if (wctx->func_map_dvsec &&
> +	    cxl_is_non_cxl_function(pdev, wctx->func_map_dvsec, fn))
> +		return 0;

The above, since the identity check, becomes:

	if (!is_cxl_sibling(pdev, func, non_cxl_func_map))
		return 0;

> +
> +	/* Only coordinate with siblings that have CXL.cachemem */

Is this meant to read as "cache/mem" since we test for either below?

> +	dvsec = pci_find_dvsec_capability(func, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +	if (pci_read_config_word(func, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return 0;
> +	if (!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
> +		     PCI_DVSEC_CXL_MEM_CAPABLE)))
> +		return 0;
> +
> +	/* Grow sibling array; double capacity for ARI devices when running out of space */
> +	if (ctx->pci_func_count >= ctx->pci_func_cap) {
> +		struct pci_dev **new;
> +		int new_cap = ctx->pci_func_cap ? ctx->pci_func_cap * 2
> +						: CXL_RESET_SIBLINGS_INIT;
> +
> +		new = krealloc(ctx->pci_functions,
> +			       new_cap * sizeof(*new), GFP_KERNEL);
> +		if (!new)
> +			return 1;
> +		ctx->pci_functions = new;
> +		ctx->pci_func_cap = new_cap;
> +	}
> +
> +	pci_dev_get(func);
> +	ctx->pci_functions[ctx->pci_func_count++] = func;
> +	return 0;
> +}
> +
> +static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
> +	struct cxl_reset_walk_ctx wctx;
> +	int i;
> +
> +	ctx->pci_func_count = 0;
> +	ctx->pci_functions = NULL;
> +	ctx->pci_func_cap = 0;
> +
> +	wctx.ctx = ctx;
> +	wctx.ari = pci_ari_enabled(pdev->bus);
> +	wctx.func_map_dvsec = pci_find_dvsec_capability(pdev,
> +			PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_FUNCTION_MAP);
> +
> +	/* Collect CXL.cachemem siblings under pci_bus_sem */
> +	pci_walk_bus(pdev->bus, cxl_reset_collect_sibling, &wctx);
> +
> +	/* Lock and save/disable siblings outside pci_bus_sem */
> +	for (i = 0; i < ctx->pci_func_count; i++) {
> +		pci_dev_lock(ctx->pci_functions[i]);
> +		pci_dev_save_and_disable(ctx->pci_functions[i]);
> +	}

We also need to trigger the pci_dev_reset_iommu_{prepare,done}() hook
around reset.

Also, I think this whole path needs to be able to return error.  We've
got the krealloc in the walk function that can fail and is just
silently ignored and also the pci_dev_lock() here, where we've
eliminated the PCI bus semaphore issue, but it's still prone to dead-
lock.  We should use trylock and support unwind when it fails.  Return
an errno to the sysfs interface.

An example deadlock that could occur is a CXL reset initiated on fn1,
where we then try to lock fn0, fn2, etc (fn1 already locked) while
another interface walks fn0, fn1, etc.  Thanks,

Alex

> +}
> +
> +static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < ctx->pci_func_count; i++) {
> +		pci_dev_restore(ctx->pci_functions[i]);
> +		pci_dev_unlock(ctx->pci_functions[i]);
> +		pci_dev_put(ctx->pci_functions[i]);
> +	}
> +	kfree(ctx->pci_functions);
> +	ctx->pci_functions = NULL;
> +	ctx->pci_func_count = 0;
> +}
> --
> 2.43.0
> 

