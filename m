Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57D371877
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131942; cv=pass; b=ReU7DBmf6A4jEg9znIb/VJoi5N3snVOTmU0Tco+r9UZJVdeG/jNfYrnskVUMEnpRSjXSSIW8tjhn8dOT7amHdopNCNbnq1UAaebbrX5hXvVg5FTETouTrbB8BxR4SRxErQ0Y8csko1aEvT8vMPQ5LJ52J09WEK8bmluXoYvHn1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131942; c=relaxed/simple;
	bh=pmPWg2hSflCPPDX+7vLbJrzm4G4Fz+aBq64Rqde9vGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHUFeLKAkbUhOXX0DfI6j9b9NdoyNd59PpS9xsjtst8Mdfx8FBl5j00N2MdyaGycDx8/HeV+mlpm4bwOxunblz7tQlbe92j8h2LuH0fFzlB9D+Xm3KhSWjmbk1fsklT/CeQbojx/xQX8z9fesq/HaqlFHdpj0rSXOSvLXrwJjbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mfzt3q3P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5ApiVEs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfzt3q3P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5ApiVEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786131936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zBgqb6nrWthj9k8kh2Ae5PFnKKg/EFogUj2j2erCQE=;
	b=Mfzt3q3P8ywcm0lhkuykdzBTeqHVGsRmZFfm0L0wiFzOUX1nsPxh9xthjEbKMeir84uYKS
	EZsQQjXNkIdZVbk2Ag2c/EG0SDisKNFJryFvBkNIZ/D/tYC3bTVx9+W0JanYq4PncZzA+j
	Zxs9l/oD9a4qpVgjQDFnDomQdnWZZW8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-ar4TCQpNPEie4kv6GvTMNQ-1; Fri, 07 Aug 2026 15:45:35 -0400
X-MC-Unique: ar4TCQpNPEie4kv6GvTMNQ-1
X-Mimecast-MFC-AGG-ID: ar4TCQpNPEie4kv6GvTMNQ_1786131934
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bf90475eb9so852133e0c.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 12:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131934; cv=none;
        d=google.com; s=arc-20260327;
        b=To5TnhZBNbZ6OX/m1fAJdnQd+g7v8tgDP8HHZDuIXiKvBopgASgBvnnZ2ERqsj1n0n
         h/+5D1siJnJmqYD9hFj6WzifYrgmOgGkNnuOvdfmPyQwnOajYxC7janvXRgiyTWtyb8i
         5Gs7ZZKVIdRv66QyZhvIkb/Rmxi2QDjpBdKXk+GQk7cRxVJCM5K+bInYb3mkLsZPd2Lq
         B8MngMBVQuOHiS6XkfIAiR8F4ueSWeUC4Tn/ASKuJ1DUWbcoimMEI/lhRZlYihWv+fhx
         KmBCYLg0eH3MSl/BTpx26oMIYZoReYcH9HcHCC7WnOc2aUv2RHpErJBco90RNKspcN70
         9H+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zBgqb6nrWthj9k8kh2Ae5PFnKKg/EFogUj2j2erCQE=;
        fh=Pk718vryFCGpN3W8iBKG+y6b0Rhf0kGOjj3PshUyQ64=;
        b=Vyu55SAWJZV51euTCv4Lr6VWWAjrlBKhT3rhDimgm4Hmh58BvGvVkqv/FlwY7NiXDe
         qjubQLSDcieq+92WTMYS4d7fUDIQW1tuSLn1uU9sbn/YafNg4r0USpMxNkevO5qKTbPc
         zn2CfF0lOlTnaf2q63jn17BnIEg3DTm8ZP2PhdZeSffQmA6MjMJXsRGk4a5XwBbknE5g
         mZtpMQ2a8RVXZonj5FWaT9pJt/WTDhhc8Ejr+HaNrPpXE2hyogMn2lE07G+bpMTIO+iE
         L8aWoDvAQLNAHejT++CuDxiCnBl9VE8ZwXF5N6Z8x1T8eyDRHhuaudaaUucdTUegnYzf
         aS+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786131934; x=1786736734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zBgqb6nrWthj9k8kh2Ae5PFnKKg/EFogUj2j2erCQE=;
        b=c5ApiVEs7yIglMzOvd2lEsZvpDHdBgm9Rw/Has8WsWU5LO8i3KttpB+W4QuYbq5n3G
         2R0ETxF9483ARnipV5ZV9PP873t98Q/9T/HtpVhbcdbTHCB9lapkjbPPbRFH7Vi1wbVU
         WPE25uyyYU6+b/dADP9PZQ7j4j/4bdljcYaPURBNx4adXd1aPskMfDpqv82RoFBZcgHx
         fiqKTKoOfaUIoT96R5TD8+wK50aITjuoRDgBW719QGZ+PWwQg7/GQAxxwAoEj1D4tExZ
         CML4v98w+P1ObGI/JhiaLB/qgQpQZPUyYUp6rmntbfwSt+8bXtig6wCw/pdt/tuzCFcc
         0FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131934; x=1786736734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zBgqb6nrWthj9k8kh2Ae5PFnKKg/EFogUj2j2erCQE=;
        b=VeZfZYEJm5yp377jKhiRJ9kbmVHCvAZRrEZqMEaFJc0dZiewcwY+mUWaGG8kcdhSIU
         0IMYblNDkd923pVOj7XptKnNcxbkiZxQ35e0JhYhydvDgBVz2ZJpJe/wiNnzhfw38FkA
         +Lk/LLXZXDoGVT+1jSSxEzoypG+ygW9DXurNb82GnyBqc4KsoEN49Gd6OWbURMGE4DVV
         gA59G/I0zae9F/58oDLIs4ylRdXJbmOQoOJgWWUo9G0iaUXZmV+zOfxY2LFPHIJSqY+7
         UZpBJwlC5+2VJsH/zoTmrLOF2J08311a1Zg5cTPtK/v0FmIYDU1CWktTMdwj3/b6HC+m
         w0Hg==
