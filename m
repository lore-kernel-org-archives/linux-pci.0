Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F66441606
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753402; cv=pass; b=aB03Nm0XzRcv+78LsEQEJVGw9Oxx3uUSxOTizwnKnh9ThPCAswtdIIU5hkCaZ66kkZn3tmXGbGAP7xmGDPZTzbChMA1WhNPrWpOcYTHlIyb9GQC3nHdA+cp4wW3l06krjgftL8tcN4APj9S2GdKNg9aMhZKB35PnPl4lC0OZvRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753402; c=relaxed/simple;
	bh=vNabcFVQbSYbIKL2cVYsp6TxHVTpkQci7HKCA5Lwa8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7zAj4Ai3iDSRIxw8gZ45ybgP7KOUYTkvMEPDedj3FirN58I+8FF+GAbVArHvUDwdG5+tjBezY+pFPqo1+kFwlIV2xPU6QV5MvsAQZhXmeGdQW6q2EQtWaR0GO5E1EdoHfMaB5JFiM0z/FW39O48vLqL376oRfkI39qAH1Z76UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZZWodO; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZZWodO"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-462da61509eso37405fac.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787753397; cv=none;
        d=google.com; s=arc-20260327;
        b=scSqiwau1O+F6GUUFQws+ycVTeq4D9Gk0hro9yOaMwalepHa+j/7djt4v6xCiG/9Ba
         Be5UF2JmVrszU7Drvw0THeuop2IhCanQ1mFMrjMRrcUAOXnDc/vTBAadlubiSzpyh6qU
         o1JwvJTegn5U3ZyIiLpt+fZj8PcAXLzS6ErHNmD0hzQoziK/i0eW5vQzUU6J3rpujpIq
         MgAUdrf6g0T78jYfnXA6TEziOWxV8ocCskiNGyEHizceeud4htgkr9HHXjGk+pQ9ZeNK
         Q6AS8oKB9tg6ZIizuRP1r/+80TJJpdARoiRyKVHnrhC3vY//RHUMtHAbNtIKsGeAYXKl
         8FdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNabcFVQbSYbIKL2cVYsp6TxHVTpkQci7HKCA5Lwa8c=;
        fh=QhyfgJm702kjgB5WNJyx8Nv0UVazsiOID0qfVkqBRNI=;
        b=HpJU/p3EI76uNiSyWYT27tpAzQFd+vFCW+aC58IsxHoxWrVnQoPYPhx7R8LcAgfHD0
         OM8hGytvwso6nI3jfeYfVlegrevMPRgTH30UpsaCAXwKeG673HNCotPasP7CzFTTMdk6
         BXXYq7th/CYrlCKaROrzAYsP6VZsc6OwjE6xeLSILydvTbhZXOUMKyMRBlwonRVQ8ZOm
         yDC7DYjP1tx1yOZIHdT7ytq8J77gIRkFUOFGKKwDKgjaWfcylJ8P3HQr8tLxxZWkD50K
         ViQZBYJvBjXaoPYQivmnCiHaUpTb1wRV2hajs9gQglNlatHvqmTeTkrpF5E7dQkuEEXH
         2CJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787753397; x=1788358197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vNabcFVQbSYbIKL2cVYsp6TxHVTpkQci7HKCA5Lwa8c=;
        b=asZZWodOE5fYVzvlMZNhtDMVa3aCEXFQuoEWxejOeoU8A3TN/pIWBeMW7afixWwHPx
         FBIRtVg2knR3Hbvu5rZ8xIo0+4xX8BmIJMgVsnTqSTqexxWw026r2QcBWJM2npXyi8LS
         TWQDji6dAAWjxBjc6YGhGfVdHQpmMir8D6h4FibmKPuJUodjstRAvcriVym71NbCYFrR
         hQ2XiVH/Mh0LkVMVTiXkk2+9Gcki91gMEdAwfW2ScMUsx7pMqMDjdPga0Z7QJxLWrj8Q
         TikfsQ99sg86424aZ+8u46dm0S+ugzkO/Z7JK953VGsP8xARA9ruLUCgMh+2HqFWwjbq
         iW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787753397; x=1788358197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNabcFVQbSYbIKL2cVYsp6TxHVTpkQci7HKCA5Lwa8c=;
        b=QBVQPBcFAAzcRRcX0c1AGRvwdS5mhPqntz9pq30tiiGV0R8heyil/OF71rhHsWdNjj
         LuddgORLWqONXu2IVLKVwhEdNvxgroNa/JQsONpuRizFu44OB9AQK7l3at5/ghITXtQ6
         peEBk+JN1r1eQQ2Tx54lR3dV+hCVzSkkmYWVZSb1Vd2dlOM91gLX/8O14BQ2VgnnLn32
         eOA5jrGk4g34ZDbdKXc4ucyqNKmCsQ4Ah9jXEovukAZR1guq2+nZ8I4B+T3fgdWKs6HQ
         p6QQCliHV6rBFzbGtBnQOJONe4N6fJt79jhJVffmnHtEB+h+HPoeJ98TO+3P3d0ww3qN
         OOCw==
