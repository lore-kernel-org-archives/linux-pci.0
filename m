Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A74C6F02;
	Tue, 12 May 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579662; cv=none; b=p47i9HrCYET4i0FOxPykgrDmj0uufLvRCEcA5Qcg8RgOW2donAD10sz8zpYl1vrBFSdXQH17QcvLyE2Jsjbq1Cxa8UvVj1J++2kGlvs53Pvzd5UmfEuD+hGd5WhiSkdLPbzUpb/UqGhdpIsXS5meLZ9CGhsZlp+dlT4YrOPzunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579662; c=relaxed/simple;
	bh=BKuTUM1JdmOD6A1ZJ/BXwcDF57YUQHC1LGfec87hqbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwGfOvWGdzWFR+CihUZdKDweBh2kpvB9nj33YnwWFhd/lE+NqF3uf/qjrGZw+evoO2huAej9W5U/ykhVxjDQTxGWDalqBUrV2kf72kb1534OtukvnwZKxlr/k3BdliFOc8zBchMkrfmVhdsHvgj9HBQ686JlwiUV+NEefILB07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZReaFyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZReaFyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84BFC2BCB0;
	Tue, 12 May 2026 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778579662;
	bh=BKuTUM1JdmOD6A1ZJ/BXwcDF57YUQHC1LGfec87hqbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZReaFyZnGTpE3IIts2eQVMuydo40pDv37bFz5ECPcWKvDIZXrhUfSDYhV6on0GYP
	 uFPVfcFnQcrnYF1Cl5AnIMTNfUFHLolUj2jHybCUSSlN8GJVEyqlVvp02GMhCIN9yV
	 YHUjf/biUDuRVS4YMbIETHwp2XXnvB2FfV7rhPlY1tjZOcyLMXX3oXvypyxvAWXet8
	 ZMTqvlot6OXeJ+5IQE/QZPmy2ntItIPEeKSRFChPa0hruvFWkp2B6zxhFoxRyf2Bks
	 myQqxhlUgB0Upb7MTLHNZX/J88WJGmsMFGbqipmBdMPjt0o4qpz4pMEkKfwwY9jSnH
	 JKuiibw03Zofg==
Date: Tue, 12 May 2026 18:54:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Ravi Kumar Bandi <ravib@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap
 handler
Message-ID: <20260512094621.GB1539393@rocinante>
References: <20260512084315.32564-1-ravib@amazon.com>
 <20260512091848.GA1539393@rocinante>
 <963819fa-1177-7e27-da34-b79013575b09@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <963819fa-1177-7e27-da34-b79013575b09@linux.intel.com>

Hello,

> > > pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
> > > a PCI BAR resource into userspace. This allows new mmaps to succeed
> > > even after a device has been marked disabled or soft-unplugged by the
> > > driver to prevent further access.
> > 
> > Which driver disables resources?  Would this be some Amazon-specific thing
> > you are trying to fix?  Or are you just manually disabling a given device
> > using sysfs, or something like this?
> > 
> > For "soft-unplugged" device we have pci_dev_set_disconnected(), but this
> > does not check current flags set.
> > 
> > What is your use case here?
> > 
> > > Add the check to return -ENODEV when the resource is disabled, blocking
> > > new userspace mmaps of BAR resources after device removal.
> > > 
> > > Tested by marking the PCI BAR resource as disabled and verifying that
> > > a subsequent mmap attempt fails with -ENODEV.
> > 
> > Can you explain how did you do this?
> > 
> > > @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (res->flags & IORESOURCE_DISABLED)
> > > +		return -ENODEV;
> > > +
> > 
> > This probably would be better if it checked IORESOURCE_DISABLED and
> > IORESOURCE_UNSET, but then probably using resource_assigned() would
> > be even better.
> 
> Yes, resource_assigned() makes more sense.
> 
> When considering Krzysztof's sysfs rework series in pci/sysfs, this all 
> should be handled in .is_visible and not in pci_mmap_resource().

We can't use the resource_assigned() sadly, but the flags is something we
definitely can check - I will add this, test, and send new series.

The callback, though, will be called on creation, or if someone calls
remove, create or update for the sysfs resource group - no driver does this
at the moment (some DRM drivers resize resources, but that's unrelated),
so I am not sure how Ravi is doing this at runtime.  Perhaps I am looking
wrong at the code somewhere...

> Also (FYI), alpha has its own pci_mmap_resource() (IIRC, it still has it 
> even after Krzysztof's series).

For the sparse/dense resources, yes.

Thank you!

	Krzysztof
