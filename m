Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116588;
	b=GNEhegfhmoLHleEQVG4YsTd3Hvkh+GIRCjKop4sCBiaO7/VgfRRVRZMctuoJcuZlPrrb
	 T3OprIQ3rPxTf1BgoC9uY2V+Y8jc+CIudl3g1W/J+JNjifnIrdJKGzB35NeWPxMKm8tdJ
	 vQuVqrhWQ7CyuCcwch3/akWYKS2dNjwlTkebfQqk+MFqLRi1cli4VFJw86uHEeUi/Rull
	 LzhYkBcvKb7x1I45gFPpYPU+4MJ9rk5HcGOYPlSrC5mwsbqQEpBnB86r0XhyGsEwLgkBp
	 XQViQBVsgSN5bVIHdNe6knKHvwwQnY/CfBn2t7tpFRFjhvHRLeVXBZE6ZLzp87+6eZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qR99A8ktPRSMAG2jVM7wbd8yoB4YC1UQUpQ9rKBCnvg=;
	b=d34XEg+EH1zldqjYOSmmqlZP+OX5YudKkxMyjtA8WHJlyhhy+0MHuEIK9X6103FAus56
	 meSE6zJR3K7AWOu2PfrYajy3SY+CJ6wOWEwbwZ8k6ZEYDSVYhVWgJ+81tcIFIrZOltTcI
	 Dyx09fEUiD9X8cAo2PEpgZ/2cYouZUvU8D5vL6I4QhlUiwA5mrieIm5H3zdpyfPX13Ec3
	 WBW/LlApoaU9Ge9ltm9o5Sks1eg3aexmCtuFaWf3n0/yoAALJqm9Lii/TOqeFON64cSQE
	 LbxiLOY4lMin9vu1yoKohtpVmaCf2J8RV3JheXcJg3knX5su7nn9+45UVyu40Zvn9gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA9L17RF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC560A6F51;
	Thu, 19 Nov 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QA9L17RF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7251F000CD;
	Thu, 19 Nov 2026 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116588;
	bh=qR99A8ktPRSMAG2jVM7wbd8yoB4YC1UQUpQ9rKBCnvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QA9L17RFbH9E76Eq9MTfgOIiX53k8eOH/M1waal+qBPGPzJe+SkKbZEAcBh9tGTtX
	 12VAj3kCa31SO3MVpERo5Q8ALnOpoGgGJtbXrv4uAzidLX6VknhNtlOqGsS/6KMDOh
	 Aniop5SPj3UoYkeUBAXD/nMCaq/RnLqE8gMmgRPT7bWB49VYj4pD5TxpiIbCIs64tR
	 Hmm7ldKrPHJM+7OvekflWNsn1H+BmnLpEvci7duId0724AFm1T+yXiXHW2E2I92+jo
	 kKIywPEk8SN4LMill5auXWtS19oizKvmZNWles7LsCR44p5vvkpvuQxAlO+EThm0Bm
	 sc6OHFCZsZdBA==
Message-ID: <sashiko-outbox-223914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 28/31] driver core: Allow driver attachment with the
 device lock held
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-28-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-28-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:47 +0000
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
> USB authorization needs to keep driver attachment and its configuration
> result under the same device lock. Dropping the lock to call
> device_attach() would let another request change that result before the
> authorizing caller can inspect it.
>=20
> Provide synchronous attachment for callers that already hold the device
> lock. Keep asynchronous scheduling outside the lock in the existing path.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D28

