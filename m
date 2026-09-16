Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170F49B465
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579763; cv=pass; b=K/PmKjv5S79R2cdUg3ikIij7hvt1Fu6jHsHBgpjoGhs3oUc4fjJ4PGegQREu8N2Kyezpz2U+akNa89+Hi0k14cXPj0YtlRLZSoLQVUkF9QQ7xJ7TjlNCm2dyH6j71fAHdWqhCBEHfQA+AJ90Zw8pKECaZNDWU6AtnJjVaFOVIG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579763; c=relaxed/simple;
	bh=SxMiluOD0uK5+ILAX1qVVq9oZ2A/QJmNeyQU2dGZ29c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+1//jdze/c56Dr4qW0fzhknN4v3tg+Ok2yNiEI6ARgUwYbKAdd3q/TC8bAJADK6nwVr8JgxDYpKs+d2gSPyAwrWSnoJwbIbTzSBQSB240LbQmDkrZYdr4PXM9/fP5SOuBiiUEUwhRCvgoMp1wzbGvyYFfAWkrrnl432Wsn2Wu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5sU7hQ3; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5sU7hQ3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so172869166b.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 10:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789579760; cv=none;
        d=google.com; s=arc-20260327;
        b=K4QxJIRVo/ofFGXo54EvGw/77ED9ZydMLNLcvoQuctYXrW5AtvjvpTLI6yJJV/oiNj
         52VhtHAZLufPRGET8LDyGBlRaWPclpO8Jt0xvtQDRGTqbe3PTaODQcrRjBSUN0e5Oarf
         PYDmSJUJIVvlEZlcBvMGY4UQ05urTtr4vetNl9dH64OyUEYdXMB38wfwgoCmh0vCwkt5
         Y0gBGNMxfuT1xgRDhi5as2sr4b/+UTgnRM+cuLfy8AzEEErGYyTmJMTbKqBPKY7J351G
         XVanBUAIZS+4IV9Ziq8dr/pHfmrHAlWGZawNB2Nuy/yrUQwHqEiFD/lSsu2UVIzLunTX
         GyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        fh=KixkJOwb2tT2lfYDzjzcTy0L8Ag8N3tZtZtc3IQGlWY=;
        b=rCROgzPw4zkAhYsbMD5o44m1NrQxlbep1yDeX4if6lHJhubOT0tbbXDKSvPk4cF2RV
         G7tT3JYfbtLhJDybBOc7dbKvhf3V/qF61Jy2K3KihSLc25eVKyEGxF+0N3LGblcC3gyn
         ntwaHgVkLkE92+41eypKigKN+PhORhA74q3VqUlQgUYKIaEQ9fA90y4YxDYdWEtdtI2Q
         db6mvOBKTr1Jz1H1D3NzVwQYvcxWAfvVxuTmLeLFETuCCpTh7e+kScA3XCWjfJbINy/g
         rEmismblWBjgW+p4hqE/c/hfdJY2dK0dIfoL739FgFHVq/c+bwtzT9/TDPFhQ+4cqDfu
         FsCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789579760; x=1790184560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        b=b5sU7hQ3GCD+ocTbm7CUFqMmSychwuLnFWguz1+RZbFsQl/y5MDpcVHlzcgYO9LRmL
         RqIatYKNkjEwDKwPPXokqZsxaYStOVConRKHo0U8JUApcmsEhDzupfQl/7nTuWPIPbbP
         wPZxEMhOz2eHoW6H2C5sSSjnfSvlnvIPmK0AOuQtEmrTn6f9W3ZSPblh5vp3EL7gCa3I
         sfP1FoeMbJUw31985PL3cjYAj1/gnl9LKmKW2XInqYtfEjRg3wLkK3bcCsAEJyJ0kNeg
         AHVq0lXDrFj77SZWwkfkPqG8IeMB2aI3Dk9wtEbza3c63y9jpC8ZtWwpR5VP5kFXoOI/
         bhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579760; x=1790184560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        b=C1LylENckdDe9aLUFyPsQrbe9QXsGcpCqjF7TpLuW2+Wi1HCzgNv6k83pdElyT+geL
         GAq94FpwyauW1Uy2Z88tozRtDWa76xr/SZ3bhpdYnal5JrayzmOUR54IYOYlnR46bb+O
         oKI9ER9VSGOjRwrtcy8gfdNJjIALj5V4TK/qADMT2FTtr4J03/JJ0nybwm3QJfYOLuvp
         pqesoP2xhQhE9gmdz/7eMSepRHqzH3OiDhhdSkplutEVZ2BgVIQ70lhCpVKRZAbed2Zs
         kFdlApzn276Nqo9+WUtV6GHLrXMgxpKqNPTOM9BbaGoeRYQu0oXOKAiArZVL+VQqT2uC
         j5jw==
