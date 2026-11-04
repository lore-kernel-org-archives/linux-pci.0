Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793772535;
	b=HYwmfjtt9U9P53XEnMxuD7SQ2vSFVHPbbFvsrPogAjPaImtji7E6pxB0UeDEg/h2pRBY
	 jzm5bp0ykN9MgpNvawc4t0znEYqBjWvww9dqTtuEPKWuHhjH80nHlCTz/Xo+wXDHZMVkj
	 EPYwxP3+JVygZEuMHizFM80dmF+KybLpmBSn28rDmfJbDUd42II1rgKHbOFyz7of4QwQ+
	 7/yVdnvn5d1kpXI56/pqQh3I4OY/tsXbzBnKheAyePZyOf/re/LESUFx8b7+foy4r8bFe
	 8IKql1dt0QRloH7C/cyR7b7QWEtyjjGAbbdhkvh6XKw4dyXn4Fct5Rjb1ms7z85GVPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
	b=NedwTOgWXIlShJtBoyD3FBBGDHmcp3RGa7wZuFwLVroUOdbt0Tw/txPWUQB8KwoWv0ZE
	 BcAupo0VY5rxkT2QjPF8c4JScVtCjOkx92pIcejdEw0JWU1vvZWHkBGwIMbicqIqd7Q3C
	 ggfqoWY39E5o30KqRzC7LA3JRKdpcylWCANcyIgt7Wjq426RKC7rvW8IxbK9cf5FnKvpB
	 InBXE3uOJWKwreVweGgFBTnrvbkxGEh1AbF42DcOosEDK5HJsq21khogyhLwJEsM7Z7au
	 m/FvmZb4dL+LO37slj9GljT9DgH2OWev9hz6fhy1WK3gfoIH/9DnPUSQ5sOiH4bNG3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLmgJ8sw;
	arc=fail smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36196606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 06:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36196606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLmgJ8sw
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so412032a12.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2026 22:08:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793772533; cv=none;
        d=google.com; s=arc-20260327;
        b=WS9gNXOttMDmap+ISLryNj9EuPYsEJRLO5YxB6/tx8SSXrYFCRwLQW8gJmNuNnQaJH
         JolKLYBKFzWrwIoCatg8510N4FSpeA+ksfArq5n4bv4Xo/0hVgTkN2S8zKYH/vEQk/Xl
         GcfvmeGzO/aiRM8CvR77F81zUtY5XQ0B6YW6KqpWdHvcAhJMQizXp1tOTuoUljagRGRH
         46NE1EdfxVoNF7Fj5TLWBfNCcE9y/3qUZj80k/UOsfPL5GDMN/BCAYgQZTjnxwooLoUA
         7v5TqSPNqGwADu4H6oyJHaLWm2fHeW+cZXmz7D/TcM1Wls62Ro0XEFMs/gPh+/l3Zmgy
         KHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        fh=eIvHNdwG1UsJd2u2uct+3PSTw9fseMEvmvzf1bPRkKs=;
        b=ac+acOUewGzZxs3VfYr8RF9heTCsNNwWEYGBQyFyRhIaoVttqhHGcYkm582RS5y4bz
         gIFIFu3v5AyCFN90WqBBz4V7a0got1EzdU9Q2rYrhxy6NgtE02h0XWIYgJYz2gTM3zjY
         y9PL0NiIrTCXYoyK2qxJFWRuUQJ95I8rkcff7BDOsYcTBRR1R4/jIYiAnsIQydN6Cn2z
         DD0plaWiGGpWKllOoEpznre8TtaB3dI54sxLH+v2vg3mE0xS7ofADQGhH0KGzz4WmGQH
         7oeTnwVsV0AMgmF4qZQJkVzmMbJmZiRAJCJwQQd3wblMUYY2gnC2/BFUToKNJjo5Tjke
         LD7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793772533; x=1794377333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        b=jLmgJ8swYkdf0IbRypo70hgc+XnzvV95AGf9zO24fj6Q0uAZt8QCX41OrrIl7c6A2Z
         noHBrpPEAOSTyghP0T/2Kjbj/BmvQoLjlltBRDKVoVhgdNNSlF+VhqVgl1nJUDF5og4P
         aiJb0wB1a5mhTv2aa/gMtoBpbaOf/F/X73AFZlMRhjPlu2T1SzzxTCoI+yy2ULhbYENe
         jo+/FZgh22tcl7RgXsGlsKiwDNuS09GVzknyMkzhxAdWeUtJ/q9ALzF7K1AKSTEppjmZ
         c9gGmrx2HDo2yxaHW1ULR6pUgL1y2x14xx0JoexDA604AurzkrJbR6d4r+Gb2yD7ASyP
         tDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793772533; x=1794377333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JA5vMLT9szW5mLfY0eUYovR/EI3W6f4OqW0QDEaEjO0=;
        b=t9d/aSpYbP9QJ0w65GPLR0btkaNHLSfsp9tvUKe9eBgaD7KyGhjbpLQwO7PISN9KEe
         SD7/BpVOSHiSEYGF6rJztP9aMBaaBQTJtGs8WkefKutyOTQahWbS0TLWTSZ/SechdSj6
         QUBidJhz2YiWugiR3GQO9EqlSpbm0XhULFEkbaYmh33n7Rd34ga1C2n0l4cbxUdeRfPq
         lmYHhUvAn+OgEnzID7p8Hxioy2FE7k8RLvrmc5uG+mXBMPNipjD8EZ8hyZvhSmNBwVy5
         RfyULyne7CYAO2ktVICn1lrx1/ylev50t0lwabfNFT7bicQ2GzjQ6zy+qwG717yBi0G1
         4caw==
