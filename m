Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148016;
	b=IZr+rPkcnFl8eRE3ekXIAPEEWxsD6zq1fQKpEvBfqaNWJh//dfWfOTe5MgQ9m0G9wBPv
	 2ALu8HHaK3qmHnKxcQRwY2PHkn17XmA5Ei6WaXTjLN+kkkiUaFiYAthwLLY1IaA0solav
	 HpMkhAOlrfq34GGA4aR/PIsaJtFtlTl9GTqDP1yj7P8EY5TgPhUcLy115ryrEeFhnA4iJ
	 gqa0O/y5T+mVAGVfmIz9Q2NTGsJ1oW5UN02JkNUtfhr8ma36NWz8gnKobQ0vcpsD8c8+n
	 TwHs/xN0CTP2Nt/vbarf3UFE4fAInBxZS681cI43aBeSfaUaJjv3mwiDuHWkHMF9MSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8a7J0NIbuyLVEsZx+RXCkwV38Ae6uKqAK/zOACbFKU8=;
	b=qY7Ayno7fWQr6zrI8w7niRYahZDcEsfUsKgbPPuTkzTF2fpWK31FyGrcZjG01thzDT3x
	 2mrGMV7VfeUkiNspXRE3CEuWXF8OClwcfIv58CaMbp1BukWeXFkMoKQt0nA2lzHmUtx5f
	 MQQRJPtIlZNGa0UFZjjLb7hQVyEwZBK0FzrqHqQ0smM7F7a9hyTgcPJeK3sZQoQVQbFAZ
	 2sn4i88OT8NQeM/Gq9/oAZUhNlWPfrVL2C6SddcAFuwliTRiwJUwxFSZnS52TuyTjtpmU
	 /97wkEodslN9FHI4/2XQjNiX+7qpabZjpw9Zhlv0dsHaSciVLpTsyqaI/s5Bk4SSI1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsGhearY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF7606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsGhearY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8161F0089F;
	Sun,  8 Nov 2026 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148015;
	bh=8a7J0NIbuyLVEsZx+RXCkwV38Ae6uKqAK/zOACbFKU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsGhearYJZsz5vSfhHcBzgxMcZGT3yilOWr9i045P4Rjh64werQRBSwFdYMz3QADr
	 lMdt52qwmEyVpFueb0wjNydYrchgS48N3+Xmfy0Io818125GNNJRXEJgSaC4eR+edr
	 BgtIi5F6D64NiNpVjN1ZPZ3vzVnYZYnzDpCJY+NVBkRS6HPatmdf9Q048FIxUuuuF5
	 oYtzF1SaFmBqJVclv4s10hxKE7xoEu5EeqB7SmJz4FE2fTgUeHHN6BfhZ7bQPW/cN0
	 YruBPaDk4oTmb7LO/Ed+4uSb8AFMN7SdJUzTqigulJ3FmFKwvynlmNCHLL1VzcyGyB
	 OBFDzJGQpRzKQ==
Message-ID: <sashiko-outbox-203798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] arm64: dts: apple: t6030: Add PCIe nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-3-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-3-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:26:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the PCIe controller, its ports, IOMMUs and clock request pins to the
> base M3 Pro .dtsi file.
> M3 Pro is only used in 14 and 16-inch Macbook Pro which connect PCIe
> devices to the port 0 and 1.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D3

