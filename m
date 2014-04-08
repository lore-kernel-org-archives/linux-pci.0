Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57956 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbaDHTPw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:15:52 -0400
Message-ID: <53444AE3.6030603@wwwdotorg.org>
Date: Tue, 08 Apr 2014 13:15:47 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <treding@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC 1/5] PCI: tegra: Overhaul regulator usage
References: <1396622969-17837-1-git-send-email-treding@nvidia.com> <1396622969-17837-2-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-2-git-send-email-treding@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/2014 08:49 AM, Thierry Reding wrote:
> The current usage of regulators for the Tegra PCIe block is wrong. It
> doesn't accurately reflect the actual supply inputs of the IP block and
> therefore isn't as flexible as it should be. Rectify this by describing
> all possible supply inputs in the device tree binding documentation and
> deprecate the old supply properties.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

> +Power supplies for Tegra30:
...
> +- Optional:
> +  - If port 0 is enabled:
> +    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
> +    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +  - If at least one of ports 1 and 2 is enabled:
> +    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
> +    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.

Did you get confirmation from HW/... that the mapping from pexa/b to
PCIe ports you document above is correct? IIRC the two supplies might be
related to lanes rather than ports?
