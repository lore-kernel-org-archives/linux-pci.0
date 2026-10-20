Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484459;
	b=V+RfuxTk7q12eIH2SbgsRkL7bs+zihjQOlgYz/nhs+9MBUoYM5uYjUjKgPx95Ukft/0Q
	 k/ARw2JB1reZ1YQo1Z4JhlrX9SOsY0Jq69hfYv3zXAfGDxC7AewYlIF54K3HS+5amLnsZ
	 Gi762DQDPsHYEBkUA2/3cqraXPLmfREFJlyqRYPa6m5fQj9OuqPyZwGPr6r8uvDiYqtXW
	 1f5UF8kXRTB76akTf/6C6GICMoXkmbUJ5DDJI3o3d+0F3FuXzC1hmW7CAQao5DDcPgDLa
	 6M029/PA22Bok6dkVDvhQA7WeLAvdtjGvZgW1q3mVZo7bSVRs6rIOlE/Xe5JXkFRzcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3+45pbumNTJsSFzmrcd2T9DcCPpG7v2E+ThWe7ZQTNk=;
	b=rwB44Mpu61TfAUASsR3n+LgsmHFlaSgO/0VHY+DFzuzE9xXMAGrfU1M3teLW74NvGSQ/
	 0vX1g3BUwTuCjqps448dWPwSkKTC3DehJ16SCGw242iHcWIDrEhy7cUt6c/v/ryLMqkGQ
	 Fs8Mu+UttY4MJtxBSsxFJtEGqftPttMNaFwh7n/cc7DmJPm8XojXAlETgkroxihz03ZcA
	 vOWHQKYt0zZhTCQumqDFW4GE0hC79u3T+gJ3aUqX437hlTBnpTvTPaJNIFBq9vuLmLkBN
	 kGTSuyGCjWEfS9/UWS9i30Cn2u3+pIvEsaG/zMgbtjCZm4kXND9jBzrgomkMM0NuV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HMD/Kqpn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57A606A31F
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMD/Kqpn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0650B1F000CA;
	Tue, 20 Oct 2026 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484459;
	bh=3+45pbumNTJsSFzmrcd2T9DcCPpG7v2E+ThWe7ZQTNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMD/KqpnQCktW6pWVeu/zPsGTbUaxxRzw5Gv9QjYBeFhRAZ7EI9RH4cJYGFltJWhR
	 owuYqLyBGl4YR1XgtxMn3RHiOqCqlNjPm3lzIQ6DdleO43BiEk705mV5jnPhBW/GHK
	 FTH+4cbaEke/VX3xj13bjtVJUU0XIbMssSEbfUuD8Gu5Er+6WqVcRQkO8pM5i2pte1
	 TF4e3CUfEZakfiTVcvzh99W+SoFrPzupkNXVUCe7FoDVSzzKTMNII8HP3y/5tyE9kr
	 ANif2Rw1irXczFWJf23QFjNYXfUg9GNL1kdhgSGdHyBygnO/6+Gz3RscffJrDOVRS/
	 Wox3YxCw2b8/A==
Message-ID: <sashiko-outbox-178525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] PCI: rcar-gen4: Move deinitialization helpers
 before SoC initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-7-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:20:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move common_deinit() next to common_init(), ahead of
> rcar_gen5_pcie_init(), which will call it when PHY initialization fails.
> Place rcar_gen5_pcie_deinit() before rcar_gen5_pcie_init() as well.
>=20
> Keep these moves separate from the following initialization refactoring
> to make that patch easier to review. The function bodies are unchanged.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D6

