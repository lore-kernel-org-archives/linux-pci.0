Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1536351C17
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323673; cv=pass; b=gp6ptttMQGWx/j+bOTTmFbqaOxvHZqRRxI58JoC4mztTcINIrQNPQZRGLOCXHc2GbXsVH6EhjgkmGfRJ6kzFmUiwf+dqjH6kMhwqCaM0lwEBq0vXErqP84+3gqeXYKCt08hopAl5/JbG+GJEMkuGKkJOH4ld3+Davkf7oij012I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323673; c=relaxed/simple;
	bh=QyuFlbrGA5AQlhnI0HMtrCQprHs6ftmSMcfrRAXjexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzRmA4nyTpogh3cCGqiskVHH6E9d1F4TiXeJZNSS08fwQpOLyGZ7ce5NIUxmozrms13y2k/7MKV+Q+8+rTofeWCoHLthEBRxmfR2M9uLCKJc5y1bEfQvELP5zU3BmxK9BY/oDtlZEpBQN6ZFC9WMcEetvRVzeCi3sV3kTTCpmOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvwCcUHs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhnd77sc; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvwCcUHs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhnd77sc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XExV6QRKq8SZymtd9B/1tvKMnhGFOwk+2Q9owYWU/z8=;
	b=OvwCcUHs0oTh6eCn/SYOb3EXiH9eLrn3FtWTpMB6s740BgPgA+wvbsiUadOavyuPspvMQH
	MrZxZ5hloOxbCGtBGqssaauYJPpCBBvvmPfLlM8i0qH2ZkqK2wc5beAkd2BK/obT+dHTqw
	Er2TFKa7vvmL0A6G3PDUyb5k9UhrSbA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-wiB4pv23OVaJm6N5MF-gWg-1; Thu, 12 Mar 2026 09:54:29 -0400
X-MC-Unique: wiB4pv23OVaJm6N5MF-gWg-1
X-Mimecast-MFC-AGG-ID: wiB4pv23OVaJm6N5MF-gWg_1773323668
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38a469b8bcbso4758861fa.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 06:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773323667; cv=none;
        d=google.com; s=arc-20240605;
        b=FRDMKAm+Sbv09Rku+mZch6Lze6StqhwsoIG60GF5CogT8QmR8uEqpwdhRp6v5CX1lK
         vFyrWVpu6kpfkpsf8cojsUul27AeF4Y30nWWztzwSgwt1CJxyWfP3NrW1t08cHCnRKMG
         a/M06skSFBMIk+bS6lORzAa+vUEdLa29U2oPIQ0Cqag1DEqW13ZZ0NKZ1kY5BSCPp5nF
         4VPFG8QTSTkmNmMg/dlaDXbVCL11FYss9yzA4uV9LdtgOdQvSqS0f/CNAh4SoQo9OEj7
         kBmsSiqJpfw0/uNX+6DY3jiWIx0NolFbvP4npLmf76iPNsmOJX/0ckeTVURRLhGp8ycR
         aUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XExV6QRKq8SZymtd9B/1tvKMnhGFOwk+2Q9owYWU/z8=;
        fh=UrV9QxorosS0hojdmM7IFF6VSZVNGefO9H5u4GSQrM4=;
        b=YgJLTe7hnc5HnpN3AoE3tZgsGjajE/0iLx2MJESaHvJYDVdnUK2OQUmF2BcLSSgsVp
         1lYdqqrTSKMUDo2FKfklLBCAYsGEXB7uScOzQbd9bwp2+jOYFFdS2utvAio3I7bC49wm
         bMuYtci9T5n7+cXxfEOFAjPcVLUNu+6mY7w2JEp0x/pp5yDJ/M1pxy3pQCbyD0kJaDSt
         gW0a5Wrr0yFwGkmf00/Cy9UKkQD9td/NRrtYcc2gp1fEVu1VAHlZd8kgsFtCgFMf4PZQ
         ngZCghWfWUnuCVn2aIRXiHLQG2e7V91wDDC1M0/ev33TPOSUJaYxDQfJhenrVkxdx//8
         +qNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323667; x=1773928467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XExV6QRKq8SZymtd9B/1tvKMnhGFOwk+2Q9owYWU/z8=;
        b=fhnd77scXK2vZ6tbApUOJ5hmiA1NJqbB1Wdkp0sdB17bbmT32tIJpkDjtfwGp27qDc
         VrQV7lho8Pm6HpZsNJsV3BuSvv6JtAzcQIrlzjTU1HAt9qv8H7UijwvKIRaSIGjLJ/rD
         pGRDn4tSbj6izizanEhErkcdfo6v8vHjGHzUgSfD+rVVDnTQFJfAiKSqhu9qCgJpfWBP
         6edabGnstkxK38V0BcPzYaVyxf4MTv45ARfASQKrWqR8Y/MMJB/Br/UjoG4zd3dyLxcG
         aknbiXWSQY62ZDUf5Kpwrn+sprif3C0bb2SLwhF8CgiQTSUeb0aDzVj10k5GCYHaPOvf
         Gawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323667; x=1773928467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XExV6QRKq8SZymtd9B/1tvKMnhGFOwk+2Q9owYWU/z8=;
        b=tGSfAzR7X8ygxz5PyJu6GeG7QhKybnzvSQBv+eXp5Huw7wPvujmgCxTkxUwRRHFMmq
         h6sD87LloCWS/fFHVM4PnJnpoMmJ4008tt/7xyxuGasB+Hl1J+40ei6e3M0bc9qs0hLm
         x0PclDAJOTESfCaDZJVppj88J2eVzEJOoJrV3Kpm1g5jkqWD/XEL8BFv9iskt3pZ4UKu
         Pm6SWcmY28YelNWf9Jsksut76MHmI/fSZZ48n1rR9zXRmrE29B7OEbn+teY3KkB6sHd9
         IHK7/93C+nm21q3FzlreExYxQhY4erGiNOESSV/MKFocKqRe7psJNgZLMrGEwXVkaJ4h
         HQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVLuHrYjb2xjR/vVw0jl24qm5AdWSJ6T1vkdYgN774WvC64DLOHEgdl2oupjztLjgB1uaqHG9Ruk9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9apy6ZzA2b3s5WHbjyXlCL0ZvSnCGSlzp7bM8eA3m/a4kL3H
	rYyojgwiIWcEFr1CVcCVpiuRCasn1fNLjqKKFhMDs+Qu2rBkyRT19TMRSsYpFlFO+eHTPFUfyRc
	USFHrSUmjfIsUwxJiArVKw5LwLyV7evm7F0TedlYJZzf2vUY2de21lGxjxDVBtY6FHDl+Eqfl1I
	jRnnZzFFpvaenS8OmnVZunqFIZsPy3YEnRU0+1
