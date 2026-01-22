Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4435CBA4
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046927; cv=pass; b=lO98VNSnS/D9+nKMX586MKW9+mbETpUjtkzJtPngQC6UPUXzqShLs8oJkt++gT6Sz4C1dzlTttGe6/fdHg9FwCAv30O73UUzGX9Cp2dtTTBgPY6ThiiOAkHziB9REhyQvLL1l1oz2eUc8lqVHL3OrPmR4LNV9DjmYcdh7dEJAi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046927; c=relaxed/simple;
	bh=s8Pycml9Fkd21qLtAfP+c2DxbBJNyUMd5kAPvNgICXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRx0fLUr9J8/vjT/arqzMjHJ14JXZrndtanedVqbbG4mErU9H8tG+XTq6l3/v93Yz6Ix3QYm74dGwNjUlM1gPQHpUfvGUbdbDuNmXDOaEpu+yOMG8t5x4FiUNJ/2HLqeZXoBgHB8eZIb1CiKS8F2eiGLDoi6Xg8CMAg54Qa9PhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQifqa+3; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQifqa+3"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233985e56aso30703c88.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 17:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769046923; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4FtLi4pt3SPHQLxfciKPfPXR0F66ldI1hubDE18Rpp+mhX03cih0BqIx3YXTGYw89
         iWGHaAyy5MHD23HAdh5qRMLdvYE4ZOdCfRMs5R/LyupWfdb2i7gOyzqOfB+9oTmyekNT
         Sug3A7Z32xgeL2YmcNVfioWmgkp4dlS2XyOXwKqn0umG51tuQToi28KmKGl/azSc26ae
         1uz99rqVIPweU8dOrzxHBeL85ESxlRdKQSHSdBQAV5MiuQU3picoYzTVgNUsBOuAxG1t
         dx0vu4LINlWT1Pkm+arkaME/xfYW3lNkuWOGHfDa3tCI+zxvIMZQ6iYwWG0eIDFBxYI8
         /6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s8Pycml9Fkd21qLtAfP+c2DxbBJNyUMd5kAPvNgICXY=;
        fh=7U/ABW7WawXUyqSnyOH/IYFAg74wn75cA2qklnBlO2k=;
        b=OLEcLMt6EUyr3Pqe/zTZW4LB2xE1zTT6K1ld+33SItVCUmOvbeecWzER8Zt3pbo2Xt
         F3AnxMz9d7hDmqo3Fyr4ZTIyYytoM/njWXG6AI01InAHu0/l+QY++g6OEHhRNjVuQmAf
         Kptz5wLc6taCYZPPuv1e+DcRIcO9Ucqx7v/JqXZazhmCfCHR/2UscldFDEZfnlstTCDk
         mdVl1MNRA00KHxtSkZM+IbZkmqKbmFlevNs6RVVs/8YgZ6YTBH8kinuW3+0O2dqwOVkG
         x/4O4EajruYYyS+zxdzIzfOwia620vuFxtYn20Ze+yG6J391WOW+BV+0LV8aWlWVSv9S
         eQbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769046923; x=1769651723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Pycml9Fkd21qLtAfP+c2DxbBJNyUMd5kAPvNgICXY=;
        b=IQifqa+3oPM1YDYHJws4QGeX6OavUuA86YjaoHAPNbmIz3YLnUd7Qdoujl8VmjQFqS
         GykXn4oacj8k2UzI3PFfgpfdwlNSX/XTH23BeYGO8gn5GtrxCEVW4Q9uWVqCq+WMrimm
         eulNld51C4Mws5JLzGL9nF7yJUHClXrDQROg+TlIzMHK7Z/EY/eJGCElBwhxv6VWehDp
         cH+BmzB5JtyQA51WLImjoA3s4he/SKJJm0mlPs5jJ2zCQz87+UvkN5FCPa0sBK02rGin
         9KKoonhlOiULyScovYs3Oo3lWcKfmjLm3FTK6fVF3CupF9a6v5NEW2gFeEWKNQjpp/Ep
         0F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769046923; x=1769651723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8Pycml9Fkd21qLtAfP+c2DxbBJNyUMd5kAPvNgICXY=;
        b=v1Rn39XUJWdj7akH8bBS2RxN7kQrVywVhQgpJLJW93P652XEQF+Do7DWrF3ZwWHwR0
         F0qh5/cS0Koj19y+pikxFVFLhzJEViBqxLC6KkLXCnb+dTyZSn+0agTlQccgEYf/yNp5
         Evp5hRuz4B86M1MzYFZMQ5As21f3eMYGDpIQws5rMIu5RtUiY/BgSJHqdh+g7SNXYCA6
         N9iHvuC2HUyUpbyixxGphyYOJsHYuNowOCXsi8/glbj+ShNDROdrdFyasTHi0vJaJhpF
         Pkdw2KskTCt+MGEXzKUSysDWv4HB5kIhA6dNBID0EWaSIrPAXEovQAQ8y1MBA6gm+nsD
         ed7A==
