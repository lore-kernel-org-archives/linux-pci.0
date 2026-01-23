Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFB333436
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159629; cv=none; b=MnyEsrxXH45zDWPPY/ZbN837RspimEUvcQqolLbS5MVQsoDE+ipF7jCtnLODc09c6fxQiArCWyzRINY+aJHfRP56sr2mOqvOx6gQqXnmyZ9GzGsw8HqoJ5OmV/v2oiYTp4eylw+SSa4bwoRvTXirPPzh4CM7G31L244R1ozU2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159629; c=relaxed/simple;
	bh=ciIrAmJYe/LBIP/e1tyFLCknBE3Ef5Fr7mcY8gWZqaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=enEcBWzFLaiANMtrQhDNBUgLIkF0PW8qGKJBcSHCg7Osy2UuX5IanSTGjnaebmmQv2H1HeHNEe4bFi3Lgawv9/BBborD16hzf8sIBY8D/kjH6oo7qPImNXrwRB8tKOSL1vr7yrvruU1QKMdu7h0LyuLCX2zw+dfx1P58boFJYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkSIJajr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkSIJajr"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso11200315e9.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769159625; x=1769764425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA7sHJ8V5XB9t/C7Z7mv34QdmVApd5UJk+OAhQYXxaY=;
        b=WkSIJajrHOKd8/xjsyofoNFm3EQ9ZXUM1Gjtb+KyGil+P/8yVvVRfC35OVW8l1h8n4
         xBgJnP2OfC/852SYrAXftiE95uAHfoeE5jfPKY/Ne43UMWd3c5Gxe6/c9jt/Gl8Hjrrp
         nszV/oGG57IfeQT8nZ2uAIA+XUIcBODFhKqToiRe4kINVYlGVjibMxcBJxflQynn4bH5
         TtHi+0sg+mycv59ryiL0l3EzDtyMw9D28ef3ghy2BnXtO/YQL5wO15KvFho3UILa7H93
         TdxCjg152O0Jvn9gnlus6dPbp1tuk8Q+RSlHLulFnZEW+6CadahlEegeF9eJHf9S+0Tj
         viHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769159625; x=1769764425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA7sHJ8V5XB9t/C7Z7mv34QdmVApd5UJk+OAhQYXxaY=;
        b=Ua+u5yCdVL5irIsMxQ/3KYfK9qZ5ZhzjvjYygY6J0Z1aiWz9hUwHNMt5lPO7t2svma
         54ekjAGOB5PFgtS1++cUlF+vF9/mPr1gI9w63wQcMEYORVxe2kqU2IYTkQWOQe7gLWQp
         Qq0XKsUFJ2Ky9zVg60b2MUSpvUqFahB5cZq5J/B3ZKJmlj55TbpweiseLSjbpSjTu9OO
         FjUw0MPEeB/yi2taze8EG2agLsuXOAbEHTgTfR6d8lrMAZoyfLYbh4GiFSatrz1EwfxI
         E5Lxh0ao9byFia/g7CkJA1LhSitUMsYdlp4wa++GeLsbD6f70xjGM/qe0OGFkXw69Z0d
         Yaug==
X-Forwarded-Encrypted: i=1; AJvYcCWsKVEFaUisin1E/mgfhsCYzcjqhP6MVGg7H3TfWs1STu19n0bI/aC1NfcIZoiiSoTH24qjku1XxjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz14o7+kbT96/+SgVKIR+ydliQE7cg1pWa4rN7/eaR9n8YuWAI
	IM+FkjhYEL+HQyHjmlaqM935xbHvXpvkUMCjZqUUm5+M5FYYyTkKPAdMdyCNuS3Xcgtbc8oa9C8
	a3mY69zV7u0DxiYv+mQ==
X-Received: from wmjf20.prod.google.com ([2002:a7b:cd14:0:b0:47d:47dc:d5d4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190b:b0:47e:e949:37e8 with SMTP id 5b1f17b1804b1-4804c9c8d1fmr35402515e9.30.1769159624587;
 Fri, 23 Jan 2026 01:13:44 -0800 (PST)
Date: Fri, 23 Jan 2026 09:13:43 +0000
In-Reply-To: <20260121202212.4438-3-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121202212.4438-1-zhiw@nvidia.com> <20260121202212.4438-3-zhiw@nvidia.com>
Message-ID: <aXM7xwP-A4qUvnBI@google.com>
Subject: Re: [PATCH v12 2/5] rust: io: separate generic I/O helpers from MMIO implementation
From: Alice Ryhl <aliceryhl@google.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Wed, Jan 21, 2026 at 10:22:08PM +0200, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevented
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
> 
> Establish a clean separation between the I/O interface and concrete
> backends by separating generic I/O helpers from MMIO implementation.
> 
> Introduce a new trait hierarchy to handle different access capabilities:
> 
> - IoCapable<T>: A marker trait indicating that a backend supports I/O
>   operations of a certain type (u8, u16, u32, or u64).
> 
> - Io trait: Defines fallible (try_read8, try_write8, etc.) and infallibile
>   (read8, write8, etc.) I/O methods with runtime bounds checking and
>   compile-time bounds checking.
> 
> - IoKnownSize trait: The marker trait for types support infallible I/O
>   methods.
> 
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements the Io traits. Rename IoRaw to MmioRaw and update consumers to
> use the new types.
> 
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
