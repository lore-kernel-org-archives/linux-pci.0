Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCB40DB39
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571398; cv=pass; b=THd7tNAfNpLpl64gOj/9jYnQyJ32gACH7n5xzVb5wKxByTFiO5iKDS05WLJ6gO7RVXpElU4lP5KTEl/U8vRcoTYrIRakZWqAl5ZHEUOA5if1VSevNWD1jBfGzSWpbpYc96J1n4epRsZCZV2WbeyMIel1Lvp9+oLwSqA9GC98Qw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571398; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T01Wj1Fd+gSGubz3WlKxMMwx41I7+tI/fQAPzhpD6zIq7HTaU33lJHAp3jSvtH0rDeHonFAsbZsOZvv/t41BJrBwCmcw0EFfaIO231CqIY9ob291sZ5c5jHidbWMi0tcqOG6NhKF5wIZBG5iaxl4MDYQTV17cf4UDgL1gWF0U7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cffd93cdedso2806825ad.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=PNHSSXKqDy7G7vRhG0V4eIr6wOfpDKszWqJk6WLV7OPCdLHlDDgaAinDCujCIIN8pS
         V6FfpPN8WaXRtf0qSYsNcvJzA5S7o8/nLAKfwuTGJBw3CGJhp7oMge30XnDQiYYEUga8
         R+YVrxh9WSGsDDBsL/S9EyOFDw8bugrnqd+yTzr6z3Rcq8aJHPl63tB7ggpAr/1ihI52
         +h6zzZM6VOaj5v1L7lfwSxBOI2ityxuv83Niu/RoLrVGYuTmRSxT0FQywMLL4LkWcS2k
         iEcWkvRu4Ig4MU1uFgdCHPqyZ9FCDq1E2GwPT6AsPQg0G44c9nSV/M1b1z+lG1vcmLWs
         vOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=rZWN8obgG3dpCQbAggwk7VWPCxVo5vNChq9qfETG+0M=;
        b=UZaqIMV1x1CyfX132NtOwCgRez0Png4FhI1dhygO8ZNSR+ZaaXuHxNTuDuirr5NJY2
         o1ZTS0SB4GT1irDmhbpwrGHV9NIfkRU4z0FeTl1T44CcyDz5jXlruQQQTlCFg29VJ916
         S6U6Zo5l78rxx43NomXTChDqQgendPZz1ZX7AaqGWNbi/wymDMvJonvFTEbR261Y5QKv
         yPDVs7Go0+9Rt7NfAgQsNvZI7YCp+wlmuwaZfzbRZ71z4iJPJaO38Ttn8dGbKAyShMmj
         l2kgTBhrDp/kR6pR58nBhjDzjR6JXQ2YjPNvESd4Gze3WEFFv42nsYDMUujhiSXfmyfW
         gpAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=nbgGm0Ew2NDrI9lvuG0+JOMuYGTa1z4Gr5eA3xWdre90Wtl+Jc26WOMfTg8cs3pf0X
         hHxmBErA97TbIOVTK+PP05gMcc3ajD0P+ZJqhL2jo0PDMkRV0Zn/pOHQKmE1UfsyrM0G
         Cy8dY7aIhL+4XjlQKVDGHStry7WKN3PiYfp2k8UeZ0n6MScbxaAyEk2Uh2ZJi9Rz0SJY
         BhreJvpw2iu7r6qUPXzujaV6QlUBvLV6pCY3qB5JOFKDGLKcbMbqDY2ilcPNnx8WUPwX
         n8DI4UEQTKTqbl57f1DcwmCEvufsceT+qQZWQomwFpElRD6ISQa87Wj3fIXEI1jOdwh4
         vKwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0rbMpbJlWaCOALrGVAicgTCxQ7Kmu90u7SnSZjOvrzTZkttxGkUzVNwDdP6QOgNL2j3pEUqtKne4=@vger.kernel.org
X-Gm-Message-State: AFuF++k4uEQmA8UN0lc8y6m3LrOT1qog4jWUELelbU+K7VX+EkcXb+83
	wuyJs89HYWyG9fxsM/0zIrDhS8NUrdOZZ12tUcUgoDTpJ59SMqDDjjD0urrCky0u9JyxqhLO7uu
	5dhHjUfQJZy/zb2KbmQuzDgautovWE+s=
X-Gm-Gg: AR+sD10oIlUKc04pdAAYKXq6jrTqA79wzgfkQcscQx5fXDHHgPt6g83w3VfirpW+Xfq
	Kp0vrMzQBz50S/cRGPJA0OxXiET8KP+LG/SXsAH0qbVueoMnUFifEJbrfcJpw1SXUKuVExuXaoY
	ZgaYXf1lpYUKGYqFbDYUl597buIUHxEhMkyDAi4ktRVJsZRv1xf3Bu4LCkR8CFER/zGYDpUDmbN
	AQXss4sEhASYwVh7ZkIA5JTuulqvdfJ6q+fyH5QfVuBselrctzdzptZOQRm3Qfv4PxxtmoY74nx
	qVt/mdjoQ/VPVLqJucZH9tYL8t1moi5J7JWZ5ZQunG0rN7Fl+iMmiuOdAhFqdkYXdDXC2OORMkE
	92PLHG+wEfVlvAKnD2A0GGgWgyoxgWltKvfbBXjfusBJQAnDxCh5yUscK9D/HimXuxnSi6LQ=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
