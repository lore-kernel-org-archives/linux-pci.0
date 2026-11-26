Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722330;
	b=L9M6xHIQGwmgaymUfxGxig4y7N5A+WqNTwXo65sdFFPLnxkZuGKlyThOhC/B4BUNLGws
	 AL+hkZVs1a585X8pa590keOJTcRAkZMaQRhaMxu0Z/EsubalZkXQszyIPeX9y5pTHCi49
	 Zo6DGLTTJsCkltWFAbf928WOnx+HjhysQaQ6OcBe+qG51SU7Z4QIdSlvK3+YkGHRiZ5Ci
	 Znzhvo8u8WHoK05Wc6iUrbIfkLji9Fv3/2u2FpLUbLF4k0ZAVUff0odO9HTUAE7lgAKiW
	 F75iPGjFy5UqAJswkgFyf5ICR0a8N3BzB9BmojiUNRrVBCbjkju86GmMUrdhx3hFK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VnSmb/l+TiH3q5AEz+6FON6wO1AuQpm7dHMMVQRNKIU=;
	b=BkUFrrQSdxrZ0LD6j+7HxuKXFbPD0Qs/4v1CrHI5T3Q/yZWY8Er9nA/7WqeIypyE6Lq6
	 XlDPC25QKLiSfHkvdsxV1xklzTkItJLju8h3k0SmJRJQ7ORhnyEjKbuvh9rY4wUrdGPcc
	 9qke8VlV6codGMn9oM2iB+0pNr9PiM954wpUeBvGlQ3ynSSvGaml0HexCP/UuKR2/vX/A
	 L32b/QPUuPDByJWs6tOwvL5vbUupcvmISohSEN9KtLP3luXWW7+/4CInaI/b67aCBGzZC
	 p/sHsfzY/BcfP9vJ4nkKKGzQOEU+T/i/QMSh9BwpKsmXo3LdpL6lZzv5vWxGFLGZsJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uut3rkSb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F5606A326
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uut3rkSb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB59C1F000C6;
	Thu, 26 Nov 2026 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795722330;
	bh=VnSmb/l+TiH3q5AEz+6FON6wO1AuQpm7dHMMVQRNKIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uut3rkSbkOdxcbL/YVEL0jzlJ/l4EIZYDvR5Bhv3hevXZSvEz0nnG6DvsGualSVA0
	 4mevRpqCc3VPPsY+XjbfEEZVkgl7rjx+lqswys30vwKUqpLEXZ+707IdTaUKij+wIU
	 6VDBNXPl1EI78iexotVP9f1JpS5hMTdvuhrJ4RR8A5k+vpSZNuK34NYjKpm423Qxmp
	 r8tZ8tBNzjSRlUVodkDpAV5lvJQZjUMNn04lh85vKAGvwCM5/U2qdt4khyrxYmRuN2
	 a4IYcdCrEn4e8DQOKvgx1kjT3QiOCXSjBo1vB2gsyVx12mIGRQrmOXBOozWU7BRVej
	 kg/3QblFPkCUA==
Message-ID: <sashiko-outbox-236118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Skip the empty CFG1 window for a two-bus
 ECAM range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felipe Infante de Castro" <felipe.infante.de.castro@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <CADy1qsZ_j7FnfZHQnwqFWiQKyxoQGLt+LJKG=Y-63Yi71uiNZQ@mail.gmail.com>
References: <CADy1qsZ_j7FnfZHQnwqFWiQKyxoQGLt+LJKG=Y-63Yi71uiNZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 19:45:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Felipe Infante de Castro <felipe.infante.de.castro@gmail.com>
> Date: Thu, 26 Nov 2026 13:54:01 -0500
> Subject: [PATCH v2] PCI: dwc: Skip the empty CFG1 window for a two-bus EC=
AM range
>=20
> With the iATU-based ECAM mechanism and a host bus resource of [bus 00-01]
> (bus-range =3D <0 1> in a device tree), dw_pcie_config_ecam_iatu() progra=
ms
> the CFG0 window for bus 1 and then requests a CFG1 window of zero bytes:
>=20
>   atu.size =3D (SZ_1M * bus_range_max) - SZ_2M;
>=20
> dw_pcie_prog_outbound_atu() rejects a zero-size window with -EINVAL, the
> error propagates through dw_pcie_host_init() and the host bridge is never
> registered.
>=20
> resource_size() counts both ends of the range, so [bus 00-01] holds two
> [ ... ]
>=20
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mech=
anism using iATU 'CFG Shift Feature'")
> Assisted-by: OpenAI Codex
> Assisted-by: Claude Fable 5.2
> Signed-off-by: Felipe Infante de Castro <felipe.infante.de.castro@gmail.c=
om>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CADy1qsZ_j7FnfZHQnw=
qFWiQKyxoQGLt+LJKG=3DY-63Yi71uiNZQ@mail.gmail.com?part=3D1
