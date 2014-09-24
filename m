Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54875 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaIXQGz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 12:06:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Robert Richter <rric@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	Sunil Goutham <sgoutham@cavium.com>
Subject: Re: [PATCH 3/6] pci, thunder: Add PCIe host controller devicetree bindings
Date: Wed, 24 Sep 2014 18:06:04 +0200
Message-ID: <3082935.e3X4GsVUDn@wuerfel>
In-Reply-To: <1411573068-12952-4-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org> <1411573068-12952-4-git-send-email-rric@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 24 September 2014 17:37:45 Robert Richter wrote:
> 
> +       pcie0@0x8480,00000000 {

The name should be pci, not pci0.

> +               compatible = "cavium,thunder-pcie";
> +               device_type = "pci";
> +               msi-parent = <&its>;
> +               bus-range = <0 255>;
> +               #size-cells = <2>;
> +               #address-cells = <3>;
> +               reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
> +               ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>, /* mem ranges */
> +                       <0x03000000 0x8300 0x00000000 0x8300 0x00000000 0x80 0x00000000>,
> +                       <0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x01 0x00000000>;
> +        };

If you claim the entire 0-255 bus range, I think you should also
specify a domain, otherwise it's not predictable which domain you
get.

The interrupt-map and interrupt-map-mask properties are required for PCI,
otherwise you can't do LSI interrupts.

If your hardware can support it, you should also list I/O space and prefetchable
memory spaces. Can you explain why you have multiple non-prefetchable ranges?

	Arnd
