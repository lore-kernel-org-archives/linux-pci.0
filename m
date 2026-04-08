Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EE2DAFCB
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657811; cv=pass; b=l1nFec2kZOIb5K6dBJ7uTbshJ0GJqW8PG65jy3Sn5p5tahulvxQkLyg1wq0j9ZbW4RB1yYx9/ASyEzeaVK5mNTTM8aT1V0+IN0pY01iMJi395YsYYZfBXwioDqSdNL9gdUj7NRaTRF0q/MN/pfIW9H38wy8Bz7nn/png3uaDsKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657811; c=relaxed/simple;
	bh=BL7bjnfiDc+oze86Z5+hb/JdSfgy0dPrHiccC1cL4co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGrv/5GFJRjWqmNXd/9yIWtwoHGoJWy+qqIpKM4eDwFBplwD8EJyPpAnJOVz9bGhZC4CnNfk06/XenmLHigjFrjTD2goEolZDCi60JeLBut+PwoZ0ehbDXPdM1I/2mKszMVTJGKWtH5pUrPjtS640RXrLzNC7hUARx9OtAzFlMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Veu55jsl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSC01FxP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Veu55jsl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSC01FxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775657809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RG7NMZgM415BV6Epnr7PY+Cg4TeSFTKlU8/eVWcZm8c=;
	b=Veu55jslWZYxOimOUUxPswlkXIQu31vCZsVfTO3IGpkJfvtjAnrLLSW7T+zKKMCmGYF151
	mexntM7vGN7SAxFlia3ME2XyA44P9IStUWSIw6U7a2BcFkRIf6RNYq2polU6IvjV58GGSV
	NbP/FTrag1bherMAvlIV9rO1JszuDfI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-K6KgyrbhNyKmOw3opMq-4Q-1; Wed, 08 Apr 2026 10:16:48 -0400
X-MC-Unique: K6KgyrbhNyKmOw3opMq-4Q-1
X-Mimecast-MFC-AGG-ID: K6KgyrbhNyKmOw3opMq-4Q_1775657807
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38df95ce2e9so20591371fa.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 07:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775657806; cv=none;
        d=google.com; s=arc-20240605;
        b=W5ub5p68Lr83zD0WXz6BQVs+07do0bvUBcaNdtMcKDu0hhuUc74GzeQGBjBbZQj9Gw
         HJn001xR26j0g+jyl/mCE7+O3TjyXF/AqQy/WbrsbpEY/PeoDQhYXImKLl1/q2tTq9N/
         Ft+GP7ov1H/ohImm/DAOd72ksnILHG5QFpG8Gghhv11v0FJuXaNmJ8JoRgxsnf7sKhbK
         Idp3itPsSB2JSpq+ksoqtwOwkEuwWzs2chYmONreTY26NVilrBTbivRVvM58dga1MAvg
         tx8SDHnvAEYSUq9/EENEw+E39JNj/ZVWZ7fRn2QtfU0LDc5OZcsQhYOJBxGdPu1yEGBK
         Gjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RG7NMZgM415BV6Epnr7PY+Cg4TeSFTKlU8/eVWcZm8c=;
        fh=Hg06pEUhJ4h7hAyYoCEprx799XfzzMfJPdNFp3YS0+c=;
        b=i04MdoNFd7SEjBoxmYE8N3ZYTE49QZPZ2r/WVsslZyIC0SFAqlnpqPGY7nHPgZIatp
         TCf7dt/KezMWeTXc+AHaT3hgF0902QCP5pAtUEJ0p46eKPh5CeRIRiKgsadQEOlTVN3v
         hz9NvKG30teWyNxbi+iQ5DL5fMxRS5GMjdn/UkU3lBnfR7+hwJ44oqKJbc+kGyPlQxuE
         KMvlrCao8LhXubCXP+kan7QOqKQZNRlpSqvOhVWPg176qRcCuGPJY4vJAXYwCx151mLH
         Or5Yjs192nD41cLTMJ/6cGTIC2dz4L1Lj8/vaO8pZXrklG2mI1slSnINiyvSFjz9OtaO
         jboQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775657806; x=1776262606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG7NMZgM415BV6Epnr7PY+Cg4TeSFTKlU8/eVWcZm8c=;
        b=MSC01FxPsLEDBiSavjUhUePJ8HLNBVHaiCMDKZWJ0tEyWso9U4pMZpRQmpHsc888UF
         pW7Zfo6vl3wtAC3mFD0Ua2Y+oTOTQ2nlkAx7Zrg4TuJFsINTUheckFfkC9AI2EisZYU3
         wKbNpd5pdCVBZYumk4EyKVFwCVxYYCpx+u7GKLh8jXeGRhEtb44Lmv6rgIgob551eewi
         7gmGEgmelplueIXCmg/4qs7noPCpfELZ4tBWOWwYQZ4/vlrrB3OJty1JG20HfWXk3ePg
         sOX746Hie80u9bgQYYspJjSVaYd1pzWYREqCCAGW4jQFez0hh46+KoFf0ZWJpgarnFNe
         8Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775657806; x=1776262606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG7NMZgM415BV6Epnr7PY+Cg4TeSFTKlU8/eVWcZm8c=;
        b=NTu9Ogi37NsA5znxVYH5klrzyg9vHOgS0L5XUPjlcWogP+LHY+PqJRvqqw0+tx/ovA
         4aZiMry7abuDar7j9CPqu560BJ56D6cp5nygLMKl5e167zmqm0WKb2ydllcdc8icGh4h
         EiYukaXf6n9VALfA+gc9aBGeVupXd7fdQe3Rp5bPTIMkcoPyAjRj4aaFZbHNw4odPoQ7
         qLjBzMdC+ruBhiLNp3NPzOJasHshuOdM53I/A8iuIPUXYrwX3IWmE8FvoNk4bLuMwu3p
         QYFLKikCEHoMPdauJzLuBoNT6L/A+x1JHRCDjBOmBeATHgfdodzIEnWINdB2I2gMncGb
         Ghzw==
