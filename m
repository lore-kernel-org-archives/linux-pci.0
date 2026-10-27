Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107210;
	b=axFSpREnMQR7jtxKZGqQMv+6R8t60NdapUV1lZHnIYJJvDIZJnJZ5YVimBGIGNFQFIeY
	 bONbTA7DpgS/VlS2Kql6V/G9bBYMHdde16ChL5qYcZLJz5HcqeQn0MudMamsKUdTKl3kx
	 MJHghlLaaLqsvMbbZfdITMc4ovrW0OZyLcSluOoj5xDQC6oas1pBSS+SxRyLvYGWRPcwa
	 +ZMvNgVYhEibk8WGy6NQG04HzV1qq+Xc0or49nXn4MYILWHfvRqwvCdgSJihk7fYMxM5H
	 NQYXfwJUoJgyKXfXOJpkAm7mpS0luIeXCZgw74DLHY54E+mKeRkjsIwGQENQUm2J3OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
	b=yrbSpO00TZwaHNhy1sTLQIJadtzFdkd07DvvhbpnCbzsAklem1u3N8rnx/029Q8hMzgO
	 vLjvKqmj4wznSf6Eaj5J5U2I4oAID5BH0b18nYs4v/JQ95t+VrPnyBh236Eznfo4l2ent
	 13BBazjnsNPjraF1jGA8PV+/x8uY4+BnzXTnnIJHhr+5V8vdNBDx7tvpGkItdNnIzqFaW
	 ceZRLG6xVNazs66lY7rnqvq166575qr1sLjDV3ERQIrDiVDTeLHrM/htgyZ89Z6rad2Qc
	 Rq/3R0QCx/rD5gEMzEBOAE4rdnt2rORSRG65KBwGlKO4F93wd8cpPkOeSwVSYr//Khg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KwmXxI7Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37A606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 13:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A37A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KwmXxI7Q
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bb5afa736so652117eec.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 06:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793107209; cv=none;
        d=google.com; s=arc-20260327;
        b=lnhFaSB4XloBMUvo5h2kKCnl4sab6JiDzkflToZnogcBJ+10PpSjQG0olLh9j1wMuG
         0HwMSHGTBqwaM9KtrT4jJY9Ko1GYK9JN+GanaebUqQbuXkvIw1wrnaYZEQuOI8WnTQA8
         OABvdRbwxSr7swFE1pCvhfQOcjD4XIoRldOsIiVISsPLc9HlcrtzMEKEM1OLkKDSUFxM
         wMqqr6wRIiPtXOY+xXmtxbzpgo0ApKxkEcyp3hOiH6qY+0g3fIS/HmIafixF0OyttNnY
         N66UoK81Z1ZR/Cwb9ANIe029ofdIA0gADIaJye9J2mhipJSsi2eSBMLzp3al85uft9cj
         bOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        fh=azSiUjJf/NyZngg4c3krtpRHOOpW21kuL6Zn+6zL3ZM=;
        b=NeoKdtfcAntxohh8wj9sW6khfDH60Ff2kR90FOfolvkr3s+5XeMZ883YZlyGoB9ZxT
         6Yi+mzYewxm/HpJaP37GWCjjwlsQ5CoNU2ZeW+2l64e3xjWTZPDsJlislmI29ShWDPIo
         zK2jWXoHi8q7Eu7KeW8PXNmyKY0ZDLLG+eM8sDqeQv9H5UIvBSQdQT1k0e6cvn7wYENd
         F5zUNwGZA5X4a6KAx3RBwX3aZbLTW17coflopdZKHuSDWV7u7EiRusLEVQCkBHJtkleo
         W4d117v1Degopfeq68cN/4iRGn0GMeiCRLHZ/nZirvtbhU6g9NLtbHwxclO6CVVbq3OR
         Ox2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107209; x=1793712009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        b=KwmXxI7QR3rV0LwEuF7BShBsVedgcPi8hai8PBobx3gkqKirVpQcBTCe4X9ZHRjS8t
         M14IQzNGZsu4ZztRoW39NVUxZXvcM5bs7xFhcfttkxagYdJMJG2NmsNxEqs/yqY7YQc/
         ImZwrvRUFoNCML37bPj7ZRCT2eT6g/M0tRhDr3GbRwirXSjVr3Kr9Ia5BU98BgeZ2SkG
         epPhWGp0UIHP0ktg328MhtG183M5XggsEaNwijx6cOirBfhy9UAS2wyTCzeBzE5pCmsR
         RPjhQWPw/SH1q+rzEVMGeKdQfE5nMr/gDetewjQmFhLg1zBP+icxHKGYp81oc3aKNDiH
         YnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107209; x=1793712009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        b=shOKzopHPIhGa4TfjwTEByvjakpcCqTq/9Lmk7eB3mZAz/bCbz+9oe7DDEvTZwFo9Z
         t5YxHF+8tKdg2y/OBSjJUoNdbvI1DaWlUNzXlBPkMT7kT+QpPkIJHMRkGQcHFy42lbmM
         gN8jzf36cc4Fqed2p6uqicWMys+/V9qP5pgfZqx8BTIU4clDJxl0Cs2rg5dFbtw/naCB
         Bx9rlEEl+QQjzJ/XCGwZw3kjAQ7Qc5tgmSPpeAL6l48LvoLyDVj3steTFwBbRt52YQr0
         ORwzlg5VmVVQ/ecA6DIVsG7L15k2OfrKj5hi65dQwSwYaWpylU1lbyQxbT70SMYfoJnk
         XS7g==
