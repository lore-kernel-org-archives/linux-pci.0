Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B23CDBC3
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690093; cv=pass; b=BxSHdKNX5MGJsjJQ1TAqOsOEWap2zc8yUpNLOhNN3LKoVV5YdUTcA7mYOevLRoQr8wtRLmZyRABh3kXIfgYeRPTRAWXYg+cvJ5+y961TvKiNuAPAk7YIQmN3yhK7HhNSMspsPTQ6K7Q4k1zI46uHlfQgZRVWI2/zHY9J0I2jMdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690093; c=relaxed/simple;
	bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODzeDld0WEffQn9Kwmbsxs+5A+PpkVm7Vj1XthMZ7E7kHVIt5vs45WgijFw0wY2z1VU//xomS6TWa9yc5OT00jOfxnZhz9DFDgQfzS4ccpOU3Kz6HLvI38/P+V298LjaW1r/JvvSi+KM4A7vQbawz99ohXTiWpXvMbYUrFZmcrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uxNMeG; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uxNMeG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eeea039ebso3176254f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
        d=google.com; s=arc-20240605;
        b=Bki3Ln7iI6vKNJiZ61I0dVc5rjqsJkcbR5tP3L2EVkgne7FCVaXbfran1ny4DJBpPZ
         jzvf2tKkQHHVTM0Ei7Hg5pxW2LOEVdLIENZ0gCz5iZ+83BwktaUu5J20zWgC+54w0Suu
         wpkVJIFNMX+zdbIlhHXUF5mN23XRtBs4CK0c1qzS7lY/eRM8gEyYqG47+A6ThtfKRzVf
         2j3mS2xC9oKhPOFEimWeKJT6O8l+omgAUtuiPdIaKBD3PVBwiCwpmwfDyqexMhvVKSge
         ovlPORurPcBs+KYnpy9DZCCAFC+JQAXO2dqq7LmfG+IGYx2k6vq3R7NXqXcTd6v5AYZ0
         cHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        fh=KPqQ/e6Mqe2L5kUMvS8yJRTeDK/B3/6oeX/ACZB0e7g=;
        b=LggDM/ftT6ZfhmX3xRg4UJXrYTlVUXkmumz/l30x9+BDOaBxspmZ30JmYHzL3ulImR
         7mNb6fXN5PKHYNyw8wOR+hjPIA7He0FLooHby6O6cChmJJsOESti+4tXe6ChorphumQF
         4T1c9b+tJ5EcAGeUuabcbvxhT7PtOmdYYoiIGJVRiuhHpW++9bQ8+/2roFmV+pvLGD0g
         dkyI8nHQwoUydCeQbgwjC0Ppx56glFKleU+8fejEYd4Fr1Z7biujkp1CVzAzZxmFZ6jc
         L4ExhMapOEyOrQkiUmxjX9e8rtQ9jRA8hQnPZOGZQ8gI7FPhNwHCuHXiQCwHgsmKRrzb
         WdBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781690090; x=1782294890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=P5uxNMeGcDIN8llkO0LerOZseMvI0xoedivCJ9FZTvVkZQDpB2XH0vEThBBsXiWG9u
         sffI4uZumgWiX1nzBNMDek3/+k765xSl2pY7u/w/2RicT1DEfhmO3fV0tSyaaYwcGcUW
         sDIXq7Nca7LlV1xIEunZuyJ9m1LZ+oEW7N8dbZE1czoJgFmOXyNTjsG/v55Westq675s
         acUzZoCXnMYEzFXbS8+neVOK/fnhKQe+EzbGYwDbJeOrcvNmrqkC4agNzuQkCHFs6iTV
         ZeHsur1G/4T4lhO749KNW2vcfZXCrVawQX8QPjkJVWTDVb+5i/q9LvGGwrB4P6paWDbi
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690090; x=1782294890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=rzaq2ZV+QWyefhst59jbBjrUrV7TFwnQL73FweJS3DSnovUU4Ya4SAY9I9Yn1C9OV1
         zXH6KDjGhB3iEDQNH+QqJaY8DFUPlriPdJ42oGsACkVxrNWdgLAXUi5i8wTFK9sMzLx8
         ZFWZMOQfr5oSAPi92xbUAEbpRYgBr6bE5nfI45IXczvg7+gLlg/Zlp8znrL+V0lj10lM
         iAAf7glNq9GIrKvAKK3t/zCPyvDa3s4NK0MdxLdFwMAqdm4ibXUZVFXvEDTBFljiyMtR
         72BZ6q1M/p0W58dU/58DXThILTHTLd4C+YahCptHHAt5L2DnosG26bFZ2i4sE+5OMEor
         OQXw==
X-Forwarded-Encrypted: i=1; AFNElJ+DcDOJVcofvx5uhvhZTGkvvTgQoJ94V0s+hMaisOCxVbPyEu/RH4Oqo8XXKjSqY49zpQNyALA5iXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhl44dXbzosgEs6hee0TaQJPFfpekQXG5u5fGNYNuho9pwBn6r
	tlE4OZ9VSZ1V/Akns8jxyxjD2jvUmmzEiFCRxUgQrQABBdqsMBbMUHZEl5xDVpK4ZBx3NeRzAfK
	i0k1N8zOgVdEOwFx5qY3IH6TIhVUsxLkdSnp7cBlC
X-Gm-Gg: AfdE7cn0vJiQml71cb66sNHwp0qiLuXPDcyDvEWTSaitDyYek8NBUzHOK15Wq7pxPP3
	5OhLg7+ME6edYBh/2N2EHn8JiZJqrtMO1F/Hpw7uTnN8xtFaD9vjsc3aqYXEO4NJeCPkTFd0IdI
	zHfwTjpLvm+fw77hCuKWZKLnJTRxxOI2ZtzRd91Lno3SVchBJElyDUceb58HWFoFD2EaodFDUeR
	QkKEEiBD2KyXVxhizQ/onV4TC3hrgZS4grb4/aqu4xeuTYpqUUXE6sptjLC01MS9ub925X4EFnb
	sEy7YhFyUOGSXhLipP50MrYEQmP1K0YbhIwvGSYZFn6UAU8+j3f7C4iSDPs=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice
