Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667624;
	b=neT3EZs8G0nfvFseoMobwWfsWVI77rexG6++OZIGkKaMf2OGWeZ7/cH6l+Pb5+yZ6c27
	 CBX4WyzqBoohvzGxp3Gpu9fT5Jaj8Y06+yUV7SUPLISMIFZh6KAOkStMIh/LygjlERoJj
	 aBzBtQCuaB7fEEBiOUSI3i1ucUGch19wC7NA9IUOB9zIx9u/lCnUXPGDQPL2nWh4Oyovg
	 19LRK3GoWQR0PTNBy5znYbZubDJuaFWkkUt0LUEvdlFx8KosMmL3CpUUaVcc+yKSc8SCL
	 znsf7YM+Rwkrs9mozmD1j6RVdf4yCJnAPMtaQeEJXzmV0jv/frrVB92aLHoK/Uin/kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
	b=dGeXEBepDwz7k1wE5twVExBt1AL80OUuFp7PbJnmuHhTCf0VDnSLLaI92DDHl1EqNiuC
	 8d2r6JfEpbRTeld9dJPnIJlmuN7z++gFcZhnhXJgEt17Ua2g3MwUfX9ukXQkddVgW1XfE
	 Vvi+E3I2S2XJF5IQDcIO6wC/FP+iatFwqHVztMJoaxoxW+QCJQ1MUPebv/ZEbYZzWtsAW
	 vOl550HSqg4iPp6XNvSnKUcf4/Z7k5fPtMYc/2cyJrd3H408mnyLRfJahtJRsemYiUVn9
	 mh+HvWwnnx3kRdd9zhAMY6JYGnWbjMcfy4cbupZC7pgQ70c2mUxlU+R/jClfGUunPcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XzcsCzOK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DF606A31B
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 11:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3DF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XzcsCzOK
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bb5afa736so232630eec.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 04:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792667624; cv=none;
        d=google.com; s=arc-20260327;
        b=pSrBOYe86juyv5qOBMf8P+0jXyYClSHuTilg2MRFtlA31+CnTt8+z3dk8Iyt48HscG
         r4BrlFb0OvdVAAliAn2M1x3RbX8Io+PKb/4T08SxTXrbirRzIkM0ZJqwR9OKEkL0QFYs
         S3dEudpaOPpbjnOfsb0ZXqJbBwQdGmkqOQ+HLEhRbBIPZkbocXMPrFr4l09n31pneL1O
         Hg2V1L5O2rFGfJ3LcwD8eVWiY9CQ7mornwxJZ39nqDNfhdkdh4AlGjrgdgxjvRIy78/1
         Lgk6vSCgeziDYZI+LpaXAcwCv5S5FdBwYJc4LtT1soF3f1ESxYarW4QpdmL9GCbEFecn
         Bb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        fh=YzhpnEmmnTURejdp+6mFvqLjFz5v4m+UlVL4ye3w5ms=;
        b=UnpPtg74oduoKVJNUeaR7nXZWLiBDQWPXSBrLa8B2PgCRAyMPVnGLP5YPU4Z8Zcs+g
         0JdHPukaFP5wKLj/CkroJzNjPQlFIXAIAjnI2B5imwpTHehlMwCLIxzBkpKPONBmXYrX
         ASHNd8O04QQWJpkrJWcfMS1QFcsOrUPUWobJVt5PeU0Y3ip5uSy/WKOrVMoAHJnFGfry
         dpEl8dkkYN64oDY5tsXX4uprm0DkDQGwqiTeqG4R+mgNyN1Xj78qZ7ND5ODmjzVuCBNT
         +8rbpoIZ2YjNliTBbxhUOTJ0yAy52ZmjxHoG9Zu82Q6aQe5NZ8RVJvnG9K3wy6u4bDgw
         5x7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792667624; x=1793272424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        b=XzcsCzOKIM1dH7X3ne5kpMLOkyW/kS/lF37y0oepZqm1lgSq0khIYNbARTOd93oqMU
         TfXjKrpV5RZBx81RtZXBePBatu/+IAWU3v4339o0MHOYOStsXtZ1gZg+ftfhrJJ97o9X
         jqknYd4gvq1/exI/EqLx798hDLeSye599FMXrfnHhM0GvQ2yXwCcnFwSF9N9+LTzHkyh
         vFCD63AmEY3JMAQwK+XD8g1FJcFNszVqG2czhj24/nSh5TVzQtFFLGhnadtrjVjEoHGV
         b5OBD27hWUq70n97TAknRmxcqTPS8aubwZjUdzwNgjSOnK0TLvQ6uQ6EHWUf7qS8H1w3
         NK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667624; x=1793272424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        b=lls+KNnCXZXtgR2naV1DGbFmczPKRunNtxq24/DHtSo05Qcvpn738sXZTRKHAuM8XG
         G+Hdk0P6A2meeqAjnp+1Tf9j2TbdVVAbK9YKt2XwQ/UGnQAHq7bjEB0diylwTCGr65ls
         /Lqwx7yj9CWhEBsKzo4+adO0F0jXbAyyw1QywtrNdbMrymJRBmXCFBvXoBditPgkR4z7
         BegdXEiQhh2XJqVuD9Ptr+wWQIjFxR5arJxBM+Y4/W2d5ZIjH+d7uwiA2AqJ/VHS/YGi
         GbPJ8WN/W/EA1jAuDFbKAiet7ZvDG91h9DWGnI4P1543S43yCmRmJf5dzzxwdG1C0R7i
         w7+A==
