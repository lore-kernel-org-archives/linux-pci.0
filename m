Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB64432FE
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135409; cv=none; b=ey5r1G0Dhhx5CMgRSthvWFHwRodUQ/3ME3M5bv/X+K4z2R+nD0yxz9PwmTdqLnyrTX5+9bCFGuKAwv8FksxW0uL91UPHts76ExRxbF8L+AZX70KKoeKhgMD4STJQ6rafmLC/WonIEJ5Eo7QG0q8ZADFt/GHjPfhE7HfQ8sQzOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135409; c=relaxed/simple;
	bh=Uwg6gCR8b708k96vja4KU4obuj1T+HDAoLHv4DH/MP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p525Teai+DlWVjQkEEirrvq+VzOsjtaWG5pbzY9SahLrfRrqbi92RmjGvKH0+Yx8jHxONSJe9pnsrR4RKQxdQLAWTCaJvSjKu9FV5Isp7bTq0aPe+iboo7pquTXflCttth7vyCgdIWtvyyQ89aIs53cSOBMaxTQS7KzZacPHHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyM+hxf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyM+hxf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A9A1F000E9;
	Wed, 19 Aug 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787135407;
	bh=8xMoFsX9OfmHYIPY9QEu2zKWVKkyYLOBBjn7JLcA2AA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JyM+hxf4rW9LtLU9AszxMKcbwvjF0ICsjZtyxQsD3AvKVb1Ta7ant9IZn1D2+vPCt
	 zhxWbzkrdFtm7MLNqB9ScbtEkWN+l9SmQ8eFiH3hBGnSe7vZkeCeBYvn1S4+i6rus9
	 DdCyJ0i1hxJXme1zfUmIgb6j7BlNo8YMVAzytFVmXpKOo6NY7705eehPMgznoZBWZ9
	 Q7o0RckuA4qDSMuvubo5atRJ/ofD/9rEPSmc+1I08xB9cel/BPwmTr9fXxAjI1zu8G
	 olWZ2kboMuDQI50hNBDmkHExxXV8C0n+5DSnKKS+yje9sVN2oAyXzLhA2b7kiyN3JZ
	 Ur3cnUbUax7kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable not supported reset methods on DG1 0x4905
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janusz Krzysztofik" <janusz.krzysztofik@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
References: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:30:07 +0000
Message-Id: <20260819103007.B9A9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> DRM CI consequently reports failing device reset attempts on Intel DG1
> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.
>=20
> Since consecutively failing device resets may lead to system hangs,
> disable both useless reset methods.  A respective CI test will then be
> skipped instead of aborting whole CI jobs.
>=20
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819102509.1662=
504-2-janusz.krzysztofik@linux.intel.com?part=3D1

