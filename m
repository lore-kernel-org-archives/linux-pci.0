Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45ACA6B
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492008; cv=none; b=aX3pKu1zXem2CNGUyhtXS/KsVby7TV493oenX6IwRkZoMIMmkZzYwO92lhkfhif6nzyFQhrgfv9XlKIiILQe233MpC5KkPD+KWiHleHM0xVQ3toa4iyQmzNDGUBuomBCcUtEELm6swx62YHF8ytL7ptuhGkE7+e5Dh7IwdInyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492008; c=relaxed/simple;
	bh=zgt9CrVbkbphKr46U2UbtrjU2xCjJtmceL1CZbevJd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wac5mIGP3H81eEKVEjJ11jK+b3LBZHKIZPT26QZW8uQyiFuoubcDhLWQDCa19gUPg/SNlYOPhl/yVTCMhpypThYeHqB6Lt0gzcvvf2kdnBMNIzCAD2niuh2MRwupTAmpCCFwV/nxp+5mNBoCZp5I50JwGHTwGQ43R1k0tToOII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8kZa1px; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8kZa1px"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4921F000E9;
	Tue, 11 Aug 2026 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492006;
	bh=hzdPTbkODH0sfkC4bP3/9KCGw+2yFZSW4H4T9ih5SU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8kZa1px9rHYMCYD7XG5cJghZjSC1ynwWSYdOGqgrCTGc1QX1NlGkf31ynafH2M/t
	 XYeP3T9dq6vFsIXjNp93nOxEXikM/bctz4oBpwoMdn/dXBjMy6I99+pK3ig1H7q+pe
	 9LZnkeSByBfD6xyu1kAZCpe7tm8Z8Q83RbiEoAQXJpX6oiZit4voN43FUeJp5DJJ9K
	 NUy7p1aX3T2o0lSt4Ud9rKD8QiFE+tRqBvCr6zothItFJI8GqyUg3S0CUTokWQG3kB
	 GbFBnCrrNerDqUTM33sLsRG2qGyyBYl+K6M7hJAT5ATERrtxuRlVBJYQJIIma4ZWCU
	 36t79GHxMuz1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] rust: pci: expose the allocated interrupt type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260811233952.3000968-6-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:46:46 +0000
Message-Id: <20260811234646.AF4921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `irq_type` method on `IrqVector` is missing the `#[inline]` att=
ribute, which is required by the subsystem guidelines for small forwarding =
functions in abstractions.
--

--- Patch [5]: [PATCH v2 5/5] rust: pci: expose the allocated interrupt typ=
e ---
commit 2729ea5a5c9bd73b2db961974f58b91749e6fbc9
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: expose the allocated interrupt type

This commit adds irq_type() methods to IrqVectorRegistration and IrqVector =
to
wrap the pci_irq_type() C function. This allows drivers to query the interr=
upt
type rather than assuming which type the PCI core selected.

Link: https://lore.kernel.org/all/20260808031120.363869-4-jhubbard@nvidia.c=
om/

> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index b3dce5b49d571..41059b922492e 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
[ ... ]
> @@ -106,6 +116,11 @@ pub fn index(&self) -> usize {
>      pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
>          self.reg
>      }
> +
> +    /// Returns the interrupt type the PCI core selected for this vector=
's allocation.
> +    pub fn irq_type(&self) -> IrqType {
> +        self.reg.irq_type()
> +    }

[Severity: Low]
This isn't a bug, but should this method have an #[inline] annotation?

The Rust subsystem guidelines specify that small or forwarding functions in
abstractions should be annotated with #[inline]. Since this just forwards to
self.reg.irq_type(), adding the annotation would ensure it aligns with the
coding guidelines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811233952.3000=
968-1-dakr@kernel.org?part=3D5