X-Forwarded-Encrypted: i=1; AJvYcCUn747iaQYHNnXmoa2olNC50QPp+Tbe3qmXeGXfopI9T6Td4INEZiw6coYkdITLTaBJ6vrmLTl05JI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DyHAijomL9OhVHrokRhgIFNXY7qWYTfM6MRxuZ5NDdkg1Q7B
	7X680eP+nq/qHV5pG3KrBjlQ7pA+Nrz0HNgTKibgod8BaaaTLp59o8j5r7n2rxKUHl7M/xprkCC
	p406OgVGSY5nDG0zij1doZigOx5uJmDo=
X-Gm-Gg: AZuq6aJIJqA/cFSQAEBqKPI947Edk+fI5sg4uC+si4i63ZYGDLWTimDBtsEa70OR58e
	RORrGQDYnAMaITNoUio2B9fOAKiCkwoBjlhUK9gNJz9Ij3LUDZB0jq+s8WWtuPvdjVziKjjXrtF
	hs9ZJQ/srlvaD5CAzCtViQA5K+ytZLPBgvxIZil2pogeqqN1IKA3qSWOQ1iIoTBsvUjdEacKnoV
	oN2b3WPXrZhpLn7a+ff9zceAevLUqQnQ6stkOOc9jWbWzOzGmx7XdSGUXLN9JyVLChrFsXNXXwN
	t2FgShi+7M74rainwMo/TDFrcDuM8hjWR0WVqxfoBvP/AFy6V0mVYKeAS7i7/SDgafqM3DZ+HSN
	uqOf9eV7wcF+u
X-Received: by 2002:a05:693c:408a:b0:2b7:1008:9f2e with SMTP id
 5a478bee46e88-2b710089fb4mr1341069eec.7.1769046923537; Wed, 21 Jan 2026
 17:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119202250.870588-1-zhiw@nvidia.com> <20260119202250.870588-2-zhiw@nvidia.com>
 <CANiq72kL9xwT-wdyGNpekmnXioUhwLjcayE_pkmKEEw+RDCyrg@mail.gmail.com> <20260121112929.5497b997.zhiw@nvidia.com>
In-Reply-To: <20260121112929.5497b997.zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Jan 2026 02:55:11 +0100
X-Gm-Features: AZwV_QhekQs9-amcH8X6hMqIMkD3M0IVxuBxjjtGtTw-9JU2gW3bh3jYidNYBz0
Message-ID: <CANiq72kz9a=Hx_tWLpSmmQ82MzO98V8-i+91qSutJvgKU+d-kQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:30=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> Sure.I am trying to Cc folks who comments in the patch for crediting
> their efforts. :)

Ah, I see, thanks.

As far as I understand the docs, Cc: is intended to document in the
commit message that someone had the chance to discuss the patch.

I can see that, if someone gave feedback in a previous version, then
it is a way to say that they had the chance to review the new version,
so that makes sense. Having said that, if we did systematically that,
the list of explicit Cc's would grow quite a bit...

Personally, I always understood the tag as meant for key stakeholders
that you really want to explicitly mention in the commit message as
having been involved (and that didn't otherwise give another tag at
the end of the process), versus everyone else that is Cc as usual in
the email headers.

But I have seen it used in different ways in the kernel... :)

Cheers,
Miguel
