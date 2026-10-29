Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254369;
	b=uZErO5ounXQzh9hAlSqe9qu4Ou3onmPN5LDki67psSq3cBVP4xKFAnos1tOQlSC5PwXL
	 a07iGeooLDCiS54WN9YqdzXX5fvgLjpi3jzWsEM7JDUeNpgi0h2IiMfJeYZ8MzZykGhgq
	 pw7o9oo13cvEzoGL6X0ToQeim9/ZXS+0GBS2VuwuZi+dRJFTOrJJEvLdMrZeak5caNUjP
	 MKWGzF1EYWkPEckg3DtPFJ2fGt4Ye1SN/9QsA619CVG0VL+PY5Dil1y1RvVyUPr6pU+hG
	 X6WxvMeoyl+ZA24PWlYEIXq/e8v42Oa/X/M9bYADiTdvTiQTj4qSv9LCKKvucHjNiGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Z9Fsj+PujM4+NiWbLcOio8XZQT71MLmyB+7AgRGeCs=;
	b=zvL3e7lTyaGbAyfsekDo1QzMcEtgG+l43g7FmXMQCf8eIGCkPcrHYK3Mga+aodEXgJ0h
	 UGJ9KoZfoop8V5O8nNSbq1rACl2MEtYQHwxn63QOTtsNpZ+bBn68ZRIzg3eXXUBxTbdC+
	 zdHNqJ+lDRLM7ScPfP+Wao70f1ASuz5Kqf30fFO2d5dradv4AJh0G1WQ3m23ywh8VlOPh
	 QXQRehSr/5CwWMl5nAyc43+W9W9seYMtUSE8DQ6XOO37eh3vYUIsGECIlUm02hSptCH3P
	 wxk31vPdVFu44AEPOdZbd4lN31khRBrfLXHlQVB12ymO4uZMY0wjVdBrC650x9v0xBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anYb9Xfq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885E606A31D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anYb9Xfq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF01F01825;
	Thu, 29 Oct 2026 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254368;
	bh=6Z9Fsj+PujM4+NiWbLcOio8XZQT71MLmyB+7AgRGeCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anYb9Xfql5jaF+PmHTp69OYpV2m27FN040uicAmN9FM75CFAlg3z4x41/IzFjOaIj
	 5xnYjYvOrAEkhe8WS5PL1VRnORKGJZcDQlTg2KfQgFkf1LyF2u7LOk7ah8oGsjpI/D
	 HFL+6xP8taLH87VyOI/Gx7zH/XKKOyzg9tr05WAUtUi7wLsG1t+fPF6kkAQsFteXAs
	 k6B4xirCXoP689frM+G7w4r88nwyc27GzWBvaZ/iz3eWoyCjeeFYTtTdCssAE7xKBZ
	 aBlBQLt4crtZRbwJ/Yps/dkagmx/na0vFi4jGXE+5zmlwVvjEHrPwXL+w7AxtaBbqU
	 sgm1Dck82hjmA==
Message-ID: <sashiko-outbox-188796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-nord-v5-1-1a13c214e89d@oss.qualcomm.com>
References: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
 <20261029-nord-v5-1-1a13c214e89d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:12:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
> controller binding.
>=20
> The Nord PCIe controller is compatible with the SA8775P PCIe
> controller implementation and reuses the same binding definition.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-nord-v5-0-=
1a13c214e89d@oss.qualcomm.com?part=3D1

