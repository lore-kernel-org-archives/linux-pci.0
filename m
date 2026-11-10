Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296122;
	b=PQI3cNE4rhG33CEcJUCPj9sQUs4sS3mTbYL00DLUTtUyHU8CWah5INGMK48fkY+qWGin
	 5lFo7QBNH49WfQ7Poio0nGcJlSdSyGyIB8aYof2Bc+xz/TVjX7SgypoOybuCLLEozshwZ
	 h6jwjgMU0jvM57saNhejmTHJyFNJL0q8uOi92dfRrCVIEgrJ6nQOzaPZmwgVlovufI5DT
	 8KupwraXtV6rQDDzIuaMhfYH1rUOU1FUTNI+o/i4yFSHrV51NCSQ5gr6grvTUB5HrTlrr
	 MOdc/IF/jpeb892SxbnV+540o2lG/xMbKOoHwKtpBaQYex46qY4ar4WNo7HFo5iBKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5puLh0Jvdg/9w3mwE9m1JpUr77HCGYNVbZHo7OLDlo0=;
	b=MWdA07/2+Zk5c5V1AM3Pel0ZMCe3tUAzLE9A3p2lMMYKO1KB8uhZzNkzq976BetCxpI5
	 rG7AJZ+h4ZXeq8IfdZOeeGEa++7Bi7ZeFBcVsBusOm339AmA4kp4SQucVKTGmB2SUE1rH
	 Pc4k34KPecTVgIoPijubr7micwJK9TfCYTxLHyx0iUgP1rq9j+9OOu9bBSYbQliIALCfl
	 tYIqCszWbhcJ79HZ6FQLcIOAEhTgQrPxxIaFjVwkresxeuc3MUFRwkS0ta4FBFd3O0FWi
	 fShAOmobuC7DjJkUKj/a6sKuD59W9leo1j22giYn33elX6nsrhK9beYZxjD6AEIikgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GWdAoaS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB960A263A;
	Tue, 10 Nov 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWdAoaS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5D21F00904;
	Tue, 10 Nov 2026 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296121;
	bh=5puLh0Jvdg/9w3mwE9m1JpUr77HCGYNVbZHo7OLDlo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWdAoaS/6v39+qLF41g2EV7WEQj+TN5y7THs9hkRl5ZRD89Mna9+uSU9aRFBZGLgX
	 dkFJ5ddC91GYEYii/Qv38NQrosFF3sP7ZW90LWl2cQ5whtv7L4Nmjy3Kx08hvjNENY
	 vnetj5MQpWh8JcJP023oFlj/nMlnZr6T6aoa6p7isNK6csRhcmkZSIBpPSciYkWpGo
	 ryQO6wL9NQItbKLQOgOfT50mWJndRBrRVoyolEfik7eqjWKUDT/zzAp6i4qYZXNGmc
	 aFPTYa3+x3cgEVs0FU+uGBhfidRLDwZHs2YYXoG+r3anh7eMqqQJivUnkhR66OybCI
	 VhGM71I6l7GNQ==
Message-ID: <sashiko-outbox-206512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/19] driver core: Expose device trust authorization
 interfaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-12-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-12-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:21 +0000
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
> An initrd must authorize a disabled device after attestation even if a
> built-in driver already attempted to probe it. Buses with their own
> authorization interface need to apply the same policy rules.
>=20
> Expose requested policy and active trust through sysfs, and export
> device_trust_set_policy() for bus authorization. Fix explicit authorizati=
on
> or commitment for the device lifetime and serialize writes with probing.
> Under the global full policy, reject changes and leave same-value writes
> as no-ops so manual attachment needs no additional lock. Include the
> attributes in device ownership changes.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D12

