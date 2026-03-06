Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28ED381AF8;
	Fri,  6 Mar 2026 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840104; cv=none; b=Yymeqt0xRWp1qlLFX5i2qkW0x34EEB1BJTdhOuE2uVp0RwUS0l7ZviTaw+7cNon+CnwT92NwUpv8OaEi/uiXHOz2RA8tf5uEs95LqKox4KvntxwcTi3cw9Wywc+tyfglbFDdFtXA7ulR1mQIwU2oW9Pc4IHa2YYKjzHMIcfElBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840104; c=relaxed/simple;
	bh=a2gyamgSQzN7xClCsUh7FwXa1GZjaS1bSQtPrA1GGjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhTqgafsZOYU2b2Zq724maHl1WIkKOzM7cxI4MQ491SVtElCO6JVvvzzjHC1Z7ZRbaqsN8S16y9pH8pMmbi+pIn4Qb9KdzmqptCPFRyjJWPAA7TFuTVQkt9GsWVpCyW95RSgMeGzEC2W6jiWyDfrtF5Dkuizyq42FRv6IKbq1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=k8NpRmfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2Dk77bD+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="k8NpRmfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Dk77bD+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A35847A0154;
	Fri,  6 Mar 2026 18:34:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 18:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772840098;
	 x=1772926498; bh=NoOIPo1RNXJINq/gEYuH8ajVx8kwYrDS76JXk6QT5W8=; b=
	k8NpRmfVdmRcRZYsHlCs13HhKlQGP7y2VfOt/itkpG6zi/sV9Rmx81UlR56ijIiC
	mp82lxmdu8ULsWVzfjvxZz5YJwz4MNak+o9qKergfLGZ3/i/SxMzMwwAE/fFuwYY
	HlEZItzHcerNCwbhdPd2viiP4EA0dKwouKJE8edGjMjy03APZrM8mzBf6ufk8fc0
	glyPDlT8ylMYV94S//aiDCNEz2HJDkO6TcmV3lRMzmVrV8ZwjrcWnztazvgVgBGz
	K+qZ60Yt77bgtE9ilnRBbg6iY6JzN+bdNw0PG6Xyw8TWhZaSil2vr2Ipl+MD3sFV
	+e4yqEfK2kCO2LjMNmpeLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772840098; x=
	1772926498; bh=NoOIPo1RNXJINq/gEYuH8ajVx8kwYrDS76JXk6QT5W8=; b=2
	Dk77bD+zmw1bVfZiXPLtcNS/DVzC7PGQBaiT2UI99DP5sEQJhO9KmDnOBYw8u183
	pVrXJr61A8Acox/fi8wSvQISvm/Y1ih2OOI4FUeLmDZPJh/FZvfVA8HeCDgHlXdG
	gqzydDiYA6S7ciwVeJGtQoGGtuKlE/yplBLcNrpW8weQU1miTh/vI7CTfHtBC0Nl
	Lfk7fI4/S0RC1xaE4kip1GQ30Xnthol+qrB5lHIFMI/bPd9Wlt1t64FV0+b4Dg0T
	gKhQ0E9B5XpmmEYpUKWouWG9YXVJzJMJ3dCCHqWjlrg+hWJLMht452kwzwMmVjts
	nMQF7RT9utt/Gnus7QaEg==
X-ME-Sender: <xms:omSraT1qs6BLF-ad3gEczguE7KvFl67rfQvlHK_dzFhxIA9LXkqAfg>
    <xme:omSraTsR3ImFJdw099rB8LNxjSPonWsRGV0L0Jyc3sg7Pkz1fQ3slcqEaFsJ7Q1rB
    zNuRZc0lozC4SsaRiJZaZ3NkTTNEndgiWGs7yXNECo4OV1f_slktQ>
