Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148299;
	b=WR1IEZ9IAxwBbfk7xdlAjgzhYrrOj8JVhgeG3IY3+pOxDUCpYlk2OIuTpEue2bwh3NPe
	 xAZh6fw3lca4/XfSsp6jkvkDa1khq88vDqNWoQYRNmqAPQo5s3e8Jri+/1JZO3KYbBV27
	 leedmhE9ddQubcKmhzP1AwlBZtCtM8BsFHwobNfzUZzxdHGKF6ljdDVw0U/vzR6DThIGY
	 Od6+EXjCo4HsrlqugosYvaF9PjqkVpdQM9PMZ83TN2nXxErt8Nv57csdzdDe8/PAkKK3k
	 5YlPlaXOYFY8CLGTiyGKeue4D4aGxwksV+HeaB/beF08aex+XUaxzDyL8BMqEwRinDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q4PxoWpG3eSayk2CXyC+QA1bYT2giibo4HQJYLMDJqs=;
	b=2z8c+dyNT+Gh8xkX6AjbZ8ZqZv9RZM7CJgX+spDRWtMpwOYtaYC+oHIqNoBQD6AH1UN+
	 Sr8SRuEm3WyeMHqEt4Ucepc09fei72CJ4TrlLNwpuu11OR8vw85XUV8DBcBPHL/4P/S0j
	 icVBWyDIUKqsYItAanFHxnml84p3fIypVpcJxOZnWRyXcc+/c7hJJ7W3SQIZ2l0ujendK
	 es63Le4UvdpGDX7wlHMTTEpg2MBegreKdDgIxAQwTiwkalGDstE4lOmujsAiq465SIhoA
	 dl0IjPLkuB3nnUEXqFvqUpOZhAaUx1nvvb+6FZOM6Fmo6Qnuh5hNLl94Z3B6aQrqloQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LqSc/jzH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEE606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqSc/jzH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63FD1F0089F;
	Sun,  8 Nov 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148299;
	bh=Q4PxoWpG3eSayk2CXyC+QA1bYT2giibo4HQJYLMDJqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqSc/jzHEzoTitwBZB2mFsABm61Hlw2rznNBIRjRFFjPD5Vk5vvQZUVthe7yAOrmf
	 UcR7L9C3anu0a2A3I7ghLELpSeE1TiLuaqZQRjDPA8rP724UWH9zeiWZTetDKR3qpB
	 rXwRHde83oZ47KhoHuTNmepeYvsVd6hlnLZqJRrd5Skwb7UjVGoZzESa/I+2okQv/a
	 84Cl5qeMOUh6jyk59BfjJAcfDxrwmO6Ph5zGmw6OjDjKugWV1o/t82pna4eKqaF/XU
	 OewXMTsEqW9ImEIfgC4gb0whJCjNKAuH7Z4ksfQiuCAXd4y8GqPdcxagDeD+pZYFGT
	 e/Upf8eRPorWw==
Message-ID: <sashiko-outbox-203808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: apple: t603x-j514-j516: Add PCIe
 device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-6-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-6-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:31:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Yureka Lilian <yureka@cyberchaos.dev>
>=20
> Add WiFi, Bluetooth and SD-Card reader device nodes to all M3 Pro and
> Max Macbook Pros.
> The bootloader will fill MAC addresses for the network devices, add
> Wifi and Bluetooth calibration data and set "apple,antenna-sku".
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D6

