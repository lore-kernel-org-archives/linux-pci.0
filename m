Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE423A9850
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744698; cv=pass; b=Ag4xMTvqKuDgM9maR+9U0djzTa99thqG6B7Iy3At8tdvgXa3Srhk/a/Qv4FLOll7EUVvHx1fWBFivmnrEAjQXMpYujqD6RJNPcFcnAFrbxC1jQsD9M8sPO7iM9X9mpxBFtNXtNdgCHd5u47a6LqQF0JhWuumlrKJoewbLIDaL/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744698; c=relaxed/simple;
	bh=LL0VllKpGJK6Oj0wB6PKLca4PbGct5FNs2evBSBuSYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSr6jkLwvefbeHvG49Iu2ko2X+Qkk7l6TDrm6H5tjq4BvaMLgHPLWVH4/NIgxhurSz/3hglxBuc1cfaHSGr+G5bxt5rIz3jPJ+cHA1l/5z691lm31tdMA/tJOcbiXcQjXZZp2p8IGNbcAZsahh3OuC2WCxjxBZUhzbaPugW5XbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvCMQJ7R; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvCMQJ7R"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d5862bc921so2298385ad.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 04:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787744697; cv=none;
        d=google.com; s=arc-20260327;
        b=sg9nCNWuyHocJXOqLjRip3TmxAdmGlchLdfhntR2osXPgIOSVQzbPMt3oxtxbXUL3J
         AOkS+W4kYlNoquCFVjcBEj4RWfjTpwAM8P4K8NHHqUG6CBp/8l7IW3tXxcc3sGde0822
         GBx4GbRJX1m4XN/0324BwQOfLg7myRHyh3NCPl6v3Y3NJx0MD1k/Dn0eIcZ2BCqrus0l
         m2X82SFWyKEQYjnJz7Q8vXEQG42dA7rB1PmPsuTomSkC8SOxlweK8ejqpxEi8HsBl+EX
         BicgQ83379qJbAPAB7lIBfvUVWuBoC2nUB3vp6b2ibRG9ehI027+Uwupnj+OpwxpDtdb
         zhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LL0VllKpGJK6Oj0wB6PKLca4PbGct5FNs2evBSBuSYs=;
        fh=VmeAxsMNUrcFzLqDIAdRURNHXblDJRCYwvaZkGsI90s=;
        b=CNGJaNPHpcMyMJWBYhMINMC+Zj5sQhwU8V48YKaOyLt1RrUErPZfMq0p7fIPWCpiyy
         52Rm8DaoOdjLxEbyNycdgf+jm5LA58B1rjwZ3BbEMzdzRvkZGO4BofJj5/kGL3pW0FDX
         39vlRnuFmklyjYk9uGqUEHoUR6jG1QxrhhNAMHpn9wnCOib9a4iw1vRl3frOQHaGRb9e
         HY3hAfM60YlF9oZMbtiHrgde2fhTbgJ/imGMVpQWRD9bNiI9XYxZq/4/lUV3qD2uj/sM
         q9K80J0MWBjasigQHwVyDJPRJoA75aL8i95zsgP6tH/FigAJzJ79IJJ+gwyqFwSVArZu
         c7IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787744697; x=1788349497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LL0VllKpGJK6Oj0wB6PKLca4PbGct5FNs2evBSBuSYs=;
        b=MvCMQJ7RZoJ36ZvVoy+KhMnUcwP5b6u5NS20J6Li7LMzRsM4AKV3+ZXEdnD+IDzgbw
         ZtK0q2K0jwsTVe3lMO818TUhxCFU11+6bdZABT1U2qEO4MAl40NbEsWllagrH7PFSRG9
         8Jz/6EwkqOcmcazGkjT+f4yX+lEA+eH4vH22nmipeEcRP+4nqFpTL8Z1OeihSdIXa37D
         rNYsK8hx2ewbuOdiuPKhsZPvm+ArU+tSKM480wK//OYGgq17IOrJmJFHvQBHfV3R5ERf
         6PXcoi/Yun3s1k5KFSC9vsAL7+QctJZz0wHeWLbg9eefD62o4Wl6+IyWqJRhx0iAUMyQ
         BRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787744697; x=1788349497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LL0VllKpGJK6Oj0wB6PKLca4PbGct5FNs2evBSBuSYs=;
        b=C+s079uXD8mG/jYMiju+Lm+AvU0RV7tB+6SGsM27MiUTEeI0ME48+OlS7z4RWWX0cA
         /hhTdXuY6SEH6Swne+VEkKIEt2bNEaMn9OrWxUQFSVgTt4hc9sQW6Nynxdjowd1HbadP
         Ve8IPYLzYTd3p1qErmR1AqtCxMEP1dPuARF7nJRzyLt0zuzsIpvtvO6/mkD4h9aWmjfQ
         qL8V60otmHFp/CBch9aZ4uoudBypd3RCHCY0qW47B4H3IL+a5hHMohNz+AtaH+cJN3CS
         hwpNs2LcpByYpOzUNAH6Rgtzz18XECDC23ZTMXDHcIP7oIPZx2J+ap3hO2CyXk0Li2q7
         Fpow==