X-Forwarded-Encrypted: i=1; AKwUvByRLZfTXG1GCQL8vuuMc5IRwCLqUlpa7Kjruzzh6fkom+Xbx5CyrAnaUCeXG538YOwEDe1C4DKRDRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E0svSmH/A/udxEhR5MJu0zFW7Gv/EBfY1jStr4rssjeEQ/RjV
	AyBYxGqtDMnPsk+711Jz/vK94Bc5zWnTiuQl5pOXwoiXC+JSg1+zfEeEe6kXblyGADL3sG2DZdy
	rBE6UKe+WgiGAV7B6MMGG1RVH8W7mccQ=
X-Gm-Gg: AYBFou1gZd6YZuPDigB561rLyDa29aAUMUGgLX3YUvSdKFJWnhEKy2xmxLYzQVvhP8B
	GCm1GhsyXedE+iMrb3RUR1TJxi9eB0oOLF0VQVspSUJwSiuhRtNvhMSsHD+339VSeBKatoyWnTb
	fCLGx6cY9i2so7pEy145Wa8BdG++VZlUj5WMmT8BxeC+ggzB6iLw/OQpp8hE3oy4+HfQUaFcdFJ
	okLiAJAmJ/mR8RSxFD1Usb3Jd13Hz24IwxHBpnYJWV/BCET7083l+1jXo0IMZxQbrQFRm/2vsH4
	mDKT72a5ea2CLxrtzNLY5bthHRlCGJfSW6gOPyGQ7mzYFmZ8eXMmUkauAKffIbGeThxdTmRhhhz
	8/YjuE4wMOKsdzKF32UkVwCey/zjkoU9qqT00q/1fSrzhtqlB1YiZdPHzLDi+fO8yfxq/98G0LH
	nXAuUnIpHXmKvl/Q==
X-Received: by 2002:aa7:c259:0:b0:6b4:2638:8ef7 with SMTP id
 4fb4d7f45d1cf-6b4d468226emr8448814a12.23.1793772533397; Tue, 03 Nov 2026
 22:08:53 -0800 (PST)
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
 <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com> <DMHAUFW5V16R.20XEO2QDXIGGG@nvidia.com>
In-Reply-To: <DMHAUFW5V16R.20XEO2QDXIGGG@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Nov 2026 16:08:26 +1000
X-Gm-Features: AclHuK8yY3BZ4pKP3zSAvQ1_8YS2crIm1mKvYKw4mutZUrcwZsReUT8BFmZzmzw
Message-ID: <CAKmqyKOLSAFZNNhLH7hTVuTRs0Mb17jsbrjsesDWaN7CoN5dNQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
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

On Thu, Oct 29, 2026 at 9:52=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Tue Oct 27, 2026 at 10:19 PM JST, Miguel Ojeda wrote:
> > On Tue, Oct 27, 2026 at 5:19=E2=80=AFAM Alistair Francis <alistair23@gm=
ail.com> wrote:
> >>
> >> That was kind of the goal with `SpdmState`. The issue is all of the
> >> drivers calling this (PCIe, NVMe, SATA and SCSI) are C drivers and
> >> won't be Rust for the foreseeable future. So there aren't any Rust
> >> users.
> >>
> >> I have improved things a lot with v5, let me know if you still want a
> >> Rust API. It just feels a bit silly to add one that will probably
> >> never be used.
> >
> > I mean, it is true that we don't want dead code, but in general we
> > would also want more Rust callers in the future -- so I guess it
> > depends on that "probably" you mention, i.e. how likely it is. So
> > could you please elaborate? i.e. why is it that you don't expect
> > future Rust callers? Would the NVMe Rust driver want to use this
> > eventually if merged? (Cc'ing Andreas)

You guys might have a better understanding them me.

For SPDM to work over a transport that transport needs a DMTF spec. So
right now SPDM will only work over PCIe, MCTP, NVMe/SCSI/ATA or TCP.

From my (limited) understanding of the kernel's MCTP subsystem, SPDM
isn't going to happen in the kernel. I don't think there is a need for
TCP support either.

So that just leaves us with PCIe and the storage bindings. Both PCIe
and the storage transports have old well established C support in the
kernel. So those would need a Rust implementation to use the Rust API
for SPDM.

The NVMe Rust driver could use this! But that would have to be
accepted upstream first. From my outside view I thought that was still
a ways off.

>
> Yeah the "probably never be used" part sounds a bit strong to me, unless
> there is a reason I missed for why no Rust driver would ever want to use
> SPDM.

The "probably never be used" comes from having a Rust
re-implementation of PCIe or a storage driver.

>
> Regardless of that, I think it still makes sense to have a layered API
> design where the (necessarily unsafe) C API builds on top of a safe Rust
> API that enforces the invariants and other rules you want to uphold.
> That makes the invariants that C callers need to uphold manually clear,
> and avoids having C-isms in the Rust code (like we had with the crypto
> APIs calls in v4). Not to mention my favorite: it makes things easier to
> review. :)

Ok, I'll add a Rust API then

Alistair
