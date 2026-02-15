Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DE257854
	for <linux-pci@vger.kernel.org>; Sun, 15 Feb 2026 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164705; cv=pass; b=h8kX030tAhkj3cC9fWisvrs8CKQ8O6rUZZGRHXMKQAuqoeez2R45jwN370+npdGZOAaJA5JEcS5TiDEIBSLbA/JVbNgK5mZNshRUYfSF4KIBM592tnmGolMm8+VZtZ70ayc0hpsY6aU5fvzMw9qEk7XkM64UmTE4mKNTnV4riBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164705; c=relaxed/simple;
	bh=IS67sc4Ha9dtdSU+DoGA1J2xownlpl0HA1i2nBo07Do=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iDjjHvQmYFvFr8ZYwZYfWrC9wwbTkzfmj5Gc7ppEcUGc6HbUPG0KrXfmJlIigFcJ5WoPnk5rDZxWPOUPo1EkiFHq/INf0EG1TcfFp9u02rqTuzv4PHlrwPw+5+x9Fv/ImzEa++OoK7d2lfOiIonZ1NB/f4a1SBrMa3FX2hoP7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6VG1AAL; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6VG1AAL"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba716126f5so125989eec.3
        for <linux-pci@vger.kernel.org>; Sun, 15 Feb 2026 06:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771164704; cv=none;
        d=google.com; s=arc-20240605;
        b=awhofoPYI+DShpLQ7DS11S2clXX9jmS0F0TQTMNcDJbeu2inZKQnzc9StntcwWPSDw
         6dJ8EAdtstoe89GNlmPOKQxDpb+LjfRAFM+ociD327GMezSJIBcLVqWRCyUNz2nhrgU1
         D1+soTJsQcbYArqyOG+bif04TFB2AR0g7gPWqflJ2LcdNfHqCLyMdUOQhgkYch2kJxK6
         XMlgrhirUxmMAux+7kTNDE1dASoHYBnLvVV4Cf1dHufgSLn8AEVp8QGw4yRNqyIcQnvQ
         uDlSKWcvooD+WWjce8OazkzCGPBogUV1mjvRrCotuH4QGyApzdzFw9EQFblRdkKhjEaD
         2SeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        fh=pCW+eq8UFtoGPcxxHFeKhAgN4HSaZgvUHrjHezNMK20=;
        b=CEaPQfk9QP+jwEtyMNTSCmwPHrhkyOqUeVVtpoxYJprHud0uq1WemIDBO+6ohcCya5
         dTKMj8ILpcEpkAoGvtES4uFSAHt/ErqIGc11jAL3DwoGatf6euBFcnN6VGisJFfJyzRq
         6/jnWdHAvdv0UMenq/qQdJYOcY+4BTVZ51Zrp1bGTvxBiS5C884j4EyjkMmUVcRXmkxx
         8gnPSW8V9PhDq/Emgwzx2H2g/zDh0oqahek+RJQHAqYQPuhcG9kjJBdor2QMJD1nhGqG
         pcwvHBTvuSC0v8IdKyDc6T5Db0pxh87qh3oTxd9pBbcQkIvdWZerXGTonBi/2H/v4zFi
         8Mvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164704; x=1771769504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        b=V6VG1AAL/WR0gifhVmdJpLYLkwCMeAM1l5parGTPYr2nLFFpCIE/a8AIMC38McGez3
         iRsufDna4Ypab/2gw5qgA+FNHVvIQfleUCxIwTx8shSTYTGYUNs7LG1vUAglyEg6HyuH
         xh11EttFv5sbj20frQ6uUuDfujLDicmD0rCej5/x6RFvNLvvUB7Vp//5iYs/XyzZzoOB
         BRlr5RwuXG7DCuSS+hbyy3wEmlF/4b8Cgo3ogtqcLHxn5u3MQpPH7QAPPyJM+zWJC5PW
         qkPp5EBlkvrsNj54Ujps/jRe+GgpMy7ZjfN8whbtzN8mZw0ooFEyjSqGHKLDQrsRbhGL
         KewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164704; x=1771769504;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmAu+Za+Ffpbk5WZHW0bF6Gwlmx16jAYsYG2pCm96Tk=;
        b=YWFw1L5LjCEFRtWffwS4AsOi5It4gRZKHqzWLKaXkqgpBpvurg69bHMV0txgqx6FFT
         dg/z32pbssXTlQowLAxmuhT9fWu/cmAT7Z9QjoIUZiRroY1jCUmpkQmq455LSujowJ8o
         Gs/rOttQzzT1ATFug7Z1DoQ0q2ob08rFn/ycK1JFtz3MtR3SCH74HNWulwqrnOPo5hml
         K1CRFTS3Wpdfx5Y2LESJnUvwBMh5rgihFU6JdkK4SFvo9SvpFYvInSQGMteF23OTY9OW
         wOQxXyOvjM2rB+KtiZO9vQ0WqMTC68ScwSOOq25foJWIA1WbjMvdAmQlBz2vOrWLf0YQ
         LmpA==
