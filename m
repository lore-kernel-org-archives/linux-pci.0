Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C52153BE9
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403236; cv=pass; b=KrQLMNVG7iSDggE3YtHWQxyO7JPi7CZs/EvsRWl8dRFbdQhplugoy/8+kbHiuxXOPcoeQGSGppdN0fEcqDT+naxYCxewCTjs8dxrfaoL/kn36aNwlv283Cc9hLGB1EOv1dpyYya+yUT9M4qDrHd+PLn6oVgj/tnmm0SGfvsYPXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403236; c=relaxed/simple;
	bh=NjLFoPnv6IxbEHzHsHXAXNpdL+P4lW5tZwXEzwHN8PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl46AgRjpgd7CiJjtp2PaeGxbUycHjxfXuXN7hfCXeEBjhd3Rq8Pbxr2TR8LXnCL4DjjcXSgrNlmarczKsUv8x7f4Uby6H8UAJZHycovB+DCeMKv3S65rXdk98ZEJqlJnvkxkdAoCURt8I9krj1bDYRYtE7IBkr1aeZcjFhb6Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quP8p+UG; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quP8p+UG"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so39066966b.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 22:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776403234; cv=none;
        d=google.com; s=arc-20240605;
        b=h0jtji0h4blZWniwOb3c2dcOwi+qo/vE4SQ09jx90WJK01Kjav9PsrJhtNmNEvVkYo
         jizHdLprLVahy2mPn2PKNQDad+RFBV+9cwV7ePrCV9TGWGHcrOVs/qlnwKmboYJkcIXF
         oEgAQsquM0PtDZNOxdfQmfU/DwKmI9vQTWiADAYVKQI7/dHPm81wH+Zo//3Q8RLoMzZY
         r/LOyQAbukSXMLahBbGKMgFI0LOtQu6GSxBCAhUQxQKpRzM/2XzScmfVuU5TNkp3VhqV
         E+5SSg/C93f4XS08tOoJoL4xb83bckZFSGRnVskkn95EIdHcm0W/YxPb7t7JQlz4U3LH
         hWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        fh=pe095XqyF+Iv7Fk/83wf+RuZRUqYxaaGzBCblDkYj7w=;
        b=aqFx84wLWTKdFCyYEPejKucgk6noMTFWKGrLFRR1HCj0kQe/0zWR22M6ZVYrgDBcfY
         Q6Y1QH4rrVIo7HZjAtoBeaArJ8RY2HzXXBTh7YX9VDJznq1gupBFb/xlw3mv6y5u04Mf
         XFmPpy/a0bxgTbuNSUHrDqU2Rh7Ld+aMCQdzBb+IYEHFngPYmI3nsKe4ILa5IwvCM0mh
         pk87YpwWAybxNsSJZU08PnVy2aplXI2OgE+wgfWXKQEp+9AsQzapW66gUei/ZWfYC+I8
         1J1NyvgAW8SQ7DF57h8Vc08PzYnvYS/55WU/xA84wFwnOm8kSSW41r9r20PezPYEvyMA
         +0iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776403234; x=1777008034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        b=quP8p+UGoNjxBUuJ+KpeJnwVIK/tmzRrlTKvRqqsEhG85VEXbYpUY5Dww2y1T+BXB/
         olJ+H0/GkLfDGEagSgWL/5az4Misd/Mc4OI1aB2bVBgFDQAVIZMvQgRhaDTIfZzn8+3g
         40+YuZM3mSuhjXfBtQyl/q1a69tBTXgGYw55i+DAtRNvWYDpVDLyjvaTHHyRTX41tPlw
         7a+A9nywgI/IWoFsS/kGe1puJ1BfpaMr2pE7hatk1Q0ESbF3THUgC+wCxcR5HuImkNrH
         PYfJBpWHTQnnsJSJcjoou8p8jPaaI2lsjE3F3oJZpNnMeUZMoYyPiDo8QntBaKdiVENn
         wymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776403234; x=1777008034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dDFG+okIhe8PYZxq7+NDc2a4MEwFZQZfmQFdzqFGjE=;
        b=D3eAUPI7uLmopMmVNyiUvUsjVWrduyja68jvtm7m33+Ns0qEC9TrvyYFqKiKWm2750
         U7CymgL5E3XVZ9Kgb8AVtAWpy7l2xid76cHdbANJ3gY9RHAkGSYKCS3488CVhPXt/p5q
         X75c9FL32mdDdqRNHqREobVWF1EMx761t3GRqdCGpQ3Runm7HHjER0V9PCUUoHsFreVC
         5YMJdVMxyDSCBdLKf6R8nzlsoogS0USjYkT2a6+oDtcwXqoCdpDGD3X1mPbyryKmPyyW
         qL491mpy/LsqwpZsrFup902O9NnpFZX1sg5dLEpf7tH5WNM+pkQ6fkDQ1MSnvPHar1FQ
         Te+w==
