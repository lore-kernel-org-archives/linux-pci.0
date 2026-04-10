Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E223BC664;
	Fri, 10 Apr 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821735; cv=none; b=tQoIguiKx1TKYzMErbbSeAa+79sRcfFeKYQ7X3w4whXoHnBDAJHzpSIaxozCj5dBfJbde8oTkMhEM/xofIsodvKE+nol6YEoRjc4wSorX38VceYTQf/Pr1bTANQo6+tkh9DP4dran4rOZr2Jb/PN+LQkOjEVBDqnCyHVfNg6eR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821735; c=relaxed/simple;
	bh=LZilPulN3qlgDY3IxRp/Zcm4TbaTOPqVA6WSuY47T5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD8vKON39QCj4y6ntAs+5P+2elgWe+YVzfq6GepJewGEanUOiD0Iv8U75yJqYnO6k7kgBigz1jpg66OdxoiFZ8vxd84atotCkNC2Bla1Gnoat1zJTX9ogJuxy+8KfSRLBvmySt+hlGso5Et8eRCTMRZvUMGnMTYJDYzVQS5o2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbE+TtYG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbE+TtYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C988C19421;
	Fri, 10 Apr 2026 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775821734;
	bh=LZilPulN3qlgDY3IxRp/Zcm4TbaTOPqVA6WSuY47T5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbE+TtYGOr1Hy4myyKWvvk1P2h7Vxhu8skNaAGe/jW4iBxEEXsK4jt8HwjFzOfbfg
	 V4wQvrxksT9bTS+Ge4keWG1lgcI9FpM+5LZOyo9TcUoB2qPyLMtbnrDGbHNLJPtCSq
	 4IiH5OKUaNI0b9oY2dK1MZA+QquqKwoxA8OMYgRsd6L5/A2Ofe9UNBAjsPd3EfKtCi
	 oYdcZcyaQGv33aiJSdEzhOehJjwJjkzBRTS70S/bCsFy8m4ifTze2+TeeWnC00xN8X
	 49zICxu10mM5Bo7ALz0On5lo6oB7Z6qdXSzOD8v0NKftzd6B80g90n04HBaLinJuhg
	 NuTZwUKrQPU/w==
Date: Fri, 10 Apr 2026 20:48:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute macros
Message-ID: <20260410114852.GA1761359@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-15-kwilczynski@kernel.org>
 <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>

Hello,

> > +#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)		\
> > +static const struct bin_attribute					\
> > +pci_dev_resource##_bar##_suffix##_attr = {				\
> > +	.attr = { .name = __stringify(_name), .mode = 0600 },		\
> > +	.private = (void *)(unsigned long)(_bar),			\
> > +	.mmap = (_mmap),						\
> > +}
> > +
> > +#define pci_dev_resource_attr(_bar)					\
> > +	__pci_dev_resource_attr(_bar, resource##_bar,,			\
> > +			    pci_mmap_resource_dense)
> > +
> > +#define pci_dev_resource_sparse_attr(_bar)				\
> > +	__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,	\
> > +			    pci_mmap_resource_sparse)
> > +
> > +#define pci_dev_resource_dense_attr(_bar)				\
> > +	__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,	\
> > +			    pci_mmap_resource_dense)
> > +
> >  /**
> >   * pci_remove_resource_files - cleanup resource files
> >   * @pdev: pci_dev to cleanup
> > 
> 
> Wouldn't this belong together with the next patch, or is there some good 
> reason why you added them separately?

No specific reason other than to make it easier to review.  The pattern
here is: macros first and then users later (when converting things over).

Thank you!

	Krzysztof
