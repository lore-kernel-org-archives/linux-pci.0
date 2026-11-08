Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148176;
	b=IxjcZf3apDe4TMF6af9YIBK5PS4Of59nl3qDfIYWW2XxgyA++Siz7WbHbxt/aFa7SkJl
	 o4a8wMs6bXJQzmH+5B6JZM/7Zhm/r8Mg2fca8p6s+6Al3W4gsJAn0lkv4+g6XvD6ewVRQ
	 4wnQrXBg/9Uup0Nk6lQgCQNJ8fTbNEMl7/dj/03oRtSXRQg7NgZwN7gd+OmPPhrQHIvXa
	 ocuI3QlK5751IAvvu+zFdH9QoZTboUTTjQKDgeXDu/1T24bBwQaVHN8aAIpNL1fwI4iF+
	 7wucAYaJS4F+IO9H7+dn5+NIiHNIWKtNezr8n958wHAYQwDxJrLtYAjjDt4VYnxmCDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ILLrAl+2aYtS7exjPNHsKhe7m+b2eUcYoF/THiX3nRI=;
	b=T4uuzLsOA4AIxTiU3RZDy+3ccYCaWce1oFRX8vEXMn2w4ouM6mHHfeQ8vW8PSF/pHOs9
	 EUS/g+ZF/xhYaCaj9LFxTgCok1l4KrryyyJltU1i2jdVGuIextPFuYGBhA/bwKG7RO5Vx
	 WMxSx+HLp3MW/ywHdUqL21WPbHf8Dy/Lwj0NDfr88vYSgeexIEHSQ4zJkCrzhALUU1cTi
	 dJ4n3Im7A1wUS79HINpFdreowr89RZC5BcAOTYo9IhEXA1EMEbftjM4i7k2yzcsDMVuc4
	 9UX2r2+nPlo0CAa62HVc5B9Z12h7VCYxmz4l0PR2aMngiW6CUm0WFOhR38CK7mmUEMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSGjUpNR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3E606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSGjUpNR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4861F008A1;
	Sun,  8 Nov 2026 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148176;
	bh=ILLrAl+2aYtS7exjPNHsKhe7m+b2eUcYoF/THiX3nRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSGjUpNRp68qvONmt7MfTVgcLb5PhkBKjQo87Pk1rIzTeoHoFgth77UY810Zu6NPI
	 G2GSt98LoSFInPkqvXaOeCUAbYC6zeIua/o0pAbOLjo5vpmtBovIcyZlvOWi+6ugnH
	 vX7ySo4zlYkdLkzpbjzO8OodLRpmgAMBRM9RgJJ5IK4yq9d/C3bc8h7GI7aVfsDhZ+
	 HT7pb3LCI7OKpwoDeJTguHqp5PZTvVgBfjdv2TWfHOjRYN/bhTMxshXZVbapZD0jIq
	 SY4MPjs0ciLhXWWuGuVz4tN//4lOCE3IMacQPgs1sZvzsJubTniCZlM72h5u6xtK4L
	 grhnM0YYafWcw==
Message-ID: <sashiko-outbox-203804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: PCI: apple,pcie: Add M3 generation
 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:29:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
> compatible with the one on M2 Pro and Max. Add their per SoC compatibles
> "apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
> "apple,t6031-pcie" (M3 Max/Ultra) to the bindings.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D2

