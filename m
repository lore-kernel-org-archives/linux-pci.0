Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107027;
	b=XK948DPpob1obNT6WzjgO9NJEe14TwUeNQSMPsQVz91/E+wdXeYuSkrWkuElqdeVkM8n
	 lP/qbd6a8RomuObTOASuZQZbcCDZS98QJhJZBDHv90u9inMCpS5xJmsJ0Aaxkz2FvHDjv
	 UCsEW0bvAE56zchVFRCkpAVksY+r+ieIKy7NvGyrrYphuVXB/ljvBNtvb6mrAQLCLN6sj
	 jCXZPlGxYDxIZbR1TUe6MF0xArCgXHX8Vn4lY+QbWKM9X1UzAFchOelaK6+u1ZYjxOddi
	 Y1KK6YO8mmL8Ds0t7m+JNJ/YFAo4BgLh2HwgJ7XABLjF5YC+AFP3SxTJohN9ghW55qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107027;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To;
	bh=j4p5rqYKys+I1GBjxylvCjNQbtDMtwcx0aS4fbc0x60=;
	b=v4k6HLZcjW/1brD/nQULTDkVYO0vuxYYTVAHXcx2GmqDAZSyVBJ5MntFGJkjRuPKPduy
	 xe1Cs9BPPGlThHnzfiJlkcLa6DYxaBMuJ21zfow4HMReRjQjr4ASFjafT16LXVhppJBwo
	 LDWmg7vNcHgAxJlNXVMiCnolgyei+xFavtY5TYFffIl+ohRYJDoExUMBNwyjE8kRml4De
	 volj+kcs0paff812R/DOGs5wkiJ6BfNlpffopryD7wRvK9BCKXzIyF6xzRNh68C/hBFpA
	 /RT1ivvhyHfaxp5FNkOBAKMWkqndghnbyCNyxS5ix7enOs+pzpSN1NcTxZ65tDe+OLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOaIBhBY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993E606A321;
	Tue, 27 Oct 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOaIBhBY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6D21F01828;
	Tue, 27 Oct 2026 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107026;
	bh=j4p5rqYKys+I1GBjxylvCjNQbtDMtwcx0aS4fbc0x60=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=gOaIBhBYPYwmzoXXxLnFmKjLNrZm1xthPdlhLedgJo8veM24q4xSarTjZOd0DyZqb
	 9ZIfZkGLZUfnaqflEE+Ml3XZqhf9Fji3LCbewut0zxQXnFkYtGj1juBwQ9PyGxER9N
	 WBtOytqRMI3wQa7QOmmkyOkm+CeKYTkIWteiWdcLg753SUj1mHowUet5Z9IyeSrHp/
	 HJ0Cd71mjtTKdFu6E/VV4h0W3zSA8S4JRiarN4bDcQmR/8Q3rwjLJVjoExnyUiU8zn
	 mSsgPd13dyVrwhGzN24N/T3Tfp+4vJ7TCjUIM19hWuZcnSOzDMfd2DhU67aYmf+sJ/
	 3K/Awj/t+5OAA==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 13:17:03 +0000
Message-Id: <DMFNE2OD18PH.27J64IS0GAJLF@kernel.org>
Cc: <ojeda@kernel.org>, <gary@garyguo.net>
Subject: Re: [PATCH v5 02/23] rust: create basic untrusted data API
From: "Benno Lossin" <lossin@kernel.org>
To: <sashiko-reviews@lists.linux.dev>, <alistair23@gmail.com>,
 <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-3-alistair.francis@wdc.com>
 <sashiko-outbox-186123@kernel.org>
In-Reply-To: <sashiko-outbox-186123@kernel.org>

On Tue Oct 27, 2026 at 5:34 AM GMT, sashiko-bot wrote:
>> +impl<T> Untrusted<T> {
>> +    /// Marks the data behind the given reference as untrusted.
>> +    ///
>> +    /// Unlike [`Untrusted::new`], this does not require moving the val=
ue.
>> +    #[inline]
>> +    pub const fn from_ref(value: &T) -> &Self {
>> +        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
>> +        // does not introduce interior mutability, as `Untrusted<T>`
>> +        // has interior mutability if and only if `T` has.
>> +        unsafe { &*from_ref(value).cast::<Self>() }
>> +    }
>> +
>> +    /// Marks the data behind the given mutable reference as untrusted.
>> +    ///
>> +    /// Unlike [`Untrusted::new`], this does not require moving the val=
ue.
>> +    #[inline]
>> +    pub const fn from_mut(value: &mut T) -> &mut Self {
>> +        // SAFETY: Same reasoning as `from_ref()`.
>> +        unsafe { &mut *from_mut(value).cast::<Self>() }
>> +    }
>> +
>> +    /// Marks the given slice of data as untrusted.
>> +    #[inline]
>> +    pub const fn from_slice(value: &[T]) -> &[Self] {
>> +        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
>> +        // does not introduce interior mutability either, as `Untrusted=
<T>`
>> +        // has interior mutability if and only if `T` has.
>> +        unsafe { slice::from_raw_parts(value.as_ptr().cast::<Self>(), v=
alue.len()) }
>> +    }
>> +
>> +    /// Marks the given mutable slice of data as untrusted.
>> +    #[inline]
>> +    pub const fn from_mut_slice(value: &mut [T]) -> &mut [Self] {
>> +        // SAFETY: Same reasoning as `from_slice()`.
>> +        unsafe { slice::from_raw_parts_mut(value.as_mut_ptr().cast::<Se=
lf>(), value.len()) }
>> +    }
>> +}
>
> [Severity: Medium]
> Do public Untrusted::from_mut() and Untrusted::from_mut_slice() allow saf=
e
> code to bypass the opacity guarantee of Untrusted<T>?
>
> Because mutable references are invariant in T, converting &mut T into
> &mut Untrusted<T> (or &mut [T] into &mut [Untrusted<T>]) allows callers t=
o
> write unvalidated Untrusted<T> values directly into a plain, trusted T or=
 [T]
> variable without validation:
>
>     let mut trusted: u8 =3D 0;
>     *Untrusted::from_mut(&mut trusted) =3D untrusted_byte;
>
> Similarly, a caller with a plain mutable slice buf: &mut [u8] can pass
> Untrusted::from_mut_slice(buf) to a function expecting &mut [Untrusted<u8=
>]
> (such as the read_from_userspace(buf: &mut [Untrusted<u8>]) pattern shown=
 in
> the documentation) and then read the unvalidated bytes directly from buf
> after the call returns.
>
> Since DerefMut on Untrusted<[T]> and Untrusted<Vec<T, A>> only converts a=
n
> already-untrusted container into &mut [Untrusted<T>], should from_mut_sli=
ce()
> be private and from_mut() be removed or kept private?

this is correct. we should remove `from_mut_slice`. but we can provide
`Vec::from_trusted: fn(Vec<T>) -> Vec<Untrusted<T>>`.

best,
Benno
