Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F2388E69
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492376; cv=none; b=QTpV+l2XMW9X2s8vWxBOm4eM6oUWTAkoS1MaupBK617bjiAME1rjMcQ287jM6VzaJ++QnIElBCRonyOfEbObIDvky2BZhUimdZMv3v+s0kbj22DH5GxYC0MOCC/YTujeyxKrusmJ4Ml4vAKpAkSJto/S0cpwi5DOBKPSH0/N18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492376; c=relaxed/simple;
	bh=yGBDmLSFDMfBXV9TVANgT3o1g4rmz99/Jck/aGCXU/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P2GmtaBwwKZRl+FtXNVHri+Hz7VBc8MfmATFv/+j1VBvMM6/5UUykbK9q4i35BnjCFBNPtxz7waldTa/vjgcs76NXl11WTAv5g6fkJ8/iM9WUaaQ92v7/K202ZRahbp9AHKfsW6kR7VgbLcTVWf4ipufb9Aby9FkAePDcAJ++iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvZPIfBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvZPIfBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BF61F000E9;
	Tue, 11 Aug 2026 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492374;
	bh=FVnPen5rXt3BpuQzmajuwy03TMjUn6nRwtFLhbvcMtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvZPIfBRJhaHEizooCLmR7pP9nMKx3KmNSEcefGdhAcV4LyCHYvFF605eayayVS4K
	 scatvFBZnjipIRRScQNdlwno8FaBLQ+wUj28OYe3dh0TETbQ3iReh/2OIqZi6+I98j
	 RtNSmHbvNMb8dhuRS5GBpU9oIUaMjFQ2FSXhKiv6RObKC0RxOBwkaeM2oDjclbNtxw
	 CADs8O/M/WX0f4+UZjN6wEDVk2LmGAVQxgZoAww0QRmLgyXqAQuWgNjeYajtQ3PHSt
	 f+XVkFy8/manYiAI6MJa4ysHlVLvS3CgvfTeCr1r74GIlogzxXErYBtlnts02VJB4c
	 TWtZmq6fAfrLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260811233952.3000968-2-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:52:53 +0000
Message-Id: <20260811235254.36BF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The lifetime bounds introduced on `IrqVectorRegistration` and `Irq=
Vector` force an impossible self-referential struct, rendering the API unus=
able in safe Rust.

Pre-existing issues:
- [High] Concurrent calls to `alloc_irq_vectors` allow unsynchronized mutat=
ion of PCI device state, leading to data races and kernel memory corruption.
--

--- Patch [1]: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a=
 lifetime-managed owning type ---
commit c70c8b630ade05d17f2339a929d25258bdd64514
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: convert IrqVectorRegistration to a lifetime-managed owning type

This commit converts IrqVectorRegistration to a lifetime-annotated type that
owns the PCI interrupt vector allocation. Dropping it frees the vectors, and
alloc_irq_vectors() is updated to return IrqVectorRegistration directly.

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index fea484dcf9cf2..8e06515878290 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
>  #[derive(Clone, Copy)]
>  pub struct IrqVector<'a> {
>      dev: &'a Device<Bound>,
> +    reg: &'a IrqVectorRegistration<'a>,
>      index: u32,
>  }

[Severity: High]
Will this lifetime bound prevent drivers from storing their PCI interrupts =
in a
device data structure?

If a driver calls alloc_irq_vectors() to get an IrqVectorRegistration, borr=
ows
it via vector() to create an irq::Registration, and then tries to store bot=
h in
its driver data struct, the compiler will reject it. Safe Rust does not all=
ow
the registration and the IRQ handler to be stored in the same struct due to
these self-referential lifetime constraints.=20

This seems to force drivers to either leak memory or drop the registration
prematurely, which would instantly free the interrupts via
pci_free_irq_vectors().

[ ... ]

> @@ -256,7 +249,21 @@ pub fn alloc_irq_vectors(
>          &self,
>          min_vecs: u32,
>          max_vecs: u32,
>          irq_types: IrqTypes,
> -    ) -> Result<RangeInclusive<IrqVector<'_>>> {
> -        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_ty=
pes)
> +    ) -> Result<IrqVectorRegistration<'_>> {

[Severity: High]
This is a pre-existing issue, but is it safe for alloc_irq_vectors to take =
an
immutable reference when it mutates PCI device state?

Because alloc_irq_vectors takes &self (which is Sync), a driver could expose
concurrent sysfs or ioctl endpoints that trigger reallocation on the same
Device.=20

The underlying C function pci_alloc_irq_vectors checks and modifies
dev->msix_enabled without locking. This can cause a data race, leading to
double-allocation of MSI-X descriptors, leaking of ioremap mappings, and
corruption of internal PCI device state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811233952.3000=
968-1-dakr@kernel.org?part=3D1
