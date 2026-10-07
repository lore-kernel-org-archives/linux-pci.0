Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A835429008;
	Wed,  7 Oct 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382096; cv=none; b=Isq5jymZYFd0UJLQB921bM6bacmtJwFjzHjNLXTueZ3jvSG9RUUChqU8qTjGnkUSiirz2FslrpVJRpXjcPgNgzlnuSntMhA/bAINXa9bv3GAmvjbrlhkUGI/JYnM3iDUDs0zMVqC3lmLKyjsfzqROeUVBBN4hsvtpJeoWz2hL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382096; c=relaxed/simple;
	bh=HO8C8ezf24ssF3gNtfd8uJduENm26rW1gdxk+JY9AIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAzz5ny7wODq8UjONzuehqjUI8OoDPHhW7MZpLeevS6ay1oCYlOJRL9AUR/zr/99kpytlA67C+1taE1faUSUFbBE+wszehNp/LIJVj4ESAzrly7u7g4QCenE8w15LrkjBvMg74CNA9GuZ5xgwMmGQAZIKLPIdf27rTxuP/3udX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeeiWSyB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeeiWSyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019261F0089B;
	Wed,  7 Oct 2026 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382087;
	bh=69NaiJVqu5bg+To8yBMQFs2+GW7aydRDIQK7Ds7cXho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IeeiWSyBQQXhV+uIhk7CGTX1fVyyDUKx6PTt6U318ev+VeKcVXv5uUMHUiJrcNIN1
	 3D0cFXpDvV+QrFWsMpGj/x4RgpGma3yJPZ4gv+wfdK4dXlsX4g5ik7fOFX4wbGXEmw
	 WA3XdL21KYOF9fMvHWZS7dp4vyqBoHBmUFBi6SOD+uj1FZE8kHAfXpimfP+2wV6aQj
	 l8OyX2hpVR+GyQ0E2C/4/BwDxQ44IO2Pxf26p81yCPtVKmEEuaW+Zn2GJu2ajG59w3
	 AjGc0wtidHjPZv7xT8zyHaEfBRlbISAZnJZNVA6T/y2LEzewgoMqz8GJgpTI6w7UCI
	 Jpqu8eDLhUhuA==
Date: Wed, 7 Oct 2026 15:08:01 +0100
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
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <asZSQRSYBjbUaaH0@willie-the-truck>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-12-praan@google.com>

On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> queue's producer index to safely gate command submissions during device
> suspension.
> 
> The flag embeds the suspend state directly into the existing global state
> The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> which acts as a Point of Commitment, ensuring that no indices are
> reserved or committed once the SMMU begins suspending.

I'm not familiar with the term "Point of Commitment". Is that something
you came up with? Without a general definition, I think I'd prefer to
avoid using it, especially as it sounds like something to do with the
Arm memory system (where we already have architectural terms such as
"Point of Coherency".
 
> This prevents a situation of "abandoned batches" where indices are
> incremented but commands are never written, which would otherwise
> lead to timeout during the drain poll.
> 
> Update queue_inc_prod_n() to preserve this flag during index
> calculations, ensuring that any in-flight commands that successfully
> passed the point of commitment can proceed to completion while the
> flag remains set.
> 
> Suggested-by: Daniel Mentz <danielmentz@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a123810fac57..7f89e2306942 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
>  static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
>  {
>  	u32 prod = Q_POS(q, q->prod) + n;
> -	return Q_OVF(q->prod) | Q_POS(q, prod);
> +
> +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
>  }
>  
>  static void queue_poll_init(struct arm_smmu_device *smmu,
> @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	do {
>  		u64 old;
>  
> +		/*
> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> +		 * our new indices yet, we can safely bail. Once the indices are
> +		 * committed, we MUST write valid commands to those slots to
> +		 * avoid indefinite polling in the drain function.
> +		 */
> +		if (Q_STOP(llq.prod)) {
> +			local_irq_restore(flags);
> +			return 0;
> +		}
> +
>  		while (!queue_has_space(&llq, n + sync)) {
>  			local_irq_restore(flags);
> +
> +			/* Avoid waiting for space if the SMMU is suspending */
> +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> +				return 0;
> +
>  			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");

It's a bit grotty to have the extra READ_ONCE() here. Why not make
arm_smmu_cmdq_poll_until_not_full() return if the stop bit is set?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index deefb17e31eb..794b258550dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>  #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
>  
>  #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
> +#define CMDQ_PROD_STOP_FLAG		(1U << 30)

I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it's
plausible that the architecture allocates that bit for something in future.
For example, if the index field was extended, then I think that would
cause problems for the driver.

Do we have to put the stop flag in the producer value, or can it just be
a flag elsewhere in memory?

Will