X-Forwarded-Encrypted: i=1; AJvYcCX0zhMy1j8BCewpTEqCwYBBnru6/lUueIiHloiTqRTEM6y6KzvKyWO1YQaMFRi55UHCSx9d/8pofZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinxoL4G0NUR8G4PLaYK0iHtA/twYM/HGZvBMhkhAoEEfNrfeH
	tY6qO4XRwENw7pKue0p+5CNEhUuGZz9WUSvpacRtfPiAheon1TL/AQNSOBZroujikZuULWYoruQ
	TK4P9IuLP720e/C3GTjMS4pbRlIftcWsYN3L/f8lxMFw8ZB34LIBGpc4V4VzZN2GKsMb5jFo+dm
	2WlKe2TW0FIeiBF0goqW54QcgSRVEepUKvc014
X-Gm-Gg: AeBDievF3yiHo2exbfHuSaZUvMmb7khzJdVkx3Pp9N2lM7ly4cIh9ETv85K7hDvad7n
	OnqJNckNnekAaMYOzd0jdfaxysjbr7OnEU18vjsfr/p6HnYAaSSh56dSSFNrMaJ2qEqkb32ASa5
	2OPRPkGYMJlI61Xcx8z/NUEVn5TGTVKSixGDcOcM1W6KLElhVwyTk2Z30H5MWiobjnCCjKhGZlD
	uUS
X-Received: by 2002:a05:651c:4408:20b0:38a:a7b4:15e8 with SMTP id 38308e7fff4ca-38d8d3856a4mr53298831fa.12.1775657806513;
        Wed, 08 Apr 2026 07:16:46 -0700 (PDT)
X-Received: by 2002:a05:651c:4408:20b0:38a:a7b4:15e8 with SMTP id
 38308e7fff4ca-38d8d3856a4mr53298501fa.12.1775657805980; Wed, 08 Apr 2026
 07:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407153532.6395-1-djeffery@redhat.com> <20260407153532.6395-6-djeffery@redhat.com>
 <c5cb8cf0-9beb-4bc4-8ce6-83b4544beede@oracle.com>
In-Reply-To: <c5cb8cf0-9beb-4bc4-8ce6-83b4544beede@oracle.com>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 8 Apr 2026 10:16:33 -0400
X-Gm-Features: AQROBzCA9JzhK-STTzQehLHNPnOIWukHHyeEOKbNwvtun8-eFJcP344aRf0ba_A
Message-ID: <CA+-xHTG9tMCCf11NZwKfvE5xvCfjXrttDXhFsyz=SCofAc9Mgw@mail.gmail.com>
Subject: Re: [PATCH 5/5] scsi: enable async shutdown support
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 12:35=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
>
> >   }
> > @@ -1396,6 +1397,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
> >       transport_configure_device(&starget->dev);
> >
> >       device_enable_async_suspend(&sdev->sdev_gendev);
> > +     device_enable_async_shutdown(&sdev->sdev_gendev);
>
> We call device_enable_async_shutdown(&sdev->sdev_gendev) here and
> scsi_sysfs_device_initialize() - any reason for that?
>

It was added to match locations where async suspend is set. But as you
point out, it does appear redundant to use both locations.

David Jeffery

