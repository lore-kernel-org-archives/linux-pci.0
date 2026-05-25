Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7092346FC8
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716922; cv=pass; b=oeJszEwnNAJwUF0EDde425EN6UA7gqv7APiTIpUluC5KibTqtD2tkN4b6Eomjpiq+4hYnfvFmmTI6xYFQ3n4WDm1/TntyXW56+nHClLA9cwpFRL1FECEXJbAXaftK5naacV/5Y5a1gMAtZDBMY2ii6X/MkIjbboV7dDxBY/SOdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716922; c=relaxed/simple;
	bh=85tyixWPRhyVYE/wRe58MC4SnHyYAkG3RgjSss+fQEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqNkS3Sc50MiRFlPWzYFE12b54ur/peG/Yd6YFuhdynmVqrHNknsXoXl4OzBliuDtbeLPLHiIvRspJSKGLunpqCkElef/nXgSYzdLoy0vmh4qXl4weRZfcINr1jCz2fEYef7iylcHkDplecWJ5lByl9ixfAXh2phdAkjnyymszE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnrQZ9pe; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnrQZ9pe"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30436e8f582so429146eec.3
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 06:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779716920; cv=none;
        d=google.com; s=arc-20240605;
        b=fXUu3X6H4SiOn5IA+QII3VAzt9tIeN3MOK6hda3iYHRAd6OdsxDl5dmkBiO0v72ubL
         lQ5hvMSRwfcUjiu9qPbbuOPzumUHa/2IOr2u8EcQE477RPC4A8B3I1D4c1ziLmxl6ixg
         FA1yksxhmHkNfhXfDboraJDvIzTNSuyN/IFuFRfIaV1ITOcK3vC+W40vDyT+Rzmv9ESB
         AYlqzdBYV6TdrlMa4+wd8eqfWznc+aY8fji48IfBU2X667k8D+Ojp8JE7G5hg81mNe+a
         oqKYEbV0gmOJomT6GEZDeq6/54VLKyySXZihI/TrfK5qOjcgQK3eqHiUrUwmocw9Qy42
         hnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85tyixWPRhyVYE/wRe58MC4SnHyYAkG3RgjSss+fQEQ=;
        fh=E3zRt8IM4z3m1OUaaJXgz/UhyyGmdfB0L8EpOGvbS4o=;
        b=ERa4pRonLwILbF0pBmoP6D0fi1/BDWn36uGcihSL9FG5CWgEX7Gp/a+L3a7LhUduwj
         T9wEGXUrZOwy5zfpPkYxm77aIcMv7m5zfpy2ZMmAjajjKN4TswrHu295EVeOQk+/MsHa
         PaSyeq9A2iCasRAupHlGwnuDz2GLogzrEhQ/CYwpmlFJQFZCbEenTJ0adt3AOu7A87sp
         mx7VSkSgIxbCicnnN1cAYlFl2gvFR0JBBmrmkhegIH6vxvowhvPAXxBxiOA9srs1f/eN
         O49cc2UKIC2A9fdOddrv82VuKssrr74mlhkgdJIC0p0vZKkMGeUBytiYWgZo3Zlq0I6N
         Pj0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779716920; x=1780321720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85tyixWPRhyVYE/wRe58MC4SnHyYAkG3RgjSss+fQEQ=;
        b=lnrQZ9peMzw0edVCKUC3WM8EsyFq+kEvdnEjN0qKzYpZeQf2LvbBfKFnWULF/Mpjad
         7mLtyyYM0gM5lPCVHP0Wd+ueIKLRT8yM1SB8LFnhYvOkuS06y5CV3MSyQfNQkxAnnyiB
         YdRWND7mPVXsAtPwxXgUTo9NVltgI38bQljJ9UwqRExV3gBUv+gXO2tlU10lLc3Dup0o
         vVeRdOlvuUC0FJAYWjeme7QrC7JlZcQXSY7wY46eDbbQ3BF8JysfGZyM2hGzS1sTLMoP
         uT0CeBstDzfBjwMjM/WfJiuHcJ2krjaGfJY1HDMCtR356o6/xZJOSNhY8JCDdzp/ss31
         ZjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716920; x=1780321720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=85tyixWPRhyVYE/wRe58MC4SnHyYAkG3RgjSss+fQEQ=;
        b=lhN2BZSOqhkVEErWs9tM5TuIMdiHq5fJO5bDtAgg/DQTbe8Kfp0sNjLprw9dXNJ/6G
         J10VWQKupGnDLwP4vwcdqMEYhPJtLuq//zoqh85RMDHKiZuArtVSDGDprqJ6dmAOYZ7U
         1Q+F/4QiKkWokpYeyTJcjzzvKHVDai8SXgrfrajFK/Jfg2eB6M+b7DjSTligXMkaDrL6
         htgq3IgUiB+ozMZThmLruYHzXg/+SV/DxJ1T/TCV/orxAZmO8wsdb5xatYrKySKiM3/L
         189jCTZIYx1gY8aQj8tqzJ2/6iaL0LjLwDZOvZpXGmumkms60txgwaCKHKX/y8sqHFME
         zxLg==
