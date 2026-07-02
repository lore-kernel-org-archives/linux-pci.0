Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767F1991D4
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000808; cv=pass; b=DjqdKqqgNsNsgGPj2gHzkfhs32T1MoXtb+hekB4eNFW97oR3tS4XwEjNQTC5kLuTCCxykXNIKsc1nrc2I38pUL3bHzdldJtL2qc8ZXfoMYhtQe9/JV26LXAUAHFEH63N9+6okh2o9cXfEjARrNCbUkPsLR4VD8UZ6hBhjnhz2Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000808; c=relaxed/simple;
	bh=utoARpDnvA3c3vaCWBg5H9ujL8C1Fui0A2kGFCJI2Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMybHpnCwFuBx3IR1EkDr2OQQocvMOBZdlC2tkBw8wRcjhYHO9KbybDPcJoHkqa8NUeLDLCsothF2EXolcLaITg1A74Bh0nXDyhUdCavsRpS0i0WqGUaZswIOWSchFIwdqsZypGQMl+2bCvuimIxdUVIepqpl1pfgmUrDQpsD8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAHLoTLw; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAHLoTLw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b7612475so15633075e9.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 07:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783000806; cv=none;
        d=google.com; s=arc-20260327;
        b=cyEwYldcRokQ4ho1jiV6okEE2jXA5AS+p8gehLEOmMxrzm8FRH5p46o5YBIsq+NlEn
         g0ZyehTbfSxIF8L9DqeySEJBHTe7KkgcBAWm41+wIim7lyYfhu1rFXUKTjudWAnrkXvc
         7cVVRCPsPmvvarsmXf5kaQ69rDFRdJI9x95Zn9825gP0hWvdtSN9YBHHLtOYry1kGikv
         R4z4Z8c8zBEZYAMo2+AlFv0Gmcdd6F/01wqIcERb1QsFrqnpYWdcXOPwbRluQ9PzIH+x
         +HNognG9IlM6TdJHZXaszoasVFofydnBiiTT/SaCMfGfTQ2a8C8EJrb2WcEWsjykj16L
         t2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
        fh=tTpt/5U4eG+AxW0ZIWWC5bd/HvqwzfMctfDmDBx7UgM=;
        b=k5rvIy9D/+/bPg9X3A+oSnSbNEDQ8yNPx7QDYFCemSUg5djpUh/lZk62/QbWJC96UR
         dGEDVQrrkfUE84EM4t1aPcWVR31S8c41ccS0xpraDRlTlZ/cFk1Yv3B2k7eQcqEWdzRu
         UD1sVyBJFbK3sVITknwtd1JQc33yPCccj5F5U1pKTrVc0TOf0VSJ66U0m6m7lj+L93Vt
         tE1nu6iIBiFH/tZWKMa4CEQ+NXofrZHODQAv4edMyeuAHcM7/K4mAJrt7n5T6bf71NYe
         oQkHyzPciDaIMQetawgx4SCtyWxxdPjLJBnztjDZV5aTpHz7FOiC5nDNnMUnI0wVJ5DP
         TRzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783000806; x=1783605606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
        b=VAHLoTLw1Fzhn0TrxD+uMogXY3CfAE9fVKRujwZ6BRLlJ7WxN/a5fh0fgnx6XgGlab
         dKjrqM3e7hqpnqIUi9rBtqvLvy0hRn3vXkSOGZSQz8mcsr5A/n7ux5uDUAgj1UkvAN7s
         uXfi4jnGR7zWBRo2YO7KzLsuRMoMWAqxem3k//zXA5ZWPHON0ZWa7fw21F2gOIbp8BlI
         D7QOg+G6Mk8HyQMdQpmQGaAUDiPdgiPho/bnAwC/ngBfO/F6OKqVP8AYOrV0nEAyN495
         WzpSwd7BEe8PHaXMNPo1z61EKY01ELqc50QQYXuJNidCfqGFqqDOPPJURBeuH5TbiHnq
         fEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783000806; x=1783605606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ad3f158zhv32TxrF7aQY3I8idlfk4/6P43hesQy1Oiw=;
        b=BoxdaJYfC0Ygwu+SKythPSHYiPaTA5lKyx3HAzosOYaymJ8TCrRr7EQE2wzhpvX8AB
         ArNjRXSZCv45b0WquTZ/yNP53GmP4rk2SIOl6RrtOIz/0I8kn3sB4dV8DqODrNiwS+IF
         KkZnp3d0B3QKF0QqUCOJvSPl7mo/XGLSoaz80e+KIuJgH/Bgg7q2yAXZf24QR6Raq+fv
         gS0sh3Evrnv/OhNm3c9FweWMFhsPWLOEgIEb0lLqSTxHFJCAe/AObyUUqs9yxWUKtfGk
         iDaMrFfNZIvHRzfgBKfiyqJ+d/4ap85vIHh1wOdICrudm1qRsI/w0Qu7h6yXN/vM23jx
         tgVg==
