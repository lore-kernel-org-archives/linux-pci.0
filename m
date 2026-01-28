Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA33612E2;
	Wed, 28 Jan 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608626; cv=none; b=dGYuhr8Qqed5HdeYZII1dLms30pFzHM9fcUvyYn19caWb7enM00WgMDmENON/g0jUuZnKFy0E42yJ2UDi7DmgViYU1JaPRWHRumaiCPAH5giTD7F7mOyT34SozkmiJDh8yoOiJCUa/yGOhx3iXfOsEV76pbi/fGAQ2q1IP+4rRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608626; c=relaxed/simple;
	bh=NAxp+VOarTvsxTlKaCSzNnAI6veRf64omEXDPHLS1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeNqH0TdgtqfedXQWwaZankacRfjHkt4D0KH3QwXGUu6Dg+yIozeYw7N/k+aWRqG5i05M5UVmHewaSszFJXaAObJNpMZXK7xilqGBzQyOmN0dQsHusBHoTxLqPJsTWJwoQkfRAB/TPXmympeACgP4z779QdATxg04QTZ+PfM84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSGWT4Sy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSGWT4Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC75C2BC87;
	Wed, 28 Jan 2026 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769608626;
	bh=NAxp+VOarTvsxTlKaCSzNnAI6veRf64omEXDPHLS1dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSGWT4Sy6W6YR+0MWo5s2ccUNM962r+AilpFjeB1Xkl4UFtlNlE1qYasJA0uGw4Lb
	 E6aEFwo/vkjidQ8Q84yKrfltK+SU60NWBQsyn/S7c+vXMcT+RDkcpzD441r3Zron7D
	 qEtt+O5+iEOpDQImCZGqiNOFpgH1IDPZ+wnTy7Api/v5KUwKokH0SArq+C8grfggRR
	 QTE/7+2/2nXPohx5zZN3WudSMq0nc/tcm4p/3PoxHPNRcZaaxCMQyllam0mVFvtBOq
	 VR7RV8KWCPPzhi1CmLM+jDqxYG6nr1EoiNGA4EZqGcRSWRu+xR5LpViEeso57/QG1W
	 0+4hnwZ9ps+VQ==
Date: Wed, 28 Jan 2026 19:26:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, cassel@kernel.org, 
	Zhiqiang.Hou@nxp.com, xiaowei.bao@nxp.com, gustavo.pimentel@synopsys.com, 
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v3 0/3] PCI: dwc: ep: Enhance multi-function endpoint
 support
Message-ID: <afcd6jugzxcxt44ock23hqrotiyv2j3jpofembuper6v4php3p@q5abmqfrku2t>
References: <20260127085010.446116-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127085010.446116-1-a-garg7@ti.com>

On Tue, Jan 27, 2026 at 02:20:07PM +0530, Aksh Garg wrote:
> This series addresses multi-function endpoint configuration issues in
> the DWC PCIe controller driver. The changes enable proper operations
> for physical functions and enhance the multi-function endpoint support.
> 

Can you rebase on top of pci/controller/dwc branch and repost?

- Mani

> Changes from v2 to v3:
> - Fixed minor nits in the patch
> 
> Changes from v1 to v2:
> - Fixed the minor nits in the patches
> - Added a new patch in the series to address PTM capability access
> 
> v2: https://lore.kernel.org/all/20260122082538.309122-1-a-garg7@ti.com/
> v1: https://lore.kernel.org/all/20260121054214.274429-1-a-garg7@ti.com/
> 
> Aksh Garg (3):
>   PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
>   PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
>   PCI: dwc: ep: Add comment explaining controller-level PTM access
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 102 ++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |   4 +-
>  2 files changed, 72 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
