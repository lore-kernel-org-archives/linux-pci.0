Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED230C61B
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767028; cv=pass; b=bZRkaEMUE/Cu/Nm0vHDxLRlkyyUAmgy/2D4mucpKiOFNfX8xBnYsXlh3z77QMEBRDJhxdDHhs4C1j5twpg93yvnnfRhQwXPGybqaX3pr2gK3eZcOdNODMyZspeh9SdcTyiKVGlT6a9g0WvZpwDDSx6ZOacPzw73Ub6F7T9IqbW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767028; c=relaxed/simple;
	bh=9GON4HqrWMN21HWEXWy1UigIACbH1qvKcO/t8RyCEB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kff32T4m8H56lT6ysJPYV8YnCGP+WbNlVN8UOqFcbkg5xrx5LU5+mogW7oLlYbQkKq6HBfbMnmhuEg5zSieWPT0KsariZaKt9DzCAWJvZn6GnJ8LtsuRR2JCGSMxIJ4NwR/GSMQIRbwMisyNphPrZ4NZUFakTMLHxwO8fRmDhBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJpfVwO8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdzkUFB7; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJpfVwO8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdzkUFB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775767026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GON4HqrWMN21HWEXWy1UigIACbH1qvKcO/t8RyCEB0=;
	b=CJpfVwO8C7Ni3xuKmN2QTWMuOxD0vTW8wg/5VvOmnzvVpHjHakksZTcW+QCEyfP+iU+gBZ
	zQZ+UQzx8MUCmeRbY1WjX0K23CtsgeLMzRn1gaQQIfFUVeGE6qrNh0BNCViUvTcX0nZ2CS
	QglY3dgMr5Eoj3hd44j8v9FqsknwZFE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-YOPbSmYEMp6VtY7PoG0rCg-1; Thu, 09 Apr 2026 16:37:04 -0400
X-MC-Unique: YOPbSmYEMp6VtY7PoG0rCg-1
X-Mimecast-MFC-AGG-ID: YOPbSmYEMp6VtY7PoG0rCg_1775767023
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38de8df0489so5764481fa.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 13:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775767023; cv=none;
        d=google.com; s=arc-20240605;
        b=OPoPps77dAeS0VSFSlR0epP+kS61+afQzB9G+dVyo6VD6iPCsYhgeICuzMQnprVzmw
         DrcfD6gA/YTi3WnjXV5bfkozcEvu661aEj6PifCWfFRrxcrFMBbD/Eh7WOsNop5X5Tn7
         3zUZAjSkY7vwRq+pfaURF2miV9xVdH1oXvz/U94LGHAdX/UB+BFHPxJtI9eTjwvWP7ob
         w+TQ7NhyBYAx8wsm+JhP6aVQX+wwRRj7MXFyNglLXfpFUMFD7cFHSMwM+W2vF2DLBJCL
         gC9RJzehYzPGpwVBxeWERHXkaYtD+N8dCIfbZ7u5Sb2TirwrOZWrv98h1p33gtpEOe7F
         wkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9GON4HqrWMN21HWEXWy1UigIACbH1qvKcO/t8RyCEB0=;
        fh=QRt1LmyggolKOzLUb3yEcSVRuIlJnGsHED3hCsKylC4=;
        b=KgiiUdgQ4hfrG3P9fT7tAGNYfa3Y8JS6jU0FptksE46OmuJA751NMqmkpELNVm7il/
         lYaGOe6wc8eqaz4RFSWE5A2BpXzYyYFe38UIGVMTITzBeDALV1ZONNieWNPb3vR3Xe6v
         CBJ5kRpXqn5dulAXCUJPin61wU+fG6TiY9/EN+FTJZgCPub/CrE2ON8yHyeFsYIk7UlD
         8UlL7JICUKCRFFEWCG9l236H/2tdDwED7rHdzWoA2MPj3H6pWQumSjTl1RQ4mwlkRH7x
         I8ZAZ8K5FPwCvaMsEVvndvF3sUp53+JKd1smCcUzygT4NNlwDP3GrpObY7Z6E9jteonV
         U/pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775767023; x=1776371823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GON4HqrWMN21HWEXWy1UigIACbH1qvKcO/t8RyCEB0=;
        b=YdzkUFB7wUFja+EhKAHF6zmTzA21H/mtWFp5DyvMtsKqktAR3DKvb/WKQvjF9ftiwy
         9bgbycl/uhHTNsESm1f7ClDwRaTz1h8YGg7cNJNnFtlcNtpHniHZ5aDOURnoX3YnbN0m
         VGCyoymORA+KN8vaZEyYs8W7Ikd49SFMQ3KhuqdpEBnubazx33ljvRUpVa9uxtkZfmEH
         XvnOxhsXhDRcL6ohiOWz5k+WNNC8IdFhiJGZ8FX0KecnSNSCt8oq53lA6gy2wsFavDA7
         0d8+269MvySqtVzHTSGVPczzsJYeEuhJiLySn5UjhCnIQtgMgNJl5D3bM3Gq60/RG8Kv
         8tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775767023; x=1776371823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GON4HqrWMN21HWEXWy1UigIACbH1qvKcO/t8RyCEB0=;
        b=H5ohvJ/UxrxmeI2T6sWmX4IG01iyR57w8Tn0+fuhboDq+L1gIz1sqSnoZge/EHxZuv
         qfWEo7zH1bFTvXgf4ZnJlAWzH/jBAD9xMK2aQVcIrFBUwpSI/bhyGHWuIwQPWveC5mqE
         NpAf3r8UMnH80C23BnG429lp/TOclkUyi7xLue2byiQInUc0+wWtYfZ5IuEchbEYucfs
         v0leMbqfxXpCT/wDfDHidpFonCulZU5eZJ1NHlGMdI/h0zMwroj2NWSEJB/izzFokddD
         8FT4l9QVywaP+H74aaM9UdhMgPzY+eBeJlKdkQxfZtGanwPJ2H/u4oMdfuhicI5tD3aE
         URNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1s4XbSAQLO7sFvIJBTRyVGu2QVzsVC+6x1lyKBYQ+qUMB4stMHp2fguo71nWzbraTKupJZSnab/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxniJeVftZs/2sgRURUgEfaxZQROJlkDzNBVVBPAZx+/UpjxO
	WMa8coyySUaJd7qAVpxnRsUZM+I406ieYg4RtPs5yeA3eky/+0rN4urrW/UrZ1y4H6mzlYR7CYY
	c7IB3kyyQZ+/67D/OEV0Jiww2gUzaTsYIoOIZGHwLER1nlroees7gfVRsKq3KHXivm0hD7G+ZdD
	BsK9dmHEWoCLqk4U+p14QTxA4KGYDRmR/dJ1I6
