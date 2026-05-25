Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317B19D8A8
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742924; cv=none; b=aTDCPHTeqHmYuboAqZIFQU3L+VS84fXtxWuI1kf2KkPzBGLtKu4Lz4ooOMKcy8YNcq97fgQY2xUZOsFdSXK3ebJhKwKuvaszQ+Bd2r3kfvtyN9MCYPpjyH57JfZqFQQyAOIDRZhlvJ3E0HmJzLwSxK2yMT+ns0Z1Vw6ciOApyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742924; c=relaxed/simple;
	bh=XK/sKlMqsfckbJpOonXa3zJFcoOoe6t5CbMfhPD7PC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q3tiho/iB+GbmD7lFNl15CP504OZKwN+UTPSQPN1KZD+O0QDpFqNEvXOtmNlbGDjBtfdW5pQA9JLGEKGXAwnMV3et6n7P60c613FRPkVza2Ul0DxKZkYzDZJFIDBBASYFbjtCjqf6LM1A5Z/CCfSUftu0PUWb+2tvW8aoUBFSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzADL1/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzADL1/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875861F000E9;
	Mon, 25 May 2026 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779742922;
	bh=Oi7Lf0Qf1p9a7vgjSU9LO6Q20W6r9EWutjbFPRsxNhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzADL1/10jkf51bS+f2Uidb9YQ2WFV8PkltKHl+LhTnv6Pqp5PBa2QCNLk+8nN6tn
	 9irKOq/iiNAPYyIdjJ7ONKS2crYV2gS7AxNPyEvq1GGxHEG1VapJaMUzajgc0G+qlJ
	 /fZDJlI7Tq2vOepG7MdTwwsYupyHZfI6vjC4c6CtQlHJmjPSA9ytK11heMrRztKhao
	 rvlTwh6oqaX9gLk3UvuFhi85WkF57OfoP0vUfGHKEGgOhboORo8Aq1+HbJyUth3+eX
	 RJyfSc7eC6djfGUPdsZRRCOoKI/MB5O2/ysTgZG20zow2yA9IjJ9zVuOs76hpyUHBJ
	 cw3sOYi1iEDhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR
 resource names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260525202921.124698-2-dakr@kernel.org>
References: <20260525202921.124698-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:02:02 +0000
Message-Id: <20260525210202.875861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `Devres::new` lacks a `'static` bound on `T`, allowing safe Rust c=
ode to register objects with non-static lifetimes to the C devres subsystem=
 and leak the `Devres` wrapper, leading to UAF on device unbind.
--

commit 1ea8f39dcd612a476e90616d2d99987a3bfdbf27
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: use 'static lifetime for PCI BAR resource names

This commit updates the lifetime of the name parameter in Bar::new and
iomap_region functions to a static CStr. This ensures the pointer remains
valid even if the Bar is leaked, preventing potential use-after-free issues
when pci_request_region stores the name pointer directly.

Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kernel=
.org/

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index ae78676c927ff..3ce21482b0797 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
[ ... ]
> @@ -249,10 +249,10 @@ impl Device<device::Bound> {
>      pub fn iomap_region_sized<'a, const SIZE: usize>(
>          &'a self,
>          bar: u32,
> -        name: &'a CStr,
> +        name: &'static CStr,
>      ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
>          Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))

[Severity: High]
This isn't a bug introduced by this patch, but does Devres::new lack a
static bound on T?

Since Devres::new registers a C callback via devres_node_add() and can
intentionally leak a reference into the C devres subsystem (which is safe
in Rust via core::mem::forget), a user could pass an object with a
non-static lifetime.

The C devres subsystem will eventually drop the object upon device unbind,
which might happen long after any stack references have become invalid.

Should Devres or its constructor enforce a static bound on T to prevent
this potential use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D1
