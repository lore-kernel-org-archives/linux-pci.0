Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500241;
	b=KFPTEWDXRd+8vp+xOIQUN9FJ3H8ZEbPBdIRu+xY8DYUfTc/p9Nyz++oQVMgwVnSH/Z1N
	 3jaGkznRFHk95byoaCkTozGaLS1wFGuaokAq8t2Jv0J6byDIRidJD757nfqA28h1OnaDs
	 k6svfkkNXRIFZFbsa6qhtDWCRkkKqgvgKYmQy6qCTW53HVhsOwrBbaxbLvS5mxiAmWt3d
	 SoTRZwY47np+TcrEjhSJ+bQeJ6G85NOXsOQMzuejELsbZh8guB42+DRhBrbb4rFrUbe82
	 0rQHNtTmxzXNajkVEjpwOP7hyVfJTUtHcSfozxAjqp7s9YOB0Of04C+fp5kWSyr4EKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500241;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=70044XyRM7M9zlZ1E3/O3HI1xtBAY4tCs57x88K8Ao8=;
	b=D/Nkdunn7GjfRhZCr0Q8Pdl1qCwGmTjRjqwfdC9vFMooD2X0nxJK1FZ4nFKFD9eugEX7
	 btNBBHn0AqW8SrTEPtE1N1i1kkSUFgRPxNr2Z0MlY0spoNHEWFJXzK0AJ/gz2hRgw/20F
	 +lfnhzD9iYOWSUQstbwoAVTfFlrcsLmuYh172jjdxf4R7DR7UFqoKC9j8FlNa3u9/w+2S
	 F5C3T6shofJzSTu4NtA26WlHIjc1Ece4JPgFLs8R5eVRvkwhLEp6AAl9z18GebhTgzt9M
	 6d731712jbr4Jb+n41h3axszrKvfdBi+7C2bdSF6A5NFhffFFFpziezE31UbJXFc3hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knUlUaYR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE6606A324
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knUlUaYR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9351C1F000C4;
	Tue, 20 Oct 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792500240;
	bh=70044XyRM7M9zlZ1E3/O3HI1xtBAY4tCs57x88K8Ao8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knUlUaYRbk5jjOfUatVr7/VWiwJXvSp7iTCe5FQm69nCEHjeI7ugUcyQoWRpjtv6F
	 RlWf1qsH/luhRp6gwkE4eeiCrMBGbe6D08FEm5BOMW5US1icYZkVbxU0Rw/NMujtzW
	 01nVNEo4I+m+qYanxTprAQgNMD2+xXdekC3HE8rvkwLZSymyqGXvugOc3AlEDEyKEX
	 mXRb90t+ROVNaXmugPuKroUco6Hv5Slu/mbmrOtWbOtBSFqIBOw1/lRKQWGXnSVgap
	 gDgysUxvTiJooEpBlakxGVarPJPCBm4OeIDK70CLcL3tcPLiUXEXJGUwmbulVGaGqy
	 tITt+UnHTbPWw==
Message-ID: <sashiko-outbox-178957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Match the hierarchy's MPS to a device's
 MPSS as necessary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020122854.1500883-6-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
 <20261020122854.1500883-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:44:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Hans Zhang <18255117159@163.com>
>=20
> pci_configure_mps() enumerates top-down and programs each device's Maximum
> Payload Size (MPS) to match its upstream bridge.  When a device's MPS
> Supported (MPSS) is too small to match, commit 9f0e89359775 ("PCI: Match
> Root Port's MPS to endpoint's MPSS as necessary") reduces the upstream
> bridge instead, but only when that bridge is a Root Port.
>=20
> That covers an endpoint directly below a Root Port and nothing else.  With
> a Switch in between, the Switch ports have already inherited the Root
> Port's larger MPS, the reduction is skipped because the upstream bridge is
> a Switch Downstream Port, and pcie_set_mps() then fails with -EINVAL for
> the endpoint.  The endpoint is left below a port programmed for a larger
> MPS, so any larger TLP it receives is treated as Malformed.
>=20
> [ ... ]
>=20
> Fixes: 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as ne=
cessary")
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020122854.1500=
883-5-cassel@kernel.org?part=3D1

