Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E06449983;
	Thu,  9 Jul 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623023; cv=none; b=jETMV1hEXXqOnpgT4mrV0K+5GFAAb7uOO4QH7xSfz/0cE3Uf2AWd3n0rSlRdlMRLbAji0epjk7jmA8IktKwza9fT31a0pDk74gHv7JR7j9MoOLzFdzXf4i/01rom7h3HM/U1PJN6XmN2wOcWiMeAaQ1K5NuKWIAnOlF2UmsuSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623023; c=relaxed/simple;
	bh=eMvLjavfrZJlD2lRmP5k01iYM1ODAb6U0vzOTDvTHkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuE66BgqqoTtddvs+WkW6f9QB6v0RR12Vt4FYVKngj1EEVNvucG126zEB8JeaNHdU427VkuQmzYCWMsiV9T7F/eILN7NVH23xpb/Nxj85gv/8jrLc88xv1O7pfXvAFzGrZPRVEFxsKqXpRBG/s7phQgGcvCQjMN/SF46jcv1KSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=M/t6VLUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeWhHHCm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="M/t6VLUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeWhHHCm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DA3AEC0197;
	Thu,  9 Jul 2026 14:50:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 14:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783623017;
	 x=1783709417; bh=7eq+s1ki9p+cx7h5OYu+Ag2KZEjIMZR2/rJcK6DAnx0=; b=
	M/t6VLUwy3NLxuqfRPwA6WvREost/ZkTc2X9GZ1ouz3sJpbcbzftnuVjBpp2muPl
	YnA86ewcgSv65yNBSyvQYL0cRN2vbPDbVq2/qo1beWuqKzy4XzE4w4VtoRn+djPs
	N7GSlG3rpk4GilxzZZi/jo3TSbwpnyadeZxIJaXviJSSEqc2vVTvibJWJGMpGNpu
	7TYvXadjbKzA8/LJjZ7x8USS+pZcekHY9MT6AZeGQQRDb5yb9Vh6ImP+Mr3pwXlv
	ILj5W9/EOErGnP8EEA2E5CWLSqx0u94g+8yBw6+HEyI8JqUSogouteQH4gzOanfM
	tRMLyua53qADya8oFHfLeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783623017; x=
	1783709417; bh=7eq+s1ki9p+cx7h5OYu+Ag2KZEjIMZR2/rJcK6DAnx0=; b=G
	eWhHHCmmchaq7gNFCebO0hlPSkPSVOp0OAZmA+YLRfYKuYsINsPQQq1l7qxepwxO
	8Wa/T+a7+U2BuJy48wSgIYV4//bShJwkbECPw4eUi41HO89fzo9RL3KwUWjxJy+M
	Aq+YlK955ilkvyEmPPw1QD7iX02sgx0Y+R2ElejuflWZLI2J4/JrKy1SLGQN4Xcx
	LxxVg5E8xc3zfX0pz0VEJQxqPQJRRjIkHVbhrYv+c4pxqTLTA0qEavQ7I1kZbBsI
	m9NqmbTOSbHjglXBu/D+gMseSdzWxI4QAGn3KyC56hEK2iCOd2IU4R9tZffVhkAh
	TEqFEHmEn/WdIEwk5okdA==
X-ME-Sender: <xms:aO1Pai-paWvwQNKt4z_xknRSfCc-FvPPgFRCjtBz-MEUDS-4wuPMEQ>
    <xme:aO1PakSA_5Vqs5P39oQLY5HEVP2JnTg6_Bw-7vH1nHAoD20Vf3bT6wrhSXyjc-1bM
    l3LkN3A9AtqKJf7FpZTJJl8AeL65z4lrZVCEeRcz2dI4tU9eEveNzk>
X-ME-Received: <xmr:aO1PanRLQegSbgCQfltGAAB2yi7AthdWyZX8Fzrs95BGd7hs9hxGOdV0pzQ>
X-ME-Proxy-Cause: dmFkZTFEkJAMthfS71ADEk1iBTN4/4AMIax5uZ45lBRkBiTnkMmOke3v5MVcBKOzW4Fcv4
    Wrt2jMEs1NyZY4b/aaTetRDUdyHCQPSNUht7HAMk+dduEVIs8ojvld2m6/jQhPEZuYFrF6
    mpevGh0lMmZdy2axmup1Err3v6PUzHzVwsFTmbi2+eqGo6LE/UXfGTe9FWxA3o2xacLhk1
    cYSKKPaFGTN2qsEGTm72g16A2/bBA/E8oSg7scRxHuN9eBe3IMiUzjM9I87NWLjVekiYn7
    LR4JZJlLTp352tCtc/PVH9HTIsWXp70n5tASuSxwezBz+nEt+G2qlLN65LrnSCfxST8AUv
    mP/ZNaC+JY1ZEX1DTfMK8p/c7lKiYo9IAKsinzjGd+KlSXzNSiDnsj2t8pWqHkLrOg9ewi
    HBM/eVGfJwIVVOsB5S8FHXagB+gEqyTiNc2cR+dBbKN4fPSc1oW2VuauYskR9ZbZrwaRyq
    PIAqZKu1GU7n+uV1WIPmbUergvNc1zKCK8+lRhaRa0a/AtZv1mAiVvNCQ/ZyzorhrwI0yv
    ey79rJVYsCR7isbnOEdBn3NEdLTeGQkwU1zf4t0IdSZfCJ0Xo3gLuRGmfHo+U4nUbgqRJW
    yzsMpRKDycSoZHPdGyXXPaUtTSjX2o0T4zSLFIbGtFIvcFlW/ffS3KnC44Hg
