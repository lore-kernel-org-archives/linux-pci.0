Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618975;
	b=mav5NaWZLEU42Mn5NpiOFXCeDQ7LYAE3L8CxVvX2CW4RNE6n18KxHApiwt2toYgDf4O+
	 wNSUsmZSKxLFd3/ze1L3eMaHigjrveQVavq44+QsKbF+Y6X9KKGS19QuvR/6XeEACTyLA
	 2Ku9vo12+JOwS8mIHCxEgofqwiKyW8wtbHkePLnFgtRp/mlvzRloSkqWrkzQZpnwUQZS1
	 z+2Qe1wgK9n0AgzVC5LyZ9idzh/CddwX0/VuUAOrNbo6YCMF+MAvCneoocAldWWRWu/Fh
	 r3HzuwdWzmuh/9/whPPl2ELnT+En4nABtA/Wn9oqoy29mlIYqXmPowWfhs0ujPge0sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zUDTBilPxeQkn7Qll2XxMGQ6/Qob/LMDIzCqzEW4xWQ=;
	b=NS405/aE0n6XGXYEdM7CBKyd3OFyWTOL4SBAhWmGlgzIlGmIQXrRDoODRDxThfkCGQNY
	 McHuoB8Jg0NaXEb9itsseeJjgtbMV6ETDAantU+3pfybD0IZdksbcP1uFi4+33USZrJmn
	 gzH2OJIynvFIsRlR+NV5bwNRepglLkcK6ET+KjYxqYAeuMkRBP0y8o2J3rrbH96Q38Tf+
	 r0/JarSYiqg/0KneJiGJChsNNwu9XKK5xI4fLF09ldVPVb3zqkj7LLfnZSiiNx9PV3ij1
	 6VY86yKayI8zdtaEzNNbgvkS4g513ERRxIMiR7ER01GokZbM3ShcAtEEFvK2wgv2iDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV9squyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA26606A33A
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aV9squyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39151F000C4;
	Sat, 14 Nov 2026 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618974;
	bh=zUDTBilPxeQkn7Qll2XxMGQ6/Qob/LMDIzCqzEW4xWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aV9squyq+oVXWOop5n4SZjXYmp1n+kcs4h2FDlsXAgRLd+05zT+8vsXCbjALca5DQ
	 dWhikuzh0VTSCMRcuh7yUy2lA9NFIplofa3823Dcs7cl9D2qLAsyLiyxNhGw/9iWB0
	 0oHMSsvUky+U8ZD5WxDZDPS9H4liYjBQO+RQhgLa2F0XNAE8ov7NqhuuD4zaw+sp24
	 RUqW1P4B67elCd/Fr80W1ndoVNxWrRS4v/dSfF969iCc3M4rrU+KfXwFUFAggtdv01
	 3wOcD0SX9qsFLJcYU7hWFAfIsYCaV1Yvwfs66VqEKAR5Yd7CNbHJVvGjGpArgzmuA4
	 OqT4l9Zb+aF9g==
Message-ID: <sashiko-outbox-213996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Add qcs8300 16 GT/s PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-monaco_ep-v3-1-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
 <20261114-monaco_ep-v3-1-7fe227cdfac0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:16:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
> compatible existed for this PHY. This was a mistake, as it left the PHY
> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
> the binding.
>=20
> Correct this by documenting a dedicated
> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-monaco_ep-=
v3-0-7fe227cdfac0@oss.qualcomm.com?part=3D1

