Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C02C21C5
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697435; cv=pass; b=BV80L/abokX303bVEqGBFjTKfobpn6Uj55X0VY7qPx8LVP6JZ4KpSKVDOGwrqZBbYhuHaneomKbuLPdesC6s+8i2Uv3+Dk/XdBwqC21dTrLhpI9qMNn3Ibudst/+HRiPJ0N2FrAcxUbSXcD+DJo39MHEVSygZe6eP8dgNZiSiu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697435; c=relaxed/simple;
	bh=Bf3HBpcXRbpnz7qtsNrFHKLAfAPv8JOiRr+8WNuuU8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGQFcL0syuJ/ai7gO5QT2wLsqc86M6II/dnc7Y95dxoP93CQmxM2Q6pfRbmPW80C3ixoGb/FXnRosVG/ROX3Ts2KneiXC/ioGRcXix8JcTl/ntMd2HcDOJ435sMUzhjmGZiGDFkO6h3SiU1WjaTjR9vuTvrmkLxv/NsFV0wXBKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc2pfcF8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOhKfElz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc2pfcF8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOhKfElz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775697433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8YmCfgK+S4qww1OeXKFRIv11CEZdN1UiyLhZqJZF1s=;
	b=Vc2pfcF8aqGSTzdjXdzQPO8az88+EBuL+18afwRHK/jZnIatcQrXd20jfedVp1gW0AHxwY
	DdWpZr529cb/0IiYVJUk1TJNpCruXuM6FpYvfsrsUYyaW70f9afSqmxJZbijj9Oqsc+VY5
	MwCCeeL1/ous7eNe8DDUTHG3n2lCcG4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-SgnRTiDQOd-iI8yT3Pup4A-1; Wed, 08 Apr 2026 15:35:49 -0400
X-MC-Unique: SgnRTiDQOd-iI8yT3Pup4A-1
X-Mimecast-MFC-AGG-ID: SgnRTiDQOd-iI8yT3Pup4A_1775676947
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38a2794fbc5so330141fa.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 12:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775676947; cv=none;
        d=google.com; s=arc-20240605;
        b=hEFpT9dGFF9pF4DzanmYKAVIgU+vIiNzJ4zsTn0jlSydif96wSBhh6kTePjzyG6aR/
         HvgvVQG71Nd+kl1Azm42HAmXxwUJ6kZ2+LhYH3MDnweQ9qijO8XskybRJroSxqp1tsYq
         Hq1BxdgZWVIqiiOTOK5VtQZYXaSo1raR8L1TC1nMBK+k5Nbhr57XQhdKjUknPJPsNtBL
         XGJ8hjp9mX3cqeQH4CNeRtHHKS1eULU7l5R2lv8f516MJeAwyB/0NwHw71azOnBruU+L
         zdTJh4uKobUDrBKllVLJ4xyHulXiuxb2YBuRid11Y9LTfjaeRCgGUctO3feoQsfoUU1d
         9Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8YmCfgK+S4qww1OeXKFRIv11CEZdN1UiyLhZqJZF1s=;
        fh=K0FAkB1rhOXXZnlErwC3cqQjimuCIwJk7rFwBzO3oG8=;
        b=OPPaGqz46KsD8uMfH6ScciJ7gfjRntv/DvUX3qxgpWayhowQ47pnah04hRso/tKJqp
         3M+uAiYpY6118ip3IkSmoRrqy7Re3IbjQ0qVTbjO4hn2EEzaZolT7MS7g3pPwFOQl4H3
         zwZ65udLedk7kQ7FYxnkfsJVCZNATvvAsQPO6pH5yDlRFKOmnFUEGU+JsGvaj9ODfc1K
         H9eGEBH7UGo9WFPlJinVi3iKlKVw/LOUIBxHtfNuyQBRagH3e04V+z9j9BBYmIab0Q0H
         5LSlKXbmkdoBXKKCgslZnsyFrR/WWUXUoylIlPq4mEhVOF240v6pqhB6ECGB6FAumt6P
         V3uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775676947; x=1776281747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8YmCfgK+S4qww1OeXKFRIv11CEZdN1UiyLhZqJZF1s=;
        b=OOhKfElzk2GMgPZfI+IUj1WYNJzcxuOoBZBVX2+e9R4er7gXCQDIdE6wk1gRFMUeeo
         3E516oxg+OEiboDxUhEVU9du5KckLTboBRftES4hZA3EaY/WFcG/Nl/AEyqpLIgFeQGH
         1MwsXaxKJBa71IQg637M+uP+vicCknhr+KdZah4kg8Wt75dHPA82Z8oKhomE0tUPql81
         mc1+7tWAxG2Jldbjh9aYcDcYcEG085ryS8qN79IoK+kxM2o5+aBAw5FXrLw2Ayus50n2
         cDe7MxVBycmxllKkRxiawaeoapbmPK79a/YYTMHjEIqyKVeXA0nQdmrKW+Bvk3Kus8I6
         iqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775676947; x=1776281747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8YmCfgK+S4qww1OeXKFRIv11CEZdN1UiyLhZqJZF1s=;
        b=OjV7IV6OLy1M8tfpzf1YTuOsIxY9GOwgxTuqD9Zm4pTnXnUFRbYmCs/GslGCqGtET7
         bO0+OfWo9vdXJCXgwQ4Vbq5L2DLntiKQkDJUcOEUVul7v4lVaYrxXg6Y1hH8ABZ7qzem
         Gx+auevzAtaXYRMAew47TIanAyU+vzq5ZEoKiRsbSx9cZ7dUIJsEcddFUJQn0W36ooFz
         panKKWu5BQuXb3ndV0/PI/uCtHTto1McXr3mrDxsK2FCT3zHdJpfCR/TPL8tMLAIu3BG
         hHVN3akxt2aAbZx8o2/0D3sVYBXZihbY/1463kx8cJN9C0b2JzepKfcU2OGOCYsmtWTd
         89dA==
