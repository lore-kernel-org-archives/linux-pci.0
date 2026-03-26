Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9453AF646;
	Thu, 26 Mar 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561136; cv=none; b=rm+6bQHu8KG7vBtj1WUfERgumetQwS9oy+OzhZq6DMs84cb1agaXITRiONeERHyTQpNxeArns/8W1Yf4FjIASfKaE+LpXUj+tcO6OXhvnKcWaxaxOMueEzXi7HFUaRwQw4fnWCfY3TKxMoSJU+kdRzGKw4LPHSq51555CXB8zK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561136; c=relaxed/simple;
	bh=jwsS1BIDUjEh2JcOLMGWa6P9hXlTnFsjvQU1cKg74sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hPlG16JnDbX7N15/0aNKQbhgCeDYuPcuLe1pTs2p0oR/g5ibZ4ChD+IpT4WYIycXiuEiBsQW1mykxP8tD6qGmK1AWU0I9DOUIWIxCASFQEukHD+kcdyN5yzB1XiDHTyi5d7+I9ciQ1GEUrRkYq6sNoY6T1dlhzbU2IV/gXn4Ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNFQ8+yA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNFQ8+yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00AEC116C6;
	Thu, 26 Mar 2026 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774561136;
	bh=jwsS1BIDUjEh2JcOLMGWa6P9hXlTnFsjvQU1cKg74sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gNFQ8+yA0iV42+u/1nLa9TFsqd2jFnZBz2YCSsmPg13bYQaf26o48Mt8GvHkBOCw7
	 k7ntWpcEHz/I4GvrsMPfg5S5Sy3sGcsH4PV5D+k8iMHs7lD2VW+OSaR3uctOiYWuZH
	 9USdHUrv4kIUHcsnXqzvr8P4LEFhkYb4JbehD2jBAsN6Z9iHgZHuX8qIHnTSsOEje9
	 0tZkPRtoXTSMKtKfD5B1OCnpLaL2IKX8bg9HrvmbDKQc2vDIBhj/En5cV+mIHQuWZH
	 42vVeJsoO2oLJb8VOdDAJByl1ufhTqTZZkNCX0VTbNjn0YQ9f8yxDVcnwkL1X4Bvf0
	 hckYQN3z50qDg==
Date: Thu, 26 Mar 2026 16:38:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260326213854.GA1348488@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>

On Fri, Mar 06, 2026 at 03:41:15PM -0800, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> device requests a translation service from its associated IOMMU HW running
> on the channel of a given PASID. This is working even when a device has no
> translation on its RID (i.e., the RID is IOMMU bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
> 
> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> "To source requests on CXL.cache, devices need to get the Host Physical
> Address (HPA) from the Host by means of an ATS request on CXL.io."

Add CXL spec rev, e.g., "CXL r4.0, sec 3.2.5.13"

> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_always_on() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.

I don't think this really has anything to do with the PCI core.
pci_ats_always_on() doesn't *do* anything with a PCI device; it just
looks for PCI_DVSEC_CXL_CACHE_CAPABLE, and the caller figures out what
to do with the result.  This doesn't make the PCI core turn on ATS
automatically by itself, and the PCI core doesn't care whether the
IOMMU driver always enables ATS.

It's only called from arm-smmu-v3.c.  Is there something unique about
SMMU, or will other IOMMUs need something similar?

> +++ b/drivers/pci/ats.c
> @@ -205,6 +205,48 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +/*
> + * CXL r4.0, sec 3.2.5.13 Memory Type on CXL.cache notes: to source requests on
> + * CXL.cache, devices need to get the Host Physical Address (HPA) from the Host
> + * by means of an ATS request on CXL.io.
> + *
> + * In other world, CXL.cache devices cannot access host physical memory without
> + * ATS.

s/other world/other words/
