Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151970;
	b=1bi0xneb73+u2rh2mIeGUKig6U3hGMcmQx1HlEeb1T9AE5Qak3DCfaFeqAwEEvvWwARx
	 11x4YuzZ9Q3DklPbFNQ92M6le7JjSk7nKq5cgOUHhGXDxDbxFvJ1AHncvTGa0+t91YPKh
	 CykDtzPvppcKPlwzQjH7cLShMZbpQngRxApi9rppuRc2cgrQHZslU2mXGTew9hWn9PUQn
	 w6yjXUvegzkE6XXBdtzqbjTN8sKT0KSdo4w61b7nAcWWm+pN5q/fio74+eChZmR5KcTJO
	 QfeVfGAjt6wHVqF1CNLyMvg+WoToJOfYH7LHW/PMFUipru2vyFsU2s7Gcw64in3EFyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LmDvZs7PWRtXlI7qHP4ompUjVs6Bjy6mw12BYbGO8pE=;
	b=jGKlmjsJ5ZKqG1+u4BlqIWArBLd8z25fKhvOJd2C+ASt1LxmKgHrFrFaivLvq4Mt5Rq7
	 HsapNBhidBTz9PWgbmSJcfg7W0C29zLIw+wEHKtWG1JLWtaxrXd8my4KCjb07ohGQBR4L
	 gP2OcNinCBpobkH0JgxZXm/YDCSZdyOtj6bHs55u98FiFafZvH4NN54eIR4zh9Uu4AhRC
	 PFtm/v3YZUTQ7D2Me71JJJqyz2reJuwS9UCuLNic4rSA3XkKtjTYAPF6z6/H9zyu0W5zp
	 x0mEg0Iok4ij0l+SXy6W0u0bBSsTxFouVyodhZ9yXX9qDIDjKIy+nWRrwFC3fA7bDsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHvL+tF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8A606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHvL+tF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A70F1F01825;
	Wed, 28 Oct 2026 01:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151969;
	bh=LmDvZs7PWRtXlI7qHP4ompUjVs6Bjy6mw12BYbGO8pE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHvL+tF+JEGMEL4pZI2u6MYTGGXc+OlP/QuJ6FMp/gzXKdJwF5K6WEdW3rEOFjDbQ
	 nKAI25cMrnCfD8jZuuMDVExEGaETHW7TH0zth2DmCWOYuOq8H2dG+EB3GZ7pICZgx3
	 nGUKYK5GzZzMPw3AFIgi3SIggp9V5QuKWH4YC5durmH8QV6KF5pLmGp6lS6vVQJ4+Y
	 3U+EDerC1dC576yl3kl/tzRfiONW0P20FyPEHAxA1vKME4z9vp4ZnsMZPIASpWUhT0
	 gUwfP4fbpgtc1o9KrECqp2rMVv9lf3nAqhdBKQmZ6vqSfKH2v1AFEgLUmWJhCksXeg
	 qv6UVUpJmA8SQ==
Message-ID: <sashiko-outbox-187319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: rockchip: Don't lengthen PERST# when power is
 already valid
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028014116.2432425-1-ehbello@gmail.com>
References: <20261028014116.2432425-1-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:46:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
> rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
> behind an rk3399 root port is almost never enumerated: the link trains
> normally, but the endpoint's configuration space never answers. On this
> controller a configuration read that gets no usable completion is
> reported as an external abort rather than as an all-ones response, so
> the machine does not merely miss a device -- it dies with an
> asynchronous SError inside rockchip_pcie_rd_conf().
>=20
> That change added an unconditional msleep(PCIE_T_PVPERL_MS) to
> rockchip_pcie_host_init_port(). PERST# is asserted much earlier, when
> the line is acquired with GPIOD_OUT_LOW in rockchip_pcie_parse_dt(), so
> the sleep lands inside the assertion and widens it. Measuring the pulse
> in the driver with a ktime delta across the two gpiod_set_value() calls
> gives 1 ms without the sleep and 108 ms with it; msleep(100) rounds up
> [ ... ]
> unchanged between v6.11 and v7.2.
>=20
> Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_por=
t() PERST# handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028014116.2432=
425-1-ehbello@gmail.com?part=3D1

