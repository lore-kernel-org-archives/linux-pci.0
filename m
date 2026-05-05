Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD152F3C0A;
	Tue,  5 May 2026 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023159; cv=none; b=npalkWcdC+u/fqbmf4xoA31nMNMTMaoZpgZ/b/ggVimbINLoUazE2UeeWwKhugSquAvWHpUpRromIagXQ77dFsa3UeEJzM4uP+Awn1OOuIGCj5S2+klJsI3SrnvVI7D0jVC01pPf8KeAw3Z3CCdgMGlE9ee7V3EJbFMUaZYL4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023159; c=relaxed/simple;
	bh=aSUWwvC/Z4hL7kLLz0uyOBLteb3wXBC4iS5QzbWk3v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQrtgLRybCQoci2Bzz07meeMwyKdOr7nwmQJDC38kTf5soKPi7u8hgSivcLCZixE2c+3G1c3CYVOJOVUJQGvKzBm3WEyq5ofBX5qqGHSUa1s3DzkFG7ujJHlAogDCXSDaoWRFZZUwDgY2A+ZOru2X0qd0Kq01tQn49X0xG4+gog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1irtPcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1irtPcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4AAC2BCB4;
	Tue,  5 May 2026 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023159;
	bh=aSUWwvC/Z4hL7kLLz0uyOBLteb3wXBC4iS5QzbWk3v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1irtPcpfqHFY1VDM3K8ELysNJFq/zwjdjMpTSwrQSsgIhrG3hD4jfvtldFC0r+B1
	 Qv32FF7xVtw6QRvptdGazbpcqIAhhypVAB8rtdLVu6PxiwFnf4vjsyV7QJL1J2CRmP
	 gaGXGGDc/YsWmrSzjTsD9VdsETYnebTmntkloGM1/R9AvdXITa0lDE606YYADj3Y3b
	 l6G78KuaByZtWVEudnARiWkGJ1SlPCckAQciDPSAjljBHmkz3gabvnVoKik1123AyO
	 HnhTR4xt3ZxAaSeWmecxnGt13CJqKt+ps/vRL8UBweVmXQNoh0w9tjSKs0/NAH8uX4
	 nVitbO6Aijv0A==
Date: Wed, 6 May 2026 08:19:17 +0900
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
Message-ID: <20260505231700.GA1410272@rocinante>
References: <20260430232202.GA3577346@rocinante>
 <20260505214659.GA752301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505214659.GA752301@bhelgaas>

Hello,

> > > The alternative would be separate llseek callbacks for both the legacy
> > > and resource attributes, which we can add if this would be the preference
> > > here.
> > 
> > If we were to do this, then it would be as follows:
> > 
> >   static loff_t pci_llseek_resource(struct file *filep,
> >                                     struct kobject *kobj,
> >                                     const struct bin_attribute *attr,
> >                                     loff_t offset, int whence)
> >   {
> >         struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> >         int bar = (unsigned long)attr->private;
> > 
> >         return fixed_size_llseek(filep, offset, whence,
> >                                  pci_resource_len(pdev, bar));
> >   }
> > 
> >   static loff_t pci_llseek_resource_legacy(struct file *filep,
> >					       struct kobject *kobj __always_unused,
> >                                            const struct bin_attribute *attr,
> >                                            loff_t offset, int whence)
> >   {
> >         return fixed_size_llseek(filep, offset, whence, attr->size);
> >   }
> > 
> > Each callback would be placed within the corresponding #ifdef block, so one
> > for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
> > legacy attributes, so behind the HAVE_PCI_LEGACY guard.
> > 
> > Note, the names need to be different, as some architectures offer both
> > type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
> > and HAVE_PCI_MMAP.
> > 
> > With this split, we can also drop the __maybe_unused annotation.
> > 
> > While I wanted to keep the changes to only what was needed for the
> > pci_llseek_resource() to cover both type of resources, it would be
> > also fine to have two distinct callbacks, too.
> 
> Yes, I think this is much more readable than the "if (attr->size)"
> check.

OK.  I will switch to two llseek callbacks in the next version.

Thank you,

	Krzysztof
