Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A72FE58C;
	Wed, 29 Apr 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496031; cv=none; b=lABTC0qSt5NiA9F4c9WJ7u08KR8Htrvv+ksW6zpGTea9oM5L8ZjZQ5i/32paH2HomMh1OcP3TRv3JOVLo8Rk4LpJpEEV/S1O1c5xHAuYwG1R8VKHaN78frQtuYjx3K9PeI7ZXpKpXD8K/tk5/WTTIfZqtGKvB3aFumfJvJucAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496031; c=relaxed/simple;
	bh=ySSBeMm1fA1RqiRnJDthA9J3oUOKBjzNQoryOMt06sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYlkVeOuwjCkLXgTTzN7AgkD8oHgMIp+CLQ+wE694uV+ORfG8QzpsANMuj6Ln2o+9ZEDaytNd/mYBygnE/4cb3YDqbXNumNl4NShfUK/T/201o1mjCBb/Z5V6z3rgX520lZWrPd/uz4D3m6DJwf/u+KWCD3B7JaaMzTjqTwE14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkeE2Q5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkeE2Q5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BB2C19425;
	Wed, 29 Apr 2026 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777496031;
	bh=ySSBeMm1fA1RqiRnJDthA9J3oUOKBjzNQoryOMt06sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkeE2Q5PhSo1fLSwyOU6Rr7oJ1LJJ07F7M8zpbaloBd1Fns+uvPnbZqXbnI6B64yd
	 geGahp3c3jNFI7tNH4Y3a+vlogeM02AF1B8DYyp160evSx4JLFlRM9ckCGys/vq8Cb
	 ZQz8ED+SBqW4kMFcwKs29vunitwRU+sP3ZYSDGi2YCokCrjkqDhzgMvIIYZo7pQFju
	 Zs0RMd/siKPi8ncNePAxh4GA2xJqMOeoVBxdw7DegLWJbgf3Iiomi5cVJWv3RmULbv
	 9YmJrAu7h1McIEZlu/kUUCAjF6AnyxZMWfLVXHJG3hhZmOFimv2Lf5s1oacHm84ceC
	 lLMiNDI6Wp6xg==
Date: Thu, 30 Apr 2026 05:53:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Message-ID: <20260429203625.GA3724801@rocinante>
References: <20260422161407.118748-5-kwilczynski@kernel.org>
 <20260429195055.GA312811@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429195055.GA312811@bhelgaas>

Hello,

> > @@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
> >   */
> >  static __maybe_unused loff_t
> >  pci_llseek_resource(struct file *filep,
> > -		    struct kobject *kobj __always_unused,
> > +		    struct kobject *kobj,
> >  		    const struct bin_attribute *attr,
> >  		    loff_t offset, int whence)
> >  {
> > -	return fixed_size_llseek(filep, offset, whence, attr->size);
> > +	struct pci_dev *pdev;
> > +	int bar;
> > +
> > +	if (attr->size)
> > +		return fixed_size_llseek(filep, offset, whence, attr->size);
> > +
> > +	pdev = to_pci_dev(kobj_to_dev(kobj));
> > +	bar = (unsigned long)attr->private;
> > +
> > +	return fixed_size_llseek(filep, offset, whence,
> > +				 pci_resource_len(pdev, bar));
>
> Is there a case where using "attr->size" is better than using
> "pci_resource_len(pdev, bar)"?
>
> In other words, would the following be equivalent?
>
>   pci_llseek_resource(...)
>   {
>     ...
>     pdev = to_pci_dev(kobj_to_dev(kobj));
>     bar = (unsigned long)attr->private;
>
>     return fixed_size_llseek(filep, offset, whence,
>                              pci_resource_len(pdev, bar));
>   }

Sadly, the simplified version would break legacy attributes.

pci_llseek_resource() is shared between device-level resource
attributes and bus-level legacy attributes, both have different
semantics:

  - Resource attributes (resource0, resource0_wc, ...) are per-device,
    carry a BAR index in attr->private, and will have .size == 0 with
    the static conversion.
  
  - Legacy attributes (legacy_io, legacy_mem, ...) are per-bus, have
    no BAR index in attr->private, and carry a fixed .size
    (PCI_LEGACY_IO_SIZE, PCI_LEGACY_MEM_SIZE, etc.).

The if (attr->size) check distinguishes the two cases, where legacy
attributes have size set at compile time (no BAR index), and the
resource attributes derive it from the BAR at runtime.

For legacy attributes, the kobj belongs to a struct pci_bus, not a
struct pci_dev, so to_pci_dev(kobj_to_dev(kobj)) would be a wrong
type for container_of().  Also, the pci_resource_len() helper would
not work there either.

Thus, dropping the attr->size check and always using pci_resource_len()
would break the legacy attributes case.

The alternative would be separate llseek callbacks for both the legacy
and resource attributes, which we can add if this would be the preference
here.

I hope this clears this up a little bit.

Thank you!

	Krzysztof
