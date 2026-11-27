Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755253;
	b=ULJwjmcBSeVSYDDtrqDFFaJw31uaZb6oNBPo5w0R29XIufUGrPjAWHubbkSz2tx5kYzM
	 kC1n/9O3O1JHV+L62Ei42MtL0ozcRYhfd83rVBBA9H7nZ2sUJ9a+TKve6lS8JnuJGGDxQ
	 cmlkLkfeSFJuePCdh0fTvAp49/6a5h2sxSGso7L+36C5/rsYsahsEPl7TfOei5G0J7yMi
	 APiI2+Pmu2RYdaECPEQSzGR6MaNR5AVaYZIWRFYeYhcyCXtVadz5YNCkboB7jTTdxHHhe
	 PlrZ6b61bFRIquqkzYA0Khax51HyJSU49TWwg55Vv0csL8sQOl2oBYO245+Ys/u/XUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RMrELjUHJB51wzZmyb3bz96tzSMg7+VOnmxrIRytZ6M=;
	b=K1SfJuhgqvt6o8hzl79UVg+5m6fGFOMV7vRF/U0krtH1aSBCqqGzZWgTpDQyJsIV5MmW
	 EWAt/tBQPXZOasgRnHWN4Rh2Eg0lUevD7bfYpUHE19H5O2y6P8nBFpt3UiCxvVL0tujc0
	 gk/nxQGrMOI5E59N7w/UGRgCxIMiG3UkqNBsnnIKQS+odWGMs1KS3dCKtIwnCuU2TiiO4
	 SFeP4S4BipM5+uxcSdHREzBnYOsVfQiSjQyR0EK3e7amQxwFz5KgaRcifeO3HIw1vV5Bd
	 YawhJjPD3QRBWSPwPaVW4Rkwqt0EJJcF3FAuADeutdm8/DRB+9PehBl2QQIiL6Ghciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOjdj+un;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C62606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOjdj+un
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493EE1F00893;
	Fri, 27 Nov 2026 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795755253;
	bh=RMrELjUHJB51wzZmyb3bz96tzSMg7+VOnmxrIRytZ6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOjdj+untpEZ77ZJP5bmC2QvyVrvHH9U8oyWVl0YX4T1Iz7H7Rzk0o8S2ASaBDxF9
	 47D/bdbRpXDEA6cdC+uVFvY+yYJo5ADSWjYjCfjoMMyfp/DJsM4J2WpMSiRqctV0xZ
	 /sj1FUK/XHYmfFwcRZPyVI4+739yzkp+l6AjdZWT/vTLXcOZ8qg4MbNcY0GsHsplyb
	 x65X9ATzl5HXPr66bB87mmJ4ttZrXVRnoXf9FmCZHFNqovo4WIDvQyyj50deMc291C
	 /wJwFOOVqd1hZKCvHIiZ4GuZ3Jk2k3xWQEKxVRWKW1hJfTvfCcSzExJddKTeCC319J
	 kFXDLWYCdkejg==
Message-ID: <sashiko-outbox-236624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Don't reset a VF through its hotplug slot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samiullah Khawaja" <skhawaja@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127044458.2757857-1-skhawaja@google.com>
References: <20261127044458.2757857-1-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 04:54:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_dev_reset_slot_function() doesn't do a slot reset of a multifunction
> device, because the reset would also reset the other functions. A VF is
> not marked as multifunction, so this check doesn't catch it.
>=20
> A VF on the same bus as its PF gets the PF's hotplug slot, so behind a
> pciehp port the VF has the "bus" reset method. A slot reset of the VF
> also resets the PF and all other VFs, and only the VF's state is
> restored afterwards.
>=20
> Fixes: 10791141a6cf ("PCI: Simplify pci_dev_reset_slot_function()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127044458.2757=
857-1-skhawaja@google.com?part=3D1
