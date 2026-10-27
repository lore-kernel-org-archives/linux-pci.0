Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079252;
	b=yNu9li1y1JFzc+wQWXtcdxsIb+GEsyYu3M3cChZbY5vejY5RoKF6ssfPfqMMU8FFOgQ/
	 qsfekvkSqW1PqIi5PJoILl7L7AMZ15LME/ogP3Apwgpe+uH7PFr/iheIKhAcnLEGI5zQQ
	 XAmmecKjiZ09pRLvhyp9oMIzLtbjKi3Qcks6i+xOYYF3Rxg0xyly4aWFbpAnbZEpKWHA5
	 8Z6V37+1e8gs7H5rKRhSN0LcUi6bJGe4+wbpqsSy4XOdoJBq4o1LcQh2ZZtTBKFK483t6
	 yGcgnuwsgclOC5Hkl+glfou0sCnQYj2U0W55gbU30XSorx+tsa+6Zgwi894WDKyA5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XFEdCphOwnT/+Z3qv7VWeCpsNui6xSEm6WDaBjRDmS4=;
	b=iidXyd+eFF3uLcy9u4AbFy73V9dEZiHA59ef6lACp/4hJwCXA6qfOphiKSnu4iCGQGCp
	 +7jRdSCKlF0qPdBJRZcCA8LMqq4CyNdxojmLa2PoPTrryeeZp1LWuPnqS9U0d32J9sPzo
	 MtF0ZT2w35yFQr/qkp9ClbYQ8Bj6A1xPM7FazeY72q3qQJNEtm0PsdLsaX6OkORWx14wJ
	 024ioYSa7PxwSLB/WYgrwxaD+6PPhvfQ8rOd7EoGs28D5ed8WOthQeS52i0QaUxJPvmzH
	 IbMKfVpwXLTXyJdsXvhpR6iRJOAgTDyDkDJrEPEClRucnPZEGTFB4qpgGDqEu7n+PCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VT2BJZ7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C1606A31A;
	Tue, 27 Oct 2026 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VT2BJZ7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256DF1F01825;
	Tue, 27 Oct 2026 05:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079251;
	bh=XFEdCphOwnT/+Z3qv7VWeCpsNui6xSEm6WDaBjRDmS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VT2BJZ7dhjF9CS7aFGZS1fRT8FaJ0WP+aOWTWbR1agcvXfX54ZWZkejw78C9QsYmd
	 4LJLMVR52XsHaPXrk6hjKa34pJqVespvWgAUxvvJYMWIA2JNzrooPYowqKp1i/5X9c
	 apLsEC4mnkwLDZhfl/S9uzsOlEXydNnDTpCg3nx2oQpGFVHlddZX9gyanq2UhgJNU4
	 LLt4wz1+NzoS928wOhd3JlFMu288D4bOsLHH99QiDARtlSpTLTiXxNUmu8mLtw933n
	 UE2BUESFiBst6WrpMNUtHnmUANV3qpA6sYYdbJVTAM3D3B8osEsC2Y/tutEhQrP+Go
	 A84fjPE6TlE/g==
Message-ID: <sashiko-outbox-186123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/23] rust: create basic untrusted data API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-3-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:34:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rust: validate: from_mut() and from_mut_slice() bypass Untrusted=
 opacity
--

commit 46cfb0c607f570933dd68037f09805a7bea851ee
Author: Benno Lossin <lossin@kernel.org>

rust: create basic untrusted data API

This commit introduces the Untrusted<T> wrapper type in kernel::validate to
explicitly mark external data as untrusted and prevent unvalidated data from
being directly read or used for kernel logic decisions.

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 0000000000000..3c1fe37624573
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,192 @@

[ ... ]

> +impl<T> Untrusted<T> {
> +    /// Marks the data behind the given reference as untrusted.
> +    ///
> +    /// Unlike [`Untrusted::new`], this does not require moving the valu=
e.
> +    #[inline]
> +    pub const fn from_ref(value: &T) -> &Self {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
> +        // does not introduce interior mutability, as `Untrusted<T>`
> +        // has interior mutability if and only if `T` has.
> +        unsafe { &*from_ref(value).cast::<Self>() }
> +    }
> +
> +    /// Marks the data behind the given mutable reference as untrusted.
> +    ///
> +    /// Unlike [`Untrusted::new`], this does not require moving the valu=
e.
> +    #[inline]
> +    pub const fn from_mut(value: &mut T) -> &mut Self {
> +        // SAFETY: Same reasoning as `from_ref()`.
> +        unsafe { &mut *from_mut(value).cast::<Self>() }
> +    }
> +
> +    /// Marks the given slice of data as untrusted.
> +    #[inline]
> +    pub const fn from_slice(value: &[T]) -> &[Self] {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
> +        // does not introduce interior mutability either, as `Untrusted<=
T>`
> +        // has interior mutability if and only if `T` has.
> +        unsafe { slice::from_raw_parts(value.as_ptr().cast::<Self>(), va=
lue.len()) }
> +    }
> +
> +    /// Marks the given mutable slice of data as untrusted.
> +    #[inline]
> +    pub const fn from_mut_slice(value: &mut [T]) -> &mut [Self] {
> +        // SAFETY: Same reasoning as `from_slice()`.
> +        unsafe { slice::from_raw_parts_mut(value.as_mut_ptr().cast::<Sel=
f>(), value.len()) }
> +    }
> +}

[Severity: Medium]
Do public Untrusted::from_mut() and Untrusted::from_mut_slice() allow safe
code to bypass the opacity guarantee of Untrusted<T>?

Because mutable references are invariant in T, converting &mut T into
&mut Untrusted<T> (or &mut [T] into &mut [Untrusted<T>]) allows callers to
write unvalidated Untrusted<T> values directly into a plain, trusted T or [=
T]
variable without validation:

    let mut trusted: u8 =3D 0;
    *Untrusted::from_mut(&mut trusted) =3D untrusted_byte;

Similarly, a caller with a plain mutable slice buf: &mut [u8] can pass
Untrusted::from_mut_slice(buf) to a function expecting &mut [Untrusted<u8>]
(such as the read_from_userspace(buf: &mut [Untrusted<u8>]) pattern shown in
the documentation) and then read the unvalidated bytes directly from buf
after the call returns.

Since DerefMut on Untrusted<[T]> and Untrusted<Vec<T, A>> only converts an
already-untrusted container into &mut [Untrusted<T>], should from_mut_slice=
()
be private and from_mut() be removed or kept private?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D2
