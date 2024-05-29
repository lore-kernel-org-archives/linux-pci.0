Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832701836CC
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003517; cv=none; b=IghzJyZo3TTNAFFppZjVGurEfT2AGGTahCG+tLS5Wy1CfpXXGCXY1TsRrAJhdL/3DPj6uaPyy5hEHaPfTWVq/nclIp6mPEXGCK8BGKFefacOpTw6UYm7vw+FRVy/sGzmQgfa5FtRAzSHZG3GB6jVGpT4Nxu6XbsZ9wo/UqYiuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003517; c=relaxed/simple;
	bh=9gENZU4qgvDvGFXncQIZb1NPNOO0uyyi2OCiPQBfPDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fsj8UpM4IItkmgi5+93uU93PSGEhenOi+4ssEnOulj6jyorg9Zh9W0lqQa5xJwAV1dwXRIaRno35Gp4H6jcKRcyI/nJ1E0abazMP/qFg52+/39zFRcsz2MJrimAd89JiUnfWmzX+kowm2NTNLQjEyhgGPzJsEMgyQ8PycBvTT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/U5JWRk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/U5JWRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5198C113CC;
	Wed, 29 May 2024 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717003517;
	bh=9gENZU4qgvDvGFXncQIZb1NPNOO0uyyi2OCiPQBfPDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g/U5JWRkV3LsICMrZszkYQHUYz28L3Z0KPHsiCTbHkokjWrDjSlXpbi32Gi4OATAK
	 uL2YZkjnYFJVg3mKOmNcDGtLQBrwtRrT3ByQA+oeHIwtADgZtSeevoUxRoSg5vDSga
	 eLtqTWnSas1w/mMtCGcsdXk/m60TgUcM92bf9LAYAwYbdJqU5D+yEIh6i24ucPkZAS
	 Rtv7bDgOGENbxSIVBvK0BkZVofA/fiis9nCOOubs8YYeq9VAbjzZ3qEJDXAMvKqlS+
	 o7j6A4OgIov1ICBXVbLgyl7z4yHxd6IpVlwKNGmn6o+1MoXrZrBNK78jbJIybm6//f
	 FhMeLPy5aOqoQ==
Date: Wed, 29 May 2024 12:25:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <20240529172515.GA511985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldBwUwyekUM-b9i@ryzen.lan>

On Wed, May 29, 2024 at 04:54:57PM +0200, Niklas Cassel wrote:
> ...

> We should probably also address Bjorn comment:
> "ls and qcom even use *both*: pci_epc_linkdown() but dw_pcie_ep_linkup()."
> 
> As far as I can tell, it is only ls (not sure why Bjorn also mentioned qcom):
> drivers/pci/controller/dwc/pci-layerscape-ep.c:         pci_epc_linkdown(pci->ep.epc);
> But this should probably also be fixed to use dw_pcie_ep_linkdown().

qcom_pcie_ep_global_irq_thread() calls both pci_epc_linkdown() and
dw_pcie_ep_linkup():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom-ep.c?id=v6.10-rc1#n628
