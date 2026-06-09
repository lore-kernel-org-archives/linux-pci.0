Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1232AAA7
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014276; cv=pass; b=dDz8ixxLnGyyzGgxwyLhg1wrgmvr37V01yJwfGrLQ3nIhu2vxssck4wDQ5pjsaWTcXQYklOF9CAo/ALdVhgRLv63fnyY9lImIFZcv33VOuEHNf/W8ceCuNM9W8QVDSOngWSreJ6GDw1UohF06JAWq7tSrJA6gEIaUS3dcCC2YuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014276; c=relaxed/simple;
	bh=O7/vXOHmBuDEN6iYoEcXZX9SQVUOxuFM9K3LUsWI6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIcn2G9x/RP+cJTydHerC33qcXMZPz583ccjkspcxoe7wOAtyN3kFg1/Mw2yRM/CKZHMVMz1hlPZIlI67E7Z5hc+yOsAgNGPNedA+gXc4rDtvk0ZXhpbGgkLLgHAliRiHzB0eZZEbyUYuTiG2gcX1gZTVixq5qUf4YtOFahV4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO6mb/Mj; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO6mb/Mj"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304f8e80b7eso400010eec.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
        d=google.com; s=arc-20240605;
        b=NhHXVgSdELp6GeJ/gC5r1IJxmZDRZ7tN/teYaCdCPhdbewirs+ky8kDJJzcPUmAid+
         weCqrgHajsrml8KYOrrH2LHbyTHdWK6k3S+9geXqImmaAlOuvVQWQGOaqPq/07ObtwxC
         C7/vcyOswAV+UuGozbbWED1/Z6RrH4PN6yaov5kELwM+nRDEkMsKPw+fVyS70U+/sgD2
         /hVQeYwPokBoM4mPAn3f6EuKcOXFX1FFG0Pq1KzloqKedaIss2xFnvWXHkP/vHlD7Rqi
         M9z+Ub4RDhHYMmQXAAlCjhej3bCpUqKXqsmZK/diL+yQYQzuL/RAIrU/94eFhYld5lu5
         fB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        fh=kLWxIFqvEIE1uRZtkR8q9lwRf50j+MHeIj9OgKzWbqI=;
        b=G+XZl9EinpC36Et4FLD5Kg4po4R8t6J8rjHkBIoFbza3yaIw7t7fCjn7xPFtGsee9C
         3lF4rbWWTDtQSU2HV44ybWDKslWfjQewZ6JUdAKLnqMg8GmQMMhHcCnKibTybbwIYWqE
         L/sf5+tuMfERJgis8leduRkQ8Rt2bXy9b+1ZnMeyPzY1Gen9vgpfkMCV+RMVKyihdr8K
         X+k4d45z/cSfxkyJV67Rnm3zG5RIpwjmQii0oCaPlRGW4lK/uhRxiuiKym4LDheFgF6E
         cHXElz7CHk2evxeuOhdIi2wTKgiEIDzHqs9VZUFl7T7IgYmjEy6HxdljyfpW7odSM3qy
         amsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=pO6mb/MjV7+9Lyoy7qKEe8jyrmAVmp1sVk9ZAQekGJY/qcYqRSPwEAedKazW1YDjAo
         daWkJzVnMyQBtO7fmggjHQ1cPEQGXHlt3VIr6I1Kj1CO/2HtnymY1aGpvzlRB8OH+ilA
         890WtpQyksZUJj37x9K37O3XCrrKWsg/O8Y8q+MGEolHuY3O9nF+Mz46OcSl6XEeAyYn
         PpKFuaWCdq+j/LCZ8xHOrMCCjyi8dyUYIO1ZCC3Qs9hwAGz+a0asgrLpY7oQ6QrXmnr+
         SzEi2Ndcvrsr6lg0pp6Uccf0k7gE8QI2hRsXCNfmZx5mer8km0ZAI5cl8BunKE5GWZwg
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014274; x=1781619074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=SGI6AATAfhpVafRhziVA7o+HLCBRgKdxL+6T3NnEBfjzWdLxesfFUyD1Nbn/EGrSBi
         8WpLXzrqE8a1pte70b2rayswOKUkmaZT7PPgDDQ7l9T4bE7FH2VtN78EThZPadW2V4hX
         E4ZGDFdeaFW/+ANsT7PBRzI8u+yhzznGkR+LEEX58ci+Vcj3xwRams0AQH+cfPYDvm9Q
         hcyvA4/wlgAwcbr3Klmvg+5QKG6knZRVlhgbsCxUICh+nmDEyGMLtqC4iYiUbkfM7iyS
         H/8Vc00E0lY5JXJ5L7FUl5JktDXpT2qq/WABmVRTAdfa+81pdjTDMRYAZMuFlHWFBTG9
         pE2w==
X-Forwarded-Encrypted: i=1; AFNElJ+T7/r9GgdjXIRxaVH27wTSQg9MwtVf8Z4Qz7aft+Owh5Rclvc7iVBs9Fr+lwiR7E9o0TyxyFJxPvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXRgXOraBBWfd66/i9ZMKqzznDJixRGvmapCZX71VCWjuKKOF
	f9pMtvnhcKYr0Ealrd2Z3WjFnSyqh30LX3JX16lx0AwJIWfP33iInvN7Ejga7X/tacEg1VY1J6r
	RhcolpTUrEjyVEuUMUhFkWWb/NZiNWmM=
X-Gm-Gg: Acq92OGBWF3Akz4J4U6hMNagZwBmI8BBYTVCB9W/aWCQwT9d6QDWoa412DaL/gQgl9i
	zXHa6NDas3trgV1c3BtZV+O2TmlVqcczvQ84MNHcYqwE96zwfSKf7qS3JuAbzhXOquIxKmm06nu
	9zt4K30/4af0qbSiChgnmJsOyOxiA7bez65ApS7Vqgd8kn9rgAw5u4RnvBpCXOk41PX/Azj2I1U
	Uwyp2JOEvPCuMhd9XymOcR33F6NAcmg7YprbBfKfSPtT/zCPs3Hym3MXwb1wYUcjlxCG9KtBj5o
	Qd+THQU0nOdwPkNzgsmUTdW3nkgsoWOQBN3wqQzaiLgdttFK132uCBMYWueHpbSLYcXWDWWasYF
	FGIgBtaaMZmLOPe4A1EG0pglSfD0uWIL6kw==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
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
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
