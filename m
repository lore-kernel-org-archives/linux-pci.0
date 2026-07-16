Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CB42D742;
	Thu, 16 Jul 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213385; cv=none; b=Dz7mnZeCbKBtZrP3aJJLA2ssIyNDhvywT0AzqqpQEr65aeAqXTnmGvpnbg0HyNF6gXwbdnRAAlvtoaMzQQGr5ScjfPdqTALGw7lA2dDYB9u2nDXvURBdmAkbQFFKKYA+HDg9/dfzFpNJecQpBkysCOAIoIgbxclIqfoD0Szw31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213385; c=relaxed/simple;
	bh=Par/M6s70tTS2iRS3SIAoAqNhvnWQDmlDyc1kEtdMtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYNkc37byC5WKqj+hqOYH93jl+tljES8uoEu0wxKJvy9PXGrFPM8XyIIm6pHYpGkCd2Co8c+E7wUNfMztOSqX/dZNzItGrJW7I3CIZxmhiyn3GZWOMUs9g41hQdpxhndoaJjY+j2SwWFGgWI4C21MUaYRJCQS5GZp/d425FjAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3esabGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3esabGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D7B1F000E9;
	Thu, 16 Jul 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213384;
	bh=zqNK14fvUgJPkPKSw3F2wEzBp6SPYyPXK1qyOUdckgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K3esabGfmFIKjOLPgAKaolLSygDxiOrWrwG/Ry2KPI0YTB50PTTslkIhpdBVK24PH
	 eqPi1gcalpvP/P65xerJArZDH03ErvYW+Ls2wOb98Y7u5DcbUsk/tJtRVludwWgps0
	 scZvArB+O9fDEE+uh+OlV0FCHOqxjFMxycWqbf1/JDOIgziKpP+JiejFIUc3SOEsBI
	 QVLc3HhonSLz2/9j0TJl/+98YUfTDlqhYNgi9nosmAWXQpfgvrcbVDV1ArAKx5OHJc
	 4serm5zFAq3uG1kEn3yWDECkW50gOHrGA0TsdONZQfTErTY9kPNOSvR6RORaWJAQjQ
	 bJJ1PUEbjZmCQ==
Date: Thu, 16 Jul 2026 16:49:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: apple: Integrate pwrctrl API
Message-ID: <pbxefv7wotwcaavoas347htdx22rdupfqn6cbuyjf4y2kjlv4p@7xdael6h7d57>
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
 <20260707-apple-pcie-pwren-v1-1-5a281b182fe2@cyberchaos.dev>
 <86a4s3p2vy.wl-maz@kernel.org>
 <8a80a170-a508-4a9e-8090-27cfcedb1cd4@cyberchaos.dev>
 <865x2qq4ts.wl-maz@kernel.org>
 <jqaxvdaxfpm5g3tdwdqpuk2ubkwim6ckmlblocvakloqishvmm@c5ofbdbdj7lf>
 <76243051-e391-45d2-b47a-d4a904f0a36f@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76243051-e391-45d2-b47a-d4a904f0a36f@cyberchaos.dev>

