Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965428;
	b=OsesMe0c3EUYtPUa5W7Ex7IcscOQusz9zCh+bh85o8J/K8/8j2QjnePDvkQYJRzdSzRI
	 0QpvUKH1jFhTpfSYtn3HpQFzpc+IjImv2yrjEWFMN1xEnEMcT2whmuzHlQZAxbnkJpEBu
	 BBDIuq/pSQHkMrcDed0zygFKoiT/7OzWYvgdxA/X/Elk4pirwGK4utF7H9CYkg5iICXv+
	 HsyVDisICnF90IgOuTP4152rpmzntw7ZFCxg92FMNm9KWLB7dPspsnV9uvP8SejpiiyWM
	 L7yeaDIYZuUCta8zBiEFH59T11fC0VeJy5g/ZrT0I2etG84hM4W3nPZnB5v+P9jaCJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ME58VOR+8sYraoJpteOUhJZJRNiSRSqTvwbrH9dUWm8=;
	b=IJFfURzJMahuRNfbsAt8edQemDcJBFGPoLttKNBj5fqqsjgiSv6YrWjmBb0xTbMp5UIc
	 4GOe2F5wESzQNDo8mtVbF42tB/7IhkJqDoyfZUnMovv28SIfPJOej8q4HRejVBO71LMG2
	 vAKavWtlPGFrjenPmbgDNDxfRrOl7h0FtjO4mxo8A99tVMsh1UcCD84XoxlJEC60OEtps
	 LuK5MRl5gvkef4NLVnSSYWlZtPXZgO0fxvzcH/b3LyAZe5G+CTva7rWBTekrlDEJQXtLu
	 DwqV4jwm1UtEJBLb24YwP4lI2iu0BD17P04BB7+IJry4IiYbAtgWHNgf2qxv/kl+Rdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbyUtDbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35557608360A;
	Fri,  6 Nov 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbyUtDbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84301F0089F;
	Fri,  6 Nov 2026 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965427;
	bh=ME58VOR+8sYraoJpteOUhJZJRNiSRSqTvwbrH9dUWm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbyUtDbE/bLsZZLVqwlAJS6ECtWfAbbKz2UPR9DZG+fzMWavO2NUUkHjWjfDBnNXa
	 MMT4LBhwrlm8v/fqfiMjicR3dCzosNte7Akg6/Bj4GQdZzh8ywNuXyDX53mQz/K7Nz
	 w4hHnXoyu0zEG2OUrsKDJCUTCdS1Yzc+dwjTcp1R61m4rdQuK7WqGKd0r4jpbDHpsY
	 Opnk93HltN3jLmIEYnfSOVyuu8t0tXCTtbPqM19q5hr2joMGfJAHkkyFZHqUoYPHH+
	 M1jUC2q+0VNSP7DkzvnXZtG6JgianBKktj4Y1fjYGWt8l7Lw502gGbWAZTrHuFeLZ7
	 0r0jvoDJRTtYA==
Message-ID: <sashiko-outbox-201347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/17] driver core: Add a global initial device trust
 policy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-14-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-14-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Confidential guests may require fresh userspace attestation before
> permitting any functional driver to probe. Listing individual devices on
> the command line leaves unlisted hardware free to probe, and initrd policy
> writes arrive too late for built-in drivers.
>=20
> A system-wide initial policy is needed to keep unlisted devices waiting
> for authorization while allowing explicit exceptions for devices needed
> to reach the initrd. Existing boot behavior must remain available when
> no global policy is selected.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D14

