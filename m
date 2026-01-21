Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A6328B49;
	Wed, 21 Jan 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000934; cv=none; b=uVNMXeoBL9KeLyetlPjPV4HDj5jY18wM2QMxiam6zoOiT4qbY5LxTDl3Vd8GQ3gTpavo+RvuR0VIvFCfXdAuwONkPDlJqi0ggJPIceYR8QAQ/2kZ2t33PYmo5GAXjMdNVveiqWkZ7Xe0b8MJlMVOuSECyH2UI/4ZBsFIOYJDXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000934; c=relaxed/simple;
	bh=+W9RBr1b3bYVVh4237uxjqSzDcyPhjhReeBBj2yel0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnMPe2cmod9fWzv8ycz5pwogeg4uJdkDJr3uQJd9SIB/wIkt3keJrU7ZQ1kFME74Sw9hWzHz1DHvigtTFmUBuNUpV7vTY7TARE2B3O3jafq3jz/5WaWMo80sYk61kE7qINjChotXSvTmr1CLzygPI51qtZlnLCMpPYJ2/L4huJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es5oExNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es5oExNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDABC19424;
	Wed, 21 Jan 2026 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769000933;
	bh=+W9RBr1b3bYVVh4237uxjqSzDcyPhjhReeBBj2yel0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=es5oExNW+Pvczv9IbisvMHzqME/NggzZrgqNuHjm0UG76H3fulb94vZktRxX9g+P9
	 7q2HaaTt4ONxW1UcgBpo36taou0qi98JN62WX1UODnxLZbb8uW4wac8H1oemzLn+oW
	 4enH6DuNwjr9gqZkN/dke2LTHCyxdCL9sfIm9n+V0S4OKOBa7rFY6sVjFkz9VgMhDN
	 8sSEitkcCZIVX0z0QS3YlxDPocSPmWhKjSzhVo8SFHNWY3y3nBsa0ladMqvBuLeJ9M
	 Lp0EFrsCYVVW74as84q3+qMbMfe84/KzG0/A/nMdJ3Gr9edvuItQvWNEg5EZSI/Sy6
	 jbZ3KZhi/pumg==
Date: Wed, 21 Jan 2026 18:38:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
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
Message-ID: <ddhcpvasw3ozlb6u6tzarhsliszm44rsfoplvlplsyjnxvxenz@3gg73hro74gz>
References: <20260106174348.GA365798@bhelgaas>
 <6607c5b8.21d6.19ba27df74f.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6607c5b8.21d6.19ba27df74f.Coremail.zhangsenchuan@eswincomputing.com>

On Fri, Jan 09, 2026 at 07:22:02PM +0800, zhangsenchuan wrote:
> > > On Tue, Jan 06, 2026 at 08:43:11PM +0800, zhangsenchuan wrote:
> > > > > On Mon, Dec 29, 2025 at 07:32:07PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > > 
> > > > > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > > > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > > > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > > > > interrupts.
> > > > > 
> > > > > > +config PCIE_EIC7700
> > > > > > +	tristate "Eswin EIC7700 PCIe controller"
> > > > > 
> > > > > > +/* Vendor and device ID value */
> > > > > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > > > > +#define PCI_DEVICE_ID_ESWIN		0x2030
> > > > > 
> > > > > Usually the device name is a little more than just the vendor.  What
> > > > > if Eswin ever makes a second device?
> > > > 
> > > > Okey, thanks.
> > > > Perhaps it's a problem. Maybe PCI_DEVICE_ID_EIC7700 is better?
> > 
> > Check pci_ids.h and follow the style used there.  Device ID macros
> > typically include both the vendor and the device.
> 
> Okey, thanks.
> 
> > 
> > > > > > +static struct platform_driver eic7700_pcie_driver = {
> > > > > > +	.probe = eic7700_pcie_probe,
> > > > > 
> > > > > This driver is tristate but has no .remove() callback.  Seems like it
> > > > > should have one?
> > > > 
> > > > In v2 patch, I referred to Mani's comments and removed the .remove()
> > > > callback, as follows:
> > > > "Since this controller implements irqchip using the DWC core driver,
> > > > it is not safe to remove it during runtime."
> > > > https://lore.kernel.org/linux-pci/jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi/
> > > > 
> > > > In addition, remove .remove() callback, because this driver has been 
> > > > modified to builtin_platform_driver and does not support HotPlug, 
> > > > therefore, the .remove() callback is not needed. Do you have any
> > > > better suggestions?
> > > 
> > > Yes, builtin_platform_driver() wouldn't allow the users to remove
> > > the module. So remove() callback will become useless. The reason why
> > > this driver is tristate is that it could be loaded from rootfs and
> > > not always statically built to the kernel image.
> > 
> > This .remove() vs IRQ thing is a perennial issue and it's hard to know
> > what style new drivers should copy.
> > 
> > There are lots of DWC-based drivers that are tristate, implement
> > .remove(), and use module_platform_driver() (e.g., bt1, kirin,
> > tegra194, rcar-gen4, exynos, k1, stm32).  Is there something different
> > about the way they implement irqchip that makes .remove() safe?
> 
> Hi Bjorn, Mani,
> 
> The comments are as follows:
> "You can make it tristate as you've used builtin_platform_driver() which
> guarantees that this driver won't be removed once loaded."
> https://lore.kernel.org/linux-pci/uijg47suvluvamftyxwc65kl34eo2eu2af2o5aia4nu45hanqc@grcr2bjgph2i/
> 
> Do not add the remove callback. It needs to be set to a bool：
> In v6 patch, it was mentioned to set tristate. Now, after careful 
> consideration, setting tristate can allow loading as a module, but the 
> driver implementation does not have a remove function. If it exists in 
> the form of a module, after testing, When insmod driver is followed by 
> rmmod driver, the resources cannot be released, and problems will occur
> when insmod driver is used again. So I think that if the remove callback
> function is not provided in the form of builtin, it can only be set to 
> bool.
> 
> Add the remove callback. It can make it tristate:
> Questions about removing it during runtime. I don't have a very good idea.
> I still don't quite understand why it's not safe. Could you explain it to 
> me?
> 

It is mostly due to IRQ disposal concern. Kernel's IRQ core gives no guarantee
that all the client drivers requested IRQs would've freed them before the
irqchip drivers like the controller drivers dispose the IRQs in their remove
callback.

More info here: https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html

> At present, refer to other manufacturers, i think there are two ways to 
> achieve it.
> 1.Set a bool. Do not add the remove function, module loading is not 
> allowed, and the driver currently does not support HotPlug.
> 2.Set a tristate, add .remove callback.
> 
> I think the first one might be better for me, because there is no need 
> to add the remove function, my understanding might also be incorrect. 
> Please review it for me. Thanks！
> 

I'd prefer to make it tristate, builtin_platform_driver() and not have
.remove() callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