On Tue, Jul 14, 2026 at 06:57:11PM +0200, Yureka Lilian wrote:
> 
> On 7/9/26 14:29, Manivannan Sadhasivam wrote:
> > On Tue, Jul 07, 2026 at 02:58:39PM +0100, Marc Zyngier wrote:
> > > On Tue, 07 Jul 2026 13:04:21 +0100,
> > > Yureka Lilian <yureka@cyberchaos.dev> wrote:
> > > > On 7/7/26 11:25, Marc Zyngier wrote:
> > > > > On Mon, 06 Jul 2026 23:38:27 +0100,
> > > > > Yureka Lilian <yureka@cyberchaos.dev> wrote:
> > > > > > Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
> > > > > > provide standardized power management for PCI devices.
> > > > > > 
> > > > > > Notably, this allows enabling powering on the WiFi, SD card reader on
> > > > > > various Macs by means of the pwrctrl framework before probing the ports.
> > > > > > 
> > > > > > Previously, a custom solution for powering on the WiFi and SD card
> > > > > > reader was proposed[1], but we can now use the new pci-pwrctrl-generic
> > > > > > driver for this purpose.
> > > > > > 
> > > > > > Link[1]: https://lore.kernel.org/lkml/20220502093832.32778-4-marcan@marcan.st/
> > > > > > 
> > > > > nit: this paragraph and the accompanying link don't belong in the
> > > > > commit message and should be moved below the --- mark or even better,
> > > > > to the cover letter.
> > > > ack, will leave it out of the commit message of the individual commit in v2
> > > > > > Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> > > > > > ---
> > > > > >    drivers/pci/controller/Kconfig      |  1 +
> > > > > >    drivers/pci/controller/pcie-apple.c | 16 ++++++++++++++++
> > > > > >    2 files changed, 17 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > > > index 2247709ef6d6..af64630d28fa 100644
> > > > > > --- a/drivers/pci/controller/Kconfig
> > > > > > +++ b/drivers/pci/controller/Kconfig
> > > > > > @@ -46,6 +46,7 @@ config PCIE_APPLE
> > > > > >    	depends on OF
> > > > > >    	depends on PCI_MSI
> > > > > >    	select PCI_HOST_COMMON
> > > > > > +	select PCI_PWRCTRL_GENERIC
> > > > > >    	select IRQ_MSI_LIB
> > > > > >    	help
> > > > > >    	  Say Y here if you want to enable PCIe controller support on Apple
> > > > > > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > > > > > index c2cffc0659f4..db038a9d4831 100644
> > > > > > --- a/drivers/pci/controller/pcie-apple.c
> > > > > > +++ b/drivers/pci/controller/pcie-apple.c
> > > > > > @@ -30,6 +30,7 @@
> > > > > >    #include <linux/msi.h>
> > > > > >    #include <linux/of_irq.h>
> > > > > >    #include <linux/pci-ecam.h>
> > > > > > +#include <linux/pci-pwrctrl.h>
> > > > > >      #include "pci-host-common.h"
> > > > > >    @@ -825,6 +826,21 @@ static int apple_pcie_init(struct
> > > > > > pci_config_window *cfg)
> > > > > >    	if (WARN_ON(!pcie))
> > > > > >    		return -ENOENT;
> > > > > >    +	ret = pci_pwrctrl_create_devices(pcie->dev);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(pcie->dev, "Failed to create pwrctrl devices: %pe\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = pci_pwrctrl_power_on_devices(pcie->dev);
> > > > > > +	if (ret) {
> > > > > > +		if (ret != -EPROBE_DEFER) {
> > > > > > +			dev_err(pcie->dev, "Failed to power on devices: %pe\n", ret);
> > > > > > +			pci_pwrctrl_destroy_devices(pcie->dev);
> > > > > > +		}
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > Why is this done globally while the whole driver works on a per-port
> > > > > basis, and that the proposed DT updates are also per port?
> > > > pci_pwrctrl_power_on_devices takes a struct device as parameter, but
> > > > pcie-apple does not allocate device structs for the individual ports.
> > > > This could be changed of course. But since pci_pwrctrl_* operate on
> > > > the subnodes recursively, it works just fine this way.
> > > Works fine is one thing. Being consistent with the way the rest of the
> > > driver works is another. pci_pwrctrl_create_device() and
> > > pci_pwrctrl_power_on_device() appear to do exactly what would be
> > > required for a single port. They just needs to be exported made
> > > global/exported.
> > > 
> > I'm fine with exporting pci_pwrctrl_create_device() and
> > pci_pwrctrl_power_on_device() and calling them with per-port np.
> > 
> > - Mani
> 
> In theory I do agree this would work to power on the slots, and I can send a
> v2 of the patch doing it that way, but I don't quite understand yet how this
> fits better with the existing driver code: If this is the case, what is the
> difference between pcie-apple and pcie-qcom and why should pcie-qcom use the
> recursive function but pcie-apple not?
> 

For pcie-qcom, it needs to iterate through all PCI child nodes, not just the RP
as we have multiple nodes due to PCIe switch (and switches in some design). So
this per-port API wouldn't work there.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
