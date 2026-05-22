Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B0265606
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410562; cv=none; b=TlSAqPbsV36G1cg8iuwXht1TZ3xH1YcinzmBQRnIEvRpD/wrMi4pM9qx3mpvMl0pYHimy7GL8MyauvI6I/ZXwUYZgXDvc9sspBQ1DHtENghUHW7ARcr51J98kztLkNE7j5MMigVu8iQQkXjY+sP1ut/YmBCzowCexDReurwsSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410562; c=relaxed/simple;
	bh=LOHztHCcxUpuq3d76Sn0fpYvkUVv76WvIB1JPpmVGqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNejh8SoVXseF2CE1csftKmApA8G2sP1DLTNdMBQK15QEQduo0o5jyrpGKjOqwkyqzWvBzoGjlc+iJgE6wZMIrKowhDlmtoEkCUEnfrKA90GQ29gkEDAqsZHj5sblZTJRK86uxmlqBpxNfd4enlP3nBrAKJZpTgoY//gOOlysXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY1Mpc3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY1Mpc3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B6D1F000E9;
	Fri, 22 May 2026 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410560;
	bh=o9ZGRL6NqSUnqYCGqcaWcX00kUf72fUIf3rCqp/pqYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dY1Mpc3cSsurnXlkHHFCwxyepm5/AXYVC6G/MmAPzXoIyAQyT/4m6DQyfi62EhLZk
	 wFvCuCG/LNYOdrC256FASHgrRD8Ta24rNz1ZzgUkB+5EFBBVmw5B6jdB/4A/e0j4JY
	 ftUBRs8DMBCx21poswxrxqr6juERMc3ZxBqeWZ96oT5VU2jCPqyjRLZfOFtsvcQyCA
	 W+05+ABMqqimT2xTklNeVKlxi8JXG+Oepc7n/ha9sSQE0PwAkSqn5Poyf3kCbwopXe
	 4YYhzlOfojITeksQ7q07dPvsvxjz+OPErX5wH2j5LS4cYxg6+mvjEjfhYVrVZMjigK
	 ns0TgVk1zRL/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v4 27/27] gpu: drm: tyr: use lifetime for IoMem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-28-dakr@kernel.org>
References: <20260521233501.1191842-28-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:42:39 +0000
Message-Id: <20260522004240.91B6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Commit message and code discrepancy regarding the `IoMem` type.
- [Low] Incomplete refactoring leaves an unused `dev` parameter in `issue_s=
oft_reset` and `l2_power_on`.
--

commit d5f1fb446208aa007978c5b149d5671f94e218d1
Author: Danilo Krummrich <dakr@kernel.org>

gpu: drm: tyr: use lifetime for IoMem

This commit simplifies the driver probe path by using the memory mapping
directly instead of relying on an Arc<Devres<IoMem>> indirection. Register
read and write operations are also updated to be infallible since the Devres
access check is no longer needed.

> gpu: drm: tyr: use lifetime for IoMem
>
> Take advantage of the lifetime-parameterized IoMem<'bound> to use the
> memory mapping directly during probe, eliminating the Arc<Devres<IoMem>>
> indirection.

[Severity: Medium]
Is the commit message outdated? It explicitly mentions using the
lifetime-parameterized IoMem<'bound>, but the code actually aliases IoMem to
kernel::io::Mmio<SZ_2M>, which is not lifetime-parameterized.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 04f83fcf09371..d0aa421295305 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> @@ -65,11 +63,11 @@ pub(crate) struct TyrDrmDeviceData {
>      pub(crate) gpu_info: GpuInfo,
>  }
> =20
> -fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Resul=
t {
> -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> +fn issue_soft_reset(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +    regs::GPU_CMD.write(iomem, regs::GPU_CMD_SOFT_RESET);

[Severity: Low]
Does this leave the dev parameter unused? Since the Devres access check was
removed, it appears dev is no longer needed here. In Rust, this triggers
the unused_variables lint, which will cause a build failure with the kernel=
's
-Dwarnings flag.

> =20
>      poll::read_poll_timeout(
> -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> +        || Ok(regs::GPU_IRQ_RAWSTAT.read(iomem)),
>          |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED !=3D 0,
>          time::Delta::from_millis(1),
>          time::Delta::from_millis(100),
[ ... ]
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index a88775160f981..bb0473c85bf78 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
[ ... ]
> @@ -208,11 +206,11 @@ fn from(value: u32) -> Self {
>  }
> =20
>  /// Powers on the l2 block.
> -pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) ->=
 Result {
> -    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
> +pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +    regs::L2_PWRON_LO.write(iomem, 1);

[Severity: Low]
Similarly, could the dev parameter be removed from this function signature
to avoid an unused variable warning and subsequent build error?

> =20
>      poll::read_poll_timeout(
> -        || regs::L2_READY_LO.read(dev, iomem),
> +        || Ok(regs::L2_READY_LO.read(iomem)),
>          |status| *status =3D=3D 1,
>          Delta::from_millis(1),
>          Delta::from_millis(100),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D27