X-Forwarded-Encrypted: i=1; AJvYcCVMUItAHaKVQfr70lqEagtt8y7Tpmf9XnzfBtdKVBmMdkUoGyVRkGy2UzBYsYaGxJT7RmAZ8rchKaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Q0z7Db4yJl/g7r+Aeye1ndN/e63ItPJKXdXsR2gJhCC3r7I+
	a96sFOBx1BEFqkojXINh8duOb5k0NLQdNLqksdDYIOcUpX8fcZmYXlmbg64NQcx9mEaF/Tf1wDa
	FTC54U99ZzIXjvS9tt2h4z8sz9v/T3EiGjnYLoMK2nruR8BO813M9+EvrLdWXDSECV7V9DaTaTS
	vVgYp0d+srGt/b9Rj4nhTjaXyv7W0aoD505J+U
X-Gm-Gg: AeBDieuEqFTfYm42OqPqqHZsg6rNyAXzAJ/4OMwiIHs+0UGN10h6srdXIUKh4ISSM4I
	tyh4D87Hb8AYj8mZQ3SV0ttePf9u7OE7AMleS1fdUgx1uwveD+cVvw1PIcP2jG4eNO1ibBamkGl
	/0mZTGEzph5dOZBXAK9uBxoo6inC53I0SUZ/4iPaNak1SgPUvSzvRcRji5C6FYLo6xzUmCJk+C9
	yLA
X-Received: by 2002:a05:651c:1509:b0:38e:2933:cefd with SMTP id 38308e7fff4ca-38e2933d33dmr12737501fa.9.1775676947309;
        Wed, 08 Apr 2026 12:35:47 -0700 (PDT)
X-Received: by 2002:a05:651c:1509:b0:38e:2933:cefd with SMTP id
 38308e7fff4ca-38e2933d33dmr12737381fa.9.1775676946827; Wed, 08 Apr 2026
 12:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407153532.6395-1-djeffery@redhat.com> <20260407153532.6395-6-djeffery@redhat.com>
 <c5cb8cf0-9beb-4bc4-8ce6-83b4544beede@oracle.com> <CA+-xHTG9tMCCf11NZwKfvE5xvCfjXrttDXhFsyz=SCofAc9Mgw@mail.gmail.com>
 <069f3f1b-8150-41e8-a760-f85a0b1b0ce4@oracle.com>
In-Reply-To: <069f3f1b-8150-41e8-a760-f85a0b1b0ce4@oracle.com>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 8 Apr 2026 15:35:34 -0400
X-Gm-Features: AQROBzD1jjRkWpzNwb8uyDg7e1dbHkjzLDl0riAoAiR4l1_QYsvUdLm-veMvcSg
Message-ID: <CA+-xHTFdKaCCwkytXpWdvp6vZ4ZCh+Pp8wzkoVZYPOy--CjiSw@mail.gmail.com>
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

On Wed, Apr 8, 2026 at 11:54=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 08/04/2026 15:16, David Jeffery wrote:
> > On Tue, Apr 7, 2026 at 12:35=E2=80=AFPM John Garry<john.g.garry@oracle.=
com> wrote:
> >>
> >>>    }
> >>> @@ -1396,6 +1397,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sde=
v)
> >>>        transport_configure_device(&starget->dev);
> >>>
> >>>        device_enable_async_suspend(&sdev->sdev_gendev);
> >>> +     device_enable_async_shutdown(&sdev->sdev_gendev);
> >> We call device_enable_async_shutdown(&sdev->sdev_gendev) here and
> >> scsi_sysfs_device_initialize() - any reason for that?
> >>
> > It was added to match locations where async suspend is set.
>
> Well it is not exactly like that. We have the following:
>
> scsi_sysfs_add_sdev() -> device_enable_async_suspend(&sdev->sdev_gendev)
>
> and
>
> scsi_sysfs_device_initialize() ->
> scsi_enable_async_suspend(&sdev->sdev_gendev) ->
> device_enable_async_suspend(&sdev->sdev_gendev) when not async
>
> Maybe similar needs to be done for this shutdown feature. AFICS, Bart,
> added scsi_enable_async_suspend(), so maybe he can comment.
>

My inclination is to drop adding device_enable_async_shutdown into
scsi_sysfs_device_initialize. The intent is for normal scsi devices,
and I see little value in setting the flag so early to flag partially
initialized or pseudo devices.

David Jeffery

