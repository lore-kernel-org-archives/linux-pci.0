Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333104218A4;
	Wed,  7 Oct 2026 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382065; cv=none; b=siM6KbfjL2J5s2WX+Kpob9a2JySLznPAsYHQtM13uOL2PFxyXsSqLQ1ftkHxrJ8+cNvAMGc7Wu8sqI1G3FJhG/L3dkPb+3xalBRRGjlUa4jwahfe8m5o2nnf8b+U0DoDShbjhh2Op7dpuKQfhnaaFknG4vPGDGjLX5UHLs23pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382065; c=relaxed/simple;
	bh=mCBO9uAWMbBWnAIv+p8uJM32klftueUB3gbDCUVgvNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkPCtWGKmyEKHrfrL3+dvlJd+4Y45Ycg8YUCAfcOQPBnlUUPfLNgrLep4BzsrSM1seFRknr9ejEmO23ix2s6tN4CnVnlplPcT6vBZXmifb4+xGG/cYK2OYU9d26jmEwHI/wY6e5JGI05LUqjbXWci/9HEHfEQFVK4zXxRcl587Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyFCCcBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyFCCcBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B91F0089B;
	Wed,  7 Oct 2026 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382054;
	bh=bOAv0R3ZhwJIJUgI99yXwYkreNKP5pjHIRNnaTrY9Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eyFCCcBJRgoHWtSILSChmLCTdptTF0dqOismLghOMQPjOc86+n6D6Y5a0QK8wLk6H
	 /zj/LHEGXw1LO6uai8bKNky2WbsUxJ1FqboclhLZhHSWtqIUXZMRuXcNSmVK3UolcI
	 c2aYHTrSXa58igX39CvzUfTEoJH2tzQr8nlmDsoXYRCOXAuFAHgq1J6kZwvQTK9CdD
	 A5ASMCTRmuHjXFaTNmxeqHj1wivmBY2fUg7dXgK3iylM9LhGKTaJ4LIyFIOxSpQ1qS
	 Jc7t9M7ZBcj/Ds2ee8WrL0cYaM1vvCX75V4xXcHhlrBpAIz/S8wndPXQdaZ6rKgr93
	 oOvKrAvpQhq+w==
Date: Wed, 7 Oct 2026 15:07:28 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <asZSIFKz-x-C_tJh@willie-the-truck>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-11-praan@google.com>

On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> The GERROR register's state might be lost when the SMMU is powered down
> during runtime suspend, requiring the suspend sequence to handle any
> pending errors before the hardware state is lost.
> 
> Refactor the gerror handling logic into a helper function. Subsequent
> patches will invoke it from the runtime suspend callback after disabling
> the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> before the hardware state is lost.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7347d3ecdae8..a123810fac57 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2406,10 +2406,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  
>  static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
>  
> -static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> +/* Lockless; must ensure that there are no concurrent callers */

This comment doesn't add an awful lot imo. You could probably say the same
about many kernel functions and this isn't exposed outside of the file...

> +static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
>  {
>  	u32 gerror, gerrorn, active;
> -	struct arm_smmu_device *smmu = dev;
>  
>  	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
>  	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
> @@ -2452,6 +2452,13 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  	return IRQ_HANDLED;
>  }

I think it's a bit weird to return an irqreturn_t from a function that
is now going to be called outside of irq context. Also, it looks like
you end up calling this later on after you have drained the cmdq, which
makes me a little worried about the case when we can end up calling
__arm_smmu_cmdq_skip_err().

Will
