Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60B349B0A;
	Fri, 12 Jun 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274859; cv=none; b=sL2bDAWt6yBCch7V+R/qi88+GQQoPgMVtXWarGZblxMKtXY0SjjKKb8MVNz5mq9pjlktrBv56ewS06WOPN1jRBd7eu2cgHy3lprAl6SdJp52tPBNrIR4uH48LaDqobFUbPkQjsUAi8GPTybKlav60/jFU2g7xHEhbrj5AZRxl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274859; c=relaxed/simple;
	bh=/QcgNYic51Snudd6fmT5+LeZSzNWftySSAX3JnUWy2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V4GRByLEeUW7Mdu2L/ofcMaiHbenZPLmYfcDfguiG+P0G+64xCrreugtJ19Sc6xrkTO4LLHIXRFsdF24J+eReSQs4rw9yEAgVXKURxhNLH9DmC13JlVgBcGlrk9Cu27sn/5vPbIX9l+G46Xvx95hiXjY+AQklIb4bA7p/XZj9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDnrH2xF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDnrH2xF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62061F000E9;
	Fri, 12 Jun 2026 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274857;
	bh=UInyQCNLuDMGn5ILiLAJOQurq7nEq+8rRLXQY88Ob1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IDnrH2xF0kKxSaPSKVQNGsBWLdKBIuLnoNZXPac3PyxErTLTtVVF2G70YwfGtNUX5
	 6KcZ5wlq5NCPR9s4Ybr60TFfqbUVe7s6FRXS24NixE4LyrjcvTa9tOg0VvXM/gNp9C
	 PBXI0jQ2PhBrrqzTmew8b8V8bEuZWDhXp2ZbKbEfj0a41wwx3rcR+tKAiQHs3mRHWG
	 MfE8c1fsSxaW82tNXGPiX+tfMehDyvfYa0tTj9qlcISa7otQZZRfRMeu+UfZbmOx/t
	 nXmYGPoI/6LgJbayHa/xbwfJhVvDWZc6mhcdtYkNTmhnfR23C4kblGcr54U2ffdgy6
	 RLZ+7r7x4s7mA==
Date: Fri, 12 Jun 2026 09:34:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 2/4] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <20260612143416.GA599694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-3-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:14PM +0000, Pranjal Shrivastava wrote:
> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
> 
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.
> 
> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 679a3c3c1d54..9cb23780093d 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -73,8 +73,12 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
>  	if (ps < PCI_ATS_MIN_STU)
>  		return -EINVAL;
>  
> -	if (dev->is_virtfn)
> +	if (dev->is_virtfn) {
> +		if (pci_physfn(dev)->ats_stu != ps)
> +			return -EINVAL;
> +
>  		return 0;
> +	}
>  
>  	dev->ats_stu = ps;
>  	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
