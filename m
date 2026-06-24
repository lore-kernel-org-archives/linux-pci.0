Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D63BB671
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309792; cv=pass; b=rEyQVANLFuh0dixlWH1Uw8qSAwnkytxwAvgdS4bPU9y31eqhOlrGno1HKzL+H8R8R+cXe5e5/S5eB9MeKrVSkQEEsz4wwMys/ymwQnNhhB+UzUmajSajEwlUtbiiAReglHhMrXQlOo3YSU8qos0oXgCNyPEYSTJegexuEY5ZiNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309792; c=relaxed/simple;
	bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK6Pvk21wsobIeTvNR8/Y94mj7Fyd/DfAJ6DVoUOR01Rxvm7sQAPMclmAzHcPiejZxfbg7EcrBRdD56Y7smL4ZVf9B/ntxAB/fCIxu3y1gqly6fyRGJr2BgZoEq91P7raeZ0oj7ngC9rnxcOPj17nBJ64hH0IKLzFGjhkREDtpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsecUjtc; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsecUjtc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bb87c90deso164490eec.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309790; cv=none;
        d=google.com; s=arc-20240605;
        b=NlwCYdxfJhzH6RwXWvfIzL9EXAYoUREAcnWUU/XOojb4dIx91d7BmTjUF1bHNj7oAj
         ZqhmqzlPZ/Tpw7uNrLy29pgSvOVT47WQf8HtjFDwA0P0G3iKampQv+nFVnpj4+nJgHdZ
         I7eu6VZJmYuatV9tVgRaDqKflMA9SSRy3b6oRksv16htHj9XImH4Pl4nQ7CTQ3ZI7SN/
         zM2RE5P1jvFdECbsIGyXevurNPkj1oE5kERshN3a8I5hRKSNKkTcZBpUXJjd9YIDb8jD
         y+0QLq9M51IAh1q0035lMCfwVztJEbaflPsEkQS1C/dXK+QdKBHzDBwxMVaQWpOu+meZ
         Edsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        fh=KLbI7xhbsOGk6lGpvV76q6ev403WOXuBb7fxQqAT3bs=;
        b=TKz3MfF6fWlGYdYni4LE2hykskFJvf4SEmtLk1Q/Hv1lNvcbmjyvzJYUb9ODT6YEyZ
         /wn5RdmHesavvuIG14kl8LPPN07IwldzQBVldnw0Ep5NdNy+15GwbokDBAs/MuEO9kiG
         a3PIORB3YeXsnbtn3Svrd9xDLt3ZleodEwD0qqUqEY6T/DL+diZE1Yie3UVFr1q9I9cR
         MWmw9arhQgHs0T7vbSdmbQukQAnVC/rKUx1ZYNqVgXeIeRBN8Qf9a64uqPf2O32H1TCq
         ug7EoHIm7x2O8DoIzd09Jg6DP5ZsYHXxDph4IT8I7wD4j6zZ7FDw4ZEU9pQ67hrvdrIC
         66uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309790; x=1782914590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=hsecUjtcX+2100VDiJTVQfiUzHkHNfosIUE1h1VgZ/aN73Nrll8dHIpfVxaPNGO3th
         oOYuhmQtxznpu59gHGEhhbQo15BpIV9NQ7ImlhNajXvohWnXDFnpuDm1cuVRFVcfNJTz
         k6CNvUOh4DZBOquwW3nuxkWRdr/+7q6JdjrF1dzUp6OzGj9cq0/tWnIR94yAw/mPyO3q
         6/lKvpIoQSgjkltjJSjbxiKJGWJCinrf5FAQ9zF7i9/S/fRNLEvQT/qqxwU3yHCpOGXH
         sRz/hIttFhf08bwI68pb0WiDIZm/lziXf5I8tsWdnEJ8IIxOgezA93WhXXVH7t6v5Ulc
         2sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309790; x=1782914590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=Xe6OmCxLq/2jYcQizRzm01BO0QrNnpsR2rz2A9yA1Oep52hXFi80yv7uqVEQPqKgKR
         B9IebvWukjbEj0dQQOMOEjzsZsbrdhRyDHlIii0TnyI4rBeTby7XCfMV7reh2gNS5uEH
         27U9bYpVOVKSGYaBqFrpbsgMOz4vsQwpgRe7QB07q69BkM5HatlwITaNNCpoDzSlR63g
         362mSpgI8HSa8iQ8zMxuXQ3Jpus+uM56bg3SPhEDuuspPCL5GCQo3SVl1uhRSCSsgPUx
         bbuHutws1zbiBGML7pUFAC/gY8xhmDF+UXj1cEujU+0x6vZN+i/9U7O+bcWBWXTp2pdA
         lnWw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9f1uxi61mIdCAv/yZmnvg45xm4QAbRnqKuhUX8DbbAJGnm8nHv0wazwLbA7tt/4pI3a60vvdonQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNijLUA7iLYMoGoY5DgN9t/oDf+HDCOrRZJpJd6hiIatBT2Opo
	94cZA5yLeqr9PvQU6i+y3SBkx+F5V7cAIWXW5omVqOQyKzw3T2Qnu4ohnKY3CFEGNPyFMHjSq3S
	4rsOF4aB6n2Je1VTEw4MLSi+qzWvoRYQ=
X-Gm-Gg: AfdE7clDGSYtvqQ+GL5238WsTdDzSuZ4sxSo4fUKvcMu18kbonYVysF8LN5kgs2qKFE
	oWkmFTXvsH5Rbr5qb5bicnAZq+9jtEHv8cWXeQB5bMATkSeBtdSs0CgLVsC65bUK6OManZy8q3G
	0wkHce0JvpOSlF/UpE/wNV/BU3iMBhnaZR9NEHuojsq9Zsp+yjiT5cFKinSdzKUrfYLJY8iKPLo
	5bTmsqahuycRnxOsoc+8oPK7qq7IrIBVoZv0GN+MrPjq1C+umpzW+hCV2XC8ueAwoenObpomnLO
	VDCd4u3wXMBEMBwmi1ojXs0zn+Eq4N0TsNqQzXF6uolVK4BAeFod6XDHHzwv40KKY2zJJmJtxkr
	b8S7QizOAQwxx
X-Received: by 2002:a05:7301:658a:b0:30b:c8bb:588f with SMTP id
 5a478bee46e88-30c5240f7damr3538472eec.5.1782309787929; Wed, 24 Jun 2026
 07:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev> <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
In-Reply-To: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jun 2026 16:02:53 +0200
X-Gm-Features: AVVi8CdZJD474qdF4GDgFLlfJ_vD8WsFaomaTI3YSRH6pluhcoRUR51gh_iz4VE
Message-ID: <CANiq72m_LakPxHt99+3eBn2rXokr3vZbdJf=Wk-Yi8_ufQ2mvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc abstractions
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:23=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I would only suggest adding the new file rust/kernel/module.rs in
> patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
> similarly to the other module-related Rust code, so that the module
> maintainers are emailed when changes to this file are proposed. I think
> you can change the existing 'F: rust/kernel/module_param.rs' to
> 'F: rust/kernel/module*.rs'.

That would be great, yes -- thanks!

Cheers,
Miguel
