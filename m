Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCB36212E;
	Sat,  5 Sep 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788614408; cv=none; b=CCTvt8aYbquaHCC5/cH07lzaoTShyqlx6SyZayRFTMJhugzdw8OOd8l6ucobIzS2k0eTGm7gIc5WO9vFGiOeldnH82660jELT+hNx8fYSTVZpyMAJ7SkWrEgL3O8wvPY1/CyW8wg4x43FUmpwCZR3BNLgiIYA1g1eqPDdJRZEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788614408; c=relaxed/simple;
	bh=WqztWZlCfHvDdyBi2rpV0V1+tAeP6OLYy8+Q10KA+wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ey7hCKhnu6qL6MSZMEi1DIjyBNxHl23Qw28NVbXSX83fBloh3AFvHTywFBPEGM7OJjcVLG9mXJKFoUCeiVKdk5dcgPa/FsRx622RmNHxev7UP/SEDhzClCDUgIQ2Nz2+UYtmHBcXVaTbYgXGQyFQLWc4fhXJPz8VdHLn1laXURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsxaYXui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsxaYXui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A45C1F00A3D;
	Sat,  5 Sep 2026 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788614397;
	bh=m55xrp+WWxJqan+Iw37nlKpCpdLJfbJdCkT6FkarQGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsxaYXuiJoM/9XbZxB3D+aDC5/5xgnJ7ipMfA62OWG8/flYExDBbTZrD2KEo5nlU7
	 /voH6LxvNDU44qUvt+vxxcPJ2INxZEi2fo1dWRJiXnyHnz8Eersajinn3lFMjW6ojd
	 HPMKQLQbDGq+/KKXccuDPdTJJPJ3EZB3XjEpZ0y7qwg5CriRwv0rxdacz1IE+7M2Fi
	 EnHRN/h+dZF2rwu6eJ1AtuPvVmnrCHEaZAE35oMrlB80xKQBS7NgCpEtrZIsD4PDVF
	 6wVzvEU4vyqRObuHkv/2jfq5XGaU+Q3Pdf4uSvPNIySEF3XR2NQF4kqB9saeCQzyGT
	 auo0MuMF/AUqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] media: dvb-core: extirpate defective and unsafe
 ULE debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905130925.7115-3-breno3011alves@gmail.com>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
 <20260905130925.7115-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:19:57 +0000
Message-Id: <20260905131957.8A45C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Removal of the `iov` array declaration breaks compilation because i=
t is still required for CRC32 computation.
- [Low] The `iov` parameter in `dvb_net_ule_check_crc()` is left entirely u=
nused, contradicting the commit message claim.

Pre-existing issues:
- [High] Missing length checks in ULE extension header parsing allows an ar=
bitrary out-of-bounds heap memory read.
--

commit 8bbfcd7d5129e4e8e1d24fd8e69989a6dcdf34d2
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

media: dvb-core: extirpate defective and unsafe ULE debug block

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up unused function parameters.

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..29f99dfe282a3 100644
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

[Severity: Low]
Does the iov parameter in dvb_net_ule_check_crc() need to be kept in the
function signature?

The commit message mentions cleaning up unused function parameters, but
iov remains in the signature while being entirely unused inside the function
now that the debug code is removed.

[ ... ]

> @@ -823,12 +783,6 @@ static void dvb_net_ule(struct net_device *dev, cons=
t u8 *buf, size_t buf_len)
>  			__be16 ulen =3D htons(h.priv->ule_sndu_len);
>  			__be16 utype =3D htons(h.priv->ule_sndu_type);
>  			const u8 *tail;
> -			struct kvec iov[3] =3D {
> -				{ &ulen, sizeof ulen },
> -				{ &utype, sizeof utype },
> -				{ h.priv->ule_skb->data,
> -				  h.priv->ule_skb->len - 4 }
> -			};
>  			u32 ule_crc =3D ~0L, expected_crc;
>  			if (h.priv->ule_dbit) {
>  				/* Set D-bit for CRC32 verification,

[Severity: Low]
Does the removal of the iov array break compilation?

Looking further down in dvb_net_ule(), iov is still passed to both
iov_crc32() and dvb_net_ule_check_crc():

			ule_crc =3D iov_crc32(ule_crc, iov, 3);
			...
			dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);

Removing the declaration causes a compile error.

[Severity: High]
This is a pre-existing issue, but can the ULE extension header parsing enter
an infinite out-of-bounds read?

When handle_ule_extensions() iteratively calls handle_one_ule_extension()
on incoming packets:

drivers/media/dvb-core/dvb_net.c:handle_ule_extensions() {
	...
	do {
		l =3D handle_one_ule_extension( p );
		if (l < 0)
			return l;
		...
	} while (p->ule_sndu_type < ETH_P_802_3_MIN);
	...
}

Inside handle_one_ule_extension(), p->ule_next_hdr is advanced without
verifying if the pointer exceeds the bounds of the skb->data payload:

drivers/media/dvb-core/dvb_net.c:handle_one_ule_extension() {
	...
	} else {
		/* Optional extension header.  Calculate the length. */
		ext_len =3D hlen << 1;
		...
		p->ule_next_hdr +=3D ext_len;
		p->ule_sndu_type =3D ntohs( *(__be16 *)(p->ule_next_hdr-2) );
	...
}

Could a malicious DVB stream payload with untrusted lengths force the kernel
to continuously read past the skb->data payload until a non-extension header
type is found or a panic occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905130925.7115=
-1-breno3011alves@gmail.com?part=3D3
