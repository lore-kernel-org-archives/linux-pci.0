Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BA24E4B4;
	Thu, 25 Jun 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392561; cv=none; b=XT1OEch90bUp+vSsKuAU3NRDgcijOJV0PGLlWcB/fOPv0IyKiaCljbPLIJA5um7pkic0o/U+wTAQN/C9JvBxmMyE9UxZYyGzMAXVAfN0WM2ae4Wh2Gf+6dSxI3tTq4dxWDmOyRCeKrfYNS4c4heJ9zgszppxANTW3X081St6BC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392561; c=relaxed/simple;
	bh=XfHXrS1ZEajkwaU5EP9lHXOw6tz2F5AWN3AtzjlBGjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPSr5xiYESQ9wCvEEOHmhzPxiRH4Lk00yVqE30BeWf78nvOFDQayknwcQqOGpLIAMoA+s56YAxpOZnck3IdM7bTSoz/soO2XKpc+DM28uIk/Au6516/X6YrMq/LQtqc6u8X1C619GOZQDj0tdL6s0cjdz5clua3gfzThUizIA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sveoc4cA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sveoc4cA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5421F000E9;
	Thu, 25 Jun 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782392560;
	bh=wWpfoYo0he+1/XkBK644Cd03AtNcgDe0rI1UeR8YX1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Sveoc4cAKUNYDUtQpv4K47fJt/hl7zZK8tsbX7Ne7/wCLB9uAGPnltdA6YWtTRmJU
	 /7xHIU7y01csInUJPCg/9YhVEti1MXSSaQW6E6aOPRwZjo//DcXdHRau31CXto4Hji
	 eEgUU7pqSa6ZEQDgQQzdCMSue43OPdISm4w3RcDKye391ngRppV/oBzlwI2rSP4Rsx
	 Ut773Qzi7tSBz58yGrEDUuGtDK55hnMqIKhvfqGjBSWWCgCw0h69p/1kmQW+L5oKoW
	 FP4dONHVHNdJwMd12HA7Zi7KhLHbHYvnRVoiISe1fU8lM2RPiyeRbyyDeEaqzP5quo
	 PIzLXh3E/J1Tw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 8/8] rust: page: add `from_raw()`
In-Reply-To: <20260625102549.B56171F00A3E@smtp.kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
 <24fS7Cgk-Y_pR5s6G0gXJ3zpbj_q2vdQ6BamOE62CiY_dtN1xrG5oDJqTy0LCceddw2AsvATlzKDX0MwJIg7Cw==@protonmail.internalid>
 <20260625102549.B56171F00A3E@smtp.kernel.org>
Date: Thu, 25 Jun 2026 15:02:28 +0200
Message-ID: <871pduixi3.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `# Safety` documentation for `Page::from_raw` is missing the precondition that `ptr` must point to a valid `struct page`.
> --
>
> commit f6aeebdd661d4004190de07e9d991442f793517a
> Author: Andreas Hindborg <a.hindborg@kernel.org>
>
> rust: page: add `from_raw()`
>
> This commit adds a from_raw() method to the Page abstraction. It allows
> the construction of a shared reference to a Page instance directly from a
> raw struct page pointer.
>
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 6dc1c2395acaf..c88fda09ead5a 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>
> [ ... ]
>
>> @@ -143,6 +143,20 @@ pub fn nid(&self) -> i32 {
>>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>>      }
>>
>> +    /// Create a `&Page` from a raw `struct page` pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
>> +    #[inline]
>> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
>
> [Severity: Medium]
> Is the safety documentation missing a requirement here?
>
> The # Safety section only requires that ptr is convertible to a shared
> reference. Under Rust's rules, an uninitialized or dummy pointer could
> technically be converted to a shared reference if properly aligned.

This is not correct. A pointer is only convertible to a shared reference
if it is pointing to properly initialized data [1].

>
>> +        // INVARIANT: By the function safety requirements, `ptr` refers to a valid `struct page`, so
>> +        // the returned reference upholds the type invariant of `Page`.
>
> The invariant justification inside the function explicitly relies on the
> caller guaranteeing that ptr refers to a valid struct page. Could the
> # Safety documentation be updated to explicitly require that ptr points
> to a valid, initialized struct page so that callers do not inadvertently
> violate the Page type invariant?

For `ptr` to be convertible to a shared reference, it must point to
valid and initialized data.

Best regards,
Andreas Hindborg


[1] https://doc.rust-lang.org/stable/core/ptr/index.html#pointer-to-reference-conversion

