Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804702;
	b=BO00MKd/HAy6uWS0T7NEvYcz8XQRh0RmesY307UMfxEvbmKU2awAkX1es2Q2EkYKYtO7
	 7Ut/y9p2QJTbHxsO6JoYDpVLlcTn0nBgOB8qJ7VQv6hGnroxeRpggti89Ig0EyFgFOyX+
	 FVNBPsQIfFIEm0TDUbgcivexp2VO7e0leeTesGJKkp9SUxAzAiLYZ/ikf+19SRh7KbFj2
	 c3d+f6iYDc0bCH8VTrspx2LMgK5/QthmI7ZHF+7qnuxY6U06VVxGM7rgVjz9jqo5fUVaP
	 TQ3IRHk6rx91YpHSUGJ9cOhjEI1Q7O9ElHWzObEXZ9kJK6pxZ3vlPvSATmfMybpAQAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qWFaQEiJmVaF8pzq18OqAEa7TCQxIafwUVNev7Z24g0=;
	b=NrZeD6NjWmljy+QnO1yxMDvyCaJ9Dd6WLpd/Z+tuBI5poTFTLqrve2oi/5IlagHlQnsJ
	 ZQiRynhfJIMlpcd75Y73LvuJeF+YQZFRfkHuYcaYNQaHRW/ZA6mgivcs4uAjmuh8capgZ
	 bD6E3ofp/Rs6wEpTbxNivyf2vmyeUJ4utiz8OElh7ouIMFujRSd5ZZnO5/orZsQbAK7ap
	 H1Py6eP7oxVb8YxW8k1Zyzha5qfdSJG+xi/ri2BMBCAxwff3AsOt7VErJKuaoMMthMqav
	 pJmsVmn3Sy9UM9hQyAGnmSEyvQCmjLDIzxm78hd5tGiBSpmi8TnRLkN1hk8eYfirMvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq1Ej6wE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A20606EE85
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq1Ej6wE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440461F00A18;
	Wed,  4 Nov 2026 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804701;
	bh=qWFaQEiJmVaF8pzq18OqAEa7TCQxIafwUVNev7Z24g0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fq1Ej6wE0GtWT6NY5Bc1RagXgIryylUx/YXFBw9jXgAHkbswB3l7FNy05PBwokbu3
	 xZtvvsjj7mHGGeK5pLTL7mWz7UNMEY+x+fcJGodrbooXb2EUHOmigoHrB5Oqaei41X
	 GPjAC0GvJM4AmWnnhfYiZ+WkYORDPzX4wknjFh4//ROoPJ+4PDnr5ZP0pHTzWaMrq/
	 i2suSVfrYwNH+/iU+GMe0DiQwEkzPEwsnUfEqvpFjVOFPDeRYUzhtK1C1ixJ2JNkRn
	 awxFw08BlQv7cSqI3vyT0GEnYSxEt/iFbJoRDhc6IxbJ5zmobaN7HwyGapocKkVXcQ
	 +XjKz7HW5BgSw==
Message-ID: <sashiko-outbox-197482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com, =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJT?=
 =?utf-8?b?WVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
References: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:05:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
>=20
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104150202.3224=
971-1-Frank.Li@oss.nxp.com?part=3D1

