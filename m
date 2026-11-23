Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462552;
	b=nyCotNUG4i9L/ou9oFGeUi/6SlgSX62+W03SYrFFjm4zW93Zi6eYPsiqLLG2QqnQv2Hw
	 PflYfppqsqbA639nufGHmzcqEJTZa1FqSnAp9tARvQzdFffF99pJX5PC7IqaiM0UkxMXC
	 8GJpPLpu3RT4K3zCGay6qkDSq2HeXpCYz4nlpJmXurNAqqQjqLvHTyZ++KhI4v8DvpW8L
	 d+pZJF1DsxkrDkI7u+C1TmSfMuRWsX+pjy2v5OEDddRYPNjO536j7pZEDkmn+QW5Jcxcy
	 cZ+lHnbVOO5nXt/4ofK1pvm6uDjvl3Ma5vq+ue2tvne84EHo8slNVKX/yu9oMihrwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aL+kO8PGkbOt6t9BTRNJvSNTeTll1NlfbQp+E6c90qI=;
	b=AImPUL0hx76V+3eH9maScSS2+jmmESmOuCOlaMRLmCesOmDUy5Lp6Fn/c3uLCCcfvzOK
	 a83bsqoA67QXlW31jynp4YqNaeHN+i9yR0SDIeWtfyEQ4vSv2nee27Bv5gV7CZs1RmvUb
	 1GSVdiWN/RsrGiwI8nGyB6BwaGwGCSRsjZgb0xEtb+9MosMroOLZuJHm5fcdoKUni4J5Y
	 rJC3Ipj7jLiU9EAYDJQSh2c0awtrfl2pdn4p0q+HDCv7H0BOxYUZGyYW2A5391X3vpwfK
	 j8THmEYIkbjtNkrmJlK+vQq0b7jJBOVbBes3SoyYlkgDBRnRHSjC9emHmNClglNsEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/PExJUl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A22606A682
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/PExJUl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6F01F000EB;
	Mon, 23 Nov 2026 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462552;
	bh=aL+kO8PGkbOt6t9BTRNJvSNTeTll1NlfbQp+E6c90qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/PExJUlth82QeIazdXQYVk+uo15Bq43aOsL52qFIk4sPg10j9aA/ct3ppA69mN4A
	 R680DJ8oqAuDg9GjMw2ahfvjpdPrJ1+1d27/lZtd4G+VudHNUtRLiiBY9r4TceJvUY
	 j83iXvrc03M+jd3JZquqSkwe1fRaTl++rF1Vo1htVz61dz5N9EIHoMXtaMn1FcNq0c
	 8FErcZhe0jLiDNTpWLp99izJMSgzbhjnlsqkf4rDAt7xDotZmY/VCeSXR/Vz5JbM4/
	 aLsIU1gZMinmkA8nPIcRi/9lSmiRF11VYBS/HvGC9ufAF5eEbVvpeDyVFx5KCFAd3c
	 Wel9DxgTKW4lg==
Message-ID: <sashiko-outbox-229946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Split iATU windows at region limit boundaries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261124-dwc-iatu-boundary-v1-1-03c8e58514e1@iscas.ac.cn>
References: <20261124-dwc-iatu-boundary-v1-1-03c8e58514e1@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:35:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> dw_pcie_iatu_setup() splits a large window into region_limit + 1 sized
> chunks starting at the window base. If the window doesn't start on a
> region_limit boundary, the first chunk crosses one, the iATU programming
> helpers reject it and the host fails to probe.
>=20
> Stop each chunk at the next boundary instead. Inbound windows have the
> same problem.
>=20
> Fixes: e9a5415adb20 ("PCI: dwc: Use multiple iATU windows for mapping lar=
ge bridge windows and DMA ranges")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-dwc-iatu-b=
oundary-v1-1-03c8e58514e1@iscas.ac.cn?part=3D1
