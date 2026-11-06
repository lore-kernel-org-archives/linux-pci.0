Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983870;
	b=Gq3frtDc85sdzYY3ojBMxlah9cNQHGfCfu0khJDATu9ECj3t4H1dxHsL9pmpqL9bO+Jl
	 NURCuROZFObN7BKHWg3GPF5M8JD+PlgsY9vPXxI3/zrSrPQKBaNasYp58NBFMOLTkteWL
	 oaEoDdI8Cs6RrEiBWN7emdLo8U+bSncKtU2HqLhEBfFEFTvquu9Tj2G9uHI6U8cWqNL3h
	 Ptx6yHOLh68/Rp1dR7SpODUtoJesIv+AgVusnDHipGsG0NxZPWdUjUJCMUCtmb0Lof4FC
	 bKv5Avpn3+g1zTowdk904fsa6qkivRKz/Q/OOa58qUvlB3kYh6c6RpLwhEbRqGNhnKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jh5Elcv6RLdZfiMa9IYl5tQRmOkYmoOp9YSbXeSAiLU=;
	b=SDO2oHmpcOOWPYQ98ZbjEVW7Jef5p+uWP+Jln6ISIByH6u3hD4UMqhxcNtby9RduwAi2
	 4LLTF9uqP/m4w4gHbz9GpIk61ZPcHA3ShVo1bCAqHe9W+ol76WduTmVnU6DB9iAed/Bwj
	 mQfI3+9oSUewlmeMC8tC7khLan3rR28Vi8CufCsCNkHfLV39DL6pOmsfW6/HoOXdWUowV
	 ssUMTSwgzWW0qpSAB/UFq2JTU/cii8eitmZY16OFlk9nfItT0GS0j4fw3e2x3EczkIb5N
	 NS1fmE61d/1bfwjKN7noI8r9QKE4eQH4LQvbHaxmf1qT0vWcsguG+hZ3LXAa4xKMvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cULCciwn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4721606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cULCciwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D61F0089F;
	Fri,  6 Nov 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983869;
	bh=Jh5Elcv6RLdZfiMa9IYl5tQRmOkYmoOp9YSbXeSAiLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cULCciwnLZLlewNzRA/qCqabdqZC+YPWXUv6Pe3BG2wX6EQHsArgTG4MhZXViCvkc
	 R168G4nmz+G1l1DA7mzqAAKRYCIXCX77yXFz2WW7gH91VqY3t2f+d0nLvmNa6prsnQ
	 gCuJwXI8uZ36Bcz5mxNJvVfLrlm0WVO5ni3gdGjIN6cHLSwYgj835FHTz51Ez5G4sL
	 AZkM0EXHSiT5wn7HJVIlIgLdUsZifa9BW3WwogzEYCW+HNN3o+nFr5J6fXObJmHPzq
	 YwO+Enh6QGCTONqjQ3FCPUeHV4sxOneklAyVzXhmlUrYHEVV1a5vmYmbxgy0WXwM3a
	 6tCwszGBVF1cQ==
Message-ID: <sashiko-outbox-201865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/7] PCI: vmd: Replace hardcoded values with enum
 and defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-6-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-6-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:51:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add enum vmd_resource type to replace hardcoded values. Add defines for
> vmd bus start number based on VMD restriction value. No functional
> changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D5

