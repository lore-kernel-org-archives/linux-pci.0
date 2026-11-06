Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984252;
	b=U3ljUtr/fxIFZajie0TFYN91P3a2v0BuOK3lZCxrEh/NGw/EOshKpmZvI6qVRMAkRBs3
	 hvTzIsOPP60MtMqFFOEPruqzRPwlhModU1faggAbfddiZIypGxyRuJbpMWxSGsS9n/fac
	 yC2HjFAWeQjsFdXNH8ucsSYDmmZtKBYfdMx86sAHBAtaZ36PS97Qw/IJ8J28fcdD7Xict
	 hS55PWNN0ILAiQFEjvDdPehuZnHnpvuBpOpxwWevJiIoyoOxe4OkwYLT17i3P4Pg5J++F
	 ITHTyvoyXzXCGg7KEesMdqSK73VfBbl7BOpB0BDUkAZuS94COdSlLvfle9sNl1b7mEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kk8FIBuRLnrS5ZLztr75ukxTWA3FBD5MApyyZ/V0aNk=;
	b=oWtC1hfiFV992Vvws1Vt80lUUdThmkEtErMYNh2bGHCt8sK6oddzpNS6PXfPSX+j9XK+
	 WlSD00Uj9fqkGH0UO5LUtA1u4J9gEWBkoDo3rHxgVcfXCy+KayQfxUU9b+6cPjl3JsDtg
	 yjJWIxweprb1o/yhG3hGAb/2603Dwcp4GvbKPu9EmwruCOgZlqIUnIBK9k5C20gVjxpNU
	 K3LMGHNDomp+hVOphPRnVhPlAyT4X62I0cG27J1MMsqbclluB1MXChDqiZR82MecpFqBV
	 Jij5xOxK3+XcpAA5YJ8DTA6ShySpF5FiILIwPalquWAkI+vGD2bNn4J37MGEqXgqjnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X3/7Wp4h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3/7Wp4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4307E1F008A4;
	Fri,  6 Nov 2026 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984251;
	bh=Kk8FIBuRLnrS5ZLztr75ukxTWA3FBD5MApyyZ/V0aNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3/7Wp4hOpcs0AXuemql9oNT6t8mpcEVnHxDDgrOB5JMweoOoYcj1PlrY62DdqqqX
	 OxKGeuYkg3rbnmWjoof2rwCrzmkCiZZFWc5mxyqQOwuZz9n754p38tPctFDTgv31jw
	 keIE+QvNvzk6zYuaWoe/SeORpBzlVAuDbqEBhdG5yDNw/AwST7OmwcDjk+AFRJur2e
	 pg4DUgfxn3swSixD3sl45m+lvhpcQXNUmglb6CYSev5gS26oaEbEueUuK7P50bdwYr
	 4LEWuhE7MRlsLwMJtxlmTHwNzK3tjhhvZK3uXMHXluVinw1azhrjsdrZvYSo54AasW
	 H7izv+38Km0iw==
Message-ID: <sashiko-outbox-201876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/7] PCI: vmd: Convert bus, busn_start and sysdata
 to an array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-7-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-7-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:57:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert bus, busn_start and sysdata in vmd_dev struct from scalar
> to an array to support multiple VMD buses in the future.
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D6

