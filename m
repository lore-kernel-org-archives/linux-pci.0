Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258786;
	b=fI4ZeHD9k2uj1DVgnPXLiyKNnP0Dmu+jhbY66swVKdeOV3Nhl+Vb+KhiOkAR1AwcmRb7
	 UbHGAGpFu4JQSVWWvk0TWKnupxjmLYJf4ynQgszc1vNIhKLhQKJIB/PJw2lpajde9hArk
	 lNjRzHgJBpkc+CyFBV591gUODvxQpLKVO8HRBNuM7UEUnqqNmVa3ZGYKFO79wdFyVuxDU
	 XAQhiD1Y8CE1z9GCG6tsIk6VqbCkMnF/snfkEiAW0EqBCKtN2LIG3l08DTqY44cgen6GC
	 3GlU3cHfrNHDjULm5qh0vyRhAOtTY1O0BXKMGbIqjrhrMRnx5o0wD1FHlVKS6H+J0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+cl+JjoGAWoRyOQHF1gvf9E3ETrJwmzNpd/pePKLHuQ=;
	b=vCRr8sawQOaxkx6dNyqCAthJ0CNpykJ44VXBtELwbMQznpciwDrSpFPxozQ+c5375Eqc
	 BL5t7BxCMnCfIESd7erKfm24vSOEAb344xtjIK2VmQgGiAoIiMtnUA5GKxIYr8XiX7po2
	 bg1ZbQBwrjPedq+f9g7fhMP/UzQ5iL3P6G1tDwQyn+WQW6Mx19EsT3PXIrnw4JZBQur8O
	 Ul9fAAglbkY8BgxKxEpQ7qDV1nnGP912J4kJ3dFqpdHOW7jeoKS/3b3ZaQduMnUct6h8e
	 KJGCbJyXB1YSdR5jDw7rcYOWtC3tqDQQKUnPt5fh7FJNnhId4jgekEiEW3dHc7PqYIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KSC80/3Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D02606A32A
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSC80/3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD481F008A3;
	Mon,  9 Nov 2026 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258786;
	bh=+cl+JjoGAWoRyOQHF1gvf9E3ETrJwmzNpd/pePKLHuQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KSC80/3Q//N4XN1cR1J2kN/MkB4G5hSy6RqzRTlZ56NJLRx1yMzDwYif6rYDr+0Mf
	 06q7evb5whJUtoOvhp1wpCa/o1r1NEReY3ePwvdmmK6YsypZWBezdKf7pOuRe0ky2O
	 LORnjMF+1OaJpYAw8pxPtUSQmuZaSlE5h+AePbyzr5khI5k37ZPI11oN1kawLBDJxI
	 XfZW3UkB7Ho6d7dTN2z8jP9LdyM04EExwwKyZ99rT/6rrKJ2lng29KoQkc4UmCvxj1
	 Hkj+J7eF5/R0pSaP42G/SdRzl4mQvVeK1AwR5N8kgZY5Zr5FmR00uIePX05ZHESzJN
	 Bw1lnxdDxIzyQ==
Message-ID: <sashiko-outbox-205645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] PCI: Free device name when pci_setup_device()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-2-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:13:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_setup_device() calls dev_set_name(), which allocates the name, before
> it can fail on an unknown Header Type. Its callers then free the device
> with kfree() because device_initialize() has not yet been called, so the
> name is never freed.
>=20
> Free the name in the error path of pci_setup_device().
>=20
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id stri=
ng array")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

