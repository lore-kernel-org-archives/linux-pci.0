Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E03471D1F
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117799; cv=pass; b=okuFRmmLPmBzAgnsP0eYa0Xxg1/k9hNkXfMFVMW9UP72UqP8P1MhodIb2o2kIr+Bw6B5uwvfOZxPXF06stg3Mvvth8BOdbR2QQE9T2iQDSroczfutxDdWDxQdx8KYccl5GNXDAvWXOgQWT3wDLZEly+NBK0chMEnhhQ0gNH6rgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117799; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNNkikQS0u4lBTDYG0BsOAPnPNDW4N3xmNNcATCveI/OC+ZQ9xLRKtmr61SlBU7cvtBbOGLHLfGJPRHp5GHk5ZkF44KRSyImyJqxZw6WIrWZ3Q67IJyQM0JzCxLGGo2zJHuKEE4w3UGi1KLZOKbsVGRaM/ciocf4YqTyF10t2/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSlPe9Et; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSlPe9Et"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de0093c42so599193f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 02:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117793; cv=none;
        d=google.com; s=arc-20260327;
        b=dZVBzg7/lz2aDNpheSJy4V5NZy9eBagBdsTYeLVXHqf1jPooHVcOFv1tuc7d5y0b0i
         nB1j/o5X7DiYmQWWJpuoZwBBbFIqSxQkMPGhTvlhhRHH5rkipMhD4ZYjoZUInj8myjxI
         M3GnZVz4rpcF2vCo/VJn5XvPAKyF7z/eBSNgWEcy9RcoRHhiyXBuqLad4PNkKCf/gfL8
         6G/zZqmeZEwQYnuGddV93qRRd5gQrC8XMmBsjow4mkghmJ4qX9dJ5VaWROJ4gH7kql79
         64gaD2/I+mqZl6EVR1Q9eATjUEwfaShZqjUFAUyspS4XH2i9MXUsOsXb702icMyD1AhL
         fk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=+QJXRFaj2KJN2/vQIkQK9nyqpR968Q/DcN9oY8CNSvY=;
        b=aCp6R4kUcTRtvDmdOdbm06B0iwsrRdDbWAQXe2Z8iIpkp4+CM0OGYnEAnMsSJ971Lz
         yRcxm/vkTrjOaWmxS/VPJJy3yCkxryki/FLGyrE/NzVG1ohvEWx1YczYhJE+rk/LklNx
         iXowSXx8qzcBuj6PYhQwNbCl+qlFMKFkGaqCvIkUrzUIfQOCKscz/c1lwjMU1yzzzyXh
         gSgzBGD/+hATlkiYASN75d1Pj68C4jwrpqyDeiiLVffWufdlfpNpgejg7gn0yth7KUJe
         cHbS6jx6pYJWK2+ECYdDc+VR+zATmlZ7CDV0AwFMydDHNDOwGQkZd2yKK6EoETRSzeJg
         4MIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117793; x=1789722593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=MSlPe9Et/aYooxs+mmr25pr80uFZG23i1Ff+HYNwoUYblRVkid0l2inKFKvyYhCHpA
         74RMEIvUI+LYnoLKLKfOmV3XsO+idJkaF0kKg+yth0rRQtl5E2y2iqZ2+BzrV44esGe9
         Gfqu0/0FtTeTt/gj1nMdkeGllp4GG8/dPMW6SAduAajB2PJTTh0EyTtISUFtDK6olxs/
         iuCpPN7ycYnpIx1qtI10WS4KO12IM90KAskYtoHYQeaRXYEsRQKGp3BGi7i/JLvOBusZ
         K3RJXi816wGUGyT/m2NeekI8C+6tI9P5dFmWFfKhpigFYWlsVGwnGy/m0LuueQHmrlvX
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117793; x=1789722593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=s1Y6YoLmGRZzEXR53xW3kYjTwNW7JpgLeD265Dr314oSu1BDm5LY6keSmHWfjakwED
         kL+v3YPaolvfzjaifvMpmp6rvuqFppoF2BnfzjlajYjkUHT+7zerLWlmcwBSdyHIJskB
         Op4Wcwr76ldXDCm/aOmC/QtEoX6TWDw1Cr4C6W3oLdKv6DdgMipFXP3oilv91qPjG1F0
         bX8myKRcvYlSNX9rhYxAX1VV/Be+lM163/8Dtm1eJsIs/m2icqCrWW+H1d4VVTNlcgyc
         ePXdT7wR6TWfRvNlytxG29/zCgVbWGwIb2Eg6bmMKIy6YSTYJ9ao8eRd8X4xM2e1E7uf
         b12A==
X-Forwarded-Encrypted: i=1; AKwUvBw0RLWVvonX+TASRSGVcS9B/tltQKW0q3KYWIFIFAgEAPTZblehq/2ec8Fzl5W3AT7uqkrYz+ZbSgQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lbvQZQ5tH+R/LXA5wARPHTrn3IdjSmE1wfOkVI5URiDLSsVOle
	t3I5o/KzAW0wS+hcJ8Sid9fsCeBR6PDohm4neOKBmwV7dCtZbs0JfISEAR9OTaxNl39B24hrDxE
	GDvOdg88djyhxjtdCKAkVPsYl2zc0MT7W0qPvl30M
X-Gm-Gg: AYBFou2DE7Srp8rJc5eBSZ3k5Mrx+mMpnpcqzHSpUXPh3E/1fhW25w1iIuT2jwQg2Qw
	7gnVeYBuEw057Y+F36RBnWNsxQWw7zDdcVOXoQ6+90ZI7q5kNpYZg34jWS+JfYDPcb7mcu7hbQ3
	dmbitLwo8XrDymgZrKRraL/ckNsqka9lfFGjM+I1Q92AyYSGSL423WTwEHEw1K8Pbm2aGKGND7Q
	Rg4L5eIw/QRpKKucO+DacyC4bcCMn5lwJ604AJV+GgY36X+XzOanUHpH52dCes8nw6hbVr9DSRa
	xiBCw6tYAuJmO48tGKzuKsToYo83TAxLVqCTEv+OzoXQZkNA/2g5yOlYo+hy3PmgiTVHZYPZZ67
	gUYURx8/yLixzLj7JpSqvLT1jt3LnkmrV5GTeJW95/lQfWeJA47R6
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
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
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
