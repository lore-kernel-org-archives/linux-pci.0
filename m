Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792643642;
	b=F4EQLWnuhzStCVUUJZ9aADvbDrMkFLEdqbOE8IGzN4jDXCcMgD0P8WckrcAIsvCQZnrV
	 +5Wp+bHQTdmxGYWAhZcErNFFBKUIJOU8diHqEnV+XWUHPKSvZH7NxFKtU/VZbbSD5sLrU
	 Z9Mw3xb+5dS4I1drxx19hCUkhhiUjzI5MlKFIA25TChKZE3ws1tmPxcYa9so/95h9M2MO
	 aTdPOdkLGVoJqrzkduj3fypyOcnwqoiUmXKZbKVkNie56YSRIeoQL24k7xwUlGECaP0su
	 DGrliwIS5XFcKIf3NMVzqxwzWj2v5WLUA+TXG5NA0IZy/bSQmHYvGOhEVA2PA0w11TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
	b=bwZFbiQDC4C9xs2wBp6Rh5Ha2dQ0LwpnrZpv4V0aTl3qArsffEHOFy8qKmnPv6HRlJ11
	 KWKJDpfrAZRZjPVkRjEo51kk8P6Qm9loYMM6fKwnYw6NjR+h4SnemwUBuYbi07b8ApByW
	 kl1ksuoKVgDHIYYbHHCvqiPSJDPQgT8P90rIBWIMk8PfrispnU0TxlYHW1X2QdliikaCe
	 +fcLsYbYQI7Tn6yg9NfVP5VpWIc27g7s9lg2dBowbtNEDYIr3r3f5Zak6G7RhN0JiTSJH
	 F3pbsrLEILPQmDZSRN1ncvJrVUCkOAaGhqiWV8dQ0ALUaboBtoxcxFIJ/V45VF0PHVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kh4Kj3yO;
	arc=fail smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F57606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 04:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F57606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kh4Kj3yO
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so2439514a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 21:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792643641; cv=none;
        d=google.com; s=arc-20260327;
        b=RUQ5NdHjCP1RyVDOOoQA7VQoKCduAS5o8NJE+lzBCPAHNRm4wZ7HWt/Y2HRKsFByz6
         gWwkOASp/bf38xVYsA99218AYeqOUcsshrXOR0eNovRUD+SfyBbqDPlIs6tanqzqq5O3
         ue8BwINA9jHkswFhsRfCUrgKEqlVzIN7yJHretPsQABCrstI4O10LninUL/vBQU5odF4
         OBOZpZQHD4AShhVM5cY+PIP70C4CW62orITk3+MZ98VMPSK2beIr8QJoNr230YIoU/Bi
         oH+d18AYYuEk/qhZ91rqiS8f6Py7mKFNEng1Q3twisHjD09tQOcHg4tTieufbvk7o1y4
         QW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        fh=DPuJeYOpNBeQnRKj62oa6vioIvmilbbjqbNAPTdCJVY=;
        b=LGvsD2h7JQc+hAJysoWxAxAQgEAdbtZEa1LkKtCho/tBWQwNHx+Z1i6HJsCyBBkDHA
         RXRrdaOkH2Nfb7ysys8NYaHEql5E83FEOjCbwf/3sR6QLMGjixedUNxMX1RHlfZ8IYIw
         htEkt4m7yyVl6NRr9kXNqiYCgPguFq7empCk9YFdmql3YoCMHzfRko01rT9l8F69bfsJ
         RQ1LBq6MM/PAblfJY67j12Kq2Fn3ZDaz0sf6LGuQG9N8lFtBQKb1j0qaTziUu74n6can
         Q+LxINOArwoo+rU4xgYEdEALCZiv79GRye2/69SF80Fq9Vb9Ph14EaLLTlJAjgcxX+CW
         ltJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792643641; x=1793248441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        b=kh4Kj3yOXXV8CiQcn4iFy1A+6FMPrhHZk30T8qITp+G7TmFL8FUg5YYRobXac7PDFA
         TkiaFKqL4mhd4RHCf6FQzEACq2KAHTf1cnH712Uc1wB4agR0mDXXIn9WwajVCJT/8So2
         83dfzqfRpe7qzMyB2ArFshwYf/YrDWzzXjvi7pK5/yh0J5EqiP1yud4QYRjixuGuHuk7
         mBpYQYJfrR5N8gnJiyCkq+Bx3KaTlhvG2YSGeTuiKrZYfUH1vYXO7chff65aeu4YKhgL
         XKmsG318gDwJ3ALdCKg+YSBvDnFnleja+tZ20vdl3JkBUJxXgw2vaU9JfSF7AaGLqhxu
         kDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792643641; x=1793248441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        b=KT1PfYJTR5+rkfSVGVAgvPrsva+bvfGZOaB4SQL5drwZJ756n+R2uadN+TvvsQ7OS6
         HWuEsZfUxjqTdHYVarrBnXLjhLvFmPNgBrELuMfqTWgTcxOK1Uw0Kp2ywFH3pkRafwEJ
         0l5T6cRvzUNyiw2jlbEnGJxiRX6JyLHcT9rjWMRYCxd0MtJafQMyb0EBaqEu/9TowRu1
         YTWaFsVM0feWsfNsVLbCulbHZam2k3jzbGNoVTDu4rCoIeyqq5sMqYt+57HGiOyrTJ+3
         ev0lGVQbiDv2ISaez1XItByouiTSU7EAF20k20Gl/qKwkT+w8dzGEgDrJIvk6/zEeVQj
         Al+w==
