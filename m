Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60584 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbcBHT4r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Feb 2016 14:56:47 -0500
Date: Mon, 8 Feb 2016 13:56:42 -0600
From: Rob Herring <robh@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 3/3] pci, pci-thunder-ecam: Add driver for
 ThunderX-pass1 on-chip devices
Message-ID: <20160208195642.GA15103@rob-hp-laptop>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com>
 <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454715675-17512-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 03:41:15PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The cavium,pci-thunder-ecam devices are exactly ECAM based PCI root
> complexes.  These root complexes (loosely referred to as ECAM units in
> the hardware manuals) are used to access the Thunder on-chips devices.
> They are special in that all the BARs on devices behind these root
> complexes are at fixed addresses.  To handle this in a manner
> compatible with the core PCI code, we have the config access functions
> synthesize Enhanced Allocation (EA) capability entries for each BAR.
> 
> Since this EA synthesis is needed for exactly one chip model, we can
> hard code some assumptions about the device topology and the
> properties of specific DEVFNs in the driver.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/pci-thunder-ecam.txt   |  30 ++
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-thunder-ecam.c                | 358 +++++++++++++++++++++
>  4 files changed, 396 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>  create mode 100644 drivers/pci/host/pci-thunder-ecam.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt b/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
> new file mode 100644
> index 0000000..34658f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
> @@ -0,0 +1,30 @@
> +* ThunderX PCI host controller for pass-1.x silicon
> +
> +Firmware-initialized PCI host controller to on-chip devices found on
> +some Cavium ThunderX processors.  These devices have ECAM based config
> +access, but the BARs are all at fixed addresses.  We handle the fixed
> +addresses by synthesizing Enhanced Allocation (EA) capabilities for
> +these devices.
> +
> +The properties and their meanings are identical to those described in
> +host-generic-pci.txt except as listed below.
> +
> +Properties of the host controller node that differ from
> +host-generic-pci.txt:
> +
> +- compatible     : Must be "cavium,pci-host-thunder-ecam"
> +
> +Example:
> +
> +	pci@84b0,00000000 {

Drop the comma, and the node name should be "pcie".

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "cavium,pci-host-thunder-ecam";
> +		device_type = "pci";
> +		msi-parent = <&its>;
> +		msi-map = <0 &its 0x30000 0x10000>;
> +		bus-range = <0 31>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		#stream-id-cells = <1>;
> +		reg = <0x84b0 0x00000000 0 0x02000000>;  /* Configuration space */
> +		ranges = <0x03000000 0x8180 0x00000000 0x8180 0x00000000 0x80 0x00000000>; /* mem ranges */
> +	};
