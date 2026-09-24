Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB4391517;
	Thu, 24 Sep 2026 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250709; cv=none; b=sVinKxvk4Yqbh8LUX44BmLMeYu0mno02Y0fK6PqkWQ16FtJH7CKEepwqq+Kvx+rMI/kZlGNnhPLx+4Iqc9KQwUJnK/+tn4xx/Ylci0IBe1ncSILZko0vsjcSV3y/9Jyt7W9DEoKieVbZrh18qoDzttqkjSwyKd1h3LHUfeEsAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250709; c=relaxed/simple;
	bh=qak65xYr5fyG8nUF3madQn7c9vSGyPs+xf5ocUGcHPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XglLyzysOKcFmmH4CeX1t3tJxC/Ocrsw//VPsklvqiqKRRLCd8ollFcybZ4/wIAd0EhhEmPvx9CpwXKO+XoQj4+7dXAST/fKv9yZdkkz5tVTIyXii3yxrl9y2ImSLk8SCbAUaUXgUUasgHyvKH6YbbYaJvzU6E8HFjqSApWvL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A144B1C7465;
	Thu, 24 Sep 2026 13:51:46 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:51:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v4 0/4] iommu/amd: Refactors for ATS robustness
Message-ID: <arUOoLwpfNlIvIXy@8bytes.org>
References: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910142655.3281464-1-praan@google.com>

On Thu, Sep 10, 2026 at 02:26:51PM +0000, Pranjal Shrivastava wrote:
> Pranjal Shrivastava (4):
>   iommu/amd: Refactor device probe and capability initialization
>   iommu/amd: Remove iommu_ignore_device()
>   iommu/amd: Fail probe on ATS configuration failure
>   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> 
>  drivers/iommu/amd/iommu.c | 164 +++++++++++++++++++-------------------
>  drivers/pci/ats.c         |   6 +-
>  2 files changed, 86 insertions(+), 84 deletions(-)

Applied the iommu parts (1-3), please submit patch 4 through the PCI tree.
