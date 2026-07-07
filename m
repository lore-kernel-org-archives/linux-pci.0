Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A743FAE1F
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429501; cv=pass; b=DnLzkZBhip0CNHaQhLT+PvPzvzknVrjMcctDoC+dOT0A/k5cz5m/QVZcfQFVCday2rblhcMIQ4Aahj1jZcKTa/4V9Jt8KltOTQ8YYakIrRMMOMyRnLEXmRpv3p7/mW/GqegL7bFoj+yo/MPHrap8Uqi3OUO+mGSwcNjb7wBzWWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429501; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrrGfTVPqJHUz5nT4xCj+Eqxrx9XudmeaZ2mMk2Ut+KSl79D+CD7hK/+D9ZDhdjcexHVzaicNy68W9kAcABGZN7vx7iIQIF9abfW/kxzKsmt+pzOF4asdPY4M+BsQ5nguTcwIAZ2AD2RABQI1kUvV8Zy4904IN1kgFfFlqY0kyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwFqpWQm; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwFqpWQm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c7902f47so25664085e9.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 06:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429498; cv=none;
        d=google.com; s=arc-20260327;
        b=Stji6JvTL+oTmCfRc8sXzb1KkzDJJFettaM32ci7LrASiejjngOEk6/FPcwRYaMNIi
         xHJGXpIgl59GmqIis3+C65rZU6D5Qy2Zmnj9qc7ucu9Hr9YVfPToB9JHqjQfBpoGL/C0
         247dXmhCf4GUinGVyoPO8TydXZN/5ShnjsDcA25RPfGbnBIzxvOsoXaOchPmYQpqETea
         vepQFj1uSBUH2d9X50EwAJyNUiCYfPbhE+PPKpoHDcOVe1tEByjC4tu/ef0ICOizIu5N
         L9c6lXz8v49cGgnpLqPRSXhyhUBe4BEnW73cMtHY3jj/8DrPqePhKf9mzFn8aIrB2UZY
         Ejig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=RIVuvSgAw0jsRKEjl9T/8xvFPFNehB8Fmyl4DdMLsAo=;
        b=lRf9POsunMd+YnJv+a7vrZsOq5+Hv52CvgA6sykucYkthypr9FIRwjRybjdLt1yroE
         scdUXRzj5EEGC7ttoXUKzdE3mxvmivUHM5xSAa7AVnASxjFb14l22QBwJk+QjCxo6KIM
         fz2BLirNNPkvu23kcuFJOiTHoDq5QQX4yo3F6T2dwJrHtT9JFIQZ8ueVdFnZz+7NR0sT
         5BlYxMcb+CYF1St0JfPCNgWf2oXDmShFJpsLwr6ToqkGKKL8MADu8nEj02IM18AwZg7l
         hBbe4511OyYucl/DSvPR3yPoRo9edfv0Ow+OiKq/fy4PbC3Z9EVDsXoslxObduvq6MhW
         FLog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429498; x=1784034298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nwFqpWQmjpkhT5N166ROjlsHRUNBKTRpXMHaTMJhkX1rzisW+j8ZNBgqb0gt0uMyFK
         kJBGogIRdGOCv+IfwKTap7nCADTIGP8KSe2axCh/K7UPtN3Y/fPn4dG6mxglUfb5sjDe
         z9wuNw/bh4mOjkdHneFd2IGooWxjn53QI3Stm22mJIjhjpbdYFfbUmPDdJ+o5ujoCGZU
         Eb2D+u6aPJP/dPUUL3BCwxU8hiDgJqf3hxk/zmzS8CtdaNnPAk27A0y9mKwZuZGJ8UZk
         RsXJ0igYAos9Lsjb5CO7DSUU9QppF9kBmRG78Ibkhp9dKy3x75qDooky2A3617Q50Udn
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429498; x=1784034298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=Xxx6tsKaMawMcEtAYDylkymKb2Oss18XfoC4UUzVz8V2AQCCEkF0NUNU7VJUFS6V0M
         NbAd1KVmM56eRNdj3CyGS+RxOhdX8BJ1WXpR8Q6bA1Lk6gK1Nab2pxDIPsC7DucAjGX6
         3b37gXFfCGhdsFY8G/mmaTo8HLi/daqZmQUMfcyFIj5fBzKBPNlhP9SroH644wCO/qrH
         xH++kiG4yQI4Inz1PWnd47OcrTrQ1lvJjyHqiIhNJs2mzHRcwnFdbVEjiUQEM+Xdr7p1
         irTE2gs4uby5CWiz4VvZvhg7QFJFC5jJP9Q9dsW9iLQdjnkBeLocnC10RqxC0JltOnBE
         qH6g==
X-Forwarded-Encrypted: i=1; AHgh+RpQb+dLr2QNJhynC2/YO9eG632xzqfXdEEsgAYXF+EUyBh0Zava9f/Ozsg1nYocVa5VcVhnwXK5hZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU0iSdYs2S+U/gpIQgx9NSjCqtLaNsTAUw2DP9JyTZkdjjudW
	JNcSnGoXmTDznZ46b0JwWTPV+RZKGixSygF2Dr3FVhSx+bAtAiTpbA2F/uy1vr3IkUUEL+G3DEy
	dgc5dfWJHYB6lTX/Lyzy2Ou5gzgoMP4sf5HTiNtQ6
X-Gm-Gg: AfdE7ckrnhsbQTM/lEt0GaPP5ggVF54OTjB97aSYOsRJWtDbHZ5iPuM+lF3eYozhNzB
	yNX8w9si/bEc4qWUdFSQjXk4tZIcDq2QltkvyWMDm5A2Ano+N25ZvX31SIBKa+eqlhJg6pfMxGr
	a4qYOXiaI5BscG18oiYclOvRwvUe6TpDI7gkXh310SKVcU4yNWGi5qazntAgyxwwzmxSU6WQRVR
	7rGoOgHPlumkJWlvDf1Ps76QQWSOUoIhoSQwIiZ6RMO+KdTKT34jdJuOhi3iVS+6eZAjgO7lOAB
	pk51zBnbqWrn7/f1YS/+HypXFIU=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
