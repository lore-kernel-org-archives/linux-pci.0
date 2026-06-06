Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181426F2A0;
	Sat,  6 Jun 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777180; cv=none; b=OoTJ3TecZfc9lr/JIq0uUE4IhGlh9e/X7Ar8bD9e+brHS0lVRytArbvwolWVrmu2rYG7wUptUZvFO5mRN0A5TMSC4RKe8UVUdP1Gwyjw3utfYy9iN0p9dIXJ4XRNyjQZkXH8ZPmlZa24DN9P/q7rggFcwHDlzlrrxfU0yqGb0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777180; c=relaxed/simple;
	bh=1N2Byx0eC1ctvrepkycVN7CV0VIRrto/LwoVYjl1rrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZRu76b7yqN6A7bDqclVulfsz7DccA/v1bNRxgg/aZP4lsoobzO3c1Bg0uOZZbdEyJu4zlzCAjVv/nXR8x2v+nGW12gzWnJpMJ8NQl9PpSb1ECPE5/kZwoXAJN7qh1D1UYysRoEfZUrRA6KfTveHy0p2/JS2jei3LwddbaDEBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMVFQeqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMVFQeqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2C71F00898;
	Sat,  6 Jun 2026 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780777179;
	bh=PHJsqPZ7ommiMVSku+2Z2QdPFsLLNhvRLuBiaN/K9DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CMVFQeqqDm08Dd+LKONMsujKL86uFmsoVAMPdUORumYZpIEKdoHBJ9QZ3hiHSWEde
	 srYFptDEQzm662UOKyAuDJwdFxujCA+IftLPRWBlGhaCwXWSlvaS3ifvkA7C/tE+oA
	 cX+CdbGv+Nuoq+SVMpVRR7P/YvXDOcglyHFQ7HknJd3Lg7RzYd7QInW/i7jeEr1dUL
	 SkIv8vtDFN2xqaIqZzGSsZBB4Yyi/5pb9svnn/6ba7dADHepHS2AS3W8zrmxlQ2gXb
	 EzsWymow14lsae6l54NymnvKLV9jdsFngdAJFYMqJyZnN7NLlBrYi5NbqjXYw0e1mI
	 oPbyn1WkRjmHQ==
Date: Sun, 7 Jun 2026 05:19:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260606201458.GA1442288@rocinante>
References: <20260606170146.673140-1-kwilczynski@kernel.org>
 <20260606172056.DADBA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606172056.DADBA1F00893@smtp.kernel.org>

Hello,

> > +	bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
> > +	if (!bus->procdir)
> > +		return -ENOMEM;
> 
> [Severity: High]
> Can this direct assignment overwrite a valid pointer with NULL if a concurrent
> creation fails?
> 
> If an asynchronous probe runs concurrently without holding
> pci_rescan_remove_lock(), two threads might both observe bus->procdir as
> NULL. If one successfully creates the entry, the second could fail due to a
> name collision and return NULL, unconditionally overwriting the valid
> bus->procdir.
> 
> Could this cause subsequent child devices to erroneously create their proc
> files in the root of /proc?

[...]
> >  	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> > -	e = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir,
> > -			     &proc_bus_pci_ops, dev);
> > -	if (!e)
> > +	dev->procent = proc_create_data(name, S_IFREG | S_IRUGO | S_IWUSR,
> > +					dev->bus->procdir, &proc_bus_pci_ops,
> > +					dev);
> > +	if (!dev->procent)
> >  		return -ENOMEM;
> 
> [Severity: High]
> Does this assignment introduce a risk of a use-after-free and resource leak?
> 
> Similar to the bus directory, if concurrent threads call
> pci_proc_attach_device() for the same device, one might overwrite a
> valid dev->procent with NULL when proc_create_data() fails.
> 
> Later, pci_proc_detach_device() would call proc_remove(NULL) which does
> nothing. The procfs file would be leaked, and because the file's data points
> to the freed pci_dev struct, subsequent reads from userspace could trigger a
> use-after-free.

I will send another revision to address this feedback.

Thank you!

	Krzysztof
