Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD9499F2B
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640773; cv=none; b=Mb7F99YEVIS+fK/nH7zXA1mlPhsWtf8MgMvz367Mm/6AX29qvaX/pyWaUinpojYnqkDtNevfeICG/liWLtp/nmWFpIuoQ9SElcws8N2MtCLlXi2/dm0Nwq4FRBMDUBk7/d5qwcUj+F5hEt3VGsQFXo8lk5EA/ZOpjeokKk4ilic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640773; c=relaxed/simple;
	bh=ipCx+Ipu9Q6xR98/mgv9WAyUuTKkf4moSDSUoP4BPs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ul+g0lbzG1YjrqtulVNunAXRrWB4HpkWeJLkCv4mXVpylRbVtqq4rUIunVGml5RjStNdSSUk02T+4aQfGeAPEnuo8NOKa73zbhsHlOCXCe0v/NHzrTofh3Aqf4EfWpyBIrGq1rF22VQuD65ckiZahRy2zAyDaq/mrAN54KzJvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/eQ9qyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/eQ9qyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02781F01559;
	Thu, 13 Aug 2026 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640772;
	bh=0mywV5OmxIOAQunk8x16Wx7/jRDml6jNvROOY5Xsc18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/eQ9qyvaNsbcv7/3QsoqHg5YDvSbZJJ2OAEZsPekd+kZtE5Oq9XeGjydrdNEKO/y
	 QW97EjkpoIrsahVZeCPBLzVXZv/1U6qWROHgyAjSvFrRt0AHj64MK2eXnM20LXJDsI
	 t1+dmi6FEe0+WvzjwkpW2o2NDEGbnopwCcd1kvYk6jymtfNMYdY+/4IjD+6LUS2i+4
	 +2OMNtkbksoCOZnmDnqX65eWxKwLQ/eeFUQiMke7NoKK8+kokZesp11zj3Op+fGf/L
	 R/PGXQdmcBVN8Lx3YK7Jhj9n8YwBG3ikqaDAIKpROVScHJG+/qiCYzgA9V1De9wDHu
	 1XoBYwDigw7aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260813165234.620555-2-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:06:11 +0000
Message-Id: <20260813170611.A02781F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The lifetime linkage between `IrqVectorRegistration`, `IrqVector`,=
 and `irq::Registration` forces a self-referential struct design, making th=
e API unusable for device drivers.
--

--- Patch [1]: [PATCH v3 1/5] rust: pci: convert IrqVectorRegistration to a=
 lifetime-managed owning type ---
commit d29a976d8fb0d09c0565565666049353a896a317
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: convert IrqVectorRegistration to a lifetime-managed owning type

This commit converts IrqVectorRegistration to a lifetime-annotated type that
owns the PCI interrupt vector allocation. It modifies IrqVector to hold a
reference to the registration, preventing the allocation from being dropped
while vectors are still in use.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index fea484dcf9cf2..daba86505cd2b 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
[ ... ]
> @@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
>  #[derive(Clone, Copy)]
>  pub struct IrqVector<'a> {
>      dev: &'a Device<Bound>,
> +    reg: &'a IrqVectorRegistration<'a>,
>      index: u32,
>  }
[ ... ]
> +    pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        if index >=3D self.len.get() {
> +            return Err(EINVAL);
> +        }
> =20
> -        Ok(range)
> +        // SAFETY: index is within bounds of this registration's allocat=
ion, and self.dev is
> +        // the device it was allocated from.
> +        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
>      }

[Severity: High]
Could this introduce a regression by creating a self-referential struct
requirement for device drivers?

A typical device driver must maintain both the IrqVectorRegistration (to ke=
ep
vectors allocated) and the irq::Registration (to keep handlers active) with=
in
its long-lived state struct across the driver lifecycle.

Looking at IrqVectorRegistration::index() in rust/kernel/pci/irq.rs, it ret=
urns
an IrqVector tied to the local borrow of self. This lifetime dependency
propagates to irq::Registration.

Storing both objects in the same driver struct requires a self-referential
design, which cannot be safely modeled using the kernel's pin_init macro.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813165234.6205=
55-1-dakr@kernel.org?part=3D1
