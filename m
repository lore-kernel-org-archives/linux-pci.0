Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216A23EA80
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439986; cv=pass; b=KvxXk+Cu2c0AsBXZcu4MQ1Lzglg/WJojKPdi4FMW9avZaIQotg5RSi0AL8p04FrbWdnXH6DQbThG8wxThzPqoLgqn91IlvqGies0VPlDCPDClBK0VnqkX1+DMSPD3jIAspfbmtlXOj9FaxVWcQvygwDw+dX3a3F9Aa6im3KIuPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439986; c=relaxed/simple;
	bh=Z41mf+ChQ/9Ufyepg/JpP8j8QIs8IVmpuK2fawXti0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBSthLdW2RxIS6D0+m9FSME6KbIPqdDM/aht38U/VGhS9g5nodYmwT88zyHxXNMzOCuom6IVxaB/xHSOxuMhQcTeYHfZU2Jf+cpnma8KtJWJhPane87uZ1Z3likp4sw8d2rJP8M3zj6Kgkzg3g/1SDt6vGUjp/4hQJgxeutr9as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMibE5iG; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMibE5iG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4327555464cso3119863f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 07:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769439983; cv=none;
        d=google.com; s=arc-20240605;
        b=HAexxcleHH11q7NNKHTFNgfxr3t5UgtSyT0oJWOC2B3k+hd+v2hjAQ/CvJxt4q+hgu
         XQlIYQUQbh4MhZURAKJon26CPe5YWCfhRHKFpHsLbEGJftBx7japwOQ81V1wxinUqWrr
         0UVIwf+Vq4but+WpsPueT9VQ76LC69clIZvHfCS1yYycaKRA12SPED8UnslDMfJzdn19
         txIZe//Ex0JI9qhJBBD2FJsGp0WR4aOkHGBQzs+g4ehLMRPECr5swXzCqbC7Y6ObEnIS
         dHUvxUmlCZg/XBUXtACVGAB02+D7j7TaJ4Txgvrfx4BcsEc/0TQFF0EdWRsAZvc3QMHh
         5R/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z41mf+ChQ/9Ufyepg/JpP8j8QIs8IVmpuK2fawXti0w=;
        fh=hOV2vrUVjFC4biLI5ASHZ6iicr3/FukXP0ZpKWr5vFM=;
        b=hYyXcP6Gy4x8Yo6I6vhTGOqqe3+OjabHfG/JWk+L9EVF3w7df/hkoG0FZN280Gxfn6
         ipuvlLYelp/BAbTKemu4TQSbfYa2Zj/WdoowxlTDX6dLf8au6m2sp3vQdFF8q1AtEkyA
         oc4W9OAxLnKukjcay54CnikwPH+qilQVTklFMAg5tOYkple+DNCe+L+RKCS16djgfhXi
         2TKsUHq3imnlKI/mwzOyUuTH5ZcLjDhg3+5Vn24iV/Rq6+gMJzG8W+T1BwboVRdJCXcD
         YMSFa6+fMO4s612t1biKB/O63ZpvP8LR3h65VwlCCdhQPbFOYUBXFybX8qUj7IAeHJel
         lpPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769439983; x=1770044783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41mf+ChQ/9Ufyepg/JpP8j8QIs8IVmpuK2fawXti0w=;
        b=uMibE5iGBWfiIQt/rkwY+h5ITijzvSNHVrWFSil5qzdPQlGV+drdYc4v2Z8ZuPQRgh
         Cdm6AeGnxqb4fX5iNPcGSaRJ52u6gOwdhmJpKCNZNmGX8BOlkUmS9eeXONehbeh9BhFU
         euOlUrn0V49fQB8k2kYbB10ELqFIfqzphLsrlCLkphjiD1ZIenUGTlmGMCQq95rpt3Oy
         GyIurIuAI7UkqUFmpZU0ZMRijNwubQ0h/2rgJulx0/ijZcCCXk9wZTSgYDLWtXBrLY4d
         boOE6saNjKZC3YzBzhhXkSEiNWdEhgROKyuXOdGtxMxhuyVoEAWG9nEatwAQQYhGtrnh
         GQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769439983; x=1770044783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z41mf+ChQ/9Ufyepg/JpP8j8QIs8IVmpuK2fawXti0w=;
        b=M50yyL3aScClHtpgplus/bb1Iw6lly0hmqrv++hZEd9s2zm/AvStSx9ukoczQqgABW
         ycENhQ8LKlP66yL6udrWrEehNMaAOtYVwthaFFc3UwnF9u5+ZrtW6R3iNSU8ui7fUQe2
         90ZF3n9G6lEyuigEztzIqyC42ISS1/BQ/UbCe+5fMHoONz0AV1C5pBOhb3G612x4HFdi
         JPvnFRAYvA42rKa2DZ1eG6q0KWvS5njw1AXp1t/9z5mJaRkClXw72ef4+nue2sWoaIPt
         kSkxirwzz/kxPutkiSkYPm4l7p/NY1xngbaQFlOJIHXsMvqeFSY1LwuyHjcfE6BDnVer
         R+rg==
