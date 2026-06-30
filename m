Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3C3A4F4B;
	Tue, 30 Jun 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823220; cv=none; b=JHkkgrg8KHWEmjlNZoVoDhAwfGI1O1TTlYUGMpKeu2ljOdRNzTTpRwndaZVk3HQjrULRdH6T/7JLK/3nUObRMO12Cw6vBcjWeInz2PbUtwV7kNgPGacW9VQ0hZ3I/oHFrWGkGZ/Gz1/FPlyi6O/l/9Q9uJc90EG60Z8WITMEUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823220; c=relaxed/simple;
	bh=N0wi7a15NjxWBjhztKeDcP9ZeAFuTbYSNVHzUfPKHSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEYTsP5THjBLujEvavscmHfGPUbCbvoh+3zn+WUAM4DfAYCpB7PwHNCQ/1j3/Lum/thHvW0oCIj9TCA4t4zb0ckTwb5L51ooXbMFlIajKdA1a0uoo9a6QOvDcQojANGKr1TOj3sPU/tadJNCHw7wCYfTRz9th0unWmHmjHKmbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCnK8OGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCnK8OGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AB11F00A3D;
	Tue, 30 Jun 2026 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823219;
	bh=N0wi7a15NjxWBjhztKeDcP9ZeAFuTbYSNVHzUfPKHSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCnK8OGzXMdhljhDQNpaVJDl2RgumAH+i7Q9OfzGbpGL1YUA8wwBPo93Ucv9W5LnH
	 gUzgEZsgXx5jhwOnHNF7gwRgNdVwUvVWM2cIUlEAiLFlpl0L6IZBAaYuGwSaPpg8d/
	 D5AV8IwQttvKvCZsyhB+wl2tG55exJu/l5d9TDKV5pDPkHdi36880i/+nkjNHw4tXL
	 DgtHxPjLNkaGqmdDbskAYXP6Xa2D7sPKdqE3J+SPqpiPslpmGrvBa1CGhGLpSac58Y
	 715wKT3w3SmJCw9fzLEst3j0Nw6ar3ivELG09T2kom8lgVpmfdhNqcv3jnxPY1gyJi
	 qoUeGwleMDqJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] rust: driver: remove `$module_table_name` from
 `module_device_table`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-7-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-7-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:17 +0000
Message-Id: <20260630124017.E8AB11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Wrap the generated code in a `const _: ()` block to avoid symbol conflict.
> This removes the need of creating a new identifier.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D7