X-Forwarded-Encrypted: i=1; AFNElJ+kZluD+46/jdwlwowu1gKOjWLf6YYmo8qnVjL3sgO6iPoXBCNT/drvRwVlZ4cYClcXTCyOIl4/Uzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNP5PZ87WvjOsf3IyV9Xp7gm5bYSrOf1x1GX8MxWdpqMM1CtG
	sHUyEYPoc56RTNaTNTAYzsrnVzHo8dE+TG2kSov2oaqfB48porfgRiM/6SZ+CYpp0xhsuX7FtGG
	rYwSs5D/8Y0DRlMjuGNZaSlssWEad+G8=
X-Gm-Gg: AeBDieuLSjOMz1WyjvLMR1ex1faz0+HmJB0cVGKev6yW+KvQglPCsYdSB8+F5yAGPSp
	XwMdJrzgq5TrgQ3HllFGY4RkPv5EtdKyl4q/oKLhnoL7nlvf3deiIGrk/Y1COxHx8R18btTXilr
	ErfCggy8bVlDTPp75Lycv+OQOj3iXcvnW1k7xyVzcgX2ag4xTxGvbgfR6NE5kBYXK/qKeu8NkLT
	sP2xr/yU99TCndtxIgRqxPqZca4BDGnB+MPjdYtnJi5dGWtepX9xABAFfWabwguu33LBk7bfWv/
	kVlTmKTFEjT0KHHQ32apLzjd64qseOFptuwu9ftN00Fq/XNI
X-Received: by 2002:a17:906:5182:20b0:b9d:1adb:fcbf with SMTP id
 a640c23a62f3a-ba41afe61a1mr47564466b.33.1776403233210; Thu, 16 Apr 2026
 22:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch> <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
 <69e19c80b892b_fe0831000@djbw-dev.notmuch> <aeG4UnyYd1FKdt1D@wunner.de>
In-Reply-To: <aeG4UnyYd1FKdt1D@wunner.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 15:20:06 +1000
X-Gm-Features: AQROBzBVB0P_lXZKhnqIa7d0_vKgMy0kgTihznkkobGfKMkBxqIBrZfKSba9-FM
Message-ID: <CAKmqyKN3nuA_uH+1o9XPrFoi7TnBY_R92SiP1srhXFdhnngd3A@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <djbw@kernel.org>, bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 2:34=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Apr 16, 2026 at 07:35:44PM -0700, Dan Williams wrote:
> > Later in the thread I proposed an alternative that instead of supportin=
g
> > 2 flavors of uapi through "authenticated", instead implement CMA as
> > another TSM driver [1].
> >
> > [1]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmu=
ch
>
> Please keep in mind though that CMA is just the PCIe adaption of SPDM,
> SPDM is not only needed for PCIe but also SCSI, ATA and possibly others
> and so implementing CMA as a TSM driver must not preclude use of SPDM
> in other subsystems.

That should be fine as the current SPDM implementation is
self-contained, but thanks for raising that.

Just to make sure I'm not going in the wrong direction, the idea would
be to build on

https://lore.kernel.org/all/20260303000207.1836586-9-dan.j.williams@intel.c=
om/

and add something like this?

```
static const struct pci_tsm_ops pci_cma_tsm_ops =3D {
    .link_ops =3D {
        .probe        =3D pci_cma_tsm_probe,
        .remove        =3D pci_cma_tsm_remove,
        .connect    =3D pci_cma_tsm_connect,
        .disconnect    =3D pci_cma_tsm_disconnect,
    },
    .refresh_evidence    =3D pci_cma_tsm_refresh,
};
```

The docs for `struct pci_tsm_ops` seem pretty TSM specific, so I just
wanted to double check before going ahead.

That means all of the netlink stuff in this series can be dropped and
we just use the TSM netlink (which might need some adjustments then,
I'll have to double check)

Alistair

>
> Thanks,
>
> Lukas
