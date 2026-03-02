Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378038D009;
	Mon,  2 Mar 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446045; cv=none; b=GDrvZ6h1Bv+o4ChjzEnW6JIZuWVUxIYFRLxG7kk/UY0AI+Hcb9GcRq2nWMVsip6MOLVseLjhiqest2mhV6bYibVvVckbUY+oCdHy8fyjFgd2xl1LN3CyiykgP5cfi/DwObUOVqNhGWbxwoL1z1n8eakqygC0hU3LkkqXAbKzOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446045; c=relaxed/simple;
	bh=WsKalQsrcTrCExLvVUrum2up311uMNa/m5xaR9444CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKUgjRqPYvrW7fJFSMlKKGMV3BEqWHAbwztfqkwM1Q9O0kiFSHvxYK0uJEnWKmM/LOBZyccsWugPE4KZ0WgYDm2A1bjFnf31h4I6QZ3e6HpfO8h9XDqcilIqmlTcnBXKPslUfAAz0hx3+8AhqeVEbS9QzCfONFt3l6De94g47GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idz31Tul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idz31Tul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777EC19423;
	Mon,  2 Mar 2026 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446044;
	bh=WsKalQsrcTrCExLvVUrum2up311uMNa/m5xaR9444CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Idz31TulenK2Oc1qZMZYRCZDv8zLtAmYydFFwom9nMBYmPgd6yBncrGZAh3Pg335B
	 nmAHJZMBGDjYDlv9jugT9XKsO0WupC4YCvHNdKxGdW+JXnx6MTf7iIpJV9jFONn6ME
	 NOlr4q6ld56SACyoBRcsCp7d38sRhxYj9Bjq9nq7EhO8gCc63vlU1RTd6y9e32GtQX
	 aiQaUa30Z4cNrtJ5V4/j9nekmGF0hrTp/ILbHE+AInsEbOWy7mIha0SWLkKRhDp09c
	 97W5FBBeHxRJ9nC4On0vYFBYnMV+P1PM2AEqO7ziDFKiJC7SbJHQffyrzOSegmcGRR
	 4T0CanHLhEOBA==
Date: Mon, 2 Mar 2026 11:07:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aaVhVc-teEeglUxJ@ryzen>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071427.534158-8-den@valinux.co.jp>

On Mon, Mar 02, 2026 at 04:14:27PM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
> 
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
> 
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the DMA address returned by dma_map_resource() (which may be an IOVA
> when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> 
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Tested-by: Niklas Cassel <cassel@kernel.org>
