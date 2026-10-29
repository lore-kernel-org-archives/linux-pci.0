Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254405;
	b=4LOdVN/ctSMmJd5T+ZiXnR9sQsrSkEChwyEsekbyo6grJOYMVVv8x71Hfj5i9pZPIFws
	 MkTvBT0T99LeAROiQ56fCzaFK0fYk8iRYXfy4q9V3wyjH/aDj1JpUsASHXgQBprwP6CM0
	 w+RsBVanqNrvU9DfdoIrVrim8oCO7Qbu8SeA4A+r3+/7N9QEoQPh1HuSzPRf4LoG/yM8J
	 teCPJ4I1gnCxtxJ3akzN1QQeYjDjndEqIMqbMvNEwugvOrKjwbxM7cwM1269uxpj6vvcm
	 yGX9AaGINk9chyQJgjV1SRo8AMGp/9Za/k127NcKd2+aNBJh470wkqE05u93cA99PqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Np0n1K3h42KoszW2CoTCHZ12Hn+fXCmMzVsvmU8U3W0=;
	b=l8P/1SVyEDPNPAwuxAL6o+vrTccC/BR5nZjAyHipGfGL5gtZ6VRulSSDHp+oFGlUvdjT
	 JrO41XZBePys46+40M+uz+XQAYOIdoDGxRJilC7OSwAk8CgkwObX5tDdlV25oxWYwSzjN
	 X1M3T4txRokbIywc3PcGb1iGfIKxTKjVWvzbZ7b5hgrKeHieZFIidfKzzvot8z1p+SeYN
	 UwW4KKANzLZoaRDXVqo8VxHP+hr/XcUAT2OFumOpDE1Mw1pWUCTrqdnZFFjZCLG9Nqq8X
	 1vYfRazT6EBTxTy9uddSxOtR9dhNXdD1A8FCJa8IYjTbIFCWYFPs3u1b6mevM0W5BaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGnOV6sR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7030606A31E
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGnOV6sR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F91F031E2;
	Thu, 29 Oct 2026 06:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254404;
	bh=Np0n1K3h42KoszW2CoTCHZ12Hn+fXCmMzVsvmU8U3W0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGnOV6sRag7gxNd0u3Hda5Hp7Co5pjuih2LHg/fx9uDThjDsCjV+7MlGLzc+vSzCl
	 ZRNLRifWliLrbfnuXTALTn9NxQtyFXug+NVCAHAAoPnohtbsTuUziA4jlUE/UuY4BP
	 kAqgyBtmchLiJpCq5xrpGd2CbzliAEo7Hscc2cr9xONa4BLe0p+kZ50bhF7UQ5LE4O
	 gqcmGxmcwtYYjdm7cBGzGzbko5uWTV+vDVh09EwtNGV8VKiMuV0Bs9XnXIqXjTb5z6
	 Winn6Jdljd7nz/vO1/GUhDd8iQG5Wp8vW6QQCZ5llTE/2l2xPkJgoynTz4lcQ2eWTh
	 96ViRLLvIZtlQ==
Message-ID: <sashiko-outbox-188797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: qcom: Add Nord PCIe controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-nord-v5-2-1a13c214e89d@oss.qualcomm.com>
References: <20261029-nord-v5-0-1a13c214e89d@oss.qualcomm.com>
 <20261029-nord-v5-2-1a13c214e89d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:13:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the Nord PCIe controller configuration and the platform-specific
> settings required for correct operation.
>=20
> Nord requires the NO_SNOOP override and L0s to be disabled. It also
> requires a clock-gating-control (CGC) workaround to address a PCIe
> power-domain timing-convergence issue. Set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset.
>=20
> This behavior is documented in the private QCTDD11972446 erratum,
> which is not publicly available.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Tested-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-nord-v5-0-=
1a13c214e89d@oss.qualcomm.com?part=3D2

