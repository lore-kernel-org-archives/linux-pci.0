Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC535E95C;
	Fri, 14 Aug 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717974; cv=none; b=tU3txDsQcLwEEkOaUt9BY32HGMYv+sR8P5pwgkHF4h5LuRxXqW3xrjPVKrWhsP3APmYKJgPN011CxV25d8ZpXBnlBg4yGWVOyAaBXQiADvysF2CJH5pVuUQDUxTD6C0DS5rlVLvIWikfUak3h7ZUR43tjlMr60P1SwTBDbR6slE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717974; c=relaxed/simple;
	bh=Ppe4zWINCcH5b2f6yoDphv64Qrb/dTMrYEddNH7Huf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO9JVoUMAxlBDq5ZsOhBRsA4XfqpjoRY3n3anOKkq/4fu/vf3TgdwRHKjq0rWP97525sxmoHCCZJ93yUki/EX5Uv7bpex41FPZAdW8nL0NsXldA7RW9W2TNJNqohV6mLajgnViQgGWwgizksyvvXEVliShYTh0CC7lwuvW57t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQMgfzLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQMgfzLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358251F000E9;
	Fri, 14 Aug 2026 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717961;
	bh=4/uPK4MDzXDsQYo1tVaREhQkVYakh1u6OLghkiUo2DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QQMgfzLCKklFwTf93WC6lT7fFnkQk14voJvliD4BqjTtKs7O+VtzUY8wDdwUAVOPV
	 kPWKayUm8ivWJiFHqlBMH5gY+90aFiQQ98RIc6bJwwxjWnqSKUGtyYIO7cXu+bgQ7Q
	 a0eO2rDMaqPTZ2672sqwj2s8/h6jEMx5ynYoMBC2hj9aDlK1zyTQQN4T6Z1Ogsry6L
	 WHbRkFnt8oWP+rYiIU6f6ASuvU4cV+NYj1+C307I4RQ/cfb9PFn2kGpohEfk0RF4zj
	 Coyyg8zqlTD4WYnfrPk3zbEBhY/u6jbaY6S6rcyItBv8zvcPYhwlUjjeZkRoky0HBj
	 BqCVfy4gCvvsA==
Date: Fri, 14 Aug 2026 16:32:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: epf-mhi: Add batched DMA read support
Message-ID: <b6sdjiqzqibgahny4mkfpwytwz4lsjfvgi2fmcyptzd3rbbbwf@tcitu5fjj2kg>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>

On Mon, Aug 03, 2026 at 04:01:46PM +0530, Sumit Kumar wrote:
> Add support for batched DMA transfers in the PCI EPF MHI driver to
> improve performance when reading multiple buffers from the host.
> 
> Implement two variants of the read_batch() callback:
> pci_epf_mhi_edma_read_batch() is a DMA-optimized implementation that uses
> dmaengine_prep_dma_sg() to transfer multiple buffers in a single DMA
> transaction, while pci_epf_mhi_iatu_read_batch() serves as a CPU-copy
> fallback for platforms without DMA support by sequentially processing each
> buffer via IATU mapping. Wire up read_batch() to the eDMA variant only
> when the RX DMA channel advertises the DMA_SG capability, falling back to
> the IATU variant otherwise.
> 
> On a successful batch, notify completion for every buffer via its
> caller-supplied buf_info->cb, mirroring the read_sync/read_async
> completion semantics so the MHI stack can free each buffer and raise its
> transfer completion event. Make read_batch() a mandatory callback in
> mhi_ep_register_controller(), alongside read_sync/write_sync/read_async/
> write_async.
> 
> This enables the MHI endpoint stack to cache ring data efficiently,
> particularly for wraparound scenarios where ring data spans two
> non-contiguous memory regions.
> 
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/ep/main.c                    |   3 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 159 +++++++++++++++++++++++++++
>  include/linux/mhi_ep.h                       |   7 ++
>  3 files changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 21bc2c50170ff7f0181c0d0d4eefd51db30f34c8..c45240fc481dc3260a61b546c223b6be8e105587 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1459,7 +1459,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  		return -EINVAL;
>  
>  	if (!mhi_cntrl->read_sync || !mhi_cntrl->write_sync ||
> -	    !mhi_cntrl->read_async || !mhi_cntrl->write_async)
> +	    !mhi_cntrl->read_async || !mhi_cntrl->write_async ||
> +	    !mhi_cntrl->read_batch)

No, this looks like a broken client-provider contract. You don't necessarily
need a new callback. Just rework read_sync/async callbacks to accept
'num_buffers' argument and let the EPF deal with however it wants to transfer
the buffers.

If the num_buffers is 1, it can use the existing path and if it is > 1, it can
use the new dmaengine API. Or to simplify further, you can use the new API for
all buffer lengths. Only caveat is that you need to check whether the dmaengine
supports relevant capabilities like DMA_SG.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
