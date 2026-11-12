Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441677;
	b=hKYnGBR9ztU74f9+94SjcOrFLOwuO3fV22fvZBIGyDqp3YHbNMvcD5g/jxaaaLdcgXNA
	 WIjtcjXw18E9Tyhx9mVxGvxPfl0hiryyDsUgRpc33WHmVpOOXPZ757xjND02q7pyQmk5b
	 URHWhouXkx+Z7xMpd2X7vR7whhQvf3H0vKnhjWO03lCSS2Vwmxh7BGl0EeQb2olTQO+OT
	 3pg1bJjgCq9D/0nk8boDYEAXzXFt5eShHEBwuDWOOslFEpfBaVb3skah9zRIh2rXnYKTZ
	 lnwIXWcc5oDmJvfx+Pk7+9pHpnoYPb18oCxZCCqRLpu6QGUU8mH1TpFKa+Y7yvB85FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441677;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=euPoI8bRNnIKsnX60+HzqrI+QtaRcWYwd4TcVTD6+lM=;
	b=q6ygszy5X/aUPC3BgdcSbALqx7Ve27w9ALrAOpGmf5rrO5jKmzm4lz9K1UZiGKWVeGtH
	 8W4Ve4kPOypgifR9khW/UWMxEiMOm6thgNjVsj2u2pc/UYmXpaC0lvex6ym1ZVQ41OpgN
	 RNdN2+YlJHJpX90tiV8rkl6mVlb9k7CZNXwfzTgLpcfNj7lHotGiNGkhp0lLQGYNf5s86
	 ck5q57UuemMTp1i6TDAa6KeEY0jOIZTb+my9ZhTXJ9FzT/yYmv1nrtuWZmpVpPvoUfi4o
	 RRzcguNvmgPB67ra46JHR3rQ+MYwBt/n4V4CD4YICKyZ7mzPzaNv1VhZrSlF4PVZuyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lopiPT9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A546606A326
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lopiPT9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5804F1F00A0A;
	Thu, 12 Nov 2026 00:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441677;
	bh=euPoI8bRNnIKsnX60+HzqrI+QtaRcWYwd4TcVTD6+lM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lopiPT9ZSODa+HZmJ0TIDriPs/yqu9144HyK1NPEq6o82Q6lkzeDvrC2upXFXwqZY
	 qF9OCcT4n5j54UH0xHK96t4CfoFiwQkRLk/BxNMHUrWqzgtvewj/tEg13cFtqHEHlf
	 zDxmBFpjH4ubOAb3xDpsbDvRCMqndnQ/xcPvZpLpsECgvNLkg6in5X8ovyDua4jJw4
	 GHjEzlUpj+yfpg6fU9w9JBUzgkoA3t6wmsZNmOGrLlKWN29Gc7AiWkqBu8htTQ5jUb
	 0mPZ1Los/Pyl2XoiAm2J2+HRhyzB/05RcHcyvJGuwwYnkjhVJH0uMfXFtLLwffpWZ6
	 jIfMyjbaoyiaw==
Message-ID: <sashiko-outbox-209874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/11] rust: pci: add SR-IOV enable and disable
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-11-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-11-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:01:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
> Split the C configure callback into sriov_enable() and sriov_disable(),
> passing pinned driver data and a token for the requested operation.
> Require drivers to implement both callbacks together.
>=20
> Return the enabled guard's VF count on success and disarm its rollback.
> On a disable request, verify that the driver has removed all VFs before
> reporting success. VfRegistration handles VF removal during PF teardown;
> these callbacks only handle explicit configuration requests.
>=20
> The PCI core invokes sriov_configure only through the PF-only
> sriov_numvfs sysfs attribute, so no extra PF role check is needed.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D10

