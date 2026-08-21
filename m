Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AD26ED40
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343286; cv=none; b=ZFZ2N3YLYb3oKWfxha96rMPUUkfbgMHDH3pPqUwC8s0PI9Oncw3NeuEAI0OFZF583Nksk3B47sKq0Bn6zBGVUNwjpGSnfVOJ0RubOIqaJ6hKsvioD1Mp5OzzlWmrpp91HXZ80qBwyYWRL5K4M/uetR9hFjb9TTu6Vke85f/FaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343286; c=relaxed/simple;
	bh=GHeiAM/QKcU2aBrnp0t9lNI4f3+ZwJ9mz+89nspuk+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HivA9uSXmvO6Ft1Yp9OojIicxLYDBE3EPM1WWvQvzTfIuyBYOa9uhRuDUug1Zn6v5gZbHufX9eJ9Ew2cSTFeNLWWENy7QK+AYWESgO/ELa7P0GLXq2SmHq+Wm4KRbbhCEchL/kk0NxdU2yPuqRdbXhCi2nYtNREEmna87uQKEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhplyznA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhplyznA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B621F000E9;
	Fri, 21 Aug 2026 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343284;
	bh=GHeiAM/QKcU2aBrnp0t9lNI4f3+ZwJ9mz+89nspuk+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhplyznA3UDpf5jdid7g6Hkj9s4t7mNPF2WDMZjfm44r6KFLfMEvswcN0He+zpalC
	 rUPYy1FYH9oY+xtYyYfPOaFffAopfDnrl0+5Z9cMuq8r2nOfgPUYClAG2L+E/LZESQ
	 oSNFtcrRAlT45657ma1P0pwt/+JidVTxiDZCI7Vr38VBkjsh6WEBbT/ftE7UthbY3d
	 J1hakqaw8j1GWG1edd8NdayHUlevEDFG0rH4gH7myJ16PoZUbwVknAkEskld1mRMfl
	 7q1OgRNFLriN6SydpN1e1iy+HSmBmuSk1Iap0IdyLzOMqXh+tMV8zT3xWq6Wa4jpH0
	 mNlVmtKYcbMdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8
 and 16AHP9 Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260821200607.621341-1-lyude@redhat.com>
References: <20260821200607.621341-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:14:44 +0000
Message-Id: <20260821201444.89B621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to en=
joy
> firing a GPE on the parent PCIe port of the nvidia GPU very shortly after=
 the
> GPU enters D3Cold. This means that every time the GPU is runtime suspende=
d,
> ACPI firmware immediately wakes up its parent PCIe port, which then wakes=
 up
> the GPU. Once it falls asleep again, the cycle repeats.
>=20
> See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
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
> Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821200607.6213=
41-1-lyude@redhat.com?part=3D1

