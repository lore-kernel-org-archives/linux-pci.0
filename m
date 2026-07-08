Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771E1DF72C
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506876; cv=pass; b=ptZS8KsSN/i59RK7Y6klV/+FfYOEOVmNIp4EwOgMqohGZt4gTSoCtRSOE+9kWELLKqnJ544TPd6NpcsgT3zBeDssQYk4u8cjI3Zpx6YignnWsuzz/7uyCCqS3AXYjEMT5cxVgViMh/3tVEd+9URCEYPciOB8jzh2S4n2WP1M9UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506876; c=relaxed/simple;
	bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCZUObYL1LJSPbUPAE1+2jLbKIllT6aciAOv5ZFRCSSAmjUaYkfRAq0Gyac6TRnemJiQecJoX0t4MnJLZiILog2cM7KotXRTGsdCiNDtHdVSml9g43uSb/Qy196pwTUSs+FGfu0rmSiT0t8cmmB57OtPw8glkLMFxb/p7tx9Bog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0d04Hnb; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0d04Hnb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c988e16bb3so1554975ad.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 03:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506860; cv=none;
        d=google.com; s=arc-20260327;
        b=hqGBxAKML9XusnA7E6dqthhCEngIU4qsZrywKDSylmfEbYjYYyUeKRNEHcfFnNcs4U
         Zp81GVeU8yBj7Dz2nMjA2Sx4QdljJW+I9CvvjJn9uCfjafvlpdqfy6gz/vTGvLBwSGe9
         Klcnt4d70nqm8b5AvdHFqWX/SGiwMz8HcP/PpxxIhanbmvHtukKoC2/Rsn7+8W65q5B3
         7V8q5SDOowVoCgLSupyZtInkGLPr4tIwa3+qlPczjZk4gs+5TJEjwwCooywMTi/VrhXe
         XiUgQLGSJ7xlJ49vzdqOKvCYFIIt6JaLmLlb2lSshd1IeFZ1Gf+5EWFZOzWVGbWmmrtF
         Xy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        fh=6BRfKXXnMJ9G3jXdnk7hwKNkZKcrs5xDrBQD7MkN8hw=;
        b=oYhrkUvhiI2UZ+SFXaYV/6VsSLzHO1rRofpo8QSjhb/ERNBKk8N4+xxYMy5qtrlzUX
         /e9OR85Vu1PIP0b2mVh0zmd4IGd6xMPcFk7OQNvy+CmwBPSxQkXRhA8DExPXRPrQtLmV
         0wyYHLazJhdcX6DF7qI0nm8Pdzv5EzhPe3fNagt2yBaptvWSCvM6hksR375tg89xqQi+
         DLK6Q/40SZ2aeq4TP35AN2wuBm81zNDp5CLCeTInnTqx0BdogeF4A4FDUnrVoD1akEZq
         RFRVpjao8NDPoYIpNRn+FDaETXH9Z7A7kZsg5u6F5639m8sN6+X7la/sg+vNygGQgHKO
         VhSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506860; x=1784111660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        b=E0d04Hnbd5JBCfkVVLlFLQCBGKGoe9pZsPHSWTt6VNJ0g5LRhsDq7W/Ymwg5sW67NW
         KI11RQLjO/5CmLcT3DjVJ9C/z0A01YaKz0aXxXLwdu6FZduvJhUFKp1zv6BLk8EpEAcK
         sf3EJDfHXBH8Ma84DRK1xo0HwzqHpxPPsjgPhwB9tPqSJoUheBnGo5Ii1WaLevaR2Jph
         TfpQcSiJxiT38J10Lh9fRhVi/p1E5adua3i7FHEoukRnkBXz0QMQaVxTJunKMfzKyOed
         1DG5v+x8HNSRTPqAQeGq/TnDGc/higgta9bj3ENqwpuJmfiA7b7gX4+geZ633yUuQc5m
         buFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506860; x=1784111660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
        b=BZVCpxgxqrP5BTOapzPJ1i6XW5B06/IO4H2bAr2fppW6jhY7uI7BFBxCAl2rR5AHR8
         PIMNqizG8zCv4k43O8MWiYp5Ng4wUpoYk7sLSdhyK6WRzTLH4RoUgQ8K/cYWyi2x1qKc
         yW01CsxsZgX3wxBJykprHtZw90zKupO5RC/qC/QIuVBz47hxwynd8PN2UiufjmOrbOlZ
         +8rOPaNGwqa9DCbeJjws48jW1w+NdBlSJJL+ZGEie2tMnsWK1rXsEvQL5PolZ2ltnl69
         a6/KAKe8tuZzsTwXV9kem6UYP85b2bbgrjZv3R6NvN0oH2hHV2/Uc4575+ocIaW2VV3b
         UW5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6xrNK4+V5s4zUMjtU1ewBTgCZA6llMxmHC83XWj7dPTNB4j51brzok2KyHLrNl+MP3F6lGU9Fcmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q835BGTQ3kJOeXDsTgjenVv9+OR/fyr9iz+aTCj7ZUfNFCNj
	gxYvp8bqa40bNZ1rC4rX5I9F7PK0r8Goibf3dSxI00Uxl0Jr3oi2sSTAvMqlA2aBFJ/jASFEamE
	vXLmuN4i1Blv9bPfEyJG4HUzzh3BVqC4=
X-Gm-Gg: AfdE7cl/PjU3+JQfqPythVKMddC7FvE/9Gg91HX9fcza5+1ds9C6Aen3MoKbFn+MYIf
	G7vwJBWGGjy3L3U4cR1ZaXGB4QX9jJtv4YvvLxs4Wp2nFgTBELl75TzakZGTYBjQ/snU4s9xPiR
	61O0Dsj7i2UEhA9/y43NFRQDD6559K6CPLb7P7o7ygWfJpImrhUyjS4vyhHsr1wqQ1/Rg2cC5uv
	sj6wGL6UlSiQjneB2SKC6078jLVBsARPvvz9jfq0GUkouUWYeTPn4uPlvriSpp6tSMu0Oh+JC+C
	F8Ptguzk3QDdA+PGy7nJvVW3p0nIf4jfCLHArpGgddsQxFA91PHuDkTpzQtVHAaWI2sWd4ACAfX
	3zzPOdzMgOFKc
X-Received: by 2002:a17:90b:57cd:b0:381:2d9a:447b with SMTP id
 98e67ed59e1d1-389417e436cmr1662657a91.4.1783506859636; Wed, 08 Jul 2026
 03:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net> <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
 <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
In-Reply-To: <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 12:34:06 +0200
X-Gm-Features: AVVi8CerPf3D12GiMfvLd9xxakdPl4vxt6Mk91TDYQmPEW-zWuPFQaL-PCqilw4
Message-ID: <CANiq72=8V967CuH92AJBAob6YaygXtCYY1GAr=qGuF8JzQfZ3A@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 10:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> It does, but if the alignment is 8 then it breaks a lot of platform devic=
es. 4
> is the most common alignment needed so it is chosen. Different base types=
 can be
> added subsequently when needs arise.

Maybe a two-line comment/doc would be worth it?

Cheers,
Miguel
