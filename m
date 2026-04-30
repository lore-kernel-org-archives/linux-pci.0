Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D907282F0C;
	Thu, 30 Apr 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591954; cv=none; b=JehnLWmf9GILZOOl+oGvuI6WnSzuZ+ikLqxlmycdLPpRw4Fa3XKNz1I4JSFRw5NL+8iXNrao3iU31l7kdepiagK8M5KsGLs4etCZ0mhz2AybHsHnZOYFigysT3kI5kJ//nfDZIA4hn5G3pT2FrZpv2un7e9kCYjhj+JCOOGcRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591954; c=relaxed/simple;
	bh=vnBYxUC+9YLt4GbugUxdFgg5DUIjNo5beM9TG7+8oZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2SiAfLY99I7PuGt0lR9vkt7QGLa6Hd40zaCfwlZvCUFeipFOfeMFZ7hh25jl1K4vXxgQLkHYOX12eGDsijTypDH1VF7H006cdbUpyvJCM08sAtKSeM1I6XOvKIg3OVxo8sQEcQ1XPrJh73JB83weoj+k0XldO2hovd/pYDEOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j41sztTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j41sztTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6B5C2BCB3;
	Thu, 30 Apr 2026 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777591953;
	bh=vnBYxUC+9YLt4GbugUxdFgg5DUIjNo5beM9TG7+8oZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j41sztTrnonOcGk4i7hFsn1OZj3ZVxBy22IOCYM1FPKjwTEchsNZvGR98gfhppo7Z
	 bhMXUaF1QclCYPFnZLBEwnmgWNs9TNJKsNh62PUD+1RlrE+aVZtcf1tAnhKN0pHP0O
	 yAe89bCvd/XV8/o1niZkrvGAznRCvRcDTVwe9cRO5lqAcR0ymTWO5snVbBDEV6j9RQ
	 buECZri1HuzCD2UhkhlPV7LZ9sIYFvScZrLTA8roeUusZ/5dftl1JFhLO1UQIUVtyQ
	 CkNJcOdJYDcuiZpOOCg3OdUweENzWAF3hk1OP9FMM9xgnyLYbjwTBh0HUfjqVpvKvX
	 icZ1gke5AIg8w==
Date: Fri, 1 May 2026 08:32:30 +0900
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
Message-ID: <20260430232202.GA3577346@rocinante>
References: <20260422161407.118748-5-kwilczynski@kernel.org>
 <20260429195055.GA312811@bhelgaas>
 <20260429203625.GA3724801@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429203625.GA3724801@rocinante>

Hello,

> The alternative would be separate llseek callbacks for both the legacy
> and resource attributes, which we can add if this would be the preference
> here.

If we were to do this, then it would be as follows:

  static loff_t pci_llseek_resource(struct file *filep,
                                    struct kobject *kobj,
                                    const struct bin_attribute *attr,
                                    loff_t offset, int whence)
  {
        struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
        int bar = (unsigned long)attr->private;

        return fixed_size_llseek(filep, offset, whence,
                                 pci_resource_len(pdev, bar));
  }

  static loff_t pci_llseek_resource_legacy(struct file *filep,
					   struct kobject *kobj __always_unused,
                                           const struct bin_attribute *attr,
                                           loff_t offset, int whence)
  {
        return fixed_size_llseek(filep, offset, whence, attr->size);
  }

Each callback would be placed within the corresponding #ifdef block, so one
for HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE, and the other for the
legacy attributes, so behind the HAVE_PCI_LEGACY guard.

Note, the names need to be different, as some architectures offer both
type of resource files, like PowerPC, which defines both the HAVE_PCI_LEGACY
and HAVE_PCI_MMAP.

With this split, we can also drop the __maybe_unused annotation.

While I wanted to keep the changes to only what was needed for the
pci_llseek_resource() to cover both type of resources, it would be
also fine to have two distinct callbacks, too.

Thank you!

	Krzysztof
