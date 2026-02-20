Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC832C94A
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584613; cv=pass; b=Mwwsi1BbrKB5o1lHhg8Im2gFqobaZQ1AXAUs9FmN3RsJDqlzrCIx6jTZoDuvnOpmRg2sf8MrAkHbcWR2iSdanUcpm35WHDdiRHyb+U1x461iIRcm9CGwMu1qWR1eRnYfS2XUvDnAqRDF4bbQyX1BvjpmZziLKeCdsyv2lana/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584613; c=relaxed/simple;
	bh=oIngJ6S5SUKbvESTbw5vt2bQmTdKhr5N3+wDe58Yw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWEcQhxWZDmUURa7DAR1AtVQTOo5Mq60QtuLX+3q264G/mGJZHMt++cd2tjbadBx2MXpCFMR8ukoK8TNigcOXjgVTdRFDXolegjt1VoGeMOjuFxhz+q4V6/Wj8/qpyRPhjnzVWCJZ0+DZB872/lbit1GLZHHVnMqYQJD0jB3Ekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrSMJnVF; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrSMJnVF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43638a33157so1805134f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 02:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584610; cv=none;
        d=google.com; s=arc-20240605;
        b=VZYk/gi3uxdf5XleHThpNCRXNIhblBkvlw421l+SudUybHjmwRylQYWfmDZT52UlII
         wa8fipeg8oOhNjPINw5Tsl79UPQ8EaAGN+jywANKysjSoLt4w5W6uotIhasa/ImgrO9u
         BRjabQxIdOKKFcYRtKX5VoahS5hVtv5of5FgtWLgpUI+ky6XVKPIwywjASet7C+GuSMo
         3ss2uBup3uq3YdOdeEQxLMlsdlg8SnJydTGQRRnpF1+Fy0iAVbrJoWoOCuarLecsN3k6
         jfg/FIoR30rXsZu3dv1xyh6myD03lBb2VaJwPAU9Y/OJQlNQQxzfALKRL5yJP/ffHj1D
         lxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        fh=ujkHFZvR1Y4wW0pYvh2AquNejTTVTh6fcbrOciopDLI=;
        b=j746005KZcPr8h+LCi06LzEIUF2yOWoga20/RfhhQHU9uiBrrB5r+HxeBOenIpl6ao
         Q8NmWtLlau2SyQnPFZLHO0bL4LYj1OJ5FrzBhqdOlPPwVZXgvrRcddLY1ppP/eoaA6Zw
         hpLsonjBLUUXXHqztZewgf2hTBKuebjRAaDqFx8IJKfyjb85r7xbpeeYrg9lWR/0F0Yz
         Bz2X0wLoemN4uYojytfPDEO7wJXCMYFRIS4w4xjXBYrj7XW47RB41Y80QxoFKRhrCRIU
         zelURdN1H/xpsyAkIzTKYVpL9h+mRzqm2YpZMcZO5FU+yNQgOR02puQ+LWM3Cun0lAwY
         S23g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584610; x=1772189410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=WrSMJnVF5uBG1etU8Ao1aJIH79rL4B/ID7aOQVzdXbXEAdapztjr+4Ojw8JeHNFzt2
         dlIX5bMaHjSwAwqSEjpbFcjWcCz/Ytn+K1E6hC7kI3h9qjQUDh33ZJHsKdwmHuuhVGRP
         YFF0cE/9CorGsiF8nd1xmbzJ3t3K/qoPOti9J8BMYJ/xUB/nPHYgwPenjrQey3oTVuLG
         c1sOzkT6SCPTSC1qWfTj6n+lkDppOSu17WoIm0D9qCdM74Q/2YDEWRK19PZ3iOOmz7QI
         hGSxz50RSjTI4gysJQiaeqVVYLKibaZlO+bWe1TNVaOl6HXS7zjCEKcoetqQAgYiZCyB
         y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584610; x=1772189410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=J8wUykSbvhdZutnB2j7tDSFCXE1MfaLHnrv6LnnQehJluQmHq37JPCPwOc7oqgxeaP
         3wFxgLXuAx0lRu/XYbr/6Ptpd+xdBEJBG03EkMx8PFfQ4JwJK59rU5ZM4Q19NYT6FJet
         Qo4yh7X7MeeBzgDpJ3EeeeCbXDMDGVfKC6OKzuMVBtCd71goYDodc8FgnqUxjZCqgsso
         sW16vSrGQa1ZqodoWX6BYfCF3m4ZUlGtZPCPrWoJSZmxCY0esMMJFSMbTADrdGqfj4Lx
         SBXjmXZiVQkuGvJZU8tXMTgiKXADNK7aSGxBRBEYKYtGYULJlwneOYkZ/NZ1kNbAjyij
         NNzg==
X-Forwarded-Encrypted: i=1; AJvYcCVKhD/urEf3eZSeWsICn5VNvqpuwvB3fhdhHJz7d2FC18CngGS65MBrs5EUF451xGvXpFWVSSS+f+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMM9co+/+LgSWAzRPgQVUXbNM3sdDkD2RUn611nKjtOJdulg+
	eEpywrgbQUoS7u/jAiE/+SN0wMtouG1DC2rXQn5dBV/Hh5bSN9qJYARGBxOvDm2QvLDHeopcOIF
	Qng8V3HK92zIs5AL9VShC3uHhZwWqyCaeIcUezl+N
X-Gm-Gg: AZuq6aKCyljSsIVyNaO6cMzfqVXTZq9bxk8vevzPvrIzMcNW4pxFbWZOePLnyQbp9d6
	h9Z8uJNwF9QP7lq5yoCykRSQmB+Jz0dH6QbyWX4HozccIcYaT0TKOQSOw/G1m0ZGttLHsK04WzR
	bq1I0QonN8ZgSq+LIyHGSqljJT25HAMsF+1UQhN362d0M+ezerLSGev8UeDH92wOGx9sXSp09h4
	/FERjH/vZL1KHtnFQu0gZQ5JIRl0aYxb5jVeVhUtjj7iNTM6tpXWZOlA6Vfx/X0tLxbfKq2OOcv
	/mk9isfp0W5B1PHvsonBe8s6M5eWQzt8my9NfA==
X-Received: by 2002:a05:6000:2409:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-43958e00ce5mr15101201f8f.18.1771584608836; Fri, 20 Feb 2026
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:57 +0100
X-Gm-Features: AaiRm525n9TXR47KvplRQPUHuuUwgU5iN4_ng3kUHWK8LN9TrQcHulfhA1IhjZ4
Message-ID: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 61caddfd89619..efe16a7fdfa5d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// # Examples
>      ///
>      /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>      ///

Either keep the imports visible or delete this empty line. And either
way, it doesn't really fit in this commit.

>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///
>
> --
> 2.51.2
>
>
