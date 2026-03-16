Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF43CF66A;
	Mon, 16 Mar 2026 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680723; cv=none; b=lB9KrIhCpcFYUiFY+Mq7zFemXK42+CIavWYyZ4v4IAIBNH/MCj6r3Zd+lmVSwzEullLMNC0ajbHrZbUMhrTQh1kM5500Uy8b3rrGyqSag3ycn3ocfTjghxIh598MC64T2kWUQOIS+zaPJ0D9GcpvCCF0v4PT8vBbbHnsdA9g8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680723; c=relaxed/simple;
	bh=RR8yRRstMrDP2gNNvqLoXBGpFLpPU/oFqyQSNNcRK7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz9X6nddDHIutubLAmcI2UrZOl0R9kchB6+LG1ua4OmsNPLwlYcIVeS04qi5nrPsSFVXQeGFthCCviWLq2ALEXzW54zlBTQoA6fXPdQbV6+4HTw4KgOCoENi2pz12NlWFAabEXXZZj1PFo1C47vGqFLiB+9UP5zbdxH8J12y8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI6A4DYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI6A4DYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE79C19421;
	Mon, 16 Mar 2026 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773680723;
	bh=RR8yRRstMrDP2gNNvqLoXBGpFLpPU/oFqyQSNNcRK7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PI6A4DYIIJVDPZVp76ofXTcaWqEOM5jrfxrsoYOt91WFyAUXWcrjKGokJCWZyY0ua
	 +BZy8sGjCR77mRqFa37R+EiLzfwAibvzu47dj4o7pj/msFimTkdxvZcfgkesVXRyrr
	 h8DdHK68gEkVttNw4+f7qmJYEi/g+TbenraEjnu7nF3LwpiEOhm7znESBrFP1BRHhF
	 YoNOCbpOAc8qLNH/wwWWB+ZWD4v6Im1/BWoHLKBs5SNOgWE8KNndfvlP0FEUnMOhtO
	 VmDrckS/ZQymB01HxMMM/03UIJdAMgmpniFhGKApUVx3bbyU/LaCv8krbHq42WlzKA
	 9lmqI1FpH5uuw==
Date: Mon, 16 Mar 2026 18:05:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
	Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
	Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/3] dmaengine: Add multi-buffer support in single DMA
 transfer
Message-ID: <abg4EnbRUz7kjxjQ@ryzen>
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
 <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
 <ab632240-f4eb-4bcc-8170-2a9a024c1ce7@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab632240-f4eb-4bcc-8170-2a9a024c1ce7@arm.com>

On Fri, Mar 13, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
> On 2026-03-13 6:49 am, Sumit Kumar wrote:
> 
> If you want to batch multiple
> dmaengine_slave_config()/dma_prep_slave_single() operations into some
> many-to-many variant of dmaengine_prep_peripheral_dma_vec(), then surely
> that requires actual batching of the config part as well - e.g. passing an
> explicit vector of distinct dma_slave_configs corresponding to each
> individual dma_vec - in order to be able to work correctly in general?

This make me think of Frank's series which tries to create an API which
combines dmaengine_slave_config() with dmaengine_prep_slave_single():

https://lore.kernel.org/dmaengine/20251218-dma_prep_config-v2-0-c07079836128@nxp.com/

Not exactly the same, but might still be of interest.


Kind regards,
Niklas
