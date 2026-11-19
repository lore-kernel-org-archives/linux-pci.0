Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052034;
	b=O4u+Ux0m4gOjaaHZ2zGdsXrUGlWknTdcobfIkGKaURJ9lvpfDL11K8QQaD7Ho+vmw0Vl
	 dXoGzTazfXQhJj0ziBPqPs23vW4LdYNwgFBtsyY507eAi1UizKnTd5p4zyfq79rW0bq9w
	 G9Ke94kijyRh+FRmuCkhOxbOZ/tgBeM3rMinCaKAU8GI6RtFni4VVX/HoOm1D9jMnfkhk
	 WZO779IVhnKfTiObNCKYknJ0AOA0pKNsXqr9m10rxnSsRLpz/nLFpLWCi/bswc+5XcL/2
	 b/1fqhsQhWXMbSisFEtoGjv1edjFg3NqVqsEVWD7Hv7BvXa9oLio6wgMiwPFNKqMiHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ttoFn+PEz3sJNPj5kYZtpkgOSOifV2xKr7YtVP6yAo=;
	b=At1/VQKWeargEUnLb+Qeq4CIoyqXPM3uvmjBOdfP+kcJglJ3cATsMZD4DMi7pBdihWnq
	 fg4OnjlQWGS5tzwSET++TbWrgwU826CfXCgdBFFFuyMkTktpxXtpIIHN7Ks2LoRhyW479
	 Xr10LJGWfHPcZY8Vwc5RkDPUXLrEai3HJF8EmeFpO0d/PHlCKzoInzLPBlEgu0LbtJHw+
	 Pf2sSaY+4WEF5aG3euuWuqXeRzv9P+bwPrGy/RgFjXwXRQq1dhQL/aXppsFsSpd8I8ld6
	 FDucdZaRE6UlYwZ1K8LebEGbm5qvrgrEif2HhBbOGIKyHwEgFt7XjKnQ/5OTnyTUTcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e++pwj7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D26606A31C
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e++pwj7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E21F000C4;
	Thu, 19 Nov 2026 01:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052034;
	bh=8ttoFn+PEz3sJNPj5kYZtpkgOSOifV2xKr7YtVP6yAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e++pwj7sn+ooeJiLWmTVN5Hxuo7X14gLwRfhcep3DmxWhuPbxrYv3rCatbMFyMqC7
	 /FqBU0sVq30lt+z1O2/4iLeM5sINJNermMI+oMlMJ6Z4cOXFbshYQuINhNhfzduYVZ
	 ZcZMSR2aRZ/XjqLCQGvUcIhJsmYyI2V8cd4TcZZBoY6rodKgp8hZyCScGkeTvaxcaz
	 4/DO2+2ep4EiB7wIo92dSlSc9MfoXBfBUIJ/FIQgchxGlyMf6n2FmBbLrVDuzWlJk8
	 WDx8FQ7w5aDLrRZg7nvCi3TXn+K1C49FiPGrwGMxTTMAFF6n3gk0TBlvm/OkM0vgR3
	 6jI+niUXtCh1w==
Message-ID: <sashiko-outbox-222283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rockchip-host: Support hibernation with endpoints
 in D0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
References: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:33:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> The driver runs its suspend callback on every system sleep transition,
> including hibernation freeze and the quiesce step of the kernel that
> loads the image. The PCI core leaves the endpoints in D0 there, the
> link does not enter L2 after PME_Turn_Off, and hibernation aborts:
>=20
>   rockchip-pcie f8000000.pcie: PCIe link enter L2 timeout!
>   rockchip-pcie f8000000.pcie: PM: failed to freeze noirq: error -110
>=20
> Keep the link up across freeze and thaw. On restore, power the port
> down and bring it up as on resume, because the kernel that loaded the
> image may have left it in any state. The port may already be down if
> poweroff_noirq ran, so track that state.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-b4-rockchi=
p-pcie-hib-v1-1-05df24cc77e6@iav.lv?part=3D1

