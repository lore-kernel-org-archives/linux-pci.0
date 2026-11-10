Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284772;
	b=5KZXzaz4CZ4beeDbqdEaIRCJeoensLaixvRBKNZFTrPBqE52HjkUQ96G6D2zeMd7XvG6
	 /jVghEeTxx4wANArvcdbyNbgdeVm0ZM0q7cxT/VHbHF1vgGfoBZmS9RfxOxW4gVm4Ati4
	 BVsKOAqLSqxa5iuHVlTGbGjHcjS1feTT4+qDXEEnUxFe2mog1kUc+ZzVA9lMEhkE3T5+V
	 GZzbzTIi14C/KpbXjEvhYPDMpsQKv81HNvhqHYgQx6elIpg/FLxjXjXC1o1fjbwOIIP4L
	 CqhRdKWeEUNfN4CY1z0W3qAjEy47Ov/IlpFRynGKmb7QwJPVb0RpeJ6tT05Bco74CIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lwCemrYyu0NQM8jnkErfog2qjaRyFweKEeDvXlL0QcM=;
	b=Ju3aJAc2VSBpmsF/xDq+ThHwhkOACN4zjehlsURwXeHFI2bYgq3zc58QnwxfjbQKAPqN
	 vcKuk740u8czAm61QUmJMzYE1XLiWMwa7sRPhw0Czhz/6AYRRJy9wNFMXdNHOg5zG/vNz
	 tHBr73VD86fawKncewO6t+b36cnuZhGGbAowFLtehQHCQuNZ/goY2xd4Wr+W7qu7Lq1Ue
	 SSMvVx0HoSgKJmR3x1pYf7sXig8tpFr13uS8R58djfxxbW8DTEotl5aryRsaiL5cKZbFg
	 3peDg32lLXv815t91C7C+k0EYghYCjaHC89hk8VcNwsRDqVzvwkVsL2tVwlhYH0reWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Heu2bUYJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3F606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Heu2bUYJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2CA1F0089F;
	Tue, 10 Nov 2026 04:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284771;
	bh=lwCemrYyu0NQM8jnkErfog2qjaRyFweKEeDvXlL0QcM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Heu2bUYJyHhwefmVP27z3hQvLZeEgWm0yhjWHqTaz8m5NRU7fDbFRRboAi/SL4OG1
	 +bTFLu/BsklyykbzBHAxtKf1nyd6eNFKGyHuiTIsE71pNrhqQCc/R2hdHLclTobqFW
	 /NN3K2nG/vOf67NP8FPPgNH1GKUovj5FhHDcqc8tSLeUKRI9Ta5Pr2IMWexVc1DIeP
	 CVYOKEQW1EaLBvRZrKtjWBTTeNV3Jzp33tuvPAg+xzF9YbSpUxwwn/BCulT75ISbP6
	 PUGeBjNsQ4imUkT67Lflls2Y4somxDQL3Gw+jpaWNNsD8Y+QJ1sy21WOmxeHYqURei
	 BiIxYdGfDg9lQ==
Message-ID: <sashiko-outbox-206195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/25] rust: device: Expose Device as_raw() publicly
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-9-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:26:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> We are going to call the as_raw() function later as part of the SPDM
> library, so expose it publicly.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D8

