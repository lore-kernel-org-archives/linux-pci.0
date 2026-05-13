Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDD42A9D;
	Wed, 13 May 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645074; cv=none; b=epmixKtcGkDmZLFdIx+lsamGfRW/TLxQX9qzhud2plPmbYFOnntA0LzZ/qycZil/iA4OA9lcOPbu9uyvVsIWXjd45DGTr2P1dp59+1wKH98PDQXj+8o6BueDoGfNlb5Gw9rLR7Jc4pw1FJtGCFPwHO6wzkOqRVnklDbwK4zrJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645074; c=relaxed/simple;
	bh=k7MpM86QtfCu3jCwWUvM4gQU7osAdzHNw2Jg+7b+Ctc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB5DzMFJq+dAwRXX2KOu9vOfPwmTeh2KUlM0uGMd5pypyanpM7aZ25tI1PJB45nXiK0/X3/Kmi0LGEloTz+pLXToxjromUwEH/F0s/FPMmRAs39blhUgGx51ggfWm4PobPnCOFxuztjDsCTjfs5r0oE9X+X4ILRrT5ytzGd0vLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XWjGf7Uw; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XWjGf7Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778645073; x=1810181073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/xbs8//p25Kr8lBeXV8kTA+S6A+9JLDKOrRl+rfB5I=;
  b=XWjGf7UwU1w3YruG4TuMfl9uhwb5jFSQhzWaEazox63LPVvU4HNejZLc
   6SgPZBkNKlOtcPwXn8GW1+XWQzmAR96tpYctWIksqmQb+EdNGzPqmLdRD
   NxvX+a6K562e5n46OEA1BKor+w9j0ii9Ys/kIzLFNZbGh1ASRBOsT++K0
   hvCbymxHNrzqI+PaugJj3nEA6S0epkRohvtUSrYnhXxChUlP5faKQhH4T
   P/L6pnLDm3hCCX2V7DoypZIxEPSYCaRYQeG6s6Vodv2XHhdzGdqnsFqwF
   kweBuncEcMzSXhS07zoqYHenrdi7KHCt6oeMQqqBmy5+TnfFGqPPabhnq
   g==;
X-CSE-ConnectionGUID: B+wgS5R1QICO2DEDLqId4A==
X-CSE-MsgGUID: ngLVMkJvR0iO5EtPhnbpRQ==
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="19399220"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:04:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:24470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.21:2525] with esmtp (Farcaster)
 id a2f9d8bf-51cb-4fe9-afc0-ed16f0efb342; Wed, 13 May 2026 04:04:32 +0000 (UTC)
X-Farcaster-Flow-ID: a2f9d8bf-51cb-4fe9-afc0-ed16f0efb342
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 04:04:31 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 04:04:30 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: <kwilczynski@kernel.org>
CC: <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<ravib@amazon.com>
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap handler
Date: Wed, 13 May 2026 04:04:01 +0000
Message-ID: <20260513040401.16035-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512094621.GB1539393@rocinante>
References: <20260512094621.GB1539393@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, May 12, 2026 at 18:26:14 +0900, Krzysztof wrote:

> > > > pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
> > > > a PCI BAR resource into userspace. This allows new mmaps to succeed
> > > > even after a device has been marked disabled or soft-unplugged by the
> > > > driver to prevent further access.
> > >
> > > Which driver disables resources?  Would this be some Amazon-specific thing
> > > you are trying to fix?  Or are you just manually disabling a given device
> > > using sysfs, or something like this?
> > >
> > > What is your use case here?

Thank you Krzysztof, Ilpo for reviewing the patch.

The use case is surprise removal of the PCIe device that does not have a
PRSNT# routed to the CPU. Based on other internal states, the
proprietary endpoint driver marks the BAR resources as disabled by
updating this flag to prevent further userspace access to the mermory
regions (mmap) to prevent kernel hang/crash. Currently, BAR memory
regions will be allowed to be mmapped using the sysfs resource files
even if drivers soft_unplug the device.

> > > For "soft-unplugged" device we have pci_dev_set_disconnected(), but this
> > > does not check current flags set.

Thanks for the suggestion. pci_dev_set_disconnected() couldn't be used
directly as it's defined in drivers/pci/pci.h and not part of exported
kernel headers, the endpoint driver is currently setting it as below
along with the flags:

    xchg(&dev->error_state, pci_channel_io_perm_failure);
    smp_wmb();

    [...]

        pdev->resource[bar].flags |= IORESOURCE_DISABLED;

    [...]

I'll replace checking for IORESOURCE_DISABLED flag
with pci_dev_is_disconnected() instead and make endpoint driver adapt
to using pci_dev_set_disconnected().

> > > > Add the check to return -ENODEV when the resource is disabled, blocking
> > > > new userspace mmaps of BAR resources after device removal.
> > > >
> > > > Tested by marking the PCI BAR resource as disabled and verifying that
> > > > a subsequent mmap attempt fails with -ENODEV.
> > >
> > > Can you explain how did you do this?

Based on the internal logic, endpoint driver sets the resource flags as
below to indicate soft_unplug, which pci-sysfs use to to reject mmap
of the resources.

    pdev->resource[bar].flags |= IORESOURCE_DISABLED;

> > > > @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj
> > > >   if (ret)
> > > >           return ret;
> > > >
> > > > + if (res->flags & IORESOURCE_DISABLED)
> > > > +         return -ENODEV;
> > > > +
> > >
> > > This probably would be better if it checked IORESOURCE_DISABLED and
> > > IORESOURCE_UNSET, but then probably using resource_assigned() would
> > > be even better.

Thank you, but as you suggested above, I will update the patch to use
pci_dev_is_disconnected() instead.

Regards,
Ravi Kumar Bandi
