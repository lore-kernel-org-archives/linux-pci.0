Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3841E6D6;
	Thu, 27 Aug 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858320; cv=none; b=WVgRuNXjpR1flu0o3Xm4c/kLCX4g5aiO5P/5nVC8yzcszW4ImHffxthXEqTJJCvPyRqTTZyUuVgZ4534A8OLmweeBGUCIItnNGOB5nBKtIjAMIoM0Q4xEKiSBiIx+teYSteZKumSwGZqqpfxE9VV/M3q9fe7ccqg0Zed9BHWwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858320; c=relaxed/simple;
	bh=ZEvghn5iUqKMeGcDHG1wGNG7qY9SwnARynbhSwp0i1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2syEzXxkeoTap0GG8fn+JgLR5T2Yrw+Ytovg2lgznaMq5Rdqr519UJI8WV2WqxMyF48qORWTRFcW5pY5eyHfJi+gYC8NSSe0nXxrVXnGxp7RzTsskAxU5RXg6Wn8msxWCdu3qRAaFb7u0z2zgFGBuizUv753mV3ROKCDqq3DP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqeGMP6p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqeGMP6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787858316; x=1819394316;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZEvghn5iUqKMeGcDHG1wGNG7qY9SwnARynbhSwp0i1Y=;
  b=ZqeGMP6pDr+V/FpCR9e2LlLGP43I6HAyiMFvfkSouPcmqp4VpjKwmY5P
   5VWWgsXWIXjnXQPMS17jMh7koZSDyKUBMJ3G9NEseWgITapw8zqT9ITa9
   Da9aQpj1NoVT+0Y9+ghHDg7fbXnFtG+WkYZ6ILrUbiUPVvLQP6o5TUhNA
   NuDmPHhTko7PZdiGB90vn9kTXam990CAICBI+Bbbk/xGAOmO4ue4QT+Us
   FaJMy+BKGXdeGa8C1vumRdFRLBz25biA/UPYTLhjmBJC32rrYVPtufKPr
   nf+4EcRNBYM+1BB0wxYRzNpnsv7bkF5R2SHlBBM0q0jwtMkaSZnunQh/s
   A==;