X-ME-Proxy: <xmx:aO1Pag4qht9LSUiPYKcEgbKaTdEPisxgYQev1sfE4EiqVbZJQA3frw>
    <xmx:aO1PasWJaWiX_g5bV9PRmUjk1DwzRYQOjgQsmVk5bObD5RAZN65GGw>
    <xmx:aO1Pam8lvXA_r2YXG1OnGK9ys2_ytBixnTQMe3ZTyjjFowhrzOjLGQ>
    <xmx:aO1PasrLbjHY6JzKP4De73WedriiXVZmklFRroigJxXHJUbRyD9crA>
    <xmx:ae1PalAzBKUQ0sh4TEe1CY2UOWVGpUN9u2bP4nk1zMvSAwBinT339INI>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 14:50:14 -0400 (EDT)
Date: Thu, 9 Jul 2026 12:50:12 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
Message-ID: <20260709125012.21784d0a@shazbot.org>
In-Reply-To: <bb0e583e-501f-4356-b554-784482b35331@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-13-fengchengwen@huawei.com>
	<20260708173117.3e399c4b@shazbot.org>
	<bb0e583e-501f-4356-b554-784482b35331@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 19:49:24 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi Alex,
>=20
> On 7/9/2026 7:31 AM, Alex Williamson wrote:
> > On Thu, 2 Jul 2026 20:42:18 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> >>
> >> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> >> ---
> >>  drivers/vfio/pci/vfio_pci_dmabuf.c | 49 +++++++++++++++++++++++++++++-
> >>  drivers/vfio/pci/vfio_pci_priv.h   |  6 ++++
> >>  2 files changed, 54 insertions(+), 1 deletion(-) =20
> >=20
> > Please don't send competing patches, just indicate the series is based
> > on Zhiping's series v#.  This makes all the naming changes that Zhiping
> > declined yet you still included their sign-off.  Thanks, =20
>=20
> Thanks for the feedback on overlapping dmabuf TPH patches with Zhiping=E2=
=80=99s series.
> There are code conflicts between the two series on PCI TPH and VFIO dmabu=
f logic,
> and I also have concerns that Sashiko may not properly parse and track cr=
oss-series
> Depends-on tags for reliable automated review.
>=20
> My current design idea is to retain this foundational metadata patch in my
> series. This patch only implements basic storage and query helpers for TP=
H tags
> on dma_buf objects, providing the underlying infrastructure. Zhiping can =
then
> build the corresponding VFIO device feature ioctl layer on top of these c=
ommits
> in his follow-up series. I will fully sync all his latest code revisions =
into
> this patch to align implementation details and minimize future merge conf=
licts

If your concern is sashiko being able to apply and review your series
on top of another, then I would suggest leading the series with the
unmodified patches clearly noted in the cover letter and commit logs.

As provided here, this patch initially appears as excerpts of Zhiping
series, again including sign-off without permission, but it introduces
this massive gap that was previously overlooked as a result:

> >> =20
> >> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u=
8 *ph)
> >> +{
> >> +	struct dma_buf *dmabuf;
> >> +	int ret =3D 0;
> >> +
> >> +	dmabuf =3D dma_buf_get(fd);
> >> +	if (IS_ERR(dmabuf))
> >> +		return PTR_ERR(dmabuf);
> >> +
> >> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> >> +		ret =3D -EINVAL;
> >> +		goto out;
> >> +	}
> >> +
> >> +	ret =3D vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
> >> +out:
> >> +	dma_buf_put(dmabuf);
> >> +	return ret;
> >> +}

.get_pci_tph() is proposed as a generic feature of dmabufs.  We cannot
require that only vfio-pci provided dmabufs are supported, nor can we
bypass the default interfaces and lifecycles.  This needs to use
dma_buf_get_pci_tph(), rather than punch through to the vfio-pci
implementation of .get_pci_tph(), and it needs to honor the calling
conventions of that interface.  That's what makes this series dependent
on Zhiping's implementation of TPH as a vfio-pci completer feature.

Already, within this patch, the caller violates the lockdep assertion
that the dma reservation lock is held.

Additionally, dma_buf_get_pci_tph() defines that the provided values
are only valid until invalidate_mappings, but this series has no
plumbing to honor that requirement.

This needs significant work if we need to track the lifecycle of every
dmabuf related TPH value.  Thanks,

Alex