X-Forwarded-Encrypted: i=1; AJvYcCWuNkjS32jaBhX9VXKuDfEn7M+U2uB6Kur3JcTtSmqVP1WbZOZRyAJA+Fl3j8uswGrVj9qhCsXvRcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApsMhe19mxKdjW4JnzUFosGfV+NyWdmUoQ0cboHbJYjlE+UGg
	6CYHVkGmlKYNk0OC960YLX9ZKbQWD5DQzHrw5FsLwec3R15HLK2qrPSdv2zSAdDqLO8Q0ABVZ9L
	1SRcV/JClw6CpAAbzBhB0Bj0c5B/Uiw8=
X-Gm-Gg: AZuq6aKQhQxsGKd2DRhU0IEF4y9YZc0Mc1UAL1qUzduxm6c+b0voNtielC1EHZIFaJE
	3KyAhxWx+P3ak0c0vlEh9HEAFkSy6G71MLo+CiBE3z4PZB9yFgvWOqOH0Q8eQHr3YbctcSEmwT4
	ljwa1eGQHVlHDLVwhdxMuVARA6bR07hhAsDl+mJboamgPp7djHWlhyWXa32tELL8ulmshHIjrnl
	1kN5zhokf7ct+6xoXh/OIlzBr1Gf8mVgnVkE8qV7oxfW08ogNIfCx3bIdHGqpyw9F5/mVu4km6g
	2QW1NPccCKNi15X7Pzv0nmmC6VGzqOKnsAvvueb2jA81aeubvSNJVYgflaAspdcOwmqEsoH1aDc
	ksFErgFwBajqWq0wUTU5lJ0v7
X-Received: by 2002:a05:7300:bc0e:b0:2ba:b16f:8092 with SMTP id
 5a478bee46e88-2bab9ec5ef6mr1638797eec.0.1771164703649; Sun, 15 Feb 2026
 06:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Feb 2026 15:11:31 +0100
X-Gm-Features: AaiRm51kWsntpYAMki_wBOn4FdlRNmJALQ-XrmQQ5z16DZEm77O5QapQ1SrWrNI
Message-ID: <CANiq72n3qPsoy2u1KxfyV4ZCjJyDZLkK-54i7EesTH=TE9h1jw@mail.gmail.com>
Subject: Consider backporting rustdoc fixes for 6.18.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	David Gow <davidgow@google.com>
Cc: stable@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha, David,

I have been seeing these warnings (errors with `WERROR=y`) in stable
6.18 UML + Rust on the `rustdoc` target [1].

Unless David (who works around UML + Rust) or the different
maintainers (Cc'd) have a concern, please consider backporting:

  a9a42f0754b6 ("rust: device: fix broken intra-doc links")
  32cb3840386f ("rust: dma: fix broken intra-doc links")
  4c9f6a782f60 ("rust: driver: fix broken intra-doc links to example
driver types")

They had Fixes tags, but not Cc: stable tags.

I hope that helps & thanks!

Cheers,
Miguel

[1]

    error: unresolved link to `kernel::pci::Device`
       --> rust/kernel/device.rs:158:22
        |
    158 | /// [`pci::Device`]: kernel::pci::Device
        |                      ^^^^^^^^^^^^^^^^^^^ no item named `pci`
in module `kernel`
        |
        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
        = help: to override `-D warnings` add
`#[allow(rustdoc::broken_intra_doc_links)]`

    error: unresolved link to `::kernel::pci::Device`
      --> rust/kernel/dma.rs:29:70
       |
    29 | /// where the underlying bus is DMA capable, such as
[`pci::Device`](::kernel::pci::Device) or
       |
       ^^^^^^^^^^^^^^^^^^^^^ no item named `pci` in module `kernel`

    error: unresolved link to `kernel::auxiliary::Driver`
      --> rust/kernel/driver.rs:82:28
       |
    82 | //! [`auxiliary::Driver`]: kernel::auxiliary::Driver
       |                            ^^^^^^^^^^^^^^^^^^^^^^^^^ no item
named `auxiliary` in module `kernel`

    error: unresolved link to `kernel::pci::Driver`
      --> rust/kernel/driver.rs:90:22
       |
    90 | //! [`pci::Driver`]: kernel::pci::Driver
       |                      ^^^^^^^^^^^^^^^^^^^ no item named `pci`
in module `kernel`
