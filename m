Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58297 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039Ab3FTNVt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2013 09:21:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V8 1/4] pci: Add PCIe driver for Samsung Exynos
Date: Thu, 20 Jun 2013 15:20:48 +0200
Cc: "'Kukjin Kim'" <kgene.kim@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"'Grant Likely'" <grant.likely@secretlab.ca>,
	"'Andrew Murray'" <andrew.murray@arm.com>,
	"'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
	"'Thierry Reding'" <thierry.reding@avionic-design.de>,
	"'Jason Gunthorpe'" <jgunthorpe@obsidianresearch.com>,
	"'Surendranath Gurivireddy Balla'" <suren.reddy@samsung.com>,
	"'Siva Reddy Kallam'" <siva.kallam@samsung.com>,
	"'Thomas Abraham'" <thomas.abraham@linaro.org>,
	"'Tomasz Figa'" <t.figa@samsung.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>
References: <00db01ce6db3$7f9a3830$7ecea890$@samsung.com>
In-Reply-To: <00db01ce6db3$7f9a3830$7ecea890$@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201306201520.49212.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 20 June 2013, Jingoo Han wrote:

> diff --git a/Documentation/devicetree/bindings/pci/exynos-pcie.txt b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> new file mode 100644
> index 0000000..f71d835
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> @@ -0,0 +1,73 @@
> +* Samsung Exynos PCIe interface

Please adapt the name of the binding as well, and name it snps-dwc-pcie.txt
for instance, to match the change in the driver and in the binding.

> +Required properties:
> +-compatible: should contain "snps,dwc-pcie" to identify the
> +	core, plus an identifier for the specific instance, such
> +	as "samsung,exynos5440-pcie".

Thanks for changing it here.

> +
> +	pcie@290000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x290000 0x1000
> +			0x270000 0x1000
> +			0x271000 0x40>;


but please also change the example and the .dts files to match.
It should say here

		compatible = "samsung,exynos5440-pcie", "snps,dwc-pcie";

as now required by the binding.

	Arnd