X-CSE-ConnectionGUID: Fohm4VWeTXmlXHfdajtgXA==
X-CSE-MsgGUID: O7bukribTOK6CvCvxzGebw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99884407"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99884407"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:18:35 -0700
X-CSE-ConnectionGUID: L0/Yj2PwQey07ZTfhx1ceg==
X-CSE-MsgGUID: iNlDjpvRT0m8hk8uRUzQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="297854378"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.26]) ([10.245.245.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:18:32 -0700
Message-ID: <7f13dc482e5ea2d22ddff75fe30c03cd8df42fb5.camel@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 2/2] dma-buf: Document how exporters and
 importers agree on mapping lifetime
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Thu, 27 Aug 2026 21:18:29 +0200
In-Reply-To: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
		 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Some comments below:

On Tue, 2026-08-25 at 09:28 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Pinned, revoked and movable mappings are selected by which optional
> callbacks each side implements and by whether dma_buf_pin() succeeds,
> not by any flag or enum. Nothing in Documentation/ says so, and the
> rules are spread over the kdoc of dma_buf_ops.pin,
> dma_buf_attach_ops.invalidate_mappings and
> dma_buf_invalidate_mappings(),
> so a driver author has to know the symbol names before finding them.
>=20
> Name, per flow, the callbacks both sides have to implement to end up
> in
> it, describe dma_buf_pin() as the runtime negotiation, and record
> that
> the pin is what tells a revoke from a move.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> =C2=A0Documentation/driver-api/dma-buf.rst |=C2=A0 6 +++
> =C2=A0drivers/dma-buf/dma-buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 85
> +++++++++++++++++++++++++++++++++++-
> =C2=A02 files changed, 90 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/driver-api/dma-buf.rst
> b/Documentation/driver-api/dma-buf.rst
> index 2f36c21d9948..39c201f38aa6 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
> =C2=A0.. kernel-doc:: drivers/dma-buf/dma-buf.c
> =C2=A0=C2=A0=C2=A0 :doc: dma buf device access
> =C2=A0
> +Mapping Lifetime Negotiation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> +=C2=A0=C2=A0 :doc: mapping lifetime negotiation
> +
> =C2=A0CPU Access to DMA Buffer Objects
> =C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..30afec7365bc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size,
> int flags)
> =C2=A0 *=C2=A0=C2=A0=C2=A0 reference acquired with dma_buf_get() by calli=
ng
> dma_buf_put().
> =C2=A0 *
> =C2=A0 * For the detailed semantics exporters are expected to implement
> see
> - * &dma_buf_ops.
> + * &dma_buf_ops. Whether the exporter may still move or destroy the
> backing
> + * storage after step 3 depends on what exporter and importer
> implement, see
> + * the mapping lifetime negotiation section below.
> + */
> +
> +/**
> + * DOC: mapping lifetime negotiation
> + *
> + * No flag or enum says whether the exporter may move or take away
> the backing
> + * storage while an importer holds a mapping. Each side implements a
> set of
> + * optional callbacks, and dma_buf_pin() settles the result at
> runtime. Three
> + * flows come out of it:
> + *
> + * - Pinned: the storage never moves and is never taken away.
> + * - Revoked: the storage never moves, but the exporter may take it
> away.
> + * - Movable: the exporter may relocate the storage at any time.

Perhaps add "even temporarily to locations that are not available for
DMA".

> + *
> + * Every exporter implements &dma_buf_ops.map_dma_buf,
> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release.
> dma_buf_export()
> + * rejects an exporter missing any of them.
> + *
> + * An importer reaches its flow like this:
> + *
> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> + *=C2=A0=C2=A0=C2=A0 &dma_buf_attach_ops.invalidate_mappings NULL rules =
out
> everything but the
> + *=C2=A0=C2=A0=C2=A0 pinned flow, because the importer can then never be=
 told
> anything.
> + * 2. Call dma_buf_pin() under the reservation lock.
> + * 3. On failure run the movable flow, or give up.
> + * 4. On success the storage stays put. Whether the exporter may
> still take it
> + *=C2=A0=C2=A0=C2=A0 away, which makes this the revoked flow instead of =
the pinned
> one, is the
> + *=C2=A0=C2=A0=C2=A0 exporter's choice and is not reported back.
> + *
> + * dma_buf_attach() is the shorthand for an importer which only ever
> wants the
> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then
> pins around
> + * every dma_buf_map_attachment() and waits for the
> DMA_RESV_USAGE_KERNEL
> + * fences on the importer's behalf. Peer to peer needs
> + * dma_buf_dynamic_attach(), because
> &dma_buf_attach_ops.allow_peer2peer lives
> + * in the attach ops.
> + *
> + * Pinned flow:
> + *
> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to
> hold the
> + *=C2=A0=C2=A0 storage still on request. An exporter whose storage never=
 moves
> implements
> + *=C2=A0=C2=A0 neither, and dma_buf_pin() then succeeds on its own. An
> exporter which
> + *=C2=A0=C2=A0 refuses to be pinned implements &dma_buf_ops.pin and fail=
s it.
> + * - Importer: nothing more. The mapping stays valid until it
> unmaps.
> + *
> + * Revoked flow:
> + *
> + * - Exporter: answer dma_buf_pin() as above. Call
> + *=C2=A0=C2=A0 dma_buf_invalidate_mappings() when the storage goes away =
and
> fail
> + *=C2=A0=C2=A0 &dma_buf_ops.map_dma_buf while it is gone. The two waits =
which
> complete a
> + *=C2=A0=C2=A0 revocation are described in dma_buf_invalidate_mappings()=
.
> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap
> within
> + *=C2=A0=C2=A0 bounded time and drop the pin.
> + *
> + * Movable flow:
> + *
> + * - Exporter: call dma_buf_invalidate_mappings() before each move,
> then wait
> + *=C2=A0=C2=A0 for the &dma_buf.resv fences. &dma_buf_ops.pin and
> &dma_buf_ops.unpin play
> + *=C2=A0=C2=A0 no part here.
> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings
> drops the
> + *=C2=A0=C2=A0 cached mapping and has to lead to dma_buf_unmap_attachmen=
t()
> within
> + *=C2=A0=C2=A0 bounded time.

Hear I would want to see the exporter being allowed to force unmap the
dma mappings and reclaim thestorage when the fences mentioned above
have signaled, but the importer has not yet called
dma_buf_unmap_attachment(). That would allow importers to call
dma_buf_unmap_attachment() lazily, just before the next map_attachment,
which would allow simplifying importer implementations. More of a
related idea than something that needs fixing for this patch.

>  It need not stop the hardware, because access runs until the
> + *=C2=A0=C2=A0 importer's &dma_buf.resv fences retire. Map again before =
the
> next DMA.

A successful map will mean the exporter has placed the data in storage
compatible with what was agreed during attachment?

Thanks,
Thomas

