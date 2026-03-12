Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A53BB48
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324109; cv=pass; b=MTiQ8WbyxKpZdfLss+9aIo7t/tFRqVKQZFsIeLMW27ePNDZp2EArszn+vXtPMRQwD+/TCVFTMAU98QWw43khyC49KqR6JHUrBclOPm10zSvK1ITt0QFnq4MOgjdWwZSJ7zljZJO9SJhABtD4xSjmTtP7LCqSY20u7xGSzjgHvtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324109; c=relaxed/simple;
	bh=h7HyxgIgdaXVa7GaIMk60Eou7grQ16jf0HfHA3SBWAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMK/gdNiicjB11+asOQeHElJk00uWwuRtFXWIbNLslbhSwKsznDe1RwaSmYSbm8xN0D7oT4jRn8MYy6o0kb1CYB78XiV6cP/tcVVQAwNOXcRmfBR3hJMIBhmx3BIc4oN6P6S+4GdbtlwC7vTmlucT5jU2FKD8actMFIsS+4q4UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnjXW8uq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nsWHhxRo; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnjXW8uq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nsWHhxRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773324107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svCptW0MF+j8ogyjRJzY7kaL3jUF3IX/ZurOettGWWg=;
	b=NnjXW8uq4PtD0ubGgFHLA4szcmVWkFXn440rJ4v/IGf6w5197eWOaiwrUJCUeg9PxZs9Fq
	kLdRwX5DXzRokkzWkefuoIkzkbnXeVLu4INLrCCx+EkO5/ozB89RxZ3oUErkWW8yPaIdXa
	ldOzCHhNTWrfjvqdQDwhVEzIrgzR/Mw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-skBGIqYRMIy5R1kVccNzZw-1; Thu, 12 Mar 2026 10:01:45 -0400
X-MC-Unique: skBGIqYRMIy5R1kVccNzZw-1
X-Mimecast-MFC-AGG-ID: skBGIqYRMIy5R1kVccNzZw_1773324105
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4171d16aad4so9593618fac.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 07:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773324105; cv=none;
        d=google.com; s=arc-20240605;
        b=GmX/e/8cV/V81SOOI6DJqlw3XD1YKFHcW34VLRk5oeH/VZRlteXjTFbuq/25xQPIXK
         G/V1kBmRgrtWVzRjSjgLzU3UD1MGlYvKYOhCp0TlmQoMmzlOlnKM+WEbgKi1ZjgDfY8E
         F546S8gpRUN2fqq4LqgtzYZKiQbr6pJabFb1/wKO00Bv0HS9Gh8kFcjscqSuSJL792H1
         /JPh5WmixAuTaO3kw3z1sLtv7kT1QMNt1KZIOg+3/0tBXI0//ps1TeS07CEiiK+BoHnT
         Ac8POvow1S4QfO1pe3Eh6y22+BEPVJuXld/RCkNMTGFMoFPaHge4JZU0XyvCPVD3NbM3
         cxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svCptW0MF+j8ogyjRJzY7kaL3jUF3IX/ZurOettGWWg=;
        fh=UoOTW72Wge1mlIh0pIn51CvIoJb7sC4se/j/6Bpp92o=;
        b=D4Hk1N3hFCh3t6Et3L3aKOKpiJ/94u1KpjNL+VWzMpt3es2BqP+J45+BaHKkk0Sa1f
         wKYKPtKEBv5DgYIxqmcnZ0OwotaSLbRhG3P+8m17EnbkLrOxrXdBmofqz3i1rOgd+pHg
         FWBuO/IHqo5ANoG+V0ODXm63/kE4wqCPMSjYy2XEwseVo3MUoThyPKjeyzPH07MgnOKe
         f/OU2p9e/QaFfCvqHkA7zdHeFrb+ZbbK7Wb/BVeU5hYTpTGfXjfuZWKKgKYEHFvha2op
         ZJRMd+XdFFfi6xgVHjxAn1aKMvXQK1gqWp13wD/fY/Bq17rUuuHEiBVYc3Zhdwofwqdw
         JUaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773324105; x=1773928905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svCptW0MF+j8ogyjRJzY7kaL3jUF3IX/ZurOettGWWg=;
        b=nsWHhxRozn7OrFsuD2ufuJNUcCBVYQ7g5gWFQAPzTFv3hh7nCuDHdLSezenGZogucf
         TA3uJGw4E1MH1jB4shBdmJxQiU9suYwleO5H3QqI8Z53ASAkGys23bVAcb+5m0PLXpjc
         vCe2ckdOdj9DyNBP8zaVAcQe9LyJui2Ds/IhEG2uxBMtXkvHCTlCdljgZKD8zc2P2H/L
         mKSkW1PDk7vK+seGnCOaKoh5a1Q9rpUWWhDBUmPd8ZCIQmQ0FvW1+CiXzatHWYpgBDeC
         RnOTgw5vdma9IMTshT5rNPEqsugHdqrjCHxukFnjWNvSj6tfBezUUnycSmm4IEcnpGE2
         ZHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324105; x=1773928905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svCptW0MF+j8ogyjRJzY7kaL3jUF3IX/ZurOettGWWg=;
        b=gT6CjY5FXpUW0RKNdpxxKNW/4xNIv1zBQjtdtBEsMShcVIAcMQ7FjInoV3v/iTmg7R
         LOWQRuop5O7FIYm+HTMoylSAYWHH5I3ViKCEW0e7xXUpIZb225/hKlBMp2glnOJKnHAm
         8yo4LHwknkRVpTy4oh7LJmPohncAP+WGCPGmd/wGZTxWlPSaGWddt8jt5fn7GaRaB3an
         2e+6KKyH2nk90ggCd3G1c1ykOLsiLXP5lbfRvf2j61GjSjJ9FSZRboQ8NXgZBRrSSHjd
         oNcowOwI9O+2Ck6lx7iAfToYmRoCJHMsnzKL/FhvRKW/mPzmOBwmCs9+lmT/6CLuhbcJ
         nOqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7JjraS8huR0C1dRM4fi++hel85iYhc/jPdxn2seLGQD0tEdt0LUUUIJ1Wa6GgGlGx6kBKPXGYAd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAMqaybwb8cCQr/JZNUlv+GhHbP6B1GIh5mTsdq5EtQuF1ZBS
	IEFh0rG5rV8qhG2svm6CR2kE/JEukXOzw09ItKeeKTmENNSCDDDYtUcGKU9Z8ZAj7zr5cDkD4Yz
	vHKfi1xvNnNGkCCXQ2Bk76z4SkEkDJH1Nu+ODFaER2Nxd2gav1xq4JkwN5BH94VaSpWwCV2QE5w
	5AsQGQYRJw93POcydvStXL1pkW7jQSmw50wfDd
