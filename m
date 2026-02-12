Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF43D3B3
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900441; cv=none; b=OLbuuCxoJQ26DdYEmiPYkPWkLeDFSVxGIFcqLF7265r/KR2K7D+SR0v9bOILDNYVlcHdMFSooTZJzoptjdBGh63HSY6oGZ/qKM22zsM6QlObqJFNppXhFA6BBYUFDUWsxHzOAQeg4jcFaiBLLgn2IpyKcsGmaaICKv4PNsheotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900441; c=relaxed/simple;
	bh=3Bz23Xx/17dHbnRgK3lWlmIN9pf5/kIMMZd5UrIpky8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFOkNegSlhENzuefi7BaV052HH0hzcJbgJ8JoHwanmejuzWvXpQlo2yTiuXt9hIj6wDD57+CBRn9O1E0o3OolMt3B+b6TrKgWPzHnUS/sfsgEo8LTdldDwwK8T2ICFL5Eo49dUpOHWDHV+YLOYOw1WkyULzpLYBaQkEbyMZdWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nww0LyaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nww0LyaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F1FC4CEF7;
	Thu, 12 Feb 2026 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770900440;
	bh=3Bz23Xx/17dHbnRgK3lWlmIN9pf5/kIMMZd5UrIpky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nww0LyaSRBTXkENUgPjpVwbsV95HrP/SJLapX5mhE0RMQmqNOP4yp6JSNR86gFph5
	 Im0iuItBRmRczpZ3QMudITz3OcrEY0qkZ1z/MewS2A9zVGPQkjABq/HKzLUtEo/RCW
	 agW3zOwl5nVihydj+InSWiaesytM+HI/Y05fNSmC4NAe6JpGiUuizsXyyxNEdx2gTt
	 7n2RLoD69/vBIEmXbm1aS/s7xLJQexremouyhya6RX9wHNxsGLH4Wu2+4FyaQ2obAO
	 gEB8GrU/dceE1FF1gv9Daip8iVSGEzOSQE34zuc3I/ZsdaTEEnAZuGTGRlplbqwAnz
	 UL0RBt/wdNhsQ==
Date: Thu, 12 Feb 2026 13:47:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Flush before unmap in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <aY3L03mLeJnPUNVz@ryzen>
References: <20260211175540.105677-2-cassel@kernel.org>
 <aYzX70JDerv8Zm1H@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYzX70JDerv8Zm1H@lizhi-Precision-Tower-5810>

On Wed, Feb 11, 2026 at 02:26:39PM -0500, Frank Li wrote:
> On Wed, Feb 11, 2026 at 06:55:41PM +0100, Niklas Cassel wrote:
> > When running e.g. fio with a larger queue depth against nvmet-pci-epf we
> > get IOMMU errors on the host, e.g.:
> >
> > arm-smmu-v3 fc900000.iommu:      0x0000010000000010
> > arm-smmu-v3 fc900000.iommu:      0x0000020000000000
> > arm-smmu-v3 fc900000.iommu:      0x000000090000f040
> > arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> > arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
> > arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0
> >
> > The reason for this is that the writel() is immediately followed by a call
> > to unmap(), which will tear down the outbound address translation.
> >
> > PCI writes are posted, i.e. don't wait for a completion. Thus, when the
> > writel() returns, might not have completed yet, and could even still be
> > buffered in the PCI bridge, at the time unmap() is called.
> >
> > Flush the write by performing a read() of the same address, to ensure that
> > the write has reached the destination before calling unmap().
> >
> > This will add some latency, but that is certainly preferred over corrupting
> > the host memory.
> >
> > The same problem was solved for dw_pcie_ep_raise_msi_irq(), in commit
> > 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping"), however
> > there it was solved by dedicating an outbound iATU only for MSI. For MSI-X,
> > we can't do the same, as each vector can have a different msg_addr, and
> > because the msg_addr is allowed to be changed while the vector is masked.
> >
> > Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> 
> Cc stable?

Considering that the stable tooling backports everything with a Fixes: tag
nowadays, I don't really see the point in adding Cc: stable anymore.

Perhaps the maintainers can amend the commit message when applying if they
think that it will give it an even higher chance of being backported.


Kind regards,
Niklas
