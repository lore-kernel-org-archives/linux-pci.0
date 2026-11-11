Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417207;
	b=yqJreHYCCFXhlXxR7Lvx37fHq2fd51clxPCfyREyA5m/HQsPC0KEjuAH7HlLiIH7RrvZ
	 sUQ1Y2RnI84pKauY07xGa4ROV6YLNNgPOWjxKmOBaoSbf7fVUshammDuYpU3KtHWS/mGs
	 vGEu2B5guy5oXVc+3xI22cGlZ/O0rrurCT82mLsFt2048vEcPG74hrSA575nHUhVaEsUJ
	 098gM8xhL7YtogxhSgAHYgQgpApWvs2MI7JNj+MuOwR+AZw8XpSvTpp6E0CtNd/xCLMWh
	 MzpBopP/VGriW/bOuBsit0SXsjXbl9/TnMrj1nGYqFqniCRETAWB9ZyoVsZrs5wvYXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UWSxnFgH/F4zFjsvtM7MKdYwQKOKNk2QN79MKyrS9+8=;
	b=o6oltJv74aSGz+qfDQGHagjojgozFu89s27xYnJeAS/gbt2ucjgJtzRjGOSQ+bIcAg44
	 96U+rwuWtmkPxNMK+lcwhYrlqo/AcfMsgMf7o8Y4ZnflH/LW15vX1pcdrEMQDDj5v1uOj
	 eiBH7nKp3gIboI0WasOkJmw0HHZOldg9IwcRXdwzMA7qYtQS19+Dojw84jvEtJr41hXkl
	 zNpBStZc60/Ua680ZPkPkQPNP4LDha1z4OaD8//cu4STqrWuy8FLeP/V0b507kebsREw0
	 je2OGUV6/MQ65qMXQWY2dFhTiR9EumBnxYD5Q2L1Ozazzm2+y9LhMS8Y/ZUYaPrdWNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwsE7+ss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB6606A321
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwsE7+ss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037411F00A05;
	Wed, 11 Nov 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417207;
	bh=UWSxnFgH/F4zFjsvtM7MKdYwQKOKNk2QN79MKyrS9+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwsE7+ssZqm1XTFstSIkaP2jXC5QQJ3ZWBTI963JUU2b8x3uuR12KkGL6wQhh9j03
	 eIAaxV396hzODtgZFzVoCfGrL7gxK0Up64M5TXQM7NBWKyBw8ldp14Xolsijz3cDQ6
	 Rgcv+xxjuu88yHsnFuQ/KYwxXCbF0ZG04ReWt/2jjWmfoDK1Hrt4RyIAvRMBnvvs8y
	 bO4T4YNGwP/jIjBN2gBXSxgt2Hi1D/UDZ3ddroL3dMQ7e88LbmvG5XVJ0BkhqJvxoj
	 iZqJ5YpVCs0BZand7b3Ds1vNiOGG7nh4Zf5retNk5DIOBLuPHW8HV0qHf3AfZCKGS1
	 OIaFqdTbAhOsg==
Message-ID: <sashiko-outbox-209388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111-vfct-regression-v6-2-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <20261111-vfct-regression-v6-2-393797bbb6e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:13:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vfct-regre=
ssion-v6-0-393797bbb6e3@amd.com?part=3D2

