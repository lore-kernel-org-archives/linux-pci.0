Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657659;
	b=smEuoU6p0d0OT6Qdldup5syL5eziiag4dcOXv8uKJzjgiJRxUqd5kHZVzWOsGrLCxHHa
	 mNJAd0w+nOwu+vHHjzSzCi8Nh6Q9mLRGsm9y52Klnf6v2KasoAr1FX7ugUhHI+XuB4sgr
	 4FoQS6vrK8eJgtAaoCeYGJEX5nmPlL/hfLSa8Xjsk8N0avkHavWkDSV2ZsKD1VuZeepVP
	 TV1XE0xiRfe+8HMqrqTCBD9Au2RRaEKHEsDkU3jyvvaSAO3NYqhrToom/d3k+JLEjbalX
	 pEWxkUhnQ26sUMCAvmyEHVWG/SviagLODTZQIJT5HbWvUZnvqmm5W5Hu5g+UvCfRpTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y/R/6AN1CJecbx78rw3M4AOnqGYIN+q5k5A43G2cgao=;
	b=hbqs/X+5+Xsxzizkiav/xmvxs3LKMYge81bIaPY2tT0jwqpw2L9ApmWAE5VGUilR9keU
	 FzrUkCKBg+qVUvUbHkx3VlIf4IXdT9ZpI0FnHpYUmDsXKoaqzeI1n/LkP3OBiPLi/oOAw
	 auET+hbFqP7leHOhmMgqbTG8MhNL/rbCvFWM04OG8RtYdaDtFfQpY4YBNC4PAOggllvxW
	 yahun/xmJ6FOsPKea8BKIgpitEOXYLjk2AhrlALx+92Q77AUgcG4E+xZm3tJRwpWxWeQE
	 CEI3daIDr3QIQMkm91vKVOvo/5K6XaI1YgK+rY2mRV0IQcqvTX6WeLRpHr3alcXavDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMXfdG9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA78606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMXfdG9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5124B1F000C1;
	Thu, 22 Oct 2026 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657658;
	bh=y/R/6AN1CJecbx78rw3M4AOnqGYIN+q5k5A43G2cgao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMXfdG9q5GqGlbKIA9n9Qe7fgIHhneuL0k7NgDyCk1nrGe6NA5XtmXm38rkB9Dtot
	 T/f//p/NECRlEYkACo/NFUW7L6h+VLCo24YjXH9pGIHVnlItNJ3zQxAfOahAK3frdt
	 riuDGdhe1WwfKIS5LM9RJKBdVSTY1Ro99WQV+u64K1TOEOjhq5axGPTxaUzkzd5QW4
	 aTzfj3lBuXTH3rhxfgHNN/4pmVIlUZ2HzXp/tWAS9zR+8R0lLFwmJWmuKkI42fG3HG
	 IN3u1VHWt4naZHxCoFH+Qwbu9blDOukxrws5Mn/EBQXzQuwcdqcZtkGQUSxHCFwr6O
	 Yt+4XAr6cvs/w==
Message-ID: <sashiko-outbox-181168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/10] Documentation: PCI: endpoint: Document vNTB
 DMA export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-8-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:27:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Document the dma_bar attribute and the requirements for exporting
> endpoint DMA channels. Also document how the selected BAR may be shared
> with an MW.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D7