X-Gm-Gg: ATEYQzwuM/IWic/cOLPwSIX6fefM9SNcLbDUwy4FL5ZhCIt20mdrh3yPAg3ih21tkm6
	LM/IWuzx/Q9s4j3fba/yZ4+BzjgS6GzbFnn65Sv4TDNsnvFnZ3QEN2u/ovlJZftCtYbw10fMAKX
	vz+Z5EIKhn5rmQy/MoU5w3iogV6EbQb1desG5xpIdnK8lxHnr8B1V4lBHZSO6I5lo+C3zEav36r
	Om+
X-Received: by 2002:a05:6870:d626:b0:417:5b7a:704b with SMTP id 586e51a60fabf-4177c8bd782mr3791135fac.31.1773324104850;
        Thu, 12 Mar 2026 07:01:44 -0700 (PDT)
X-Received: by 2002:a05:6870:d626:b0:417:5b7a:704b with SMTP id
 586e51a60fabf-4177c8bd782mr3791060fac.31.1773324104254; Thu, 12 Mar 2026
 07:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311171209.9205-3-djeffery@redhat.com> <20260311230523.GA1066455@bhelgaas>
In-Reply-To: <20260311230523.GA1066455@bhelgaas>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Mar 2026 10:01:28 -0400
X-Gm-Features: AaiRm520iVQTqV1-hjp19cjbWN8oiME0iudO3mEzYMJHW6uBnWcs_r1tMTE9dMI
Message-ID: <CA+-xHTHP2QY7T_mTFbN7XN4gbtPo06-EsovuMWuJ5u1A0HXEFQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
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

On Wed, Mar 11, 2026 at 7:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Mar 11, 2026 at 01:12:07PM -0400, David Jeffery wrote:
> > Patterned after async suspend, allow devices to mark themselves as want=
ing
> > to perform async shutdown. Devices using async shutdown wait only for t=
heir
> > dependencies to shutdown before executing their shutdown routine.
>
> I'm not an expert on dependencies.  Is it obvious to everybody else
> how these dependencies are expressed?  What would I look at to verify
> that, for example, PCI devices are dependencies of the PCI bridges
> leading to them?  I suppose it's the same dependencies used for
> suspend?

Yes, it uses the same dependencies as async suspend does.

> From wait_for_shutdown_dependencies() below, it looks like we'll wait
> for each child of dev and then wait for each consumer of dev before
> shutting down dev itself.

Right, just like async suspend, all children and consumers need to
shut down first for async shutdown.

>
> > Sync shutdown devices are shut down one at a time and will only wait fo=
r an
> > async shutdown device if the async device is a dependency.
>
> > @@ -132,6 +133,7 @@ struct device_private {
> >  #ifdef CONFIG_RUST
> >       struct driver_type driver_type;
> >  #endif
> > +     struct completion complete;
>
> I thought "complete" might be a little too generic, but I guess async
> suspend uses "dev->power.completion" :)

I am open to a better name, but anything I came up with ended up
excessively long in my opinion, so I settled on the current and boring
"complete".

>
> > +static void wait_for_shutdown_dependencies(struct device *dev, bool as=
ync)
> > +{
> > +     struct device_link *link;
> > +     int idx;
> > +
> > +     device_for_each_child(dev, &async, wait_for_device_shutdown);
> > +
> > +     idx =3D device_links_read_lock();
> > +
> > +     dev_for_each_link_to_consumer(link, dev)
> > +             if (!device_link_flag_is_sync_state_only(link->flags))
> > +                     wait_for_device_shutdown(link->consumer, &async);
> > +
> > +     device_links_read_unlock(idx);
> > +}
>
> > @@ -4828,6 +4919,12 @@ void device_shutdown(void)
> >
> >       cpufreq_suspend();
> >
> > +     /*
> > +      * Start async device threads where possible to maximize potentia=
l
> > +      * paralellism and minimize false dependency on unrelated sync de=
vices
>
> s/paralellism/parallelism/
>

Gah, I will correct it.

David Jeffery

