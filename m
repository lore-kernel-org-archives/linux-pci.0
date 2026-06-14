Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5A1917FB
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453051; cv=none; b=S61xNDu1REMTLXCmCveIh7oul9Yv7fQeskHhsfe5wikxMvvtJ46jCZsOc4EK5HTgSU1fEzziEcOkzeLJVwXhZSb7/2mabzTwaKzT54zlKWI5/5jtApbnl8oJCVt8aoKf1MJF7NtX51XL5nVobxGIDBEOyRBfli/kzZMdCfm+IAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453051; c=relaxed/simple;
	bh=eSezvwP1SgXQ+i8I2IRHWNaifj15NQnhOtAl6gRUVFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sku1n44wEZ/C0+X2ZsFKsN48OW2HpwxFnuVXecgokwXx+IfD677XeC9pJhw9X7mj+A4xfObUJZTGbQlupeRjnANeC4se5BIYVLXi7rwlbG8BNxb8E4pi4j2um9ZXCnNZPEYSMSXrhf090+56NAqXY7vLYlJcTkKeo1LReY7EgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk9RY1Li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk9RY1Li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D531F000E9;
	Sun, 14 Jun 2026 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781453050;
	bh=d2J3VgSz1hbi71585XIFrO3rtCLviV0IdgX3EsfmD3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jk9RY1LiGuSAQ61Vlc8aqYNy+MIwgfoCJBo9qoHrIP65V/T06SPYYsA1FeJTSbwUY
	 vw5SRFtnF9JKoZEODzywTRU69Kmu/l1B5mt4tvBjPaLJTdAn53OtdU/dDFisgR9Vok
	 2TLjedUFXeCGZH6sPxLnXFy115TOKUoEdeWjy+VmjpujrH378wet8AfJlYhJ2ttbgw
	 yhbujreMStH0AxaDNfwSLamNcOYKeXcqGqEYdCKKmlGXoI5WLyAVJ7+x2cEN9PCT3l
	 7FwGdHEy3+Xyw2qlki0aE4OSM6Q2jdDiiSKHZeGEqo7v8iAywp6wIKsbWMA8ET+n+0
	 r7DeuqSak9Hmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] rust: completion: add complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-3-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 16:04:09 +0000
Message-Id: <20260614160410.51D531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` annotation on the `complete()` abstraction wrap=
per.
--

commit 566fae28c64ca5359e88bcd074eba624bc6951cb
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: completion: add complete()

The initial completion abstraction only added complete_all() and
wait_for_completion(). Add complete(), which wakes a single waiter and
increments the internal counter by one. Paired one-to-one with
wait_for_completion(), it allows the same completion to be reused across
multiple cycles.

> diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion=
.rs
> index c50012a940a3c..b386b84222f97 100644
> --- a/rust/kernel/sync/completion.rs
> +++ b/rust/kernel/sync/completion.rs
> @@ -90,6 +90,20 @@ fn as_raw(&self) -> *mut bindings::completion {
>          self.inner.get()
>      }
> =20
> +    /// Signal one task waiting on this completion.
> +    ///
> +    /// This method wakes up a single task waiting on this completion an=
d increments the
> +    /// internal counter by one. If no task is currently waiting, the ne=
xt
> +    /// [`Completion::wait_for_completion`] returns immediately.
> +    ///
> +    /// Unlike [`Completion::complete_all`], the completion is not marke=
d permanently done, so a
> +    /// single [`Completion`] paired one-to-one with [`Completion::wait_=
for_completion`] can be
> +    /// reused to signal the same event repeatedly.
> +    pub fn complete(&self) {

[Severity: Low]
This isn't a bug, but should this function have an #[inline] annotation?

Since complete() is a small wrapper in an abstraction that merely forwards
to the C binding bindings::complete(), adding #[inline] would match the
guidelines for such functions.

> +        // SAFETY: `self.as_raw()` is a pointer to a valid `struct compl=
etion`.
> +        unsafe { bindings::complete(self.as_raw()) };
> +    }
> +
>      /// Signal all tasks waiting on this completion.
>      ///
>      /// This method wakes up all tasks waiting on this completion; after=
 this operation the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-rust-pc=
i-edu-driver-v1-0-e3f2471b595c@mailbox.org?part=3D3
