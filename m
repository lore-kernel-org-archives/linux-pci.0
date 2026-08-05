Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697523DEAC8
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916359; cv=pass; b=uSZMfKfGJVFjlc5vJo3lTqaND/7kUTy0G6/vXeN1W4eZR5+5t4Wu4/7WIEtKEKcTLpZ6gGk7CmwdfJey/HaCSmX3kvTZ6s0Pqv1rkUSJOdExdVuiheKWuj0JaWnIQVMQh8Jnhc0yYw+Y7MbuM0sckf/Q0eWv6sqZpWxVIDmHUTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916359; c=relaxed/simple;
	bh=pNEDEGkvhsjz0oUUfWOaI2HwjcWdvqQEyqTxD4WWlEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwDjDl3G4+pUMzSTAd7SiCL0IbdwKoE/qA5OKx8KDwf0YZKEPKoDdRabo4IdgsM8MSneKP9H/R2EE2GVccHzU+hykemXzx/WWcZs11SNMzO5axpwmzhcaJGEeNO0CaLZHzNHdhUoez4awKKknhXYv/GIua1zB1LNQDshr+sImQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doCVckUf; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doCVckUf"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f633e6058so529841f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2026 00:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785916355; cv=none;
        d=google.com; s=arc-20260327;
        b=VqKI3ASlgagWPrD99zH0kHyr3iUTYUu02z6SgkOnsSjeyUDdb9MDwQLR/Q/u7oviYm
         cdQSRffCnZZn2FwQ7KYH5LyUboNmAhDh7s5VmhoVb3LEbNqpt1w8+7CNNzyOqhm7VMBO
         pEOZabTOh+GesSgd/D/NH6wVJO3leH4fsyIM0JITBu3J7C/GLmSygUhlQAawWqPw1ESL
         qWhjTjuDQtjlWu2jbxRQZHh3XtXoSIgxiJWLuCuFHLjYbmXmDEF+YdyEx9eY0b4bDZ2Z
         jSpIP1fPGKDS4OMmQj3negumRWEWpvt2EL9O/gwdVPaY/vjXK8uq42iCyP+ULLMIv6Uu
         1Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pNEDEGkvhsjz0oUUfWOaI2HwjcWdvqQEyqTxD4WWlEc=;
        fh=D+vNf6bxg3kZO1eBu9uf/OXShnveFmQ1EGUnV3BHKl0=;
        b=eNO0pF/3Y9Y5B3nrH1T0hOOiSHKScUPrQX48CGeGYG4f5cpFpDDHq1SdEhLCF0/3pT
         3g4AveDVm+4eqiePONZzUpCPNCKXKYL001+miMF6nM/l2LJb6XbSPknIpue/Lrr8OgCl
         qPNkncdol0LwSjmFwuTSG0xNPMaP2qZpDcCREZElGktsfA8/4wnPrlCXYt2OAMWcxf2N
         5RMZsOsDgDH2VX1nI5IkKZP3MUhCChQzIZlHTgkf4HnkzvxjqX8F3ceZr7RGqpX0yEAq
         l7nv9jbY/SCRBK95Cm6g7xYuZBjsug/1iPERS9PueICGEvPV5eEnxaNuO6mind1RukzB
         /Ong==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785916355; x=1786521155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pNEDEGkvhsjz0oUUfWOaI2HwjcWdvqQEyqTxD4WWlEc=;
        b=doCVckUfF9YfZ7BvDitmSAr8L1OkJtxwgdwmh4PvADmlvpMuFPg9G1GVL3wu1BxvCf
         Xj5x1jpluejugpRBybCGwH3LIANFoiX5yxdolDfvQD3Zg9kK+n9z02rZh00+8m8W8RYe
         fBBNTEX1u6UNEnICIj1tvADzWIWNb8MM/HBMtyECIZR/m/d9xWTq03xTpy/5jvuPZsU7
         CFck9Fs/VEYPMC39CrnM2XTqcRdPPREqdBHdhLaCgNDyYwhcQYxCB9k+O5+p5QCKX2bC
         jgrUuZPPFd0fF2fRA2XyX7lFI47wfv1dT+g6FOYuaab25PFTlGgBoqDXaxPEosggfNQS
         HEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916355; x=1786521155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pNEDEGkvhsjz0oUUfWOaI2HwjcWdvqQEyqTxD4WWlEc=;
        b=tRTO8g2DUzSQcL4r7bLWQPs4lXRbothE7vJ24RmLs7KIMqo2BJSvarN9vyh9GJbT6z
         TNdFCSVygEV+crjIrfDQEh0FNCByKr0pCPLDkkNKWY9+aHKqENCFW0HgF2nFbw9YpBfE
         H1cdwQ2M3WgDhgpSf+Jr7jf3egnkS3C7DbzX/RJgyRfyJj0Yw6FDWRtY+jwjWB2PSKKq
         zMmXLh2V0KFEel5J1hP2XHseT7i/2IZwcIwf2pYRNbJIerA4EmfPqP16YgkiJFB3xqrk
         oJcrsUCgsGkSQLpm4vVdSJ/q51CADUOUwirE31ekOBujGdl4fndcmXJy3Pwkfg6y881/
         xWvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdLQN0euXmmFpOJdqfXZNwaklJbj0g8Td1C3I7cbJpDM42+Ykv3fYOhOJEjv7W9sXx6pX1IQp/2/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sdTqd248N5A/p2pOpPl4s0mnLlpnAvynkJKDiaey/EZzHx3H
	kBYf1sO49OmnaKgCUnXqbwVcydiqA3Vi0NatjLUMN1it8p1YDwIJhfQEBsfbZe8ICjFqKLnNMe5
	b93V15cLV2kC0Daea76CJDmwdx86HBYl0QNHvyBLx
