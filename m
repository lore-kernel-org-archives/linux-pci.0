Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39A35B136;
	Sat,  5 Sep 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617555; cv=none; b=aSql1DDpp0ZkC6NJIg92AGB40lW9cIKL9XaZRKpe8QWi5+rYljElFh1+7PpJKU8VspyBZkMUQye1/gDnF8kzfKoFoHxV6zucmq8HYGzJJdGH7OGbjYeWsDA928ZL2Ui8G94KX+8diYR01azv2w44mCHXCLgGRkxSGRfefCOghIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617555; c=relaxed/simple;
	bh=mv8VZ74PWKpzPwh6Aj6UXXfAmUnYMMAFFXKLqSkxTfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JT3Y5jShUQUKtrNlhFc7G0Lgyg2gs7rglPNlkVPlC69SDkis+0EVWkW9X+RPnEaavYZ8xhkhWOBiwMqP1Xo+xPa2OF2qd9eYOkfGgs4uuoWfWRniZm8FY1mZrgowDNTlWw1l0hpT9PQPoEvpmfUXpQlDHk6Wnw1NNWAvnvWVB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncQ8xU0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncQ8xU0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A1F1F00A3D;
	Sat,  5 Sep 2026 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788617553;
	bh=Vs884suqopPYagEUw6uw5u4ScRF6rdzLaNwPfM1Khy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ncQ8xU0LVoxgf0Eu3BMIY4C3V0Miz0HgDYFwZmDGJvkynJT/x2RrA8YB4A0F6fobt
	 r1/vZTMQiputYLGaJcVK/s6Lv7dAzhcuhSjLv7YX0A0TgN6eUPrMNrGEbKObI+4ped
	 tuR1QTXBWo2PffcrT16sPWgAM4fJrQ+aFcLwzj+ycaZ34Sorjmj21JB4mUJwA3O++5
	 ZwQp3ZurvEb/CPKBzYPIcWEL+uZR9DI08SeBVPvRGdY9n8tHE4gm3lpji1tP0en+zW
	 wAV6rzc3OifqhKhVVzL4sHpZ8zNKQw7akslWt0Bj3xz88Awtalb3R7qWiVI5uvsFzz
	 dXlH72u915gWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/3] media: dvb-core: extirpate defective and unsafe
 ULE debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260905140113.21638-3-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
 <20260905140113.21638-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:12:32 +0000
Message-Id: <20260905141233.39A1F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a severe compilation failure by modifying the =
call to `dvb_net_ule_check_crc()` to pass 3 arguments instead of 4, without=
 updating the function's signature to match.

Pre-existing issues:
- [Critical] The network device is unregistered after flushing the workqueu=
es, allowing callbacks to queue works during unregistration, which leads to=
 a Use-After-Free.
- [Critical] Missing bounds checks when parsing ULE extension headers allow=
s malformed packets to cause out-of-bounds memory reads.
--

commit e9caeb2ec9c58e63757d73d1d8a17bcadf35a678
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

media: dvb-core: extirpate defective and unsafe ULE debug block

This commit removes the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition. It aims to eliminate race
conditions and clean up unused function signature parameters.

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..5060b8866de8a 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c

[ ... ]

> @@ -843,7 +803,7 @@ static void dvb_net_ule(struct net_device *dev, const=
 u8 *buf, size_t buf_len)
>  				       *(tail - 2) << 8 |
>  				       *(tail - 1);
> =20
> -			dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);
> +			dvb_net_ule_check_crc(&h, ule_crc, expected_crc);

[Severity: Low]
Does this change miss updating the function signature of
dvb_net_ule_check_crc()?=20

It looks like the invocation now passes 3 arguments, but the function
definition for dvb_net_ule_check_crc() still expects the iov array as its
second argument, which causes a compilation failure due to too few argument=
s.

> =20
>  			/* Prepare for next SNDU. */
>  			reset_ule(h.priv);


While reviewing this code, I also noticed a couple of issues that are not
introduced by this patch, but might be worth addressing:

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free
when unregistering the network device.

In dvb_net_remove_if(), the workqueues are flushed before the device is
unregistered:

	flush_work(&priv->set_multicast_list_wq);
	flush_work(&priv->restart_net_feed_wq);
	pr_info("removed network interface %s\n", net->name);
	unregister_netdev(net);

When unregister_netdev() is called, callbacks can be triggered (such as
ndo_set_rx_mode mapping to dvb_net_set_multicast_list) which schedule work
back onto set_multicast_list_wq. Could this result in a use-after-free
when the pending work executes later, since the priv memory gets freed
during teardown?

[Severity: Critical]
This is a pre-existing issue, but it looks like there might be an
out-of-bounds read when parsing ULE extension headers.

The handle_ule_extensions() loop iterates over extension headers using
handle_one_ule_extension(), which reads memory and advances the pointer:

	p->ule_next_hdr +=3D ext_len;
	p->ule_sndu_type =3D ntohs( *(__be16 *)(p->ule_next_hdr-2) );

Is it possible for a malformed payload to specify extension lengths that
push p->ule_next_hdr past the end of the allocated skb buffer? The loop
appears to continue without bounds checking against skb->len, which could
cause a page fault on malicious inputs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905140113.2163=
8-1-breno3011alves@gmail.com?part=3D3
