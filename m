Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9E33C192;
	Wed,  2 Sep 2026 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330964; cv=none; b=T5NBXbsmtEFNF47UquYxarV1/f4s6Vb0rIRVDWvV6ymFQPL6APawGwq5YRa6I2g/mrkmnAmQ9apV4/5rhMeWzt42lv0vr9ZNu5sSVzOOE8Lg1NRAseNUfsEram65L5bPqA6DFUlo6EwCGzv1jKyoZ4lsretdoJmMB/RZNT1zCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330964; c=relaxed/simple;
	bh=566/xxON/tjlrFQDOExL6nlhTXAQP3+qJzDw+BbIsBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPaulxKtopFzi6iriDDogWCNNz1eBtnK9MCAzUc4ZNX+UTTjOA/7orukuRcu/T7rgWPU0+Oi4FcEaqr0dLlCNtR0h1b+CotzMwIlGOr0am+5kfHg8B34T1v29sZi6sj3JPLUnob5L8MdrZClgW+26XsIdvx57xYA2+xpd3kdGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5+Ob6cI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5+Ob6cI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DE51F000E9;
	Wed,  2 Sep 2026 06:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330962;
	bh=566/xxON/tjlrFQDOExL6nlhTXAQP3+qJzDw+BbIsBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5+Ob6cIjs/ltFq8+kKjP9+H1UqxNC2sfSVtLMiWwGY0Anrvd7/Yc0vLA4OqSoaWm
	 Es4PnjTPuL1j+3BkDAN/xTh2aJiIYcapIy5HekcM1a4uNu7VBeJpDTivJtQy7ss68s
	 D9QrnMgKfhArSCOe71YTChoAcub3K+JJnKlE/6xLWczaR/5YDV+YVVR1Ow3BAziVoV
	 GVYVH907QGsP4AP2JMc2dLWw5/B917+bwvuQD9blZ5ONQFnNqmwbyWujuZddPZZ8WH
	 XCMoBY5A3xV2ZXAGujdKyXTlxyllf+hvCUWVLXWKIPa3TLDxyvjzFFQ2rhfpxc2MCT
	 qO5cC6X+ctxPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260902062153.31048-2-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:36:01 +0000
Message-Id: <20260902063602.27DE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
> desc_ring[] entry without clearing the pointers afterward. If
> switchtec_dma_alloc_chan_resources() fails partway through and calls
> it during unwind, then a later retry of alloc_chan_resources() fails
> in switchtec_dma_alloc_desc() before reallocating one of those
> pointers, its own failure path calls switchtec_dma_free_desc() again
> and frees the same, already-freed pointers a second time.
>=20
> NULL out each pointer as it's freed so a subsequent call is a no-op
> for anything already released.
>=20
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initia=
lization and cleanup")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D1

