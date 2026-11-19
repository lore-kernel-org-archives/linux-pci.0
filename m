Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116569;
	b=f1sBgS+ueMcX/s/7Tun61Zq3ysqBRpTPo1hB8/pzjXejIfSerY3o1SkzvoRBv3PpuENA
	 p2YLb/2AHGRVfP2aCpRgmLweLHYnat43ni+hEgwZmKQWZEqRNx4oEY2v6EAKHM9sPSbSH
	 03IOaSR4dq20sguJ3MBidkmJD3hNyPRQbCUrgCNn81WMHyo+Z16EnpQimZuGK/MZ2OYWH
	 h9TPmq+s1bpAkXtOzvXRm0PB4sVKG/0JbBWdqQaZNYl59Bcz28RRVCKpLa6bIRfkLnFr8
	 jGEFAGEUUzdv/okb2YXni43N6jwUxV+H8ZwcfhTMdtkgBfJLIscRW2k7MRXKAtoQFVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=toAgYbtZb0oJs8UwIlt+vvneLKacaIQVzGBaEBtzkMo=;
	b=ZRAdrN9CJFPsV8/L8Rs1BspbohVg6jhDgrUZPFF3iezZnTu6erHF967vMkezetAAXINi
	 eSiyeaIj1zvO3fmx1ppkVH8MX0nqoTZeQwBseCbtmGXFZHIY4oRuuK+tF+Nnt4r2zhwAZ
	 CwOu1XQb0QAovIsWhpCHtDnAWP48dDa7yeR2AX7yv+podLh8Q7PUxKaWRyQ860G4a5lga
	 UqPv1vXocO/NbrNGtSKod7jykCj2YHzq7pYsmF0bPKF+4MEWQQdIBL6WqhITNL9V7/vRo
	 i/YMyBMUK2CGaSH/kLCkvXoLNP31r8L2slQBj2ohwtUwDctAxyYgrvB1leJqHnv4rkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+0LABxI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517860A2605;
	Thu, 19 Nov 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+0LABxI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34BA1F000CE;
	Thu, 19 Nov 2026 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116568;
	bh=toAgYbtZb0oJs8UwIlt+vvneLKacaIQVzGBaEBtzkMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+0LABxIr5oUGcCzY/wTU8ctpKxtwZyfSpZfM6QR4LZc2UHFoJA70OtSNreVrCH1p
	 6ttsdnGt05PJkEGhQ/RbgK+fzzKEvxq9z4wQbLM+1s0BC2NxYI/jnT2kCzf+hDPB07
	 xnb4jLP5NknN6qwnK0Rgpozyulh4ZMoAVDdgj7Tnf0gl7GBUFMkaNOawYQT0fptMkT
	 bA/4uAqXbB3G53ilae1X6VSNGsdYLjdFVl2Erc6L/tVNLIoas2ZMrHyoxUrRfxkfxj
	 X+oyAGPsKFonb42CAhnBG5d1r6CdHBDH7vD46xbPO1aqJVQDateLSC7FC6EZ+WO85j
	 JNDo2Rwo8J5ng==
Message-ID: <sashiko-outbox-223896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/31] USB: Add helpers to release unpublished
 interface claims
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-10-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-10-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:28 +0000
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
> An early USB claim can require disconnect even though driver core never
> bound the interface. Binding failure may also have cleared the claimant
> pointer.
>=20
> Add release helpers so registration rollback and configuration removal
> can unwind these claims through USB.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D10

