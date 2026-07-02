Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E731A549;
	Thu,  2 Jul 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007207; cv=none; b=IzZ8E4zYMeL1Rt/V0BYOy62xbjl4pOM3OlHaCCjFVwXUBrvVGn7kaT6SRmc1qhPibDWQJGO049kzEqAtQgHUlOUsMnoBMqv1WDZUr/RvuinSqL5bIfHA2jtE9i4hcsswmCpf0ub5e+eADQDPcRrku2MazUBwxXU9NGegMc9aue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007207; c=relaxed/simple;
	bh=BpqZXQ7tSLN0BXpsRqxL1k64attfyEvZ0QKJFK8v+XM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hC/bQcj/Sax9EYAlN3dlx2Ma3YCD8B9+fVglM0S7JkN8wf9OWYw9KfU8XRfGgfPr8OgslX51SwVKyfQSdl6HinWIcj60Ua2/pSl3/ptGMb3p2A2Ai4Hoy/KM9esaj0xuSfpc+mxmTF69gjzvSV6qv7UM9LcQNJ9Og+R18EXCnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=NMJlC0W9; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NMJlC0W9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=kyJzbfSqoUXaNBv1Ig4SDg9TeDVODqylZdwHs0c6zpw=; b=NMJlC0W9kihForMdCYYnlLUQ6m
	Eo6IW7rO0b1c3osWSWCUUldacbvkYcIHJHIs657/dhe4oEXiTtpTQ/dWk3ifTTLUQaEbidde5h+Za
	PcycMOPmLVTwDWHJQDPiDcGfQFjTrxGqlbaAn1kK1DM5rhbiznK9fasb+RfVbru6MJxXbEPCEc2BB
	ISWRcrKmHu4YocW7NLlTKBCzF8RiOcqDAlrl1qmazF+AWcg8m31/uJD0FplDbG195cflmPyzGuwqL
	1GZfpCJbvEWPB56K9HdzIMLEdCpT6Q5vbDcy9K/PQB2P0uo3+xF6t8DCMd8+dsioqd8R68fxzYcGo
	8krZuUbA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wfJcc-00000006yLj-3jeO;
	Thu, 02 Jul 2026 09:46:39 -0600
Message-ID: <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
Date: Thu, 2 Jul 2026 09:45:38 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260701171245.90111-3-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org, jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com, kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org, ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-01 11:12 a.m., Matt Evans wrote:>
>  PCI POWER CONTROL
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 33c88432b728..59d70bc84cc9 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -206,11 +206,7 @@ config PCIE_TPH
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
>  	depends on ZONE_DEVICE
> -	#
> -	# The need for the scatterlist DMA bus address flag means PCI P2PDMA
> -	# requires 64bit
> -	#
> -	depends on 64BIT
> +	select PCI_P2PDMA_CORE

Can we remove this dependency on 64BIT? Althogh it looks like
af2880ec440 complicated the issue a bit.

If I remember correctly, the original reason for this is because on
64bit systems dma_flags fit into unusued space in struct scatterlist and
on 32bit systems this space didn't exist and thus adding the flag
required increasing the size of the structure which wasn't desirable at
the time.

But af2880ec440 introduced CONFIG_NEED_SG_DMA_FLAGS which doesn't depend
on 64bit which means if CONFIG_IOMMU_DMA and CONFIG_SWIOTLB are now set
on 32bit systems that structure will grow quite a bit.

So maybe at this point it's fine to enable this on 32bit systems and we
can remove this requirement. However, I think we should do that
explicitly in its own patch, not hide it in this refactoring patch.

Logan
