Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49364A8C
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978881; cv=none; b=NtZlxcATKKarfZ/zXMXMjnX7PNL2zy7Kc6ZOU1ooV4cdYYPgyDzi8VVxYhYHDcQUuO55s7EOsclRde/eXxPdYY/Cuzkoz7+7VQcxaKqwveHTAhswUEOe3ZxitA5hx9rwxtJ1e5ElAWbMBM32cq8Os1kGcdjJyE8PviKnzZ4un38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978881; c=relaxed/simple;
	bh=Pv8JRgsRYA+GpO+uIE0LtznSmw+HDpDdr/kDFLdb2UI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=poIw5COnetRDKQVg2z9veHnhR/y/ectkQfvGUZNPkhQrUGEO68qbNdWQo4MI2JTmZ9OQNVYQg5lG7FOAHEXT2wHfYaLYaCMVkB6rTf2xu1cujOZvw5YmsHjuThXUOlhWRUak1X7f5AD3jQPvZ++VmGtEOIUGvxqEqfhXS8zgHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOPA+0Wn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOPA+0Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7903BC19425;
	Sun, 17 May 2026 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978880;
	bh=Pv8JRgsRYA+GpO+uIE0LtznSmw+HDpDdr/kDFLdb2UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eOPA+0WnRjoSnRNBenPqooLDnur9Vv8QiCOP23JQ1LK1w/W24NT5tH1M2VLu0K12/
	 xxeBmM4V4126ZfVosqiv+Jy642vq9N8kz6t1YXwZA0VAfh/IYncgHq50ghHG8qvRKJ
	 +Nz2j2abRacy3Paznb39wfROROXhCH6HzPK/F7WLf3ZKcMv8YYB8w1e5sqv6kp/0PZ
	 lMTcMeHoHdCmqpWBgqb2stjw3W0h+AIhjyaUVj2UfXWiOVuBK+VzQdP7WYPPuXO0bP
	 8Mr5hNMWzia2qvawGVK9RBKmjoeUhnoO8fBNTq3QYftIfNhGtLEoESTKr76DNz2ZS+
	 sYBk26U/ZKQMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v3 27/27] gpu: drm: tyr: use lifetime for IoMem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-28-dakr@kernel.org>
References: <20260517000149.3226762-28-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:47:59 +0000
Message-Id: <20260517004800.7903BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Meaningful mismatch between the commit message and the code rega=
rding the I/O memory type.
- [Low] The `dev` parameter is now unused in `issue_soft_reset` and `l2_pow=
er_on`.
--

commit 763cc0c53067cdbb12995b72ad25897a1324b9d9
Author: Danilo Krummrich <dakr@kernel.org>

gpu: drm: tyr: use lifetime for IoMem
   =20
This commit simplifies the memory mapping during probe by using the mapped
memory directly and eliminating the Arc<Devres<IoMem>> indirection, which
also makes Register::read/write infallible.

> Take advantage of the lifetime-parameterized IoMem<'bound> to use the
> memory mapping directly during probe, eliminating the Arc<Devres<IoMem>>
> indirection.

The commit message mentions using the lifetime-parameterized IoMem<'bound>,
but the code changes the type alias to kernel::io::Mmio<SZ_2M> which lacks
a lifetime parameter. Is this difference intentional?

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 8c916913e9765..884c20ec18cef 100644
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

Does the dev parameter still need to be in the function signature here? It
appears to be unused now that it is no longer passed to regs::GPU_CMD.write=
().

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

Are there any remaining uses for the dev parameter in this function, or
could it be removed from the signature?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D27
