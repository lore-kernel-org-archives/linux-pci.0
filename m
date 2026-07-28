Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61241B8CC;
	Tue, 28 Jul 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239792; cv=none; b=J5tQlRqEBWhIjjjtcEgtBm3TyOPbWS/ZDPjqnkQDe9tA8paa2h1HvoHh8JldTj7UzYbZ5yKE4EF3Vc9ZOKQUvLBPL0lyo6p2+Mg/Q61DHwf+hi8BbvocIMwHBqLn7/tECSM7+WjGTS7GxfBxg+n19NoDa+/y/hBeDGJenntsN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239792; c=relaxed/simple;
	bh=PInYNSuczodvOIsUn2fYJl6VovWJKy+DVbDbpgvfzmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYNXhoiSzu2u0UVObSSNt1P7X8xAjYiQgn+HO1sQlreFgRsNMdZ2Ht8BP1TTVJJyroYrwERUMIvqSrzUWPvcBTagzFcQUYSisEOedRBDuc90oAWko5JtKOgUgitBYSW7pO7BEXIKz68F9esqhEDQsIuqifuH+ZHA5OBrdKbfQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eASZFug7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eASZFug7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B81F000E9;
	Tue, 28 Jul 2026 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785239791;
	bh=eNwZQCkHKwYFKkrNjWZTS93nuqW+VicG7takxDF9Vgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eASZFug7jzWnrOF3OuHWC4dJIdUSnjJMhAZUEWqUVi4S7MXbtF5ibFVRSy4+s537i
	 XUoY0kXJCaCx8MxtLhr+lrqq7NBntmoWdrBHhwp89a1vo6ad9Be0OIxrxYWGthQELk
	 RqQ0blwKXaXTZmXrJFZgO2OKqLo7ZWy1fBwW1QPIGDXU1mei6Oh2U7348bqhX6Ij1F
	 utV4CnZhplr9TkSvfz0vgnkLdUys67sBj2wznd3JK92mKYhvuAzLwbPqxgom8dj0rh
	 GxzUUzbP6wspjvSYYLHIQ6Tlw8fhCAnoo+ZdRHNGcd1kuoMAUM8GVTYLJ4ROhBtRXu
	 isnidYxLb535g==
Date: Tue, 28 Jul 2026 13:56:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <k5zkz2wnvkb2kzwyazafghgncqefv4cvuzrwwek6xi27vvldej@o4ostebesrbm>
References: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
 <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
 <ameE3SBWqbiE8PJp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ameE3SBWqbiE8PJp@ryzen>

On Mon, Jul 27, 2026 at 06:18:37PM +0200, Niklas Cassel wrote:
> On Mon, May 18, 2026 at 08:29:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The MSI iATU mapping is currently only cleared when the endpoint is
> > stopped via configfs or when the host updates the MSI address/size.
> > This avoids redundant iATU reconfiguration every time the endpoint
> > raises an MSI interrupt.
> > 
> > However, a fundamental reset triggered by PERST# assert/deassert
> > resets all iATU inbound/outbound registers without going through the
> > configfs stop path. If the host also retains the same MSI address/size
> > after PERST# deassert, the driver never clears the stale MSI iATU
> > mapping. It then continues using this stale mapping to raise the MSI
> > interrupts, which can cause IOMMU faults and MSI failures on the host.
> > 
> > Fix this by clearing the MSI iATU mapping inside dw_pcie_ep_cleanup(),
> > which is already called as part of the PERST# assert/deassert sequence.
> > This unmaps the MSI iATU region and sets the msi_iatu_mapped flag to
> > false, ensuring that dw_pcie_ep_raise_msi_irq() performs a fresh iATU
> > mapping on its next invocation, regardless of whether the host changed
> > the MSI address/size.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Doesn't this need a Fixes tag?
> 

It needs one yes!

> 
> Side node: It seems like this series does no longer apply on pci/next.
> 
> Perhaps need to rebase and resend?
> 

Yep. I'm preparing th next version. Will post it asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
