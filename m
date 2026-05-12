Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFA3B9D8D
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619622; cv=pass; b=f3Lod07Oh9PzZJcCovFMudunMGAM08/f0LaCxql2nSxp9e8c3lRcyfogo26hkHKmaxfSkASj5y87hrOSUdzEXNjUlXeIsXcAshLPADmnKo2L7IqehK3RKk62ogdDgbb1/LDNTMOzWD6UMr9pV/O6T5iC038IGHWkDdqm1FkKpao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619622; c=relaxed/simple;
	bh=yjcYpwM0bNWA8F+oMBSlbnJX7nZ+1khq657ozFenk1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsJ+4NTerVhrmgVx77mW/rHm9XWWj+feZzp+aZVjpm5O2Wm9sbGUUdiD4ecl7fNMXjkkF0PmpE738LMUUyfyY/zqUwEYfQquMHmgtYiiT1ggoSInTZ1DluZIr+MeSWNGriDl45OJHZq8+mlOJO9Y9jtYDq3ISxE5A1d4wYzc8lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYU5vNgn; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYU5vNgn"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1331e851faaso1460239c88.1
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 14:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619619; cv=none;
        d=google.com; s=arc-20240605;
        b=F6v5EdRAPCFW8ob1yN03uw0NQrNFMxNmVitqQ4ZnaDiO8oNw3SXnWyAGN5tUFCGXXj
         G0m3iNoo4sfVIB06ih4uA6oUq2UTRUz8IE0c7+J/SexLWcKQI8X7gT52ZRn7yituTMyc
         lal44rZ8pIT4SzLpm9JbVlDd9eEL8hh0gs7b+z4n17KqqUIeZdp5fRUchB71w4aY01ed
         MTE8vF5RLx+7RC8V/IiSdFwLULyOUtxFk/j6MUo8vdZmyyHxaARGeB2iZa/M04O0EoxS
         Apx89oxQkTl42Otc/wdzfRfbqA4DECzSjAMi8ET+e42bDm+au2d4bDVSbtU/D4F9x69j
         NtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        fh=xwYph5mYrFb3HJTafmjx5hwf5UjJiMr5yKKEM1LFasM=;
        b=Hi9RO6RqPEU7C9RZ2med7vgLh9KpLrzU2H5NuYj4ct9ltKy8IVVNsVleiQtxKZxrTU
         SyK0M1BXm7YjqwKrrRJkuPMkcHa7gnbXv07wpnaA8gchTtCydbZiJ6Hjd9p+aY0T2Gt8
         /v/hJlDVaE+L7r9MeqvKG9njR8GZ73B3y6W+yqZtPX1uls2NyjbmS62VglOy33ZfIxc0
         /vjiI/BKcBypjD61PCUVxeJvaqiIwsnJEPobO1tPrcg7AbWMY1q27iqG/OrciKdgE7Y3
         Ymm6gG8TA2zcZxQkd4OIYtISEBXcQUfpV9FvQN67tHZQK8q5SkBA5N6YZPol0BhFJ/N0
         vSow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778619619; x=1779224419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        b=KYU5vNgnDBBJPuWlxf7lFR91IHbrV8OkzR3trOdGVz4KIMAWskUuH1oyFcJQNd0DRu
         w9wrP8xMj0EL1TuFo8QxPIdL2PJ17f1TJ6tlpbG9ibsue1EWsKm6FER6163MD3rEZQ6S
         iJAACQAzV1vdNBgf3Jy/7BRVoaRtfrELpuEeQpbRdfEAi6Bf8w0RhPg4jSA+Nna7c7Ap
         ighJ8xRz8+xXr1/s0ERILzp1adkUgDz/0kgugFZc1kLMlPBW9FYVRTeGm3CoBPJDynEV
         3orwTuARevjTMKC6XyOm4eEemo8WIm4W6GukN+crwCdqN3ZWdkD9/9216JtUvUvbSv2f
         oZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619619; x=1779224419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9t69VAH4Nc1O0MVDyKt+JQMOR1DA7dJ94HBiu06W+HM=;
        b=cDEj1Y3gkpTr6mmF5TX0SYp/ti6cHs2ccHeuZDSdP5Fe4BH1Js2mV4rgz0eQUjz2CS
         kY09DPlk/zITeEbRjkd67zwESZkJ46hiz3UKCrHBpLgbcNq79+49TBJ+8gL+iv/9L5uV
         dBcCc7E/zNJF0A/GwmFiwMOYqnEcsbPwYvVgDynLrXYl6zaIBD2PDnbP/D/Rc+O8NUZB
         fX26wUiUpRHu3D3voklpeHyHbz2ZcA6p6kPKAq7/IxGqZhTVDJwdOzNnyte+RlS9Kc0s
         o2EP/RIzRh+IxlGwyePlgl31uXi/itLRC7kTENJP46IAlRBZXxJKJGcbLJ+OefZKuacq
         VUjg==
