Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965426;
	b=Z4UMCpY0aHpjpt/CRZ30PEducqNmdKebiXnBmoaCB82xIn1+rB+FPj9hwdS3nQRO0j9D
	 clvCBO6tW0s01F0s77c5w3e0bSchflIFfxZtnlDBC2Rkq8EvaZp1rn+XZKQ2HIdE5nxBL
	 TjrhNVg5tvRJZwRsfUqUzzhFx5B6vXdHvFURhlhO0BCl5A1aCYfBqV9RKoK9pZy/Fnh+M
	 JZ5C5m3IKD5jsui7NFSJoxecwY+gzVz9BQmTfvMkPmExkKaQSO9r3Jk6elNNk+qxinI7p
	 eyymIfziJGuFsqt/rklMKkVc2fWHdqlXU6ARwrWRGrqdwg2MoX2S7S95/uakF04H0qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dUzxBLdurIP8PEFSVuZ9FlMdtZNzH0oLENZbknDRoEA=;
	b=eeYLAt0jQ4wz9unX68MC8o/rexxhm79n9rjj31R7v+RMATPVPe5CpZ1UXKM24CVmDFVn
	 eriIRS1YaaTJVZyZ9D0s3CTsJJeQ5ZgxxCs292dzJeZyD0Z0lDUph5hA5OB4qfZpXFHvJ
	 6eegyquea6XNDYYLcQVai4tj0+xlfCCA+yetucIlbUoO4uN+B/Ku6B8QTiqK8flYomusG
	 gHtyk4cJ26Iu3NYVY+qOoaRSkMkRrPN74NKdShI7/0HB/EahRqBZurUKHGJiofooOI3ib
	 rDlYV01QYOJMwBYNdFfJO203VZ+AfTkXsR9lHB6pbxS6faLlZWtQQAtBLbJXZ59PX6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZ9+2bGg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26479606D822;
	Fri,  6 Nov 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZ9+2bGg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D11F0089F;
	Fri,  6 Nov 2026 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965425;
	bh=dUzxBLdurIP8PEFSVuZ9FlMdtZNzH0oLENZbknDRoEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZ9+2bGga4QcJG5anea4ZHpaOuQ2CBI6y/eFV4otY07fLD6/Aebd5lfSEJraLIVAO
	 QASSKD6kk5L0TFGeom5hVdgMySUJmfaLjiMG6LuBqdLXAFNvrtRTAcN8QSjxYez/uP
	 6PaR21eFmsbjCpn/Zw05uAwnyMI8ZoxUiQSfnGAr3EoJrtt2ss/kOr2RPuDhC2/jVI
	 XI4zdSVLR4G8ueieGN+cMvpbAewz6HH3HUX2Q5CsuNLg5MWQ3WL94kV9LTaOwKuVlj
	 pRv+KgI0SO4Rk3RzDKbVROyFASwFPTLAcyRHnSH5JNGqLJqYevF50ZJYvataSh1HnC
	 d1mbedteIjdfQ==
Message-ID: <sashiko-outbox-201344@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/17] driver core: Accept device trust policy on the
 kernel command line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-11-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-11-1e536825b4eb@nvidia.com>
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
> Built-in drivers can probe before initrd policy agents start. Fresh
> attestation therefore requires disabled policy before those attempts.
>=20
> Add device_trust=3D<bus>:<device>=3D<policy>[,...] to initialize requested
> policy before registration. Apply PCI overrides during discovery so IOMMU
> and ACS decisions use the same initial policy as binding. Retain rules for
> hotplug, preserve admission history when a device object is reused, and
> leave unlisted devices unchanged.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D11