X-Gm-Gg: AR+sD13+CI3EVGxzqOqjEBHllWppX+wkPnMBiMNP1j1pqsG7NybCgtUbs472eP3a63n
	8F/HPz0oTHjxYhAJHQ7U4Ft8DRBEnmQWs1mdDYLJh2HV79oDmyPzZQ3ZQreN3J/7Ns/i/YTi5SI
	kTgbs5gAsMuYL7BqFE+WofuIeFkYxG53i5AJQhyUAPHxgoXtbzk85mtHCinyr5A1JjiFNCtPue+
	9zSh6aIRaUtSyrUPXnNtZeV3CgI/kC9S1p/hlpG2AnISsIfCnFqAsnfZ80xj0wglQGOZUszwoiR
	sD5jsNWgJzWNi0lqZCIhwPk4TP2mqmhc7MDLD6INsvhuGGpwqj2Q15ilDaaOqJgL6nawN7Hur7k
	=
X-Received: by 2002:a05:6000:46cf:b0:475:3a97:8e2c with SMTP id
 ffacd0b85a97d-47fec62d8b8mr5492989f8f.16.1785916354952; Wed, 05 Aug 2026
 00:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
In-Reply-To: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 5 Aug 2026 09:52:23 +0200
X-Gm-Features: AUfX_mxXQfbIfIRglagIcJY8aXRXibWNJw_m0iRmxH8ggsi6AStaB60A1hf5LBk
Message-ID: <CAH5fLgghsXHTWfdQ8j44kXO3+Da-YzhJxxP8ncTbfmw-c=fW4A@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: Mark Device refcount methods inline
To: plant.ethan@gmail.com
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 1:24=E2=80=AFAM Ethan Plant via B4 Relay
<devnull+plant.ethan.gmail.com@kernel.org> wrote:
>
> From: Ethan Plant <plant.ethan@gmail.com>
>
> When building the kernel, the following Rust symbols are generated:
> $ nm vmlinux | grep ' _R' | rustfilt | grep -E 'pci::Device.*(inc_ref|dec=
_ref)'
> ... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::dec_=
ref
> ... T <kernel::pci::Device as kernel::sync::aref::AlwaysRefCounted>::inc_=
ref
>
> These Rust symbols are trivial wrappers around pci_dev_put() and
> pci_dev_get(), respectively. It doesn't make sense to go through a
> trivial wrapper for these functions, so mark them inline.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ethan Plant <plant.ethan@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
