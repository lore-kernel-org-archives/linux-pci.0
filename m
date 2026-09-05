Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7230CD81;
	Sat,  5 Sep 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612880; cv=none; b=aVx+9JkrpcwuHjKbDWj029Ic8deYj2W2eQfaM7VLtri6cm3NuvUBmPgzXFxA40eCwdmySRuY1Zo5oMZujF6/O8m8WH2ijtXnlMuug1Yqp3OK35Y6R98q1MsnG2IAEMzaeiLECVPxliRNwUTucwiphJSZaSw8MSGbfnQGd+DEWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612880; c=relaxed/simple;
	bh=nudWVbA+xOSmAJu2klERHAMQitNEzhW9CQ1GUuisBDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwb2nLf600kEI6dY54oh7xj8/qY/3WBQs4F9eHfPD3n3X61Mc+TbZXvCkHNnwLDEt7qrOTs7Oxl+mGlgjP1ZEKOmsiPYfwY0ahr0cEFf3vgv66jydwNT3RYXf46aWYXYcBxiGbLKRx6w1SPna4SpvnSk+GcWvT4rWC/EFfGIaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay+N7mU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay+N7mU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978591F00A3D;
	Sat,  5 Sep 2026 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612879;
	bh=BkTM9xa/tB0gIimEm2HcjWnynQXEzijTVj4bJ5tzlB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ay+N7mU7VlSszXh0g60u1f/7+mG0+5qIwYalQlUxlDKc0SRt2l7+zOzkc1Qr4qDRW
	 mX+vquPjn13GjKuZ26EgakRGdBEAOQG0cr27omuzjFw6P6+uQVLzvSPLnH57Qs6xBs
	 2dqT1PTMDOJnrjojMwMPZ06Ns5/AGGJ9n4t+8o9sem8wPMiVbmfxL5bFZq0QGfAZFK
	 wuqmkcDrSlWR4Ps0CZod5ONzCuLQEPYTmdRHXZL5zi8dkecUKpb4ZhnE3OEUhEblAg
	 VRnF6NrH8OJEcxguz0MU6IANMNY8O7E7sTBovGM8Wu9kCneXD3LmPILl06p8GA2MGD
	 pQ5CRK5Y1YdDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] media: dvb-core: extirpate defective and unsafe
 ULE debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260905124434.6163-3-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
 <20260905124434.6163-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:54:38 +0000
Message-Id: <20260905125438.978591F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The patch silently includes an unrelated modification in the LED=
 subsystem Kconfig.
- [Low] The commit removes the `DVB_ULE_DEBUG` code blocks from `dvb_net.c`=
 but fails to remove the corresponding Kconfig option from `drivers/media/d=
vb-core/Kconfig`.
- [Low] The parameter `iov` in `dvb_net_ule_check_crc()` is now unused afte=
r the removal of the debug block.

Pre-existing issues:
- [Critical] The ULE SNDU payload parser lacks robust bounds checking on us=
er-controlled length fields, allowing an attacker to underflow `skb->len` v=
ia `skb_pull()` and read/write out-of-bounds memory.
- [High] Dereferencing a casted `unsigned short *` pointer from an unaligne=
d byte stream causes a kernel panic due to alignment faults on strict archi=
tectures.
--

commit fe63e38a3f8932fddc46f48a9206976093b6c1c6
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

    media: dvb-core: extirpate defective and unsafe ULE debug block

    Completely purge the unmaintained DVB_ULE_DEBUG code block from
    dvb_net.c to eliminate severe lockless race conditions and buffer overf=
low
    vulnerabilities on global network state variables.

>     Completely purge the unmaintained DVB_ULE_DEBUG code block from
>     dvb_net.c to eliminate severe lockless race conditions and buffer ove=
rflow
>     vulnerabilities on global network state variables.

[Severity: Low]
Did this commit miss removing the config DVB_ULE_DEBUG definition from
drivers/media/dvb-core/Kconfig? Leaving it in makes the Kconfig option
selectable but has no effect.

> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d0d3182236be4..800fbd56093ec 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -873,7 +873,6 @@ config LEDS_UPBOARD
>  	  This driver can also be built as a module. If so the module will be
>  	  called leds-upboard.
> =20
> -comment "LED driver for blink(1) USB RGB LED is under Special HID driver=
s (HID_THINGM)"
> =20
>  config LEDS_BLINKM
>  	tristate "LED support for the BlinkM I2C RGB LED"

[Severity: Medium]
Is this unrelated modification in the LED subsystem Kconfig intentional? It
doesn't seem to be documented in the commit message and introduces an
undocumented side effect in an unrelated subsystem.

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

[Severity: High]
This isn't a bug introduced by this patch, but does the unaligned pointer c=
ast
here cause a fatal alignment fault on strict architectures?

In drivers/media/dvb-core/dvb_net.c:dvb_net_ule_check_crc(), when an attack=
er
sends a ULE packet with an invalid CRC, the error path unsafely casts the
unaligned h->from_where pointer to an unsigned short * and dereferences it:

    h->ts_remain > 2 ? *(unsigned short *)h->from_where : 0);

This can cause a kernel panic (Denial of Service) on architectures like SPA=
RC
or older ARM that do not support unaligned accesses.

[Severity: Low]
With the removal of the DVB_ULE_DEBUG block below, is the parameter iov in
dvb_net_ule_check_crc() now unused?

drivers/media/dvb-core/dvb_net.c:dvb_net_ule_check_crc(struct dvb_net_ule_h=
andle *h,
                                  struct kvec iov[3],
                                  u32 ule_crc, u32 expected_crc)

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
This is a pre-existing issue, but does the ULE SNDU payload parser lack
robust bounds checking on user-controlled length fields?

In drivers/media/dvb-core/dvb_net.c:dvb_net_ule_new_payload(), the minimum
length check fails to account for the 6-byte MAC address when ule_dbit is 0:

    if (h->priv->ule_sndu_len < 5) {

If an attacker sends a malformed packet with ule_dbit =3D=3D 0 and a payload
length of 5, after the 4-byte CRC is removed in dvb_net_ule_check_crc(),
skb->len becomes 1. Then skb_pull(h->priv->ule_skb, ETH_ALEN) subtracts 6,
causing skb->len to underflow:

drivers/media/dvb-core/dvb_net.c:dvb_net_ule_check_crc() {
    ...
    if (!h->priv->ule_dbit) {
        ...
        skb_pull(h->priv->ule_skb, ETH_ALEN);
    ...
}

Similarly, in handle_ule_extensions(), the loop accumulates lengths without
validating they fit in the payload buffer:

drivers/media/dvb-core/dvb_net.c:handle_ule_extensions() {
    ...
        total_ext_len +=3D l;
    ...
}

This unbounded length is then passed to skb_pull() in dvb_net_ule_check_crc=
(),
again causing an skb->len underflow:

drivers/media/dvb-core/dvb_net.c:dvb_net_ule_check_crc() {
    ...
        skb_pull(h->priv->ule_skb, l);
    ...
}

This allows an attacker to underflow skb->len and read or write
out-of-bounds memory, leading to network stack memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905124434.6163=
-1-breno3011alves@gmail.com?part=3D3