X-Forwarded-Encrypted: i=1; AFNElJ+yhEMGDEFc5hHkTd9LSrhBUT5v3prdq1IiBvRsNaGFUdNJbmoZHjrZRBAqcmeBiYXkfsKDwhc4Z+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqu1I1V+X4D3QCcAEV4uN9DX54C7+zXd9J1/x2oUjydqONLOHB
	p2FzuhPDyjTyk0krbxrqugzgFJfWQwEa5Lg9lxhYcKEI9jELYVYA6+M2OaIlXehcCUOHbiN/RFO
	fBgZc/Ed2T37vOLYG1FReCeOA1EIJs3k=
X-Gm-Gg: Acq92OH+6mYPO47PO8gK2kp+R4//51BTLiYyd/qN27Byvnl8/muuyA9HxBuPyOpoGAh
	QeYFHXEk8C/LQUf8uqKN5D5qlF46g2PHnjY8g3lD2Dy7X3SoecLqMvT/TjWOA1OJwh2CY6BQVkn
	0sM8EpORpvcziGrJ6YPXpKxOxnVD41V8v4DgH+k2+KTTtFlRkpzu2vNEoMi3y8MOKN63Wju+kdD
	aMocw1xbxywAX61mVcwpyVVVzuA/FPSOUHFaazBM3HNcpmXCmZ6p2fogPy4C/h72yGK91mpuzWK
	hsrZXw2eEJKCAkmO/VyM2vijioAsByLq+jArKQUG488+3epWJA+GHAlD/h1aGZ2KDR+F9KDJPe/
	/v8OCsKeJ6iskR3qVOtE/xWE=
X-Received: by 2002:a05:7300:cd97:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-304490ec25bmr3233212eec.6.1779716919856; Mon, 25 May 2026
 06:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-strict-provenance-redux-v1-1-0880b65fc17c@kernel.org>
In-Reply-To: <20260522-strict-provenance-redux-v1-1-0880b65fc17c@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 May 2026 15:48:26 +0200
X-Gm-Features: AVHnY4KSxYqiTdhQ2JGDTcNoQ7xW8opRoeLvLR7fidZtFguYw_peTCo-of46_mI
Message-ID: <CANiq72kwRam1yk_w+B2n2osXLEVdofDbisBs+FYoukZ7GYNcog@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: use strict provenance APIs
To: Tamir Duberstein <tamird@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:19=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/

The linked suggestion seems to be about enabling the lints, not using
the provenance APIs (which we have been discussing for a long time).
Do we want to enable the lints after this? Or what am I missing?

In any case, some of these are not equivalent to the `as` casts, so
they are not a mechanical change. Could we have, at least for those,
the reason why it is OK to perform the change? (perhaps as separate
commits?)

Thanks for cleaning this up!

Cheers,
Miguel
