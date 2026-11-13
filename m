Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576810;
	b=o0F6xTIO9+ZuL87khQGBUuIftJk0t0ko/QaBLXL5ZLfBCb1rumZubYahoXz/IdMiMKz0
	 LpqrPisp7cW25hnHi2x/ULQG+VFKCil9R/fSuYPP7/dr4U+WVwatBmafhto5FZzzT3MiI
	 MvIe9OWl8NFuZHrB7khYBZFYlrgfM6A9xEFmXk0r9o6POzC+oiLxhlrs5t1X+7GdW+2O2
	 w2sTFFKE6Iu2T3QnQuRXJuJU9NiX3zOiKZf91KZ++eue6i7icCxipmt42zZxrlJpKC6Qg
	 kl9sOabBf38BM97VySntKrCPADnVqTg8J3AUhRjwJHibUhFeh/FYbAApHR8mIEAUZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oc3sBRH99fUYkqtV1J306SbmDsThughoPPEnSsnJsPA=;
	b=HxSCVaelwEP8fwEv2wkQ4XrBCBw53D90cwzaJlNOv2WIevXUY4JSPz2Dolvat7In7uj3
	 NQyxyOvXEn/skfXEXlbsoIuyjF8jwf3WqRKFacHBNhLCSyHGLnIttPPt3IPYgyN7Tlqvv
	 rI+2FpzNRpF/YB4YOzaSWp5xrQQzDMJ0sDwikCgMeYGSZ0eQ5Jx/5LT30sYp1uyrJSgRJ
	 V211aBW+V6YESdsMc27LVx93KBvcWz90rJW1jBkxUekr5mRTsxl/fi4NqdpDfBDiSkVxT
	 RDTx6/CXCG3TJOE4fGaDNtrPfvL+buAymh2lCd56UPedtFn8WvmcSWs6T7b3LvrmpLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K/OOZC2f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE56606A89D
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/OOZC2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB51F000C4;
	Fri, 13 Nov 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576810;
	bh=Oc3sBRH99fUYkqtV1J306SbmDsThughoPPEnSsnJsPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/OOZC2f4rwbFNcye6isWGtWU4fODUdUnREAxVgKXQ6vWIko/+QVDOVF2ac8KdbxA
	 hY8wAW5ZE6YhLCwP/Z+AoeLeZybpN6r95G/xCIWAoxLVPRM/VVPxj1YZpovpysBIbh
	 rfSdnGPgUG+fJ9dKWJOHu4NESrqNNFYUJ8AEAGdGF0Apno2Hyp3FgzYnTdnazhBZBz
	 D6h6PFBRsU1ziiyVh3oSyDc4rEoNI+f+tl97p1zyv03GthRx06b/Td8hFsStR+Hc9t
	 pVMegCAer8ir4HFzjKTQgxkaitFIZ9Y8+0OgSVr7HupOJXaCRQu/jCJoaM9carLGxw
	 9wymzVYpdjtcg==
Message-ID: <sashiko-outbox-212891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/10] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-4-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:33:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D3

