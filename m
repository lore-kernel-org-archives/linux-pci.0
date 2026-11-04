Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827632;
	b=eG19fbT7NSxL1W3Ay2YztMPvZUm/lOS1HgVuB7nRsBEEPThnXrxu72p6hvTv/zNrZ5rH
	 LOSdxdWCTbCtUxpr91nAdpi4rr/2xRNDY9GDn/AooC8IrSsU5Rgw8jQJk00HHM9R4RRNx
	 agBDX7IgGBsYKC2wGDLT68NZBOLwZpvq3Qps8i5KS48BFZohInNftM6VgE+CQ+0f1ouJh
	 PUFIKfVPNCUwLr+AMwwiGIcjo8s3XnosPCyCCFGb3R1ndpSJcy8yn29mUUSoZ6/ewveAf
	 w0zM18u7K2kdDSltdHbJlYW2zYxTN/nn62lptjW60rWu46h/EqygYab12xfByfEekUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xMVyjW3anad3yUouSOpaoPLbg/hGtJeZKhlBpwB0ylk=;
	b=r1/6P7oHH7PujUoJ8PRModmTxyl2EoEMJhZgN/djit8a786RG541IJrM3cUvLPsaVddZ
	 Nq8rtP25gmsLFNYienYWvtTqPC+1ab9Kj050BHlOSr2sB0NWSqBVT57nbOWMxc1B0Wytu
	 t/uPu0NVcfZ+apG4MEP8zzwtFpXdyLSPaGCjOIhlzKvcXD9KNWhHt6bOluoYio8eJ3Pci
	 JGCWctNmGSgK1Vmi9bxIlFTKxZ1tLDehmgJJhOSuSi1tcduDFNlvNuQUU9B0MCeJQuHyf
	 r9ZAe3tCMdXFFb4ekOP243nCUL052kXLuWsW/YbwMiytNU1nGJb0zxDhmKcHUQPCARQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9O2RVWc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B6606B2E4;
	Wed,  4 Nov 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9O2RVWc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B41E1F00A15;
	Wed,  4 Nov 2026 21:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827631;
	bh=xMVyjW3anad3yUouSOpaoPLbg/hGtJeZKhlBpwB0ylk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=m9O2RVWcNdBs1yTan7/gxI3m0dZUHTOrgciJ2PcUqZlpIwlNe80XQDU3Jnj5Zjqha
	 ZMQE8HHIAcGCGDJZCx1PuZlivpyd28fFfRy9CYI+xHPO4LDx2vm9dUfZb6Tss7AFZu
	 EI4b7QcqFBgxQQ8eAhFjsvHjOoW7ptCY+YR6NdZ9umdaikRMMNEds9/op4cV3JA1vf
	 hk/be8LvEroDqm2mAYi0zFmxMbQiMPvZNzceqS0wK2I5SejtOYOwexbuMOd1NF4z/M
	 Mv7EN0ItfiDqJGvWzl4tRW+qAYBw9uSpepS70cL+hQOGxc1yy2DFc7ciO7oj1MLjjC
	 vxOuG+ktAeZQw==
Date: Wed, 4 Nov 2026 15:27:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	"open list:MHI BUS" <mhi@lists.linux.dev>,
	"open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <20261104212710.GA1434725@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>

On Wed, Nov 04, 2026 at 10:01:59AM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

"Prepare to make ..." I assume?