X-Forwarded-Encrypted: i=1; AKwUvBzIf69IxAH/XF7WP/UFt3yfpQVNp9OeRC5xSwAYG2bpSlG0ibWVr55Brbv+O7JETrCgHpp0aw83rhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF26Mof3r6nUH3iJN/2HkAufvt6ybcvwichnj50mapsxYnhm6J
	YC5RuNNFPPSwaWBciL24NKR2EPbmMcm0H+PUQ00cEuCAOfIvwn0Uk2tYGlP5zsmdOkaTy2V0N8Y
	p5WDkfS47jN8QavHrBMl8y9Ujkz29Vd4=
X-Gm-Gg: AYBFou1PfObEtNHIkCtekCjMRNROMwn3vhGn4uVkbpQHqvtdxq9i7GNj+i4wty67yV5
	a2ymiaoIXeaEW8rbXT9tfi617rabzG2GbYKlRda2ZhDj7h9gsXoxDQa83lGkHahGuyHF38a44wo
	Iw9DbJJtaljr3AbqYR2LSy+XCwPvtTVLKwt35/Dxyc5US28nc3KBgw9ICsvEZzvjxjxUqUY2O8X
	/95peup7TN94ufnFRxU2fBdAYLCBDKRyZOnGOK2FniZa7R0lvpb0e5AaPDUGJqQlSzuGOMg5CW7
	hqZlgENLGc4QdWYlfjU6bNS9PSK8zcXc2lCRjyEIOuvzekqVoGsvzlsdR0mt2WmOPVUEivU1/uJ
	74qh/hbyhI/CEdM8jI3wlGgtoqLoWgaaJyEuFVQbaL7uzA0TT+pJEifapRTDN3UKNkKAv4+1/5T
	FpToOYYQEULxCFgPPCx6l5SnUQ3fRHdPdSptyeMomuIdAu6QAHyYb4zB0Kx23ur9F4jSpIVBudg
	Dt2OqUSwWCQc1jvv7QwT8czSc8cFOfyRRli
X-Received: by 2002:a05:693c:42d6:b0:368:5521:612f with SMTP id
 5a478bee46e88-3685522022emr5207256eec.0.1792667623553; Thu, 22 Oct 2026
 04:13:43 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <as_r8n7p_wdbChuQ@google.com> <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
 <DM596TT7E841.1U05OKY9N6I6C@nvidia.com> <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
In-Reply-To: <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Oct 2026 13:13:30 +0200
X-Gm-Features: AclHuK8IRxRyOadDqQczFV7IA6tccuepCRvhA3-QGnHUz-1woYEjtN6EKSEPPVw
Message-ID: <CANiq72kWv2HHniM3HXM=DkTbaNWSHsqfA_dKQNihfAdmA_sgnQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alistair Francis <alistair23@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, 
	linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, gary@garyguo.net, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:34=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Oh! That is a great idea. I have added that locally and it's pretty
> nice. I'll tidy it up a bit more and then send a v5

Yeah, to clarify, abstractions do not need to be complete. In fact,
they should only cover whatever you as a user need, since the kernel
does not want dead code anyway.

In general, though, we also avoid adding them locally and we involve
the subsystem maintainers etc.

Cheers,
Miguel
