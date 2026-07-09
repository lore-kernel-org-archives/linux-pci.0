Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851540D580;
	Thu,  9 Jul 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600153; cv=none; b=FDue58fSmReQVizzC6XNCcT4TU8HdL53KAC5k4/8t3xNpmFMjPTgAWP9brqNCnA+JRd2zLgPsgrvGue0DFXBC3e+Duz6oMVUnfBxduAT/aMXD5C6QglO66yMEQOco7v4c3Fk8vcUnOs3dMXDRj1LV2nOUn6e8+Zo6cik4OGY9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600153; c=relaxed/simple;
	bh=tno/hW6ymTqwOVbL3jxAVSS0YOSGy7nVmy9o2YVE458=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7h4iqdhT0f+YXoWpvccfw+zBsPEhz3reMDYYuwTsjJs/wmrgeVCunlyfEi/UP1wT12GKFiwpzy92JPzEjdUvKn6zcub3kp65uXLg/ipw5UZTEiLqrNfGqlMi90dKv7sJ0gMLW2aybiBo2Fmtb9z/RzLrAUGC2dJ9c4HZ+fsDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLd/eqFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLd/eqFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E601F000E9;
	Thu,  9 Jul 2026 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600152;
	bh=HZpphPHS+kE2zjJn6fV5pW8hZvy6pxeJHUSkdrcp6Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jLd/eqFuhPtL1sLKjbUyoLPRP1TLORuf1HQ/wIx4jQSeTFjHc18+nQ3asKKX41MVk
	 BCupLVDx+Lx0SF5qsFx3Wid2vc+OEBFvGvaCH2wpzR9nVdgEUcdyKg8Aqm3Zx6S1Qw
	 /Mju0eky30JNZgjxR1tq9gAO4646HIh37UlTJcnmNlU3VooH5/mkYlY/28VZCIc89c
	 gXQwu4b/6Y+YiEhmonGRvwO6630Rf80D5B/LCNxyauV0S2HTFsvVlLPBZK6jueRMku
	 fxINKECQjnbaQ1abTansLXKlqLprEf/CGc4x7qh6yVBHNpjI5eXz9Go3p0WPSb8zav
	 rI9E2vaFy5gZg==
Date: Thu, 9 Jul 2026 14:29:02 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Yureka Lilian <yureka@cyberchaos.dev>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: apple: Integrate pwrctrl API
Message-ID: <jqaxvdaxfpm5g3tdwdqpuk2ubkwim6ckmlblocvakloqishvmm@c5ofbdbdj7lf>
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
 <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
 <86a4s3p2vy.wl-maz@kernel.org>
 <8a80a170-a508-4a9e-8090-27cfcedb1cd4@cyberchaos.dev>
 <865x2qq4ts.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <865x2qq4ts.wl-maz@kernel.org>

On Tue, Jul 07, 2026 at 02:58:39PM +0100, Marc Zyngier wrote:
> On Tue, 07 Jul 2026 13:04:21 +0100,
> Yureka Lilian <yureka@cyberchaos.dev> wrote:
> > 
> > On 7/7/26 11:25, Marc Zyngier wrote:
> > > On Mon, 06 Jul 2026 23:38:27 +0100,
> > > Yureka Lilian <yureka@cyberchaos.dev> wrote:
> > >> Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
> > >> provide standardized power management for PCI devices.
> > >> 
> > >> Notably, this allows enabling powering on the WiFi, SD card reader on
> > >> various Macs by means of the pwrctrl framework before probing the ports.
> > >> 
> > >> Previously, a custom solution for powering on the WiFi and SD card
> > >> reader was proposed[1], but we can now use the new pci-pwrctrl-generic
> > >> driver for this purpose.
> > >> 
> > >> Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/
> > >> 
> > > nit: this paragraph and the accompanying link don't belong in the
> > > commit message and should be moved below the --- mark or even better,
> > > to the cover letter.
> > ack, will leave it out of the commit message of the individual commit in v2
> > >> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> > >> ---
> > >>   drivers/pci/controller/Kconfig      |  1 +
> > >>   drivers/pci/controller/pcie-apple.c | 16 ++++++++++++++++
> > >>   2 files changed, 17 insertions(+)
> > >> 
> > >> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > >> index 2247709ef6d6..af64630d28fa 100644
> > >> --- a/drivers/pci/controller/Kconfig
> > >> +++ b/drivers/pci/controller/Kconfig
> > >> @@ -46,6 +46,7 @@ config PCIE_APPLE
> > >>   	depends on OF
> > >>   	depends on PCI_MSI
> > >>   	select PCI_HOST_COMMON
> > >> +	select PCI_PWRCTRL_GENERIC
> > >>   	select IRQ_MSI_LIB
> > >>   	help
> > >>   	  Say Y here if you want to enable PCIe controller support on Apple
> > >> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > >> index c2cffc0659f4..db038a9d4831 100644
> > >> --- a/drivers/pci/controller/pcie-apple.c
> > >> +++ b/drivers/pci/controller/pcie-apple.c
> > >> @@ -30,6 +30,7 @@
> > >>   #include <linux/msi.h>
> > >>   #include <linux/of_irq.h>
> > >>   #include <linux/pci-ecam.h>
> > >> +#include <linux/pci-pwrctrl.h>
> > >>     #include "pci-host-common.h"
> > >>   @@ -825,6 +826,21 @@ static int apple_pcie_init(struct
> > >> pci_config_window *cfg)
> > >>   	if (WARN_ON(!pcie))
> > >>   		return -ENOENT;
> > >>   +	ret = pci_pwrctrl_create_devices(pcie->dev);
> > >> +	if (ret) {
> > >> +		dev_err(pcie->dev, "Failed to create pwrctrl devices: %pe\n", ret);
> > >> +		return ret;
> > >> +	}
> > >> +
> > >> +	ret = pci_pwrctrl_power_on_devices(pcie->dev);
> > >> +	if (ret) {
> > >> +		if (ret != -EPROBE_DEFER) {
> > >> +			dev_err(pcie->dev, "Failed to power on devices: %pe\n", ret);
> > >> +			pci_pwrctrl_destroy_devices(pcie->dev);
> > >> +		}
> > >> +		return ret;
> > >> +	}
> > >> +
> > > Why is this done globally while the whole driver works on a per-port
> > > basis, and that the proposed DT updates are also per port?
> > 
> > pci_pwrctrl_power_on_devices takes a struct device as parameter, but
> > pcie-apple does not allocate device structs for the individual ports.
> > This could be changed of course. But since pci_pwrctrl_* operate on
> > the subnodes recursively, it works just fine this way.
> 
> Works fine is one thing. Being consistent with the way the rest of the
> driver works is another. pci_pwrctrl_create_device() and
> pci_pwrctrl_power_on_device() appear to do exactly what would be
> required for a single port. They just needs to be exported made
> global/exported.
> 

I'm fine with exporting pci_pwrctrl_create_device() and
pci_pwrctrl_power_on_device() and calling them with per-port np.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
