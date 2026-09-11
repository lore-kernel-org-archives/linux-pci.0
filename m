Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8446AA7B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117715; cv=pass; b=fJIp/USmZiX4YcxpTqjX0R672a1shbz8opoPmjlPivcjRI0UUQxKVEeemyf4+puXqJB7KVNLmxbQNU8ekuAHJM0RNm0PNE5ybbf6cwBGEc5okyGBqLRikT8jTJwZ9bgb8/fgglZKzsqxbkC6ocmp9T+y/ACgC8sKTKAXHBKbUcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117715; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibKZDplQCe13cibloq9Vuz8KjIw4/54fgsFqnsXCphj6LgfRaAGvHBIWhSTcbiPbYUsHNoVIAqZUpg2Nz6oIGbSEqK1UfzRgbJ9KFtKiuJkcRF2S8eUGaOATQ1k912SMJp4oIaVWaV3v15zIuS0oV4mnYnRFL+CaYFXVtcSNFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843e397f74so406028f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=Hk5OMaEGa9rr7QMlzqpe2BzdLHzZvPXuw0RbMK+UKdFaxhqbBq53nXBF387rOqYf3v
         Zm3X6zJJoZaqYDN17MXLuCvpbKQrB9O8/BgEDjnCa98M4RhpFGfq+itzzaAt3zPc2+1J
         pD84zMnUtP6Nwr6ZrFknrMw4+7vn0w1KEvZ+Hosoez9PYA4tWANuARAkUOvGthwsRNyM
         S/jurbjaeFqZgxEJZe2bk+qSAZ85PZbM+gq5ERPtAhe0n1imiHaOKWrlr/OAiwKskVEy
         tlkfbo2DyvjnEH3WY+EsqMv43rJEHlwiaOKIcLki9GXKhg8V0tbJtnNZsD/1GQcbc4ov
         Nsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=YorTMqWiFP3ga9hzdkl4Hzhn/oDXVAkZdEbqDnFrkT8=;
        b=bwYQfqtoW2wUKGnlDhun9Oy6vN7rWq4tTTz3dRfFLJIWD+iPskIUEJR4BPd4q2c6Qr
         usEtagT2CQt4Ax73XVDGX9vJ02KoASySb7z4bNp8AUl6BRlJ6QSigCArRF4nJQZI9kzN
         qF9MG78gPzfDH7ZZvrBk1/fjFvMh1MnkR4cv5elQafjkvjhPgjWakNCPfBwByc0ZUjxL
         PiKdvFHBIsSehytoCUcD5i9JHE8nkFC0WHZeIkORu/C/7Nlo8bSc9oF+VuAHkJRLytmk
         /F2uRFi6v3bNnu1uFSaUXnt0Frt9svHcY8Kt5BtanMZbpOmpdyuOsI3GPxcyMgk8qCjY
         JJGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=HdiAbVs4dzQKJnAzXyh384aWoJJybK+B2vrZ786CGiOeJOxcOjgJJ1chO02PscPlmY
         5vGZOy7SYoULKuGVLyiy4k42eNMIEnqSSGlVXUL1PBwSgJuOr97ob4tahRmr/5yUm5lR
         gwsqN2Y6gLWQxIvgl1eBYBmxLtLi8fhmrpdOi094f8fdG8cQaC5bcWSKXneM+0/KfDQs
         C17cZm0Qtc9RBi8Dw7M1yRBEB2YGivdUcMXpL5FjARIf7xZj8ve7STUSc2LOh9wVtDX8
         wUFQgRiXxUfoUqqyuS2LqInrhc50uVP21bPrYzj0r8uQv3m4cx6oFvwkNC9vUkXwxo4E
         Qp9A==
X-Forwarded-Encrypted: i=1; AKwUvBy3HibxgBChuzlf+xo51O2U5ZKyUVDUSUcGi8KyU4NjGrsx8bwpVpPbC7CmIzYO8vBROojlA3x6jjI=@vger.kernel.org
X-Gm-Message-State: AFuF++n5U3HcMxd80ya6TkNd69+3Cv4PeK/r3kbKhJl7kO420MC2qjJW
	Ky/n+blElGe4AUi0iImWHFNXWN115ugiryCe/83sN6RrcC6ovtJMok5TNpRvn2/KVSJpD86BfML
	k/tmp3friOWi1OYgTrKKids+OEhxgoN6TiE1zkXoK
X-Gm-Gg: AYBFou3JVobBiQTpMzRVMft1siZPykKk4AcaAFup4yAkoyIsK0xZUrMiZOSO61yC4Jy
	Ov4JdJCX1lPQ6dfUTxjIpMomgexOybjr9g700BgAdL/x51MU5MTh/hcJ73/UzxL4OG/JOntSYb/
	ZoIDvDZyRolWfZv0eLsnNIU9yVICQ/wekrAYNuK5bEU+5sS70nmMZlfzPtItdOly94VonT5M+ed
	4WK1S1/RnkL39uxpVj7R3r2sFuPR273YEzAI8OFCoB1O7NWAvIvTUfwwYA3kg/fOoEUA5CCVHA2
	Sq3yR98Pi/caoEbPI3+eGOzCUdB9BmwNeziAqA1D+OmMDFkoODYriS1+DjjFggkv01zE+QFORQU
	HtpwLoVlE0LfdIDUnf40CQE9FIluvQH+k+sIsbqUJ9AYbKfE4c+/u55HbyCZB/mHu
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
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
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
