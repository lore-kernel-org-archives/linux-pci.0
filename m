Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296117;
	b=pfxs3ruE68Fmj1XKzRtT+OyIgFGdcAdNWxDzE824XRd8w0M6LTdg1JmscOy1l1fuIN2Y
	 U+V0MCY0cKhq07MN7SimEQQq2W+3Ji2sOneXbHpR64fcMMt700rCUf8cfJw6HrAVBJugz
	 6g5DDSxOJVeg508Om12TJzCMISqrigPE5YrG6nOsstBLP5UB7OHwLmJlTuS1RY04kHcJM
	 n1TkhR6VWlEKVWx2cfsojzCxBNn/rDky29BpfDNFLArchy4LcoIKA/3hhVqAbugnACbCW
	 /1K4CJqz7vxLTTqVheB+apJs3jv/gMU37vYNwmK0lVJahrCX37+fLHWuts+JbHYWOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fOS5Kpwx2YgLC7GnBclqDBmJkb4yUyEbMuzytJVGQCs=;
	b=Cah/HX2HX9/3MXmPjSrmEWS8XMPZpMf4uKZkEn0qCA7DCaQmravyo97Egl9KPG9JKRXf
	 N7uLeLtWzePDXsbik4aLCraFOhG5KOBYu2RGcm4CranZ8NqGDXxohROb804aji8A6yZBz
	 Cj7nYEx+SX7LZR9puVLuFv4a4R51xDbQvBFiInLCxdNYOCYuxKn0nGQeUsHe70WQYEBSv
	 g3p97FOel/cCDc+dGyux/P7ESXI8cUSavOCoqeS68v5T6NjmWWYr85RnQNHdVRSn7jzhQ
	 MbaLIKVsZ3Xff+kcEs30oefxh996rgyGaOTEjUbFMzOcJJLxHhKewYV0W0RHuctMC/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arHJ1WYb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B09F606A333;
	Tue, 10 Nov 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arHJ1WYb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487601F008A3;
	Tue, 10 Nov 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296117;
	bh=fOS5Kpwx2YgLC7GnBclqDBmJkb4yUyEbMuzytJVGQCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arHJ1WYbw/nvikLrTk7iYGcPlQM/bSYoRV4Snr2CtaDN8pba1lR+J1XWVF1Ykd5PZ
	 1UpMdYB194+7rL7R3yrwrShZ6eUyH/joombvHWKwxPyNEK+ewMLI/zJYobFqUSnrZ0
	 g0rw0XyLSf18jYcHNZIfQ141aDEPrj8MbCmULNSblngz/KOSrNrp1sC9Qxx4j9S0dP
	 BuNkBrO5hpOSMvtqXlkkRBRGOtucemYnJ9Snm7S/xxqfna04W51ED+qPah2xvToLNp
	 K5ZPPcwVlHegwUuDUCVl3925ijltS5fEbbqEZcMwaTcv1b5KuKgZMtczGc7inI37d9
	 x3uQkDw3HopDA==
Message-ID: <sashiko-outbox-206507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/19] driver core: Report deferred probes through
 sysfs drivers_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-7-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-7-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:16 +0000
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
> commit b8c5cec23d5c ("Driver core: udev triggered device-<>driver
> binding") introduced the concept of "Systems who want to control the
> driver binding with udev" can use the drivers_probe sysfs to trigger a
> driver bind based on the kernel's match list.
>=20
> If attaching the driver is deferred before its probe callback runs,
> userspace sees EINVAL and cannot tell it should try again, maybe after
> loading other drivers.
>=20
> Map that deferral to EAGAIN and add missed documentation for the
> drivers_probe sysfs. A deferral requested by the probe callback itself
> is still not reported.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D7

