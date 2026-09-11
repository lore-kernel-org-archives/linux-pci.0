Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC43B774B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134214; cv=pass; b=M5bq7W9GTZH1UoT9YVQm7qgXGskXNn3/USrLlBTPGpHXnynaqIfxhGWBblpk13/IstBFi0FkG8jFQ4q41qeh7kl11V8D+/pVTFCIck7TPoV+3qKLZaImrhk7i0zMPDWK1mVx3WKgCuqBYFYghc/lWAnSHvf9uFpuynZ5pVjkkKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134214; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZW3DOCSdjDVJz8MuigrtSPJaB5NWbV14nk2vjsXLwMzYRP8kc2AYHkR0HhzTBiCmfIW4eL8nytE2sYb5R4p1y7D7lCrlig2lWSsdkMNMlmKAKrWe16gXlIaqpO3e2bbb9rIUKCzaMRDmJ7gF2JKjH01JtPxiFgGxI12bmFe6f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b965570d7so11607475e9.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=XJLoXznOvQfbx1NC28eomwpXNSHXeT8Gy1hedmC2W8bGqk4ou+q9gBLsrgPkwkHzxe
         XjWFtLsrfFL3gR55naiZGanH7Ps9oaXggftu2LaUkFPxIsfjaTHK2J0a2GzgmzY5QTvv
         yEY+Htp6JBbKXRUa4Pub7ONKm3gkRlUJn1zgOAfWFgq4+H3uAIb2K6z07urVHonchmbg
         aXzcC75p1nHx161uG9NxwEomtEny5tCe44gVMvTFALlD6G0jn0IDN2FMdUFZ2fp5Q9pS
         3j04SP+mivAEVtGdDs9sbV/WQjzUEY9kHS62WCRccIpUsuPPCe2VcYHSJuMfpaFoKpC1
         9LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=rPj/F2v06B4jlmKfFThDlKpUqYtCvw+YBDjTDcnh3VM=;
        b=ia/2J6Dp4t4r9SCUHc68qSAZblxhAtDKltu1hs7/uOr08KbT6oPhiyVKQJXnWs/XTR
         ae+8MoomTG204Mx31TLw9CL9tV7XbAbN8g5w0SjGGts38iKP9D0+6qhqtBA2stIf7DZW
         jLy+rgenmS6TBHU0YZmCX+z4ODqpy/8oTLpHTv+eFOOafQUIF6klIIkP8BDno4laXhGp
         V3COyURnoTckM7EaTICYO19uNLWKqsAQhirm8h1J/AelDW726/Fg/WMYxjVi/WarSJVT
         VmLG/V5kHRGMhWxcjUTurSBD7f5DAHTUzX1DAobOyZPItIILiyWWsSimaLTJpeUNaEXE
         3H3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=EQc4N72pGz+VbGHtPYPHNXa7Tc2BmTqep4RgSfxwVWe9n7Vh1fz9AqjWcYDuOhx/s4
         mVMgOgg2D2ofT5Kdebwq6bz6WEOMvT26vReR5ti0FhoV3GntQVRxbepWMDClP0+t+SvY
         eiRgB74CcXv+fP5pFTNggfEmjz9wcF/jFLmBSXE0lMAG5lE0uGloFGaHGUKtF+aobFkg
         5wZxfWy1HPwZxVrbVORx3qWGxlfrNZ0m1w+OStbzMuICnIUL00ATclf5Lop8Q/FjY9Dd
         Ozg0WwOf/W9GykZV7bLLR+DpksrOBwbS7cjY04Xx9+P1kP4hF/dQrBfe1F7uCt6bK0ik
         NEVw==
X-Forwarded-Encrypted: i=1; AKwUvBz+OshpFc6kNtaE7Ym7KLS9yCWkg9M1pfssGIGP8hS/lakYXWTkc2PH74t121mlWDC7tcIW5M9g+8I=@vger.kernel.org
X-Gm-Message-State: AFuF++msc7XUi34hC7+TtuMjhiGg1LtAcWGbOIGnvIeTFLI63buizhzu
	Of2eBzxQGQ25xkEdKJiwYKi3CqPqS8q/fD+BelEHxFtQ5PBkBPtm9+gzsNaz3rz3zsIO46sHvqy
	pi2b64/GdjF4NkMhIzm1IlmsM+ULoBN/Ugxe3C1p3
X-Gm-Gg: AYBFou0//Y2YU66yQaLhe5d4R5TUptIWs0wPDlUDa1/bUySF9z2jQGLZRYnB2LlUNyO
	fKz6ldBfC1Z0IAk7EKpLJZPo78LluWwy+6xJu6l+jIaN/4xNzhfZfELLy/czDWaC77ZC+0Ytm1+
	4BEPq6KP8U3MMYPOzB+bvklvQJiDD4yLXCywTGLIYWuLXG6M0OMceQdtnjq2Q9fku2GkEoOC14E
	g6KkW3SPxgvsD9ZeJoNdHEIE5LOj9fWIttFLMovkBcatnpFcmwqdGqwKVckaPw/RiM8bBajYj+8
	zj+ukMB/MSPYlnVA9wj4/Aqcj56QVU8YBu2fwAnbiBYanWFdwpvNpHWdJSGGjvesSxi5QxR45f7
	YXFP+6Cv71jexhj8mE0hwx0pqD/Wbi5hQFQe7AvdnM7UYNdN+vDvV
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
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
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
