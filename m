Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777873CF97E
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382928; cv=none; b=lg0am8CUXISmO/IZIqVk3b6wTZ4Yb0z35MMewY5ry0D2ZnRFQE+WCsxF09MPe9l3/f3N5lxxjVFVH0e34wZKY6xfax17JHSwVEaTKPQxjTSTD68dfQWrlR7NCgTU7B46Yw8at2KX+nB2atCz3A1FPeBjxJVQ03WDTkurW4SH3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382928; c=relaxed/simple;
	bh=wskw6w9NzvF85UCFAjLThqi6Wl28vTsDmJIAzK0xwS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMC1Vi7BJz8ObHJpzwkS/D8EBbJ2+r4ap+wyDtfIBHfIlFffHopBUkjK2hwgVIfnIfr99wxTdfZTGSFZWn0Gp0eBgcMFlPlq9j5LJTBfoFfqleArJoVSWfEgIKx+nrxZEcalQURg1eYzl2EH1Cw+Fit37px6SnOedAk1KXgPL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxTZobx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxTZobx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF121F000E9;
	Thu, 25 Jun 2026 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782382927;
	bh=kHYninHeoO15QPVSpDTTpGn+Wym7QkYbV3//DkbL/BI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxTZobx/bitU2o0ayop7tvoh53gpwrRdmRpVhYl4KlS/5ykfnxcEyd7MuLVRtrvYs
	 RIkACGKd73+Oacd5MJqOInFt5OZMWjWmL3PF0Fivggqsc30eBddXcYBZLd7Qvvfhgj
	 H9UoqYAWuuI7QySS3hZR4EQTWzQhX+9Coi9EJWfkXrsmZfxHNddQHRVGUqlZV1mKtg
	 /nQCE0nznwXtcksBfwGDyKwr2kpPucIpowuUY7UQl7e+50UgYSaMVcCrOplt52H3pR
	 b+Atlfft2TzxwKTfTzAqqgDXCmDU+LP6LR3Tz7G1F3s4OUXZb08jDFEStylI470aSG
	 KWQtgef1KToDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/8] rust: alloc: add `KBox::into_non_null`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:22:06 +0000
Message-Id: <20260625102207.1DF121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mismatch between SAFETY comment and executed code in `into_non_null=
`.
--

commit c2c9f847b4c97663dbc3f96c92652dbd5698f0aa
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: alloc: add KBox::into_non_null

This commit adds an into_non_null() method to Box<T, A> that consumes the b=
ox
and returns a NonNull<T>. It acts as a convenience wrapper around
Self::into_raw() for callers requiring a NonNull pointer.

> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 35d1e015848dd..d534e8adcf7b3 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
[ ... ]
> @@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>          // which points to an initialized instance of `T`.
>          unsafe { &mut *Box::into_raw(b) }
>      }
> +
> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
> +    ///
> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
> +    #[inline]
> +    pub fn into_non_null(b: Self) -> NonNull<T> {
> +        // SAFETY: `KBox::into_raw` returns a valid pointer.
> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }

[Severity: Low]
This isn't a bug, but there is a mismatch between the safety comment and the
executed code in into_non_null(). The safety comment specifies KBox::into_r=
aw,
but the code executes Self::into_raw(b) on the generic Box<T, A>.=20

Would it be better for the comment to reference the actual generic type met=
hod
being called to prevent reader confusion?

> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D1