X-Forwarded-Encrypted: i=1; AJvYcCWlac8LvyiRZodgzW/YBzwJngTxueqHkuRG91Dnrt2u5HUqTnx9Alc0DgjKBeNbQTr0X/Ynd+Vc2fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJW1NzL+dpPVR0G4FGcy/YontMsgm/qGdEo6whXOuMhLCPtHPj
	OnGM1G9GLx78B+b/LSs3rRREUHzXy1Hlke57YepjZqcdFeVfB/rMKv5ZSkvV1uH+AEfKBxSUm9a
	VDiCudKY5+n0eOy/2vzPsERtyt20eDu8gbCg+SxXR
X-Gm-Gg: AZuq6aIBkEehmq33ZK2fZwel/rdxtw/IULYJ3ZXZAOri67eRh7GSFAMnXQ3TPLpG4ui
	2EskMifIGThByPo3bHMUw5WZkFG3199xgdEUFJRLkUly22dq+CY6nXHvyMlUhNGWICA2PUoma6N
	UaaHtArv7C7TwSFFR+baR0iAaGswB+Zfd5O+lh6licuo62u/maUjhxpE3JVIXImot6mmU7GKNS0
	oV31hLPSyVpm3zutUFRnK0FxHD4Q0TrQPUZe0KDkcE7q1f1VCFZi/ebI3oGVpr+9XbX/n0qe1r/
	2MQ5vpVGyxB6/u0xC94/ysOaXJRqQ7FUAymSiFI/X5hLcDljJ734VkzoEw==
X-Received: by 2002:a5d:5f44:0:b0:435:a48a:1239 with SMTP id
 ffacd0b85a97d-435ca14577cmr8053819f8f.14.1769439982862; Mon, 26 Jan 2026
 07:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120181152.3640314-1-gary@kernel.org> <20260120181152.3640314-4-gary@kernel.org>
 <aXcxMShqvHzYMllD@google.com> <DFYKD4MRY9BK.7O6YH0H3RHOO@kernel.org>
In-Reply-To: <DFYKD4MRY9BK.7O6YH0H3RHOO@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Jan 2026 16:06:11 +0100
X-Gm-Features: AZwV_QhdWfajSqPqBDtNF163E0Xp0jfpmiLPUwX0qTH6ZyZyU_r6RbWqp7VnRm4
Message-ID: <CAH5fLgiOMJ_6bUfhRiHorg9HkNeDknSO0bjK61wry1ZaNO0A4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpu: tyr: remove redundant `.as_ref()` for `dev_*` print
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:43=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Jan 26, 2026 at 10:17 AM CET, Alice Ryhl wrote:
> > On Tue, Jan 20, 2026 at 06:11:09PM +0000, Gary Guo wrote:
> >> From: Gary Guo <gary@garyguo.net>
> >>
> >> This is now handled by the macro itself.
> >>
> >> Signed-off-by: Gary Guo <gary@garyguo.net>
> >
> > Acked-by: Alice Ryhl <aliceryhl@google.com>
>
> Given your ACK, do you want me to take this one through driver-core for t=
his
> cycle? For the nova-core one I will wait for -rc1 to be out and take it t=
hrough
> the drm-rust tree to avoid conflicts, Tyr should be less prone to conflic=
ts
> though.

I don't mind either way, but if there are no conflicts, it would be
nice to take it off our plate now.

Alice
