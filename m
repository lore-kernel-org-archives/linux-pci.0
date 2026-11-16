Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794873007;
	b=NmVXKCTvn0lwYrdZQBJKwBy5Q/2l1a7M34gRwMfaJlMiSBSMXmsp77N+ZQviBKz35fw1
	 DyPAoVjDi4A1xtuRbWlP+s9FftEvhK2UlnSoTiW+kD4D+TQnK/zRAWkz8J1V8FywpcnAt
	 XB0Oz1blLSsXRKwXtWdr5EhQDhE99QcXBtA3LlfiPpq4nEZaC5mivM9E8b+nefD9LtPvk
	 GEnKxB/beJWWNqNR8qdiUKw+Fv1qGp40jUFcTFoJzG9qrNf1FKyJLJenQJADeb9w1aavo
	 Tww/GxyzdgicU4rDDTbmIKMXpPQ0nXNfiL4xMsgwDs0kGR5+hkhwmNQ02vqjylQrIqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
	b=fzKJIZqhppes2P84IQgZwGGmpOSq4Xg7TkE0c5nICTNmwwqipY71gku4yAYFqUPCb4im
	 SWNFUqJfMYM3XMrIh6Z3Yz9m8Ryx6HWskg3y455runhZdrIEeuF1kuRuipo65TFLX8Xg7
	 4TZaqYINB1ZcDu4RgUhjtimzz9+omeDyIDN9b/cU90NJbeR0bUFbseKWaJJsZejVMslyZ
	 Y60k/1/3tVpdtgnvWZV0p2/Dh4RiiKcJUEVgd9OyUpJ0h+yn1qacO/WmmCRFAKGKC+t0C
	 Xc8eVvGelhhyShqzbWXkawFt5ygirWcBVbRe+COEm/kgNd2rztLtDXq60Kopg5auDUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqvemtLw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB8606A33B
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 23:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FB8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqvemtLw
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so1104648a12.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794873005; cv=none;
        d=google.com; s=arc-20260327;
        b=OUY9QjhwzbXdDgsnWT21STamZj3rdvW0rvMdZcqXPERgKWVgD5g6y0DDmQFpJYq24N
         4rOSweUmqojpvBBmzAwwnPwVDTuAdwljIve9hw/J15m4ASLqp7xO0gycmldHHPQTZp8l
         CHhhG3BCqDyT5Umgx7L1a+r0POXTyMKpMH9w9/43pzoOmIHxG2pDNwuOVHRMx+FORswf
         1v6HoviRud94HGvDsqoFAmXZCe+2fidZhTtxxbJAbt0q+YBmpbI6VKZtJsera2IZ0TPX
         CyJUuYAu158aTpP3nm9EgLhQypDVEZNGApEnojccCpQFdsaaMJV86TZ0dfUX4hlnoeNj
         8cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        fh=ON+HtOS69eRrE+GzY5WJFnYqlTkCjAIEkRk1w/g8kVs=;
        b=e+tVwvH/izD7EDGKaQblJ3r/T4BZiCFUIroOnkR2d3Fh8VD+B99x08mfsiheAlQdPp
         3TL0c6H+OF+SOZHZWXupdGFKo0lY4Lgmwoa+kxF9fv5pgFyLCm6iEn9gbDBhV0jV2OdH
         BP2wsrnRb9gyOjnU+M//TWe/U031gw6ZT7Xn+5gIiYai8nod+f+M4lRffZoVNrAXLNdB
         EsXoSfcjHIpjh6DEJ6K04EBXz4NLPI2G/g7lxRAGGArK78fQN6ZdpeEo8DemXNnVkljJ
         TQlvvn8atxTFtxEJ/3m4MJUe/j77xhFIR4IqW+p201F5LC7DcgN9wu/QaOmTY/tJmRfL
         qaQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794873005; x=1795477805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        b=pqvemtLw2O71X7r23B62BRqkqr+ryl8tzqCUbYwgOY8P9YRUtcY5noeVc0Q4rLsNBQ
         zijkKIPLCDKO8bwiCim25UesGTSY9PgIFy7BY5BexbxUgvRf4JviUfuZfwg9GXzqBt2K
         12vOGr/NdO1pwsLaG3ylr9O5p99suJ0iugumHnc1JuF8pJLItmDdUyWamNXb2XRMEg/z
         4dCCrKpaSZ2JqSVMkI3zctHREdE479RxMTlpS7La3NKrdpxrC18LucQoJEAcVlEHQgTx
         qHYkh9qIJQYZ+wruOEwWz6f+6CEzqCq6PifkKVZ2SbtA0cgN0/sgUvGuZ9HBEZgOK3Yj
         GyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873005; x=1795477805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FRS3DAvrAxtXcplP2lI1BU1rJaQlAKpU++3t87iHlU=;
        b=mL0IniERfU+ypHV16qRHIFjSOq6ZwT+N6g8ZrmSiITdLvAOLqcbEUA4+oZ7VbaXsfG
         60dGFuiz8bGOFn/ZHYxL44ml78ht5xTpid7SgLCt90Y4oVoPoYbkjudCknLcj7Cgr45m
         7YGyM4t4iEuCFqzxgfO9CxvfZv8RuRbD8UtbyjXyJqTbbGXOHktSHCOpvcCbq2itDDP4
         CGtVSogxLzdefqWL3HH+W+LQcb08frvMzu2XeOdVUIZeFpILIqfVGt/cbtlsVVmI84Om
         QpItrt7k9xRmxWfpzfRf9qGn9LXWZA9zpHFCa3NaN0wmOrhMt13uORD9K8fikOt1bIeB
         5j2g==
