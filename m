Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1A370D6E
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031658; cv=none; b=LNaoTMkpNPTcpGhxr+Yo8heNYHEZ2aMXklf9bsVyqwU2qEiI+ck4dchJ6f+hDT0iYXRsEtYpxmrykOBJ+8RPP81I6Lq2ac39nYamzCUZBCvQEvSTfZcyHybAm266ZjNNskaAN8L3aKUuGIoXBYT7zKjn/kZLRFaihVVNwPZ7ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031658; c=relaxed/simple;
	bh=5dR/Mi7U3KD0HKjOhVZ1M/DulDLXuokm4d0Dr7ZMJgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZAvQmpHbVSjLrGOLyyQGIdi0T6HAUUfpO69wtzodJt9tTr8A5IxsHJrousvT1+Tmn+bdPFIgcr/5rjG3b9XmSqU36jprC6/AfDPLUJRCxUNk/8nhj4rUlR7WNFH06gz+w/IdUTFhigfhhsb4gonZ9G0YxqdKbaYOz4j7rMeO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpN+QqH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpN+QqH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F7A1F00893;
	Thu, 10 Sep 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031651;
	bh=H8PFvjkgLnvGlQ0YmBY8hPylGgzpIXwfgLMu+qWREyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpN+QqH3JlGwzdGiKb5hiN7RDO/O0lgHfG548D6B+o3LaxMxaBncmHMYB4D8NC/af
	 YuXnMbOL3KeDcSzTpjqQok1qqExNd6cPdwSmHWGIGa8k+X42kglJmNLz827vkzHZlj
	 153dYiyfaItp35vpRQ1EUvmaauhxvhkfXDqF9ggBiw8q3LWdcOcssLCmv3JWbh7hEw
	 IsH1mhrLLWIiYZVRItuik25U185LVJjTRDYSVUiyJFzwcrdPx1aFHtd8QnBrAkIikE
	 SOW1LCA6pxYgRNoo0YWCMF2tb9JI+mf3ZE3hKlGNEV/beJ+Svfks/6fRa5fWmqngfb
	 fj1cG5+d1mQMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 9/9] rust: page: add `ExclusivePage` for race-free
 page access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-9-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-9-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:14:10 +0000
Message-Id: <20260910091410.E5F7A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `ExclusivePage::alloc_page` method is missing the `#[inline]` a=
ttribute, violating the Rust subsystem guidelines for small abstraction fun=
ctions.
--

commit 3d93318174c0f08ec348e7d20ff2086b2a3244a6
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `ExclusivePage` for race-free page access

`ExclusivePage` wraps a regular page but adds an invariant that the
page data area does not incur data races. This means `ExclusivePage`
cannot be mapped to user space or shared with devices.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index cd394b0656c0c..4e5b1c2f43466 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> +impl ExclusivePage {
> +    /// Allocates a new `ExclusivePage`.
> +    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {

[Severity: Low]
This isn't a bug, but should this abstraction wrapper around
bindings::alloc_pages() have an #[inline] attribute?

The Rust subsystem guidelines specify that abstraction functions forwarding=
 to
C binding calls should be annotated with #[inline].

> +        // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep. Other than that, it
> +        // is always safe to call this method.
> +        let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
> +        let page =3D NonNull::new(page).ok_or(AllocError)?;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D9
