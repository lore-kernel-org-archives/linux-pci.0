Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DD175A75
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008112; cv=pass; b=n2WWMnRQwdrvcWI/sVBArtHDntkhCNXbbyE2gFp4qSU1n6GYmpn3jrEjRL3JGinkkoZ4X/TyOiXVvPRGWxscTJiQBhAgs70vFGNvppaaUnVqpFeihPoMRRy2w6e064L+PPZu3z3b0BSu9NJ6vzks61BU1cII7VnTlxd4r9v83mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008112; c=relaxed/simple;
	bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZAYZ+GTbabYXQT3w21zPcfR2/Uu82ieQ6PwI1qZ6df62JeXD+J2/F1HwNzXrwgz7SWG4X+lA6zjK1OBmLoaK4qOlvb8EsKEFUT6AAiaUlJWJxRwdMtdoijTFxQ+Oz+rOcNfjYSt3e0A+svQKvDyyQmmjOJ1q97hJvx3ICjOegs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCgme1dX; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgme1dX"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso713701866b.3
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 18:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775008109; cv=none;
        d=google.com; s=arc-20240605;
        b=ZK+Uk8otxhvJu7y4z7+1ebOZGQSx7p9G1K4rgIeqaYDjBIQcnCD4Om/QYwsrp83rj9
         VA5N8fzkbyhLiH/u0JZHMgHXzKaC/A1VelnqDXmu72qjvFdnkYZ3DGaoB8nnNs3vXrSa
         4uW8LwZDR/gShSSAr/+s+F4vE2oF3OgE3kH/kIgbDi0zQ2jwIQQDqO8DRcAHL2Tdv4J0
         GOkjaWpMdZCBNM3Xxrts16l8Kjz4eRCH+gkORUNh7qvwD3QvKZbwXkesvr8ckRkIvZ9K
         NQXqqSQ9RjCdqTJfyd9vAs2/z6I2j5uSugxNYGpChmLE7aOcDkAP93crNSupbYFMEqH1
         jKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        fh=DS2WZYbyWL7alU0YldMaIGnyeUU1GuqtZ/NOq7N3SPQ=;
        b=fJKhzIz8BGqBjOMHotZalFUvlVm9K9EECEKfDaivBHO9Q+lmOVnR9iUNvJvOcWXkse
         L7S5RAnJ9AapOLBsUGk/Vx181UTnIUbyYrbms6MR5c9YxMbJEwGTyt2PIzsXH3ZuJBA7
         XwAM4po0urhLw2JOPLtqL2M72PMKfD9PB1gJAJunI2OskqXiyoJYOk6pJomV62n8ETyV
         6oLj17omq3mSafTOCmpPSrMCF2KUZHsnKQJG5XiDjuOIGsnclG7gtk3jNIFmttP73hbI
         IjoSkWfFUq2C60bGjGcapoKJhLMYGMN6PBfW4vOCOFrp7xetmmd8WTA96cHBQM2CSRbf
         zlpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775008109; x=1775612909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        b=ZCgme1dX9AyJySVRw0PgeaWcSiMrEGEV93Qgoxz7uOY2YLbX2EBWLzTiYaWOXSCKpk
         OWXyTz/P/97MrnWAOyqVxhMKZK9XbGfwa4HvaR9JPRv++U4FVT0MqaZx9V611Md/JMN7
         7ibtOoGaE/FQV/UsqNxcb81AsjM3wTnBRJsQ05cidHUngE8XgkX9fhSRd9+sXyVfilkl
         V1FxanHPYk62rHAWJY7kN5tMFUV8suhIZRadgvEgGf5U1MJzGr4z71UxcUzAFsB8JP5C
         cf1rhKluqfVC5KGMShgV8G3+lJnzb5+pmZZJPv2I+AzoTphrob0wZLtGQlKtHbckXm2i
         zy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775008109; x=1775612909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        b=fRAiJ+GrRZ9Rz3qCXW5IPwg2WRtaDk49VNWuwE7HsQ5jgPfokPEol+ljLTx26YuNZE
         DMACAEA2h5lJn71q1UZ1TGeYDcMezKkGRiTPvSLQ8YrlgOAVk6lJyr6DenQajxNaJtZ8
         3eC2ZEA0HENJAblKEeUzosbjyDX19HnlK698xBQhCXLzz2zv7QJjqJM3VVsu9oAU/d41
         dxoVpSFQOcDL/Ys0ibDVjEadt/6SBu3EmS04UUOIV0YwOz8dSgLL7QMjLnzDiQl8ML3p
         hLCpARc58T/mEfgx+20GHoiMzmD8UiwM/qrK+oKsTZcL3U9zupmACuwQbnSgRMHqQmu0
         sihA==
X-Forwarded-Encrypted: i=1; AJvYcCWBnh7VhCYw33rBLvgO2zzPw3ttoPlrwKARItMztB7cyTffrH1TdSAShi6dT579ypCw/l6ZekEx3ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQy3Ebmm4Cz2uJjAAm8zsZKJP3yNClrU0YIRK1/laAvfbCuZ0
	EtGpp9/z94byI7TdESNOGoeEY6QVwGBKAvP8+3Xf5kq/FZDT/OcRxU7tAqR/7bt4c+kk8BhFNFj
	FHf6+Vhx875CVzgHRidzzRimu9GrfBy0=
X-Gm-Gg: ATEYQzwL5vR/drZ0imtBIHNFFgyWITeKG5cSvlQFIpp91ZW71/EIWO2foIUwKZouLU7
	hi9Zs4czkHm1cm2exJN5GPAYXzHVTe+zT39IODmAYiqXdFOt3KvpjK7I7yh0gfc6zpZtl5mRcim
	qpuexwU0pcN5V/Nhylm4Kju+EtPRSiJsjJ7czlRJrnTE5qlEs49HdEiNmU20ziHDReUwbw+iHoq
	qi83Pl5PN+8ykGk4fUxjB5Vjtt8tphlpRMcWNQbX/jbsZtlK2BgYQ9/ULwpQktMVXzrSHnlwyGG
	3iUuqZnKLahAGrnVifYvJ8VTWKaOQSTxDqQH3Q==
X-Received: by 2002:a17:907:160f:b0:b97:98e9:1b17 with SMTP id
 a640c23a62f3a-b9c13b5bb0fmr102635666b.28.1775008108998; Tue, 31 Mar 2026
 18:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com> <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
In-Reply-To: <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 11:48:02 +1000
X-Gm-Features: AQROBzBOwFmUEqf32on5JrU8aXHIhvBHljtpfJBqW29uemU4k1ri6P4DAEIz0EI
Message-ID: <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:11=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 5:30=E2=80=AFAM Alistair Francis <alistair23@gmai=
l.com> wrote:
> >
> > Yep, same thing. My way is the Rust-y way to do it
>
> Hmm... In what way? I would say it is the other way around.

I think it's Rust-ier as it uses the fact that
 * if statements can be used as expressions, which is a cool feature of Rus=
t
 * Rust is explicit about comparisons being bools (no `if (value)` for exam=
ple)

So I find the if statement expression returning explicit bools very
Rust-y and easier to read

Alistair

>
> Clippy should be flagging this, too.
>
> Cheers,
> Miguel
