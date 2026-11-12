Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444241;
	b=eCIt+l++5F4F29oDkivYE1JnuSUIQaA29c35CKcWmurJ2fjOg0HTjK9EqgIkoR8YXVa4
	 xIb5TzUWD/eBd2hnFg7RPKHQpCNdcqJWjEOoY4XjMDN9jlCdU3VhKHfvaoo1R8db0uNv6
	 6RcPceVUH8JndIPdk4XilTPHqpZkF1a/yXYY7dYdhn+PqQc9r49+R0CdzqQRuReE/wvqj
	 WXHUlmiyyaIWtB/JEHW2zMdqHbaj0BjatFpg46QJS0uaGMIW/jtqdP7rsqXzoU/o2tL3K
	 ELjHjBXHoGUvlfm454GRC18khTpnnAeOp9Ikd6oOPeAFkdyjRoWY/zOEiCQ3Yv2w6Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444241;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lKyy0YeUB4l7r6rdgGShI84vbcAjIc+AIxEnu9KXysQ=;
	b=3N73sKqZ+zWcla5xywN6hbxH/wJh+pdhQyVIb2541GfUdyVyX2oZ2MZJEc7f+7GcnWB/
	 T/2M8XLOIRs4ghM8pd42COcVrOoChCMUaHpYdVtHwItQcm0G6CldPWwSXbJJfHJMF53zo
	 UayLuSUmHLpXPEcdvqv0m6xqPJs0dm9k5KdVH3/qUQXTApYRe6bVP1HBt/a6/D/wAxJB8
	 XSf///7RIMwmm3PfsVeQspOB1kHc56CCGPxSpVXJTJZFUlbU/9EZcQF2WsUGu61gr4ZcI
	 DI7E7vGz+uMVKr45qDDgz4ddHtwXpVwiPg07ljNLNstBCTH1FwntjmQ9EYoVoFmqB3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtCtMf1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA7606A327
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtCtMf1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88521F00A06;
	Thu, 12 Nov 2026 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444241;
	bh=lKyy0YeUB4l7r6rdgGShI84vbcAjIc+AIxEnu9KXysQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtCtMf1Xoy08wunkrXUrqAhaqvcxSE6RYyNVW4G3/NgJlK27DbMEw82XlnnDhrIVA
	 GUWGB8BkRmj8E4Yg3eHFx0ga7CLxTHltwKvBRYOEwZKBnpAUY2YSPs0/lWsR8xYiW+
	 ZpRdZns2Sk6hVDJE/gThmw2OkuqF2cbpHJ/fBYQagh0Uu1/fGultsIvtijSS2muXaZ
	 8E4O+ziGezP1181w0HNWA5N5wCWzOQHCweciSPlrh9cm/pbyXKrIRBNjdYGuhX9V+B
	 moSIH3zzMCm/QB0W1kwbtuejx4jMxnpZjQC9rEtmmrKEn/R9geBeRAND0TyTHrgQ5F
	 VIYN5YqgjQ1gQ==
Message-ID: <sashiko-outbox-209978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Add ID@path device format for pci= parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cressey" <ben@cressey.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
References: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:44:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The <pci_dev> grammar shared by pci=3Dresource_alignment=3D,
> pci=3Ddisable_acs_redir=3D and pci=3Dconfig_acs=3D names a device either =
by
> address, with an optional path, or by ID. When one command line serves
> more than one platform, neither form limits an entry to the intended
> device: an address applies to whatever occupies it on each platform, and
> an ID applies to every instance, such as all Downstream Ports of a
> switch rather than the one that needs different ACS settings.
>=20
> Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
> <path> is the address format, and match only when both halves match. An
> entry written for one platform is then inert on another where that
> address holds a different device. For example,
>=20
>   pci=3Dconfig_acs=3Dxx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0
>=20
> configures ACS on the Downstream Port at that path only if it is a
> PEX 8749 port.
>=20
> The path goes last since pci_dev_str_match_path() consumes up to the
> next ';'. The IDs are compared first, and the path is parsed only for a
> device that matches them. The <order>@ and <flags>@ prefixes of
> resource_alignment and config_acs are stripped before
> pci_dev_str_match() is called, so the callers are unchanged.
>=20
> Suggested-by: Wei Wang <wei.w.wang@hotmail.com>
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-pci-idpath=
-selector-v2-1-83ea668e38f0@cressey.dev?part=3D1

