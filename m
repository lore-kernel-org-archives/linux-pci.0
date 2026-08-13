Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AA43B4B7
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609162; cv=pass; b=Goh73d3xi1AECIMUSCE7ZL33ghW4eiosdzAiLRDBZB+jg+uBR/B8rKQ0Gm4GCZLunAP+CwC1igNNj0hOD9wOZxbi2+EZ/cGO3CgOiKUO5f1X6Kz+DktRH7jIjE6bLWcNjQ/aS9lFWKJhDLPKOIZYgx2/FUFH4bwOdUojWZIt/aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609162; c=relaxed/simple;
	bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z943N3QTyd0axtMj/2oFKKXVqPpKHeM/ByBwoLMx1WlhiHhvbN4jadzV5NLI4J9znahE+Gc1xDcnQzWuGowMm4HsCDhF13hq89EawOOu6VAXR3Neg90GLGE+E175hykYhg7a7feBjGuiyZOHc1ad6Py9vZw4NQ8DaY6jNnQWYTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiKXJg03; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiKXJg03"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-392af6bda98so354685a91.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 01:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786609160; cv=none;
        d=google.com; s=arc-20260327;
        b=W+lTTdbEQ+S1uhrtcnsqE52v3XNxjuQVA8aI+qth3QRz7bOP7UUovtpJnOWDTCYAF9
         31Vo99kXhmRSp+aKQlXVI2iyYfSfAvynOEaURK7kGDPzMIsEtEz3IhO7TFsWE6A8UkeE
         rotvisCkYQhIYn04nDJW3l5LvKBkefYY5Mg3mamKYiCosYfo6PiWSQqOpOCh8NIHt95T
         3bYkaMdZKGmlsSNSDzanHpetvh5+VdYKmuWTNeL32ZnjKoj0Hr655Z4t/siAwAT1zkNy
         R+5ye/1aG/PSKeXnx+508IMGsShw30MJ5bDlEUPsAwZHYtrJM3aeRcUUEtu0uWsvxRAP
         peZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        fh=lNKu1NnC+2RtQMiELvy9d5IxT0v0wP6qk9Volq6Cc0I=;
        b=a1UU/ROOWHGtCXF+DhSbXoXPFOQU00jrB0bbr+rZqoIj+k76tfewTtQw8venVcIh7F
         NjO9J/k3syQIOzbCH/bBy0kR0d9nC9Z1otOhofEE+d+hpJC3QpuLngf29NoWV6ii6SyR
         cqAKDOeW1GhcF2oSmuEGP0Ip2T2EyXV8zzeOYcaysVaWDTCuuqfXnE9vlF/rvJRpumY3
         X1pnrIzjVLVRbTyHQvjBxXNOxvM04dVMN84yxS+CSoDqRcE/25YCCdowG1Du71G7BaLw
         6MCSuTjJUIkFr6A8zSRulxjJQzvzdn/7ul8cHeHFHKUGDSAB36/S5lCvB42tMipVrr2c
         0MLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786609160; x=1787213960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=jiKXJg03ISCWp4I5Y7ccPMu321Ea6AemOZfQWlLgVESV0Vh7f3GfggkE0tt+xWkPpi
         3ACJjmUZFwOHd4xdX45veGxbDPNmBHmWplhxbEmy/YKTVnkRGV5Zm9dXtlcLWuYbBACn
         M3WXqdZUW47hmbmp3YHhFoRMGh3/FL8SbUiZfcchHI4i43vXfNupNOt0MQTPWpD74ajA
         JptqLcLrvVjxvvALg1i53eNw8PTMq7AS0IgAzYWk1XBV0I7Hygmf7Me67r8NWsjqbyY8
         7GNl2JTiQ+PfCLX7//mzkJspyqK6oK7NOLXJfN5pSltReyQsGmRqKK9Er43gYXiqaEdn
         Bp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609160; x=1787213960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVrUSNzIYXwmMA2xnmHjPXifoomFAeIS+si0eytqGMU=;
        b=mgPTv+Ohe5B8gMpKFxeAqVFFAZl/R7yB3w1NW7umiNttk4d6a1ppJkHwv6zDzUtfxn
         nhJj6X6e2iNvwsrbnwwRVxLcZgjbjqrihvz4DHf2Szb88KiOPKCh6VWyO8kOelHKjARH
         YTC3q1kND+FOEwph1uTD+/ePK1Lro7JD/b3bkW9GY6OCto3BIm6DGFJII/wG8DC6P0dB
         b8SXguKL0IuGWU9vuoXUsUJDZA8y0NrvhSup+6YoNTwsNc7XCAsciDs1ueXw6f+ji/BI
         iqM4AjT9CwZk35L+obCxgX1XxeSNCdnXVLXTEvcXr78eeZzG/Tcu9skSus6ZxzYcopYy
         oBMQ==
X-Forwarded-Encrypted: i=1; AHgh+RohG3oIw+iMm9uTawafeS+Fze+LX5fTUSPJM1awGHvOtEyINxiheyuHlcB28WRjbrTc0sI68BzxI2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrnazWRBtsR2z/IFWUawpkp/o+pQRtKnbZjS5yzOqbreBYP04
	NbbNfyZY7vwAgZkbcO09KdF4clZ9svHWMzPVMAxTUEOuyr4xn1chNrs5nVub3FDf0vJGFq0vQI/
	ltIpztlgOP0ZjDCW1sH85x9971DtEyIw=
X-Gm-Gg: AR+sD12evQ/YvWqUQ+pwiPs69VoQEiCP+kYu/KFGqqyLFsARSrm81V/OTnM8N0y2EOe
	ovpghuXUQSBbLPId9V8OU9CGMQnCXxyMvHtdoFOcehZmDl5rUDO0O9w1wketrRDk91h1w9uoMCN
	v/aMhdZIeeX47cjsT6m33qwwVLDxv7VIR2RWdmOE8l1B4uAkyrv+uVSL83x1fqUUu7coAURQZgr
	hkODo2qD9mAZD2N9LfU/L0NdZf/oqUI56XXky63eB2UoE8n7oIc2emvQwTcbyZrSOyAAyc9NGI6
	QiFF/Debi+ISUOTn8Bwc4JyGU+TxRjCbVYGUZpe/ZGlajSKM2W0daKjr5PpeZLghDgeve9R9ccw
	akkk2kGriZHikVaMVk4YthihzHg66bjVav0WlY/K+sOfo0duTdcs1YergPOzkCHnEX/OvYGU=
X-Received: by 2002:a17:90b:5807:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3931e2aa828mr3336244a91.3.1786609159836; Thu, 13 Aug 2026
 01:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com> <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
In-Reply-To: <0102f153-154b-430d-a3da-2c8423fb3f1f@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 10:19:07 +0200
X-Gm-Features: AUfX_mwh5p3w0RKVhg92eH8jsf5k7VluJKRFIvAAaH6tiIul7a7G8q8L9_4Mlig
Message-ID: <CANiq72mcFp-MODPkNGPcufxb0YhPDO_eN8J-ZFVzkd2-W6VK6A@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:15=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
> Thanks for applying the series and catching the stray Acked-by.
> It was a v5 series-tag, from before the MAINTAINERS patch existed,
> so no need to re-add it. I'll be more careful with tags in future
> submissions.

Thanks for confirming! :)

Cheers,
Miguel
