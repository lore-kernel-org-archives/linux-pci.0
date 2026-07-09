Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CA3E44EB;
	Thu,  9 Jul 2026 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584688; cv=none; b=B3o9pOml3WAmp1qo8vE6kLY1tU7QUUag3rS9W7isFTJqUyga4+owgUJSTmjAmJmo5RBM/+BYzy8463BtMjnSJkfaJOC25suC/mb3qW7mqfvfcF+bd70LYo1H9cxAMe3fzyYqLNF0rrf6Xa3MXwWqkTxHHxELyWrdwFUiW+jbHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584688; c=relaxed/simple;
	bh=IbUMjf3OOf0mIv7PIz8HIry4C0huZCkhRlRItJfU1Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYAtTVjkJV3H+t0CfEWEAL5iqhdsZKoA8Ah2vOGHlDF6rcu8H3WYZy/5k5kNcLfXyQ45ZsmSdOy/01XPd/kxxQPtq0/K+w+SCQAEBKHmpd2gvURurfeHORx9ls2bpHX4aGEheIJTHWq6/fjAh96nqvIq21p/hbB1ulzbrvfmx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EB8CC203552;
	Thu,  9 Jul 2026 10:11:25 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:11:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v9 0/4] iommu: Standardize ATS robustness and state
 tracking
Message-ID: <ak9XnCpWAqaMcFk_@8bytes.org>
References: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615235037.259909-1-praan@google.com>

On Mon, Jun 15, 2026 at 11:50:33PM +0000, Pranjal Shrivastava wrote:
> Pranjal Shrivastava (4):
>   PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
>   PCI/ATS: Validate STU for VFs in pci_prepare_ats()
>   iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
>   iommu/vt-d: Fail probe on ATS configuration failure
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 +++++++--
>  drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
>  drivers/pci/ats.c                           | 13 ++++++++++---
>  3 files changed, 29 insertions(+), 8 deletions(-)

Applied, thanks.
