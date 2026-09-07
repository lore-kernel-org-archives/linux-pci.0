Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1123F1071
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773079; cv=pass; b=WDlaur1vUIBL3jwW8e6kuuXp8gsKURC4zoxfdV1bYdtZX/YN4Gs9+fAtwa85Zf8u5mBnov3g+x85OemdCmWkXj4LamVwnbaXlcf8w0AM36Q+GQ2/AF5o7gABcdYkENlnGbQTKqtUOOSJDzjVv4pLKUzAXUEOQkd5I20iV6dpbuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773079; c=relaxed/simple;
	bh=cSfmMGgIFwjjaaI7Bk9duU/SsMv1zgWa3X4ow3p9Z0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU8RfTaGEiKFuH21zYwqVvFj/HXO54ClMLJLv5GGRVlxFYl3sxbXySK3EMupr1xjP8leFVsLnvgBu51YfnHnqpmZLBVpse4S72pArGrth4Ug2mV4tXDBQJNj1eZcO1ter/sd0F6PTFfiZVrNPF+HxEJ4k/omXe+vVx0zpufHWh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYzWZS6h; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYzWZS6h"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436251906so3779623f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 02:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773075; cv=none;
        d=google.com; s=arc-20260327;
        b=Nmk9AZZ7LF+0YbkZj/k9Q+GV5jfuj1xb299hhCG3bKDsq3k9EEEYb/qKlPkeTkDfIT
         ZMgjc0TLALz0LGCwzeIrwLiNCrNt59AkZkVIV+Mad5b50dpNR8LLyFMuzYBLS/+L49gY
         fMTLfHYixzKWm7u3kUcVML62nqch8OXARdGOR63swwq6VM3Nldmx8PvM12YS6KjFAH9W
         AhXqumw68t6lZLghbwRiAYDDA8gsS97hr5bFRDRfIBrR9y7R36H9OsDNCAvHf+BImCIK
         hBjFf9lsPhu+htug6Acmr8R6u3NLc/fkshZ88SgkFxw5vxkYF3CWswu20EUYkUBn2b4I
         mORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        fh=RTEODscaZTvE3bLy2C4YsNtjhE/FEaitW2o4SwUjAV0=;
        b=RS2ybiThgRktHE15CPpRcg8ffrTbF2E6l+qEPdyRyxivM8Aojxh8JjJ93matPXO17+
         eQroitxSYZhfmrCBnlywXnqBbsERomevrB0kxCNQdKqnVgkNCcRF+AFdE14p66ueL2E6
         8DSOnEAKempJoJ8mjqTtK1olq8YXQv26WgIVjQ6rySCC17OfT5LQaZD5Pqh6s/Be2Kwi
         Pw4lqWVrNcLsdsEA8MGyklZASu44RpKAXm+f0WSzOtO1y0Pgd4IWMYjELxc5dKbr/y0G
         vYTzHPGwK+uFOmJrJIFZUxs0srpazICktdx9qYR2tkw5i+OSe98P8zjyjvTqs6Qxp0Ew
         rL2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788773075; x=1789377875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=bYzWZS6hvyblgTmL2WcmqKBFUHHD7UV1gkXyod2CvfAo9EbydIVeGF++9jABbnZPte
         ys7ocRIu1X8wdEIGp96wY0ZJwuX9iep0RRInWAVJmxBvFDn1O/SCyei+2Uu4DEx9EFWy
         Ju0SX+/3BqiQeyfykHFwlXZNMjTYSHT9Hz+p1tge65xlQefntxQdIOB//wajbELDPR6l
         bZSz7BV5hpdU91s0tZALuvzT0BaGoZvdwZ+37h8mSbXVV8RthaPq9o6xvdh7qixRCia5
         5aTu+haqTXNlK7d6WQD6MLUT44ym0DOgw7EgnQhTgLv5A9qh2xRN6Nek2Upj1f/kRQ35
         VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773075; x=1789377875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=AKpMztzly6xlCdNODQOJCAYRvlzWQ1yx+lP3cLJ9qVimXxxGQ+Plylk/GyhDb/EOln
         fX3fZDHV41Zz+baxl7MLdTUZRuAivqHvAFwdw4v/B1Vxfh9DWdRTfGBpPcgl1UL2yh1h
         5xS3xzqow4B1lp4zFI7oWFSwNhCeMy5KpdcVN1+iS9yRvSSEGX1ljny8T12DFnqE1ij/
         U0okFjE9wpgSfsl0baKqCulbsWHYP/xpjy6vNx+pFtPecE8V/uAKz3CAVbXHkKbzDtje
         K0UCknO+fTjdunwchyxXNuMFPntsbeCSG1XaQyHYc8ov+hJ/gXO5GHR1OZ8e8rlRjpsJ
         E8Hw==
