Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819259;
	b=Tx8CrmHvohKjzLk71uN0gdZu0MNymsuKv7/imftZXOdEefz33BvbLuG7mOUoF3KaD03Z
	 18QCl6D3Qg/YJ0hOUPucT2LtMnD4Pa4gFp5M0c/8D0hBb0JmcC50v/wZtRlcL7m25y7Ij
	 HGdlcfWxWshEyJ/iuxDHCfNffhjkXtVH3WXbmzNPeGmLpZUs0+erauVToVoismGcKqjQc
	 /AKQrXGCh42M+EPCemZ7SjxyqA6N5FvlNXw1nDgpZdZUDKHzcxqRO4BjenUDIaGPOYggg
	 IyGqIsUfno0yob0n5y9SpgvdKO4b1dT9EYQ2Ka6/ThE7iyYW6/WhYJFnQHeFDnknm9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oHFN8m0HxarC21v7u2Aw+Ors3HJOSgEtksEylW8sISA=;
	b=lEFgO7MHuDYbHvgEXCAbxn+/N9fBxO19N8h3iOSQ1IB1PBFzYswBMqAcNLQbIC6wI4Xq
	 5hkYw+yQGCbs3dMnvD8xM5oFN3eXzB5XLxgOoPCmITDMoAZwC74OnCr0X8FZXl6Of7lgh
	 BLrMEi6YfShGY5g99BqZtLmD4ATGt9HARsnE+1omVXhDvP7kX3nn28e9rUHspTM7LFkPu
	 agzVRcovgK2QaviY9mz+gvTF1xi4fTOi3D9QA2BjCFYNd3QjQ1QwYO7OSV5UGaMpdK//U
	 kT/aklpRFPQyclnlgUtjyje/qL/+S6+1dwFSicE7R//SEZV4+9Ra1dj4D2atBTcSz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOHdKEkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C20606A331
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOHdKEkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159621F00A16;
	Wed,  4 Nov 2026 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819259;
	bh=oHFN8m0HxarC21v7u2Aw+Ors3HJOSgEtksEylW8sISA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOHdKEkO7QfpQsmNe2jktN8rmHP0gVhUE1sulnOMLDir6x8aLeO6Z952xl42NPdeu
	 /ETxI01Sa+CVAe0A+zKsRDKk4pwtuQj37miK0YwdnKKxShaXz9RpFxb5EAYOkQJ+1v
	 ZSk8KMqpc7SmVQ+J5Ky+DqLtDkrVSjFpwNwObn82ePijoi2K3VCT8nTAlzSstu7IxV
	 /oezDaXB4uwe1sV+e0FmAwQGcBlsnnKgOmLazGH4DZJdEfdSBZA/6nmzN8b3HBdnKN
	 mQawtwxpjMrkNkGcG8kju+D6q92ONEMISWYhBanYt/UZJURQvfpJCv6RBdU0O7QrN5
	 DvULiJjlcdr3A==
Message-ID: <sashiko-outbox-197918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-2-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-2-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:07:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
> setup with devm_regulator_get_enable_optional()"), which nicely cleaned
> up the code.
>=20
> The vpcie3v3 regulator handle is needed to disable the regulator during
> system suspend (to be added in its own patch).
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D2

