Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684938E119
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570856; cv=none; b=YVn3kZ8C4/tj+IPBj2poz98/ye8SyQg+DVumWYZXe7+8nJkqFwZhnJ1w3LtmLoa8oM86SA35rgvr9vqZ0aFa7+jTVVLlnWdSdAwokSYxr1Sr57+0Bk+Sa1/stl7N8WUZ13Vl/FYZuNV+HulGxiSWXmo+woSZifL0rHr2PQYhsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570856; c=relaxed/simple;
	bh=Q456v3XWfGegHttT2M/3Pn2nopAk+ZbXRwvfVsCpQgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmUK+2qixkEPmrTzpmy6em+jrZf2MJdHjSFrE0IbTKPd3u0o0yOHAXVYToY4Zc+/L+jckLle5x70+vd7BhZMsV8W8e1yaeAhIQJJarz2CAgXb2oVE6KlgHYPXFtkI9S39wSoJ8TMGP33MYI0IrGeEjmYZzKs4F49WLMTtiAUmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1XJ/dQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1XJ/dQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1321F000E9;
	Mon, 24 Aug 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570854;
	bh=U7SgFVjZxa3fzThGKmaXeVtMA5IypPrOPDUHiEGN9qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1XJ/dQPM0ESVHrS1DF+VjsyswG7Hv87JXmogszLE/Z+gkyGCnN/e2CFMt+jZg1Op
	 Wf9hGvPqkwC6uHzyd27BF24EeGR5kwP8FIDfnuf11nid/9Sg5TfDck/ol+lf8huFoR
	 EK8cBel+usgF8rtz7MIgyeRQBayxlS1NL5/rC+Fej7pbPzBl6CR2g8nkqlEtfgsvHQ
	 5C7IzkCVC1AuVFcAo8mOydQzX72ZhuVvYEZkJdiWimzfI39i8wiEGR3L20wenSTtWA
	 yhdJTlwgTJu4iu2nRv8TFu3s0K5nytfZATfjXxghAojqkuyv22gfRmxoUw2IxFUW1i
	 SM0r4kjGErD7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/8] rust: types: Add Ownable/Owned types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-2-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-2-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:27:34 +0000
Message-Id: <20260824112734.7B1321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The safety documentation for `Owned::from_raw` fails to require =
the caller to uphold the pinning invariant.
--

--- Patch [2]: [PATCH v20 2/8] rust: types: Add Ownable/Owned types ---
commit 82ccf756b593f4c76a8a6694855add1d65c27d53
Author: Asahi Lina <lina+kernel@asahilina.net>
rust: types: Add Ownable/Owned types

This commit introduces Ownable and Owned types for unique ownership of obje=
cts
with custom drop logic. It provides a mechanism for C-allocated objects to =
be=20
owned by Rust without generic allocators, delegating resource management to=
=20
the type itself.

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..7fe9ec3e55126
> --- /dev/null
> +++ b/rust/kernel/owned.rs
[ ... ]
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// This function takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusiv=
ely owns the underlying `T`.
> +    #[inline]
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

[Severity: Medium]
Should the safety documentation for from_raw() explicitly require the caller
to uphold the pinning invariant?

Since as_pin_mut() returns a Pin<&mut T> and the internal comments note that
T is treated as pinned from now on, it seems the caller must guarantee this.

If a caller provides an unpinned allocation, retrieves the pointer later wi=
th
into_raw(), and safely moves the object, it could violate the pinning
assumptions established here. Could this lead to memory corruption if the
pinned object is self-referential or registered elsewhere?

> +        // INVARIANT: By function safety requirement we satisfy the firs=
t invariant of `Self`.
> +        // We treat `T` as pinned from now on.
> +        Self { ptr }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D2
