Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889621;
	b=LHPMgiWgAfro87DR/6iyGN6rI8fDchbiN+UY1F+ZNjAUp7Ea43003yZYngMauUHuiIQt
	 douTPVF0qBp+HTY8E/MYDAHI1Ny+SIfQRsqX+xtyN6K49TTEi9FvAPn2ZIpE+aOsApmUX
	 LQEcMnkHp2xEzWAnuPFEJ24PsgVYBoEtMQzUXN8Lna99As9PRVzn4P1dm1hWm/rE8j/qy
	 y5rNzxHn+5cuuC9eEsvmmeqb9bpPRtPj+PA/N6fnJcyPCaasZ8cBhM0afVIiuJKwfN1VU
	 TuIfqgtkSPUvxeP6cydKOjtX0vtQ1YK/cY+mmteAkmdLQXjsYYPtK8paF+Qp0NDcp6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x9GSk0EaYAW67hbCnUKP4exODtovzL50+xBUEL2LvqE=;
	b=Ozcxec5596iMEYNT+vuCe9EbbRnm2tHQalAcQ3YNMDmEvFJQDGLJLnAtzv82OWjexf/i
	 WBBvO6vFVByOBl7sPUr/Jgv7hdda75ASaEQ50qs//N6oSY7Hn5kwmPLVaA0J/1qqNDotS
	 X8pdqNR7e5B6ZWw9p4FNjQV1t3mt5VQeG7GKyd6Av/AAL0eSY48QTzcT/siOUXKHkDK8b
	 ZCqX5OQz2kxzW0ECDjxhaSQcA3WnEbnorDn7FQe9NUBfJUU/83ScYyAY37UZ5hbfQmANt
	 hjM/hGVdEEpRW6dC+B6ZtzDII5hxK6SEzfc/6U/KS8zhLhhQFEztATf4BWGIychULww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EToP5XVY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24F606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EToP5XVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7431A1F01828;
	Sun, 25 Oct 2026 00:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889620;
	bh=x9GSk0EaYAW67hbCnUKP4exODtovzL50+xBUEL2LvqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EToP5XVY7GoAiisz47wbYdUOss3TYaaQ6o1uxUvTIFxzA2xitHrgw0Z3wT+eEmpzV
	 PPxOjwMTL4c70SH5gtLOTPYvB6Fz+gcDzQUu8Tbm/7KdwChitwuuxLO/QscxkWYr+5
	 UhMhEV1qWL/K5EQQRq5pUVuQ5AixGGNeKczQ47FO5ww1a8qWPLHsG6DDR5BZT5d4r1
	 06hK+WRnFS+shWMlnhgIRu+bt6ywQm+wsrmaeR2XowFe7SiY8YGJYds5tf1YVDNcgw
	 +BKsswdorUpSEVQJRIEQZVn+XJws2K7vrKmihp2EKzPZ7ukKpp+GRsRQHiY/BwqDzy
	 iOj5LmDtpeRIA==
Message-ID: <sashiko-outbox-183962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] PCI: Add disconnected device checks to user config
 reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261025000836.58294-2-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:53:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit 4b1038834739 ("PCI: Don't attempt config access to
> disconnected devices") the kernel config read accessors skip devices
> marked disconnected, returning PCIBIOS_DEVICE_NOT_FOUND and ~0 data.
> The user config read accessors still issue the read, and if the host
> bridge completes it with ~0 data and no error, they report success.
>=20
> Check pci_dev_is_disconnected() in pci_user_read_config_*() as well,
> failing with -ENODEV and ~0 data. Do the check after waiting for any
> pci_cfg_access_lock() holder so a reader blocked behind a reset also
> sees a device that was disconnected while it waited.
>=20
> This prepares for converting sysfs attributes from the kernel
> accessors to the user accessors so they keep skipping disconnected
> devices.
>=20
> On a disconnected device, existing callers of the user read accessors
> now behave as follows:
>=20
>   - The sysfs "config" file and /proc/bus/pci ignore the return value
>     and return the same ~0 data as before
>   - pciconfig_read() fails with -EIO
>   - VPD reads and VFIO config reads fail with -ENODEV instead of
>     returning ~0 data
>   - VPD writes fail with -ENODEV instead of timing out with a
>     "firmware bug" warning
>   - VFIO writes to PCI_COMMAND fail with -ENODEV, since VFIO reads the
>     current value first
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025000836.5829=
4-1-thepacketgeek@gmail.com?part=3D1

