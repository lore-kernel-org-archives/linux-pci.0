Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069030C146
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635932; cv=pass; b=Uj5lwCkJsZva/uE/RiPMtInQmRNPMBw8PPK+SO00FIwT/BsuqQh83HNHttUyhbSCE1BNCH9YVcong4XzRe8+SSR0zV9997VXukbibTySsAL153jbjXVdMlcmwZBWmaYwp/ohqV9MZPB2aGRc2tOW8OPIMIhPLYvkysroH/6gMd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635932; c=relaxed/simple;
	bh=1A9tdM4UxvEUDadWxG3NZidYXbKcok5wvUqTQR6GVlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvKO0+GTxpd8S8gcUhAQcrVLJTg2wtSkf+qruVJKnSuGUwm6Hq9QKHUqiXWxFvyMCZeCOkwF6kgCc/W+86/e2jV4Pu5aGPpkJWC0+mA72qcnc7SZwnMqBlfbKL6VJ4SKo1Ji8IZh8izv/c5cxPazgVXqMTf+yY5gkRtyOWxNgd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q22iKF8/; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q22iKF8/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-399026951a2so208741a91.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 12:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788635931; cv=none;
        d=google.com; s=arc-20260327;
        b=pnHUQans/+ZovoYcIPdbtT68fomRb9vHtXDp8fjFEZCvrSbqcNVH5Y9mtz8w9jWm9z
         j8tDRt96Afi1Lw+xLc+uQeES6sl8TMcCjM98uA+W/NlWSQKqakF1bz9izxDPD3WKFQOp
         WQZst+NImwf61RZJszU5kbBS3BdZ6VmS4aGKhsnr/RxxKElp26UjCYP3RERhzdwDo2BO
         9y/cftykwqonAE3sGcT1m3YoqooBEHHnWGCA5IYSG7DRGpD0Bui3iCgVdj5hZq+uB0aQ
         bbzuoZKNVIATLcKDADb6q2cYYeyVu8brXNYVLTUMc1/6muG+Z4GDvRl4G6wNcSHc3nPq
         RhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
        fh=leRQxYBF/PxiPKDENDQv6+qLoo2IYS4lef7D1DcHlrM=;
        b=TqvZP0UnTFULVp6lJScGIIOWE6rGh1fyuM1mgDZTGNqegVqPsrHjABKxvVKvNJXaix
         6oGYl4Xcn7Br1vtJ7o3AB+HxBsCLvGCzNKjjTqnNRnA89tn9JBtr5cCYxXCNOOCj9ikI
         FRdxjDWWNzQRsc7C2BJNspa70yNeX6f+HXoUzWgH+2+bHDOtCiRcCIiA88HlZEJiwynO
         FIPqiCQ1W00Lft91iNUCFjpUlQUT0AC08TkvXPsBUWR4sWfJ/kC624QT33cPS0vqTvvV
         fnDo5q19Jw+JdXKuLlxIk+JhKPESX4heVb5tLV/TQBzdQ9Hf0sVqdQgm205VyhllYhAV
         Z/Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788635931; x=1789240731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
        b=Q22iKF8/xfqiNmykx9EcWT6bQCxt0wnOrocFLh0rF8/8QAW9Cc+PHcJwgKc0mLMmhl
         PtC38ZHD+LoU+zk9b+aaUPO9zykq9K3Du44XY8BY4BNBu2zHRfbEthKB1xe2Xh3s4lWz
         DD3Shmn/YW72vnBl5qWet0Jlnqs48Lw0NGnmpsOmLdJ++PQw5tueLoXvQ36cZSA2I3Ey
         6Z4Z2Y67L11LKmY+zrvmw/3M0qs/3ka9Rfl+DSWFQE08V9ww3e+P0nnbNnp9FecT7lDV
         99c9dZh55BC6D9QeSuX5hwzyGtq9xoxy7VwGT/fTKflffpW3BrLLDcFzvd/dFULqvs06
         ukKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788635931; x=1789240731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
        b=ZfuFrkw/WX674MIwl6MFye6lpjh2v8/8jZ7p4At9Agyc+9bTnYJFGQB9duJQzq5u0y
         QJPU+e4/rNC7+Lxpl/bHAIfMPsID1XNUYky6cQ3xALI/Xx5nzmpgM9DedwpjpwfQjlyJ
         eFeu8rE84mHqY75znQ3vSHrsY4TEr1wLjc6uV34gQFU9SdslmCgejM6UVjTDRphtv43Z
         2YjJp8BVySHLGrPWWxwcJ/qBlYTq+WKN33pRprv9cva1ufpvMMn0q5M7vbR6psaIM4h1
         AhW0ypQkQD9EcTiebIv+1LbO/8QLDZtn8uG3hyYeNa5FkhjKDoWvgcWQ3T8A+mXZ/ico
         dcTQ==
X-Forwarded-Encrypted: i=1; AKwUvByS1mt2f4An3tm8d6yikPjoQAceGDuGO/M6UhtCFk0obdelFqQ+niydM/61yEMIE7y/DiQyzosjr2o=@vger.kernel.org
X-Gm-Message-State: AFuF++leYuC8ORLEcGPoALqk2VC2Q9Jy1THrDN29x7w/cWko9DxdjpIC
	kV5TGtdfs8hEVtzbTMyz7pBsghRRmhWwP/oVQbQ/n9a0AGQp3t9DZB9pufuKxHHeA1tzxXiE6rw
	s90S8v9T9F8CrKRFmdUKHmc7QaLbOuu1ihQ==
X-Gm-Gg: AYBFou2KoYR/qLL88+xVnvyXiDqPWXgN69KcwPBPkXevGdAtg1y5xnjYLJJ2VKV4fIf
	AYGVapZqyxeBGhyo5Xp/OZj6K0SICUt6DDceLvO/5qKY8Bgca5xNhkmw+G50Ao40iybo8E6Fs2Q
	NJxryeygyGi9QH+XB4YEWObw5gxtAUyIbs30jy3nnf16qE5MrFBm6SZg9Rsv+VF7AUiIFCJSR/e
	X8o64slfRE12ngfvqEzRyB73NUTe1Svuhrc7/ZIJSucnOrWbQmUrXmPZFY6+KWXO9TBp2QM/Cpu
	nZXMLeHNNZ84jEpUQ+c3ABjVWLHjliHF8rhR5SKNAHm8EDVW0zKJ6zQUiBkl+Tnst6P4Ag5KqNA
	CBI93eziHOgWQtcut7fHIyQYjGfGHQkZVhkd/ndt4iHqK+IwxLh3vJEegVWtL
X-Received: by 2002:a17:90b:3843:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-39b3d3db82emr6481594a91.0.1788635930630; Sat, 05 Sep 2026
 12:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net> <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:18:37 +0200
X-Gm-Features: AcwNN1W_ZpD7BnW-6N9vI0Wb1kb0jyPzchOyBf701rQL7ntZoTH7GyzL5sIHsSA
Message-ID: <CANiq72k4NQ6yJByyb73Sy+iwqVc=i5CuZy2b5uRVksA+gkr9qA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size check
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 6:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +/// This can be used when types are known to have the same size, but onl=
y at runtime.
> +/// ```no_run

Newline between them.

> +///     // SAFETY: We've checked that `T` is u32!

`u32`

> +/// This is typically used in generic code where it's known that type wi=
ll have the same size, but
> +/// the compiler cannot prove it generically.
> +/// ```no_run

Same.

> +    // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds=
.

`transmute`

I think we could also link to the intrinsic and the `_neo` one,
perhaps with a permalink to avoid drift if they go away, but not a big
deal of course.

Cheers,
Miguel
