Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C1A682C
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037862; cv=pass; b=ccZ0u03qJYPBclneVme1RJgrEjXep4vClmecxM/Iylpn0da2NTBbXeizM4C2WcaPDHuK3TLz7MMLqX7NATNxAuu9LJNl4Qvkwbh8Y1cFgjtEUCYcu89Vdv395rhQxa+odptGNfHran6JgKV2G/6QxznUv4gfcVpP+K3MQf9R1lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037862; c=relaxed/simple;
	bh=l5wBNlemWX0p2srbr2KMc8Dqy6ZbOGjvLXeG4h1En8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KP3AtUCZ7kTeWgcADnvy4hHfaSuWoJ9GbzQ9VCp0qYHGX6fe+S+eG1lDKAsVCmO1n5WlyovxSjOI6e3Cjqb4NIb8wInhK8DfnCVownk743RP0/Mz7tAod5arMKLpUFU9OcSLk9LKEFB5m4aurOhkBFbIkn2zyMbs+SVbCK45dQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuSP2V8L; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuSP2V8L"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso5158306a12.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 21:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792037859; cv=none;
        d=google.com; s=arc-20260327;
        b=JIixVq2DPQ7gHp2vWKPrn0ooznPENLtDBUAN8Th32qRLA2bawKyCCpdGWjM3YcqOBf
         Lhl0hYc9MC9zPfsbxDH6fJ2EnLmrEmxapksUyM6W1Vya7t93B7K743BPPNuF/1vTs+Ae
         o+xCiuli6M2ncYKlNJPQ0CIlIAjx0SWCdgWhp8n+k6pwTpiFe1mOBMnoambFegGATJGU
         gmUt3XhrNljXtwSHRLuXhwcgT4j6/QSxkL7jghiGIWSmj7ATHI9ZtFEEXbiqy1rT32eV
         TQcQ4LGMEpwzxo98RAPUwFjIPYNk0LlO6gEGH88uo5gx4aw6i/UF7k80E8WDdCdq7oHs
         P3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        fh=osWUG82CFYLiBGgX3i8SdrfORtP7aEsv9Xy4IdOWWXA=;
        b=QNSqJTmFoeqElRBzSym3vm5g8h1F33O5J3qVBVdkmn5UO+klCx8zhuZ9k01TqIRaVZ
         /txhVLZfz8S87I7TZtnafGDxzhwSTC2DtyW5jfcETzcTiZu+LH6kSJwTFr/80DCfttso
         icDzSDVrmubep9mmJsqfmz//75zFVVybMXQifAK0Z7fBE0tfRHhV9Ojts2bvVv0DzGaZ
         LWUKGo2QbZF4K2rqC8dRVXHopRrnBh2SKvWVz2Dg9kPMo5gG9Tjat88CLXktTAzG/tiR
         wvrJ7l8jsfPxz5XYsO/DpbrLkiYyBCXJV1aYGmbGq0i9XQfEaa9H8d5uDL2rOWzWX2I4
         6+AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792037859; x=1792642659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        b=FuSP2V8LUPiltHl9fyH5JNOgbMQ1RghzkgASnrgj5aSLy/AX3ATqblSIaOwzICvhOS
         XH6b0fCgEdrj3yhgCkHvrRNgT2S3T7IkGF6okBE2xgeRdVk4C+OoWdHiBwVbncNQBbdg
         KNrplc1KMHINi9/RCGK+h5QEEMeboFm+nuhndYO3+4pi2koLMZRZqwG+aXUI2wbxyBkX
         k33o5cmKQKQpnRA4DMVOmt+xzlg9WcvmuCaNNisd/pgIrLHltDKYpmRmLPo6vAZ+yPjn
         nEYKbxd5ktnd4VyM4dTQ4OaPArQQau7JLLGqJX5psKMIPzhCGT8POKmJ8r8Q4EQ2bZZq
         6DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792037859; x=1792642659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Mif+7jW3EO1r6NAyd48pdX/YR6ScEx4Ic6vaTYMoxc=;
        b=tnzk6Gs5VZKsfP/M8Zv3Ri3XtjKN1mWi78zScpP/WmYSAtJZae3b/YuXKugpJpjPjr
         8QvKIiT9HOY4RSQzDZWJfRGSqeZJxtHYUaRO3di318POr7Bc6o60vh0JrBL3Qr6a5pWp
         LTmd0kh79t94m4NibtZo+lmbEqqH+K/FoRkuZcavAioXfuL7HkCaktiDN7pXfjiFpyei
         /FZ2lYqv4Ardf8804SA0fZlaONx0m54y8W/M2YHCVCiWeTmFDICKSYxwHX/+u21JpiWd
         BmXIXltml+mepyjlrN/vVKaR7fDxG6YsOvYUT4ToQ3hRNaRhmGcihMAnjN7ZK8irwBLd
         GjAg==