X-Forwarded-Encrypted: i=1; AHgh+RoLbAXiGgzt64vvALsrUcIVk6K8IvjO4MU29aImIns+mXJ9GjqFzUBub4vK6GczM+I7iFDD4sZrvjw=@vger.kernel.org
X-Gm-Message-State: AFuF++nRHZZdwLUxpYacgwK76FNgY9tDgAYNlz2Co/MBze04pzoeztC2
	gdFwnMthv0h1prNrkit+lr3JhZTC8y/EonrN6BGcKi+CjMZ2oeq1gxjqvPFFNsg8cjKWQgpJ7Bw
	TzDZwKClFTmFFsOFAvNglAP2vPDWVM6o=
X-Gm-Gg: AR+sD13u7I7RlDHMC68JJHaVkFa1ZSJzsRsCXcRiLgBEVJMd4EB8Qhk9xrnQQU0wNLP
	6qB0oHjd0zZAGzx1AztEl3L6Rkqi7zQhGLwmN7tU7dpRu/XaeU/BY/b75V1aBYVBb422PPzOizx
	9etXfsaiJgae+AbfoChhnlQz2PLRR91dcRD6vTBrgk/tsHNbPlNYN1jj5b7TwNW7E5GGeQUzIPp
	R+ngihJAnnQ8I1ZlsrNsPieHhOzOV0EwNjDN38bRui4Rp/kf2K+/4ydj9wljoIdCtY62XGcC6ki
	K6pVQMth8mu4uduQ3G56kcMAKC2ctYEz0TJIf3CRofAc8fv/xoBJB925zgDlJHblFYsydo+auzT
	D5d2YLxuZ5WuHu39zh2pZocbMkzQ7SGkxyBlwJ6kIUCAnaF0bSeBb6t4Ka/oD
X-Received: by 2002:a17:903:3b84:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d707b73febmr51355925ad.4.1787744696684; Wed, 26 Aug 2026
 04:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818084633.1673214-1-zhiw@nvidia.com> <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKYU6ELNN060.154BHE2QG442C@nvidia.com> <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
In-Reply-To: <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Aug 2026 13:44:42 +0200
X-Gm-Features: AcwNN1ViXIyYBwk3UCoSH1F24R1mvItcAAdRfKXUoySGlw38Kl_je3lenZCJsk0
Message-ID: <CANiq72m3pGr+sywbZ=woVnpbHW616VN2sG+RKYZWbWHAehRvvA@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 1:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> So either this should just be a regular as-cast, or we have a signed tag =
to
> share with other trees for [1] early in the cycle. Since -rc1 isn't even =
out
> yet, I'd prefer the latter.

We can also just keep the "old" interface and remove it later.

Cheers,
Miguel
