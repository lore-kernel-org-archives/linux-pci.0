Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352437;
	b=NDZZKLOJCLg6Il8rqwmpt0bW43Ry8mHS7eKHiKF36dpYBA5f24jMYI+uj9qZIkmh+p7N
	 hj2QE/J+ePqkmY3n1ibSYeSduUiU/FfZ72brY/VgUmBdUpo5X1Brx1qkt/wZKNIw6Jx4p
	 U5pu4wxPw7hhxOD+py2GfRDTmhfittyHhI0u+9N0EGd7CLZQ6mZd0//ltnQRf4dPWlvtk
	 K1wdILtcYXiOw54hrJjOLzbUosfgJzm7YUoF5lDA+fYuvuwtRsoNMHm8N6EzjbEt/0pCl
	 o6aqByW8nH5M/RM//GRuTwRcKmqgp0NyyDZs/rV3q44a+m0PcWKBAmOmTZsIQim/g0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Q0Lu5WcpUQSDUTg6hCd8cCVZd12e/4a+J134Nni5PA=;
	b=DAcWtLcBIDizOfAFcAz4QJ0h3NBUBZTAAWKj0U21MPa5v7LExQx/zZ/hX0daYHTZ1i7s
	 EC/UwpbseOfC5xh2ESykjSHns+mS5L/kX7L3955qTTG+N0LgeXDZWm/ZTif8SuETXytoa
	 v/r7yXHXl28UpFwnqixQBRLqGSJITUfPjjdhxIi7fDKZf54q7UZzh7SMgBZZdcVdrcGmK
	 kV2FaqV8xHHsFDUysD4Wf6qe0NMFeisdAEYi+CvvdNNjwl8fcAv/ZOjoEA62UVX6QJesW
	 FycdunuxTABKpBLLxTv/v91IILII2B3TN2CIc82Vi0eEiRQ0yoMXuYrdndNk6qlTOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ4spVGE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A5606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZ4spVGE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9441F0093C;
	Tue, 10 Nov 2026 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352436;
	bh=7Q0Lu5WcpUQSDUTg6hCd8cCVZd12e/4a+J134Nni5PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZ4spVGEqV4SrFPmcMpk9ESlrIcUyreAYRO45LA0dQ6TaDS4jgncBZ2fMDBm4sW52
	 b5/U/JkAdNXg5S2Xc3RxaGiyP0GMXRj3XSbQ1Rl1EKdfYAc9hXqPpSKkJ27ytWNjeD
	 1hscuje964KaRsd3gOIpPZMUEaUgcLYT3PN30QSFumSKZRCeTQOVBvgDC31Jcq7rP5
	 5/lCAcNw1Mb4VxnXSApabdhjcmzgUe1w/zuc3bbQ5sjAwXX9F6IB1ZB2pFOpNcNqwI
	 mgTx8Lq1eNM0SQ80Rfj6/fEOKDwQjqPWlymQYj89UXhExr5SxuIbbc/W0IDVgt0drO
	 pSzZhOoPwnzuQ==
Message-ID: <sashiko-outbox-207869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Convert HiSilicon STB PCI host to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109195206.913231-1-robh@kernel.org>
References: <20261109195206.913231-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:13:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the HiSilicon STB PCI host to DT schema format.
>=20
> As this binding uses additional vendor specific resource names, the
> common dw-pcie schema has to be updated with the additions. It's not
> exactly clear what the clock and reset names match up to, so it's a best
> guess.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109195206.9132=
31-1-robh@kernel.org?part=3D1

