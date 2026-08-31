Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A3357A25
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157064; cv=none; b=fFG2O8Vt5T8duUNGga9DoaSZlaAuqmMiNOpcYp8DLiJqTPQ3iwrlX5SvLOPIzhp5z1gqlcbgq3d66sreHpsDWNTKSVp2cZQQUaWqqx3G7vLmnv2DvONs/WYbIf76d/jvRj9g+LLG1zxNxkDs167Ed2ZBM+3RlsBln5ry/mpOCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157064; c=relaxed/simple;
	bh=MD+kkahZJBuohcTsDHguIhxcqXMVhPbEB/Yvb1Qkc/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X48L+mMMkc2paD0/qBwship92xjz5FJB5uti/qHChSwwzVjRnYJJDQrgc4RaQ/4fwXgHHh+uJ2m9OAf0d6sFXJtv1/EiRNvZy+DE7oj9vevkHqpF3QwLrRty2u7TspZitOCUZKeKZeOfoyZ3y2mQOA63m/48Jwq6EULADSQpzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2MZd2cT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2MZd2cT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A32E1F000E9;
	Mon, 31 Aug 2026 06:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157062;
	bh=IzIOz1SAP7VNHkfVg9CoqYNRHGi1ULuVFx0TUrQ4Fjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U2MZd2cT3x+XcQufRtHurtWcQQH3mpKwf7I5tfooYxsf+uabzRCRrOzVYWSEIzj9r
	 DqSKd/Q2xxrmHVYm1QWKjEOzPP7EqkxOkmHVt/NbKLGQvVTymX9CTGbAJH5Be1V6Ph
	 c3gyeIZ6epkzsakzFjhbre4nwMlkCw7arMMnWSsEjeKJQcTeddSgkehYSjITx4f/w1
	 XcxYu+Bo7J/EOx+w9gHvzu8vAeq9/hcuQqcQmMlBh0l8wiNPm/+IRUyMz874Eoz85Z
	 T8WzsLGRTZi3qR8t0v4ebTNlbYr51y+X9YR3+c184z4md5YxrS/TVMKcMievpWh5hE
	 V6dwmSg0CCo5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: pci: Reject IRQ vector indices that do not fit
 in u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sophon Z" <aiqubits@hotmail.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260831-fix-pci-irq-vector-index-truncation-v2-1-4030ea7746a9@hotmail.com>
References: <20260831-fix-pci-irq-vector-index-truncation-v2-1-4030ea7746a9@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:17:42 +0000
Message-Id: <20260831061742.8A32E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `IrqVectorRegistration::index` delegates out-of-bounds validation =
entirely to the C API `pci_irq_vector`, which triggers a `WARN_ON_ONCE` for=
 sufficiently large indices, potentially causing a kernel panic.
--

commit 1d05a4f88062a655f88b6ab70e939331e2445d7b
Author: Sophon Z <aiqubits@hotmail.com>

rust: pci: Reject IRQ vector indices that do not fit in u32

IrqVectorRegistration::index() accepts a usize, but pci_irq_vector() takes
an unsigned int. This commit adds a checked conversion to prevent wrapping
on 64-bit architectures, returning EINVAL if the index exceeds u32 limits.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 6741046ec1c09..1bf91973cb1f4 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -151,8 +151,10 @@ pub fn irq_type(&self) -> IrqType {
>      /// [`Self::len()`].
>      #[inline]
>      pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        let index =3D u32::try_from(index).map_err(|_| EINVAL)?;

[Severity: High]
This is a pre-existing issue, but does this adequately prevent out-of-bounds
indices from reaching the C API?

Passing an index greater than 65535 (MSI_MAX_INDEX) causes the underlying
C API msi_domain_get_virq() to trigger a WARN_ON_ONCE(index > MSI_MAX_INDEX=
).
On systems configured with panic_on_warn=3D1, this leads to a kernel panic.

If a driver exposes IRQ vector selection to userspace without its own bounds
checking, relying on this abstraction to return EINVAL, this could result in
a Denial of Service.

Since self.len() is already known and guaranteed to be at most 2048 for
MSI-X, wouldn't explicitly checking if index >=3D self.len() be safer and
inherently prevent the warning from being triggered?

> +
>          // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index) };
>          if irq < 0 {
>              return Err(Error::from_errno(irq));
>          }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-fix-pci-ir=
q-vector-index-truncation-v2-1-4030ea7746a9@hotmail.com?part=3D1