X-ME-Received: <xmr:omSraX89VN3Zm5KUV5VAi1HFLsGvJQe19qIu1HhxvkC7BGA4Du8og543jOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgig
    sehshhgriigsohhtrdhorhhgpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtth
    hopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrght
    hhgrnhdrtggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtohepihhrrgdrfi
    gvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhm
    rgesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlug
    esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:omSrafTvQ4WuJ6OvFmXu9nlr1MnpknoPNz1r6CuqoKM5TRN-KXm2gg>
    <xmx:omSraVD_bGLWsSTRkzSKHz4pKD661UrfX-M2-1xLl_I7pdKbnPtRMw>
    <xmx:omSraYaI25VDoPNrbbtGueSNWl7zbVQhdm0vwIs3o9fRP5_Wezbcow>
    <xmx:omSraeKV1XLuSJ0sZUbWy_OO3uFP6RU6l2KIlnXSl7VOcjJEoOsYtg>
    <xmx:omSrafOSjiqcLJTb95EjaIdfLjEKovQKB9cJMb4Hw-O5hv3Sg-Rp68_V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:34:56 -0500 (EST)
Date: Fri, 6 Mar 2026 16:34:05 -0700
From: Alex Williamson <alex@shazbot.org>
To: <smadhavan@nvidia.com>
Cc: alex@shazbot.org, <bhelgaas@google.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] cxl: Add memory offlining and cache flush
 helpers
Message-ID: <20260306163405.6a613a52@shazbot.org>
In-Reply-To: <20260306092322.148765-4-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
	<20260306092322.148765-4-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:23:18 +0000
<smadhavan@nvidia.com> wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add infrastructure for quiescing the CXL data path before reset:
> 
> - Memory offlining: check if CXL-backed memory is online and offline
>   it via offline_and_remove_memory() before reset, per CXL
>   spec requirement to quiesce all CXL.mem transactions before issuing
>   CXL Reset.
> - CPU cache flush: invalidate cache lines before reset
>   as a safety measure after memory offline.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c | 110 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f96ce884a213..9e6f0c4b3cb6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,6 +4,8 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/memory_hotplug.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> @@ -869,3 +871,111 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
> 
>  	return ctx.count;
>  }
> +
> +/*
> + * CXL Reset support - core-provided reset logic for CXL devices.
> + *
> + * These functions implement the CXL reset sequence.
> + */
> +
> +/*
> + * If CXL memory backed by this decoder is online as System RAM, offline
> + * and remove it per CXL spec requirements before issuing CXL Reset.
> + * Returns 0 if memory was not online or was successfully offlined.
> + */
> +static int __maybe_unused cxl_offline_memory(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	struct cxl_region_params *p;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +	if (!cxlr)
> +		return 0;
> +
> +	p = &cxlr->params;
> +	if (!p->res)
> +		return 0;
> +
> +	if (walk_iomem_res_desc(IORES_DESC_NONE,
> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				p->res->start, p->res->end, NULL, NULL) <= 0)
> +		return 0;
> +
> +	dev_info(dev, "Offlining CXL memory [%pr] for reset\n", p->res);
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	rc = offline_and_remove_memory(p->res->start, resource_size(p->res));
> +	if (rc) {
> +		dev_err(dev,
> +			"Failed to offline CXL memory [%pr]: %d\n",
> +			p->res, rc);
> +		return rc;
> +	}
> +#else
> +	dev_err(dev, "Memory hotremove not supported, cannot offline CXL memory\n");
> +	rc = -EOPNOTSUPP;
> +	return rc;
> +#endif

This would be cleaner if we stubbed offline_and_remove_memory() with
-EOPNOTSUPP.  Thanks,

Alex



> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cxl_reset_prepare_memdev(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	struct device *dev;
> +
> +	if (!cxlmd || !cxlmd->cxlds)
> +		return -ENODEV;
> +
> +	dev = cxlmd->cxlds->dev;
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		return 0;
> +
> +	return device_for_each_child(&endpoint->dev, NULL,
> +				      cxl_offline_memory);
> +}
> +
> +static int __maybe_unused cxl_decoder_flush_cache(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	res = cxlr->params.res;
> +	cpu_cache_invalidate_memregion(res->start, resource_size(res));
> +	return 0;
> +}
> +
> +static int __maybe_unused cxl_reset_flush_cpu_caches(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd)
> +		return 0;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint || IS_ERR(endpoint))
> +		return 0;
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return 0;
> +
> +	device_for_each_child(&endpoint->dev, NULL, cxl_decoder_flush_cache);
> +	return 0;
> +}
> --
> 2.43.0
> 
> 