X-Forwarded-Encrypted: i=1; AKwUvBx3iP/7W/AGjSoocf1vJYg6LpTXO7CTTl8t8fU7YGsNpKldZArWUNQLYGjy9FvCYMhn5X0GnOKLBXI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCEgOqoqGiuRT29/WX1wAoWg9DaigpZr06uAGfInLaRnMlO8Zp
	7xWIfs2gMB6/BE+mrnwaWeJx+4k095Fu+x+8sgAME0TqkUdA60QYwPzjfe1yeOkczqMX1Vusq+t
	yILKhn8qQQKtMkDs6zj7JoVkEEuPt50w=
X-Gm-Gg: AYBFou1qkZPkUz0++oFTXB296+/U1tAgBrABFR5lDsq8KM7ppC48IhWQEkC6HWfb6Z5
	q7TdZ7i4Bm5/5wpIs6ZxWh4og2AsOrPcjx/f1BrqXa5cKmRKrkvfB4m+SA+nC/Svo1z6Bk1UmKe
	1TmBo+WVKh+5Pf1rHEDsV8PYErwE1krUmvxNw/WGa9H+BNCCGg+8ARpk0XpwgIe+Fc1Ce7zPKgu
	QrXBXv61W/pUDeR3b84yLGcmZ/vVcLf+f2lro9izmgH44pwLEpEXvMWg4hEqFpn83DHjsT8GjPi
	UDCymwntF8gt5sH5ITGlhpupUaaGR9CxeNOvzkbzvCwS9a6HhHWJjjHo53XiI2Moe1T9cs4EhUm
	iAr2Ees1Jx/fliNoN4mGGJBfdxVqlUZ6CZfD8V4lwww7KJ/5QCH/HjYJXok0R/uaBlA3UQQmNSg
	CfcJCmxNE0o4qzQlyv+9l7Ga8NUW/pTp7CHmGGY3YAXa2oxnEWE1NK42P6r/T6e9JzDbkORHV84
	7CqUuYs5pL8M4Cm6tiJKxyminhF3hWW3b4m
X-Received: by 2002:a05:693c:8817:10b0:36a:143d:98db with SMTP id
 5a478bee46e88-36a143d9df6mr3896465eec.1.1793107209313; Tue, 27 Oct 2026
 06:20:09 -0700 (PDT)
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
 <20260928011123.450800-11-alistair.francis@wdc.com> <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
 <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
 <DM58HRC3DHSS.1YC0E53ZXANT4@nvidia.com> <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
In-Reply-To: <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Oct 2026 14:19:55 +0100
X-Gm-Features: AclHuK8O_cUPC_NV8nLehaHvClvws6tvszHDrs0qLddmTGSO7twgLKCazt9sU5Q
Message-ID: <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
To: Alistair Francis <alistair23@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	gregkh@linuxfoundation.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:19=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> That was kind of the goal with `SpdmState`. The issue is all of the
> drivers calling this (PCIe, NVMe, SATA and SCSI) are C drivers and
> won't be Rust for the foreseeable future. So there aren't any Rust
> users.
>
> I have improved things a lot with v5, let me know if you still want a
> Rust API. It just feels a bit silly to add one that will probably
> never be used.

I mean, it is true that we don't want dead code, but in general we
would also want more Rust callers in the future -- so I guess it
depends on that "probably" you mention, i.e. how likely it is. So
could you please elaborate? i.e. why is it that you don't expect
future Rust callers? Would the NVMe Rust driver want to use this
eventually if merged? (Cc'ing Andreas)

Cheers,
Miguel