X-Forwarded-Encrypted: i=1; AKwUvByAYulQJomcf2pqM+yHvSiBXHrO1KkI0VtwlMJ2EwNkYsxsXAuQL8DwAkxkD+67oN3LaitWlYvl2R4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGgIGu2oK3fbjmjVRu4Qq1P4Av1kZBx85RCncL6r4Ep7VPI0xY
	wgaaTFCVILNMNAmjTckUa3fj1LH7ftddgQ39T4BTj74jWrrfjg46Mz8bUhCQadpXlgZtAiG6Gbx
	Cqp4XtCVuvqGSpztM3Lk/xqc/jin0c3k=
X-Gm-Gg: AYBFou2t1U5iR0SQtoNkR+kp6b7A0BVzIS6RXitt5YnUmvsf2WDwb77VGwxSeH8rOke
	87i4+q6WkirVNZ70c1x/iIO5K8jEzbgSqdHVIZUVYCVDUmojpHMxA+XTDySL1O9QymmBD0mDCPi
	nEzAJTM1ALtAZTv6K02sX2VdwFvZLqvTpt3cXeM/YET/fBD2enQOcCiSnsojHYFYsCdruBkgqI2
	GFuzzznkTn0AYwhoFgssPM0tP17jyMw/rvu/NIB6lOcc1tOF8xlrYvyVh3XgSfaTiQ/SAVjYdQY
	dJMqYKjNXSSUqPtoOygHZnlkplOXeh8iIhLS51WkafjMjBtvrsay7K+z6UEhIQnivTcL8I5N0ns
	AFYno2K/NuDWUq/u7PdGG
X-Received: by 2002:a05:6402:4028:b0:6b1:c2ff:89f5 with SMTP id
 4fb4d7f45d1cf-6b1c2ffc1aemr8407700a12.42.1792037859176; Wed, 14 Oct 2026
 21:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com> <DM4NSAYZG3EW.27L8GX0Q9CV0P@nvidia.com>
In-Reply-To: <DM4NSAYZG3EW.27L8GX0Q9CV0P@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Oct 2026 14:17:11 +1000
X-Gm-Features: AclHuK92TTyKf2sa6xlCV_vbhTCWcDi-jWO21qAlHEyvl88OFTnb9FdoPdKhY64
Message-ID: <CAKmqyKMZw5MJ=NMvNOP4=_FkV8QSKN1+FRz1zgCdfjtdZY+N2w@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: lukas@wunner.de, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:16=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Hi Alistair,
>
> On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
>
> A few high-level comments/questions about this series:

Thanks for the review!

>
> - Have you tried building it with `CLIPPY=3D1` as per the checklist [1]? =
I
>   am getting dozen of Clippy warnings about unused imports, unused
>   constants, missing safety comments, and style issues. Series are
>   expected to be Clippy-clean when submitted.

I have been, but apparently running

```
CLIPPY=3D1 LLVM=3D1 make  -j32
```
doesn't trigger clippy while

```
LLVM=3D1 make CLIPPY=3D1 -j32
```

does. I have fixed the clippy issues

> - Most of the C parts have received more attention than the Rust ones so
>   far, if they are meaningful on their own can they be merged separately
>   so this series can focus on the Rust bits and the C FFI?

Not really unfortunately. A few could be pulled out and merged today,
but there isn't much movement there

> - I see many unsafe calls to C crypto functions in e.g. patch 17, these
>   will need to have their own Rust wrapper so they can be called safely.

Yeah, the crypto calls all use unsafe as there aren't bindings written.

This came up at Kangrejos and I thought the takeaway that this was ok
as a starting point. My next step is to work on PQC and crypto
bindings, but I was hoping to split it out of this series, as it's
already long and touching a few subsystems.

>
> I am not familiar with SPDM yet so I cannot comment on the
> protocol-specific parts, but I'll try to perform a review on the Rust
> bits. For this revision it won't be exhaustive as there are a few
> critical things to fix before considering the rest.

Thanks. I have fixed up your comments and have a few fixes I have
found. I'll get a v5 out soon

Alistair

>
> [1] https://rust-for-linux.com/contributing#submit-checklist-addendum