X-Forwarded-Encrypted: i=1; AKwUvBy3/IC0pgMiA6dpsvJw8t4zQoA2eEvChk/uP9vOgYuAXWJokvDVTjUSaTqVsiuGHjxqZYz3M62q35o=@vger.kernel.org
X-Gm-Message-State: AFuF++mww03w3ROC+idblKkjyteGtxH4x0Pa8kbtm44A2T7eM41Uxxtf
	6G8KfWTLtuzSMZfF59tMSUSE2UsBaQxgbENn1hqzdKt0QNstyt+WG22lr+14fVtUYqVRzrCEylh
	4IlYbaZJDGbQTKejFIROHx5P+YH6hdqEwX4eAbobkwuHg3K8MV46w8Yd8
X-Gm-Gg: AYBFou2/kQjJO7gAMFmw9LQHI9DaDVx1eeS8Py0GsjVVDTOMuFWBhsDX/DyW12qX9M6
	88OEJyqcwFaDejKNUPHEDnyixZdl9URFdG8IZOO28Reedd++e0iUn4RNBcH2gb8E3/GTxAet//k
	7RW0ljfxOSPgW9lvaVTr7Y/nUCG/4qDrvmiq6tkp757mDOpdkG5GRgYQcmwFbM7gCRHXdROC1Ah
	jYCexfB+7osAg/FY2OCjim6d4rygHwZCLNUu/nG3GjMugDFYMvAK/SsAV5i4tee2ysOHnyZRT1s
	v4tVnUwEDCGGUR0yvPfI1OmYIfLZNoZyH2QTkotQR71hfr3oDTqpG54eANSLNY9NX6wQg3RLArF
	hn/GEVrT09EHtFy0qcDq0
X-Received: by 2002:a17:906:c114:b0:c29:52dd:317c with SMTP id
 a640c23a62f3a-c29e52ff5aamr253749566b.30.1789579759601; Wed, 16 Sep 2026
 10:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
In-Reply-To: <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 10:28:52 -0700
X-Gm-Features: AcwNN1X8OtlPLlB_fEFGTTxlBHL1RWBLk55_RIeZg7bMhopD1i4pmTuVWaDvZaI
Message-ID: <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:

> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that th=
e
> > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > as the xarray key.

> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 3781e2b5f095..8af20f558086 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >
> >   config PCI_LIVEUPDATE
> >       bool "PCI Live Update Support"
> > -     depends on PCI && LIVEUPDATE
> > +     depends on PCI && LIVEUPDATE && 64BIT
>
> One question about adding 64BIT to the dependency:
>
> As I understand it, enabling CONFIG_64BIT essentially means that we are
> building a 64-bit kernel, and a 32-bit architecture cannot normally
> enable CONFIG_64BIT.
>
> If that is the case, would depends on 64BIT be necessary here? Or is PCI
> Live Update already inherently restricted to 64-bit architectures by the
> existing LIVEUPDATE/architecture configuration, so that this dependency
> would be redundant?
>
> If this problem has already discussed, I am very sorry about this.

The necessity is that the PCI core needs to store more than 32-bits in
the unsigned long xarray key (see the snippet above). The dependency
on CONFIG_64BIT ensures that unsigned long is big enough. We could
probably remove the dependency but I would rather wait until someone
with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
before putting any effort into it.
