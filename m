Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD713F44C2
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475631; cv=none; b=B8eC9vZElbFSl3fgY5New3vJjiV+7Jmu7ftrWVURH3FCX7eu473Zhz3J8lZ4Ys7yPq6dC1Z6jfRwGdhXr5/SluDtrGsLS//Y+clwT0Z1bguHp0krjc3RR4D565zHdDIGdnVXYZwcj/ASEX4wcdacM0DDBtCfwixfY3NlUX5JZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475631; c=relaxed/simple;
	bh=JwMXwMZTMjLHfv8XbQByZmT9NiXVamFix2TmESvRaWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QHs0FyHqspG+bFRVUy16XMwZBhuWKQpjClEuyDYSPwy2Wca24eoDkF3xNiJzOBUkudMVEnL023Ynopq+5RTq8+EWxkbR8WxYMGRzWUc9nNU2mpwPZ4EzaIUhkxjA4i2JhtlI08vt2+JL5LvZZMwlJCAZ9udr3DdVxbuAuicl8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEIRRi6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEIRRi6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DAB1F000E9;
	Fri, 26 Jun 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475630;
	bh=ppjgt+FXUa/Fw0EA5nU9+z5Wr4fLZ76N/w51kvSjYxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEIRRi6JApGaVMdkrpeErFC0eXmVIGx2JHrKWoAoKplgsv8QTFDmVM7tVBhYt0fJH
	 XzJnNvWLAz/JOrDu4JhbnDzcOdp8T1NPQ30NtmPCJup1ECrMgJ/acXWA7eJq+p2W1m
	 Wy3T8bQkU9Tlm57CfTyvw1kBKlnt6UQV7JjfAlJWIaKT6ZA5hIkMfPErzo8lIC/+qn
	 v8juTac1hTBhhmtFcET4P8VnDZvSmsSzG5YSVoqkj7E4L4r+xqw5WTVknrOMMeO2GY
	 kQhhbbjzJVByzdPmeGdwEAwHPIBLvVzUPtLfAHJ/yHjYiOxniRA7+sOJ7qxUeJAHh/
	 2Q0YMqZDzg/Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:07:08 +0000
Message-Id: <20260626120709.A8DAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Use of `kernel::` instead of `crate::` for intra-crate imports and =
paths.
--

commit 5d83778cf519ec33130e7eef0e627d3e0a92700a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: implement ForeignOwnable for Owned

This commit implements ForeignOwnable for Owned<T>, which allows it to be
used in places such as the XArray.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 7fe9ec3e55126..93a5dfcc1e6f5 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -15,6 +15,8 @@
>      ptr::NonNull, //
>  };
> =20
> +use kernel::types::ForeignOwnable;

[Severity: Low]
This isn't a bug, but should this import use crate::types::ForeignOwnable
instead of kernel::types::ForeignOwnable for an intra-crate reference?

[ ... ]

> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {

[Severity: Low]
This is also a minor style detail, but is there a reason to use kernel::
instead of crate:: for the c_void path here?

Would it be better to use crate::ffi::c_void for the return type, as well
as for the ptr arguments in from_foreign(), borrow(), and borrow_mut() belo=
w?

> +        Owned::into_raw(self).as_ptr().cast()
> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        // SAFETY: By function safety contract, `ptr` came from `into_fo=
reign` and cannot be null.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D3