X-Forwarded-Encrypted: i=1; AHgh+RpUFNH7dEuwNJo/A1bQkDmNmQputlLqZ91iKyPEI2skdfEeCepr61XKLVD+6XErXOoAwCpKbggYX4M=@vger.kernel.org
X-Gm-Message-State: AFuF++n0VB1Nwxl3yx6XziwpDKXS0rYuONXXaNl/fAqq+Nry4nxjMoZR
	Tuu2NMyYd5ok/z7cBZq+sWpfIFOuPAGgtpF5YzcQSFBPTGNpcMpnMJo9XL//gQlBq8jw+sDZWwt
	toxrlSywS7uktR2/1nfTt/WtaZuvIBM8=
X-Gm-Gg: AR+sD11UAc8/vSx1yOVjzFdRQvOotIQqo2Ul66pPBucSfg1PgSgJlVu3Nsy81ghkqbk
	nVWPUPhvAehMbahQap7cy9SSBVTvQcXYsTldCL7urilK2sZs7BCsyeNJo5ffVat+4g0mqh7VwRg
	3CT/lu4GMZGyEAYIWEtgPVyBACvtkSxYfRujSMH8CdsXMIElQfLR/XaQzieMWOCLC4wmIUAO+rf
	CPRLrJh8bOOhHlBGpbZBbXSa3uNuMWrNZjtOC/USxjbspQQeIFspK19r3Je0a/z3Wt4bnMzn0S8
	Q2tqkj7PTibrSGaDcB3vE1D3A923yWvIlZN1vVhdQiFcI9skiStTbKpshHtOF80avlbn8McI4Mb
	nzUlTKXVMoWjo/825fxyRs3TCnJ8+pg3onMzoevvajvj0ClARbk6auQ87/iqO
X-Received: by 2002:a05:6820:4206:b0:6b1:95fb:7d3 with SMTP id
 006d021491bc7-6b1a01f7ff9mr2702848eaf.0.1787753396788; Wed, 26 Aug 2026
 07:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818084633.1673214-1-zhiw@nvidia.com> <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKYU6ELNN060.154BHE2QG442C@nvidia.com> <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
 <CANiq72m3pGr+sywbZ=woVnpbHW616VN2sG+RKYZWbWHAehRvvA@mail.gmail.com> <DKYWYZPPYZNU.32R4UV9WLNZ60@kernel.org>
In-Reply-To: <DKYWYZPPYZNU.32R4UV9WLNZ60@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Aug 2026 16:09:41 +0200
X-Gm-Features: AcwNN1UJDnIsDK3s-Xz74AoPxa-_z4dXNrN8ZtRzT0xk3LN05nkWqoC5E2b1vr8
Message-ID: <CANiq72k+-fNWZCwGuQ=FTchxgm-X-f6WR=tG=Ercn19ic1edQg@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aliceryhl@google.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, cjia@nvidia.com, smitra@nvidia.com, 
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com, 
	targupta@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Sure, that works as well. But in that case I think I'd rather have the re=
gular
> as-cast intermediately (unless your idea is to go for the full three cycl=
e dance
> of "introduce new API, convert users, remove old API").

I meant adding the new interface now instead of replacing; and then
later migrating. 2 cycles should be enough, since we don't really have
users.

Cheers,
Miguel
