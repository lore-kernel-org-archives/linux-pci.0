Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E682377A99
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205580; cv=none; b=TIqHbhpC+rX+IX1FQ7tTlyvRQkip+jaficP9UdJcJbjO7Da+dWv4DUufs08F1uwgoMSb1DAfjE/Wiu+/+a5uqb3GsngOUjI4aaLGViB/cA0hIBr5+e6CChfQzh4nLhfIxQnRljbQb2R68wjSIr7qZF7GzUbVmlOPxWdTz9nVUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205580; c=relaxed/simple;
	bh=f2NmndtY7RCKltp9GrbvpGWWVdO1m1wy9Ct2uDt4EsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uHVBef8fBP03n1ookwC39tSe9tAGMwbp6RoulCf8LfNVjFMnpKFfj3gX6cbXtqTuKaJUxba8/PV9kCrzFZ0VI4LY4eDgbFb4gqzB4NIf37c0PBtt78yOeKIZKQSGIIb5tOMeBZBEYcwlZT8zqPoeK44NfXNBf46p4gwuMWEGZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyuLzuSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyuLzuSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E6A1F000E9;
	Mon, 31 Aug 2026 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205578;
	bh=tRQn8gm11xCkD1foydzBVsEpC6Rw5OWfkBV/WtLIE00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyuLzuSmanVaS9UI0ZGBp2/UDLZoQpPzAMExx5HC2bQbAIehhqrqBYjbWgkJq3JmZ
	 ZEGeepnTfNmXVFE0sv+N30z57fkS1FAg7Fzr8xWWoUFE9Njf/fn6MdPCu1qkJEBw0x
	 drpESuO5RciXOSBxnEEFMkDHbkWAY4HZDe6Tvs5tP8atUAQrU3AHa+pxAyy02goR/p
	 nOhRRtib9ws2wFtfVy7de/Mn5OO0bpDJp9OSgzrXiq5WKbFRgZZ+psdM8sHegS/K13
	 EqMUHUmKZHi4UCMg4pCvWJujgz63emIBFBkcLqhfW8a3n8hDUoMa1d2R+LBzyUQAR2
	 PGO0jQ5bRKNJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sophon Zhang" <aiqubits@hotmail.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:46:17 +0000
Message-Id: <20260831194618.63E6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check in `IrqVectorRegistration::index()` leads to =
kernel warning/panic via C API.
--

commit 97b70137801249b8b3a7409015c5b394925bf777
Author: Sophon Zhang <aiqubits@hotmail.com>
rust: pci: reject IRQ vector indices that do not fit in u32

This commit attempts to prevent 64-bit Rust IRQ vector indices from wrapping
when passed to the C API by introducing a checked cast to u32. It relies on
the PCI core to validate the range of the index rather than doing a bounds
check in Rust.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -151,8 +151,10 @@ pub fn irq_type(&self) -> IrqType {
>      /// [Self::len()].
>      #[inline]
>      pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        let index =3D u32::try_from(index)?;
> +
>          // SAFETY: self.dev.as_raw() is a valid pointer to a struct pci_=
dev.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index) };

[Severity: High]
This is a pre-existing issue, but does relying on the C API for bounds
checking violate Rust safety guarantees by triggering a kernel warning or
panic?

If a driver calls this safe Rust function with an out-of-bounds index that
still fits in a u32 (for example, 65536), it will pass the u32 conversion
and be handed directly to bindings::pci_irq_vector().

If MSI is enabled, this eventually calls msi_domain_get_virq() in
kernel/irq/msi.c, which executes:

    if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >=3D MSI_MAX_DEVICE_IRQ=
DOMAINS))
        return 0;

Because MSI_MAX_INDEX is 65535, an index of 65536 will trigger the
WARN_ON_ONCE, which can crash the kernel if panic_on_warn is set.

Furthermore, if the kernel is built without CONFIG_PCI_MSI, the fallback
inline pci_irq_vector() in include/linux/pci.h will trigger a similar
warning for any index > 0:

    if (WARN_ON_ONCE(nr > 0))
        return -EINVAL;

Since IrqVectorRegistration::index() is exposed as a safe Rust API, could an
explicit check against self.len() be added here to avoid relying on C-side
WARN_ON_ONCE checks for validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-fix-pci-ir=
q-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com?part=3D1
