Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618996;
	b=yAc2zpHFfutPWEBbskQOsddnCtZ828xiJKwLL0fE5PZAO6Qy8ryMi6Rn3ZfxqecgIWk4
	 vuyKs1OFBBy+gDrR29nlo8EMcK7xg4URgl+ENTfG1M6PwoVTnE2IB8OHGHWq/4K0CRY7e
	 kBaYyDLR7CVYvAaryCYGy+zO4Xejpegl7YfyXJrM9JXvZno4vjxDHojqU6qtia2Rh/Ko1
	 80QgVhNR2OiFEsUHEwTVxU5smGQWuFsv5EvzJ4w9TFeFHrW08D4H7RMuGs3Q1XFvUqzwF
	 TpZmeqFbEFO1KZ0ity0doVZv2a6Lh7DHVLEhUHHEYrnIo/FP2vqgQx8qyZrtuvJnrqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pvZd9P752EZ6rK3tHnVUjvAQ0WnSS30B6o6nsqXx1y8=;
	b=4ZXjmrQ9JyLC/mxXjR65o93Nu6cUuQTzznkajuFGSZ6ZCt2DhVOehoiVgmBfw001hQ/7
	 j2Bs5d5z5OorB45R4Jfp0lr5vDm/LafyHtEKQ7ymPiqQNUDWRiXHz7PM+VuDsx9CbVfW6
	 4439b/lP4Ig4gsIHAzgxUJML9+55IotPeJpqmQNTGEd2lg+K8fKwFy7Xz5zAjT2RwTiwq
	 A0hXkoeYOCwg63YRbMxLJcVR/YzTpedgw7YjY713fz9Bdu4DJbFCNv67S5GXB49udSHDu
	 4STus1e05AXpHFKvFYwqGtC9FL/OMZwOZ+gd3QyO3xlV0tauiGLz+IKZzijEahEMtaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZN1i72D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDA606A337
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZN1i72D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728401F000C4;
	Sat, 14 Nov 2026 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618995;
	bh=pvZd9P752EZ6rK3tHnVUjvAQ0WnSS30B6o6nsqXx1y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZN1i72DIGcwFUZN983HdmAJvQKFecV39KQQ6XxWG2ALT5csy/5j5vBuNjTMEA7C+
	 4Y747y0W+vMIWu/O70hcx/6jMZvkXWaB0fD85vm/Wcco36IpQsryPPnK8jt8RhnOFV
	 tEWv+Xd2tFjVhQGCbwm3RJ/dd3bbfCvQA8u23eJYKuMwSO7drUXM7LBX987kXPncPs
	 3Ct8sQicDD1mmGlLexyKkRWZOPyR0VV/1oHB1DpAUEIrCfoKjGCun3MLRBvhOewC4x
	 fs4JbrclEOgStXhaanOmy0/jZ7c1drpdd9GOkFlw/lnqoKmTD8id+bKZ60oE5I1OTd
	 tWAu0aBHH7jnw==
Message-ID: <sashiko-outbox-213997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-monaco_ep-v3-2-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-2-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:16:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
> PCIe Endpoint controller and uses the same programming model. Document
> the QCS8300 compatible string and its fallback to the SA8775P
> compatible.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D2

