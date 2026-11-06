Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965426;
	b=eKaeWG3CbhGNk4TqK9PO61oCkbGYaaNadJoXRgB2DzAzCJDEt8GVNmAbG+20fXuAdm/v
	 YFATQapjgSxq52p0/FB+QWY3YThOsyO9UTqyP550yfD66+iipIesjcFqeiLwVG9t4e88U
	 m3G8i21qTwlz0qiYlCjVWhSu9Y3EDKTwV/Dotsn72II15dHOXcVA4ptsK+6oa93wIj/DQ
	 3lw3W5edEMkZR0J+N0uY4qK7C3E0j7qhMBiibWiYgbadRA72QVYnO6RWCEK5f91J7QI1c
	 Wz96DC7p/etCnMVmUuKZjXkuoyr2CbIA+UUS3z3XICryOfCiGf057UEQF5W0E3a8xvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zLs0u7uPwSmPe17dHFEEi7BWvSlghuNarcvHDV6y62o=;
	b=OiQcA9UkKv10mvAF/WO59AnQQxGlt2nCl1iszkZQx5xeoq4hj9IP05X0LkLzzbnl+7oJ
	 00z/Mh2849Si0Ybiy8V6JjyayFGrhPGXb1+hMbTq0OvmANkfyJdSBgDfmoXQmBUgwsz2N
	 SYQzTE4YX8uP0L6XSkwcZjyj+DC6DQunzfjfQo/2sshUwRjlU9uElsDfna8vzbQTguLxV
	 kayAMIf3d8DXoXKBbJ1x4PcqqbVjSbwV7Uzk/2HiTvBluBejxjKj5aCWffW5IhXPvAyKN
	 GTXKddaTK5u2yfuIS67gdsahzVZB8KHbAIOQkYjSGRincCJw6b3SxeRHPZEHFjxXejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjiEjFHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116E6082BF5;
	Fri,  6 Nov 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjiEjFHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E721F008A1;
	Fri,  6 Nov 2026 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965426;
	bh=zLs0u7uPwSmPe17dHFEEi7BWvSlghuNarcvHDV6y62o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjiEjFHdbdhcPOvJOPia2kefYiYMuv8rRSfEw2DyQoRKXn0YbiNlfehu9bScyEeCF
	 f4y2NSV7W/pVOs+d6pbllb0J11RNqjg7MaJIcoHRalHS62fscP9EX2PXyuXd+I5ART
	 Mjzyfo0hsNSzhzMZ9Upeq4cHzA9mXusMHm0z9WFvDFF+toVedg7TLuGXiuOHf9YsA3
	 tp682EdGIZ4iZzaOrY5Auo44ShVLtaFH/DSTn+25NXOWDaRyJnPxg1QbIaq1nIy7rj
	 /ZaOyuE7DIfo/KaZoVBfd0aFkz8F4AHJK4GBI2qayzNnll8MgmETkCP6PbVNOy6/nf
	 C0Q/9UbelRXNQ==
Message-ID: <sashiko-outbox-201345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] driver core: Accept device trust policy by driver
 name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-12-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-12-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:45 +0000
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
> Device addresses can change between boots and cannot conveniently name
> every device handled by a driver, including devices discovered later.
> Userspace arrives too late to choose the initial policy for built-in
> drivers.
>=20
> Administrators need a driver-wide boot default without weakening an
> explicit device policy, userspace authorization, or a device's lifetime
> trust commitment.
>=20
> A driver may claim a USB interface before it is registered, which skips
> admission. Let USB refuse such a claim early when the interface's own
> policy is disabled, and leave driver rules to admission at registration.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D12

