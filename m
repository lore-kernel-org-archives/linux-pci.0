Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F2345752
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323233; cv=pass; b=lV6NY/pMZcL3oz8n0ZDr3CUUPVqxscRq8uo0IFKOnUcMVO2Q+ble7XARF5cywC7zGReJY0P3lUz0Djrh1bR+Z/9gfTEB4zaHrmFARxb4T/wiepz/fhCNknQTR8gtQTJtZSxGsXMm0BzRzn9PqUQcdH7m6xjLKURtNE48iJbrpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323233; c=relaxed/simple;
	bh=ZV3VbZ1mNM0aS2EfUb3caDrCm043ueTXRh1wTOrM/Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzrWp0i/yIZSlGWAUsW1PdHr354fRIVRPVOm/l44es3d/JyscKxXIqx4Xq9u+QgBVaB83BWf2QrGoa8/wpEG5rGCz8ciUcZ+ph1yTmeekZwSz7Dg2m9wq+I2HSh/YQ1Vt2zveQSIPVhak8SfWNfg7jcklpcJIL3q8rKtAZ8Dy+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNJl/l/H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lgO31Eej; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNJl/l/H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lgO31Eej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdlxH/5WUEaVpOS5WFYwF5v8OUn3hB2b+n1tpHi0S+k=;
	b=TNJl/l/HQe5oTpBpF3keEC2A2zIdmOtadlKl6X8p17HScOhCMgyur4Z/z9ZuUCubltxLan
	WjN9aC7lnQ7z2hcSJEp2Y4SRCxLPoO6L4pINd2vrbv29xr074Fy2dph/T7leLOOB7NW+QO
	SJuXXGg3myGwdzH9NOk698owGs+chQk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-3UYPd-APMjKNnNEK4ZQI7Q-1; Thu, 12 Mar 2026 09:47:10 -0400
X-MC-Unique: 3UYPd-APMjKNnNEK4ZQI7Q-1
X-Mimecast-MFC-AGG-ID: 3UYPd-APMjKNnNEK4ZQI7Q_1773323229
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38a34c834c0so5626091fa.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 06:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773323228; cv=none;
        d=google.com; s=arc-20240605;
        b=NvkII5sg3jHjVA4IjXvIn/2fqr/yfSyga6cA6A2qGMq1REM6K//gh0324RXpG81jUN
         lpidMdgnlQaVbYQmgDhsMNh6B3gxJtXMLdO/NmzEtlpO4+J54wyuFsL9wKE1bVxus26W
         aiJJxEtrqVoJAdxPH4ITjnIlDqLxPiBxsY4bPcQjCPCGoG0UZ2M/u+phEY5NCZlB4wpi
         FX5Uc7LE+DZnPFclClKrZ2DdcsXBi2VRNcclV4A2g09ECZJ5IehQAN8PlVH0Nmvr2sC0
         qJOTuHCczCtBO6tOGNF7EbXbumkgdhAm5iTfcZPVc6nJPWq/JcpojftTSIYpt0M9QUo/
         aHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gdlxH/5WUEaVpOS5WFYwF5v8OUn3hB2b+n1tpHi0S+k=;
        fh=2QTsimzpwBNksN8JMhZ0DspEyW/PDCRDj1o+37AFKOU=;
        b=Obe/oo1vLl3k4/sPOe4yINdUWLM/WAlp6hcUa300kmjtkzeT737XUgyJ6j3BBCW/B4
         cP8/wKsCt4/Wqhsi+sHKFTB/QcvOnemRF4EhohZwld8QJtu0aZn3WpHc4+BcVLYCA3PK
         GsUtj0G1SJtUCibtY21LP+zWAWqsCfwIoszWZ8XTpMOuxJGLR69yCJgdBUpXCViryUV+
         BugdDDW438qqU98zHDe6baxqX17/o8/Bc62P9m8GRGThdQ/8c61D/pdZUtvM2mfFUYzu
         LkWx9i14mhP+20Suw1kkQWz5M2/gGea2/Fyplo5H3muS2ALoxH39Hzsi2hKfg412Fbor
         jV1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323228; x=1773928028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdlxH/5WUEaVpOS5WFYwF5v8OUn3hB2b+n1tpHi0S+k=;
        b=lgO31EejrsDVSyJRMnmAsJuX3vE1RlU55aGe+itHS+AM4A0l0fTm7izhrQGUrw9hJB
         zNnNywQdnhXx+jK8rd9CfyETOlV3HU2edV/7Sq9vcPQfhwjnwR6mnP2QrnVKk2aZsd8i
         Gsadd8bzvHllb17MKCIQMl25/vBt5Zk78WKBOxrMCKuRKYLfNgC5RnXSQz60ZQoIEgXU
         QsU8o6Rtu5qLRcucZRmNDR5jCvmvdkSTVhFifjc2muleJo+xcX8Q5QLxO7M9rkjZ+W/F
         GpULG9EMKnv0qqXWtOjOqkz/xgo0JMiTsszP12hG8rTRL+WheL3jASKJRjVMfdU79GVB
         HYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323228; x=1773928028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdlxH/5WUEaVpOS5WFYwF5v8OUn3hB2b+n1tpHi0S+k=;
        b=nZ0UohmeWejvWZMY5pbCzStTgYzRL1BJnwjcsBwZ9BJe9gD7uxJJhv9aB0BKpGaikh
         O07z6RqV4Iu9kOrRxhtDKX92Vp9j358SKUJCxJRcJsjotZ/Y/HP1/L8x6sJt0CBc/gMD
         DoeqVS0gEsAXUph+goYjibhBL3oiGs2vvouQjVfV2TD+0QDsnlOqpHNrQqLociHWM6zG
         pasfpNmp+cZD73m1U2MAFsYqxUvqo74zdWErPr5/vBa4Z5o52g2FfX3j5MMoFAP3WLbr
         BmVOTrmK8oxLSAiFPw3iRxwJZj7M9wjUXbt23FYvrmML9j72WoCvLgPhT2koN3Jm515D
         gZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVXnbwaFSznz323Kgzu9Znv3MXgZfmPJAVpGD+XbGs/lYNhPrlJzH1yAHyV3pNLupWypAmpZtTyMPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ5DV4jARjVp1/YSqoMLoq5ZYvQ8V5/YGc/E1E0nl4ju5QBO/
	xxxS9vfuO1dghtuTqpMxxeTgiEwPF6bWLg3Q4OuzooLCoykpnLWj9bsNEE7Tz1BpEbRor7gkzA0
	BvjSqjywT4pwDbPQKWqQXWGuFf5f8FUOKOnrdsKbW5KqiOU5xouwtqZKd8VG+GpDceoWYt1XTl2
	YJLYDO06PiIupxUtvN+HQmMw+FkV46j86VVXXD