X-Forwarded-Encrypted: i=1; AKwUvBwYujCkfdvFu1ae/u/wBLYWLw6no4nNUSpcU+ojmOW7OQDEXaaSXEO0qGsI40RQGtfp8yxHog0fY2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYH93B4HtFJu55AiULR+MIFCdEmAJr69yAeidmhvcW7FnRjPOA
	XhHEjUXJiQphh7bhQsFq9MP+ORSBvvj00jcQ5iTohg1yHuxzClXfL7vILacPqW6ufVSUbSMXBmx
	OgPGhxC5JEusNKVDsI249C2W8iL658Vw=
X-Gm-Gg: AYBFou3HfQEcMdIxeCIN5F3jZ7HRPYFz4KNabPWWJ7yNNVZIUDHflwow01Nwy3GEzPK
	yU7OZIFtbA8DgYwWwFVNQctF1+KTWP9zeQPOmovOtTXLJ36XyPCtUxjnSuutgqpKwjK2Ac53Ts8
	KyjXPiHw55qBInbzrY00vgnHcfjIXmuDeWbN+vMkKUN6jF/VCy1SGEfbqmzHncGRSExToNbGC/A
	ytf32Bc+K1u9LChEkWnCu009ndYZuo35C/dJo+e3rrdizOa34fuTgzQkUDI6MAM63NLI3nNG4a2
	5kN22qGoxwPL7GZuuTdQK68J444bIhf3mBTntcw5/Sfg2ixjQ432REA/mpvY69lR0R6gwSoey4+
	YSMw4nCBeV9c4FRhY4n665+Al1nja/Ro8Yk1038pvCeU8Lr/8KlL+J5Fp9s14X3t7X/k=
X-Received: by 2002:a05:6402:28c8:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6b408dcd1femr2989972a12.3.1792643640365; Wed, 21 Oct 2026
 21:34:00 -0700 (PDT)
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
 <DM596TT7E841.1U05OKY9N6I6C@nvidia.com>
