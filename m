Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38423246EB;
	Sat,  5 Sep 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613597; cv=none; b=aoKmX8JjHYqSJem1l3xXLnUNy+UGc+rju/09SUJDV5h3de/Y5K4Qot6cZT3XBOeVCHaLpPeSi0tqjZM0xXW7XN2zTf+pNIoPqoSo9QJUWHnYuEGCF5vq70gAyAsyFkmqOmDioypTvcoZOIJpEtpGXf2/ozdlnr59og7GaymqrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613597; c=relaxed/simple;
	bh=hxSIZW5feJ//3mtQtHkoEZEkKUh+23Tl03NTyfz5TEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gt8U/G0CjQD+F70fJcWkA9mdSJUIcHMjes1S1LzPswxdpR8dQrJCKg0Z071PDKmCaD/2TRTQ66GrErYRsqnuQoAugN9mciE4wtGV17E8KvVCn7+znvc2Snnrb4gbgi71NFOo2A0bl+3CukPT3iRW6sClVCEPZrBgw1tcQK4BJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj8zU8sB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj8zU8sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390501F00A3D;
	Sat,  5 Sep 2026 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613595;
	bh=AYG1jxghEIiwupHbFL/KVXvESRMDvvtFP+EE4BnPD2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tj8zU8sBmhMxLqJuK1IgY6YrSGuqf6Bx3N233gegv06q+URprhR9h19V7KbVeJ2yj
	 Tg6IgrMke0HEEnrKw3FpXGxQ3wi9lN3lzwWjjJxFAwA8j/FWdZSUcdVFH9oAZqU8nE
	 A6SbgcsGKY/co/6LFyDbKdQ3RMWxajbXJJhV2CTBTo3vntJPHnFeVJIOD9y1C9+DXq
	 iylyxulec90s7GynvOZB1FInKPmddKCYwpS3TN8ykLA/ts9hzmMY9M/9bRiHiRxW7y
	 4jhjsl3CdISVpGcL5gYkaaaPuNflxxIk2hcYIVgJtMom4HFkaFajtGa2WJRJhuoehC
	 zYuSwqVjuVzeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] media: dvb-core: extirpate defective and unsafe
 ULE debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905125706.6550-3-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
 <20260905125706.6550-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:06:34 +0000
Message-Id: <20260905130635.390501F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The commit message explicitly claims to 'clean up unused function p=
arameters', but the `iov` parameter in `dvb_net_ule_check_crc()` is left in=
tact and completely unused.

Pre-existing issues:
- [Critical] Insufficient length checks during ULE decapsulation allow out-=
of-bounds reads from kernel memory, leading to an information leak and pote=
ntial kernel crash.
--

commit bc7f64f0594cb54302cffa558b837ac23e377b2e
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

    media: dvb-core: extirpate defective and unsafe ULE debug block

This patch removes the unmaintained DVB_ULE_DEBUG code block from the dvb-c=
ore
network code, cleaning up its Kconfig definition and logging logic. It also
claims to clean up unused function parameters.

>     Completely purge the unmaintained DVB_ULE_DEBUG code block from
>     dvb_net.c and its Kconfig definition to eliminate severe lockless race
>     conditions and clean up unused function parameters.

[Severity: Low]
The commit message claims to "clean up unused function parameters", but
is the iov parameter still present and completely unused in
dvb_net_ule_check_crc() after this removal?

It appears the caller in dvb_net_ule() still initializes and passes iov:

	struct kvec iov[3] =3D {
		{ &ulen, sizeof ulen },
		{ &utype, sizeof utype },
		{ h.priv->ule_skb->data,
		  h.priv->ule_skb->len - 4 }
	};
	...
	dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);

Should iov be removed from the function signature and the caller as well?

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..ae0073b949a50 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c
[ ... ]
> @@ -659,23 +636,6 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule=
_handle *h,
>  			h->ts_remain > 2 ?
>  				*(unsigned short *)h->from_where : 0);
> =20
> -	#ifdef DVB_ULE_DEBUG
> -		hexdump(iov[0].iov_base, iov[0].iov_len);
> -		hexdump(iov[1].iov_base, iov[1].iov_len);
> -		hexdump(iov[2].iov_base, iov[2].iov_len);
> -
> -		if (ule_where =3D=3D ule_hist) {
> -			hexdump(&ule_hist[98*TS_SZ], TS_SZ);
> -			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
> -		} else if (ule_where =3D=3D &ule_hist[TS_SZ]) {
> -			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
> -			hexdump(ule_hist, TS_SZ);
> -		} else {
> -			hexdump(ule_where - TS_SZ - TS_SZ, TS_SZ);
> -			hexdump(ule_where - TS_SZ, TS_SZ);
> -		}
> -		ule_dump =3D 1;
> -	#endif
> =20
>  		h->dev->stats.rx_errors++;
>  		h->dev->stats.rx_crc_errors++;

[Severity: Critical]
This is a pre-existing issue, but does this code properly check boundaries
before pulling from the SKB?

Further down in dvb_net_ule_check_crc(), we blindly copy and pull ETH_ALEN:

	skb_copy_from_linear_data(h->priv->ule_skb, dest_addr, ETH_ALEN);
	skb_pull(h->priv->ule_skb, ETH_ALEN);

If skb->len is very small (e.g., ule_sndu_len < 10), skb_pull() fails silen=
tly,
leaving the data pointer unadvanced.

Later, handle_one_ule_extension() blindly advances the header pointer by
hlen << 1 without bounds checking:

	ext_len =3D hlen << 1;
	if (ule_optional_ext_handlers[htype])
		(void)ule_optional_ext_handlers[htype]( p );
	p->ule_next_hdr +=3D ext_len;
	p->ule_sndu_type =3D ntohs( *(__be16 *)(p->ule_next_hdr-2) );

Can this sequence lead to an out-of-bounds slab read if an attacker broadca=
sts
a malformed DVB transport stream cell with extension headers indicating a l=
arge
length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905125706.6550=
-1-breno3011alves@gmail.com?part=3D3
