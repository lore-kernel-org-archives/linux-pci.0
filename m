Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B7416CF8
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824541; cv=pass; b=UgiHvnVp7BsnAh0MPmC2oCYTUTLQOKQp/9Q1uXW0o9+SMlb4wF+v7pkeJU5FtkXtguxK8wGk8b29fHxAgzbQnGTPSYzGA9JJ3Z133L0yXUUMZWzMIlB/Qkut21rrbi5U0NHmPrUzergbPmwgbnT8itBsq2JfNtLvA2DrVsPIPyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824541; c=relaxed/simple;
	bh=zVGN+irJoRn6fLQWlrqbDrVdpoX5ulyKwx3V8NzpaKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHQZwN2IuwEBafYy32I0d4orh/3787fBucjh52JSGplWlWnycSY8QRDuT7tSAmS3XP38oBBvkImQJ/+wRC8Sgf8X1irYkeJwH2NyeM2c4+plUG4kxfw+Xlo3sbredGx+76HlmoDQrVn+CdS7neZ8YTPVt8ItxePRYgcN9PSP0LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/shVtnE; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/shVtnE"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30ecc2e02e7so154768eec.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 06:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782824540; cv=none;
        d=google.com; s=arc-20260327;
        b=dlNlGOWz6y4JJCHn3UV9mOnAwj7LVGOrVzX+wPHf0ssJnKxMs2JK4KnsIWkHp3UloG
         fkpWOeyl1BwM1tqN6dqrkMb/EmQfPxFefsDL7+FpcADunW0Ynv2KkvfVOSyN4moC16mq
         vIwxjPF3TK+4ILfbswwSwRPhdEKcRCl6EJa7ZpqFyZtK8HKPF8ctT9V2nZ38FtCb59Q8
         RzSiAki1kDGcFIPX+s17I2PEYhSynEoHiWsPR0GCY3j9u7T1EDwok49GoU2OhqixS/oC
         TU+8Z4Aw7OJld7YtArhRTSfE3zgYFyVMCfiBcZqNKFAf2l+2BCVo2+1fYo6QQns1rKrR
         zZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        fh=D0rtwhVNQwJiJNzt70LITcUiuqqNG6aeVhWh5XNw1sQ=;
        b=Y96ukgrK6mM8Q4IvB8Mmq7/Rpu7Xz/IYUza12210Y/mwv7t1q/+332raALg/x1PJSp
         PmvgHRUAWNuPOgBtl5qBRiVqEc26BQzQQquDwraCscSmZO5guOetuqTcnOboIW6sMTOl
         Wz/kfXc4LtEFDwam1FwloUK/ErdaIGxC/Qp/rhoyFzEY6dMuu1rQvmWzGsyJy0bkfAth
         9/9kADC00mVrSYG+/SFi+ChjvRlDIA6ONU9V8KHCkd+oOx5dC34vRxD3J36HV/CqpZjU
         QCYEPLR2g1ktjgbOQRoBflrbleEkPR1AcdbeKaMiy6zWEQqfkcKxFiKLC2RzUzq7yglm
         8QfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824540; x=1783429340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        b=W/shVtnEjxIbeiLPvQZbnxVOAB1dEYpDvCixFFIZJDBWOb4YeKK2YBLQSJvJzVitJL
         djy3i2wYpeQm8rHpOyhRnPY4N3PLr1/oEDzYV5LRc5SPi2EfG4v+SrOSA6ZBxiwBTtFl
         nOpmMb0+BOa1hpM3X+NFuTmBCxyureOfewIJp0/oyLy43E7glJkSgFLLFC2ds4c0kvAN
         ZodmwbAvora6LNjydB1rmz+skrYoTbeRNUyhx6R8TbO599/OsmAwFwEupvfsmkXw7XX0
         vSM8uNCTaJtk4CUwsnb84ayRMxMWujVsNSExdKrALitmXBXxX2k4RZqcajm1KRloqRHm
         3dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824540; x=1783429340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        b=XjR5BlytKkSoBzKggGjBl8vhqf2gioDlPowMA0tT+St38wRH3jv8k7a5uWd/KdD9oq
         oxwrkA8M60E8NLzsJG/csmP4L0A77vGyihZK+yEkidlC3v5bMRvT4fpouPqX50r/203B
         fpkeF//SuX6nAqQsqRLw0cPkI2UWHDy+vnbIC4pWAz5L7meMBiPuR/xL3t63iL1LRPkU
         ULxKBEbUebdX8gYUDqfdJ3re+OTSVin5JMeZ3+VyQV2rsWKhJXwjKZR1+d2+j+mo2jXD
         EPZXxBSP4oE/G27V2VB4IkToZdVLTbW+97wAza77Zz4e5QQsli/JnfTviPiivqp44IYJ
         xNLA==
X-Forwarded-Encrypted: i=1; AHgh+RrD8YvJD7xy9d6Lma+UYM8E/M+AZU0iBN+pd68kHiLgxARwQIxfSPNMaSWv0UDBcyjortcBcp/d7Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GLQ5U8XMHwaXNHBCcZyZFDGJyeTcNblqdTE8pcRCUUYm3axy
	6vCdBajR1GCO402WqRiiuIVNj1tlbfX3bZ45tGfyDPS4UKc8rGCkvRP4cj3uWyC/wbQLColUUmK
	wz7DH7wOsCZ1+Mdx8tE7lmZVk5HoEK8k=
X-Gm-Gg: AfdE7cmJSFr4pl3esBIRYYGsqEz1OrAWO4XRApyR50wevrJJV7ZV39cwN2D9mC3zIIr
	a1Vv9M8mOfgE40G4NcumEWN+gOdGfJMZPY8NxiB/YXdae3NugySjm3ulP9Xg+Zpo+pUdi9WOWGl
	8i3wKaLvoifTMWmI1rWTVtM59KLu+DPyNENUAN4ZA7YUuYenbedHDwS+cIBbLer1jKsOw3HWC1q
	PrCPHsQV1+VwuoA/jQNPYxkVtpqyKW3wKdXw1VJf2IK81TJverhEMbpbdkQvAylnIBqXTSYxhn8
	sMzUReM5Z05LBRy+m5gsAtt2d15wiaTMJresev5MYxeP4JngwgkqNa8X8mH5hKSrSgmaAFlSp/b
	L7PQRcnZLFBd0
X-Received: by 2002:a05:7300:fd13:b0:30e:b3e5:cc43 with SMTP id
 5a478bee46e88-30ee13cd8b8mr1307107eec.4.1782824538764; Tue, 30 Jun 2026
 06:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org> <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
In-Reply-To: <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 15:02:06 +0200
X-Gm-Features: AVVi8CdlaW0HC3qcToqh7v3q0JT2Ai7s9vfzaVZXIxvGTDn0q6fiJzf_f2XS20c
Message-ID: <CANiq72==81FEfMxTnUCdrFBtj9fnCnhF6jXgx_eqE-VsLgW9Rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
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
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:15=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Hmm, this looks like a false positive introduced in new version of rustdo=
c.
> I didn't get this with rustdoc 1.85, but do get it in latest rustc, howev=
er the
> generated link is correct despite the warning.
>
> This pattern is used by other code, I'm unsure why it doesn't trigger the=
re.
> Anyhow, the following diff seems to be able to work around the issue.

It seems to me that the issue is this line at the end:

  /// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)

should have been:

  /// [`include/linux/iosys-map.h`]: srctree/include/linux/iosys-map.h

i.e. not a false positive.

Or do you mean something else?

Cheers,
Miguel