X-Forwarded-Encrypted: i=1; AHgh+RrJXkh9mkmuCOlS1ey6Zku5/74bG1gfUHi3DQEfBhf7VLQV4+EJUc9ohVYCta1YwLIhCe1pL5cxalA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1waw6Eyk06/JyoIdjtHiznpTEd/Q3MEYa8XWSb4N1sWfpDN+u
	H0YpMFu38tLe1LaOp5b9OFcAy3iib0rXE1iRsl81Ki3b1Z7qMkLRHUWw8/Uab8BsxjoMCGtde+S
	UFabCC1DQIsPJCZ3kJy1bdk2eKjeLHMwJEzIXvrs1dRixKsykDu1g/8tBAr+31z9iHDGJ//dnQy
	WhBlWB4e8N77OPili8K94VSUufChuspqpr2aiF
X-Gm-Gg: AR+sD13uP5Hky43Oq/HpkPzZVImyk/IbdvyXX6nPH2XhjYZ0A4AgrbGH6VaU6aq4Xyb
	EG+4S3YwG7wuoOEFKHNR+rYYV+dDJAvEXpL19JPpcz/e/tNb8kw9nBZMpSVt/2oLKHHjj46F7NB
	Aots0JuyvLHFBnt9SkW37xg5rlIt1DZEnbtiSuwfTw04KoJGxgVz1mdH8a0ubnC8IzgBQcmJB+C
	68QykzOimuSpHFRxzAlsyEPTarIvgjAKE9oPCWt4tpd70ZsyGoS0xMterkT8ktD3PkG+GbH//k=
X-Received: by 2002:a05:6102:2b85:b0:738:d6c:7104 with SMTP id ada2fe7eead31-760e3a974d8mr6638616137.0.1786131934460;
        Fri, 07 Aug 2026 12:45:34 -0700 (PDT)
X-Received: by 2002:a05:6102:2b85:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-760e3a974d8mr6638604137.0.1786131934061; Fri, 07 Aug 2026
 12:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726093200.146111-1-rihyeon8648@gmail.com> <20260726093200.146111-3-rihyeon8648@gmail.com>
In-Reply-To: <20260726093200.146111-3-rihyeon8648@gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Fri, 7 Aug 2026 15:45:21 -0400
X-Gm-Features: AUfX_myZ-4K9kmrOODaO9ni9ff4hE-GZ_6m-2C3sfG8tpP1x1tCkBNXkpSnUeWI
Message-ID: <CA+-xHTE20nzFqk+vQB=+jCz7=FiC63zMJAGtjM_nqxOuS_W_ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Free the device name on the
 pci_setup_device() error path
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	tarunsahu@google.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:32=E2=80=AFAM Rihyeon Kim <rihyeon8648@gmail.com>=
 wrote:
>
> pci_setup_device() sets the device name with dev_set_name(), which
> allocates it.  When the header type turns out to be unknown the function
> returns -EIO, and pci_scan_device() then releases the device with kfree()
> rather than put_device(), because the device has not been initialized wit=
h
> device_initialize() yet.  The name is never freed, so it is leaked.
>
> Free it there and clear the pointer, so the freed name is not left behind
> in the kobject.
>
> Yang Yingliang reported the same leak in 2022.
>
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id stri=
ng array")
> Suggested-by: Yang Yingliang <yangyingliang@huawei.com>
> Link: https://lore.kernel.org/linux-pci/20220817084444.2876059-1-yangying=
liang@huawei.com/
> Assisted-by: Claude:claude-opus-5 sparse
> Signed-off-by: Rihyeon Kim <rihyeon8648@gmail.com>
> ---
> v2: new patch, picked up from Yang Yingliang's 2022 posting as suggested =
in
>     review, with the NULL assignment added.
>
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3e6f0eb7d456..74d84093943b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2192,6 +2192,8 @@ int pci_setup_device(struct pci_dev *dev)
>         default:                                    /* unknown header */
>                 pci_err(dev, "unknown header type %02x, ignoring device\n=
",
>                         dev->hdr_type);
> +               kfree_const(dev->dev.kobj.name);
> +               dev->dev.kobj.name =3D NULL;
>                 pci_release_of_node(dev);
>                 return -EIO;
>
> --
> 2.43.0
>

A solid, simple fix.

Reviewed-by: David Jeffery <djeffery@redhat.com>

