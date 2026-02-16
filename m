Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513012FFDEA
	for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248154; cv=none; b=fe/BnoTpi/p1cR9t3RuXz1FUpm2pE3+qdbIkJWMuDtDCuo3Lvt9Pvs1hJZeckOMd9DJ8+5QuBC5OmvVL9KHHmBbs4DpdIJfXcZeHVFwlKlsOx/fbq6hDMhO8EKjGttRWjhbMEwIMx+hVl6MMcyZX0OUfaj1/bqqjqxeWFiOlrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248154; c=relaxed/simple;
	bh=V5PyQQvgVLRArBUaO0H6XDypFxZ4oZWPK4ihpQOsK/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4GSKFb0/wVRa+skKYgEfR2lVSA9MRSpMN2T1vjCXdj7WLp8qdo7Tag5wNYJ0VNBOc5hMVqaXkyWWvsRHVM0hXdU3yBZrN1XJ2jOvTHpvwsl5WhHtGJfyuv/h93WX2STj9STVm//aPrg4VfhHmmfclWMpkVpAN69QeYNCARgDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcF5Jr7W; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcF5Jr7W"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-435ab907109so2142208f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Feb 2026 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771248152; x=1771852952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElKyrfCE+7loQXJG3oD3y1xXHkPN8AgZyfzmDqci610=;
        b=bcF5Jr7WFovaQiSxFvRi3rCAIhiRd+05QCx/qS58xH5StcyWtUdi5Q/1r5isBb0+aI
         ap34ixOSfXPkPVl1oWF25fLaFj7zjkuwDymiQFZwww1xUXwrlZ+QD4wyA2OXtQcgNtEa
         JWRIS5+3gqe6xnLmQc5p+jJMufg5CRBmToxZ0jxBUjfFbh9NS23LTpNk9Mylwc6ntEEO
         mMawBLcng9yAmk7pfGhlzkhQO1/ku0BEQo6ZmgStqQl2M1sIbmSWt5tLfxsl09whAC70
         rDzMl5BrN2u6bQJuKXEkEL259L+pjE7cAwFGLMAUqq6z52XbYcCGTtPBMbTCZJaG9d0X
         ff6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248152; x=1771852952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElKyrfCE+7loQXJG3oD3y1xXHkPN8AgZyfzmDqci610=;
        b=J+gGV0M2zle+/Cf68GcLHFHwdUey6KNbrWiGkF0fyYFBiSIJJyovxOeZ8cxdDsohle
         jlEnno0k0sZpZF2DZYMS0KcEKQOdDN9mCrW/3K689pISL7jXVM0n7yUV4go5cVgebTIh
         ehf9xHgDx+C4rQy1x3YiKlWmgl1ZYwadhC6GK1jCZ3grjkL9Gaf39s1iTYfoFSAd6F/3
         JLG1nbzbaJPiZ56//H+fpNe7cYS78LIz2nyWjZZZBnPIOmln73s+6hdEEWXvOzbGHFw2
         23GZwDfGzXuaSEq/RQ1APOJ5LbzY4DzHdyQw109ZBrN/uK0iV81SXOqmN2jW1f641kWh
         CEdg==
X-Forwarded-Encrypted: i=1; AJvYcCWFm8TF1VYmlwlLgXvNOcc//QxtPGZOXFJs125JDrhh1y3gAggJDGE1MBWugMK/IsO1hSiJdFWpsww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrqlXqYe15xOVLz021VX0RfXfKH9I8rkc1qwVxfSRTyHJT36m
	6nkrB2E3WEjLDNgmUj022+LbPvaSHRBmZ1d53HxbWWBVLU0zW7MGxWh82DcS5H7q9fyPWfMAUJk
	JycCLFyLJltlEJ/jQuQ==
X-Received: from wrbeh10.prod.google.com ([2002:a05:6000:410a:b0:42f:b6ec:c515])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:310c:b0:437:70d3:44ec with SMTP id ffacd0b85a97d-437979189c5mr17087369f8f.43.1771248151307;
 Mon, 16 Feb 2026 05:22:31 -0800 (PST)
Date: Mon, 16 Feb 2026 13:22:30 +0000
In-Reply-To: <20260216131534.65008-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216131534.65008-1-dakr@kernel.org>
Message-ID: <aZMaFhvZWiknu8UK@google.com>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and io_define_write!()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	ojeda@kernel.org, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, zhiw@nvidia.com, acourbot@nvidia.com, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 02:14:33PM +0100, Danilo Krummrich wrote:
> Currently, the define_read!() and define_write!() I/O macros are crate
> public. The only user outside of the I/O module is PCI (for the
> configurations space I/O backend). Consequently, when CONFIG_PCI=n this
> causes a compile time warning [1].
> 
> In order to fix this, rename the macros to io_define_read!() and
> io_define_write!() and use #[macro_export] to export them.
> 
> This is better than making the crate public visibility conditional, as
> eventually subsystems will have their own crate.
> 
> Also, I/O backends are valid to be implemented by drivers as well. For
> instance, there are devices (such as GPUs) that run firmware which
> allows to program other devices only accessible through the primary
> device through indirect I/O.
> 
> Since the macros are now public, also add the corresponding
> documentation.
> 
> Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO implementation")
> Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Closes: https://lore.kernel.org/driver-core/CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com/ [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> -pub(crate) use define_read;
> -pub(crate) use define_write;

You should keep these re-exports (as full `pub`) so that they can be
accessed from kernel::io. Exposing all macros from crate root via
#[macro_export] is legacy approach.

Alice