X-Gm-Gg: AeBDieulhWyywHnJWzbPGFBEKNdix8DgOH1m6QnUncW8YJ6Hm1FOzdgKgs+ONHMFOWx
	Ouza/8j30HhV9YdOKcCk4QEjcUHkIncTjgohlowENgKmLIWbyvwg5Vx9kFD1J8e7B2dsSK/ve3x
	3ipH9Rbo7pNYamdnDGDEckAzJvB+5jfqqDjrJWA0S4qD+VOQqF43bKWJcfnyEt6kqErRC2XHV6m
	E3u
X-Received: by 2002:a2e:b8d1:0:b0:38a:4dd3:6a48 with SMTP id 38308e7fff4ca-38e4bf6873bmr720081fa.26.1775767023274;
        Thu, 09 Apr 2026 13:37:03 -0700 (PDT)
X-Received: by 2002:a2e:b8d1:0:b0:38a:4dd3:6a48 with SMTP id
 38308e7fff4ca-38e4bf6873bmr719981fa.26.1775767022741; Thu, 09 Apr 2026
 13:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407153532.6395-1-djeffery@redhat.com> <20260407153532.6395-6-djeffery@redhat.com>
 <c5cb8cf0-9beb-4bc4-8ce6-83b4544beede@oracle.com> <CA+-xHTG9tMCCf11NZwKfvE5xvCfjXrttDXhFsyz=SCofAc9Mgw@mail.gmail.com>
 <069f3f1b-8150-41e8-a760-f85a0b1b0ce4@oracle.com> <CA+-xHTFdKaCCwkytXpWdvp6vZ4ZCh+Pp8wzkoVZYPOy--CjiSw@mail.gmail.com>
 <c9af1723-550c-4f2b-aa04-3ce769bb4a84@oracle.com>
In-Reply-To: <c9af1723-550c-4f2b-aa04-3ce769bb4a84@oracle.com>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 9 Apr 2026 16:36:50 -0400
X-Gm-Features: AQROBzCNo2zD09xUDoJkeee-Ps33E2lSudGCsUOC7vsRfjmkn3a0hz8Fbj91pfc
Message-ID: <CA+-xHTEGpmM7Kvpip1C4QjMPU8u9MoP9=bMyukEWtgwK6VdShw@mail.gmail.com>
Subject: Re: [PATCH 5/5] scsi: enable async shutdown support
To: John Garry <john.g.garry@oracle.com>
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:18=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 08/04/2026 20:35, David Jeffery wrote:
> >> Well it is not exactly like that. We have the following:
> >>
> >> scsi_sysfs_add_sdev() -> device_enable_async_suspend(&sdev->sdev_gende=
v)
> >>
> >> and
> >>
> >> scsi_sysfs_device_initialize() ->
> >> scsi_enable_async_suspend(&sdev->sdev_gendev) ->
> >> device_enable_async_suspend(&sdev->sdev_gendev) when not async
> >>
> >> Maybe similar needs to be done for this shutdown feature. AFICS, Bart,
> >> added scsi_enable_async_suspend(), so maybe he can comment.
> >>
> > My inclination is to drop adding device_enable_async_shutdown into
> > scsi_sysfs_device_initialize. The intent is for normal scsi devices,
> > and I see little value in setting the flag so early to flag partially
> > initialized or pseudo devices.
>
> That seems reasonable, but, again I am not so familiar with this async
> suspend and shutdown.
>

There also appears to be similar duplication with flagging scsi hosts
and targets for async shutdown. I'll see about consolidating those as
well.

