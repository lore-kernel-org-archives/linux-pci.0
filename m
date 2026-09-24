Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC94471258
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249127; cv=none; b=QBJdhJ5dLN/hArbhaVjdIPZEyZh3bRl5vBWtABfVksGRF2FOqJ3YyIjJGSVvDczoN9pvh+3PM/gIxTQW5Nz9pS1XA/75psN6j9n9l//MpoAeZwMiEeFJgGcsp0/N3CMoo5vPr68lPgIjtgf0JydeuDSiDR/l2GOWf+uc0eVoaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249127; c=relaxed/simple;
	bh=JuhL/WoBmcyIFRkma1o1JeCNa0owMmiA3pM0wbgqsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cklkuOgFDPRsf7KicGQ8KH4UmjA922CRHYFIruvsfQtj+rKDKS4xqlzZKEqkb4x3VXnebT3CDAHyR5Y6tkZXoiFtXWtgEhlz9xANcqL/KDqQwqdLTUGeBjmrJ1BVYVUJ+ORm/aGTYnXqAtGMLLV5a+YRjeWcHeEBHK3Q2Pjero8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8ED201C7465;
	Thu, 24 Sep 2026 13:25:24 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:25:23 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, will@kernel.org, 
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bhelgaas@google.com, 
	alexander.deucher@amd.com, mario.limonciello@amd.com, felix.kuehling@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <arUIg2skN9AQNpCV@8bytes.org>
References: <20260824085821.5422-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>

On Mon, Aug 24, 2026 at 08:58:21AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)

Applied, thanks.
