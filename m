Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FC2F8EA6
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479405; cv=pass; b=iSZoFY15i7qpnOj8F1bW5zKoGCjutE6/29PKTpN2YwbUM6KBBzoNkIzCaEaO14olSpiy5QfGg8jW1EO7VN68RMaUPQIlLYeB1khElFfyQIqK1zZibcv9ky0eFfzdNKSw8nw5w6R/NCAfapm0MwAL5csBVsqAmSfWytztOqscRLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479405; c=relaxed/simple;
	bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL8kNlFe/7kANx7N4BNJfUU+si4YsR6d+spJGz+nTaAW6NL6Dl7GJDZi8+vtPjm+OXN5ZM3Z0oDNU9U3u/dBtiOQVzfogSmEAm5K9HYfTsrLy4J3ncyAlnmR1oM0Bt3hRSz3HESk1y1RUTUJhJoMHcAOZ0JRkWMbQsfH2q5WF6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWCaNt6d; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCaNt6d"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf49dc28ccso869375ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479403; cv=none;
        d=google.com; s=arc-20260327;
        b=iPkRMON5equykV3t29K9pd7OF2kDHySxqPotOljMrbMboKYI1u+OG8YVOFQ0Y1LBOF
         EjxhSBfJ3yOcJDcUBCFv9kUb+uAbgk4gs2Oyg5Ju0jWuQ3RoyDCl8Oqt7I/AMwMv0qWo
         hZEq9RVCbwPL4yhcg2YaPeiAXoXcglXluel0KJiqQjUdbPEykAk0XTgBvjq6G9dPZSA/
         MLW4nyitDp3htwJ0CYgyO6pt/ZFbWbbgsutpqITyXHMyvcp/ZvXTN+vOEZ05NgyPI/Ko
         qrCYCkHqMBHBSac2olrbDnrnVfA7kA95EkbuKixCa/UvbHUwHDJEfmh3Dh4DZ+l7oVvK
         6WSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        fh=+BsNijRG4/IiTqC4qycg0z6f4PHzYbJisur5YKGjNjI=;
        b=RS6bD1zlBqXa22PK+bLXhjPWouPSYtKNSxiD9uWUNxgduZX+8sszzl8DBNJ9N46Vwp
         CMLJR73NCMB43WG5emAHz6xhfA17gXpLA/aVDtQnx7+d9boQB3dFdrZH6F+kLB3KLzPF
         Zu6XqqY3eHJ0Obwd6M3/CcivarBsrm7fDW8hZ6WPWwvXtwmL08P+vl0cwiCk+koj67Na
         ZkXUNUo9ujKI7WlI6iai900husj8uOGcFGZGZ7ovxnPmZE9QWQyb3LWkKISb/m93kyeQ
         R+2PRb+KRLFJmAZ8pJaVfcqbedXClyFXxmv29RGkK341zobAgfIxoKZHYYtOYFLSdFTp
         lSZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479403; x=1786084203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=NWCaNt6dNgAGARtRG0i87Zg/4MX5m8mmYfHmRZodmPVVojtjaNus2ym6gJYtL1Pd/L
         AOv8wQRegNwG+GTWDMU06KuMRMWo9BXgtNKT0WdD02cXI6YUfx3v6sR0VOs9hagIJ4w4
         vnKyIIdeB+5YOvum8D393ArHcLC4LBT79fBcIgbLi5vihAt4TNMsu4hXeFugfhN4ySHC
         W5nQEtPsoLJ884H3F4mK4Qtrrd1jUgKr9KCr4ehF1xIV8/txfgWipTUtPYDapxLJ/34I
         F6/4LcrSYzE7iSczVrekyvtA/Ww6xZ6wYo3NFEDB9G7amXtbcR2IB4gYc02nSfWbY2eZ
         DKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479403; x=1786084203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plYqvJikpm2phA6sJTWH2hDra12ZFHqZ7KqSsbbbx3E=;
        b=ObTsAblnISIXnrucCOT/CJC2TMQOFTuAV85DcNMk9NTqP9A5enCyXhhlyxUbLnHHlz
         KJMcWZPPrnDmHZNY0zN2LjhOFMQfiALO8HszE+b7UjzN70+b8u6mRX+t+gxMSbOiDR9u
         cm7SFQas6dRiozaEcMEJJPewamYRZiViPsMKhxkuuwQRYb9GhBYORgVF1McXW6q8NiOa
         0DHRkGj3/Fv2Rk3R7g2RHuh2XVdODfw5807zSccfhuNLu/SCbHN8ucA3THx44Rql8bQL
         JqR6R0eJMbZB/tam00ZFrkWbJ+KiO0oz/dZ+F0xMlucPMclWAglUWF+OzRtsKjHJGYKh
         /Tnw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4DxgifGOycPwLW/3zqsXdow1v0GcY2ify46KOswywQa8zQ5sDiWlufZ4P3t4PG3qvz2huSpfZmlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuiupJzBLg8BfRP9P+rnR7GO9AG+8mZqWSpBaZdONVKW5U0Ob
	hUGNMhywPbGJtEEETns4+UQKekVFhd8L9S5YzmpiomLZlyEfT9c2LpkWy62xhHZzZLHaDtjn602
	0kgUOCmQOw3l+OONrS5sqIjE7J0USi7U=
X-Gm-Gg: AR+sD11Toc8Ea4uSU8oQ3YW+2L0GuMrgw1zwckMMK2d4qenhtlTNBixAQx1PQZTHkgv
	P7douEshxbqrEYo9gBdJMUMtzW/z9pad2OWnOf/jcHcg2u2Y3wuGYt66YBh+DSXb4+CNvm6RDdQ
	vcouobNXavLf6AK23hzpit+Y35u9E+J99EieP6i+vrdIILA/6VrZ1IJvDJZNygdJ8TYFkfMheek
	+sJdhAAfCqYO0eI3QGfnzoKCUw/g1a9KZCjbNMJtZMcSaw581p0qM9O1rKshgH/DBoSxcIuhlxI
	r9RbmSDYJqpQIB/r4GHoNrauEJSjuQZYC8Mvw31QqiT235+4rpOTV5ZXzn9E8xlcd91gF/LzWdy
	aqtxJNTIkaYESnQcLAO3IRM7P1Uh0MtaSULapI0uptVQdKa9y3H0vicDirxEv
X-Received: by 2002:a17:902:ceca:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d046ef0048mr13066585ad.4.1785479403240; Thu, 30 Jul 2026
 23:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev> <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
In-Reply-To: <a9dde63a-5f2d-494b-95dd-7567879de38d@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:29:50 +0200
X-Gm-Features: AUfX_mxTwoRg7YuTGPUdUHKCs3gSMN4l-jXSn1vTLDoexparxESqmVPaSYuvKs8
Message-ID: <CANiq72kkuKsRAF-r+2OyZbjjgvC+jvqMSXR=LgmqTNRaWQZ-nw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:39=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Back in v3, Gary suggested this series go via the rust tree.
> Would you be happy with that, or would you prefer a different
> path? If so, is there anything else needed from my side?

That is fine with me, but let's see what the modules maintainers think...

Luis, Petr, Daniel, Sami: what would you like to do? This touches your
entry, so it would be nice to know what your thoughts are /
Acked-by's.

Thanks!

Cheers,
Miguel