In-Reply-To: <DM596TT7E841.1U05OKY9N6I6C@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Oct 2026 14:33:34 +1000
X-Gm-Features: AclHuK9U67i3MHCSs1fpGty_QgfHHhn6FdMHJ0fAOkjnn4XpsrsbQBC3WfRL_pw
Message-ID: <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	a.hindborg@kernel.org, gregkh@linuxfoundation.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:02=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Thu Oct 15, 2026 at 2:23 PM JST, Alistair Francis wrote:
> > On Thu, Oct 15, 2026 at 6:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >>
> >> On Mon, Sep 28, 2026 at 11:11:01AM +1000, alistair23@gmail.com wrote:
> >> > From: Alistair Francis <alistair.francis@wdc.com>
> >> >
> >> > Security Protocols and Data Models (SPDM) [1] is used for authentica=
tion,
> >> > attestation and key exchange. SPDM is generally used over a range of
> >> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >> >
> >> > From the kernels perspective SPDM is used to authenticate and attest=
 devices.
> >> > In this threat model a device is considered untrusted until it can b=
e verified
> >> > by the kernel and userspace using SPDM. As such SPDM data is untrust=
ed data
> >> > that can be mallicious.
> >> >
> >> > The SPDM specification is also complex, with the 1.2.1 spec being al=
most 200
> >> > pages and the 1.3.0 spec being almost 250 pages long.
> >> >
> >> > As such we have the kernel parsing untrusted responses from a comple=
x
> >> > specification, which sounds like a possible exploit vector. This is =
the type
> >> > of place where Rust excels!
> >> >
> >> > This series implements a SPDM requester in Rust.
> >>
> >> So I looked a bit at this, and here are some comments. I will not repe=
at
> >> what Alexandre has already said.
> >>
> >> First, I'd like to say that it's good to see that all wire-format
> >> parsing in lib/rspdm/validator.rs is written in completely safe Rust.
> >> That's exactly what we want to see for parsing in Rust. We want the co=
de
> >> to have basically no unsafe code whatsoever so that we really get to
> >> rely on the bullet-proof guarantees about bugs being caught at compile
> >> time, or at least at runtime.
> >>
> >> Unfortunately it looks like the same cannot be said for the state
> >> machine in lib/rspdm/state.rs, which has way too much unsafe code in i=
ts
> >> interaction with the rest of the kernel. There needs to be more
> >> intermediate Rust abstractions here. This file should not have *any*
> >> unsafe code, except maybe 1-2 blocks for using the C transport and
> >> validate function pointers.
> >
> > Yeah, it's the crypto functions. There are currently no bindings, so
> > it's just directly calling the C functions.
> >
> > Without the crypto functions it's just a single unsafe call to
> > `transport_function()` in `state.rs` and a few in `lib.rs` to handl
> > the C <-> FFI boundy.
> >
> > I was trying to avoid adding crypto and X.509 bindings in this series,
> > as that's a few more subsystems this ends up touching. We need to add
> > PQC as well, so crypto bindings are next on the todo list once this is
> > merged.
> >
> > Is this going to stall on adding crypto bindings?
>
> So without going all the way to fully-fledged crypto bindings, you will
> spare yourself and your reviewers quite a bit of pain if you at least
> implement a safe and lightweight crypto wrapper that is local to SPDM
> and could eventually grow into official crypto bindings as a future
> effort. As it is the code is very hard to review: for instance
> `crypto_free_shash` is always called after `free_desc`, and looks like
> it could/should be part of it, but that's hard to assess as the crypto
> code is mixed with the rest and called here and there. I just cannot
> tell whether all these unsafe blocks are safe of not, which is a problem
> since the goal of writing this in Rust is to prevent exploits.
>
> A self-contained crypto module exposing a safe interface would remove
> that burden, reduce the number of `unsafe` blocks, and make the series
> easier to review globally while not necessarily resulting in more code.
> You just need to store the relevant pointers into a new data structure,
> enforce the required invariants at construction time, and codify the
> actions that SPDM is already doing in the form of methods.

Oh! That is a great idea. I have added that locally and it's pretty
nice. I'll tidy it up a bit more and then send a v5

Alistair