X-Forwarded-Encrypted: i=1; AKwUvBx7D3++quf45nVJMvwLiw15jymZHgMFW+QQm5T5frL5PjvVx3J2RwE6c67TtnfI7hexKvQPdQ1A66M=@vger.kernel.org
X-Gm-Message-State: AFuF++ly00TjPk/8ybbqru2uN0jnD8hL3gEZJpKt6c7iPJQuT/ojXWu9
	PPO/+qDp0b0anmnP2MRQv1swmQx1pbqaW1D2h5H8oeTY65B4yQZ6vRTurB8U+TngyVjf5YiZfUg
	XaR42rQDjnLIdx2gNQSrHwG2wU4iAKdyFu8p/2DC9
X-Gm-Gg: AYBFou1ATRREfTFFgcDaUxKhayKPWAajdBehKXVH/u3PcqQJFpTtWcfA1Bcxzv4V2iS
	o/DH/W0VpI97kDbTssuVwExKAJHctRWpBsJliTIYS4tLQ67cQADKNv7uDVo43QYwTP3EqojkmFc
	fZa1RmWxRYGPeTuyzormAh4BcTPdLGnSszRbxRLj0i3lnBdS2JBgEnMEvSkeYR0BFcrveyr/QH9
	7xjjX1o65JnGoO7RJvsPOP7BcgtKP5RoxaTN+sGLvcQQGBZjdYoJvps4kttQbGVAcIPubFpwvv+
	PMRap1uWpgMAZaMjhdKmwB0IjmGdJP2Lf2NknsF2KCN5sNGAm6UgTSvyq4PyrTzmGCV8qyLypHV
	Vlrb7ipQEedcQHV9Hz2vNCtL1kikdZ4s=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr37026021f8f.5.1788773074197; Mon, 07 Sep 2026
 02:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org> <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
In-Reply-To: <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 11:24:21 +0200
X-Gm-Features: AcwNN1V4plkowyMHAsnIxTQwxzR-aYAz331pg1N8okzwNx7uKX70uWh-YG4Yx6I
Message-ID: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> +        // SAFETY: We just successfully allocated a page, so we now h=
ave ownership of the newly
> >> +        // allocated page. We transfer that ownership to the new `Own=
ed<Page>` object.
> >> +        // Since `Page` is transparent, we can cast the pointer direc=
tly.
> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >
> > This doesn't satisfy the safety requirements of Owned::from_raw()
> > because the page may be used with vm_insert_page(), which increments it=
s
> > refcount and causes it to be shared the vma system, and this occurs
> > before Page::release() is called.
>
> I suppose the existing vm_insert_page() abstraction we have is already
> problematic, because it uses `&Page`?
>
> Maybe we want to change the API to use `ARef<Page>` so it already has to =
be
> shared? Conceptually it takes a reference count from a `&Page`, which isn=
't
> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<P=
age>`
> to be able to do that op.

Honestly, the problem is the safety requirements of Owned::from_raw().
Pages have a "special" main reference, and free_page() does more than
put_page(). It even does something when the refcount does not hit
zero.

The correct behavior for Page is to allow the user to hold one
Owned<Page> whose drop calls free_page(), *plus* any number of
ARef<Page> references that invoke put_page() on drop. This way, the
owned page controls the special drop codepath.

Alice
