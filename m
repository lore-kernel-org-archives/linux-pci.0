Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42964 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285AbaDHTRF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:17:05 -0400
Message-ID: <53444B2D.8050209@wwwdotorg.org>
Date: Tue, 08 Apr 2014 13:17:01 -0600
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
Subject: Re: [RFC 2/5] ARM: tegra: Add new PCIe regulator properties
References: <1396622969-17837-1-git-send-email-treding@nvidia.com> <1396622969-17837-3-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-3-git-send-email-treding@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/2014 08:49 AM, Thierry Reding wrote:
> These new properties more accurately reflect the real connections of the
> boards and therefore make it easier to match them up with schematics.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

>  	pcie-controller@00003000 {
>  		status = "okay";
> +
> +		/* AVDD_PEXA and VDD_PEXA are grounded on Cardhu. */

Perhaps add the word "inputs" before "are"?
