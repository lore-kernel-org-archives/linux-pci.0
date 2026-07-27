Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D341F5EE;
	Mon, 27 Jul 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169125; cv=none; b=ob3Q7k3I02EvTJ8D74iwg3Dsf79qZHDCx32CPwCUaK/ncHk+De4Q1lcXmZHrKjIcAC1V2n6xidI8iDemsktp6ql8t7N2moKi4DJJHAuM1DQDJoMvL39gkNT8L8HXZriXlWO0y7y/wdDbVzoNLDbUpJYSp2yyw7dNiw+RiAtaPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169125; c=relaxed/simple;
	bh=bdzKfG3Jj1iCZ3a/DF2X0wPti1xlmaAbBgWFTcK0IrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKQnGe48ZgSpuG3SleREAfCHrD7Z1K65HM9eiEdgcs6FvQHPPe9whbtitfR2ndmFisWFzTvskA6GmFmi+rhlJiizEkU5aX+JkNWvLcEvhhIO0LcxioTv8ETk/hoBrwYmUBfr5Hgv+egksXry3J9NWluQHy4/ST4pZxFiUgfAlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enBAogfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enBAogfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF391F000E9;
	Mon, 27 Jul 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169124;
	bh=06M4KFqCz6SAPpTAamw98wDkXyr1xHgX4OA2w7xESWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=enBAogfoOEeCgerqwKDnan2rG4kdIvWwu5OsTjW/wsCXONxI+Bxyz9sJbEtytivK8
	 W1SqHqHvtq5WHHEK8pozmnV/fjtAOJ8Wm72Kan0GUdbUeCASEsYxW3vc5BenWRIMEG
	 lDXafmL0aZzu3g+7qWVcNf4LOmO2bLLgquj2Gs2ImTXhNTokgQQLfD0ltjtKbsQZQ2
	 mUw/5A6qsbsEkCYKXoJMPQiIErI8hUQDkDMbJjJWean18YnrfA/U+G9xH5CpfNEy76
	 rE+vwgin8bbdBr69LnNzDX2/qneNSP4745BhviSWn4t4dXZPaTNN4+N+TE4kNNiDHg
	 Ej8WBel57HFGQ==
Date: Mon, 27 Jul 2026 18:18:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <ameE3SBWqbiE8PJp@ryzen>
References: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
 <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>

On Mon, May 18, 2026 at 08:29:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The MSI iATU mapping is currently only cleared when the endpoint is
> stopped via configfs or when the host updates the MSI address/size.
> This avoids redundant iATU reconfiguration every time the endpoint
> raises an MSI interrupt.
> 
> However, a fundamental reset triggered by PERST# assert/deassert
> resets all iATU inbound/outbound registers without going through the
> configfs stop path. If the host also retains the same MSI address/size
> after PERST# deassert, the driver never clears the stale MSI iATU
> mapping. It then continues using this stale mapping to raise the MSI
> interrupts, which can cause IOMMU faults and MSI failures on the host.
> 
> Fix this by clearing the MSI iATU mapping inside dw_pcie_ep_cleanup(),
> which is already called as part of the PERST# assert/deassert sequence.
> This unmaps the MSI iATU region and sets the msi_iatu_mapped flag to
> false, ensuring that dw_pcie_ep_raise_msi_irq() performs a fresh iATU
> mapping on its next invocation, regardless of whether the host changed
> the MSI address/size.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Doesn't this need a Fixes tag?


Side node: It seems like this series does no longer apply on pci/next.

Perhaps need to rebase and resend?


Kind regards,
Niklas
