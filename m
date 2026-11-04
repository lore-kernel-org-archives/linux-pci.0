Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795348;
	b=Xy7SVUYahjPaRJ/0zjCU9fD4Psf2xV2BjRUAzTqKeBWUtkx31WApCrcrEKIsJQAGPE5R
	 bXp/5mtSHOjqdPNR8ZqojipFm/vYngCJXLcdz0AoQkaEnB98wcJ1bfS2e664KMwRIAR+q
	 kIIKwc1LYUXTFtZN8DnnFE+Z8qGSn5KXAjPe0asOFLJogzRtDos5YUhpnhV2ju7rhqCEm
	 k6/But/Yjy1F02Mp6hWozfxX8oHvtSQtEQ/8J/JuASrafUYchgnsK60KuayYeNRtExf8i
	 4bv7Rncns+qnrzkaYFo67qVPWaxsCy4HHVfpNOrX2JW5ZhpwggwRXkWvxebWrsAWJMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=24cY91u8SRMJBFc6PEPCetVOYqPTG0TSVBaT59Cckn4=;
	b=zikYGkatuJhBiS63Uj7zxrJC+UkzUWcs7iV53pL/WXPuxfLWZxSsZJlu12ooXFarcmZa
	 ZkEXrJxSxaA/4MOe1E44uSDRKqACFqQ+01VJ0yEbxn/AsHp9QtkTsQDwNMmQdkItTnrKL
	 S5PwZ+gj0/kEnjvLHdvgv0aPABhZ+ytzIr4LsHEb819pRWTgRr0+vmwJq8gCz7A93wd4a
	 1bnvDBybVTQxBenFijlmPpTH25suN6Xg/u0dHILtFudl/6tmjyAaioN+jYkrHljGZK322
	 5NnrvPT8JxCGWd178uyPWUIjQbUFLzvR6NJwbN6me/CCs6XvXmvdGpb1odTIzxdWXQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXJERD6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18166606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXJERD6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4971F000C1;
	Wed,  4 Nov 2026 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795347;
	bh=24cY91u8SRMJBFc6PEPCetVOYqPTG0TSVBaT59Cckn4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KXJERD6F+M/unoUi+LEKilbGpHGuff1XiiUj6Lu7kv6Hc7WriJJC2kLIPc+7b3Yy+
	 e7OmQTUywLy1LxLDrTb867d2aABoteH1B3xnP+G46yF0PsX+WlbMOKn9XqY9iSwJxA
	 d/5dWzm32IMUJRdG0uG0w/v9O9F+6WspMUpISVlhawprq/Md58SxROgxg/I+7iLBow
	 Nylt6PzuaR0d8yutTsftoeVUj95bG2qe0DJ2d8Q/9O5UkO6xD7aK2g6HVp7fvHdGks
	 tTytWhlVI+9Z2TH8svXjTJ4GK9fWQPPDoemvgujWmoKQA5bHr9smG41S/TYSBYd3rm
	 Phjd3IkJ9tM+Q==
Message-ID: <sashiko-outbox-197253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/PTM: Keep ptm_enable_cnt balanced when
 pci_enable_ptm() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Yifan" <yifan2.li@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261104121457.2108515-1-yifan2.li@intel.com>
References: <20261104121457.2108515-1-yifan2.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:29:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically
> for Root and Switch Upstream Ports"), pci_enable_ptm() takes a
> reference on the device and on each port of the upstream path, and
> pci_disable_ptm() releases them. If pci_enable_ptm() fails, the counts
> can become incorrect in two ways:
>=20
> 1. pci_disable_ptm() decrements dev->ptm_enable_cnt without a check.
>    Many drivers ignore the return value of pci_enable_ptm() and call
>    pci_disable_ptm() unconditionally, for example mlx5 and bnxt. If
>    pci_enable_ptm() failed, for example because the upstream port does
>    not support PTM, the count becomes -1 and stays negative after the
>    driver unbinds. Then pcie_ptm_enabled() returns true, and
>    pci_resume_ptm() can enable PTM on the device after a resume,
>    although the upstream path does not support PTM. Before
>    e1092d5e15e6, pci_disable_ptm() did nothing if PTM was not enabled.
> [ ... ]
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20261102222817.GA983941@bhelgaas
> Link: https://lore.kernel.org/r/20260616141733.1688264-1-vulab@iscas.ac.c=
n # [1]
> Signed-off-by: Li Yifan <yifan2.li@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104121457.2108=
515-1-yifan2.li@intel.com?part=3D1

