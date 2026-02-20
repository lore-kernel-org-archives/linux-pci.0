Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EB365A0E
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608845; cv=pass; b=Wyx9E2WJ6qffG0OJe3gslw3uRuR0+wflsN0IrUxVNYvRAxcP8jaSLhzd2l/zegqj+70CaTQF9r8oU1fkK7hJCK3ilwnhWxzsB7IQDiHgYlybhruQ6I2h18jjWPQhWT0BDASQ3FU3wh7l0Gvanq3PIjq9sQWCL3kZ0gUNhYaFqrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608845; c=relaxed/simple;
	bh=dW69iUku9IRFksYkhFKb49OwK2nuvLOXPied0JTmtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH1V0TmtfhafVvWeq14DE0MDgTVz2j4vf58XlqMw6bEurZOwUuM9WUOtjQCDnSlhsLeMeMG/KLLhSq3CkDcUHFfKWT0nMKPYjomc5YYPUchNVR8A/8+8PuRIRfHxg/2mWhpXCfzoO4gx1VI5VGR8cGU6FVpZ9ZRaZ006fVC+pZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmovhQZ; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmovhQZ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-127148c2112so221442c88.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608843; cv=none;
        d=google.com; s=arc-20240605;
        b=UtqenyqNILisXvTbht1CxUB1AHAEL9SALALL9oEbv4VV/bp8yt0XMYSkqyd8svzOWy
         H+xRouZl5huvsOzu+JckmxPLosKUJeBMbFsYtziACg61sFosyTNXbE7vLlCh5vSpVG5i
         A664mjPX+js0aybS/eS9c3R9+v4kvmKclX0NeULr0oVxEMxVi/37YuYKKEglIHZWBzRa
         JxYL5DMYdx6ckjLkmVHudJ2Sz+kKHD92Hm2UFm0NrGNBC8zo8VEaes4e+6SG+XzZNrf9
         nH96Xh4guC1Inr/6sbirWjOBljTHgC/oItBC0HsINPJ6zxe0ycrU82KPTxLQU7SBxNoj
         qwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        fh=5o0/a1aig8BddK8WdMChpIHHkykoj0vr/jD9wdWuAlQ=;
        b=CCaxVytMOUK/YJrSLHLx7yJbKFISpD1lAVDh2fxShzi+Wg2dEQN6sYXyt0RCWnhTL6
         8MjwiVsQPhg2D2zD6XflWG/Hfv0B/a65n0r4v6QaMz3Hzyv+A9+EEnyADXHl/udfGU8q
         Wge/k03CXvNMon98BvN0xD5L6WCpPNS26awzsgiJd5Xcorib3nn5C4WpEvIc3PrhaTyF
         Rq0mtqisCVj6prz6BCXuxMNZ2KG+XWDwNM8FMxskV5nyn40deaYhfulV3KKH4+K0WjTH
         2WdXjBeysuaiy+Um+fNQEtDJt7t4C30uHYmTFhUxPiA/zAqd5kku3a8T2vHrHsrgERwZ
         nZDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608843; x=1772213643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=GUmovhQZ0/gL6Csm9lB/oZvXQzoRbh+uVmBzc8YSv+cMKg9Uubues33H/9RyfdILfj
         k+zc557ufFVnuu02HgkHoFuAOrYPjf492rTJMSJs+Y14GZdZJ6vatA+cSh9f6oo963Io
         d0+6cjq3IXdboW94NV5+1nI2XbXJvpX520Bj2HNaDdIOD88O4E6cx87O+l9159ye1JVx
         z5ECFYUXaEaFv94IyKrGZwFgzAl9mjpRAIoxg2VDDG4MXRpqli7BRe0VZzFziNXygZdF
         C5HOej3GIe0ixLu5QAUeJFlzHR9sfGixz9LuDB31Pak32LJ1sCx/7snoqduumBjN/l3T
         gKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608843; x=1772213643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=ZMTCpvpoaJW+jPoNUuLWsQF60ElrlvrNXN08Dwzq1NoBkNse5ayVyAfwW4+kZitdMP
         ZqYdPRzxQpsfut1oLhNcdvmL83A+DSFWv9WnxPWtCZuhw1sdht81EvWEh8vG1fw+yzo3
         2loUJFKK05Sc2cUnAwc/G2WLCzdBCwR+DkZgSg8ID4J5kvYJlSEm2UPyC6kP7WDmpR/4
         umI316e15H7oi6pWR2ooBibln68axg06qmm1d2WLkKns4pvZQQ+Infj+X11AXo2o9iy/
         +AobJDv2PrwiEhK2z9hONGDCQhLC8RHRcdGY+8aj0HmdIV0mCw+fHa4On6fIcedjpf/1
         vgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9Q6NKFg8F4ReNPzWTmL0IKW2kUW6B6zg2Boaswuhi28YkiTHNheDF5orv2rdAKqv39c4mrYOmgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2em+HM731H8jx19MSMDe0qFh+fzj00N/eLKqi4Se58qdt8Y4P
	HIZub6UQqzdEYB0KH9Di6YuG+LdNkE7tIfO2+UdmTzLanK+uJrJYk8JvlbzkVvYt4vB2NZaVHo0
	nygfvNJLEF6B+JMiQ5DkiAiQj35n93W8=
X-Gm-Gg: AZuq6aL5gE+cALDyIHQivmFBlPOQwG6bBodyC37/35sK/ntyVc2HrHD0Cv52E0soeG5
	XcKqxpw4ElAuQUwZOd52dWgGwsei/CT3QIfvqBNfbonlDgTvMHpi1bNDcWg2uy6kw91Lmcl6miT
	FL+ucugXAVpEwaz8A8Bq9WmNElT5+F3MaX0J2YCd+C+fmyPZTg7wXwiT1wTc2rkBjQWEEAiZ+KE
	WEXB7lP/F3CQX+Svu8xxQJkwpTliQpWw+lIsu8iznTYdf1A+YWgweLv0SdWLfoj20a85o5ypAjy
	HAPdlW3jImUn0CX8DEyWj9xWAn9jDjYSkEaAVPvDJK3J/21YlkAYdYeAVWEgTATv6dlhLwtOHbS
	0EC5ygP3juwHZuYJdEEp3YKvH
X-Received: by 2002:a05:693c:2c17:b0:2ba:674a:dbe8 with SMTP id
 5a478bee46e88-2bd7bdbce7cmr74947eec.8.1771608842904; Fri, 20 Feb 2026
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 18:33:49 +0100
X-Gm-Features: AaiRm53lo0keI-FayfnRj4AYfVuM2jzmE06bNyAO-n4MO92LWSUkvblDHz_tCFM
Message-ID: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> +    /// Create a `&Page` from a raw `struct page` pointer

Please end sentences with a period.

> +        // SAFETY: By function safety requirements, ptr is not null and =
is

Please use Markdown in comments: `ptr`.

> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.

Since we will likely try to starting introducing at least a subset of
the Safety Standard soon, we should try to use standard terms.

So I think this "valid for use as a reference" is not an established
one, no? Isn't "convertible to a shared reference" the official term?

  https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-convers=
ion

In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
stabilized for 1.95.0, so we should probably starting using those were
applicable as we bump the minimum, but we should probably use already
a similar wording as the standard library for the safety section and
the comment:

  "`ptr` must be [convertible to a reference](...)."

where the term is a link to that section. Cc'ing Benno.

I have created a (future) issue for that:

  https://github.com/Rust-for-Linux/linux/issues/1225

Cc'ing Tamir since this is close to the cast work, so it may interest
him as well.

Cheers,
Miguel
