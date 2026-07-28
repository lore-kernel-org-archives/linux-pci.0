Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162539B949;
	Tue, 28 Jul 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260911; cv=none; b=OD4GBjCS9cntZGow7RJWSb338LrcMcUqblYgxjTnLUTH3FaoWCOR1x/ltWOJoJb9Rxykm/rV45lfU4Iow1m/aFgX/5pCCkSc54yFPqqN0vTtXD+7om0gSEHHQqF2spVHpiYMnTuv8Ex7M0lr8Hk47WaJismJ82omUETm9Cv7s5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260911; c=relaxed/simple;
	bh=r7+6RHQ9v7QuIIpjYfsxG+Pnn6vBU268pgyW7T5oDyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gO8PpmaWXojjvZyD4bLgxYDaI+30a79OaQ/7z7iR+SD9dbDKV2L0tt2wvISWm+c0/4UlU66NBbMrhvstTMoTxqdIqHjDXsgjQVILnkcZkQLBR2/tPvq0ZvGY2IkYbKVsNYJqqM1tlYEgoAdNsGs/G10rcMDj0J1fuA9VINVVs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEJu/6kR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEJu/6kR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8871F000E9;
	Tue, 28 Jul 2026 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260909;
	bh=8EjoOgXazjeZqRsKdp/GvYIzgsOlK+HU+xu/uBGZJlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEJu/6kR7UhfOk9ZMraubWY5qAA1Y9e6L/2Fa3C34Hu2L9/pl6pBdpoosEM3+cJ/k
	 FnUPGTQ1h/Gvr2a6mlhGOwUXAjin52OjcMw5qbu0fg4vm7xMKAN9nswK3tVQkFvWY9
	 6XoRSUDI1CPVqjTfslAZzYGWiC8ESXTC8m0CUy/fQuG6IR9NVH0u+RUk03BZ0wpDJw
	 pLBIgFb1N1irXO3+hvSFt9atow3h6QPbW82+/4Sb5ilbf0hsxmWSTCKB0IDTZVQrPh
	 M74BYS++los24V9hin9fpo4AUgmdkCJ3AJmT7kAMbD2bBfGkQD1B7Z/hyIJXaSliYq
	 MqGqDKHx/0FpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/12] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260728171523.112244-12-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-12-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:48:29 +0000
Message-Id: <20260728174829.5C8871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The embedded kobject in `struct ioatdma_chan` lacks a `.release` m=
ethod, decoupling its lifecycle from the containing object and creating a p=
otential use-after-free via sysfs.
--

--- Patch [11]: [PATCH v4 11/12] dmaengine: ioat: use sysfs_emit() in per-c=
hannel sysfs show() ---
commit af292acf66777b7c34a85fccbbbae1f36425b555
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()

Convert the sprintf() calls in the per-channel sysfs attribute show()
functions to sysfs_emit().

> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index e796ddb5383f8..976134df81084 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
[ ... ]
> @@ -135,7 +135,7 @@ static ssize_t intr_coalesce_show(struct dma_chan *c,=
 char *page)
>  {
>  	struct ioatdma_chan *ioat_chan =3D to_ioat_chan(c);
> =20
> -	return sprintf(page, "%d\n", ioat_chan->intr_coalesce);
> +	return sysfs_emit(page, "%d\n", ioat_chan->intr_coalesce);
>  }
> =20
>  static ssize_t intr_coalesce_store(struct dma_chan *c, const char *page,

[Severity: High]
This is a pre-existing issue, but since we are modifying sysfs behavior her=
e,
does the embedded kobject in struct ioatdma_chan lack a proper lifecycle?

Looking at ioat_ktype further down in this file, it does not define a relea=
se
callback:

const struct kobj_type ioat_ktype =3D {
	.sysfs_ops =3D &ioat_sysfs_ops,
	.default_groups =3D ioat_groups,
};

If a sysfs file is kept open by a userspace process and the driver is unbou=
nd,
release_ioatdma() unconditionally frees the channel:

drivers/dma/ioat/init.c:release_ioatdma() {
    ...
	for (i =3D 0; i < IOAT_MAX_CHANS; i++)
		kfree(d->idx[i]);
    ...
}

Could this result in a use-after-free when the userspace process eventually
closes the file descriptor, dropping the kernfs reference and causing
kobject_put() to dereference the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D11
