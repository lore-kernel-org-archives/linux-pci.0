Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B82248A3;
	Sat,  6 Jun 2026 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705600; cv=none; b=OcGVu+8ruy2pHnX5iZ0SDVfNqmt1M49D6fRMkQW0dOppBdd0+OUxy52X2UAOgDbXs2rMXmSQRCS0iFUc5U8ignGC4vGSYTBRPe9FyYplUGCelguxuzsgPrY2JKFeW4NBhXEGMiUjOPIUSaH+CJjCKVF1fIvqaFQNmjlIvhJnXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705600; c=relaxed/simple;
	bh=257nY1KOi0hxr8bzdF3zWvWlAGtdbN2T/wXPHS9UXFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mBVln/KcX+o5Pcp23EqxqlP2nZS4wNX88Yt0zv39+zBBCGL/TH73VnA41RL2kHY5NX5G8sER+gQrmRVPln9zBP0GDRa9o8MYAdW96NLlGIehu7Ko9LDGHgP5fNF64NM2WgbDxhtTUSfs9qBxfj1HylyFNRbzqoDDXZts2G8mBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEvQ7Wgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEvQ7Wgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA96B1F00893;
	Sat,  6 Jun 2026 00:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705598;
	bh=ZoeWKOoCfE//lsEZdvgy1YIU9Wy12g4ctb6rVAercF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEvQ7Wgmv1G8/JieLeuOfQPIvwX25skvnHJmExfsz301YKqz/YXiXww/Fk4X49LCR
	 rYrX/dnZgyWzu6ecnT/cOYiNqPoAatX5rrZpP9nIqGF9FJzgZ3lcdUZbzF1r0VtcJE
	 CNKqUYC3AJ9nyN9N8d3B9UeLF0oBF2vf9eDH4KGsAOOJFs2P9E4mEl5JK+0GVmU5aJ
	 QZoImZlIDNlSp5xbAhI3/NYH1QSJNFAXZGy1BYNfeyDo63F4T5HcUCiiPx8meh0/Di
	 EQgkA/qqWBiqUJF0SXqcJJVVala/TaJXUqH7/jFJCg7WHU6m0EunzXyq8Nzjq+LRWq
	 2VBe9yySZ18tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/23] dmaengine: sdxi: Add unit tests for descriptor
 encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-21-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-21-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:26:37 +0000
Message-Id: <20260606002637.DA96B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Copy-paste error in the `cxt_stop` test causing it to assert on an =
incorrect union field (`desc.cxt_start.vflags`).
--

commit cabf8e94603d8e7f4dadb05e7df3a65c6cd9cd8f
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add unit tests for descriptor encoding

This commit adds unit tests for the SDXI descriptor encoder functions.
It uses the packing API to independently decode and verify the descriptor
layouts without relying on the driver's bitfield macros.

> diff --git a/drivers/dma/sdxi/descriptor_kunit.c b/drivers/dma/sdxi/descr=
iptor_kunit.c
> new file mode 100644
> index 0000000000000..1f3c2e7ab2ddf
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor_kunit.c
[ ... ]
> +static void cxt_stop(struct kunit *t)
> +{
> +	struct unpacked_desc unpacked;
> +	struct sdxi_cxt_stop stop =3D {
> +		.range =3D sdxi_cxt_range_single(2),
> +	};
> +	struct sdxi_desc desc;
> +
> +	desc_poison(&desc);
> +	KUNIT_ASSERT_EQ(t, 0, sdxi_encode_cxt_stop(&desc, &stop));
> +
> +	unpack_cxt_stop(&unpacked, &desc);
> +
> +	/* Check op-specific fields. */
> +	KUNIT_EXPECT_EQ(t, 0, desc.cxt_start.vflags);

[Severity: Low]
Is there a copy-paste error here? This is the cxt_stop test, but it checks
desc.cxt_start.vflags instead of desc.cxt_stop.vflags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D21
