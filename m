Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116564;
	b=EBvzbIcTIRYb/io/YfmcpSjlB+VdJIzLxWHgEeG2xlH64kRe2g6Nn5btBYzdlaR1HzIG
	 HUjsr/NblGCi1jeFSAc0csUwNa0vfjU5Cpo/7vPgDozzt9RmWtLxvfkRIM1V+IrsrEFps
	 EyHBAABv5/ATW5ubJkULZeIvpquI2aFdaPj+ygy8QPYCdLdnJBPKd38un1ATJ72kxTVbX
	 T4h2pI0LRVS2TqxQKMCX3rflWvqvHoqBpdfGjX6ub7+SgpeHrdK0k5XuZULnVTEFurwdW
	 3wv/J59B1CuNtbjbVNLrb6UTwgl+N1utJaVTZimHBTVW1r628TUg0T8hCZyMMz1SNsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Goxwd/kE0tKjfIhWtI2uPK2HXv8MANmj0nYKszZnb9g=;
	b=TmjOG8JJpZqgeWR+6f799BY25260MKUiXYglFi6aGKa0m3PdmT+kzTNlCjN1d0K8vHs/
	 Sdn/tq79mGZ3ewwazfQvDFSrC7TfKyg8vuMYXpirpVbhgCC3tpwu9b7UOvdG3sUNZeai8
	 mAJqoPLCXMS6E4sBcSrlsRmY31o/aMIX5u2bl13zW6iBmo+DU4IM3CoaNHVeyJLyMQWdU
	 44u9cZoo029jJasdDA/kR08D1ojDTsMJxyLUWVcUlmoWMu5gkKbjgV4p0X+3kl3VnKc8a
	 11ZYwoYZF/TZTCr/h1sFry01oX6pVGYFvRNKQ+4tEpc5T/0UE3yCQSrSINTSp5eTF3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3uSFQ2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72E60A2604;
	Thu, 19 Nov 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3uSFQ2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C181F000C5;
	Thu, 19 Nov 2026 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116564;
	bh=Goxwd/kE0tKjfIhWtI2uPK2HXv8MANmj0nYKszZnb9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3uSFQ2aACTHMUbDtmCjxcHeiwcbWyU7aiG8ala/3oHdEMe81ZPdJl3oeKkeY+0df
	 KTXMH6GSTp9elczMzj5HldVXR/ImxIdyrUixA7x9mGKq1HbEczTVvjl7Qtc3yFO3VL
	 ZG7KMLWN7IfwvKLVn1lvhhSmz0Yp9olUVavqdJbTZKl6lUvyA8QrgwSf9BliarO8WN
	 qgy+KtId08pJZ6p2YjqcT88gXlVHOG9mJ3KLL8N/LdAN5FRyA9qaDmnUj7rN+gwH7D
	 qz4sSVE/I/j8ENunSdNah7o5JhYr4IS7DETz2ucupfPql/MFXLtZ5Jk8buQxIAb4lm
	 pLmF7g0Xx1WgA==
Message-ID: <sashiko-outbox-223890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/31] USB: serial: Register USB drivers with their
 owning module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-4-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-4-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:23 +0000
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
> The USB-serial core allocates each USB driver on behalf of its serial
> module, which deregisters and frees it during module exit. Registering
> through usb_register() instead identifies the USB-serial core as its
> owner, so a module reference does not retain the driver's allocation.
>=20
> Pass the serial module's owner and KBUILD_MODNAME to usb_register_driver(=
).
> Keep the module name separate from the USB driver name so built-in drivers
> also link to the correct module.
>=20
> Fixes: 68e24113457e ("USB: serial: rework usb_serial_register/deregister_=
drivers()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D4

