Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FDE342515;
	Thu, 28 May 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953743; cv=none; b=QBACrKrW8t65yGrl/zG6HIfnpPX7N/phxq5Wis1B2u2ybUxTsP7PmyXfhWc92IWV2Ty9nV8LPxhMnQDN8CLQSNo2wiCz3LPKZDcSffowyCGpmPILF9pXE6qRv1m84kPt8k6d7A7fnCvuEyO8Trc7idXJVxxHPxoRlLSwS1G6hZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953743; c=relaxed/simple;
	bh=vIm4S2bJbOGfSBK+nClmoRt8k8LN0uFkwS0Eno9HSXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d41P1XIQI/lLb3yLQT3/94ewJJpY+XwGf2ez1ImF+PgIf6P//jg7kqbg2o0hxZV7V4KjmupdZCJLrLFLCgnrXQDlmLfvpbu1WTqO3Et6H5Ue7JAAufiddM2bGhQHmbOoXRMFRuqGmD19AWf9dUvW/KhCw6H/B1+Ze3bv2CcP+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7F4DD1C5BA7;
	Thu, 28 May 2026 09:35:40 +0200 (CEST)
Date: Thu, 28 May 2026 09:35:39 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com, 
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, vsethi@nvidia.com, linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 0/3] Allow ATS to be always on for certain ATS-capable
 devices
Message-ID: <ahfwOTzAWdZ7v-Ai@8bytes.org>
References: <cover.1779392420.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779392420.git.nicolinc@nvidia.com>

On Thu, May 21, 2026 at 01:34:19PM -0700, Nicolin Chen wrote:
> Nicolin Chen (3):
>   PCI: Add pci_ats_required() for CXL.cache capable devices
>   PCI: Allow ATS to be always on for pre-CXL devices
>   iommu/arm-smmu-v3: Allow ATS to be always on
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/pci/pci.h                           |  9 +++
>  include/linux/pci-ats.h                     |  3 +
>  include/uapi/linux/pci_regs.h               |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 81 ++++++++++++++++++---
>  drivers/pci/ats.c                           | 47 ++++++++++++
>  drivers/pci/quirks.c                        | 42 +++++++++++
>  7 files changed, 175 insertions(+), 9 deletions(-)

Applied, thanks.