X-Forwarded-Encrypted: i=1; AL+hErEtDF84HnitfNr1J/nBkNndeTuh/iBLxlurR/jElcohdbPD8RPb94Kp2c+H0+00sO4EiRxFeoqdyFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sEj6WNvD9q0U1FJWWM9rPOEszyo0ydUKAN8c+eF4x2xxOM9xE
	qzRhUMD2H1t7zRmiTUSQUZngL7PgdP41beWzyE+6pvAV0BBzxxtGtbQ431CccuD0DYKSwsOQcMR
	zKVsxUntF9vdGCWwdTNM99lhqQn7Tzuw=
X-Gm-Gg: AYBFou1vGEUOg6AYAQYRr+LzWyCiBJY/Urf1FYqcePyobgXsFcKwvOno0vBnFaDoHWZ
	sqi9uzXYIxPJnSMgJB5mVhtil0YNuxOXemCCu1CuOctiCBJ9y/Is3UhIT6NbNJ7N22W/dHL8elJ
	ZGAA48mEynoNLUdyU+riwc2ieounLB6SVE9wK+wA0pBAEC1+wcE8EJ4ih1YABNOm68w4WH1ptLN
	LM9SLB8agQX8PyHQgmDzkU23kUmHE2rr1I3xzEx+JKGD/OjbaCCSb6foVK1RjILoVYKq72SaRIj
	r42Q82iMmMTRzY1psnFB1HMQAFfP/QFdSnvQNXnGkvRIgsjaYiRyN4/cCd1TCbDiI8DVDRxezbv
	aCIISMcZgfnQyunngODM5oAJ2DbWkFwz+rBzjb38MdAxFeIG11RW4Pnw/BG3TbcFoQJp0k1ve
X-Received: by 2002:a17:907:d88:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c50f320cef8mr84585466b.4.1794873005174; Mon, 16 Nov 2026
 15:50:05 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPZV9qUk3-eKOGEjVc7f0QzZcjb3L5QwUceAEUV0nuCdo90eGw@mail.gmail.com>
 <20261114235828.GF3706007@nvidia.com> <CAPZV9qUvgKjoBXGjYXJzwnCmqzSfu781ZSG8zW6Fn4PokUN2uQ@mail.gmail.com>
 <CAPZV9qUMZcwVF=CUK4LY4G6Qoqd5ykCXE5ocX8VCy_f1c6+aBw@mail.gmail.com> <20261116074022.29d96bd7@shazbot.org>
In-Reply-To: <20261116074022.29d96bd7@shazbot.org>
From: Gustavo Andrade <gustavogyn@gmail.com>
Date: Mon, 16 Nov 2026 20:49:48 -0300
X-Gm-Features: AclHuK--I7eLB9wssYrjidNqtZcmf5db4-ZbJTD49xw-7f4cTL26Jgoahe2N3Nc
Message-ID: <CAPZV9qWp8rWLkdzdQ0hJ3nsN0CQXj=7epsV9UnG-x_7PvYgMXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vfio/pci: Wait for GB202 firmware after reset
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I completely agree with you. I wasn't aware that QEMU was the proper
place for this, but I've made the change there and it is working
without any issues.

Thank you very much, Alex and Jason, for pointing me in the right direction=
.

Cheers,
Gustavo Andrade

On Mon, Nov 16, 2026 at 12:40=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Sat, 14 Nov 2026 22:47:34 -0300
> Gustavo Andrade <gustavogyn@gmail.com> wrote:
>
> > Hi Jason,
> >
> > Thanks for the feedback. I submitted this as an RFC because, while the
> > workaround solved the issue for me, it seemed unusual that only my
> > card required it, since I haven't seen recent reports of this issue.
> >
> > How would you suggest I proceed? I am currently running the latest
> > VBIOS available for my card (Palit RTX 5090 GameRock, version
> > 98.02.2E.80.10), which is also the most recent version listed in the
> > TechPowerUp database.
>
> I imagine a better shape for a quirk is a resetfn in QEMU.
>
> The fact that nova knows about this issue and has code to handle it
> suggests to me that it's only the guest initial boot and reboot, where
> the VBIOS is run before the FSP is initialized, that's causing the
> problem. We don't want to pollute every vfio-pci reset with this
> wait-for-device action (if we did, a reset_done callback would be a
> better solution) and I also don't think we want to implement a
> kernel PCI-core device specific reset.  Either of those would make the
> device behave differently in a VM, or modify the current bare metal
> behavior that's clearly expected by drivers like nova.
>
> A resetfn in QEMU can be device specific, wait for FSP to initialize,
> and not affect runtime resets where it would be the driver's
> responsibility to wait for FSP, as nova already does.  For example
> something similar to vfio_radeon_reset(), but calling the
> VFIO_DEVICE_RESET ioctl and then stalling for the FSP initialization
> to complete.  Thanks,
>
> Alex