X-Gm-Gg: ATEYQzwQbDTa6PNTGPVldDtw/Z2yGcVAEe0yac5swTpiC6CXAMPgXLKdp33SNVtigQO
	8z/4Qch7fpDbDDCVaGUCf4CUA5iOf254Jf6nt3esZSfrY6wtzwl1Qz/OgLXIMEVsiBKOQHYzVRS
	2WxcOSE3eej4fG9O/rrMQa0vA8r1j3Hfo4UeKJN+n28drStK62n8ZqeiS/Z6ILHD0vV40p819bI
	hsd
X-Received: by 2002:a2e:8a86:0:b0:386:1ce2:11ab with SMTP id 38308e7fff4ca-38a67da3325mr25663051fa.11.1773323667554;
        Thu, 12 Mar 2026 06:54:27 -0700 (PDT)
X-Received: by 2002:a2e:8a86:0:b0:386:1ce2:11ab with SMTP id
 38308e7fff4ca-38a67da3325mr25662881fa.11.1773323667010; Thu, 12 Mar 2026
 06:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311171209.9205-1-djeffery@redhat.com> <20260311171209.9205-4-djeffery@redhat.com>
 <2026031229-coastland-ducktail-c4b9@gregkh>
In-Reply-To: <2026031229-coastland-ducktail-c4b9@gregkh>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Mar 2026 09:54:15 -0400
X-Gm-Features: AaiRm53czMd8xlW_uvkK052fMb3Ujo3XTxm7kNzW6g-GQBO5hD6Lp1oyDE-dXEA
Message-ID: <CA+-xHTHR84gAoz-82CKKEsbwY5npqofUb3=jQ-=OJnqUQZR1yQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pci: enable async shutdown support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 11, 2026 at 01:12:08PM -0400, David Jeffery wrote:
> > Like its async suspend support, allow pci device shutdown to be perform=
ed
> > asynchronously to improve shutdown time.
> >
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> > ---
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
>
> For all PCI devices?  Are you sure this is ok?  That feels like it is
> going to be ripe with race conditions...

I did not see or find any issues. PCI already enables async suspend on
all devices, it just does so in a power management specific function
so I didn't put device_enable_async_shutdown next to the
device_enable_async_suspend call.

> How was this tested?

It has been running on various VMs and x86_64 physical machines.

> thanks,
>
> greg k-h
>

David Jeffery