X-Forwarded-Encrypted: i=1; AFNElJ9vt/o6POeGVtNwr01vwL13Dj4J4temhgsVHj0n3Id0EhoyS5a1enHL2lJIIfQSYzOOUo2J3SmLE4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyz8B+imAbm9cHmx0QoqZ+MvJWZDOcuuSV+XPmuZMus5nq9IMD
	4I1+LiUGe/7tBem+tD5RFafpKtop6c53cUqKjQ9SYfmkdXLaQaTedNdrJGQitmAQopS9oWPOtuQ
	OK6VLSvwmXsQpRboZJZ3r0b+wPV4cPsFwYvqcP5oa
X-Gm-Gg: Acq92OEBb5DOKuqKFFX4RD5aXlgg8CFYrIADuEGRkGqALLELMa1YbFtO9FML26MkeWU
	3456q9wNayI6E1y09gMqcXXnSDOMvH8EVHtl1KqHjurMRxNuJclYRp7/4PIZXZuu0TMHYGNL3LL
	cFL+5YEhC4tw1/JuOxFsaOlEsAXBTSXR135Eb6rdjyPIRp2Cw7ezQ84ZnsshqA2/Cq+J7kv6PPN
	dsEQ5NZEPEkE/1s0/Ludo+XxQImHhoK69xWB4fWFIpMynKgQ9xkQ04wf3yhngeT3RWp+79Khy3d
	duwvflN1JxL58W3YeBM=
X-Received: by 2002:a05:7022:2394:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-1333b2d9c6bmr3134966c88.16.1778619618598; Tue, 12 May 2026
 14:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com> <20260511234802.2280368-3-vipinsh@google.com>
In-Reply-To: <20260511234802.2280368-3-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 12 May 2026 13:59:51 -0700
X-Gm-Features: AVHnY4KwNtssIpJT8BgW9ND1vjmOC-DKwSQu-Dn5zwJb7fp396v17OflLbojuVc
Message-ID: <CALzav=fR8c2tYj9jeOc_K=xoupxAfWMHmk0ipDniSXg6uGiFYA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, 
	amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:48=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index c12d614fc6c4..019de053f116 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -45,13 +45,15 @@ config VFIO_PCI_IGD
>
>  config VFIO_PCI_LIVEUPDATE
>         bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> -       depends on PCI_LIVEUPDATE
> +       depends on PCI_LIVEUPDATE && VFIO_DEVICE_CDEV
>         help
>           Support for preserving devices bound to vfio-pci across a Live
>           Update. This option should only be enabled by developers workin=
g on
>           implementing this support. Once enough support has landed in th=
e
>           kernel, this option will no longer be marked EXPERIMENTAL.
>
> +         Enabling this will disable support for VFIO PCI DMA buffer.
> +
>           If you don't know what to do here, say N.
>
>  endif
> @@ -68,7 +70,7 @@ config VFIO_PCI_ZDEV_KVM
>           To enable s390x KVM vfio-pci extensions, say Y.
>
>  config VFIO_PCI_DMABUF
> -       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> +       def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER &&=
 !VFIO_PCI_LIVEUPDATE

Why does enabling VFIO_PCI_LIVEUPDATE require disabling
VFIO_PCI_DMABUF? I saw the cover letter says "to keep things simple",
but what specific problem does this solve or simplify?
