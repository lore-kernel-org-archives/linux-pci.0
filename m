Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF73346A8;
	Thu,  2 Jul 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007589; cv=none; b=cvhP9S8JLZ9xBVhZswq93Bue8VA2joEFnVDtXNcPT2HohRCXFBy5B7ywiwPVPxg85zI0f0J78XsPAB7G9DYM9rYozp1fjC3m/qYwALBLHHieDH7Sphz5KD+LUctkNNTKP1W2EzDfMmY2Qfmxfkj5UNgBryMBYAK5ubl8+1fty6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007589; c=relaxed/simple;
	bh=VdNLw1AHjIwxY+Vg+6eZfZKG7g2sOWOkYPUSzbquVNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7rMim+ySM+ffntFh0UU+ZRj99nRalkQEKmC51tolt+qnxO8bS9JyYgVxuK0O8e34Kdhs8LPgE+A+NWe1+wf/vCM1B1Dxf6IOr3/RIiaguMFVD/czbofr0UOTPN4MWxfKwojKlxrHXaVlt+qhOnDHEscoD7duESQ09uDG5i2Fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC3PiQcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC3PiQcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CF01F00A3A;
	Thu,  2 Jul 2026 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007587;
	bh=VdNLw1AHjIwxY+Vg+6eZfZKG7g2sOWOkYPUSzbquVNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MC3PiQcHKgkw7DU1S7avN4kGIlYm7M4s/1rIiEF8+uVF0PxstCS64X8FtglONBkn3
	 L/Un6l1Sqig7xrY6kWbErHshgFtUbCf6PUeBEttb0MHQOEoXdRQDk2F67/BAtEeBx5
	 d+Nqc9IiSjV1zvMkGXLr6tik41LNoMYCWyG3Q9auV8pw5bXCYKVWrSO3MtAHcNwP5X
	 x93J0kgyWx4Ya4ooIVrojwIq9/RExYYNBb1Zcbw9B6E3FnLKDAaaeRPTjvhTyAyMRh
	 xdv7dvDzmD72mctyk3Z++xp06ZDV6n4VOV/CMp4Z8cB/8jGyqIn4jgvRNM5gs9isVA
	 RCnKrscS1CJNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] fpga: dfl-fme-perf: Use sysfs_emit() for
 cpumask show
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260702154725.185376-7-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-7-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:53:07 +0000
Message-Id: <20260702155307.71CF01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cpumask_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D6