X-Gm-Gg: ATEYQzwvUoD5G4Ms51qilgMoAaP86ooRZ6vhd22FmJcb0Vm5GEHjjoxLJ6v+6D5akFe
	UIjdrVG2AKf+5ckCMCAgGxNJrChEMn8i9z3Hsczmj3kRAvpJgv9+vG2xlq/ffYaCOF1yov/PUAf
	AzB83HUGSOviDWuexJu8oVS2SrUceO+t5WZ1+OvtUVG4u1v4H0DFdsXPaQ1yeVSuX9/Iey5uvG2
	FJK
X-Received: by 2002:a05:651c:418a:b0:386:9653:5d52 with SMTP id 38308e7fff4ca-38a67e7491amr23214051fa.34.1773323228367;
        Thu, 12 Mar 2026 06:47:08 -0700 (PDT)
X-Received: by 2002:a05:651c:418a:b0:386:9653:5d52 with SMTP id
 38308e7fff4ca-38a67e7491amr23213891fa.34.1773323227890; Thu, 12 Mar 2026
 06:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311171209.9205-4-djeffery@redhat.com> <20260311230854.GA1051125@bhelgaas>
In-Reply-To: <20260311230854.GA1051125@bhelgaas>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Mar 2026 09:46:56 -0400
X-Gm-Features: AaiRm52AtdZGk-qB4SJr26Fu0GESy8t58w0K_vuANNjeyWOVb3Y93GXrhdA1CIU
Message-ID: <CA+-xHTFHCvqqg+_XKyvsWUEVo=hqXYARRMVT_nqZkwJOX+o6yQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pci: enable async shutdown support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:09=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> In subject, to match history:
>
>   PCI: Enable async shutdown support
>
> On Wed, Mar 11, 2026 at 01:12:08PM -0400, David Jeffery wrote:
> > Like its async suspend support, allow pci device shutdown to be perform=
ed
> > asynchronously to improve shutdown time.
>
> s/pci/PCI/
> s/improve/reduce/

Sure, I can clean up the wording.

> I like how simple this looks, so I hope it all works out.
>
> BTW, something seems messed up in your post threading.  I assume this
> series is supposed to go with the cover letter at
> https://lore.kernel.org/all/20260311170956.9146-1-djeffery@redhat.com,
> but the patches don't seem to be replies to the cover letter.

This was from an email issue I should have handled better. For some
reason, send-email hit an error with smtp after sending the cover
letter and failed to send the rest. When I then sent the rest
separately, I failed to consider the threading and didn't think to use
the option to force it to work as a reply to an ID from the already
sent cover letter.

> >  drivers/pci/probe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index bccc7a4bdd79..4d98bab2163d 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1040,6 +1040,7 @@ static int pci_register_host_bridge(struct pci_ho=
st_bridge *bridge)
> >
> >       bus->bridge =3D get_device(&bridge->dev);
> >       device_enable_async_suspend(bus->bridge);
> > +     device_enable_async_shutdown(bus->bridge);
> >       pci_set_bus_of_node(bus);
> >       pci_set_bus_msi_domain(bus);
> >       if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
> > @@ -2749,6 +2750,7 @@ void pci_device_add(struct pci_dev *dev, struct p=
ci_bus *bus)
> >       pci_reassigndev_resource_alignment(dev);
> >
> >       pci_init_capabilities(dev);
> > +     device_enable_async_shutdown(&dev->dev);
> >
> >       /*
> >        * Add the device to our list of discovered devices
> > --
> > 2.53.0
> >
>

