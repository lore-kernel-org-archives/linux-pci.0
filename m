Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8D3ECBC2;
	Wed, 21 Jan 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999928; cv=none; b=eiXg3R178tjERCxGk0Rb72oAbD+SNaW9zxvGy4gnizvfPaBZ4P96p5X3rPCXswM3/hx6nC+bgE0lcq2hkdQ0q+NVZ7T7hwnzglFCOwTwpW3rhTrZVnEk4w3rR6/cwSUOdfYEpw1Z2SkscHBMZywPNBSPvXXZlW/9vpBAWU2xHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999928; c=relaxed/simple;
	bh=leMl3oXeQbKOezU9GD2iOvYdF5WK3q971ctFN7xMINA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC92MGNkA2Gnc+/pnTvDG+tCS266oZ4R3mLDvSBtxhaQU1TEA5sqeAYRtTfEpYuSRIgwa8BkjjswILq0qnrv9j/a6vYL0+trgrUef5JKhjb+Gy3yQqP3YtfriuPfU9DGxYWHJ5FgDvaLhCNpOq0IIGoU5b+XHE6VH9On1mEfFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwfIypJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwfIypJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A4C116D0;
	Wed, 21 Jan 2026 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768999925;
	bh=leMl3oXeQbKOezU9GD2iOvYdF5WK3q971ctFN7xMINA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwfIypJ9fvTP86b+8ps3bKi5uNt/qfCcnIhDlKqBJaDY0XfKo2Sw+FRNZGtIQGEmM
	 c+UhLxU14VcL2MMHjqKDWIBpcd9MKRDZt9EQj/r6HjjlsP8bHJG+5VyKcb0fuwtoes
	 ySjLISh6wTUkTeP/1Ps3U+K32n9lASZ9pLUGDCTP8vGdaPl4cvRcrC7HuOXPOg1YSy
	 Cnh0WXptqyCIUDBBHJTxaDp79evgPt2GzpSd8aLLlZBpJCRtk/7/XnKApsWbjXEy4B
	 Oco4ERF3ehjfho3AgR6bdEPsBPymlYbJPUldkYhqJ9/3yj1JJHr1hfMUdgAKqDHRam
	 BQ1k3WMLRa0zg==
Date: Wed, 21 Jan 2026 18:21:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: zhangsenchuan <zhangsenchuan@eswincomputing.com>, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, 
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <cl2gdo6ledszdkubyimullksobtzuh4stplrctrsjxvi4u4xc4@s5daay4pwukx>
References: <4f3rhkrlp3jypajh77rohqgpoujivpxq6g3o6vrt6u7u5j2atd@gd5o3vtlhapp>
 <20260106174348.GA365798@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106174348.GA365798@bhelgaas>

On Tue, Jan 06, 2026 at 11:43:48AM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 06, 2026 at 06:49:58PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 06, 2026 at 08:43:11PM +0800, zhangsenchuan wrote:
> > > > On Mon, Dec 29, 2025 at 07:32:07PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > 
> > > > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > > > interrupts.
> > > > 
> > > > > +config PCIE_EIC7700
> > > > > +	tristate "Eswin EIC7700 PCIe controller"
> > > > 
> > > > > +/* Vendor and device ID value */
> > > > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > > > +#define PCI_DEVICE_ID_ESWIN		0x2030
> > > > 
> > > > Usually the device name is a little more than just the vendor.  What
> > > > if Eswin ever makes a second device?
> > > 
> > > Okey, thanks.
> > > Perhaps it's a problem. Maybe PCI_DEVICE_ID_EIC7700 is better?
> 
> Check pci_ids.h and follow the style used there.  Device ID macros
> typically include both the vendor and the device.
> 
> > > > > +static struct platform_driver eic7700_pcie_driver = {
> > > > > +	.probe = eic7700_pcie_probe,
> > > > 
> > > > This driver is tristate but has no .remove() callback.  Seems like it
> > > > should have one?
> > > 
> > > In v2 patch, I referred to Mani's comments and removed the .remove()
> > > callback, as follows:
> > > "Since this controller implements irqchip using the DWC core driver,
> > > it is not safe to remove it during runtime."
> > > https://lore.kernel.org/linux-pci/jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi/
> > > 
> > > In addition, remove .remove() callback, because this driver has been 
> > > modified to builtin_platform_driver and does not support HotPlug, 
> > > therefore, the .remove() callback is not needed. Do you have any
> > > better suggestions?
> > 
> > Yes, builtin_platform_driver() wouldn't allow the users to remove
> > the module. So remove() callback will become useless. The reason why
> > this driver is tristate is that it could be loaded from rootfs and
> > not always statically built to the kernel image.
> 
> This .remove() vs IRQ thing is a perennial issue and it's hard to know
> what style new drivers should copy.
> 
> There are lots of DWC-based drivers that are tristate, implement
> .remove(), and use module_platform_driver() (e.g., bt1, kirin,
> tegra194, rcar-gen4, exynos, k1, stm32).  Is there something different
> about the way they implement irqchip that makes .remove() safe?

Yes, there are differences currently. Mostly due to some drivers missed the
IRQ maintainers eyes when they got added (way before my involvement with PCI
controller drivers). I will fix them to maintain uniformity.

But the general undocumented rule is that if the controller driver implement
any irqchip (MSI/MSI-X/INTx), they should not get removed. So they can be
tristate, but builtin_platform_driver(). If they use any external irqchip
controller for receiving interrupts, they can safely be removed. This is the
case for dwc/pcie-stm32.

This prompts me to write the controller driver documentation that I was planning
for a while...

- Mani

-- 
மணிவண்ணன் சதாசிவம்
