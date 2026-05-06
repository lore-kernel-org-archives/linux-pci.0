Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A366831
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106992; cv=none; b=TOKlsW9ZGCQFe1cgAPjzf+CC4fd+V2pfeqRaspSzOBRrAJV/VRT4aOFZzoqTUgGj4KuwiXlvZkoxu0SgxX9Z4SV74pzeOPUj1nWiHmYc/0/K+/hDPbuKWbph+Q4uy2rE4LQGm/0e0GfRKOeHRgnEovxyyFuD0e1EAjGeqWGhOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106992; c=relaxed/simple;
	bh=EOWSsOJOGzYHMAIoasqQECFNklk4yclhtnH4hXexJaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAwFSMxi90pB4gMZY52wObIGZXjULwwYjeEhuadvhfiJGMXNBvSsntyfYqIJ+FH+wEoROjp3BKCPnZ0ihRArurRj1rJSN9PY5gw39M9W2y7r6EfJ9gYIZ/RCqAR+TcYYOf7MHwKxNXXNBEHSo5qY9PwyqxPyt52GVJCTAAcrWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcDFVNGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcDFVNGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3515EC2BCB0;
	Wed,  6 May 2026 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106992;
	bh=EOWSsOJOGzYHMAIoasqQECFNklk4yclhtnH4hXexJaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QcDFVNGV6yWXpUo3O1uw+viL05zsMzMRT3s9xsUSONfD4YOSpdjnQyps3xTRo1lbD
	 PA4Gh23gzQPX1uP8xt1XRPukwTjakn630nx8HsqsW48MyF36ebLN0j6U7Zo/uchZ1z
	 PJZ0ucsAgO0dt3I/R8Cc1zxBvXd0qX0Ug0PAZPO5mjPXxPPvwWk2eiUvfa3aPcI+dS
	 /to0R3bdZMLc1wojgLnlyA50aBw6weKy05OrH5iwwnmmljagIyZzateH0HaKHD1vcu
	 Ob/SMT8M+SrdXM16eto03+v1o6wZaOcfqH9p5Q4ft5LHlICKdiXDflWnJY5Fka7ayT
	 vwxPFcnsz+AYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:36:31 +0000
Message-Id: <20260506223632.3515EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Ignored return value of dw_edma_device_config() causes transfer to=
 proceed with rejected configuration.
- [High] Data races and violation of atomic configuration due to lockless g=
lobal state mutation in dw_edma_device_prep_config_sg().
--

commit c3c3192e70e9eff9723db89a8944f9898577a1fd
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index f7f58b0010e26..ec6f6b1e48256 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan,=
 struct scatterlist *sgl,
>  	if (config)
>  		dw_edma_device_config(dchan, config);

Is it safe to ignore the return value of dw_edma_device_config() here?

If dw_edma_device_config() fails, for example by returning -EINVAL due to a
peripheral_size mismatch, the code will still call dw_edma_device_transfer()
with the rejected config.=20

Since dw_edma_device_config() sets chan->non_ll =3D false before validating=
 the
peripheral config, a failed call might also leave the channel in an
inconsistent state.

Should this check the return value and return NULL on failure?

Additionally, the commit message mentions this change is to support atomic
configuration. When device_prep_config_sg() is implemented, the dmaengine
core deliberately bypasses chan->lock via dmaengine_prep_config_sg_safe(),
expecting the callback to be re-entrant and thread-safe.

However, dw_edma_device_config() modifies global channel state:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_config() {
    ...
    chan->non_ll =3D false;
    ...
    memcpy(&chan->config, config, sizeof(*config));
    chan->configured =3D true;
    ...
}

If multiple threads prepare descriptors on the same channel concurrently,
won't they data race on these fields?=20

Furthermore, dw_edma_device_transfer() still reads the mutated chan->non_ll
to determine bursts_max. Does this break the re-entrancy promised by the sa=
fe
API, potentially leading to incorrectly programmed hardware descriptors?

> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, =
config));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D5
