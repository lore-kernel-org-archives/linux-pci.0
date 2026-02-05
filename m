Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1452D6409
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285286; cv=none; b=fbXoAEtxxz4BEd8ApER2zFyx8edBYSXL62F0o7uew+IJlJV8da888lgDOf5l3Tux/xM4PI8GrVcM8tO1lWW/aNO0RnFSfz4y0f+dtt6FBj0ReQYOgUlGGbc9546ZvNssC6Baq79QOTqm9VOC0yXbv2PFVuI2Ih6NRDYOulg7YFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285286; c=relaxed/simple;
	bh=+gH07T7gJ7+X3xesrNA2+Bs3sMLJhA4gaSIsoseJoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f08utrXbOV3zGb/QOzOSeYY4bD43dkB82J08MqdvrOuqxohRkC+1c0qpPVx9bN1pyItTNsPIJcYLA4OCFyPFVzwoGOaBuVWx99ssAMRtWYwIjrdXCtR6q0tNXwh052kKwbv18aPSDGzl9VT1vapw2qQMmQVSfmWM8lulcgEAwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIztZXVg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIztZXVg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so526073a91.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770285286; x=1770890086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=OIztZXVg1hLazuEkmqd8LlclnaLE4rA0fxlphw3KvArdlCYxrvdQZyDtKojtlalHtG
         1a66CHSgueLHo3e7wgPFL5SSykTdE+DP/Wqo/IzjGPPDm4GcyVlPjTjvAduAfl8knaW9
         NrADuUlm153qtL+TZOZwB02E5FIxQEvXf8VcuyXxGRlrop4XdAcCjNyZpmvoKpOXaqx5
         iTqPuOKTZ61EEAXWEtUzcfKjsOfoqd6olMTXQbZ52wRe3LltSc6K1bAuQ04//rTzOU9I
         efFMVyoMMVC/Y1sfaoxEqpR0CYhnFWHReEGc2mHEIYgZfGzJCicUald9h2trI26NPIf1
         gaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285286; x=1770890086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xBIY0mav+3IAaN2sDOZsKW4O0cnUlRHLSnJJ3/BuhM=;
        b=LAyAu2GrD8H303abwUlwvr5Bv/hKQNz3nV8rDk0T1Dinef14ZYzJWW082Tj1jH+bEw
         I2J7dizCTOimKmHJfwYshaDXBYEor42H1CiBY8YYN9GapfwZNXTevSqFS9x6JtR78UoO
         FaYEIngviXwrZGxlvaOKPUGq3rdxVREotYa563VfiPtAm0HptHxIpITZ90yaWndQCtJX
         1MaOqAjaXdYIj/5vqh7eZjool25y8i1C37yC1pc5KXag2PslFv0CC68n3UxwFf0VBECv
         wgYQjMlZe7WvJnVyTGFY3OqX6f4akKWH5r3N9GSHSAgTdXyIyOdyNq+wkE9wigsfd4BW
         YmLA==
X-Forwarded-Encrypted: i=1; AJvYcCVBXteOAEUuhOX3jzHX/KLCERYhLuE28wt6dWFtpZBomPM3QId0dOu4z+HxnVRojN5vMiNN1UFX7n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DXjdfd7yGozvTr/dhypxilJ3Hwe1mswJicbeoXM2M2vImA0T
	rJRxgla5yPoBrwn3JW3l5PvmrFLTmhvDQsokedLh59qFjM6hbnOGZSRp5yJ9gKJqh9k=
X-Gm-Gg: AZuq6aIt5XtvhsXI4MJR0/gtgmBl7Ojm/vA/uNQkWTt/JlJzXMYHzhWW0zzwfkgqP1x
	aG5uE9/s/qNcf6eo2DECHBSSO4K2D4r0yBiMI/BsSTS8toeHKKQBVci+8HLKcvI5kwhoqr3qmoP
	mGAxtLSkG2Feh32l8kORAmFruW5epolFl7L8XpQ2XofQZ0U3HxpGiIH1ACeweV2oF9hluSfd0eB
	Die2SnwWzqZzG++vvsHKGZ8OLvVH5dzYcfUncDDzsdm9hOy5ubSStqwyV1Vd0ij1SNnhqMQ+hEB
	aC/mCA2ZPVSDGsC4efshRxbFfAneLFjK9muqpPnBFbZXrSX7bmMj0k9+vi544N+1wDJ+CH+hArB
	QxCP8x7pbDAQN8HlOPZA7KnW5d1I9VQDZ/9tQQNWViDjYjdr6dGFEQmu7lcKKn1vx8MEEZt/age
	3sNC/L1x6fLlo=
X-Received: by 2002:a17:90a:c110:b0:354:a05d:9dc2 with SMTP id 98e67ed59e1d1-354a05da864mr1522955a91.9.1770285285886;
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354894533dbsm2000361a91.7.2026.02.05.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:54:45 -0800 (PST)
Date: Thu, 5 Feb 2026 15:24:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
Message-ID: <xh3iuwlz4wapmgzojg4v3sen4oezfua4vsedskvrqhc7ryyclj@jggikwra6dmj>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>

On 04-02-26, 12:56, Andreas Hindborg wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a760fac287655..06fe2ca776a4f 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,8 +16,8 @@
>      ffi::{c_char, c_ulong},
>      prelude::*,
>      str::CString,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  
>  #[cfg(CONFIG_CPU_FREQ)]
> @@ -1041,7 +1041,7 @@ unsafe impl Send for OPP {}
>  unsafe impl Sync for OPP {}
>  
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
> -unsafe impl AlwaysRefCounted for OPP {
> +unsafe impl RefCounted for OPP {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> @@ -1053,6 +1053,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
> +// `&OPP`.
> +unsafe impl AlwaysRefCounted for OPP {}
> +
>  impl OPP {
>      /// Creates an owned reference to a [`OPP`] from a valid pointer.
>      ///

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
