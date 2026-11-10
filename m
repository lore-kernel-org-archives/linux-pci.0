Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299616;
	b=DqBGrkFQ6DscNn6zYU/hpuosqxxKZXwir+bLRPQwXw4flD0IU1F+6OpZ4vjNpuCVF6YN
	 104Q9AzNv2axffChkQFQk/JoDTqururAarCtIvw3HM29Wpq0W4/yCiqVnrqBz/uDUrjDO
	 xVkbFeiimrrqAuZliPyKvz25aY/7qI9Mq16W+dQdgvlvjgTAa3Q6DiSL3ssxLl4m8+2qu
	 7WFMohYUsu0dIC5B3Uj5Ptc4pYzciePT0EqYWxsh8C6zrjA8unbEcPtwgOBPv89KhIN8N
	 4ORBzzXQxD2slNzhmp0slvifLx7EM1J97lUE3mbzp+otYauzKtG3sBxpzoCK31j4yYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299616;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qjabxaaxPFPju1mQp7DJd32/BoRE8s0baVMcxrIyNGE=;
	b=a1xOkfkqLlaySiEwLv7Taj7jBQUNkp1bXaSHnpOEm1GABfGdNOFJHVjQvpsNNJC7Gklr
	 wbDeS47fF0GMd7nCBkJEc2iBV6OoyTPou13q+OR0Rlmbqd38ouNhjfetgT0nIhZbPJ/4z
	 jV4+KCtCwnupxSEntb8uKRhfKVeAafLxuglj0/gzftP+HpHyBGOs9WBiiQFLANNL4A5pb
	 R5qg+/JmMX+Md1rSoVScuC+xZ3DeBJgLj25sv4lAcPby3o/BlPawlFGCl2uDDC6Q31Ytd
	 04l0jFEN2QwL1R6P5pHcC80dc6YPT29kzRDi5E8LH6evxxYoy3wkUD5psXw7jukoXUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqlRkG+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF07606A33F
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GqlRkG+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19301F008A1;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299616;
	bh=qjabxaaxPFPju1mQp7DJd32/BoRE8s0baVMcxrIyNGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqlRkG+EJSYB0xctsFO1lW79ayOtPKSLCLe7rQZ7wX53HpYgo0PtT/DJDUnU54+O0
	 +6zjQVA4OGVoUR9TjINbsoyjyMy6YXVQ/TU+BMAGpozagC+Es4t+9OKdcdojyzrDXy
	 3CjFVpT/fVICwJ9nIxyyoUXNSIZRdS2RX9CPLoXeQITVvZAP0FfPS8OM8LGZIusxqb
	 ZRFDTMpBe1qP8j2XCWTt+GBsP9968EJLihz41P2GPDJkZj4WilRdN08Afq84SKpAut
	 6oDlLhYRIPJakTbCsKvmAKCUwiloX8//JULTnUyoeEWczXeTzj3b2x4Gb/aeqcroyN
	 /xSL/HwlHQKAg==
Message-ID: <sashiko-outbox-206629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/10] Documentation: PCI: endpoint: Document vNTB
 DMA export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-8-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:33:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D7

