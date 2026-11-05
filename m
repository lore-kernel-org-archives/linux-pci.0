Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894867;
	b=ncJAz+zebaERTlySLhLJg+v+ReJkBVHIAaDCUeXt/RulG+EBGXqAZXdt6Ofj4CImxFQq
	 zBzb/blntIlmQLk32dYUSADkA+qVlfYCVc06z0hscXyaaM4hUvDBqJW6Zl7d6C12TtaDN
	 e85pstCXtIOTe8VN6v7DEOd9/3szdpFx4pqlzAo3qgK+1KrC5pAZIlNxL2DOi5gHzgCBV
	 gWufD9VLR/ciBsye+wV4ZDq0MsPXnN8TqYEKr+lZTkfxVJ3l2Wez9wkwFBuGYcI6MESbC
	 hyUBdiU58iLO9DK9+9Mbyo643dtAwDebRY1VEwe8FEsUDEjxlXM0592xcvfBFd2Qo1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sXVjyKt8yNeAw++szizNigcvHpgGPjnzmA+jvGqrd14=;
	b=2O7hlKkEl5Hq2pmqsQ8tPYaDRZc/pKoOmZLKzpcYef6SfGfrOKUOaVmHa1jsBmqGriqO
	 eOwykU7uxEBQUB4l8duBG7urkdUOB0wCEE9mAtQjhaR8wzTV6nyUDfeKCo1VUgUTYEkin
	 51utwk3f5BadaItbqVdv/uSTtboU3teSUnYTYxOq+3q0k8bxjcWSwKLbjUSpBrJoaWMGP
	 dRYdCbDjenFgskxa0LI24067ovC1z5GX6flxIWd6Jdz7Kaw7sfX3cRyd3b5OOPX4sXk6n
	 HYIhaNzUD1VasuBhUXTn+YfyeR2+7tPgGio05hnmHiQcXo6YSLvH5TCIM7G1bchwnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m06BYNZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F6606CFAD
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m06BYNZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666351F00A21;
	Thu,  5 Nov 2026 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894866;
	bh=sXVjyKt8yNeAw++szizNigcvHpgGPjnzmA+jvGqrd14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m06BYNZH/Zp34TgIQguIAfWaqCn4Y4cyZmMi/9RuLkZ8XAJGGVXftaxA7nbYWS6nE
	 dvEnDWi0Nk+vz86YM10utJgJIQynaUINE0beiv2pAwgo6HMK86OOd5bVqKJA0y53hi
	 YGdbkyxc6yp0FzCq5uxblHxtuaNxKLF97lt6F+CAUgv33/It85URcn4/y5CzRM81Og
	 rFk2Wimk8K3y88UGEgaPWNLf7h18AoVJ4xRLJc3Pi5h3ddWPzX66UyZmS/uugoRucw
	 yQ7k9CIVJ74SYAy2aAiADdLL+qi8y4puYhuQVRvSz4Let3Q8rKb3k5JEtxXdZ51LsT
	 utqcLyDyn4Owg==
Message-ID: <sashiko-outbox-199413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: fix serdev controller reference leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:07:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
> pdev is already tracked in ctx->pci_devices, we return early from the
> loop and skip the serdev_controller_put(), leaking the reference.
>=20
> Initialize ret to 0 and jump directly to the label that ensures the
> reference is released.
>=20
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/bug/linux-07754192-a8ad-42d6-ab1b-cd6f16bec=
846
> Fixes: c4be520907a4 ("power: sequencing: pcie-m2: Create serdev for PCI d=
evices present before probe")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-pwrseq-pci=
e-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com?part=3D1