X-Forwarded-Encrypted: i=1; AFNElJ83Lff1WpJvN91LMOnwDE9Vjksavs+FEJN+wXzBBBIYK69xunWETh8Eguo8CpP2JggJPq/x9hym32s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKgqaq/c94+5r8RWcNMKszSH3anqcYIsAS+TUda1UsyLxEXIY
	2MSXcaYqUm4LPsU/0Pl6X7mwgklRHEzYbByWBDXX1lSYcA29iZbWhB0JE9QXYpiIJBA0YaiVjBs
	X8ILkahOw+ZIkSyAgZigoCm0UZO9b2CfcIi3lxjrc
X-Gm-Gg: AfdE7cltdvstM0wxIV3HyGWwSUE9e7q/NwIDawgVn/bMR+uHSMu6Y5Jxccz2NAWR99a
	bQN9uW0WqhSaOuPKho0hjDVkfDqaJy+TR+EiuhJ6Vhiaq/et1AYXs+LkwYW2+hncMyR2GAF0qEe
	XdQ0oKROu0Qcbl7NxX3IvyXclbsD5zsYa0GOUPzAHOBAUh9ioo5Ao64VJYsoIdksdjm06VMEwtH
	16GzHhzkP5wHXF8HyVN162rPJqzkttwcSsU26HOxhu+8Kw0clZBgNun8d9XHt5wwriSjpSgTCrX
	ooCO9xHX6Bg5/wQr3WXqSeQn+qs=
X-Received: by 2002:a05:600c:5296:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-493c2b99781mr85583495e9.28.1783000804786; Thu, 02 Jul 2026
 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-idtable-rename-asptr-v1-1-e0927273c71a@google.com> <DJO4SC0M6BCM.B7RP36WUWCM9@garyguo.net>
In-Reply-To: <DJO4SC0M6BCM.B7RP36WUWCM9@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 2 Jul 2026 15:59:50 +0200
X-Gm-Features: AVVi8CexQdyFEd0R-YBeb950WefW10NhAupPBjQ8CXL2XbC1XoogGwE5GSAY5zY
Message-ID: <CAH5fLgjz_FTzv7rFsxcvt2N-3ehPxa2kHJqUHKDBv56OZw5UVA@mail.gmail.com>
Subject: Re: [PATCH] rust: device_id: rename IdTable::as_ptr to as_raw_id_table()
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Igor Korotin <igor.korotin@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 3:48=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu Jul 2, 2026 at 1:30 PM BST, Alice Ryhl wrote:
> > The current name of `as_ptr` is very generic, and if you attempt to
> > invoke `foo.as_ptr()` on a type for which this method is missing, then
> > an error along these lines will be printed:
> >
> >       error[E0599]: no method named `as_ptr` found for reference `&DmaB=
uf` in the current scope
> >          --> linux/rust/kernel/dma_buf/buf.rs:54:38
> >           |
> >        54 |         ptr::eq(self.as_ptr(), other.as_ptr())
> >           |                                      ^^^^^^ method not foun=
d in `&DmaBuf`
> >           |
> >           =3D help: items from traits can only be used if the trait is =
implemented and in scope
> >       note: `device_id::IdTable` defines an item `as_ptr`, perhaps you =
need to implement it
> >          --> linux/rust/kernel/device_id.rs:165:1
> >           |
> >       165 | pub trait IdTable<T: RawDeviceId, U> {
> >           | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Suggesting the IdTable trait when an as_ptr() method is missing is not
> > useful. Renaming it to `as_raw_id_table` makes the method name unique t=
o
> > this trait and avoids these bad suggestions.
>
> I think the name is fine. Functions of this sort is named `as_ptr()` and =
I don't
> see why it should differ just because it's on traits.
>
> I'd rather say this is a Rust deficiency. Perhaps there needs to be a
> improvement of `#[diagnostic::do_not_recommend]` so it can be sticked to =
methods
> or traits as well.

I had a similar thought:
https://internals.rust-lang.org/t/do-not-recommend-for-traits-themselves/24=
431

Alice
