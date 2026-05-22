Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821B4594A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408875; cv=none; b=ZTXYyEOs0noFCbZ3MfDZoM1JxXW5JAnTH6N/eB3kzVBsBJtC5yi1gkFj3QeiDyJ1JWIzYqf7lJrVLOzaMXT+zXbg5UkUfVCJdKblK/Spgxdug6DuGAkRDdFbcsEOEUgVcMG7HHwlzPNkFilCM12opYA0v8QSLoSB53p3h/1qh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408875; c=relaxed/simple;
	bh=U65QlqRngKN91iszXfSjvcIw0XZYLbEX7cO8BPUzk+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhqVi1JEz7KoIUYkPfqhYPkert6FGPboy6KREvbcccOIuxPXYmMXmslDz7AAtO5F1/DsH9QF05ojcUlTS5Ho2G9Lw1HgrwdAt2NgJAzH/v2R4kiANun6dJ53n5IBTIyPuE1JiDBLi9F47/wZiMCPuvZWOiM1GpqVhkZA6LxsUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJcJ/YmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJcJ/YmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE601F000E9;
	Fri, 22 May 2026 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779408874;
	bh=f6P/Y1pIRQRI/3YIMmzbEOWfM5rvFeeo88WaRbVr2XY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJcJ/YmNjnW8NJb2/fBCBf6b2uZUnOfM280lHpVv+GNO/G4BPZakfKlzN4Iy5YyG+
	 F44uVCniKU9/2HQIhgB9V1e9vTejU5W931IgRr34vMd16vpRYHgnNBMaWZ0WRSeBFJ
	 yCeOj4d6mRi/pq3O8oYWQaog3IKAaCQ1i6IEiDz6TklYmNYs4CFVggAhaw8h5gzkyA
	 jXxMgq8MwbOguB4SiquN+YMXx4srQWPJsBTlX7yFUahaOPSDzmWKS17DuiWe0rMX/7
	 kq1GBweDQ2uuaOhcO4M9GOsV9cMnwuD/QlyhOHbeqYW8xCAT07UeqbB3lnaYFVpNbG
	 D2En5oCOVP1Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/27] rust: pci: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521233501.1191842-12-dakr@kernel.org>
References: <20260521233501.1191842-12-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:14:33 +0000
Message-Id: <20260522001434.1BE601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Outdated type reference in SAFETY comment.
--

commit 45872ca21486aeb451f739fb1f9f5058f15c7ed8
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: make Driver trait lifetime-parameterized

This commit adds a 'bound lifetime parameter to the Data associated type
of the pci::Driver trait, changing it to Data<'bound>. It updates the
probe() and unbind() callbacks to use this lifetime parameter, allowing
drivers to store bus device private data with a bounded lifetime directly by
reference rather than requiring Devres.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 314ad9fefdb0b..a462f4e8f5f3f 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs

[ ... ]

> @@ -130,7 +130,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
i_dev) {
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.

[Severity: Low]
This isn't a bug, but should this SAFETY comment be updated to reflect the
new lifetime parameterization and use Pin<KBox<T::Data<'_>>>?

> -        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() =
};
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> =20
>          T::unbind(pdev, data);
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D11
