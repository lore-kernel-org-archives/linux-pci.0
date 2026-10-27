Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117570;
	b=PaxikHVAVZbBwnwM2CCl/7FrV7Fmscrlw0e+lWgtYt9dhXag8BUJ0tZ9AI2kxC0DgnG8
	 BjZItEXErSSYFlCeGEYoPl8R2aqXY0dT9DVY5yt11kS0yVN18yO8Lyb9pcImWMKFbrA57
	 VoNZkRY4E9Drg+Imp38YCkM8WG2cRyWIJCNI+t1cHhYwR+gz1VT7QiVJ8wy34SeY7Jga9
	 RSeAESWYTztlLIGVIthhWorhyBNbMKAjfB4ol/ghsrFpwLR6RbhD8NyGH0p2c+pd1pUJL
	 72wp2EBiBlg7+QT7+Y0a6FPEHGcBVEBDYt0PsMfAt9ca8kFWNwArm5YTKwG6MQVezvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W/TlX6cfzTJsmVjnLCNUAku2s4XKsThVMLxrxpf+6S8=;
	b=YMphGt69B/WgO0C6hp0CL8J6jhDhZGmsuxBoJ3NAuFWdiR7daxZkcCCSIysi1TpLy5GY
	 2/s9y7Ut/2/0q5rW+CUU/JA0vB5wjdMF+aV5tvYyPLjHSID/fjraIHjOS4NoLUUj2gZNd
	 RRJvFG3ghRRN97Af1BxgnKj06S9Fd4J15+IapF4AAciQYbFDWTVw8VSO+2Okf5EjpGDQt
	 CtyGv4yuzviiT2i5EOOpnHVoDerL/z3niqiIBzyUHmkph1qljKm/rt4v9Gl/IP9g1urNG
	 r/W783uIBDIuQY2wOz7rfr7byzzVbsEa6S+1yzbLciGjlYAePlD7cVtEfDeGunqJQRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6JyjsYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFA606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6JyjsYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA2F1F01829;
	Tue, 27 Oct 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117569;
	bh=W/TlX6cfzTJsmVjnLCNUAku2s4XKsThVMLxrxpf+6S8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d6JyjsYmfVmolE1BLN7jH18HnYfNuX0bJORco+oCj62pl5x6w9gRmSXCabNdOHmP0
	 wufimYUaqKWEBTnOOK8LiR0vQnOyFTMQqBYGGFgWXJsjtxdNIww/McUw+jp84DTHbT
	 V22AEEMJPJkSQjEx8vcdNCfZnXVqqUkqtkk7QBwpX+DDvxg7FKpIsz+EB9pMXCXmgg
	 gdjrcus0TnmFrJzlqGWXjy7+DLK5qUQZNDWOJLmUjDChGPebQpY6CC8KjbAyZKfBv4
	 TLmFdNnvWUt54H/Z2O6AnFoMLRaAJCulX/TyWByqrvPdkigf47dn8ADdkSPGl3ixLq
	 dkKFPwpPgzf6w==
Message-ID: <sashiko-outbox-186881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] pds_core: Lock VFs around
 pci_reset_function_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-7-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-7-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:12:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_reset_function_locked() now requires PF callers to hold the device
> locks for all enabled VFs as well. Lock VFs around the reset in
> pdsc_pci_error_resume().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D6

