Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE7499F23
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640759; cv=none; b=QeK2tpKyehRm6tQvfAx/Kuz2Kwb0+AoyWMjmiY/BqeH3rvBl8pC6kjSYhO545BLibT4NYt5IQlJCOYISlKy2y4F3mHcjhT64JvXBW+YX56HYou0HkMoseLvI8qFvYT3nz5gYbv7LwymOUnOHNoL9Rk10O2TsUVxPB2w21hkmjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640759; c=relaxed/simple;
	bh=xFUXD7CKt8hRX8pDXG5ILEiu+8MFS183dswng0cuML4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mz9tLej2U5IvM+hF7dD8NyyrWv54PibqwAFg0mJt0aan6G6qttw3beq5VAsh3nG4gahszcm4yg/QlH/WCxJeb8kiYFzdzwTRLBM0odub+Fs5DF7SsAYx2yHOfV7JNCr/ibHiB9LLFtzG8vYqirjc+jaWEACc41hfDUil+fohnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWNmbzPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWNmbzPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BBB1F01560;
	Thu, 13 Aug 2026 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786640757;
	bh=BUo4ATzLk8ReDTeIuKyQIfcYDHj2361ZZD+21vz7l0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWNmbzPUmgRi4A22ifnvJ8s0uuQxl0qXLTrbNUosKMSCduAeBCa8gVAm9rcc3BY6O
	 0Spf3cj/GZUPFSTmWdWF0w0G5FAY7Q1r29VjTYuvK6qbQosLQ9XG1F6TD9/6ZUkVOi
	 cx5PsCKKR6qzgXoc0nGnW9FxQJWYru1YmfChx84rW218Zs1aqIA4/ClbclwWsHm5D0
	 dPHcN3OY/w8iuScMlW7I3KnHOVseGuNbQh1NKY7sHP2vRdMBixHqHGAoIxHtpzzq5z
	 pRiHUPDBaFMWCubRCNF75y7ziE4Y3lL6sWNwDiGNyRmeVlf9sGD1pOr+zsUgX1Da08
	 YMiiEccjTRqDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] rust: pci: remove request_irq() and
 request_threaded_irq() from Device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813165234.620555-4-dakr@kernel.org>
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:05:57 +0000
Message-Id: <20260813170557.91BBB1F01560@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new `IrqVectorRegistration` lifetime design creates a self-ref=
erential lifetime trap, making it practically impossible for drivers to saf=
ely store their IRQ handler registrations in their driver data structures.
--

--- Patch [3]: [PATCH v3 3/5] rust: pci: remove request_irq() and request_t=
hreaded_irq() from Device ---
commit 391f2070be9b225ebd0a122e28fa0091732c94e1
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: remove request_irq() and request_threaded_irq() from Device

Remove the thin wrappers on Device<Bound> that only forwarded to
irq::Registration::new() and irq::ThreadedRegistration::new(). With
IrqVector embedding a resolved IrqRequest, the conversion is infallible
and drivers call irq::Registration::new(vector.into(), ...) directly.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 81b74c4c17d98..b6d1699ee3ebf 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -70,9 +67,8 @@ const fn as_raw(self) -> u32 {
> =20
>  /// A resolved IRQ vector from a PCI interrupt vector allocation.
>  ///
> -/// Created by [`IrqVectorRegistration::index`] and consumed by [`Device=
::request_irq`] or
> -/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistratio=
n`] it was derived from,
> -/// so the allocation stays live until the handler is freed.
> +/// Created by [`IrqVectorRegistration::index`]. Convert to [`IrqRequest=
`] via [`From`] to register
> +/// a handler with [`irq::Registration::new`](crate::irq::Registration::=
new).
>  pub struct IrqVector<'a> {
>      request: IrqRequest<'a>,
>      reg: &'a IrqVectorRegistration<'a>,
>  }

[Severity: High]
Does this new IrqVectorRegistration lifetime design create a self-referenti=
al
lifetime trap that makes it impossible for drivers to safely store their IRQ
handler registrations?

Because IrqVector uses a single lifetime parameter 'a for both its embedded
IrqRequest<'a> and its borrow of the registration &'a IrqVectorRegistration=
<'a>,
the returned IrqRequest is forced to inherit the short lifetime of the meth=
od
call's borrow of the IrqVectorRegistration when converted via From:

rust/kernel/pci/irq.rs:
impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {
    #[inline]
    fn from(vector: IrqVector<'a>) -> Self {
        vector.request
    }
}

This conversion propagates the strictly constrained borrow lifetime into the
IrqRequest, permanently tying any resulting irq::Registration to the local
scope of the IrqVectorRegistration.=20

For a driver to return from its probe() function, it must store both the ve=
ctor
registration and the IRQ handler registration in its main device struct.
However, this creates a self-referential struct (the IRQ registration borro=
ws
the sibling vector registration field), which is forbidden in safe Rust.

There is no devres escape hatch because devres::register requires 'static, =
and
DevresLt cannot encapsulate a borrow of a local field.

This affects all PCI drivers attempting to use the new API, breaking the
primary use case of the subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813165234.6205=
55-1-dakr@kernel.org?part=3D3
