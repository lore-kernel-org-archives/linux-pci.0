Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791F33EB01
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584561; cv=pass; b=s+2COg+SwpbCH2z4LBVXu5FRW3W+JPl0fTmOm2LhtLBE5DAGQq9ABuiMs278OkgeQEeAVLMvcwqcZcLt/psXCHcDga55cBxIcZRUZEXdtWA3/ijIaWNVGW2nNJPAqLCRwZMBZrtFJdkMcyCphMUEcCpcAqkDSYHploGWl7Q9gDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584561; c=relaxed/simple;
	bh=aOLVDIR4WnlUw1nvqXwQwf234Bh2W6bojDklxd8Gees=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=covuS2DLgYj1SHC0C2sYta5H03v/Ho09N6aNT8bxmR2Do9J8s15LJptAVxJvLdT6iEBkUFpX0B9kR6k4dO0YKPIbV7+OuGcuyjrMIguUL0j/CV9D0mmiIThsurxef8KGExBzXroAg+/x8mFXbENBq4D04Kh0EhfN/uax2KSgMRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JABONran; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JABONran"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48375f1defeso13660695e9.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 02:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584558; cv=none;
        d=google.com; s=arc-20240605;
        b=PUUFbaSycThD6KK82mttQDdP8vO674Im04fiM5KBy89OpRmUbpXDcZTyJiVD4BSymy
         7JXb7/yC6Icu+kPBS6wl5N4u19ojtP4KqAyN34NDubS5SS/QMmdaFYh7FWKNyNAnemJh
         9KQ6nlBt57CzHtcvJIF0EjQJbBruaAOFAnUowdzMFSJcJrhArv1szfmiaAjJuiEHvkob
         ObNaTtN1evfCway9yNQ/OGeCJgYpUh4ur2lWztz5BXDg4hLYxcrMhkBf+5iVW5cFmdSe
         U3iMppbfsVyBD8uctdUUZIZhQgFiRHpWmkHorT0YUn2CiyIy8IWga6KvRA7D+p4Guqdp
         rNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        fh=Mmjk/kacBs6sT6eLcZc9WoQtV5PvUIeVWYr6TYlh2Ow=;
        b=ESosviBpG3ze3PP85T3bWU8nQVEUv6SCetLE0gVAA6NgnRUPq3SZAOX7iAYg62HXVM
         cQFNQaWNUPsFEQmn9nWr8oxs4Q/CncpmsIgc6X5qodBts7tR1FYBs9AHpvNO0cdtYeqC
         H+YKHmP+vSt8XY6cJP5jdtCyILt0W9/5A6XfKo56HdfuGWCQLdek1/I+oMDSOih4g3kC
         M4w4PFfaqd3TcvU5xcR0yHwzkdt1wHRW5XieWPpAulKt1P39JXC0+0fv62l1boxRHmjc
         U8+4hmzNLvKJcvf9VMgthIuSkirL0keow+oHcpRV/t/HJkUfHuZPnb0aXY1cSP6+0ane
         3dNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584558; x=1772189358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=JABONranC/t/ZRWaTeXGCdbAg3MlyNGEm32nb8g+0L+PjkN0k7v4kud2f/Lc8HtI9p
         RSJ70uRPi9eRvWSiQdR4rSEaIEyNlubpm35GfQ3YOcWC3G9WcVSK61xAwUJAmv+fEQjH
         U0VDLzRhvDs3mprDIFVy3TKWENLnYZA8lvak3zCs19Vc7dc+4ymdsOOcoNXANG+9O4wA
         yAElmODqtzgqw7FDaasHWfeg3jDiHmL7dRWAknBHeykcq12ka7XVCsyOk7kCewg+AQ13
         iGKyafSskeM/uBbKXgMnW0Dq60qRd6tC6hK6mVrNBSjRBZQXO7HJmMLT1etJbZnXuKpV
         q+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584558; x=1772189358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=JySGpyqQivqpbH21qbggJZ9Ec6nUzXYM1/JMCbkXw8a8odoiwlUiVw/Xq7Lcm+j0g1
         cxb/M8gKDj7ZGyzJ2/Jus4UQYfTyNQDwutOAVcXMLX6geWZXgfBKh4LQ95s8f4+2aSYP
         tc/Xn1VSdq9IYQHe92Z4X/Hq0gn+k4eaQKtWFFCVR9Ys9NTI061R7mnYbNrTXNcYdccT
         1E/SpgrfKAt9n4Cu8Ln/ITVCMGaV+sqbarz9e5cY4cnsZVYYKWttpiezZ4ki9qKMjLca
         2s9bbRJ3p2vfhs3appurZ/r6Mu/wO/iokS1RdvlFaL80u03zENdFo36XL6jEfCFOo5os
         7XYg==
X-Forwarded-Encrypted: i=1; AJvYcCUATsloeOrAPVRh1shdZAQ25YE59zCexgjdgSvTwb0gPxTm0AyNUId32oHjuoo1KsCwuqQRyJXOgwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZCKTMq37EuorrJYQoN1Ur+yBX2dXNObiKaY5LoSq888CgBKw5
	XG+kTtK+lTOiIH5n9gyiHrYhqYop7Vypm4b1m+z/PDfiLrzjGqOUnW/HX2+LOd7KDUIGCJWD9vG
	IQvHndzkt6YR8hcKGdwzI9FaAmgbEEJNCMQrGBs5l
X-Gm-Gg: AZuq6aIzfSJc1UfY9p9TXaKqUFMoyNfHOOtSnZwQL82Q8VIeuyvhWmuR+4bzWF4tJPY
	7RY77LuTatX6NbsptWkcfcxbP4laoe9hnBz8m/y8QBqMJiGnAcRweN03lNrta7ScU0k4LQ51PbK
	RRqBibU8AFfkA9n6LM+CnJ0PhTQE4Pyll/+yYL+9dSAbjdjjBAov2zARc9hgNZH0Trt6ExO/IEZ
	H3kPp+t0dcnbuf6idbl7hNIuYbmNWRmpeOLhqAVAck2Vn34c0orkPh6lQfNhGCA5oNqU5HvhSEk
	hvFGbPuU9Tz079DsJaj+AHb8DPajpSq55kd0hA==
X-Received: by 2002:a05:600c:5289:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48398b0990dmr130223325e9.12.1771584557648; Fri, 20 Feb 2026
 02:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:06 +0100
X-Gm-Features: AaiRm51MAhLW1OtRkAHOYwRwshfGarw67yqaE2vYRvgLvB2RCqsl8u_ReojFPGo
Message-ID: <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
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
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/page.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 4591b7b01c3d2..803f3e3d76b22 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
>
> +    /// Create a `&Page` from a raw `struct page` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // SAFETY: By function safety requirements, ptr is not null and =
is
> +        // valid for use as a reference.
> +        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }

If you're going to do a pointer cast, then keep it simple and just do
&*ptr.cast().

Alice
