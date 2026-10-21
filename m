Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609571;
	b=UYGyTdjhj43Mt/ij3YpW147XD5j8p3iRIIsLsMJ50xJea8AZ2Ghyv9yIXA8pBMym0xwH
	 TCtyfW2avU9Qt1VJXF+z4ijE9ef80YoVLZBUCUB36FJkLo5f9g+fBEOGAjINed49EZ6ZF
	 Qmrj3dp+6WeA2ee6ps3kgzZJjFOx6/3IG5ZUbG+ZdtIcoeX5S1AiyYifjGqSFRRtIwICw
	 qaWxnne1aae5iEK8QmmoTx4Ff6WINn5JNlhZ0Pea11KVqkWfc8Z1Wibf2BWWlAAchEAu1
	 r0Z3XUsNU69t4JO+VMytymDJO7GmMFQY0lZRmIy/QzmUM9ZhV864e2VMWjhmGIunLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aiF8VK8Jh90E+el9vWXCuarh5jerR0iSSLHNb4OSvVQ=;
	b=CvzmZuDUTT8aCqd6OjvwxKOLq0a7PMrFsWtJVQQh3BcHPxa/VlCPkJeB5OGc6rok+gSM
	 0AL6kiPT+1Sk14O8wd0d6RsI2ljhNevNjC0UgM7qKBgnVrXzTh2b0vmluhbUKxiPy2HSz
	 B3rrpEG5oqPgyU5jbg2TOsIFnxpMnNLrBVoLVBOvVsXVcUEiPHB2MXvAjWBn2vk2iqG1R
	 Th7jt0i0pybRt/Yn6VLr6eQMsPXokR4l17vv+sXSVuqr16KUzPVSfR+qaccE9DaTl/CN1
	 fT75kAEaVGWGPivIVlYCSVT4DhbsLTB3a25DS4Ygu1gTvjburUhubXNBa6i59yjvTjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="motK/hnT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAB606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=motK/hnT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C11F000C1;
	Wed, 21 Oct 2026 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792609571;
	bh=aiF8VK8Jh90E+el9vWXCuarh5jerR0iSSLHNb4OSvVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=motK/hnTbXIWDOLZ1bgVMFL7MqbmZUczuBoAhsUURgddO2UW+NzArQR7QEND7BNNS
	 FY8O5dgwS0bMpSoEsHWg+Y9wS8tAV0e2G6QyWpXAumWN0AAA2E2D8TVr1EDrwPaTBJ
	 lxh+y8XGo8tFyyIC4G8tgQR3X1jKLhazM4K6w5Duf2iPem5gTbzoETQmxF1XLkkAyT
	 jJSYiscWjiJm8m8otCbBQHw/dtWqnnOZnLroEue7RmUjcFjopbHd67NNKMT8PLCQQb
	 wZjkhUAsLPi1IRaRN7rn+Ks6UFxHnqEXeperYJyHV98N5e5xqPUCxwuyMF3n+/rEDm
	 P83F3vYZdMukA==
Message-ID: <sashiko-outbox-180571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v3] pci: Add broken-GPE quirk for some Lenovo
 Legions with Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021-broken-gpe-legion-v3-1-097226ba8383@gmail.com>
References: <20261021-broken-gpe-legion-v3-1-097226ba8383@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 19:06:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lyude Paul <lyude@redhat.com>
>=20
> On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
> 15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
> port of the nvidia GPU very shortly after the GPU enters D3Cold. This mea=
ns
> that every time the GPU is runtime suspended, ACPI firmware immediately
> wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
> asleep again, the cycle repeats.
>=20
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>=20
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>=20
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-broken-gpe=
-legion-v3-1-097226ba8383@gmail.com?part=3D1

