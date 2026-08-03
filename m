Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BE430CE3;
	Mon,  3 Aug 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781524; cv=none; b=dUZp3k9tChBM8huY3paeWfsvt4j5v+q1J4NLIXco8R4UufXacnKm6Bz7nciIJQomlO+9pj3k4Yc8xkY2pmc5PZxae7uyMzLykUe6Hb9BF1g+rZP0xVpIe/ZfGTrUhX5WoW1Wx+ZhHvW8/Usuv1BRRkzoZ+3ZyLfGFEx85pQig0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781524; c=relaxed/simple;
	bh=CTPeWJIs+cwCA5PGL5y/G9cywKrWF8r2JZ573HzruJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IAjVwZShgpyrM4l46ml35CSKayL5ZP+XHPxGDiurX5De183EV5nFUYgwCzk968URATySapCrzdJ8bz66hJTttZUO5BIWHPPcC9t8O9bSVERDt3hx8BhVZ8H2rLLSa5UewtA4gmdzd2s11L64D4IiiRczdngFUnXWxYJvfXPch1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQsHYgm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQsHYgm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE151F00A3A;
	Mon,  3 Aug 2026 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781522;
	bh=q8GbdgfeM5xRVAnGGnGwVbydx4ol0JlXToGOau78a6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQsHYgm9hNTOJkHM01cnLlaEKX1md4ymAmBhdZvX/oDlaW40fjeSZgo1H5w4YO3fF
	 mn/ED41qPkHMehbwgGp+00YEBsU7t6SPR6kHoVhhXCa0cd9PRgcyr1g5kBHsACvjX7
	 BYkaG3iatxuuUOyonYO5Q5NoYaFgXLc0APOELEiyhVKCkRWpIN/3FJkaKh1gBaCUDM
	 DWqGTYDAXbDmGhnJFqwgPWwUlKE0YZhSDENRXXIoAa87kr725Q+/xBerNIj1tpoELK
	 xaBTieS93jLAdcqS+8PndQ3OPQiMck4pC8kQQv1l9vZygp7sPkn232pnJ0KqqS0lXJ
	 7G3T3S5IUK8Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] NTB: perf: Reject grouped memory windows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260803180439.1963864-9-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:25:21 +0000
Message-Id: <20260803182521.EDE151F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mismatch in memory window indices (`perf->gidx` vs `peer->gidx`) b=
reaks test communication on multi-port configurations.
- [High] Multiple test threads executing concurrently map memory and overwr=
ite a shared `peer->dma_dst_addr`, leading to DMA mapping leaks, IOMMU faul=
ts, and double-unmapping.
--

--- Patch [8]: [PATCH 08/11] NTB: perf: Reject grouped memory windows ---
commit 8a37bed871c2fb90c1fc72578c46b05070e8ad53
Author: Koichiro Den <den@valinux.co.jp>

NTB: perf: Reject grouped memory windows

NTB perf configures one MW per peer through the per-MW translation API.
It cannot configure one member of a larger translation group.
Reject such layouts at probe.

> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..50bfbec1e251e 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
[ ... ]
> @@ -1469,7 +1469,19 @@ static int perf_init_peers(struct perf_ctx *perf)
>  	}
> =20
>  	for (pidx =3D 0; pidx < perf->pcnt; pidx++) {
> -		ret =3D perf_setup_peer_mw(&perf->peers[pidx]);
> +		peer =3D &perf->peers[pidx];
> +		ret =3D ntb_mw_get_trans_group(perf->ntb, peer->pidx,
> +					     peer->gidx, &first, &count);
> +		if (ret)
> +			return ret;
> +		if (first !=3D peer->gidx || count !=3D 1) {
> +			dev_err(&perf->ntb->dev,
> +				"Peer %d MW %d is not a standalone window\n",
> +				peer->pidx, peer->gidx);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		ret =3D perf_setup_peer_mw(peer);

[Severity: High]
This is a pre-existing issue, but does perf_setup_peer_mw() incorrectly mix
index variables on multi-port configurations?

Looking at perf_setup_peer_mw(), it maps the physical address of the
outbound window using the local port's index (perf->gidx):

	ret =3D ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
				   &peer->outbuf_size);

However, perf_setup_outbuf() later configures the outbound translation using
the peer's index (peer->gidx):

	ret =3D ntb_peer_mw_set_trans(perf->ntb, peer->pidx, peer->gidx,
				    peer->outbuf_xlat, peer->outbuf_size);

When perf->gidx and peer->gidx differ, this mismatch causes writes to the
mapped memory to go to an unconfigured window.

The same index mismatch occurs for inbound windows between ntb_mw_get_align=
()
and ntb_mw_set_trans().

Could we use a consistent index?

[Severity: High]
This is a pre-existing issue, but can multiple concurrent test threads
overwrite peer->dma_dst_addr and leak DMA allocations?

When a user configures multiple test threads, they all execute
perf_init_test() concurrently without serialization.

Because they share the same perf->test_peer structure, they each call
dma_map_resource() and overwrite peer->dma_dst_addr:

drivers/ntb/test/ntb_perf.c:perf_init_test() {
    ...
	peer->dma_dst_addr =3D
		dma_map_resource(pthr->dma_chan->device->dev,
				 peer->out_phys_addr, peer->outbuf_size,
				 DMA_FROM_DEVICE, 0);
    ...
}

Later, threads may read an IOVA mapped for a completely different DMA device
in perf_copy_chunk():

	dst_dma_addr =3D peer->dma_dst_addr + (dst_vaddr - vbase);

During teardown, all threads call dma_unmap_resource() on the exact same
pointer in perf_clear_test(), causing a double-unmap:

	dma_unmap_resource(pthr->dma_chan->device->dev,
			   pthr->perf->test_peer->dma_dst_addr,
			   pthr->perf->test_peer->outbuf_size,
			   DMA_FROM_DEVICE, 0);

Does this sequence need additional locking or per-thread DMA mapping tracki=
ng?

>  		if (ret)
>  			return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D8
