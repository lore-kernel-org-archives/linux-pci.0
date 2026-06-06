Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F962199385;
	Sat,  6 Jun 2026 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705381; cv=none; b=ln1xPtMINP7wmfmCUWI6mpzxdktRDCHHWEzQOqle6vsp6SmcrZguZQIzxx9AObEXAIiDa63mk9zoUP2yetwfuY1/jvKJaG5uMOzjLapuEBPKKpjG3Zg9JTFoiSTaqmSfhD3+c9yw4sLY8V2XPliwtYHXoj2YEFc16l6ni5NIkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705381; c=relaxed/simple;
	bh=UJoEbhqXsQ04lBoC+yJODTBQX1DKC92XIdNSL8fQTjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glsUYXEcjsgVSou1H24Al5LHySSCbPDKKBZxSwbHdUauKovt5N+UI5Z7P3HVZyRfiHUMzbW+OIwqSJzGzQkH5GRfC8vTh6TKPq9UDLTi7ftvg0vczIEODkugx7EAZ0xVcmc/DbiIYvmS4mq13gaO4kQxDNAFuYKgMNkVSMLX8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3MLPdJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3MLPdJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35DB1F00893;
	Sat,  6 Jun 2026 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705379;
	bh=qeByog+RWT14GnISKe1EeP55EiD71JAqKpnvlRh6dZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3MLPdJjUipnMibueXd5Rly1ogcf3rSWDQP71uxrs8+Tv8LsHeev0IYJjkmJ5Aqb8
	 GB52Tq+B9+9hlVqwtzA7RWaGKoX3YR9fgU3RS2+qz+55TuANtA9TS9OrLqbjQP0eHK
	 xhxxbbx+Jslloi28e8BIrT0154uMtaqvB7eg9NFWApvw6k1pUQenudt8OxJhsldR0N
	 /9OMC5FH2n7yelnrXhW1LReSLbKs3Ysy4nG/XNDgoWJM+1a1X+Ho8jA68rC7QA6qDj
	 jBO2VGczrRVpbz9CGh0h++UJnotR2XE5Xvc4FsM72p6eBjgM5E2We/sw67923D4763
	 1aFo9ooU1eCUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-11-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-11-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:22:59 +0000
Message-Id: <20260606002259.A35DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Inverted teardown sequence in `sdxi_unregister()` causes DMA U=
se-After-Free and host Use-After-Free by freeing contexts while active.
- [High] Context DMA memory is freed without hardware synchronization, lead=
ing to use-after-free by the device.
--

commit f66266c7bb64ddb6a5bf8b858f8554af8ba46c5a
Author: Nathan Lynch <nathan.lynch@amd.com>
Subject: dmaengine: sdxi: Add client context alloc and release APIs

This commit exposes sdxi_cxt_new() and sdxi_cxt_exit() to create and release
SDXI contexts, tracking them in an xarray. It also introduces logic to
invalidate a context's L1 entry upon deallocation.

> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index cc99fe9ecf928..2f9a29df5d9ce 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c

[ ... ]

> +/* Invalidate a context. */
> +static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
> +{
> +	u8 l1_idx =3D ID_TO_L1_INDEX(cxt->id);
> +	struct sdxi_cxt_L1_ent *ent =3D &cxt->sdxi->L1_table->entry[l1_idx];
> +
> +	invalidate_L1_entry(ent);
> +	invalidate_cxtl_ctl(cxt->cxt_ctl);
> +	/* todo: need to send DSC_CXT_UPD to admin */
> +}

[ ... ]

> +void sdxi_cxt_exit(struct sdxi_cxt *cxt)
> +{
> +	if (WARN_ON(sdxi_cxt_is_admin(cxt)))
> +		return;
> +
> +	sdxi_rescind_cxt(cxt);
> +	sdxi_free_cxt(cxt);
> +}

[Severity: High]
Does this code free context DMA memory without synchronizing with the hardw=
are?

By clearing the valid bits but leaving the DSC_CXT_UPD synchronization for a
later TODO in sdxi_rescind_cxt(), the device is not notified and its intern=
al
caches may still reference these context structures.

When sdxi_cxt_exit() immediately calls sdxi_free_cxt() afterwards, could the
hardware perform DMA accesses on memory that has been returned to the
allocators, leading to a device use-after-free?

[ ... ]

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index b875d8cdb58af..d3d1ad2f2effe 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c

[ ... ]

> @@ -346,6 +348,12 @@ EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
>  void sdxi_unregister(struct device *dev)
>  {
>  	struct sdxi_dev *sdxi =3D dev_get_drvdata(dev);
> +	struct sdxi_cxt *cxt;
> +	unsigned long index;
> +
> +	xa_for_each(&sdxi->client_cxts, index, cxt)
> +		sdxi_cxt_exit(cxt);
> +	xa_destroy(&sdxi->client_cxts);
> =20
>  	sdxi_dev_stop(sdxi);
>  }

[Severity: Critical]
Does this teardown sequence result in DMA memory corruption and a host
double-free?

By forcefully freeing all client context DMA memory via sdxi_cxt_exit()
before calling sdxi_dev_stop(), the device hardware is still active and the
contexts themselves have never been stopped via sdxi_stop_cxt().

Furthermore, since these contexts are allocated per channel, won't the DMA
engine framework later invoke sdxi_dma_free_chan_resources() on channel
release or devres teardown, which will attempt to stop and free the already
freed sdchan->cxt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D11
